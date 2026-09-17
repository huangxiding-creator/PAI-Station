@echo off
rem 夜间全套测试（PAIStation-test-suite 04:00 兜底；常规路径=watcher 提取完即测）
rem 幂等守卫：3 小时内已跑过（watcher 已触发）则跳过，防双跑
cd /d E:\AI-Station
powershell -NoProfile -Command "if ((Get-Item 'E:\AI-Station\data\local_index\test_suite_latest.log' -ErrorAction SilentlyContinue) -and (((Get-Date) - (Get-Item 'E:\AI-Station\data\local_index\test_suite_latest.log').LastWriteTime).TotalHours -lt 3)) { exit 1 }"
if errorlevel 1 exit /b 0
E:\AI-Station\.venv\Scripts\pythonw.exe -m pytest --tb=short -p no:cacheprovider > E:\AI-Station\data\local_index\test_suite_latest.log 2>&1
