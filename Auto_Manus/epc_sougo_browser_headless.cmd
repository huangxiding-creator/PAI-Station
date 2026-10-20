@echo off
rem Ensure collection browser runs headless (zero desktop windows).
rem Order 2026-10-03: browsers opened for data collection must be minimized/hidden.
rem Idempotent. Busy-guard -> daemon down -> kill 19826 chrome -> kill service by
rem :3000 port owner (cmdline filter never matches: cwd is not in cmdline) ->
rem headless msedge on 19826 with real UA and a REAL start page (about:blank
rem leaves no page target, daemon then fails with "No page target found") ->
rem relaunch service with BB_BROWSER_CDP_URL -> birth daemon via snapshot.
rem Never touches user chrome or the WeAIPO metaso browser (port 9222).
rem 1020 修: SGDIR 旧路径 E:\AIResearch(1012已失)→E:\AI-Station\ResearchFactory-Eng;
rem          浏览器口 19825→19826 (opencli daemon 长驻占用 19825, 抢绑必败);
rem          busy-guard 修连接拒绝误判 (服务死≠忙, 死=照常重建)。
chcp 65001 >nul
set NPM=C:\Users\91216\AppData\Roaming\npm
set PYDIR=C:\Users\91216\AppData\Local\Programs\Python\Python311
set SGDIR=E:\AI-Station\ResearchFactory-Eng\SouGouWeDown2
set CDP_PORT=19826

rem 0) busy guard: never switch browsers while a download task is running
rem    (exit 2 = 真"running":true; 服务不可达/异常 = exit 0 照常重建)
"%PYDIR%\python.exe" -c "import sys,urllib.request
try:
    body = urllib.request.urlopen('http://127.0.0.1:3000/api/status',timeout=5).read()
except Exception:
    sys.exit(0)
sys.exit(2 if b'\"running\":true' in body else 0)" >nul 2>&1
if errorlevel 2 (
  echo [headless] service busy, skip switch
  exit /b 2
)

rem 1) stop bb-browser daemon (let go of current browser)
call "%NPM%\bb-browser.cmd" daemon shutdown >nul 2>&1

rem 2) kill ONLY a chrome/msedge still holding CDP %CDP_PORT% (never user chrome, never 9222)
wmic process where "name='chrome.exe' and commandline like '%%19826%%'" call terminate >nul 2>&1

rem 3) kill SouGouWeDown2 service by :3000 port owner PID
for /f "tokens=5" %%p in ('netstat -ano ^| findstr ":3000" ^| findstr /i "LISTENING"') do taskkill /f /pid %%p >nul 2>&1
timeout /t 3 /nobreak >nul

rem 4) ensure a headless msedge owns %CDP_PORT% (skip if already ours)
set OWNER=
for /f "tokens=5" %%p in ('netstat -ano ^| findstr ":%CDP_PORT%" ^| findstr /i "LISTENING"') do set OWNER=%%p
set IS_EDGE=
if defined OWNER wmic process where "processid=%OWNER%" get name 2>nul | findstr /i "msedge" >nul && set IS_EDGE=1
if not defined IS_EDGE (
  start "" /b "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" --headless=new --remote-debugging-port=%CDP_PORT% --user-data-dir="%TEMP%\bb_profile_headless" --disable-gpu --user-agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36 Edg/129.0.0.0" https://www.sogou.com
  timeout /t 6 /nobreak >nul
)

rem 5) relaunch service hidden with BB_BROWSER_CDP_URL (attach to headless edge)
cd /d "%SGDIR%"
set BB_BROWSER_CDP_URL=http://127.0.0.1:%CDP_PORT%
powershell -NoProfile -Command "$env:BB_BROWSER_CDP_URL='http://127.0.0.1:%CDP_PORT%'; Start-Process -FilePath 'node' -ArgumentList 'dist/index.js' -WorkingDirectory '%SGDIR%' -WindowStyle Hidden"
timeout /t 5 /nobreak >nul

rem 6) birth daemon attached to headless edge (snapshot doubles as a page-target check)
call "%NPM%\bb-browser.cmd" snapshot >nul 2>&1

rem 7) report final state
curl -s --max-time 5 http://127.0.0.1:3000/api/status
echo.
exit /b 0
