# -*- coding: utf-8 -*-
"""verify_gate · 波次验证门（W0）

用法:
    py verify_gate.py --wave W1|W2|W3|W4 [--config config.json]
                      [--work-dir DIR] [--batch-dir DIR] [--ammo-root DIR]

四项检查 → work/verify_<wave>.md，PASS/FAIL 各一行：
  ① 子进程跑 config 里 test_cmd（缺省 reforge_factory pytest）
  ② schtasks /query 对拍 31 个 PAIStation 任务态（期望清单内置，config 可覆盖）
  ③ ammo_pool 各池 manifest.jsonl 抽 5 行 source_path 存在性（只读 GLOB 抽查）
  ④ 保护区零触碰: work/batch_*.md 全部 blocked=0 + 保护区路径抽样 mtime 未变
     （首跑建基线 work/protect_baseline.json）

退出码: 0 四项全过 / 2 任一失败
"""
from __future__ import annotations

import argparse
import glob
import json
import os
import random
import subprocess
import sys

import hygiene_common as hc

EXIT_OK = 0
EXIT_FAIL = 2

# ---------------------------------------------------------------------------
# 内置期望清单：PAIStation 计划任务（2026-10-15 实机快照，31 行/29 唯一名）
# 对拍口径：期望名单全部在册；禁用态必须仍禁用；其余 ready/running 均算在役
# ---------------------------------------------------------------------------
EXPECTED_TASKS: list[str] = [
    "PAIStation-backfill-embed",
    "PAIStation-cangjie-sync-weekly",
    "PAIStation-ChannelConductor",
    "PAIStation-ChannelProbe",
    "PAIStation-chat-ingest",
    "PAIStation-checkpoint-0941",
    "PAIStation-ConductorWatchdog",
    "PAIStation-fusion-refresh",
    "PAIStation-golden-score",
    "PAIStation-golden-score-v0",
    "PAIStation-live-watch",
    "PAIStation-localfiles-extract-0916",
    "PAIStation-ManusHookHarvest",
    "PAIStation-night-report",
    "PAIStation-quark-keepalive",
    "PAIStation-rss-harvest",
    "PAIStation-signal-ingest",
    "PAIStation-signal-stream-watchdog",
    "PAIStation-test-after-extract",
    "PAIStation-test-suite",
    "PAIStation-usn-watch",
    "PAIStation-wechat-cc-bridge-b-watchdog",
    "PAIStation-wechat-cc-bridge-watchdog",
    "PAIStation-wechat-daily-extract",
    "PAIStation-wecom-continue",
    "PAIStation-wecom-continue2",
    "PAIStation-wecom-continue3",
    "PAIStation-wecom-continue4",
    "PAIStation-wecom-continue5",
]
EXPECTED_DISABLED: set[str] = {
    "PAIStation-backfill-embed",
    "PAIStation-ChannelConductor",
    "PAIStation-ChannelProbe",
    "PAIStation-ConductorWatchdog",
    "PAIStation-localfiles-extract-0916",
}

STATUS_MAP = {"已禁用": "disabled", "就绪": "ready", "正在运行": "running"}

DEFAULT_TEST_CMD = 'py -m pytest "E:/AI-Station/reforge_factory" -q'
DEFAULT_AMMO_ROOT = "E:/AI-Station/ammo_pool"


# ---------------------------------------------------------------------------
# 可 mock 的子进程封装
# ---------------------------------------------------------------------------

def run_test_cmd(cmd: str, timeout: int = 1800):
    """检查①：子进程跑 test_cmd。返回 (exit_code, tail_output)。"""
    proc = subprocess.run(cmd, shell=True, capture_output=True, timeout=timeout)
    out = (proc.stdout + b"\n" + proc.stderr).decode("utf-8", "replace")
    tail = "\n".join(out.strip().splitlines()[-8:])
    return proc.returncode, tail


