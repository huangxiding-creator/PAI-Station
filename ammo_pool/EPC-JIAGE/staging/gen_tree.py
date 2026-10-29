# -*- coding: utf-8 -*-
"""EPC-JIAGE 问题树生成器 — 第10份研报《工程计价依据与市场价基准实战研究报告》S1 定纲.

照 EPC-OVERSEAS/question_tree.json 在役 schema (26 subquestions / 78 EEI / 10 dim,
每 EEI 带 need/grades/stance/channels_hint/queries), 维度按 EXEC-计价依据研报-S1S5.md
三场景骨架 (投标编制/结算核对/合同解除结算 各成 dim 组) + 任务书建议十维定制.
不 question_tree.py generate 直接跑的原因: 其 SUBQ_TEMPLATES 是通用工程域 v0 六维+
固定四面, 无计价域十维模板 — 本件只借用其 falsifiable_check/context_pack 判据,
树 schema 字段完全同构 (coverage 命令零改动可消费).

用法: py -X utf8 E:/AI-Station/ammo_pool/EPC-JIAGE/staging/gen_tree.py
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
from question_tree import falsifiable_check, context_pack  # noqa: E402
import search_query_generator as sqg                       # noqa: E402

CID = "EPC-JIAGE"
TOPIC = "工程计价依据与市场价基准实战研究报告"
REGION = "全国"
SUBJECT_Q = "工程计价依据 市场价基准"      # 查询词用紧凑形 (全称搜索命中率低)
YEAR = sqg.YEAR_WINDOW                     # 2025-2026 (M1 四维公式时间窗)
OUT = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE\question_tree.json")

# ---------- 十维模板 (三场景 dim 组: 投标编制实务/结算核对实务/合同解除结算) ----------
SUBQ_TEMPLATES: dict[str, list[str]] = {
    "政策法规与定额体系": [
        "{r} {s} 主管部门与监管框架",
        "{s} 造价管理制度体系与政策文件沿革",
        "{s} 定额体系构成与发布管理制度",
    ],
    "计价依据与定额测定": [
        "{s} 预算定额测定方法与编制规程的技术标准",
        "{s} 人工材料机械消耗量定额水平数据与调整机制",
        "{s} 企业定额建设现状与标杆案例",
    ],
    "信息价与市场价基准": [
        "{s} 信息价发布机制与各省造价管理机构",
        "{s} 信息价与市场价差异口径及计价采用规则",
        "{s} 造价指数发布数据与材料价差调整规则",
    ],
    "投标编制实务": [
        "{s} 招标控制价编制规则与复核争议案例",
        "{s} 投标报价编制模式与不平衡报价风险案例",
        "{s} 综合单价组价规则与全费用单价模式",
    ],
    "结算核对实务": [
        "{s} 竣工结算编审规则与量价费核对要点",
        "{s} 签证与变更计价规则及审核口径",
    ],
    "合同解除结算": [
        "{s} 合同解除情形与已完工程量结算规则",
        "{s} 合同解除后损失赔偿与结算争议判例",
    ],
    "造价鉴定与争议": [
        "{s} 造价鉴定程序规范与鉴定机构管理",
        "{s} 计价争议类型与司法解释口径",
        "{s} 造价争议典型判例与裁判规则",
    ],
    "清单与定额计价模式": [
        "{s} 工程量清单计价规范体系与版本沿革",
        "{s} 定额计价与清单计价模式差异及适用边界",
        "{s} 估算概算预算结算全过程计价链条与控制规则",
    ],
    "造价咨询与职业": [
        "{s} 造价工程师执业制度与咨询资质改革",
        "{s} 造价咨询企业排名与收费模式",
    ],
    "数据源与工具生态": [
        "{s} 造价信息数据源与发布平台清单",
        "{s} 计价软件工具生态与数字化平台格局",
    ],
}

# 渠道提示 (渠道名词汇=站内既有 engine/渠道名; std_samr=国标直下链 skill,
# court=裁判文书腿, wenku=文库池 — 三者为本战役 WBS 明示 S2 采集主力)
CH = {
    "政策法规与定额体系": (["govlist", "std_samr", "rss"],
                        ["sogou_wechat", "websearch", "metaso"],
                        ["govlist", "std_samr", "opencli"]),
    "计价依据与定额测定": (["metaso", "cnki", "opencli"],
                        ["sogou_wechat", "websearch", "manus_corps"],
                        ["govlist", "std_samr", "ebook"]),
    "信息价与市场价基准": (["wenku", "metaso", "opencli"],
                        ["sogou_wechat", "websearch"],
                        ["govlist", "websearch", "opencli"]),
    "投标编制实务": (["wenku", "metaso", "sogou_wechat"],
                   ["sogou_wechat", "websearch"],
                   ["govlist", "cnki", "chinca"]),
    "结算核对实务": (["wenku", "metaso", "sogou_wechat"],
                   ["sogou_wechat", "websearch"],
                   ["govlist", "court", "cnki"]),
    "合同解除结算": (["court", "cnki", "sogou_wechat"],
                   ["websearch", "sogou_wechat"],
                   ["court", "govlist", "opencli"]),
    "造价鉴定与争议": (["court", "cnki", "metaso"],
                    ["sogou_wechat", "websearch"],
                    ["court", "govlist", "opencli"]),
    "清单与定额计价模式": (["std_samr", "metaso", "wenku"],
                        ["sogou_wechat", "websearch"],
                        ["std_samr", "govlist", "opencli"]),
    "造价咨询与职业": (["metaso", "sogou_wechat", "dangdang"],
                    ["sogou_wechat", "websearch"],
                    ["govlist", "cnki", "opencli"]),
    "数据源与工具生态": (["websearch", "metaso", "chinca"],
                       ["sogou_wechat", "websearch"],
                       ["govlist", "opencli", "rss"]),
}

# E3 权威口径查询词 (域定制 — 不用通用省政府模板, 直捣计价权威源:
# 住建部标准定额司/省造价管理总站/计价规范标准号/最高法司法解释)
AUTHORITY_Q = {
    "政策法规与定额体系": [
        "住房和城乡建设部 标准定额司 计价依据 政策",
        "建设工程造价管理办法 住建部",
        "省住房和城乡建设厅 造价管理总站"],
    "计价依据与定额测定": [
        "住建部 建设工程定额 编制规程",
        "全国统一建筑工程基础定额",
        "标准定额研究所 定额测定"],
    "信息价与市场价基准": [
        "省建设工程造价管理总站 信息价 2025-2026",
        "中国建设工程造价管理协会 造价指数",
        "住房和城乡建设部 工程造价指标"],
    "投标编制实务": [
        "建设工程工程量清单计价规范 GB50500",
        "住建部 招标控制价 编制 规定",
        "标准施工招标文件 住房和城乡建设部"],
    "结算核对实务": [
        "建设工程价款结算暂行办法 财政部 建设部",
        "竣工结算 财政投资评审 规定",
        "住建部 工程价款结算 政策"],
    "合同解除结算": [
        "最高人民法院 建设工程施工合同司法解释",
        "民法典 建设工程合同 解除 结算",
        "合同解除 已完工程 结算 规定"],
    "造价鉴定与争议": [
        "建设工程造价鉴定规范 GB/T 51262-2017",
        "最高人民法院 造价鉴定 规定",
        "全国法院 建设工程施工合同纠纷 司法解释二"],
    "清单与定额计价模式": [
        "GB 50500-2013 建设工程工程量清单计价规范",
        "住房和城乡建设部 计价规范 公告",
        "工程量清单计价规范 修订 2024"],
    "造价咨询与职业": [
        "造价工程师职业资格制度 规定 人社部",
        "工程造价咨询企业 资质 取消 政策",
        "中国建设工程造价管理协会 收费 指导"],
    "数据源与工具生态": [
        "住房和城乡建设部 工程造价 信息平台",
        "省造价信息 网刊 发布",
        "中国建设工程造价管理协会 数据"],
}


def eei_triple(subq: str, dim: str) -> list[dict]:
    """每子问题 → 3 EEI (正/反/权威 — 与 eei_for 同构, 查询词域定制)."""
    import re
    short = re.sub(r"[（()，,。.?？]", "", subq).replace(REGION, "")
    short = short.replace(TOPIC, "").replace(SUBJECT_Q, "").strip()[:20]
    e1c, e2c, e3c = CH[dim]
    return [
        {"id": "", "need": f"正面证据: {short} 的数据/清单/案例",
         "grades": ["A", "B"], "stance": "support", "channels_hint": e1c,
         "queries": [f"全国 {SUBJECT_Q} {short} {YEAR}",
                     f"{SUBJECT_Q} {short} 实务 方法"]},
        {"id": "", "need": f"反面证据: {short} 的风险/反例/对立观点",
         "grades": ["B", "C"], "stance": "against", "channels_hint": e2c,
         "queries": [f"全国 {SUBJECT_Q} {short} 风险 纠纷 争议",
                     f"{SUBJECT_Q} {short} 问题 教训 质疑"]},
        {"id": "", "need": f"权威口径: {short} 的官方文件/规范/公报原文",
         "grades": ["A"], "stance": "support", "channels_hint": e3c,
         "queries": AUTHORITY_Q[dim][:3]},
    ]


def main() -> int:
    subqs, n_unfalsifiable = [], 0
    sid = 0
    for dim, templates in SUBQ_TEMPLATES.items():
        assert dim in CH and dim in AUTHORITY_Q, f"dim 配置缺: {dim}"
        for t in templates:
            text = t.format(r=REGION, s=TOPIC)
            ok, note = falsifiable_check(text)
            n_unfalsifiable += 0 if ok else 1
            sid += 1
            eeis = eei_triple(text, dim)
            for i, e in enumerate(eeis, 1):
                e["id"] = f"Q{sid}-E{i}"
                e["status"] = "zero"       # 运行时由 coverage 更新
            subqs.append({"id": f"Q{sid}", "dim": dim, "text": text,
                          "falsifiable": ok, "falsify_note": note,
                          "eeis": eeis})
    dims = {q["dim"] for q in subqs}
    tree = {
        "campaign": CID, "topic": TOPIC, "region": REGION,
        "generated": time.strftime("%Y-%m-%d %H:%M"),
        "engine": "v0-heuristic 计价域十维定制 (EPC-JIAGE S1; "
                  "军团参谋网络恢复后升级 — M4)",
        "context_pack": context_pack(CID),
        "loop_policy": "M3 增量生长: 小批采→即时判挂树→按 coverage 缺口补下批",
        "hypotheses": [
            {"id": "H1",
             "text": f"{TOPIC}: 计价依据体系趋于稳定, 按图索骥即可规避主要风险",
             "prior": 0.35},
            {"id": "H2",
             "text": f"{TOPIC}: 定额信息价体系与市场实际持续脱节, 争议与结算风险大于确定性",
             "prior": 0.35},
            {"id": "H3",
             "text": f"{TOPIC}: 结构性分化: 规范依据确定性高, 市场价基准与解除结算端风险集中",
             "prior": 0.3},
        ],
        "subquestions": subqs,
        "stats": {"subquestions": len(subqs),
                  "unfalsifiable": n_unfalsifiable,
                  "eeis": sum(len(q["eeis"]) for q in subqs),
                  "queries": sum(len(e["queries"]) for q in subqs
                                 for e in q["eeis"])},
        "note_scenario": "三场景骨架: 投标编制实务(Q10-Q12)/结算核对实务"
                         "(Q13-Q14)/合同解除结算(Q15-Q16) 各成 dim 组; "
                         "七源调研与四自查门见 EXEC-计价依据研报-S1S5.md S1",
    }
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"[tree] {CID}: {len(subqs)} 子问题 | {len(dims)} 维 | "
          f"{tree['stats']['eeis']} EEI | {tree['stats']['queries']} 查询词 | "
          f"不可证伪 {n_unfalsifiable} → {OUT}")
    for q in subqs:
        if not q["falsifiable"]:
            print(f"  ⚠ 不可证伪: {q['id']} {q['text']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
