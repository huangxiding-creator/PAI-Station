# -*- coding: utf-8 -*-
"""A2 相关性过滤测试（KB-FACTORY 2.0 轴②×3）——relevance.py 三权打分 + 惩罚 +
滤池淘汰账 + evidence_cli 接线（KB_RELEVANCE 默认开）。

任务验收口径（五钉）：
  正例高分 / 负例被汰（广告词·空标题·纯数字·超短标题）/ 权威度分级
  （官方标准/统计 > 研报机构 > 文库UGC，channel+title 特征词判级）/
  淘汰账真实（kept+dropped 对账、原因分布求和=dropped、top/avg 复算一致、
  空池 None 不记 0.0 冒充）/ 幂等（重滤同结果、滤后池再滤零淘汰）。

夹具纪律：全部 FileMeta 为测试夹具造数（模拟渠道元数据形态，非真实检索）；
零网络零 LLM（纯规则件，relevance 自身零 IO）。
"""
import os
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # E:\AI-Station 入 sys.path

from kb_factory.catalog_engine import relevance as R              # noqa: E402
from kb_factory import evidence_cli                                # noqa: E402

# 钉死 purpose（确定性：显式 keywords，防领域词表演化漂移测试语义）
PURPOSE_WATER = {"domain": "水利工程EPC知识库", "keywords": ["水利", "工程", "EPC"],
                 "intent": "从零建库", "size_hint": "small"}
PURPOSE_WATER_STR = "给水利工程公司建一个EPC行业知识库"
PURPOSE_LAW = {"domain": "律师事务所知识库", "keywords": ["民法典", "诉讼", "合规"],
               "intent": "诉讼与合规", "size_hint": "medium"}

# mock 供弹标题（口径同 kb_factory/tests/test_kb_server.py _MOCK_TITLES：跨标题
# 命中 ≥2 关键词——正常标题必须全过阈值，任务校准令）
_MOCK_TITLES = [("水利工程EPC总承包合同范本", "pdf"),
                ("水利水电工程施工组织设计指南", "doc"),
                ("EPC工程总承包项目管理实务", "pdf"),
                ("水利工程验收资料整编手册", "xls"),
                ("水利水电工程监理规划范本", "doc"),
                ("水利工程造价编制与审核", "pdf")]


def _meta(title, channel="wenku", **extra_kv):
    """FileMeta dict 夹具（契约形状：title/fmt/badge/perm/source_url/extra）。"""
    return {"title": title, "fmt": "pdf", "pages": 40, "badge": "green_free",
            "perm": "green", "source_url": None, "channel": channel,
            "extra": {"doc_id": f"t{abs(hash(title)) % 10_000:04d}", **extra_kv}}


# ── 一、打分口径：三权 0.4/0.3/0.3 + 惩罚 -0.2 ─────────────────────────────

class TestScore:
    def test_positive_scores_high(self):
        """正例高分：标题命中满权 + 摘要语料命中 + 研报渠道权威 → ≥0.7。"""
        m = _meta("水利工程EPC总承包合同管理实务", "djyanbao",
                  abstract="覆盖水利枢纽EPC工程总承包合同管理与工程造价控制。",
                  tags=["水利工程", "EPC"])
        d = R.score_detail(m, PURPOSE_WATER)
        assert d["title_hit"] == pytest.approx(0.4)     # 3 命中 ≥2 → 满权
        assert d["abstract_hit"] > 0                    # 摘要语料命中（0.3 权）
        assert d["authority"] == pytest.approx(0.18) and d["grade"] == "research"
        assert d["score"] >= 0.7 and 0.0 <= d["score"] <= 1.0

    def test_weights_are_task_pinned(self):
        """三权与阈值=任务钉死口径（0.4/0.3/0.3，threshold 0.35）。"""
        assert (R.W_TITLE, R.W_ABSTRACT, R.W_AUTHORITY) == (0.4, 0.3, 0.3)
        assert R.DEFAULT_THRESHOLD == 0.35 and R.PENALTY_STEP == 0.2

    def test_purpose_forms_equivalent(self):
        """purpose 三形态（str 派生 / need dict / 同值 str）打分一致（确定性）。"""
        m = _meta("水利工程EPC总承包合同管理实务", "wenku")
        by_dict = R.score(m, PURPOSE_WATER)
        by_str = R.score(m, PURPOSE_WATER_STR)          # str 现场派生关键词
        assert by_dict == pytest.approx(by_str)
        assert R.score(m, PURPOSE_WATER) == R.score(m, PURPOSE_WATER)  # 纯函数

    def test_bad_purpose_raises(self):
        with pytest.raises(ValueError):
            R.score(_meta("任意标题"), 12345)


