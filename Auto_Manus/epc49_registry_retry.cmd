@echo off
rem EPC49 注册表重试班 (schtasks EPC49-Registry-Retry 每晚 03:37).
rem 1004 夜班扩容: 23:00 班的失败线 (ccgp 反爬冷却/creditchina 不可达/
rem shixin 选择器/em_news) 跨 4.5h 冷却窗后重试; 成功线不重扫省带宽.
chcp 65001 >nul
cd /d E:\AI-Station\Auto_Manus
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_registry_night.py --only ccgp,creditchina,shixin,em_news,patents,standards --tag retry > E:\AI-Station\Auto_Manus\epc49_registry_retry.log 2>&1
