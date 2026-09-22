@echo off
rem Manus webhook 事件收割器 — 计划任务包装 (0923)
rem 每 5 分钟单次拉增量; 不弹窗; 日志滚动.
cd /d E:\AI-Station\Auto_Manus
E:\AI-Station\.venv\Scripts\python.exe hook_harvest.py >> data\hook_harvest_task.log 2>&1
