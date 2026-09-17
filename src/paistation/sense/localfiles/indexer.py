"""索引编排器：L0 枚举 → 清单差分 → L1 提取（缓存阶梯）→ P2 入库。

缓存阶梯（护城河）：size+mtime 未变 → 跳过（零 IO）；变了 →
partial hash 4096B 初筛 → full hash 定案 → parser 指纹比对，命中
即复用旧提取结果只重切分。

并行收割（2026-09-17 根治单文件串行）：滚动窗口满水提交——窗口=
工人数，每个提交立即有线程开工；hash 阶梯（GIL 释放）与 pymupdf
解析在多线程下真并行。单文件超时只占用自己那个槽位（头部收割，
挂死者至多烧掉自己 30s 预算），绝不阻塞批次（Tika fork 隔离的
线程内平替）。DB 写入全在主线程收割侧——SQLite 单写者纪律。
"""
from __future__ import annotations

import logging
import multiprocessing
import time
from collections import deque
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import TimeoutError as FutTimeout

from paistation.sense.localfiles.chunker import CHUNKER_VER, chunk_text
from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.extract import ExtractionError, extract
from paistation.sense.localfiles.inventory import Inventory, file_hashes, file_partial_hash
from paistation.sense.localfiles.triage import Triage, ocr_image_eligible
from paistation.sense.localfiles.store import ChunkIndex
from paistation.sense.localfiles.walk import enumerate_files

_log = logging.getLogger("paistation.sense.localfiles.indexer")

EXTRACT_TIMEOUT_S = 30.0
PDF_TIMEOUT_MULT = 4  # PDF 预算 ×4：OCR 是真计算（0.5s/页）非挂死
EXTRACT_WORKERS = 8
PROC_WORKERS = 12
MpTimeout = multiprocessing.TimeoutError


def _job_timeout_s(kind: str) -> float:
    """kind 感知超时：扫描件 OCR 40 页×0.5s×并行争抢需 ~120s 预算。"""
    return EXTRACT_TIMEOUT_S * (PDF_TIMEOUT_MULT if kind == "pdf" else 1)


def _pv_compatible(old_pv: str, expect_pv: str) -> bool:
    """parser_ver 前缀兼容：『1.26.x+winrt-ocr1』命中期望『1.26.x』。

    OCR 兜底的产物 parser_ver 带后缀，但基础库未升级时缓存应照常
    复用（否则每轮复活/升级重扫都会全量重跑 OCR）。
    """
    return old_pv == expect_pv or old_pv.startswith(expect_pv + "+")


def _cancel(fut) -> None:
    """线程 Future 可取消；mp AsyncResult 无 cancel——静默跳过。"""
    cancel = getattr(fut, "cancel", None)
    if callable(cancel):
        try:
            cancel()
        except Exception:  # noqa: BLE001 — 取消尽力而为
            pass


class _MpFut:
    """mp ApplyResult 适配器：统一成 thread Future 的 .result(timeout)。"""

    __slots__ = ("_ar",)

    def __init__(self, ar):
        self._ar = ar

    def result(self, timeout=None):
        return self._ar.get(timeout)


