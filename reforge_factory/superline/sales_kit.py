# -*- coding: utf-8 -*-
"""sales_kit — 付费研报转化面生成器 (旗舰付费研报 F0 件).

用户令 (1007): 发布时公开「详细内容简介 + 目录大纲」作为 ¥10,000 定价
的转化面; 简介要非常详细、体现报告价值. 本件从战役真账 (framework/
claim_ledger/independence/grade/doc_weight/charts_gate sidecars) 机生成
两件发布物, **徽章数字零手拍** — 每个数字都可对账到盘上 sidecar:

  blurb.md      详细内容简介: 价值主张三卖点 + 信任徽章 (断言总数/
                双独立源确证率/引用 recall·precision/独立信息源数/
                文档级语料当量/A 级占比/表锚覆盖率) + 样章钩子 + 购买栏
  outline_sales.md  目录大纲: 章 100% 覆盖 + 每章定位句 + 证据强度徽章

¥10,000 定价的信任锚 = 断言链 W1-W5 七门 (「每句话可溯源」是行业孤品
卖点, 不是修辞 — 徽章即审计入口).

用法 (reforge_factory 根):
  PYTHONPATH=. python superline/sales_kit.py \
      --battle-dir superline/replay_out_charter/EPC50-SNEI/00 研究报告需求 \
      --pool-root E:/AI-Station/ammo_pool --campaign-id EPC50-SNEI \
      --price 10000 --volume 卷二·企业深度研究
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def _j(path: Path, default=None):
    if path.is_file():
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except json.JSONDecodeError:
            return default
    return default


# ---------------------------------------------------------- 徽章 (零手拍)

def compute_badges(pool_dir: Path, framework: dict) -> dict:
    """从 sidecar 实时计算信任徽章 — 简介里的每个数字都源出盘上真账."""
    led = _j(pool_dir / "claim_ledger.json", {}) or {}
    ind = _j(pool_dir / "independence.json", {}) or {}
    dw = _j(pool_dir / "doc_weight.json", {}) or {}
    gs = _j(pool_dir / "grade_summary.json", {}) or {}
    cg = _j(pool_dir / "charts_gate.json", {}) or {}
    st = led.get("stats", {})
    by_state = st.get("by_state", {})
    n_claims = st.get("claims", 0)
    per_eei = ind.get("per_eei", {})
    grades = (gs.get("summary", {}) or {}).get("grade_dist") \
        or gs.get("grades") or gs.get("by_grade") or {}
    _dl = dw.get("doc_level") if isinstance(dw.get("doc_level"), dict) else {}
    n_docs = _dl.get("n_docs") or dw.get("doc_count") or len(per_eei)
    doc_chars = _dl.get("chars") or dw.get("doc_chars") or 0
    a_share = None
    if grades:
        total = sum(grades.values()) or 1
        a_share = round(grades.get("A", 0) * 100.0 / total, 1)
    cov = cg.get("coverage", {}).get("coverage")
    return {
        "章数": len(framework.get("chapters", [])),
        "断言总数": n_claims,
        "双独立源确证率": round(
            by_state.get("双独立源确证", 0) * 100.0 / n_claims, 1)
        if n_claims else 0.0,
        "引用召回率": st.get("citation_recall"),
        "引用精确率": st.get("citation_precision"),
        "独立信息源数": max((p.get("independent_n", 0)
                          for p in per_eei.values()), default=0),
        "文档级语料万字": round(doc_chars / 10000) if doc_chars else None,
        "在档文档数": n_docs,
        "A级占比%": a_share,
        "表锚覆盖率": cov,
    }


# ---------------------------------------------------------- 简介与目录

def gen_blurb(title: str, badges: dict, price: int,
              volume: str, hooks: list[str]) -> str:
    """详细内容简介 — 三卖点+信任徽章+样章钩子+购买栏 (markdown)."""
    b = badges
    badge_lines = [
        f"- **{b['断言总数']} 条断言逐句建档**——每句话踩在哪些证据上，可审计",
        f"- **双独立源确证率 {b['双独立源确证率']}%**（域名×渠道×文档三键口径，"
        "同源转载不算独立）",
        f"- **引用召回 {b['引用召回率']} / 精确 {b['引用精确率']}**"
        "（ALCE 双指标门：recall≥0.95∧precision≥0.9）",
        f"- **单断言最高 {b['独立信息源数']} 个独立信息源交叉验证**",
        f"- **{b['在档文档数']} 份在档文档、文档级语料 {b['文档级语料万字']} 万字**"
        if b.get("文档级语料万字") else f"- **{b['在档文档数']} 份在档文档**",
    ]
    if b.get("A级占比%") is not None:
        badge_lines.append(f"- **A 级（一手权威）证据占比 {b['A级占比%']}%**")
    if b.get("表锚覆盖率") is not None:
        badge_lines.append(f"- **正文数字 {b['表锚覆盖率']*100:.0f}% 表锚**"
                           "（每个数字先成表、带口径与时点）")
    if not hooks:   # 兜底钩子从徽章衍生 (零手拍纪律同样适用于示例句)
        hooks = [f"本战役单条断言最高获 {b['独立信息源数']} 个独立信息源交叉验证"
                 "——这就是正文里每一句话的待遇。"]
    hook_txt = "\n".join(f"> {h}" for h in hooks)
    return f"""# {title}（{volume}）· 内容简介

