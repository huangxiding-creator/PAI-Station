# -*- coding: utf-8 -*-
"""传输引擎（W4）：上传三段 + 下载多线程。

上传：precreate 试秒传（return_type=2 零传输）→ 未命中 superfile2 分片并发（≤8，
数据面不计控制面节流间隔）→ create 收尾。断点续传：<local>.bdn_upload_state.json
记录 uploadid+已完成分片，进程重启后跳过已传分片（幂等；uploadid 失效自动重走 precreate）。

下载：metas?dlink=1 拿直链（dlink 请求用浏览器 UA——蓝本坑位：netdisk UA 得 118 字节
错误页）→ Range 多线程（≤8，分片 4MB——CT11 节点有界 Range ≤5MB 红线）→
断点续传 <local>.bdn_dl_state.json → 完成后 md5 校验。

纯逻辑（分块数学/md5/状态文件）可离线单测：poster/fetcher 可注入。
"""
from __future__ import annotations

import hashlib
import json
import os
import threading
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

import requests

from .errors import BdnCircuitOpen, BdnError, CIRCUIT_ERRNOS
from .session import _backoff_sleep

SLICE_MD5_SIZE = 256 * 1024          # 蓝本 SliceMD5Size（upload.go:26）
BLOCK_MIN = 4 * 1024 * 1024          # 4MB（默认）
BLOCK_MID = 16 * 1024 * 1024         # >8GB
BLOCK_MAX = 64 * 1024 * 1024         # >32GB（注意不是 32MB）
MAX_WORKERS = 8                      # 数据面并发红线
DL_CHUNK = 4 * 1024 * 1024           # 下载分片：CT11 有界 Range ≤5MB → 4MB 安全位
DEFAULT_UPLOAD_HOST = "https://d.pcs.baidu.com"   # bdpan 直用（STATIC_NETBASE）
# superfile2 实测 1029（judge 勘误后口径）：缺参（path 未双放/缺 vip/web/app_id）→ 400/31023；
# 全参放行、UA 腿无关（V5 命中系全参+CEF 恰同现；judge native UA 全参重放=200）。详 ERRATA_1029.md
CEF_UA = ("Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 "
          "(KHTML, like Gecko) baidunetdisk/8.2.5 Chrome/108.0.5359.215 "
          "Electron/22.3.27 Safari/537.36;netdisk;8.2.5.103;PC;PC-Windows;"
          "10.0.19045;WindowsBaiduYunGuanJia")
BROWSER_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
              "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")
DATA_TIMEOUT = (10, 300)             # 数据面（connect, read）
PART_ATTEMPTS = 3                    # 单分片/单块传输重试（含首发）


class BdnTransferError(BdnError):
    """传输引擎错误（md5 校验失败/分片响应异常等）。退出码 1。"""
    exit_code = 1


# ---------------- 纯逻辑：分块 / md5 ----------------

def choose_block_size(size: int) -> int:
    """动态分块（蓝本阈值 upload.go:30-32）：≤8GB→4MB，≤32GB→16MB，更大→64MB。"""
    if size <= 8 * 2 ** 30:
        return BLOCK_MIN
    if size <= 32 * 2 ** 30:
        return BLOCK_MID
    return BLOCK_MAX


def block_ranges(size: int, block_size: int) -> list:
    """[(idx, offset, length)]；size=0 → []（空文件上传走整文件单块由调用方处理）。"""
    out, off, idx = [], 0, 0
    while off < size:
        n = min(block_size, size - off)
        out.append((idx, off, n))
        off += n
        idx += 1
    return out


def md5_file(path: str, chunk: int = 4 * 1024 * 1024) -> str:
    h = hashlib.md5()
    with open(path, "rb") as f:
        while True:
            b = f.read(chunk)
            if not b:
                break
            h.update(b)
    return h.hexdigest()


def slice_md5_file(path: str) -> str:
    """slice-md5 = 前 256KB 的 md5（蓝本口径；<256KB 时=整文件 md5）。"""
    with open(path, "rb") as f:
        head = f.read(SLICE_MD5_SIZE)
    return hashlib.md5(head).hexdigest()


def block_md5s(path: str, ranges: list) -> list:
    """逐块 md5（block_list 的内容，顺序=分片序号）。"""
    out = []
    with open(path, "rb") as f:
        for _, off, n in ranges:
            f.seek(off)
            data = f.read(n)
            if len(data) != n:
                raise BdnTransferError(f"读块不完整 off={off} want={n} got={len(data)}")
            out.append(hashlib.md5(data).hexdigest())
    return out


# ---------------- 状态文件 ----------------

def _save_json_atomic(path: str, obj: dict):
    tmp = path + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False)
    os.replace(tmp, path)


