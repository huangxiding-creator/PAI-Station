# -*- coding: utf-8 -*-
"""卷五 bank 构建器: 三 bank + 复用一件.

  vol5_bank_method.txt  (5-1 方法论)  = claim-chain PROPOSAL.md + reforge METHODOLOGY.md
                                        重编号 P100001+ (逐 md 段落)
  vol5_bank_wubufa.txt  (5-2 五步法)  = topic_wubufa.txt 重编号 P200001+ (段>=40字)
  vol5_bank_sample.txt  (5-6 独家样本) = topic_tieshe.txt P300001+ + topic_zjshuili.txt P400001+
  (5-3 创效30招 复用 vol1_bank_yingli.txt — 创效原稿区锚已在)

幂等: 输出存在即跳过 (--force 重跑).
"""
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
PROPOSALS = r"E:\AI-Station\_proposals"
REFACT = r"E:\AI-Station\reforge_factory"

ANCHOR_RE = re.compile(r"\[P(\d{1,6})\]")


def paragraphs(bank_path, min_len=0, cap=None):
    """topic bank (自带 [Pnnnnnn] 锚) -> [text], 可选长度过滤+上限."""
    txt = open(os.path.join(HERE, bank_path), encoding="utf-8").read()
    out, buf, cur = [], [], None
    for tok in re.split(r"(\[P\d{1,6}\])", txt):
        m = re.fullmatch(r"\[P(\d{1,6})\]", tok)
        if m:
            if cur is not None:
                out.append("".join(buf).strip())
            cur, buf = int(m.group(1)), []
        elif cur is not None:
            buf.append(tok)
    if cur is not None:
        out.append("".join(buf).strip())
    out = [t for t in out if len(t) >= min_len]
    return out[:cap] if cap else out


def md_paragraphs(md_path):
    """md -> 段落 (按空行分, 去标题符号/表格行保留)."""
    txt = open(md_path, encoding="utf-8").read()
    parts = [p.strip() for p in re.split(r"\n\s*\n", txt)]
    keep = []
    for p in parts:
        p = re.sub(r"^#{1,6}\s+", "", p, flags=re.M).strip()
        if len(p) >= 15:
            keep.append(p)
    return keep


def write_bank(name, sections, force=False):
    """sections = [(base_anchor, header, [texts])]"""
    out = os.path.join(HERE, name)
    if os.path.exists(out) and not force:
        print(f"[{name}] skip (exists)")
        return
    parts = []
    for base, header, texts in sections:
        parts.append(f"[P{base}] ◆{header} (本段=区间头, 段数={len(texts)}, "
                     f"锚 P{base + 1}..P{base + len(texts)})")
        for i, t in enumerate(texts):
            parts.append(f"[P{base + 1 + i}] {t}")
    body = "\n".join(parts) + "\n"
    open(out, "w", encoding="utf-8").write(body)
    print(f"[{name}] {sum(len(t) for _, _, t in sections)} 段 -> "
          f"{os.path.getsize(out)} bytes")


if __name__ == "__main__":
    force = "--force" in sys.argv
    # 5-1 方法论 bank
    write_bank("vol5_bank_method.txt", [
        (100000, "源=claim-chain-engine-1006/PROPOSAL.md (断言链七门)",
         md_paragraphs(os.path.join(PROPOSALS, "claim-chain-engine-1006", "PROPOSAL.md"))),
        (150000, "源=reforge_factory/METHODOLOGY.md (调研宪法 v2 七步循环+证据分级+红队)",
         md_paragraphs(os.path.join(REFACT, "METHODOLOGY.md"))),
    ], force)
    # 5-2 五步法 bank
    write_bank("vol5_bank_wubufa.txt", [
        (200000, "源=《马斯克成大事五步法实践指北》电子书 (总包创研院) 全文段",
         paragraphs("topic_wubufa.txt", min_len=40, cap=4500)),
    ], force)
    # 5-6 独家样本 bank (双源槽位)
    write_bank("vol5_bank_sample.txt", [
        (300000, "源=《中国铁设如何做EPC总承包？》(EXCL-01, 13万字独家稿)",
         paragraphs("topic_tieshe.txt", min_len=40, cap=2500)),
        (400000, "源=《浙江省水利工程商机研究报告》(EXCL-02 独家稿)",
         paragraphs("topic_zjshuili.txt", min_len=40, cap=2500)),
    ], force)
    print("DONE")
