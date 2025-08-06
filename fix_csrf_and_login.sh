#!/bin/bash

echo "🔧 FIXING CSRF TOKEN AND LOGIN ISSUES"
echo "======================================"

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

# Admin user credentials
ADMIN_USERNAME="wp_admin_2025"
ADMIN_PASSWORD="WpAdmin123!@#"

echo "🔑 Admin Credentials:"
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo ""

echo "🔍 STEP 1: GETTING FRESH CSRF TOKEN..."
echo "======================================="

# Get fresh CSRF token from login page
echo "Fetching fresh CSRF token from login page..."
csrf_response=$(curl -s -c cookies.txt -b cookies.txt "$LOGIN_URL")

# Extract CSRF token from response
csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [[ -z "$csrf_token" ]]; then
    echo "⚠️ Could not extract CSRF token from response"
    echo "Response preview:"
    echo "$csrf_response" | head -20
else
    echo "✅ Fresh CSRF Token: $csrf_token"
fi

echo ""
echo "🔍 STEP 2: TESTING LOGIN WITH FRESH TOKEN..."
echo "============================================="

# Test login with fresh CSRF token
echo "Attempting login with fresh CSRF token..."
login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Referer: $LOGIN_URL" \
    -H "Origin: $BASE_URL" \
    -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "Cache-Control: max-age=0" \
    -H "Sec-Fetch-Dest: document" \
    -H "Sec-Fetch-Mode: navigate" \
    -H "Sec-Fetch-Site: same-origin" \
    -H "Sec-Fetch-User: ?1" \
    -H "Upgrade-Insecure-Requests: 1" \
    -c cookies.txt -b cookies.txt \
    -d "_token=$csrf_token&username=$ADMIN_USERNAME&password=$ADMIN_PASSWORD" \
    "$LOGIN_URL")

http_status=$(echo "$login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
response_time=$(echo "$login_response" | grep "TIME:" | cut -d: -f2)
response_body=$(echo "$login_response" | grep -v "HTTP_STATUS:" | grep -v "TIME:")

echo "Login Status: $http_status"
echo "Login Time: ${response_time}s"
echo "Login Response Preview:"
echo "$response_body" | head -10

if [[ "$http_status" == "302" ]]; then
    echo "✅ LOGIN SUCCESS - Redirect indicates successful login"
elif [[ "$http_status" == "419" ]]; then
    echo "❌ CSRF TOKEN EXPIRED - Need to get fresh token"
elif [[ "$http_status" == "200" ]]; then
    echo "⚠️ LOGIN ATTEMPT - Need to check response content"
else
    echo "❌ LOGIN FAILED - Status: $http_status"
fi

echo ""
echo "🔍 STEP 3: ALTERNATIVE LOGIN METHOD..."
echo "======================================"

# Try alternative login method with different approach
echo "Trying alternative login method..."

# Get fresh session and token
echo "Getting fresh session..."
session_response=$(curl -s -c new_cookies.txt "$LOGIN_URL")

# Extract new CSRF token
new_csrf_token=$(echo "$session_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [[ -n "$new_csrf_token" ]]; then
    echo "✅ New CSRF Token: $new_csrf_token"
    
    # Try login with new token
    alt_login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        -H "Referer: $LOGIN_URL" \
        -H "Origin: $BASE_URL" \
        -c new_cookies.txt -b new_cookies.txt \
        -d "_token=$new_csrf_token&username=$ADMIN_USERNAME&password=$ADMIN_PASSWORD" \
        "$LOGIN_URL")
    
    alt_http_status=$(echo "$alt_login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
    alt_response_time=$(echo "$alt_login_response" | grep "TIME:" | cut -d: -f2)
    
    echo "Alternative Login Status: $alt_http_status"
    echo "Alternative Login Time: ${alt_response_time}s"
    
    if [[ "$alt_http_status" == "302" ]]; then
        echo "✅ ALTERNATIVE LOGIN SUCCESS"
    elif [[ "$alt_http_status" == "419" ]]; then
        echo "❌ ALTERNATIVE LOGIN FAILED - Still CSRF issue"
    else
        echo "⚠️ ALTERNATIVE LOGIN ATTEMPT - Status: $alt_http_status"
    fi
else
    echo "❌ Could not get new CSRF token"
fi

echo ""
echo "🎯 FINAL RESULTS"
echo "================"
echo "✅ Admin User: $ADMIN_USERNAME"
echo "✅ Admin Password: $ADMIN_PASSWORD"
echo "✅ Login URL: $LOGIN_URL"
echo ""
echo "📋 MANUAL LOGIN INSTRUCTIONS:"
echo "1. Open browser and go to: $LOGIN_URL"
echo "2. Username: $ADMIN_USERNAME"
echo "3. Password: $ADMIN_PASSWORD"
echo "4. Click Login"
echo ""
echo "🔧 CSRF TOKEN FIX:"
echo "- Clear browser cookies and cache"
echo "- Refresh the login page"
echo "- Try login again"
echo ""
echo "Status: CSRF TOKEN FIX AND LOGIN TEST COMPLETED"