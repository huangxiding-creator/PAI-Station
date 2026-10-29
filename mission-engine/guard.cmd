@echo off
rem MissionEngine 5-min revival guard (schtasks TR target)
rem W2.2: revive organs too (idempotent, organs self-abdicate via own locks)
cd /d E:\AI-Station\mission-engine
py -X utf8 organ_start.py >> logs\guard.log 2>&1
"C:\Program Files\Git\usr\bin\bash.exe" ./auto-loop.sh >> logs\guard.log 2>&1
