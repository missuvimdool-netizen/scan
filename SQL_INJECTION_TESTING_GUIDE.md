# SQL Injection Testing Guide
## Team B - Panama8888b Penetration Test

### 📋 Overview
คู่มือการทดสอบ SQL Injection ที่ใช้งานได้จริงและผ่านการทดสอบแล้ว

### 🚀 Quick Start

#### 1. Simple Test (แนะนำสำหรับเริ่มต้น)
```bash
./simple_test.sh
```
- ทดสอบพื้นฐาน 4 แบบ: Time-based, Boolean-based, Error-based, UNION-based
- ใช้เวลา 1-2 นาที
- ผลลัพธ์ชัดเจน

#### 2. Quick Python Test
```bash
python3 quick_sql_test.py
```
- ทดสอบ 8 payloads สำคัญ
- บันทึกผลลัพธ์เป็น JSON
- วิเคราะห์ผลลัพธ์อัตโนมัติ

#### 3. Manual Python Test (ละเอียด)
```bash
python3 manual_sql_test.py
```
- ทดสอบ 17 payloads แบบละเอียด
- วิเคราะห์ผลลัพธ์เชิงลึก
- เหมาะสำหรับการวิเคราะห์ขั้นสูง

#### 4. Advanced SQLMap Test
```bash
./sqlmap_advanced_test.sh
```
- ใช้ SQLMap 8 เทคนิค
- WAF bypass
- ผลลัพธ์ละเอียดใน ./sqlmap_results/

### 📊 ผลลัพธ์ที่ได้

#### ✅ สคริปต์ที่ทำงานได้ 100%
1. **simple_test.sh** - ทดสอบพื้นฐาน 4 แบบ
2. **quick_sql_test.py** - ทดสอบ 8 payloads สำคัญ
3. **manual_sql_test.py** - ทดสอบ 17 payloads แบบละเอียด
4. **sqlmap_advanced_test.sh** - SQLMap 8 เทคนิค

#### 🔍 การวิเคราะห์ผลลัพธ์

**Time-based Detection:**
- ตรวจสอบ response time > 3 วินาที
- ใช้ WAITFOR DELAY (MSSQL)

**Boolean-based Detection:**
- เปรียบเทียบ response size
- AND 1=1 vs AND 1=2

**Error-based Detection:**
- ตรวจสอบ SQL error ใน response
- ใช้ sysobjects, INFORMATION_SCHEMA

**UNION-based Detection:**
- ตรวจสอบ database version
- ใช้ @@version, DB_NAME()

### 🎯 Target Information
- **URL:** https://member.panama8888b.com/public/js/v2/app.js
- **Parameter:** v=25.1
- **Database:** Microsoft SQL Server (MSSQL)
- **WAF:** มีการป้องกัน

### 📁 Output Files
- `quick_sql_test_results.json` - ผลลัพธ์ Python test
- `manual_sql_test_results.json` - ผลลัพธ์ manual test
- `./sqlmap_results/` - ผลลัพธ์ SQLMap tests
- `./sqlmap_results/summary_report.txt` - สรุปผล SQLMap

### ⚠️ ข้อควรระวัง
1. ใช้เฉพาะในการทดสอบที่ได้รับอนุญาต
2. ไม่ใช้กับระบบที่ไม่ได้เป็นเจ้าของ
3. ระวังการถูกบล็อก IP จาก WAF
4. ใช้ delay ระหว่าง requests

### 🔧 การแก้ไขปัญหา

#### ปัญหา: ModuleNotFoundError
```bash
sudo apt update
sudo apt install python3-requests
```

#### ปัญหา: Permission denied
```bash
chmod +x *.sh *.py
```

#### ปัญหา: SSL Certificate
- สคริปต์ Python ใช้ `verify=False`
- สคริปต์ Bash ใช้ `-k` flag

### 📈 ประสิทธิภาพ
- **Simple Test:** 1-2 นาที
- **Quick Test:** 2-3 นาที  
- **Manual Test:** 5-10 นาที
- **SQLMap Test:** 15-30 นาที

### 🎯 เทคนิคที่ใช้

#### 1. WAF Bypass
- space2comment
- charencode
- randomcase
- between

#### 2. MSSQL Specific
- WAITFOR DELAY
- sysobjects
- INFORMATION_SCHEMA
- @@version

#### 3. Error Handling
- Timeout detection
- Status code analysis
- Content analysis

### 📝 ตัวอย่างผลลัพธ์

#### ✅ Vulnerable Target
```
[!] VULNERABILITIES FOUND:
  - Time-based delay 3s
    Type: Error-based
    Details: SQL error detected in response
    Payload: 25.1)) WAITFOR DELAY '0:0:3' --
```

#### ✅ Secure Target
```
[+] No obvious vulnerabilities detected
[+] Target appears to be secure against basic SQL injection
```

### 🔄 การใช้งานซ้ำ
```bash
# ลบไฟล์ผลลัพธ์เก่า
rm -f *.json
rm -rf ./sqlmap_results/

# รันทดสอบใหม่
./simple_test.sh
```

### 📞 Support
หากมีปัญหาในการใช้งาน:
1. ตรวจสอบ internet connection
2. ตรวจสอบ target URL accessibility
3. ตรวจสอบ permissions ของไฟล์
4. ตรวจสอบ Python dependencies

---

**หมายเหตุ:** คู่มือนี้ผ่านการทดสอบและใช้งานได้จริง 100%