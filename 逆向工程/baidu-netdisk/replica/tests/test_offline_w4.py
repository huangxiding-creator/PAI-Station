# -*- coding: utf-8 -*-
"""W4 离线单测：分块数学 / md5 / 写面参数形态 / 上传三段与断点 / 下载分片与校验 / rm 双段流。

全部零网络：控制面走 FakeTransport，数据面（superfile2/dlink）注入 fake poster/fetcher。
运行（于 replica/ 目录）：python -m unittest discover -s tests -v
"""
from __future__ import annotations

import hashlib
import json
import os
import sys
import tempfile
import unittest
from unittest import mock

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import (BdnApi, BdnApiError, BdnError, BdnSession, Throttle,  # noqa: E402
                     DownloadEngine, UploadEngine)
from bdncore.transfer import (BLOCK_MIN, DL_CHUNK, _load_json, _PartRejected,  # noqa: E402
                              block_md5s, block_ranges, choose_block_size,
                              md5_file, slice_md5_file)


# ---------------- 桩件（与 test_offline 同款） ----------------

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


def tmpfile(content: bytes) -> str:
    fd, path = tempfile.mkstemp(prefix="bdnw4_", suffix=".bin")
    with os.fdopen(fd, "wb") as f:
        f.write(content)
    return path


def _try_remove(path: str):
    try:
        os.remove(path)
    except OSError:
        pass


MB = 1024 * 1024


# ---------------- 分块与 md5 数学 ----------------

class TestBlockMath(unittest.TestCase):
    def test_block_size_thresholds(self):
        self.assertEqual(choose_block_size(1024), BLOCK_MIN)          # ≤8GB → 4MB
        self.assertEqual(choose_block_size(200 * MB), BLOCK_MIN)
        self.assertEqual(choose_block_size(9 * 2**30), 16 * MB)       # >8GB → 16MB
        self.assertEqual(choose_block_size(33 * 2**30), 64 * MB)      # >32GB → 64MB

    def test_block_ranges_shapes(self):
        r = block_ranges(10 * MB, 4 * MB)
        self.assertEqual([x[0] for x in r], [0, 1, 2])
        self.assertEqual([x[2] for x in r], [4 * MB, 4 * MB, 2 * MB])  # 尾块部分
        self.assertEqual(r[1][1], 4 * MB)                              # offset
        self.assertEqual(len(block_ranges(200 * MB, 4 * MB)), 50)      # 冒烟 d 的 50 片
        self.assertEqual(block_ranges(0, 4 * MB), [])
        self.assertEqual(block_ranges(4 * MB, 4 * MB), [(0, 0, 4 * MB)])

    def test_slice_md5_head_256k(self):
        data = os.urandom(300 * 1024)
        p = tmpfile(data)
        self.addCleanup(os.remove, p)
        self.assertEqual(slice_md5_file(p),
                         hashlib.md5(data[:256 * 1024]).hexdigest())
        self.assertEqual(md5_file(p), hashlib.md5(data).hexdigest())

    def test_slice_md5_small_file_is_whole(self):
        data = os.urandom(1024)
        p = tmpfile(data)
        self.addCleanup(os.remove, p)
        self.assertEqual(slice_md5_file(p), hashlib.md5(data).hexdigest())

    def test_block_md5s_per_range(self):
        data = os.urandom(9 * MB)
        p = tmpfile(data)
        self.addCleanup(os.remove, p)
        ranges = block_ranges(len(data), 4 * MB)
        digests = block_md5s(p, ranges)
        self.assertEqual(len(digests), 3)
        self.assertEqual(digests[0], hashlib.md5(data[:4 * MB]).hexdigest())
        self.assertEqual(digests[2], hashlib.md5(data[8 * MB:]).hexdigest())


# ---------------- 会话：跨域绝对 URL / 裸数组 ----------------

class TestSessionW4(unittest.TestCase):
    def test_absolute_url_logged_with_host(self):
        sess, t = make_session(lambda *a: {"errno": 0, "servers": []})
        sess.get("https://d.pcs.baidu.com/rest/2.0/pcs/file",
                 params={"method": "locateupload"})
        self.assertTrue(t.calls[0]["url"].startswith("https://d.pcs.baidu.com/"))
        self.assertEqual(sess.request_log[0]["path"],
                         "d.pcs.baidu.com/rest/2.0/pcs/file")

    def test_bare_array_payload_wrapped(self):
        sess, _ = make_session(lambda *a: [{"status": 2}])
        r = sess.get("/rest/2.0/xpan/task", params={"method": "querytask"})
        self.assertEqual(r["errno"], 0)
        self.assertEqual(r["_list"], [{"status": 2}])


