# -*- coding: utf-8 -*-
"""断点台账 Store（FR3.1/FR4.1 支持；SYNTHESIS 要点11；DOC88_SPEC §3 R14 / BOOK118_SPEC §2）。

统一 resume 三件套：
1. **整文件字节缓存**（doc88 ebt）：CDN 忽略 Range 头（R14，探针实测 0-63 请求回 200 全文件）
   → 断点续传不可依赖服务端；只能整文件下载 + 本地按字节复用。ebt 资产按名缓存
   （键→文件名净化 + 键 sha1 盐防净化撞名），二次请求同文件直接本地命中，幂等首写保留。
2. **token 台账**（book118）：view_token 实测跨月稳定（BOOK118_SPEC §2，2026-08 样例 token
   2026-10 仍 200）→ 按 (site, aid, project_id) 键控存取，留档 aid_encode 等字段，
   复用命中即可跳过 Playwright 首跳（NewView 指纹墙）。
3. **失败页重单**：失败页号集合 (site, doc, page) 键控，下次只拉失败页；
   页号一律 int 数值序（防 "10"<"2" 字典序坑，SYNTHESIS 要点2）。

落盘布局（base_dir 下，全部显式传入路径；单测只写 tests/fixtures/）：
    assets/            整文件字节缓存（不可变，.bin=原始字节，doc88 即 .ebt 原件）
    progress/<doc>.json  doc88 分块记录（每块实测字节数，零造假）
    tokens/<site>.json   token 台账（token/aid/project_id/附加字段/first_seen/last_used）
    failed/<site>/<doc>.json  失败页台账（页号→{fails, detail, last_fail}）

线程安全：进程内 threading.RLock（读改写全程持锁；同 base_dir 多实例经模块级锁注册表
共享同一把锁）；落盘=临时文件 + os.replace 原子替换，读者永不读到半截文件（崩溃残留
.tmp 由下次写覆盖）。跨进程不设防——引擎由 orchestrator 单进程约束。
"""
from __future__ import annotations

import hashlib
import json
import os
import re
import threading
import time

_TS_FMT = "%Y-%m-%dT%H:%M:%S"  # 与 harvest_audit 台账同格式

# 目录名（布局契约，orchestrator/适配器按此读取）
ASSETS_DIR = "assets"
PROGRESS_DIR = "progress"
TOKENS_DIR = "tokens"
FAILED_DIR = "failed"

_SAFE_CHARS = re.compile(r"[^0-9A-Za-z._=+!-]")  # enc2 名含 =/!/+：保留，其余净化为 _

_locks_guard = threading.Lock()
_locks: dict[str, threading.RLock] = {}  # base_dir(normcase) → RLock：同库多实例共锁


def _lock_for(base_dir: str) -> threading.RLock:
    """按台账库路径取进程级锁（同库实例共享，跨线程读改写串行化）。"""
    key = os.path.normcase(os.path.abspath(base_dir))
    with _locks_guard:
        lock = _locks.get(key)
        if lock is None:
            lock = threading.RLock()
            _locks[key] = lock
        return lock


def _now() -> str:
    return time.strftime(_TS_FMT, time.localtime())


def _safe_name(name: str, max_len: int = 96) -> str:
    """键→文件系统安全名：净化非法字符 + 截长（Windows 路径长约束）。"""
    safe = _SAFE_CHARS.sub("_", name.strip())[:max_len]
    if not safe or set(safe) == {"_"}:
        raise ValueError(f"名字净化后为空: {name!r}")
    return safe


def _atomic_write(path: str, data: bytes) -> None:
    """原子落盘：写临时文件+fsync 后 os.replace（读者只见完整文件）。"""
    os.makedirs(os.path.dirname(path), exist_ok=True)  # failed/<site>/ 等嵌套父目录自举
    tmp = path + ".tmp"
    with open(tmp, "wb") as f:
        f.write(data)
        f.flush()
        os.fsync(f.fileno())
    os.replace(tmp, path)


