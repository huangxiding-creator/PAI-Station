# -*- coding: utf-8 -*-
"""nblm_pack_jiage — JIAGE 第10份报告 NotebookLM 上传包整理器 (1026 用户令适配版).

蓝本: m2/sched_nblm_pack.py (SCHED 战役验证件) — 打包源适配:
  SCHED 版 = ammo_pool manifest 路径行 → 整底料文件
  JIAGE 版 = bank_chNN.md 的 top 锚点块 (P锚块=完整证据文本, 块内~5.9k字)

产出 nblm_upload/:
  00_战役总笔记本/   全书级代表源 ≤50 (12 bank 轮转保覆盖; 十大维=每章映射全覆盖)
  chNN_笔记本/       每 bank top 锚点块 (章内路径去重, 取 15-20)
  NotebookLM指令集.md / 上传清单.md

约束: NBLM 免费版每笔记本 ≤50 源; 块内文本即证据原文, 如实搬运不重写。
用法: py -X utf8 nblm_pack_jiage.py [--top-per-ch 20] [--framework-rows 4]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "nblm_upload"
BLOCK_RE = re.compile(r"## P(\d+) \(([^)]+)\)(.*?)(?=\n## P|\Z)", re.S)
FW_CAP = 50          # 战役总笔记本源上限 (免费版 50, 留 0 余量按实计)
DIM_ORDER = [
    "政策法规与定额体系", "计价依据与定额测定", "信息价与市场价基准",
    "投标编制实务", "结算核对实务", "合同解除结算", "造价鉴定与争议",
    "清单与定额计价模式", "造价咨询与职业", "数据源与工具生态",
]


def parse_bank(nn: str) -> list[dict]:
    """bank_chNN.md → 锚块列表 (按分数降序, 原序即降序)."""
    t = (HERE / f"bank_ch{nn}.md").read_text(encoding="utf-8")
    blocks = []
    for m in BLOCK_RE.finditer(t):
        pid, head, body = m.group(1), m.group(2), m.group(3)
        pm = re.search(r"路径:\s*([^\n]+)", body)
        path = pm.group(1).strip() if pm else "?"
        hm = re.match(r"分(\d+)\s+([\d,]+)字\s+(\S+)\s+(\S+)(?:\s+T1:(\d+))?", head)
        if not hm:
            continue
        blocks.append({
            "pid": pid, "score": int(hm.group(1)), "src_chars": int(hm.group(2).replace(",", "")),
            "channel": hm.group(3), "kind": hm.group(4), "t1": int(hm.group(5) or 0),
            "path": path, "body": body.strip(),
            "block_chars": len(body),
        })
    return blocks


def sanitize(name: str) -> str:
    return re.sub(r'[\\/:*?"<>|\s#]+', "_", name)[:60]


def block_file_name(prefix: str, b: dict) -> str:
    stem = Path(b["path"]).stem if b["path"] != "?" else f"P{b['pid']}"
    return f"{prefix}_{sanitize(stem)}.md"


def block_content(b: dict, ch_nn: str) -> str:
    head = (f"[证据块 P{b['pid']} | 评分:{b['score']} | 渠道:{b['channel']} | "
            f"类型:{b['kind']} | 底料:{b['src_chars']:,}字 | T1命中:{b['t1']} | "
            f"采集章:ch{ch_nn}]\n\n")
    return head + b["body"] + "\n"


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--top-per-ch", type=int, default=20)
    ap.add_argument("--framework-rows", type=int, default=4,
                    help="战役总笔记本每 bank 轮转取数 (12×4=48≤50)")
    ns = ap.parse_args()

    chapters = json.loads((HERE / "chapters.json").read_text(encoding="utf-8"))
    banks = {f"{c['no']:02d}": parse_bank(f"{c['no']:02d}") for c in chapters}
    for nn, bl in banks.items():
        print(f"[parse] bank ch{nn}: {len(bl)} 锚块")

    if OUT.exists():
        print("[pack] nblm_upload 已存在——不覆盖 (不删既有件), 如需重跑先人工处置")
        return 1

    manifest = ["# JIAGE NotebookLM 上传清单 (1026)",
                "> 产线: 总笔记本框架 NBLM 化 → 按框架逐章初稿 NBLM 化",
                "> 打包源 = bank_chNN.md top 锚点块 (完整证据文本, 如实搬运)",
                f"> 十大维覆盖 = 12 bank × 每章≥{ns.framework_rows}源轮转 (章↔维映射见尾注)", ""]

    # ---- 00 战役总笔记本: 12 bank 轮转 ≤FW_CAP ----
    fw_dir = OUT / "00_战役总笔记本"
    fw_dir.mkdir(parents=True)
    used_paths: set[str] = set()
    fw_picked: list[dict] = []
    rows = ns.framework_rows
    for r in range(rows):
        for nn in banks:
            if len(fw_picked) >= FW_CAP:
                break
            for b in banks[nn]:
                if b["path"] in used_paths or b["block_chars"] < 400:
                    continue
                used_paths.add(b["path"])
                fw_picked.append({**b, "from_ch": nn})
                break
    fw_names = []
    for i, b in enumerate(fw_picked, 1):
        nm = block_file_name(f"S{i:02d}", b)
        (fw_dir / nm).write_text(block_content(b, b["from_ch"]), encoding="utf-8")
        fw_names.append(nm)
    fw_total = sum(f.stat().st_size for f in fw_dir.glob("*.md"))
    ch_cov = {}
    for b in fw_picked:
        ch_cov[b["from_ch"]] = ch_cov.get(b["from_ch"], 0) + 1
    manifest.append(f"## 00_战役总笔记本（{len(fw_names)} 源, {fw_total:,}B）")
    manifest.append(f"章覆盖: {json.dumps(ch_cov, ensure_ascii=False)}")
    for nm in fw_names:
        manifest.append(f"- {nm}（{(fw_dir / nm).stat().st_size:,}B）")

    # ---- chNN 笔记本: 每 bank top 锚块 (章内去重 15-20) ----
    for nn, bl in banks.items():
        d = OUT / f"ch{nn}_笔记本"
        d.mkdir(parents=True)
        seen: set[str] = set()
        picked = []
        for b in bl:
            if b["path"] in seen:
                continue
            seen.add(b["path"])
            picked.append(b)
            if len(picked) >= ns.top_per_ch:
                break
        names = []
        for i, b in enumerate(picked, 1):
            nm = block_file_name(f"{i:02d}", b)
            (d / nm).write_text(block_content(b, nn), encoding="utf-8")
            names.append(nm)
        total = sum((d / n).stat().st_size for n in names)
        title = next(c["title"] for c in chapters if f"{c['no']:02d}" == nn)
        manifest.append(f"\n## ch{nn}_笔记本（{len(names)} 源, {total:,}B）「{title[:24]}」")
        for n in names:
            manifest.append(f"- {n}（{(d / n).stat().st_size:,}B）")
        print(f"[pack] ch{nn}: {len(names)} 源 {total:,}B")

    # ---- 指令集 ----
    fw_prompt = (
        "你是工程建设行业战略咨询总监。基于本笔记本全部资料，为《工程计价依据与市场价基准实战研究报告》"
        "设计全书目录框架（12章左右）。读者（本书买家）：中国工程行业的造价工程师与商务经理。"
        "本书三大使用场景：①投标报价编制（招标控制价、投标报价、综合单价组价）；"
        "②结算核对（进度款支付、竣工结算核对）；③合同解除与争议（合同解除结算、造价鉴定）。"
        "要求：1)每章标题用判断句或动作句，不用名词堆砌；2)按读者认知路径排序"
        "（体系与规则全景→计价方法→三大场景实战→职业与工具生态→行动清单收尾）；"
        "3)每章注明：本章解决的读者问题、3-6个小节要点、主要使用场景（①或②或③或通用）；"
        "4)章节须覆盖笔记本证据的十大主题维度：政策法规与定额体系、计价依据与定额测定、"
        "信息价与市场价基准、投标编制实务、结算核对实务、合同解除结算、造价鉴定与争议、"
        "清单与定额计价模式、造价咨询与职业、数据源与工具生态；"
        "5)输出格式严格：先给不超过500字的全书定位说明；随后每章一块，首行格式为"
        "【第N章】章标题｜场景：X，接着一行「本章解决：…」，再以「·」开头给出3-6行小节要点。"
        "全部简体中文，不使用计算机术语。")
    (OUT / "NotebookLM指令集.md").write_text(
        "# JIAGE NotebookLM 指令集\n\n## 一、框架生成指令（00_战役总笔记本）\n\n"
        + fw_prompt + "\n\n## 二、各章初稿指令\n\n由 nblm_run_jiage.py 按 chapters_nblm.json 动态生成。\n",
        encoding="utf-8")
    (OUT / "上传清单.md").write_text("\n".join(manifest), encoding="utf-8")

    # 章↔维映射尾注 (十大维覆盖审计用)
    dim_map = {c["no"]: c["title"] for c in chapters}
    (OUT / "章维映射.json").write_text(json.dumps(
        {"note": "bank 章 → 问题树十维的近似映射 (审计覆盖用)",
         "dims": DIM_ORDER, "chapters": dim_map}, ensure_ascii=False, indent=1),
        encoding="utf-8")
    print(f"[pack] 完成: {OUT} | 00={len(fw_names)}源 | 指令集+清单已落盘")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
