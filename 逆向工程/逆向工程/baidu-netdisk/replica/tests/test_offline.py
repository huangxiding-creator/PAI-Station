# -*- coding: utf-8 -*-
"""离线单测：节流器 / errno 映射 / JSON 归一 / 熔断器 / 退避重试 / 翻页护栏 / 凭据加载。

全部零网络：HTTP 走 FakeTransport 打桩，退避睡眠与节流时钟可注入。
运行：python -m unittest discover -s tests -v   （于 replica/ 目录）
"""
from __future__ import annotations

import json
import os
import sys
import tempfile
import unittest
from unittest import mock

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

import requests  # noqa: E402  仅用其异常类型，不发网络

from bdncore import BdnApi, BdnAuthError, BdnCircuitOpen, BdnApiError  # noqa: E402
from bdncore import Throttle, BdnSession, mask, describe  # noqa: E402
from bdncore.errors import CIRCUIT_ERRNOS  # noqa: E402
from bdncore.session import _FakeResponse  # noqa: E402


# ---------------- 桩件 ----------------

class FakeTransport:
    """记录调用并可编程返回/抛错的假 HTTP 传输层。"""

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
        return _FakeResponse(result)


def make_session(handler, creds=None):
    t = FakeTransport(handler)
    creds = creds or {"bduss": "AB-cd" * 48, "stoken": "st" * 32}
    return BdnSession(creds=creds, transport=t,
                      throttle=Throttle(min_interval=0)), t


# ---------------- errno 映射 ----------------

class TestErrnoMap(unittest.TestCase):
    def test_known_codes(self):
        self.assertIn("未登录", describe(-6))
        self.assertIn("限流", describe(20012))
        self.assertIn("配额", describe(31034))
        self.assertIn("风控", describe(31119))
        self.assertIn("内部错误", describe(12))
        self.assertIn("参数", describe(-7))
        self.assertIn("风控", describe(31329))

    def test_unknown_code(self):
        self.assertIn("未知", describe(99999))
        self.assertIn("非法", describe("abc"))

    def test_circuit_set_exact(self):
        self.assertEqual(set(CIRCUIT_ERRNOS), {31119, 31329, 20012, 31034})


# ---------------- 凭据 ----------------

class TestCredentials(unittest.TestCase):
    def _write(self, d):
        fd, path = tempfile.mkstemp(suffix=".json")
        with os.fdopen(fd, "w", encoding="utf-8") as f:
            json.dump(d, f)
        self.addCleanup(os.remove, path)
        return path

    def test_load_ok_and_cookie_keeps_dash(self):
        bduss = "Az0-" + "x" * 188          # 含 '-' 的 192 位
        path = self._write({"bduss": bduss, "stoken": "t" * 64,
                            "ua_native": "netdisk;8.2.5.103;PC"})
        sess, _ = make_session(lambda *a: {}, creds=None)
        loaded = BdnSession.load_credentials(path)
        self.assertEqual(loaded["bduss"], bduss)
        sess2 = BdnSession(creds=loaded,
                           transport=FakeTransport(lambda *a: {}),
                           throttle=Throttle(min_interval=0))
        cookie = sess2.cookie_header()
        self.assertIn(bduss, cookie)         # 整串保留，含 '-'
        self.assertTrue(cookie.startswith("BDUSS="))
        self.assertIn("STOKEN=", cookie)

    def test_missing_field_raises_auth(self):
        path = self._write({"bduss": "x" * 192})
        with self.assertRaises(BdnAuthError):
            BdnSession.load_credentials(path)

    def test_missing_file_raises_auth(self):
        with self.assertRaises(BdnAuthError):
            BdnSession.load_credentials(r"Z:\no\such\file.json")

    def test_mask_hides_value(self):
        self.assertNotIn("SECRET", mask("SECRET192"))
        self.assertIn("len=", mask("SECRET192"))


# ---------------- 会话：成功/业务错/凭据错/台账 ----------------

