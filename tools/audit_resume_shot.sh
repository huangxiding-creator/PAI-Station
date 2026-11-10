#!/bin/bash
# audit_resume_shot — 4h养号后单发ch7-12 (1110 双跑触闸的恢复件)
export NBLM_PROXY=http://127.0.0.1:7895
export NOTEBOOKLM_TRANSPORT=curl_cffi
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/audit
LOG=nblm_ch2.log
echo "[$(date +%m-%d\ %H:%M)] 养号4h计时开始" >> "$LOG"
sleep 14400
echo "[$(date +%m-%d\ %H:%M)] 单发ch7-12" >> "$LOG"
py -3 -X utf8 audit_nblm_run.py --phase chapters --chapters 7,8,9,10,11,12 >> "$LOG" 2>&1
echo "[$(date +%m-%d\ %H:%M)] 单发毕 落盘$(ls sched/_ch[0-9][0-9]_nblm.md 2>/dev/null | wc -l)/12" >> "$LOG"
# 守门随行
