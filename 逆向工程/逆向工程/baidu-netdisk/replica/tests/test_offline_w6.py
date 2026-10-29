# -*- coding: utf-8 -*-
"""W6 离线单测：judge 4 项修正的回归件。

- share-cancel 属主护栏（FakeTransport：非自建拒发退出 3 / 自建放行）；
- mirror 远端目标护栏（/ 与一级根目录拒绝；--allow-root 放行；零请求发出）；
- 归档清洗器 scrub（URL pwd 掩码 / 已掩码保持 / 凭据字段 / .orig 幂等）。
零网络。运行（于 replica/ 目录）：python -m unittest discover -s tests -v
"""
from __future__ import annotations

import importlib.util
import json
import os
import sys
import tempfile
import unittest
from types import SimpleNamespace

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

import bdn as bdn_cli                                    # noqa: E402
from bdncore import BdnApi, BdnApiError, BdnSession, RoutedApi, Throttle  # noqa: E402

# scrub.py 住在 _diag_archive（数据目录，非包）→ 按路径加载
_SCRUB_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                           "_diag_archive", "scrub.py")
_spec = importlib.util.spec_from_file_location("diag_scrub", _SCRUB_PATH)
scrub = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(scrub)


# ---------------- 桩件（与 test_offline_w5 同款） ----------------

class FakeTransport:
    def __init__(self, handler):
        self.handler = handler
        self.calls = []

    def request(self, method, url, params=None, data=None, headers=None, timeout=None):
        self.calls.append({"method": method, "url": url,
                           "params": dict(params or {}),
                           "data": dict(data) if data else data})
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


SHARE_RECORDS = {"errno": 0, "list": [
    {"shareId": 7, "shortlink": "https://pan.baidu.com/s/1Xy", "typicalPath": "/f/a",
     "passwd": "abcd"},
    {"shareId": 9, "shortlink": "https://pan.baidu.com/s/1Zz", "typicalPath": "/f/b",
     "passwd": ""}]}


def _api(handler=None):
    def h(method, url, params, data):
        if "/share/record" in url:
            return SHARE_RECORDS
        return {"errno": 0}
    sess, t = make_session(handler or h)
    return RoutedApi(BdnApi(sess)), t


def _args(**kw):
    return SimpleNamespace(json=True, **kw)


# ---------------- judge #1：share-cancel 属主护栏 ----------------

class TestShareCancelOwnerGuard(unittest.TestCase):

    def test_foreign_shareid_rejected_no_cancel_sent(self):
        api, t = _api()
        rc = bdn_cli.cmd_share_cancel(api, _args(shareids=[65048642201]))
        self.assertEqual(rc, 3)                          # 退出码 3（对齐 rm 语义）
        cancels = [c for c in t.calls if "/share/cancel" in c["url"]]
        self.assertEqual(len(cancels), 0)                # 零取消请求发出
        self.assertEqual(len(t.calls), 1)                # 只发了属主校验的 record 拉取
        self.assertIn("/share/record", t.calls[0]["url"])

    def test_mixed_ids_all_must_be_owned(self):
        api, t = _api()
        rc = bdn_cli.cmd_share_cancel(api, _args(shareids=[7, 12345]))
        self.assertEqual(rc, 3)                          # 混入任一非自建 → 整体拒发
        self.assertEqual(len([c for c in t.calls if "/share/cancel" in c["url"]]), 0)

    def test_owned_shareid_cancel_sent(self):
        api, t = _api()
        rc = bdn_cli.cmd_share_cancel(api, _args(shareids=[7, 9]))
        self.assertEqual(rc, 0)
        cancels = [c for c in t.calls if "/share/cancel" in c["url"]]
        self.assertEqual(len(cancels), 1)
        self.assertEqual(json.loads(cancels[0]["data"]["shareid_list"]), [7, 9])


# ---------------- judge #3：mirror 远端目标护栏 ----------------

