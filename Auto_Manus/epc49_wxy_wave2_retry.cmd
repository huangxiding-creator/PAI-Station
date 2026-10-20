@echo off
chcp 65001 >nul
REM EPC49 wxy二波重试 (1005 07:03 一次性) — 1004 ccki镜像日限额耗尽自动顺延
REM 跑磁盘最新码: wrapper直接引用 _wxy_wave2.py / epc49_wxy_leg v3 / vendor pipeline v3
cd /d E:\AI-Station\Auto_Manus
C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe -u _wxy_wave2.py > E:\AI-Station\Auto_Manus\epc49_wxy_wave2_retry.log 2>&1
