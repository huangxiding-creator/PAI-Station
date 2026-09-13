"""M5.1 用户画像模型（06 卷）：五层+双时间线+四操作。

画像本体=带生命周期的结构化条目（向量只做检索，不做画像）：
- 五层：identity 身份事实/preference 偏好风格/knowledge 领域知识/
  workflow 做事流程/achievement 成果库
- 双时间线（Zep 式）：事实变化不删旧条目，写 effective_to 封口——
  "2023 年常驻北京→2026 常驻上海"全程可溯，防画像僵化也防失忆
- 四操作：record/expire/query/history
"""
from __future__ import annotations

import hashlib
import json
import os
from dataclasses import asdict, dataclass
from datetime import datetime
from pathlib import Path

LAYERS = ("identity", "preference", "knowledge", "workflow", "achievement")


@dataclass
class ProfileEntry:
    id: str
    layer: str
    key: str
    value: str
    confidence: float = 0.7
    source: str = ""                 # 证据指针（事件 ts 等）
    effective_from: str = ""
    effective_to: str | None = None  # None=当前有效
    created_at: str = ""

    @property
    def active(self) -> bool:
        return self.effective_to is None


class ProfileModel:
    def __init__(self, data_dir: str | Path, clock=None):
        self._clock = clock or datetime.now
        self._path = Path(data_dir) / "profile" / "entries.jsonl"
        self._entries: list[ProfileEntry] = []
        if self._path.is_file():
            try:
                for line in self._path.read_text(encoding="utf-8").splitlines():
                    if line.strip():
                        self._entries.append(ProfileEntry(**json.loads(line)))
            except (OSError, ValueError, TypeError):
                self._entries = []

    # ---- 四操作 ----

    def record(self, layer: str, key: str, value: str,
               confidence: float = 0.7, source: str = "") -> ProfileEntry:
        now = self._clock().isoformat(timespec="milliseconds")
        dup = None
        for e in self._entries:
            if (e.active and e.layer == layer and e.key == key
                    and e.value == value):
                return e                          # 同值幂等
            if e.active and e.layer == layer and e.key == key:
                dup = e
        if dup is not None:
            dup.effective_to = now                # 双时间线：旧事实封口
        eid = hashlib.sha1(f"{layer}|{key}|{value}".encode()
                           ).hexdigest()[:10]
        entry = ProfileEntry(id=eid, layer=layer, key=key, value=value,
                             confidence=confidence, source=source,
                             effective_from=now, created_at=now)
        self._entries.append(entry)
        self._save()
        return entry

    def expire(self, entry_id: str) -> None:
        for e in self._entries:
            if e.id == entry_id and e.active:
                e.effective_to = self._clock().isoformat(timespec="milliseconds")
        self._save()

    def query(self, layer: str | None = None,
              keyword: str | None = None) -> list[ProfileEntry]:
        out = [e for e in self._entries if e.active]
        if layer:
            out = [e for e in out if e.layer == layer]
        if keyword:
            out = [e for e in out
                   if keyword in e.key or keyword in e.value]
        return out

    def history(self, key: str, layer: str | None = None) -> list[ProfileEntry]:
        out = [e for e in self._entries if e.key == key]
        if layer:
            out = [e for e in out if e.layer == layer]
        return out

    def get(self, entry_id: str) -> ProfileEntry | None:
        return next((e for e in self._entries if e.id == entry_id), None)

    def _save(self) -> None:
        self._path.parent.mkdir(parents=True, exist_ok=True)
        tmp = self._path.with_suffix(".tmp")
        tmp.write_text(
            "\n".join(json.dumps(asdict(e), ensure_ascii=False)
                      for e in self._entries) + "\n",
            encoding="utf-8")
        os.replace(tmp, self._path)
