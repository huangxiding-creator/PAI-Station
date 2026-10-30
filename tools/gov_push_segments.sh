#!/bin/bash
# 主仓分段全推守护 — 零历史改写，逐段 fast-forward（1030 治理役）
# 自适应段宽：段耗 >300s 减半，<90s 增大（上限80）；每段重试×3（退避30s×n）；连败3段停机待人工
set -u
cd /e/AI-Station || exit 1
LOG=/e/AI-Station/tools/gov_push_1030.log
N=20
seg=0
fail_streak=0
echo "[$(date '+%m-%d %H:%M:%S')] 分段推送启动：初始段宽=$N" >> "$LOG"
while :; do
  REMAIN=$(git rev-list --count origin/main..main 2>/dev/null)
  [ "${REMAIN:-1}" -eq 0 ] 2>/dev/null && { echo "[$(date '+%m-%d %H:%M:%S')] 全量推完（origin/main 已追平 main）" >> "$LOG"; break; }
  if [ "$REMAIN" -le "$N" ]; then
    TARGET=$(git rev-parse main)
  else
    TARGET=$(git rev-list --reverse origin/main..main | sed -n "${N}p")
  fi
  seg=$((seg+1))
  T0=$(date +%s)
  ok=0
  for try in 1 2 3; do
    if git push origin "$TARGET:refs/heads/main" >> "$LOG" 2>&1; then ok=1; break; fi
    echo "[$(date '+%m-%d %H:%M:%S')] 段$seg 第$try推失败，退避$((try*30))s" >> "$LOG"
    sleep $((try*30))
  done
  DT=$(( $(date +%s) - T0 ))
  if [ $ok -eq 1 ]; then
    fail_streak=0
    LEFT=$(git rev-list --count origin/main..main 2>/dev/null)
    echo "[$(date '+%m-%d %H:%M:%S')] 段$seg OK ${DT}s (->${TARGET:0:9}, 余${LEFT}条)" >> "$LOG"
    if   [ "$DT" -gt 300 ]; then N=$(( N/2 )); [ "$N" -lt 5 ] && N=5
    elif [ "$DT" -lt 90 ];  then N=$(( N*3/2 )); [ "$N" -gt 80 ] && N=80
    fi
  else
    fail_streak=$((fail_streak+1))
    echo "[$(date '+%m-%d %H:%M:%S')] 段$seg 三推皆败（目标${TARGET:0:9}），连败=$fail_streak" >> "$LOG"
    [ "$fail_streak" -ge 3 ] && { echo "[$(date '+%m-%d %H:%M:%S')] 连败3段→停机待人工（查 $LOG）" >> "$LOG"; exit 2; }
    N=$(( N/2 )); [ "$N" -lt 5 ] && N=5
  fi
done
echo "[$(date '+%m-%d %H:%M:%S')] 守护退出：共 $seg 段" >> "$LOG"
