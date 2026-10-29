# -*- coding: utf-8 -*-
r"""cleanup_runner · 清理执行器（W0）

清单驱动（manifest=唯一删除依据）｜两段式（dry-run → --go）｜对账闭环（磁盘差 vs 字节账）。

用法:
    py cleanup_runner.py --batch <manifest.txt> [--go] [--report <名>]
                         [--work-dir DIR] [--disk-root PATH]

manifest 行: `<bytes>\t<abs_path>` 或 `DIR\t<abs_path>`
守卫（先于一切）:
  ① 保护区前缀硬编码（hygiene_common.PROTECTED_PREFIXES）→ blocked
  ② junction/symlink/realpath 偏离 → blocked（exit 3）
  ③ 长路径一律 \\?\ 前缀处理

退出码: 0 成功 / 2 执行有失败项 / 3 junction 或保护区拦截
产物: work/run_progress.jsonl（--go 逐行进度）、work/batch_<名>.md（对账报告）
"""
from __future__ import annotations

import argparse
import json
import os
import shutil
import sys

import hygiene_common as hc

EXIT_OK = 0
EXIT_FAILURES = 2
EXIT_INTERCEPT = 3


def parse_args(argv=None):
    ap = argparse.ArgumentParser(description="清单驱动清理执行器（两段式）")
    ap.add_argument("--batch", required=True, help="manifest 路径")
    ap.add_argument("--go", action="store_true", help="执行删除（缺省 dry-run）")
    ap.add_argument("--report", default=None, help="报告名（work/batch_<名>.md），缺省取 manifest 名")
    ap.add_argument("--work-dir", default=None, help="工作目录（缺省 <脚本目录>/work）")
    ap.add_argument("--disk-root", default="E:/", help="对账磁盘根（缺省 E:/）")
    return ap.parse_args(argv)


def default_work_dir() -> str:
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), "work")


def default_report_name(manifest_path: str) -> str:
    stem = os.path.splitext(os.path.basename(manifest_path))[0]
    if stem.lower().startswith("manifest_"):
        stem = stem[len("manifest_"):]
    return stem


def tree_size_bytes(path_lp: str) -> int:
    """目录树字节估算（go 前统计，用于 freed 估算与对账）。"""
    total = 0
    stack = [path_lp]
    while stack:
        top = stack.pop()
        try:
            with os.scandir(top) as it:
                for e in it:
                    try:
                        if e.is_dir(follow_symlinks=False):
                            stack.append(e.path)
                        elif e.is_file(follow_symlinks=False):
                            total += e.stat(follow_symlinks=False).st_size
                    except OSError:
                        pass
        except OSError:
            pass
    return total


def classify(entry: hc.ManifestEntry):
    """守卫分类：先保护区（纯字符串），后 junction（文件系统），再存在性。

    返回 (status, detail, size_est)：
      status ∈ ok / blocked_protected / blocked_junction / warn_missing
    """
    reason = hc.is_protected(entry.path)
    if reason:
        return "blocked_protected", reason, 0
    if hc.is_junction_or_link(entry.path):
        return "blocked_junction", "路径自身是 junction/symlink", 0
    dev = hc.realpath_deviation(entry.path)
    if dev:
        return "blocked_junction", dev, 0
    p = hc.lp(entry.path)
    if not os.path.exists(p):
        return "warn_missing", "路径不存在=跳过", 0
    if entry.kind == "dir":
        return "ok", "目录（树删）", tree_size_bytes(p)
    try:
        sz = os.stat(p).st_size
    except OSError as e:
        return "warn_missing", f"stat 失败: {e}", 0
    return "ok", "", sz


