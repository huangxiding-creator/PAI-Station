# -*- coding: utf-8 -*-
"""adversarial_review — P1-3 TradingAgents 牛熊对抗辩论轮 (终极提案 P1-3, 1028 用户已批).

思想来源: TauricResearch/TradingAgents (117,312★) 的
  analyst → bull researcher → bear researcher → judge 对抗结构, 移植到报告质检:
  ①乐观审查者: 找「这段论述有充分证据支撑」的理由 (列证据锚 P\\d{6});
  ②悲观审查者: 找「这个结论可能站不住脚」的反证 (bank 矛盾证据/逻辑跳跃/数据过时);
  ③独立裁决官: 维持原文 / 需修正 / 需补充 (无证据论点判无效)。

引擎: mission-engine/forge/glm_json.py 双钥客户端 (GLM-4-flash 免费档,
双密钥轮换, 智谱双账号强制令; 每角色独立调用, 串行 ≤4 并发天然合规)。
证据面: 章节终稿 + 对应 bank 的所引锚点节 (复用 claim_verifier.parse_bank)。

用法:
  py reforge_factory/adversarial_review.py --chapter <chNN.md> \
      --bank <bank_chNN.md> [--sections 3] [--max-section-chars 6000]
产物: <chapter>.adversarial.md / .json + adversarial_review_log.jsonl (只增)。
铁律: 免费宪法 / 数字零造假 (LLM 输出如实落账) / 密钥不进仓不进日志。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.path.insert(0, str(Path(__file__).resolve().parents[1]
                       / "mission-engine" / "forge"))
from glm_json import GlmJson                     # noqa: E402 (双钥客户端)
import claim_verifier as cv                      # noqa: E402 (bank 解析复用)

LOG = Path(__file__).resolve().parent / "adversarial_review_log.jsonl"

BULL_SYS = (
    "你是报告质检中的乐观审查者(bull researcher)。你的任务: 阅读研究报告的一个小节"
    "及其证据包, 找出『这段论述有充分证据支撑』的理由。每条论点必须挂证据锚"
    "(证据包中的 P 六位编号); 无证据锚的论点会被判无效。只输出 JSON: "
    '{"arguments": [{"point": "论点(30字内)", "anchor": "Pxxxxxx", '
    '"quote": "证据包中支撑原文(50字内)"}]}, 至少3条, 不超过5条。}')

BEAR_SYS = (
    "你是报告质检中的悲观审查者(bear researcher)。你的任务: 阅读研究报告的一个小节"
    "及其证据包, 找出『这个结论可能站不住脚』的反证。检查四类问题: 证据矛盾"
    "(证据包中有相反信号) / 逻辑跳跃(结论超出证据) / 数据过时(引用口径陈旧) / "
    "证据缺失(关键断言无锚)。只输出 JSON: "
    '{"counter_arguments": [{"point": "反证论点(30字内)", "type": '
    '"证据矛盾|逻辑跳跃|数据过时|证据缺失", "detail": "依据(60字内)", '
    '"anchor": "Pxxxxxx或空"}]}, 至少3条, 不超过5条。}')

JUDGE_SYS = (
    "你是独立裁决官(judge)。你收到报告小节原文、乐观方论点、悲观方反证。"
    "规则: 无证据锚的论点一律无效; 悲观方命中『证据缺失/矛盾』且属实才可判需修正。"
    '只输出 JSON: {"verdict": "维持原文|需修正|需补充", '
    '"reasons": ["理由(40字内)", ...], "must_fix": ["若判需修正/需补充, '
    '列出必改项(40字内)", ...]}。')


def split_sections(chapter_md: str) -> list[dict]:
    """按 ## 标题切节 (节含标题行)。"""
    secs, cur = [], None
    for ln in chapter_md.splitlines():
        if re.match(r"^##\s+", ln):
            if cur:
                secs.append(cur)
            cur = {"title": ln.strip("# ").strip(), "lines": [ln]}
        elif cur is not None:
            cur["lines"].append(ln)
        elif re.match(r"^#\s+", ln):
            cur = {"title": ln.strip("# ").strip(), "lines": []}
    if cur and (cur["lines"] or cur["title"]):
        secs.append(cur)
    return [{"title": s["title"], "text": "\n".join(s["lines"]).strip()}
            for s in secs if len("\n".join(s["lines"]).strip()) >= 200]


def evidence_pack(section_text: str, bank: dict[str, dict],
                  cap: int = 9000) -> str:
    """节内所引锚点 → bank 节文本打包 (每节头两行+正文, 总量封顶)。"""
    anchors = list(dict.fromkeys(cv.ANCHOR_RE.findall(section_text)))
    parts, used = [], 0
    for a in anchors:
        s = bank.get(a)
        if not s or s["empty"] or not s["text"]:
            continue
        seg = "## P%s %s\n%s" % (a, s["title"], s["text"][:1500])
        if used + len(seg) > cap:
            seg = seg[: max(0, cap - used)]
        parts.append(seg)
        used += len(seg)
        if used >= cap:
            break
    return "\n\n".join(parts) or "(证据包为空: 所引锚点在 bank 无可用正文)"


