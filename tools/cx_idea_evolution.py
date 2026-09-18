# -*- coding: utf-8 -*-
"""思想演化十年曲线：zbzs 公众号(2016-2026) × 飞书观点句 × prompt 流。

三分层时间轴：
- zbzs 文章按年 × 主题（标题关键词分类；A-/A-mirror=本人平台主笔层，
  B 系=生态互动层）
- 飞书 A/A- 观点句按 doc 名 YYMMDD → 月
- prompt 流按 ts → 月（意图先行信号）

产出 SELF_PROFILE/cx_思想演化曲线_<date>.md。
用法：python tools/cx_idea_evolution.py
"""
from __future__ import annotations

import json
import re
from collections import Counter, defaultdict
from datetime import datetime
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
SP = REPO / "SELF_PROFILE"
OUT = SP / f"cx_思想演化曲线_{datetime.now():%Y%m%d}.md"

THEMES: list[tuple[str, tuple[str, ...]]] = [
    ("EPC政策模式", ("工程总承包", "EPC", "总承包", "模式", "政策", "发包", "转型")),
    ("计价造价", ("计价", "造价", "清单", "定额", "审计", "结算", "追索", "工程款", "代位")),
    ("合同风险", ("合同", "风险", "纠纷", "判决", "索赔", "转包", "违法", "合规", "仲裁", "律师")),
    ("海外国际", ("海外", "迪拜", "国际", "一带一路", "涉外", "核电")),
    ("AI数字化", ("AI", "人工智能", "数字化", "智能", "数据", "大模型", "机器人", "智慧")),
    ("生态运营", ("总包之声", "总包说", "社群", "直播", "训练营", "诊断营", "公开课", "智库", "学园", "会员")),
]


def theme_of(text: str) -> str:
    hits = Counter()
    for name, kws in THEMES:
        for kw in kws:
            if kw.lower() in text.lower():
                hits[name] += 1
    return hits.most_common(1)[0][0] if hits else "其他"


def zbzs_layer() -> tuple[dict[str, Counter], dict[str, Counter]]:
    """(全部文章 年→主题, 本人主笔 年→主题)；含 RSS 当年 A-。"""
    all_y: dict[str, Counter] = defaultdict(Counter)
    own_y: dict[str, Counter] = defaultdict(Counter)
    p = SP / "zbzs" / "zbzs_articles.jsonl"
    for ln in open(p, encoding="utf-8"):
        a = json.loads(ln)
        y = a.get("year") or ""
        if not y:
            continue
        t = theme_of(a["title"])
        all_y[y][t] += 1
        if a["verdict"].startswith("A"):
            own_y[y][t] += 1
    for f in sorted((SP / "zbzs" / "articles").glob("rss_*.md")):  # 增量 RSS=当年主笔
        first = f.read_text(encoding="utf-8").splitlines()
        title = next((l.lstrip("# ") for l in first if l.startswith("# ")), f.stem)
        own_y["2026"][theme_of(title)] += 1
        all_y["2026"][theme_of(title)] += 1
    return all_y, own_y


def feishu_layer() -> dict[str, Counter]:
    """A/A- 句 doc 名内嵌日期（240429 / __240221__ / 20240429 形态）→ 月 → 主题。"""
    out: dict[str, Counter] = defaultdict(Counter)
    for ln in open(SP / "feishu" / "opinions.jsonl", encoding="utf-8"):
        o = json.loads(ln)
        if o.get("verdict") not in ("A", "A-"):
            continue
        doc = (o.get("doc") or "") + " " + (o.get("title") or "")
        m = re.search(r"(?<!\d)(?:20)?(\d{2})(0[1-9]|1[0-2])(0[1-9]|[12]\d|3[01])(?!\d)", doc)
        if not m:
            continue
        y, mo = "20" + m.group(1), m.group(2)
        out[f"{y}-{mo}"][theme_of(o["sent"])] += 1
    return out


def prompt_layer() -> dict[str, int]:
    out: Counter = Counter()
    for ln in open(SP / "cc_sessions" / "prompt_stream.jsonl", encoding="utf-8"):
        try:
            p = json.loads(ln)
        except json.JSONDecodeError:
            continue
        ts = p.get("ts")
        if not ts:
            continue
        try:
            d = datetime.fromisoformat(str(ts).replace("Z", "+00:00")).astimezone()
        except ValueError:
            continue
        out[d.strftime("%Y-%m")] += 1
    return dict(out)


def main() -> int:
    all_y, own_y = zbzs_layer()
    fei = feishu_layer()
    pr = prompt_layer()

    L = ["# 思想演化十年曲线（zbzs × 飞书 × prompt 流）", ""]
    L.append(f"> {datetime.now():%Y-%m-%d %H:%M} · tools/cx_idea_evolution.py · "
             "zbzs 文章按年 / 飞书 A 级观点句按月 / prompt 按月")
    L.append("")
    L.append("## 公众号层（zbzs，按年 × 主题）")
    L.append("")
    themes = [t for t, _ in THEMES] + ["其他"]
    L.append("| 年 | " + " | ".join(themes) + " | 本年篇数 |")
    L.append("|---|" + "---:|" * (len(themes) + 1))
    for y in sorted(all_y):
        c = all_y[y]
        L.append(f"| {y} | " + " | ".join(str(c.get(t, 0)) for t in themes)
                 + f" | {sum(c.values())} |")
    L.append("")
    L.append("### 本人主笔层（A-/A-mirror/RSS）")
    L.append("")
    L.append("| 年 | " + " | ".join(themes) + " |")
    L.append("|---|" + "---:|" * len(themes))
    for y in sorted(own_y):
        c = own_y[y]
        L.append(f"| {y} | " + " | ".join(str(c.get(t, 0)) for t in themes) + " |")
    L.append("")
    L.append("## 飞书观点句（A/A-，按月 × 主题）")
    L.append("")
    L.append("| 月 | " + " | ".join(themes) + " | 句数 |")
    L.append("|---|" + "---:|" * (len(themes) + 1))
    for mo in sorted(fei):
        c = fei[mo]
        L.append(f"| {mo} | " + " | ".join(str(c.get(t, 0)) for t in themes)
                 + f" | {sum(c.values())} |")
    L.append("")
    L.append("## prompt 流（意图先行信号，按月）")
    L.append("")
    L.append("| 月 | 条数 |")
    L.append("|---|---:|")
    for mo in sorted(pr):
        L.append(f"| {mo} | {pr[mo]} |")
    OUT.write_text("\n".join(L), encoding="utf-8")
    print(f"思想演化曲线 → {OUT}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