def main(argv=None) -> int:
    args = parse_args(argv)
    work_dir = args.work_dir or default_work_dir()
    os.makedirs(work_dir, exist_ok=True)
    report_name = args.report or default_report_name(args.batch)
    report_path = os.path.join(work_dir, f"batch_{report_name}.md")
    progress_path = os.path.join(work_dir, "run_progress.jsonl")
    mode = "GO" if args.go else "DRY-RUN"

    try:
        entries = hc.read_manifest(args.batch)
    except (OSError, ValueError) as e:
        print(f"[FATAL] manifest 不可读: {e}", file=sys.stderr)
        return EXIT_FAILURES

    # 守卫分类（dry-run 与 go 共用同一守卫，先于一切）
    rows = []
    for e in entries:
        status, detail, size_est = classify(e)
        rows.append({"e": e, "status": status, "detail": detail, "size_est": size_est})

    ok_rows = [r for r in rows if r["status"] == "ok"]
    warn_rows = [r for r in rows if r["status"] == "warn_missing"]
    blocked_p = [r for r in rows if r["status"] == "blocked_protected"]
    blocked_j = [r for r in rows if r["status"] == "blocked_junction"]
    blocked = blocked_p + blocked_j
    manifest_bytes = sum(r["e"].declared_bytes for r in rows)
    est_bytes = sum(r["size_est"] for r in ok_rows)
    n_files = sum(1 for r in rows if r["e"].kind == "file")
    n_dirs = sum(1 for r in rows if r["e"].kind == "dir")

    disk_before = None
    if args.go:
        try:
            disk_before = shutil.disk_usage(args.disk_root).free
        except OSError:
            disk_before = None

    deleted = errors = freed_est = 0
    error_rows = []
    if args.go:
        with open(progress_path, "a", encoding="utf-8") as prog:
            for r in rows:
                e = r["e"]
                status = r["status"]
                if status == "ok":
                    p = hc.lp(e.path)
                    try:
                        if e.kind == "dir":
                            sz = r["size_est"]
                            shutil.rmtree(p)
                        else:
                            sz = r["size_est"]
                            os.remove(p)
                        deleted += 1
                        freed_est += sz
                        rec = "deleted"
                    except OSError as ex:
                        errors += 1
                        error_rows.append((e.path, str(ex)))
                        rec = "error"
                        r["status"] = "error"
                    prog.write(json.dumps({
                        "ts": hc.now_iso(), "batch": report_name, "mode": mode,
                        "kind": e.kind, "path": e.path, "status": rec,
                        "declared_bytes": e.declared_bytes, "size_est": r["size_est"],
                    }, ensure_ascii=False) + "\n")
                    prog.flush()
                elif status in ("blocked_protected", "blocked_junction", "warn_missing"):
                    prog.write(json.dumps({
                        "ts": hc.now_iso(), "batch": report_name, "mode": mode,
                        "kind": e.kind, "path": e.path, "status": status,
                        "detail": r["detail"],
                    }, ensure_ascii=False) + "\n")

    disk_delta = None
    within_tol = None
    if args.go and disk_before is not None:
        try:
            disk_after = shutil.disk_usage(args.disk_root).free
            disk_delta = disk_after - disk_before
            if freed_est > 0:
                within_tol = abs(disk_delta - freed_est) / freed_est < 0.01
        except OSError:
            pass

    # ------------------------------------------------------------------
    # 报告
    # ------------------------------------------------------------------
    lines = [
        f"# batch_{report_name} · {mode} · {hc.now_iso()}",
        "",
        f"- manifest: `{os.path.abspath(args.batch)}`",
        f"- 模式: {'--go 实删' if args.go else 'dry-run 零执行'}",
        f"- 件数: {len(rows)}（文件 {n_files} / 目录 {n_dirs}）",
        f"- 字节(manifest 申报): {manifest_bytes} ({hc.fmt_bytes(manifest_bytes)})",
        f"- 字节(实测可删): {est_bytes} ({hc.fmt_bytes(est_bytes)})",
        f"- warn 不存在: {len(warn_rows)}",
        f"- blocked 拒删: {len(blocked)}（保护区 {len(blocked_p)} / junction {len(blocked_j)}）",
    ]
    if args.go:
        lines += [
            f"- 实删件数: {deleted} / 失败: {errors}",
            f"- 磁盘差(释放): {disk_delta} ({hc.fmt_bytes(disk_delta or 0)})",
            f"- 对账容差1%: {'yes' if within_tol else ('no' if within_tol is False else 'n/a')}",
        ]
    lines.append("")
    lines.append("## 前 10 例（可删）")
    for r in ok_rows[:10]:
        lines.append(f"- [{r['e'].kind}] {hc.fmt_bytes(r['size_est'])} `{r['e'].path}`")
    if warn_rows:
        lines.append("")
        lines.append("## warn 不存在")
        for r in warn_rows[:20]:
            lines.append(f"- `{r['e'].path}`")
        if len(warn_rows) > 20:
            lines.append(f"- ... 共 {len(warn_rows)} 条")
    if blocked:
        lines.append("")
        lines.append("## blocked 拒删清单")
        for r in blocked:
            lines.append(f"- [{r['status']}] `{r['e'].path}` — {r['detail']}")
    if error_rows:
        lines.append("")
        lines.append("## 执行失败")
        for p, msg in error_rows[:20]:
            lines.append(f"- `{p}` — {msg}")
    with open(report_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines) + "\n")

    # ------------------------------------------------------------------
    # 控制台摘要 + 退出码
    # ------------------------------------------------------------------
    print(f"[{mode}] batch={report_name} 件数={len(rows)} (file {n_files}/dir {n_dirs}) "
          f"字节={hc.fmt_bytes(manifest_bytes)} 可删={hc.fmt_bytes(est_bytes)} "
          f"warn={len(warn_rows)} blocked={len(blocked)}")
    for r in ok_rows[:10]:
        print(f"  例 [{r['e'].kind}] {hc.fmt_bytes(r['size_est'])} {r['e'].path}")
    if args.go:
        print(f"  实删 {deleted} 失败 {errors} 磁盘差 {hc.fmt_bytes(disk_delta or 0)} "
              f"容差内 {'yes' if within_tol else 'no'}")
    print(f"报告: {report_path}")

    if blocked:
        return EXIT_INTERCEPT
    if args.go and errors:
        return EXIT_FAILURES
    return EXIT_OK


if __name__ == "__main__":
    try:
        sys.exit(main())
    except KeyboardInterrupt:
        print("[INTERRUPT] 用户中断", file=sys.stderr)
        sys.exit(130)
