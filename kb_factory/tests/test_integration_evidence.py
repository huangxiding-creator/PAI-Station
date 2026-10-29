# -*- coding: utf-8 -*-
"""W3 集成接线测试：evidence 链全链（expand→harvest→tree→CLI 子进程真入口）。

验收口径（任务钉死）：
  1. FakeAdapter（ChannelAdapter 契约形状，零网络，mock 真实名）注入收割层 →
     全链跑通，real_file_ratio==1.0（树槽全由真实元数据供弹=全真锚）。
  2. CLI 以 subprocess 走 `py -3 -m kb_factory.evidence_cli` 真入口（非进程内直调）。
  3. engine 接线三态：默认关=既有输出逐字节零漂移（与 test_wiring_gates.PINNED
     同源钉子）；开（传参/env KB_EVIDENCE_TREE）= evidence 链替代 taxonomy 主链；
     链上无果如实降级 taxonomy。
  4. 零造假：检索 0 件 → CLI 退出码 1 + 如实计 0（不产树不编造）。

契约替身：W1/W2 并行开发未落地时，stub pool/evidence_tree 经
KB_EVIDENCE_CHAIN_DIR 针位装载（钉死接口的最小实现）；真模块落地后另有
KB_LIVE 门的真链冒烟腿（缺席如实 skip，不打真网络）。
"""
import hashlib
import json
import os
import subprocess
import sys
import tempfile
import unittest
from dataclasses import asdict
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # 仓库根入 sys.path

from kb_factory.catalog_engine import build_blueprint
from kb_factory.catalog_engine.blueprint import canonical_json
from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta
from kb_factory import evidence_cli

REPO_ROOT = Path(__file__).resolve().parents[2]

NEED_LAW = {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规", "尽职调查", "劳动争议"],
            "intent": "诉讼与合规", "size_hint": "medium"}
SENT_WATER = "给水利工程公司建一个EPC行业知识库"

# 零漂移钉子：与 catalog_engine/tests/test_wiring_gates.py PINNED_LAW_NONE 同源同值
# （tax-law-None 全开关关，1025 采集；获准变更须两处同步注明）
PINNED_LAW_NONE = "dc2f8e5488321748db48bbabfd52776c2a641cd750a990fe91fab93467ea8fd5"

# 测试涉 env 开关全集（前后如实保存/复位，互不外泄）
_SWITCHES = ("KB_EVIDENCE_CHAIN_DIR", "KB_EVIDENCE_HARVEST_MODULE", "KB_EVIDENCE_TREE",
             "KB_PURPOSE", "KB_COLD_EXPAND", "KB_TAXONOMY_GATE", "KB_VIEWS", "KB_GUIDED_LAYER")

# ── 契约替身源码（写入临时目录，KB_EVIDENCE_CHAIN_DIR 针位装载）──────────────

STUB_POOL = '''\
# -*- coding: utf-8 -*-
"""契约替身 pool（W2 钉死接口 harvest_pool→{channel:[FileMeta dict]} 的最小实现）。"""


def expand_queries(text):
    """确定性查询扩展：原文 + 规范腿 + 案例腿（3 查）。"""
    return [text, text + "·规范", text + "·案例"]


def harvest_pool(queries):
    """契约收割（故意不收 channels 关键字——供 CLI 的 TypeError 宽容退路实测）。"""
    items = []
    for i, _q in enumerate(queries):
        for j in range(2):
            items.append({"title": f"真调研题录{i}-{j}·水利EPC工程", "fmt": "pdf",
                          "pages": 30 + j, "badge": "green_free", "perm": "green",
                          "source_url": None, "extra": {"doc_id": f"stub{i}{j}"}})
    return {"stubch": items}
'''

