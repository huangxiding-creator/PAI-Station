# -*- coding: utf-8 -*-
"""M9.5b 首课题报告密度重构实跑：结论卡拼贴(42分) → 节级综合(目标≥60)。

每节一次 GLM 综合（report_dense.SECTION_SYNTH_PROMPT），断点续传
（dense_checkpoint.jsonl 逐节落盘，重跑只补缺），节流 2s/节 + 重试×3。
产出：report.md（真报告）+ density_doc.json + acceptance.json（C11
before→after 同档存证，不覆盖旧分数）。
用法：python tools/research_dense_report.py
"""
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config as pai_config                     # noqa: E402
from paistation.foundry.density import density_score            # noqa: E402
from paistation.foundry.report_dense import (                   # noqa: E402
    SECTION_SYNTH_PROMPT,
    assemble_report_md,
    build_dense_doc,
    keyword_components,
    merge_components,
    parse_synthesis,
)
from paistation.llm.zhipu_client import ZhipuClient             # noqa: E402

TOPIC = "EPC合同风险与索赔管理"
D = ROOT / "08 成果" / "research" / TOPIC
CKPT = D / "dense_checkpoint.jsonl"


def load_json(name):
    return json.loads((D / name).read_text(encoding="utf-8"))


def main() -> int:
    master = load_json("master_framework.json")
    questions = load_json("question_list.json")["items"]
    cards = load_json("conclusion_cards.json")

    by_node: dict[str, list[dict]] = {}
    qnode = {q["qid"]: q.get("node_id", "") for q in questions}
    for card in cards:
        by_node.setdefault(qnode.get(card.get("qid"), ""), []).append(card)

    done: dict[str, dict] = {}
    if CKPT.exists():
        for line in CKPT.read_text(encoding="utf-8").splitlines():
            if line.strip():
                rec = json.loads(line)
                done[rec["node_id"]] = rec["synth"]

    cfg = pai_config.load(ROOT / "config" / "pai.ini")
    client = ZhipuClient(pai_config.resolve_api_key(cfg),
                         [cfg["llm"]["fast_model"], cfg["llm"]["deep_model"]])

    sections = [n for n in master if n.get("level") != "章"]
    todo = [s for s in sections if s["id"] not in done]
    print(f"[dense] 节 {len(sections)}｜已综合 {len(done)}｜待综合 {len(todo)}",
          flush=True)

    with open(CKPT, "a", encoding="utf-8") as ck:
        for i, sec in enumerate(todo):
            cards_here = by_node.get(sec["id"], [])
            cards_text = "\n\n".join(
                f"— 卡{j + 1} —\n{c.get('text', '')[:400]}"
                for j, c in enumerate(cards_here[:8]))
            prompt = SECTION_SYNTH_PROMPT.format(
                title=sec["title"], n_cards=len(cards_here), cards=cards_text)
            text, attempts = "", 0
            while attempts < 3:
                try:
                    text = client.chat(
                        "你是严谨的工程领域研究员，输出精炼、可核查。",
                        prompt, temperature=0.2)
                    break
                except Exception as exc:  # noqa: BLE001 - 限流/瞬断→退避重试
                    attempts += 1
                    print(f"[dense] {sec['id']} 第{attempts}次失败："
                          f"{str(exc)[:60]}，睡 30s", flush=True)
                    time.sleep(30)
            if not text:
                print(f"[dense] {sec['id']} 三次失败，跳过（下次续作）", flush=True)
                continue
            syn = parse_synthesis(text)
            syn["components"] = merge_components(
                syn["components"], keyword_components(syn["content"]))
            ck.write(json.dumps({"node_id": sec["id"], "synth": syn},
                                ensure_ascii=False) + "\n")
            ck.flush()
            done[sec["id"]] = syn
            if (i + 1) % 10 == 0:
                print(f"[dense] 进度 {i + 1}/{len(todo)}", flush=True)
            time.sleep(2)

    doc = build_dense_doc(TOPIC, master, done)
    score = density_score(doc)
    meta = {"nodes": len(master), "questions": len(questions),
            "evidenced": load_json("manifest.json")["steps"]["evidence"]
            ["detail"]["evidenced"],
            "conclusions": len(cards)}
    (D / "density_doc.json").write_text(json.dumps(
        doc, ensure_ascii=False, indent=1), encoding="utf-8")
    (D / "report.md").write_text(assemble_report_md(doc, meta),
                                 encoding="utf-8")

    acceptance = load_json("acceptance.json")
    acceptance["density_card_collage"] = acceptance.pop("density")  # C11 before
    acceptance["density"] = score                                   # after
    (D / "acceptance.json").write_text(json.dumps(
        acceptance, ensure_ascii=False, indent=1), encoding="utf-8")

    print(f"\n[dense] 完成 {len(done)}/{len(sections)} 节", flush=True)
    print(f"[density] before=42 → after={score['score']} "
          f"passed={score['passed']}", flush=True)
    for f in score["failures"]:
        print(f"  - {f}", flush=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
