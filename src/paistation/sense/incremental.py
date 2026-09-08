"""1AM 增量扫描（提案 M1 deferred）：mtime 增量兜底，补 watcher 漏报。

watchdog 只在服务运行时看得到事件——停机窗口内的文件变更会漏。
每日 01:00（先于 02:00 PDCA）静默补扫：last_run 之后的改动全量入库，
无报告不打扰（静默维护），状态原子落盘、单文件失败不阻塞推进。
首跑无状态 → 回看窗 24h（全盘首扫另有上帝时刻负责，不在此重扫）。
"""
import fnmatch
import json
import logging
import os
import time

_log = logging.getLogger("paistation.sense.incremental")

_SUFFIXES = {".md", ".txt", ".py", ".ini", ".toml", ".yaml", ".yml",
             ".json", ".csv", ".log", ".html", ".xml"}
_FIRST_WINDOW_SEC = 86400  # 首跑回看 24h


def _epoch(value) -> float:
    """epoch/struct_time/datetime 通吃 → epoch 秒（与 runtime._now 对齐）。"""
    if hasattr(value, "tm_year"):
        return time.mktime(value)
    if hasattr(value, "timestamp"):
        return value.timestamp()
    return float(value)


class IncrementalScanner:
    """watch_dirs mtime 增量 → ingest 回调 → 状态推进。"""

    def __init__(self, watch_dirs, ingest_fn, state_path: str,
                 ignore_patterns=None, suffixes=None, max_per_dir: int = 500):
        self._dirs = [os.path.expanduser(d) for d in watch_dirs]
        self._ingest = ingest_fn
        self._path = state_path
        self._ignore = [p.lower() for p in (ignore_patterns
                                            or [".git", "node_modules"])]
        self._suffixes = set(suffixes or _SUFFIXES)
        self._max_per_dir = max_per_dir

    # ---------- 状态 ----------

    def _load_state(self) -> dict:
        try:
            with open(self._path, encoding="utf-8") as fh:
                return json.load(fh)
        except (OSError, ValueError):
            return {}

    def _save_state(self, state: dict) -> None:
        tmp = self._path + ".tmp"
        parent = os.path.dirname(os.path.abspath(self._path))
        os.makedirs(parent, exist_ok=True)
        with open(tmp, "w", encoding="utf-8") as fh:
            json.dump(state, fh, ensure_ascii=False)
        os.replace(tmp, self._path)

    # ---------- 扫描 ----------

    def _hit_ignore(self, path: str) -> bool:
        norm = path.replace("\\", "/").lower()
        return any(fnmatch.fnmatch(norm, f"*{p.lower()}*") for p in self._ignore)

    def pending(self, since_ts: float) -> list:
        """mtime > since_ts 的白名单文件（纯只读，感知红线）。"""
        out: list[str] = []
        for root in self._dirs:
            if not os.path.isdir(root):
                continue
            taken = 0
            for dirpath, dirnames, filenames in os.walk(root):
                dirnames[:] = [d for d in sorted(dirnames)
                               if not self._hit_ignore(os.path.join(dirpath, d))]
                for name in sorted(filenames):
                    full = os.path.join(dirpath, name)
                    if taken >= self._max_per_dir or self._hit_ignore(full):
                        continue
                    if os.path.splitext(name)[1].lower() not in self._suffixes:
                        continue
                    try:
                        mtime = os.stat(full).st_mtime
                    except OSError:
                        continue
                    if mtime > since_ts:
                        out.append(full)
                        taken += 1
        return out

    def run(self, now_fn=time.time) -> dict:
        """一次增量补扫：找 delta → 入库（失败不挡）→ 推进状态。"""
        now = _epoch(now_fn())
        state = self._load_state()
        since = state.get("last_run")
        if not since:
            since = now - _FIRST_WINDOW_SEC
        try:
            changed = self.pending(since)
        except OSError as exc:
            _log.warning("增量扫描失败（下次再试）: %s", exc)
            return {"changed": 0, "ingested": 0, "error": str(exc)}
        ingested = 0
        if changed:
            try:
                self._ingest(changed)
                ingested = len(changed)
            except Exception as exc:  # noqa: BLE001 - 入库失败不挡状态推进
                _log.warning("增量入库失败 %d 个文件: %s", len(changed), exc)
        self._save_state({"last_run": now,
                          "runs": state.get("runs", 0) + 1,
                          "date": time.strftime("%Y-%m-%d", time.localtime(now))})
        _log.info("增量补扫：%d 变更 / %d 入库（since=%.0f）",
                  len(changed), ingested, since)
        return {"changed": len(changed), "ingested": ingested}
