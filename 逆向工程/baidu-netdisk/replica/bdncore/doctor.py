# -*- coding: utf-8 -*-
"""bdn doctor 复验器：链路体检 + 协议漂移检测（W5）。

全只读 8 针（不给服务器添写负担；第 8 针为「故意缺参→应拒」形态探针：
拒绝=零服务端状态，即使意外放行也只留临时 uploadid，绝不 create——零落盘）：
  1 loginStatus  凭据活性（往返时延/errno/画像）
  2 quota        配额回显
  3 api/list     根目录读探针（errno 形态 + 条目数 vs W3 基线 17）
  4 api/filemetas 元信息字段族（info 键 + isdir 字符串形态）
  5 share/record 分享记录字段族（驼峰键）
  6 api/recycle/list 回收站字段族
  7 d.pcs locateupload 上传数据面发现面（servers[] 非空）
  8 api/precreate 参数完整度门探针（缺 block_list/md5 族 → 应拒 -7/2）

协议指纹 = 实测响应特征 vs PROTOCOL.md A 级预期清单（EXPECT_*）；任何偏差进
drift[]（结构字段缺失=degraded；根条目数变化=信息项——W4 围栏产物即会增根项）。
每针 status ∈ ok/degraded/dead → 总 verdict 取最差。预算 8 发（控制面节流内）。
"""
from __future__ import annotations

import time

from .errors import BdnAuthError, BdnError, BdnNetworkError

# PROTOCOL.md A 级预期（证据：冒烟/W1/W4 2026-10-29）
EXPECT_LOGIN_FIELDS = ["login_info"]                 # 画像明文发放（含 bdstoken/uk）
EXPECT_QUOTA_FIELDS = ["total", "used"]
EXPECT_LIST_FIELDS = ["list", "guid_info"]           # G3：api/list 正常返回字段族
EXPECT_LIST_ENTRY_FIELDS = ["fs_id", "server_filename", "isdir", "size"]
EXPECT_METAS_FIELDS = ["info"]                       # G5：数据在 info 键
EXPECT_METAS_ENTRY_FIELDS = ["fs_id", "md5", "isdir"]
EXPECT_SHARE_RECORD_FIELDS = ["list"]
EXPECT_SHARE_ENTRY_FIELDS = ["shareId", "shortlink", "typicalPath"]   # 驼峰键族
EXPECT_RECYCLE_FIELDS = ["list"]
EXPECT_LOCATE_FIELDS = ["servers"]
ROOT_BASELINE_ENTRIES = 17                           # W3 冒烟基线（根目录 17 项）
PRECREATE_GATE_REJECT = {-7, 2}                      # 缺参应拒（G8：errno -7/-10 族）
PRECREATE_PROBE_PATH = "/API复刻测试_1029/.bdn_doctor_probe_never_created"
STATUS_ORDER = {"ok": 0, "degraded": 1, "dead": 2}


def _worst(a: str, b: str) -> str:
    return a if STATUS_ORDER[a] >= STATUS_ORDER[b] else b


def _fingerprint(rep: dict, name: str, payload: dict, fields: list,
                 sub_key: str | None = None, sub_fields: list | None = None) -> dict:
    """字段族核对：缺失→degraded + drift 条目；sub_key 指第一层子对象再核一层。"""
    missing = [f for f in fields if f not in (payload or {})]
    sub_missing = []
    if sub_key and sub_fields and not missing:
        first = (payload.get(sub_key) or [{}])
        first = first[0] if isinstance(first, list) and first else {}
        sub_missing = [f for f in sub_fields if f not in first]
    row = {"probe": name, "status": "ok" if not (missing or sub_missing) else "degraded",
           "expect": fields, "missing": missing, "sub_missing": sub_missing}
    if missing or sub_missing:
        rep["drift"].append({"probe": name, "missing_fields": missing,
                             "missing_sub_fields": sub_missing,
                             "kind": "fingerprint"})
    rep["fingerprints"].append(row)
    return row


