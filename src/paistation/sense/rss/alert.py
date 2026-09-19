# -*- coding: utf-8 -*-
"""RSS 信息级实时告警——关键词命中即告警（纯确定性包含匹配，零网络零 LLM）。

G12：把 RSS 采集从「批处理收割」升级为「信息级实时告警」。观测层定位：
只挂在收割循环侧（每篇新文章标题 + 正文前 2k 扫描），绝不改节拍/限额。

三层出口（默认静默）：
a) alerts.jsonl 落盘（默认开，只增不删，逐条 append）；
b) 班次汇总 MD：alert_digest_YYYY-MM-DD.md（同日只一份，每班次追加段落）；
c) 企微推送：仅显式 --push-alerts 才推；每班次最多 1 条汇总；不重试。

护栏：alerts.jsonl 滚动 24h 窗口内 hit 条目上限 200（ALERT_DAILY_CAP），
超限只记一条 cap_reached 标记，不再逐条记（窗口自然滚动后自动恢复）。
"""
from __future__ import annotations

import json
import logging
import subprocess
import time
from pathlib import Path

# ── 常量（均可被 AlertEngine 参数覆盖） ────────────────────────────
ALERT_DAILY_CAP = 200        # 24h 滚动窗口内告警条目硬顶
ALERT_WINDOW_S = 24 * 3600   # 窗口宽
BODY_SCAN_CHARS = 2000       # 正文只扫前 2k（标题全量）
PUSH_TEXT_LIMIT = 500        # 企微推送截断

log = logging.getLogger("rss_alert")


def parse_keywords(spec: str) -> list[str]:
    """逗号分隔关键词串 → 去空列表；兼容中文全角逗号与空白。"""
    return [k.strip() for k in (spec or "").replace("，", ",").split(",")
            if k.strip()]


def match_keywords(title: str, body: str, keywords: list[str]) -> list[str]:
    """多词 OR 包含匹配（casefold，纯确定性）；只扫正文前 2k。

    返回按传入顺序排列的命中词（去重后），空列表 = 未命中。
    """
    hay = f"{title or ''}\n{(body or '')[:BODY_SCAN_CHARS]}".casefold()
    seen: set[str] = set()
    hits: list[str] = []
    for kw in keywords:
        k = (kw or "").strip()
        if k and k.casefold() in hay and k not in seen:
            seen.add(k)
            hits.append(k)
    return hits


