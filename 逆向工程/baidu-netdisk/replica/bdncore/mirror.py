# -*- coding: utf-8 -*-
"""MirrorEngine：本地目录 → 远端增量镜像（W5）。

铁律：**远端只增不删**——本地没有而远端有的文件只进 remote_only 报告，绝不删除；
覆盖上传（rtype=3）仅发生在「远端缺文件 / 远端 size 不符 / 本地内容较上次镜像变更」
三种判定下，不产生任何删除语义。

增量模型（filediff 游标链未激活——W4 遗留，故走「本地扫描+远端对账」面）：
- 本地：os.walk 收 size+mtime；md5 走 state 缓存（size+mtime 未变→复用旧值不重哈希）；
- 远端：递归 ls 对账（api 家族，翻页护栏）；服务端 md5 混淆（漂移账 #14）不可比 →
  变更判定 = 远端缺文件 / size 不符 / 本地 md5 ≠ 上次镜像缓存；
- state 文件：<local>/.bdn_mirror_<md5(remote)[:8]>.json（恒排除出扫描；换远端目标
  即作废重建）；上传走 UploadEngine（断点续传+分片并发≤8）；
- 空文件不支持三段流（引擎限制，蓝本同款）→ 跳过并如实列名；
- 断点状态文件（*.bdn_upload_state.json / *.bdn_dl_state.json）同样排除出扫描。
"""
from __future__ import annotations

import hashlib
import os
import re
import time

from .errors import BdnApiError, BdnError
from .transfer import (BdnTransferError, DownloadEngine, UploadEngine,
                       _load_json, _save_json_atomic, md5_file)

STATE_RE = re.compile(r"^\.bdn_mirror_[0-9a-f]{8}\.json$")
RESIDUE_RE = re.compile(r"\.bdn_(upload|dl)_state\.json$")   # 传输引擎断点残件
MAX_NUM = 1000


