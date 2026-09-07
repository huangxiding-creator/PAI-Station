"""入口：装配各引擎、启动调度器。

M0 骨架阶段仅支持 `--check`（INI 配置校验）与 `--version`；
引擎装配随里程碑逐个接入（见附录 P 逐日计划）。
"""
import argparse
import os
import sys

from paistation import __version__, config

# 配置文件解析顺序：项目根 config/pai.ini，可用环境变量 PAI_INI 覆盖
DEFAULT_INI = os.path.join(os.path.dirname(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__)))), "config", "pai.ini")


def check(config_path: str) -> int:
    """全量校验（附录 C.4）：五类错误中文报错，非法即拒绝。"""
    try:
        config.load(config_path)
    except config.ConfigError as exc:
        print(f"[check] 配置非法：{exc}")
        return 1
    print(f"[check] OK config={config_path}")
    return 0


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(prog="paistation",
                                 description="PAI-Station 个人超级 AI 工作站")
    ap.add_argument("--check", action="store_true", help="校验配置文件后退出")
    ap.add_argument("--config", default=os.environ.get("PAI_INI", DEFAULT_INI),
                    help=f"INI 路径（默认 {DEFAULT_INI}，环境变量 PAI_INI 可覆盖）")
    ap.add_argument("--version", action="version",
                    version=f"paistation {__version__}")
    args = ap.parse_args(argv)
    if args.check:
        return check(args.config)
    ap.print_help()
    return 0


if __name__ == "__main__":
    sys.exit(main())
