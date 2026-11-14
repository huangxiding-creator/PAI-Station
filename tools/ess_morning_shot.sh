#!/bin/bash
# 晨间单发: 等到07:00 → ESS ch12追版一轮 → 落盘则接OVERSEAS框架一轮
# (1106深夜判: 区域闸在生成压力下翻脸, 过夜静默+晨间单发是最优解)
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess
LOG=nblm_gate_watch.log
NOW=$(date +%s)
TARGET=$(date -d "07:00" +%s)
[ "$TARGET" -le "$NOW" ] && TARGET=$((TARGET + 86400))
WAIT=$((TARGET - NOW))
echo "[$(date +%m-%d\ %H:%M)] 晨间单发挂岗: 睡$((WAIT/60))分钟至07:00" >> "$LOG"
sleep $WAIT
echo "[$(date +%m-%d\ %H:%M)] 晨间到点 — 探闸" >> "$LOG"
RED=$(curl -s -m 15 -x http://127.0.0.1:7895 -o /dev/null -w "%{redirect_url}" "https://notebooklm.google.com" 2>/dev/null)
echo "[$(date +%m-%d\ %H:%M)] 闸态: ${RED:0:70}" >> "$LOG"
if [ -n "$RED" ] && ! echo "$RED" | grep -q "unsupported"; then
  echo "[$(date +%m-%d\ %H:%M)] 闸清 — ESS ch12单发(supervisor ch12模式)" >> "$LOG"
  bash /e/AI-Station/tools/ess_supervisor.sh
  if [ -f sched/_ch12_nblm.md ]; then
    echo "[$(date +%m-%d\ %H:%M)] ch12落盘 — 接OVERSEAS框架" >> "$LOG"
    cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/overseas
    NBLM_PROXY=http://127.0.0.1:7895 NOTEBOOKLM_TRANSPORT=curl_cffi \
      py -3 -X utf8 overseas_nblm_run.py --phase framework > nblm_framework.log 2>&1
    echo "[$(date +%m-%d\ %H:%M)] OVERSEAS框架轮exit=$? — 见nblm_framework.log" >> "$LOG"
  else
    echo "[$(date +%m-%d\ %H:%M)] ch12未落 — OVERSEAS不启(防双压闸)" >> "$LOG"
  fi
else
  echo "[$(date +%m-%d\ %H:%M)] 闸仍闭 — 顺延2h再单发" >> "$LOG"
  sleep 7200
  bash /e/AI-Station/tools/ess_supervisor.sh
fi
echo "[$(date +%m-%d\ %H:%M)] 晨间单发流程毕" >> "$LOG"
