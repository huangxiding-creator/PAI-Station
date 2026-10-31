#!/bin/bash
# nblm_sweep_driver - caselaw 第12份收尾清扫 (1101): 探针门控 + --phase chapters
# 幂等: 已达门章自动 skip; ch07 重产; ch08-12 补产. 32轮×30min=16h 覆盖 PT 重置窗.
PY="C:/Users/91216/AppData/Local/Programs/Python/Python313F/python.exe"
CD="E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/caselaw"
cd "$CD" || exit 9
for cycle in $(seq 1 32); do
  echo "=== sweep cycle $cycle $(date '+%F %T') ===" >> sched/nblm_sweep_driver.log
  if "$PY" -X utf8 nblm_probe.py >> sched/nblm_sweep_driver.log 2>&1; then
    echo "[sweep] $(date '+%F %T') chat 通 — 跑 --phase chapters (skip已达标章)" >> sched/nblm_sweep_driver.log
    "$PY" -X utf8 caselaw_nblm_run.py --phase chapters >> sched/nblm_mega_run2.log 2>&1
    rc=$?
    echo "[sweep] $(date '+%F %T') chapters 退出 rc=$rc" >> sched/nblm_sweep_driver.log
    # 全达标则收工
    n_ok=$("$PY" -X utf8 - <<'EOF'
import json,re,sys
from pathlib import Path
S=Path(r'E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/caselaw/sched')
n=0
for i in range(1,13):
    p=S/f'_ch{i:02d}_nblm.md'
    if p.is_file() and len(re.findall(r'[一-鿿]',p.read_text(encoding='utf-8',errors='replace')))>=15000:
        n+=1
print(n)
EOF
)
    echo "[sweep] 达标章数: $n_ok/12" >> sched/nblm_sweep_driver.log
    if [ "$n_ok" = "12" ]; then
      echo "[sweep] $(date '+%F %T') 12/12 全达标 — 收工" >> sched/nblm_sweep_driver.log
      exit 0
    fi
  fi
  sleep 1800
done
echo "[sweep] $(date '+%F %T') 32轮(16h)仍有缺章 — 停车如实报告" >> sched/nblm_sweep_driver.log
exit 1
