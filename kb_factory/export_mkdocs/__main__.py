# -*- coding: utf-8 -*-
"""命令行入口：py -3 -m export_mkdocs <蓝图.json> <out_dir>（回执 JSON 打 stdout）。

收口波/运维免写 Python 即可出预览骨架；判据②随后跑：
    py -3 -m mkdocs build --strict -f <out_dir>/mkdocs.yml
"""
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # kb_factory/ 入 sys.path

from export_mkdocs.exporter import export_mkdocs  # noqa: E402


def main(argv: list) -> int:
    if len(argv) != 3:
        print("用法: py -3 -m export_mkdocs <蓝图.json> <out_dir>", file=sys.stderr)
        return 2
    bp = json.loads(Path(argv[1]).read_text(encoding="utf-8"))
    receipt = export_mkdocs(bp, argv[2])
    print(json.dumps(receipt, ensure_ascii=True, indent=2))  # 控制台 GBK 安全
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
