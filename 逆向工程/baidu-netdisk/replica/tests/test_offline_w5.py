# -*- coding: utf-8 -*-
"""W5 离线单测：通道路由降级 / doctor 八针 / mirror 增量计划 / 分享转存形态。

全部零网络：控制面走 FakeTransport（降级路径用 handler 抛 requests 异常模拟），
mirror 用假引擎/假远端。运行（于 replica/ 目录）：python -m unittest discover -s tests -v
"""
from __future__ import annotations

import json
import os
import sys
import tempfile
import unittest
from unittest import mock

import requests

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import (BdnApi, BdnApiError, BdnAuthError, BdnCircuitOpen,  # noqa: E402
                     BdnError, BdnSession, BdpanSubprocessChannel,
                     BdnNetworkError, MirrorEngine, READ_CHAINS, RoutedApi,
                     Throttle, WRITE_FAMILY, mask, run_doctor, should_fallback)
from bdncore.mirror import STATE_RE  # noqa: E402


# ---------------- 桩件（与 test_offline_w4 同款） ----------------

class FakeTransport:
    def __init__(self, handler):
        self.handler = handler
        self.calls = []

    def request(self, method, url, params=None, data=None, headers=None, timeout=None):
        self.calls.append({"method": method, "url": url,
                           "params": dict(params or {}),
                           "data": dict(data) if data else data,
                           "headers": dict(headers or {})})
        result = self.handler(method, url, params, data)
        if isinstance(result, Exception):
            raise result
        return _Resp(result)


class _Resp:
    def __init__(self, payload, status_code=200):
        self._p = payload
        self.status_code = status_code

    def json(self):
        return self._p


def make_session(handler):
    t = FakeTransport(handler)
    creds = {"bduss": "AB-cd" * 48, "stoken": "st" * 32}
    return BdnSession(creds=creds, transport=t,
                      throttle=Throttle(min_interval=0)), t


def tmpdir() -> str:
    return tempfile.mkdtemp(prefix="bdnw5_")


def wfile(path: str, content: bytes, mtime=None) -> str:
    with open(path, "wb") as f:
        f.write(content)
    if mtime is not None:
        os.utime(path, (mtime, mtime))
    return path


def _try_remove(path: str):
    try:
        os.remove(path)
    except OSError:
        pass


def _try_rmtree(path: str):
    import shutil
    try:
        shutil.rmtree(path, ignore_errors=True)
    except OSError:
        pass


# ---------------- 路由 / 降级 ----------------

