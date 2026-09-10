"""FDE 方案生成器（M7.2 / PROPOSAL_M7 §4 广产品）——统一方案工厂内核。

编排：目录(L1) → 逐节重构(密度闸门+重生成) → 整案密度终检 → MD 渲染。
断点续传：每节落盘 checkpoint，中断续跑只补未完成节（AIResearch 资产移植）。
降级不假完成：未过闸门的节带 degrade_note 进成品，读者可见。
"""

import json
import os

from paistation.foundry.density import density_score
from paistation.foundry.prompts import DEFAULT_COVERAGE
from paistation.foundry.reconstructor import Reconstructor

FDE_COVERAGE = DEFAULT_COVERAGE  # 行业诊断→机会→路线图→抄作业→度量


def digest_markdown(md_text: str, max_chars: int = 30000) -> str:
    """长书 MD → 骨架摘要：保留全部标题 + 每段首行（前 200 字），供提示词注入。"""
    keep, size, para_seen = [], 0, False
    for raw in md_text.splitlines():
        line = raw.strip()
        if line.startswith("#"):
            keep.append(line)
            size += len(line)
            para_seen = False
            continue
        if not line:
            continue
        if not para_seen:
            take = line[:200]
            keep.append(take)
            size += len(take)
            para_seen = True
        if size >= max_chars:
            break
    return "\n".join(keep)


def compose_plan(engine: Reconstructor, theme: str, corpus: str, *,
                 n_chapters: int = 6, coverage: str = FDE_COVERAGE,
                 immune_rules: tuple | list = (),
                 checkpoint_path: str | None = None) -> dict:
    """整案编排：目录 → 逐节（断点续传）→ 终检。返回带 score/passed/failures 的方案。"""
    done: dict[str, dict] = {}
    if checkpoint_path and os.path.exists(checkpoint_path):
        done = json.load(open(checkpoint_path, encoding="utf-8"))
        print(f"[resume] 断点续传：已完成 {len(done)} 节", flush=True)

    toc = engine.reconstruct_toc(theme, corpus=corpus, n_chapters=n_chapters,
                                 immune_rules=immune_rules, coverage=coverage)
    chapters = []
    for ch in toc["chapters"]:
        sections = []
        for spec in ch["sections"]:
            key = f"{ch['title']}||{spec['title']}"
            if key in done:
                sections.append(done[key])
                continue
            out = engine.reconstruct_section(ch, spec["title"], corpus=corpus,
                                             immune_rules=immune_rules)
            sec = {"title": spec["title"], "framework": out["framework"],
                   "components": out["components"], "content": out["content"],
                   "degraded": out["degraded"], "degrade_note": out["degrade_note"]}
            sections.append(sec)
            if checkpoint_path:
                state = {**done, key: sec}
                json.dump(state, open(checkpoint_path, "w", encoding="utf-8"),
                          ensure_ascii=False)
                done = state
            print(f"  [section] {key} → {out['score']} 分"
                  f"{'（降级）' if out['degraded'] else ''}", flush=True)
        chapters.append({**ch, "sections": sections})

    doc = {"title": toc["title"], "chapters": chapters}
    verdict = density_score(doc)
    plan = {**doc, "score": verdict["score"], "passed": verdict["passed"],
            "failures": verdict["failures"]}
    if checkpoint_path and os.path.exists(checkpoint_path):
        os.remove(checkpoint_path)  # 完工清除断点，防陈旧复用
    return plan


def render_markdown(plan: dict) -> str:
    """方案 → Markdown 成品（章/节框架标注可见，降级说明明示）。"""
    lines = [f"# {plan.get('title', '未命名方案')}", "",
             f"> 思想密度分：**{plan.get('score', 0)}**"
             f"（{'✅ 通过密度闸门' if plan.get('passed') else '⚠️ 未达阈值'}）", ""]
    for ch in plan.get("chapters", []):
        lines += [f"## {ch.get('title', '')}", "",
                  f"> 章框架：{ch.get('framework', '未标注')}", ""]
        for sec in ch.get("sections", []):
            lines += [f"### {sec.get('title', '')}", "",
                      f"*节框架：{sec.get('framework', '未标注')}"
                      f"｜组件：{('、'.join(sec.get('components', [])) or '无')}*", "",
                      sec.get("content", ""), ""]
            if sec.get("degraded"):
                lines += [f"> ⚠️ **{sec.get('degrade_note', '降级')}**", ""]
    return "\n".join(lines)


def save_plan(plan: dict, out_dir: str) -> tuple[str, str]:
    """落盘 plan.json + plan.md，返回 (json_path, md_path)。"""
    os.makedirs(out_dir, exist_ok=True)
    json_path = os.path.join(out_dir, "plan.json")
    md_path = os.path.join(out_dir, "plan.md")
    json.dump(plan, open(json_path, "w", encoding="utf-8"),
              ensure_ascii=False, indent=2)
    with open(md_path, "w", encoding="utf-8") as f:
        f.write(render_markdown(plan))
    return json_path, md_path
