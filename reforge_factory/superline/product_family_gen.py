# -*- coding: utf-8 -*-
"""product_family_gen — 六层变现面 SKU 骨架生成器 (百倍V3 T-017 / REQ-031).

一份语料 → 一族六层变现面 (BUSINESS_MODEL.md 产品阶梯):
  L0 免费试读 ¥0 | L1 尝鲜判断卡 ¥9.9 | L2 单章 ¥199 | L3 全本 ¥498-698
  L4 企业版 ¥1,999-10,000 | L5 订阅或定制线索 (议价)

地基=sales_kit 徽章零手拍机制 (本件只复用不改动 sales_kit.py):
每个徽章数字都源自 corpus_stats 实数 (T1 字符数/在档条目/EEI 数/独立源数/
章数), 实数自 pool_state.json / question_tree*.json / independence.json /
framework.json 现读 — **读不到的字段标 null, 绝不手拍**; 每个非 null 徽章
随行对账锚 (badge_sources), 机检可回溯.

价档表=BUSINESS_MODEL.md 默认锚, 只作骨架不自动调价 — 调价走
「需求雷达建议 + 实验数据 + 用户批准」三签 (price_note 常驻输出).

用法 (reforge_factory 根):
  py superline/product_family_gen.py --campaign EPC-BID26 \
      [--pool-root E:/AI-Station/ammo_pool] [--battle-dir D] [--out-dir work]
→ out_dir/product_family_<campaign>.json + .md (六层表摘要)
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

import superline as _sl                            # noqa: E402  (版本横幅)

STATION = Path(r"E:\AI-Station")
POOL_ROOT = STATION / "ammo_pool"
DEFAULT_OUT = (STATION / "ResearchFactory-Eng" / "06 迭代优化"
               / "百倍V3_极致调研变现计划" / "work")

# ------------------------------------------------ 价档默认锚 (BUSINESS_MODEL.md)
PRICE_ANCHORS: dict[str, dict] = {
    "L0": {"price": 0, "price_band": "¥0"},
    "L1": {"price": 9.9, "price_band": "¥9.9"},
    "L2": {"price": 199, "price_band": "¥199"},
    "L3": {"price_lo": 498, "price_hi": 698, "price_band": "¥498-698"},
    "L4": {"price_lo": 1999, "price_hi": 10000,
           "price_band": "¥1,999-10,000"},
    "L5": {"price": None, "price_band": "议价",
           "note": "订阅 ¥1,999/年锚；定制 ¥30k-50k 档线索承接"},
}
PRICE_NOTE = ("价档=BUSINESS_MODEL.md 六层默认锚（骨架价，非实售价）；"
              "调价只走「需求雷达建议+实验数据+用户批准」三签，"
              "三签缺一不动价——徽章数字零手拍纪律同样适用于价格。")

# 徽章实数对账锚 (非 null 徽章才挂锚; null=盘上无账, 如实缺)
SOURCE_ANCHORS = {
    "t1_chars": "pool_state.json#total_chars",
    "items": "pool_state.json#items",
    "eei_count": "question_tree*.json#stats.eeis",
    "independent_sources": "independence.json#per_eei[].independent_n(max)",
    "chapters": "framework.json#chapters(len)",
}
BADGE_DISCIPLINE = ("徽章数字全部源自 corpus_stats 实数（T1字符数/在档条目/"
                    "EEI数/独立源数/章数）；读不到=null，绝不手拍。")


def _j(path: Path, default=None):
    if path.is_file():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            return default
    return default


# ------------------------------------------------ corpus_stats 现读 (只读)
def read_corpus_stats(pool_dir: Path,
                      battle_dir: Path | None = None) -> dict:
    """池/战场 sidecar 现读 → corpus_stats (缺账字段 None, 不造假).

    t1_chars  pool_state.json total_chars (T1 字符数)
    items     pool_state.json items (在档条目)
    eei_count question_tree_v2.json → question_tree.json 的 stats.eeis
    independent_sources independence.json per-eei independent_n 最大值
    chapters  battle_dir/framework.json chapters 数
    """
    state = _j(pool_dir / "pool_state.json", {}) or {}
    t1_chars = state.get("total_chars")
    items = state.get("items")
    eei_count = None
    tree = None
    for name in ("question_tree_v2.json", "question_tree.json"):
        tree = _j(pool_dir / name)
        if tree:
            break
    if tree:
        eei_count = (tree.get("stats", {}) or {}).get("eeis")
    ind = _j(pool_dir / "independence.json", {}) or {}
    per = ind.get("per_eei", {}) or {}
    n_ind = None
    if per:
        n_ind = max((p.get("independent_n", 0) for p in per.values()),
                    default=None)
    chapters = None
    if battle_dir:
        fw = _j(Path(battle_dir) / "framework.json", {}) or {}
        if fw.get("chapters") is not None:
            chapters = len(fw["chapters"])
    stats = {"t1_chars": t1_chars, "items": items, "eei_count": eei_count,
             "independent_sources": n_ind, "chapters": chapters}
    stats["sources"] = {k: SOURCE_ANCHORS[k] for k in
                        ("t1_chars", "items", "eei_count",
                         "independent_sources", "chapters")
                        if stats[k] is not None}
    return stats


# ------------------------------------------------ 六层骨架
def _badges(stats: dict, keys: tuple[str, ...]) -> dict:
    wan = round(stats["t1_chars"] / 10000) if stats.get("t1_chars") else None
    vals = {"T1语料万字": wan,
            "在档条目": stats.get("items"),
            "EEI数": stats.get("eei_count"),
            "独立源数": stats.get("independent_sources"),
            "章数": stats.get("chapters")}
    return {k: vals[k] for k in keys}


def _hook(stats: dict, layer: str) -> str:
    """试读钩子 — 数字只来自实数; 缺账如实声明「不标数」."""
    wan = round(stats["t1_chars"] / 10000) if stats.get("t1_chars") else None
    ch, eei = stats.get("chapters"), stats.get("eei_count")
    ind, items = stats.get("independent_sources"), stats.get("items")
    if layer == "L0":
        return (f"样章免费开读：{wan} 万字 T1 语料背书，先看再买" if wan
                else "样章免费开读：T1 语料规模徽章待池账就绪后点亮"
                     "（如实不标数）")
    if layer == "L1":
        return (f"¥9.9 先看预判：问题树 {eei} 条 EEI 逐条可证伪预判" if eei
                else "¥9.9 先看预判：判断卡条数=问题树 EEI 实数"
                     "（树未建，如实不标数）")
    if layer == "L2":
        return (f"只买用得上的章：全 {ch} 章任选单购" if ch
                else "只买用得上的章：任意单章可购"
                     "（章数=框架实数，框架未定如实不标数）")
    if layer == "L3":
        parts = []
        if ch:
            parts.append(f"{ch} 章全本+断言账本附录")
        if ind:
            parts.append(f"单断言最高 {ind} 个独立源交叉验证")
        return "，".join(parts) if parts else \
            "全本+断言账本附录（章数/独立源徽章待账本就绪后点亮，如实不标数）"
    if layer == "L4":
        parts = []
        if items:
            parts.append(f"{items} 份在档文档")
        if wan:
            parts.append(f"{wan} 万字语料")
        return "企业级多席位+更新流：" + " · ".join(parts) if parts else \
            "企业级多席位+更新流（规模徽章待池账就绪后点亮，如实不标数）"
    return (f"报告即线索：基于 {eei} 条 EEI 的定制研究承接"
            f"（报价走需求雷达+实验数据+用户批准）" if eei
            else "报告即线索：定制研究承接方案模板"
                 "（报价走需求雷达+实验数据+用户批准，如实不标数）")


_LAYER_DEFS = [  # (layer, name, format, badge keys)
    ("L0", "免费试读", "样章+数据表前 3 行+判断卡样例（列表资产）",
     ("T1语料万字", "在档条目")),
    ("L1", "尝鲜判断卡", "判断卡 PDF（预判清单，条数=问题树 EEI 实数）",
     ("EEI数", "T1语料万字")),
    ("L2", "单章拆分购", "单章 PDF+该章断言账本摘录",
     ("章数", "T1语料万字")),
    ("L3", "全本专题报告", "全本 PDF+断言账本附录+更新说明",
     ("章数", "EEI数", "独立源数", "T1语料万字")),
    ("L4", "企业版", "多席位授权+更新流+内训版（good-better-best+同价诱饵变体）",
     ("在档条目", "独立源数", "T1语料万字")),
    ("L5", "订阅或定制线索",
     "年度更新流订阅 / 定制研究与内训承接（线索→承接方案）",
     ("EEI数", "独立源数")),
]


def gen(campaign: str, corpus_stats: dict) -> dict:
    """corpus_stats 实数 → 六层 SKU 骨架 {layers:[…6], campaign}.

    每层: layer/name/price(|lo|hi)/price_band/format/sample_hook/badges;
    badges 全部出自 corpus_stats 实数 (缺=null). 纯函数 — 不落盘不突变入参.
    """
    layers = []
    for layer, name, fmt, bkeys in _LAYER_DEFS:
        row = {"layer": layer, "name": name,
               "price_band": PRICE_ANCHORS[layer]["price_band"],
               "format": fmt,
               "sample_hook": _hook(corpus_stats, layer),
               "badges": _badges(corpus_stats, bkeys)}
        for k in ("price", "price_lo", "price_hi", "note"):
            if k in PRICE_ANCHORS[layer]:
                row[k] = PRICE_ANCHORS[layer][k]
        layers.append(row)
    cs = {k: corpus_stats.get(k) for k in
          ("t1_chars", "items", "eei_count", "independent_sources",
           "chapters")}
    return {"campaign": campaign,
            "generated": time.strftime("%Y-%m-%d %H:%M"),
            "layers": layers,
            "tiers": layers,          # 兼容键 (taskgraph T-017 verify 口径)
            "price_anchors": PRICE_ANCHORS,
            "price_note": PRICE_NOTE,
            "corpus_stats": cs,
            "badge_sources": corpus_stats.get("sources", {}),
            "badge_discipline": BADGE_DISCIPLINE}


def render_md(doc: dict) -> str:
    """六层表 md 摘要 — 徽章列实数/null 如实."""
    head = [f"# 产品族六层变现面 · {doc['campaign']}", "",
            f"> 生成 {doc['generated']} · {doc['badge_discipline']}", "",
            "| 层 | 名称 | 价格 | 形态 | 徽章（实数） | 试读钩子 |",
            "|---|---|---|---|---|---|"]
    for L in doc["layers"]:
        badges = " · ".join(
            f"{k}={v}" if v is not None else f"{k}=null"
            for k, v in L["badges"].items())
        head.append(f"| {L['layer']} | {L['name']} | {L['price_band']} "
                    f"| {L['format']} | {badges} | {L['sample_hook']} |")
    src = doc.get("badge_sources") or {}
    src_lines = [f"- {f} ← {a}" for f, a in src.items()] or \
        ["- （本次无实数徽章对账锚：相关 sidecar 缺席，徽章 null 如是）"]
    head += ["", f"**价档说明**：{doc['price_note']}", "",
             "**徽章对账锚**（非 null 字段）：", *src_lines]
    return "\n".join(head) + "\n"


def write(doc: dict, out_dir: Path) -> tuple[Path, Path]:
    """落盘 product_family_<campaign>.json + .md (只增; 返回两路径)."""
    out = Path(out_dir)
    out.mkdir(parents=True, exist_ok=True)
    pj = out / f"product_family_{doc['campaign']}.json"
    pm = out / f"product_family_{doc['campaign']}.md"
    pj.write_text(json.dumps(doc, ensure_ascii=False, indent=1),
                  encoding="utf-8")
    pm.write_text(render_md(doc), encoding="utf-8")
    return pj, pm


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(
        description="六层变现面 SKU 骨架生成器 (T-017/REQ-031)")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--battle-dir",
                    help="含 framework.json 的战场目录 (缺=章数徽章 null)")
    ap.add_argument("--out-dir", default=str(DEFAULT_OUT))
    ns = ap.parse_args(argv)
    print(f"[pf-gen] superline v{_sl.__version__}")
    stats = read_corpus_stats(Path(ns.pool_root) / ns.campaign,
                              Path(ns.battle_dir) if ns.battle_dir else None)
    doc = gen(ns.campaign, stats)
    pj, pm = write(doc, Path(ns.out_dir))
    print(f"[pf-gen] {ns.campaign} corpus_stats: "
          f"{json.dumps({k: v for k, v in stats.items() if k != 'sources'}, ensure_ascii=False)}")
    for L in doc["layers"]:
        b = " · ".join(f"{k}={'null' if v is None else v}"
                      for k, v in L["badges"].items())
        print(f"[pf-gen] {L['layer']} {L['name']} {L['price_band']:>12} | {b}")
    print(f"[pf-gen] → {pj} + {pm}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