# ---------------- 写面参数形态 ----------------

class TestWriteApiShapes(unittest.TestCase):
    def _api(self, handler):
        sess, t = make_session(handler)
        return BdnApi(sess), t

    def test_mkdir_primary_api_create(self):
        cap = {}
        def handler(m, u, params, data):
            cap.update(url=u, method=m, params=params, data=data)
            return {"errno": 0, "path": "/d", "fs_id": 1}
        api, t = self._api(handler)
        r = api.mkdir("/d")
        self.assertFalse(r["exists"])
        self.assertTrue(cap["url"].endswith("/api/create"))   # /api 家族（W4 实测）
        self.assertEqual(cap["params"]["web"], 1)
        self.assertEqual(cap["params"]["app_id"], 250528)
        self.assertEqual(cap["data"]["isdir"], 1)
        self.assertEqual(cap["data"]["rtype"], 0)
        self.assertEqual(len(t.calls), 1)

    def test_mkdir_exists_idempotent(self):
        api, t = self._api(lambda *a: {"errno": -8})
        r = api.mkdir("/d")
        self.assertTrue(r["exists"])
        self.assertEqual(r["errno"], 0)
        self.assertEqual(len(t.calls), 1)          # 幂等短路，不重试

    def test_mkdir_generic_failure_raises_honestly(self):
        # xpan 9019/pcs 假成功兜底均已拔除：失败如实抛（W4 实测教训）
        api, t = self._api(lambda *a: {"errno": 9019, "errmsg": "need verify"})
        with self.assertRaises(BdnApiError) as cm:
            api.mkdir("/d")
        self.assertEqual(cm.exception.errno, 9019)
        self.assertEqual(len(t.calls), 1)

    def _fm_capture(self, fn, cap):
        def handler(m, u, params, data):
            cap.update(url=u, params=params, data=data)
            return {"errno": 0, "info": [{"errno": 0, "path": "/x"}]}
        api, _ = self._api(handler)
        fn(api)
        self.assertTrue(cap["url"].endswith("/api/filemanager"))
        return cap

    def test_rename_shape(self):
        cap = {}
        self._fm_capture(lambda a: a.rename("/dir/a.txt", "b.txt"), cap)
        self.assertEqual(cap["params"]["opera"], "rename")
        self.assertEqual(json.loads(cap["data"]["filelist"]),
                         [{"path": "/dir/a.txt", "newname": "b.txt"}])

    def test_rename_rejects_path_in_newname(self):
        api, _ = self._api(lambda *a: {"errno": 0})
        with self.assertRaises(BdnApiError):
            api.rename("/dir/a.txt", "sub/b.txt")

    def test_move_shape_ondup_newcopy(self):
        cap = {}
        self._fm_capture(lambda a: a.move("/a.txt", "/dst"), cap)
        self.assertEqual(cap["params"]["opera"], "move")
        # 官方 OpenAPI 口径：path+dest+newname（from/to 形态实测 errno 2 已弃主位）
        self.assertEqual(json.loads(cap["data"]["filelist"]),
                         [{"path": "/a.txt", "dest": "/dst", "newname": "a.txt"}])
        self.assertEqual(cap["params"]["ondup"], "newcopy")

    def test_copy_shape(self):
        cap = {}
        self._fm_capture(lambda a: a.copy("/a.txt", "/dst/"), cap)
        self.assertEqual(cap["params"]["opera"], "copy")
        self.assertEqual(json.loads(cap["data"]["filelist"]),
                         [{"path": "/a.txt", "dest": "/dst", "newname": "a.txt"}])

    def test_delete_shape(self):
        cap = {}
        self._fm_capture(lambda a: a.delete(["/a.txt", "/b.txt"]), cap)
        self.assertEqual(cap["params"]["opera"], "delete")
        # 官方口径：filelist=纯路径数组
        self.assertEqual(json.loads(cap["data"]["filelist"]),
                         ["/a.txt", "/b.txt"])

    def test_delete_falls_back_to_path_dict_shape(self):
        seq = [{"errno": 2, "info": []},
               {"errno": 0, "info": [{"errno": 0, "path": "/a.txt"}]}]
        def handler(m, u, params, data):
            return seq.pop(0)
        api, t = self._api(handler)
        api.delete(["/a.txt"])
        self.assertEqual(json.loads(t.calls[0]["data"]["filelist"]), ["/a.txt"])
        self.assertEqual(json.loads(t.calls[1]["data"]["filelist"]),
                         [{"path": "/a.txt"}])

    def test_filemanager_per_file_errno_raises(self):
        def handler(*a):
            return {"errno": 0, "info": [{"errno": -9, "path": "/gone"}]}
        api, _ = self._api(handler)
        with self.assertRaises(BdnApiError) as cm:
            api.delete(["/gone"])
        self.assertEqual(cm.exception.errno, -9)

    def test_precreate_shape(self):
        cap = {}
        def handler(m, u, params, data):
            cap.update(params=params, data=data)
            return {"errno": 0, "return_type": 1, "uploadid": "U1",
                    "block_list": [0]}
        api, _ = self._api(handler)
        api.precreate("/f.bin", 8 * MB, ["m0", "m1"], "cm", "sm",
                      local_mtime=1700000000)
        d = cap["data"]
        self.assertEqual(d["path"], "/f.bin")
        self.assertEqual(d["size"], 8 * MB)
        self.assertEqual(d["autoinit"], 1)
        self.assertEqual(d["rtype"], 3)
        self.assertEqual(json.loads(d["block_list"]), ["m0", "m1"])
        self.assertEqual(d["content-md5"], "cm")
        self.assertEqual(d["slice-md5"], "sm")
        self.assertEqual(d["local_mtime"], 1700000000)

    def test_create_file_shape(self):
        cap = {}
        def handler(m, u, params, data):
            cap.update(params=params, data=data)
            return {"errno": 0, "fs_id": 9}
        api, _ = self._api(handler)
        api.create_file("/f.bin", 8 * MB, "U1", ["m0", "m1"])
        self.assertEqual(cap["data"]["uploadid"], "U1")
        self.assertEqual(json.loads(cap["data"]["block_list"]), ["m0", "m1"])
        self.assertEqual(cap["data"]["size"], 8 * MB)

    def test_locate_upload_normalizes(self):
        def handler(m, u, params, data):
            assert u.startswith("https://d.pcs.baidu.com/")
            assert params["method"] == "locateupload"
            return {"errno": 0, "servers": ["https://h1.example",
                                            {"server": "https://h2.example"},
                                            "junk"]}
        api, _ = self._api(handler)
        r = api.locate_upload()
        self.assertEqual(r["servers"], ["https://h1.example", "https://h2.example"])

    def test_filediff_full_template_and_no_cursor_key(self):
        cap = {}
        def handler(m, u, params, data):
            cap.update(params=params, data=data)
            return {"errno": 0, "cursor": "C1", "entries": []}
        api, _ = self._api(handler)
        api.filediff(None)
        for k in ("block_list", "clienttype", "channel", "version", "deviceid", "dname"):
            self.assertIn(k, cap["params"])       # 参数完整度门（W1 教训）
        self.assertNotIn("cursor", cap["data"])   # 冷启动不带 cursor 键
        self.assertEqual(cap["data"]["action"], "manual")
        api.filediff("OLD")
        self.assertEqual(cap["data"]["cursor"], "OLD")

    def test_filediff_bootstrap_retries_empty_cursor(self):
        seq = [{"errno": 2}, {"errno": 0, "cursor": "C1"}]
        def handler(m, u, params, data):
            return seq.pop(0)
        api, t = self._api(handler)
        r = api.filediff_bootstrap()
        self.assertEqual(r["cursor"], "C1")
        self.assertNotIn("cursor", t.calls[0]["data"])
        self.assertEqual(t.calls[1]["data"].get("cursor"), "")


