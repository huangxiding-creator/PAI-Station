# -*- coding: utf-8 -*-
"""W5 真网络冒烟（默认 skip，设 KB_LIVE=1 才跑）。

文库 1 个词、≤12 条、频控默认值（3s/日500）；审计写包内 audit.jsonl。
"""
import os
import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))

from kb_factory.channel_adapters.base import AuditLog
from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter


@unittest.skipUnless(os.environ.get("KB_LIVE"), "live smoke: set KB_LIVE=1 to run")
class TestLiveSmoke(unittest.TestCase):
    def test_live_smoke_wenku_single_word(self):
        audit = AuditLog()  # 默认包内 audit.jsonl，冒烟即审计
        a = WenkuMetaAdapter(audit=audit)  # 默认频控：间隔3s、日上限500
        self.assertTrue(a.available())
        metas = a.metadata("水利工程EPC项目管理", 12)
        self.assertGreaterEqual(len(metas), 1, "文库免登录配方应至少命中 1 条")
        self.assertLessEqual(len(metas), 12)
        self.assertTrue(all(m.title for m in metas))
        print(f"LIVE wenku items={len(metas)} first={metas[0].title!r} "
              f"fmt={metas[0].fmt} badge={metas[0].badge} limiter={a.limiter.status()}")


if __name__ == "__main__":
    unittest.main()
