# -*- coding: utf-8 -*-
"""top50_nblm_pack - 第11份 EPC-TOP50 NBLM 上传包整理器 (照 JIAGE sched_nblm_pack 型).

产出 (campaign dir = m2/top50/sched):
  nblm_upload/00_战役总笔记本/   12 bank 各 top 锚点块(NB章基底3+底料7)合并=12源, <=50
  nblm_upload/ch{NN}_笔记本/     bank 路径序 top 全文源(去重,<=40) + bank全38块锚点合集1源
  nblm_upload/NotebookLM指令集.md  框架prompt + 12章初稿prompt (三场景/买家版)
  nblm_upload/上传清单.md          每笔记本源清单与字数
铁律: 只新增不删除; 幂等(已存在跳过); 锚点合集逐字取自 bank 块.
用法: py -X utf8 top50_nblm_pack.py [--anchors 10]
"""
from __future__ import annotations

import json
import re
import shutil
import sys
from pathlib import Path

M2TOP = Path(__file__).resolve().parent
SCHED = M2TOP / "sched"
UPLOAD = SCHED / "nblm_upload"
POOL = Path(r"E:\AI-Station\ammo_pool\EPC-TOP50")
MAX_CH = 40
ANCHORS = 10

REPORT = "工程企业工程总承包业务全景研究报告：2025 TOP50"
BUYERS = "工程企业高管、设计院院长、EPC从业者"


def name_index() -> dict:
    idx: dict = {}
    for ln in (POOL / "manifest.jsonl").read_text(encoding="utf-8").splitlines():
        ln = ln.strip()
        if not ln:
            continue
        try:
            r = json.loads(ln)
        except json.JSONDecodeError:
            continue
        sp = str(r.get("source_path", ""))
        if r.get("judge") == "valid" and sp:
            fp = Path(sp)
            if fp.is_file():
                idx.setdefault(fp.name, fp)
                idx.setdefault(fp.stem, fp)
    return idx


def bank_paths(nn: str, idx: dict) -> list:
    t = (SCHED / ("bank_ch" + nn + ".md")).read_text(encoding="utf-8")
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


def bank_blocks(nn: str) -> list:
    t = (SCHED / ("bank_ch" + nn + ".md")).read_text(encoding="utf-8")
    parts = re.split(r"(?m)^(?=## P\d{6})", t)
    return [p.strip() for p in parts[1:] if p.strip()]


def copy_as(fp: Path, dest_dir: Path, idx: int) -> str:
    name = str(idx).zfill(2) + "_" + re.sub(
        r'[\/:*?"<>|\s]+', "_", fp.stem)[:55] + fp.suffix.lower()
    dest = dest_dir / name
    if not dest.exists():
        shutil.copy2(fp, dest)
    return name


def chapters() -> list:
    return json.loads((SCHED / "chapters.json").read_text(encoding="utf-8"))


