# -*- coding: utf-8 -*-
"""pm_terminology — AI/研究用语 → 项目管理/水电工程用语 全文净化 (1103用户令)
用法: py -X utf8 pm_terminology.py <md文件路径>
"""
import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

#: AI/研究用语 → 工程用语 (有序, 先长后短)
REPLACEMENTS: list[tuple[str, str]] = [
    # ── 最高频AI研究腔 ──
    ("采信", "采用"),
    ("口径对照", "参数对照"),
    ("口径纪律", "数据管理纪律"),
    ("口径", "版本"),
    ("择源", "选定"),
    ("终裁", "审定"),
    ("裁决", "审定"),
    ("基线判定", "基线确定"),
    ("覆盖声明", ""),
    ("对标声明", ""),
    ("覆盖并超越", "全面执行并优化"),
    ("对标", "依据"),
    ("落位", "落实"),
    ("落成", "建成"),
    # ── AI方法论黑话 ──
    ("赋能", "支撑"),
    ("抓手", "重点"),
    ("底层逻辑", "基本原理"),
    ("颗粒度", "细化程度"),
    ("打法", "做法"),
    ("战役", ""),
    ("编织", "整合"),
    ("弹药", ""),
    ("军团", "体系"),
    ("心智", ""),
    ("认知", "理解"),
    # ── 研究/审查腔 ──
    ("声明", "说明"),
    ("呈报", "报告"),
    ("申明", "说明"),
    ("挂账", "列为跟踪事项"),
    ("承底稿", ""),
    ("底稿", ""),
    # ── 策划不需要的自证 ──
    ("我们计划这么做", "本策划安排"),
    ("不需要向谁", ""),
    # ── 冗余工程腔修正 ──
    ("闭环管控", "全过程管控"),
    ("闭环管理", "全过程管理"),
    ("闭环", "闭合"),
    ("穿透管控", "直接管控"),
    ("穿透", "直接"),
    ("部署章", "章"),
    ("部署节", "节"),
]


def clean(text: str) -> tuple[str, int]:
    total = 0
    for old, new in REPLACEMENTS:
        n = text.count(old)
        if n:
            text = text.replace(old, new)
            total += n
    # 清理残留双空格/空头
    text = re.sub(r"  +", " ", text)
    text = re.sub(r"\n{4,}", "\n\n\n", text)
    return text, total


def main() -> int:
    if len(sys.argv) < 2:
        print("用法: py -X utf8 pm_terminology.py <md>")
        return 1
    fp = Path(sys.argv[1])
    t = fp.read_text(encoding="utf-8")
    t2, n = clean(t)
    fp.write_text(t2, encoding="utf-8")
    print(f"[pm] {fp.name}: {n} replacements")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
