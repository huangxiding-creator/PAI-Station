# -*- coding: utf-8 -*-
"""DownloadAdapter 四段框架（FR1.1）+ LadderResult 数据类 + wall_status 标记位（NFR1）。

统一语言（CONTEXT.md）：
- 适配器 DownloadAdapter：单站点收割插件，四段 = search/plan/fetch_ladder/verify（唯一权威序）。
- 三级梯队 ladder：L1 协议直连 → L2 站内JS签名渲染 → L3 截图+OCR，逐级自动降级。
- 标记映射：needs_vip_candidate / paid_wall / blocked_waf / blocked_mirror_policy
  → 统一落 FileMeta.extra.wall_status + ledger；行为=硬拒或部分收割如实标注。
- FileMeta 直接 import 复用 channel_adapters.base 真符号（元数据层口径，不重复定义）。

四段组合、降级循环与红线复验属 orchestrator（T40）；本件只定抽象、数据类与纯函数梯队步进
（FR1.2 数值化降级判定器=超时30s/页、HTTP≥400连续3次、envelope 失败、质检不过，由后续任务落本件）。
"""
from abc import ABC, abstractmethod
from dataclasses import dataclass

from kb_factory.channel_adapters.base import FileMeta

FOUR_STAGES = ("search", "plan", "fetch_ladder", "verify")  # FR1.1 四段调用序（唯一权威序）

LADDER_ORDER = ("L1", "L2", "L3")  # L1 协议直连 → L2 站内JS签名渲染 → L3 截图+OCR

WALL_NEEDS_VIP_CANDIDATE = "needs_vip_candidate"      # wenku 侧推断标记（FR2.3）
WALL_PAID = "paid_wall"                                # csdn 侧 DOM 判定标记（FR5.1）
WALL_BLOCKED_WAF = "blocked_waf"                       # doc88 WAF 标记（FR4.AC2）
WALL_BLOCKED_MIRROR_POLICY = "blocked_mirror_policy"   # 禁第三方镜像硬拒标记（R20）
WALL_STATUS_MARKERS = frozenset(
    (WALL_NEEDS_VIP_CANDIDATE, WALL_PAID, WALL_BLOCKED_WAF, WALL_BLOCKED_MIRROR_POLICY))


def mark_wall_status(meta: FileMeta, marker: str) -> FileMeta:
    """把统一标记落 FileMeta.extra.wall_status（NFR1 统一落点；ledger 同步行由调用方写）。"""
    if marker not in WALL_STATUS_MARKERS:
        raise ValueError(f"非统一标记映射词表: {marker!r}（合法={sorted(WALL_STATUS_MARKERS)}）")
    meta.extra["wall_status"] = marker
    return meta


def next_ladder(ladder: str) -> str | None:
    """梯队降级步进（纯函数）：L1→L2→L3→None。"""
    if ladder not in LADDER_ORDER:
        raise ValueError(f"非法梯队级: {ladder!r}（合法={LADDER_ORDER}）")
    i = LADDER_ORDER.index(ladder)
    return LADDER_ORDER[i + 1] if i + 1 < len(LADDER_ORDER) else None


@dataclass
class HarvestPlan:
    """收割计划（单文档）：蓝图槽位 × FileMeta → 梯队级执行清单（CONTEXT「收割计划」）。"""

    meta: FileMeta
    slot: str = ""
    ladder_try: tuple = LADDER_ORDER
    red_check: bool = True  # 双红线检查点（plan 期 sources_registry + fetch 前复验）


@dataclass
class LadderResult:
    """fetch_ladder 单文档产物（字段序=任务书契约，不得增删改名）。"""

    ok: bool
    ladder_used: str | None = None  # L1/L2/L3；梯队全败=None
    artifact_path: str | None = None
    pages: int | None = None  # 实测页数（数字零造假）
    chars: int | None = None  # 实测字数
    wall_status: str | None = None  # WALL_STATUS_MARKERS 之一；无标记=None
    coverage: str | None = None  # 部分收割覆盖页数，形态 "showPage/page"
    detail: str = ""


class DownloadAdapter(ABC):
    """单站点收割适配器抽象（四段，FR1.1）；编排/容器逻辑不在此（orchestrator 事）。"""

    site = "abstract"

    @abstractmethod
    def search(self, query: str, limit: int) -> list[FileMeta]:
        """段1：按查询词检 ≤limit 条 FileMeta（行结构复用元数据层口径）。"""

    @abstractmethod
    def plan(self, meta: FileMeta) -> HarvestPlan:
        """段2：单文档 → 收割计划（槽位/梯队尝试序/红线检查点）。"""

    @abstractmethod
    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        """段3：按 plan.ladder_try 逐级收割（降级判定=FR1.2 数值化门）。"""

    @abstractmethod
    def verify(self, result: LadderResult) -> bool:
        """段4：按质检门口径核验产物（页数/字数/水印/完整性，quality_gate 数值化）。"""
