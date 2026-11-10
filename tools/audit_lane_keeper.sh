#!/bin/bash
# audit_lane_keeper — AUDIT产线车道守门: 7895死且跑者在→照原配置拉起内核
LOG=/e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/audit/lane_keeper.log
KER=/e/AI-Station/tools/bin/clash-core.exe
CFG_D="C:/Users/91216/.config/clash"
CFG_F="C:/Users/91216/.config/clash/fomi_nb_run.yaml"
echo "[$(date +%m-%d\ %H:%M)] audit keeper上岗" >> "$LOG"
while true; do
  if ! wmic process where "name='python.exe' or name='py.exe'" get commandline 2>/dev/null | grep -q "audit_nblm_run"; then
    echo "[$(date +%m-%d\ %H:%M)] 跑者不在 — 退休" >> "$LOG"
    exit 0
  fi
  CODE=$(curl -s -m 12 -x http://127.0.0.1:7895 -o /dev/null -w "%{http_code}" "https://notebooklm.google.com" 2>/dev/null)
  if [ "$CODE" = "000" ]; then
    echo "[$(date +%m-%d\ %H:%M)] 7895死(跑者在) — 拉内核" >> "$LOG"
    "$KER" -d "$CFG_D" -f "$CFG_F" >> "$LOG" 2>&1 &
    sleep 10
    echo "[$(date +%m-%d\ %H:%M)] 拉起后=$(curl -s -m 15 -x http://127.0.0.1:7895 -o /dev/null -w '%{http_code}' https://notebooklm.google.com 2>/dev/null)" >> "$LOG"
  fi
  sleep 300
done
