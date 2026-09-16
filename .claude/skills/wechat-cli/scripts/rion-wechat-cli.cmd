@echo off
rem rion-wechat-cli Windows executable shim for CreateProcess callers (wechat-intelligence-hub).
rem Same engine as rion-cli: vendor venv python + rion_wechat_reader.py (read-only).
rem Keep this file ASCII-only: cmd.exe parses it with the ANSI codepage.
set "PYTHONUTF8=1"
"E:\AI-Station\vendor\wechat-intelligence-hub\.venv\Scripts\python.exe" "E:\AI-Station\vendor\wechat-intelligence-hub\projects\rion-wechat-reader\rion_wechat_reader.py" %*
