# -*- coding: utf-8 -*-
"""S1-1 框架生成器 v1 (超级生产线) — 报告框架即路由表.

输入 = S0 charter (批准件: tiers + family + 体量) + 存量先验摘要 (可选) +
侦察段 (可选, S1-2 接真腿); 输出 = framework.json (章 title/description/
tier 词表映射/渠道组合/证据密度/budget_band 五字段 — contracts 契约).

四框架族双轨:
  enterprise → EPC 域十维度模板 (企业基本面…市场与对标)
  industry/topic/policy → 通用骨架族 (是什么-为什么-怎么办 适配)

双参数: 体量参数 (charter.volume 章×节 → 目标章数) + 密度参数
  (侦察命中 → evidence_density 升档; 无侦察据只准 low — 禁凭空预估).

模型分档: 默认免费档; high 密度/gap 章切 reasoning (fw.model_band 记录).

纪律:
- v1 纯规则确定性 (同输入同输出, 章数零波动) — LLM 路不在本件.
- 批准前 S1 不动工: 只吃 charter_accepted.json (S0-3 门真接线).
- 坏输入硬拒 (ValueError) — 回炉/降级环在 S1-3, 本件不兜底.

用法:
  python superline/framework_gen.py --battle-dir D [--scout scout.json]
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

import superline as _sl
from superline import charter_gate as CG
from superline import contracts as C

# ---------- EPC 域十维度模板 (epc-deep-research topic_dimensions 同源) ----------
EPC_TEN_DIMS = [
    ("企业基本面", "企业沿革、资质、规模与财务底盘"),
    ("EPC战略定位", "总承包战略取舍、业务组合与转型路径"),
    ("组织与人才", "组织架构、项目经理体系与人才梯队"),
    ("项目管理体系", "PMO、进度/成本/质量体系与数字化工具"),
    ("设计管理", "设计牵头模式、设计采购施工一体化接口"),
    ("采购与供应链", "集采体系、供应商分级与长周期设备管理"),
    ("施工管理", "施工组织、分包管理与现场执行力"),
    ("风险管控", "合同风险、履约风险与安全环保体系"),
    ("技术创新", "核心技术、专利与研发转化"),
    ("市场与对标", "市场格局、竞对打法与对标差距"),
]

# ---------- 通用骨架族 (是什么-为什么-怎么办 适配三族) ----------
SKELETONS = {
    "industry": [("行业全景", "行业是什么: 规模、格局与价值链"),
                 ("驱动逻辑", "行业为什么变: 政策/技术/需求三力"),
                 ("竞争格局", "谁在赢: 集中度与头部打法"),
                 ("商业模式", "怎么赚钱: 盈利模式与成本结构"),
                 ("风险与周期", "什么会杀死它: 周期与风险清单"),
                 ("趋势与对策", "怎么办: 趋势研判与行动清单")],
    "topic": [("概念界定", "主题是什么: 定义、边界与事实底盘"),
              ("现状扫描", "现在到哪了: 数据与典型事实"),
              ("机理拆解", "为什么这样: 因果链与关键变量"),
              ("反方论据", "对立面: 质疑、反例与失败案例"),
              ("对策框架", "怎么办: 分层对策与落地路径")],
    "policy": [("政策全景", "政策是什么: 沿革、条文与适用范围"),
               ("出台逻辑", "为什么出: 问题导向与利益格局"),
               ("执行现状", "落到哪了: 执行案例与堵点"),
               ("影响评估", "改变了什么: 对行业/企业的影响"),
               ("应对建议", "怎么办: 合规路径与机会清单")],
}
TAIL_PADS = [("深度案例拆解", "标杆项目全周期复盘: 决策链与得失"),
             ("失败与纠纷警示", "反例库: 亏损项目、纠纷判例与教训"),
             ("能力建设路线图", "从差距到能力: 分阶段建设清单")]

BAND_BY_ROLE = {   # 章 role → (budget_band, 渠道三类分标执行者清单)
    "intro": ("outline_wide", ["stock_harvest", "current_increment",
                               "on_demand"]),
    "core": ("section_narrow", ["current_increment", "on_demand"]),
    "benchmark": ("gap", ["on_demand"]),
    "outro": ("outline_wide", ["stock_harvest", "on_demand"]),
}


def _role(idx: int, n: int, title: str) -> str:
    if idx == 0:
        return "intro"
    if idx >= n - 1:
        return "outro"
    if any(k in title for k in ("对标", "竞争", "格局")):
        return "benchmark"
    return "core"


def _chapters_for(family: str, target_n: int) -> list[tuple[str, str, str]]:
    """框架族模板 → 目标章数 (确定性补齐/裁剪, 波动=0)."""
    if family == "enterprise":
        base = ([("引言与研究框架", "研究对象、核心问题与方法论")] +
                [(t, d) for t, d in EPC_TEN_DIMS] +
                [("结论与行动清单", "核心判断、风险提示与行动建议")])
    else:
        sk = SKELETONS.get(family, SKELETONS["topic"])
        base = ([("引言与研究框架", "研究对象、核心问题与方法论")] +
                list(sk) + [("结论与行动清单", "核心判断、风险提示与行动建议")])
    n = len(base)
    if target_n > n:                      # 尾部确定性补齐 (案例/失败/路线图)
        pads = [p for _, p in zip(range(target_n - n),
                                  TAIL_PADS * ((target_n - n) // 3 + 1))]
        base = base[:-1] + pads + [base[-1]]
    elif target_n < n:                    # 确定性裁剪: 保头尾, 核心区等步抽
        step = (n - 2) / (target_n - 2)
        mid = [1 + int(i * step) for i in range(target_n - 2)]
        base = [base[0]] + [base[i] for i in sorted(set(mid))] + [base[n - 1]]
    return [(t, d, _role(i, len(base), t)) for i, (t, d) in enumerate(base)]


def _tier_map(ch_title: str, idx: int, n: int, tiers: dict) -> dict:
    """章 → tier 词表映射 (确定性切片 + 语义挂点).

    引言/结论拿 t1 头部核心词 (S0-2 规则链变体居头), 核心章轮转中段 —
    尾部存量挖掘词不占首尾章."""
    t1 = C.tier_words(tiers, "T1")
    t2 = C.tier_words(tiers, "T2")
    t3 = C.tier_words(tiers, "T3") or ["EPC总承包", "工程总承包"]
    if not t1:
        return {}
    if idx == 0 or idx >= n - 1:
        seg = t1[:3]
    else:
        pool = t1[3:] or t1
        k = max(2, len(pool) // max(1, n - 2))
        start = (idx - 1) * k % len(pool)
        seg = pool[start:start + k] or pool[:2]
    tm = {"T1": seg}
    if "对标" in ch_title or "竞争" in ch_title or "格局" in ch_title:
        tm["T2"] = t2[:4] or t1[:2]
    if any(w in ch_title for w in ("EPC", "项目", "体系", "施工", "设计",
                                   "采购", "风险", "工程", "模式")):
        tm["T3"] = t3[:3]
    return tm


def load_charter(battle_dir: str) -> dict:
    """S1 准入门: 只吃批准件 (批准前 S1 不动工 — S0-3 门真接线)."""
    ok, why = CG.s1_may_start(battle_dir)
    if not ok:
        raise PermissionError(f"S1 禁动工: {why}")
    out = CG._out_dir(battle_dir)
    ch = CG._read_json(out / CG.ACCEPTED_F)
    errs = C.validate_charter(ch)
    if errs:
        raise ValueError(f"批准件校验失败 (回炉 S1-3): {errs[:3]}")
    return ch


def generate(charter: dict, scout: dict | None = None) -> dict:
    """批准 charter → framework.json (确定性; 坏输入硬拒不兜底)."""
    if not isinstance(charter, dict) or not C.charter_ready_for_s1(charter):
        raise ValueError("charter 未达 S1 准入 (approved+零错) — 硬拒")
    fam = charter["family"]
    if fam not in C.FAMILY_TYPES:
        raise ValueError(f"family 非四框架族: {fam!r}")
    vol = charter["volume"]
    target = max(3, int(vol["chapters"]))
    tiers = charter["tiers"]
    chs = _chapters_for(fam, target)
    scout = scout or {}
    chapters = []
    for i, (title, desc, role) in enumerate(chs):
        band, chans = BAND_BY_ROLE[role]
        hits = scout.get(title) or []
        density = ("high" if len(hits) >= 3
                   else "medium" if hits else "low")   # 无侦察据只准 low
        ch = {"id": f"ch{i + 1:02d}", "title": title,
              "description": desc,
              "tier_map": _tier_map(title, i, len(chs), tiers),
              "channels": chans, "budget_band": band,
              "evidence_density": density}
        if hits:
            ch["scout_hits"] = hits[:5]
        chapters.append(ch)
    fw = {"schema": "framework_v1", "campaign_id": charter["campaign_id"],
          "report_title": charter["report_title"], "family": fam,
          "version": 1, "chapters": chapters,
          "volume_ref": {"chapters": vol["chapters"],
                         "sections": vol["sections"],
                         "total_chars": vol["total_chars"]},
          "model_band": {"default": "free",
                         "escalate_rule": "evidence_density=high 或 "
                                          "budget_band=gap 章切 reasoning",
                         "escalated": [c["id"] for c in chapters
                                       if c["evidence_density"] == "high"
                                       or c["budget_band"] == "gap"]},
          "generated_by": f"framework_gen v1 (rule, deterministic) "
                          f"superline {_sl.__version__}"}
    errs = C.validate_framework(fw)
    if errs:                              # 生成件必须自过契约 (不悬空)
        raise ValueError(f"framework 自校验失败: {errs[:3]}")
    return fw


def render(fw: dict, battle_dir: str) -> Path:
    out = CG._out_dir(battle_dir)
    p = out / "framework.json"
    p.write_text(json.dumps(fw, ensure_ascii=False, indent=1),
                 encoding="utf-8")
    done, total = C.route_completeness(fw)
    md = ["# S1 框架 (路由表)", "",
          f"- campaign {fw['campaign_id']} | {fw['family']} 族 | "
          f"{len(fw['chapters'])} 章 | 路由齐备 {done}/{total}", "",
          "| 章 | 题目 | band | 密度 | T1 词 | 渠道 |", "|---|---|---|---|---|---|"]
    md += [f"| {c['id']} | {c['title']} | {c['budget_band']} | "
           f"{c['evidence_density']} | {'、'.join(c['tier_map'].get('T1', []))} | "
           f"{'/'.join(c['channels'])} |" for c in fw["chapters"]]
    (out / "framework.md").write_text("\n".join(md) + "\n", encoding="utf-8")
    return p


def _load_scout(path: str) -> dict:
    """--scout 归一: 裸 {题:[串]} 或 S1-2 scout_v1 包 ({schema,hits}) 皆可."""
    data = json.loads(Path(path).read_text(encoding="utf-8"))
    if isinstance(data, dict) and data.get("schema") == "scout_v1":
        from superline import scout_inject as SI
        return SI.to_scout_json(data.get("hits") or {})
    return data


def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="S1-1 框架生成器 v1")
    ap.add_argument("--battle-dir", default="")
    ap.add_argument("--scout", default="", help="侦察段 JSON (章题→命中清单)")
    args = ap.parse_args(argv)
    print(f"[s1-1] superline {_sl.__version__} 框架生成器 v1 (确定性)")
    try:
        ch = load_charter(args.battle_dir)
    except (PermissionError, ValueError) as e:
        print(f"[s1-1] ✗ {e}", file=sys.stderr)
        return 2
    scout = _load_scout(args.scout) if args.scout and Path(args.scout).is_file() else {}
    fw = generate(ch, scout=scout)
    p = render(fw, args.battle_dir)
    done, total = C.route_completeness(fw)
    print(f"[s1-1] framework.json 落 {p} | {len(fw['chapters'])} 章 | "
          f"路由齐备 {done}/{total} | fingerprint {C.fingerprint(fw)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
