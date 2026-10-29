#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
bili_subtitle_api.py — B站 CC/AI 字幕直拉复刻件(逆向实证 2026-10-24)
================================================================
链路(全 HTTP, 无浏览器):
  1. GET api.bilibili.com/x/player/pagelist?bvid=...          → cid (免登录)
  2. GET api.bilibili.com/x/player/v2?bvid=..&cid=..          → data.subtitle.subtitles[]
     实测: 匿名(含 finger/spi 引导的 buvid3/4) subtitles=0;
           带 SESSDATA → subtitles>0 (261024 实证 BV1qP4y1T7sd)
  3. GET subtitle_url (aisubtitle.hdslb.com / haiwei? ...)     → {body:[{from,to,content}]}
SESSDATA 来源(合法三选一):
  a) env BILI_SESSDATA
  b) E:/AI-Station/data/secrets/bilibili/SESSDATA.txt (gitignored, 永不进仓)
  c) 本件 qr_login 流程产物(web QR 登录 poll 响应 cookie_fields, 见 逆向报告.md)
用法:
  py bili_subtitle_api.py --bvid BV1qP4y1T7sd                 # 列字幕语言/行数
  py bili_subtitle_api.py --bvid BV1qP4y1T7sd --save out.md  # 存纯文本
  py bili_subtitle_api.py --batch <dir> [--out <dir>]        # 扫目录 bili_(BVxx)_ 文件名批量拉
数字纪律: 行数/字数全部实测, 无字幕如实报 0, 不造数。
"""
from __future__ import annotations
import argparse, json, os, re, sys, time, urllib.request
from pathlib import Path

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
SESS_PATH = Path(r"E:\AI-Station\data\secrets\bilibili\SESSDATA.txt")

def sessdata() -> str:
    v = os.environ.get("BILI_SESSDATA", "").strip()
    if v: return v
    if SESS_PATH.is_file(): return SESS_PATH.read_text(encoding="utf-8").strip()
    return ""

def _get(url: str, sess: str = "", referer: str = "https://www.bilibili.com/"):
    h = {"User-Agent": UA, "Referer": referer}
    if sess: h["Cookie"] = "SESSDATA=" + sess
    req = urllib.request.Request(url, headers=h)
    return json.loads(urllib.request.urlopen(req, timeout=15).read().decode("utf-8", "replace"))

def pagelist(bvid: str) -> list:
    d = _get(f"https://api.bilibili.com/x/player/pagelist?bvid={bvid}")
    if d.get("code") != 0:
        raise RuntimeError(f"pagelist {bvid}: code={d.get('code')} {d.get('message')}")
    return d["data"]

def subtitles(bvid: str, cid: int | None = None, sess: str = "") -> list:
    if cid is None:
        cid = pagelist(bvid)[0]["cid"]
    d = _get(f"https://api.bilibili.com/x/player/v2?bvid={bvid}&cid={cid}", sess)
    if d.get("code") != 0:
        raise RuntimeError(f"player/v2 {bvid}: code={d.get('code')} {d.get('message')}")
    return d.get("data", {}).get("subtitle", {}).get("subtitles", []) or []

def fetch_body(sub_url: str, sess: str = "") -> list:
    u = sub_url if sub_url.startswith("http") else "https:" + sub_url
    d = _get(u, sess, referer="https://www.bilibili.com/")
    return d.get("body", []) or []

def to_text(body: list) -> str:
    return "\n".join(x.get("content", "") for x in body)

def pick(subs: list) -> dict:
    for lan in ("zh-CN", "ai-zh", "zh-Hans"):
        for s in subs:
            if s.get("lan") == lan: return s
    return subs[0] if subs else {}

def run_one(bvid: str, sess: str, save: str | None = None) -> dict:
    subs = subtitles(bvid, sess=sess)
    meta = {"bvid": bvid, "sub_count": len(subs),
            "lans": [(s.get("lan"), s.get("lan_doc")) for s in subs]}
    print(f"[{bvid}] subtitles={len(subs)} {meta['lans']}")
    if not subs: return meta
    s = pick(subs); body = fetch_body(s.get("subtitle_url", ""), sess)
    text = to_text(body)
    meta.update(lan=s.get("lan"), lines=len(body), chars=len(text))
    print(f"[{bvid}] picked lan={s.get('lan')} lines={len(body)} chars={len(text)}")
    if save:
        p = Path(save); p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(f"# {bvid} 字幕({s.get('lan')})\n- 行数: {len(body)} | 字数: {len(text)}\n\n{text}\n", encoding="utf-8")
        meta["file"] = str(p)
    return meta

def run_batch(folder: str, out: str | None = None, sess: str = "") -> list:
    src = Path(folder); dst = Path(out) if out else src
    raw_dir = dst / "subs_raw"; raw_dir.mkdir(parents=True, exist_ok=True)
    ledger = []
    for f in sorted(src.glob("bili_*.md")):
        m = re.match(r"bili_(BV[0-9A-Za-z]{10})_", f.name)
        if not m: continue
        bvid = m.group(1)
        try:
            subs = subtitles(bvid, sess=sess)
            if not subs:
                print(f"[{bvid}] subtitles=0 (该视频无可用CC/AI字幕)")
                ledger.append({"bvid": bvid, "sub_count": 0, "lines": 0, "chars": 0, "file": None}); time.sleep(1.2); continue
            s = pick(subs); body = fetch_body(s.get("subtitle_url", ""), sess)
            text = to_text(body); lan = s.get("lan")
            md = dst / f"bili_{bvid}_cc字幕_{lan}.md"
            md.write_text(f"# {bvid} CC字幕({lan})\n- 源: api.bilibili.com/x/player/v2 + SESSDATA | 实测行数: {len(body)} | 字数: {len(text)}\n\n{text}\n", encoding="utf-8")
            (raw_dir / f"{bvid}_{lan}.json").write_text(json.dumps({"bvid": bvid, "lan": lan, "body": body}, ensure_ascii=False), encoding="utf-8")
            print(f"[{bvid}] SAVED lan={lan} lines={len(body)} chars={len(text)} -> {md.name}")
            ledger.append({"bvid": bvid, "sub_count": len(subs), "lan": lan, "lines": len(body), "chars": len(text), "file": str(md)})
            time.sleep(1.2)
        except Exception as e:
            print(f"[{bvid}] FAIL {type(e).__name__}: {str(e)[:120]}")
            ledger.append({"bvid": bvid, "error": str(e)[:200]})
    (dst / "_subs_ledger.json").write_text(json.dumps({"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "items": ledger}, ensure_ascii=False, indent=1), encoding="utf-8")
    return ledger

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--bvid"); ap.add_argument("--save"); ap.add_argument("--batch"); ap.add_argument("--out")
    a = ap.parse_args(); sess = sessdata()
    if not sess:
        print("[warn] 无SESSDATA(匿名): 实测 subtitles=0, 仅能取cid"); 
    if a.bvid: run_one(a.bvid, sess, a.save)
    elif a.batch: run_batch(a.batch, a.out, sess)
    else: ap.print_help()

if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"): sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    main()
