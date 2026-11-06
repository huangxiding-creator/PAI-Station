#!/bin/bash
# ESS ch12 NBLM追版哨(独立进程版): 2h一探区域闸, 连2清写标记文件(主会话可见)
LOG=/e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess/nblm_gate_watch.log
FLAG=/e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess/GATE_CLEAN_FLAG
echo "[$(date +%m-%d\ %H:%M)] 追版哨上岗(独立进程)" >> "$LOG"
CLEAN=0
for i in $(seq 1 8); do
  sleep 7200
  RED=$(curl -s -m 15 -x http://127.0.0.1:7895 -o /dev/null -w "%{redirect_url}" "https://notebooklm.google.com" 2>/dev/null)
  echo "[$(date +%m-%d\ %H:%M)] 追版探$i: ${RED:0:70} (连清=$CLEAN)" >> "$LOG"
  if [ -n "$RED" ] && ! echo "$RED" | grep -q "unsupported"; then
    CLEAN=$((CLEAN+1))
    if [ "$CLEAN" -ge 2 ]; then
      echo "[$(date +%m-%d\ %H:%M)] 闸连清x2 — 可单发ch12追版" >> "$LOG"
      echo "$(date +%F\ %H:%M)" > "$FLAG"
      exit 0
    fi
  else
    CLEAN=0
  fi
done
echo "[$(date +%m-%d\ %H:%M)] 16h未清 — ch12维持NB对照稿" >> "$LOG"
