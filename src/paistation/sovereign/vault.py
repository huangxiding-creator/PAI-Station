"""主权记忆库 + 决策记忆（Phase A1）。

MemoryVault：markdown 为源、人机双读。每条=元信息行+缩进正文行：
    - [2026-09-13T10:00:00] (source: first-scan) #偏好
      用户偏好深色模式
追加式时间线（append-only）；同文同源幂等。

DecisionLedger：一决策一文件（decisions/DEC-YYYYMMDD-NN.md）。
被否方案是一等公民（obra/episodic-memory 语义：含被否决的备选与理由，
进化环不再重复提出已被否决的路线）；supersede 留链（status/superseded_by，
正文不删）；review 复盘回填（三线复盘之「回头验证」）。
"""
from __future__ import annotations

import os
import re
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path

_META_LINE = re.compile(r"^- \[([^\]]+)\](?: \(source: ([^)]*)\))?( .*)?$")
_TAG = re.compile(r"#([^\s#]+)")
_FRONT = re.compile(r"\A---\s*\n(.*?)\n---\s*\n?", re.DOTALL)
_KV = re.compile(r"^([A-Za-z_]+):\s*(.*)$")
_PLACEHOLDER = "_待回填_"


# ---- 记忆库 ----

@dataclass
class MemoryEntry:
    ts: str
    text: str
    source: str = ""
    tags: tuple[str, ...] = ()

    def render(self) -> str:
        source = f" (source: {self.source})" if self.source else ""
        tags = "".join(f" #{t}" for t in self.tags)
        head = f"- [{self.ts}]{source}{tags}\n"
        body = "\n".join(f"  {line}"
                         for line in (self.text.splitlines() or [""]))
        return f"{head}{body}\n"


def parse_memory(md: str) -> list[MemoryEntry]:
    """memory.md → 条目列表；缩进行（两空格起）归属上一个元信息行。"""
    parsed: list[dict] = []
    current: dict | None = None
    for line in md.splitlines():
        match = _META_LINE.match(line)
        if match:
            current = {"ts": match.group(1), "source": match.group(2) or "",
                       "tags": tuple(_TAG.findall(match.group(3) or "")),
                       "lines": []}
            parsed.append(current)
        elif current is not None and line.startswith("  "):
            current["lines"].append(line[2:])
    return [MemoryEntry(ts=item["ts"], text="\n".join(item["lines"]),
                        source=item["source"], tags=item["tags"])
            for item in parsed]


class MemoryVault:
    def __init__(self, vault_dir: str | Path, clock=None):
        self._clock = clock or datetime.now
        self._dir = Path(vault_dir)
        self._path = self._dir / "memory.md"

    def remember(self, text: str, source: str = "",
                 tags: tuple[str, ...] | list[str] = ()) -> MemoryEntry:
        """追加记忆（同文同源幂等），返回条目。"""
        for entry in self.entries():
            if entry.text == text and entry.source == source:
                return entry
        ts = self._clock().isoformat(timespec="seconds")
        record = MemoryEntry(ts=ts, text=text, source=source,
                             tags=tuple(tags))
        self._dir.mkdir(parents=True, exist_ok=True)
        with open(self._path, "a", encoding="utf-8") as fh:
            fh.write(record.render())
        return record

    def restore(self, entry: MemoryEntry) -> bool:
        """导入用：按原时间戳并入（幂等）。返回是否新增。"""
        for existing in self.entries():
            if existing.ts == entry.ts and existing.text == entry.text:
                return False
        self._dir.mkdir(parents=True, exist_ok=True)
        with open(self._path, "a", encoding="utf-8") as fh:
            fh.write(entry.render())
        return True

    def entries(self) -> list[MemoryEntry]:
        if not self._path.is_file():
            return []
        return parse_memory(self._path.read_text(encoding="utf-8"))

    def search(self, query: str) -> list[MemoryEntry]:
        return [e for e in self.entries()
                if query in e.text or query in e.source
                or any(query in tag for tag in e.tags)]

    def rewrite(self, entries: list[MemoryEntry]) -> None:
        """整库重渲染（遗忘/整理用；审计与遗忘日志由 protocol 层负责）。"""
        self._dir.mkdir(parents=True, exist_ok=True)
        tmp = self._path.with_suffix(".md.tmp")
        tmp.write_text("".join(e.render() for e in entries),
                       encoding="utf-8")
        os.replace(tmp, self._path)


# ---- 决策记忆 ----

@dataclass
class Decision:
    id: str
    topic: str
    status: str = "active"        # active | superseded
    supersedes: str = ""
    superseded_by: str = ""