def _load_json(path: str):
    try:
        with open(path, "r", encoding="utf-8") as f:
            return json.load(f)
    except (OSError, ValueError):
        return None


def _looks_hex32(s: str) -> bool:
    return (len(s) == 32
            and all(c in "0123456789abcdef" for c in s.lower()))


# ---------------- 上传引擎 ----------------

class UploadEngine:
    def __init__(self, api, workers: int = MAX_WORKERS, poster=None):
        """api=BdnApi；poster 可注入（离线单测）：fn(url, params, data, files, headers) -> dict。"""
        self.api = api
        self.workers = max(1, min(int(workers), MAX_WORKERS))
        self._poster = poster or self._real_post
        self._host = None
        self._lock = threading.Lock()
        self.bytes_sent = 0          # 本次运行发出的数据面字节（分片体）
        self.data_requests = 0       # 数据面请求数（superfile2）

    # ---- 数据面传输 ----

    def _real_post(self, url, params, data, files, headers):
        r = requests.post(url, params=params, data=data, files=files,
                          headers=headers, timeout=DATA_TIMEOUT)
        if r.status_code >= 500:
            raise requests.HTTPError(f"HTTP {r.status_code}")
        try:
            return r.json()
        except ValueError:
            raise BdnTransferError(f"superfile2 非 JSON 响应（HTTP {r.status_code}）")

    def _upload_host(self) -> str:
        if self._host:
            return self._host
        try:
            servers = (self.api.locate_upload().get("servers") or [])
            self._host = servers[0] if servers else DEFAULT_UPLOAD_HOST
        except BdnError:
            self._host = DEFAULT_UPLOAD_HOST      # 定位失败用 bdpan 直用默认 host
        return self._host

    def _post_part(self, uploadid: str, partseq: int, blob: bytes,
                   remote_path: str, fname: str) -> dict:
        """一片 superfile2（全参形态：vip/web/app_id + path 双放；UA 任一腿可用——1029 勘误）。
        失败信使是 error_code（pcs 族）或 errno（xpan 族）——两者都查。
        熔断码→trip 全停。"""
        url = self._upload_host() + "/rest/2.0/pcs/superfile2"
        params = {"method": "upload", "type": "tmpfile", "uploadid": uploadid,
                  "partseq": partseq, "vip": 2, "web": 1, "app_id": 250528,
                  "path": remote_path}
        headers = {"Cookie": self.api.s.cookie_header(),
                   "User-Agent": CEF_UA}
        last_exc = None
        for attempt in range(PART_ATTEMPTS):
            self.api.s._check_circuit()
            try:
                p = self._poster(url, params, {"path": remote_path},
                                 {"file": (fname, blob)}, headers)
                errno = 0
                if isinstance(p, dict):
                    errno = p.get("errno", 0) or p.get("error_code", 0) or 0
                if errno in CIRCUIT_ERRNOS:
                    self.api.s._trip(errno)
                    raise BdnCircuitOpen(f"数据面熔断: errno={errno}", errno)
                if errno != 0:
                    raise _PartRejected(errno, p)
                return p
            except _PartRejected:
                raise                          # 业务性拒绝不重试（交给上层换 uploadid）
            except (requests.RequestException, BdnTransferError) as e:
                last_exc = e
                if attempt + 1 < PART_ATTEMPTS:
                    _backoff_sleep(1.5 * (2 ** attempt))
        raise BdnTransferError(f"分片 partseq={partseq} 重试耗尽: {last_exc}")

    # ---- 状态 ----

    @staticmethod
    def _state_path(local: str) -> str:
        return local + ".bdn_upload_state.json"

    # ---- 主流程 ----

    def upload(self, local: str, remote: str, rtype: int = 3) -> dict:
        t0 = time.perf_counter()
        sess = self.api.s
        sess._check_circuit()
        if not os.path.isfile(local):
            raise BdnTransferError(f"本地文件不存在: {local}")
        size = os.path.getsize(local)
        if size == 0:
            raise BdnTransferError("空文件不支持三段流（蓝本 EmptyContentMD5 特例，遗留）")
        mtime = int(os.path.getmtime(local))
        block_size = choose_block_size(size)
        ranges = block_ranges(size, block_size)
        fname = os.path.basename(local)

        # 全量 md5 预算（秒传与 create 都要全量 block_list）
        content_md5 = md5_file(local)
        slice_md5 = slice_md5_file(local)
        digests = block_md5s(local, ranges)

        fresh = False                      # False=允许吃断点状态；True=状态作废重走
        for _round in range(2):            # 第二轮=uploadid 失效兜底重启
            uploadid, done, resumed, base, pre = self._load_or_precreate(
                local, remote, size, content_md5, block_size, digests,
                slice_md5, rtype, mtime, fresh)
            if uploadid is None:           # 秒传成功
                return {"errno": 0, "rapid": True, "path": remote, "size": size,
                        "fs_id": pre.get("fs_id"),
                        "return_type": pre.get("return_type"),
                        "bytes_sent": 0, "data_requests": self.data_requests,
                        "blocks_total": len(ranges), "blocks_uploaded": 0,
                        "resumed": False,
                        "elapsed_s": round(time.perf_counter() - t0, 2)}
            try:
                self._upload_parts(uploadid, done, ranges, local, remote, fname,
                                   base)
            except _PartRejected as e:
                if _round == 0 and e.errno in (2, -9, 31064, 31202, 31363):
                    fresh = True           # uploadid 失效/分片错位 → 重走 precreate
                    self._clear_state(local)
                    continue
                raise BdnTransferError(f"分片被拒 errno={e.errno}: {e.payload}")
            cr = self.api.create_file(remote, size, uploadid, digests, rtype=rtype)
            self._clear_state(local)
            return {"errno": 0, "rapid": False, "path": remote, "size": size,
                    "fs_id": cr.get("fs_id"), "return_type": 1,
                    "bytes_sent": self.bytes_sent, "data_requests": self.data_requests,
                    "blocks_total": len(ranges),
                    "blocks_uploaded": len(done),
                    "resumed": resumed,
                    "uploadid": uploadid,
                    "elapsed_s": round(time.perf_counter() - t0, 2)}
        raise BdnTransferError("上传两轮均失败（uploadid 兜底重启后仍被拒）")

    def _load_or_precreate(self, local, remote, size, content_md5, block_size,
                           digests, slice_md5, rtype, mtime, fresh):
        """返回 (uploadid|None, done_set, resumed, state_base, pre_payload)。
        uploadid=None 即秒传成功（pre_payload 直接贯通给上层）。"""
        sp = self._state_path(local)
        if not fresh:
            st = _load_json(sp)
            if (st and st.get("remote") == remote and st.get("size") == size
                    and st.get("content_md5") == content_md5
                    and st.get("block_size") == block_size and st.get("uploadid")):
                done = set(int(x) for x in st.get("done") or [])
                done &= set(range(len(digests)))
                base = dict(st)
                return st["uploadid"], done, True, base, {}
        pre = self.api.precreate(remote, size, digests, content_md5, slice_md5,
                                 rtype=rtype, local_mtime=mtime)
        if pre.get("return_type") == 2:    # 秒传：零传输收尾
            return None, set(), False, {}, pre
        uploadid = pre.get("uploadid")
        if not uploadid:
            raise BdnTransferError(f"precreate 未回 uploadid: {pre}")
        need = set(int(x) for x in (pre.get("block_list") or []))
        done = set(range(len(digests))) - need
        base = {"remote": remote, "size": size, "content_md5": content_md5,
                "block_size": block_size, "uploadid": uploadid, "mtime": mtime}
        base["done"] = sorted(done)
        _save_json_atomic(sp, base)
        return uploadid, done, False, base, pre

    def _upload_parts(self, uploadid, done, ranges, local, remote, fname,
                      state_base: dict):
        todo = [r for r in ranges if r[0] not in done]
        if not todo:
            return
        self._upload_host()               # 主线程预热 host 缓存（防并发 worker 惊群 8 发）
        idx_map = {r[0]: r for r in ranges}

        def work(seq):
            _, off, n = idx_map[seq]
            with open(local, "rb") as f:
                f.seek(off)
                blob = f.read(n)
            if len(blob) != n:
                raise BdnTransferError(f"读块不完整 partseq={seq}")
            self._post_part(uploadid, seq, blob, remote, fname)
            with self._lock:
                done.add(seq)
                self.bytes_sent += n
                self.data_requests += 1
                st = dict(state_base)
                st["done"] = sorted(done)
                _save_json_atomic(self._state_path(local), st)
            return seq

        with ThreadPoolExecutor(max_workers=self.workers) as pool:
            futs = {pool.submit(work, seq): seq for seq in (r[0] for r in todo)}
            for fut in as_completed(futs):
                fut.result()               # 异常向上冒泡（含熔断）

    def _clear_state(self, local: str):
        try:
            os.remove(self._state_path(local))
        except OSError:
            pass