class Indexer:
    """一键全链路：scan() 差分 → extract_pending() 提取入库。"""

    def __init__(self, domain: ScanDomain, inventory: Inventory,
                 chunks: ChunkIndex, triage: Triage | None = None,
                 es=None, events_queue=None):
        self._domain = domain
        self._inv = inventory
        self._chunks = chunks
        self._triage = triage or Triage()
        self._es = es
        self._events_queue = events_queue  # 秒级事件 jsonl（live_watch 产）
        self._pool = ThreadPoolExecutor(
            max_workers=EXTRACT_WORKERS, thread_name_prefix="lfextract")

    # ---------- L0 → 清单 ----------

    def scan(self) -> dict:
        records, backend = enumerate_files(self._domain, es=self._es)
        diff = self._inv.apply_scan(records)
        return {"backend": backend, "seen": len(records),
                "added": len(diff.added), "changed": len(diff.changed),
                "gone": len(diff.gone)}

    # ---------- L1 提取 → P2 入库 ----------

    def drain_events(self, limit: int = 5000) -> dict:
        """消费秒级事件队列：offset 续读 → per-path 取最新 op →
        单行 apply_event（deleted→gone；stat 失败且非 deleted 跳过
        ——瞬时文件由全量 walk 兜底）。"""
        if self._events_queue is None:
            return {}
        import json as _json
        import os as _os
        from pathlib import Path as _P

        from paistation.sense.localfiles.inventory import _norm_path
        q = _P(self._events_queue)
        if not q.exists():
            return {}
        off_file = q.with_suffix(".offset")
        prev_off = off = int(off_file.read_text()) if off_file.exists() else 0
        latest: dict[str, str] = {}
        with q.open("rb") as fh:
            fh.seek(off)
            for i, raw in enumerate(fh):
                if i >= limit:
                    break
                try:
                    ev = _json.loads(raw)
                except ValueError:
                    continue
                latest[_norm_path(ev["path"])] = ev.get("op", "modified")
                if ev.get("dest"):
                    latest[_norm_path(ev["dest"])] = "created"
                off += len(raw)
        off_file.write_text(str(off))
        stats: dict[str, int] = {}
        for path, op in latest.items():
            if op == "deleted":
                self._inv.apply_event({"path": path}, "deleted")
                stats["gone"] = stats.get("gone", 0) + 1
                continue
            try:
                st = _os.stat(path)
            except OSError:
                continue  # 瞬时文件（创建即删）——USN/全量兜底
            rec = {"path": path, "size": st.st_size,
                   "mtime": int(st.st_mtime),
                   "birthtime": int(getattr(st, "st_birthtime", st.st_ctime)),
                   "atime": int(st.st_atime),
                   "secret": int(self._domain.is_secret(path))}
            r = self._inv.apply_event(rec, op)
            stats[r] = stats.get(r, 0) + 1
        if off != prev_off or stats:
            _log.info("秒级事件消费：读 %d 行 → %s", off - prev_off, stats)
        return stats

    def extract_pending(self, limit: int = 200, workers: int | None = None,
                        engine: str = "thread") -> dict:
        rows = self._inv.pending(limit)
        done = failed = cached = 0
        head = rows[0]["priority"] if rows else None
        # 主线程预筛：零成本行（metadata-only / 缓存命中）不进池
        jobs: list[tuple] = []
        for row in rows:
            path = row["path"]
            kind, parser_id = self._triage.classify(path)
            if parser_id == "metadata-only" and ocr_image_eligible(
                    path, row["size"]):
                parser_id = "image-ocr"  # 工作证据图升 OCR 路由
            if parser_id == "metadata-only":
                # 零解析路由：登记即完成，不产文本块。hash 对无文本
                # 路由没有缓存价值，大视频全量 hash 是纯 IO 浪费——
                # size+mtime 变更走 pending→重新登记（stat 级成本）
                self._inv.mark_extracted(
                    path, "metadata-only", "1", "", kind, status="ok")
                cached += 1
            elif self._inv.cache_hit(path, row["size"], row["mtime"],
                                     parser_id, _parser_ver(parser_id)):
                cached += 1
            else:
                jobs.append((row["path"], kind, parser_id,
                             row["hash_partial"], row["hash_full"],
                             row["parser_id"], row["parser_ver"]))
        # 滚动窗口满水收割：窗口=工人数 → 提交即开工；头部收割 →
        # 挂死文件至多烧掉自己的超时预算，其余槽位照常产出。
        # 双引擎同构：thread（fut.result 兼容）/ proc（spawn 子进程
        # 真并行破 GIL——pymupdf 纯 Python 段线程加不动，16 核机
        # 生产位用 proc；池批级生命周期 + terminate 硬清场防孤儿）
        w = workers or (PROC_WORKERS if engine == "proc" else EXTRACT_WORKERS)
        embedder_ver = self._chunks.stats()["embedder"]  # 每批一次
        mp_pool = None
        if engine == "proc" and jobs:
            import multiprocessing as mp
            ctx = mp.get_context("spawn")
            mp_pool = ctx.Pool(processes=max(1, w), maxtasksperchild=200)
            submit = lambda fn, *a: _MpFut(  # noqa: E731
                mp_pool.apply_async(fn, a))
        else:
            submit = self._pool.submit
        try:
            inflight: deque = deque()  # (fut, deadline, ctx)
            ji = 0
            while ji < len(jobs) or inflight:
                while ji < len(jobs) and len(inflight) < w:
                    path, kind, parser_id, hp, hf, old_pid, old_pv = jobs[ji]
                    ji += 1
                    inflight.append((
                        submit(_extract_job, path, kind, parser_id,
                               hp, hf, old_pid, old_pv),
                        time.monotonic() + _job_timeout_s(kind),
                        (path, kind, parser_id)))
                fut, deadline, (path, kind, parser_id) = inflight[0]
                try:
                    res = fut.result(timeout=max(
                        deadline - time.monotonic(), 0.05))
                except (FutTimeout, MpTimeout):
                    _cancel(fut)
                    _log.warning("提取超时标记失败: %s", path)
                    self._inv.mark_extracted(path, parser_id, "?", "", kind,
                                             status="failed")
                    failed += 1
                except (ExtractionError, OSError) as exc:
                    _log.info("提取失败（毒文件常态）: %s", exc)
                    self._inv.mark_extracted(path, parser_id, "?", "", kind,
                                             status="failed")
                    failed += 1
                else:
                    if res["status"] == "cached":  # hash 阶梯复活
                        self._inv.mark_extracted(
                            path, res["parser_id"], res["parser_ver"],
                            res["full"], res["kind"],
                            hash_partial=res["partial"])
                        cached += 1
                    else:  # ok
                        self._inv.mark_extracted(
                            path, res["parser_id"], res["parser_ver"],
                            res["full"], res["kind"],
                            hash_partial=res["partial"])
                        if res["texts"]:
                            self._chunks.upsert_file(
                                path, res["texts"],
                                f"{CHUNKER_VER}+{embedder_ver}",
                                file_gen=self._inv.generation)
                        done += 1
                inflight.popleft()
        finally:
            if mp_pool is not None:
                mp_pool.terminate()  # 硬清场：挂死子进程不滞留不 join 卡
                mp_pool.join()
        return {"processed": len(rows), "extracted": done,
                "cached": cached, "failed": failed,
                "queue_priority_head": head}

    # ---------- 组合 ----------

    def full_cycle(self, limit: int = 200) -> dict:
        report = self.scan()
        report.update(self.extract_pending(limit))
        return report

    def status(self) -> dict:
        out = {"inventory": self._inv.stats(), "chunks": self._chunks.stats()}
        return out

    def close(self) -> None:
        self._pool.shutdown(wait=False, cancel_futures=True)
        self._inv.close()
        self._chunks.close()


