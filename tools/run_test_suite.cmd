@echo off
rem 夜间全套测试（PAIStation-test-suite 04:00 调用；OCR 风暴白天挤死 pytest 的替代窗）
cd /d E:\AI-Station
E:\AI-Station\.venv\Scripts\pythonw.exe -m pytest --tb=short -p no:cacheprovider > E:\AI-Station\data\local_index\test_suite_latest.log 2>&1
