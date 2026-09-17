"""飞书 530 万字语料 → 观点句抽取（规则法第一遍）。

立场判断：第一人称立场/强判断标记 > 处方式措辞——语料混有收藏性
材料（档案库/文件库/政策汇编），观点句要的是「总包君的想法」而非
转述常识。产出 opinions.jsonl（逐句+溯源）+ OPINIONS.md（统计+
高分样例人评）。第二遍（LLM 精炼 claim ledger）待规则池跑通另排。

输出落 SELF_PROFILE/（不入 git）；本脚本可入 git 复跑。
"""
from __future__ import annotations

import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(r"E:\AI-Station\SELF_PROFILE\feishu")
DOCS = ROOT / "raw" / "docs"
OUT_JSONL = ROOT / "opinions.jsonl"
OUT_MD = ROOT / "OPINIONS.md"

# 标记（权重）：第一人称立场 3 > 强判断/价值排序 2 > 处方式/因果 1
MARKERS = [
    (3, re.compile(r"我认为|我觉得|依我看|在我看来|我敢说|我断定|"
                   r"我的判断|我的看法|我主张|我坚持认为|我始终认为")),
    (3, re.compile(r"我们公司|我方提出|我们团队决定|总包说(?!公司)")),
    (2, re.compile(r"本质上|本质是|关键在于|核心问题是|根本问题|"
                   r"归根结底|说白了|真相是|底层逻辑|要害在于")),
    (2, re.compile(r"最.{1,10}的是|比.{1,12}更重要|首要任务|第一位的|"
                   r"优先级最高")),
    (1, re.compile(r"应该|必须|切忌|一定要|千万别|务必|最好是")),
    (1, re.compile(r"所以说|这说明|这意味着|可见|显然|事实上|实际上|"
                   r"恰恰|反而|未必")),
]
THRESHOLD = 2  # 首人称(3)/强判断(2) 单类即过；处方式需叠加
TEMPLATE_MIN = 5  # 同头 8 字达此数=套话家族
# 收藏类文档特征（逐字稿/回放转写时间戳/档案汇编）——句子的"我认为"
# 是讲者的不是总包君的；本人思想与思想饮食分开统计
COLLECTED = re.compile(r"逐字稿|大咖谈|档案库|文件库|政策|直播|"
                       r"\d{4}-\d{2}-\d{2} \d{2}_\d{2}|读书|笔记|讲座|分享会|混沌")

SENT_SPLIT = re.compile(r"[。！？!?；\n]+")
SKIP_LINE = re.compile(r"^(#|\||-|\d+[\.、）)]|[（(]?\d{1,3}[）)]?)")


def find_text(obj, depth: int = 0) -> str:
    """递归找长正文字段（回包结构 data→document→…→text）。"""
    if depth > 5:
        return ""
    if isinstance(obj, str):
        return obj if len(obj) > 300 else ""
    if isinstance(obj, dict):
        for v in obj.values():
            r = find_text(v, depth + 1)
            if r:
                return r
    if isinstance(obj, list):
        for v in obj[:30]:
            r = find_text(v, depth + 1)
            if r:
                return r
    return ""


def sentences(text: str):
    for ln in text.splitlines():
        ln = ln.strip()
        if not ln or SKIP_LINE.match(ln):  # 跳标题/表格/列表编号
            continue
        for s in SENT_SPLIT.split(ln):
            s = s.strip(" ，,、；;：:·—-")
            if 15 <= len(s) <= 150:
                yield s


def score_sent(s: str):
    pts, hits = 0, []
    for w, pat in MARKERS:
        m = pat.search(s)
        if m:
            pts += w
            hits.append(m.group())
    return pts, hits


def main() -> int:
    if not DOCS.exists():
        print(f"[缺] {DOCS}")
        return 1
    rows = []
    total_sents = 0
    for p in sorted(DOCS.glob("*.json")):
        try:
            d = json.loads(p.read_text(encoding="utf-8"))
        except Exception:
            continue
        title = d.get("_title") or p.stem
        text = find_text(d.get("data") or {})
        if not text:
            continue
        src = "collected" if COLLECTED.search(title) else "self"
        for s in sentences(text):
            total_sents += 1
            pts, hits = score_sent(s)
            if pts >= THRESHOLD:
                rows.append({"doc": p.name, "title": title, "sent": s,
                             "score": pts, "hits": hits, "source": src})
    seen: set[str] = set()
    # 模板家族过滤：同头 8 字 ≥5 句=AI 生成套话（"记住，X，关键在于Y"
    # 家族实测几十条同款），整族丢弃——真观点不会五连相同开头
    fam = Counter(e["sent"][:8] for e in rows)
    templated = sum(n for n in fam.values() if n >= TEMPLATE_MIN)
    uniq = []
    for e in rows:
        if fam[e["sent"][:8]] >= TEMPLATE_MIN:
            continue
        if e["sent"] not in seen:
            seen.add(e["sent"])
            uniq.append(e)

    with OUT_JSONL.open("w", encoding="utf-8") as fh:
        for e in uniq:
            fh.write(json.dumps(e, ensure_ascii=False) + "\n")

    marker_freq = Counter(h for e in uniq for h in e["hits"])
    by_doc = Counter(e["title"] for e in uniq)
    self_rows = [e for e in uniq if e["source"] == "self"]
    coll_rows = [e for e in uniq if e["source"] == "collected"]

    def _top(es, n=50):
        return sorted(es, key=lambda e: -e["score"])[:n]

    lines = [
        f"# 观点句池（规则法第一遍）",
        "",
        f"- 语料：{len(list(DOCS.glob('*.json')))} 篇 / 候选句 {total_sents:,}"
        f" / 入池 **{len(uniq):,}**（本人 {len(self_rows)} + 收藏 {len(coll_rows)}；"
        f"去重+套话家族过滤，阈值≥{THRESHOLD} 分，套话族丢 {templated:,} 句）",
        f"- 生成：opinions.jsonl（逐句+溯源+来源标签）；本文件=统计+高分样例",
        "",
        "## 标记命中频次（Top 15）",
        "",
    ]
    for h, n in marker_freq.most_common(15):
        lines.append(f"- {h} ×{n}")
    lines += ["", "## 观点最密文档（Top 15）", ""]
    for t, n in by_doc.most_common(15):
        lines.append(f"- {n} 句 · {t[:48]}")
    lines += ["", f"## 本人原声高分样例（Top 50）", ""]
    for e in _top(self_rows):
        lines.append(f"- [{e['score']}] {e['sent']}（{e['title'][:24]}）")
    lines += ["", f"## 收藏材料高分样例（Top 30，思想饮食）", ""]
    for e in _top(coll_rows, 30):
        lines.append(f"- [{e['score']}] {e['sent']}（{e['title'][:24]}）")
    OUT_MD.write_text("\n".join(lines), encoding="utf-8")

    print(f"候选句 {total_sents:,} → 入池 {len(uniq):,}"
          f"（本人 {len(self_rows)} / 收藏 {len(coll_rows)}，套话丢 {templated:,}）")
    print(f"[写] {OUT_JSONL}")
    print(f"[写] {OUT_MD}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