# ---------------- meta_by_path ----------------

class TestMetaByPath(unittest.TestCase):
    def _handler(self, info):
        def handler(m, u, params, data):
            if u.endswith("/api/list"):
                return {"errno": 0, "list": [
                    {"fs_id": 1, "path": "/dir/sub", "isdir": 1,
                     "server_filename": "sub"},
                    {"fs_id": 5, "path": "/dir/f.bin", "isdir": 0,
                     "size": 123, "server_filename": "f.bin"}]}
            if u.endswith("/api/filemetas"):
                return {"errno": 0, "info": info}
            raise AssertionError(f"unexpected {u}")
        return handler

    def test_resolves_via_parent_ls_then_metas_dlink(self):
        sess, t = make_session(self._handler([
            {"fs_id": 5, "path": "/dir/f.bin", "isdir": 0, "size": 123,
             "md5": "abc", "dlink": "https://d.pcs/x", "server_filename": "f.bin"}]))
        api = BdnApi(sess)
        m = api.meta_by_path("/dir/f.bin", dlink=1)
        self.assertEqual(m["dlink"], "https://d.pcs/x")
        self.assertEqual(m["_fsid"], 5)
        self.assertEqual(t.calls[1]["params"]["dlink"], 1)

    def test_missing_raises_minus9(self):
        sess, _ = make_session(self._handler([]))
        api = BdnApi(sess)
        with self.assertRaises(BdnApiError) as cm:
            api.meta_by_path("/dir/nope.bin")
        self.assertEqual(cm.exception.errno, -9)


