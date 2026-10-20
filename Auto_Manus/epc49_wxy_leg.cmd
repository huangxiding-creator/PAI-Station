@echo off
REM EPC49 文献云全文腿入口 (v1) — 杜绝旧码: 本 cmd 只调 Auto_Manus\epc49_wxy_leg.py
cd /d E:\AI-Station
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe Auto_Manus\epc49_wxy_leg.py >> Auto_Manus\epc49_wxy_leg.log 2>&1
