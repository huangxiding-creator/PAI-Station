#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""v3_constitution_audit — 宪法红线审计件 (百倍V3 T-026, REQ-000 / REQ-003).

对两条 R0 宪法约束做**只读**审计; 本工具自身绝不执行任何删除 / 推送动作:

1. REQ-000 删除守卫: scan_deletion_calls 对给定文件/目录下的 .py 做正则扫描,
   危险模式至少覆盖 rmtree / os.remove / unlink 三类, 另带 os.rmdir 与
   shutil.move; 后者目标是否存在静态不可判定, 命中一律按观察级上报。
   白名单 = tests/ 目录下文件名含 test_ 的文件里、行内含 tmp 的临时目录
   清理语句跳过。默认入口扫描 git status --porcelain 变更集(含 ?? 未跟踪)
   中 reforge_factory/ 与 _proposals/flagship-paid-report-1007/work/ 的 .py。

2. REQ-003 推送冻结对账: audit_push_freeze 用 merge-base --is-ancestor 判
   origin/main 是否为 main 的祖先 —— 是 = 本地领先/冻结健康 PASS; 否 = 远程
   存在本地没有的提交(有人推过) VIOLATED; 无 origin/main → 无从违反记
   PASS(无远程跟踪); git 异常一律 fail-closed 记 VIOLATED。

CLI: py reforge_factory/v3_constitution_audit.py [--json] [paths...]
     退出码 0 = 通过, 2 = 违宪(删除命中或对账 violated)。
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from pathlib import Path
from typing import Iterable, List, Optional, Tuple

# 管道/重定向下 Windows 默认 locale(GBK) 会与 UTF-8 消费端错配; 真实控制台
# 走 WinAPI 宽字符输出不受影响。reconfigure 仅让捕获/CI 场景可读。
try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")
except (AttributeError, ValueError):
    pass

# 默认入口审计范围(相对仓库根, 正斜杠): 变更集内这些前缀下的 .py 才扫
SCOPE_PREFIXES = (
    "reforge_factory/",
    "_proposals/flagship-paid-report-1007/work/",
)

# 危险模式(REQ-000): (模式名, 正则)。至少覆盖 rmtree / os.remove / unlink。
DANGEROUS_PATTERNS: List[Tuple[str, "re.Pattern[str]"]] = [
    ("rmtree", re.compile(r"\brmtree\s*\(")),
    ("os.remove", re.compile(r"\bos\.remove\s*\(")),
    ("os.rmdir", re.compile(r"\bos\.rmdir\s*\(")),
    ("unlink", re.compile(r"\.unlink\s*\(")),
    ("shutil.move", re.compile(r"\bshutil\.move\s*\(")),
]


def _run_git(args: List[str], cwd: Optional[Path] = None) -> Tuple[int, str]:
    """只读执行一条 git 命令, 返回 (returncode, stdout)。不跑任何 git 写操作。"""
    proc = subprocess.run(
        ["git", *args], cwd=cwd, capture_output=True, text=True,
        encoding="utf-8", errors="replace",
    )
    return proc.returncode, proc.stdout.strip()


def _find_repo_root() -> Path:
    """从本文件向上找含 .git 的目录; 找不到退回 cwd。"""
    for base in Path(__file__).resolve().parents:
        if (base / ".git").exists():
            return base
    return Path.cwd()


def _whitelisted(path: Path, line: str) -> bool:
    """REQ-000 白名单: tests/ 下文件名含 test_ 的文件里, tmp 目录清理跳过。

    规范口径 = 调用对象含 tmp_path/tmp/, 或文件在 tests/ 目录且行含 tmp
    (前者是后者的子集, 实际归并为: tests/test_* 文件中行含 tmp)。
    """
    if "tests" not in path.parts or "test_" not in path.name:
        return False
    if "tmp_path" in line or "tmp/" in line:
        return True
    return "tmp" in line


def _collect_py_files(paths: Iterable[Path]) -> List[Path]:
    """把入参(文件/目录混合)归并为待扫 .py 文件清单; 目录递归、跳过 __pycache__。"""
    files = set()
    for p in map(Path, paths):
        if p.is_dir():
            for q in p.rglob("*.py"):
                if "__pycache__" not in q.parts:
                    files.add(q)
        elif p.is_file() and p.suffix == ".py":
            files.add(p)
    return sorted(files)


def scan_deletion_calls(paths: Iterable[Path]) -> List[dict]:
    """删除守卫扫描: 返回命中清单 [{file, line, code, pattern}]。

    对每个 .py 逐行匹配 DANGEROUS_PATTERNS; tests 白名单命中不计入;
    同一行只记第一个命中的模式; 结果按 (file, line) 排序保证确定性。
    """
    hits: List[dict] = []
    for f in _collect_py_files(paths):
        try:
            text = f.read_text(encoding="utf-8", errors="replace")
        except OSError:
            continue
        for lineno, line in enumerate(text.splitlines(), 1):
            for name, rx in DANGEROUS_PATTERNS:
                if rx.search(line):
                    if _whitelisted(f, line):
                        break
                    hits.append({
                        "file": str(f),
                        "line": lineno,
                        "code": line.strip(),
                        "pattern": name,
                    })
                    break
    hits.sort(key=lambda h: (h["file"], h["line"]))
    return hits


