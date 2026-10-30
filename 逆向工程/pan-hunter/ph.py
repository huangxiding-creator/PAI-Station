#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""PAN-HUNTER CLI 雏形（W1 · ph.py）

用法：
  ph.py search <关键词> [--json] [--source 源名,...]   聚合 9 活源搜索（去重+盘型红绿灯）
  ph.py download <分享链> [--out 目录]                 按盘型路由 adapter → 直链 → 落盘
  ph.py gates                                          十盘真件门状态（analysis/W1_GREEN_GATES.md 台账）
  ph.py doctor --sources                               源健康（live 探针 9 活源 + W0 审计台账摘要）
铁律：零登录零凭据；单源间隔≥2s；下载仅通道测试。
"""
from __future__ import annotations

import argparse
import hashlib
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from adapters import ADAPTERS, disk_of_url, light_of           # noqa: E402
from adapters.base import PanError, extract_pwd as split_pwd   # noqa: E402
from searchagg import LIVE_SOURCES, search_all                 # noqa: E402


def cmd_search(args):
    sources = args.source.split(",") if args.source else None
    t0 = time.time()
    hits = search_all(args.kw, sources=sources)
    hits.sort(key=lambda h: (h.light != "绿", h.disk))
    if args.json:
        print(json.dumps([dict(url=h.url, disk=h.disk, light=h.light, source=h.source)
                          for h in hits], ensure_ascii=False, indent=1))
        return 0
    print(f"关键词「{args.kw}」命中 {len(hits)}（去重后，{round(time.time()-t0)}s）\n")
    cur = None
    for h in hits:
        tag = f"{h.light}·{h.disk}"
        if tag != cur:
            print(f"— {tag} —")
            cur = tag
        print(f"  [{h.source:14s}] {h.url[:100]}")
    return 0


def _download_stream(url: str, out_path: Path, headers: dict, max_bytes: int = 1_500_000_000):
    from curl_cffi import requests as creq
    r = creq.get(url, headers=headers, impersonate="chrome124", stream=True, timeout=60)
    if r.status_code >= 400:
        raise PanError(f"下载 HTTP {r.status_code}")
    total = 0
    sha = hashlib.sha1()
    with open(out_path, "wb") as f:
        for chunk in r.iter_content(1 << 16):
            if not chunk:
                continue
            f.write(chunk)
            sha.update(chunk)
            total += len(chunk)
            if total >= max_bytes:
                break
    return total, sha.hexdigest().upper()


def cmd_download(args):
    disk = disk_of_url(args.url)
    if not disk or disk not in ADAPTERS:
        print(f"盘型未注册（disk={disk}）：{args.url}")
        return 2
    adapter = ADAPTERS[disk]
    base, pwd = split_pwd(args.url)
    print(f"[1/3] 盘型={disk}（{light_of(disk)}） 解析列表 ...")
    entries = adapter.parse(base, pwd)
    for e in entries[:20]:
        mark = "DIR " if e.is_dir else f"{e.size/1048576:7.1f}M"
        print(f"      {mark} {e.name}")
    target = next((e for e in entries if not e.is_dir and e.size >= (args.min_mb << 20)),
                  next((e for e in entries if not e.is_dir), None))
    if not target:
        print("无文件项")
        return 1
    print(f"[2/3] 直链：{target.name} ({target.size} B) ...")
    u = adapter.direct_url(target)
    print(f"      {u[:110]}")
    out_dir = Path(args.out) if args.out else ROOT / "w1_downloads" / disk
    out_dir.mkdir(parents=True, exist_ok=True)
    safe = "".join(c for c in target.name if c not in '\\/:*?"<>|')[:80] or f"{disk}_gate.bin"
    out = out_dir / safe
    print(f"[3/3] 下载 → {out}")
    n, sha = _download_stream(u, out, adapter.download_headers())
    print(f"完成：{n} bytes  sha1={sha}")
    return 0


def cmd_gates(_args):
    p = ROOT / "analysis" / "W1_GREEN_GATES.md"
    if not p.exists():
        print("尚无门台账（analysis/W1_GREEN_GATES.md）")
        return 1
    print(p.read_text(encoding="utf-8"))
    return 0


def cmd_doctor(args):
    print("== PAN-HUNTER doctor ==")
    if args.sources:
        from searchagg import SearchSession, SearchLedger
        led = SearchLedger()
        for s in LIVE_SOURCES:
            t0 = time.time()
            try:
                sess = SearchSession(s, led)
                hits = sess.search("测试")
                print(f"  {s:16s} LIVE  hits={len(hits)}  {round(time.time()-t0,1)}s")
            except Exception as e:
                print(f"  {s:16s} FAIL  {type(e).__name__} {str(e)[:50]}")
        print(f"  （探针 {led.shots} 发；W0 全量审计见 analysis/SOURCE_AUDIT_1030.md）")
    # 盘矩阵
    print("\n盘矩阵（路由注册）：")
    for name, ad in ADAPTERS.items():
        print(f"  {name:10s} {light_of(name)}  domains={','.join(ad.domains[:3])}...")
    return 0


def main():
    ap = argparse.ArgumentParser(prog="ph.py", description="PAN-HUNTER CLI 雏形")
    sub = ap.add_subparsers(dest="cmd", required=True)
    s1 = sub.add_parser("search")
    s1.add_argument("kw")
    s1.add_argument("--json", action="store_true")
    s1.add_argument("--source", default="")
    s2 = sub.add_parser("download")
    s2.add_argument("url")
    s2.add_argument("--out", default="")
    s2.add_argument("--min-mb", type=int, default=10)
    sub.add_parser("gates")
    s4 = sub.add_parser("doctor")
    s4.add_argument("--sources", action="store_true")
    args = ap.parse_args()
    return {"search": cmd_search, "download": cmd_download,
            "gates": cmd_gates, "doctor": cmd_doctor}[args.cmd](args)


if __name__ == "__main__":
    sys.exit(main() or 0)
