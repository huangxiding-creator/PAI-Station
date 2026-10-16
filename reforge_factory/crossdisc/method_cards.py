# -*- coding: utf-8 -*-
"""crossdisc.method_cards — 跨学科方法卡注册器 (V-006 / REQ-024 / REQ-025).

方法卡 = 一门非本行业学科的真实调查方法可被流水线复用的四件套合同
(REQ-025 [MUST]: 四件套齐备才许注册, 缺任一 ValueError 拒注册):

  1. source_authority_table  源权威表 — 该学科各源类型 → grade_rules 等级.
     等级口径参数化自 grade_rules (A=一手官方/一手材料, B=权威二手,
     C=合成聚合·当事人自辩 — 保守地板), 值可带括注如 "C(保守地板)".
  2. independence_keys       独立性键集 — 判「两条证据是否独立」的字段键
     (与 independence_audit / depth_ladder L3 双源判定同一思想).
  3. hypothesis_templates    假设模板 — 该学科默认要证伪的假设族 (证伪优先,
     先假设对面在撒谎, 再找材料).
  4. golden_questions        学科黄金四问 — 动手前必答, 决定从什么原始材料
     开始 / 用什么方法 / 拿什么外部基准验证.

三张出厂卡 (真实方法非角色扮演; import 即注册进 CARD_REGISTRY):
  做空审计  — 做空机构式法务会计红旗筛查 (filings→红旗→法务会计→外部基准)
  法务穿透  — 股权穿透式实控人追查 (工商档案→穿透链→司法记录验证)
  调查叙事  — 调查记者式信源交叉验证 (一手材料→动机→时间线裂缝→事实核查)

用法:
  from crossdisc.method_cards import register_card, get_card, list_cards
  register_card("新学科", {...四件套...})   # 缺任一 → ValueError
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

# 同级/上级导入纪律 (与 completeness/depth_ladder 同款): 保证
# reforge_factory (grade_rules) 无论以何种包前缀导入均可解析
_HERE = Path(__file__).resolve().parent
for _p in (str(_HERE.parent), str(_HERE)):
    if _p not in sys.path:
        sys.path.insert(0, _p)
import grade_rules as _gr                                   # noqa: E402

#: 四件套合同键 (REQ-025: 缺任一拒注册)
METHOD_CARD_SCHEMA: tuple[str, ...] = (
    "source_authority_table",   # 源权威表 (grade_rules A/B/C 参数化)
    "independence_keys",        # 独立性键集
    "hypothesis_templates",     # 假设模板列表
    "golden_questions",         # 该学科黄金四问列表
)

#: 合法等级字母 — 参数化自 grade_rules 活规则表 (渠道表 ∪ 前缀表 ∪ 默认地板),
#: grade_rules 演化时此处随动, 不在method_cards 里另立等级体系
VALID_GRADES: frozenset[str] = frozenset(
    {pair[0] for pair in _gr.ENGINE_GRADES.values()}
    | {pair[1][0] for pair in _gr.PREFIX_GRADES}
    | {_gr.DEFAULT_GRADE[0]}
)

#: 等级值形如 "A" / "C(保守地板)" / "C（保守地板）" — 字母 + 可选括注
_GRADE_RE = re.compile(r"^\s*([A-Za-z])\s*(?:[（(][^）)]*[）)])?\s*$")

#: 方法卡注册表 (name → card); 出厂三卡 import 即注册
CARD_REGISTRY: dict[str, dict] = {}


def _grade_letter(value: object) -> str | None:
    """解析源权威表等级值 → 等级字母; 非法形制返回 None."""
    m = _GRADE_RE.match(str(value or ""))
    if not m:
        return None
    letter = m.group(1).upper()
    return letter if letter in VALID_GRADES else None


def register_card(name: str, card: dict) -> str:
    """注册方法卡 (覆盖同名; REQ-025: 四件套缺任一/任一为空 → ValueError).

    校验 (全部拒绝才落表, 拒注册不污染 CARD_REGISTRY):
      - name 非空字符串; card 为 dict
      - 四件套键全在且均非空:
        * source_authority_table: dict[源类型→等级], 等级字母 ∈ VALID_GRADES
        * independence_keys / hypothesis_templates / golden_questions:
          非空 str 元素的非空 list
    """
    if not isinstance(name, str) or not name.strip():
        raise ValueError("方法卡名必须为非空字符串")
    if not isinstance(card, dict):
        raise ValueError(f"方法卡 {name} 必须为 dict (四件套)")
    missing = [k for k in METHOD_CARD_SCHEMA if k not in card]
    if missing:
        raise ValueError(f"方法卡 {name} 四件套缺失: {missing} (REQ-025 拒注册)")

    sat = card["source_authority_table"]
    if not isinstance(sat, dict) or not sat:
        raise ValueError(f"方法卡 {name} source_authority_table 必须为非空 dict")
    for src, grade in sat.items():
        if not isinstance(src, str) or not src.strip():
            raise ValueError(f"方法卡 {name} 源权威表含空源类型: {src!r}")
        if _grade_letter(grade) is None:
            raise ValueError(
                f"方法卡 {name} 源类型 {src!r} 等级非法: {grade!r} "
                f"(合法字母 {sorted(VALID_GRADES)}, 可带括注, grade_rules 口径)")

    for key in ("independence_keys", "hypothesis_templates", "golden_questions"):
        vals = card[key]
        if not isinstance(vals, list) or not vals:
            raise ValueError(f"方法卡 {name} {key} 必须为非空 list")
        for v in vals:
            if not isinstance(v, str) or not v.strip():
                raise ValueError(f"方法卡 {name} {key} 含空元素: {v!r}")

    CARD_REGISTRY[name] = {k: card[k] for k in card}   # 浅拷贝防外部引用篡改
    return name


def get_card(name: str) -> dict:
    """取已注册方法卡; 未注册 → KeyError (禁隐身兜底)."""
    try:
        return CARD_REGISTRY[name]
    except KeyError:
        raise KeyError(f"方法卡未注册: {name!r} (已注册: {sorted(CARD_REGISTRY)})") from None


def list_cards() -> list[str]:
    """已注册方法卡名 (按名排序)."""
    return sorted(CARD_REGISTRY)


# ---------- 三张出厂卡 (真实方法; import 即注册) ---------------------------

#: 做空审计 — 做空机构式法务会计红旗筛查: 从 SEC filings/审计意见等一手监管
#: 文件找红旗 (关联交易/收入确认/现金流与利润背离), 管理层解释一律 C 保守地板
CARD_SHORT_AUDIT: dict = {
    "source_authority_table": {
        "SEC文件": "A",
        "审计意见": "A",
        "管理层解释": "C(保守地板)",   # 利益相关方自辩, 溯源核实前不升格
    },
    "independence_keys": ["byline", "jurisdiction", "source_doc"],
    "hypothesis_templates": ["增长不可持续", "管理层误导", "财务异常"],
    "golden_questions": [
        "做空的红旗信号有哪些",
        "从什么原始 filings 开始",
        "用什么法务会计方法",
        "什么外部基准能验证",
    ],
}

#: 法务穿透 — 股权穿透式实控人追查: 工商档案/判决书逐层穿透代持与担保链,
#: 转载聚合稿一律 C (穿透只认登记与司法原件)
CARD_LEGAL_PENETRATE: dict = {
    "source_authority_table": {
        "判决书": "A",
        "工商档案": "A",
        "转载": "C",
    },
    "independence_keys": ["filer", "period", "statement"],
    "hypothesis_templates": ["实控人隐藏", "资金挪用", "担保链风险"],
    "golden_questions": [
        "谁的股权在暗中变化",
        "从什么工商档案开始",
        "用什么穿透方法",
        "什么司法记录能验证",
    ],
}

#: 调查叙事 — 调查记者式信源交叉验证: 当事人陈述与一手档案为 A,
#: 聚合稿 C; 按时间线交叉找裂缝, 信源动机先行
CARD_INVESTIGATIVE_NARRATIVE: dict = {
    "source_authority_table": {
        "当事人陈述": "A",
        "一手档案": "A",
        "聚合稿": "C",
    },
    "independence_keys": ["byline", "source_doc", "date"],
    "hypothesis_templates": ["叙事有误导", "信源有动机", "时间线有裂缝"],
    "golden_questions": [
        "谁在说什么为什么",
        "从什么一手材料开始",
        "用什么交叉验证方法",
        "什么事实核查工具能验证",
    ],
}

register_card("做空审计", CARD_SHORT_AUDIT)
register_card("法务穿透", CARD_LEGAL_PENETRATE)
register_card("调查叙事", CARD_INVESTIGATIVE_NARRATIVE)
