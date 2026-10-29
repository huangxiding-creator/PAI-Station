#!/usr/bin/env bash
# MissionEngine auto-loop v1.0 — auto-company骨架 Windows(Git Bash) 移植（W1.1, 2026-10-23）
# 前台运行: ./auto-loop.sh   优雅停止: ./stop-loop.sh 或 touch .auto-loop-stop
# 宪法改造: 日志只增不删(站规删除铁律)——超MAX_LOGS只告警企微+ledger, 不轮转删除
set -uo pipefail
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"; cd "$SCRIPT_DIR"
CLAUDE_BIN="${CLAUDE_BIN:-$(find "$USERPROFILE/.vscode/extensions" -maxdepth 4 -path "*claude-code-*/resources/native-binary/claude.exe" 2>/dev/null | sort -V | tail -1)}"   # 首选VSCode扩展原生二进制(find解析:ls有-F星号alias+USERPROFILE反斜杠坑)
[ -x "$CLAUDE_BIN" ] || CLAUDE_BIN="$(command -v claude || true)"; [ -n "$CLAUDE_BIN" ] || { echo "FATAL: claude CLI 不可达(扩展二进制与npm壳均无)"; exit 1; }
LOG_DIR=logs; CONSENSUS=consensus.md; PROMPT_FILE=PROMPT.md
PID_FILE=.auto-loop.pid; STATE_FILE=.auto-loop-state; LEDGER=ledger/run-ledger.jsonl
LOOP_INTERVAL="${LOOP_INTERVAL:-60}"; CYCLE_TIMEOUT_SECONDS="${CYCLE_TIMEOUT_SECONDS:-1800}"
MAX_CONSECUTIVE_ERRORS="${MAX_CONSECUTIVE_ERRORS:-5}"; COOLDOWN_SECONDS="${COOLDOWN_SECONDS:-300}"
LIMIT_WAIT_SECONDS="${LIMIT_WAIT_SECONDS:-3600}"; MAX_LOGS="${MAX_LOGS:-200}"
export CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1
mkdir -p "$LOG_DIR"
ts(){ date '+%F %T'; }
log(){ echo "[$(ts)] $1" >> "$LOG_DIR/auto-loop.log"; }
ledger(){ printf '{"ts":"%s","event":"%s","detail":%s}\n' "$(ts)" "$1" "${2:-{\}}" >> "$LEDGER"; }
wecom(){ py -X utf8 "E:/AI-Station/tools/notify_approval_wecom.py" "MissionEngine:$1" "${2:-无详情}" >/dev/null 2>&1 || true; }
# 注: 自产临时控制件(.pid/.stop/.bak/超时旗)随自身生命周期自清; 用户资产永不删(站规)
peak_gate(){ [ -n "${SKIP_PEAK_GATE:-}" ] && return 1; local h dow; h=$(date +%H); dow=$(date +%u); [ "$dow" -le 5 ] && [ "$h" -ge 14 ] && [ "$h" -lt 18 ]; }
run_cycle(){
  local n=$1 rc=0 tmp err cons full
  cons=$(cat "$CONSENSUS" 2>/dev/null || echo "首次循环，无接力棒")
  full="$(cat "$PROMPT_FILE")
---
## Current Consensus (预载，勿重读该文件)
$cons
---
这是第 ${n} 轮。轮末三件套：更新consensus.md传棒+追加ledger事件+到审批闸则企微通知后停轮。高峰期(工作日14-18)外才可重活。"
  tmp="$LOG_DIR/cycle-$(printf '%04d' "$n").json"; err="$LOG_DIR/cycle-$(printf '%04d' "$n").err"
  timeout -k 10 "$CYCLE_TIMEOUT_SECONDS" "$CLAUDE_BIN" -p "$full" --output-format json > "$tmp" 2>"$err" || rc=$?
  if [ $rc -eq 124 ]; then ledger cycle_timeout "{\"cycle\":$n}"; log "#$n 超时被看门狗强杀"; return 124; fi
  if [ $rc -ne 0 ]; then ledger cycle_claude_exit "{\"cycle\":$n,\"exit\":$rc}"; return $rc; fi
  if grep -qiE "usage limit|rate limit|too many requests|resource_exhausted|overloaded|429|额度" "$tmp" "$err" 2>/dev/null; then
    ledger cycle_limit_hit "{\"cycle\":$n}"; return 429
  fi
  log "#$n OK $(sed -n 's/.*\"result\":\"\{0,1\}\([^\"\]*\).*/\1/p' "$tmp" | head -c 160)"
  ledger cycle_ok "{\"cycle\":$n}"; return 0
}
# --- 单实例门 ---
if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then echo "已在运行 PID $(cat "$PID_FILE")，先 ./stop-loop.sh"; exit 1; fi
echo $$ > "$PID_FILE"
trap 'rm -f "$PID_FILE"; ledger loop_stop; log "=== Loop 停止 (PID $$) ==="; exit 0' SIGTERM SIGINT
# W2.2 器官保活:循环点火连带幂等拉起器官(zqg护盾等,单实例锁内建自弃权)
py -X utf8 "$SCRIPT_DIR/organ_start.py" >> "$LOG_DIR/organ-start.log" 2>&1 || true
n=0; errors=0; limit_hits=0
log "=== MissionEngine Loop v1.0 启动 (PID $$) interval=${LOOP_INTERVAL}s timeout=${CYCLE_TIMEOUT_SECONDS}s breaker=${MAX_CONSECUTIVE_ERRORS} ==="
ledger loop_start "{\"pid\":$$}"
while true; do
  if [ -f .auto-loop-stop ]; then rm -f .auto-loop-stop; log "收到停止令，优雅退出"; break; fi
  if peak_gate; then [ $((n % 1)) -eq 0 ] && sleep 300; continue; fi   # 工作日14-18让路(铁律)，每5min自查
  n=$((n+1)); cp "$CONSENSUS" "$CONSENSUS.bak" 2>/dev/null
  run_cycle "$n"; rc=$?
  case $rc in
    0) errors=0; limit_hits=0 ;;
    429) limit_hits=$((limit_hits+1))
         shield="$(py -X utf8 "$SCRIPT_DIR/organ_probe.py" --organ zqg 2>/dev/null | head -1)"; [ -n "$shield" ] || shield='{"probe":"failed"}'
         summary="$(py -X utf8 "$SCRIPT_DIR/organ_probe.py" --organ zqg --summary 2>/dev/null | head -1)"; [ -n "$summary" ] || summary="护盾探针不可达"
         ledger shield_snapshot "$shield"
         log "#$n 限额命中，等${LIMIT_WAIT_SECONDS}s(第${limit_hits}次) 护盾:$summary"
         wecom "限额等待" "cycle#$n 第${limit_hits}次,等${LIMIT_WAIT_SECONDS}s;护盾:$summary"; sleep "$LIMIT_WAIT_SECONDS" ;;
    *) errors=$((errors+1)); cp "$CONSENSUS.bak" "$CONSENSUS" 2>/dev/null
       if [ "$errors" -ge "$MAX_CONSECUTIVE_ERRORS" ]; then
         log "断路器触发(${errors}连错)——停轮待查，consensus已回滚"; ledger breaker "{\"errors\":$errors,\"cycle\":$n}"
         wecom "断路器停轮" "${errors}连错,cycle#$n,consensus已回滚,请查logs"; break
       fi
       log "#$n 失败rc=$rc，冷却${COOLDOWN_SECONDS}s(${errors}/${MAX_CONSECUTIVE_ERRORS})"; sleep "$COOLDOWN_SECONDS" ;;
  esac
  local_logs=$(find "$LOG_DIR" -name 'cycle-*.json' 2>/dev/null | wc -l | tr -d ' ')
  if [ "$local_logs" -gt "$MAX_LOGS" ]; then ledger log_overflow "{\"count\":$local_logs}"; wecom "日志超量" "cycle日志${local_logs}份>${MAX_LOGS},按只增铁律不删,请明示清理"; fi
  printf 'LAST_CYCLE=%s\nERRORS=%s\nSTATUS=%s\n' "$n" "$errors" "idle" > "$STATE_FILE"
  if [ -n "${FIRST_RUN_ONLY:-}" ]; then log "首跑单循环模式完成(FIRST_RUN_ONLY)"; break; fi
  sleep "$LOOP_INTERVAL"
done
printf 'LAST_CYCLE=%s\nERRORS=%s\nSTATUS=stopped\n' "$n" "$errors" > "$STATE_FILE"
ledger loop_end "{\"cycles\":$n}"
