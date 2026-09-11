# -*- coding: utf-8 -*-
"""M9.5 首课题全链实跑：两阶段调研管线 × 真实渠道（GLM 免费链 + DDG 检索）。

课题：工程总承包（EPC）合同风险与索赔管理
验收（PROPOSAL_V2.md 5.3）：≥300 问 / 每问证据 / 结论卡 / 密度分 / 时长
断点续传：ResearchPipeline manifest（重跑跳过已完成步骤）。
"""
import json
import re
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation import config as pai_config  # noqa: E402
from paistation.foundry.density import density_score  # noqa: E402
from paistation.foundry.research_pipeline import ResearchPipeline  # noqa: E402
from paistation.llm.zhipu_client import ZhipuClient  # noqa: E402

TOPIC = "EPC合同风险与索赔管理"
WORKDIR = ROOT / "08 成果" / "research" / TOPIC

FRAME_PERSPECTIVES = [
    ("工程管理教材视角",
     "你是工程总承包（EPC）领域资深教授，为《{topic}》编写教材目录。"),
    ("国际咨询方法论视角",
     "你是麦肯锡式国际工程咨询合伙人，为《{topic}》设计咨询方法论框架。"),
    ("企业内网实务视角",
     "你是大型工程企业总工程师，基于一线项目经验为《{topic}》列实务目录。"),
]
FRAME_PROMPT = """{role}
只输出目录本身（12-16 节），格式严格为：
第一章 章名
1.1 节名
1.2 节名
第二章 章名
2.1 节名
...
不要输出任何解释、前言或其他内容。"""

CONCLUDE_PROMPT = """问题：{q}
证据：
{basis}
请输出结论卡（≤120字），格式：
结论：...
依据：...
反方：...
置信度：高/中/低
组件：从[key_points,wbs,formula,experience_map,pitfall_checklist,arsenal,case,infographic,flowchart]中选0-2个，逗号分隔"""

_TAG_MAP = [("案例", "case"), ("步骤", "flowchart"), ("流程", "flowchart"),
            ("公式", "formula"), ("清单", "pitfall_checklist"),
            ("要点", "key_points"), ("分解", "wbs"), ("武器", "arsenal"),
            ("经验", "experience_map"), ("图", "infographic")]


def make_llm() -> ZhipuClient:
    cfg = pai_config.load(ROOT / "config" / "pai.ini")
    key = pai_config.resolve_api_key(cfg)
    return ZhipuClient(key, [cfg["llm"]["fast_model"],
                             cfg["llm"]["deep_model"]],
                       vision_model=cfg["llm"]["vision_model"])


def glm_llm(prompt: str) -> str:
    global _CLIENT
    return _CLIENT.chat("你是严谨的工程领域研究员，输出精炼、可核查。",
                        prompt, temperature=0.2)


def ddg_search(query: str) -> list[dict]:
    """证据检索：Bing 公开页（国内可达/零登录/非个人账号）+ 礼貌节流。"""
    time.sleep(2.0)
    try:
        from paistation.forge.bing_search import search as bing_search
        return bing_search(query, max_results=8)
    except Exception as exc:  # noqa: BLE001 - 网络故障如实降级
        print(f"  [search] {type(exc).__name__}: {str(exc)[:60]}", flush=True)
        return []


def gen_frames(llm) -> list[str]:
    texts = []
    for name, role in FRAME_PERSPECTIVES:
        prompt = FRAME_PROMPT.format(role=role.format(topic=TOPIC))
        out = llm.chat("你是目录设计专家。", prompt, temperature=0.4)
        if "第一章" in out or re.search(r"^# ", out, re.M):
            texts.append(out)
            print(f"[frames] {name}: {len(out.splitlines())} 行", flush=True)
        else:
            print(f"[frames] {name}: 输出无目录结构，丢弃", flush=True)
    return texts


def scan_components(text: str) -> list[str]:
    found = [slug for kw, slug in _TAG_MAP if kw in text]
    return list(dict.fromkeys(found))[:2]


