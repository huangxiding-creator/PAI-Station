#!/usr/bin/env bash
# B级数据集波·字节下载收尾 1026 — 5渠道9件样本入盘 (只增/大件只样本/数字全实测)
set -u
ROOT="E:/AI-Station/data/datasets"
SURV="E:/AI-Station/reforge_factory/channels_survey_2026"
LOG="$SURV/_btier_ds_download_1026.log"
MAN="$SURV/_btier_ds_manifest_1026.jsonl"
PROXY="http://127.0.0.1:7890"
TS="$(date '+%F %T')"
mkdir -p "$ROOT/opensanctions" "$ROOT/commoncrawl" "$ROOT/overture" "$ROOT/aiddata" "$ROOT/ofac_sdn"
: > "$LOG"; : > "$MAN"
say(){ printf '%s\n' "$*" | tee -a "$LOG"; }
fetch(){ # url relpath cap channel desc
  local url="$1" out="$ROOT/$2" cap="$3" ch="$4" desc="$5"
  local code eff via="direct" extra="" trunc=0
  code=$(curl -sSL --max-time 150 --connect-timeout 25 --retry 1 $extra -w '%{http_code}|%{url_effective}' -o "$out.dl" "$url" 2>>"$LOG" | tail -c 400)
  eff="${code#*|}"; code="${code%%|*}"
  if [ "$code" != "200" ] && [ "$code" != "206" ]; then
    via="proxy7890"
    code=$(curl -sSL --max-time 150 --connect-timeout 25 --retry 1 -x "$PROXY" -w '%{http_code}|%{url_effective}' -o "$out.dl" "$url" 2>>"$LOG" | tail -c 400)
    eff="${code#*|}"; code="${code%%|*}"
  fi
  if [ "$code" != "200" ] && [ "$code" != "206" ]; then say "FAIL|$ch|$desc|$url|code=$code"; return 1; fi
  local sz dl_sz
  dl_sz=$(wc -c < "$out.dl" | tr -d ' ')
  if [ "$cap" -gt 0 ] && [ "$dl_sz" -gt "$cap" ]; then head -c "$cap" "$out.dl" > "$out"; trunc=1; else cp "$out.dl" "$out"; fi
  rm -f "$out.dl"
  sz=$(wc -c < "$out" | tr -d ' ')
  local md5; md5=$(md5sum "$out" | cut -d' ' -f1)
  printf '{"ts":"%s","channel":"%s","file":"data/datasets/%s","url":"%s","final_url":"%s","bytes":%s,"cap":%s,"truncated":%s,"md5":"%s","http":"%s","via":"%s"}\n' "$TS" "$ch" "$2" "$url" "$eff" "$sz" "$cap" "$trunc" "$md5" "$code" "$via" >> "$MAN"
  say "OK|$ch|$2|bytes=$sz|cap=$cap|trunc=$trunc|md5=$md5|http=$code|via=$via"
}
say "# B级数据集波·下载收尾 start=$TS (5渠道9件, 大件只样本, 数字全实测)"
for ep in "https://data.opensanctions.org/datasets/latest/index.json" "https://index.commoncrawl.org/collinfo.json" "https://overturemaps-us-west-2.s3.amazonaws.com/?list-type=2&max-keys=1" "https://api.github.com/repos/aiddata/gcdf-geospatial-data"; do
  c=$(curl -s -o /dev/null --max-time 60 -w '%{http_code}' "$ep" 2>/dev/null)
  [ "$c" != "200" ] && c=$(curl -s -o /dev/null --max-time 60 -x "$PROXY" -w '%{http_code}' "$ep" 2>/dev/null)
  say "LIT|$ep|$c"
done
fetch "https://data.opensanctions.org/datasets/latest/index.json" "opensanctions/index.json" 0 opensanctions "datasets latest index.json 全量"
FTM="https://data.opensanctions.org/datasets/latest/us_ofac_sdn/default/ftm.json"
grep -q 'us_ofac_sdn/default/ftm.json' "$ROOT/opensanctions/index.json" 2>/dev/null && say "LIT|index.json含us_ofac_sdn/default/ftm.json直链|verified"
fetch "$FTM" "opensanctions/us_ofac_sdn.ftm.json.head64k" 65536 opensanctions "us_ofac_sdn ftm.json 头64KB样本"
fetch "https://index.commoncrawl.org/collinfo.json" "commoncrawl/collinfo.json" 0 commoncrawl "collinfo 全量"
CDX=$(grep -o '"cdx-api": *"[^"]*"' "$ROOT/commoncrawl/collinfo.json" 2>/dev/null | head -1 | sed 's/.*: *"//;s/"$//')
[ -z "$CDX" ] && CDX="https://index.commoncrawl.org/CC-MAIN-2026-43-index"
say "LIT|最新cdx-api=$CDX"
fetch "$CDX?url=example.com&matchType=prefix&limit=5&output=json" "commoncrawl/cdx_sample.example.com.jsonl" 0 commoncrawl "CDX样本 example.com前缀5条"
fetch "https://overturemaps-us-west-2.s3.amazonaws.com/?list-type=2&max-keys=25" "overture/bucket_list.maxkeys25.xml" 0 overture "S3清单XML max-keys=25"
KEY=$(grep -o '<Key>[^<]*</Key>' "$ROOT/overture/bucket_list.maxkeys25.xml" 2>/dev/null | head -1 | sed 's/<Key>//;s|</Key>||')
if [ -n "$KEY" ]; then say "LIT|首Key=${KEY:0:100}"; fetch "https://overturemaps-us-west-2.s3.amazonaws.com/$KEY" "overture/bridgefile.head32k.parquet" 32768 overture "首Key 头32KB样本"; else say "FAIL|overture|Key解析失败"; fi
fetch "https://raw.githubusercontent.com/aiddata/gcdf-geospatial-data/main/latest/version.txt" "aiddata/version.txt" 0 aiddata "gcdf latest version.txt"
say "LIT|version.txt内容=[$(cat "$ROOT/aiddata/version.txt" 2>/dev/null | tr -d '\r\n')]"
fetch "https://raw.githubusercontent.com/aiddata/gcdf-geospatial-data/main/latest/geojsons/100.geojson" "aiddata/100.geojson" 0 aiddata "gcdf 100.geojson 样本"
fetch "https://www.treasury.gov/ofac/downloads/sdn.xml" "ofac_sdn/sdn.xml.head512k" 524288 ofac_sdn "OFAC sdn.xml 头512KB样本(302跳 sanctionslistservice)"
say "# done $(date '+%F %T')"
say "# manifest=$MAN lines=$(wc -l < "$MAN")"
