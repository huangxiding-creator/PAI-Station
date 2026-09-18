# -*- coding: utf-8 -*-
"""飞书文档演化时间线（演化维 L4 补强·第四数据源=写作流）。

两层：
- 全景层（零 API）：doc_inventory.json 756 文档 created×月 直方图
  ——飞书写作流的"开题史"
- 修订层（限额 API）：核心卷宗 docs +history-list（每篇 ≤3 页×20 版，
  节流 2.5s）——revision 总量+按月修订曲线=打磨强度

账号安全纪律：单次运行 ≤60 请求熔断，请求间 sleep 2.5s。
产出 SELF_PROFILE/cx_飞书文档演化_<date>.md。
用法：python tools/cx_feishu_evolution.py [--deep]（--deep 才调 API）
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
import time
from collections import Counter
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
LARK = Path.home() / "AppData/Roaming/npm/node_modules/@larksuite/cli/bin/lark-cli.exe"
INVENTORY = REPO / "SELF_PROFILE/feishu/raw/doc_inventory.json"
OUT = REPO / "SELF_PROFILE" / f"cx_飞书文档演化_{datetime.now():%Y%m%d}.md"

# 核心卷宗挑选：标题关键词（战略/品牌文档优先）
CORE_KEYS = ("总包", "AI", "眼镜", "生态", "智库", "访谈", "方案", "学园")
CORE_LIMIT = 15
REQ_BUDGET = 60  # 账号安全：单跑请求上限
THROTTLE_S = 2.5


def lark_history(doc_token: str, page_token: str = "") -> dict:
    """一页版本史（20 条）。失败/超限返回空 dict。"""
    cmd = [str(LARK), "docs", "+history-list", "--doc", doc_token,
           "--as", "user", "--json"]
    if page_token:
        cmd += ["--page-token", page_token]
    proc = subprocess.run(
        cmd, capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=60,
        creationflags=0x08000000,
    )
    try:
        doc = json.loads(proc.stdout)
    except json.JSONDecodeError:
        return {}
    if not doc.get("ok"):
        return {}
    data = doc.get("data") or {}
    return {
        "entries": data.get("entries") or [],
        "page_token": data.get("page_token") or "",
    }


def deep_core(docs: list[dict]) -> list[dict]:
    """核心卷宗修订史（每篇 ≤3 页）。返回 [{title, rev_total, edits[月]}]。"""
    core = [d for d in docs
            if d.get("doc_type") in ("docx", "doc", None)
            and any(k in (d.get("title") or "") for k in CORE_KEYS)]
    core = core[:CORE_LIMIT]
    out = []
    req = 0
    for d in core:
        entries: list[dict] = []
        token = ""
        for _ in range(3):
            if req >= REQ_BUDGET:
                print(f"[budget] 请求达 {REQ_BUDGET} 上限，熔断")
                return out
            time.sleep(THROTTLE_S)
            page = lark_history(d["token"], token)
            req += 1
            if not page:
                break
            entries += page["entries"]
            token = page["page_token"]
            if not token:
                break
        if not entries:
            continue
        months = Counter()
        for e in entries:
            try:
                t = datetime.fromisoformat(e["edit_time"].replace("Z", "+00:00"))
                months[t.astimezone().strftime("%Y-%m")] += 1
            except (KeyError, ValueError):
                continue
        out.append({
            "title": d["title"],
            "rev_total": entries[0].get("revision_id") or 0,
            "n_editors": len({e.get("editor_ids", [""])[0] for e in entries}),
            "months": dict(months),
            "latest": entries[0].get("edit_time", "")[:10],
        })
        print(f"[ok] {d['title'][:24]} rev={out[-1]['rev_total']}")
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--deep", action="store_true", help="调 API 拉核心卷宗修订史")
    args = ap.parse_args()

    docs = json.loads(INVENTORY.read_text(encoding="utf-8"))
    created = Counter()
    touched = Counter()
    types = Counter()
    for d in docs:
        c = (d.get("created") or "")[:7]
        u = (d.get("updated") or "")[:7]
        if c:
            created[c] += 1
        if u:
            touched[u] += 1
        types[d.get("doc_type") or "?"] += 1

    L = ["# 飞书文档演化时间线（写作流）", ""]
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · {len(docs)} 文档 · "
             "全景层=清单零 API；修订层=核心卷宗版本史（节流+限额）")
    L.append("")
    L.append("## 全景：开题史（created × 月）")
    L.append("")
    L.append("| 月 | 新建 | 被修订月分布 |")
    L.append("|---|---:|---:|")
    months = sorted(set(created) | set(touched))
    for m in months:
        L.append(f"| {m} | {created.get(m, 0)} | {touched.get(m, 0)} |")
    L.append("")
    L.append("类型分布：" + "、".join(f"{k} {v}" for k, v in
             types.most_common(8)))
    L.append("")

    if args.deep:
        core = deep_core(docs)
        if core:
            L.append("## 核心卷宗修订史（revision 总量 × 近期打磨月）")
            L.append("")
            L.append("| 文档 | 累计修订 | 可见编辑月（深 60 版内） | 最近编辑 |")
            L.append("|---|---:|---|---|")
            for c in sorted(core, key=lambda x: -x["rev_total"]):
                mm = "、".join(f"{k}×{v}" for k, v in sorted(c["months"].items()))
                L.append(f"| {c['title'][:28]} | {c['rev_total']} | {mm} | {c['latest']} |")

    OUT.write_text("\n".join(L), encoding="utf-8")
    print(f"飞书文档演化 → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
