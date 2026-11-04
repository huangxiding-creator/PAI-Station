#!/bin/bash
export PYTHONIOENCODING=utf-8
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/lumpsum
while true; do
  CODE=$(curl -s -m 12 -x http://127.0.0.1:7892 -o /dev/null -w "%{http_code}" "https://notebooklm.google.com" 2>/dev/null)
  echo "[$(date +%H:%M)] NBLM=$CODE" >> rpc_probe_loop.log
  if [ "$CODE" = "301" ] || [ "$CODE" = "200" ]; then
    echo "[$(date +%H:%M)] RECOVERED — 重跑ch02" >> rpc_probe_loop.log
    py -3 -X utf8 lumpsum_nblm_run.py --phase chapters --chapters 2 > nblm_ch02_regen2.log 2>&1
    break
  fi
  sleep 1800
done
