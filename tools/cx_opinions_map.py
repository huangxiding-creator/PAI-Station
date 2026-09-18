# -*- coding: utf-8 -*-
"""总包之声观点池 jsonl → OPINIONS_MAP.md（卷宗检索域的 md 版）。

zbzs_opinions.jsonl 是观点维主源之一，但 jsonl 不在 dossier glob
（*.md）里——50 句池进不了检索域（2026-09-18 金标准 #73 即此缺口）。
本工具做格式转换入卷宗；节标题带事实（层数/主笔/句数），标题 3 倍
加成让"观点语料密度"类问题直接路由进层。
用法：python tools/cx_opinions_map.py
排程：随 PAIStation-fusion-refresh 每日 00:10 链跑（jsonl 随 zbzs 周采增长）
"""
from __future__ import annotations

import json
from collections import Counter
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
SRC = REPO / "SELF_PROFILE" / "zbzs" / "zbzs_opinions.jsonl"
OUT = REPO / "SELF_PROFILE" / "zbzs" / "OPINIONS_MAP.md"

_LAYERS = [
    ("A-", "A- 层（总包之声主笔，{n} 句）"),
    ("B-mix", "B-mix 层（约稿/转载掺杂，{n} 句）"),
]


def build_map(rows: list[dict]) -> str:
    """jsonl 行 → markdown 文本。纯函数，测试覆盖。"""
    cnt = Counter(r["verdict"] for r in rows)
    L = ["# 总包之声观点池", "",
         f"> {datetime.now():%Y-%m-%d} 从 zbzs_opinions.jsonl 生成 · "
         f"{len(rows)} 句 · " + " ".join(f"{k} {v}" for k, v in cnt.most_common())
         + " · 判定口径见 ZBZhISHENG_SOURCE.md", "",
         "观点维度主源之一：总包之声为用户主笔运营的公众号，A 级观点语料"
         f"密度之王即此池（{cnt['A-']} 句 A-，超过 refly 用户访谈 18 句）。"
         "B-mix 层为约稿/转载掺杂。句子原样保留（答案词面即在此）。", ""]
    for verdict, header_tpl in _LAYERS:
        vr = [r for r in rows if r["verdict"] == verdict]
        if not vr:
            continue
        L.append("## " + header_tpl.format(n=len(vr)))
        L.append("")
        for r in vr:
            sent = r["sent"].replace("\n", " ")
            src = r.get("title") or r["doc"]
            L.append(f"- 【{src[:32]}】{sent}")
        L.append("")
    return "\n".join(L)


def main() -> int:
    rows = [json.loads(ln) for ln in open(SRC, encoding="utf-8")]
    if not rows:
        print(f"空池，跳过（{SRC}）")
        return 0
    OUT.write_text(build_map(rows), encoding="utf-8")
    print(f"观点地图 → {OUT}（{len(rows)} 句）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
