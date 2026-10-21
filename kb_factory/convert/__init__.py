"""KB-FACTORY W8 · 交付包转换层：轻便阅读版（Markdown版）+ 随身导入包。

CLI（仓库根运行）：
  py -3 -m kb_factory.convert --md <交付包目录>        # 生成 Markdown 版（目录旁 {包名}_md）
  py -3 -m kb_factory.convert --import <交付包目录>    # 生成随身导入包（{库名}_import_pack.zip）
  可选 --dst <目录> 指定输出位置。
pandoc 定位：环境变量 KB_PANDOC > 站内 E:\\AI-Station\\tools\\pandoc-3.11\\pandoc.exe > PATH。
"""
from __future__ import annotations

import argparse
import sys

from kb_factory.convert.import_pack import HOW_TO_NAME, OVERVIEW_NAME, make_import_pack
from kb_factory.convert.md_convert import REPORT_NAME, convert_package

__all__ = [
    "convert_package",
    "make_import_pack",
    "REPORT_NAME",
    "HOW_TO_NAME",
    "OVERVIEW_NAME",
    "main",
]


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(
        prog="kb_factory.convert",
        description="KB 交付包转换：轻便阅读版（Markdown版）/ 随身导入包",
    )
    parser.add_argument("--md", metavar="SRC_DIR", help="生成 Markdown 版交付包")
    parser.add_argument("--import", dest="import_src", metavar="SRC_DIR", help="生成随身导入包 zip")
    parser.add_argument("--dst", metavar="DIR", help="可选输出目录")
    args = parser.parse_args(argv)

    if not args.md and not args.import_src:
        parser.print_help()
        return 2
    if args.md:
        try:
            dst = convert_package(args.md, args.dst)
        except FileNotFoundError as e:
            print(f"错误：{e}（请用 --md 指向交付包目录）", file=sys.stderr)
            return 2
        print(f"Markdown 版已生成: {dst}（报告: {dst / REPORT_NAME}）")
    if args.import_src:
        try:
            zip_path = make_import_pack(args.import_src, args.dst)
        except FileNotFoundError as e:
            print(f"错误：{e}（请用 --import 指向交付包目录）", file=sys.stderr)
            return 2
        print(f"随身导入包已生成: {zip_path}（含 {HOW_TO_NAME} / {OVERVIEW_NAME}）")
    return 0


if __name__ == "__main__":
    sys.exit(main())
