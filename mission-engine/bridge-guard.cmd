@echo off
rem 微信Claw桥守护(W4.3b) - Windows版daemon: node dist/main.js start 常驻
cd /d C:\Users\91216\.claude\skills\wechat-claude-code
node dist\main.js start >> daemon_win.log 2>&1
