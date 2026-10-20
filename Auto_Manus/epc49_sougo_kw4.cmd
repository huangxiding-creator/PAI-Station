@echo off
rem EPC49 搜狗夜腿二班 (schtasks EPC49-Sougo-Kw4 每晚 04:20 载荷, 1004 夜班扩容令).
rem 用户令: 晚上黄金窗充分利用 (用户不动电脑+网络空闲). 一班 22:47 跑完约
rem 00:47, opencli 01:47-03:30 换防后 headless.cmd 已还原三位一体, 本班接力
rem 再取下 4 词. 账号安全: 全夜合计 8 词, 沿用同浏览器+delayMin 3-6s 节流.
chcp 65001 >nul
call E:\AI-Station\Auto_Manus\epc_sougo_browser_headless.cmd
cd /d E:\AI-Station\Auto_Manus
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo.py --next 4 > E:\AI-Station\Auto_Manus\epc49_sougo_kw4.log 2>&1
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe epc49_sougo_harvest.py >> E:\AI-Station\Auto_Manus\epc49_sougo_kw4.log 2>&1
