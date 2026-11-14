#!/bin/bash
# ima登录态守护: 每6h ensure_token刷新(refresh_token 30天窗内永续)
export PYTHONIOENCODING=utf8
while true; do
  echo "[$(date +%F' '%H:%M)] ima token keepalive" >> /e/AI-Station/data/state/ima_keeper.log
  py -3 -X utf8 /e/AI-Station/.claude/skills/ima-kb-harvest/scripts/harvest.py status >> /e/AI-Station/data/state/ima_keeper.log 2>&1
  sleep 21600
done
