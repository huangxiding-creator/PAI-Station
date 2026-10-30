#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""PAN-HUNTER CLI（W2 · ph.py）

用法：
  ph.py search <关键词> [--json] [--source 源名,...]   聚合搜索 → 发现/交付两栏（W2）
  ph.py download <分享链> [--out 目录]                 绿盘：盘型路由 adapter → 直链 → 落盘
  ph.py discover <分享链> [--pwd 提取码]               五盘发现层（大四盘+139）：列表+探活，不下载
  ph.py gates                                          十盘真件门状态（analysis/W1_GREEN_GATES.md 台账）
  ph.py doctor [--sources]                             源健康 + 盘矩阵 + 插件态（默认全关）
铁律：零登录零凭据（BDCLND 等分享面派生令牌除外）；单源间隔≥2s；发现层总预算≤150 发；下载仅通道测试。
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
from searchagg import LIVE_SOURCES, search_all, SearchLedger   # noqa: E402
from discovery import discover_url, DISK_TIER                  # noqa: E402


def cmd_search(args):
    sources = args.source.split(",") if args.source else None
    t0 = time.time()
    # W4：发数+命中 URL 永续归档（数字零造假；judge#1 精神落到 CLI 面）
    led = SearchLedger(jsonl_path=str(ROOT / "analysis" / "search_ledger.jsonl"),
                       hits_path=str(ROOT / "analysis" / "search_hits.jsonl"))
    hits = search_all(args.kw, sources=sources, ledger=led)
    hits.sort(key=lambda h: (h.light != "绿", h.disk))
    deliver = [h for h in hits if h.light == "绿"]
    if args.json:
        print(json.dumps([dict(url=h.url, disk=h.disk, light=h.light, source=h.source,
                               deliverable=(h.light == "绿"))
                          for h in hits], ensure_ascii=False, indent=1))
        return 0
    # ---- 交付层（绿盘免登直下）----
    print(f"关键词「{args.kw}」命中 {len(hits)}（去重后，{round(time.time()-t0)}s）")
    print(f"\n【交付层·绿盘可直下】{len(deliver)} 条")
    for h in deliver:
        print(f"  ✓[{h.disk:9s}] {h.url[:100]}  ({h.source})")
    # ---- 发现层（全部链接：含黄盘列表/探活可用，交付需凭据插件）----
    print(f"\n【发现层·全部命中】{len(hits)} 条（黄盘=可发现可列表，交付走本地凭据插件，默认关）")
    cur = None
    for h in hits:
        tag = f"{h.light}·{h.disk}"
        if tag != cur:
            print(f"— {tag} —")
            cur = tag
        mark = "✓" if h.light == "绿" else " "
        print(f" {mark}[{h.source:14s}] {h.url[:100]}")
    return 0


def cmd_discover(args):
    disk = None
    try:
        from discovery import discovery_of_url
        disk = discovery_of_url(args.url)
    except Exception:
        pass
    if not disk:
        print(f"非五盘发现层链接（baidu/aliyun/quark/xunlei/139）：{args.url[:80]}")
        return 2
    print(f"[发现层] {disk}（{DISK_TIER.get(disk, '?')}）解析：{args.url[:90]}")
    try:
        r = discover_url(args.url, pwd=args.pwd)
    except Exception as e:
        print(f"异常：{type(e).__name__} {str(e)[:100]}")
        return 1
    print(f"  状态={r.state}  存活={r.alive}  发数={r.shots}")
    if r.title:
        print(f"  分享名：{r.title[:60]}")
    if r.message:
        print(f"  上游：{r.message[:100]}")
    print(f"  文件数：{len(r.entries)}（上游口径 file_count={r.file_count}）")
    for e in r.entries[:30]:
        mark = "DIR " if e.is_dir else f"{e.size/1048576:9.2f}M"
        print(f"    {mark} {e.name[:70]}")
    if len(r.entries) > 30:
        print(f"    ...（余 {len(r.entries)-30} 项省略）")
    print("  （发现层只列清单+探活，不下载；交付=绿盘 download / 黄盘本地凭据插件[默认关]）")
    return 0 if r.ok else 1


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
    # W4 法务落件：下载成功行落审计位（法务原则#4 商用防火墙——收割物仅内部调研语料）
    audit = ROOT / "analysis" / "download_audit.jsonl"
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "url": args.url, "disk": disk,
           "file": safe, "bytes": n, "sha1": sha, "purpose": "research", "out": str(out)}
    with open(audit, "a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
    print(f"审计行：analysis/{audit.name}（purpose=research）")
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
    # 发现层（W2）
    print("\n发现层（五盘·免登列表+探活，零 Cookie）：")
    from discovery import DISCOVERY, DISK_TIER
    for name, d in DISCOVERY.items():
        print(f"  {name:10s} {DISK_TIER.get(name, '?')}  domains={','.join(d.domains[:2])}")
    # 插件态（W2 · 默认全关，零凭据加载）
    print("\n本地凭据插件（法务原则#3：凭据零托管，默认关；此处只显态不执行）：")
    try:
        from plugins import plugin_states
        for st in plugin_states():
            en = "ON " if st["enabled"] else "off"
            cred = "凭据在位" if st["cred_present"] else "凭据缺位"
            print(f"  [{en}] {st['plugin']:12s} 盘={st['tier']:6s} {cred}  {st['note'][:60]}")
    except Exception as e:
        print(f"  插件态读取异常：{type(e).__name__} {str(e)[:60]}")
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
    s3 = sub.add_parser("discover")
    s3.add_argument("url")
    s3.add_argument("--pwd", default="")
    sub.add_parser("gates")
    s4 = sub.add_parser("doctor")
    s4.add_argument("--sources", action="store_true")
    args = ap.parse_args()
    return {"search": cmd_search, "download": cmd_download, "discover": cmd_discover,
            "gates": cmd_gates, "doctor": cmd_doctor}[args.cmd](args)


if __name__ == "__main__":
    sys.exit(main() or 0)
