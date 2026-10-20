@echo off
rem EPC49 弹药入账班载荷 (schtasks EPC49-PoolJudge-2137 / -0040).
rem 零网络: 收割器落盘文件 → ingest(pending) → judge(有效才计数).
chcp 65001 >nul
cd /d E:\AI-Station\Auto_Manus
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_pool_ingest.py > E:\AI-Station\Auto_Manus\epc49_pool_ingest.log 2>&1
