# -*- coding: utf-8 -*-
"""sched_nblm_pack — NotebookLM 上传包整理器 (1020用户产线第一步: 资料整理).

从 EPC-SCHED 池按章 bank 排名 curate 上传源:
  nblm_upload/
    00_框架笔记本/        综述级源(全报告共用) ≤48源
    ch{NN}_笔记本/        每章 bank top 源(去重) ≤42源; 小件wenshu按章合并为判例合集
    NotebookLM指令集.md   框架prompt + 12章初稿prompt(嵌章纲+纪律)
    上传清单.md           每笔记本的源清单与字数
约束: NotebookLM 每笔记本源数上限(免费版50), 单源50万词内——均满足。
用法: py -X utf8 sched_nblm_pack.py
"""
from __future__ import annotations

import json
import re
import shutil
import sys
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
OUT = M2 / "nblm_upload"
POOL = Path(r"E:\AI-Station\ammo_pool\EPC-SCHED")
MAX_SRC = 42          # 每章笔记本源上限(留余量)
MERGE_CAP = 45        # wenshu 小件合并后的合集内件数上限


_NAME_INDEX: dict | None = None


def name_index() -> dict:
    """manifest 文件名/stem → 全路径 索引。"""
    global _NAME_INDEX
    if _NAME_INDEX is None:
        _NAME_INDEX = {}
        for ln in (POOL / "manifest.jsonl").read_text(
                encoding="utf-8").splitlines():
            if not ln.strip():
                continue
            try:
                r = json.loads(ln)
            except json.JSONDecodeError:
                continue
            sp = str(r.get("source_path", ""))
            if r.get("judge") == "valid" and sp:
                fp = Path(sp)
                if fp.is_file():
                    _NAME_INDEX.setdefault(fp.name, fp)
                    _NAME_INDEX.setdefault(fp.stem, fp)
    return _NAME_INDEX


def bank_paths(nn: str) -> list:
    """读 bank_chNN 的「路径:」行, 经文件名索引解析为全路径。"""
    t = (M2 / f"bank_ch{nn}.md").read_text(encoding="utf-8")
    idx = name_index()
    seen, out = set(), []
    for m in re.finditer(r"路径:\s*([^\n]+)", t):
        nm = m.group(1).strip()
        if "#" in nm or nm.startswith(("90_", "91_", "data/", "std")):
            continue
        fp = idx.get(nm) or idx.get(Path(nm).stem)
        if fp and str(fp) not in seen:
            seen.add(str(fp))
            out.append(fp)
    return out


def fsize(fp: Path) -> int:
    return fp.stat().st_size


def copy_as(fp: Path, dest_dir: Path, idx: int) -> str:
    name = f"{idx:02d}_" + re.sub(r'[\\/:*?"<>|\s]+', "_", fp.stem)[:60] \
        + fp.suffix.lower()
    dest = dest_dir / name
    if not dest.exists():
        shutil.copy2(fp, dest)
    return name


