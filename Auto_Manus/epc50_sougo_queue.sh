#!/bin/bash
# epc50 搜狗微信采集续跑队列: 等当前任务完成 → 600s 词间节流 → 发下一词
# 词表: epc50_sougo_words_todo.txt 第2-5词 (第1词"总承包"已由主会话发出)
cd /e/AI-Station/Auto_Manus
LOG=epc50_sougo_queue.log
WORDS=("中石化南京工程 海外项目" "中石化南京工程 安全生产" "中石化南京工程 数字化转型" "中石化南京工程 科技创新")

log() { echo "[$(date '+%m-%d %H:%M:%S')] $*" >> $LOG; }

# 等当前任务跑完 (running=false 且 phase 不在 error/captcha)
while true; do
  ST=$(curl -s http://127.0.0.1:3000/api/status)
  RUN=$(echo "$ST" | grep -o '"running":[a-z]*' | cut -d: -f2)
  PH=$(echo "$ST" | grep -o '"phase":"[^"]*"' | cut -d'"' -f4)
  if [ "$RUN" != "true" ]; then
    log "前置任务结束 phase=$PH"
    break
  fi
  sleep 60
done

for W in "${WORDS[@]}"; do
  sleep 600   # 词间节流
  # 任务若被人工抢先启动则跳过本词 (running=true 时 409)
  RUN=$(curl -s http://127.0.0.1:3000/api/status | grep -o '"running":[a-z]*' | cut -d: -f2)
  if [ "$RUN" = "true" ]; then log "skip(占用中): $W"; continue; fi
  printf '{"keyword":"%s","pages":2,"delayMin":8,"delayMax":15}' "$W" > /tmp/word_next.json
  R=$(curl -s -X POST http://127.0.0.1:3000/api/search -H "Content-Type: application/json" --data-binary @/tmp/word_next.json)
  log "fired: $W -> $(echo $R | head -c 60)"
  # 等本词完成
  while true; do
    sleep 90
    ST=$(curl -s http://127.0.0.1:3000/api/status)
    RUN=$(echo "$ST" | grep -o '"running":[a-z]*' | cut -d: -f2)
    PH=$(echo "$ST" | grep -o '"phase":"[^"]*"' | cut -d'"' -f4)
    MSG=$(echo "$ST" | grep -o '"message":"[^"]*"' | head -1 | cut -c1-80)
    [ "$RUN" != "true" ] && { log "done: $W phase=$PH $MSG"; break; }
    echo "$ST" | grep -q '"phase":"captcha"' && { log "CAPTCHA hit on: $W — 停队等待人工/主会话解码"; echo "$W" > epc50_sougo_stuck_word.txt; exit 2; }
  done
done
log "ALL_WORDS_DONE"
