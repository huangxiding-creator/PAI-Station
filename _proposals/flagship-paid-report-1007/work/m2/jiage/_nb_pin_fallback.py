# -*- coding: utf-8 -*-
"""_nb_pin_fallback — 薄命中章钉选兜底 + 全章 NB 初稿实测量 (1026 NB初稿铁律强化令).

铁律口径: ch6 控制价(命中13)/ch7 综合单价(19)/ch5 信息价(20)/ch2 政策(21) 为薄命中,
从 NB 123 篇全量清单人工钉选招投标/清单/计价/政策类篇目 (即便弱相关亦钉入作体裁骨架),
追加进对应 _chNN_nb_draft.md 尾部, 标注「钉选兜底」; 理由含头部词频实证 (_nb_pin_probe.py)。
随后实测 12 章: 篇数 / 原文 CJK 合计 → sched/_nb_draft_stats.json。
幂等: 已含钉选兜底区的章不重复追加。用法: py -X utf8 _nb_pin_fallback.py
"""
from __future__ import annotations

import json
import re
import sys
from datetime import datetime
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
NB = Path(r"E:\AI-Station\ResearchFactory-Eng\NB_MD_library_v2")
VOLS = ["90_研究报告成果合集_vol001.md", "90_研究报告成果合集_vol002.md",
        "90_研究报告成果合集_vol003.md", "91_法规共性资料_vol001.md"]
BLOCK_HEAD = "\n\n---\n\n# "
MIN_CHARS = 2000
MARKER = "<!-- ======== 钉选兜底区"
CJK = re.compile(r"[\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]")

# 钉选清单 (match=清单norm精确或唯一包含; reason 含 _nb_pin_probe.py 头部8000字词频实证)
PINS: dict[str, list[dict]] = {
    "ch02": [
        {"match": "建工司法解释演进与新旧条文对照",
         "reason": "法规演进×新旧条文对照体裁; 头部'招标'×7'条文'×13 — 政策法规演进全景骨架"},
        {"match": "2026年建工解释二 法释2026 12号 核心条文框架与制度要点",
         "reason": "最新法释制度要点框架; '招标'×8'中标'×5 — 新政条文框架体裁"},
        {"match": "最高法发布《关于审理建设工程施工合同纠纷案件适用法律问题的解释（二）》",
         "reason": "政策发布通稿; '招标'×8'计价'×3'结算'×5 — 政策发布口径骨架"},
        {"match": "最高法民一庭庭长陈宜芳就《关于审理建设工程施工合同纠纷案件适用法律问题的解释（二）》答记者问",
         "reason": "权威政策解读问答体裁(13,231字) — 政策章权威解读骨架"},
        {"match": "各地法院建工纠纷裁判指引汇编",
         "reason": "地方法规/裁判指引汇编体裁; '裁判'×15 — 政策全景地域维度骨架"},
        {"match": "知识库总览与学习指南",
         "reason": "体系总览体裁; '法规'×8 — 定额体系'全景'总览骨架"},
    ],
    "ch05": [
        {"match": "第5章 采购与核电设备供应链",
         "reason": "'采购'×52'材料'×8 — 材料/设备价格来源链骨架(信息价的采购价源头)"},
        {"match": "第11章 多项目标杆矩阵与方法论",
         "reason": "方法论矩阵体裁; '市场价'×1'指数'×1'方法'×12 — 基准方法论骨架"},
        {"match": "第6章 商务防线与EVM挣值硬约束",
         "reason": "'价'×42'预算'×8 — 价格/费用指标管控体裁(价差与指数管控骨架)"},
        {"match": "渠道调研成果报告",
         "reason": "'调研'×11'价'×9 — 调研数据报告体裁(信息价采集调研骨架)"},
    ],
    "ch06": [
        {"match": "建设工程“黑白合同”效力认定规则研究",
         "reason": "黑白合同系列效力认定规则集大成篇(58,377字), 与top8四篇同族互补 — 招投标中标效力主线骨架"},
        {"match": "建工司法解释演进与新旧条文对照",
         "reason": "'招标'×7'条文'×13 — 招投标条文演进骨架"},
        {"match": "2026年建工解释二 法释2026 12号 核心条文框架与制度要点",
         "reason": "'招标'×8'中标'×5'结算'×3 — 中标合同计价结算条文框架"},
        {"match": "关联法律法规体系",
         "reason": "'招标投标法'×3'计价'×2'清单'×2 — 招投标法规索引骨架"},
        {"match": "第6章 商务防线与EVM挣值硬约束",
         "reason": "'价'×42'单价'×2'预算'×8 — 投标报价测算费用硬约束体裁"},
        {"match": "第9章 合同商务与风险管控",
         "reason": "'清单'×7'单价'×2 — 合同商务报价体裁"},
    ],
    "ch07": [
        {"match": "第9章 合同商务与风险管控",
         "reason": "'清单'×7'单价'×2 — 清单单价商务体裁"},
        {"match": "第8章 四控 进度·费用·质量·安全",
         "reason": "'措施'×7'费用'×16'单价'×3 — 措施项目费骨架"},
        {"match": "避坑清单",
         "reason": "'清单'×4'单价'×1'费用'×4 — 实战避坑清单体裁"},
        {"match": "第6章 商务防线与EVM挣值硬约束",
         "reason": "'单价'×2'预算'×8 — 综合单价组价测算骨架"},
        {"match": "正文 14章",
         "reason": "'清单'×3'单价'×1 — 全书正文结构骨架"},
        {"match": "完整报告",
         "reason": "'清单'×2'费用'×2 — 报告整体体裁骨架"},
    ],
}