def collect_changed_scope(repo_root: Path) -> List[Path]:
    """默认入口目标: git status --porcelain 变更集(含未跟踪 ??)里,
    SCOPE_PREFIXES 前缀下的 .py 文件; 未跟踪目录整目录代入由扫描器递归。
    只读, 解析失败(非仓库等)返回空表。
    """
    rc, out = _run_git(["status", "--porcelain"], cwd=repo_root)
    if rc != 0:
        return []
    targets: List[Path] = []
    for raw in out.splitlines():
        if len(raw) < 4:
            continue
        entry = raw[3:].strip()
        if entry.startswith('"') and entry.endswith('"'):
            entry = entry[1:-1]
        if " -> " in entry:                       # 重命名取新路径一侧
            entry = entry.rsplit(" -> ", 1)[1]
        norm = entry.replace("\\", "/").rstrip("/")
        if not norm.startswith(SCOPE_PREFIXES):
            continue
        p = repo_root / norm
        if p.is_dir():
            targets.append(p)
        elif p.is_file() and norm.endswith(".py"):
            targets.append(p)
    return targets


def audit_push_freeze(repo_root: Optional[Path] = None) -> dict:
    """REQ-003 推送冻结对账(只读)。

    origin/main 是 main 祖先 → pass(本地领先/冻结健康); 不是 → violated
    (远程有本地没有的提交, 疑似有人 push); 无 origin/main → pass(无远程跟踪);
    main 解析失败或 merge-base 异常 → fail-closed 记 violated。
    """
    cwd = repo_root if repo_root is not None else _find_repo_root()
    rc, out = _run_git(["rev-parse", "--verify", "origin/main"], cwd=cwd)
    if rc != 0:
        return {"status": "pass",
                "reason": "无远程跟踪 (origin/main 不存在), 推送冻结无从违反",
                "origin_main": None, "local_main": None}
    origin = out
    rc2, out2 = _run_git(["rev-parse", "--verify", "main"], cwd=cwd)
    if rc2 != 0:
        return {"status": "violated",
                "reason": "main 分支无法解析, 推送冻结对账 fail-closed",
                "origin_main": origin, "local_main": None}
    local = out2
    rc3, _ = _run_git(["merge-base", "--is-ancestor",
                       "origin/main", "main"], cwd=cwd)
    if rc3 == 0:
        return {"status": "pass",
                "reason": "origin/main 是 main 的祖先 — 本地领先/同步, 冻结健康",
                "origin_main": origin, "local_main": local}
    if rc3 == 1:
        return {"status": "violated",
                "reason": "远程有本地没有的提交 (origin/main 非 main 祖先) — "
                          "疑似有人 push, 违反推送冻结令",
                "origin_main": origin, "local_main": local}
    return {"status": "violated",
            "reason": "merge-base 对账异常 (exit %d), fail-closed" % rc3,
            "origin_main": origin, "local_main": local}


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser(
        description="宪法红线审计件: REQ-000 删除守卫扫描 + REQ-003 推送冻结对账 "
                    "(只读审计, 退出码 0=通过 / 2=违宪)")
    parser.add_argument("--json", action="store_true",
                        help="输出 JSON 而非人类可读摘要")
    parser.add_argument("paths", nargs="*", type=Path,
                        help="可选: 显式指定要扫描的文件/目录; "
                             "缺省扫描 git 变更集内宪法管辖路径")
    args = parser.parse_args(argv)

    repo = _find_repo_root()
    targets = args.paths if args.paths else collect_changed_scope(repo)
    scanned = _collect_py_files(targets)
    hits = scan_deletion_calls(targets)
    freeze = audit_push_freeze(repo)
    ok = (not hits) and freeze["status"] == "pass"
    result = {
        "audit": "v3_constitution_audit",
        "deletion_guard": {"scanned_files": len(scanned),
                           "hit_count": len(hits), "hits": hits},
        "push_freeze": freeze,
        "verdict": "pass" if ok else "violated",
    }
    if args.json:
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        print("[宪法审计·REQ-000 删除守卫] 扫描 %d 个 .py 文件, 命中 %d 处"
              % (len(scanned), len(hits)))
        for h in hits:
            print("  命中 %s:%d [%s] %s"
                  % (h["file"], h["line"], h["pattern"], h["code"]))
        print("[宪法审计·REQ-003 推送冻结] %s — %s"
              % (freeze["status"].upper(), freeze["reason"]))
        print("结论: %s" % ("通过 (exit 0)" if ok else "违宪 (exit 2)"))
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(main())
