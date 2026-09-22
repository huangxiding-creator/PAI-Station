# -*- coding: utf-8 -*-
"""弹药池 (Ammo Foundry F-2) — 千万字弹药工程核心件, 用户 09-22 批准 R0.

蓝图: reforge_factory/PROPOSAL.md (scorecard 0.791 proceed)
铁律: 单课题调研成果 >=1000万字才准撰写 (ammo_gate); 弹药等价原则
      (渠道资料与军团成果同池同schema同核验, source_engine 只作账本追溯).

池结构 (全站级资产, 本地明文 — Ghost 律):
  E:\AI-Station\ammo_pool\<campaign_id>\
    manifest.jsonl    每条弹药一行 (引用式入池, 不复制文件本体)
    pool_state.json   实时字数账本 (总字数/条目/渠道贡献榜/独立域名数)

用法:
  python ammo_pool.py init <campaign_id>
  python ammo_pool.py ingest <campaign_id> --file <path> --engine own:rss [--url URL] [--cred media]
  python ammo_pool.py stocktake <campaign_id> --dirs <dir> [--dirs <dir2>] [--kw "EPC 水利"]
  python ammo_pool.py status <campaign_id>          # 盘点仪表首屏 (进度条 X/1000万)

R0 验收: 家底字数报告 + schema 冒烟 + 仪表首屏.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import time
from pathlib import Path
from urllib.parse import urlsplit, urlunsplit, parse_qsl

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

STATION = Path(r"E:\AI-Station")
POOL_ROOT = STATION / "ammo_pool"
AMMO_GATE_CHARS = 10_000_000   # 用户铁律: 1000 万字


# ---------- URL 归一化 (跨引擎去重键) ----------
_UTM = re.compile(r"^(utm_|spm|from|share|chksm|scene|srcid)")


def norm_url(url: str) -> str:
    """小写 host + 去 utm 族参数 + 去尾斜杠 — 弹药等价原则的去重基础."""
    try:
        p = urlsplit(url.strip())
        q = "&".join(f"{k}={v}" for k, v in parse_qsl(p.query)
                     if not _UTM.match(k))
        path = p.path.rstrip("/") or "/"
        return urlunsplit((p.scheme.lower(), p.netloc.lower(), path, q, ""))
    except ValueError:
        return url.strip()


def dedup_key(url: str | None, text_head: str) -> str:
    """URL 优先; 无 URL 用内容前 500 字指纹."""
    if url:
        return "u:" + hashlib.sha1(norm_url(url).encode()).hexdigest()[:16]
    return "c:" + hashlib.sha1(
        re.sub(r"\s", "", text_head)[:500].encode()).hexdigest()[:16]


def count_chars(text: str) -> int:
    """有效字数: 去空白后的字符数 (中文口径)."""
    return len(re.sub(r"\s", "", text))


def read_text_safe(p: Path) -> str:
    for enc in ("utf-8", "gbk", "utf-16"):
        try:
            return p.read_text(encoding=enc, errors="ignore")
        except OSError:
            return ""
    return ""


# ---------- 池操作 (immutability: 读→新对象→原子写回) ----------
def _camp_dir(cid: str) -> Path:
    if not re.fullmatch(r"[A-Za-z0-9_\-]{3,40}", cid):
        raise ValueError(f"非法 campaign_id: {cid}")
    return POOL_ROOT / cid


def _load_state(d: Path) -> dict:
    p = d / "pool_state.json"
    if p.is_file():
        return json.loads(p.read_text(encoding="utf-8"))
    return {"campaign": d.name, "total_chars": 0, "items": 0,
            "by_engine": {}, "domains": [], "gate_chars": AMMO_GATE_CHARS,
            "created": time.strftime("%Y-%m-%d %H:%M")}


def _save_state(d: Path, s: dict) -> None:
    d.mkdir(parents=True, exist_ok=True)
    tmp = d / "pool_state.tmp"
    tmp.write_text(json.dumps(s, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(d / "pool_state.json")


def _manifest_keys(d: Path) -> set[str]:
    p = d / "manifest.jsonl"
    if not p.is_file():
        return set()
    return {json.loads(x).get("dedup_key", "") for x in
            p.read_text(encoding="utf-8").splitlines() if x.strip()}


def ingest(cid: str, file: str, engine: str, url: str = "",
           cred: str = "unknown") -> int:
    """单条入池: URL 归一 + 去重 + source_engine 标记 + 字数累计."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在, 先 init {cid}", file=sys.stderr)
        return 1
    fp = Path(file)
    if not fp.is_file():
        print(f"[pool] 文件不存在: {file}", file=sys.stderr)
        return 1
    text = read_text_safe(fp)
    if len(text) < 50:
        print(f"[pool] 跳过 (太短): {fp.name}")
        return 0
    key = dedup_key(url or None, text)
    if key in _manifest_keys(d):
        print(f"[pool] 跳过 (重复): {fp.name}")
        return 0
    row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "engine": engine,
           "source_path": str(fp), "url_norm": norm_url(url) if url else "",
           "chars": count_chars(text), "credibility": cred,
           "dedup_key": key}
    with (d / "manifest.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")
    s = _load_state(d)
    ns = {**s, "total_chars": s["total_chars"] + row["chars"],
          "items": s["items"] + 1,
          "by_engine": {**s["by_engine"],
                        engine: s["by_engine"].get(engine, 0) + row["chars"]}}
    host = urlsplit(row["url_norm"]).netloc if row["url_norm"] else fp.stem
    if host and host not in ns["domains"]:
        ns = {**ns, "domains": [*ns["domains"], host][:2000]}
    _save_state(d, ns)
    pct = 100 * ns["total_chars"] / AMMO_GATE_CHARS
    print(f"[pool] +{row['chars']:>7,}字 {fp.name[:36]:<36} "
          f"累计 {ns['total_chars']:,} ({pct:.1f}%)")
    return 0