def _probe(rep, checks, name, fn):
    """执行一针：异常按类型落 dead/degraded；正常返回 payload 由调用方续核。"""
    sent0 = rep["_requests_sent"]
    t0 = time.perf_counter()
    try:
        payload = fn()
        ms = round((time.perf_counter() - t0) * 1000, 1)
        checks[name] = {"status": "ok", "errno": (payload or {}).get("errno", 0),
                        "ms": ms, "requests": rep["_requests_sent"] - sent0}
        return payload
    except BdnAuthError as e:
        checks[name] = {"status": "dead", "errno": getattr(e, "errno", None),
                        "error": str(e), "requests": rep["_requests_sent"] - sent0}
        rep["drift"].append({"probe": name, "kind": "auth_dead",
                             "errno": getattr(e, "errno", None)})
    except BdnNetworkError as e:
        checks[name] = {"status": "dead", "errno": None, "error": str(e),
                        "requests": rep["_requests_sent"] - sent0}
        rep["drift"].append({"probe": name, "kind": "network_dead"})
    except BdnError as e:
        checks[name] = {"status": "degraded", "errno": getattr(e, "errno", None),
                        "error": str(e), "requests": rep["_requests_sent"] - sent0}
        rep["drift"].append({"probe": name, "kind": "errno_nonzero",
                             "errno": getattr(e, "errno", None)})
    return None


