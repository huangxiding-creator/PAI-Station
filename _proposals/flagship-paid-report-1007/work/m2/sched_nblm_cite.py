# -*- coding: utf-8 -*-
"""sched_nblm_cite — NB 初稿引用映射器: [N]标注 → 真实源名索引/附录.

NB 生成稿句末带 [3] / [7, 12] 式源编号; 本件从 nblm_state.json 取笔记本id,
拉源清单建 编号→源名 映射(NotebookLM 源列表序≈上传/显示序, 输出对照表
供人工校核), 产出每章《源引用对照.md》; --rewrite 直接把 [N] 替换为
(源名) 内联形式。
用法: py -X utf8 sched_nblm_cite.py [--chapters 1,2] [--rewrite]
"""
from __future__ import annotations

import argparse
import asyncio
import json
import os
import re
import sys
import time
import urllib.request
from pathlib import Path
from urllib.parse import quote

os.environ.setdefault("HTTP_PROXY", "http://127.0.0.1:7890")
os.environ.setdefault("HTTPS_PROXY", "http://127.0.0.1:7890")

SCHED = Path(__file__).resolve().parent / "sched"
OUT = SCHED / "nblm_out"
STATE_P = SCHED / "nblm_state.json"
CLASH_SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"


def clash_put(group: str, node: str) -> None:
    req = urllib.request.Request(
        f"http://127.0.0.1:53401/proxies/{quote(group)}", method="PUT",
        headers={"Authorization": "Bearer " + CLASH_SECRET,
                 "Content-Type": "application/json"},
        data=json.dumps({"name": node}).encode())
    try:
        with urllib.request.urlopen(req, timeout=8) as r:
            r.read()
    except Exception:  # noqa: BLE001
        pass


async def fetch_source_maps(keys: list[str]) -> dict:
    from notebooklm import NotebookLMClient
    st = json.loads(STATE_P.read_text(encoding="utf-8"))
    maps: dict[str, list[str]] = {}
    async with await (lambda: NotebookLMClient.from_storage())() as client:
        for key in keys:
            nb_id = st["notebooks"].get(key)
            if not nb_id:
                continue
            srcs = await client.sources.list(nb_id)
            # 编号=源在笔记本中的序(1起), 标题做源名
            maps[key] = [getattr(s, "title", "") or getattr(s, "name", "")
                         for s in srcs]
            await asyncio.sleep(1)
    return maps


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--chapters", default="")
    ap.add_argument("--rewrite", action="store_true")
    ns = ap.parse_args()
    clash_put("默认节点", "🇺🇸 美国 02")
    time.sleep(2)
    nums = [int(x) for x in ns.chapters.split(",") if x.strip()] \
        or list(range(1, 13))
    keys = [f"ch{n:02d}" for n in nums]
    maps = asyncio.run(fetch_source_maps(keys))
    for n in nums:
        key = f"ch{n:02d}"
        draft_p = OUT / f"ch{n:02d}_初稿.md"
        if not draft_p.is_file() or key not in maps:
            print(f"[cite] ch{n:02d} 跳过(无稿或无映射)")
            continue
        names = maps[key]
        lines = [f"# 第{n}章 源引用对照",
                 f"源总数: {len(names)}",
                 "注: NB 引用编号按笔记本源列表序, 人工抽核2-3条确认对齐。",
                 ""]
        for i, nm in enumerate(names, 1):
            lines.append(f"[{i}] {nm}")
        (OUT / f"ch{n:02d}_源对照.md").write_text(
            "\n".join(lines), encoding="utf-8")
        print(f"[cite] ch{n:02d} 对照表 {len(names)} 源")
        if ns.rewrite:
            t = draft_p.read_text(encoding="utf-8")

            def rep(m):
                ids = [x.strip() for x in m.group(1).split(",")]
                nm = []
                for i in ids:
                    if i.isdigit() and 0 < int(i) <= len(names):
                        nm.append(names[int(i) - 1][:24])
                return "(" + "; ".join(nm) + ")" if nm else m.group(0)
            t2 = re.sub(r"\[([\d,\s]+)\]", rep, t)
            draft_p.with_name(
                f"ch{n:02d}_初稿_实名引用.md"
            ).write_text(t2, encoding="utf-8")
            print(f"[cite] ch{n:02d} 实名引用版已出")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