class _PartRejected(Exception):
    def __init__(self, errno, payload):
        self.errno = errno
        self.payload = payload
        super().__init__(f"superfile2 拒绝 errno={errno}")


# ---------------- 下载引擎 ----------------

class DownloadEngine:
    def __init__(self, api, workers: int = MAX_WORKERS, chunk: int = DL_CHUNK,
                 fetcher=None):
        """fetcher 可注入（离线单测）：fn(url, start, end, headers) -> (status, bytes)。"""
        self.api = api
        self.workers = max(1, min(int(workers), MAX_WORKERS))
        self.chunk = int(chunk)
        self._fetcher = fetcher or self._real_fetch
        self._lock = threading.Lock()
        self.bytes_received = 0
        self.data_requests = 0

    def _real_fetch(self, url, start, end, headers):
        h = dict(headers)
        h["Range"] = f"bytes={start}-{end}"
        r = requests.get(url, headers=h, timeout=DATA_TIMEOUT, allow_redirects=True)
        return r.status_code, r.content

    @staticmethod
    def _state_path(local: str) -> str:
        return local + ".bdn_dl_state.json"

    def download(self, remote: str, local: str, expected_md5: str | None = None) -> dict:
        t0 = time.perf_counter()
        self.api.s._check_circuit()
        meta = self.api.meta_by_path(remote, dlink=1)
        dlink = meta.get("dlink")
        total = int(meta.get("size") or 0)
        if not dlink:
            raise BdnTransferError(f"metas 未返回 dlink（source={meta.get('_meta_source')}）")
        want_md5 = (expected_md5 or meta.get("md5") or "").lower() or None
        if want_md5 and not _looks_hex32(want_md5):
            # 百度对部分上传文件的 md5 做混淆（含非 hex 字符，实测 1029）→ 不作硬比对
            want_md5 = None

        sp = self._state_path(local)
        st = _load_json(sp)
        ranges = block_ranges(total, self.chunk)
        all_ids = {r[0] for r in ranges}
        if (st and st.get("remote") == remote and st.get("total") == total
                and st.get("chunk") == self.chunk and os.path.exists(local)):
            done = set(int(x) for x in st.get("done") or []) & all_ids
        else:
            done = set()
            # 预占位（稀疏文件）
            with open(local, "wb") as f:
                if total > 0:
                    f.seek(total - 1)
                    f.write(b"\0")
            _save_json_atomic(sp, {"remote": remote, "total": total,
                                   "chunk": self.chunk, "done": [],
                                   "md5": want_md5})
        idx_map = {r[0]: r for r in ranges}
        todo = [i for i in sorted(all_ids) if i not in done]
        headers = {"Cookie": self.api.s.cookie_header(),
                   "User-Agent": BROWSER_UA,     # 蓝本坑位：web dlink 必须浏览器 UA
                   "Referer": "https://pan.baidu.com/disk/main"}

        def work(seq):
            _, off, n = idx_map[seq]
            last_exc = None
            for attempt in range(PART_ATTEMPTS):
                self.api.s._check_circuit()
                try:
                    status, body = self._fetcher(dlink, off, off + n - 1, headers)
                    if status in (200, 206) and len(body) == n:
                        break
                    last_exc = BdnTransferError(
                        f"块 seq={seq} 响应异常 status={status} len={len(body)} want={n}")
                except requests.RequestException as e:
                    last_exc = e
                if attempt + 1 < PART_ATTEMPTS:
                    _backoff_sleep(1.5 * (2 ** attempt))
            else:
                raise BdnTransferError(f"块 seq={seq} 重试耗尽: {last_exc}")
            with open(local, "r+b") as f:
                f.seek(off)
                f.write(body)
            with self._lock:
                done.add(seq)
                self.bytes_received += n
                self.data_requests += 1
                st_now = _load_json(sp) or {}
                st_now.update({"remote": remote, "total": total,
                               "chunk": self.chunk, "done": sorted(done),
                               "md5": want_md5})
                _save_json_atomic(sp, st_now)
            return seq

        with ThreadPoolExecutor(max_workers=self.workers) as pool:
            futs = [pool.submit(work, seq) for seq in todo]
            for fut in as_completed(futs):
                fut.result()

        md5_ok = None
        if want_md5:
            got = md5_file(local)
            md5_ok = got == want_md5
            if not md5_ok:
                raise BdnTransferError(
                    f"md5 校验失败: 远端={want_md5} 本地={got}（local={local}）")
        try:
            os.remove(sp)
        except OSError:
            pass
        elapsed = time.perf_counter() - t0
        return {"errno": 0, "path": remote, "local": local, "size": total,
                "chunks_total": len(ranges), "chunks_this_run": len(todo),
                "resumed": len(done) - len(todo) > 0,
                "bytes_received": self.bytes_received,
                "data_requests": self.data_requests,
                "md5_ok": md5_ok, "md5": want_md5,
                "elapsed_s": round(elapsed, 2),
                "speed_mb_s": round(self.bytes_received / elapsed / 2 ** 20, 2)
                if elapsed > 0 else None}
