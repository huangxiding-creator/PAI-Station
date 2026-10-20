@echo off
rem EPC49 搜狗夜腿一班 (schtasks EPC49-Sougo-Kw2 每晚 22:47 载荷).
rem 1004: 自动取词模式 --next 4 (游标 data/sougo_kw_cursor.json, 起始=8:
rem 词1-8 已实跑), 词池 24 词自动前进, captcha 死锁根修 (unstick_service).
chcp 65001 >nul
call E:\AI-Station\Auto_Manus\epc_sougo_browser_headless.cmd
cd /d E:\AI-Station\Auto_Manus
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo.py --next 4 > E:\AI-Station\Auto_Manus\epc49_sougo_kw2.log 2>&1
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo_harvest.py >> E:\AI-Station\Auto_Manus\epc49_sougo_kw2.log 2>&1