class TestMirrorRemoteGuard(unittest.TestCase):

    def test_root_rejected(self):
        with self.assertRaises(BdnApiError):
            bdn_cli.guard_mirror_remote("/", allow_root=False)

    def test_first_level_rejected(self):
        for remote in ("/备份", "/data"):
            with self.assertRaises(BdnApiError):
                bdn_cli.guard_mirror_remote(remote, allow_root=False)

    def test_deep_path_passes(self):
        bdn_cli.guard_mirror_remote("/API复刻测试_1029/mirror_test", allow_root=False)

    def test_allow_root_flag_passes(self):
        bdn_cli.guard_mirror_remote("/", allow_root=True)
        bdn_cli.guard_mirror_remote("/备份", allow_root=True)

    def test_cmd_mirror_guard_fires_before_any_request(self):
        api, t = _api()
        with self.assertRaises(BdnApiError):
            bdn_cli.cmd_mirror(api, _args(local="X:/nope", remote="/备份",
                                          dry_run=True, allow_root=False))
        self.assertEqual(len(t.calls), 0)                # 零请求（纯客户端判定）

    def test_relative_path_rejected(self):
        with self.assertRaises(BdnApiError):
            bdn_cli.guard_mirror_remote("backup/dir", allow_root=False)


# ---------------- judge #2：归档清洗器 ----------------

class TestScrub(unittest.TestCase):

    def test_url_pwd_masked(self):
        obj = {"qrcodeurl": "https://pan.baidu.com/api/wechat/qrcode"
                           "?shorturl=1Xy&clienttype=7&channel=&pwd=w5dr"
                           "&imagetype=0&from_src=netdisk_share_qr"}
        new, n, hits = scrub.scrub_payload(obj)
        self.assertEqual(n, 1)
        self.assertIn("&pwd=***&", new["qrcodeurl"])
        self.assertIn("shorturl=1Xy", new["qrcodeurl"])  # 其余查询参数不动
        self.assertTrue(hits)

    def test_already_masked_fields_kept(self):
        obj = {"pwd": "***", "pwd_masked": "<masked len=4>"}
        new, n, _ = scrub.scrub_payload(obj)
        self.assertEqual(n, 0)                           # 既有掩码保持，零替换
        self.assertEqual(new, obj)

    def test_plaintext_pwd_field_masked(self):
        new, n, hits = scrub.scrub_payload({"passwd": "w5dr"})
        self.assertEqual((new["passwd"], n), ("***", 1))

    def test_cred_field_masked_with_warning(self):
        new, n, hits = scrub.scrub_payload({"bdstoken": "b" * 32})
        self.assertEqual(new["bdstoken"], "***")
        self.assertEqual(n, 1)

    def test_scrub_file_keeps_orig_idempotent(self):
        d = tempfile.mkdtemp(prefix="bdnw6scrub_")
        try:
            p = os.path.join(d, "x.json")
            with open(p, "w", encoding="utf-8") as f:
                json.dump({"qrcodeurl": "https://q/?pwd=leak"}, f)
            row = scrub.scrub_file(p)
            self.assertEqual(row["replacements"], 1)
            self.assertTrue(row["rewritten"])
            self.assertTrue(os.path.exists(p + ".orig"))    # 原件仅此一份
            with open(p, encoding="utf-8") as f:
                self.assertIn("pwd=***", json.load(f)["qrcodeurl"])
            with open(p + ".orig", encoding="utf-8") as f:
                self.assertIn("pwd=leak", json.load(f)["qrcodeurl"])  # 原件原样
            row2 = scrub.scrub_file(p)                       # 二跑=干净幂等
            self.assertEqual(row2["replacements"], 0)
            with open(p + ".orig", encoding="utf-8") as f:   # .orig 不被覆盖
                self.assertIn("pwd=leak", json.load(f)["qrcodeurl"])
        finally:
            import shutil
            shutil.rmtree(d, ignore_errors=True)


if __name__ == "__main__":
    unittest.main()
