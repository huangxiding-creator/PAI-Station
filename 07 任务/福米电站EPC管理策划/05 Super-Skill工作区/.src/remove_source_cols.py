# -*- coding: utf-8 -*-
"""remove_source_cols — 全面清除表格中的来源/出处/状态列 (1103用户令: 全面清理)
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
OUT = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区\nblm_out")

#: 要删的列名关键词(含这些词的表头列→整列删)
KILL = ["出处", "来源/版本", "母版", "数据源", "状态", "资料与", "依据与", "依据/",
        "风险/缺口", "关联数据", "待补说明", "缺口说明", "版本出处"]

#: 保留的列名(精确匹配不删)
KEEP_EXACT = {"第一来源：资源置换收益金", "第二来源：上网电费收入（网关计量）",
              "证据链留存与归档要求", "证据留存与合规要件", "动作规范与证据留存",
              "证据包类别", "数据源与测量"}


def should_remove(col_name: str) -> bool:
    c = col_name.strip()
    if c in KEEP_EXACT:
        return False
    return any(k in c for k in KILL)


def main() -> int:
    total_cols = 0
    for fp in sorted(OUT.glob("_v2_ch*.md")) + [OUT / "_ch00_综合说明.md"]:
        if not fp.is_file():
            continue
        lines = fp.read_text(encoding="utf-8").split("\n")
        new_lines = []
        remove_idx = set()          # 本表要删的列号
        in_table = False
        n_removed = 0

        for i, ln in enumerate(lines):
            s = ln.strip()
            if not s.startswith("|"):
                if remove_idx:
                    n_removed += len(remove_idx)
                    remove_idx = set()
                in_table = False
                new_lines.append(ln)
                continue

            cells = ln.split("|")
            # 判断是否是表头行(下一行是分隔线)
            is_header = (i + 1 < len(lines)
                         and lines[i + 1].strip().startswith("|")
                         and "---" in lines[i + 1])

            if is_header:
                remove_idx = set()
                for j, c in enumerate(cells):
                    if should_remove(c):
                        remove_idx.add(j)

            if remove_idx:
                cells = [c for j, c in enumerate(cells) if j not in remove_idx]
                new_lines.append("|".join(cells))
            else:
                new_lines.append(ln)

        if remove_idx:
            n_removed += len(remove_idx)

        if n_removed:
            fp.write_text("\n".join(new_lines), encoding="utf-8")
            print(f"  {fp.name}: 删 {n_removed} 列")
            total_cols += n_removed

    print(f"TOTAL: {total_cols} 列删除")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