class TestRouter(unittest.TestCase):

    def _handler_ok(self):
        def h(method, url, params, data):
            if "/api/list" in url:
                return {"errno": 0, "guid_info": "g", "list": [
                    {"fs_id": 1, "server_filename": "a.bin", "isdir": "0",
                     "size": 5, "path": "/a.bin"}]}
            return {"errno": 0}
        return h

    def test_read_api_ok_no_fallback(self):
        sess, t = make_session(self._handler_ok())
        r = RoutedApi(BdnApi(sess)).list_dir("/")
        self.assertEqual(r["_route"], "api")
        self.assertEqual(r["entries"][0]["name"], "a.bin")
        self.assertFalse(r["entries"][0]["isdir"])      # isdir 字符串归一
        self.assertTrue(all(x["ok"] for x in
                            RoutedApi(BdnApi(sess)).routing_log or [{"ok": True}]))

    def test_read_fallback_api_to_xpan_on_network_error(self):
        def h(method, url, params, data):
            if "/api/list" in url:
                return requests.exceptions.ConnectionError("api dead")
            if "xpan/file" in url and params.get("method") == "list":
                return {"errno": 0, "list": [
                    {"fs_id": 2, "server_filename": "b.bin", "isdir": 0,
                     "size": 7, "path": "/b.bin"}]}
            return {"errno": 0}
        sess, t = make_session(h)
        routed = RoutedApi(BdnApi(sess))
        with mock.patch("bdncore.session._backoff_sleep"):
            r = routed.list_dir("/")
        self.assertEqual(r["_route"], "xpan")            # 降级链命中
        self.assertEqual(r["entries"][0]["name"], "b.bin")
        log = [x for x in routed.routing_log if x["op"] == "ls"]
        self.assertEqual(log[0]["family"], "api")
        self.assertFalse(log[0]["ok"])
        self.assertTrue(log[0]["fallback"])
        self.assertEqual(log[1]["family"], "xpan")
        self.assertTrue(log[1]["ok"])
        # xpan 通道形态：start/limit 分页 + web=1&folder=1
        xp = [c for c in t.calls if "xpan/file" in c["url"] and
              c["params"].get("method") == "list"]
        self.assertEqual(xp[0]["params"]["start"], 0)
        self.assertEqual(xp[0]["params"]["limit"], 1000)

    def test_no_fallback_on_business_errno(self):
        def h(method, url, params, data):
            if "/api/list" in url:
                return {"errno": -9, "errmsg": "not exist"}
            return {"errno": 0}
        sess, t = make_session(h)
        routed = RoutedApi(BdnApi(sess))
        with self.assertRaises(BdnApiError):
            routed.list_dir("/nope")
        self.assertEqual(len([c for c in t.calls if "xpan" in c["url"]]), 0)

    def test_no_fallback_on_circuit_or_auth(self):
        self.assertFalse(should_fallback(BdnCircuitOpen("open", 31119)))
        self.assertFalse(should_fallback(BdnAuthError("-6", errno=-6)))
        self.assertTrue(should_fallback(BdnNetworkError("exhausted")))
        self.assertTrue(should_fallback(BdnApiError(-10)))
        self.assertFalse(should_fallback(BdnApiError(-9)))
        self.assertFalse(should_fallback(ValueError("x")))

    def test_share_records_fallback_to_xpan(self):
        def h(method, url, params, data):
            if "/share/record" in url:
                return requests.exceptions.ReadTimeout("t")
            if "xpan/share" in url:
                return {"errno": 0, "list": [{"shareId": 9, "shortlink":
                        "https://pan.baidu.com/s/1Ab", "typicalPath": "/f",
                        "passwd": "abcd"}]}
            return {"errno": 0}
        sess, _ = make_session(h)
        routed = RoutedApi(BdnApi(sess))
        with mock.patch("bdncore.session._backoff_sleep"):
            r = routed.share_records()
        self.assertEqual(r["_route"], "xpan")
        self.assertEqual(r["entries"][0]["shareid"], 9)
        self.assertEqual(r["entries"][0]["passwd"], "***")   # 掩码纪律

    def test_write_family_api_only(self):
        self.assertEqual(WRITE_FAMILY, "api")
        # 写面结构性无 xpan 通道：xpan 通道方法只服务读面 READ_CHAINS 键
        for meth in dir(RoutedApi):
            if meth.startswith("_ch_xpan_"):
                self.assertIn(meth[len("_ch_xpan_"):], READ_CHAINS,
                              f"写操作 {meth} 不得进 xpan 通道")
        for op in ("mkdir", "rename", "move", "copy", "delete"):
            self.assertNotIn(f"_ch_xpan_{op}", dir(RoutedApi))
        sess, t = make_session(self._handler_ok())
        def h2(method, url, params, data):
            if "/api/create" in url:
                return {"errno": 0, "fs_id": 3}
            return {"errno": 0}
        t.handler = h2
        routed = RoutedApi(BdnApi(sess))
        r = routed.mkdir("/d")                              # 写面直通 /api
        self.assertEqual(r["fs_id"], 3)
        writes = [c for c in t.calls if "xpan" in c["url"] and "create" in c["url"]]
        self.assertEqual(len(writes), 0)

    def test_t1_bdpan_stub_off(self):
        ch = BdpanSubprocessChannel()
        self.assertFalse(ch.enabled)
        with self.assertRaises(NotImplementedError):
            ch.call("ls", dir_path="/")

    def test_routed_passthrough_unknown_method(self):
        sess, _ = make_session(self._handler_ok())
        routed = RoutedApi(BdnApi(sess))
        self.assertTrue(callable(routed.login_status))     # __getattr__ 直通
        with self.assertRaises(AttributeError):
            routed._no_such_private


# ---------------- doctor ----------------

OK_LIST = {"errno": 0, "guid_info": "g", "list": [
    {"fs_id": 11, "server_filename": "a.bin", "isdir": "0", "size": 1,
     "path": "/a.bin"}]}
OK_METAS = {"errno": 0, "info": [{"fs_id": 11, "md5": "ab" * 16, "isdir": "0"}]}
OK_SHARE = {"errno": 0, "list": [{"shareId": 5, "shortlink": "https://x/1A",
                                  "typicalPath": "/f", "passwd": "xx"}]}
OK_RECYCLE = {"errno": 0, "list": [{"fs_id": 1}]}
OK_LOCATE = {"errno": 0, "servers": ["https://c5.pcs.baidu.com"]}


