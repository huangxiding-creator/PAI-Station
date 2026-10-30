#!/usr/bin/env bash
# B级数据集波·补漏重试 1026 — 3失败件修复 (ftm路径解析/空格URL编码/-w解析修复)
set -u
ROOT="E:/AI-Station/data/datasets"
SURV="E:/AI-Station/reforge_factory/channels_survey_2026"
LOG="$SURV/_btier_ds_retry_1026.log"
MAN="$SURV/_btier_ds_manifest_1026.jsonl"
PROXY="http://127.0.0.1:7890"
TS="$(date '+%F %T')"
say(){ printf '%s\n' "$*" | tee -a "$LOG"; }
record(){ # channel file url eff bytes cap trunc md5 http via
  printf '{"ts":"%s","channel":"%s","file":"data/datasets/%s","url":"%s","final_url":"%s","bytes":%s,"cap":%s,"truncated":%s,"md5":"%s","http":"%s","via":"%s"}\n' "$TS" "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "${10}" >> "$MAN"
}
fetch2(){ # url out cap ch desc
  local url="$1" out="$2" cap="$3" ch="$4" desc="$5"
  local w code eff via="direct" trunc=0
  w=$(curl -sSL --max-time 150 --connect-timeout 25 --retry 1 -w '|W|%{http_code}|W|%{url_effective}' -o "$out.dl" "$url" 2>>"$LOG")
  code=$(printf '%s' "$w" | awk -F'|W|' '{print $2}')
  if [ "$code" != "200" ] && [ "$code" != "206" ]; then
    via="proxy7890"
    w=$(curl -sSL --max-time 150 --connect-timeout 25 --retry 1 -x "$PROXY" -w '|W|%{http_code}|W|%{url_effective}' -o "$out.dl" "$url" 2>>"$LOG")
    code=$(printf '%s' "$w" | awk -F'|W|' '{print $2}')
  fi
  eff=$(printf '%s' "$w" | awk -F'|W|' '{print $3}')
  if [ "$code" != "200" ] && [ "$code" != "206" ]; then say "FAIL|$ch|$desc|code=$code"; return 1; fi
  local sz dl_sz
  dl_sz=$(wc -c < "$out.dl" | tr -d ' ')
  if [ "$cap" -gt 0 ] && [ "$dl_sz" -gt "$cap" ]; then head -c "$cap" "$out.dl" > "$out"; trunc=1; else cp "$out.dl" "$out"; fi
  rm -f "$out.dl"
  sz=$(wc -c < "$out" | tr -d ' ')
  local md5; md5=$(md5sum "$out" | cut -d' ' -f1)
  record "$ch" "${out#$ROOT/}" "$url" "$eff" "$sz" "$cap" "$trunc" "$md5" "$code" "$via"
  say "OK|$ch|${out#$ROOT/}|bytes=$sz|cap=$cap|trunc=$trunc|md5=$md5|http=$code|via=$via"
}
say "# retry start=$TS"
# (1) 解析 index.json 里 us_ofac_sdn 的真实资源URL
FTM=$(py -I -c "import json,sys; d=json.load(open(r'E:/AI-Station/data/datasets/opensanctions/index.json',encoding='utf-8',errors='replace')); ds=[x for x in d.get('datasets',[]) if x.get('name')=='us_ofac_sdn']; rs=ds[0].get('resources',[]) if ds else []; print('\n'.join((r.get('url') or '') for r in rs if 'ftm.json' in (r.get('url') or '')+(r.get('path') or '')))" 2>>"$LOG" | head -1)
if [ -n "$FTM" ]; then
  say "LIT|us_ofac_sdn ftm直链=$FTM"
  fetch2 "$FTM" "$ROOT/opensanctions/us_ofac_sdn.ftm.json.head64k" 65536 opensanctions "us_ofac_sdn ftm.json 头64KB样本"
else
  say "FAIL|opensanctions|index.json解析未得ftm直链"
fi
# (2) Overture 首Key (空格→%20)
KEY=$(grep -o '<Key>[^<]*</Key>' "$ROOT/overture/bucket_list.maxkeys25.xml" 2>/dev/null | head -1 | sed 's/<Key>//;s|</Key>||')
if [ -n "$KEY" ]; then
  KEYENC=$(printf '%s' "$KEY" | sed 's/ /%20/g')
  fetch2 "https://overturemaps-us-west-2.s3.amazonaws.com/$KEYENC" "$ROOT/overture/bridgefile.head32k.parquet" 32768 overture "首Key(空格已编码) 头32KB样本"
else
  say "FAIL|overture|Key解析失败"
fi
# (3) OFAC sdn.xml (Range + 修复解析)
fetch2 "https://www.treasury.gov/ofac/downloads/sdn.xml" "$ROOT/ofac_sdn/sdn.xml.head512k" 524288 ofac_sdn "OFAC sdn.xml 头512KB样本(302→sanctionslistservice→S3预签名)"
# 旧失败残留 .dl 如存在则并入清理 (自建临时件)
for f in "$ROOT/ofac_sdn/sdn.xml.head512k.dl" "$ROOT/opensanctions/us_ofac_sdn.ftm.json.head64k.dl" "$ROOT/overture/bridgefile.head32k.parquet.dl"; do
  [ -f "$f" ] && { say "CLEAN|残留临时件 $(wc -c < "$f" | tr -d ' ')字节 $f"; rm -f "$f"; }
done
say "# retry done $(date '+%F %T')"
say "# manifest lines=$(wc -l < "$MAN")"