def run_doctor(api) -> dict:
    """跑 8 针体检，返回体检报告 dict（--json 直出；掩码纪律：无任何凭据明文）。"""
    s = api.s
    rep = {"generated_at": time.strftime("%Y-%m-%d %H:%M:%S"),
           "checks": {}, "fingerprints": [], "drift": [],
           "_requests_sent": s.requests_sent, "verdict": "ok"}
    checks = rep["checks"]

    # 1 凭据活性
    r = _probe(rep, checks, "credentials", api.login_status)
    if r is not None:
        acc = r.get("account") or {}
        info = r.get("login_info") or {}
        if not acc.get("uk"):
            checks["credentials"]["status"] = "degraded"
            rep["drift"].append({"probe": "credentials", "kind": "no_uk"})
        checks["credentials"].update({
            "username": acc.get("username"), "uk": acc.get("uk"),
            "vip_level": acc.get("vip_level"),
            "roundtrip_ms": checks["credentials"]["ms"]})
        _fingerprint(rep, "loginStatus 字段族", r, EXPECT_LOGIN_FIELDS)

    # 2 配额回显
    r = _probe(rep, checks, "quota", api.quota)
    if r is not None:
        total, used = r.get("total", 0), r.get("used", 0)
        checks["quota"].update({"total": total, "used": used,
                                "free": total - used})
        _fingerprint(rep, "api/quota 字段族", r, EXPECT_QUOTA_FIELDS)

    # 3 api/list 根目录读探针
    r = _probe(rep, checks, "read_probe_ls_root", lambda: api.list_dir("/"))
    ls_raw = None
    if r is not None:
        n = len(r.get("entries") or [])
        checks["read_probe_ls_root"]["entries"] = n
        if n != ROOT_BASELINE_ENTRIES:            # 信息项：W4 围栏产物即会增根项
            rep["drift"].append({"probe": "read_probe_ls_root",
                                 "kind": "root_count_changed",
                                 "entries": n, "baseline": ROOT_BASELINE_ENTRIES})
        _fingerprint(rep, "api/list 字段族", r, EXPECT_LIST_FIELDS,
                     sub_key="list", sub_fields=EXPECT_LIST_ENTRY_FIELDS)
        ls_raw = r

    # 4 api/filemetas 字段族（探针 fsid 取自根列表首个条目）
    def _metas_probe():
        fsid = None
        for e in (ls_raw or {}).get("entries") or []:
            fsid = e["fs_id"]
            break
        if fsid is None:
            return {"info": [{}], "_skip": "根无条目"}
        raw = s.get("/api/filemetas", params={"fsids": f"[{fsid}]",
                                              "dlink": 0, "clienttype": 8})
        return raw

    r = _probe(rep, checks, "filemetas", _metas_probe)
    if r is not None and not r.get("_skip"):
        _fingerprint(rep, "api/filemetas 字段族", r, EXPECT_METAS_FIELDS,
                     sub_key="info", sub_fields=EXPECT_METAS_ENTRY_FIELDS)

    # 5 share/record 字段族
    r = _probe(rep, checks, "share_record",
               lambda: s.get("/share/record",
                             params={"page": 1, "desc": 1, "order": "time",
                                     "clienttype": 8}))
    if r is not None:
        checks["share_record"]["count"] = len(r.get("list") or [])
        _fingerprint(rep, "share/record 字段族", r, EXPECT_SHARE_RECORD_FIELDS,
                     sub_key="list", sub_fields=EXPECT_SHARE_ENTRY_FIELDS)

    # 6 回收站字段族
    r = _probe(rep, checks, "recycle_list",
               lambda: s.get("/api/recycle/list",
                             params={"num": 10, "page": 1, "clienttype": 8}))
    if r is not None:
        checks["recycle_list"]["count"] = len(r.get("list") or [])
        _fingerprint(rep, "api/recycle/list 字段族", r, EXPECT_RECYCLE_FIELDS)

    # 7 上传数据面发现面（superfile2 host 发现；只读 GET）
    r = _probe(rep, checks, "locateupload", api.locate_upload)
    if r is not None:
        servers = r.get("servers") or []
        checks["locateupload"]["servers"] = len(servers)
        if not servers:
            checks["locateupload"]["status"] = "degraded"
            rep["drift"].append({"probe": "locateupload", "kind": "servers_empty"})
        _fingerprint(rep, "locateupload 字段族", r, EXPECT_LOCATE_FIELDS)

    # 8 precreate 参数完整度门（故意缺参→应拒；拒绝=零写负担）
    def _precreate_probe():
        return s.post("/api/precreate",
                      params={"clienttype": 8, "app_id": 250528},
                      data={"path": PRECREATE_PROBE_PATH,
                            "size": 1, "isdir": 0})    # 故意缺 block_list/md5 族
    sent0 = rep["_requests_sent"]
    t0 = time.perf_counter()
    try:
        r = _precreate_probe()                          # 放行=门漂移（degraded）
        checks["precreate_gate"] = {
            "status": "degraded", "errno": 0,
            "return_type": r.get("return_type"),
            "note": "缺参形态被放行（参数完整度门疑似松动；未 create 零落盘）",
            "requests": s.requests_sent - sent0,
            "ms": round((time.perf_counter() - t0) * 1000, 1)}
        rep["drift"].append({"probe": "precreate_gate", "kind": "gate_loosened",
                             "return_type": r.get("return_type")})
    except BdnError as e:
        errno = getattr(e, "errno", None)
        status = "ok" if errno in PRECREATE_GATE_REJECT else "dead"
        checks["precreate_gate"] = {
            "status": status, "errno": errno,
            "requests": s.requests_sent - sent0,
            "ms": round((time.perf_counter() - t0) * 1000, 1)}
        if status == "dead":
            rep["drift"].append({"probe": "precreate_gate",
                                 "kind": "gate_dead", "errno": errno})

    # 汇总（checks 与协议指纹双轴取最差）
    verdict = "ok"
    for c in checks.values():
        verdict = _worst(verdict, c["status"])
    for fp in rep["fingerprints"]:
        verdict = _worst(verdict, fp["status"])
    rep["verdict"] = verdict
    rep["requests_sent"] = s.requests_sent - rep["_requests_sent"]
    rep["requests_total_session"] = s.requests_sent
    rep["circuit_open"] = s.circuit_open
    rep["baseline"] = {"root_entries": ROOT_BASELINE_ENTRIES}
    del rep["_requests_sent"]                       # 内部记账键不进报告
    return rep