def doctor_handler(login=None, lst=None, metas=None, share=None, recycle=None,
                   locate=None, precreate=None):
    def h(method, url, params, data):
        if "loginStatus" in url:
            return login if login is not None else {
                "errno": 0, "login_info": {"username": "u", "uk": 1,
                                           "vip_level": 8, "bdstoken": "b" * 32}}
        if "/api/quota" in url:
            return {"errno": 0, "total": 100, "used": 40}
        if "/api/list" in url:
            return lst if lst is not None else OK_LIST
        if "/api/filemetas" in url:
            return metas if metas is not None else OK_METAS
        if "/share/record" in url:
            return share if share is not None else OK_SHARE
        if "/api/recycle/list" in url:
            return recycle if recycle is not None else OK_RECYCLE
        if "locateupload" in url or url.startswith("https://d.pcs.baidu.com"):
            return locate if locate is not None else OK_LOCATE
        if "/api/precreate" in url:
            return precreate if precreate is not None else BdnApiError(
                -7, "param error")
        return {"errno": 0}
    return h


class TestDoctor(unittest.TestCase):

    def test_all_ok(self):
        baseline_list = {"errno": 0, "guid_info": "g", "list": [
            {"fs_id": i, "server_filename": f"f{i}.bin", "isdir": "0",
             "size": 1, "path": f"/f{i}.bin"} for i in range(17)]}
        sess, _ = make_session(doctor_handler(lst=baseline_list))
        rep = run_doctor(BdnApi(sess))
        self.assertEqual(rep["verdict"], "ok")
        self.assertEqual(rep["drift"], [])               # 17 项=基线，零漂移
        self.assertEqual(len(rep["checks"]), 8)
        self.assertLessEqual(rep["requests_sent"], 8)

    def test_root_count_change_is_informational(self):
        sess, _ = make_session(doctor_handler())
        rep = run_doctor(BdnApi(sess))
        kinds = [d["kind"] for d in rep["drift"]]
        self.assertIn("root_count_changed", kinds)       # 信息项不降级
        self.assertEqual(rep["checks"]["read_probe_ls_root"]["status"], "ok")

    def test_dead_credentials(self):
        sess, _ = make_session(doctor_handler(login={"errno": -6}))
        rep = run_doctor(BdnApi(sess))
        self.assertEqual(rep["verdict"], "dead")
        self.assertEqual(rep["checks"]["credentials"]["status"], "dead")

    def test_missing_guid_info_degrades(self):
        lst = {"errno": 0, "list": OK_LIST["list"]}      # 缺 guid_info
        sess, _ = make_session(doctor_handler(lst=lst))
        rep = run_doctor(BdnApi(sess))
        self.assertEqual(rep["verdict"], "degraded")
        fp = [f for f in rep["fingerprints"] if "api/list" in f["probe"]][0]
        self.assertEqual(fp["missing"], ["guid_info"])

    def test_precreate_gate_intact(self):
        sess, _ = make_session(doctor_handler(precreate=BdnApiError(-7, "x")))
        rep = run_doctor(BdnApi(sess))
        self.assertEqual(rep["checks"]["precreate_gate"]["status"], "ok")
        self.assertEqual(rep["checks"]["precreate_gate"]["errno"], -7)

    def test_precreate_gate_loosened_degrades(self):
        sess, _ = make_session(doctor_handler(
            precreate={"errno": 0, "return_type": 1, "uploadid": "u1"}))
        rep = run_doctor(BdnApi(sess))
        self.assertEqual(rep["checks"]["precreate_gate"]["status"], "degraded")
        kinds = [d["kind"] for d in rep["drift"]]
        self.assertIn("gate_loosened", kinds)


# ---------------- mirror ----------------

class FakeUploadEngine:
    """假上传引擎：记录调用；按 rel 返回成功（bytes/data_requests 可算）。"""

    def __init__(self):
        self.calls = []
        self.bytes_sent = 0
        self.data_requests = 0

    def upload(self, local, remote, rtype=3):
        self.calls.append({"local": local, "remote": remote, "rtype": rtype})
        n = os.path.getsize(local)
        self.bytes_sent += n
        self.data_requests += 1
        return {"errno": 0, "bytes_sent": self.bytes_sent,
                "data_requests": self.data_requests, "rapid": False}


