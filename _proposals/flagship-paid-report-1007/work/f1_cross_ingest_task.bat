@echo off
rem F1 跨战役收割件增量入池 — 1011 采集域常驻腿 (幂等, 30min 一跑)
cd /d E:\AI-Station\_proposals\flagship-paid-report-1007\work
E:\AI-Station\.venv\Scripts\python.exe f1_cross_ingest.py >> f1_cross_ingest_task.log 2>&1