class MirrorEngine:
    def __init__(self, api, upload_engine: UploadEngine | None = None,
                 max_scan_requests: int = 100):
        self.api = api
        self.s = api.s
        self.eng = upload_engine or UploadEngine(api)
        self.max_scan_requests = max_scan_requests

    # ---------- state ----------

    @staticmethod
    def state_path(local_root: str, remote_root: str) -> str:
        h = hashlib.md5(remote_root.encode("utf-8")).hexdigest()[:8]
        return os.path.join(local_root, f".bdn_mirror_{h}.json")

    # ---------- 扫描 ----------

    @staticmethod
    def _excluded(fname: str) -> bool:
        return bool(STATE_RE.match(fname) or RESIDUE_RE.search(fname))

    def scan_local(self, local_root: str, state: dict) -> tuple[dict, int]:
        """→ ({rel: {size,mtime,md5}}, 重哈希数)。md5 缓存命中条件=size+mtime 未变。"""
        files, rehashed = {}, 0
        cached_files = state.get("files") or {}
        for dirpath, _dirnames, filenames in os.walk(local_root):
            for fn in filenames:
                if self._excluded(fn):
                    continue
                full = os.path.join(dirpath, fn)
                rel = os.path.relpath(full, local_root).replace("\\", "/")
                st = os.stat(full)
                size, mtime = st.st_size, int(st.st_mtime)
                cached = cached_files.get(rel)
                if (cached and cached.get("size") == size
                        and cached.get("mtime") == mtime and cached.get("md5")):
                    digest = cached["md5"]
                else:
                    digest = md5_file(full)
                    rehashed += 1
                files[rel] = {"size": size, "mtime": mtime, "md5": digest}
        return files, rehashed

    def scan_remote(self, remote_root: str) -> tuple[dict, set, dict]:
        """递归 ls 对账 → ({rel: {size,fs_id}}, 远端全路径目录集, 扫描账)。

        W7 A3：扫描预算护栏改为**如实报告**——耗尽时不再硬崩，返回已扫部分 +
        scan 账 {"used","limit","truncated","unscanned":[未扫目录]}（调用方
        继续在已扫面上做只增镜像：未扫目录里的同名文件会被当 missing 重传，
        rtype=3 覆盖=以本地为准，无删除语义，代价只是多传）。根不存在=空。"""
        files: dict = {}
        dirs: set = set()
        sent0 = self.s.requests_sent
        first = True
        truncated = False
        pending_pages: list = []
        queue = [remote_root.rstrip("/")]
        while queue:
            d = queue.pop(0)
            page = 1
            while True:
                if self.s.requests_sent - sent0 >= self.max_scan_requests:
                    truncated = True              # 预算耗尽：余下目录如实列账
                    pending_pages.append(d if page == 1 else f"{d}(第{page}页起)")
                    break
                try:
                    r = self.api.list_dir(d, page=page, num=MAX_NUM)
                except BdnApiError as e:
                    if first and e.errno in (-9, -7):     # 根不存在 → 空远端
                        return {}, set(), self._scan_meta(
                            sent0, False, [])
                    raise
                first = False
                entries = r.get("entries") or []
                for e in entries:
                    full = (e.get("path") or "").rstrip("/")
                    if not full.startswith(remote_root.rstrip("/")):
                        continue                    # 防御：只收本根下的条目
                    rel = full[len(remote_root.rstrip("/")):].lstrip("/")
                    if e["isdir"]:
                        dirs.add(full)              # 目录键=远端全路径（对账/补建同键）
                        queue.append(full)
                    else:
                        files[rel] = {"size": int(e.get("size") or 0),
                                      "fs_id": e.get("fs_id")}
                if len(entries) < MAX_NUM:
                    break
                page += 1
            if truncated:
                break
        unscanned = pending_pages + queue if truncated else []
        return files, dirs, self._scan_meta(sent0, truncated, unscanned)

    def _scan_meta(self, sent0: int, truncated: bool, unscanned: list) -> dict:
        return {"used": self.s.requests_sent - sent0,
                "limit": self.max_scan_requests,
                "truncated": truncated, "unscanned": unscanned}

    # ---------- 计划 ----------

    @staticmethod
    def plan(local_files: dict, remote_files: dict, state: dict) -> dict:
        """变更判定三分支 + remote_only 报告（只报告不删——铁律）。"""
        uploads, unchanged, assumed, zero_byte = [], [], [], []
        prev_files = state.get("files") or {}
        for rel in sorted(local_files):
            lf = local_files[rel]
            rf = remote_files.get(rel)
            prev = prev_files.get(rel)
            if lf["size"] == 0:
                zero_byte.append(rel)               # 引擎不支持空文件（蓝本同款）
                continue
            if rf is None:
                uploads.append({"rel": rel, "reason": "missing_remote"})
            elif rf["size"] != lf["size"]:
                uploads.append({"rel": rel, "reason": "size_mismatch"})
            elif prev is None:
                assumed.append(rel)    # 远端已有同尺寸但无本地镜像史 → 视同未变补账
            elif prev.get("md5") != lf["md5"]:
                uploads.append({"rel": rel, "reason": "content_changed"})
            else:
                unchanged.append(rel)
        remote_only = sorted(set(remote_files) - set(local_files))
        return {"uploads": uploads, "unchanged": unchanged, "assumed": assumed,
                "zero_byte": zero_byte, "remote_only": remote_only}

    # ---------- 执行 ----------

    def _fence(self, path: str, fence: str | None, what: str):
        if fence:
            f = fence.rstrip("/")
            if path != f and not path.startswith(f + "/"):
                raise AssertionError(
                    f"[mirror guard] 写操作越界({what}): {path!r}")

    def _ensure_dir(self, remote_dir: str, remote_dirs: set,
                    created: list, fence: str | None):
        """逐段补建远端目录（幂等 mkdir；remote_dirs=远端全路径集合，已存在段零请求）。"""
        parts = remote_dir.strip("/").split("/")
        cur = ""
        for seg in parts:
            cur = cur + "/" + seg
            if cur in remote_dirs:
                continue
            self._fence(cur, fence, "mkdir")
            r = self.api.mkdir(cur)
            created.append({"path": cur, "exists": bool(r.get("exists"))})
            remote_dirs.add(cur)

    def run(self, local: str, remote: str, dry_run: bool = False,
            write_fence: str | None = None) -> dict:
        t0 = time.perf_counter()
        if not isinstance(remote, str) or not remote.startswith("/"):
            raise BdnApiError(-7, f"远端路径必须以 / 开头: {remote!r}")
        local = os.path.abspath(local)
        if not os.path.isdir(local):
            raise BdnTransferError(f"本地目录不存在: {local}")
        sent0 = self.s.requests_sent
        sp = self.state_path(local, remote)
        state = _load_json(sp) or {}
        if state.get("remote") != remote or not isinstance(state.get("files"), dict):
            state = {"remote": remote, "files": {}}

        local_files, rehashed = self.scan_local(local, state)
        remote_files, remote_dirs, scan = self.scan_remote(remote)
        plan = self.plan(local_files, remote_files, state)

        report = {"errno": 0, "local": local, "remote": remote,
                  "dry_run": dry_run, "files_scanned": len(local_files),
                  "bytes_total": sum(f["size"] for f in local_files.values()),
                  "md5_rehashed": rehashed,
                  "remote_scan_requests": 0,
                  "scan_truncated": scan["truncated"],
                  "scan_used": scan["used"], "scan_limit": scan["limit"],
                  "unscanned_dirs": scan["unscanned"][:50],
                  "unscanned_count": len(scan["unscanned"]),
                  "uploads_planned": len(plan["uploads"]),
                  "uploads_done": 0, "uploads_failed": [],
                  "unchanged": len(plan["unchanged"]),
                  "assumed_unchanged": len(plan["assumed"]),
                  "zero_byte_skipped": plan["zero_byte"],
                  "remote_only_count": len(plan["remote_only"]),
                  "remote_only_sample": plan["remote_only"][:20],
                  "dirs_created": [], "bytes_uploaded": 0,
                  "data_requests": 0, "note": ""}
        report["remote_scan_requests"] = self.s.requests_sent - sent0
        if scan["truncated"]:
            report["note"] = (f"远端扫描预算耗尽：已用 {scan['used']}/{scan['limit']} 发，"
                              f"未扫目录 {len(scan['unscanned'])} 个"
                              "（已列 unscanned_dirs；未扫面上的同名文件将按本地覆盖重传，"
                              "无删除语义）")

        if dry_run:
            report["note"] = "dry-run：只出计划零上传零落盘"
            report["uploads"] = plan["uploads"]
            report["elapsed_s"] = round(time.perf_counter() - t0, 2)
            report["requests"] = self.s.requests_sent - sent0
            return report

        # 目录先行（只补缺失段）
        for item in plan["uploads"]:
            rel = item["rel"]
            parent = rel.rsplit("/", 1)[0] if "/" in rel else ""
            if parent:
                self._ensure_dir(remote.rstrip("/") + "/" + parent,
                                 remote_dirs, report["dirs_created"], write_fence)

        eng_bytes0 = self.eng.bytes_sent            # 引擎复用 → 记基线取增量
        eng_req0 = self.eng.data_requests
        for item in plan["uploads"]:
            rel = item["rel"]
            lpath = os.path.join(local, rel.replace("/", os.sep))
            rpath = remote.rstrip("/") + "/" + rel
            self._fence(rpath, write_fence, "upload")
            try:
                self.eng.upload(lpath, rpath, rtype=3)
                report["uploads_done"] += 1
                state["files"][rel] = local_files[rel]
                _save_json_atomic(sp, state)        # 逐文件落账：中断不丢已传清单
            except BdnError as e:
                report["uploads_failed"].append({"rel": rel, "errno":
                                                 getattr(e, "errno", None),
                                                 "error": str(e)})
        report["bytes_uploaded"] = self.eng.bytes_sent - eng_bytes0
        # 未变/补账文件回写缓存（后续本地变更检测的基准）
        for rel in plan["unchanged"] + plan["assumed"]:
            state["files"][rel] = local_files[rel]
        _save_json_atomic(sp, state)
        report["uploads"] = plan["uploads"]

        report["data_requests"] = self.eng.data_requests - eng_req0
        report["requests"] = self.s.requests_sent - sent0
        report["elapsed_s"] = round(time.perf_counter() - t0, 2)
        if plan["remote_only"]:
            tail = "远端只增不删：多余远端文件仅报告"
            report["note"] = (report["note"] + " | " + tail
                              if report["note"] else tail)
        if report["uploads_failed"]:
            report["errno"] = 1
        return report


