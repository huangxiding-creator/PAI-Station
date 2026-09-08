"""错误免疫系统（提案第 24 章③）：纠正 → 抗体规则 → 生成前拦截。

闭环：用户纠正 → learn() 落抗体（签名+错误+正确姿势）→ 之后同类
上下文 check() 命中 → inject() 把"过去在这里犯过什么"注入提示词。
复拦率（同签名二次拦截占比）度量免疫是否真的生效（目标 ≥60%）。
"""
import json
import os
import re
import time

_STOP_CHARS = "的了在是我你有和与及或对为到把被这那也要不了又在"


def _tokens(context: str) -> set:
    """上下文 → 特征 token 集：ASCII 词 + CJK 二元组（免分词可交集）。"""
    text = re.sub(r"[\W_]+", "", context.lower())
    text = text.translate(str.maketrans("", "", _STOP_CHARS))
    tokens = set(re.findall(r"[a-z0-9]+", text))
    cjk = re.findall(r"[一-鿿]", text)
    tokens |= {a + b for a, b in zip(cjk, cjk[1:], strict=False)}
    return tokens


def _signature(context: str) -> str:
    """上下文 → 归一化签名（token 排序拼接，可序列化）。"""
    return " ".join(sorted(_tokens(context)))


class ImmuneSystem:
    """纠正免疫库：learn/check/inject/stats/monthly_report。"""

    def __init__(self, json_path: str, now_fn=time.time):
        self._path = json_path
        self._now = now_fn
        parent = os.path.dirname(os.path.abspath(json_path))
        os.makedirs(parent, exist_ok=True)
        try:
            with open(self._path, encoding="utf-8") as fh:
                self._rules = json.load(fh).get("rules", [])
        except (OSError, ValueError):
            self._rules = []

    def _save(self) -> None:
        with open(self._path, "w", encoding="utf-8") as fh:
            json.dump({"rules": self._rules}, fh, ensure_ascii=False, indent=1)

    def learn(self, context: str, wrong: str, right: str) -> dict:
        """一次纠正 → 一条抗体（同签名合并，intercepts 计数）。"""
        sig = _signature(context)
        for rule in self._rules:
            if rule["signature"] == sig:
                rule.update({"wrong": wrong, "right": right,
                             "updated": self._now()})
                self._save()
                return rule
        rule = {"signature": sig, "wrong": wrong, "right": right,
                "created": self._now(), "intercepts": 0}
        self._rules.append(rule)
        self._save()
        return rule

    def check(self, context: str) -> dict | None:
        """生成前拦截：token 集有交集（任一 bigram/词命中）即命中抗体。"""
        tokens = _tokens(context)
        if not tokens:
            return None
        best = None
        for rule in self._rules:
            rule_tokens = set(rule["signature"].split())
            if rule_tokens & tokens:
                best = rule
        if best is not None:
            best["intercepts"] = best.get("intercepts", 0) + 1
            self._save()
        return best

    def inject(self, context: str) -> str:
        """命中的抗体 → 提示词注入后缀。"""
        rule = self.check(context)
        if not rule:
            return ""
        return (f"\n[免疫提醒] 此前在此类任务犯过：{rule['wrong']}；"
                f"正确姿势：{rule['right']}")

    def rules(self) -> list:
        return list(self._rules)

    def stats(self) -> dict:
        total = len(self._rules)
        touched = [r for r in self._rules if r.get("intercepts", 0) >= 1]
        reblocked = [r for r in self._rules if r.get("intercepts", 0) >= 2]
        rate = round(len(reblocked) / len(touched), 2) if touched else 0.0
        return {"rules": total, "touched_rules": len(touched),
                "reblocked_rules": len(reblocked), "reblock_rate": rate}

    def monthly_report(self) -> str:
        s = self.stats()
        top = sorted(self._rules, key=lambda r: -r.get("intercepts", 0))[:5]
        lines = [f"本月免疫报告：{s['rules']} 条免疫规则，"
                 f"复拦率 {s['reblock_rate']:.0%}"]
        for r in top:
            lines.append(f"- {r['signature']}：拦 {r.get('intercepts', 0)} 次"
                         f"（{r['wrong']} → {r['right']}）")
        return "\n".join(lines)