# ── 二、负例被汰（广告词 / 空标题 / 纯数字 / 超短标题）──────────────────────

class TestNegatives:
    def test_ad_word_dropped_even_with_keyword_hits(self):
        """广告词负例：标题碰瓷命中关键词也必汰（0.4+0.1-0.2=0.3 < 0.35）。"""
        ad = _meta("点击下载水利EPC工程全套资料VIP专享", "wenku")
        d = R.score_detail(ad, PURPOSE_WATER)
        assert d["hits_title"] >= 2 and "ad_word" in d["penalties"]
        assert d["score"] < R.DEFAULT_THRESHOLD
        kept, dropped = R.filter_pool(mock_pool_like() + [ad], PURPOSE_WATER)
        assert ad not in kept and any(r["title"].startswith("点击下载") for r in dropped)

    def test_empty_short_pure_number_dropped(self):
        """空标题 / <6字 / 纯数字：硬负例全汰（惩罚项在 reasons 首位）。"""
        negs = [_meta(""), _meta("资料"), _meta("2023"), _meta("2023年度")]
        kept, dropped = R.filter_pool(_pool_with(negs), PURPOSE_WATER)
        titles_out = {r["title"] for r in dropped}
        assert titles_out == {"", "资料", "2023", "2023年度"}
        for r in dropped:
            assert r["reasons"], "淘汰件必带原因码（零造假：不静默汰）"
        assert len(kept) == 1   # 仅 mock 正常件存活（负例如实全汰）

    def test_clean_mock_pool_all_pass(self):
        """校准钉：mock 池（正常标题）在 threshold 模式全过（任务令原文）。"""
        kept, dropped = R.filter_pool(mock_pool_like(), PURPOSE_WATER)
        assert len(kept) == 6 and dropped == []


def _pool_with(extra):
    """mock 六件 + 注入负例（threshold 模式供弹池）。"""
    return [_meta(t, "wenku") for t, _ in _MOCK_TITLES][:1] + list(extra)


def mock_pool_like():
    """完整六件 mock 池（threshold 模式）。"""
    return [_meta(t, "wenku") for t, _ in _MOCK_TITLES]


# ── 三、权威度分级（官方标准/统计 > 研报机构 > 文库UGC；channel+title 判级）──

class TestAuthority:
    TITLE = "水利工程EPC总承包合同管理实务"

    def test_channel_grading_order(self):
        """同标题三渠道：official > research > ugc 严格降序。"""
        by_ch = {ch: R.score_detail(_meta(TestAuthority.TITLE, ch), PURPOSE_WATER)
                 for ch in ("gb", "djyanbao", "wenku")}
        assert [by_ch[c]["grade"] for c in ("gb", "djyanbao", "wenku")] == \
            ["official", "research", "ugc"]
        assert by_ch["gb"]["authority"] > by_ch["djyanbao"]["authority"] \
            > by_ch["wenku"]["authority"]

    def test_title_features_upgrade_not_downgrade(self):
        """标题特征词升级：标准编号→official / 研报词族→research；不降级渠道档。"""
        std = R.grade_authority(_meta("GB50500-2013建设工程工程量清单计价规范", "wenku"))
        assert std[0] == "official" and std[1]["title_grade"] == "official"
        rpt = R.grade_authority(_meta("2026水利行业分析报告", "doc88"))
        assert rpt[0] == "research" and rpt[1]["channel_grade"] == "ugc"
        gov = R.grade_authority(_meta("水利统计公报2026", "djyanbao"))
        assert gov[0] == "official"           # 统计公报特征词 > 渠道 research 档

    def test_unknown_channel_unrated_zero(self):
        """渠道不可知 + 无特征词 = unrated 0.0（不猜渠道不奖分，零造假）。"""
        d = R.score_detail(_meta("某某渠道普通题录", "fakech"), PURPOSE_WATER)
        assert d["grade"] == "unrated" and d["authority"] == 0.0

    def test_upgrade_changes_pass_verdict(self):
        """权威度差决定去留：同 1 关键词命中下 official 过线(0.2+0.3)、ugc 被汰
        (0.2+0.1)——权威档是边缘件的生死差。"""
        t = "工程项目管理实务"                      # 仅命中「工程」1 词
        off = R.score(_meta(t, "gb"), PURPOSE_WATER)
        ugc = R.score(_meta(t, "wenku"), PURPOSE_WATER)
        assert off == pytest.approx(0.5) and ugc == pytest.approx(0.3)
        kept, dropped = R.filter_pool([_meta(t, "gb"), _meta(t, "wenku"),
                                       _meta("水利EPC工程实务", "wenku")], PURPOSE_WATER)
        assert len(kept) == 2 and len(dropped) == 1   # gb 件与命中件过，ugc 件汰
        assert dropped[0]["reasons"] == ["below_threshold"]


