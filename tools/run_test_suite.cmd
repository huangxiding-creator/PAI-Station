@echo off
rem Nightly full test suite (PAIStation-test-suite 04:00 fallback; primary = watcher after extract)
rem Idempotent guard: skip if test_suite_latest.log written within 3h (watcher already ran)
rem NOTE: keep this file ASCII-only. UTF-8 Chinese comments corrupt cmd parsing under
rem       GBK codepage (cd line gets swallowed -> cwd stays System32 -> pytest scans it).
cd /d E:\AI-Station
powershell -NoProfile -Command "if ((Get-Item 'E:\AI-Station\data\local_index\test_suite_latest.log' -ErrorAction SilentlyContinue) -and (((Get-Date) - (Get-Item 'E:\AI-Station\data\local_index\test_suite_latest.log').LastWriteTime).TotalHours -lt 3)) { exit 1 }"
if errorlevel 1 exit /b 0
E:\AI-Station\.venv\Scripts\pythonw.exe -m pytest tests --tb=short -p no:cacheprovider > E:\AI-Station\data\local_index\test_suite_latest.log 2>&1
