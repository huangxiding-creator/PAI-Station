@echo off
chcp 65001 >nul
call E:\AI-Station\Auto_Manus\epc_sougo_browser_headless.cmd
cd /d E:\AI-Station\Auto_Manus
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo.py --limit 1 > E:\AI-Station\Auto_Manus\epc49_sougo_kw1.log 2>&1
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo.py --from 3 --limit 4 >> E:\AI-Station\Auto_Manus\epc49_sougo_kw1.log 2>&1
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo_harvest.py >> E:\AI-Station\Auto_Manus\epc49_sougo_kw1.log 2>&1