def norm_title(s: str) -> str:
    s = re.sub(r"^《[^》]*》\s*/\s*", "", s.strip())
    s = re.sub(r"_(citefixed|conf)(?=\.md$|$)", "", s)
    s = re.sub(r"\s*\[目标字数[^\]]*\]", "", s)
    s = re.sub(r"\.md$", "", s)
    s = s.replace("_", " ").replace("　", " ")
    s = re.sub(r"\s+", " ", s)
    return s.strip()[:60]


def load_pieces() -> dict[str, tuple[str, str, int]]:
    segs: dict[str, tuple[str, str, int]] = {}
    for vol in VOLS:
        fp = NB / vol
        if not fp.is_file():
            continue
        for seg in fp.read_text(encoding="utf-8", errors="replace").split(BLOCK_HEAD)[1:]:
            nl = seg.find("\n", 1)
            title = seg[:nl].strip() if nl > 0 else seg.strip()[:80]
            if len(seg) < MIN_CHARS:
                continue
            base = norm_title(title)
            text = BLOCK_HEAD + seg
            if base not in segs or len(text) > segs[base][2]:
                segs[base] = (vol, text, len(text))
    return segs


def resolve(norms: list[str], key: str) -> str:
    if key in norms:
        return key
    cand = [n for n in norms if key in n]
    if len(cand) == 1:
        return cand[0]
    raise SystemExit(f"[pin] 解析失败: {key!r} → {len(cand)} 候选 {cand}")


