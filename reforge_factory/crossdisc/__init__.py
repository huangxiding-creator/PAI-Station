# -*- coding: utf-8 -*-
"""crossdisc — V4 跨学科武器库 (百倍V4 / REQ-024 / REQ-025).

把非本行业学科的真实调查方法 (做空审计·法务穿透·调查叙事) 真值化为
可被工厂流水线复用的「方法卡」合同 — 真实方法非角色扮演:
每张卡的源权威表取自该学科实际使用的原始材料类别, 等级遵循
grade_rules 的 A/B/C 判级口径 (A一手官方 / B权威二手 / C合成聚合保守地板)。

- method_cards.METHOD_CARD_SCHEMA  四件套合同 (缺任一拒注册)
- method_cards.register_card/get_card/list_cards/CARD_REGISTRY
- 三张出厂卡: 做空审计 / 法务穿透 / 调查叙事 (import 即注册)
- 对应三域维度包在 completeness/dimension_matrix.py 出厂注册 (九维升十二维)
"""
from crossdisc.method_cards import (          # noqa: F401
    CARD_REGISTRY,
    METHOD_CARD_SCHEMA,
    get_card,
    list_cards,
    register_card,
)
