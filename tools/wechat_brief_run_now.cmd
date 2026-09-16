@echo off
rem Run WeChat brief pipeline in foreground for manual testing.
rem Keep ASCII-only: cmd.exe parses this with the ANSI codepage.
"E:\AI-Station\.venv\Scripts\python.exe" "E:\AI-Station\tools\wechat_brief_daily.py" %*
pause