# ── 四、淘汰账真实（零造假：对账可复算）────────────────────────────────────

class TestLedger:
    def test_ledger_accounts_add_up(self):
        """kept+dropped=harvested；原因分布求和=dropped；top/avg 复算一致。"""
        pool = mock_pool_like() + [
            _meta("点击下载水利EPC资料VIP", "wenku"), _meta("", "wenku"),
            _meta("2023", "wenku"), _meta("餐饮门店运营手册", "wenku")]
        kept, dropped, led = R.pool_ledger(pool, PURPOSE_WATER)
        assert led["harvested"] == len(pool)
        assert led["kept"] == len(kept) == 6
        assert led["dropped"] == len(dropped) == 4
        assert sum(led["drop_reasons"].values()) == led["dropped"]
        scores = sorted(R.score(m, PURPOSE_WATER) for m in pool)
        assert led["top_score"] == pytest.approx(max(R.score(m, PURPOSE_WATER)
                                                     for m in pool))
        avg = round(sum(R.score(m, PURPOSE_WATER) for m in pool) / len(pool), 4)
        assert led["avg"] == pytest.approx(avg)
        # dropped 记录可对账：index/title/score/reasons 全在
        for r in dropped:
            assert 0 <= r["index"] < len(pool)
            assert r["title"] == pool[r["index"]]["title"]

    def test_empty_pool_honest_none(self):
        """空池：top_score/avg=None（不记 0.0 冒充实测）。"""
        kept, dropped, led = R.pool_ledger([], PURPOSE_WATER)
        assert kept == [] and dropped == []
        assert led["kept"] == 0 and led["dropped"] == 0
        assert led["top_score"] is None and led["avg"] is None

    def test_threshold_param_respected(self):
        """threshold 形参生效：高阈值收紧（0.6 汰掉 0.5 分件，如实非硬钉）。"""
        pool = mock_pool_like()
        _, dropped_lo, _ = R.pool_ledger(pool, PURPOSE_WATER, threshold=0.35)
        kept_hi, dropped_hi, led_hi = R.pool_ledger(pool, PURPOSE_WATER, threshold=0.9)
        assert dropped_lo == [] and len(kept_hi) + len(dropped_hi) == len(pool)
        assert led_hi["threshold"] == 0.9


# ── 五、幂等与零信号护栏（校准钉）──────────────────────────────────────────

class TestIdempotent:
    def test_refilter_same_result(self):
        pool = mock_pool_like() + [_meta("点击下载水利EPC资料VIP", "wenku")]
        r1 = R.pool_ledger(pool, PURPOSE_WATER)
        r2 = R.pool_ledger(pool, PURPOSE_WATER)
        assert [d["index"] for d in r1[1]] == [d["index"] for d in r2[1]]
        assert r1[2] == r2[2]                      # 账本逐键一致（确定性）

    def test_filtered_pool_is_fixed_point(self):
        """滤后池再滤：零新增淘汰（滤池是收缩映射）。"""
        pool = mock_pool_like() + [_meta("点击下载水利EPC资料VIP", "wenku")]
        kept1, dropped1, _ = R.pool_ledger(pool, PURPOSE_WATER)
        kept2, dropped2, _ = R.pool_ledger(kept1, PURPOSE_WATER)
        assert dropped2 == [] and len(kept2) == len(kept1)

    def test_no_signal_pool_penalty_only(self):
        """零信号护栏：law purpose 配水利池（零命中）→ penalty_only 只汰硬负例
        （正常标题放行——test_integration_evidence 钉子场景，汰全池=拿弱证据
        杀人；模式如实记账不静默）。"""
        pool = [_meta(t, "stubch") for t, _ in _MOCK_TITLES] + \
            [_meta("点击下载全套VIP资料专享", "stubch")]   # 广告词负例（零关键词命中）
        kept, dropped, led = R.pool_ledger(pool, PURPOSE_LAW)
        assert led["mode"] == "penalty_only" and led["signal_docs"] == 0
        assert len(kept) == 6 and len(dropped) == 1
        assert dropped[0]["reasons"] == ["ad_word"]   # penalty_only 模式只记惩罚项


