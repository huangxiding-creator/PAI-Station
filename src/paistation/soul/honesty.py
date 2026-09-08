"""诚实引擎（提案第 24 章②）：魔鬼代言人第二意见卡 + 谄媚漂移检测。

- DevilAdvocate：重大外发前 100% 过卡——规则层先查"无证据强断言"，
  deep_fn 可注入则补 LLM 第二意见；major 一票拦截。
- sycophancy_drift：近期输出中迎合性口头禅占比 → 漂移分（≥0.5 告警）。
"""
import json
import re

_MAJOR_PATTERNS = (
    r"一定(会|能)", r"保证\s*\d+%", r"100%\s*(满意|成功)",
    r"(最好|第一|顶尖)", r"完美(无缺)?的?方案", r"绝无仅有")
_MINOR_PATTERNS = (r"应该没问题", r"大概(没问题|可以)", r"我猜")
_EVIDENCE_MARK = ("数据", "测试", "实测", "根据", "来源", "%", "例")
_SYCOPHANT = ("你说得对", "完全正确", "绝对没错", "好问题", "正是如此",
              "您真", "不愧是")


class DevilAdvocate:
    """第二意见卡：review(content) → {severity, challenges, pass}。"""

    def __init__(self, deep_fn=None):
        self._deep = deep_fn

    def review(self, content: str) -> dict:
        challenges = []
        has_evidence = any(m in content for m in _EVIDENCE_MARK)
        for pat in _MAJOR_PATTERNS:
            if re.search(pat, content):
                challenges.append(f"强断言『{pat.replace(chr(92), '')}』"
                                  "缺乏证据支撑")
        for pat in _MINOR_PATTERNS:
            if re.search(pat, content):
                challenges.append(f"模糊表述『{pat}』建议给出可验证依据")
        if challenges and not has_evidence:
            challenges.append("全文未见任何数据/实测/来源标记")
        severity = "major" if any(
            re.search(p, content) for p in _MAJOR_PATTERNS) else "minor"
        if self._deep is not None:
            try:
                raw = self._deep(
                    "对以下内容当魔鬼代言人，只输出 JSON 数组（每项一条质疑）：\n"
                    + content, reasoning=False)["text"]
                match = re.search(r"\[.*\]", raw, re.DOTALL)
                if match:
                    extra = json.loads(match.group(0))
                    if isinstance(extra, list):
                        challenges += [str(e) for e in extra][:3]
            except Exception:  # noqa: BLE001 - LLM 缺席 → 纯规则意见
                pass
        return {"severity": severity if challenges else "none",
                "challenges": challenges,
                "pass": not (severity == "major" and challenges)}


def sycophancy_drift(outputs: list) -> float:
    """迎合性口头禅命中率（0-1）；≥0.5 触发漂移告警。"""
    if not outputs:
        return 0.0
    hits = sum(1 for text in outputs
               if any(p in text for p in _SYCOPHANT))
    return round(hits / len(outputs), 2)
