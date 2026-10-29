@echo off
cd /d E:\AI-Station\mission-engine
echo [STEP1]CD_OK >> E:\AI-Station\mission-engine\logs\detached_cycle.log
"C:\Program Files\Git\usr\bin\bash.exe" --noprofile --norc /e/AI-Station/mission-engine/run-cycle.sh >> E:\AI-Station\mission-engine\logs\detached_cycle.log 2>&1
echo [STEP3]BASH_EXIT=%ERRORLEVEL% >> E:\AI-Station\mission-engine\logs\detached_cycle.log
