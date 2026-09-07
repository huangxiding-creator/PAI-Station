"""PDCA 每日复盘（提案 4.2 learn）：三源数据 → Plan/Done/Check/Act 四段。

数据源：审计日志（当日 action 计数）、记忆库 stats、outbox stats。
deep 模型可选生成 Act 段洞察；不可用时规则模板兜底——复盘不因模型
故障缺席（服务 7×24 的底线：每天都要照镜子）。
"""
import json
import time

_PROMPT = (
    "以下是个人 AI 工作站的一天运行数据。请给出一句话 Act 建议"
    "（明早可执行、具体、不超过 40 字）。只输出建议本身。\n")


class DailyReview:
    """review() -> {Plan, Done, Check, Act}。"""

    def __init__(self, audit, outbox_stats: dict, store_stats: dict,
                 quiet_violations: int = 0, deep_fn=None):
        self._audit = audit
        self._outbox = outbox_stats
        self._store = store_stats
        self._quiet_violations = quiet_violations
        self._deep = deep_fn

    def _today_counts(self) -> dict[str, int]:
        cutoff = time.time() - 86400
        counts: dict[str, int] = {}
        try:
            rows = self._audit.query(limit=2000)
        except TypeError:
            rows = []
        for r in rows:
            if r.get("ts", 0) >= cutoff:
                action = r.get("action", "?")
                counts[action] = counts.get(action, 0) + 1
        return counts

    def review(self) -> dict:
        counts = self._today_counts()
        sent = self._outbox.get("today_sent", 0)
        drawer = self._outbox.get("drawer_items", 0)
        files = self._store.get("total", 0)
        denies = sum(c for a, c in counts.items() if "deny" in a)

        done = [
            f"心跳 {counts.get('heartbeat', 0)} 次（服务存活）",
            f"感知批次 {counts.get('fs.batch', 0)} 次",
            f"记忆库累计 {files} 个文档摘要",
            f"推送 {sent} 条 / 静默入抽屉 {drawer} 条",
        ]
        check = [f"越界拦截 {denies} 次（含 tool_guard.deny）",
                 f"勿扰违规 {self._quiet_violations} 次"]
        if self._quiet_violations == 0 and denies == 0:
            check.append("边界纪律：良好")
        else:
            check.append("边界纪律：需整改")

        insight = self._insight(counts, files, sent, drawer)
        return {
            "Plan": "明日目标：保持感知-记忆-推送链路心跳，画像提案过一个确认一个。",
            "Done": "；".join(done),
            "Check": "；".join(check),
            "Act": insight,
        }

    def _insight(self, counts: dict, files: int, sent: int, drawer: int) -> str:
        payload = json.dumps({"counts": counts, "files": files,
                              "pushed": sent, "drawer": drawer},
                             ensure_ascii=False)
        if self._deep is not None:
            try:
                return str(self._deep(_PROMPT + payload,
                                      reasoning=True)["text"]).strip()
            except Exception:  # noqa: BLE001 - 模型故障不挡复盘
                pass
        if drawer > sent:
            return "抽屉积压多于实发：明早优先消化抽屉，再开新扫描。"
        return "节奏健康：明日按既定计划推进，无需调整。"
