#!/bin/bash
# ESS lane keeper — nb_lane(7895) 车道守门 (1105):
# 仅当 ESS NBLM 跑者存活期间: 每10分钟探活7895; 内核死则照原配置拉起(不切出口不改配置).
# 跑者不在 => 守门退休(车道寿命绑定产线寿命, 不逆用户网络姿态).
# 日志: m2/ess/nblm_lane_keeper.log
export PYTHONIOENCODING=utf8
LOG=/e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess/nblm_lane_keeper.log
KER=/e/AI-Station/tools/bin/clash-core.exe
CFG_D="C:/Users/91216/.config/clash"
CFG_F="C:/Users/91216/.config/clash/fomi_nb_run.yaml"

runner_alive() {
  wmic process where "name='python.exe' or name='py.exe'" get commandline 2>/dev/null | grep -q "ess_nblm_run" && return 0
  wmic process where "name='bash.exe'" get commandline 2>/dev/null | grep -q "ess_supervisor"
}

echo "[$(date +%m-%d\ %H:%M)] keeper 上岗" >> "$LOG"
while true; do
  if ! runner_alive; then
    echo "[$(date +%m-%d\ %H:%M)] keeper: 无ess_nblm_run跑者 — 退休" >> "$LOG"
    exit 0
  fi
  CODE=$(curl -s -m 12 -x http://127.0.0.1:7895 -o /dev/null -w "%{http_code}" "https://notebooklm.google.com" 2>/dev/null)
  if [ "$CODE" = "000" ]; then
    if ! netstat -an 2>/dev/null | grep -q "127.0.0.1:7895.*LISTENING"; then
      echo "[$(date +%m-%d\ %H:%M)] keeper: 7895内核死(跑者在) — 照原配置拉起" >> "$LOG"
      "$KER" -d "$CFG_D" -f "$CFG_F" >> "$LOG" 2>&1 &
      sleep 10
      CODE2=$(curl -s -m 15 -x http://127.0.0.1:7895 -o /dev/null -w "%{http_code}" "https://notebooklm.google.com" 2>/dev/null)
      echo "[$(date +%m-%d\ %H:%M)] keeper: 拉起后探针=$CODE2" >> "$LOG"
    else
      echo "[$(date +%m-%d\ %H:%M)] keeper: 7895在听但NBLM=$CODE (出口侧问题, 不动配置)" >> "$LOG"
    fi
  fi
  sleep 600
done
