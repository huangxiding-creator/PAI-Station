# -*- coding: utf-8 -*-
"""KB-HARVEST 发布门（T43 · FR11.AC1 / NFR3 / NFR6）——四门逐门机检，全 PASS 才放行。

用法（仓库根）：``py -3 kb_factory/harvest_engine/tools/release_gate.py`` 退出码 0=四门全过。

四门（REQUIREMENTS「W8→W10 准入」=RELEASE 前安全门+NFR3/NFR6 扫描零命中+PentAGI P0 清零）：

- **G1 NFR3 密钥明文扫描**：引擎源码面（``*.py``/``*.md``；排除 ``__pycache__``、
  ``tests/fixtures/`` 离线夹具面、``e2e/artifacts/`` 运行件——边界如实打印）三条规则：
  R1 凭据名=字符串字面量赋值、R2 BDUSS/STOKEN/BAIDUID/BDCLND cookie 字面量、
  R3 Bearer/sk- 密钥字面量。豁免表只存 sha256（值永不复制进本件），逐值注记理由；
- **G2 NFR6 license 扫描**：运行面代码（排除 tests 夹具）AST import 根零 GPL/AGPL
  （禁根 fitz=AGPL、doc88_extractor=原 GPL 码、presse/ffdec=防误引入）；FFDec/presse
  =GPL-3.0 **仅子进程调用不进仓**（``tools/LICENSES.md`` 本机实测核对表在案）；
- **G3 check_p0 子进程**：``engine/PENTAGI/check_p0.py`` 退出码 0（4 份研判 16 条
  P0 已于 2026-10-23 全清偿，FR10.1 硬门）；
- **G4 pytest 全套**：``KB_HARVEST_SKIP_LIVE=1`` 跑全测试套件（实弹用例跳过且明示；
  发布门口径=离线全过+三链验收+E2E 证据在档——三链/全链件见 RELEASE.md 章③）。

铁律（SECURITY_CHECKLIST 同源）：门不通过=改代码/改配置，绝不改门；数字零造假。
``--skip-pytest`` 仅限门器自测快测档（G4 显式 SKIPPED 不冒充 PASS），验收命令勿带。
"""
from __future__ import annotations

import argparse
import hashlib
import os
import re
import subprocess
import sys
from dataclasses import dataclass
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):  # Windows 管道 cp936 防 CJK 乱码
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

_TOOLS_DIR = Path(__file__).resolve().parent          # …/kb_factory/harvest_engine/tools
ENGINE_DIR = _TOOLS_DIR.parent                         # …/kb_factory/harvest_engine
REPO_ROOT = ENGINE_DIR.parents[1]                      # E:\AI-Station
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))                 # 脚本直跑（非 -m）时补仓根

#: PentAGI P0 全清检查器（engine/PENTAGI=gitignored 工作区，open问题①裁定）
CHECK_P0 = REPO_ROOT / "07 任务" / "自动建库Agent" / "engine" / "PENTAGI" / "check_p0.py"

# --------------------------------------------------------------- G1 · NFR3 规则

#: 凭据形态词（赋值/字典键两侧均命中）
_CRED_NAME = r"(?:password|passwd|pwd|secret|token|cookie|api_?key|access_?key|bduss|authorization)"
_RULES: dict[str, re.Pattern[str]] = {
    "R1": re.compile(_CRED_NAME + r"\s*[:=]\s*[\"']([^\"'\n]{8,})[\"']", re.I),
    "R2": re.compile(r"\b(?:BDUSS|STOKEN|BAIDUID|BDCLND)\s*=\s*[A-Za-z0-9%~._-]{12,}"),
    "R3": re.compile(r"[\"'](?:Bearer\s+[A-Za-z0-9._-]{16,}|sk-[A-Za-z0-9]{16,})[\"']"),
}
#: 占位值（不算明文密钥）：x 串/星点串/尖括号模板/${…}/%s/常见占位词前缀
_PLACEHOLDER_RE = re.compile(
    r"^(?:x{3,}|[\*\.\u2026]+|<[^>]{0,40}>|\$\{[^}]{0,40}\}|%[sd]|"
    r"(?:stub|dummy|fake|mock|test|sample|example|placeholder|your|todo|none|null|n/a)[\w.\-]*)$",
    re.I)
#: 豁免表：sha256(值) → 注记理由（**只存哈希**，样本值不复制进本件——自扫描不自杀）。
#: 两值均为「站点侧短时公开口令/上游公开测试常量」，非我方凭据（密钥永不进仓铁律不受影响）：
#: ① book118 匿名 openapi view_token=T19 活探针留档样本（2026-10-22 匿名捕获，任务卡令
#:    留档复核算；tests/test_book118_preview.py LIVE_TOKEN 与夹具 _probe_t19_*.html 同值）；
#: ② 上游 DocumentBrowserTest.PREVIEW_PAGE 公开金样 view_token（GPL 原工具仓公开测试
#:    常量原文，非凭据；tests/test_inline_var.py 等金样复用）。
NFR3_EXEMPT: dict[str, str] = {
    "049266feedbd080801ebe10f48b1795b30d3bd116aa3c8f2996011f8b7e642c6":
        "book118 匿名 openapi view_token（T19 活探针留档样本，站方短时预览口令/零账号态）",
    "d0551e5311f76bc307ca9a6bcaf6e0b34e6097a1a23e4c65c99af72894461e35":
        "上游 DocumentBrowserTest.PREVIEW_PAGE 公开金样 view_token（原工具仓公开常量，非凭据）",
}

