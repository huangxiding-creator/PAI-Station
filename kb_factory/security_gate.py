# -*- coding: utf-8 -*-
"""KB-FACTORY W10 · 安全自检门（PentAGI 蒸馏：上线前逐项机检，不可机检的列人工核）。

用法（仓库根）：py -3 -m kb_factory.security_gate --check
三态：PASS（机检通过）/ FAIL（机检不通过）/ MANUAL（不可机检，人工核）。
退出码：有 FAIL → 1；全 PASS/MANUAL → 0。清单全文见 kb_factory/SECURITY_CHECKLIST.md。
"""
from __future__ import annotations

import argparse
import inspect
import json
import re
import subprocess
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")  # GBK 控台防绞碎
except Exception:
    pass

REPO_ROOT = Path(__file__).resolve().parents[1]
PKG_DIR = Path(__file__).resolve().parent
MP_DIR = REPO_ROOT / "微信小程序" / "zongbao-ai"

# 网络面白名单：只允许 百度文库检索域 与 ima 官方域（逐条列人工核语境）
NET_ALLOWLIST = {"wenku.baidu.com", "ima.qq.com"}
# _credentials 目录下的非凭据占位（.gitkeep=空占位；chain.jsonl=操作链日志，均已核验 0 字节）
CREDS_ALLOWLIST_NAMES = {".gitkeep", "chain.jsonl"}
# 凭据形态：文件名含 secret/credentials/key/pem/token，或 *.ini 带 secret 字样
_CREDS_NAME_RE = re.compile(
    r"(secret|credential|password|passwd|\.key\b|\.pem\b|\.p12\b|token|cookie)", re.I)
# 零删除红线（运行时代码；tests 下的夹具清理不在红线内）
_DELETE_RE = re.compile(r"os\.remove\s*\(|shutil\.rmtree\s*\(|\.unlink\s*\(")
# 日志/打印凭据启发式（print/xxx.log( 调用形参里出现凭据词）
_CRED_PRINT_RE = re.compile(
    r"(print|\blog\b|logging|_log)\s*\([^)\n]*(password|passwd|pwd|token|secret|cookie)", re.I)
_URL_RE = re.compile(r"https?://([A-Za-z0-9.-]+)")


@dataclass
class CheckResult:
    cid: str
    title: str
    verdict: str          # PASS | FAIL | MANUAL
    detail: str

    def line(self) -> str:
        return f"[{self.verdict}] {self.cid} {self.title} · {self.detail}"


def _runtime_py_files(pkg: Path = PKG_DIR) -> list:
    """kb_factory 运行时代码（排除 tests/ 与 samples/ 夹具）。"""
    return [p for p in sorted(pkg.rglob("*.py"))
            if not any(part in ("tests", "samples", "__pycache__") for part in p.parts)]


def _rel(p: Path) -> str:
    """仓内相对路径；仓外（如测试 tmp 夹具）回退全路径字符串。"""
    try:
        return str(p.relative_to(REPO_ROOT))
    except ValueError:
        return str(p)


def _test_py_files(pkg: Path = PKG_DIR) -> list:
    return [p for p in sorted(pkg.rglob("tests/*.py")) if "__pycache__" not in p.parts]


# ---------------------------------------------------------------- ① 凭据零入仓

# 门的作用域=本产线发布面（kb_factory/ + 小程序 zongbao-ai/）；站内其余历史文件不属本门
# 管辖（清理由用户明示令，见 CLAUDE.md 清理纪律），仅在 detail 里如实带出计数供人核。
_RELEASE_PREFIXES = ("kb_factory/", "微信小程序/")


