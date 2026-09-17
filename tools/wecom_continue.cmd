@echo off
cd /d E:\AI-Station
E:\AI-Station\.venv\Scripts\python.exe tools\cx_wecom.py --pull >> data\cx\wecom_continue.log 2>&1