STUB_TREE = '''\
# -*- coding: utf-8 -*-
"""契约替身 evidence_tree（W1 钉死接口 build_evidence_tree 的最小实现：
metas 全真实锚 real=True——真实链语义=树槽全由真实元数据供弹）。"""


def build_evidence_tree(text, metas_flat, need=None):
    if not metas_flat:
        return None  # 检索不足不建树（零造假，与真实链同语义）
    files = []
    for i, m in enumerate(metas_flat, 1):
        files.append({"name": "%03d-%s.%s" % (i, m["title"], m["fmt"]),
                      "tier": "core", "ext": m["fmt"], "real": True,
                      "badge": m.get("badge", "green_free"),
                      "perm": m.get("perm", "green")})
    l2 = {"code": "EV-01/01", "dir": "01", "path": "EV-01/01/",
          "name": "真调研供弹组·" + (metas_flat[0].get("channel") or "?"),
          "theme": "真实调研元数据供弹",
          "file_count": len(files), "files": files}
    l1 = {"code": "EV", "dir": "EV-01", "path": "EV-01/", "name": "真调研层",
          "theme": "t", "source": "evidence", "l2": [l2]}
    domain = (need or {}).get("domain") or text[:12]
    return {"domain": domain, "need": need,
            "tree": {"mode": "evidence", "root": domain, "l1": [l1]},
            "ratio": {"core": 100, "field": 0, "guide": 0},
            "stats": {"files": len(files), "gb": 0.01, "l1_count": 1, "l2_count": 1,
                      "dir_count": 1, "split_dir_count": 0},
            "quote": {"base": 29.0, "per_gb": 2.0, "total": 29.0},
            "provenance": {"engine_version": "evidence-stub/1.0", "stage_log": []}}
'''

# 子进程针位收割件：FakeAdapter 真实契约形状（ChannelAdapter 子类 + FileMeta dict）
FAKE_HARVEST_MOD = '''\
# -*- coding: utf-8 -*-
"""测试针位收割件：FakeAdapter（ChannelAdapter 契约形状，零网络，mock 真实名）。"""
from dataclasses import asdict

from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta

_TITLES = [("水利工程EPC总承包合同范本", "pdf"), ("水利水电工程施工组织设计指南", "doc")]


class FakeAdapter(ChannelAdapter):
    channel = "fakech"

    def metadata(self, query, limit):
        out = []
        for i, (t, f) in enumerate(_TITLES[:limit]):
            out.append(asdict(FileMeta(title=f"{t}·{query[:6]}", fmt=f, pages=40 + i,
                                       badge="green_free", perm="green",
                                       source_url=None, extra={"doc_id": f"fx{i}"})))
        return out


def harvest(queries, channels=None):
    """契约形状 {channel: [FileMeta dict]}；另混一路 otherch 供 --channels 过滤实测。"""
    ad = FakeAdapter()
    metas = []
    for q in queries:
        metas.extend(ad.metadata(q, 2))
    return {"fakech": metas, "otherch": metas[:2]}
'''


def _real_chain_present() -> bool:
    """真契约模块（W1/W2）是否已落地（在场时缺席腿 skip、真链腿走 KB_LIVE 门）。"""
    saved = {k: os.environ.pop(k, None) for k in ("KB_EVIDENCE_CHAIN_DIR",)}
    try:
        pool_mod, tree_mod, _ = evidence_cli.load_chain()
    finally:
        for k, v in saved.items():
            if v is not None:
                os.environ[k] = v
    return pool_mod is not None and tree_mod is not None


class _EnvCase(unittest.TestCase):
    """开关环境隔离基类：每用例前清空、测后复原（互不外泄）。"""

    def setUp(self):
        self._saved = {k: os.environ.get(k) for k in _SWITCHES}
        for k in _SWITCHES:
            os.environ.pop(k, None)
        self.addCleanup(self._restore)

    def _restore(self):
        for k, v in self._saved.items():
            if v is None:
                os.environ.pop(k, None)
            else:
                os.environ[k] = v