def review_section(llm: GlmJson, sec: dict, bank: dict[str, dict],
                   max_chars: int) -> dict:
    text = sec["text"][:max_chars] + (
        "\n(节超长截断, 如实)" if len(sec["text"]) > max_chars else "")
    ev = evidence_pack(sec["text"], bank)
    user = "## 报告小节原文\n%s\n\n## 证据包 (bank 锚点节)\n%s" % (text, ev)
    bull = llm.chat_json(BULL_SYS, user, temperature=0.3)
    bear = llm.chat_json(BEAR_SYS, user, temperature=0.3)
    ju = llm.chat_json(JUDGE_SYS, "## 报告小节原文\n%s\n\n## 乐观方论点\n%s\n\n"
                       "## 悲观方反证\n%s" % (text,
                            json.dumps(bull, ensure_ascii=False),
                            json.dumps(bear, ensure_ascii=False)))
    return {"section": sec["title"], "chars": len(sec["text"]),
            "bull": bull, "bear": bear, "judge": ju}


def main() -> int:
    ap = argparse.ArgumentParser(description="牛熊对抗辩论轮 (P1-3)")
    ap.add_argument("--chapter", required=True)
    ap.add_argument("--bank", required=True)
    ap.add_argument("--sections", type=int, default=3,
                    help="审多少节 (从前往后, 0=全)")
    ap.add_argument("--max-section-chars", type=int, default=6000)
    ap.add_argument("--campaign", default="", help="落账战役名 (仅台账用)")
    ns = ap.parse_args()
    chapter, bank_p = Path(ns.chapter), Path(ns.bank)
    chap = chapter.read_text(encoding="utf-8", errors="replace")
    bank = cv.parse_bank(bank_p)
    secs = split_sections(chap)
    if ns.sections:
        secs = secs[:ns.sections]
    if not secs:
        print("[adv] 无 ≥200 字的节可审", file=sys.stderr)
        return 2
    llm = GlmJson()                              # glm-4-flash 免费档双钥
    t0 = time.time()
    results = []
    for i, sec in enumerate(secs, 1):
        print("[adv] 节 %d/%d: %s (%d字) …" % (i, len(secs), sec["title"][:40],
                                               len(sec["text"])))
        try:
            results.append(review_section(llm, sec, bank, ns.max_section_chars))
        except Exception as e:
            results.append({"section": sec["title"], "error":
                            "%s: %s" % (type(e).__name__, e)})
    tally = {}
    for r in results:
        v = (r.get("judge") or {}).get("verdict", "ERROR")
        tally[v] = tally.get(v, 0) + 1
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M"), "campaign": ns.campaign,
           "chapter": str(chapter), "bank": str(ns.bank),
           "sections": len(results), "llm_calls": llm.calls,
           "elapsed_sec": round(time.time() - t0, 1), "verdict_tally": tally,
           "results": results}
    out_md = Path(str(chapter)[:-3] + ".adversarial.md")
    out_json = Path(str(chapter)[:-3] + ".adversarial.json")
    md = ["# 牛熊对抗辩论报告 | %s" % chapter.name, "",
          "- 节 %d | LLM 调用 %d | 耗时 %.0fs | 裁决分布 %s"
          % (len(results), llm.calls, time.time() - t0,
             json.dumps(tally, ensure_ascii=False)), ""]
    for r in results:
        md.append("## %s" % r["section"])
        if "error" in r:
            md += ["", "> 失败: %s" % r["error"], ""]
            continue
        md.append("")
        md.append("**乐观方论点:**")
        for a in (r.get("bull") or {}).get("arguments") or []:
            md.append("- %s `[锚:%s]`" % (a.get("point", ""),
                                          a.get("anchor", "")))
        md.append("")
        md.append("**悲观方反证:**")
        for a in (r.get("bear") or {}).get("counter_arguments") or []:
            md.append("- [%s] %s — %s `%s`" % (a.get("type", ""), a.get("point", ""),
                                               a.get("detail", ""),
                                               a.get("anchor", "")))
        j = r.get("judge") or {}
        md.append("")
        md.append("**裁决: %s** — %s" % (j.get("verdict", "?"),
                                         "; ".join(j.get("reasons") or [])))
        for f in j.get("must_fix") or []:
            md.append("- 必改: %s" % f)
        md.append("")
    out_md.write_text("\n".join(md), encoding="utf-8")
    out_json.write_text(json.dumps(rec, ensure_ascii=False, indent=1),
                        encoding="utf-8")
    with LOG.open("a", encoding="utf-8") as fh:   # 台账只增不删
        fh.write(json.dumps({k: v for k, v in rec.items() if k != "results"},
                            ensure_ascii=False) + "\n")
    print("[adv] 完成: 裁决 %s | 报告 %s" % (
        json.dumps(tally, ensure_ascii=False), out_md))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
