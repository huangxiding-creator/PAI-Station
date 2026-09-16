"""L0 枚举层：Everything(es.exe) 优先 → 并行遍历兜底。

es.exe 是 Windows 文件索引事实标准协议（goz/Flow-Launcher 同款），
在位即享 MFT+USN 毫秒级枚举；缺席自动降级 os.scandir 并行遍历
（只读操作，线程并行安全）。两后端同产 records：
[{path, size, mtime, secret}]——secret 由域红线判定，均不读内容。

实证坑（09-16 真机验证）：
- es.exe 管道输出走 ANSI 代码页（中文机=GBK），UTF-8 解码会把中文
  路径变乱码被静默丢弃——必须 mbcs 解码（GBK 显示层假象同源）。
- 路径过滤必须用 `-path <root>` 旗标形式；内联 `path:C:\\...` 会被
  盘符冒号截断解析，整根查空。
- `-csv -size -date-modified -date-format 5` 让 es 直接吐原始字节 +
  ISO-8601 全精度时间列，省掉每文件两次 os.stat（29 万文件级关键）。
- 双后端 mtime 一律归一为整秒（ISO 列 vs st.st_mtime 的浮点尾数
  对不齐，后端切换会引发全量误判「已变更」；亚秒级变更由
  size/hash 阶梯兜底）。
"""
from __future__ import annotations

import csv
import logging
import os
import shutil
import subprocess
import sys
from concurrent.futures import ThreadPoolExecutor
from datetime import datetime

from paistation.sense.localfiles.domain import ScanDomain

_log = logging.getLogger("paistation.sense.localfiles.walk")

NO_WINDOW = 0x08000000 if sys.platform == "win32" else 0  # CREATE_NO_WINDOW
ES_FALLBACKS = (r"C:\Program Files\Everything\es.exe",
                r"C:\Program Files (x86)\Everything\es.exe")


def _run(cmd: list[str], timeout: float = 120.0) -> str:
    """真实子进程执行器（测试可注入 fake runner）。"""
    enc = "mbcs" if sys.platform == "win32" else "utf-8"
    proc = subprocess.run(
        cmd, capture_output=True, text=True, encoding=enc, errors="replace",
        timeout=timeout, creationflags=NO_WINDOW)
    if proc.returncode != 0:
        raise RuntimeError(f"es.exe 退出码 {proc.returncode}: {proc.stderr[:200]}")
    return proc.stdout


def _parse_es_mtime(s: str) -> int:
    """ISO-8601 全精度（2026-06-20T13:34:58.5288214）→ 整秒 epoch。"""
    try:
        return int(datetime.fromisoformat(s.split(".")[0]).timestamp())
    except ValueError:
        return 0


def _parse_es_csv(out: str, domain: ScanDomain) -> list[dict]:
    """解析 es CSV：`"路径",字节整数,ISO时间`；表头行 int() 失败自然跳过。

    按路径去重：GBK 外码位会被 es 替换成 `?`，多个不同坏名文件可能
    塌缩成同一 `?` 串（真机实证 QQ 表情/爬虫目录 29 处）——重复行
    留一条即可（此类路径后续提取 open() 失败自然进 failed）。
    """
    records: dict[str, dict] = {}
    for row in csv.reader(out.splitlines()):
        if len(row) != 3:
            continue
        path, size_s, dm_s = row[0].strip(), row[1].strip(), row[2].strip()
        try:
            size = int(size_s)
        except ValueError:  # 表头（Filename,Size,Date Modified）等非数据行
            continue
        if not path or path in records or not domain.covers(path):
            continue
        records[path] = {"path": path, "size": size,
                         "mtime": _parse_es_mtime(dm_s),
                         "secret": int(domain.is_secret(path))}
    return list(records.values())


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
        """逐根 `es.exe -csv -size -dm -path root file:`；列直取零 stat。"""
        records: list[dict] = []
        for root in domain.existing_roots():
            out = self._runner(
                [self._es, "-n", str(limit), "-csv", "-size",
                 "-date-modified", "-date-format", "5", "-path", root, "file:"])
            records.extend(_parse_es_csv(out, domain))
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
                                        "mtime": int(st.st_mtime),
                                        "secret": int(domain.is_secret(entry.path)),
                                    })
                        except OSError:  # 单项失败不阻塞推进
                            continue
            except OSError as exc:
                _log.debug("目录不可读跳过 %s: %s", cur, exc)
        return out


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
