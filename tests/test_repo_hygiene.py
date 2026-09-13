"""仓库卫生守卫（Phase 10 Ralph S1 → 约束）。

教训来源：src/paistation/dist 包名撞了 .gitignore 的 dist/ 构建产物
规则，提交中途失败靠人工补救。本测试把这类事故变成永久约束：
源码树里的 .py 永远不允许被任何 ignore 规则吞掉。
"""
import subprocess
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def _check_ignore(paths: list[str]) -> list[str]:
    proc = subprocess.run(
        ["git", "check-ignore", *paths], cwd=str(ROOT),
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    return [ln for ln in proc.stdout.splitlines() if ln.strip()]


def test_no_source_file_gitignored():
    """src/paistation 全部 .py 必须可被 git 追踪（不被 ignore）。"""
    py_files = [str(p.relative_to(ROOT)).replace("\\", "/")
                for p in (ROOT / "src" / "paistation").rglob("*.py")]
    assert len(py_files) > 50                    # 树完整，防止误判空集
    swallowed = _check_ignore(py_files)
    assert swallowed == [], f"源码被 .gitignore 误吞：{swallowed}"


def test_packaging_sources_gitignored():
    """setup/ 源文件与 scripts/*.py 不许被吞（M6 分发层教训泛化）。

    setup/wheels/ 是 build.ps1 现生成的构建产物，合法被忽略，不计入。
    """
    targets = [str(p.relative_to(ROOT)).replace("\\", "/")
               for p in (ROOT / "setup").glob("*")
               if p.is_file()]
    targets += ["scripts/fetch_bge_m3.py", "scripts/acceptance_e2e.py",
                "conftest.py"]
    swallowed = _check_ignore(targets)
    assert swallowed == [], f"分发源文件被 .gitignore 误吞：{swallowed}"