def mirror_session(remote_tree=None):
    """remote_tree: {dir: [entry…]}；缺目录=errno -9。"""
    remote_tree = remote_tree if remote_tree is not None else {}

    def h(method, url, params, data):
        if "/api/list" in url:
            d = params.get("dir")
            if d not in remote_tree:
                return {"errno": -9, "errmsg": "not exist"}
            return {"errno": 0, "list": remote_tree[d]}
        if "/api/create" in url:
            return {"errno": 0, "fs_id": 99}
        return {"errno": 0}
    return make_session(h)


class TestMirror(unittest.TestCase):

    def test_scan_local_excludes_state_and_residue(self):
        d = tmpdir()
        try:
            wfile(os.path.join(d, "a.bin"), b"hello")
            wfile(os.path.join(d, ".bdn_mirror_deadbeef.json"), b"{}")
            wfile(os.path.join(d, "x.bin.bdn_upload_state.json"), b"{}")
            wfile(os.path.join(d, "y.bin.bdn_dl_state.json"), b"{}")
            eng = MirrorEngine.__new__(MirrorEngine)      # 只测扫描静态件
            files, _ = eng.scan_local(d, {"files": {}})
            self.assertEqual(list(files), ["a.bin"])
        finally:
            _try_rmtree(d)

    def test_scan_local_md5_cache_reuse(self):
        d = tmpdir()
        try:
            p = wfile(os.path.join(d, "a.bin"), b"hello", mtime=1000000)
            eng = MirrorEngine.__new__(MirrorEngine)
            files1, rh1 = eng.scan_local(d, {"files": {}})
            self.assertEqual(rh1, 1)
            files2, rh2 = eng.scan_local(d, {"files": files1})   # size+mtime 未变
            self.assertEqual(rh2, 0)
            self.assertEqual(files2["a.bin"]["md5"], files1["a.bin"]["md5"])
            wfile(p, b"world", mtime=1000001)            # 内容+mtime 变 → 重哈希
            _, rh3 = eng.scan_local(d, {"files": files2})
            self.assertEqual(rh3, 1)
        finally:
            _try_rmtree(d)

    def test_plan_first_run_all_missing(self):
        lf = {"a.bin": {"size": 3, "mtime": 1, "md5": "m1"},
              "sub/b.bin": {"size": 0, "mtime": 1, "md5": "m2"}}   # 空文件
        plan = MirrorEngine.plan(lf, {}, {"files": {}})
        self.assertEqual([u["rel"] for u in plan["uploads"]], ["a.bin"])
        self.assertEqual(plan["zero_byte"], ["sub/b.bin"])

    def test_plan_second_run_zero_uploads(self):
        lf = {"a.bin": {"size": 3, "mtime": 1, "md5": "m1"}}
        state = {"files": {"a.bin": {"size": 3, "mtime": 1, "md5": "m1"}}}
        remote = {"a.bin": {"size": 3, "fs_id": 1}}
        plan = MirrorEngine.plan(lf, remote, state)
        self.assertEqual(plan["uploads"], [])
        self.assertEqual(plan["unchanged"], ["a.bin"])
        self.assertEqual(plan["remote_only"], [])

    def test_plan_size_mismatch_and_content_changed(self):
        lf = {"a.bin": {"size": 5, "mtime": 1, "md5": "m2"},
              "b.bin": {"size": 3, "mtime": 1, "md5": "m9"}}
        state = {"files": {"a.bin": {"size": 3, "mtime": 1, "md5": "m1"},
                           "b.bin": {"size": 3, "mtime": 1, "md5": "m8"}}}
        remote = {"a.bin": {"size": 3, "fs_id": 1},      # size 不符
                  "b.bin": {"size": 3, "fs_id": 2}}      # 同尺寸内容变
        plan = MirrorEngine.plan(lf, remote, state)
        self.assertEqual(plan["uploads"], [
            {"rel": "a.bin", "reason": "size_mismatch"},
            {"rel": "b.bin", "reason": "content_changed"}])

    def test_plan_remote_only_reported_never_deleted(self):
        lf = {"a.bin": {"size": 3, "mtime": 1, "md5": "m1"}}
        state = {"files": lf}
        remote = {"a.bin": {"size": 3, "fs_id": 1},
                  "ghost.bin": {"size": 9, "fs_id": 2},
                  "olddir/x.bin": {"size": 9, "fs_id": 3}}
        plan = MirrorEngine.plan(lf, remote, state)
        self.assertEqual(plan["remote_only"], ["ghost.bin", "olddir/x.bin"])
        self.assertEqual(plan["uploads"], [])            # 无删除语义

    def test_run_dry_run_uploads_nothing(self):
        d = tmpdir()
        try:
            wfile(os.path.join(d, "a.bin"), b"hello")
            sess, _ = mirror_session()
            eng = MirrorEngine(BdnApi(sess), upload_engine=FakeUploadEngine())
            r = eng.run(d, "/fence/m1", dry_run=True)
            self.assertEqual(eng.eng.calls, [])          # 零上传
            self.assertEqual(r["uploads_planned"], 1)
            self.assertFalse(os.path.exists(                             # 零落盘
                eng.state_path(d, "/fence/m1")))
        finally:
            _try_rmtree(d)

    def test_run_uploads_and_state_saved(self):
        d = tmpdir()
        try:
            wfile(os.path.join(d, "a.bin"), b"hello", mtime=1000000)
            wfile(os.path.join(d, "empty.bin"), b"")
            os.makedirs(os.path.join(d, "sub"))
            wfile(os.path.join(d, "sub", "c.bin"), b"12345", mtime=1000000)
            sess, _ = mirror_session()
            fake = FakeUploadEngine()
            eng = MirrorEngine(BdnApi(sess), upload_engine=fake)
            r = eng.run(d, "/fence/m2", write_fence="/fence")
            self.assertEqual(r["uploads_done"], 2)
            self.assertEqual(len(fake.calls), 2)         # 空文件被跳过
            self.assertEqual(r["zero_byte_skipped"], ["empty.bin"])
            st = json.load(open(eng.state_path(d, "/fence/m2"), encoding="utf-8"))
            self.assertEqual(sorted(st["files"]), ["a.bin", "sub/c.bin"])
            self.assertEqual(r["bytes_uploaded"], 10)
            # 第二遍：远端按落盘形态回填 → 增量=0
            tree = {"/fence/m2": [
                {"fs_id": 1, "server_filename": "a.bin", "isdir": "0",
                 "size": 5, "path": "/fence/m2/a.bin"},
                {"fs_id": 2, "server_filename": "sub", "isdir": "1", "size": 0,
                 "path": "/fence/m2/sub"}],
                "/fence/m2/sub": [
                    {"fs_id": 3, "server_filename": "c.bin", "isdir": "0",
                     "size": 5, "path": "/fence/m2/sub/c.bin"}]}
            sess2, _ = mirror_session(tree)
            fake2 = FakeUploadEngine()
            eng2 = MirrorEngine(BdnApi(sess2), upload_engine=fake2)
            r2 = eng2.run(d, "/fence/m2", write_fence="/fence")
            self.assertEqual(r2["uploads_planned"], 0)
            self.assertEqual(fake2.calls, [])
            self.assertEqual(r2["unchanged"], 2)
        finally:
            _try_rmtree(d)

    def test_run_fence_violation_aborts(self):
        d = tmpdir()
        try:
            wfile(os.path.join(d, "a.bin"), b"hello")
            sess, _ = mirror_session()
            eng = MirrorEngine(BdnApi(sess), upload_engine=FakeUploadEngine())
            with self.assertRaises(AssertionError):      # 写出围栏=硬停
                eng.run(d, "/elsewhere/m3", write_fence="/fence")
        finally:
            _try_rmtree(d)

    def test_state_invalidated_on_remote_change(self):
        d = tmpdir()
        try:
            wfile(os.path.join(d, "a.bin"), b"hello", mtime=1000000)
            sess, _ = mirror_session()
            fake = FakeUploadEngine()
            eng = MirrorEngine(BdnApi(sess), upload_engine=fake)
            eng.run(d, "/fence/m4")
            # 同一 state 键但换远端目标 → 缓存作废（state.remote 不匹配）
            st = json.load(open(eng.state_path(d, "/fence/m4"), encoding="utf-8"))
            self.assertEqual(st["remote"], "/fence/m4")
            other = eng.state_path(d, "/fence/m5")
            self.assertNotEqual(other, eng.state_path(d, "/fence/m4"))
        finally:
            _try_rmtree(d)

    def test_state_re_regex(self):
        self.assertTrue(STATE_RE.match(".bdn_mirror_deadbeef.json"))
        self.assertFalse(STATE_RE.match("bdn_mirror_deadbeef.json"))
        self.assertFalse(STATE_RE.match(".bdn_mirror_zz.json"))