def stocktake(cid: str, dirs: list[str], kw: str = "") -> int:
    """盘家底: 扫描存量语料目录, 相关文件引用式入池 (批量模式: keys 一次载入,
    state 循环外一次写 — 大目录不拖死)."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在, 先 init {cid}", file=sys.stderr)
        return 1
    kws = [k for k in re.split(r"[\s,，、]+", kw) if len(k) >= 2]
    keys = _manifest_keys(d)
    s = _load_state(d)
    by_eng = dict(s["by_engine"])
    total, items = s["total_chars"], s["items"]
    scanned = ingested = skipped_short = skipped_kw = dup = 0
    ts = time.strftime("%Y-%m-%dT%H:%M:%S")
    with (d / "manifest.jsonl").open("a", encoding="utf-8") as out:
        for ds in dirs:
            root = Path(ds)
            if not root.is_dir():
                print(f"[pool] 目录不存在, 跳过: {ds}", file=sys.stderr)
                continue
            engine = f"own:{root.name[:20]}"
            for p in sorted(root.rglob("*")):
                if p.suffix.lower() not in (".md", ".txt", ".json"):
                    continue
                scanned += 1
                text = read_text_safe(p)
                if len(text) < 200:
                    skipped_short += 1
                    continue
                if kws:
                    head = text[:2000]
                    if not any(k in head or k in p.name for k in kws):
                        skipped_kw += 1
                        continue
                key = dedup_key(None, text)
                if key in keys:
                    dup += 1
                    continue
                keys.add(key)
                ch = count_chars(text)
                out.write(json.dumps(
                    {"ts": ts, "engine": engine, "source_path": str(p),
                     "url_norm": "", "chars": ch, "credibility": "stock",
                     "dedup_key": key}, ensure_ascii=False) + "\n")
                total += ch
                items += 1
                by_eng[engine] = by_eng.get(engine, 0) + ch
                ingested += 1
    _save_state(d, {**s, "total_chars": total, "items": items,
                    "by_engine": by_eng,
                    "last_stocktake": time.strftime("%Y-%m-%d %H:%M")})
    print(f"\n[盘家底] 扫描文件 {scanned} | 入池 {ingested} | 重复弃 {dup} | "
          f"太短弃 {skipped_short} | 不相关弃 {skipped_kw}")
    print(f"[家底] 累计 {total:,} 字 "
          f"({100 * total / AMMO_GATE_CHARS:.1f}% of 1000万门槛) "
          f"| 差 {max(0, AMMO_GATE_CHARS - total):,} 字")
    return 0


def status(cid: str) -> int:
    """盘点仪表首屏: 进度条 + 渠道贡献榜 + 独立域名数."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在: {cid}", file=sys.stderr)
        return 1
    s = _load_state(d)
    pct = min(1.0, s["total_chars"] / AMMO_GATE_CHARS)
    bar = "█" * int(pct * 30) + "░" * (30 - int(pct * 30))
    print(f"\n╔═ 弹药池仪表 ═ {cid}")
    print(f"║ 字数门槛: {s['total_chars']:>12,} / {AMMO_GATE_CHARS:,}  "
          f"[{bar}] {pct * 100:.1f}%")
    print(f"║ 弹药条目: {s['items']:>12,} | 独立信源域: {len(s['domains']):>6,}")
    print(f"║ 门槛状态: {'✅ 已过门 (可进撰写)' if pct >= 1 else '⏳ 未过门 (继续采)'}")
    print(f"║ 渠道贡献榜 (字数):")
    for eng, ch in sorted(s["by_engine"].items(), key=lambda x: -x[1])[:8]:
        print(f"║   {eng[:24]:<24} {ch:>12,}  {'▇' * max(1, int(20 * ch / max(1, s['total_chars'])))}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="弹药池 (千万字弹药工程 F-2)")
    ap.add_argument("cmd", choices=["init", "ingest", "stocktake", "status"])
    ap.add_argument("cid", help="campaign_id (如 EPC100-电建-2026Q4)")
    ap.add_argument("--file", default="")
    ap.add_argument("--engine", default="own:manual")
    ap.add_argument("--url", default="")
    ap.add_argument("--cred", default="unknown",
                    choices=["official", "media", "research", "stock", "unknown"])
    ap.add_argument("--dirs", action="append", default=[])
    ap.add_argument("--kw", default="", help="相关性关键词 (空格分隔, 空=全量)")
    args = ap.parse_args()
    try:
        if args.cmd == "init":
            d = _camp_dir(args.cid)
            _save_state(d, _load_state(d))
            print(f"[pool] 战役池就绪: {d}")
        elif args.cmd == "ingest":
            if not args.file:
                print("--file 必填", file=sys.stderr)
                return 2
            return ingest(args.cid, args.file, args.engine, args.url, args.cred)
        elif args.cmd == "stocktake":
            if not args.dirs:
                print("--dirs 必填 (可多次)", file=sys.stderr)
                return 2
            return stocktake(args.cid, args.dirs, args.kw)
        return status(args.cid)
    except (ValueError, OSError, json.JSONDecodeError) as e:
        print(f"[pool] 错误: {e}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