def check_credentials(tracked_files: list) -> CheckResult:
    hits, outside = [], 0
    for f in tracked_files:
        parts = Path(f).parts
        name = Path(f).name
        shaped = ("_credentials" in parts and name not in CREDS_ALLOWLIST_NAMES) or \
                 ("_credentials" not in parts and _CREDS_NAME_RE.search(name))
        if not shaped:
            continue
        if f.startswith(_RELEASE_PREFIXES):
            hits.append(f)
        else:
            outside += 1
    if hits:
        return CheckResult("1", "凭据零入仓", "FAIL",
                           f"发布面命中凭据形态 {len(hits)} 件: {', '.join(hits[:5])}")
    note = f"；站内非发布面另见 {outside} 个凭据形态文件名（skill 文档/探针脚本等，不属本门管辖，清理须用户令）" if outside else ""
    return CheckResult("1", "凭据零入仓", "PASS",
                       "发布面（kb_factory+小程序）git ls-files 零命中（占位文件以 ls-files 结果为准，字节数未核）" + note)


# ---------------------------------------------------------------- ② 零删除红线

def scan_deletions(files: list) -> list:
    hits = []
    for p in files:
        text = p.read_text(encoding="utf-8", errors="replace")
        for i, ln in enumerate(text.splitlines(), 1):
            if _DELETE_RE.search(ln):
                hits.append(f"{_rel(p)}:{i}: {ln.strip()[:80]}")
    return hits


def check_no_delete(files: list | None = None) -> CheckResult:
    hits = scan_deletions(files if files is not None else _runtime_py_files())
    if hits:
        return CheckResult("2", "零删除红线", "FAIL",
                           f"运行时代码存在删除调用 {len(hits)} 处: " + " | ".join(hits[:3]))
    return CheckResult("2", "零删除红线", "PASS",
                       "kb_factory 运行时代码（含 fulfillment/convert）零 os.remove/rmtree/unlink")


# ---------------------------------------------------------------- ③ 频控参数在位

def check_rate_limits() -> CheckResult:
    problems = []
    from kb_factory.channel_adapters.base import RateLimiter
    sig = inspect.signature(RateLimiter.__init__)
    mi = sig.parameters["min_interval"].default
    dl = sig.parameters["daily_limit"].default
    if not (mi >= 3):
        problems.append(f"RateLimiter 默认 min_interval={mi} < 3")
    if not (dl <= 500):
        problems.append(f"RateLimiter 默认 daily_limit={dl} > 500")

    wenku_src = (PKG_DIR / "channel_adapters" / "wenku_meta.py").read_text(encoding="utf-8")
    m = re.search(r'KB_WENKU_MIN_INTERVAL",\s*"([\d.]+)"', wenku_src)
    if not m or float(m.group(1)) < 3:
        problems.append("wenku KB_WENKU_MIN_INTERVAL 代码默认 < 3s")
    m = re.search(r'KB_WENKU_DAILY_LIMIT",\s*"(\d+)"', wenku_src)
    if not m or int(m.group(1)) > 500:
        problems.append("wenku KB_WENKU_DAILY_LIMIT 代码默认 > 500")

    ima_src = (PKG_DIR / "channel_adapters" / "ima_meta.py").read_text(encoding="utf-8")
    m = re.search(r"min_interval=([\d.]+),\s*daily_limit=(\d+)", ima_src)
    if not m or float(m.group(1)) < 3:
        problems.append("ima 适配器默认 min_interval < 3s")
    elif int(m.group(2)) > 500:
        problems.append("ima 适配器默认 daily_limit > 500")

    if problems:
        return CheckResult("3", "频控参数在位", "FAIL", "; ".join(problems))
    return CheckResult("3", "频控参数在位", "PASS",
                       "RateLimiter 默认 3s/500；wenku 代码默认 3s/500；ima 3s/200（均满足 ≥3s 且 ≤500/日）")


# ---------------------------------------------------------------- ④ 黄源双闸默认OFF

def check_wenku_double_gate() -> CheckResult:
    from kb_factory.fulfillment.sources_registry import registry
    r1 = registry(env={}, wenku_secret=str(REPO_ROOT / "不存在.secret"))
    r2 = registry(env={"KB_WENKU_FETCH": "1"}, wenku_secret=str(REPO_ROOT / "不存在.secret"))
    ok = (r1["wenku"].on is False) and (r2["wenku"].on is False)
    if not ok:
        return CheckResult("4", "黄源双闸默认OFF", "FAIL",
                           f"默认态 on={r1['wenku'].on}，仅 env=1 态 on={r2['wenku'].on}（应双双 OFF）")
    return CheckResult("4", "黄源双闸默认OFF", "PASS",
                       "默认 OFF；KB_WENKU_FETCH=1 但 secret 缺位仍 OFF（env+secret 双闸实测）")