def chapter_prompt_md(ch: dict) -> str:
    kws = "、".join(ch["kws"])
    return (
        "## 第" + str(ch["no"]) + "章「" + ch["title"] + "」初稿指令（在 ch"
        + str(ch["no"]).zfill(2) + "_笔记本 中分段发送）\n"
        "你是深耕工程行业的资深研究总监。基于本笔记本全部资料，撰写《" + REPORT
        + "》第" + str(ch["no"]) + "章「" + ch["title"] + "」完整初稿"
        "（15000-20000字），读者是" + BUYERS + "。本章主题词：" + kws
        + "（树子问 " + ",".join(ch.get("subqs", [])) + "）。"
        "要求：开篇一段说明本章帮读者解决什么问题；按小节展开，企业案例写清"
        "数据-动作-结果，方法给可执行步骤；所有数字与企业名必须来自笔记本资料，"
        "句末标注来源编号；语言平实具体面向买家决策，不用计算机术语与空话套话；"
        "章末附「小结要点」与「本章证据边界」。分四段生成：段1前部小节约6000字"
        "→段2中部小节约5000字（只写段1未输出的小节）→段3后部小节收束约5000字"
        "（只写未输出的小节，含小结要点与证据边界）→段4《源引用对照》清单"
        "（编号→源名→内容摘要，不重复正文）。\n\n")


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    global ANCHORS
    if "--anchors" in sys.argv:
        ANCHORS = int(sys.argv[sys.argv.index("--anchors") + 1])
    chs = chapters()
    idx = name_index()
    UPLOAD.mkdir(exist_ok=True)
    fw_dir = UPLOAD / "00_战役总笔记本"
    fw_dir.mkdir(exist_ok=True)
    manifest_lines = ["# 上传清单 (EPC-TOP50 第11份 NBLM 产线)\n"]
    sep = "\n\n---\n\n"

    manifest_lines.append("\n## 00_战役总笔记本 (NB章基底3+底料7 锚点块合并=12源)\n")
    for ch in chs:
        nn = str(ch["no"]).zfill(2)
        allb = bank_blocks(nn)
        nb_anch = [b for b in allb if "NB章基底" in b.splitlines()[0]]
        ranked = [b for b in allb if "NB章基底" not in b.splitlines()[0]]
        blocks = nb_anch + ranked[:max(0, ANCHORS - len(nb_anch))]
        title = "c" + nn + "_锚点合集_" + ch["title"][:18]
        fname = re.sub(r'[\/:*?"<>|\s]+', "_", title)[:60] + ".md"
        body = ("# 第" + str(ch["no"]) + "章「" + ch["title"] + "」top"
                + str(len(blocks)) + "锚点合集(逐字取自 bank_ch" + nn
                + ".md, 块序=NB锚优先+排名序)\n\n" + sep.join(blocks) + "\n")
        fp = fw_dir / fname
        if not fp.exists():
            fp.write_text(body, encoding="utf-8")
        manifest_lines.append("- " + fname + " | " + str(len(blocks)) + "块 | "
                              + f"{fp.stat().st_size:,}" + "B | " + ch["title"])
    n_fw = len(list(fw_dir.glob("*.md")))
    print("[pack] 00_战役总笔记本: " + str(n_fw) + " 源 "
          + ("(<=50 OK)" if n_fw <= 50 else "超限!"))

    for ch in chs:
        nn = str(ch["no"]).zfill(2)
        d = UPLOAD / ("ch" + nn + "_笔记本")
        d.mkdir(exist_ok=True)
        paths = bank_paths(nn, idx)[:MAX_CH]
        manifest_lines.append("\n## ch" + nn + "_笔记本 (" + ch["title"][:20]
                              + ") 全文源" + str(len(paths)) + "+锚点合集1\n")
        for i, fp in enumerate(paths, 1):
            name = copy_as(fp, d, i)
            manifest_lines.append("- " + name + " | " + f"{fp.stat().st_size:,}" + "B")
        allb = bank_blocks(nn)
        if allb:
            dblock = d / ("00_ch" + nn + "_bank锚点合集_" + str(len(allb)) + "块.md")
            if not dblock.exists():
                dblock.write_text(
                    "# 第" + str(ch["no"]) + "章 bank 全锚点合集 (逐字取自 bank_ch"
                    + nn + ".md, 块序=排名序)\n\n" + sep.join(allb) + "\n",
                    encoding="utf-8")
            manifest_lines.append("- " + dblock.name + " | "
                                  + f"{dblock.stat().st_size:,}" + "B | bank锚点合集")
        n = len(list(d.iterdir()))
        print("[pack] ch" + nn + "_笔记本: " + str(n) + " 源 "
              + ("OK" if n <= 48 else "超限!"))

    fw_prompt = (
        "# NotebookLM 指令集（EPC-TOP50 第11份, 复制粘贴用）\n\n"
        "## 一、框架生成指令（在 00_战役总笔记本 中发送, 前段自动前置 STORM 多视角问题块）\n"
        "你是工程建设行业首席研究总监。基于本笔记本全部资料，为《" + REPORT
        + "》设计12章实战目录框架。读者是" + BUYERS + "，报告必须同时服务三类"
        "使用场景：①全景画像（谁是50强、格局如何、钱与人在哪）；②分档对比"
        "（头部/中坚/追赶各档企业的能力与打法差异）；③行动清单（不同位置的"
        "企业下一步怎么干）。要求：1)每章标题用判断句而非名词堆砌；2)每章列出"
        "本章解决的读者问题与3-6个小节要点；3)按读者认知路径排序：全景画像→"
        "榜单与口径→央企集团军→专业赛道→区域梯队→设计院转型路径→项目管理交付→"
        "营收盈利风险→人才组织→数字化创新→50强分档画像→三场景行动清单；"
        "4)每章注明建议引用的资料主题，并标注该章主要服务哪一场景（全景画像/"
        "分档对比/行动清单）；5)全部简体中文，不超过3000字。\n\n"
        + "".join(chapter_prompt_md(c) for c in chs))
    (UPLOAD / "NotebookLM指令集.md").write_text(fw_prompt, encoding="utf-8")
    (UPLOAD / "上传清单.md").write_text("\n".join(manifest_lines) + "\n",
                                         encoding="utf-8")
    print("[pack] 指令集 " + f"{len(fw_prompt):,}" + "B | 上传清单落盘")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