class PullEngine:
    """W7 A2：pull 恢复腿——远端目录 → 本地（mirror 的反向件）。

    模型：远端递归扫描（复用 MirrorEngine.scan_remote，含预算护栏）→ 本地对账：
    - 本地缺文件 / 本地 size ≠ 远端 size → DownloadEngine 下载（md5 校验+断点续传）；
    - 本地多出的文件**只报告不删**（对齐 mirror「远端只增不删」铁律的反向表述）；
    - 远端空文件可拉（下载引擎 0 字节形态天然支持：d41d8… md5 全等）；
    - 相同 size 视为未变（服务端 md5 混淆不可比，漂移账 #14；不做逐文件 metas
      全量对账——O(1) 轴换 filediff 游标链留激活后）。
    """

    def __init__(self, api, download_engine=None, max_scan_requests: int = 100):
        self.api = api
        self.s = api.s
        self.eng = download_engine or DownloadEngine(api)
        self.max_scan_requests = max_scan_requests

    @staticmethod
    def _safe_rel(rel: str) -> str:
        """防路径穿越：rel 含 '..' 段 → 拒（服务端条目不可信面）。"""
        if not rel or any(seg in ("..", "") for seg in rel.split("/")) or ":" in rel:
            raise BdnTransferError(f"远端条目路径不合法（拒绝落盘）: {rel!r}")
        return rel

    @staticmethod
    def scan_local(local_root: str) -> dict:
        """本地对账面 {rel: size}；断点残件/镜像 state 排除（与 mirror 同口径）。"""
        files = {}
        for dirpath, _dirnames, filenames in os.walk(local_root):
            for fn in filenames:
                if MirrorEngine._excluded(fn):
                    continue
                full = os.path.join(dirpath, fn)
                rel = os.path.relpath(full, local_root).replace("\\", "/")
                files[rel] = os.path.getsize(full)
        return files

    @staticmethod
    def plan(remote_files: dict, local_files: dict) -> dict:
        downloads, unchanged = [], []
        for rel in sorted(remote_files):
            size = int(remote_files[rel].get("size") or 0)
            if rel not in local_files:
                downloads.append({"rel": rel, "size": size,
                                  "reason": "missing_local"})
            elif local_files[rel] != size:
                downloads.append({"rel": rel, "size": size,
                                  "reason": "size_mismatch"})
            else:
                unchanged.append(rel)
        local_only = sorted(set(local_files) - set(remote_files))
        return {"downloads": downloads, "unchanged": unchanged,
                "local_only": local_only}

    def run(self, remote: str, local: str, dry_run: bool = False) -> dict:
        t0 = time.perf_counter()
        if not isinstance(remote, str) or not remote.startswith("/"):
            raise BdnApiError(-7, f"远端路径必须以 / 开头: {remote!r}")
        local = os.path.abspath(local)
        if os.path.exists(local) and not os.path.isdir(local):
            raise BdnTransferError(f"本地目标不是目录: {local}")
        sent0 = self.s.requests_sent
        scanner = MirrorEngine(self.api, max_scan_requests=self.max_scan_requests)
        remote_files, _dirs, scan = scanner.scan_remote(remote)
        local_files = self.scan_local(local)
        plan = self.plan(remote_files, local_files)

        report = {"errno": 0, "remote": remote, "local": local,
                  "dry_run": dry_run,
                  "remote_files": len(remote_files),
                  "bytes_total": sum(int(f.get("size") or 0)
                                     for f in remote_files.values()),
                  "scan_truncated": scan["truncated"],
                  "scan_used": scan["used"], "scan_limit": scan["limit"],
                  "unscanned_dirs": scan["unscanned"][:50],
                  "unscanned_count": len(scan["unscanned"]),
                  "downloads_planned": len(plan["downloads"]),
                  "downloads_done": 0, "downloads_failed": [],
                  "unchanged": len(plan["unchanged"]),
                  "local_only_count": len(plan["local_only"]),
                  "local_only_sample": plan["local_only"][:20],
                  "bytes_received": 0, "data_requests": 0, "note": ""}
        if scan["truncated"]:
            report["note"] = (f"远端扫描预算耗尽：已用 {scan['used']}/{scan['limit']} 发，"
                              f"未扫目录 {len(scan['unscanned'])} 个（列于 unscanned_dirs）")
        if dry_run:
            report["downloads"] = plan["downloads"]
            report["requests"] = self.s.requests_sent - sent0
            report["elapsed_s"] = round(time.perf_counter() - t0, 2)
            report["note"] = (report["note"] + " | " if report["note"] else "") \
                             + "dry-run：只出计划零下载零落盘"
            return report

        eng_bytes0 = self.eng.bytes_received
        eng_req0 = self.eng.data_requests
        for item in plan["downloads"]:
            rel = self._safe_rel(item["rel"])
            rpath = remote.rstrip("/") + "/" + item["rel"]
            lpath = os.path.join(local, rel.replace("/", os.sep))
            try:
                self.eng.download(rpath, lpath)
                report["downloads_done"] += 1
            except BdnError as e:
                report["downloads_failed"].append(
                    {"rel": item["rel"], "errno": getattr(e, "errno", None),
                     "error": str(e)})
        report["bytes_received"] = self.eng.bytes_received - eng_bytes0
        report["data_requests"] = self.eng.data_requests - eng_req0
        report["requests"] = self.s.requests_sent - sent0
        report["elapsed_s"] = round(time.perf_counter() - t0, 2)
        if report["local_only_count"]:
            report["note"] = (report["note"] + " | " if report["note"] else "") \
                + f"本地多出 {report['local_only_count']} 项只报告不删"
        if report["downloads_failed"]:
            report["errno"] = 1
        return report
