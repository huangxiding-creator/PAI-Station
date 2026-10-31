#!/bin/bash
# nblm_resume_driver - caselaw 第12份 NBLM 产线自动复航驱动 v2 (1031 续跑攻坚员)
# 铁律: 通道锁定不轮换; chat 账户级节流时周期探针 (30min), 通了自动接产
#   --phase all (框架+12章+三武器). 只新增不删除; 探针每轮 1 ask.
# v2: 完成度循环 — --phase all 幂等, 每轮跑完检查 12 章稿 (CJK≥15000) 是否全绿,
#   未全绿则回到探针循环继续等窗口 (拒绝单发即退: 1029 实测节流窗可长达
#   12-20h, 窗内部分章可能再拒). 探针扩到 48 轮 (约24h).
PY="C:/Users/91216/AppData/Local/Programs/Python/Python313F/python.exe"
CD="E:/AI-Station/_proposals/flagship-paid-report-1007/work/m2/caselaw"
cd "$CD" || exit 9

done_all() {  # 12 章稿全达 CJK 门 = 0
  "$PY" -X utf8 - <<'EOF'
import re, sys
from pathlib import Path
d = Path("sched")
ok = 0
for i in range(1, 13):
    f = d / f"_ch{i:02d}_nblm.md"
    if f.is_file():
        cjk = len(re.findall(r"[一-鿿]", f.read_text(encoding="utf-8", errors="replace")))
        if cjk >= 15000:
            ok += 1
print(f"[driver] 完成度 {ok}/12")
sys.exit(0 if ok == 12 else 1)
EOF
}

for cycle in $(seq 1 48); do
  if done_all; then
    echo "[driver] $(date '+%F %T') 12章全绿 — 收官退出" >> sched/nblm_resume_driver.log
    exit 0
  fi
  echo "=== cycle $cycle $(date '+%F %T') ===" >> sched/nblm_resume_driver.log
  if "$PY" -X utf8 nblm_probe.py >> sched/nblm_resume_driver.log 2>&1; then
    echo "[driver] $(date '+%F %T') chat 通道恢复 — 接产 --phase all" >> sched/nblm_resume_driver.log
    "$PY" -X utf8 caselaw_nblm_run.py --phase all >> sched/nblm_mega_run.log 2>&1
    rc=$?
    echo "[driver] $(date '+%F %T') --phase all 退出 rc=$rc" >> sched/nblm_resume_driver.log
    if done_all; then
      echo "[driver] $(date '+%F %T') 12章全绿 — 收官退出" >> sched/nblm_resume_driver.log
      exit 0
    fi
    echo "[driver] $(date '+%F %T') 未全绿 — 回探针循环等下一窗口" >> sched/nblm_resume_driver.log
  fi
  sleep 1800
done
echo "[driver] $(date '+%F %T') 48轮(约24h)探针仍拒/未全绿 — 停车如实报告" >> sched/nblm_resume_driver.log
exit 1
