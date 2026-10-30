# -*- coding: utf-8 -*-
"""W1 十盘真件硬门跑批器

流程：候选链（analysis/w1_gate_links.json 分桶 + GATE_OVERRIDES 手工件）→ adapter 全链
      → 选 ≥10MB 文件 → 落盘 w1_downloads/<盘名>/ → sha1 → 证据行落 analysis/W1_GREEN_GATES.md
铁律：每盘一件为限；下载总额≤1.5GB；找不到真实链=「绿?·门未过·原因」如实记，不降标准。
"""
from __future__ import annotations

import hashlib
import json
import re
import sys
import time
from datetime import datetime
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from adapters import ADAPTERS                              # noqa: E402
from adapters.base import PanError, extract_pwd            # noqa: E402


def _norm(u: str) -> tuple[str, str]:
    """候选 URL → (base, pwd)：提取码从 URL 剥离（含 # 尾污染清理）。"""
    base, pwd = extract_pwd(u)
    return base, pwd

MIN_BYTES = 10 * 1024 * 1024
TOTAL_BUDGET = 1_500_000_000

#: 手工候选（README 公开示例/公开网页示例；格式 url 或 (url, pwd)）
GATE_OVERRIDES: dict[str, list] = {
    "ilanzou": [("https://www.ilanzou.com/s/LEBZySxF", ""),
                ("https://www.ilanzou.com/s/lGFndCM", "KMnv")],   # refs_nfd README 公开示例
    "ecpan": [("https://www.ecpan.cn/web/#/yunpanProxy?path=%2F%23%2Fdrive%2Foutside&data=70017ece572737b12b30709b7f029308eJD0&isShare=1", "1234")],
    # 其余盘由 w1_gate_links.json 搜索分桶供给；wenshushu/cow/feijipan/guangya 稀有盘
    # 另有 GATE_EXTRA_JSON 追加（公开示例狩猎结果，见 runlog）
}
GATE_EXTRA_JSON = ROOT / "analysis" / "w1_gate_extra.json"

down_total = 0
rows: list[dict] = []