# ---------------- 分享/转存形态 ----------------

class TestShareShapes(unittest.TestCase):

    def test_share_create_body_blueprint_form(self):
        sess, t = make_session(lambda m, u, p, d: {"errno": 0, "shareid": 7,
                                                   "link": "https://pan.baidu.com/s/1X"})
        BdnApi(sess).share_create("/f/a.bin", pwd="x1y2", period=7)
        c = t.calls[-1]
        self.assertIn("/share/pset", c["url"])
        self.assertEqual(json.loads(c["data"]["path_list"]), ["/f/a.bin"])
        self.assertEqual(c["data"]["schannel"], 4)
        self.assertEqual(c["data"]["channel_list"], "[]")
        self.assertEqual(c["data"]["period"], 7)
        self.assertEqual(c["data"]["pwd"], "x1y2")
        self.assertEqual(c["data"]["share_type"], 9)

    def test_share_create_variant_web_form(self):
        sess, t = make_session(lambda m, u, p, d: {"errno": 0})
        BdnApi(sess).share_create("/f/a.bin", variant=1)
        self.assertEqual(json.loads(t.calls[-1]["data"]["path_list"]),
                         [{"path": "/f/a.bin"}])
        self.assertEqual(t.calls[-1]["data"]["schannel"], 0)   # 无码=公开

    def test_share_cancel_body(self):
        sess, t = make_session(lambda m, u, p, d: {"errno": 0})
        BdnApi(sess).share_cancel([7, 8])
        self.assertIn("/share/cancel", t.calls[-1]["url"])
        self.assertEqual(json.loads(t.calls[-1]["data"]["shareid_list"]), [7, 8])

    def test_share_verify_list_transfer_chain_and_cookies(self):
        holder = {}

        def h(method, url, params, data):
            if "/share/verify" in url:
                holder["verify"] = (params, data)
                return {"errno": 0, "randsk": "R4ND"}
            if "/share/list" in url:
                holder["list"] = params
                return {"errno": 0, "list": [
                    {"fs_id": 42, "isdir": 0, "path": "/f/a.bin"},
                    {"fs_id": 43, "isdir": 1, "path": "/f/d"}]}
            if "/share/transfer" in url:
                holder["transfer"] = (params, data)
                return {"errno": 0}
            return {"errno": 0}

        sess, t = make_session(h)
        api = BdnApi(sess)
        v = api.share_verify(7, 12345, "x1y2", bdstoken="b" * 32)
        self.assertEqual(v["randsk"], "R4ND")
        self.assertEqual(holder["verify"][0]["shareid"], 7)
        self.assertEqual(holder["verify"][0]["clienttype"], 1)
        self.assertEqual(holder["verify"][1]["pwd"], "x1y2")
        self.assertEqual(holder["verify"][1]["bdstoken"], "b" * 32)
        sl = api.share_list("AbC", randsk="R4ND")
        self.assertEqual(holder["list"]["shorturl"], "AbC")
        self.assertEqual(holder["list"]["channel"], "chunlei")
        cookie = [c for c in t.calls if "/share/list" in c["url"]][0]["headers"]["Cookie"]
        self.assertIn("BDCLND=R4ND", cookie)             # randsk 以 BDCLND 携带
        self.assertIn("BDUSS=", cookie)
        api.share_transfer([42], "/dst", shareid=7, share_uk=12345,
                           randsk="R4ND", bdstoken="b" * 32)
        tp, td = holder["transfer"]
        self.assertEqual(tp["channel"], "chunlei")
        self.assertEqual(tp["bdstoken"], "b" * 32)      # W5 实测：缺 bdstoken→errno 2
        # W6 蓝本全参（transfer.go:79-85）：shareid+from 必参（仅 bdstoken 仍 errno 2）
        self.assertEqual(tp["shareid"], 7)
        self.assertEqual(tp["from"], 12345)
        self.assertEqual(json.loads(td["fsidlist"]), [42])
        self.assertEqual(td["path"], "/dst")
        cookie2 = [c for c in t.calls if "/share/transfer" in c["url"]][0]["headers"]["Cookie"]
        self.assertIn("BDCLND=R4ND", cookie2)
        # list 归一由调用方（CLI）处理；引擎侧无归一要求
        self.assertEqual(sl["list"][0]["fs_id"], 42)

    def test_surl_from_link(self):
        f = BdnApi.surl_from_link
        self.assertEqual(f("https://pan.baidu.com/s/1AbCdEf"), "AbCdEf")
        self.assertEqual(f("https://pan.baidu.com/s/Xy9"), "Xy9")   # 无前导 1
        self.assertEqual(f("AbCdEf"), "AbCdEf")

    def test_mask_independence(self):
        self.assertEqual(mask("x1y2"), "<masked len=4>")


if __name__ == "__main__":
    unittest.main()
