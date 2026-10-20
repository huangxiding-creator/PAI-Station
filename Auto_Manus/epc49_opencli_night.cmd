@echo off
rem EPC49 opencli night leg (1003 all-channels order): 19825 swap after kw2.
rem Waits for sogou idle, borrows the port for opencli daemon, restores after.
set PY=C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe
set PYTHONIOENCODING=utf-8
cd /d E:\AI-Station\Auto_Manus
"%PY%" epc49_opencli_night.py > epc49_opencli_night.log 2>&1
