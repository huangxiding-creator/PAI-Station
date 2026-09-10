"""重构引擎（M7.1 / PROPOSAL_M7 §3）：生成器 GLM × 验证器密度计 × 重生成环。

核心循环（verifier > generator）：
  选卡注入 → GLM 生成节 JSON → schema 归一化 → 密度计打分 →
  不达标则把失败原因喂回重生成（≤max_regens 次）→ 仍不过 → 降级标注（不假完成）。
多候选时按密度分择优（免费模型的挥霍式采样， EnsembleRunner 字符串投票的
长文替代——质量可验证场景用 verifier 择优，不靠文本相同）。
主脑依赖注入（deep_fn 契约同 forge.skill_cards：deep_fn(prompt, reasoning=True)["text"]）。
"""

import json
import re

from paistation.foundry.density import NINE_COMPONENTS, density_score
from paistation.foundry.methodology import suggest_cards
from paistation.foundry.prompts import NINE_MARKERS, section_prompt, toc_prompt

_JSON_RE = re.compile(r"\{.*\}", re.DOTALL)

# 九件套中文标签（id → 去【】标签），用于从内容反查已嵌入组件
_LABELS = {key: mark.strip("【】") for key, mark in NINE_MARKERS}


def _loads_json(text: str) -> dict | None:
    """三级解析：去围栏 → 直解 → 正则截取首个 JSON 对象；失败返回 None。"""
    if not text:
        return None
    stripped = text.strip()
    if stripped.startswith("```"):
        stripped = re.sub(r"^```[a-zA-Z]*\s*|\s*```$", "", stripped)
    candidates = [stripped]
    match = _JSON_RE.search(stripped)
    if match:
        candidates.append(match.group(0))
    for cand in candidates:
        try:
            obj = json.loads(cand)
        except ValueError:
            continue
        if isinstance(obj, dict):
            return obj
    return None


class Reconstructor:
    """重构引擎。deep_fn 返回 {"text": ...}；全程不改入参（宪法：只读映射）。"""

    def __init__(self, deep_fn, max_regens: int = 2, threshold: int = 60):
        self._deep = deep_fn
        self._max_regens = max_regens
        self._threshold = threshold

    def _call(self, prompt: str) -> str:
        return self._deep(prompt, reasoning=True)["text"]

    # ---------- 节层重构 ----------

    def reconstruct_section(self, chapter: dict, section_title: str, corpus: str = "",
                            immune_rules: tuple | list = (), n_candidates: int = 1) -> dict:
        """生成一节：best-of-N 择优 + 失败原因回喂重生成 + 降级不假完成。

        返回 {...节字段, score, passed, degraded, degrade_note}。
        """
        spec = next(
            (s for s in chapter.get("sections", []) if s.get("title") == section_title),
            {"title": section_title, "framework": ""},
        )
        cards = [(c["name"], c["one_liner"])
                 for c in suggest_cards(section_title, "L2L3", k=6)]
        best, calls, failures_note = None, 0, []
        regens = 0
        while True:
            for _ in range(n_candidates if calls == 0 else 1):
                calls += 1
                prompt = section_prompt(
                    chapter.get("title", ""), spec, corpus=corpus,
                    cards_l2l3=cards, immune_rules=list(immune_rules),
                    failures=failures_note,
                )
                candidate = self._normalize_section(_loads_json(self._call(prompt)))
                result = self._score_section(chapter, candidate)
                if best is None or result["score"] > best["score"]:
                    best = result
                if best["passed"]:
                    return self._emit(best, calls, degraded=False)
            if best["passed"] or regens >= self._max_regens:
                break
            regens += 1
            failures_note = list(best["failures"])  # 验证器反馈喂回生成器
        return self._emit(best, calls, degraded=True)

    @staticmethod
    def _normalize_section(obj) -> dict:
        """schema 归一化：非法组件滤除、字段强制成串；内容反查补全组件。

        GLM 常在正文嵌入组件却漏报 components——密度计应丈量真实嵌入，
        故按中文标签（如"小案例"）从 content 反查并集（防漏报），声明序优先。
        """
        if not isinstance(obj, dict):
            return {"title": "", "framework": "", "components": [], "content": ""}
        declared = [c for c in obj.get("components", [])
                    if isinstance(c, str) and c in NINE_COMPONENTS]
        content = str(obj.get("content", "")).strip()
        embedded = [key for key, label in _LABELS.items() if label in content]
        components = list(dict.fromkeys(declared + embedded))
        return {
            "title": str(obj.get("title", "")).strip(),
            "framework": str(obj.get("framework", "")).strip(),
            "components": components,
            "content": content,
        }

    def _score_section(self, chapter: dict, section: dict) -> dict:
        """单节密度打分：借密度计（包一层最小文档，复用全部维度逻辑）。"""
        doc = {"title": chapter.get("title", ""),
               "chapters": [{**chapter, "sections": [section]}]}
        verdict = density_score(doc, threshold=self._threshold)
        return {"section": section, "score": verdict["score"],
                "passed": verdict["passed"], "failures": verdict["failures"]}

    def _emit(self, best: dict, calls: int, degraded: bool) -> dict:
        note = (f"降级：连续 {calls} 次生成未达密度阈值 {self._threshold}"
                f"（最高 {best['score']} 分），本节按实际质量交付，不假完成"
                if degraded else "")
        return {**best["section"], "score": best["score"], "passed": best["passed"],
                "degraded": degraded, "degrade_note": note}

    # ---------- 目录重构（L1 章层） ----------

    def reconstruct_toc(self, theme: str, corpus: str = "", n_chapters: int = 8,
                        immune_rules: tuple | list = (), coverage: str = "") -> dict:
        """生成三级目录骨架；解析失败自动重试，弹尽粮尽如实报错。"""
        cards = [(c["name"], c["one_liner"]) for c in suggest_cards(theme, "L1", k=12)]
        kwargs = {"theme": theme, "corpus": corpus, "cards_l1": cards,
                  "n_chapters": n_chapters}
        if coverage:
            kwargs["coverage"] = coverage
        attempts = self._max_regens + 1
        for _ in range(attempts):
            toc = self._normalize_toc(_loads_json(self._call(toc_prompt(**kwargs))))
            if toc:
                return toc
        raise RuntimeError(f"目录生成失败：{attempts} 次尝试均无法解析出合法三级目录")

    @staticmethod
    def _normalize_toc(obj) -> dict | None:
        """目录 schema 归一化：非法章/节剔除，无有效章返回 None。"""
        if not isinstance(obj, dict):
            return None
        chapters = []
        for ch in obj.get("chapters", []):
            if not isinstance(ch, dict) or not str(ch.get("title", "")).strip():
                continue
            sections = [
                {"title": str(s.get("title", "")).strip(),
                 "framework": str(s.get("framework", "")).strip()}
                for s in ch.get("sections", [])
                if isinstance(s, dict) and str(s.get("title", "")).strip()
            ]
            chapters.append({"title": str(ch["title"]).strip(),
                             "framework": str(ch.get("framework", "")).strip(),
                             "sections": sections})
        if not chapters:
            return None
        return {"title": str(obj.get("title", "")).strip() or "未命名方案",
                "chapters": chapters}
