@echo off
chcp 65001 >nul
cd /d E:\AI-Station\Auto_Manus
"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe" epc50_sougo.py --keywords-file epc50_sougo_words_todo.txt > E:\AI-Station\Auto_Manus\sougo_night_run.log 2>&1