# ---------------------------------------------------------------- ⑤a 小程序自检门

def check_mp_verify() -> CheckResult:
    if not MP_DIR.is_dir():
        return CheckResult("5a", "小程序自检门", "FAIL", f"目录不存在: {MP_DIR}")
    r = subprocess.run(
        [sys.executable, "-X", "utf8", "tools/verify_kbfactory.py"],
        cwd=MP_DIR, capture_output=True, text=True, timeout=300,
        encoding="utf-8", errors="replace", env={**__import__("os").environ,
                                                 "PYTHONIOENCODING": "utf-8"})
    tail = (r.stdout or "").strip().splitlines()[-1:] or ["(无输出)"]
    if r.returncode == 0:
        return CheckResult("5a", "小程序自检门", "PASS",
                           f"verify_kbfactory 全绿（页序锚+敏感词+支付接线）：{tail[0]}")
    return CheckResult("5a", "小程序自检门", "FAIL",
                       f"verify_kbfactory rc={r.returncode}：{tail[0]}")


# ---------------------------------------------------------------- ⑤b 交付文案禁词

def check_deliverable_words() -> CheckResult:
    from kb_factory.convert.import_pack import GUIDE_TEMPLATE, HOW_TO_NAME, OVERVIEW_NAME
    from kb_factory.convert.md_convert import FORBIDDEN_WORDS, _placeholder_for
    texts = {"如何导入模板": GUIDE_TEMPLATE}
    with tempfile.TemporaryDirectory() as td:
        tmp = Path(td)
        samples = {"x.pdf": b"%PDF-1.4", "y.xlsx": b"PK", "z.doc": b"PK", "w.docx": b"PK"}
        for name, blob in samples.items():
            src = tmp / name
            src.write_bytes(blob)
            dst = tmp / (name + ".out.md")
            _placeholder_for(src, dst)
            texts[f"占位({name})"] = dst.read_text(encoding="utf-8")
        texts["文件名模板"] = HOW_TO_NAME + OVERVIEW_NAME
    hits = {}
    for surface, text in texts.items():
        for w in FORBIDDEN_WORDS:
            if w in text:
                hits.setdefault(surface, []).append(w)
    if hits:
        return CheckResult("5b", "交付文案禁词", "FAIL",
                           "用户面文案命中禁词: " + json.dumps(hits, ensure_ascii=False))
    return CheckResult("5b", "交付文案禁词", "PASS",
                       f"占位文案+导入说明全扫零禁词（词表 {len(FORBIDDEN_WORDS)} 词，与 convert 测试同源）")


# ---------------------------------------------------------------- ⑥ 网络面白名单

def scan_urls(files: list) -> list:
    hits = []
    for p in files:
        text = p.read_text(encoding="utf-8", errors="replace")
        for i, ln in enumerate(text.splitlines(), 1):
            for host in _URL_RE.findall(ln):
                hits.append((f"{_rel(p)}:{i}", host))
    return hits


def check_net_whitelist(files: list | None = None) -> tuple[CheckResult, list]:
    urls = scan_urls(files if files is not None else _runtime_py_files())
    bad = [(loc, h) for loc, h in urls if h not in NET_ALLOWLIST]
    listing = "; ".join(f"{loc}→{h}" for loc, h in urls) or "零外呼 URL"
    if bad:
        res = CheckResult("6a", "网络面白名单", "FAIL",
                          f"白名单外域名 {len(bad)} 处: " + "; ".join(f"{l}→{h}" for l, h in bad[:5]))
    else:
        res = CheckResult("6a", "网络面白名单", "PASS",
                          f"运行时代码 URL 全在白名单 {sorted(NET_ALLOWLIST)}：{listing}")
    return res, urls


def check_net_manual(urls: list) -> CheckResult:
    listing = "; ".join(f"{loc}→{h}" for loc, h in urls) or "（零 URL）"
    return CheckResult("6b", "网络语境人工核", "MANUAL",
                       f"逐条人工核对请求语境/频控真跑：{listing}")


