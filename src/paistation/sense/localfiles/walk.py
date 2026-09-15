"""L0 枚举层：Everything(es.exe) 优先 → 并行遍历兜底。

es.exe 是 Windows 文件索引事实标准协议（goz/Flow-Launcher 同款），
在位即享 MFT+USN 毫秒级枚举；缺席自动降级 os.scandir 并行遍历
（只读操作，线程并行安全）。两后端同产 records：
[{path, size, mtime, secret}]——secret 由域红线判定，均不读内容。
"""
from __future__ import annotations

import logging
import os
import shutil
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor

from paistation.sense.localfiles.domain import ScanDomain

_log = logging.getLogger("paistation.sense.localfiles.walk")

NO_WINDOW = 0x08000000 if sys.platform == "win32" else 0  # CREATE_NO_WINDOW
ES_FALLBACKS = (r"C:\Program Files\Everything\es.exe",
                r"C:\Program Files (x86)\Everything\es.exe")


def _run(cmd: list[str], timeout: float = 120.0) -> str:
    """真实子进程执行器（测试可注入 fake runner）。"""
    proc = subprocess.run(
        cmd, capture_output=True, text=True, encoding="utf-8", errors="replace",
        timeout=timeout, creationflags=NO_WINDOW)
    if proc.returncode != 0:
        raise RuntimeError(f"es.exe 退出码 {proc.returncode}: {proc.stderr[:200]}")
    return proc.stdout


class EverythingEnumerator:
    """es.exe IPC 枚举：在位即用，缺席静默降级（available() 判定）。"""

    def __init__(self, es_exe: str | None = None, runner=_run):
        self._runner = runner
        if es_exe is None:
            found = shutil.which("es") or shutil.which("es.exe")
            self._es = found or next(
                (p for p in ES_FALLBACKS if os.path.isfile(p)), None)
        else:
            self._es = es_exe

    @property
    def available(self) -> bool:
        return self._es is not None

    def enumerate(self, domain: ScanDomain, limit: int = 2_000_000) -> list[dict]:
        """逐根 `es.exe -n limit -path root`；stat 补 size/mtime。"""
        records: list[dict] = []
        for root in domain.existing_roots():
            out = self._runner([self._es, "-n", str(limit), "-path", root])
            for line in out.splitlines():
                p = line.strip().strip('"')
                if p and os.path.isfile(p) and domain.covers(p):
                    records.append(_stat_record(p, domain))
        return records


class WalkerEnumerator:
    """os.scandir 并行遍历兜底：目录级线程池，排除段整树剪枝。"""

    def __init__(self, workers: int = 8):
        self._workers = workers

    def enumerate(self, domain: ScanDomain) -> list[dict]:
        roots = domain.existing_roots()
        if not roots:
            return []
        records: list[dict] = []
        with ThreadPoolExecutor(max_workers=self._workers) as pool:
            for batch in pool.map(lambda r: self._walk_root(r, domain), roots):
                records.extend(batch)
        return records

    def _walk_root(self, root: str, domain: ScanDomain) -> list[dict]:
        out: list[dict] = []
        stack = [root]
        while stack:
            cur = stack.pop()
            try:
                with os.scandir(cur) as it:
                    for entry in it:
                        try:
                            if entry.is_dir(follow_symlinks=False):
                                norm = entry.name.lower().replace("\\", "/")
                                if norm not in domain.exclude_names:
                                    stack.append(entry.path)
                            elif entry.is_file(follow_symlinks=False):
                                if domain.covers(entry.path):
                                    st = entry.stat(follow_symlinks=False)
                                    out.append({
                                        "path": entry.path,
                                        "size": st.st_size,
                                        "mtime": st.st_mtime,
                                        "secret": int(domain.is_secret(entry.path)),
                                    })
                        except OSError:  # 单项失败不阻塞推进
                            continue
            except OSError as exc:
                _log.debug("目录不可读跳过 %s: %s", cur, exc)
        return out


def _stat_record(path: str, domain: ScanDomain) -> dict:
    st = os.stat(path)
    return {"path": path, "size": st.st_size, "mtime": st.st_mtime,
            "secret": int(domain.is_secret(path))}


def enumerate_files(domain: ScanDomain,
                    es: EverythingEnumerator | None = None) -> tuple[list[dict], str]:
    """统一入口：返回 (records, backend_name)。Everything 在位即用。"""
    backend = es if es is not None else EverythingEnumerator()
    if backend.available:
        try:
            return backend.enumerate(domain), "everything"
        except Exception as exc:  # es.exe 抖动 → 降级不致命
            _log.warning("es.exe 枚举失败，降级遍历: %s", exc)
    return WalkerEnumerator().enumerate(domain), "walker"
