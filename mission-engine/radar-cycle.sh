#!/usr/bin/env bash
cd /e/AI-Station/mission-engine
export PATH="/usr/bin:/bin:$LOCALAPPDATA/Programs/Python/Python313F:$SYSTEMROOT/System32:$PATH"
CB=$(find "$USERPROFILE/.vscode/extensions" -maxdepth 4 -path "*claude-code-*/resources/native-binary/claude.exe" 2>/dev/null | sort -V | tail -1)
echo "[radar] $(date +%F_%T) JTBD radar cycle start"
# quota_precheck: 空额度窗直接静默跳过,不烧失败循环
REMAIN=$(py -X utf8 organ_probe.py 2>/dev/null | py -X utf8 -c "import json,sys;d=json.load(sys.stdin);print(d.get('ledger',{}).get('poll',{}).get('remaining',100))" 2>/dev/null || echo 100)
if [ "$(echo "$REMAIN < 8" | bc 2>/dev/null || echo 0)" = "1" ]; then echo "[radar] quota_precheck skip (remaining=${REMAIN}%)"; exit 0; fi
timeout 900 "$CB" -p "RadarCycle轻量轮: 1)py signals_pull.py拉双源 2)wechat-24h-ops/data/topic-signals/最新mtime陈旧>24h则跑../wechat-24h-ops/soak/night_shift.py刷源后重拉 3)全量分析:以ledger/signals.jsonl全史信号为底,近3小时窗口权重加倍(最新需求方向主导,历史模式不丢),JTBD锻造四步,只认三族(研报/解决方案/在线部署工具),知识库类禁推 4)合格提案六件套→py approval_gate.py request推送 5)动作全落ledger;无提案记no_proposal。守CLAUDE.md红线" --dangerously-skip-permissions --output-format json > logs/radar-last.json 2> logs/radar-last.err
echo "[radar] rc=$? $(date +%F_%T)"
