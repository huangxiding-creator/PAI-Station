"""两阶段调研管线编排器（PROPOSAL_V2.md 第 5 章，用户裁决①首发域）。

七步：①初级调研(框架提取) ②框架合成 ③问题清单(≥300) ④综合调研
⑤知识炼金 ⑥三层重构 ⑦验收。断点续传（manifest.json 步进）+ 器官
凭证落链（R14）。search_fn/llm_fn 注入：缺席即降级如实记 0，不停摆。
"""
from __future__ import annotations

import json
import time
from dataclasses import dataclass, field
from pathlib import Path

from .frame_extract import parse_toc
from .frame_synthesis import synthesize
from .question_gen import check_gate, generate_questions, to_records

MANIFEST = "manifest.json"


@dataclass
class _Step:
    name: str
    done: bool = False
    at: str = ""
    detail: dict = field(default_factory=dict)


def _now() -> str:
    return time.strftime("%Y-%m-%dT%H:%M:%S")


class ResearchPipeline:
    """单课题管线：run(topic, frames_texts) 可反复重入（断点续传）。"""

    STEPS = ("frames", "master", "questions", "evidence",
             "conclusions", "report", "acceptance")

    def __init__(self, workdir, search_fn=None, llm_fn=None,
                 station_root=None, min_questions: int = 300):
        self.workdir = Path(workdir)
        self.search_fn = search_fn
        self.llm_fn = llm_fn
        self.station_root = Path(station_root) if station_root else None
        self.min_questions = min_questions

    # -- 基础设施 ---------------------------------------------------------

    def _topic_dir(self, topic: str) -> Path:
        d = self.workdir / topic
        d.mkdir(parents=True, exist_ok=True)
        return d

    def _load_manifest(self, d: Path) -> dict:
        f = d / MANIFEST
        if f.exists():
            try:
                return json.loads(f.read_text(encoding="utf-8"))
            except json.JSONDecodeError:
                pass
        return {"topic": d.name, "steps": {s: {"done": False}
                                           for s in self.STEPS}}

    def _save_manifest(self, d: Path, manifest: dict, step: str,
                       detail: dict) -> None:
        manifest["steps"][step] = {"done": True, "at": _now(), "detail": detail}
        (d / MANIFEST).write_text(json.dumps(manifest, ensure_ascii=False,
                                             indent=1), encoding="utf-8")

    def _credential(self, kind: str, upstream: str, downstream: str,
                    payload: dict) -> None:
        if not self.station_root:
            return
        from ..organ.credential import append_to_chain, issue
        append_to_chain(self.station_root, upstream,
                        issue(kind=kind, upstream=upstream,
                              downstream=downstream, payload=payload))

    # -- 七步实现 ---------------------------------------------------------

    def _step_frames(self, d: Path, manifest, frames_texts) -> list[dict]:
        step = "frames"
        if manifest["steps"][step]["done"]:
            return json.loads((d / "frameworks.json").read_text(encoding="utf-8"))
        frames = [{"name": f"框架{i + 1}", "nodes": parse_toc(text)}
                  for i, text in enumerate(frames_texts or [])]
        (d / "frameworks.json").write_text(
            json.dumps(frames, ensure_ascii=False, indent=1), encoding="utf-8")
        self._save_manifest(d, manifest, step,
                            {"frames": len(frames)})
        self._credential("frames_extracted", "04 智库", "05 方法",
                         {"frames": len(frames)})
        return frames

    def _step_master(self, d: Path, manifest, frames) -> list[dict]:
        step = "master"
        if manifest["steps"][step]["done"]:
            return json.loads((d / "master_framework.json")
                              .read_text(encoding="utf-8"))
        master = synthesize([(f["name"], f["nodes"]) for f in frames])
        (d / "master_framework.json").write_text(
            json.dumps(master, ensure_ascii=False, indent=1), encoding="utf-8")
        self._save_manifest(d, manifest, step,
                            {"nodes": len(master)})
        return master

    def _step_questions(self, d: Path, manifest, master) -> list[dict]:
        step = "questions"
        if manifest["steps"][step]["done"]:
            return json.loads((d / "question_list.json")
                              .read_text(encoding="utf-8"))["items"]
        questions = to_records(generate_questions(master))
        ok, count = len(questions) >= self.min_questions, len(questions)
        (d / "question_list.json").write_text(json.dumps(
            {"topic": d.name, "items": questions}, ensure_ascii=False,
            indent=1), encoding="utf-8")
        self._save_manifest(d, manifest, step, {"count": count, "gate": ok})
        return questions

    def _step_evidence(self, d: Path, manifest, questions) -> dict:
        step = "evidence"
        if manifest["steps"][step]["done"]:
            return json.loads((d / "evidence_pool.json")
                              .read_text(encoding="utf-8"))
        pool: dict[str, list[dict]] = {}
        if self.search_fn:
            for q in questions:
                pool[q["qid"]] = list(self.search_fn(q["text"]) or [])
        (d / "evidence_pool.json").write_text(json.dumps(
            pool, ensure_ascii=False, indent=1), encoding="utf-8")
        evidenced = sum(1 for v in pool.values() if v)
        self._save_manifest(d, manifest, step,
                            {"questions": len(questions), "evidenced": evidenced})
        return {"pool": pool, "evidenced": evidenced}

    def _step_conclusions(self, d: Path, manifest, questions, evidence) -> int:
        step = "conclusions"
        if manifest["steps"][step]["done"]:
            return manifest["steps"][step]["detail"]["count"]
        cards: list[dict] = []
        if self.llm_fn:
            for q in questions:
                ev = evidence.get("pool", {}).get(q["qid"], [])
                basis = "\n".join(f"- {e.get('title', '')}：{e.get('snippet', '')}"
                                  for e in ev[:3])
                text = self.llm_fn(
                    f"问题：{q['text']}\n证据：\n{basis or '（无证据，标注待证）'}\n"
                    "请输出结论卡：结论/依据/反方/置信度。")
                cards.append({"qid": q["qid"], "text": text,
                              "sources": len(ev)})
        (d / "conclusion_cards.json").write_text(json.dumps(
            cards, ensure_ascii=False, indent=1), encoding="utf-8")
        self._save_manifest(d, manifest, step, {"count": len(cards)})
        self._credential("knowledge_refined", "04 智库", "05 方法",
                         {"cards": len(cards)})
        return len(cards)

    def _step_report(self, d: Path, manifest, master, questions,
                     conclusions) -> Path | None:
        step = "report"
        if manifest["steps"][step]["done"]:
            return d / manifest["steps"][step]["detail"]["file"]
        if not conclusions:
            self._save_manifest(d, manifest, step,
                                {"file": "", "skipped": "no conclusions"})
            return None
        lines = [f"# {d.name} —— 调研报告（管线出厂）", "",
                 f"- 框架节点：{len(master)}；问题：{len(questions)}；"
                 f"结论卡：{conclusions}", ""]
        for node in master:
            lines += [f"## {node['title']}", ""]
            related = [q for q in questions if q["node_id"] == node["id"]]
            lines.append(f"（本节覆盖 {len(related)} 问；"
                         f"频次 {node['frequency']}；"
                         f"{'共识' if node['consensus'] else '独家'}）")
            lines.append("")
        path = d / "report.md"
        path.write_text("\n".join(lines), encoding="utf-8")
        self._save_manifest(d, manifest, step, {"file": path.name})
        return path

    def _step_acceptance(self, d: Path, manifest, questions, evidence,
                         conclusions) -> dict:
        step = "acceptance"
        result = {
            "questions": len(questions),
            "evidenced": evidence.get("evidenced", 0),
            "conclusions": conclusions,
            "gate_questions": len(questions) >= self.min_questions,
        }
        self._save_manifest(d, manifest, step, result)
        return result

    # -- 总装 -------------------------------------------------------------

    def run(self, topic: str, frames_texts: list[str] | None = None) -> dict:
        d = self._topic_dir(topic)
        manifest = self._load_manifest(d)
        frames = self._step_frames(d, manifest, frames_texts)
        master = self._step_master(d, manifest, frames)
        questions = self._step_questions(d, manifest, master)
        evidence = self._step_evidence(d, manifest, questions)
        conclusions = self._step_conclusions(d, manifest, questions, evidence)
        report = self._step_report(d, manifest, master, questions, conclusions)
        acceptance = self._step_acceptance(d, manifest, questions, evidence,
                                           conclusions)
        acceptance["report_path"] = report
        return acceptance
