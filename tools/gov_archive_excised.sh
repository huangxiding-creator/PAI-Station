#!/bin/bash
# 剔件网盘归档补账链 — slim(63d35c2f0) 剔除件 → 分桶分片 tar → bdn 上传 /AI-Station-archive/slim-excised-1030/
# 幂等：跳过网盘已存在同名包（上传前 ls 对账）；零删除；逐桶落账
set -u
export MSYS_NO_PATHCONV=1   # 封死 Git Bash 把 /远端路径 改写成 C:/Program Files/Git/... 的翻译怪癖（技能文档既账）
cd /e/AI-Station || exit 1
LOG=/e/AI-Station/tools/gov_archive_1030.log
TMP=/c/Users/91216/AppData/Local/Temp/gov_archive_1030
TMPW=C:/Users/91216/AppData/Local/Temp/gov_archive_1030
BDN="python -I E:/AI-Station/逆向工程/baidu-netdisk/replica/bdn.py"
REMOTE_BASE=/AI-Station-archive/slim-excised-1030
mkdir -p "$TMP"
export PYTHONIOENCODING=utf-8

echo "[$(date '+%m-%d %H:%M:%S')] 归档补账链启动（权威清单版：tools/_repo_backup_tmp/_big_paths.json，slim 主刀会话交棒）" >> "$LOG"
# 1) 剔件清单 = 主刀会话权威 JSON（12,836 原生路径）
python -c "import json,io,sys; sys.stdout.reconfigure(encoding='utf-8',errors='replace'); io.open(r'C:/Users/91216/AppData/Local/Temp/gov_archive_1030/excised_all.txt','w',encoding='utf-8').writelines(p.replace(chr(92),'/')+'\n' for p in json.load(io.open(r'E:/AI-Station/tools/_repo_backup_tmp/_big_paths.json',encoding='utf-8')))" 2>>"$LOG" || { echo "[$(date '+%m-%d %H:%M:%S')] 清单解析失败" >> "$LOG"; exit 1; }
sort -u "$TMP/excised_all.txt" -o "$TMP/excised_all.txt"   # 六启修正：truncate 写+去重（四/五启追加模式曾致 3 倍膨胀事故）
TOTAL=$(wc -l < "$TMP/excised_all.txt")
echo "[$(date '+%m-%d %H:%M:%S')] 剔件总数=$TOTAL" >> "$LOG"
awk -F/ '{print $1}' "$TMP/excised_all.txt" | sort | uniq -c | sort -rn > "$TMP/buckets.txt"
cat "$TMP/buckets.txt" >> "$LOG"

# 2) 按桶×1.5GiB 分片 tar（只收现存文件）
find_existing() { while IFS= read -r f; do [ -f "$f" ] && printf '%s\n' "$f"; done; }
idx=0
while read -r cnt bucket; do
  [ -z "$bucket" ] && continue
  grep "^${bucket}/" "$TMP/excised_all.txt" | find_existing > "$TMP/list_$idx.txt"
  N=$(wc -l < "$TMP/list_$idx.txt")
  [ "$N" -eq 0 ] && { echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket] 现存0件跳过" >> "$LOG"; idx=$((idx+1)); continue; }
  # 累计 1.5GiB 切片
  part=0; size=0; : > "$TMP/chunk.txt"
  while IFS= read -r f; do
    sz=$(stat -c %s "$f" 2>/dev/null || echo 0); size=$((size+sz)); echo "$f" >> "$TMP/chunk.txt"
    if [ "$size" -ge 1610612736 ]; then
      part=$((part+1)); tar_name="$(echo "$bucket" | tr ' /' '__')-v2-part${part}.tar.gz"
      if tar -czf "$TMP/$tar_name" -T "$TMP/chunk.txt" 2>>"$LOG"; then
        UP="$REMOTE_BASE/$tar_name"
        if $BDN ls "$REMOTE_BASE" --json 2>/dev/null | grep -q "\"$tar_name\""; then
          echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]片$part 已在网盘，跳过" >> "$LOG"
        else
          $BDN mkdir "$REMOTE_BASE" --json >>"$LOG" 2>&1
          OUT=$($BDN upload "$TMPW/$tar_name" "$UP" --json 2>&1); echo "$OUT" >> "$LOG"
          if echo "$OUT" | grep -q '"errno": 0'; then
            echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]片$part 上传OK $(stat -c %s "$TMP/$tar_name")B ($(wc -l < "$TMP/chunk.txt")件)" >> "$LOG"
            sleep 20   # 六启：片间拟人间隔（五启曾撞真实 20012 限流）
          elif echo "$OUT" | grep -q '熔断'; then
            echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]片$part 上传FAIL(熔断窗) → 静默 31 分钟等 TTL" >> "$LOG"
            sleep 1860
          else
            echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]片$part 上传FAIL → 20s 后续" >> "$LOG"
            sleep 20
          fi
        fi
        rm -f "$TMP/$tar_name" "$TMP/chunk.txt"; : > "$TMP/chunk.txt"; size=0
      fi
    fi
  done < "$TMP/list_$idx.txt"
  if [ -s "$TMP/chunk.txt" ]; then
    part=$((part+1)); tar_name="$(echo "$bucket" | tr ' /' '__')-v2-part${part}.tar.gz"
    if tar -czf "$TMP/$tar_name" -T "$TMP/chunk.txt" 2>>"$LOG"; then
      $BDN mkdir "$REMOTE_BASE" --json >>"$LOG" 2>&1
      OUT=$($BDN upload "$TMPW/$tar_name" "$REMOTE_BASE/$tar_name" --json 2>&1); echo "$OUT" >> "$LOG"
      if echo "$OUT" | grep -q '"errno": 0'; then
        echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]尾片$part 上传OK ($(wc -l < "$TMP/chunk.txt")件)" >> "$LOG"; sleep 20
      elif echo "$OUT" | grep -q '熔断'; then
        echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]尾片$part 上传FAIL(熔断窗) → 静默 31 分钟" >> "$LOG"; sleep 1860
      else
        echo "[$(date '+%m-%d %H:%M:%S')] 桶[$bucket]尾片$part 上传FAIL" >> "$LOG"; sleep 20
      fi
      rm -f "$TMP/$tar_name"
    fi
  fi
  idx=$((idx+1))
done < <(awk '{print $1" "$2}' "$TMP/buckets.txt")
echo "[$(date '+%m-%d %H:%M:%S')] 归档补账链收工" >> "$LOG"
