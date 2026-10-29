# -*- coding: utf-8 -*-
"""storm_perspectives — P2-3 STORM 多视角问题框架 (终极提案 P2-3, 1028 已批).

思想来源: stanford-oval/storm (31,720★, MIT/ Apache 族开源) — 写维基级长文前,
让多个不同 persona (学者/记者/从业者/批评者) 各自提问, 汇聚成多视角大纲,
防单一视角盲区. 本件移植到研报框架生成前置位 (NBLM 产线框架 Phase 0):
课题关键词 → 4 persona × 各 5-8 问 (GLM-4-flash 免费档, 双钥, 串行) →
归一去重 (标点折叠 + difflib 近似合并) → 多视角问题框架 md + 可前置的
prompt 块 (--emit-prompt).

NBLM 接入 (sched_nblm_run.py 已打同款钩, 1028 P2-3): 框架笔记本目录下存在
00_多视角问题框架.md 时, framework_prompt() 自动前置该块 (文件缺席=零行为
变化, 保守接入)。

用法:
  py reforge_factory/storm_perspectives.py --topic "央企设计院转型" \
      [--out <md>] [--emit-prompt] [--campaign X]
产物: 默认 reforge_factory/completeness/storm_<hash>.md (+.json 同名) +
storm_perspectives_log.jsonl (只增)。
铁律: 免费宪法 / 数字零造假 (LLM 输出原样落账) / 密钥不进仓不进日志 / 串行调用。
"""
from __future__ import annotations

import argparse
import difflib
import hashlib
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1]
                       / "mission-engine" / "forge"))

LOG = Path(__file__).resolve().parent / "storm_perspectives_log.jsonl"
OUTDIR = Path(__file__).resolve().parent / "completeness"

#: STORM 式 persona 阵容 (问题侧重各异, 防单一视角盲区)
PERSONAS = (
    ("学者", "行业研究学者", "机理与结构: 演进脉络/因果机制/量化证据/理论框架"),
    ("记者", "调查记者", "事实与冲突: 谁在做什么/数据从哪来/争议在哪/反例何在"),
    ("从业者", "一线从业者(投标/商务总监)", "实操与坑: 怎么落地/成本账/踩过什么坑/工具与清单"),
    ("批评者", "唱反调的批评者", "证伪与盲区: 什么情况下结论不成立/幸存者偏差/过时风险"),
)

PROMPT_TMPL = (
    "你是%s。研究课题: 《%s》。请以你的视角提出 5-8 个最值得在研究报告里"
    "回答的问题 (侧重: %s)。要求: 每问一句一问、具体到可检索可验证、"
    "避免泛泛的「现状与对策」式空问。"
    '只输出 JSON: {"questions": ["问题1", "问题2", ...]}。')


def norm_q(q: str) -> str:
    """归一: 去空白与标点, 小写 — 去重比较键。"""
    return re.sub(r"[\s，。？！；：、\"'“”‘’()（）\[\]【】,\.?!;:'\"]+",
                  "", str(q)).lower()


def dedupe(persona_qs: dict[str, list]) -> tuple[list, list]:
    """跨 persona 去重: 完全同键合并 + difflib 相似比 ≥0.82 归并。"""
    pool: list[dict] = []          # {q, personas:[], key}
    merged_log = []
    for pname, qs in persona_qs.items():
        for q in qs:
            k = norm_q(q)
            hit = None
            for p in pool:
                if k == p["key"] or difflib.SequenceMatcher(
                        None, k, p["key"]).ratio() >= 0.82:
                    hit = p
                    break
            if hit:
                hit["personas"].append(pname)
                merged_log.append({"kept": hit["q"], "dup": q,
                                   "ratio": round(difflib.SequenceMatcher(
                                       None, k, hit["key"]).ratio(), 2)})
            else:
                pool.append({"q": str(q).strip(), "personas": [pname], "key": k})
    return pool, merged_log


