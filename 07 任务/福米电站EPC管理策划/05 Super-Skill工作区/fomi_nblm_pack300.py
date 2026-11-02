# -*- coding: utf-8 -*-
"""fomi_nblm_pack300 - 用户令(1102): 调研资料整理合并全量上 NBLM, 单笔记本≤300文件.
从池 manifest + bdn_staging 拉取库出发, 按主题域合并打包(每包≤CAP_CHARS字, 含来源清单头),
产物落 nblm_upload/00_战役总笔记本/ (编号 p20 起, 避让 c01-c13 既有源).
铁律: 只新增; 幂等; 文本清洗(surrogates); 来源清单逐件标注(零编造可溯源).
用法: py -X utf8 fomi_nblm_pack300.py [--max-files 265] [--cap-mb 2]
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool                                        # noqa: E402

WS = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区")
FW = WS / "nblm_upload" / "00_战役总笔记本"
STAGING = WS / "bdn_staging"
POOL = Path(r"E:\AI-Station\ammo_pool\FOMI-EPC")
SRC = Path(r"E:\AI-Station\07 任务\福米电站EPC管理策划")

MAX_FILES = 265
CAP_CHARS = 2_000_000
MIN_CHARS = 150
PACK_START = 20

#: 主题域路由: (匹配函数于 (engine, source_path)) → 域名
THEMES: list = [
    ("福米项目原件", lambda e, p: "fomi_project" in e or ("07 任务" in p and "05 Super" not in p)),
    ("兰州专著一手档案", lambda e, p: "lanzhou_monograph" in e or "兰州水源地专著" in p),
    ("兰州档案doc转换", lambda e, p: "lanzhou_doc_conv" in e or "doc_converted" in p),
    ("总包创新院库", lambda e, p: "zbcx_institute" in e or "AI总包创新院" in p),
    ("几内亚凯乐塔前例", lambda e, p: "kaleta" in e.lower() or "凯乐塔" in p),
    ("国际项目管理库198", lambda e, p: "intl_pm198" in e or "国际项目管理库" in p),
    ("总包大脑知识库", lambda e, p: "bdn:brain" in e or "总包大脑" in p or "brain" in p.lower()),
    ("网盘检索直下件", lambda e, p: e.startswith("bdn:")),
    ("调度采集语料", lambda e, p: True),          # 兜底域: dispatcher 各渠道
]


def clean(t: str) -> str:
    return (t or "").encode("utf-8", errors="ignore").decode("utf-8")


def subtheme(path: str) -> str:
    """域内二级主题: 取源路径的特征目录段."""
    p = path.replace("\\", "/")
    for key in ("凯乐塔",):                        # 凯乐塔按子目录细分
        if key in p:
            seg = [s for s in p.split("/") if s.strip()]
            for i, s in enumerate(seg):
                if key in s and i + 1 < len(seg):
                    return seg[i + 1][:18]
    seg = [s for s in p.split("/") if s.strip() and not re.match(r"^\d{8}_", s)]
    return (seg[-2][:16] if len(seg) >= 2 else Path(p).stem[:16])


def theme_of(engine: str, path: str) -> tuple:
    for name, fn in THEMES:
        try:
            if fn(engine, path):
                return name
        except Exception:
            continue
    return "调度采集语料"


def read_text(fp: Path) -> str:
    try:
        text, _ = ammo_pool._format_to_text(fp)
    except Exception:
        return ""
    return clean(text)


def main() -> int:
    if "--max-files" in sys.argv:
        global MAX_FILES
        MAX_FILES = int(sys.argv[sys.argv.index("--max-files") + 1])
    global PACK_START
    items = []
    mp = POOL / "manifest.jsonl"
    if mp.is_file():
        for ln in mp.read_text(encoding="utf-8").splitlines():
            ln = ln.strip()
            if not ln:
                continue
            try:
                o = ammo_pool._jload(ln)
            except Exception:
                continue
            if ammo_pool.RAW_MARK in o:
                continue
            items.append((o.get("engine", ""), o.get("source_path", ""),
                          o.get("chars", 0)))
    # bdn_staging 拉取库(未入池的也收)
    for f in STAGING.rglob("*"):
        if f.is_file() and f.suffix.lower() in (".md", ".txt", ".pdf", ".docx"):
            s = str(f)
            if any(s == p for _, p, _ in items):
                continue
            items.append(("bdn:staging", s, f.stat().st_size))
    print(f"[pack300] 候选源件 {len(items)}")

    # 分域 → (域, 子题) 分组
    groups: dict = {}
    for eng, path, ch in items:
        fp = Path(path)
        if not fp.is_file() or (ch and ch < MIN_CHARS):
            continue
        th = theme_of(eng, path)
        st = subtheme(path)
        groups.setdefault((th, st), []).append((fp, ch or 0))

    # 打包: 每组可裂多包(超CAP_CHARS), 包数控制在预算内
    packs: list = []          # (fname, [(fp, chars)])
    # 重跑安全: 编号避让既有 pNNN 包
    exist_p = sorted(int(m.group(1)) for f in FW.glob("p[0-9][0-9][0-9]_*.md")
                     if (m := re.match(r"p(\d{3})_", f.name)))
    if exist_p:
        PACK_START = exist_p[-1] + 1
        MAX_FILES = max(MAX_FILES, PACK_START + 5)
        print(f"[pack300] 既有包至 p{exist_p[-1]:03d} → 本轮自 p{PACK_START:03d} 起")
    budget = MAX_FILES - PACK_START
    group_list = sorted(groups.items(),
                        key=lambda x: -sum(c for _, c in x[1]))
    for (th, st), files in group_list:
        if len(packs) >= budget:
            break
        files = sorted(files, key=lambda x: -x[1])
        cur, cur_chars = [], 0
        n_in_group = 0
        for fp, ch in files:
            est = ch if ch > 500 else max(500, fp.stat().st_size)
            if cur and cur_chars + est > CAP_CHARS:
                packs.append((th, st, len(packs), cur))
                cur, cur_chars = [], 0
                if len(packs) >= budget:
                    break
            cur.append(fp)
            cur_chars += est
            n_in_group += 1
            if n_in_group >= 60:                # 每包最多60件源(可溯源清单不失控)
                break
        if cur:
            packs.append((th, st, len(packs), cur))

    manifest = ["# NBLM 300 全量包 上传清单 (整理合并后)\n",
                f"> 上限纪律: 单笔记本≤300文件; 本批 p{PACK_START}起 "
                f"{len(packs)} 包 + 既有13源 = {len(packs) + 13} ≤ 300\n"]
    for i, (th, st, _, files) in enumerate(packs):
        fname = f"p{PACK_START + i:03d}_{th[:8]}_{re.sub(chr(92)+'W+','_',st)[:14]}.md"
        fp_out = FW / fname
        parts = [f"# 【{th}·{st}】合并包 (源{len(files)}件)\n",
                 "> 本文件为多份调研资料原文合并; 来源清单如下, 文内以『◆源: 文件名』分隔。\n"]
        src_list = []
        for fp in files:
            src_list.append(f"- {fp.name} ({fp.stat().st_size:,}B)")
        parts.append("\n## 来源清单\n" + "\n".join(src_list) + "\n\n---\n")
        for fp in files:
            text = read_text(fp)
            if not text.strip():
                continue
            parts.append(f"\n\n◆源: {fp.name}\n\n{text[:CAP_CHARS // max(1, len(files))]}")
        body = clean("".join(parts))
        if not fp_out.exists():
            fp_out.write_text(body, encoding="utf-8")
        manifest.append(f"- {fname} | 源{len(files)}件 | {fp_out.stat().st_size:,}B")
        print(f"[pack300] {fname} 源{len(files)} {fp_out.stat().st_size:,}B")
    (WS / "nblm_upload" / "上传清单_300包.md").write_text(
        "\n".join(manifest) + "\n", encoding="utf-8")
    total = len(list(FW.glob("*.md"))) + len(list(FW.glob("*.pdf")))
    print(f"[pack300] 总本文件数 {total} (≤300: {'OK' if total <= 300 else '超限!'})")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