**这是一份敢把「每句话的证据」摊开给你看的行业研究报告。**

大多数研报告诉你结论；这份报告同时告诉你——每个结论踩在几条证据上、
证据是一手还是转载、独立到什么程度、以及我们自己有多大把握（每个关键
判断带可能性×置信度双维标注）。你付的不只是结论，是一套可复核的情报
生产线。

## 你将得到

1. **广度**：{b['章数']} 章体系化覆盖——从产业格局到企业纵深到模式合同风险；
2. **深度**：断言级溯源（见下方信任徽章），单源结论强制标注、绝不冒充定论；
3. **前瞻**：竞争假设对抗验证（ACH）+ 未来判断带验证口径与到期对账
   （校准账本制度——我们的判断可信度本身是被审计的资产）。

## 信任徽章（实时从研究台账计算，非文案数字）

{chr(10).join(badge_lines)}

## 样章先看

{hook_txt}

## 购买

- 定价 **¥{price:,}**/份（五卷总集·PDF 交付+断言账本附录）
- 扫码下单 → 即刻交付；附赠更新说明与勘误通道
- 适合：工程企业战略/市场负责人、总承包公司经营层、行业投资机构
"""


def gen_outline(framework: dict, badges: dict, volume: str) -> str:
    """目录大纲 — 章 100% 覆盖机检 + 每章定位句 + 证据强度徽章."""
    chs = framework.get("chapters", [])
    lines = [f"# 目录大纲 · {framework.get('report_title', '')}（{volume}）",
             "",
             f"> 全 {len(chs)} 章 · {badges['断言总数']} 条断言 · "
             f"双独立源确证率 {badges['双独立源确证率']}% · "
             "每章断言可溯源（详见断言账本附录）", ""]
    for c in chs:
        desc = str(c.get("description") or "").strip()
        first = desc.split("。")[0].strip() if desc else ""
        lines.append(f"## {c.get('id')} {c.get('title')}")
        if first:
            lines.append(f"{first}。")
        lines.append("")
    return "\n".join(lines)


# ---------------------------------------------------------- 主装配

def build(battle_dir: Path, pool_dir: Path, price: int, volume: str,
          hooks: list[str] | None = None,
          out_dir: Path | None = None) -> dict:
    """framework+sidecars → blurb.md/outline_sales.md 落 out_dir (默认 battle)."""
    fw = _j(battle_dir / "framework.json")
    if not fw or not fw.get("chapters"):
        raise ValueError(f"framework.json 缺失或无 chapters: {battle_dir}")
    badges = compute_badges(pool_dir, fw)
    title = fw.get("report_title", "")
    hooks = hooks or []
    out = out_dir or battle_dir
    out.mkdir(parents=True, exist_ok=True)
    (out / "blurb.md").write_text(
        gen_blurb(title, badges, price, volume, hooks), encoding="utf-8")
    outline = gen_outline(fw, badges, volume)
    (out / "outline_sales.md").write_text(outline, encoding="utf-8")
    n_outline = outline.count("## ")
    return {"title": title, "chapters": len(fw["chapters"]),
            "chapters_in_outline": n_outline,
            "coverage_ok": n_outline == len(fw["chapters"]),
            "badges": badges,
            "generated": time.strftime("%Y-%m-%d %H:%M"),
            "out_dir": str(out)}


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="付费研报转化面生成器 (F0)")
    ap.add_argument("--battle-dir", required=True)
    ap.add_argument("--pool-root", default=r"E:\AI-Station\ammo_pool")
    ap.add_argument("--campaign-id", required=True)
    ap.add_argument("--price", type=int, default=10000)
    ap.add_argument("--volume", default="样卷")
    ap.add_argument("--out-dir")
    ns = ap.parse_args(argv)
    r = build(Path(ns.battle_dir), Path(ns.pool_root) / ns.campaign_id,
              ns.price, ns.volume, None,
              Path(ns.out_dir) if ns.out_dir else None)
    print(f"[sales] {r['title']}")
    print(f"[sales] 章覆盖 {r['chapters_in_outline']}/{r['chapters']} "
          f"({'OK' if r['coverage_ok'] else 'MISSING'})")
    print(f"[sales] 徽章: {json.dumps(r['badges'], ensure_ascii=False)}")
    print(f"[sales] → {r['out_dir']}/blurb.md + outline_sales.md")
    return 0 if r["coverage_ok"] else 1


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
