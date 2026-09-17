# -*- coding: utf-8 -*-
"""主权卷宗 CLI。

用法：
  python -m paistation.sovereign.dossier build [--dest data/dossier]
  python -m paistation.sovereign.dossier export --dest tmp/dossier-export
  python -m paistation.sovereign.dossier status
  python -m paistation.sovereign.dossier verify <导出包路径>
"""
import argparse
import sys
from pathlib import Path

from . import build_dossier, export_dossier, repo_status, commit_snapshot
from ..format import manifest_validate


def _find_root() -> Path:
    """从模块位置向上找 pyproject.toml 锚点（src 布局/编辑安装两态皆稳）。"""
    for parent in Path(__file__).resolve().parents:
        if (parent / "pyproject.toml").is_file():
            return parent
    return Path.cwd()


ROOT = _find_root()
DATA = ROOT / "data"
DEFAULT_DOSSIER = DATA / "dossier"
DEFAULT_EVALS = [ROOT / "tests" / "fixtures" / "intent_golden.jsonl",
                 ROOT / "tests" / "fixtures" / "golden_qa.jsonl"]


def main(argv=None) -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace") if hasattr(
        sys.stdout, "reconfigure") else None
    ap = argparse.ArgumentParser(prog="dossier")
    sub = ap.add_subparsers(dest="cmd", required=True)
    p_build = sub.add_parser("build", help="构建/刷新卷宗树（快照式）")
    p_build.add_argument("--dest", default=str(DEFAULT_DOSSIER))
    p_build.add_argument("--no-commit", action="store_true")
    p_export = sub.add_parser("export", help="导出自包含人可读包")
    p_export.add_argument("--dest", required=True)
    p_status = sub.add_parser("status", help="卷宗 git 版本化状态")
    p_status.add_argument("--dir", default=str(DEFAULT_DOSSIER))
    p_verify = sub.add_parser("verify", help="校验导出包完整性")
    p_verify.add_argument("package")
    args = ap.parse_args(argv)

    if args.cmd == "build":
        report = build_dossier(DATA, Path(args.dest),
                               self_profile_dir=ROOT / "SELF_PROFILE",
                               eval_sources=DEFAULT_EVALS)
        print(f"built: {report}")
        if not args.no_commit:
            sha = commit_snapshot(args.dest, "dossier snapshot")
            print(f"git: {'commit ' + sha if sha else 'no changes'}")
        return 0
    if args.cmd == "export":
        report = export_dossier(DATA, args.dest,
                                self_profile_dir=ROOT / "SELF_PROFILE",
                                eval_sources=DEFAULT_EVALS)
        print(f"exported: {report['files']} files -> {report['dest']}")
        return 0
    if args.cmd == "status":
        print(repo_status(args.dir))
        return 0
    if args.cmd == "verify":
        report = manifest_validate(args.package)
        print(report)
        return 0 if report.get("ok") else 1
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