class TestBuildEvidenceInProcess(_EnvCase):
    """进程内全链：expand → harvest_pool（stub）→ build_evidence_tree → 记账。"""

    def setUp(self):
        super().setUp()
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        d = Path(self.tmp.name)
        (d / "pool.py").write_text(STUB_POOL, encoding="utf-8")
        (d / "evidence_tree.py").write_text(STUB_TREE, encoding="utf-8")
        os.environ["KB_EVIDENCE_CHAIN_DIR"] = str(d)

    def test_full_chain_pool_size_ratio_and_accounting(self):
        bp = evidence_cli.build_evidence_blueprint(SENT_WATER)
        self.assertIsNotNone(bp)
        self.assertEqual(bp["tree"]["mode"], "evidence")
        ev = bp["provenance"]["evidence"]
        self.assertEqual(ev["pool_size"], 6)          # 3 查 × 2 条（stub 契约收割）
        self.assertEqual(ev["real_file_ratio"], 1.0)  # 树槽全真锚（mock 真实名）
        self.assertEqual(ev["channels"], {"stubch": 6})
        self.assertEqual(len(ev["queries"]), 3)       # expand_queries 真跑（非原文单查）
        self.assertEqual(ev["expander"], "pool.expand_queries")
        self.assertIn("Se evidence 链", "".join(bp["provenance"]["stage_log"]))

    def test_harvest_injection_fake_adapter(self):
        """FakeAdapter 注入收割层（零网络），契约形状直通建树。"""
        from dataclasses import asdict as _asdict

        class FakeAdapter(ChannelAdapter):
            channel = "fakech"

            def metadata(self, query, limit):
                titles = [("水利工程EPC总承包合同范本", "pdf"),
                          ("EPC工程总承包项目管理实务", "pdf")]
                return [_asdict(FileMeta(title=t, fmt=f, pages=50, badge="green_free",
                                         perm="green", source_url=None,
                                         extra={"doc_id": f"fx{i}"}))
                        for i, (t, f) in enumerate(titles[:limit])]

        def fake_harvest(queries, channels=None):
            ad = FakeAdapter()
            metas = []
            for q in queries:
                metas.extend(ad.metadata(q, 2))
            return {ad.channel: metas}

        bp = evidence_cli.build_evidence_blueprint(SENT_WATER, harvest=fake_harvest)
        self.assertIsNotNone(bp)
        ev = bp["provenance"]["evidence"]
        self.assertEqual(ev["pool_size"], 6)
        self.assertEqual(ev["real_file_ratio"], 1.0)  # 任务钉死断言
        # 渠道锚注入实测：{channel:[…]} 拍平后 W1 式建树仍读得到渠道（不丢归属）
        l2_names = [l2["name"] for l1 in bp["tree"]["l1"] for l2 in l1["l2"]]
        self.assertTrue(any("fakech" in n for n in l2_names), l2_names)

    def test_zero_pool_returns_none_honestly(self):
        """检索 0 件 → 不产树（如实计 0，禁编造）。"""
        bp = evidence_cli.build_evidence_blueprint(SENT_WATER, harvest=lambda q, channels=None: {})
        self.assertIsNone(bp)


