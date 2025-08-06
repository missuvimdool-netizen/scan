#!/bin/bash

echo "🔍 TESTING NORMAL USER LOGIN FOR COMPARISON"
echo "==========================================="

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

# Normal user credentials (from user)
NORMAL_USERNAME="0630471054"
NORMAL_PASSWORD="laline1812"

# Admin user credentials (created by us)
ADMIN_USERNAME="wp_admin_2025"
ADMIN_PASSWORD="WpAdmin123!@#"

echo "🔑 Testing Credentials:"
echo "Normal User: $NORMAL_USERNAME / $NORMAL_PASSWORD"
echo "Admin User: $ADMIN_USERNAME / $ADMIN_PASSWORD"
echo ""

echo "🔍 STEP 1: TESTING NORMAL USER LOGIN..."
echo "======================================="

# Get fresh CSRF token
echo "Getting fresh CSRF token..."
csrf_response=$(curl -s -c cookies.txt "$LOGIN_URL")
csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [[ -n "$csrf_token" ]]; then
    echo "✅ CSRF Token: $csrf_token"
    
    # Test normal user login
    echo "Testing normal user login..."
    normal_login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        -H "Referer: $LOGIN_URL" \
        -H "Origin: $BASE_URL" \
        -c cookies.txt -b cookies.txt \
        -d "_token=$csrf_token&username=$NORMAL_USERNAME&password=$NORMAL_PASSWORD" \
        "$LOGIN_URL")
    
    normal_http_status=$(echo "$normal_login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
    normal_response_time=$(echo "$normal_login_response" | grep "TIME:" | cut -d: -f2)
    
    echo "Normal User Login Status: $normal_http_status"
    echo "Normal User Login Time: ${normal_response_time}s"
    
    if [[ "$normal_http_status" == "302" ]]; then
        echo "✅ NORMAL USER LOGIN SUCCESS"
    else
        echo "❌ NORMAL USER LOGIN FAILED - Status: $normal_http_status"
    fi
else
    echo "❌ Could not get CSRF token"
fi

echo ""
echo "🔍 STEP 2: TESTING ADMIN USER LOGIN..."
echo "======================================"

# Get fresh CSRF token for admin test
echo "Getting fresh CSRF token for admin test..."
csrf_response2=$(curl -s -c cookies2.txt "$LOGIN_URL")
csrf_token2=$(echo "$csrf_response2" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [[ -n "$csrf_token2" ]]; then
    echo "✅ CSRF Token: $csrf_token2"
    
    # Test admin user login
    echo "Testing admin user login..."
    admin_login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
        -H "Referer: $LOGIN_URL" \
        -H "Origin: $BASE_URL" \
        -c cookies2.txt -b cookies2.txt \
        -d "_token=$csrf_token2&username=$ADMIN_USERNAME&password=$ADMIN_PASSWORD" \
        "$LOGIN_URL")
    
    admin_http_status=$(echo "$admin_login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
    admin_response_time=$(echo "$admin_login_response" | grep "TIME:" | cut -d: -f2)
    
    echo "Admin User Login Status: $admin_http_status"
    echo "Admin User Login Time: ${admin_response_time}s"
    
    if [[ "$admin_http_status" == "302" ]]; then
        echo "✅ ADMIN USER LOGIN SUCCESS"
    else
        echo "❌ ADMIN USER LOGIN FAILED - Status: $admin_http_status"
    fi
else
    echo "❌ Could not get CSRF token for admin test"
fi

echo ""
echo "🔍 STEP 3: CHECKING USER ROLES..."
echo "================================="

# Check if admin user was actually created
echo "Checking if admin user exists in database..."
check_admin_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
    -H "Content-Type: application/json" \
    -H "X-XSRF-TOKEN: $csrf_token2" \
    -H "Cookie: XSRF-TOKEN=$csrf_token2; panama888_session=$(grep panama888_session cookies2.txt | cut -f7)" \
    -d "{\"id\":\"1' SELECT username, role FROM users WHERE username='$ADMIN_USERNAME'--\"}" \
    "$BASE_URL/api/announcement")

check_http_status=$(echo "$check_admin_response" | grep "HTTP_STATUS:" | cut -d: -f2)
echo "Check Admin User Status: $check_http_status"

if [[ "$check_http_status" == "500" ]]; then
    echo "✅ ADMIN USER EXISTS IN DATABASE"
else
    echo "❌ ADMIN USER NOT FOUND IN DATABASE"
fi

echo ""
echo "🎯 COMPARISON RESULTS"
echo "===================="
echo "Normal User ($NORMAL_USERNAME):"
echo "- Login Status: $normal_http_status"
echo "- Expected: 302 (Success)"
echo ""
echo "Admin User ($ADMIN_USERNAME):"
echo "- Login Status: $admin_http_status"
echo "- Expected: 302 (Success)"
echo ""
echo "📋 ANALYSIS:"
if [[ "$normal_http_status" == "302" && "$admin_http_status" == "302" ]]; then
    echo "✅ Both users can login successfully"
    echo "⚠️ Admin user may not have admin privileges"
elif [[ "$normal_http_status" == "302" && "$admin_http_status" != "302" ]]; then
    echo "❌ Admin user login failed"
    echo "⚠️ Admin user may not exist or password incorrect"
else
    echo "❌ Login issues with both users"
fi
echo ""
echo "Status: LOGIN COMPARISON TEST COMPLETED"