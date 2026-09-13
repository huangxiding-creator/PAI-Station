"""E1 治理章程 v1：对外承诺三律（Ghost 律）+ open-core 切分。

三律：永不卖用户数据 / 数据本地优先 / 一键带走（export+heritage 已落地）。
机器可查一致性：章程列出的开源核心目录必须真实存在（说一套做一套=假章程）。
"""
from __future__ import annotations

from pathlib import Path

THREE_LAWS = (
    "永不卖用户数据：用户画像/记忆/决策是用户资产，绝不出售、绝不出租、绝不广告化",
    "数据本地优先：markdown/JSONL 明文落地本机，云同步是可选项不是前提",
    "一键带走：export/heritage 全量导出随时可用，数据可携带是退出权",
)

CORE_DIRS = (
    "src/paistation/sovereign",    # 主权层（P0）
    "src/paistation/gate",         # 验证资产（P4）
    "src/paistation/control",      # 控制面（P1）
    "src/paistation/market",       # 市场协议（P3）
    "src/paistation/channels",     # IM 通道
    "src/paistation/profile",      # 画像
    "src/paistation/memory",       # 记忆索引
    "src/paistation/skills",       # 技能载体
    "src/paistation/evolve",       # 进化引擎
)

COMMERCIAL_BOUNDARY = (
    "托管同步（多端 vault 同步服务）",
    "托管备份（加密异地备份）",
    "多端订阅（家庭/团队席位）",
    "验证资产市场抽成（签名 skill card 分发）",
)


def generate_charter() -> str:
    lines = [
        "# PAI-Station 治理章程 v1", "",
        "## 对外承诺三律（Ghost 律）", "",
        *[f"{i + 1}. {law}" for i, law in enumerate(THREE_LAWS)], "",
        "## 开源核心（用户主权不可收费的部分）", "",
        *[f"- `{d}`" for d in CORE_DIRS], "",
        "## 商业边界（收费只在托管与增值，不在主权）", "",
        *[f"- {b}" for b in COMMERCIAL_BOUNDARY], "",
        "## 一致性",
        "- 本章程由 `audit_charter` 机器校验：上述核心目录不存在即章程失效。",
    ]
    return "\n".join(lines) + "\n"


def audit_charter(repo_root: str | Path) -> dict:
    repo = Path(repo_root)
    missing = [d for d in CORE_DIRS if not (repo / d).is_dir()]
    return {"consistent": not missing, "core_dirs": list(CORE_DIRS),
            "missing": missing}