def run(topic: str, out: Path | None, emit_prompt: bool,
        campaign: str) -> int:
    from glm_json import GlmJson                   # 双钥免费档
    llm = GlmJson()
    persona_qs: dict[str, list] = {}
    t0 = time.time()
    for pname, prole, focus in PERSONAS:
        try:
            r = llm.chat_json(PROMPT_TMPL % (prole, topic, focus),
                              "课题: %s" % topic, temperature=0.4)
            qs = [str(x).strip() for x in (r.get("questions") or [])
                  if str(x).strip()]
        except Exception as e:                     # noqa: BLE001 — 如实计败
            print("[storm] persona %s 失败 (如实): %s" % (pname, e),
                  file=sys.stderr)
            qs = []
        persona_qs[pname] = qs
        print("[storm] %s(%s): %d 问" % (pname, prole, len(qs)))
    pool, merged = dedupe(persona_qs)
    n_raw = sum(len(v) for v in persona_qs.values())
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M"), "campaign": campaign,
           "topic": topic, "personas": {k: v for k, v in persona_qs.items()},
           "raw_questions": n_raw, "unique_questions": len(pool),
           "merged_away": len(merged), "llm_calls": llm.calls,
           "elapsed_sec": round(time.time() - t0, 1)}
    out = out or (OUTDIR / ("storm_%s.md" % hashlib.md5(
        topic.encode("utf-8")).hexdigest()[:8]))
    out.parent.mkdir(parents=True, exist_ok=True)
    md = ["# STORM 多视角问题框架 | %s" % topic, "",
          "- persona %d 面 × 5-8 问 | 原始 %d 问 → 去重 %d 问 (合并 %d, "
          "相似阈 0.82) | GLM 调用 %d | 耗时 %.0fs"
          % (len(persona_qs), n_raw, len(pool), len(merged), llm.calls,
             time.time() - t0), ""]
    for pname, _, focus in PERSONAS:
        md.append("## %s (%s)" % (pname, focus))
        for q in persona_qs.get(pname, []):
            md.append("- %s" % q)
        md.append("")
    md.append("## 汇聚问题池 (去重后, 括号=提问 persona)")
    for i, p in enumerate(pool, 1):
        md.append("%d. %s (%s)" % (i, p["q"], "+".join(
            dict.fromkeys(p["personas"]))))
    md += ["", "## 框架前置块 (NBLM 框架 Phase 0 用, 原样可贴)", "", "```"]
    md.append(storm_block(topic, pool))
    md += ["```", "", "> 思想来源: stanford-oval/storm (31,720★) persona "
           "多视角提问; 去重为确定性算法 (归一键 + difflib≥0.82), 数字零造假。"]
    out.write_text("\n".join(md), encoding="utf-8")
    Path(str(out)[:-3] + ".json").write_text(
        json.dumps({**rec, "pool": pool, "merged": merged},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    with LOG.open("a", encoding="utf-8") as fh:    # 台账只增
        fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
    print("[storm] 汇聚 %d 问 (原始 %d, 合并 %d) → %s"
          % (len(pool), n_raw, len(merged), out))
    if emit_prompt:
        print("\n%s" % storm_block(topic, pool))
    return 0 if pool else 3


def storm_block(topic: str, pool: list) -> str:
    """NBLM 框架 prompt 前置块 (sched_nblm_run.framework_prompt 同款拼接)."""
    lines = ["[多视角问题框架前置 (STORM 式, 课题《%s》)]" % topic,
             "在生成框架前, 先吸收四个视角(学者/记者/从业者/批评者)汇聚的"
             "以下问题; 框架的小节设计必须显式覆盖其中高优先问题:"]
    for i, p in enumerate(pool, 1):
        lines.append("%d. %s" % (i, p["q"] if isinstance(p, dict) else p))
    return "\n".join(lines)


def main() -> int:
    ap = argparse.ArgumentParser(description="STORM 多视角问题框架 (P2-3)")
    ap.add_argument("--topic", required=True, help="课题关键词")
    ap.add_argument("--out", default="", help="输出 md (默认 completeness/storm_<hash>.md)")
    ap.add_argument("--emit-prompt", action="store_true",
                    help="额外把前置块打印到 stdout")
    ap.add_argument("--campaign", default="")
    ns = ap.parse_args()
    return run(ns.topic, Path(ns.out) if ns.out else None,
               ns.emit_prompt, ns.campaign)


if __name__ == "__main__":
    raise SystemExit(main())
