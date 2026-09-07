"""N 路自洽采样（第 26 章兵器一）：免费模型的挥霍式多数票。

能力 = 模型 × 推理时算力：对同一问题并行 N 次采样，多数票定答案，
一致率即置信度；低于阈值点燃验证环重采（verify_rounds 上限）。
免费模型重试零成本——这是付费模型用不起的打法。
"""
from collections import Counter


class EnsembleRunner:
    """client 需实现 fast() 契约；单路失败不拖垮全局。"""

    def __init__(self, client, n: int = 8, min_agreement: float = 0.6,
                 verify_rounds: int = 2):
        self._client = client
        self._n = n
        self._min = min_agreement
        self._verify_rounds = verify_rounds

    def _sample(self, prompt: str, context: str, n: int):
        answers, calls, failures = [], 0, 0
        for _ in range(n):
            calls += 1
            try:
                answers.append(self._client.fast(prompt, context)["text"].strip())
            except Exception:  # noqa: BLE001 - 单路失败（限流等）不拖垮全局
                failures += 1
        return answers, calls, failures

    def answer(self, prompt: str, context: str = "") -> dict:
        """返回 {answer, agreement, votes, calls, successes}。"""
        top, top_count, round_size, votes, calls = None, 0, 0, Counter(), 0
        for _ in range(self._verify_rounds + 1):
            answers, c, _ = self._sample(prompt, context, self._n)
            calls += c
            votes.update(answers)
            if answers:
                top = Counter(answers).most_common(1)[0][0]
                top_count = sum(1 for a in answers if a == top)
                round_size = len(answers)
                if top_count / round_size >= self._min:
                    break
        successes = sum(votes.values())
        if successes == 0:
            raise RuntimeError(f"ensemble 全部失败：n={self._n}，calls={calls}")
        return {"answer": top, "agreement": top_count / max(round_size, 1),
                "votes": dict(votes), "calls": calls, "successes": successes}
