# -*- coding: utf-8 -*-
"""金标准 100 题月度跑分（L4 验收机制）——检索命中代理 v0。

口径（v0，keyword-only）：
- 检索：ChunkIndex.search(问题原文, k=8)（FTS+LIKE 分级路由；语义路由待
  嵌入回填完成后接入）
- 命中：top-8 块任一块文本含答案关键 token（取答案里最长的 ≤3 个 token，
  长词最具区分度；全短词答案退 2 字 token）
- 报告：总 hit@8 + 按维 × 按难度 + 未命中清单（区分"零结果"vs"词面不匹配"
  ——后者才是词汇鸿沟真问题）

用法：python tools/cx_golden_score.py [--k 8] [--golden 路径]
产出：SELF_PROFILE/golden_set/score_<date>.md（本地私有）
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from collections import defaultdict
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.sense.localfiles.store import ChunkIndex  # noqa: E402

TOKEN_RE = re.compile(r"[一-龥]{2,}|[A-Za-z][A-Za-z0-9_-]{2,}|\d{2,}")
# 答案里的通用词（命中也不证明检对了文档）
GENERIC = {
    "什么", "如何", "我的", "自己", "关系", "岗位", "单位", "公司", "有限",
    "有限公司", "股份有限", "工程院", "研究院", "事业部", "信息化", "副业",
    "主业", "工作", "项目", "系统", "平台", "数据", "时间", "开始", "使用",
}


def _residual(token: str) -> str:
    """token 剔除全部通用子词与虚词后的残值——残值<2 字=整词皆通用，弃。"""
    r = token
    for g in GENERIC:
        if g in r:
            r = r.replace(g, "")
    for f in "与和的是了在及或为中":
        r = r.replace(f, "")
    return r


def extract_tokens(answer: str) -> list[str]:
    """答案 → 区分度 token（长词优先，剔通用词）。纯函数，测试覆盖。

    中文连续 run 不分词，故通用性判定用"剔通用子词看残值"：整串通用
    （如"我的主业单位与岗位是什么"）残值空 → 弃；含专名残值留 → 保。
    """
    toks = [t for t in TOKEN_RE.findall(answer) if t not in GENERIC and len(_residual(t)) >= 2]
    if not toks:
        return []
    longs = sorted((t for t in toks if len(t) >= 3), key=len, reverse=True)
    if longs:
        return longs[:3]
    shorts = sorted(toks, key=len, reverse=True)
    return shorts[:3]


def is_hit(hits: list, tokens: list[str]) -> bool:
    """top-k 块任一含任一 token。hits=ChunkHit 列表。"""
    if not tokens:
        return False
    return any(tok in h.text for tok in tokens for h in hits)


def classify_miss(hits: list, tokens: list[str]) -> str:
    if not hits:
        return "零结果（索引无此词汇面）"
    if not tokens:
        return "答案无区分 token（考题待修）"
    return "词面不匹配（问答鸿沟：问题词≠文档词）"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--golden", default=str(
        REPO / "SELF_PROFILE" / "golden_set" / "golden_100_v1.jsonl"))
    ap.add_argument("--k", type=int, default=8)
    args = ap.parse_args()

    questions = [json.loads(ln) for ln in open(args.golden, encoding="utf-8")]
    index = ChunkIndex(REPO / "data" / "local_index" / "index.db")

    rows = []
    for q in questions:
        toks = extract_tokens(q["a"])
        hits = index.search(q["q"], k=args.k)
        hit = is_hit(hits, toks)
        rows.append({
            "id": q["id"], "dim": q["dim"], "diff": q["diff"],
            "q": q["q"], "hit": hit,
            "miss_type": "" if hit else classify_miss(hits, toks),
            "tokens": toks, "n_hits": len(hits),
        })

    out = REPO / "SELF_PROFILE" / "golden_set" / f"score_{datetime.now():%Y%m%d_%H%M}.md"
    total = len(rows)
    n_hit = sum(r["hit"] for r in rows)
    by_dim = defaultdict(lambda: [0, 0])
    by_diff = defaultdict(lambda: [0, 0])
    for r in rows:
        by_dim[r["dim"]][1] += 1
        by_diff[r["diff"]][1] += 1
        if r["hit"]:
            by_dim[r["dim"]][0] += 1
            by_diff[r["diff"]][0] += 1

    L = ["# 金标准跑分 v0（keyword-only 检索命中代理）", ""]
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · hit@{args.k} = {n_hit}/{total}"
             f"（{n_hit / total:.0%}）· 语义路由未接（嵌入回填中，分数为下界）")
    L.append("")
    L.append("| 维度 | 命中/总数 |")
    L.append("|---|---|")
    for d in sorted(by_dim):
        h, n = by_dim[d]
        L.append(f"| {d} | {h}/{n} |")
    L.append("")
    L.append("| 难度 | 命中/总数 |")
    L.append("|---|---|")
    for d in sorted(by_diff):
        h, n = by_diff[d]
        L.append(f"| {d} | {h}/{n} |")
    L.append("")
    L.append("## 未命中清单")
    L.append("")
    for r in rows:
        if not r["hit"]:
            L.append(f"- #{r['id']} [{r['dim']}/D{r['diff']}] {r['q']} — {r['miss_type']}")
    out.write_text("\n".join(L), encoding="utf-8")
    print(f"hit@{args.k} = {n_hit}/{total}（{n_hit / total:.0%}）→ {out}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