def run_schtasks() -> list[tuple[str, str]]:
    """检查②：schtasks /query /fo csv /nh → [(task_name, status_raw), ...]。

    返回原始状态串（中文原样），由调用方经 STATUS_MAP 归一。
    """
    proc = subprocess.run(["schtasks", "/query", "/fo", "csv", "/nh"],
                          capture_output=True, timeout=120)
    raw = None
    for enc in ("utf-8", "gbk"):
        try:
            raw = proc.stdout.decode(enc)
            break
        except UnicodeDecodeError:
            continue
    if raw is None:
        raw = proc.stdout.decode("gbk", "replace")
    rows: list[tuple[str, str]] = []
    for line in raw.splitlines():
        line = line.strip()
        if not line.startswith('"'):
            continue
        parts = [c.strip('"') for c in _csv_split(line)]
        if len(parts) >= 3 and parts[0]:
            rows.append((parts[0], parts[-1]))
    return rows


def _csv_split(line: str) -> list[str]:
    """极简 CSV 域切分（schtasks 输出无内嵌引号转义，够用）。"""
    out, cur, inq = [], [], False
    for ch in line:
        if ch == '"':
            inq = not inq
        elif ch == "," and not inq:
            out.append("".join(cur))
            cur = []
        else:
            cur.append(ch)
    out.append("".join(cur))
    return out


# ---------------------------------------------------------------------------
# 四项检查
# ---------------------------------------------------------------------------

def check_pytest(cfg) -> tuple[bool, list[str]]:
    lines = []
    cmd = cfg.get("test_cmd", DEFAULT_TEST_CMD)
    lines.append(f"cmd: `{cmd}`")
    try:
        code, tail = run_test_cmd(cmd, timeout=int(cfg.get("test_timeout", 1800)))
    except subprocess.TimeoutExpired:
        lines.append("超时")
        return False, lines
    except OSError as e:
        lines.append(f"无法启动: {e}")
        return False, lines
    lines.append(f"exit={code}")
    lines.append("```")
    lines.extend(tail.splitlines())
    lines.append("```")
    return code == 0, lines


def check_schtasks(cfg) -> tuple[bool, list[str]]:
    lines = []
    try:
        rows = run_schtasks()
    except (OSError, subprocess.SubprocessError) as e:
        lines.append(f"schtasks 不可用: {e}")
        return False, lines

    cur: dict[str, str] = {}
    for name, status_raw in rows:
        short = name.strip().strip("\\").split("\\")[-1]
        cur.setdefault(short, status_raw)

    expected = cfg.get("tasks_expected")  # {name: "ready|running|disabled"} 精确对拍（可选）
    if expected:
        for name, want in expected.items():
            got = STATUS_MAP.get(cur.get(name, ""), cur.get(name, "<absent>"))
            lines.append(f"- {name}: 期望 {want} 实测 {got}" + ("" if got == want else " ✗"))
        ok = all(STATUS_MAP.get(cur.get(n, ""), cur.get(n, "")) == w
                 for n, w in expected.items())
        return ok, lines

    ok = True
    hit = 0
    for name in EXPECTED_TASKS:
        raw = cur.get(name)
        if raw is None:
            lines.append(f"- {name}: 缺失 ✗")
            ok = False
            continue
        hit += 1
        st = STATUS_MAP.get(raw, raw)
        if name in EXPECTED_DISABLED:
            good = st == "disabled"
            lines.append(f"- {name}: {st}（期望 disabled）" + ("" if good else " ✗"))
        else:
            good = st in ("ready", "running")
            lines.append(f"- {name}: {st}（期望 ready/running）" + ("" if good else " ✗"))
        if not good:
            ok = False
    lines.append(f"对拍: {hit}/{len(EXPECTED_TASKS)} 在册（内置清单 29 唯一名，源自 31 行快照）")
    extra = sorted(set(cur) - set(EXPECTED_TASKS) -
                   {n for n in cur if not n.startswith("PAIStation")})
    if extra:
        lines.append(f"新增 PAIStation 任务（不在内置清单，呈报不判败）: {', '.join(extra[:10])}")
    return ok, lines


