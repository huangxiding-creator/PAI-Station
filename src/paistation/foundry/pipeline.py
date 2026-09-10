"""七步研究管线（M7.5 / PROPOSAL_M7 §6，AIResearch workflow_engine 编排移植）。

AIResearch 七步：主题 → 关键词 → 多源收集 → 合并 → 目录 → 逐节 → 发布。
PAI-Station 化重写：INI 配置/依赖注入/可测/断点续传（管线级 state +
节级 checkpoint 双层），5-6 步复用重构引擎（密度闸门内建）。
"""

import json
import os
import re

from paistation.foundry.collector import collect_corpus, merge_corpus
from paistation.foundry.fde import compose_plan, save_plan
from paistation.foundry.promo import save_promo
from paistation.foundry.reconstructor import Reconstructor

_STEPS = ("theme", "keywords", "collect", "merge", "toc", "sections", "publish")


def generate_keywords(theme: str, fast_fn=None) -> list[str]:
    """七步之二：智谱关键词扩展（AIResearch 原案）。GLM 失败落分词兜底。"""
    if fast_fn is not None:
        try:
            payload = fast_fn(
                f"为主题「{theme}」生成 6 个中文调研关键词（覆盖行业术语/方法论/"
                "落地场景）。只输出 JSON 数组，如 [\"关键词1\", ...]")
            text = re.sub(r"^```[a-zA-Z]*\s*|\s*```$", "", payload["text"].strip())
            kws = json.loads(text)
            if isinstance(kws, list) and kws:
                return [str(k)[:30] for k in kws if str(k).strip()][:8]
        except Exception:  # noqa: BLE001 - 兜底路径，闭环不断链
            pass
    # 兜底：主题切词（去虚词取实词块）
    tokens = re.split(r"[\s，、/·—()（）]+", theme)
    return [t for t in tokens if len(t) >= 2][:6]


class Pipeline:
    """七步编排（依赖注入 deep_fn/fast_fn，纯本地 state 断点）。"""

    def __init__(self, deep_fn, fast_fn=None, workdir: str = "data/foundry/pipeline"):
        self._deep = deep_fn
        self._fast = fast_fn
        self._workdir = workdir
        self._state_path = os.path.join(workdir, "pipeline_state.json")

    # ---------- 断点 ----------

    def _load_state(self) -> dict:
        if os.path.exists(self._state_path):
            try:
                return json.load(open(self._state_path, encoding="utf-8"))
            except (OSError, ValueError):
                pass
        return {"step": "theme"}

    def _save_state(self, **fields) -> None:
        os.makedirs(self._workdir, exist_ok=True)
        state = {**self._load_state(), **fields}
        json.dump(state, open(self._state_path, "w", encoding="utf-8"),
                  ensure_ascii=False, indent=2)

    # ---------- 七步 ----------

    def run(self, theme: str, *, pools: dict[str, str], n_chapters: int = 6,
            immune_rules: tuple | list = ()) -> dict:
        """跑通七步（可从任意断点续）。返回 {plan, outdir, keywords, chunks}。"""
        state = self._load_state()
        if state.get("theme") != theme:  # 换主题 → 重开管线
            state = {"step": "theme"}
        state["theme"] = theme
        state["n_chapters"] = n_chapters

        if state["step"] == "theme":
            state["step"] = "keywords"
            self._save_state(**state)

        # 各步以"产出是否存在"驱动跳过（断点续传），step 字段仅作进度记账
        if "keywords" not in state:
            kws = generate_keywords(theme, fast_fn=self._fast)
            state.update(step="collect", keywords=kws)
            self._save_state(**state)
            print(f"[pipeline:keywords] {kws}", flush=True)
        elif state["step"] == "keywords":
            state["step"] = "collect"

        if "chunks" not in state:
            collected = collect_corpus(theme, pools=pools,
                                       keywords=tuple(state.get("keywords", ())))
            state.update(step="merge", chunks=collected["chunks"],
                         stats=collected["stats"])
            self._save_state(**state)
            print(f"[pipeline:collect] 命中 {collected['stats']['matched_files']} 源",
                  flush=True)

        corpus = merge_corpus(state.get("chunks", []))
        if state["step"] == "merge":
            state["step"] = "toc"
            self._save_state(**state)
            print(f"[pipeline:merge] 语料 {len(corpus)} 字", flush=True)

        engine = Reconstructor(self._deep)
        slug = re.sub(r"[^\w-]+", "-", theme).strip("-")[:40] or "plan"
        outdir = os.path.join(self._workdir, "out", slug)
        ckpt = os.path.join(outdir, "plan.ckpt.json")

        plan = None
        if state["step"] in ("toc", "sections"):
            plan = compose_plan(engine, theme, corpus, n_chapters=n_chapters,
                                immune_rules=immune_rules, checkpoint_path=ckpt)
            state.update(step="publish", plan_summary={
                "title": plan["title"], "score": plan["score"],
                "passed": plan["passed"]})
            self._save_state(**state)
        elif state["step"] in ("publish", "done"):
            plan_path = os.path.join(outdir, "plan.json")
            if os.path.exists(plan_path):
                plan = json.load(open(plan_path, encoding="utf-8"))
        if plan is None:  # publish/done 态但成品缺失（异常态）→ 重生成
            plan = compose_plan(engine, theme, corpus, n_chapters=n_chapters,
                                immune_rules=immune_rules, checkpoint_path=ckpt)

        plan = {**plan, "slug": slug}
        save_plan(plan, outdir)
        save_promo(plan, os.path.join(outdir, "promo.md"))
        state["step"] = "done"
        self._save_state(**state)
        print(f"[pipeline:publish] {outdir}", flush=True)
        return {"plan": plan, "outdir": outdir, "keywords": state.get("keywords", []),
                "chunks": state.get("chunks", [])}
