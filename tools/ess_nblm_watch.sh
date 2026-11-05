#!/bin/bash
# ESS NBLM恢复哨: 30分钟探活+恢复即pack+chapters全跑
export PYTHONIOENCODING=utf8
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/ess
while true; do
  CODE=$(curl -s -m 12 -x http://127.0.0.1:7892 -o /dev/null -w "%{http_code}" "https://notebooklm.google.com" 2>/dev/null)
  echo "[$(date +%H:%M)] NBLM=$CODE" >> nblm_watch.log
  if [ "$CODE" = "301" ] || [ "$CODE" = "200" ]; then
    echo "[$(date +%H:%M)] RECOVERED" >> nblm_watch.log
    py -3 -X utf8 ess_nblm_pack.py >> nblm_watch.log 2>&1
    py -3 -X utf8 ess_nblm_run.py --phase all > nblm_chapters.log 2>&1
    break
  fi
  sleep 1800
done
