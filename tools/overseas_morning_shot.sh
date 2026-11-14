#!/bin/bash
# 明晨05:30深谷单发: OVERSEAS框架(第15份) → 成功后ESS ch12单发(顺序缓压)
# (1107晨判: 鉴权RPC被闸歧视性拦截, curl假阳性; 账号静默24h后首单)
export NBLM_PROXY=http://127.0.0.1:7895
export NOTEBOOKLM_TRANSPORT=curl_cffi
ESS=/e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess
OV=/e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/overseas
LOG=$OV/nblm_gate_watch.log
NOW=$(date +%s)
TARGET=$(date -d "05:30" +%s)
[ "$TARGET" -le "$NOW" ] && TARGET=$((TARGET + 86400))
echo "[$(date +%m-%d\ %H:%M)] 晨05:30单发挂岗: 睡$(( (TARGET-NOW)/60 ))分钟" >> "$LOG"
sleep $((TARGET - NOW))
echo "[$(date +%m-%d\ %H:%M)] === 晨间首单: OVERSEAS框架 ===" >> "$LOG"
cd "$OV"
py -3 -X utf8 overseas_nblm_run.py --phase framework > nblm_framework.log 2>&1
RC=$?
echo "[$(date +%m-%d\ %H:%M)] OVERSEAS框架 exit=$RC" >> "$LOG"
if [ $RC -eq 0 ] && [ -f sched/nblm_out/00_框架.md ]; then
  echo "[$(date +%m-%d\ %H:%M)] 框架成 — 缓10分钟后ESS ch12单发" >> "$LOG"
  sleep 600
  cd "$ESS"
  py -3 -X utf8 ess_nblm_run.py --phase chapters --chapters 12 >> nblm_all.log 2>&1
  echo "[$(date +%m-%d\ %H:%M)] ESS ch12 exit=$? (落盘=$([ -f sched/_ch12_nblm.md ] && echo Y || echo N))" >> "$LOG"
else
  echo "[$(date +%m-%d\ %H:%M)] 框架未成 — 不再压, 待人工/下窗" >> "$LOG"
fi
