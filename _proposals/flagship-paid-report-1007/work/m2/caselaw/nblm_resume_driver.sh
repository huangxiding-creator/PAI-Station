#!/bin/bash
# nblm_resume_driver - caselaw 第12份 NBLM 产线自动复航驱动 (1031)
# 铁律: 通道锁定不轮换; chat 账户级节流时周期探针 (30min), 通了自动接产
#   --phase all (框架+12章+三武器). 只新增不删除; 探针每轮 1 ask.
PY="C:/Users/91216/AppData/Local/Programs/Python/Python313F/python.exe"
CD="E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/caselaw"
cd "$CD" || exit 9
for cycle in $(seq 1 20); do
  echo "=== cycle $cycle $(date '+%F %T') ===" >> sched/nblm_resume_driver.log
  if "$PY" -X utf8 nblm_probe.py >> sched/nblm_resume_driver.log 2>&1; then
    echo "[driver] $(date '+%F %T') chat 通道恢复 — 接产 --phase all" >> sched/nblm_resume_driver.log
    "$PY" -X utf8 caselaw_nblm_run.py --phase all >> sched/nblm_mega_run.log 2>&1
    rc=$?
    echo "[driver] $(date '+%F %T') --phase all 退出 rc=$rc" >> sched/nblm_resume_driver.log
    exit $rc
  fi
  sleep 1800
done
echo "[driver] $(date '+%F %T') 20轮(约10h)探针仍拒 — 停车如实报告" >> sched/nblm_resume_driver.log
exit 1
