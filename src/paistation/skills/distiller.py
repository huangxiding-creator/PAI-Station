"""初终稿 diff 蒸馏器（提案 H1 核心自研，M3 PoC）。

自学习闭环的最小可运转型：拿一对（初稿, 终稿），
①算词级 diff 统计 ②LLM 提炼一条可复用偏好规则 ③规则入记忆库。
模型不可用时降级为"改写事实规则"（词级替换清单），蒸馏永不空手。
"""
import difflib
import logging
import time

from ..llm.zhipu_client import extract_json

_log = logging.getLogger("paistation.skills.distiller")

_PROMPT = (
    "用户对同一任务先后写了初稿与终稿。请从改写差异中提炼一条"
    "**可复用的用户偏好规则**（下次同类写作直接应用），"
    "输出 JSON：{\"preference\": \"一条规则，祈使句，不超过40字\", "
    "\"evidence\": \"初稿→终稿的关键替换\"}。只输出 JSON。")


def word_diff(initial: str, final: str) -> dict:
    """字符级相似度 + 变化术语清单（CJK 单字/英文单词）。"""
    ratio = difflib.SequenceMatcher(a=initial, b=final).ratio()
    sm = difflib.SequenceMatcher(a=initial, b=final)
    removed: list[str] = []
    added: list[str] = []
    for tag, i1, i2, j1, j2 in sm.get_opcodes():
        if tag in ("delete", "replace"):
            removed.append(initial[i1:i2].strip())
        if tag in ("insert", "replace"):
            added.append(final[j1:j2].strip())
    return {"same_ratio": round(ratio, 3),
            "changed_terms": [t for t in removed + added if t]}


class Distiller:
    """distill(initial, final, task) -> {rule, diff, saved}。"""

    def __init__(self, client, store=None):
        self._client = client
        self._store = store

    def distill(self, initial: str, final: str, task: str = "") -> dict:
        diff = word_diff(initial, final)
        if diff["same_ratio"] >= 0.999:
            return {"rule": "", "diff": diff, "saved": False,
                    "reason": "初终稿无差异，无可蒸馏"}
        rule = self._extract_rule(initial, final, task, diff)
        saved = False
        if rule and self._store is not None:
            self._store.upsert(
                path=f"preference/{int(time.time() * 1000)}",
                title=f"偏好规则：{rule[:30]}",
                summary=rule, score=0.9)
            saved = True
        _log.info("蒸馏完成 saved=%s rule=%s", saved, rule[:40])
        return {"rule": rule, "diff": diff, "saved": saved}

    def _extract_rule(self, initial: str, final: str, task: str,
                      diff: dict) -> str:
        context = (f"任务：{task or '(未注明)'}\n初稿：{initial}\n终稿：{final}\n"
                   f"词级变化：{diff['changed_terms'][:20]}")
        try:
            r = self._client.fast(_PROMPT, context=context, json_mode=True)
            data = extract_json(r["text"])
            preference = str(data.get("preference", "")).strip()
            if preference:
                return preference[:60]
        except Exception as exc:  # noqa: BLE001 - 降级不空手
            _log.warning("LLM 蒸馏失败，降级规则：%s", exc)
        pairs = diff["changed_terms"][:3]
        return "用户改写偏好：将 " + "、".join(f"「{t}」" for t in pairs) + \
            " 类表述按终稿方向改写"