class TestCLISubprocess(_EnvCase):
    """CLI 子进程真入口：py -3 -m kb_factory.evidence_cli（expand→harvest→tree→落盘）。"""

    def setUp(self):
        super().setUp()
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        d = Path(self.tmp.name)
        (d / "pool.py").write_text(STUB_POOL, encoding="utf-8")
        (d / "evidence_tree.py").write_text(STUB_TREE, encoding="utf-8")
        self.harvest_mod = d / "fake_harvest.py"
        self.harvest_mod.write_text(FAKE_HARVEST_MOD, encoding="utf-8")
        os.environ["KB_EVIDENCE_CHAIN_DIR"] = str(d)
        os.environ["KB_EVIDENCE_HARVEST_MODULE"] = f"{self.harvest_mod}::harvest"
        self.out = d / "out.json"

    def _run(self, *extra):
        env = dict(os.environ)
        env["PYTHONIOENCODING"] = "utf-8"
        return subprocess.run(
            [sys.executable, "-m", "kb_factory.evidence_cli", SENT_WATER,
             "-o", str(self.out), *extra],
            capture_output=True, text=True, encoding="utf-8", errors="replace",
            cwd=str(REPO_ROOT), env=env, timeout=180)

    def test_cli_channels_filter_and_summary(self):
        r = self._run("--channels", "fakech")
        self.assertEqual(r.returncode, 0, r.stdout + r.stderr)
        data = json.loads(self.out.read_text(encoding="utf-8"))
        ev = data["provenance"]["evidence"]
        self.assertEqual(ev["pool_size"], 6)           # otherch 2 条被白名单如实滤除
        self.assertEqual(ev["real_file_ratio"], 1.0)   # 任务钉死断言（mock 真实名全真锚）
        self.assertEqual(ev["channels"], {"fakech": 6})
        self.assertIn("pool_size=6", r.stdout)         # provenance 摘要（任务口径）
        self.assertIn("real_file_ratio=1.00", r.stdout)
        self.assertIn("fakech=6", r.stdout)            # 各渠道数
        self.assertIn("测试针位生效", r.stdout)         # 针位透明告知（可审计）

    def test_cli_no_channels_keeps_all_channels(self):
        r = self._run()
        self.assertEqual(r.returncode, 0, r.stdout + r.stderr)
        data = json.loads(self.out.read_text(encoding="utf-8"))
        ev = data["provenance"]["evidence"]
        self.assertEqual(ev["pool_size"], 8)           # fakech 6 + otherch 2（全渠道）
        self.assertEqual(ev["channels"], {"fakech": 6, "otherch": 2})
        self.assertEqual(ev["real_file_ratio"], 1.0)

    def test_cli_zero_pool_exit_1_honest(self):
        """收割 0 件 → 退出码 1 + 如实计 0（不落树不编造）。"""
        empty = Path(self.tmp.name) / "empty_harvest.py"
        empty.write_text(
            "# -*- coding: utf-8 -*-\n"
            "def harvest(queries, channels=None):\n"
            "    return {}\n", encoding="utf-8")
        os.environ["KB_EVIDENCE_HARVEST_MODULE"] = f"{empty}::harvest"
        out_empty = Path(self.tmp.name) / "empty.json"
        env = dict(os.environ)
        env["PYTHONIOENCODING"] = "utf-8"
        r = subprocess.run(
            [sys.executable, "-m", "kb_factory.evidence_cli", SENT_WATER,
             "-o", str(out_empty)],
            capture_output=True, text=True, encoding="utf-8", errors="replace",
            cwd=str(REPO_ROOT), env=env, timeout=180)
        self.assertEqual(r.returncode, 1)
        self.assertIn("pool_size=0", r.stdout)          # 如实计 0
        self.assertFalse(out_empty.exists())            # 不产树


class TestEngineWiring(_EnvCase):
    """engine.build_blueprint evidence 接线三态 + 零漂移钉子。"""

    def setUp(self):
        super().setUp()
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        d = Path(self.tmp.name)
        (d / "pool.py").write_text(STUB_POOL, encoding="utf-8")
        (d / "evidence_tree.py").write_text(STUB_TREE, encoding="utf-8")
        self.chain_dir = str(d)

    def test_default_off_zero_drift_pinned(self):
        """默认关=既有输出逐字节零漂移（test_engine/test_wiring_gates 钉子原值过）。"""
        bp = build_blueprint(NEED_LAW, mode="taxonomy")
        self.assertEqual(hashlib.sha256(canonical_json(bp).encode("utf-8")).hexdigest(),
                         PINNED_LAW_NONE)
        # 显式 False 同值（缺省与显式关逐字节一致）
        bp2 = build_blueprint(NEED_LAW, mode="taxonomy", evidence=False)
        self.assertEqual(canonical_json(bp), canonical_json(bp2))

    def test_evidence_on_replaces_taxonomy_chain(self):
        """开（显式传参）→ evidence 链替代 taxonomy 主链（真调研供弹记账在档）。"""
        os.environ["KB_EVIDENCE_CHAIN_DIR"] = self.chain_dir
        bp = build_blueprint(NEED_LAW, mode="taxonomy", evidence=True)
        self.assertEqual(bp["tree"]["mode"], "evidence")
        self.assertEqual(bp["provenance"]["evidence"]["pool_size"], 6)
        self.assertEqual(bp["provenance"]["evidence"]["real_file_ratio"], 1.0)
        self.assertIn("lint", bp["provenance"])        # 统一出口 lint 门照跑

    def test_evidence_env_switch(self):
        """env KB_EVIDENCE_TREE=1 + 缺省传参 → evidence 链（env 开关生效）。"""
        os.environ["KB_EVIDENCE_CHAIN_DIR"] = self.chain_dir
        os.environ["KB_EVIDENCE_TREE"] = "1"
        bp = build_blueprint(NEED_LAW, mode="taxonomy")
        self.assertEqual(bp["tree"]["mode"], "evidence")

    def test_evidence_explicit_false_overrides_env(self):
        """显式 False 压过 env=1（三态口径同 guided/views）。"""
        os.environ["KB_EVIDENCE_CHAIN_DIR"] = self.chain_dir
        os.environ["KB_EVIDENCE_TREE"] = "1"
        bp = build_blueprint(NEED_LAW, mode="taxonomy", evidence=False)
        self.assertNotEqual(bp["tree"]["mode"], "evidence")

    @unittest.skipIf(_real_chain_present(), "真契约模块已落地（此腿将打真网络；真链验证走 KB_LIVE 门）")
    def test_evidence_degrades_to_taxonomy_when_chain_absent(self):
        """契约模块缺席 → 如实降级 taxonomy 兜底（不崩不编造）。"""
        bp = build_blueprint(NEED_LAW, mode="taxonomy", evidence=True)
        self.assertNotEqual(bp["tree"]["mode"], "evidence")
        self.assertEqual(hashlib.sha256(canonical_json(bp).encode("utf-8")).hexdigest(),
                         PINNED_LAW_NONE)


