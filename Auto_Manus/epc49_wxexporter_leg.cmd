@echo off
REM EPC49 官微全历史导出腿入口 (v1) — 杜绝旧码: 本 cmd 只调 Auto_Manus\epc49_wxexporter_leg.py
cd /d E:\AI-Station
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe Auto_Manus\epc49_wxexporter_leg.py >> Auto_Manus\epc49_wxexporter_leg.log 2>&1
