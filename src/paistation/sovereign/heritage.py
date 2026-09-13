"""遗产模式（Phase A3）：公司死了 AI 还活着（Moxie/Dot 尸检律）。

heritage_bundle = 完整主权包 + OFFLINE.md（离线功能清单：本地可用 vs
需云分列）+ HEIRLOOM.md（继承指定）。全明文、无锁定、无加密——
「被收购即数据死」在设计上不可能。
"""
from __future__ import annotations

from pathlib import Path

from .protocol import export_vault

_LOCAL = (
    "记忆检索（memory.md / decisions/，markdown 明文，人可直接阅读）",
    "画像查询（profile.md 渲染视图 + profile-entries.jsonl 机器源）",
    "技能清单（skills-ledger.jsonl；技能本体在原安装的 skills/ 目录）",
    "审计与遗忘日志（forgotten.jsonl + MANIFEST.json 指纹校验）",
)
_CLOUD = (
    "LLM 对话/推理（智谱 API；可替换任意 OpenAI 兼容端点，模型无关）",
    "视觉感知（GLM-4.6V-Flash 免费链，同样可替换）",
)


def heritage_bundle(data_dir: str | Path, dest: str | Path,
                    heir: str = "", clock=None) -> dict:
    dest = Path(dest)
    dest.mkdir(parents=True, exist_ok=True)
    report = export_vault(data_dir, dest / "vault", clock=clock)
    (dest / "OFFLINE.md").write_text(_offline_md(), encoding="utf-8")
    (dest / "HEIRLOOM.md").write_text(_heirloom_md(heir), encoding="utf-8")
    return {"files": report["files"], "dest": str(dest)}


def _offline_md() -> str:
    lines = ["# 离线功能清单（遗产模式）", "",
             "本包不依赖任何公司存活。以下功能离线可用（无网环境）：", ""]
    lines += [f"- ✅ {item}" for item in _LOCAL]
    lines += ["", "需要联网（或更换供应商）：", ""]
    lines += [f"- ☁️ {item}" for item in _CLOUD]
    lines += ["", "## 复活指南", "",
              "1. 人读：任意 markdown 阅读器直接打开本包。",
              "2. 机读：新装任意支持主权导入的 agent（如 PAI-Station），"
              "执行 `pai sovereign import <本包/vault>`，资产 100% 复活；",
              "   或用适配器直通 Claude Code / OpenClaw / AstrBot。"]
    return "\n".join(lines) + "\n"


def _heirloom_md(heir: str) -> str:
    return f"""\
# 数字资产继承指定（HEIRLOOM）

本包是持有人的数字主权资产法定包（记忆 / 决策 / 画像 / 技能 / 声誉）。

- 继承人：{heir or "（待填写）"}
- 指定日期：（待填写）
- 生效条件：（待填写，如"原持有人失联 90 天"）

## 继承人须知

- 本包全部内容为 markdown / jsonl 明文，无加密、无锁定、无电话回家。
- forgotten.jsonl 记录了持有人已行使删除权的内容：请尊重其意愿，
  不要试图恢复。
- 技能本体在原安装的 skills/ 目录（清单见 vault/skills-ledger.jsonl），
  可直接复用或改造。
"""
