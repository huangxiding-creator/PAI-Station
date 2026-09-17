@echo off
rem 21:50 夜班恢复：启用 watch 任务+撤 usn 暂停旗标（对应白天暂停 2026-09-17）
schtasks /change /tn "PAIStation-live-watch" /enable
schtasks /change /tn "PAIStation-signal-stream-watchdog" /enable
del E:\AI-Station\data\local_index\PAUSE
