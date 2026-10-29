@echo off
cd /d E:\AI-Station\zhipu-quota-guard
E:\AI-Station\.venv\Scripts\pythonw.exe -X utf8 -m zqg.daemon >> state\daemon_stdout.log 2>&1
