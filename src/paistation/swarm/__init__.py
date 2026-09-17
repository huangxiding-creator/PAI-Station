"""P2 站群试点（DISRUPTION_PLAN 假设④破界：孤岛→站群）。

总包圈 3-5 站技能包 swap 最小闭环 + 积分记账。复用 skills/market 的
安全扫描与导入闸（五层扫描→元数据校验→同版拒覆盖），本包只加三件：
站点身份（ed25519 签名）、站群注册表（通讯录）、积分账本（jsonl 只增不删）。

ANP 身份（did:wba，第 13 路调研）：e1_ 指纹派生+合法 DID 字符串+
DID 文档生成已落地（identity.py）；HTTPS 端点与 proof 官方闭环属基建档。
"""
from .identity import SiteIdentity, SwarmUnavailable, e1_fingerprint, verify_document
from .ledger import PointsLedger
from .registry import SiteRegistry
from .swap import (
    confirm_receipt,
    pack_swap,
    receive_swap,
    verify_swap,
)

__all__ = [
    "SiteIdentity", "SwarmUnavailable", "SiteRegistry", "PointsLedger",
    "pack_swap", "receive_swap", "verify_swap", "confirm_receipt",
    "e1_fingerprint", "verify_document",
]