class TestSessionResponses(unittest.TestCase):
    def test_success_returns_payload(self):
        sess, t = make_session(lambda *a: {"errno": 0, "username": "u"})
        r = sess.get("/api/loginStatus", params={"clienttype": 8})
        self.assertEqual(r["username"], "u")
        self.assertEqual(sess.requests_sent, 1)
        self.assertEqual(t.calls[0]["headers"]["Cookie"].count("BDUSS="), 1)

    def test_business_errno_raises(self):
        sess, _ = make_session(lambda *a: {"errno": 12})
        with self.assertRaises(BdnApiError) as cm:
            sess.get("/api/x")
        self.assertEqual(cm.exception.errno, 12)
        self.assertEqual(cm.exception.exit_code, 1)

    def test_auth_errno_raises_auth(self):
        sess, _ = make_session(lambda *a: {"errno": -6})
        with self.assertRaises(BdnAuthError):
            sess.get("/api/x")

    def test_absent_errno_is_success(self):
        sess, _ = make_session(lambda *a: {"total": 1, "used": 0})
        r = sess.get("/api/quota")
        self.assertEqual(r["total"], 1)

    def test_log_has_no_credentials(self):
        sess, t = make_session(lambda *a: {"errno": 0})
        sess.get("/api/loginStatus", params={"clienttype": 8})
        entry = sess.request_log[0]
        self.assertNotIn("Cookie", entry)
        self.assertNotIn("bduss", json.dumps(entry).lower())

    def test_non_json_raises(self):
        class BadResp:
            status_code = 200
            def json(self):
                raise ValueError("no json")
        t = FakeTransport(lambda *a: {"errno": 0})
        t.request = lambda *a, **k: BadResp()
        sess = BdnSession(creds={"bduss": "a", "stoken": "b"}, transport=t,
                          throttle=Throttle(min_interval=0))
        with self.assertRaises(BdnApiError):
            sess.get("/api/x")


# ---------------- 熔断器 ----------------

class TestCircuitBreaker(unittest.TestCase):
    def _trip_session(self, errno=20012):
        state = {"n": 0}
        def handler(*a):
            state["n"] += 1
            return {"errno": errno}
        sess, t = make_session(handler)
        return sess, t, state

    def test_trip_raises_circuit(self):
        sess, _, _ = self._trip_session()
        with self.assertRaises(BdnCircuitOpen):
            sess.get("/api/list")
        self.assertTrue(sess.circuit_open)

    def test_open_blocks_all_later_calls(self):
        sess, t, state = self._trip_session()
        with self.assertRaises(BdnCircuitOpen):
            sess.get("/api/list")
        n_after_first = state["n"]
        for _ in range(3):
            with self.assertRaises(BdnCircuitOpen):
                sess.get("/api/quota")
        self.assertEqual(state["n"], n_after_first)   # 不再触网

    def test_every_circuit_errno_trips(self):
        # HOLDOUT-3（ss-judge 1029 抓雷返工后钉死）：四枚熔断码逐一验「触发即熔断+二连击零触网」
        for code in sorted(CIRCUIT_ERRNOS):
            sess, t, state = self._trip_session(code)
            with self.assertRaises(BdnCircuitOpen):
                sess.get("/api/list")
            self.assertTrue(sess.circuit_open, f"errno={code} 未开熔断")
            n = state["n"]
            with self.assertRaises(BdnCircuitOpen):
                sess.get("/api/quota")
            self.assertEqual(state["n"], n, f"errno={code} 熔断后仍在触网")

    def test_plain_business_error_does_not_trip(self):
        sess, _ = make_session(lambda *a: {"errno": 12})
        with self.assertRaises(BdnApiError):
            sess.get("/api/list")
        self.assertFalse(sess.circuit_open)


# ---------------- 退避重试 ----------------

class TestRetryBackoff(unittest.TestCase):
    def test_network_error_retries_then_success(self):
        seq = [requests.exceptions.ConnectionError("boom"),
               requests.exceptions.ConnectionError("boom2"),
               {"errno": 0, "ok": 1}]
        def handler(*a):
            item = seq.pop(0)
            if isinstance(item, Exception):
                raise item
            return item
        sess, t = make_session(handler)
        sleeps = []
        with mock.patch("bdncore.session._backoff_sleep",
                        side_effect=lambda s: sleeps.append(s)):
            r = sess.get("/api/x")
        self.assertEqual(r["ok"], 1)
        self.assertEqual(len(t.calls), 3)
        self.assertAlmostEqual(sleeps[0], 1.5)
        self.assertAlmostEqual(sleeps[1], 3.0)
        self.assertEqual(sess.requests_sent, 3)

    def test_5xx_retries(self):
        seq = [{"_status": 502}, {"errno": 0, "ok": 2}]
        def handler(*a):
            return seq.pop(0)
        t = FakeTransport(handler)
        real_request = t.request
        def wrap(method, url, **kw):
            item = handler(method, url, kw.get("params"), kw.get("data"))
            if isinstance(item, dict) and item.get("_status"):
                class R:
                    status_code = item["_status"]
                    def json(self):
                        raise ValueError()
                return R()
            return _FakeResponse(item)
        t.request = wrap
        sess = BdnSession(creds={"bduss": "a", "stoken": "b"}, transport=t,
                          throttle=Throttle(min_interval=0))
        with mock.patch("bdncore.session._backoff_sleep"):
            r = sess.get("/api/x")
        self.assertEqual(r["ok"], 2)

    def test_exhausted_raises_network_error(self):
        def handler(*a):
            raise requests.exceptions.Timeout("slow")
        sess, _ = make_session(handler)
        with mock.patch("bdncore.session._backoff_sleep"):
            with self.assertRaises(Exception) as cm:
                sess.get("/api/x")
        self.assertIn("Network", type(cm.exception).__name__)