# ---------------- 上传引擎 ----------------

class TestUploadEngine(unittest.TestCase):
    def _env(self, pre_payloads, parts_ok=True, reject_first_errno=None):
        """pre_payloads: list of precreate responses（每轮弹一个）。"""
        state = {"pre": list(pre_payloads), "posted": [], "created": []}
        def handler(m, u, params, data):
            if u.endswith("/api/precreate"):
                return state["pre"].pop(0) if state["pre"] else {
                    "errno": 0, "return_type": 1, "uploadid": "UX",
                    "block_list": [0, 1]}
            if u.endswith("/api/create"):
                state["created"].append(dict(data))
                return {"errno": 0, "fs_id": 77}
            if "d.pcs.baidu.com" in u:                     # locateupload（跨域）
                return {"errno": 0, "servers": ["https://up.example"]}
            raise AssertionError(f"unexpected {u}")
        sess, t = make_session(handler)
        calls = {"n": 0}

        def poster(url, params, data, files, headers):
            calls["n"] += 1
            if reject_first_errno is not None and calls["n"] == 1:
                raise _PartRejected(reject_first_errno, {})
            blob = files["file"][1]
            state["posted"].append((params["partseq"], len(blob),
                                    params["uploadid"]))
            return {"errno": 0, "md5": hashlib.md5(blob).hexdigest()}
        eng = UploadEngine(BdnApi(sess), poster=poster)
        return eng, sess, t, state

    def test_rapid_upload_zero_transfer(self):
        eng, sess, t, state = self._env([{"errno": 0, "return_type": 2,
                                          "fs_id": 42}])
        p = tmpfile(os.urandom(1024))
        self.addCleanup(os.remove, p)
        r = eng.upload(p, "/t/a.bin")
        self.assertTrue(r["rapid"])
        self.assertEqual(r["bytes_sent"], 0)
        self.assertEqual(state["posted"], [])          # 零数据面
        self.assertEqual(state["created"], [])         # 不走 create
        self.assertEqual(len(t.calls), 1)              # 仅 precreate 一发控制面

    def test_full_upload_only_needed_parts(self):
        eng, sess, t, state = self._env([{"errno": 0, "return_type": 1,
                                          "uploadid": "U1", "block_list": [1]}])
        p = tmpfile(os.urandom(8 * MB))
        self.addCleanup(os.remove, p)
        r = eng.upload(p, "/t/b.bin")
        self.assertFalse(r["rapid"])
        self.assertEqual([x[0] for x in state["posted"]], [1])   # 只传待传序号
        self.assertEqual(state["posted"][0][2], "U1")
        self.assertEqual(r["bytes_sent"], 4 * MB)
        self.assertEqual(state["created"][0]["uploadid"], "U1")
        self.assertFalse(os.path.exists(p + ".bdn_upload_state.json"))  # 完成清状态

    def test_resume_skips_precreate(self):
        p = tmpfile(os.urandom(8 * MB))
        self.addCleanup(os.remove, p)
        md5 = md5_file(p)
        with open(p + ".bdn_upload_state.json", "w", encoding="utf-8") as f:
            json.dump({"remote": "/t/c.bin", "size": 8 * MB,
                       "content_md5": md5, "block_size": BLOCK_MIN,
                       "uploadid": "U9", "done": [0]}, f)
        self.addCleanup(lambda: _try_remove(p + ".bdn_upload_state.json"))
        eng, sess, t, state = self._env([])
        r = eng.upload(p, "/t/c.bin")
        self.assertTrue(r["resumed"])
        pre_calls = [c for c in t.calls if c["url"].endswith("/api/precreate")]
        self.assertEqual(pre_calls, [])               # 断点命中→不重 precreate
        self.assertEqual([x[0] for x in state["posted"]], [1])  # 只补缺片
        self.assertEqual(state["created"][0]["uploadid"], "U9")

    def test_state_mismatch_triggers_fresh_precreate(self):
        p = tmpfile(os.urandom(8 * MB))
        self.addCleanup(os.remove, p)
        with open(p + ".bdn_upload_state.json", "w", encoding="utf-8") as f:
            json.dump({"remote": "/t/other.bin", "size": 999,
                       "content_md5": "x", "block_size": BLOCK_MIN,
                       "uploadid": "U9", "done": [0]}, f)
        self.addCleanup(lambda: _try_remove(p + ".bdn_upload_state.json"))
        eng, sess, t, state = self._env([{"errno": 0, "return_type": 1,
                                          "uploadid": "U2", "block_list": [0, 1]}])
        r = eng.upload(p, "/t/c.bin")
        self.assertFalse(r["resumed"])
        self.assertEqual(sorted(x[0] for x in state["posted"]), [0, 1])

    def test_part_reject_restarts_precreate(self):
        # 首片被拒 errno=2（uploadid 失效形态）→ 兜底重走 precreate 全量重传
        eng, sess, t, state = self._env([
            {"errno": 0, "return_type": 1, "uploadid": "U1", "block_list": [0, 1]},
            {"errno": 0, "return_type": 1, "uploadid": "U2", "block_list": [0, 1]}],
            reject_first_errno=2)
        p = tmpfile(os.urandom(8 * MB))
        self.addCleanup(os.remove, p)
        r = eng.upload(p, "/t/d.bin")
        pre_calls = [c for c in t.calls if c["url"].endswith("/api/precreate")]
        self.assertEqual(len(pre_calls), 2)
        self.assertEqual(r["uploadid"], "U2")
        # 被拒那片不记 posted；另一片可能已在飞完成。不变量：总实传=3 次且两片均覆盖
        # （哪片先撞拒绝与并发完成序均不定）
        self.assertEqual(len(state["posted"]), 3)
        self.assertEqual(set(x[0] for x in state["posted"]), {0, 1})
        self.assertEqual(state["created"][0]["uploadid"], "U2")


