"""M2.5 文件索引器：全盘扫描→文本提取→多路由写入（mtime 水位线增量）。

扫描纪律（普适性铁律）：只读不改；目录黑名单（.git/.venv/models
等）与体积上限（512KB）先剪枝再读；二进制与非文本后缀直接跳过。
增量语义：state 记 path→mtime，mtime 未变零成本跳过，变了才重嵌。
"""
from __future__ import annotations

import json
import logging
import os
from pathlib import Path

from paistation.memory.layers import LayeredLoader

_log = logging.getLogger("paistation.memory.index")


class FileIndexer:
    IGNORE_DIRS = {".git", ".venv", "venv", "node_modules", "__pycache__",
                   ".pytest_cache", "models", ".idea", ".vscode", "dist",
                   "build", "_credentials"}
    TEXT_EXTS = {".md", ".txt", ".py", ".json", ".jsonl", ".csv", ".yaml",
                 ".yml", ".toml", ".html", ".htm", ".js", ".ts", ".log",
                 ".ps1", ".bat", ".cfg", ".ini", ".rst", ".svg"}
    MAX_FILE_BYTES = 512 * 1024
    READ_CHARS = 4000      # 每文件入索引的正文上限（L2 语义，非全文）
    BATCH = 64

    def __init__(self, routes: list, loader: LayeredLoader | None = None,
                 state_path: str | Path | None = None):
        self._routes = routes            # 须实现 upsert([(path, text)])
        self._loader = loader or LayeredLoader()
        self._state_path = Path(state_path) if state_path else None
        self._own_files: set[str] = set()   # 状态/索引自身文件永不入索引
        if self._state_path:
            self._own_files.add(str(self._state_path.resolve()))
        self._state: dict[str, float] = {}
        if self._state_path and self._state_path.is_file():
            try:
                self._state = json.loads(
                    self._state_path.read_text(encoding="utf-8"))
            except (OSError, ValueError):
                self._state = {}  # 状态坏→全量重建，不致命

    def scan(self, root: str | Path) -> dict:
        root = Path(root)
        docs: list[tuple[str, str]] = []
        scanned = 0
        skipped = 0
        for dirpath, dirnames, filenames in os.walk(root):
            dirnames[:] = [d for d in dirnames
                           if d not in self.IGNORE_DIRS
                           and not d.startswith(".git")]
            for name in filenames:
                p = Path(dirpath) / name
                key = str(p)
                if p.suffix.lower() not in self.TEXT_EXTS:
                    continue
                if key in self._own_files or str(p.resolve()) in self._own_files:
                    continue  # 索引自身产物不自举
                try:
                    st = p.stat()
                except OSError:
                    continue
                scanned += 1
                if self._state.get(key) == st.st_mtime:
                    skipped += 1
                    continue
                if st.st_size > self.MAX_FILE_BYTES:
                    continue
                text = self._loader.l2(p, max_chars=self.READ_CHARS)
                if text.strip():
                    docs.append((key, text))
                    self._state[key] = st.st_mtime
        for i in range(0, len(docs), self.BATCH):
            batch = docs[i:i + self.BATCH]
            for route in self._routes:
                try:
                    route.upsert(batch)
                except Exception as exc:  # noqa: BLE001 - 单路由写坏不连坐
                    _log.warning("路由 %s 写入失败: %s", route, exc)
        if self._state_path:
            self._state_path.write_text(
                json.dumps(self._state, ensure_ascii=False), encoding="utf-8")
        stats = {"scanned": scanned, "indexed": len(docs),
                 "skipped_unchanged": skipped}
        _log.info("索引扫描 %s: %s", root, stats)
        return stats
