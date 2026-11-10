#!/bin/bash
# audit_long_sentry — AUDIT ch7-12追版长哨: 每日05:30单发, 3日horizon
export NBLM_PROXY=http://127.0.0.1:7895
export NOTEBOOKLM_TRANSPORT=curl_cffi
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/audit
LOG=nblm_ch2.log
for day in 1 2 3; do
  NOW=$(date +%s); T=$(date -d "05:30" +%s); [ "$T" -le "$NOW" ] && T=$((T+86400))
  echo "[$(date +%m-%d\ %H:%M)] 追版哨第${day}日: 睡$(( (T-NOW)/60 ))分钟" >> "$LOG"
  sleep $((T-NOW))
  echo "[$(date +%m-%d\ %H:%M)] 追版第${day}日单发" >> "$LOG"
  py -3 -X utf8 audit_nblm_run.py --phase chapters --chapters 7,8,9,10,11,12 >> "$LOG" 2>&1
  N=$(ls sched/_ch[0-9][0-9]_nblm.md 2>/dev/null | wc -l)
  echo "[$(date +%m-%d\ %H:%M)] 第${day}日毕 落盘${N}/12" >> "$LOG"
  [ "$N" -ge 12 ] && break
done
echo "[$(date +%m-%d\ %H:%M)] 追版哨收班 落盘$(ls sched/_ch[0-9][0-9]_nblm.md 2>/dev/null | wc -l)/12" >> "$LOG"