# ---------------- 下载引擎 ----------------

class TestDownloadEngine(unittest.TestCase):
    def _make(self, total, md5_of_content):
        def handler(m, u, params, data):
            if u.endswith("/api/list"):
                return {"errno": 0, "list": [
                    {"fs_id": 5, "path": "/t/f.bin", "isdir": 0,
                     "size": total, "server_filename": "f.bin"}]}
            if u.endswith("/api/filemetas"):
                return {"errno": 0, "info": [
                    {"fs_id": 5, "path": "/t/f.bin", "isdir": 0, "size": total,
                     "md5": md5_of_content, "dlink": "https://d.example/dl",
                     "server_filename": "f.bin"}]}
            raise AssertionError(f"unexpected {u}")
        sess, t = make_session(handler)
        return sess, t

    def _fetcher_from(self, blob, log):
        def fetcher(url, start, end, headers):
            log.append({"url": url, "range": (start, end),
                        "ua": headers["User-Agent"], "cookie": "BDUSS=" in headers["Cookie"]})
            return 206, blob[start:end + 1]
        return fetcher

    def test_download_assembles_and_verifies(self):
        blob = os.urandom(5 * MB)                       # 2 块：4MB+1MB
        md5 = hashlib.md5(blob).hexdigest()
        sess, t = self._make(len(blob), md5)
        log = []
        eng = DownloadEngine(BdnApi(sess), fetcher=self._fetcher_from(blob, log))
        dst = os.path.join(tempfile.gettempdir(), "bdnw4_dl_ok.bin")
        self.addCleanup(os.remove, dst)
        r = eng.download("/t/f.bin", dst)
        self.assertEqual(r["size"], len(blob))
        self.assertEqual(r["chunks_total"], 2)
        self.assertEqual(r["data_requests"], 2)
        self.assertEqual(r["bytes_received"], len(blob))
        self.assertTrue(r["md5_ok"])
        with open(dst, "rb") as f:
            self.assertEqual(f.read(), blob)
        for e in log:                                   # 浏览器 UA + Cookie 带凭据
            self.assertTrue(e["ua"].startswith("Mozilla/5.0"))
            self.assertTrue(e["cookie"])
        self.assertFalse(os.path.exists(dst + ".bdn_dl_state.json"))

    def test_download_resume_skips_done_chunk(self):
        blob = os.urandom(5 * MB)
        md5 = hashlib.md5(blob).hexdigest()
        sess, _ = self._make(len(blob), md5)
        log = []
        dst = os.path.join(tempfile.gettempdir(), "bdnw4_dl_resume.bin")
        self.addCleanup(os.remove, dst)
        with open(dst, "wb") as f:                       # 预存在部分文件
            f.write(blob[:4 * MB])
        with open(dst + ".bdn_dl_state.json", "w", encoding="utf-8") as f:
            json.dump({"remote": "/t/f.bin", "total": len(blob),
                       "chunk": DL_CHUNK, "done": [0], "md5": md5}, f)
        def _rm_state():
            try:
                os.remove(dst + ".bdn_dl_state.json")     # 引擎完成后可能已删
            except OSError:
                pass
        self.addCleanup(_rm_state)
        eng = DownloadEngine(BdnApi(sess), fetcher=self._fetcher_from(blob, log))
        r = eng.download("/t/f.bin", dst)
        self.assertEqual(r["chunks_this_run"], 1)
        self.assertEqual([e["range"] for e in log], [(4 * MB, 5 * MB - 1)])
        self.assertTrue(r["md5_ok"])
        with open(dst, "rb") as f:
            self.assertEqual(f.read(), blob)

    def test_download_md5_mismatch_raises(self):
        blob = os.urandom(5 * MB)
        sess, _ = self._make(len(blob), "0" * 32)        # 远端 md5 故意错
        eng = DownloadEngine(BdnApi(sess),
                             fetcher=self._fetcher_from(blob, []))
        dst = os.path.join(tempfile.gettempdir(), "bdnw4_dl_bad.bin")
        def _rm():
            try:
                os.remove(dst)
                os.remove(dst + ".bdn_dl_state.json")
            except OSError:
                pass
        self.addCleanup(_rm)
        with self.assertRaises(BdnError) as cm:
            eng.download("/t/f.bin", dst)
        self.assertIn("md5", str(cm.exception))