def _read_json(path: str) -> dict:
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except FileNotFoundError:
        return {}


def _norm_id(value) -> int | str:
    """aid/project_id 归一：纯数字串→int（'188244482' 与 188244482 同键），其余原样 str。"""
    text = str(value).strip()
    return int(text) if text.isdigit() else text


class Store:
    """断点台账：资产字节缓存 + token 台账 + 失败页集合（统一 resume 入口）。

    用法（doc88 下载循环，10 线程共享一个 Store 实例）：
        data = store.get_asset(ebt_name)          # 命中→零网络；miss→整文件下载
        if data is None:
            data = http_get(url)                   # CDN 忽略 Range，只能整下（R14）
            store.put_asset(ebt_name, data, doc=p_code)  # 落缓存+progress.json 分块记录
    """

    def __init__(self, base_dir: str):
        self.base_dir = os.path.abspath(str(base_dir))
        self._lock = _lock_for(self.base_dir)
        for sub in (ASSETS_DIR, PROGRESS_DIR, TOKENS_DIR, FAILED_DIR):
            os.makedirs(os.path.join(self.base_dir, sub), exist_ok=True)

    # ---- 内部路径 ----

    def _asset_path(self, key: str) -> str:
        safe = _SAFE_CHARS.sub("_", key)[:64]
        digest = hashlib.sha1(key.encode("utf-8")).hexdigest()[:12]
        return os.path.join(self.base_dir, ASSETS_DIR, f"{safe}.{digest}.bin")

    def _progress_path(self, doc: str) -> str:
        return os.path.join(self.base_dir, PROGRESS_DIR, f"{_safe_name(doc)}.json")

    def _tokens_path(self, site: str) -> str:
        return os.path.join(self.base_dir, TOKENS_DIR, f"{_safe_name(site)}.json")

    def _failed_path(self, site: str, doc: str) -> str:
        return os.path.join(self.base_dir, FAILED_DIR,
                            _safe_name(site), f"{_safe_name(doc)}.json")

    # ---- ① 资产字节缓存（doc88 ebt 整文件，R14）----

    def get_asset(self, key: str) -> bytes | None:
        """取缓存资产原始字节；未命中返回 None（resume 判据=非 None 即零网络复用）。"""
        if not key:
            raise ValueError("资产键不能为空")
        with self._lock:
            try:
                with open(self._asset_path(key), "rb") as f:
                    return f.read()
            except FileNotFoundError:
                return None

    def put_asset(self, key: str, data: bytes, *, doc: str = "") -> str:
        """落资产缓存（不可变：同名再写保留首写）+ 可选记入 doc 的 progress.json 分块记录。

        返回缓存文件路径。doc88 传 doc=p_code；分块记录 bytes=盘上实测字节数（零造假）。
        """
        if not key:
            raise ValueError("资产键不能为空")
        if not isinstance(data, (bytes, bytearray, memoryview)):
            raise TypeError(f"data 必须为 bytes 型，得到 {type(data).__name__}")
        with self._lock:
            path = self._asset_path(key)
            if not os.path.exists(path):
                _atomic_write(path, bytes(data))  # 已存在→保留首写，不重写（幂等）
            if doc:
                prog = _read_json(self._progress_path(doc))
                prog["doc"] = doc
                chunks = prog.setdefault("chunks", {})
                chunks[key] = {"bytes": os.path.getsize(path)}
                _atomic_write(self._progress_path(doc),
                              json.dumps(prog, ensure_ascii=False, sort_keys=True,
                                         indent=1).encode("utf-8"))
        return path

    # ---- ② token 台账（book118 view_token 跨月复用）----

    def put_token(self, token: str, *, site: str = "book118", aid, project_id,
                  **fields) -> None:
        """存 token（键=site|aid|project_id）。附加字段（book118: aid_encode）原样留档，
        命中即可整链免首跳。同键再存=token 轮换覆盖，first_seen 保留。"""
        if not isinstance(token, str) or not token.strip():
            raise ValueError("token 不能为空")
        for reserved in ("token", "aid", "project_id", "first_seen", "last_used"):
            if reserved in fields:
                raise ValueError(f"附加字段不得占用保留名: {reserved}")
        aid_n, pid_n = _norm_id(aid), _norm_id(project_id)
        key = f"{aid_n}|{pid_n}"
        with self._lock:
            path = self._tokens_path(site)
            tokens = _read_json(path)
            old = tokens.get(key) or {}
            rec = {"token": token, "aid": aid_n, "project_id": pid_n, **fields}
            rec["first_seen"] = old.get("first_seen") or _now()
            rec["last_used"] = _now()
            tokens[key] = rec
            _atomic_write(path, json.dumps(tokens, ensure_ascii=False,
                                           sort_keys=True, indent=1).encode("utf-8"))

    def get_token(self, *, site: str = "book118", aid, project_id) -> dict | None:
        """按键取 token 记录（含 token/aid/project_id/附加字段/时间戳）；未命中 None。

        命中即回写 last_used（复用留痕）。返回副本，调用方改坏不影响台账。
        """
        key = f"{_norm_id(aid)}|{_norm_id(project_id)}"
        with self._lock:
            path = self._tokens_path(site)
            tokens = _read_json(path)
            rec = tokens.get(key)
            if rec is None:
                return None
            rec["last_used"] = _now()
            _atomic_write(path, json.dumps(tokens, ensure_ascii=False,
                                           sort_keys=True, indent=1).encode("utf-8"))
            return dict(rec)

    # ---- ③ 失败页重单（失败页号集合，下次只拉失败页）----

    def mark_failed(self, *, site: str, doc: str, page: int, detail: str = "") -> int:
        """记一页失败（fails 计数+1，detail 留痕；空 detail 保留旧值）。返回累计失败次数。"""
        page_n = self._check_page(page)
        if not site or not doc:
            raise ValueError("site/doc 不能为空")
        with self._lock:
            path = self._failed_path(site, doc)
            data = _read_json(path)
            data["doc"] = doc
            pages = data.setdefault("pages", {})
            entry = pages.get(str(page_n)) or {}
            entry["fails"] = int(entry.get("fails", 0)) + 1
            entry["detail"] = detail or entry.get("detail", "")
            entry["last_fail"] = _now()
            pages[str(page_n)] = entry
            _atomic_write(path, json.dumps(data, ensure_ascii=False,
                                           sort_keys=True, indent=1).encode("utf-8"))
            return entry["fails"]

    def unfailed(self, *, site: str, doc: str, page: int) -> bool:
        """成功后除名一页。返回是否本在失败集合中（False=本就未失败）。"""
        page_n = self._check_page(page)
        if not site or not doc:
            raise ValueError("site/doc 不能为空")
        with self._lock:
            path = self._failed_path(site, doc)
            data = _read_json(path)
            pages = data.setdefault("pages", {})
            existed = str(page_n) in pages
            if existed:
                del pages[str(page_n)]
                _atomic_write(path, json.dumps(data, ensure_ascii=False,
                                               sort_keys=True, indent=1).encode("utf-8"))
            return existed

    def iter_failed(self, *, site: str, doc: str) -> list[int]:
        """失败页号数值升序列表（int 排序，防 "10"<"2" 字典序坑）；无失败=[]。"""
        if not site or not doc:
            raise ValueError("site/doc 不能为空")
        with self._lock:
            data = _read_json(self._failed_path(site, doc))
            return sorted(int(p) for p in data.get("pages", {}))

    @staticmethod
    def _check_page(page) -> int:
        try:
            page_n = int(page)
        except (TypeError, ValueError) as exc:
            raise ValueError(f"非法页号: {page!r}") from exc
        if page_n < 1:
            raise ValueError(f"页号必须 ≥1: {page_n}")
        return page_n