# ---------------- 节流器 ----------------

class TestThrottle(unittest.TestCase):
    def test_interval_spacing(self):
        class Clock:
            def __init__(self):
                self.t = 1000.0
            def __call__(self):
                return self.t
        clock = Clock()
        sleeps = []
        def sleeper(d):
            sleeps.append(d)
            clock.t += d
        th = Throttle(min_interval=1.5, clock=clock, sleeper=sleeper)
        with th.slot():
            pass                          # 首发免等
        with th.slot():
            pass                          # 等 1.5
        with th.slot():
            pass                          # 再等 1.5
        self.assertEqual(sleeps, [1.5, 1.5])

    def test_concurrency_cap_two(self):
        th = Throttle(max_concurrency=2, min_interval=0)
        self.assertTrue(th._sem.acquire(blocking=False))
        self.assertTrue(th._sem.acquire(blocking=False))
        self.assertFalse(th._sem.acquire(blocking=False))   # 第三并发被拒


# ---------------- API 层参数与归一 ----------------

class TestApiLayer(unittest.TestCase):
    def _api(self, handler):
        sess, t = make_session(handler)
        return BdnApi(sess), t

    def test_list_dir_num_clamped(self):
        api, t = self._api(lambda *a: {"errno": 0, "list": []})
        api.list_dir("/", num=5000)
        self.assertEqual(t.calls[0]["params"]["num"], 1000)
        self.assertEqual(t.calls[0]["params"]["clienttype"], 8)
        self.assertTrue(t.calls[0]["url"].endswith("/api/list"))

    def test_list_dir_path_must_be_absolute(self):
        api, _ = self._api(lambda *a: {"errno": 0})
        for bad in ("abc", "", "C:/x", "分享/子目录"):
            with self.assertRaises(BdnApiError):
                api.list_dir(bad)

    def test_list_entries_normalized(self):
        api, _ = self._api(lambda *a: {"errno": 0, "list": [
            {"fs_id": 1, "path": "/a", "isdir": 1, "server_filename": "dirA"},
            {"fs_id": 2, "path": "/b.txt", "isdir": 0, "size": 12,
             "server_filename": "b.txt"}]})
        r = api.list_dir("/")
        self.assertEqual(r["entries"][0]["name"], "dirA")
        self.assertTrue(r["entries"][0]["isdir"])
        self.assertEqual(r["entries"][1]["size"], 12)

    def test_search_falls_back_to_wd_on_param_error(self):
        seq = [{"errno": -7}, {"errno": 0, "list": []}]
        def handler(m, u, params, data):
            return seq.pop(0)
        api, t = self._api(handler)
        api.search("关键词", dir_path="/")
        self.assertEqual(t.calls[0]["params"].get("key"), "关键词")
        second = t.calls[1]["params"]
        self.assertNotIn("key", second)
        self.assertEqual(second.get("wd"), "关键词")
        self.assertEqual(second.get("method"), "search")

    def test_metas_primary_info_key_and_string_isdir(self):
        api, t = self._api(lambda *a: {"errno": 0, "info": [
            {"fs_id": 7, "path": "/d", "isdir": "1", "server_filename": "d"},
            {"fs_id": 8, "path": "/f", "isdir": "0", "size": "15",
             "server_filename": "f"}]})
        r = api.metas([7, 8])
        self.assertEqual(r["_source"], "api/filemetas")
        self.assertTrue(r["entries"][0]["isdir"])       # '1' 字符串 → True
        self.assertFalse(r["entries"][1]["isdir"])      # '0' 字符串 → False
        self.assertEqual(len(t.calls), 1)               # 主通道成功不落兜底

    def test_metas_falls_back_to_xpan(self):
        seq = [{"errno": 2}, {"errno": 0, "list": []}]
        def handler(m, u, params, data):
            return seq.pop(0)
        api, t = self._api(handler)
        r = api.metas([111, 222])
        self.assertIn("filemetas", t.calls[0]["url"])
        # W1 实证 xpan/multifile 旧形态 404 已死 → W4 兜底升现行 multimedia 形态
        self.assertIn("xpan/multimedia", t.calls[1]["url"])
        self.assertEqual(t.calls[1]["params"].get("method"), "filemetas")
        self.assertEqual(json.loads(t.calls[0]["params"]["fsids"]), [111, 222])
        self.assertEqual(r["_source"], "xpan/multimedia")

    def test_share_records_camelcase_shape(self):
        api, t = self._api(lambda *a: {"errno": 0, "list": [
            {"shareId": 9, "shortlink": "https://pan.baidu.com/s/1abc",
             "typicalPath": "/x", "vCnt": 3, "dCnt": 1, "passwd": "ab12"}]})
        r = api.share_records(page=2)
        self.assertTrue(t.calls[0]["url"].endswith("/share/record"))
        self.assertEqual(t.calls[0]["params"]["order"], "time")
        self.assertEqual(t.calls[0]["params"]["desc"], 1)
        self.assertEqual(t.calls[0]["params"]["page"], 2)
        row = r["entries"][0]
        self.assertEqual(row["shareid"], 9)
        self.assertEqual(row["views"], 3)
        self.assertEqual(row["passwd"], "***")          # 提取码掩码

    def test_login_status_account_nested(self):
        api, _ = self._api(lambda *a: {"errno": 0, "login_info": {
            "username": "u1", "uk": 42, "vip_level": 8,
            "vip_type": "21", "bdstoken": "T" * 32}})
        r = api.login_status()
        self.assertEqual(r["account"]["username"], "u1")
        self.assertEqual(r["account"]["uk"], 42)
        self.assertNotIn("T" * 32, json.dumps(r["account"]))     # 令牌明文不落输出

    def test_recycle_list_shape(self):
        api, t = self._api(lambda *a: {"errno": 0, "list": [
            {"fs_id": 5, "server_filename": "del.txt"}]})
        r = api.recycle_list()
        self.assertTrue(t.calls[0]["url"].endswith("/api/recycle/list"))
        self.assertEqual(t.calls[0]["params"]["num"], 100)
        self.assertEqual(r["entries"][0]["server_filename"], "del.txt")

    def test_quota_falls_back_to_post(self):
        seq = [{"errno": 2}, {"errno": 0, "total": 5, "used": 1}]
        def handler(m, u, params, data):
            return seq.pop(0)
        api, t = self._api(handler)
        r = api.quota()
        self.assertEqual(t.calls[0]["method"], "GET")
        self.assertEqual(t.calls[1]["method"], "POST")
        self.assertEqual(r["total"], 5)

    def test_filediff_capture_shape(self):
        api, t = self._api(lambda *a: {"errno": 0, "cursor": "NEW"})
        api.filediff("OLD_CURSOR")
        c = t.calls[0]
        self.assertEqual(c["method"], "POST")
        self.assertTrue(c["url"].endswith("/api/filediff"))
        self.assertEqual(c["params"].get("block_list"), 1)
        self.assertEqual(c["data"]["cursor"], "OLD_CURSOR")
        self.assertEqual(c["data"]["action"], "manual")

    def test_tree_budget_truncation(self):
        def handler(m, u, params, data):
            d = (params or {}).get("dir", "/")
            if d == "/":
                return {"errno": 0, "list": [
                    {"fs_id": 1, "path": "/d1", "isdir": 1, "server_filename": "d1"},
                    {"fs_id": 2, "path": "/d2", "isdir": 1, "server_filename": "d2"},
                    {"fs_id": 3, "path": "/f.txt", "isdir": 0, "size": 9,
                     "server_filename": "f.txt"}]}
            return {"errno": 0, "list": [
                {"fs_id": 9, "path": d + "/inner", "isdir": 0, "size": 1,
                 "server_filename": "inner"}]}
        api, t = self._api(handler)
        out = api.tree("/", depth=3, max_requests=2)
        self.assertEqual(out["requests"], 2)
        self.assertEqual(len(t.calls), 2)
        self.assertTrue(out["truncated"])
        self.assertEqual(out["nodes"], 4)      # 根3 + 1个子目录内1

    def test_tree_depth_prune(self):
        def handler(m, u, params, data):
            return {"errno": 0, "list": [
                {"fs_id": 1, "path": "/d", "isdir": 1, "server_filename": "d"}]}
        api, _ = self._api(handler)
        out = api.tree("/", depth=1, max_requests=5)
        self.assertEqual(out["dirs"], 1)
        self.assertTrue(out["tree"][0]["children"] is None)
        self.assertTrue(out["tree"][0].get("pruned_depth"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
