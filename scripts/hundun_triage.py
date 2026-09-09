"""混沌学园课程分诊：按「AI 产品研发」价值密度排序（挖掘前的调度器）。

只读元数据 + 章节标题 + 文稿首部采样，本地打分零成本：
- AI 属性（tab=AI / 标题关键词）+30/+20
- 方法论关键词命中（标题/章节名）逐项 +2
- 文稿采样中方法词汇密度 +0~15
输出 data/hundun/_mining/triage.json（cid → score/reasons），并打印分布。
"""
import glob
import json
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "data", "hundun")
OUT_DIR = os.path.join(BASE, "_mining")
SAMPLE = 20000

_AI_KW = re.compile(r"AI|人工智能|大模型|智能体|AIGC|GPT|Agent|机器学习|深度学习"
                    r"|LLM|生成式|OpenAI|DeepSeek|大语言模型")
_METHOD_KW = re.compile(r"思维|心智|模型|第一性|第二曲线|创新|方法论|认知|战略|产品"
                        r"|增长|组织|领导|决策|系统|复利|破界|分形|颠覆|迭代|壁垒"
                        r"|护城河|需求|用户|场景|定位|差异化|竞争|商业模式|本质|逻辑")
_DENSITY_KW = re.compile(r"方法论|思维模型|第一性原理|第二曲线|底层逻辑|本质是"
                         r"|框架|原则|策略|路径|破局|创新|认知")


def score_course(c: dict, folder: str) -> tuple:
    title = c.get("title", "") or ""
    reasons = []
    sc = 0.0
    if folder == "AI课程":
        sc += 30
        reasons.append("AI课程目录+30")
    elif _AI_KW.search(title):
        sc += 20
        reasons.append("标题AI关键词+20")
    hits = set(_METHOD_KW.findall(title))
    if hits:
        sc += min(14, 2 * len(hits))
        reasons.append(f"标题方法论命中{'+'.join(sorted(hits)[:4])}")
    ch_titles = [ch.get("title", "") or "" for ch in c.get("chapters") or []]
    ch_hits = sum(1 for t in ch_titles if _METHOD_KW.search(t))
    if ch_hits:
        sc += min(10, ch_hits)
        reasons.append(f"章节名命中{ch_hits}")
    text = "".join((ch.get("transcript") or "")[:4000]
                   for ch in (c.get("chapters") or [])[:4])[:SAMPLE]
    dens = len(_DENSITY_KW.findall(text)) * 10 / max(len(text), 1) * 1000
    sc += min(15, dens)
    if dens >= 2:
        reasons.append(f"文稿方法词密度{dens:.1f}/千字")
    return sc, reasons


def main() -> int:
    os.makedirs(OUT_DIR, exist_ok=True)
    out = {}
    for path in glob.glob(os.path.join(BASE, "**", "*.json"), recursive=True):
        if "_recon" in path or "_mining" in path:
            continue
        folder = os.path.basename(os.path.dirname(path))
        cid = os.path.basename(path)[:-5]
        if folder in ("_recon", "skills") or len(cid) != 32:
            continue
        try:
            c = json.load(open(path, encoding="utf-8"))
        except (OSError, ValueError):
            continue
        sc, reasons = score_course(c, folder)
        out[cid] = {"score": round(sc, 1), "folder": folder,
                    "title": c.get("title", ""), "teacher": c.get("teacher", ""),
                    "reasons": reasons[:3]}
    with open(os.path.join(OUT_DIR, "triage.json"), "w", encoding="utf-8") as fh:
        json.dump(out, fh, ensure_ascii=False, indent=1)
    scores = sorted((v["score"] for v in out.values()), reverse=True)
    n = len(scores)
    print(f"[triage] {n} 门打分完成")
    for th in (50, 40, 30, 20, 10, 0):
        print(f"  score>={th}: {sum(1 for s in scores if s >= th)} 门")
    print("Top10:")
    for cid, v in sorted(out.items(), key=lambda kv: -kv[1]["score"])[:10]:
        print(f"  {v['score']:>5} {v['title'][:28]} ({v['teacher'][:8]})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
