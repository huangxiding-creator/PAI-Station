# -*- coding: utf-8 -*-
"""观点池 jsonl → OPINIONS_MAP.md（卷宗检索域的 md 版）。

两个池都卡在 jsonl 层进不了 dossier glob（*.md）：
- zbzs_opinions.jsonl（总包之声 50 句）
- feishu/opinions.jsonl（1184 句，其中 A/A- 79 句真思想资产——判定书
  只有矿脉图分布表，句子原文从未进 md 检索域）

本工具做格式转换入卷宗；节标题带事实（层名/句数），标题 3 倍加成让
"观点语料密度/我的观点"类问题直接路由进层。句子原样保留。
用法：python tools/cx_opinions_map.py
排程：随 PAIStation-fusion-refresh 每日 00:10 链跑（jsonl 随周采增长）
"""
from __future__ import annotations

import json
from collections import Counter
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
ZBZS_SRC = REPO / "SELF_PROFILE" / "zbzs" / "zbzs_opinions.jsonl"
ZBZS_OUT = REPO / "SELF_PROFILE" / "zbzs" / "OPINIONS_MAP.md"
FEISHU_SRC = REPO / "SELF_PROFILE" / "feishu" / "opinions.jsonl"
FEISHU_OUT = REPO / "SELF_PROFILE" / "feishu" / "OPINIONS_MAP.md"

ZBZS_LAYERS = [
    ("A-", "A- 层（总包之声主笔，{n} 句）"),
    ("B-mix", "B-mix 层（约稿/转载掺杂，{n} 句）"),
]
FEISHU_LAYERS = [
    ("A", "A 层（本人原声：访谈/复盘/方案第一人称，{n} 句）"),
    ("A-", "A- 层（本人文档项目观点：AI 辅助产出、本人采纳立场，{n} 句）"),
    ("B+", "B+ 层（外宣宣言，{n} 句）"),
]


def _bullets(rows: list[dict]) -> list[str]:
    out = []
    for r in rows:
        sent = r["sent"].replace("\n", " ")
        src = r.get("title") or r["doc"]
        out.append(f"- 【{src[:32]}】{sent}")
    return out


def build_map(rows: list[dict], title: str, layers: list[tuple[str, str]],
              note: str) -> str:
    """jsonl 行 → markdown。纯函数，测试覆盖。"""
    cnt = Counter(r["verdict"] for r in rows)
    L = [f"# {title}", "",
         f"> {datetime.now():%Y-%m-%d} 生成 · {len(rows)} 句 · "
         + " ".join(f"{k} {v}" for k, v in cnt.most_common()), "",
         note, ""]
    for verdict, header_tpl in layers:
        vr = [r for r in rows if r["verdict"] == verdict]
        if not vr:
            continue
        L.append("## " + header_tpl.format(n=len(vr)))
        L.append("")
        L.extend(_bullets(vr))
        L.append("")
    return "\n".join(L)


def build_zbzs(rows: list[dict]) -> str:
    n_a = sum(1 for r in rows if r["verdict"] == "A-")
    return build_map(
        rows, "总包之声观点池", ZBZS_LAYERS,
        "观点维度主源之一：总包之声为用户主笔运营的公众号，A 级观点语料"
        f"密度之王即此池（{n_a} 句 A-，超过 refly 用户访谈 18 句）。"
        "B-mix 层为约稿/转载掺杂。判定口径见 ZBZhISHENG_SOURCE.md。")

def build_feishu(rows: list[dict]) -> str:
    """feishu 池按源切小节（整层大节实测吸流：66→64，#14/#21 被挤）。

    矿脉图本就按源分布（refly 访谈/Manus 全家/知识炼金……），节=源，
    节头=真标题（区分度高，3 倍加成落在窄信号上）。同 corpus 实测为准。
    """
    n_a = sum(1 for r in rows if r["verdict"] == "A")
    n_am = sum(1 for r in rows if r["verdict"] == "A-")
    kept = [r for r in rows if r["verdict"] in ("A", "A-", "B+")]
    label = dict(FEISHU_LAYERS)
    L = ["# 飞书观点池（A/B+ 判定层，按源分节）", "",
         f"> {datetime.now():%Y-%m-%d} 生成 · {len(rows)} 句 · "
         f"真思想资产 {n_a + n_am} 句（A {n_a} + A- {n_am}；判定法见 "
         "OPINIONS_VERDICT.md；collected 877 句/C 嘉宾 108 句不入图）", "",
         "观点维度第一主源。矿脉分布：refly 用户访谈 18 句（工具观/付费"
         "观，A 级密度之王 refly 访谈 18 句）、总包 Manus 全家 18 句（AI "
         "管理论）、知识炼金工厂 11 句、总包大脑实战方案 9+ 句。", ""]
    buckets: dict[tuple[str, str], list[dict]] = {}
    for r in kept:
        key = (r["verdict"], (r.get("title") or r["doc"])[:24])
        buckets.setdefault(key, []).append(r)
    for (verdict, src), vr in sorted(buckets.items(),
                                     key=lambda kv: (kv[0][0] != "A", -len(kv[1]))):
        L.append(f"## {label[verdict].split('（')[0]}·{src}（{len(vr)} 句）")
        L.append("")
        L.extend(_bullets(vr))
        L.append("")
    return "\n".join(L)


def _emit(src: Path, out: Path, builder) -> None:
    if not src.exists():
        print(f"缺 {src}，跳过")
        return
    rows = [json.loads(ln) for ln in open(src, encoding="utf-8")]
    if not rows:
        print(f"空池，跳过（{src}）")
        return
    out.write_text(builder(rows), encoding="utf-8")
    print(f"观点地图 → {out}（{len(rows)} 句）")


def main() -> int:
    _emit(ZBZS_SRC, ZBZS_OUT, build_zbzs)
    _emit(FEISHU_SRC, FEISHU_OUT, build_feishu)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
