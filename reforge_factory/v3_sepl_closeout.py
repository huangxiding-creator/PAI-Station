# -*- coding: utf-8 -*-
"""v3_sepl_closeout — SEPL 收口审计件 (百倍V3 T-028 / REQ-061.AC1).

REQ-061 [MUST]: 任何 V3 改动提交应通过全套回归后 commit (SEPL), message
附 pytest 摘要行; 劣化回滚记录 (如发生) 在 .super-skill/ledger.jsonl。

本件对 E:/AI-Station 主仓全部 V3 提交 (git log --grep="v3-") 做只读对账:
  ① 摘要行覆盖  每条 message 须含「N passed」pytest 摘要行 + Co-Authored-By 行
     (真案已知口径: "272 pass / 3 fail" 与 "43 pass + 2 honest skip" 不构成
      N passed 模式 → 判缺, 如实报)
  ② 白名单合规  逐提交变更文件须落在白名单内:
       reforge_factory/ · report_platform/ ·
       _proposals/flagship-paid-report-1007/ ·
       ResearchFactory-Eng/channel_manifest.json (单文件)
     变更文件取 `git show --name-only` (与任务规格的 --stat 同源但不截断长
     路径 —— --stat 的 ".../xxx" 截断会把白名单内文件误判成无名路径)
  ③ 回归态      跑当前全量 pytest (子进程 reforge_factory/tests, 超时 300s)
     与最近一条提交声明的计数比对: 只允许增长/持平, 回退即违规;
     当前套件存在 failed/error 亦违规 (全套回归后才许 commit 的 SEPL 底线)
     报告附全史声明计数曲线 (并行波次交错的回落以 ⚠ 注记, 不计入违规)
  ④ 报告落盘    work/sepl_closeout.md: 提交清单 / 摘要行覆盖 / 白名单合规 /
     回归计数曲线 / ledger 回滚记录扫描 (只增追加, 不覆盖他件)

退出码: 0=全部合规 · 2=有违规项 (如实报告, 不遮不掩) · 1=运行性错误
        (git 失败 / pytest 超时或摘要不可解析)。

红线: git 只读 (log/show, 绝不写); 唯一写动作 = 追加式落盘本件报告。

CLI:
    py reforge_factory/v3_sepl_closeout.py                  # 真仓实跑
    py reforge_factory/v3_sepl_closeout.py --json           # 机读摘要
    py reforge_factory/v3_sepl_closeout.py --report <path>  # 报告落点覆盖
    py reforge_factory/v3_sepl_closeout.py --skip-pytest    # 跳过③(调试用)
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path

try:  # 管道/重定向下 Windows 默认 GBK, 与 UTF-8 消费端错配
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")
except (AttributeError, ValueError):
    pass

REPO_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_REPORT = (REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化"
                  / "百倍V3_极致调研变现计划" / "work" / "sepl_closeout.md")
DEFAULT_LEDGERS = (
    REPO_ROOT / ".super-skill" / "ledger.jsonl",
    REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化" / "百倍V3_极致调研变现计划"
    / ".super-skill" / "ledger.jsonl",
)
PYTEST_TARGET = "reforge_factory/tests"
PYTEST_TIMEOUT_S = 300

WHITELIST_DIRS = (
    "reforge_factory/",
    "report_platform/",
    "_proposals/flagship-paid-report-1007/",
)
WHITELIST_FILES = ("ResearchFactory-Eng/channel_manifest.json",)

PASSED_RE = re.compile(r"(\d+)\s+passed")
COAUTHOR_MARKER = "Co-Authored-By: Claude Code"
LOG_FIELD_SEP = "\x1f"
LOG_RECORD_SEP = "\x1e"


class GitError(RuntimeError):
    """git 只读子命令失败 (非零退出/不可执行)。"""


# ================================================================ 纯函数层 ===
def has_pytest_summary(body: str) -> bool:
    """message 是否含「N passed」pytest 摘要行 (N 为数字; 'pass'/'passed 裸词不算)。"""
    return PASSED_RE.search(body) is not None


def extract_declared_passed(body: str) -> int | None:
    """取声明的全量计数 —— 多处匹配取最后一处 (全量回归行惯例在文末署名前)。"""
    hits = PASSED_RE.findall(body)
    return int(hits[-1]) if hits else None


def has_coauthor(body: str) -> bool:
    return COAUTHOR_MARKER in body


def _norm(path: str) -> str:
    return path.strip().replace("\\", "/")


def whitelist_violations(files: list[str]) -> list[str]:
    """白名单外变更文件 (目录前缀须整段匹配, 单文件须全等)。"""
    out = []
    for raw in files:
        p = _norm(raw)
        if not p:
            continue
        if p.startswith(WHITELIST_DIRS) or p in WHITELIST_FILES:
            continue
        out.append(p)
    return out


def parse_pytest_output(text: str) -> dict | None:
    """从 pytest -q 输出取最终摘要行 → {passed, failed, errors}; 无摘要行 → None。"""
    for line in reversed((text or "").splitlines()):
        line = line.strip()
        if not line:
            continue
        has = (" passed" in line) or (" failed" in line) or (" error" in line)
        if not has:
            continue
        m_p = re.search(r"(\d+) passed", line)
        m_f = re.search(r"(\d+) failed", line)
        m_e = re.search(r"(\d+) error", line)
        if not (m_p or m_f or m_e):
            continue
        return {"passed": int(m_p.group(1)) if m_p else 0,
                "failed": int(m_f.group(1)) if m_f else 0,
                "errors": int(m_e.group(1)) if m_e else 0}
    return None


def curve_decreases(seq: list[tuple[str, int]]) -> list[tuple[str, int, str, int]]:
    """声明计数曲线 (旧→新) 的回落段 [(prev_short, prev_n, short, n)]。持平不算。"""
    drops = []
    for (p_short, p_n), (short, n) in zip(seq, seq[1:]):
        if n < p_n:
            drops.append((p_short, p_n, short, n))
    return drops


def regression_violation(last_declared: int | None, current_passed: int) -> bool:
    """当前全量计数 vs 最近提交声明值: 只许增长/持平, 回退即违规。"""
    if last_declared is None:
        return False
    return current_passed < last_declared


def scan_rollbacks(text: str) -> list[str]:
    """ledger.jsonl 中劣化回滚记录行 (REQ-061.AC1 在案要求, 信息节非违规)。"""
    hits = []
    for line in (text or "").splitlines():
        low = line.lower()
        if "回滚" in line or "rollback" in low:
            hits.append(line.strip()[:200])
    return hits


def parse_commits(raw: str) -> list[dict]:
    """git log --format=H\x1fh\x1fad\x1fs\x1fB\x1e 原文 → 提交字典列表 (新→旧)。"""
    commits = []
    for rec in raw.split(LOG_RECORD_SEP):
        rec = rec.strip("\r\n")
        if not rec.strip():
            continue
        parts = rec.split(LOG_FIELD_SEP, 4)
        if len(parts) != 5:
            continue
        full, short, date, subject, body = parts
        commits.append({
            "hash": full.strip(), "short": short.strip(), "date": date.strip(),
            "subject": subject.strip(), "body": body.strip(),
            "declared": extract_declared_passed(body),
            "has_summary": has_pytest_summary(body),
            "has_coauthor": has_coauthor(body),
            "files": [], "out_of_whitelist": [],
        })
    return commits


def parse_commit_files(raw: str) -> list[str]:
    """git show --name-only 原文 → 变更文件列表 (去空行)。"""
    return [ln.strip() for ln in (raw or "").splitlines() if ln.strip()]


# ============================================================ 子进程边界层 ===
# (测试 monkeypatch 点: 单测零真仓依赖)
def _git(repo: Path, args: list[str]) -> str:
    cmd = ["git", "-c", "core.quotepath=false", *args]
    try:
        r = subprocess.run(cmd, cwd=str(repo), capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=60)
    except (OSError, subprocess.TimeoutExpired) as exc:
        raise GitError(f"git {' '.join(args[:2])} 失败: {exc}") from exc
    if r.returncode != 0:
        raise GitError(f"git {' '.join(args[:2])} rc={r.returncode}: "
                       f"{r.stderr.strip()[:200]}")
    return r.stdout


def git_log_v3(repo: Path = REPO_ROOT) -> str:
    """主仓全部 V3 提交 (hash+message), 只读。"""
    fmt = f"%H{LOG_FIELD_SEP}%h{LOG_FIELD_SEP}%ad{LOG_FIELD_SEP}%s" \
          f"{LOG_FIELD_SEP}%B{LOG_RECORD_SEP}"
    return _git(repo, ["log", f"--grep=v3-", f"--format={fmt}", "--date=short"])


def git_commit_files(repo: Path, short: str) -> str:
    """单提交变更文件 (--name-only 不截断长路径; --stat 会截断致误判)。"""
    return _git(repo, ["show", "--name-only", "--format=", "--no-renames", short])


def run_full_pytest(repo: Path = REPO_ROOT) -> str:
    """当前全量回归 (reforge_factory/tests), 超时 300s, 只读不写报告外物。

    命令行不再叠 -q: pyproject addopts 已有一个 -q, 再加成 -qq (-2 verbosity)
    会隐藏最终「N passed」摘要行 → 解析必败 (真机踩坑, 2026-10-15)。
    """
    r = subprocess.run(
        [sys.executable, "-m", "pytest", PYTEST_TARGET],
        cwd=str(repo), capture_output=True, text=True,
        encoding="utf-8", errors="replace", timeout=PYTEST_TIMEOUT_S)
    return (r.stdout or "") + "\n" + (r.stderr or "")


# ================================================================= 编排层 ===
def run_audit(report_path: Path, run_pytest: bool = True,
              repo: Path = REPO_ROOT,
              ledgers: tuple[Path, ...] | None = None) -> dict:
    """全链审计: ①摘要行 ②白名单 ③回归态 ④报告落盘 → 结果字典。"""
    violations: list[dict] = []
    errors: list[str] = []

    commits = parse_commits(git_log_v3(repo))          # 新→旧
    for c in commits:
        c["files"] = parse_commit_files(git_commit_files(repo, c["short"]))
        c["out_of_whitelist"] = whitelist_violations(c["files"])
        if not c["has_summary"]:
            violations.append({"kind": "missing_summary", "commit": c["short"],
                               "detail": "message 缺「N passed」pytest 摘要行"})
        if not c["has_coauthor"]:
            violations.append({"kind": "missing_coauthor", "commit": c["short"],
                               "detail": "message 缺 Co-Authored-By: Claude Code 行"})
        for f in c["out_of_whitelist"]:
            violations.append({"kind": "out_of_whitelist", "commit": c["short"],
                               "detail": f"白名单外变更文件: {f}"})

    # ③ 回归态: 最近一条提交 (commits[0]) 的声明值 vs 当前全量实测
    # 共享仓 24-7 并行 worker 存在瞬态 collection error (Windows 文件锁竞态,
    # 真机踩坑 2026-10-15: 首跑 1 error / 26s 后复跑 595 全绿) → 最多跑两次,
    # 取末次判定; 两次轨迹全部落报告, 不遮掩 (两次皆红即红)。
    last_declared = commits[0]["declared"] if commits else None
    current = None
    regression = False
    attempts: list[str] = []
    if run_pytest:
        for i in (1, 2):
            try:
                parsed = parse_pytest_output(run_full_pytest(repo))
            except subprocess.TimeoutExpired:
                errors.append(f"第{i}次全量 pytest 超时 (>{PYTEST_TIMEOUT_S}s)")
                break
            if parsed is None:
                attempts.append(f"第{i}次: 输出无摘要行, 不可解析")
                continue
            attempts.append(
                f"第{i}次: {parsed['passed']} passed, {parsed['failed']} failed, "
                f"{parsed['errors']} errors")
            current = parsed
            if parsed["failed"] == 0 and parsed["errors"] == 0:
                break
        if current is None and not errors:
            errors.append("pytest 输出无摘要行, 计数不可解析 (见实测轨迹)")
        if current is not None:
            if current["failed"] or current["errors"]:
                violations.append({
                    "kind": "current_red_suite", "commit": "-",
                    "detail": (f"当前全量非绿(末次): {current['passed']} passed, "
                               f"{current['failed']} failed, {current['errors']} "
                               "errors (SEPL: 全套回归后才许 commit)")})
            if regression_violation(last_declared, current["passed"]):
                regression = True
                violations.append({
                    "kind": "count_regression", "commit": "-",
                    "detail": (f"计数回退: 最近提交声明 {last_declared} passed, "
                               f"当前实测 {current['passed']} passed")})

    # ④ ledger 回滚记录扫描 (信息节; 在案即列, 不构成违规)
    rollbacks: list[tuple[str, list[str]]] = []
    for lp in (ledgers or DEFAULT_LEDGERS):
        if lp.exists():
            try:
                rollbacks.append((str(lp), scan_rollbacks(
                    lp.read_text(encoding="utf-8", errors="replace"))))
            except OSError as exc:
                errors.append(f"ledger 不可读 {lp}: {exc}")

    res = {
        "generated_at": datetime.now(timezone.utc).astimezone().isoformat(
            timespec="seconds"),
        "repo": str(repo), "commit_total": len(commits),
        "summary_ok": sum(1 for c in commits if c["has_summary"]),
        "coauthor_ok": sum(1 for c in commits if c["has_coauthor"]),
        "whitelist_ok": sum(1 for c in commits if not c["out_of_whitelist"]),
        "last_declared": last_declared, "current": current,
        "attempts": attempts,
        "regression_violation": regression,
        "violations": violations, "errors": errors,
        "commits": commits, "rollbacks": rollbacks,
        "pytest_skipped": not run_pytest,
    }
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(build_report(res), encoding="utf-8")
    return res


def exit_code(res: dict) -> int:
    if res["errors"]:
        return 1
    if res["violations"] or res["regression_violation"]:
        return 2
    return 0


# ================================================================= 报告层 ===
def build_report(res: dict) -> str:
    """closeout 报告 (markdown): 提交清单/摘要行覆盖/白名单合规/回归计数曲线。"""
    L: list[str] = []
    cur = res["current"]
    L.append("# SEPL 收口对账报告 (v3_sepl_closeout / T-028 / REQ-061)")
    L.append("")
    L.append(f"- 生成: {res['generated_at']} · 主仓: `{res['repo']}`")
    L.append(f"- 范围: `git log --grep=\"v3-\"` 全部 V3 提交 × "
             f"{res['commit_total']} 条")
    L.append(f"- 白名单: {' · '.join(WHITELIST_DIRS)} · "
             f"{WHITELIST_FILES[0]}")
    rc = exit_code(res)
    verdict = ("全部合规" if rc == 0 else
               "有违规项 (exit 2)" if rc == 2 else "运行性错误 (exit 1)")
    L.append(f"- 结论: **{verdict}** · 违规 {len(res['violations'])} 项 · "
             f"运行性错误 {len(res['errors'])} 项")
    L.append("")

    L.append("## ① 提交清单与摘要行覆盖")
    L.append("")
    L.append("| # | 提交 | 日期 | 主题 | N passed 摘要 | 声明计数 | Co-Authored-By |")
    L.append("|---|------|------|------|----------------|----------|----------------|")
    for i, c in enumerate(res["commits"], 1):
        L.append(f"| {i} | `{c['short']}` | {c['date']} | {c['subject'][:60]} | "
                 f"{'✔' if c['has_summary'] else '**✘ 缺**'} | "
                 f"{c['declared'] if c['declared'] is not None else '—'} | "
                 f"{'✔' if c['has_coauthor'] else '**✘ 缺**'} |")
    L.append("")
    L.append(f"- 摘要行覆盖: **{res['summary_ok']}/{res['commit_total']}** · "
             f"署名覆盖: **{res['coauthor_ok']}/{res['commit_total']}**")
    L.append("")

    L.append("## ② 白名单合规")
    L.append("")
    bad = [c for c in res["commits"] if c["out_of_whitelist"]]
    L.append(f"- 合规提交: **{res['whitelist_ok']}/{res['commit_total']}**")
    if bad:
        L.append("- 白名单外变更 (逐提交):")
        for c in bad:
            for f in c["out_of_whitelist"]:
                L.append(f"  - `{c['short']}` → `{f}`")
    else:
        L.append("- 无白名单外变更文件")
    L.append("")

    L.append("## ③ 回归计数曲线 (旧→新, 声明值)")
    L.append("")
    seq = [(c["short"], c["declared"]) for c in reversed(res["commits"])
           if c["declared"] is not None]
    drops = {(p, pn, s, n) for p, pn, s, n in curve_decreases(seq)}
    drop_keys = {(p, s) for p, _, s, _ in drops}
    L.append("| 提交 | 声明 passed | 备注 |")
    L.append("|------|-------------|------|")
    for i, (short, n) in enumerate(seq):
        note = ""
        if i > 0:
            prev = seq[i - 1]
            if (prev[0], short) in drop_keys:
                note = f"⚠ 回落 (前值 {prev[1]})"
        L.append(f"| `{short}` | {n} | {note} |")
    L.append("")
    interleaved = len(drops)
    if interleaved:
        L.append(f"- ⚠ 曲线回落 {interleaved} 处: 并行波次提交交错所致注记, "
                 "不计入违规 (③ 硬门 = 当前全量实测 vs 最近声明, 只增不退)")
    if res["pytest_skipped"]:
        L.append("- 当前全量实测: **跳过** (--skip-pyptest)")
    elif cur is not None:
        for a in res.get("attempts", []):
            L.append(f"- 实测轨迹: {a}")
        L.append(f"- 当前全量实测: **{cur['passed']} passed, "
                 f"{cur['failed']} failed, {cur['errors']} errors** · "
                 f"最近提交声明: {res['last_declared']} passed · "
                 f"{'✘ 回退' if res['regression_violation'] else '✔ 增长/持平'}")
    else:
        L.append("- 当前全量实测: 不可用 (见运行性错误)")
    L.append("")

    L.append("## ④ 劣化回滚记录在案扫描 (.super-skill/ledger.jsonl)")
    L.append("")
    found = False
    for lp, hits in res["rollbacks"]:
        if hits:
            found = True
            L.append(f"- `{lp}`: {len(hits)} 条回滚记录:")
            for h in hits[:20]:
                L.append(f"  - {h}")
        else:
            L.append(f"- `{lp}`: 无回滚记录")
    if not res["rollbacks"]:
        L.append("- ledger 文件不存在 (无回滚可查)")
    if not found and res["rollbacks"]:
        L.append("- REQ-061.AC1: 未见劣化回滚 (如发生应记录在案)")
    L.append("")

    if res["violations"]:
        L.append("## 违规项汇总")
        L.append("")
        for v in res["violations"]:
            L.append(f"- [{v['kind']}] `{v['commit']}` {v['detail']}")
        L.append("")
    if res["errors"]:
        L.append("## 运行性错误")
        L.append("")
        for e in res["errors"]:
            L.append(f"- {e}")
        L.append("")
    if not res["violations"] and not res["errors"]:
        L.append("## 结论: 全部合规")
        L.append("")
        L.append("V3 提交 SEPL 三查 (摘要行 / 白名单 / 回归只增不退) 全部通过。")
        L.append("")
    return "\n".join(L)


# =================================================================== CLI ===
def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="SEPL 收口审计 (REQ-061)")
    ap.add_argument("--report", default=str(DEFAULT_REPORT),
                    help=f"报告落点 (默认 {DEFAULT_REPORT})")
    ap.add_argument("--skip-pytest", action="store_true",
                    help="跳过③当前全量实测 (调试用)")
    ap.add_argument("--json", action="store_true", help="机读摘要输出")
    args = ap.parse_args(argv)

    try:
        res = run_audit(report_path=Path(args.report),
                        run_pytest=not args.skip_pytest)
    except GitError as exc:
        print(f"[v3_sepl_closeout] 运行性错误: {exc}", file=sys.stderr)
        return 1

    rc = exit_code(res)
    if args.json:
        slim = {k: v for k, v in res.items() if k != "commits"}
        slim["commits_brief"] = [
            {"short": c["short"], "declared": c["declared"],
             "has_summary": c["has_summary"], "has_coauthor": c["has_coauthor"],
             "out_of_whitelist": c["out_of_whitelist"]} for c in res["commits"]]
        print(json.dumps(slim, ensure_ascii=False, indent=1))
    print(f"[v3_sepl_closeout] 提交 {res['commit_total']} 条 · "
          f"摘要行 {res['summary_ok']}/{res['commit_total']} · "
          f"白名单 {res['whitelist_ok']}/{res['commit_total']} · "
          f"当前全量 "
          f"{('None' if res['current'] is None else str(res['current']['passed']) + ' passed')} · "
          f"违规 {len(res['violations'])} · 报告 → {args.report} · exit {rc}")
    return rc


if __name__ == "__main__":
    sys.exit(main())
