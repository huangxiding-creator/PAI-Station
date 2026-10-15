# -*- coding: utf-8 -*-
r"""dedup_scanner · PDF 去重扫描器（W0）

用法:
    py dedup_scanner.py --root <dir> --out <jsonl> [--resume]
                        [--ext .pdf] [--checkpoint-every 500] [--work-dir DIR]

- 遍历 <root> 下指定扩展名（缺省 .pdf），长路径（\\?\ 前缀）流式 sha256
- 断点续扫: work/scan_progress.json 每 N 件原子落点；--resume 跳过已完成件
- 幂等: 中断→--resume 续跑 == 一次跑完
- 输出: 每行 {sha, size, paths[]}（同 sha 聚合，组内路径去重排序）
- 摘要: 组数 / 冗余字节 / 前 50 大组（按冗余字节降序）

退出码: 0 完成 / 2 中断未完（进度已存，可 --resume 续跑）
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys

import hygiene_common as hc

CHUNK = 1 << 20  # 1 MiB 流式读


def parse_args(argv=None):
    ap = argparse.ArgumentParser(description="PDF 去重扫描器（流式 sha256 + 断点续扫）")
    ap.add_argument("--root", required=True, help="扫描根目录")
    ap.add_argument("--out", required=True, help="输出 jsonl 路径")
    ap.add_argument("--resume", action="store_true", help="从 work/scan_progress.json 断点续扫")
    ap.add_argument("--ext", default=".pdf", help="扩展名（缺省 .pdf）")
    ap.add_argument("--checkpoint-every", type=int, default=500, help="进度落点间隔（缺省 500）")
    ap.add_argument("--work-dir", default=None, help="工作目录（缺省 <脚本目录>/work）")
    ap.add_argument("--top", type=int, default=50, help="摘要里前 N 大组（缺省 50）")
    return ap.parse_args(argv)


def default_work_dir() -> str:
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), "work")


def hash_file(path: str) -> str:
    """流式 sha256（长路径前缀打开）。"""
    h = hashlib.sha256()
    with open(hc.lp(path), "rb") as f:
        while True:
            b = f.read(CHUNK)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def iter_targets(root: str, ext: str):
    """深度遍历（长路径），yield 命中扩展名的文件路径。"""
    root_lp = hc.lp(root)
    ext_low = ext.lower()
    for dirpath, dirnames, filenames in os.walk(root_lp):
        for name in filenames:
            if name.lower().endswith(ext_low):
                yield os.path.join(dirpath, name)


def load_progress(path: str, root: str):
    """载入进度；root 不匹配（换扫描根）则视为不可续。"""
    if not os.path.exists(path):
        return None
    try:
        with open(path, "r", encoding="utf-8") as f:
            obj = json.load(f)
    except (OSError, ValueError):
        return None
    if obj.get("root") != os.path.abspath(root):
        return None
    return obj


def save_progress(path: str, root: str, done: list, scanned: int, finished: bool):
    hc.atomic_write_json(path, {
        "root": os.path.abspath(root),
        "scanned": scanned,
        "finished": finished,
        "done": done,          # [[sha, size, path], ...]
        "updated_at": hc.now_iso(),
    })


def main(argv=None) -> int:
    args = parse_args(argv)
    work_dir = args.work_dir or default_work_dir()
    os.makedirs(work_dir, exist_ok=True)
    progress_path = os.path.join(work_dir, "scan_progress.json")

    groups: dict[str, dict] = {}   # sha -> {"size": n, "paths": [...]}
    done_paths: set[str] = set()
    scanned = 0

    if args.resume:
        prog = load_progress(progress_path, args.root)
        if prog:
            for sha, size, path in prog.get("done", []):
                g = groups.setdefault(sha, {"size": size, "paths": []})
                if path not in g["paths"]:
                    g["paths"].append(path)
                done_paths.add(path)
            scanned = len(done_paths)
            print(f"[RESUME] 续扫: 已完成 {scanned} 件（progress 已载入）")

    done: list = [[g_sha, g["size"], p]
                  for g_sha, g in groups.items() for p in g["paths"]]

    targets = list(iter_targets(args.root, args.ext))
    warns: list[str] = []
    interrupted = False
    try:
        n_new = 0
        for path in targets:
            spath = hc.strip_lp(path)
            if spath in done_paths:
                continue
            try:
                sha = hash_file(path)
                size = os.stat(hc.lp(path)).st_size
            except OSError as e:
                warns.append(f"{spath}: {e}")
                continue
            g = groups.setdefault(sha, {"size": size, "paths": []})
            if spath not in g["paths"]:
                g["paths"].append(spath)
            done_paths.add(spath)
            done.append([sha, size, spath])
            scanned += 1
            n_new += 1
            if args.checkpoint_every > 0 and n_new % args.checkpoint_every == 0:
                save_progress(progress_path, args.root, done, scanned, finished=False)
    except KeyboardInterrupt:
        interrupted = True
        save_progress(progress_path, args.root, done, scanned, finished=False)
        print(f"[INTERRUPT] 已存进度 {scanned} 件 → {progress_path}，用 --resume 续跑",
              file=sys.stderr)

    if interrupted:
        return 2

    # 完成态进度（幂等：重跑时 --resume 直接命中全部 done）
    save_progress(progress_path, args.root, done, scanned, finished=True)

    # 聚合输出（确定性排序：冗余字节降序 → sha 升序；组内路径排序）
    out_groups = []
    for sha, g in groups.items():
        paths = sorted(set(g["paths"]))
        out_groups.append({"sha": sha, "size": g["size"], "paths": paths})
    out_groups.sort(key=lambda g: (-(g["size"] * max(0, len(g["paths"]) - 1)), g["sha"]))
    out_dir = os.path.dirname(os.path.abspath(args.out))
    os.makedirs(out_dir, exist_ok=True)
    with open(args.out, "w", encoding="utf-8") as f:
        for g in out_groups:
            f.write(json.dumps(g, ensure_ascii=False) + "\n")

    dup_groups = [g for g in out_groups if len(g["paths"]) > 1]
    redundant = sum(g["size"] * (len(g["paths"]) - 1) for g in dup_groups)
    total_files = sum(len(g["paths"]) for g in out_groups)

    print(f"[SCAN] root={args.root} 扫描件数={total_files} 本次新扫={n_new} "
          f"组数={len(out_groups)} 重复组={len(dup_groups)}")
    print(f"[SCAN] 冗余字节={redundant} ({hc.fmt_bytes(redundant)})")
    for g in dup_groups[: args.top]:
        rb = g["size"] * (len(g["paths"]) - 1)
        print(f"  dup {g['sha'][:12]} ×{len(g['paths'])} {hc.fmt_bytes(rb)}")
    if warns:
        print(f"[WARN] {len(warns)} 件读失败:")
        for w in warns[:10]:
            print(f"  {w}")
    print(f"输出: {args.out}")
    return 0


if __name__ == "__main__":
    if os.name == "nt":
        try:
            sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass
    sys.exit(main())
