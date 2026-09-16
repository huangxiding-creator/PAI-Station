"""索引编排器：L0 枚举 → 清单差分 → L1 提取（缓存阶梯）→ P2 入库。

缓存阶梯（护城河）：size+mtime 未变 → 跳过（零 IO）；变了 →
partial hash 4096B 初筛 → full hash 定案 → parser 指纹比对，命中
即复用旧提取结果只重切分。原生挂死护栏：线程池 + 单文件超时，
超时标记 failed-timeout 不阻塞批次（Tika fork 隔离的进程内平替）。
"""
from __future__ import annotations

import logging
from concurrent.futures import ThreadPoolExecutor
from concurrent.futures import TimeoutError as FutTimeout

from paistation.sense.localfiles.chunker import CHUNKER_VER, chunk_text
from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.extract import ExtractionError, extract
from paistation.sense.localfiles.inventory import Inventory, file_hashes, file_partial_hash
from paistation.sense.localfiles.store import ChunkIndex
from paistation.sense.localfiles.triage import Triage
from paistation.sense.localfiles.walk import enumerate_files

_log = logging.getLogger("paistation.sense.localfiles.indexer")

EXTRACT_TIMEOUT_S = 30.0
EXTRACT_WORKERS = 4


class Indexer:
    """一键全链路：scan() 差分 → extract_pending() 提取入库。"""

    def __init__(self, domain: ScanDomain, inventory: Inventory,
                 chunks: ChunkIndex, triage: Triage | None = None,
                 es=None):
        self._domain = domain
        self._inv = inventory
        self._chunks = chunks
        self._triage = triage or Triage()
        self._es = es
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

    def extract_pending(self, limit: int = 200) -> dict:
        rows = self._inv.pending(limit)
        done = failed = cached = 0
        head = rows[0]["priority"] if rows else None
        for row in rows:
            path = row["path"]
            kind, parser_id = self._triage.classify(path)
            if parser_id == "metadata-only":
                # 零解析路由：登记即完成，不产文本块。hash 对无文本
                # 路由没有缓存价值，大视频全量 hash 是纯 IO 浪费——
                # size+mtime 变更走 pending→重新登记（stat 级成本）
                self._inv.mark_extracted(
                    path, "metadata-only", "1", "", kind,
                    status="ok")
                cached += 1
                continue
            if self._inv.cache_hit(path, row["size"], row["mtime"],
                                   parser_id, _parser_ver(parser_id)):
                cached += 1
                continue
            outcome = self._extract_one(path, kind, parser_id, row)
            if outcome == "ok":
                done += 1
            elif outcome == "cached":
                cached += 1
            else:
                failed += 1
        return {"processed": len(rows), "extracted": done,
                "cached": cached, "failed": failed,
                "queue_priority_head": head}

    def _extract_one(self, path: str, kind: str, parser_id: str,
                     row) -> str:
        """单文件：hash 阶梯前置 → 未变零解析复活；变了才提取。"""
        # ① partial 4KB 初筛：头部已变 → 必然内容变，直接进提取
        partial = _safe_partial(path)
        if (partial and row["hash_partial"] == partial
                and row["hash_full"]):
            # ② 头部未变 → full hash 定案（touch 场景零解析复活）
            _, full = _safe_hashes(path)
            if (full and row["hash_full"] == full
                    and row["parser_id"] == parser_id
                    and row["parser_ver"] == _parser_ver(parser_id)):
                self._inv.mark_extracted(path, parser_id,
                                         _parser_ver(parser_id), full, kind,
                                         hash_partial=partial)
                return "cached"

        fut = self._pool.submit(extract, path, kind, parser_id)
        try:
            doc = fut.result(timeout=EXTRACT_TIMEOUT_S)
        except FutTimeout:
            fut.cancel()
            _log.warning("提取超时标记失败: %s", path)
            self._inv.mark_extracted(path, parser_id, "?", "", kind,
                                     status="failed")
            return "failed"
        except ExtractionError as exc:
            _log.info("提取失败（毒文件常态）: %s", exc)
            self._inv.mark_extracted(path, parser_id, "?", "", kind,
                                     status="failed")
            return "failed"

        _, full = _safe_hashes(path)
        self._inv.mark_extracted(path, doc.parser_id, doc.parser_ver,
                                 full, doc.kind, hash_partial=partial)
        embedder_ver = self._chunks.stats()["embedder"]
        texts = chunk_text(doc.text) if doc.text else []
        if texts:
            self._chunks.upsert_file(
                path, texts, f"{CHUNKER_VER}+{embedder_ver}",
                file_gen=self._inv.generation)
        return "ok"

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


def _parser_ver(parser_id: str) -> str:
    """解析器版本号（首次调用导入五库后缓存；升级自动失效提取缓存）。"""
    if not _PARSER_VERS:
        import docx
        import extract_msg
        import openpyxl
        import pptx
        import pymupdf

        _PARSER_VERS.update({
            "pymupdf": pymupdf.__version__, "python-docx": docx.__version__,
            "openpyxl": openpyxl.__version__,
            "python-pptx": pptx.__version__,
            "extract_msg": extract_msg.__version__,
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
