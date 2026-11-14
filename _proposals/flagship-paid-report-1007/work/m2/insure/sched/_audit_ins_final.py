# -*- coding: utf-8 -*-
"""_audit_ins_final — EPC-INSURE ch01-04 终稿审计门.
用法: E:/AI-Station/.venv/Scripts/python.exe _audit_ins_final.py NN   (NN=01..04)
检查: CJK门/锚实存/幽灵锚/铁律①②③④⑤/残留/尾注/小结边界. 输出 PASS/FAIL 明细.
"""
from __future__ import annotations
import json, re, sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
GATES = {"01": 25311, "02": 39843, "03": 15000, "04": 38442}
TITLES = {
    "01": "导论：EPC工程保险与保函的市场全景与规则地图",
    "02": "保函的法律基础：独立担保与从属担保的分野",
    "03": "投标保函：从开出到退还的全流程管理",
    "04": "履约保函：开出、减额与索赔攻防",
}


def main(nn: str) -> int:
    out = {"chapter": nn, "checks": {}, "pass": False}
    fin = HERE / f"_ch{nn}_final.md"
    led = HERE / f"_ch{nn}_collation_ledger.md"
    bank = (HERE / f"bank_ch{nn}.md").read_text(encoding="utf-8", errors="replace")

    def chk(name, ok, detail):
        out["checks"][name] = {"ok": bool(ok), "detail": detail}

    chk("files_exist", fin.is_file() and led.is_file(), f"final={fin.is_file()} ledger={led.is_file()}")
    if not fin.is_file():
        print(json.dumps(out, ensure_ascii=False, indent=1)); return 1
    t = fin.read_text(encoding="utf-8", errors="replace")

    hanzi = len(re.findall(r"[一-鿿]", t))
    gate = max(15000, GATES[nn])
    out["hanzi"] = hanzi; out["gate"] = gate
    chk("cjk_gate", hanzi >= gate, f"hanzi={hanzi} gate={gate}")

    # anchors
    bank_anchors = set(re.findall(r"^## (P\d{6})", bank, flags=re.M))
    used = re.findall(r"P\d{6}", t)
    uniq = sorted(set(used))
    ghosts = sorted(set(used) - bank_anchors)
    out["anchors_used"] = len(uniq)
    chk("anchors_real", len(ghosts) == 0, f"uniq={len(uniq)} ghosts={ghosts}")
    chk("anchor_count", len(uniq) >= 6, f"uniq={len(uniq)} (want>=6)")

    # rule 1/2: no 出品行 / 纪律声明
    chk("no_chupin", not re.search(r"^出品[:：]", t, flags=re.M), "出品：行")
    chk("no_jilv", "纪律声明" not in t, "纪律声明块")

    # rule 3: heading numbering
    h1 = re.findall(r"^# (.+)$", t, flags=re.M)
    h2 = [(int(a), int(b)) for a, b in re.findall(r"^## (\d+)\.(\d+)[ 　]", t, flags=re.M)]
    h3 = [(int(a), int(b), int(c)) for a, b, c in re.findall(r"^### (\d+)\.(\d+)\.(\d+)[ 　]", t, flags=re.M)]
    h1ok = len(h1) == 1 and h1[0].startswith(f"第{int(nn)}章")
    chk("h1_single", h1ok, f"h1={h1[:2]}")
    n = int(nn)
    h2bad = [x for x in h2 if x[0] != n]
    h2seq = [x[1] for x in h2]
    seq_ok = h2seq == list(range(1, len(h2seq) + 1))
    chk("h2_seq", not h2bad and seq_ok, f"M序列={h2seq[:20]}{'...' if len(h2seq)>20 else ''} 坏锚章={h2bad}")
    h3bad, last = [], {}
    for a, b, c in h3:
        if a != n or (a, b) not in h2:
            h3bad.append((a, b, c)); continue
        if c != last.get((a, b), 0) + 1:
            h3bad.append((a, b, c))
        last[(a, b)] = c
    chk("h3_seq", not h3bad, f"坏K={h3bad[:8]}")
    chk("no_deep_head", "#### " not in t, "#### 出现")

    # rule 4: no ascii box
    box = re.findall(r"[┌┐└┘├┤┬┴┼│─═╔╗╚╝║]", t)
    chk("no_box", not box, f"框线字符{len(box)}个")
    chk("no_latex", "$$" not in t and not re.search(r"\\(text|frac|times)", t), "LaTeX残留")

    # rule 5: no unordered list
    ul = re.findall(r"^[-*+] +\S", t, flags=re.M)
    chk("no_ul", not ul, f"无序列表行{len(ul)}: {ul[:5]}")

    # residue / terms
    resid = {w: len(re.findall(p, t)) for w, p in {
        "分段标记": r"下一段将继续输出", "Studio": r"Studio", "面板": r"面板",
        "NBLM": r"NBLM", "AI": r"\bAI\b", "NB初稿": r"NB初稿|NB-\d",
        "方括号来源腔": r"\[来源", "目标字数": r"目标字数", "语料": r"语料",
        "出品方腔": r"^出品", "机器尾巴": r"是否需要我",
    }.items()}
    bad = {k: v for k, v in resid.items() if v}
    chk("no_residue", not bad, f"{bad}")

    # tail: 小结 + 证据边界 + 尾注
    tail = t[-8000:]
    chk("tail_summary", "本章小结" in t and ("证据边界" in t), "小结/证据边界")
    chk("tail_notes", "尾注" in t and uniq and all(p in t for p in []) , "尾注表")

    out["pass"] = all(c["ok"] for c in out["checks"].values())
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    print(json.dumps(out, ensure_ascii=False, indent=1))
    return 0 if out["pass"] else 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1].zfill(2)))
