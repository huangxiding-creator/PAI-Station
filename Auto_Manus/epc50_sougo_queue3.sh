#!/bin/bash
# epc50 搜狗微信采集 波3: 8 新词 (饥饿维度定向: 供应商物资(采购26)智能建造焊接(施工25)HSE(风险23)专利(创新21)数字化交付(设计17)市场开发(对标31)), 600s 词间节流
cd /e/AI-Station/Auto_Manus
LOG=epc50_sougo_queue3.log
WORDS=("中石化南京工程 供应商" "中石化南京工程 物资" "中石化南京工程 智能建造" "中石化南京工程 焊接" "中石化南京工程 HSE" "中石化南京工程 专利" "中石化南京工程 数字化交付" "中石化南京工程 市场开发")

log() { echo "[$(date '+%m-%d %H:%M:%S')] $*" >> $LOG; }
log "=== 波3启动: ${#WORDS[@]} 词 ==="

for W in "${WORDS[@]}"; do
  sleep 600   # 词间节流 (账号安全四件套)
  RUN=$(curl -s http://127.0.0.1:3000/api/status | grep -o '"running":[a-z]*' | cut -d: -f2)
  if [ "$RUN" = "true" ]; then log "skip(占用中): $W"; continue; fi
  printf '{"keyword":"%s","pages":2,"delayMin":8,"delayMax":15}' "$W" > /tmp/word_next3.json
  R=$(curl -s -X POST http://127.0.0.1:3000/api/search -H "Content-Type: application/json" --data-binary @/tmp/word_next3.json)
  log "fired: $W -> $(echo $R | head -c 60)"
  while true; do
    sleep 90
    ST=$(curl -s http://127.0.0.1:3000/api/status)
    RUN=$(echo "$ST" | grep -o '"running":[a-z]*' | cut -d: -f2)
    PH=$(echo "$ST" | grep -o '"phase":"[^"]*"' | cut -d'"' -f4)
    MSG=$(echo "$ST" | grep -o '"message":"[^"]*"' | head -1 | cut -c1-80)
    [ "$RUN" != "true" ] && { log "done: $W phase=$PH $MSG"; break; }
    echo "$ST" | grep -q '"phase":"captcha"' && { log "CAPTCHA hit: $W — 退场等主会话"; echo "$W" > epc50_sougo_stuck_word.txt; exit 2; }
  done
done
log "ALL_WORDS_DONE_WAVE2"