@unittest.skipUnless(_real_chain_present(), "真契约模块（W1 evidence_tree + W2 pool）在场才跑")
class TestRealContractModulesNoNetwork(_EnvCase):
    """真 W1/W2 契约件全链（零网络）：仅适配器边界经 W2 pool 的 channels
    注入针位换 FakeAdapter（W2 契约显式收适配器实例），expand/harvest/tree 全真跑。"""

    def test_real_pool_and_tree_with_fake_adapter_injection(self):
        class FakeAdapter(ChannelAdapter):
            """适配器契约形状：metadata() 返 FileMeta 对象（pool 内 meta_to_dict
            自行 dict 化——适配器层给对象、池层给 dict，两层契约如实分层）。"""

            channel = "fakech"

            def metadata(self, query, limit):
                titles = [("水利工程EPC总承包合同范本", "pdf"),
                          ("水利水电工程施工组织设计指南", "doc"),
                          ("EPC工程总承包项目管理实务", "pdf"),
                          ("水利工程验收资料整编手册", "xls"),
                          ("水利水电工程监理规划范本", "doc"),
                          ("水利工程造价编制与审核", "pdf")]
                qi = abs(hash(query)) % 97
                return [FileMeta(title=f"{t}·{qi:02d}", fmt=f, pages=40 + i,
                                 badge="green_free", perm="green", source_url=None,
                                 extra={"doc_id": f"r{qi}{i}"})
                        for i, (t, f) in enumerate(titles[:limit])]

        bp = evidence_cli.build_evidence_blueprint(SENT_WATER, channels=[FakeAdapter()])
        self.assertIsNotNone(bp)
        self.assertEqual(bp["tree"]["mode"], "evidence_tree")   # 真 W1 造树
        ev = bp["provenance"]["evidence"]
        self.assertGreater(ev["pool_size"], 0)                  # 真 W2 收割（FakeAdapter 供弹）
        self.assertEqual(set(ev["channels"]), {"fakech"})       # 注入渠道如实记账
        ratio = ev["real_file_ratio"]
        self.assertIsNotNone(ratio)
        self.assertTrue(0 < ratio <= 1.0)  # 真树种子兜底可能添占位组，ratio 如实不硬钉


@unittest.skipUnless(os.environ.get("KB_LIVE") and _real_chain_present(),
                     "真链冒烟: 真 pool/evidence_tree 在场且设 KB_LIVE=1 才跑（真网络）")
class TestRealChainLiveSmoke(_EnvCase):
    """真契约模块（W1/W2 落地后）+ 真网络冒烟：进程内一条龙，验收实调不 mock。"""

    def test_real_chain_produces_blueprint(self):
        bp = evidence_cli.build_evidence_blueprint(SENT_WATER)
        if bp is None:  # 网络不济/渠道 0 命中 → 如实 skip（零造假：不造实调假象）
            self.skipTest("真链检索 0 件（如实计 0）")
        ev = bp["provenance"]["evidence"]
        self.assertGreater(ev["pool_size"], 0)
        self.assertIsNotNone(ev["real_file_ratio"])


if __name__ == "__main__":
    unittest.main()
