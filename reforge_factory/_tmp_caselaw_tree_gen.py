# -*- coding: utf-8 -*-
"""EPC-CASELAW S1 问题树一次性生成件 (照 JIAGE/TOP50 产线: 26子问/78EEI/十维定制).

不动 question_tree.py 生产件 — 本件 import 后覆盖 SUBQ_TEMPLATES/
HYPOTHESIS_SEEDS/eei_for 三件, 再调 generate(); 生成后 engine 字段改判例域
定制标注 (与 EPC-JIAGE 1025 增补同范式). 用毕可留档复算.
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import question_tree as qt  # noqa: E402

CID = "EPC-CASELAW"
TOPIC = "工程造价争议判例谱系与调解实务研究报告·2026"
REGION = "全国"
SUBJECT_ABBR = "工程造价争议"          # 查询词用主题缩位 (防双拼, 照 JIAGE)

# ---------- 十维 26 子问模板 (3/3/3/3/3/2/3/2/2/2 = 26) ----------
CASELAW_TEMPLATES = {
    "判例方法论与争议分类学": [
        "判例谱系总览与争议类型分层索引",
        "判例方法论与类案检索规则体系",
        "造价争议案由分布与高发类型统计数据",
    ],
    "固定总价与总价包干争议": [
        "固定总价合同范围认定争议判例与裁判规则",
        "固定总价合同解除与价格波动调价判例",
        "总价包干清单缺项漏项与风险范围争议案例",
    ],
    "结算与审减攻防": [
        "竣工结算争议与送审审减攻防判例 (GB/T 50500-2024 计价规范口径)",
        "以审计结果为结算依据条款效力判例",
        "逾期未答复视为认可送审价判例",
    ],
    "变更签证索赔反索赔": [
        "工程变更与签证效力争议判例",
        "索赔期限条款与索赔失权判例",
        "业主反索赔与扣款对抗判例案例",
    ],
    "造价鉴定程序与质证": [
        "造价鉴定程序规则与鉴定依据判例 (GB/T 51262)",
        "鉴定意见质证与重新鉴定判例",
        "鉴定范围与结算审计关系争议案例",
    ],
    "工期与费用索赔": [
        "工期延误与顺延认定争议判例",
        "赶工费用与停窝工损失索赔判例",
    ],
    "合同效力与黑白合同": [
        "黑白合同认定与结算依据选择判例",
        "无效合同折价补偿与验收合格结算判例",
        "必须招标项目与中标无效合同效力判例",
    ],
    "优先受偿权与工程款保护": [
        "建设工程价款优先受偿权判例",
        "工程款利息起算与垫资返还判例",
    ],
    "调解与ADR实务": [
        "造价争议调解实务与调解协议司法确认案例",
        "争议评审DAAB机制与FIDIC条款国内实践判例",
    ],
    "仲裁与诉讼策略": [
        "造价争议仲裁实务与仲裁法修订动向 (2026-03-01施行)",
        "建工案件诉讼管辖与证据规则判例",
    ],
}

CASELAW_HYPOTHESES = [
    {"id": "H1", "prior": 0.35,
     "text": "{s}: 建工司法解释与人民法院案例库已统一裁判规则, 判例谱系清晰可检索, 依谱防控造价争议的确定性高"},
    {"id": "H2", "prior": 0.35,
     "text": "{s}: 同案不同判普遍, 判例谱系表面统一实则规则冲突, 鉴定与调解实务的确定性被高估"},
    {"id": "H3", "prior": 0.30,
     "text": "{s}: 结构性分化: 计价实体规则(固定总价/结算)裁判趋稳, 程序与权利端(鉴定质证/仲裁/优先受偿权)争议风险集中"},
]

# ---------- 每维权威口径查询词 (E3 槽 3 条; 照 JIAGE 每维定制) ----------
DIM_AUTHORITY_QUERIES = {
    "判例方法论与争议分类学": [
        "最高人民法院 建设工程施工合同纠纷司法解释 理解与适用",
        "人民法院案例库 建设工程 造价 争议",
        "中国裁判文书网 建设工程施工合同 判决",
    ],
    "固定总价与总价包干争议": [
        "最高人民法院 固定总价合同 结算 裁判规则",
        "人民法院案例库 固定总价 判例",
        "GB/T 50500-2024 建设工程工程量清单计价规范",
    ],
    "结算与审减攻防": [
        "最高人民法院 竣工结算 司法解释",
        "审计署 建设工程 结算审计 规定",
        "人民法院案例库 竣工结算 判例",
    ],
    "变更签证索赔反索赔": [
        "最高人民法院 工程变更 签证 索赔 裁判规则",
        "建设工程施工合同示范文本 GF-2017-0201 变更签证",
        "人民法院案例库 索赔 判例",
    ],
    "造价鉴定程序与质证": [
        "建设工程造价鉴定规范 GB/T 51262",
        "最高人民法院 造价鉴定 程序 规定",
        "人民法院案例库 造价鉴定 判例",
    ],
    "工期与费用索赔": [
        "最高人民法院 工期延误 顺延 裁判规则",
        "住建部 建设工程施工合同 工期 管理规定",
        "人民法院案例库 工期 判例",
    ],
    "合同效力与黑白合同": [
        "最高人民法院 黑白合同 结算依据 司法解释",
        "招标投标法 必须招标的工程项目 规定",
        "人民法院案例库 合同效力 判例",
    ],
    "优先受偿权与工程款保护": [
        "民法典 建设工程价款优先受偿权 条文",
        "最高人民法院 优先受偿权 司法解释",
        "人民法院案例库 优先受偿权 判例",
    ],
    "调解与ADR实务": [
        "人民调解法 建设工程纠纷 调解",
        "最高人民法院 调解协议司法确认 规定",
        "FIDIC 争议评审 DAAB 规则",
    ],
    "仲裁与诉讼策略": [
        "中华人民共和国仲裁法 2026 修订 全文",
        "最高人民法院 建设工程 仲裁 司法解释",
        "人民法院案例库 建设工程 管辖 判例",
    ],
}

# E3 渠道: 判例域基座 court/govlist/opencli; 标准锚维度加 std_samr
DIM_E3_CHANNELS = {
    "固定总价与总价包干争议": ["std_samr", "court", "govlist", "opencli"],
    "造价鉴定程序与质证": ["std_samr", "court", "govlist", "opencli"],
}


def caselaw_eei_for(subq: str, region: str, subject: str, dim: str) -> list[dict]:
    """判例域三槽 EEI (正/反/权威口径) — 查询词不双拼地域主题 (照 JIAGE)."""
    import re
    stem = re.sub(r"[（(][^）)]*[）)]", "", subq)   # 剥括注锚 (GB/T 51262 等 → E3 权威词已带)
    short = (stem.replace(subject, "").replace(region, "").strip())[:20]
    core = f"{region} {SUBJECT_ABBR} 判例"
    return [
        {"id": "", "need": f"正面证据: {short} 的判例/数据/清单",
         "grades": ["A", "B"], "stance": "support",
         "channels_hint": ["court", "cnki", "metaso"],
         "queries": [f"{core} {short} 2025-2026",
                     f"{SUBJECT_ABBR} {short} 实务 裁判"]},
        {"id": "", "need": f"反面证据: {short} 的风险/反例/对立观点",
         "grades": ["B", "C"], "stance": "against",
         "channels_hint": ["sogou_wechat", "websearch", "metaso"],
         "queries": [f"{core} {short} 风险 败诉 争议",
                     f"{SUBJECT_ABBR} {short} 同案不同判 质疑 教训"]},
        {"id": "", "need": f"权威口径: {short} 的司法解释/规范/判例原文",
         "grades": ["A"], "stance": "support",
         "channels_hint": DIM_E3_CHANNELS.get(dim, ["court", "govlist", "opencli"]),
         "queries": list(DIM_AUTHORITY_QUERIES[dim])},
    ]


def main() -> int:
    # 覆盖三件 (生产件零改动)
    qt.SUBQ_TEMPLATES = CASELAW_TEMPLATES
    qt.HYPOTHESIS_SEEDS = CASELAW_HYPOTHESES
    orig_eei_for = qt.eei_for

    def patched(subq, region, subject):
        # generate() 不传 dim — 从 subq 文本反查所属维度
        for dim, tpls in CASELAW_TEMPLATES.items():
            for t in tpls:
                if subq.endswith(t):
                    return caselaw_eei_for(subq, region, subject, dim)
        return orig_eei_for(subq, region, subject)

    qt.eei_for = patched
    out = qt.generate(CID, TOPIC, REGION)

    # engine 标注改判例域定制 (照 JIAGE 范式)
    tree = json.loads(out.read_text(encoding="utf-8"))
    tree["engine"] = ("v0-heuristic 造价争议判例域十维定制 "
                      "(EPC-CASELAW S1; 军团参谋网络恢复后升级 — M4)")
    st = tree["stats"]
    assert st["subquestions"] == 26, st
    assert st["eeis"] == 78, st
    assert st["queries"] == 182, st
    assert st["unfalsifiable"] == 0, st
    out.write_text(json.dumps(tree, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print(f"[caselaw-tree] 26子问/78EEI/182查询断言全过 → {out}")
    print(f"[caselaw-tree] engine 标注: {tree['engine']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