#: 扫描面：引擎仓内 *.py/*.md（排除 __pycache__、tests/fixtures 夹具面、e2e/artifacts 运行件）
_SCAN_SUFFIXES = {".py", ".md"}


@dataclass
class Hit:
    """一条未豁免命中（rule=规则号，path=引擎相对路径，line=行号，match=命中截断）。"""
    rule: str
    path: str
    line: int
    match: str


def _is_exempt(value: str) -> bool:
    return hashlib.sha256(value.encode("utf-8")).hexdigest() in NFR3_EXEMPT


def nfr3_scan_lines(samples: list[tuple[str, str]]) -> list[Hit]:
    """逐行扫描接口（测试用）：``[(文件名, 行文本), …]`` → 未豁免命中列表。"""
    hits: list[Hit] = []
    for name, text in samples:
        for i, ln in enumerate(text.splitlines(), 1):
            hits.extend(_scan_line(name, i, ln))
    return hits


def _scan_line(name: str, i: int, ln: str) -> list[Hit]:
    out: list[Hit] = []
    for rule, rx in _RULES.items():
        for m in rx.finditer(ln):
            value = m.group(1) if m.lastindex else m.group(0)
            if _PLACEHOLDER_RE.match(value.strip()) or _is_exempt(value):
                continue
            out.append(Hit(rule, name, i, m.group(0)[:72]))
    return out


def _scan_files() -> list[Path]:
    skip_dirs = {"__pycache__"}
    skip_roots = [ENGINE_DIR / "tests" / "fixtures", ENGINE_DIR / "e2e" / "artifacts"]
    files: list[Path] = []
    for p in sorted(ENGINE_DIR.rglob("*")):
        if p.suffix not in _SCAN_SUFFIXES or not p.is_file():
            continue
        if any(part in skip_dirs for part in p.parts):
            continue
        if any(p.is_relative_to(root) for root in skip_roots):
            continue
        files.append(p)
    return files


# --------------------------------------------------------------- G2 · NFR6 规则

#: 禁根：fitz=PyMuPDF(AGPL)；doc88_extractor=原 GPL 码（DOC88_SPEC §4 方案B 零 import）；
#: presse/ffdec=GPL-3.0 工具本体（防未来误引入模块面；现役=仅子进程，见 LICENSES.md）
GPL_BANNED_ROOTS = frozenset({"fitz", "doc88_extractor", "presse", "ffdec"})


def import_roots(source: str) -> set[str]:
    """源码 → AST import 根名集合（import x.y / from x.y import z 均归到 x）。"""
    import ast
    roots: set[str] = set()
    for node in ast.walk(ast.parse(source)):
        if isinstance(node, ast.Import):
            roots.update(alias.name.split(".")[0] for alias in node.names)
        elif isinstance(node, ast.ImportFrom) and node.module:
            roots.add(node.module.split(".")[0])
    return roots


def _runtime_py_files() -> list[Path]:
    return [p for p in _scan_files()
            if p.suffix == ".py" and "tests" not in p.parts]  # 运行面（夹具/单测不入）


# --------------------------------------------------------------- 四门判定

def gate1_nfr3_secrets() -> tuple[bool, str]:
    """G1：NFR3 密钥明文扫描——未豁免命中 0 才 PASS。"""
    files = _scan_files()
    hits: list[Hit] = []
    for p in files:
        for i, ln in enumerate(p.read_text(encoding="utf-8", errors="replace").splitlines(), 1):
            hits.extend(_scan_line(str(p.relative_to(ENGINE_DIR)).replace("\\", "/"), i, ln))
    scope = (f"扫描 {len(files)} 文件（*.py/*.md；排除 __pycache__、tests/fixtures 夹具面、"
             f"e2e/artifacts 运行件）；规则 R1 凭据字面量/R2 BDUSS 族 cookie/R3 Bearer·sk-")
    if hits:
        shown = " | ".join(f"{h.path}:{h.line}({h.rule}): {h.match}" for h in hits[:5])
        return False, f"FAIL——未豁免命中 {len(hits)} 处: {shown}…（{scope}）"
    return True, (f"PASS——未豁免命中 0；豁免 {len(NFR3_EXEMPT)} 值（sha256 表，理由注记在案）；{scope}")