class DecisionLedger:
    def __init__(self, decisions_dir: str | Path, clock=None):
        self._clock = clock or datetime.now
        self._dir = Path(decisions_dir)

    # ---- 读 ----

    def get(self, dec_id: str) -> Decision | None:
        path = self._dir / f"{dec_id}.md"
        if not path.is_file():
            return None
        meta, _body = self._load(path)
        return Decision(id=meta.get("id", dec_id),
                        topic=meta.get("topic", ""),
                        status=meta.get("status", "active"),
                        supersedes=meta.get("supersedes", ""),
                        superseded_by=meta.get("superseded_by", ""))

    def list_decisions(self, include_superseded: bool = False
                       ) -> list[Decision]:
        if not self._dir.is_dir():
            return []
        out = [self.get(p.stem) for p in sorted(self._dir.glob("DEC-*.md"))]
        out = [d for d in out if d is not None]
        if not include_superseded:
            out = [d for d in out if d.status == "active"]
        return out

    def _load(self, path: Path) -> tuple[dict, str]:
        raw = path.read_text(encoding="utf-8")
        match = _FRONT.match(raw)
        meta: dict[str, str] = {}
        if match:
            for line in match.group(1).splitlines():
                kv = _KV.match(line)
                if kv:
                    meta[kv.group(1)] = kv.group(2).strip()
        return meta, raw[match.end():] if match else raw

    def body(self, dec_id: str) -> str:
        """决策正文（frontmatter 之后），供审计/渲染。"""
        path = self._dir / f"{dec_id}.md"
        if not path.is_file():
            return ""
        return self._load(path)[1]

    # ---- 写 ----

    def decide(self, topic: str, chosen: str, rationale: str,
               alternatives: list[dict] | None = None, context: str = "",
               source: str = "") -> Decision:
        return self._create(topic, chosen, rationale,
                            alternatives=alternatives, context=context,
                            source=source)

    def supersede(self, old_id: str, topic: str, chosen: str, rationale: str,
                  why: str, alternatives: list[dict] | None = None,
                  context: str = "", source: str = "") -> Decision:
        old_path = self._dir / f"{old_id}.md"
        if not old_path.is_file():
            raise KeyError(f"决策不存在：{old_id}")
        old_meta, old_body = self._load(old_path)
        new = self._create(topic, chosen, rationale,
                           alternatives=alternatives, context=context,
                           source=source, supersedes=old_id, supersede_note=why)
        old_meta["status"] = "superseded"
        old_meta["superseded_by"] = new.id
        self._write_file(old_path, old_meta, old_body)
        return new

    def review(self, dec_id: str, outcome: str, evidence: str = "") -> None:
        """复盘回填：追加到「## 复盘」节（模板保证其在文末）。"""
        path = self._dir / f"{dec_id}.md"
        if not path.is_file():
            raise KeyError(f"决策不存在：{dec_id}")
        raw = path.read_text(encoding="utf-8")
        if _PLACEHOLDER in raw:
            raw = raw.replace(f"{_PLACEHOLDER}\n", "").replace(_PLACEHOLDER, "")
        ts = self._clock().isoformat(timespec="seconds")
        line = f"- [{ts}] 结论：{outcome}"
        if evidence:
            line += f"（证据：{evidence}）"
        with open(path, "a", encoding="utf-8") as fh:
            fh.write(f"{line}\n")

    # ---- 内部 ----

    def _create(self, topic: str, chosen: str, rationale: str, *,
                alternatives: list[dict] | None, context: str, source: str,
                supersedes: str = "", supersede_note: str = "") -> Decision:
        now = self._clock()
        date = now.strftime("%Y%m%d")
        self._dir.mkdir(parents=True, exist_ok=True)
        existing = len(list(self._dir.glob(f"DEC-{date}-*.md")))
        dec_id = f"DEC-{date}-{existing + 1:02d}"
        meta = {"id": dec_id, "topic": topic,
                "date": now.isoformat(timespec="seconds"),
                "status": "active", "supersedes": supersedes,
                "superseded_by": ""}
        rows = ["| 方案 | 否决理由 |", "|---|---|"]
        for alt in alternatives or []:
            rows.append(f"| {alt.get('option', '')} "
                        f"| {alt.get('why_rejected', '')} |")
        alts_block = "\n".join(rows) if alternatives else "_无记录_"
        body = [f"# 决策：{topic}", ""]
        if context:
            body += ["## 背景", context, ""]
        body += ["## 决策", chosen, "",
                 "## 被否方案", alts_block, "",
                 "## 理由", rationale, ""]
        if supersedes and supersede_note:
            body += [f"## 推翻前任（{supersedes}）", supersede_note, ""]
        if source:
            body += [f"来源：{source}", ""]
        body += ["## 复盘", _PLACEHOLDER, ""]
        self._write_file(self._dir / f"{dec_id}.md", meta, "\n".join(body))
        return Decision(id=dec_id, topic=topic, status="active",
                        supersedes=supersedes)

    @staticmethod
    def _write_file(path: Path, meta: dict, body: str) -> None:
        front = "\n".join(f"{k}: {v}" for k, v in meta.items())
        content = f"---\n{front}\n---\n\n{body}"
        if not content.endswith("\n"):
            content += "\n"
        tmp = path.with_suffix(".md.tmp")
        tmp.write_text(content, encoding="utf-8")
        os.replace(tmp, path)
