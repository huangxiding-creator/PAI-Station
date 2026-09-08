"""恐怖时刻与奇点宣告（提案第 25 章②"太恐怖了"工程学）。

- horror_calendar：每周"上周我还不会"——敬畏=能力斜率的可见性
- singularity_message：60 分奇点跨过时的庄重岗位交接仪式
- SingularityWatch：每域只宣告一次（协议变关系事件，不刷屏）
"""
import json
import os

_THRESHOLD = 60


def horror_calendar(first_times: list) -> str:
    """[{week, first_time}] → 恐怖时刻日历文本。"""
    lines = ["恐怖时刻日历（上周我还不会，这周我会了）："]
    for item in first_times:
        what = item.get("first_time")
        if what:
            lines.append(f"- {item.get('week', '?')}：{what}")
    if len(lines) == 1:
        lines.append("（本周无新能力——平稳周也是好周）")
    return "\n".join(lines)


def singularity_message(domain: str, score: float) -> str:
    """奇点宣告：庄重的岗位交接（协议 → 关系事件）。"""
    return (f"【奇点宣告】{domain}域自治分 {score:g}，跨过 60 分奇点。\n"
            f"从今天起，{domain}的日常执行正式移交给我——"
            "你保留判断与决策，我承担流程与产出。\n"
            "这不是功能上线，是一次交接仪式。")


class SingularityWatch:
    """各域奇点监视：首跨阈值宣告一次，落盘记忆。"""

    def __init__(self, json_path: str, threshold: float = _THRESHOLD):
        self._path = json_path
        self._threshold = threshold
        try:
            with open(self._path, encoding="utf-8") as fh:
                self._announced = json.load(fh).get("announced", {})
        except (OSError, ValueError):
            self._announced = {}

    def check_and_announce(self, domain: str, score: float,
                           now: float | None = None) -> str | None:
        """跨阈值且未宣告过 → 宣言文本；否则 None。"""
        if score < self._threshold or domain in self._announced:
            return None
        self._announced[domain] = round(float(score), 1)
        os.makedirs(os.path.dirname(os.path.abspath(self._path)), exist_ok=True)
        with open(self._path, "w", encoding="utf-8") as fh:
            json.dump({"announced": self._announced}, fh,
                      ensure_ascii=False, indent=1)
        return singularity_message(domain, score)