def _sha1(p: Path) -> str:
    h = hashlib.sha1()
    with open(p, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            h.update(chunk)
    return h.hexdigest().upper()


def _download(url: str, headers: dict, out: Path, cap: int) -> tuple[int, str]:
    from curl_cffi import requests as creq
    r = creq.get(url, headers=headers, impersonate="chrome124", stream=True, timeout=120)
    if r.status_code >= 400:
        raise PanError(f"下载 HTTP {r.status_code}")
    total, sha = 0, hashlib.sha1()
    with open(out, "wb") as f:
        for chunk in r.iter_content(1 << 18):
            if not chunk:
                continue
            f.write(chunk)
            sha.update(chunk)
            total += len(chunk)
            if total >= cap:
                break
    return total, sha.hexdigest().upper()


def run_gate(disk: str, url: str, pwd: str = "") -> dict:
    """单盘一门：链→列表→直链→落盘。返回证据行 dict。"""
    global down_total
    ev = {"disk": disk, "url": url, "pwd": pwd, "verdict": "", "file": "", "size": 0,
          "sha1": "", "steps": [], "err": ""}
    t0 = time.time()
    adapter = ADAPTERS[disk]
    try:
        entries = adapter.parse(url, pwd)
        ev["steps"].append(f"列表OK({len(entries)}项): " + "; ".join(
            f"{e.name[:36]}{'/' if e.is_dir else '/%.1fM' % (e.size/1048576)}"
            for e in entries[:6]))
        cand = next((e for e in entries if not e.is_dir and e.size >= MIN_BYTES), None)
        if not cand:
            raise PanError("无 ≥10MB 文件项: " + "; ".join(e.name[:30] for e in entries[:5]))
        ev["steps"].append(f"选中 {cand.name[:60]} ({cand.size} B)")
        u = adapter.direct_url(cand)
        ev["steps"].append(f"直链OK: {u[:100]}")
        cap = min(cand.size if cand.size > 0 else 500 * 1048576,
                  TOTAL_BUDGET - down_total, 50 * 1048576)   # 门只需 ≥10MB 证据，50MB 封顶
        out_dir = ROOT / "w1_downloads" / disk
        out_dir.mkdir(parents=True, exist_ok=True)
        safe = "".join(c for c in cand.name if c not in '\\/:*?"<>|')[:80] or f"{disk}.bin"
        out = out_dir / safe
        n, sha = adapter.stream_download(u, out, cap)
        down_total += n
        ev.update(verdict="绿·门过", file=str(out.relative_to(ROOT)), size=n, sha1=sha)
        ev["steps"].append(f"落盘 {n} B sha1={sha}")
    except PanError as e:
        ev.update(verdict="绿?·门未过", err=str(e)[:300])
    except Exception as e:
        ev.update(verdict="绿?·门未过", err=f"{type(e).__name__}: {str(e)[:250]}")
    ev["elapsed_s"] = round(time.time() - t0, 1)
    return ev


def main(disks: list[str] | None = None):
    buckets = {}
    p = ROOT / "analysis" / "w1_gate_links.json"
    if p.exists():
        buckets = json.loads(p.read_text(encoding="utf-8"))
    if GATE_EXTRA_JSON.exists():
        extra = json.loads(GATE_EXTRA_JSON.read_text(encoding="utf-8"))
        for d, links in extra.items():
            buckets.setdefault(d, []).extend(links)

    order = disks or ["uc", "115", "123", "lanzou", "ilanzou", "feijipan", "ecpan",
                      "wenshushu", "cow", "guangya"]
    # 累积台账：已「绿·门过」的盘不重跑（证据沿用既有行）
    prev_rows = {}
    prev_p = ROOT / "analysis" / "w1_gates_rows.json"
    if prev_p.exists():
        for r in json.loads(prev_p.read_text(encoding="utf-8")):
            if r.get("verdict") == "绿·门过":
                prev_rows[r["disk"]] = r
    order = [d for d in order if d not in prev_rows] or list(prev_rows)
    for disk in order:
        cands: list[tuple[str, str]] = []
        for o in GATE_OVERRIDES.get(disk, []):
            cands.append((o[0], o[1] if len(o) > 1 else ""))
        seen = set(u for u, _ in cands)
        for it in buckets.get(disk, []):
            u = it["url"] if isinstance(it, dict) else it
            if u not in seen:
                cands.append((u, ""))
                seen.add(u)
        if not cands:
            rows.append({"disk": disk, "url": "", "verdict": "绿?·门未过",
                         "err": "无真实链候选（9 活源搜索无此盘型+公开示例未获）", "steps": []})
            print(f"[{disk:10s}] 无候选", flush=True)
            continue
        cands = [_norm(u) if isinstance(u, str) else (_norm(u[0]) if not u[1] else (u[0], u[1]))
                 for u in cands]
        cands = [(b, p) for b, p in cands if b]
        done = False
        try_cap = 10 if disk == "lanzou" else 5
        for url, pwd in cands[:try_cap]:
            print(f"[{disk:10s}] 试 {url[:80]}" + (f" pwd={pwd}" if pwd else ""), flush=True)
            ev = run_gate(disk, url, pwd)
            rows.append(ev)
            print(f"           -> {ev['verdict']} {ev.get('err','')[:90]} "
                  f"({ev['size']//1024}KB {ev['elapsed_s']}s)", flush=True)
            if ev["verdict"] == "绿·门过":
                done = True
                break
            time.sleep(2)
        _ = done

    # 落证据 md（合并历史绿行）
    for d, r in prev_rows.items():
        if not any(x["disk"] == d for x in rows):
            rows.append(r)
    out_md = ROOT / "analysis" / "W1_GREEN_GATES.md"
    lines = ["# W1 十盘真件硬门台账（2026-10-31）", "",
             "> 出口门纪律（红队令）：真实分享链→列表→直链→≥10MB 真文件落盘 w1_downloads/<盘名>/ 才算「绿」；",
             "> 未达=「绿?·门未过+原因」，不降标准。下载内容仅通道测试。", ""]
    n_pass = sum(1 for r in rows if r["verdict"] == "绿·门过")
    lines.append(f"**门过 {n_pass}/10** · 下载总额 {down_total/1048576:.1f} MB（预算 1.5GB）· "
                 f"生成 {datetime.now().strftime('%H:%M')}")
    lines.append("")
    lines.append("| 盘 | 门 | 链接 | 文件 | 大小 | sha1 | 失败原因 |")
    lines.append("|---|---|---|---|---|---|---|")
    for r in rows:
        if r["verdict"] == "绿·门过":
            lines.append(f"| {r['disk']} | 绿·门过 | {r['url'][:60]} | {Path(r['file']).name[:36]} "
                         f"| {r['size']/1048576:.1f}MB | `{r['sha1'][:16]}…` | — |")
        else:
            lines.append(f"| {r['disk']} | 绿?·门未过 | {r['url'][:60] or '—'} | — | — | — "
                         f"| {r.get('err','')[:100]} |")
    lines.append("")
    lines.append("## 全链证据（逐盘步骤）")
    for r in rows:
        lines.append(f"\n### {r['disk']} · {r['verdict']}")
        lines.append(f"- 链接: `{r['url'][:120]}`" + (f"（pwd={r['pwd']}）" if r.get('pwd') else ""))
        for s in r.get("steps", []):
            lines.append(f"- {s}")
        if r.get("err"):
            lines.append(f"- 失败: {r['err']}")
    out_md.write_text("\n".join(lines), encoding="utf-8")
    (ROOT / "analysis" / "w1_gates_rows.json").write_text(
        json.dumps(rows, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\n== 门过 {n_pass}/10，台账 -> {out_md}")


if __name__ == "__main__":
    main(sys.argv[1:] or None)