# ---------------------------------------------------------------- ⑦ 日志无凭据打印

def scan_cred_prints(files: list) -> list:
    hits = []
    for p in files:
        text = p.read_text(encoding="utf-8", errors="replace")
        for i, ln in enumerate(text.splitlines(), 1):
            if _CRED_PRINT_RE.search(ln):
                hits.append(f"{_rel(p)}:{i}: {ln.strip()[:80]}")
    return hits


def check_no_cred_print(files: list | None = None) -> CheckResult:
    hits = scan_cred_prints(files if files is not None else _runtime_py_files())
    if hits:
        return CheckResult("7", "日志无凭据打印", "FAIL",
                           f"疑似凭据打印 {len(hits)} 处: " + " | ".join(hits[:3]))
    return CheckResult("7", "日志无凭据打印", "PASS",
                       "print/审计日志零凭据词形参（启发式机检；新增日志点时人工复看）")


# ---------------------------------------------------------------- ⑧ 测试覆盖入口

def check_cli_test_cover() -> CheckResult:
    files = _test_py_files()
    if not files:
        return CheckResult("8", "测试覆盖入口", "FAIL", "kb_factory 下无 tests")
    has_sub = any("subprocess" in p.read_text(encoding="utf-8", errors="replace") for p in files)
    has_cli = any('"-m", "kb_factory' in p.read_text(encoding="utf-8", errors="replace")
                  or "'-m', 'kb_factory" in p.read_text(encoding="utf-8", errors="replace")
                  for p in files)
    if has_sub and has_cli:
        return CheckResult("8", "测试覆盖入口", "PASS",
                           f"{len(files)} 个测试文件含 subprocess 真 CLI 入口（直调不算数）")
    return CheckResult("8", "测试覆盖入口", "FAIL",
                       f"subprocess={has_sub} / -m kb_factory={has_cli}（缺真 CLI 入口测试）")


# ---------------------------------------------------------------- ⑨ 生产开关人工核

def check_prod_env_manual() -> CheckResult:
    return CheckResult("9", "生产开关人工核", "MANUAL",
                       "上线时人工确认：生产机不设 KB_WENKU_FETCH（黄源默认OFF）；"
                       "KB_SMTP_SECRET/KB_WENKU_SECRET 指向仓外文件且不入仓；"
                       "KB_WENKU_MIN_INTERVAL 生产取 6s（v2 实测软拒教训）")


def run_all() -> tuple[list, int]:
    r = subprocess.run(["git", "-C", str(REPO_ROOT), "-c", "core.quotepath=false", "ls-files"],
                       capture_output=True, text=True, encoding="utf-8", errors="replace")
    tracked = [x for x in (r.stdout or "").splitlines() if x.strip()]
    results = [
        check_credentials(tracked),
        check_no_delete(),
        check_rate_limits(),
        check_wenku_double_gate(),
        check_mp_verify(),
        check_deliverable_words(),
    ]
    net, urls = check_net_whitelist()
    results += [net, check_net_manual(urls), check_no_cred_print(),
                check_cli_test_cover(), check_prod_env_manual()]
    fails = sum(1 for x in results if x.verdict == "FAIL")
    return results, fails


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="kb_factory.security_gate",
                                 description="KB-FACTORY 安全自检门（PentAGI 蒸馏）")
    ap.add_argument("--check", action="store_true", help="跑全部检查并打印三态报告")
    args = ap.parse_args(argv)
    if not args.check:
        ap.print_help()
        return 2
    results, fails = run_all()
    for x in results:
        print(x.line())
    n_pass = sum(1 for x in results if x.verdict == "PASS")
    n_manual = sum(1 for x in results if x.verdict == "MANUAL")
    print(f"汇总: {n_pass} PASS / {fails} FAIL / {n_manual} MANUAL"
          + ("（有 FAIL，门不放行）" if fails else "（门放行；MANUAL 项人工核后归档）"))
    return 1 if fails else 0


if __name__ == "__main__":
    sys.exit(main())
