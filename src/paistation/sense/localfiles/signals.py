"""L3 信号层：路径/时间簇/命名模式/TODO 语法 → 画像与任务线索。

调研铁律（paperless/organize/ActivityWatch 共识）：路径、文件名、
修改时间簇是与内容同权的零成本信号，冷启动阶段比内容更可靠。
语义型任务标签统计分类器学不会（paperless Auto 实证）——TODO
扫描走规则正则，LLM 语义标签留给 P3 金标准驱动阶段。
输出只进台账不动原文件（写回三档模式 P4 再议）。
"""
from __future__ import annotations

import logging
import re
import time
from collections import Counter
from dataclasses import dataclass, field

_log = logging.getLogger("paistation.sense.localfiles.signals")

ACTIVE_WINDOW_DAYS = 30
TOP_DIRS = 10

_NAME_PATTERNS = {
    "dated": re.compile(r"(20\d{2}[-_.]?\d{1,2}[-_.]?\d{1,2})"),
    "versioned": re.compile(r"[vV]\d+(\.\d+)+|\d+\.\d+版|第?\d+版"),
    "final": re.compile(r"final|最终版|定稿|终稿|正式版", re.I),
    "copy": re.compile(r"副本|copy|\(\d\)$", re.I),
    "draft": re.compile(r"draft|草稿|待定|tmp|临时", re.I),
}
TODO_PATTERNS = (
    re.compile(r"^\s*[-*]\s*\[ \]\s*(.+)"),           # markdown checkbox
    re.compile(r"^(?:TODO|待办|待处理|待回复)[:：\s]+(.+)", re.I | re.M),
)


@dataclass
class SignalReport:
    """一轮信号分析的产物（只读结论，绝不写回原文件）。"""
    active_dirs: list[tuple[str, int]] = field(default_factory=list)
    kind_distribution: list[tuple[str, int]] = field(default_factory=list)
    name_pattern_counts: dict[str, int] = field(default_factory=dict)
    todos: list[dict] = field(default_factory=list)
    total_alive: int = 0

    def to_profile_md(self, title: str = "LOCAL_FILES_PROFILE") -> str:
        """画像档案（P4：SELF_PROFILE/local_files/ 同规格 markdown）。"""
        lines = [f"# {title}", "",
                 f"- 存活文件总数：{self.total_alive}"]
        if self.active_dirs:
            lines += ["", "## 活跃目录（近 30 天修改密度 Top10）"]
            lines += [f"- {d}：{n} 次变更" for d, n in self.active_dirs]
        if self.kind_distribution:
            lines += ["", "## 文件类型分布"]
            lines += [f"- {k}：{n}" for k, n in self.kind_distribution[:10]]
        if self.name_pattern_counts:
            lines += ["", "## 命名模式信号"]
            lines += [f"- {k}：{n} 个文件" for k, n
                      in self.name_pattern_counts.items() if n]
        if self.todos:
            lines += ["", f"## 待办线索（{len(self.todos)} 条，规则抽取）"]
            for t in self.todos[:50]:
                lines.append(f"- [{t['path']}] {t['text'][:80]}")
        lines.append("")
        return "\n".join(lines)


class SignalAnalyzer:
    """从清单库+chunk 库抽信号（只读查询，零文件系统访问）。"""

    def __init__(self, inventory, chunks=None, now: float | None = None):
        self._inv = inventory
        self._chunks = chunks
        self._now = time.time() if now is None else now

    def analyze(self) -> SignalReport:
        report = SignalReport()
        rows = self._inv._db.execute(
            "SELECT path, kind, mtime FROM files WHERE status!='gone'").fetchall()
        report.total_alive = len(rows)
        report.kind_distribution = self._kind_dist(rows)
        report.active_dirs = self._active_dirs(rows)
        report.name_pattern_counts = self._name_patterns(rows)
        if self._chunks is not None:
            report.todos = self._todos()
        return report

    # ---------- 各信号源 ----------

    @staticmethod
    def _kind_dist(rows) -> list[tuple[str, int]]:
        return Counter(r["kind"] or "unknown" for r in rows).most_common()

    def _active_dirs(self, rows, top: int = TOP_DIRS) -> list[tuple[str, int]]:
        cutoff = self._now - ACTIVE_WINDOW_DAYS * 86400
        counter = Counter()
        for r in rows:
            if r["mtime"] >= cutoff:
                counter[r["path"].replace("\\", "/").rsplit("/", 1)[0]] += 1
        return counter.most_common(top)

    @staticmethod
    def _name_patterns(rows) -> dict[str, int]:
        counts = {name: 0 for name in _NAME_PATTERNS}
        for r in rows:
            name = r["path"].replace("\\", "/").rsplit("/", 1)[-1].lower()
            for pname, pattern in _NAME_PATTERNS.items():
                if pattern.search(name):
                    counts[pname] += 1
        return counts

    def _todos(self) -> list[dict]:
        """文档内任务语法扫描（dataview TASK 思路，正则版）。"""
        todos = []
        try:
            rows = self._chunks._db.execute(
                "SELECT path, seq, text FROM chunks").fetchall()
        except Exception:
            return todos
        for r in rows:
            for line in r["text"].splitlines():
                for pattern in TODO_PATTERNS:
                    m = pattern.search(line)
                    if m and m.group(1).strip():
                        todos.append({"path": r["path"], "seq": r["seq"],
                                      "text": m.group(1).strip()})
                        break
        todos.sort(key=lambda t: t["path"])
        return todos