def cjk_count(t: str) -> int:
    return len(CJK.findall(t))


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    pieces = load_pieces()
    norms = list(pieces)
    chapters = json.loads((M2 / "chapters.json").read_text(encoding="utf-8"))
    meta = {f"ch{c['no']:02d}": c for c in chapters}

    # ── 1. 钉选兜底追加 (幂等) ──
    pin_log = {}
    for chkey, pins in PINS.items():
        fp = M2 / f"_{chkey}_nb_draft.md"
        doc = fp.read_text(encoding="utf-8")
        if MARKER in doc:
            pin_log[chkey] = {"appended": 0, "note": "已含钉选兜底区, 跳过(幂等)"}
            continue
        no = int(chkey[2:])
        header = (f"\n\n{MARKER} (1026 NB初稿铁律强化令: 薄命中章钉选兜底) ========\n"
                  f"第{no}章 NB 检索命中 {len(pins)} 处薄命中, 以下 PIN 篇为人工钉选: NB 123 篇全量\n"
                  f"清单中招投标/清单/计价/政策类篇目, 即便弱相关亦钉入作体裁骨架;\n"
                  f"钉选清单与理由 (含头部词频实证) 见 _nb_draft_stats.json。\n"
                  f"=============================================== -->\n")
        # 命中数从文件头行读实测值
        m = re.search(r"NB命中 (\d+) 篇", doc)
        hits = m.group(1) if m else "?"
        header = header.replace(f"命中 {len(pins)} 处薄命中", f"命中 {hits} 篇 (薄命中)")
        parts = [header]
        resolved = []
        for i, p in enumerate(pins, 1):
            nk = resolve(norms, p["match"])
            vol, text, n = pieces[nk]
            parts.append(f"\n## PIN-{i} 「钉选兜底」 [{vol} | {n:,}字]")
            parts.append(f"源章: {nk[:80]}")
            parts.append(f"钉选理由: {p['reason']}")
            parts.append("")
            parts.append(text[:24000])
            parts.append("")
            resolved.append({"pin": f"PIN-{i}", "title": nk, "vol": vol,
                             "chars_full": n, "reason": p["reason"]})
        fp.write_text(doc + "\n".join(parts), encoding="utf-8")
        pin_log[chkey] = {"appended": len(resolved), "pins": resolved,
                          "nb_hits": int(hits) if hits != "?" else None}
        print(f"[pin] {chkey} 追加钉选 {len(resolved)} 篇 (NB命中{hits})")

    # ── 2. 12 章实测量 ──
    stats = {}
    for c in chapters:
        chkey = f"ch{c['no']:02d}"
        doc = (M2 / f"_{chkey}_nb_draft.md").read_text(encoding="utf-8")
        m = re.search(r"NB命中 (\d+) 篇", doc)
        nb_blocks = re.findall(r"^## (NB-\d) .*\n源章: (.*)$", doc, re.M)
        pin_blocks = re.findall(r"^## (PIN-\d) 「钉选兜底」 \[(\S+?) \| ([\d,]+)字\]\n源章: (.*)$", doc, re.M)
        # 分块 CJK 实测
        blk_re = re.compile(r"^## ((?:NB|PIN)-\d) .*$", re.M)
        heads = [(m2.group(1), m2.start()) for m2 in blk_re.finditer(doc)]
        cjk_nb = cjk_pin = 0
        for k, (tag, pos) in enumerate(heads):
            end = heads[k + 1][1] if k + 1 < len(heads) else len(doc)
            body = doc[pos:end]
            if tag.startswith("NB"):
                cjk_nb += cjk_count(body)
            else:
                cjk_pin += cjk_count(body)
        stats[chkey] = {
            "title": c["title"], "nb_hits": int(m.group(1)) if m else None,
            "nb_pieces": len(nb_blocks), "pin_pieces": len(pin_blocks),
            "pins": pin_log.get(chkey, {}).get("pins", []),
            "cjk": {"nb_blocks": cjk_nb, "pin_blocks": cjk_pin,
                    "file_total": cjk_count(doc)},
            "src_titles": [t[:60] for _, t in nb_blocks],
        }
        print(f"[stat] {chkey} NB{len(nb_blocks)} PIN{len(pin_blocks)} "
              f"CJK(nb={cjk_nb:,} pin={cjk_pin:,} 全文件={cjk_count(doc):,})")

    dedupe = json.loads((M2 / "_nb_dedupe_log.json").read_text(encoding="utf-8"))
    out = {
        "when": datetime.now().isoformat(timespec="seconds"),
        "cmd": "py -X utf8 sched_nb_draft.py --top 8 (+ _nb_pin_fallback.py 钉选兜底)",
        "nb_pool": {"segments_cut": 296, "unique_pieces": 123, "text_cap_per_piece": 24000},
        "bank_dedupe": {
            "summary": "top3→top8 重跑使 bank_chNN.md 的 P{ch}0051-53 各双份; 已删旧留新, "
                       "12 库 NB 块均=8 且锚唯一; 旧/新内容一致(11库md5直证+ch04 P000353尾随换行差异重构实证)",
            "ch04_collision": "新 NB4-6 公式锚 P000354-356 撞第4章写作期补录区锚, 已重编号 P000359-361, 补录区未动一字",
            "ch02_submitted_refs_safe": "_ch02_p1.md 引用 P000151/P000152 仍解析到同一内容",
            "detail_log": "sched/_nb_dedupe_log.json"},
        "pin_fallback": {
            "rule": "薄命中章(ch6=13/ch7=19/ch5=20/ch2=21)人工钉选, 即便弱相关亦钉入作体裁骨架",
            "pin_totals": {k: v.get("appended", 0) for k, v in pin_log.items()}},
        "chapters": stats,
        "totals": {
            "nb_pieces": sum(s["nb_pieces"] for s in stats.values()),
            "pin_pieces": sum(s["pin_pieces"] for s in stats.values()),
            "cjk_nb_blocks": sum(s["cjk"]["nb_blocks"] for s in stats.values()),
            "cjk_pin_blocks": sum(s["cjk"]["pin_blocks"] for s in stats.values()),
            "cjk_file_total": sum(s["cjk"]["file_total"] for s in stats.values())},
    }
    (M2 / "_nb_draft_stats.json").write_text(
        json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[stat] 12章合计 NB{out['totals']['nb_pieces']}篇 "
          f"PIN{out['totals']['pin_pieces']}篇 "
          f"CJK {out['totals']['cjk_file_total']:,} → sched/_nb_draft_stats.json")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
