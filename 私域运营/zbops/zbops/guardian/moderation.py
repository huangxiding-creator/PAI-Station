# -*- coding: utf-8 -*-
"""内容审核闸门：三级词库（ARCHITECTURE §5.5）。

  A 级硬阻断：涉政涉法涉黄暴恐 / 广告法绝对化用语 / 工程承诺类话术
  B 级强制人审：报价 / 工期 / 资质表述
  C 级提示：营销味过浓

词库版本化本地维护；LLM 二审（可选）只升严不放行。
逆向对照：识流 bundle 敏感词零命中且 reply_mode 默认 auto——本模块即补此缺口。
"""
from __future__ import annotations

from dataclasses import dataclass

LEVEL_A = [
    # 广告法第九条绝对化用语
    "最优秀", "最好", "最佳", "第一品牌", "国家级", "最高级", "独家", "全网第一",
    "100%通过", "百分之百", "绝无仅有", "史无前例",
    # 工程行业承诺类（禁用话术）
    "保证中标", "包过", "包验收", "包通过", "终身免费", "绝对安全", "零事故",
    "零风险", "稳过", "挂靠", "围标", "串标",
    # 平台高压
    "加微信详谈", "扫码进群", "点击链接领取",
]

LEVEL_B = [
    "报价", "多少钱", "费用", "造价多少", "工期承诺", "保证工期",
    "资质代办", "资质转让", "包资质",
]

LEVEL_C = [
    "限时优惠", "最后机会", "速来", "抢占", "名额有限", "立省",
]


@dataclass
class Verdict:
    level: str          # pass / A / B / C
    hits: list
    action: str         # pass / block / review / note

    @property
    def ok(self) -> bool:
        return self.level in ("pass", "C")


def moderate(text: str) -> Verdict:
    for w in LEVEL_A:
        if w in text:
            return Verdict("A", [w], "block")
    b = [w for w in LEVEL_B if w in text]
    if b:
        return Verdict("B", b, "review")
    c = [w for w in LEVEL_C if w in text]
    if c:
        return Verdict("C", c, "note")
    return Verdict("pass", [], "pass")
