#!/bin/bash
# ESS supervisor — 跑者监督兜底 (1105): 跑者无声死亡时5分钟幂等重拉, 直至12章齐.
# ess_nblm_run.py 全链幂等 (已落盘≥门章自动skip, 差门章[regen]重产, 本/源按账复用).
# 退出条件: 12章齐 或 连续20次失败. 日志: m2/ess/nblm_supervisor.log
export PYTHONIOENCODING=utf8
export NBLM_PROXY=http://127.0.0.1:7895
export NOTEBOOKLM_TRANSPORT=curl_cffi
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess
LOG=nblm_supervisor.log
MAXTRY=20
echo "[$(date +%m-%d\ %H:%M)] supervisor 上岗" >> "$LOG"
for i in $(seq 1 $MAXTRY); do
  # 1106 02:0x 令: 单点ch12 (8-11已齐; ch01差274/ch11差2字由收编补, 不烧重产)
  py -3 -X utf8 ess_nblm_run.py --phase chapters --chapters 12 >> nblm_all.log 2>&1
  RC=$?
  CNT=$(ls sched/_ch[0-9][0-9]_nblm.md 2>/dev/null | grep -c .)
  echo "[$(date +%m-%d\ %H:%M)] 第${i}轮 rc=$RC 章稿${CNT}/12" >> "$LOG"
  if [ "$CNT" -ge 12 ]; then
    echo "[$(date +%m-%d\ %H:%M)] 12章齐 — supervisor 收工" >> "$LOG"
    exit 0
  fi
  if [ "$i" -lt "$MAXTRY" ]; then
    echo "[$(date +%m-%d\ %H:%M)] 300s后重拉" >> "$LOG"
    sleep 300
  fi
done
echo "[$(date +%m-%d\ %H:%M)] 连续${MAXTRY}轮未齐 — supervisor 放弃, 待人工" >> "$LOG"
exit 1
