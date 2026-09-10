"""M7.1 重构引擎实跑验收：混沌语料 → 真实 GLM → 三层目录 + 1 节内容。

金标准：三层标注齐（章/节 framework）、九件套 ≥2、密度分 ≥60。
用法: python scripts/foundry_pilot_section.py
产物: data/foundry/_m71_pilot/（toc.json + section.md + verdict.json）
"""
import glob
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config
from paistation.foundry.density import density_score
from paistation.foundry.reconstructor import Reconstructor
from paistation.llm.zhipu_client import ZhipuClient

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUT = os.path.join(ROOT, "data", "foundry", "_m71_pilot")

# 语料：任鑫两门最落地课程（JTBD 视角，贴合 FDE 方案场景）
WANT_TITLES = ("100% 可以落地的AI产品", "从用户任务出发：如何把AI加入原有产品")


def build_corpus() -> str:
    lines = []
    for path in sorted(glob.glob(os.path.join(ROOT, "data", "hundun", "_mining", "*.json"))):
        course = json.load(open(path, encoding="utf-8"))
        if not isinstance(course, dict) or not course.get("title"):
            continue
        if not any(w in course["title"] for w in WANT_TITLES):
            continue
        lines.append(f"# 课程：《{course['title']}》 讲师：{course.get('teacher', '')}")
        for item in course.get("items", []):
            lines.append(f"- {item.get('name', '')}：{item.get('core', '')}"
                         f"｜AI应用：{item.get('ai_application', '')}")
    corpus = "\n".join(lines)
    if not corpus:
        raise SystemExit("未找到目标课程语料，检查 data/hundun/_mining/")
    return corpus


def main():
    cfg = config.load(os.path.join(ROOT, "config", "pai.ini"))
    key = config.resolve_api_key(cfg)
    client = ZhipuClient(
        key, [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]],
        vision_model=cfg["llm"]["vision_model"])
    engine = Reconstructor(client.deep)
    os.makedirs(OUT, exist_ok=True)

    corpus = build_corpus()
    print(f"[corpus] {len(corpus)} 字", flush=True)

    theme = "传统企业 AI 转型实施方案"
    print(f"[toc] 生成三级目录（真实 GLM）...", flush=True)
    toc = engine.reconstruct_toc(theme, corpus=corpus, n_chapters=6)
    json.dump(toc, open(os.path.join(OUT, "toc.json"), "w", encoding="utf-8"),
              ensure_ascii=False, indent=2)
    n_sections = sum(len(c["sections"]) for c in toc["chapters"])
    print(f"[toc] {toc['title']}：{len(toc['chapters'])} 章 {n_sections} 节", flush=True)
    for ch in toc["chapters"]:
        print(f"  - {ch['title']}（{ch['framework']}）"
              f" {len(ch['sections'])} 节", flush=True)

    chapter = toc["chapters"][0]
    section_title = chapter["sections"][0]["title"]
    print(f"[section] 生成 {section_title}（真实 GLM）...", flush=True)
    out = engine.reconstruct_section(chapter, section_title, corpus=corpus)
    with open(os.path.join(OUT, "section.md"), "w", encoding="utf-8") as f:
        f.write(f"# {section_title}\n\n框架：{out['framework']}"
                f"｜组件：{', '.join(out['components'])}\n\n{out['content']}\n")

    doc = {"title": toc["title"],
           "chapters": [{**chapter, "sections": [{k: v for k, v in out.items()
                                                  if k in ("title", "framework",
                                                           "components", "content")}]}]}
    verdict = density_score(doc)
    verdict["degraded"] = out["degraded"]
    verdict["degrade_note"] = out["degrade_note"]
    json.dump(verdict, open(os.path.join(OUT, "verdict.json"), "w", encoding="utf-8"),
              ensure_ascii=False, indent=2)
    print(f"[verdict] 密度分 {verdict['score']} / passed={verdict['passed']}"
          f" / degraded={verdict['degraded']}", flush=True)
    for f_ in verdict["failures"]:
        print(f"  ! {f_}", flush=True)
    print(f"[done] 产物 → {OUT}", flush=True)


if __name__ == "__main__":
    main()
