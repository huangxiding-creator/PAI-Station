"""L0 枚举层：walker 并行遍历优先 → Everything(es.exe) 兜底。

主次对调（2026-09-17 真机裁决，原 es 优先）：es 的 ANSI/mbcs 管道
对坏名文件必失真（`?` 假路径=open() 必炸 Errno 22 的毒文件家族真身），
walker 宽字符 API 拿真名且速度相当（34 万文件 62s）——忠实度完胜。
es 保留作 walker 整体故障时的兜底（幽灵行已由 _parse_es_csv 拒收）。
两后端同产 records：[{path, size, mtime, secret}]——secret 由域红线
判定，均不读内容。

实证坑（09-16/09-17 真机验证）：
- es.exe 管道输出走 ANSI 代码页（中文机=GBK），UTF-8 解码会把中文
  路径变乱码被静默丢弃——必须 mbcs 解码（GBK 显示层假象同源）。
- 路径过滤必须用 `-path <root>` 旗标形式；内联 `path:C:\\...` 会被
  盘符冒号截断解析，整根查空。
- `-csv -size -date-modified -date-format 5` 让 es 直接吐原始字节 +
  ISO-8601 全精度时间列，省掉每文件两次 os.stat（29 万文件级关键）。
- 双后端 mtime 一律归一为整秒（ISO 列 vs st.st_mtime 的浮点尾数
  对不齐，后端切换会引发全量误判「已变更」；亚秒级变更由
  size/hash 阶梯兜底）。
- es 的 1970 前时间戳（NTFS 零时间=1601-01-01）在 Windows 上
  .timestamp() 抛 OSError 22 而非 ValueError——_parse_es_mtime
  两类异常都吞（09-17 实锤：一票坏行炸掉整轮 43 万枚举静默降级）。
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
    """ISO-8601 全精度（2026-06-20T13:34:58.5288214）→ 整秒 epoch。

    1970 前日期（NTFS 零时间戳=1601-01-01）在 Windows 上
    .timestamp() 抛 OSError 22 而非 ValueError——必须一并吞掉归零，
    否则整轮 es 枚举静默降级 walker（09-17 真机实锤：43 万行全量
    因个别零时间戳行炸 Errno 22，连跑三次全降级）。
    """
    try:
        return int(datetime.fromisoformat(s.split(".")[0]).timestamp())
    except (ValueError, OSError):
        return 0


_NTFS_ILLEGAL = set('?*"<>|')  # es/GBK 失真产物必含；真名不可能含


def _parse_es_csv(out: str, domain: ScanDomain) -> list[dict]:
    """解析 es CSV：`"路径",字节整数,ISO时间`；表头行 int() 失败自然跳过。

    幽灵行拒收（09-17 升级裁决）：GBK 外码位会被 es 替换成 `?`，坏名
    文件（NTFS 不合法字符/坏代理对）经 mbcs 管道必失真——`?` 拼出的
    是假路径，真名叫坏代理对、只有 walker 宽字符 API 拿得到。假路径
    入库后 open() 必炸 Errno 22（毒文件家族真身），且与 walker 的
    真名行互为幽灵振荡（互相标 gone）。故含 NTFS 不合法字符的行
    一律拒收，让 walker 扫描以真名收编。
    """
    records: dict[str, dict] = {}
    for row in csv.reader(out.splitlines()):
        if len(row) not in (3, 5):  # 3=dm-only 旧形态；5=dm+dc+da
            continue
        path, size_s, dm_s = row[0].strip(), row[1].strip(), row[2].strip()
        try:
            size = int(size_s)
        except ValueError:  # 表头（Filename,Size,Date Modified）等非数据行
            continue
        if (not path or path in records or not domain.covers(path)
                or _NTFS_ILLEGAL & set(path)):
            continue
        rec = {"path": path, "size": size, "mtime": _parse_es_mtime(dm_s),
               "secret": int(domain.is_secret(path)),
               "birthtime": 0, "atime": 0}
        if len(row) == 5:  # 列序真机实证：dm, dc(创建), da(访问)
            rec["birthtime"] = _parse_es_mtime(row[3].strip())
            rec["atime"] = _parse_es_mtime(row[4].strip())
        records[path] = rec
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
                 "-date-modified", "-date-created", "-date-accessed",
                 "-date-format", "5", "-path", root, "file:"])
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
                                        # Windows st_ctype=创建（3.12+ 另有
                                        # st_birthtime，取到哪个用哪个）
                                        "birthtime": int(getattr(
                                            st, "st_birthtime", st.st_ctime)),
                                        "atime": int(st.st_atime),
                                        "secret": int(domain.is_secret(entry.path)),
                                    })
                        except OSError:  # 单项失败不阻塞推进
                            continue
            except OSError as exc:
                _log.debug("目录不可读跳过 %s: %s", cur, exc)
        return out


def enumerate_files(domain: ScanDomain,
                    es: EverythingEnumerator | None = None,
                    walker: WalkerEnumerator | None = None
                    ) -> tuple[list[dict], str]:
    """统一入口：返回 (records, backend_name)。walker 主、es 兜底。

    主次对调（2026-09-17 真机裁决）：es 的 mbcs 管道对坏名文件（坏
    代理对/NTFS 不合法字符）必失真成 `?` 假路径，而 walker 走宽字符
    API 拿真名；两者速度相当（34 万文件 62s vs ~60s），忠实度完胜——
    walker 升主，es 只在 walker 整体故障时兜底（此时幽灵行已由
    _parse_es_csv 拒收，不再污染清单）。
    """
    try:
        return (walker or WalkerEnumerator()).enumerate(domain), "walker"
    except Exception as exc:  # walker 整体故障（盘级错误）→ es 兜底
        _log.warning("walker 枚举失败，降级 es.exe: %s", exc)
    backend = es if es is not None else EverythingEnumerator()
    if backend.available:
        try:
            return backend.enumerate(domain), "everything"
        except Exception as exc:  # es.exe 也抖 → 空手而归不致命
            _log.warning("es.exe 枚举失败: %s", exc)
    return [], "none"