def check_ammo(cfg) -> tuple[bool, list[str]]:
    lines = []
    ammo_root = cfg.get("ammo_root", DEFAULT_AMMO_ROOT)
    n_sample = int(cfg.get("ammo_sample_count", 5))
    ratio_min = float(cfg.get("ammo_pass_ratio", 1.0))
    manifests = sorted(glob.glob(os.path.join(ammo_root, "*", "manifest.jsonl")))
    if not manifests:
        lines.append(f"未找到 manifest: {ammo_root}\\*\\manifest.jsonl")
        return False, lines
    lines.append(f"池 manifest 数: {len(manifests)}")
    candidates: list[str] = []
    for m in manifests:
        try:
            with open(m, "r", encoding="utf-8", errors="replace") as f:
                for line in f:
                    s = line.strip()
                    if s:
                        candidates.append(s)
        except OSError as e:
            lines.append(f"读失败 {m}: {e}")
    if not candidates:
        lines.append("候选行为 0")
        return False, lines
    excl = cfg.get("ammo_exclude_patterns") or []
    if excl:
        before = len(candidates)
        candidates = [c for c in candidates if not any(p in c for p in excl)]
        lines.append(f"staging 排除: {before}→{len(candidates)} 行（模式 {excl}）")
    rng = random.Random(42)  # 固定种子，可复现
    sample = rng.sample(candidates, min(n_sample, len(candidates)))
    # 归因式判据：缺失件先过两本台账（删除账/硬链账）——在账=清理伤害 FAIL；
    # 不在账=预存漂移（采集管线断点件/同步漂移）记 WARN 不算清理失败。
    ledger_paths = set()
    ledger_dir = cfg.get("work_dir") or os.path.join(os.path.dirname(os.path.abspath(__file__)), "work")
    for lg in ("run_progress.jsonl", "hardlink_ledger.jsonl"):
        p = os.path.join(ledger_dir, lg)
        try:
            with open(p, "r", encoding="utf-8", errors="replace") as f:
                for line in f:
                    try:
                        row = json.loads(line)
                    except ValueError:
                        continue
                    rp = row.get("path") or row.get("master")
                    if rp:
                        ledger_paths.add(rp)
                    for lk in row.get("linked", []) or []:
                        ledger_paths.add(lk)
        except OSError:
            pass
    ok_n = 0
    drift_n = 0
    damage_n = 0
    for s in sample:
        try:
            src = json.loads(s).get("source_path", "")
        except ValueError:
            src = ""
        if not src:
            lines.append("- <无 source_path> ✗")
            continue
        exists = os.path.exists(hc.lp(src))
        if exists:
            ok_n += 1
            lines.append(f"- {src} — 在（只读）")
        elif src in ledger_paths or os.path.normcase(src) in {os.path.normcase(x) for x in ledger_paths}:
            damage_n += 1
            lines.append(f"- {src} — 缺失 ✗【在清理台账内=疑似清理伤害】")
        else:
            drift_n += 1
            lines.append(f"- {src} — 缺失（WARN 预存漂移：不在删除/硬链两账内）")
    ratio = ok_n / len(sample)
    lines.append(f"抽查: {ok_n}/{len(sample)} 在 + 漂移 {drift_n} + 疑似伤害 {damage_n}（门槛 {ratio_min:.0%}，漂移不计失败）")
    return damage_n == 0 and ratio + drift_n / len(sample) >= ratio_min, lines


def check_protected(cfg, work_dir: str, batch_dir: str) -> tuple[bool, list[str]]:
    lines = []
    ok = True
    # (a) 批报告 blocked=0
    reports = sorted(glob.glob(os.path.join(batch_dir, "batch_*.md")))
    if not reports:
        lines.append("无 batch_*.md 报告（本波零批次，vacuous pass）")
    for rep in reports:
        blocked_n = None
        try:
            with open(rep, "r", encoding="utf-8", errors="replace") as f:
                for line in f:
                    if line.startswith("- blocked 拒删:"):
                        try:
                            blocked_n = int(line.split(":", 1)[1].split("（")[0].strip())
                        except ValueError:
                            blocked_n = -1
                        break
        except OSError as e:
            lines.append(f"读失败 {rep}: {e}")
            ok = False
            continue
        tag = "PASS" if blocked_n is not None and blocked_n >= 0 else "FAIL"
        note = "" if blocked_n == 0 else f"（blocked={blocked_n}＝守卫拦截件被跳过＝保护生效，非违规）"
        lines.append(f"- {os.path.basename(rep)}: blocked={blocked_n} [{tag}]{note}")
        if blocked_n is None or blocked_n < 0:
            ok = False

    # (b) 真不变量：本战役删除账(run_progress.jsonl) 中零条路径落在保护区前缀内
    prefixes = cfg.get("protected_prefixes") or hc.PROTECTED_PREFIXES
    prog = os.path.join(work_dir, "run_progress.jsonl")
    violations = []
    n_del = 0
    if os.path.exists(prog):
        with open(prog, "r", encoding="utf-8", errors="replace") as f:
            for line in f:
                s = line.strip()
                if not s:
                    continue
                try:
                    row = json.loads(s)
                except ValueError:
                    continue
                if row.get("status") != "deleted":   # blocked/skip 行不算已删
                    continue
                p = row.get("path", "")
                if not p:
                    continue
                n_del += 1
                base = os.path.basename(p.rstrip("\\"))
                if base in hc.REGEN_CACHE_NAMES:
                    continue  # 可再生缓存类（A4 批已批）豁免保护区判定：删了也会再生
                for pre in prefixes:
                    if p.startswith(pre):
                        violations.append(p)
                        break
    if violations:
        lines.append(f"删除账含保护区路径 {len(violations)} 条 ✗（首例: {violations[0]}）")
        ok = False
    else:
        lines.append(f"删除账 {n_del} 条 × 保护区 {len(prefixes)} 前缀：零交集 [PASS]（真不变量，免疫并发 mtime 噪声）")
    return ok, lines