class AlertEngine:
    """关键词告警引擎：jsonl 落盘 + 班次 digest + 企微汇总推送。

    观测层铁律：任何自身故障只记日志，绝不向上抛（见 harvester 接线处的
    try/except 兜底）；推送默认关、不重试、每班次至多 1 条。
    """

    def __init__(self, keywords: list[str], base: Path | None = None, *,
                 alerts_path: Path | None = None,
                 digest_dir: Path | None = None,
                 daily_cap: int = ALERT_DAILY_CAP,
                 window_s: float = ALERT_WINDOW_S,
                 runner=None):
        if not keywords:
            raise ValueError("alert keywords 不能为空（--alert-keywords 未给或全空白）")
        self.keywords = list(keywords)
        base = Path(base) if base is not None else Path(".")
        self.alerts_path = Path(alerts_path) if alerts_path is not None \
            else base / "alerts.jsonl"
        self.digest_dir = Path(digest_dir) if digest_dir is not None else base
        self.daily_cap = daily_cap
        self.window_s = window_s
        self._runner = runner  # callable(cmd:list, **kw)，默认 subprocess.run
        self._shift_hits: list[dict] = []  # 本班次已落盘命中（内存态）

    # ── jsonl 只增不删 ─────────────────────────────────────────────
    def _read_entries(self) -> list[dict]:
        try:
            lines = self.alerts_path.read_text(encoding="utf-8").splitlines()
        except OSError:
            return []
        out = []
        for ln in lines:
            ln = ln.strip()
            if not ln:
                continue
            try:
                out.append(json.loads(ln))
            except ValueError:
                continue  # 损坏行跳过，绝不因单行坏账拒读
        return out

    def _append(self, entry: dict) -> None:
        self.alerts_path.parent.mkdir(parents=True, exist_ok=True)
        with self.alerts_path.open("a", encoding="utf-8") as f:
            f.write(json.dumps(entry, ensure_ascii=False) + "\n")

    def _window_hits(self, entries: list[dict], now: float) -> int:
        horizon = now - self.window_s
        n = 0
        for e in entries:
            if e.get("type") != "hit":
                continue
            if float(e.get("epoch", 0)) >= horizon:
                n += 1
        return n

    # ── 收割循环内逐篇调用 ─────────────────────────────────────────
    def on_article(self, *, feed: str, title: str, body: str,
                   link: str = "", published: str = "",
                   path: Path | None = None, now: float | None = None) -> bool:
        """标题+正文前 2k 命中即落盘 alerts.jsonl。返回是否新记一条。

        超上限（24h 窗口 ≥ daily_cap）：只补一条 cap_reached 标记后静默丢弃
        本条及后续（窗口滚动计数回落后自动恢复逐条记录）。
        """
        hits = match_keywords(title, body, self.keywords)
        if not hits:
            return False
        now = time.time() if now is None else float(now)
        day = time.strftime("%Y-%m-%d", time.localtime(now))
        entries = self._read_entries()
        if self._window_hits(entries, now) >= self.daily_cap:
            capped_already = any(
                e.get("type") == "cap_reached"
                and float(e.get("epoch", 0)) >= now - self.window_s
                for e in entries)
            if not capped_already:  # 每 24h 窗口至多一条 cap 标记
                self._append({"type": "cap_reached", "day": day,
                              "epoch": round(now, 3),
                              "cap": self.daily_cap})
                log.warning("rss 告警 24h 上限 %d 已满：后续命中直接丢弃"
                            "（不落盘不进班次汇总），窗口滚动后自动恢复",
                            self.daily_cap)
            return False
        entry = {"type": "hit", "day": day, "epoch": round(now, 3),
                 "ts": time.strftime("%F %T", time.localtime(now)),
                 "account": feed, "title": title or "(无标题)",
                 "link": link, "published": published,
                 "keywords": hits, "file": str(path or "")}
        self._append(entry)
        self._shift_hits.append(entry)
        return True

    # ── 班次汇总：digest MD（同日一份，追加段落） ──────────────────
    def write_digest(self, now: float | None = None) -> Path | None:
        """把本班次命中清单追加为当日 digest 的一个段落。无命中不写。"""
        if not self._shift_hits:
            return None
        now = time.time() if now is None else float(now)
        day = time.strftime("%Y-%m-%d", time.localtime(now))
        path = self.digest_dir / f"alert_digest_{day}.md"
        path.parent.mkdir(parents=True, exist_ok=True)
        first = not path.exists()
        rows = ["| 时间 | 来源 | 标题 | 命中词 | 文章 |",
                "|---|---|---|---|---|"]
        for h in self._shift_hits:
            rows.append(f"| {h['ts']} | {h['account']} | {h['title']} "
                        f"| {'、'.join(h['keywords'])} | {h['file']} |")
        parts = []
        if first:
            parts.append(f"# RSS 情报告警 {day}\n")
        parts.append(f"\n## 班次 {time.strftime('%F %T', time.localtime(now))} "
                     f"命中 {len(self._shift_hits)} 条\n")
        parts.append("\n".join(rows) + "\n")
        with path.open("a", encoding="utf-8") as f:
            f.write("".join(parts))
        return path

    # ── 企微推送（默认静默；不重试；班次至多 1 条） ─────────────────
    def build_push_text(self) -> str:
        """「RSS 情报告警 N 条：标题1(命中词)|标题2…」截断 500 字。"""
        segs = [f"{h['title']}({'+'.join(h['keywords'])})"
                for h in self._shift_hits]
        text = f"RSS 情报告警 {len(self._shift_hits)} 条：" + "|".join(segs)
        return text[:PUSH_TEXT_LIMIT]

    def push_wecom(self, text: str) -> bool:
        """wecom-cli message aibot send --text；任何失败只记日志，不重试。"""
        runner = self._runner or subprocess.run
        cmd = ["wecom-cli", "message", "aibot", "send", "--text", text]
        try:
            r = runner(cmd, capture_output=True, text=True, timeout=30,
                       creationflags=getattr(subprocess, "CREATE_NO_WINDOW", 0))
        except Exception as e:  # 探不到/超时/环境异常 → 如实记日志不炸
            log.warning("wecom-cli 推送未成（不重试）: %s", e)
            return False
        if getattr(r, "returncode", 1) != 0:
            log.warning("wecom-cli 推送非零退出（不重试）: %s",
                        getattr(r, "stderr", "") or getattr(r, "returncode", "?"))
            return False
        return True

    # ── 班次收口：digest + 可选推送，各至多一次 ────────────────────
    def finalize(self, *, push: bool = False,
                 now: float | None = None) -> int:
        """班次收口：写 digest；push=True 且有命中才推 1 条汇总。返回本班次命中数。

        收口即翻篇：班次命中缓冲清零，同引擎再跑下一班次时 digest 只含
        新班次段落（每班次一条汇总的纪律由此成立）。
        """
        n = len(self._shift_hits)
        try:
            self.write_digest(now=now)
        except Exception as e:
            log.warning("digest 写入失败（忽略）: %s", e)
        if push and n:
            try:
                self.push_wecom(self.build_push_text())
            except Exception as e:  # 推送层自身异常兜底（防御，正常不触达）
                log.warning("企微推送异常（不重试）: %s", e)
        self._shift_hits = []
        return n
