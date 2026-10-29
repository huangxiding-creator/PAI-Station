# -*- coding: utf-8 -*-
"""claim_verifier — P1-2 FacTool 式 claim 级核查链 (终极提案 P1-2, 1028 用户已批).

思想来源: GAIR-NLP/Factool (Apache-2.0, 935★) — 把报告事实句拆成原子 claim,
逐条核验是否有源支撑; 本件把现役 m2_gate2 的「锚点数字门」从数字粒度升维到
**句级事实可溯**: 每个含数字/专名的事实句 → PASS / FAIL / UNVERIFIED + 证据指针。

对接资产 (只读复用, 不改产线):
  - m2_gate2.py 的 norm 归一 (去逗号/全角逗号/空格) 与数字正则思路;
  - 章节终稿 work/m2/<战役>/chNN.md (锚点 P\d{6} 体例);
  - 对应 bank: work/m2/<战役>/bank_chNN.md (## P\d{6} 节体例)。

判定口径 (如实, 零造假):
  PASS        句内全部数字/专名 claim 在所引锚点 bank 节 norm 命中;
  PASS(bank)  锚点节未命中但在 bank 全文命中 (弱证据, 单列);
  FAIL        ≥1 claim 在 bank 全文也找不到 (需回写修订项);
  UNVERIFIED  无锚点 / 锚点在 bank 无节 / bank 节为空源 (抓取失败件);
  OWN_CALC    句内 own_calc 标注 (作者推算, 免核, 单列计数)。

用法:
  py reforge_factory/claim_verifier.py --chapter <ch01.md> --bank <bank_ch01.md>
      [--out <报告md>] [--json <报告json>] [--max-rows 0]
产物: 默认 <chapter>.claim_verdict.md + .json (与章节同目录)。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

#: 锚点体例: 书链 6 位 (P012345, m2_gate2) / 章节bank 4 位 (P1027, transform 实测) — 双口径兼容
ANCHOR_RE = re.compile(r"P(\d{4,6})")
OWN_CALC_RE = re.compile(r"own_calc")
#: 数字 claim: 带单位数值 (gate2 口径扩展) + 独立年份数
NUM_RE = re.compile(
    r"\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|千|％|%|个百分点|元|倍|家|项|人|个|吨|片|公里|"
    r"米|台|次|轮|期|分|秒|年|月|日|GW|MW|kV|kW))|(?<![\d.])(?:19|20)\d{2}(?![\d.])",
    re.IGNORECASE)
#: 专名 claim: 书名号内容 / 带后缀的组织名 / 引号短语
PROPER_RE = re.compile(
    r"《[^》]{2,40}》|[一-龥A-Za-z]{2,14}(?:公司|集团|设计院|勘测设计研究院|"
    r"工程局|研究院|协会|联合会|杂志|大学|学院|部委|商务部|建设部|发改委|能源局|"
    r"住建部|计委)")
HEADING_RE = re.compile(r"^#{1,6}\s")
META_RE = re.compile(r"^(?:>|\*|-{3,}|\|[\s:|-]+\|?\s*$)")


def norm(x: str) -> str:
    """gate2 同款归一: 去半/全角逗号与空格 (子串匹配前统一口径)。"""
    return x.replace(",", "").replace("，", "").replace(" ", "")


def parse_bank(bank_path: Path) -> dict[str, dict]:
    """bank_chNN.md → {P号: {title, text, empty}} (## P\\d{6} 节体例)。"""
    lines = bank_path.read_text(encoding="utf-8", errors="replace").splitlines()
    secs: dict[str, dict] = {}
    cur = None
    for ln in lines:
        m = re.match(r"^##\s+P(\d{4,6})\s*(.*)", ln)
        if m:
            cur = m.group(1)
            secs[cur] = {"title": m.group(2).strip(), "body": []}
            continue
        if cur is not None:
            # P 节内的嵌套标题 (## 11.1 / ### …) 归属该源内容, 不截断
            secs[cur]["body"].append(ln)
    for s in secs.values():
        s["text"] = "\n".join(s["body"]).strip()
        s["empty"] = bool(re.search(r"全文抓取失败|为空|重试仍空", s["text"]))
        s["norm"] = norm(s["text"])
    return secs


def split_sentences(chapter_md: str) -> list[str]:
    """章节 → 候选句 (。；！？换行 + 表格竖线切分; 跳标题/元信息行)。"""
    out: list[str] = []
    for raw in chapter_md.splitlines():
        if HEADING_RE.match(raw) or META_RE.match(raw) or not raw.strip():
            continue
        for cell in raw.split("|"):          # 表格行 → 单元格级
            for s in re.split(r"[。；！？;]", cell):
                s = s.strip(" \t*-—–")
                if len(s) >= 8:              # 过短碎片不构成 claim 句
                    out.append(s)
    return out


def verify_sentence(sent: str, bank: dict[str, dict],
                    bank_full_norm: str) -> dict:
    """单句 → {verdict, claims, evidence, detail}。"""
    anchors = list(dict.fromkeys(ANCHOR_RE.findall(sent)))
    clean = ANCHOR_RE.sub("", sent)
    nums = sorted(set(NUM_RE.findall(clean)))
    props = sorted(set(
        re.sub(r"^[按由但对和及在对了是而从自向于受经据依被让给跟同如若则即均皆也就才更"
               r"已将并且或使把该这那其又再随沿靠着之]", "", p)
        for p in PROPER_RE.findall(clean)))
    props = sorted(set(p for p in props if len(p) >= 4))
    is_own = bool(OWN_CALC_RE.search(sent))
    if not nums and not props:
        return {"verdict": "SKIP", "claims": 0, "evidence": "-",
                "detail": "无数字/专名 (非事实句)"}
    if is_own:
        return {"verdict": "OWN_CALC", "claims": len(nums) + len(props),
                "evidence": "-", "detail": "own_calc 作者推算, 免核"}
    if not anchors:
        return {"verdict": "UNVERIFIED", "claims": len(nums) + len(props),
                "evidence": "-", "detail": "含数字/专名但无锚点引用"}
    texts, missing_anchor, empty_anchor = [], [], []
    for a in anchors:
        s = bank.get(a)
        if s is None:
            missing_anchor.append(a)
        elif s["empty"] or not s["text"]:
            empty_anchor.append(a)
        else:
            texts.append(s["norm"])
    if not texts:
        why = ("锚点在bank无节: %s" % missing_anchor if missing_anchor
               else "锚点bank节为空源(抓取失败): %s" % empty_anchor)
        return {"verdict": "UNVERIFIED", "claims": len(nums) + len(props),
                "evidence": ",".join("P" + a for a in anchors), "detail": why}
    claims, fails, bank_hits = [], [], []
    for n in nums:
        nn = norm(n)
        hit = None
        for a in anchors:                    # 先锚点节
            s = bank.get(a)
            if s and not s["empty"] and nn in s["norm"]:
                hit = "P" + a
                break
        if hit is None and nn in bank_full_norm:   # bank 全文兜底
            hit = "bank全文"
            bank_hits.append(n)
        if hit is None:
            fails.append(n)
        claims.append({"claim": n, "kind": "number", "evidence": hit or "-"})
    for p in props:
        pn = norm(p)
        hit = next(("P" + a for a in anchors
                    if bank.get(a) and not bank[a]["empty"]
                    and pn in bank[a]["norm"]), None)
        if hit is None and pn in bank_full_norm:
            hit = "bank全文"
            bank_hits.append(p)
        if hit is None:
            fails.append(p)
        claims.append({"claim": p, "kind": "proper", "evidence": hit or "-"})
    verdict = "FAIL" if fails else ("PASS(bank)" if bank_hits else "PASS")
    return {"verdict": verdict, "claims": len(claims),
            "evidence": ",".join("P" + a for a in anchors),
            "detail": ("缺证: %s" % "; ".join(fails[:5])) if fails else
                      ("锚点全命中" if not bank_hits else
                       "锚点节未中/bank全文兜底: %s" % "; ".join(bank_hits[:5])),
            "claim_rows": claims}


def run(chapter: Path, bank: Path, out_md: Path, out_json: Path,
        max_rows: int) -> int:
    chap_text = chapter.read_text(encoding="utf-8", errors="replace")
    bank_secs = parse_bank(bank)
    bank_full_norm = norm("\n".join(s["text"] for s in bank_secs.values()))
    sents = split_sentences(chap_text)
    rows = []
    for i, s in enumerate(sents, 1):
        r = verify_sentence(s, bank_secs, bank_full_norm)
        if r["verdict"] != "SKIP":
            rows.append({"n": len(rows) + 1, "sentence": s[:160], **r})
    tally: dict[str, int] = {}
    for r in rows:
        tally[r["verdict"]] = tally.get(r["verdict"], 0) + 1
    factual = [r for r in rows if r["verdict"] not in ("OWN_CALC",)]
    pass_like = tally.get("PASS", 0) + tally.get("PASS(bank)", 0)
    summary = {
        "chapter": str(chapter), "bank": str(bank),
        "ts": time.strftime("%Y-%m-%d %H:%M"),
        "bank_sections": len(bank_secs),
        "bank_empty_sections": sum(1 for s in bank_secs.values() if s["empty"]),
        "sentences_total": len(sents), "claim_sentences": len(rows),
        "tally": tally,
        "pass_rate": round(pass_like / len(factual) * 100, 1) if factual else 0.0,
    }
    shown = rows if not max_rows else rows[:max_rows]
    md = ["# claim 级核查表 | %s" % chapter.name, "",
          "- 银行: %s (P节 %d, 空源 %d)" % (bank.name, len(bank_secs),
              summary["bank_empty_sections"]),
          "- 候选句 %d | 事实句 %d | %s | 通过率 %s%% (PASS/事实句, 含bank兜底)"
          % (len(sents), len(rows), json.dumps(tally, ensure_ascii=False),
             summary["pass_rate"]),
          "", "| # | 判定 | 证据 | 句 (截160) | 明细 |", "|---|---|---|---|---|"]
    for r in shown:
        md.append("| %d | **%s** | %s | %s | %s |"
                  % (r["n"], r["verdict"], r["evidence"],
                     r["sentence"].replace("|", "\\|"),
                     r["detail"].replace("|", "\\|")[:120]))
    md += ["", "> 判定口径: PASS=锚点节全命中 / PASS(bank)=bank全文兜底 / "
           "FAIL=bank全文无据(回写修订) / UNVERIFIED=无锚或空源 / "
           "OWN_CALC=作者推算免核。数字零造假, 全部为实测命中。"]
    out_md.write_text("\n".join(md), encoding="utf-8")
    out_json.write_text(json.dumps(
        {"summary": summary, "rows": rows}, ensure_ascii=False, indent=1),
        encoding="utf-8")
    print("[claim_verifier] %s" % json.dumps(summary, ensure_ascii=False))
    print("  报告: %s" % out_md)
    return 0 if tally.get("FAIL", 0) == 0 else 1


def main() -> int:
    ap = argparse.ArgumentParser(description="claim 级核查链 (P1-2, gate2 升维)")
    ap.add_argument("--chapter", required=True, help="章节终稿 md")
    ap.add_argument("--bank", required=True, help="对应 bank_chNN.md")
    ap.add_argument("--out", default="", help="报告 md (默认 <chapter>.claim_verdict.md)")
    ap.add_argument("--json", default="", help="报告 json")
    ap.add_argument("--max-rows", type=int, default=0, help="表内最多行 (0=全)")
    ns = ap.parse_args()
    chapter, bank = Path(ns.chapter), Path(ns.bank)
    if not chapter.is_file() or not bank.is_file():
        print("章节或 bank 不存在", file=sys.stderr)
        return 2
    out_md = Path(ns.out) if ns.out else chapter.with_suffix(
        "").as_posix() + ".claim_verdict.md"
    out_json = Path(ns.json) if ns.json else str(out_md)[:-3] + ".json"
    return run(chapter, bank, Path(out_md), Path(out_json), ns.max_rows)


if __name__ == "__main__":
    raise SystemExit(main())
