#!/usr/bin/env bash
# B级数据集波·重试3 — tab分隔-w解析修复 + 服务端Range (awk -F'|W|' 正则坑修复)
set -u
ROOT="E:/AI-Station/data/datasets"
SURV="E:/AI-Station/reforge_factory/channels_survey_2026"
LOG="$SURV/_btier_ds_retry3_1026.log"
MAN="$SURV/_btier_ds_manifest_1026.jsonl"
PROXY="http://127.0.0.1:7890"
TS="$(date '+%F %T')"
say(){ printf '%s\n' "$*" | tee -a "$LOG"; }
fetch3(){ # url out cap ch desc  (cap>0 => 服务端Range优先+本地截断兜底)
  local url="$1" out="$2" cap="$3" ch="$4" desc="$5"
  local rng=() w code eff via="direct" trunc=0
  [ "$cap" -gt 0 ] && rng=(-r "0-$((cap-1))")
  w=$(curl -sSL --max-time 150 --connect-timeout 25 --retry 1 "${rng[@]}" -w '\n%{http_code}\t%{url_effective}' -o "$out.dl" "$url" 2>>"$LOG")
  code=$(printf '%s' "$w" | tail -n 1 | cut -f1)
  if [ "$code" != "200" ] && [ "$code" != "206" ]; then
    via="proxy7890"
    w=$(curl -sSL --max-time 150 --connect-timeout 25 --retry 1 -x "$PROXY" "${rng[@]}" -w '\n%{http_code}\t%{url_effective}' -o "$out.dl" "$url" 2>>"$LOG")
    code=$(printf '%s' "$w" | tail -n 1 | cut -f1)
  fi
  eff=$(printf '%s' "$w" | tail -n 1 | cut -f2)
  if [ "$code" != "200" ] && [ "$code" != "206" ]; then say "FAIL|$ch|$desc|code=$code"; rm -f "$out.dl"; return 1; fi
  local sz dl_sz
  dl_sz=$(wc -c < "$out.dl" | tr -d ' ')
  if [ "$cap" -gt 0 ] && [ "$dl_sz" -gt "$cap" ]; then head -c "$cap" "$out.dl" > "$out"; trunc=1; else cp "$out.dl" "$out"; fi
  rm -f "$out.dl"
  sz=$(wc -c < "$out" | tr -d ' ')
  local md5; md5=$(md5sum "$out" | cut -d' ' -f1)
  printf '{"ts":"%s","channel":"%s","file":"data/datasets/%s","url":"%s","final_url":"%s","bytes":%s,"cap":%s,"truncated":%s,"md5":"%s","http":"%s","via":"%s"}\n' \
    "$TS" "$ch" "${out#$ROOT/}" "$url" "$eff" "$sz" "$cap" "$trunc" "$md5" "$code" "$via" >> "$MAN"
  say "OK|$ch|${out#$ROOT/}|bytes=$sz|cap=$cap|trunc=$trunc|md5=$md5|http=$code|via=$via"
}
say "# retry3 start=$TS"
FTM=$(py -I -c "import json; d=json.load(open(r'E:/AI-Station/data/datasets/opensanctions/index.json',encoding='utf-8',errors='replace')); ds=[x for x in d.get('datasets',[]) if x.get('name')=='us_ofac_sdn']; rs=ds[0].get('resources',[]) if ds else []; print(next((r.get('url') for r in rs if 'ftm.json' in (r.get('url') or '')),''))" 2>>"$LOG")
[ -n "$FTM" ] && fetch3 "$FTM" "$ROOT/opensanctions/us_ofac_sdn.ftm.json.head64k" 65536 opensanctions "us_ofac_sdn entities.ftm.json 头64KB样本" || say "FAIL|opensanctions|FTM解析空"
KEY=$(grep -o '<Key>[^<]*</Key>' "$ROOT/overture/bucket_list.maxkeys25.xml" 2>/dev/null | head -1 | sed 's/<Key>//;s|</Key>||')
KEYENC=$(printf '%s' "$KEY" | sed 's/ /%20/g')
[ -n "$KEYENC" ] && fetch3 "https://overturemaps-us-west-2.s3.amazonaws.com/$KEYENC" "$ROOT/overture/bridgefile.head32k.parquet" 32768 overture "首Key(%20编码) 头32KB样本"
fetch3 "https://www.treasury.gov/ofac/downloads/sdn.xml" "$ROOT/ofac_sdn/sdn.xml.head512k" 524288 ofac_sdn "OFAC sdn.xml 头512KB样本(302→S3预签名, Range)"
say "# retry3 done $(date '+%F %T') manifest_lines=$(wc -l < "$MAN")"