def build_density_doc(master: list[dict], cards: list[dict],
                      questions: list[dict]) -> dict:
    by_node: dict[str, list[dict]] = {}
    qnode = {q["qid"]: q.get("node_id", "") for q in questions}
    for card in cards:
        by_node.setdefault(qnode.get(card.get("qid"), ""), []).append(card)
    chapters = [n for n in master if n.get("level") == "章"]
    sections = [n for n in master if n.get("level") != "章"]
    ch_map = {}
    for ch in chapters:
        ch_map[ch["id"]] = {"title": ch["title"], "framework": "调研重构框架",
                            "sections": []}
    sec_list = []
    for sec in sections:
        cards_here = by_node.get(sec["id"], [])
        content = "\n".join(c.get("text", "")[:200] for c in cards_here[:4])
        sec_list.append({
            "title": sec["title"], "framework": "5W1H×利益相关方",
            "content": content or "（该节点结论卡待证——单源/无源标注）",
            "components": scan_components(content),
            "subsections": [],
        })
    for i, sec in enumerate(sections):
        owner = ch_map.get(sec["id"].split(".")[0]) or ch_map.get(
            (chapters[0]["id"] if chapters else ""), {"sections": []})
        owner["sections"].append(sec_list[i])
    return {"title": TOPIC, "chapters": list(ch_map.values())}


def main() -> int:
    global _CLIENT
    t0 = time.time()
    _CLIENT = make_llm()
    print(f"[llm] GLM 免费链就绪", flush=True)

    frames_dir = WORKDIR
    frames_dir.mkdir(parents=True, exist_ok=True)
    seed_file = frames_dir / "frames_texts.json"
    if seed_file.exists():
        frames_texts = json.loads(seed_file.read_text(encoding="utf-8"))
        print(f"[frames] 复用已生成框架 {len(frames_texts)} 份", flush=True)
    else:
        frames_texts = gen_frames(_CLIENT)
        if len(frames_texts) < 2:
            print("[frames] 有效框架不足 2 份，中止（先检查模型链）")
            return 1
        seed_file.write_text(json.dumps(frames_texts, ensure_ascii=False,
                                        indent=1), encoding="utf-8")

    pipe = ResearchPipeline(workdir=WORKDIR.parent, search_fn=ddg_search,
                            llm_fn=glm_llm, station_root=ROOT)
    result = pipe.run(TOPIC, frames_texts=frames_texts)
    elapsed = time.time() - t0
    print(f"\n[acceptance] questions={result['questions']} "
          f"evidenced={result['evidenced']} conclusions={result['conclusions']} "
          f"elapsed={elapsed / 60:.1f}min", flush=True)

    d = WORKDIR
    cards = json.loads((d / "conclusion_cards.json").read_text(encoding="utf-8")) \
        if (d / "conclusion_cards.json").exists() else []
    questions = json.loads((d / "question_list.json")
                           .read_text(encoding="utf-8"))["items"] \
        if (d / "question_list.json").exists() else []
    master = json.loads((d / "master_framework.json")
                        .read_text(encoding="utf-8")) \
        if (d / "master_framework.json").exists() else []
    if cards and questions and master:
        doc = build_density_doc(master, cards, questions)
        score = density_score(doc)
        print(f"[density] score={score['score']:.0f} passed={score['passed']}",
              flush=True)
        (d / "density_doc.json").write_text(json.dumps(
            doc, ensure_ascii=False, indent=1), encoding="utf-8")
    else:
        score = {"score": 0, "passed": False, "failures": ["产物不全"]}
    acceptance = {"topic": TOPIC, "questions": result["questions"],
                  "evidenced": result["evidenced"],
                  "conclusions": result["conclusions"],
                  "elapsed_min": round(elapsed / 60, 1),
                  "density": score,
                  "gate_questions": result["gate_questions"]}
    (d / "acceptance.json").write_text(json.dumps(acceptance,
                                                  ensure_ascii=False, indent=1),
                                       encoding="utf-8")
    print(json.dumps(acceptance, ensure_ascii=False, indent=1), flush=True)
    return 0


_CLIENT = None

if __name__ == "__main__":
    raise SystemExit(main())
