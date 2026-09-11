# -*- coding: utf-8 -*-
"""M8.2 器官宪法引导器：从 organ.registry 单一事实源生成 12 器官落地件。

幂等：README/_state/子目录已存在则跳过（只增不删红线）。
生成物：README.md（器官宪法）+ _state.json（液态状态，items 按实测计数）
      + 子目录骨架（.gitkeep 占位）。
用法：PYTHONPATH=src python tools/bootstrap_organs.py [--root E:\\AI-Station]
"""
import argparse
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.organ.registry import ORGANS, organ_dir  # noqa: E402
from paistation.organ.state import OrganState, save_state  # noqa: E402

README_TMPL = """# {dirname} —— 器官宪法

> 液态架构 12 器官之一（PROPOSAL_V2.md 第 3 章）。本文件是器官的宪法：
> 使命、边界、IO 契约、质量门、自主更新触发器。引擎只是代谢层，可换；器官与数据不朽。

## 使命
{mission}

## IO 契约
- **输入**：{inputs}
- **输出**：{outputs}

## 质量门（出厂标准）
{quality_gate}

## 自主更新触发器
{trigger}

## 目录结构
{subdirs}

## 液态状态
`_state.json`：水位（watermark）/ 条目计数（items）/ 新鲜度（freshness）/
健康度（health）/ 上次同步（last_sync）。由引擎经 `paistation.organ.state`
原子更新，水位只前进不后退。

## 流转凭证（红线 R14）
器官间一切交接落 `_credentials/chain.jsonl`（带 sha256 摘要，可审计）。
引擎禁止直写本器官之外的任何器官内部。
"""

GITKEEP = ".gitkeep"


def count_items(directory: Path) -> int:
    """器官当前条目计数（全部文件，不含宪法/状态/凭证自件）。"""
    if not directory.exists():
        return 0
    skip = {"README.md", "_state.json", CRED_DIR, GITKEEP}
    return sum(1 for p in directory.rglob("*")
               if p.is_file() and p.name not in skip
               and CRED_DIR not in p.parts)


CRED_DIR = "_credentials"


def bootstrap(root: Path) -> dict:
    """逐器官落宪法/状态/骨架。返回执行摘要。"""
    summary = {}
    for spec in ORGANS:
        directory = organ_dir(root, spec)
        directory.mkdir(parents=True, exist_ok=True)
        actions = []

        readme = directory / "README.md"
        if not readme.exists():
            subdirs = "\n".join(f"- `{d}/`" for d in spec.subdirs) or "（无子目录）"
            readme.write_text(README_TMPL.format(
                dirname=spec.dirname, mission=spec.mission,
                inputs="、".join(spec.inputs), outputs="、".join(spec.outputs),
                quality_gate=spec.quality_gate, trigger=spec.trigger,
                subdirs=subdirs), encoding="utf-8")
            actions.append("README")

        cred_keep = directory / CRED_DIR / GITKEEP
        if not cred_keep.exists():
            cred_keep.parent.mkdir(parents=True, exist_ok=True)
            cred_keep.write_text("", encoding="utf-8")
            actions.append("credentials")
        for sub in spec.subdirs:
            sub_dir = directory / sub
            sub_dir.mkdir(parents=True, exist_ok=True)
            keep = sub_dir / GITKEEP
            if not keep.exists():
                keep.write_text("", encoding="utf-8")

        state_file = directory / "_state.json"
        if not state_file.exists():
            save_state(root, OrganState(organ_id=spec.id,
                                        items=count_items(directory)))
            actions.append("state")

        summary[spec.dirname] = actions or ["已就绪（跳过）"]
    return summary


def main() -> int:
    parser = argparse.ArgumentParser(description="12 器官宪法引导")
    parser.add_argument("--root", default=str(Path(__file__).resolve().parents[1]),
                        help="站根目录（默认：仓库根）")
    args = parser.parse_args()
    root = Path(args.root).resolve()

    summary = bootstrap(root)
    for name, actions in summary.items():
        print(f"{name:12s} -> {', '.join(actions)}")
    print(f"\n完成：{len(summary)} 器官就绪（root={root}）")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
