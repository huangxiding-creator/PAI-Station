# -*- coding: utf-8 -*-
"""hardlink_factory · 硬链工厂（W0）

用法:
    py hardlink_factory.py --manifest <dedup.jsonl> [--go]
                           [--prefer-prefix <P>] [--work-dir DIR]

- 每组 paths>1: 定母本 → 其余副本删原件→os.link(母本, 副本)（长路径前缀）
  → 验 st_ino 相同 → 台账 work/hardlink_ledger.jsonl {group, master, linked[]}
- 母本规则: --prefer-prefix 命中者中最短路径（C4 乐奇本体优先用）；
  未指定/无命中 → 全组字典序最短路径
- dry-run（缺省）只出计划（组数/回收字节）；--go 才动盘
- 失败（跨卷/权限）: 跳过+记录，不中断

退出码: 0 成功 / 2 部分失败
"""
from __future__ import annotations

import argparse
import json
import os
import sys

import hygiene_common as hc

EXIT_OK = 0
EXIT_FAILURES = 2


def parse_args(argv=None):
    ap = argparse.ArgumentParser(description="硬链去重工厂（母本保底+副本硬链）")
    ap.add_argument("--manifest", required=True, help="dedup_manifest.jsonl 路径")
    ap.add_argument("--go", action="store_true", help="执行硬链（缺省 dry-run）")
    ap.add_argument("--prefer-prefix", default=None,
                    help="母本优先前缀（命中该前缀者优先，如乐奇本体路径）")
    ap.add_argument("--work-dir", default=None, help="工作目录（缺省 <脚本目录>/work）")
    return ap.parse_args(argv)


def default_work_dir() -> str:
    return os.path.join(os.path.dirname(os.path.abspath(__file__)), "work")


def load_groups(manifest_path: str):
    groups = []
    with open(manifest_path, "r", encoding="utf-8") as f:
        for i, line in enumerate(f, 1):
            s = line.strip()
            if not s:
                continue
            obj = json.loads(s)
            sha = obj.get("sha") or f"line{i}"
            size = int(obj.get("size") or 0)
            paths = sorted(set(obj.get("paths") or []))
            if len(paths) > 1:
                groups.append({"group": sha, "size": size, "paths": paths})
    return groups


def pick_master(paths: list[str], prefer_prefix: str | None) -> str:
    """母本规则：优先前缀命中者；池内最短路径（长度同则字典序最小）。"""
    pool = paths
    if prefer_prefix:
        pre = os.path.normcase(prefer_prefix)
        hit = [p for p in paths if os.path.normcase(p).startswith(pre)]
        if hit:
            pool = hit
    return min(pool, key=lambda p: (len(p), p))


def main(argv=None) -> int:
    args = parse_args(argv)
    work_dir = args.work_dir or default_work_dir()
    os.makedirs(work_dir, exist_ok=True)
    ledger_path = os.path.join(work_dir, "hardlink_ledger.jsonl")
    plan_path = os.path.join(work_dir, "hardlink_plan.json")

    groups = load_groups(args.manifest)
    for g in groups:
        g["master"] = pick_master(g["paths"], args.prefer_prefix)
        g["copies"] = [p for p in g["paths"] if p != g["master"]]

    plan_recovered = sum(g["size"] * len(g["copies"]) for g in groups)

    # dry-run：只出计划
    if not args.go:
        hc.atomic_write_json(plan_path, {
            "ts": hc.now_iso(), "mode": "DRY-RUN",
            "groups": len(groups),
            "recovered_bytes_plan": plan_recovered,
            "detail": [{"group": g["group"], "master": g["master"],
                        "copies": g["copies"], "size": g["size"]} for g in groups],
        })
        print(f"[DRY-RUN] 组数={len(groups)} 回收字节(计划)={plan_recovered} "
              f"({hc.fmt_bytes(plan_recovered)})")
        for g in groups[:10]:
            print(f"  组 {g['group'][:12]} ×{len(g['paths'])} 母本={g['master']} "
                  f"副本 {len(g['copies'])} 件")
        print(f"计划: {plan_path}")
        return EXIT_OK

    # --go：逐组执行
    recovered = 0
    n_linked = n_failed = 0
    with open(ledger_path, "a", encoding="utf-8") as ledger:
        for g in groups:
            master = g["master"]
            mlp = hc.lp(master)
            if not os.path.exists(mlp):
                ledger.write(json.dumps({
                    "ts": hc.now_iso(), "group": g["group"], "master": master,
                    "linked": [], "failed": [{"path": p, "error": "master 不存在"}
                                             for p in g["copies"]],
                    "recovered_bytes": 0,
                }, ensure_ascii=False) + "\n")
                n_failed += len(g["copies"])
                continue
            linked, failed = [], []
            m_ino = os.stat(mlp).st_ino
            for p in g["copies"]:
                plp = hc.lp(p)
                tmplp = plp + ".hl_tmp"
                try:
                    # 安全序：先链临时名（跨卷在此失败，原件无损）→删原件→原子改名
                    try:
                        if os.path.exists(tmplp):
                            os.remove(tmplp)
                    except OSError:
                        pass
                    os.link(mlp, tmplp)
                    os.remove(plp)
                    os.replace(tmplp, plp)
                    if os.stat(plp).st_ino != m_ino:
                        raise OSError(f"st_ino 校验不符: {os.stat(plp).st_ino} != {m_ino}")
                    linked.append(p)
                    recovered += g["size"]
                    n_linked += 1
                except OSError as e:
                    # 失败兜底：清临时名，保原件（跨卷/权限：跳过+记录，不中断）
                    try:
                        if os.path.exists(tmplp):
                            os.remove(tmplp)
                    except OSError:
                        pass
                    failed.append({"path": p, "error": str(e)})
                    n_failed += 1
            ledger.write(json.dumps({
                "ts": hc.now_iso(), "group": g["group"], "master": master,
                "linked": linked, "failed": failed,
                "recovered_bytes": g["size"] * len(linked),
            }, ensure_ascii=False) + "\n")
            ledger.flush()

    print(f"[GO] 组数={len(groups)} 链成={n_linked} 失败={n_failed} "
          f"回收字节={recovered} ({hc.fmt_bytes(recovered)})")
    print(f"台账: {ledger_path}")
    return EXIT_FAILURES if n_failed else EXIT_OK


if __name__ == "__main__":
    if os.name == "nt":
        try:
            sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        except Exception:
            pass
    sys.exit(main())