_PARSER_VERS: dict[str, str] = {}


def _extract_job(path: str, kind: str, parser_id: str, row_hp: str,
                 row_hf: str, old_pid: str, old_pv: str) -> dict:
    """worker 纯函数（线程体）：hash 阶梯 + 解析 + 切分，绝不碰 DB。

    返回 {"status": "ok"/"cached", ...}；解析失败以 ExtractionError
    抛给收割侧统一记 failed。old_pid/old_pv 是行内旧指纹，供阶梯
    比对（touch 场景零解析复活）。
    """
    # ① partial 4KB 初筛：头部已变 → 必然内容变，直接进提取
    partial = _safe_partial(path)
    if (partial and row_hp == partial and row_hf):
        # ② 头部未变 → full hash 定案（touch 场景零解析复活）
        _, full = _safe_hashes(path)
        if (full and row_hf == full and old_pid == parser_id
                and _pv_compatible(old_pv, _parser_ver(parser_id))):
            return {"status": "cached", "parser_id": parser_id,
                    "parser_ver": _parser_ver(parser_id), "full": full,
                    "partial": partial, "kind": kind, "texts": None}
    doc = extract(path, kind, parser_id)
    _, full = _safe_hashes(path)
    texts = chunk_text(doc.text) if doc.text else []
    return {"status": "ok", "parser_id": doc.parser_id,
            "parser_ver": doc.parser_ver, "full": full,
            "partial": partial, "kind": doc.kind, "texts": texts}


def _parser_ver(parser_id: str) -> str:
    """解析器版本号（首次调用导入五库后缓存；升级自动失效提取缓存）。"""
    if not _PARSER_VERS:
        import docx
        import extract_msg
        import openpyxl
        import pptx
        import pymupdf

        from paistation.sense.localfiles.ocr import OCR_VER

        _PARSER_VERS.update({
            "pymupdf": pymupdf.__version__, "python-docx": docx.__version__,
            "openpyxl": openpyxl.__version__,
            "python-pptx": pptx.__version__,
            "extract_msg": extract_msg.__version__,
            "image-ocr": f"1+{OCR_VER}",
            "stdlib-email": "stdlib", "plaintext": "1", "metadata-only": "1"})
    return _PARSER_VERS.get(parser_id, "?")


def _safe_hashes(path: str) -> tuple[str, str]:
    try:
        return file_hashes(path)
    except OSError:
        return "", ""


def _safe_partial(path: str) -> str:
    try:
        return file_partial_hash(path)
    except OSError:
        return ""
