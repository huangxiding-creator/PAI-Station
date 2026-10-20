@echo off
rem EPC49 KB+registry night leg (1003 all-channels order). ASCII-only wrapper:
rem all Chinese paths/args live inside the python scripts (UTF-8 source).
rem Serial: ima KB-998 - lark export - registry HTTP sweep - ima_public 2 KBs.
set PY=C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe
set LOG=E:\AI-Station\Auto_Manus\epc49_kb_night.log
set PYTHONIOENCODING=utf-8
cd /d E:\AI-Station\Auto_Manus
echo [%date% %time%] kb-night start >> "%LOG%"
"%PY%" epc49_ima_harvest.py >> "%LOG%" 2>&1
"%PY%" epc49_lark_harvest.py >> "%LOG%" 2>&1
"%PY%" epc49_registry_night.py >> "%LOG%" 2>&1
"%PY%" epc49_imapub_harvest.py >> "%LOG%" 2>&1
echo [%date% %time%] kb-night done >> "%LOG%"
