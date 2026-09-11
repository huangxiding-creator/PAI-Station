"""器官注册表：12 器官宪法纲要（PROPOSAL_V2.md 3.2 表的机读形态）。

每个器官 = 编号 + 名称 + 使命 + IO 契约 + 质量门 + 自主更新触发器。
目录命名规则：`{id} {name}`（如 `04 智库`），与站根目录实况一致。
"""
from __future__ import annotations

from dataclasses import dataclass, field
from pathlib import Path


@dataclass(frozen=True)
class OrganSpec:
    """一个器官的宪法条目（不可变）。"""

    id: str
    name: str
    mission: str
    inputs: tuple[str, ...]
    outputs: tuple[str, ...]
    quality_gate: str
    trigger: str
    subdirs: tuple[str, ...] = field(default=())

    @property
    def dirname(self) -> str:
        return f"{self.id} {self.name}"


_ORGAN_ROWS = [
    ("00", "愿景", "不变式中枢：保管愿景/宪法/裁决记录，一切模块的为什么",
     ("用户转录", "澄清裁决"), ("不变式清单", "批准书"),
     "裁决须用户亲批", "新转录入库时"),
    ("01", "用户", "自我镜像：比你更懂你的画像 + 纠正资产",
     ("18 源感知", "微信深读", "初终稿 diff"), ("五维画像报告", "avatar.pai"),
     "陈述真度可验证（V1 T23）", "每日增量扫描/每会话纠正",
     ("profile", "sources", "diff")),
    ("02", "规则", "行为边界：国/行/地/企四级规则 + 网络资源登记表",
     ("规则库爬取", "用户投喂"), ("规则引用（成果出厂必检）",),
     "引用必须给权威源链接", "规则源变更/月度巡检",
     ("national", "industry", "local", "enterprise", "registry")),
    ("03", "样本", "风格先例：终稿库 + 企业内网镜像（文风/模板/排序）",
     ("终稿识别器", "内网爬取"), ("同类任务的最像样本",),
     "终稿判定置信度 ≥0.8", "新终稿落盘/内网周增量",
     ("finals", "intranet")),
    ("04", "智库", "原料仓库：顶级大脑的一手成果（外+内）",
     ("各采集渠道（节流红线）",), ("分类语料", "来源登记"),
     "全程溯源/版权三态", "周增量（混沌）/额度日提取（微信读书）",
     ("万维钢调研方法论", "混沌", "调研框架库", "internal")),
    ("05", "方法", "思维兵器：从智库炼出的方法论",
     ("知识炼金（04→05）",), ("方法论文档", "可执行清单"),
     "每方法 ≥3 一手出处", "智库入库后炼金",
     ("万维钢", "毛选", "调研总论", "重构总论")),
    ("06", "技能", "可调用能力：SKILL.md 库（四源蒸馏+血缘图+衰减检测）",
     ("05 方法包装", "diff 蒸馏"), ("即插即用技能",),
     "五层安全扫描全过", "新方法/新 diff/季度审计",
     ("library", "lineage")),
    ("07", "任务", "行动入口：动态多渠道任务识别 + 用户裁决",
     ("8 类任务源",), ("任务清单（含时效安排）",),
     "用户确认后才执行", "感知事件实时",
     ("inbox", "board", "decisions")),
    ("08", "成果", "产能仓库：答案/文稿/报告/方案/工具五层成果",
     ("任务执行",), ("成品", "交接记录"),
     "密度计 ≥60 或如实降级", "任务完成时",
     ("answers", "drafts", "reports", "solutions", "tools")),
    ("09", "发布", "变现出口：FDE 商店 + 书城 + 宣传文",
     ("08 成果出厂",), ("上架 SKU", "定价实验位"),
     "试读 20% + 反馈入口", "成果过质量门后",
     ("store", "bookmall", "promo")),
    ("10", "反馈", "市场之声：返钱账本/评价/下载观看付款数据",
     ("发布端回流",), ("结构化反馈流",),
     "AI 核验真诚度", "实时回流",
     ("ledger", "reviews", "metrics")),
    ("11", "进化", "变异中枢：免疫规则/复盘/奇点宣告/进化提案",
     ("10 反馈", "运行遥测"), ("进化 PR（用户一键批）",),
     "提案须附 before→after", "每日 PDCA/反馈达标",
     ("immune", "pdca", "singularity", "proposals")),
]


def _mk(row) -> OrganSpec:
    org_id, name, mission, inputs, outputs, gate, trigger = row[:7]
    subdirs = row[7] if len(row) > 7 else ()
    return OrganSpec(id=org_id, name=name, mission=mission,
                     inputs=tuple(inputs), outputs=tuple(outputs),
                     quality_gate=gate, trigger=trigger,
                     subdirs=tuple(subdirs))


ORGANS: tuple[OrganSpec, ...] = tuple(_mk(r) for r in _ORGAN_ROWS)
_BY_ID = {o.id: o for o in ORGANS}
_BY_NAME = {o.name: o for o in ORGANS}


def find(organ_id: str) -> OrganSpec:
    """按编号查器官；未知编号显式报 KeyError（带全部合法值）。"""
    try:
        return _BY_ID[organ_id]
    except KeyError:
        raise KeyError(f"未知器官编号 {organ_id!r}，合法值：{sorted(_BY_ID)}") from None


def find_by_name(name: str) -> OrganSpec:
    """按名称查器官；未知名称显式报 KeyError。"""
    try:
        return _BY_NAME[name]
    except KeyError:
        raise KeyError(f"未知器官名称 {name!r}，合法值：{sorted(_BY_NAME)}") from None


def organ_dir(root: Path, spec: OrganSpec) -> Path:
    """器官在站根下的目录路径（不负责创建）。"""
    return Path(root) / spec.dirname
