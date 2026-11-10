#!/bin/bash
# audit_night_shift — 24/7无人值守夜班跑 (1109用户令: 批准外全自动)
# 职责: ①AUDIT S1轮磨到三门/S1.5旗(到人工闸即停+wecom请批) ②ESS两稿锁窗发布 ③全程落账
export PYTHONIOENCODING=utf8
cd /e/AI-Station
LOG=report_platform/promo/audit_night.log
S15FLAG=_proposals/flagship-paid-report-1007/work/m2/audit_s15_ready.flag
echo "[$(date +%m-%d\ %H:%M)] 夜班上岗" >> "$LOG"

# --- 职责②: ESS两稿锁窗发布(一次性) ---
ESS_DONE=0
try_ess() {
  [ "$ESS_DONE" = "1" ] && return
  if [ ! -f "/f/We-AIPO/autopub/data/run.lock" ]; then
    echo "[$(date +%m-%d\ %H:%M)] 锁空 — 发ESS两稿" >> "$LOG"
    cd /e/AI-Station/report_platform/promo
    WECHAT_ACCOUNTS_FILE=F:/We-AIPO/data/wechat_accounts.json py -X utf8 publish_sitting_drafts.py \
      --profile acct01 --nickname 总包说 --match 储能技术选型 --go >> "$LOG" 2>&1
    WECHAT_ACCOUNTS_FILE=F:/We-AIPO/data/wechat_accounts.json py -X utf8 publish_sitting_drafts.py \
      --profile acct05 --nickname 工程行业大脑 --match 114号文 --go >> "$LOG" 2>&1
    ESS_DONE=1
    cd /e/AI-Station
  fi
}

# --- 职责①: AUDIT S1 磨门 (max 40轮×10分钟) ---
for i in $(seq 1 40); do
  [ -f "$S15FLAG" ] && break
  try_ess
  echo "[$(date +%m-%d\ %H:%M)] S1轮$i: judge→backfill→spread→gap→gates" >> "$LOG"
  py -X utf8 reforge_factory/ammo_pool.py judge EPC-AUDIT --limit 2000 >> "$LOG" 2>&1
  py -X utf8 reforge_factory/tree_backfill.py --campaign EPC-AUDIT >> "$LOG" 2>&1
  py -X utf8 reforge_factory/tree_spread.py --campaign EPC-AUDIT >> "$LOG" 2>&1
  py -X utf8 reforge_factory/harvest_gap.py --campaign EPC-AUDIT >> "$LOG" 2>&1
  py -X utf8 reforge_factory/tier_fulltext_reledger.py EPC-AUDIT >> "$LOG" 2>&1
  G=$(py -X utf8 reforge_factory/report_gate_check.py --campaign EPC-AUDIT 2>&1 | tail -2)
  echo "$G" >> "$LOG"
  if ! echo "$G" | grep -q "阻塞"; then
    echo "$(date +%F\ %H:%M)" > "$S15FLAG"
    py -X utf8 tools/notify_approval_wecom.py "第15份AUDIT-2026 S1三门全绿" "S1.5人工闸就绪——请批准进入撰写链(S2三件套→NBLM全速→收编→成书→发布, 预计24h内落地)。回复'批准撰写'即开" >> "$LOG" 2>&1
    echo "[$(date +%m-%d\ %H:%M)] S1.5旗已立+wecom已请批" >> "$LOG"
    break
  fi
  sleep 600
done
echo "[$(date +%m-%d\ %H:%M)] 夜班收班 (S1.5旗=$([ -f "$S15FLAG" ] && echo 立 || echo 未立))" >> "$LOG"
