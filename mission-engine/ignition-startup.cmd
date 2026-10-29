@echo off
rem MissionEngine ignition (copy to Startup folder for logon autostart, no admin needed)
rem W2.2: organs (zqg shield etc.) start first, idempotent via their own locks
cd /d E:\AI-Station\mission-engine
py -X utf8 organ_start.py >> logs\guard.log 2>&1
if not exist .auto-loop.pid (
  "C:\Program Files\Git\usr\bin\bash.exe" ./auto-loop.sh >> logs\guard.log 2>&1
) else (
  echo [%date% %time%] already running >> logs\guard.log
)