def gate2_nfr6_license() -> tuple[bool, str]:
    """G2：NFR6 license 扫描——运行面零 GPL import + GPL-3.0 子进程注记。"""
    bad: list[str] = []
    for p in _runtime_py_files():
        roots = import_roots(p.read_text(encoding="utf-8", errors="replace"))
        found = sorted(GPL_BANNED_ROOTS & roots)
        if found:
            bad.append(f"{p.relative_to(ENGINE_DIR)}→{','.join(found)}")
    note = ("FFDec/presse=GPL-3.0 仅子进程调用不进仓（tools/LICENSES.md 本机实测核对表在案；"
            "FFDec 26.4.0=java -jar 子进程，presse=独立进程 merge；doc88_extractor=方案B 机制重写零 import）")
    if bad:
        return False, f"FAIL——禁根命中 {len(bad)} 文件: {' | '.join(bad[:5])}"
    return True, f"PASS——运行面零 GPL/AGPL import（禁根 {sorted(GPL_BANNED_ROOTS)}）；{note}"


def gate3_check_p0() -> tuple[bool, str]:
    """G3：PentAGI P0 全清（check_p0.py 子进程；FR10.1 发布硬门）。"""
    if not CHECK_P0.is_file():
        return False, f"FAIL——check_p0.py 不在位: {CHECK_P0}"
    proc = subprocess.run([sys.executable, str(CHECK_P0)],
                          capture_output=True, text=True, encoding="utf-8", errors="replace",
                          timeout=300)
    out = (proc.stdout or "").strip().splitlines()
    tail = out[-1] if out else "(无输出)"
    return proc.returncode == 0, f"{'PASS' if proc.returncode == 0 else 'FAIL'}——{tail}"


def gate4_pytest() -> tuple[bool, str]:
    """G4：pytest 全套（KB_HARVEST_SKIP_LIVE=1 实弹跳过=发布门口径明示）。"""
    env = {**os.environ, "KB_HARVEST_SKIP_LIVE": "1"}
    # 注意：仓根 pyproject 已有 addopts="-q"——此处再传 -q 会叠加成 -qq（吞掉
    # 「N passed, M skipped」计数行），故只传路径与插件开关，保持单层 -q。
    cmd = [sys.executable, "-m", "pytest", "kb_factory/harvest_engine/tests",
           "-p", "no:cacheprovider"]
    try:
        proc = subprocess.run(cmd, cwd=str(REPO_ROOT), env=env,
                              capture_output=True, text=True,
                              encoding="utf-8", errors="replace", timeout=5400)
    except subprocess.TimeoutExpired:
        return False, "FAIL——pytest 全套 5400s 超时（含 OCR/浏览器用例，检查挂死用例）"
    summary = ""
    for ln in reversed((proc.stdout or "").strip().splitlines()):
        if " passed" in ln or " failed" in ln or "error" in ln.lower():
            summary = ln.strip()
            break
    verdict = "PASS" if proc.returncode == 0 else "FAIL"
    extra = ("（KB_HARVEST_SKIP_LIVE=1 实弹用例跳过须明示；发布门口径=离线全过+三链验收"
             "+E2E 证据在档，见 RELEASE.md 章③）")
    if proc.returncode == 0:
        return True, f"{verdict}——{summary or '全套退出码 0'} {extra}"
    tail = "\n".join((proc.stdout or "").strip().splitlines()[-12:])
    return False, f"{verdict}——{summary or '退出码非 0'} {extra}\n{tail}"


# --------------------------------------------------------------- 汇编

_GATES = (("G1", "NFR3 密钥明文", gate1_nfr3_secrets),
          ("G2", "NFR6 license", gate2_nfr6_license),
          ("G3", "PentAGI P0", gate3_check_p0),
          ("G4", "pytest 全套", gate4_pytest))


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="KB-HARVEST 发布门（四门机检）")
    ap.add_argument("--skip-pytest", action="store_true",
                    help="快测档：G4 显式 SKIPPED（仅限门器自测，验收命令勿带）")
    args = ap.parse_args(argv)

    print("=" * 78)
    print(f"KB-HARVEST 发布门（T43 · FR11.AC1/NFR3/NFR6）扫描面: kb_factory/harvest_engine")
    print("=" * 78)
    results: list[tuple[str, str, bool]] = []
    for gid, title, fn in _GATES:
        if args.skip_pytest and gid == "G4":
            print(f"[{gid}] {title} · SKIPPED——--skip-pytest 快测档（非发布口径，实弹跳过"
                  f"口径同样适用 KB_HARVEST_SKIP_LIVE=1）")
            continue
        ok, detail = fn()
        print(f"[{gid}] {title} · {detail}")
        results.append((gid, title, ok))
    if args.skip_pytest:
        ok_all = all(ok for _, _, ok in results)
        verdict = "PASS" if ok_all else "FAIL"
        print(f"release_gate: {verdict}——快测档 G1-G3 {'全过' if ok_all else '有 FAIL'} + G4 SKIPPED"
              f"（发布须跑四门全判）")
        return 0 if ok_all else 1
    ok_all = all(ok for _, _, ok in results)
    tally = "/".join(gid for gid, _, ok in results if not ok) or "4/4 门过"
    print(f"release_gate: {'PASS' if ok_all else 'FAIL'}——{tally}")
    return 0 if ok_all else 1


if __name__ == "__main__":
    sys.exit(main())
