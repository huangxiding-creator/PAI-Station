#!/bin/bash
# audit_halfday_sentry — 半日探哨(1112降频): 12h一探车道+真试一发ch7-12, 5日horizon
export NBLM_PROXY=http://127.0.0.1:7895
export NOTEBOOKLM_TRANSPORT=curl_cffi
cd /e/AI-Station/_proposals/flagship-paid-report-1007/work/m2/audit
LOG=nblm_ch2.log
for day in 1 2 3 4 5 6 7 8 9 10; do
  RED=$(curl -s -m 15 -x http://127.0.0.1:7895 -o /dev/null -w "%{redirect_url}" "https://notebook.google.com/" 2>/dev/null)
  echo "[$(date +%m-%d\ %H:%M)] 半日探: ${RED:0:60}" >> "$LOG"
  if [ -n "$RED" ] && ! echo "$RED" | grep -q "unsupported"; then
    echo "[$(date +%m-%d\ %H:%M)] 池清! 单发ch7-12" >> "$LOG"
    py -3 -X utf8 audit_nblm_run.py --phase chapters --chapters 7,8,9,10,11,12 >> "$LOG" 2>&1
    N=$(ls sched/_ch[0-9][0-9]_nblm.md 2>/dev/null | wc -l)
    echo "[$(date +%m-%d\ %H:%M)] 落盘${N}/12" >> "$LOG"
    [ "$N" -ge 12 ] && break
  fi
  sleep 43200
done
echo "[$(date +%m-%d\ %H:%M)] 半日哨收班 $(ls sched/_ch[0-9][0-9]_nblm.md 2>/dev/null | wc -l)/12" >> "$LOG"