# ---------------- CLI：rm 双段流 / mkdir ----------------

class TestCliW4(unittest.TestCase):
    def _patch_session(self, handler):
        sess, t = make_session(handler)
        return sess, t

    def test_rm_without_confirm_exit3_no_delete(self):
        def handler(m, u, params, data):
            if u.endswith("/api/list"):
                return {"errno": 0, "list": [
                    {"fs_id": 9, "path": "/API复刻测试_1029/x.bin", "isdir": 0,
                     "size": 1024, "server_filename": "x.bin"}]}
            raise AssertionError(f"unexpected write call: {u}")
        sess, t = self._patch_session(handler)
        import bdn
        with mock.patch.object(bdn, "BdnSession", lambda **kw: sess):
            rc = bdn.main(["rm", "/API复刻测试_1029/x.bin", "--json"])
        self.assertEqual(rc, 3)
        writes = [c for c in t.calls if "filemanager" in c["url"]]
        self.assertEqual(writes, [])                    # 未执行任何删除

    def test_rm_with_confirm_deletes_after_listing(self):
        def handler(m, u, params, data):
            if u.endswith("/api/list"):
                return {"errno": 0, "list": [
                    {"fs_id": 9, "path": "/API复刻测试_1029/x.bin", "isdir": 0,
                     "size": 1024, "server_filename": "x.bin"}]}
            if u.endswith("/api/filemanager"):
                return {"errno": 0, "info": [{"errno": 0,
                                              "path": "/API复刻测试_1029/x.bin"}]}
            raise AssertionError(f"unexpected {u}")
        sess, t = self._patch_session(handler)
        import bdn
        with mock.patch.object(bdn, "BdnSession", lambda **kw: sess):
            rc = bdn.main(["rm", "/API复刻测试_1029/x.bin", "--json", "--confirm"])
        self.assertEqual(rc, 0)
        del_calls = [c for c in t.calls if c["url"].endswith("/api/filemanager")]
        self.assertEqual(len(del_calls), 1)
        self.assertEqual(del_calls[0]["params"]["opera"], "delete")
        self.assertEqual(json.loads(del_calls[0]["data"]["filelist"]),
                         ["/API复刻测试_1029/x.bin"])    # 官方口径：纯路径数组

    def test_mkdir_cli_channel(self):
        sess, t = self._patch_session(lambda *a: {"errno": 0, "path": "/d"})
        import bdn
        with mock.patch.object(bdn, "BdnSession", lambda **kw: sess):
            rc = bdn.main(["mkdir", "/d", "--json"])
        self.assertEqual(rc, 0)
        self.assertTrue(t.calls[0]["url"].endswith("/api/create"))


if __name__ == "__main__":
    unittest.main(verbosity=2)
