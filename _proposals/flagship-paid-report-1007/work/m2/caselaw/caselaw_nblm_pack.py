# -*- coding: utf-8 -*-
"""caselaw_nblm_pack - 第12份 EPC-CASELAW NBLM 上传包整理器 (JIAGE锚点块模型 + TOP50轮转封面).

打包源选型 (与 TOP50 全文件模型不同的实锚原因): 本池 top 底料为 364MB 级
判决语料切片 (crosspool:EPC-CONTRACT / corpus_stores:judgment_slice), 整文件
不可上传 → 照 JIAGE 验证线用 bank_chNN.md 锚点块 (逐字 6000 字头, 块内即证据
原文, 如实搬运不重写)。

产出 (campaign dir = m2/caselaw/sched):
  nblm_upload/00_战役总笔记本/   12 bank 各 (NB锚优先+排名补) 合并=1源 → 12 源 ≤50
  nblm_upload/ch{NN}_笔记本/     每章 NB锚(≤3)+排名块去重 共 20 个独立源文件
                                  (源名开头两位数字=章prompt引用的[源编号])
  nblm_upload/NotebookLM指令集.md / 上传清单.md
铁律: 只新增不删除; 幂等(已存在跳过); 锚点块逐字取自 bank。
用法: py -X utf8 caselaw_nblm_pack.py [--per-ch 20] [--fw-rows 4]
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
SCHED = HERE / "sched"
UPLOAD = SCHED / "nblm_upload"
POOL = Path(r"E:\AI-Station\ammo_pool\EPC-CASELAW")
PER_CH = 20
FW_ROWS = 4

REPORT = "工程造价争议判例谱系与调解实务研究报告·2026"
BUYERS = "工程造价工程师、商务经理、工程法务与建工律师"


def chapters() -> list:
    return json.loads((SCHED / "chapters.json").read_text(encoding="utf-8"))


def bank_blocks(nn: str) -> list[dict]:
    """bank_chNN.md → 块列表 (NB锚 与 排名块 分型)."""
    t = (SCHED / f"bank_ch{nn}.md").read_text(encoding="utf-8")
    parts = re.split(r"(?m)^(?=## P\d{6})", t)
    out = []
    for p in parts[1:]:
        p = p.strip()
        if not p:
            continue
        head = p.splitlines()[0]
        is_nb = "NB章基底" in head
        pm = re.search(r"路径:\s*([^\n]+)", p)
        path = pm.group(1).strip() if pm else "?"
        m = re.match(r"## P(\d+)", head)
        pid = m.group(1) if m else "0"
        if is_nb:
            score_m = re.search(r"(\d+)分\s+([\d,]+)字", head)
            score = int(score_m.group(1)) if score_m else 0
            src_chars = int(score_m.group(2).replace(",", "")) if score_m else 0
        else:
            score_m = re.search(r"分(\d+)\s+([\d,]+)字\s+(\S+)\s+(\S+)(?:\s+T1:(\d+))?", head)
            if not score_m:
                continue
            score = int(score_m.group(1))
            src_chars = int(score_m.group(2).replace(",", ""))
        out.append({"pid": pid, "nb": is_nb, "score": score,
                    "src_chars": src_chars, "path": path,
                    "body": p, "chars": len(p)})
    return out


def sanitize(name: str) -> str:
    return re.sub(r'[\\/:*?"<>|\s#]+', "_", name)[:60]


def block_stem(b: dict) -> str:
    p = b["path"]
    if "#" in p:                       # NB 锚: 卷名#源章标题 → 取源章标题
        p = p.split("#", 1)[1]
    return Path(p).stem if p != "?" else f"P{b['pid']}"


def block_head(b: dict, ch_nn: str) -> str:
    tag = "NB章基底(历史报告库)" if b["nb"] else "底料锚点"
    return (f"[{tag} P{b['pid']} | 评分:{b['score']} | 底料:{b['src_chars']:,}字 | "
            f"采集章:ch{ch_nn} | 以下为证据原文逐字搬运]\n\n")


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    if "--per-ch" in sys.argv:
        global PER_CH
        PER_CH = int(sys.argv[sys.argv.index("--per-ch") + 1])
    if "--fw-rows" in sys.argv:
        global FW_ROWS
        FW_ROWS = int(sys.argv[sys.argv.index("--fw-rows") + 1])

    chs = chapters()
    banks = {f"{c['no']:02d}": bank_blocks(f"{c['no']:02d}") for c in chs}
    for nn, bl in banks.items():
        nb_n = sum(1 for b in bl if b["nb"])
        print(f"[parse] bank ch{nn}: {len(bl)} 块 (NB锚{nb_n}+排名{len(bl)-nb_n})")

    UPLOAD.mkdir(exist_ok=True)
    manifest = [f"# 上传清单 (EPC-CASELAW 第12份 NBLM 产线)\n",
                "> 打包源 = bank_chNN.md 锚点块 (6000字头逐字搬运, 整文件因364MB级语料切片不可上传)",
                f"> 框架本 = 12 bank × 每章{FW_ROWS}块轮转合并 = 12 源; 章本 = NB锚+排名块 {PER_CH} 源/章", ""]
    sep = "\n\n---\n\n"

    # ---- 00 战役总笔记本: 每 bank (NB锚优先 + 排名补) 合并 1 源 ----
    fw_dir = UPLOAD / "00_战役总笔记本"
    fw_dir.mkdir(exist_ok=True)
    fw_names = []
    for ch in chs:
        nn = f"{ch['no']:02d}"
        bl = banks[nn]
        nb_b = [b for b in bl if b["nb"]][:2]
        rk_b = [b for b in bl if not b["nb"] and b["chars"] >= 400]
        picked, seen = [], set()
        for b in nb_b + rk_b:
            if b["path"] in seen:
                continue
            seen.add(b["path"])
            picked.append(b)
            if len(picked) >= FW_ROWS:
                break
        title = f"c{nn}_锚点合集_{ch['title'][:18]}"
        fname = sanitize(title)[:60] + ".md"
        fp = fw_dir / fname
        body = (f"# 第{ch['no']}章「{ch['title']}」top{len(picked)}锚点合集"
                f"(逐字取自 bank_ch{nn}.md, NB锚优先+排名序)\n\n"
                + sep.join(block_head(b, nn) + b["body"] for b in picked) + "\n")
        if not fp.exists():
            fp.write_text(body, encoding="utf-8")
        fw_names.append(fname)
        manifest.append(f"- {fname} | {len(picked)}块 | {fp.stat().st_size:,}B | {ch['title']}")
    n_fw = len(list(fw_dir.glob("*.md")))
    fw_total = sum(f.stat().st_size for f in fw_dir.glob("*.md"))
    print(f"[pack] 00_战役总笔记本: {n_fw} 源 {fw_total:,}B " + ("(<=50 OK)" if n_fw <= 50 else "超限!"))

    # ---- chNN 笔记本: NB锚(≤3)+排名块 去重 → PER_CH 个独立源文件 ----
    for ch in chs:
        nn = f"{ch['no']:02d}"
        d = UPLOAD / f"ch{nn}_笔记本"
        d.mkdir(exist_ok=True)
        bl = banks[nn]
        nb_b = [b for b in bl if b["nb"]][:3]
        rk_b = [b for b in bl if not b["nb"] and b["chars"] >= 400]
        picked, seen = [], set()
        for b in nb_b + rk_b:
            if b["path"] in seen:
                continue
            seen.add(b["path"])
            picked.append(b)
            if len(picked) >= PER_CH:
                break
        manifest.append(f"\n## ch{nn}_笔记本（{len(picked)} 源）「{ch['title'][:24]}」")
        for i, b in enumerate(picked, 1):
            nm = f"{i:02d}_{sanitize(block_stem(b))}.md"
            fp = d / nm
            if not fp.exists():
                fp.write_text(block_head(b, nn) + b["body"] + "\n", encoding="utf-8")
            manifest.append(f"- {nm} | {fp.stat().st_size:,}B | "
                            + ("NB锚" if b["nb"] else f"分{b['score']}"))
        total = sum((d / f"{i:02d}_{sanitize(block_stem(b))}.md").stat().st_size
                    for i, b in enumerate(picked, 1))
        print(f"[pack] ch{nn}_笔记本: {len(picked)} 源 {total:,}B "
              + ("OK" if len(picked) <= 50 else "超限!"))

    # ---- 指令集 ----
    fw_prompt = (
        "# NotebookLM 指令集（EPC-CASELAW 第12份, 复制粘贴用）\n\n"
        "## 一、框架生成指令（在 00_战役总笔记本 中发送, 前段自动前置 STORM 多视角问题块）\n"
        "你是工程建设行业首席研究总监。基于本笔记本全部资料，为《" + REPORT
        + "》设计12章实战目录框架。读者是" + BUYERS + "，报告必须同时服务三类"
        "使用场景：①争议防控（签约阶段条款设计与履约证据留痕）；②争议应对"
        "（结算审减、变更签证索赔、造价鉴定攻防）；③争议解决（调解、争议评审、"
        "仲裁与诉讼路径选择）。要求：1)每章标题用判断句而非名词堆砌；2)每章列出"
        "本章解决的读者问题与3-6个小节要点；3)按读者认知路径排序：争议全景与谱系"
        "方法论→类案检索方法→固定总价→结算审减→变更签证索赔→造价鉴定→工期费用"
        "索赔→合同效力与黑白合同→优先受偿权→调解与ADR→仲裁与诉讼→判例谱系总表"
        "与行动清单；4)每章注明建议引用的资料主题，并标注该章主要服务哪一场景；"
        "5)全部简体中文，不超过3000字。\n")
    (UPLOAD / "NotebookLM指令集.md").write_text(fw_prompt, encoding="utf-8")
    (UPLOAD / "上传清单.md").write_text("\n".join(manifest) + "\n", encoding="utf-8")
    print(f"[pack] 指令集 {len(fw_prompt):,}B | 上传清单落盘 | {UPLOAD}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