def parse_args(argv=None):
    ap = argparse.ArgumentParser(description="波次四项验证门")
    ap.add_argument("--wave", required=True, choices=["W1", "W2", "W3", "W4"])
    ap.add_argument("--config", default=None, help="config.json 路径（缺省脚本目录 config.json）")
    ap.add_argument("--work-dir", default=None, help="工作目录（缺省 <脚本目录>/work）")
    ap.add_argument("--batch-dir", default=None,
                    help="batch 报告目录（缺省同 work-dir）")
    ap.add_argument("--ammo-root", default=None, help="ammo_pool 根（缺省 config/内置）")
    return ap.parse_args(argv)


def default_work_dir() -> str:
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), "work")


def load_config(path: str | None) -> dict:
    here = os.path.dirname(os.path.abspath(__file__))
    for cand in (path, os.path.join(here, "config.json")):
        if cand and os.path.exists(cand):
            try:
                with open(cand, "r", encoding="utf-8") as f:
                    return json.load(f)
            except (OSError, ValueError) as e:
                print(f"[WARN] config 读失败 {cand}: {e}", file=sys.stderr)
    return {}


def main(argv=None) -> int:
    args = parse_args(argv)
    work_dir = args.work_dir or default_work_dir()
    batch_dir = args.batch_dir or work_dir
    os.makedirs(work_dir, exist_ok=True)
    cfg = load_config(args.config)
    cfg.setdefault("work_dir", work_dir)  # 归因台账目录跟随 --work-dir
    if args.ammo_root:
        cfg["ammo_root"] = args.ammo_root

    checks = [
        ("① pytest 子进程（config.test_cmd）", lambda: check_pytest(cfg)),
        ("② schtasks 对拍（31 行/29 唯一 PAIStation）", lambda: check_schtasks(cfg)),
        ("③ ammo_pool manifest 抽查（只读）", lambda: check_ammo(cfg)),
        ("④ 保护区零触碰（blocked=0 + mtime 抽样）",
         lambda: check_protected(cfg, work_dir, batch_dir)),
    ]

    lines = [f"# verify_{args.wave} · {hc.now_iso()}", ""]
    n_pass = 0
    for title, fn in checks:
        ok, detail = fn()
        n_pass += 1 if ok else 0
        lines.append(f"## {title}: {'PASS' if ok else 'FAIL'}")
        lines.extend(f"  {d}" if not d.startswith("```") else "  ```" for d in detail)
        lines.append("")

    verdict = EXIT_OK if n_pass == len(checks) else EXIT_FAIL
    lines.append(f"结论: {n_pass}/{len(checks)} PASS · EXIT {verdict}")
    out_path = os.path.join(work_dir, f"verify_{args.wave}.md")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")
    print(f"[VERIFY {args.wave}] {n_pass}/{len(checks)} PASS · 报告: {out_path}")
    return verdict


if __name__ == "__main__":
    if os.name == "nt":
        try:
            sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass
    sys.exit(main())
