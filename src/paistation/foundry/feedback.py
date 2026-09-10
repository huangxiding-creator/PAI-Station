"""反馈返钱账本 + 免疫沉淀（M7.3 / PROPOSAL_M7 §5.2）——市场环的心脏。

链路：反馈 → 三维评分（GLM fast 打分 + 规则兜底，verifier 思路）
     → 阶梯返款（>15min ¥100 · >30min ¥200 · >60min ¥400 · >70min 全退，
       质量分调制：高质满档/中质六折/低质三折——灌水拿不到钱，防刷）
     → 免疫沉淀（反馈 → 免疫规则入库 → 下一版生成时注入约束）。
灵魂连接：反馈返钱 = soul/ 错误免疫系统的商业化形态——用户替你训练印钞机，
且为训练付了对价（返款），双向公平（曾鸣智能复利的微观实现）。
"""

import datetime
import json
import os
import re

# 返款阶梯（09-09 晚转录原案）：(分钟阈值, 档位金额)，全退档特殊处理
_REFUND_LADDER: tuple[tuple[int, int], ...] = ((15, 100), (30, 200), (60, 400))
_FULL_REFUND_MINUTES = 70

# 规则兜底的评分线索（透明可解释，不藏黑盒）
_ACTION_MARKERS = ("建议", "应该", "可以", "需要补", "改为", "加上", "缺", "有误", "错")
_SPECIFIC_MARKERS = re.compile(r"\d+(\.\d+)?%?")  # 出现数字即具体性证据


def _rule_score(text: str) -> dict:
    """无 LLM 时的规则兜底评分（0-10，透明启发式）。"""
    n = len(text)
    has_personal = any(w in text for w in ("我", "我们", "读者", "用户"))
    numbers = len(_SPECIFIC_MARKERS.findall(text))
    actions = sum(1 for m in _ACTION_MARKERS if m in text)

    sincerity = min(10, 3 + n / 40 + (2 if has_personal else 0))
    specificity = min(10, 2 + numbers * 1.5 + n / 100)
    actionability = min(10, 2 + actions * 2 + n / 120)
    scores = {"sincerity": round(sincerity, 1), "specificity": round(specificity, 1),
              "actionability": round(actionability, 1)}
    scores["quality"] = round(sum(scores.values()) / 3, 1)
    return scores


def score_feedback(text: str, fast_fn=None) -> dict:
    """三维评分：真诚度/具体性/可行动性 + 综合质量分（0-10）。

    fast_fn 可选（契约同 llm.ZhipuClient.fast：fast_fn(prompt) -> {"text"}）；
    GLM 打分失败或解析失败自动落规则兜底——闭环永不断链。
    """
    if fast_fn is not None:
        try:
            payload = fast_fn(
                "请为下面的用户反馈打分（0-10 整数，各一维）：真诚度（是否真实使用过）、"
                "具体性（是否指向具体章节/问题）、可行动性（是否给出可执行的修改建议）。"
                "只输出 JSON：{\"sincerity\": n, \"specificity\": n, \"actionability\": n}\n\n"
                f"反馈：{text[:2000]}")
            obj = json.loads(re.sub(r"^```[a-zA-Z]*\s*|\s*```$", "",
                                    payload["text"].strip()))
            scores = {k: max(0, min(10, int(obj[k])))
                      for k in ("sincerity", "specificity", "actionability")}
            scores["quality"] = round(sum(scores.values()) / 3, 1)
            return scores
        except Exception as exc:  # noqa: BLE001 - 闭环永不断链：模型故障→规则兜底
            print(f"[feedback] GLM 打分失败（{type(exc).__name__}），落规则兜底",
                  flush=True)
    return _rule_score(text)


def refund_tier(minutes: float, price: int, quality: float = 8.0) -> dict:
    """阶梯返款：时长定档，质量调制（≥7 满档 / 4-7 六折 / <4 三折）。"""
    if minutes > _FULL_REFUND_MINUTES:
        base, tier = price, "全退"
    else:
        base, tier = 0, "未达返款时长"
        for threshold, amount in _REFUND_LADDER:
            if minutes > threshold:
                base, tier = amount, f"¥{amount}"
    if base == 0:
        return {"tier": tier, "amount": 0}
    factor = 1.0 if quality >= 7 else (0.6 if quality >= 4 else 0.3)
    return {"tier": tier, "amount": int(base * factor)}


def _immune_path(slug: str, ledger_dir: str) -> str:
    return os.path.join(ledger_dir, "immune", f"{slug}.json")


def deposit_immune_rule(slug: str, rule_text: str, *, quality: float,
                        ledger_dir: str, minutes: float = 0.0,
                        refund_amount: int = 0) -> str:
    """免疫沉淀：反馈提炼的规则入库 + 账本记账，返回规则文本。"""
    rule = rule_text.strip()
    path = _immune_path(slug, ledger_dir)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    rules = []
    if os.path.exists(path):
        rules = json.load(open(path, encoding="utf-8"))
    entry = {"rule": rule, "quality": quality, "date": datetime.date.today().isoformat()}
    if rule not in {r.get("rule") for r in rules}:  # 按文本去重：同一问题不重复入库
        rules = rules + [entry]  # 只增不删（宪法红线）
        json.dump(rules, open(path, "w", encoding="utf-8"), ensure_ascii=False, indent=2)

    ledger = os.path.join(ledger_dir, "feedback_ledger.jsonl")
    record = {"ts": datetime.datetime.now().isoformat(timespec="seconds"),
              "slug": slug, "minutes": minutes, "quality": quality,
              "refund_amount": refund_amount, "rule": rule}
    with open(ledger, "a", encoding="utf-8") as f:
        f.write(json.dumps(record, ensure_ascii=False) + "\n")
    return rule


def load_immune_rules(slug: str, ledger_dir: str) -> list[str]:
    """取某方案的免疫规则（注入下一版生成：reconstruct_section(immune_rules=...)）。"""
    path = _immune_path(slug, ledger_dir)
    if not os.path.exists(path):
        return []
    rules = json.load(open(path, encoding="utf-8"))
    return [r["rule"] for r in rules if r.get("quality", 0) >= 4]  # 灌水不进基因库