# ── 六、evidence_cli 接线（KB_RELEVANCE 默认开；关=零漂移）───────────────────

class TestEvidenceCliWiring:
    """进程内真链接线腿：真 pool/evidence_tree 契约件 + FakeAdapter 收割注入
    （零网络），验 A2 滤池真跑进 build_evidence_blueprint。"""

    SWITCHES = ("KB_RELEVANCE", "KB_EVIDENCE_CHAIN_DIR", "KB_EVIDENCE_HARVEST_MODULE")

    def setup_method(self):
        self._saved = {k: os.environ.get(k) for k in self.SWITCHES}
        for k in self.SWITCHES:                     # 强制真契约链 + 默认开滤池
            os.environ.pop(k, None)

    def teardown_method(self):
        for k, v in self._saved.items():
            if v is None:
                os.environ.pop(k, None)
            else:
                os.environ[k] = v

    @staticmethod
    def _harvest(queries, channels=None):
        """FakeAdapter 收割：六件正常 + 两件广告/空标题噪声（零网络）。"""
        metas = [_meta(t, "fakech") for t, _ in _MOCK_TITLES]
        metas += [_meta("点击下载水利EPC资料VIP专享", "fakech"), _meta("", "fakech")]
        return {"fakech": metas}

    @staticmethod
    def _slot_titles(bp):
        return [s.get("title") for l1 in bp["tree"]["l1"] for l2 in l1["l2"]
                for s in ((l2.get("files") or [])
                          + [f for sd in l2.get("split_dirs") or []
                             for f in sd.get("files") or []])]

    def test_default_on_filters_noise_and_ledger_lands(self):
        """默认开：噪声被汰出树输入，provenance.relevance 四钉键落账。"""
        bp = evidence_cli.build_evidence_blueprint(PURPOSE_WATER_STR,
                                                   harvest=self._harvest)
        assert bp is not None
        rel = bp["provenance"]["relevance"]
        assert rel["kept"] == 6 and rel["dropped"] == 2
        assert rel["mode"] == "threshold" and rel["threshold"] == 0.35
        assert rel["drop_reasons"] == {"ad_word": 1, "title_short": 1}
        assert rel["top_score"] is not None and rel["avg"] is not None
        ev = bp["provenance"]["evidence"]
        assert ev["pool_size"] == 6                  # 树输入=滤后池（口径钉）
        titles = self._slot_titles(bp)
        assert not any(t and "点击下载" in t for t in titles)   # 广告件不进树
        assert any("Sf relevance 滤池" in s for s in bp["provenance"]["stage_log"])

    def test_switch_off_zero_drift_no_relevance_key(self):
        """KB_RELEVANCE=0：滤池零调用——噪声原样进树、无 relevance 键。"""
        os.environ["KB_RELEVANCE"] = "0"
        bp = evidence_cli.build_evidence_blueprint(PURPOSE_WATER_STR,
                                                   harvest=self._harvest)
        assert bp is not None
        assert "relevance" not in bp["provenance"]   # 关=不落键零漂移
        ev = bp["provenance"]["evidence"]
        assert ev["pool_size"] == 8                  # 未滤（6 正常+2 噪声全进）
        titles = self._slot_titles(bp)
        assert any(t and "点击下载" in t for t in titles)       # 噪声未被汰

    def test_explicit_flag_overrides_env(self):
        """显式 relevance=False 压过默认开（三态口径同 engine 众开关）。"""
        bp = evidence_cli.build_evidence_blueprint(PURPOSE_WATER_STR,
                                                   harvest=self._harvest,
                                                   relevance=False)
        assert bp is not None and "relevance" not in bp["provenance"]


if __name__ == "__main__":
    sys.exit(pytest.main([__file__, "-v"]))