def merge_small(files: list[Path], dest: Path, cap: int) -> int:
    """把 wenshu 小 md 合并成 判例合集N.md, 每合集≤cap 件。"""
    smalls = [f for f in files if "wenshu_sched_scan" in str(f)]
    bigs = [f for f in files if "wenshu_sched_scan" not in str(f)]
    n = 0
    for i in range(0, len(smalls), cap):
        chunk = smalls[i:i + cap]
        parts = [f"# 判例合集 {n+1}（第部分 {i+1}-{i+len(chunk)}）\n"]
        for f in chunk:
            try:
                txt = f.read_text(encoding="utf-8", errors="replace")[:20000]
            except OSError:
                continue
            parts.append(
                f"\n\n---\n\n# 案例文件: {f.stem}\n\n{txt}")
        (dest / f"99_判例合集{n+1}.md").write_text(
            "".join(parts), encoding="utf-8")
        n += 1
    return n + len(bigs)


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    if OUT.exists():
        print("[pack] nblm_upload 已存在——为保既有内容不覆盖, 先人工确认")
        return 1
    chapters = json.loads((M2 / "chapters.json").read_text(encoding="utf-8"))
    manifest = ["# NotebookLM 上传清单\n",
                "> 产线: 整理→上传→NB框架→NB各章初稿 (1020用户令)\n"]

    # ---- 00 框架笔记本: 综述级源(手工指定) ----
    fw_dir = OUT / "00_框架笔记本"
    fw_dir.mkdir(parents=True)
    fw_specs = [
        "司法解释二答记者问", "窗口分析", "停工损失_", "工期签证_",
        "工期顺延 签证_", "工期顺延的行权机制", "承包商索赔研究",
        "华龙一号挣值", "网络计划技术在", "FIDIC", "国际EPC案例",
        "海外工程巨额亏损", "P6项目进度控制", "停工权研究",
    ]
    idx, fw_files = 0, []
    for ln in (POOL / "manifest.jsonl").read_text(encoding="utf-8").splitlines():
        r = json.loads(ln)
        if r.get("judge") != "valid":
            continue
        p = str(r.get("source_path", ""))
        if any(k in Path(p).stem or k in p for k in fw_specs) and Path(p).is_file():
            if p not in [str(x) for x in fw_files]:
                fw_files.append(Path(p))
    fw_files.sort(key=lambda f: -fsize(f))
    kept = 0
    for f in fw_files[:48]:
        idx += 1
        copy_as(f, fw_dir, idx)
        kept += 1
    manifest.append(f"\n## 00_框架笔记本（{kept} 源, 全报告共用）")
    for f in sorted(fw_dir.glob("*")):
        manifest.append(f"- {f.name}（{fsize(f):,}B）")

    # ---- 章笔记本 ----
    for ch in chapters:
        nn = f"{ch['no']:02d}"
        d = OUT / f"ch{nn}_笔记本"
        d.mkdir(parents=True)
        files = bank_paths(nn)
        bigs = [f for f in files if "wenshu_sched_scan" not in str(f)][:20]
        smalls = [f for f in files if "wenshu_sched_scan" in str(f)][:60]
        idx = 0
        names = []
        for f in bigs:
            idx += 1
            names.append(copy_as(f, d, idx))
        n_merge = 0
        for i in range(0, len(smalls), MERGE_CAP):
            chunk = smalls[i:i + MERGE_CAP]
            parts = [f"# 第{ch['no']}章 判例合集 {n_merge+1}\n"]
            for f in chunk:
                try:
                    txt = f.read_text(encoding="utf-8", errors="replace")[:20000]
                except OSError:
                    continue
                parts.append(f"\n\n---\n\n# 案例文件: {f.stem}\n\n{txt}")
            nm = f"90_判例合集{n_merge+1}.md"
            (d / nm).write_text("".join(parts), encoding="utf-8")
            names.append(nm)
            n_merge += 1
        total = sum(fsize(d / n) for n in names)
        manifest.append(
            f"\n## ch{nn}_笔记本（{len(names)} 源, {total:,}B）"
            f"「{ch['title'][:24]}」")
        for n in names:
            manifest.append(f"- {n}（{fsize(d/n):,}B）")
        print(f"[pack] ch{nn}: {len(names)} 源 {total:,}B")

    # ---- 指令集 ----
    prompts = ["# NotebookLM 指令集（复制粘贴用）\n",
               "\n## 一、框架生成指令（在 00_框架笔记本 中发送）\n",
               "你是资深工程咨询研究团队。基于本笔记本全部资料，为中国施工企业"
               "读者生成一份《工程工期管理与延误索赔实战指南》的报告框架："
               "12章结构，每章给出章题、本章解决什么问题、3-6个小节标题与要点、"
               "建议引用的资料主题。要求：面向承包商实战（判责任/保工期/索赔/算钱），"
               "规则与案例并重，语言平实无术语堆砌。\n"]
    for ch in chapters:
        nn = f"{ch['no']:02d}"
        prompts.append(
            f"\n## 章{ch['no']}初稿指令（在 ch{nn}_笔记本 中发送）\n\n"
            f"你是资深工程咨询研究团队。基于本笔记本全部资料，撰写报告第{ch['no']}章"
            f"「{ch['title']}」的完整初稿（12000-15000字）。要求：开篇一段说明本章帮"
            f"读者解决什么问题；小节结构与要点如下……（按框架生成的小节写）；所有数字"
            f"与案例必须来自笔记本资料并注明来源文件；判例写清案情-裁判-教训；每节末"
            f"给可执行动作；结尾附「小结六问/反证三问/证据盲区」。语言面向施工企业"
            f"项目经理/商务/造价/法务，平实具体，不用计算机术语。\n")
    (OUT / "NotebookLM指令集.md").write_text("\n".join(prompts), encoding="utf-8")
    (OUT / "上传清单.md").write_text("\n".join(manifest), encoding="utf-8")
    nb = sum(1 for _ in OUT.iterdir())
    print(f"[pack] 完成: {OUT} | {nb} 个笔记本目录 | 指令集+清单已落盘")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
