# -*- coding: utf-8 -*-
"""弹药池 (Ammo Foundry F-2) — 千万字弹药工程核心件, 用户 09-22 批准 R0.

门槛语义铁律 (用户 09-22 终版定调, 不可漂移):
  1. 单课题门槛 = 本次任务**新增**调研资料 >= 1000 万字 (存量不计入);
  2. 每次研究报告任务 = 全新全渠道调研, 从头开始;
  3. 新增资料**通过有效性判断才计数**: 入池=pending 不计门槛, 判有效才入账;
  4. 成稿素材不受限: 报告生成可用一切掌握的资料 = 存量 + 本次新增
     (存量不上门槛账, 但成稿阶段照常可用 — 门槛管计数, 不管引用);
  5. 弹药等价原则: 渠道资料与军团成果同池同 schema 同核验.

判断链 (三铁律: 免费优先/fail-soft/证据先行):
  R0 = 本地启发式 (免费: 课题相关性+实质度+垃圾页特征, 判不了就留 pending);
  R3 = Jev S2 硬门接管 (F-3 接线后 --engine jev).

池结构 (全站级资产, 本地明文 — Ghost 律):
  E:\\AI-Station\\ammo_pool\\<campaign_id>\\
    manifest.jsonl    每条弹药一行 (judge: pending|valid|rejected + 判由)
    pool_state.json   实时账本 (门槛账=valid; 待审/废弃只作审计)

用法:
  python ammo_pool.py init <campaign_id> --kw "EPC 总承包 水利"
  python ammo_pool.py ingest <cid> --file <path> --engine own:rss [--url URL] [--cred media]
  python ammo_pool.py judge <cid> [--limit 500]        # pending -> valid/rejected
  python ammo_pool.py stocktake <cid> --dirs <dir> [--kw "..."]   # 只读, 不入池
  python ammo_pool.py status <cid>                     # 仪表: 门槛账只认 valid
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
AMMO_GATE_CHARS = 10_000_000   # 用户铁律: 1000 万字 (仅有效新增弹药)


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


def parse_kws(kw: str) -> list[str]:
    return [k for k in re.split(r"[\s,，、]+", kw) if len(k) >= 2]


# ---------- 有效性判断 (R0 启发式 — 免费优先/fail-soft/证据先行) ----------
_GARBAGE = ("登录后查看", "请输入验证码", "404 Not Found", "403 Forbidden",
            "扫码关注", "访问过于频繁", "页面不存在", "网络出错")
MIN_SUBSTANCE = 300   # 实质度: 去空白后至少 300 字


def judge_heuristic(text: str, kws: list[str]) -> tuple[str, str]:
    """返回 (verdict, reason). 判不了相关性时返回 pending — 绝不静默计数."""
    if count_chars(text) < MIN_SUBSTANCE:
        return "rejected", f"substance<{MIN_SUBSTANCE}"
    head = text[:3000]
    if sum(1 for g in _GARBAGE if g in head) >= 2:
        return "rejected", "garbage_page"
    if not kws:
        return "pending", "no_campaign_kws"   # 无判据=不计数 (fail-soft)
    body = text[:8000]
    if not any(k in head or k in body or k in text[:8000] for k in kws):
        return "rejected", "off_topic"
    return "valid", "kw_hit+substance_ok"


# ---------- 池操作 (immutability: 读→新对象→原子写回) ----------
def _camp_dir(cid: str) -> Path:
    if not re.fullmatch(r"[A-Za-z0-9_\-]{3,40}", cid):
        raise ValueError(f"非法 campaign_id: {cid}")
    return POOL_ROOT / cid


def _load_state(d: Path) -> dict:
    p = d / "pool_state.json"
    if p.is_file():
        return json.loads(p.read_text(encoding="utf-8"))
    return {"campaign": d.name, "kws": [], "total_chars": 0, "items": 0,
            "pending_chars": 0, "pending_items": 0,
            "rejected_chars": 0, "rejected_items": 0,
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
    """单条入池: URL 归一 + 去重 + source_engine 标记. 入池即 pending,
    **不计门槛账** — 判有效 (judge) 才计数 (用户 09-22 铁律)."""
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
    ch = count_chars(text)
    row = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "engine": engine,
           "source_path": str(fp), "url_norm": norm_url(url) if url else "",
           "chars": ch, "credibility": cred, "dedup_key": key,
           "judge": "pending", "judge_reason": "", "judge_engine": ""}
    with (d / "manifest.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")
    s = _load_state(d)
    ns = {**s, "pending_chars": s.get("pending_chars", 0) + ch,
          "pending_items": s.get("pending_items", 0) + 1}
    _save_state(d, ns)
    print(f"[pool] +待审 {ch:>7,}字 {fp.name[:36]:<36} "
          f"待审判有效后计数 (现待审 {ns['pending_chars']:,})")
    return 0


def judge(cid: str, limit: int = 500) -> int:
    """有效性判断: pending -> valid (入门槛账) / rejected (审计废弃).
    判据随行写入 manifest; 文件丢失/无课题关键词 -> 保持 pending 不计数."""
    d = _camp_dir(cid)
    mp = d / "manifest.jsonl"
    if not mp.is_file():
        print(f"[pool] 无 manifest: {cid}", file=sys.stderr)
        return 1
    s = _load_state(d)
    kws = s.get("kws", [])
    if not kws:
        print("[judge] 战役未配置课题关键词 (init --kw), 无法判相关性 — "
              "全部保持 pending, 绝不静默计数", file=sys.stderr)
        return 2
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    n_valid = n_rej = n_keep = 0
    for row in rows:
        if limit and n_valid + n_rej >= limit:
            break
        if row.get("judge", "pending") != "pending":
            continue
        fp = Path(row["source_path"])
        text = read_text_safe(fp) if fp.is_file() else ""
        if not text:
            row.update(judge="pending", judge_reason="file_missing",
                       judge_engine="heuristic")
            n_keep += 1
            continue
        verdict, reason = judge_heuristic(text, kws)
        row.update(judge=verdict, judge_reason=reason, judge_engine="heuristic")
        ch = row["chars"]
        if verdict == "valid":
            n_valid += 1
            s = {**s, "total_chars": s["total_chars"] + ch,
                 "items": s["items"] + 1,
                 "pending_chars": s["pending_chars"] - ch,
                 "pending_items": s["pending_items"] - 1,
                 "by_engine": {**s["by_engine"],
                               row["engine"]: s["by_engine"].get(
                                   row["engine"], 0) + ch}}
            host = (urlsplit(row["url_norm"]).netloc
                    if row["url_norm"] else fp.stem)
            if host and host not in s["domains"]:
                s = {**s, "domains": [*s["domains"], host][:2000]}
        else:
            n_rej += 1
            s = {**s,
                 "rejected_chars": s.get("rejected_chars", 0) + ch,
                 "rejected_items": s.get("rejected_items", 0) + 1,
                 "pending_chars": s["pending_chars"] - ch,
                 "pending_items": s["pending_items"] - 1}
    tmp = d / "manifest.tmp"
    tmp.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                             for r in rows) + "\n", encoding="utf-8")
    tmp.replace(mp)
    _save_state(d, {**s, "last_judge": time.strftime("%Y-%m-%d %H:%M")})
    print(f"\n[判断] 启发式@课题关键词({len(kws)}): 有效 {n_valid} 入门槛账 | "
          f"废弃 {n_rej} | 留审 {n_keep} (文件缺失)")
    print(f"[门槛账] 有效弹药 {s['total_chars']:,} 字 "
          f"({100 * s['total_chars'] / AMMO_GATE_CHARS:.1f}% of 1000万) | "
          f"待审 {s['pending_chars']:,} 字 | 废弃 {s.get('rejected_chars', 0):,} 字")
    return 0


def stocktake(cid: str, dirs: list[str], kw: str = "") -> int:
    """全站资产盘点 (纯只读统计, 不入战役池) — 用户 09-22 令: 存量不参与
    报告生产, 战役池只收新增调研资料; 本命令仅作全站资产摸底报表."""
    kws = parse_kws(kw)
    scanned = relevant = skipped_short = skipped_kw = 0
    total = 0
    by_dir: dict[str, int] = {}
    for ds in dirs:
        root = Path(ds)
        if not root.is_dir():
            print(f"[盘点] 目录不存在, 跳过: {ds}", file=sys.stderr)
            continue
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
            relevant += 1
            ch = count_chars(text)
            total += ch
            by_dir[root.name] = by_dir.get(root.name, 0) + ch
    print(f"\n[全站资产盘点·只读] 扫描 {scanned} | 相关 {relevant} | "
          f"太短弃 {skipped_short} | 不相关弃 {skipped_kw}")
    print(f"[相关存量] {total:,} 字 (全站资产摸底; 不入战役池, 不算门槛; "
          f"成稿阶段可作素材引用 — 用户 09-22 终版定调)")
    for k, v in sorted(by_dir.items(), key=lambda x: -x[1])[:5]:
        print(f"  {k[:24]:<24} {v:>12,}")
    return 0


def status(cid: str) -> int:
    """仪表首屏: 门槛账只认有效弹药 (valid); 待审/废弃为审计副账."""
    d = _camp_dir(cid)
    if not d.is_dir():
        print(f"[pool] 战役池不存在: {cid}", file=sys.stderr)
        return 1
    s = _load_state(d)
    pct = min(1.0, s["total_chars"] / AMMO_GATE_CHARS)
    bar = "█" * int(pct * 30) + "░" * (30 - int(pct * 30))
    print(f"\n╔═ 弹药池仪表 ═ {cid}")
    print(f"║ 课题关键词: {' | '.join(s.get('kws', [])) or '(未配置!)'}")
    print(f"║ 门槛账 [有效新增弹药 — 通过判断才计数, 用户铁律]:")
    print(f"║   {s['total_chars']:>12,} / {AMMO_GATE_CHARS:,}  "
          f"[{bar}] {pct * 100:.1f}%")
    print(f"║   有效条目: {s['items']:,} | 独立信源域: {len(s['domains']):,}")
    print(f"║   待审: {s.get('pending_items', 0):,} 条 / "
          f"{s.get('pending_chars', 0):,} 字 (judge 后移动)")
    print(f"║   废弃: {s.get('rejected_items', 0):,} 条 / "
          f"{s.get('rejected_chars', 0):,} 字 (off_topic/垃圾/太短)")
    print(f"║   门槛状态: {'✅ 已过门 (可进撰写)' if pct >= 1 else '⏳ 未过门 (有效弹药继续)'}")
    print(f"║ 渠道贡献榜 (仅有效弹药):")
    top = max(s["by_engine"].values()) if s["by_engine"] else 1
    for eng, ch in sorted(s["by_engine"].items(), key=lambda x: -x[1])[:8]:
        print(f"║   {eng[:24]:<24} {ch:>12,}  {'▇' * max(1, int(20 * ch / top))}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="弹药池 (千万字弹药工程 F-2)")
    ap.add_argument("cmd", choices=["init", "ingest", "judge",
                                    "stocktake", "status"])
    ap.add_argument("cid", help="campaign_id (如 EPC100-2026Q4)")
    ap.add_argument("--kw", default="", help="课题关键词 (init 配置判断判据)")
    ap.add_argument("--limit", type=int, default=500, help="judge 批量上限")
    ap.add_argument("--file", default="")
    ap.add_argument("--engine", default="own:manual")
    ap.add_argument("--url", default="")
    ap.add_argument("--cred", default="unknown",
                    choices=["official", "media", "research", "stock", "unknown"])
    ap.add_argument("--dirs", action="append", default=[])
    args = ap.parse_args()
    try:
        if args.cmd == "init":
            d = _camp_dir(args.cid)
            s = _load_state(d)
            if args.kw:
                s = {**s, "kws": parse_kws(args.kw)}
            _save_state(d, s)
            print(f"[pool] 战役池就绪: {d} (课题关键词 {len(s['kws'])} 个)")
        elif args.cmd == "ingest":
            if not args.file:
                print("--file 必填", file=sys.stderr)
                return 2
            return ingest(args.cid, args.file, args.engine, args.url, args.cred)
        elif args.cmd == "judge":
            return judge(args.cid, args.limit)
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
