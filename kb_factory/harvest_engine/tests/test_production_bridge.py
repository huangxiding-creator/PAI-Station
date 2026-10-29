# -*- coding: utf-8 -*-
"""E1 产线桥单测：production_bridge — 收割引擎 → 研报产线调研渠道（1023 任务卡）。

- 离线用例=注入假适配器（scout_inject 先例：「检索腿全部 injectable，离线绝不真触网」）
  + book118 无浏览器真件零网络用例（no_browser 如实 [] 零请求）；
- schema 对齐断言=以 ammo_pool/EPC-OVERSEAS manifest.jsonl 实测行键集（侦察 1023）
  为基准，桥行键必须覆盖；dedup_key/url_norm 与 reforge_factory.ammo_pool 真符号
  逐字相等（绝不自造公式）；
- 实弹用例（@pytest.mark.live）=真实网络（三站聚合 1 词 + doc88 post.do 直查，
  zero-mock）；KB_HARVEST_SKIP_LIVE=1 时跳过并在输出明示（公约第 4 条）。
"""
import json
import os
import re
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
_REPO_ROOT = _KB_DIR.parent                   # E:\AI-Station
sys.path.insert(0, str(_KB_DIR))
for _p in (str(_REPO_ROOT), str(_REPO_ROOT / "reforge_factory")):
    if _p not in sys.path:                     # reforge 同目录件(gates_loader)绝对导入
        sys.path.insert(0, _p)

from kb_factory.channel_adapters.base import FileMeta, RateLimiter  # noqa: E402
from kb_factory.harvest_engine.adapters.base import WALL_PAID       # noqa: E402
from reforge_factory import ammo_pool as _pool_mod                 # noqa: E402

from kb_factory.harvest_engine import production_bridge as pb      # noqa: E402

_LIVE_SKIP = os.environ.get("KB_HARVEST_SKIP_LIVE") == "1"

#: 侦察基准（1023）：ammo_pool/EPC-OVERSEAS/manifest.jsonl 实测行的恒有键集
#: （pending 行权威 schema = reforge_factory/ammo_pool.py ingest() 行字段）。
REQUIRED_POOL_KEYS = {
    "ts", "engine", "source_path", "url_norm", "chars", "credibility",
    "dedup_key", "judge", "judge_reason", "judge_engine", "tree_node",
    "stance", "budget_band", "text_head", "engine_detail",
}


class _FakeSiteAdapter:
    """注入假腿：返回固定 FileMeta / 或抛指定异常（单站故障注入形态）。"""

    def __init__(self, metas=None, not_impl=False):
        self._metas = metas or []
        self._not_impl = not_impl
        self.calls = []

    def search(self, query, limit):
        self.calls.append((query, limit))
        if self._not_impl:
            raise NotImplementedError("注入：未实装形态（doc88 端点已破译入仓 T46，此为故障注入）")
        return self._metas[:limit]

    def reason(self):
        return ""


def _instant_limiters():
    """零等待频控（确定性注入；真跑用桥缺省真频控——频控复用 RateLimiter 真符号）。"""
    return {"book118": RateLimiter(min_interval=0, daily_limit=50, name="t_book118")}


def _meta(title, url, *, site="wenku", perm="green", fmt="doc", pages=8):
    return FileMeta(title=title, fmt=fmt, pages=pages, perm=perm,
                    source_url=url, extra={"kb_harvest_site": site})


# ---------------------------------------------------------------- E1-R1 三站聚合

def test_e1_r1_aggregate_tags_and_cross_site_dedup():
    """三站聚合：假腿注入 → 合并+站点标注+跨站 URL 去重——doc88 同入聚合（T46 后
    三站段1 全在位，无跳过特例）。"""
    wenku = _FakeSiteAdapter([
        _meta("国际工程EPC合同管理", "https://wenku.baidu.com/view/abc123.html", site="wenku"),
        _meta("海外项目风险管理", "https://wenku.baidu.com/view/def456.html", site="wenku"),
    ])
    book = _FakeSiteAdapter([
        # 与 wenku 首件同 URL（跨站镜像）→ 去重；不同件保留
        _meta("国际工程EPC合同管理(镜像)", "https://wenku.baidu.com/view/abc123.html", site="book118"),
        _meta("FIDIC 条款解读", "https://max.book118.com/html/2026/1234.shtm", site="book118"),
    ])
    doc88 = _FakeSiteAdapter([
        # doc88 题录（T46 post.do 真件形态：extra 携 p_code）；与 wenku 次件同 URL → 去重
        _meta("海外项目风险管理(镜像)", "https://wenku.baidu.com/view/def456.html", site="doc88"),
        _meta("EPC 总承包合同范本", "https://www.doc88.com/p-932437377718031.html", site="doc88"),
    ])
    bridge = pb.ProductionBridge(
        adapters={"wenku": wenku, "book118": book, "doc88": doc88},
        site_limiters=_instant_limiters())
    metas = bridge.search_channel("国际工程EPC", 10)

    assert len(metas) == 4                      # 6-2 跨站同 URL 去重（book118/doc88 各镜像 1）
    assert {m.extra["kb_harvest_site"] for m in metas} == {"wenku", "book118", "doc88"}
    urls = [_pool_mod.norm_url(m.source_url) for m in metas]
    assert len(urls) == len(set(urls))          # URL 归一后无重复
    rep = bridge.last_report
    assert rep.per_site["wenku"]["count"] == 2 and rep.per_site["wenku"]["status"] == "ok"
    assert rep.per_site["book118"]["count"] == 2 and rep.per_site["book118"]["status"] == "ok"
    assert rep.per_site["doc88"]["count"] == 2 and rep.per_site["doc88"]["status"] == "ok"
    assert rep.total == 4
    engines = {pb.to_pool_evidence(m)["engine"] for m in metas}
    assert engines == {"kb_harvest:wenku", "kb_harvest:book118", "kb_harvest:doc88"}


def test_e1_r1_doc88_failure_isolated_honest_error():
    """doc88 腿失败如实 error 不炸聚合：T46 后无 skipped 特例——未实装形态
    NotImplementedError 与一般异常同落 error 留因，他站成果照常返回。"""
    class _Boom(_FakeSiteAdapter):
        def search(self, query, limit):
            raise NotImplementedError("注入：未实装形态")

    bridge = pb.ProductionBridge(
        adapters={"wenku": _FakeSiteAdapter(
                      [_meta("海外EPC实务", "https://wenku.baidu.com/view/w1.html")]),
                  "book118": _FakeSiteAdapter([]),
                  "doc88": _Boom()},
        site_limiters=_instant_limiters())
    metas = bridge.search_channel("海外EPC", 5)
    assert [m.title for m in metas] == ["海外EPC实务"]   # 他站成果照常返回
    site = bridge.last_report.per_site["doc88"]
    assert site["status"] == "error" and site["count"] == 0
    assert "NotImplementedError" in site["reason"]      # 如实留因，不冒充空结果


def test_e1_r1_doc88_default_leg_search_implemented():
    """doc88 默认腿在聚合位（零网络构造级断言）：全缺省站点集=三站含 doc88，
    ``_adapter("doc88")`` 出真件 Doc88DownloadAdapter 且 ``search`` 在位（T46
    post.do 免登录题录，非桩）——聚合循环不再有 doc88 跳过分支。"""
    from kb_factory.harvest_engine.adapters.doc88 import Doc88DownloadAdapter
    bridge = pb.ProductionBridge()
    assert bridge._sites == pb.SITES == ("wenku", "book118", "doc88")
    adapter = bridge._adapter("doc88")
    assert isinstance(adapter, Doc88DownloadAdapter)
    assert callable(adapter.search)


def test_e1_r1_book118_no_browser_real_symbol_honest_zero():
    """book118 真件零网络：未注入浏览器 → search 如实 [] + reason=no_browser（不冒充）。"""
    from kb_factory.harvest_engine.adapters.book118 import Book118Adapter
    bridge = pb.ProductionBridge(
        adapters={"book118": Book118Adapter()},
        site_limiters={"book118": RateLimiter(min_interval=0, daily_limit=5, name="t")})
    metas = bridge.search_channel("国际工程", 3)
    assert metas == []
    site = bridge.last_report.per_site["book118"]
    assert site["count"] == 0
    assert "no_browser" in site["reason"]


def test_e1_r1_site_error_isolated_not_fatal():
    """单站异常不炸链：他站成果照常返回，异常站如实落 error 报告。"""
    class _Boom(_FakeSiteAdapter):
        def search(self, query, limit):
            raise RuntimeError("网络抖动(注入)")

    bridge = pb.ProductionBridge(
        adapters={"wenku": _Boom(), "book118": _FakeSiteAdapter(
            [_meta("海外EPC实务", "https://max.book118.com/html/2026/77.shtm", site="book118")]),
            "doc88": _FakeSiteAdapter(not_impl=True)},
        site_limiters=_instant_limiters())
    metas = bridge.search_channel("海外EPC", 5)
    assert [m.title for m in metas] == ["海外EPC实务"]
    assert bridge.last_report.per_site["wenku"]["status"] == "error"
    assert "网络抖动" in bridge.last_report.per_site["wenku"]["reason"]


# ---------------------------------------------------------------- E1-R2 入池 schema

def test_e1_r2_pool_row_schema_alignment_with_ammo_manifest():
    """桥行 schema 对齐：覆盖实测 manifest 恒有键集；dedup_key/url_norm 与
    reforge_factory.ammo_pool 真符号逐字相等（线索行走 c: 标题指纹支路）。"""
    meta = _meta("国际工程EPC合同风险管理实务", "https://wenku.baidu.com/view/abc123.html")
    row = pb.to_pool_evidence(meta, tree_node="Q23-E1")

    assert REQUIRED_POOL_KEYS <= set(row), sorted(REQUIRED_POOL_KEYS - set(row))
    assert row["engine"] == "kb_harvest:wenku"
    assert row["judge"] == "pending"           # 入池不计账——判有效才计数（池铁律 3）
    assert row["chars"] == 0                    # 检索级线索零内容，数字零造假
    assert row["source_path"] == ""             # 无本地文件；judge 扫掠如实 file_missing
    assert row["text_head"] == meta.title
    assert row["tree_node"] == "Q23-E1"
    assert row["engine_detail"] == "kb_harvest:wenku:search"
    # 真符号对齐（绝不禁公式分叉）：
    assert row["url_norm"] == _pool_mod.norm_url(meta.source_url)
    assert row["dedup_key"] == _pool_mod.dedup_key(None, meta.title)
    # 线索键走 c: 支路 → 不占 u:URL 位：全文腿收割后同 URL ingest 不被本行挡道
    assert row["dedup_key"].startswith("c:")
    assert row["dedup_key"] != _pool_mod.dedup_key(meta.source_url, meta.title)
    # FT-5 权威度两键：要么同在要么同缺（ammo_pool 缺件先例）
    has_auth = {"authority_score", "authority_grade"} <= set(row)
    assert has_auth or not ({"authority_score", "authority_grade"} & set(row))
    json.dumps(row, ensure_ascii=False)         # 可序列化入 manifest.jsonl


def test_e1_r2_budget_band_passthrough_real_symbol():
    """band 通路：BUDGET_BANDS 真符号三档直引；非法值归 ""=未归档（ingest 同款）。"""
    meta = _meta("海外EPC预算分档件", "https://wenku.baidu.com/view/bd1.html")
    ok = pb.to_pool_evidence(meta, band="section_narrow")
    assert ok["budget_band"] == "section_narrow"
    assert pb.to_pool_evidence(meta, band="瞎填档")["budget_band"] == ""
    assert pb.to_pool_evidence(meta)["budget_band"] == ""


def test_e1_r2_yellow_line_wall_status_and_form_annotation():
    """黄线件（perm=yellow）：wall_status=paid_wall（NFR1 统一标记映射）+形态标注；
    绿线件 wall_status=None。"""
    yellow = _meta("VIP专享:EPC索赔案例集", "https://wenku.baidu.com/view/vip9.html",
                   perm="yellow", fmt="pdf", pages=None, site="book118")
    row = pb.to_pool_evidence(yellow)
    assert row["wall_status"] == WALL_PAID
    assert row["form"] == "search_lead"
    assert row["meta_fmt"] == "pdf"
    assert row["meta_pages"] is None            # 渠道无此字段如实 None
    assert row["meta_badge"]                     # badge 形态标注在位

    green = _meta("免费公开:FIDIC导读", "https://wenku.baidu.com/view/free1.html")
    assert pb.to_pool_evidence(green)["wall_status"] is None


# ---------------------------------------------------------------- E1-R3 注册行 + 调用台账

def test_e1_r3_registration_row_shape():
    """channel 注册行：{id,name,runner,note} 对齐 channel_builder RECIPES manifest 底稿。"""
    row = pb.channel_registration_row()
    assert row["id"] == "kb_harvest"
    assert {"id", "name", "runner", "note"} <= set(row)
    assert "production_bridge" in row["runner"]
    assert "wenku" in row["runner"] and "book118" in row["runner"] and "doc88" in row["runner"]
    json.dumps(row, ensure_ascii=False)


def test_e1_r3_invocation_row_format_and_append(tmp_path):
    """调用台账行：{channel,ts,tool,queries,yield,note} 六键对齐 1022 宪法台账格式；
    追加只增不改；dry-run 零落盘。"""
    bridge = pb.ProductionBridge(adapters={
        "wenku": _FakeSiteAdapter([_meta("海外EPC", "https://wenku.baidu.com/view/x1.html")]),
        "book118": _FakeSiteAdapter([]),   # 注入空腿：不触发桥自建 book118 腿的桥级频控（离线确定性）
    })
    bridge.search_channel("海外EPC", 5)
    row = pb.invocation_row("海外EPC", bridge.last_report)
    assert set(row) >= {"channel", "ts", "tool", "queries", "yield", "note"}
    assert row["channel"] == "kb_harvest"
    assert re.fullmatch(r"\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}", row["ts"])
    assert "1条检索线索" in row["yield"]

    ledger = tmp_path / "channel_invocations.jsonl"
    pb.append_invocation(row, ledger=ledger, commit=False)
    assert not ledger.exists()                  # dry-run 零落盘
    pb.append_invocation(row, ledger=ledger, commit=True)
    lines = ledger.read_text(encoding="utf-8").splitlines()
    assert len(lines) == 1 and json.loads(lines[0])["channel"] == "kb_harvest"


# ---------------------------------------------------------------- E1-R4 CLI

def _cli_bridge():
    wenku = _FakeSiteAdapter([
        _meta("海外工程EPC实务", "https://wenku.baidu.com/view/e1.html"),
        _meta("国际工程合同范本", "https://wenku.baidu.com/view/e2.html"),
    ])
    return pb.ProductionBridge(
        adapters={"wenku": wenku,
                  "book118": _FakeSiteAdapter([
                      _meta("FIDIC合同实务解读", "https://max.book118.com/html/2026/909.shtm",
                            site="book118")]),
                  "doc88": _FakeSiteAdapter([
                      _meta("EPC总承包项目管理指南",
                            "https://www.doc88.com/p-603909091562201.html", site="doc88")])},
        site_limiters=_instant_limiters())


def test_e1_r4_cli_dry_run_writes_nothing(tmp_path, capsys):
    """CLI 默认 dry-run：预览打印（注册行+池行+台账行）但零落盘。"""
    rc = pb.main(["search", "海外工程EPC", "--pool", "TPOOL",
                  "--limit", "2", "--pool-root", str(tmp_path)],
                 bridge=_cli_bridge())
    out = capsys.readouterr().out
    assert rc == 0
    assert "dry-run" in out and "未落盘" in out
    assert "kb_harvest" in out
    assert not (tmp_path / "TPOOL" / "manifest.jsonl").exists()
    assert not (tmp_path / "TPOOL" / "channel_invocations.jsonl").exists()


def test_e1_r4_cli_commit_appends_then_idempotent_manifest(tmp_path, capsys):
    """--commit：diff 预览后追加 manifest 行+台账行；同词重跑 manifest 零新增
    （dedup_key 查重）、台账照记（调用是义务，收获另计）。"""
    (tmp_path / "TPOOL").mkdir()               # 池先在（--commit 不静默建池——产线资产纪律）
    argv = ["search", "海外工程EPC", "--pool", "TPOOL",
            "--limit", "2", "--pool-root", str(tmp_path), "--commit"]
    rc1 = pb.main(argv, bridge=_cli_bridge())
    out1 = capsys.readouterr().out
    assert rc1 == 0
    assert "预览" in out1                              # --commit 前打印 diff 预览（纪律）
    pool = tmp_path / "TPOOL"
    rows1 = [json.loads(x) for x in
             (pool / "manifest.jsonl").read_text(encoding="utf-8").splitlines()]
    assert len(rows1) == 4
    assert {r["engine"] for r in rows1} == {
        "kb_harvest:wenku", "kb_harvest:book118", "kb_harvest:doc88"}
    inv1 = (pool / "channel_invocations.jsonl").read_text(encoding="utf-8").splitlines()
    assert len(inv1) == 1

    rc2 = pb.main(argv, bridge=_cli_bridge())          # 同词重跑
    capsys.readouterr()
    assert rc2 == 0
    rows2 = [json.loads(x) for x in
             (pool / "manifest.jsonl").read_text(encoding="utf-8").splitlines()]
    assert len(rows2) == 4                             # dedup_key 查重 → 零重复追加
    inv2 = (pool / "channel_invocations.jsonl").read_text(encoding="utf-8").splitlines()
    assert len(inv2) == 2                              # 台账每次调用如实一行


def test_e1_r4_cli_commit_refuses_unknown_pool(tmp_path, capsys):
    """--commit 未知池拒写（不静默建池，产线资产纪律）+ 非法池名早拒。"""
    rc = pb.main(["search", "海外工程EPC", "--pool", "NOPOOL",
                  "--pool-root", str(tmp_path), "--commit"], bridge=_cli_bridge())
    assert rc == 2
    assert not (tmp_path / "NOPOOL").exists()
    capsys.readouterr()
    assert pb.main(["search", "x", "--pool", "a/b"], bridge=_cli_bridge()) == 2


def test_e1_r4_cli_register_prints_row(capsys):
    rc = pb.main(["register"])
    out = capsys.readouterr().out
    assert rc == 0 and "kb_harvest" in out


# ---------------------------------------------------------------- E1 实弹（真实网络）

@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（公约第 4 条，CI 场景明示）")
def test_e1_live_doc88_search_epc_min_one():
    """实弹 doc88 直查（zero-mock，1026 复审令验收锚）：真件
    ``Doc88DownloadAdapter().search("EPC", 5)`` 真网免登录题录 ≥1 条（T46 post.do
    端点在役）；题录 extra 带 p_code 可接段2，产物行 schema 合法可序列化。
    不触产线池（只读检查，不落盘）。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹用例跳过")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1")
    from kb_factory.harvest_engine.adapters.doc88 import Doc88DownloadAdapter
    metas = Doc88DownloadAdapter().search("EPC", 5)
    print(f"[live] doc88 search('EPC',5) → {len(metas)} 条")
    for m in metas[:3]:
        print(f"[live]   {m.title[:40]!r} p_code={(m.extra or {}).get('p_code')} fmt={m.fmt}")
    assert len(metas) >= 1
    assert all(isinstance(m, FileMeta) for m in metas)
    assert all((m.extra or {}).get("p_code") for m in metas)   # 段2 plan 的直入口
    row = pb.to_pool_evidence(metas[0])
    assert REQUIRED_POOL_KEYS <= set(row)
    assert row["engine"] == "kb_harvest:doc88"
    json.dumps(row, ensure_ascii=False)


@pytest.mark.live
@pytest.mark.skipif(_LIVE_SKIP, reason="KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（公约第 4 条，CI 场景明示）")
def test_e1_live_one_word_three_site_real_network():
    """实弹 1 词（zero-mock）：三站真聚合——wenku syncmrecall 免登录应真产；
    book118 走真浏览器（缺席则如实 no_browser）；doc88 post.do 选品端点已实装
    （2026-10-24 doc88-reverse 战役，T46）——真网下应真产（免登录题录）；
    产物行 schema 合法可序列化。不触产线池（只读检查，不落盘）。"""
    if _LIVE_SKIP:
        print("[live-skip] KB_HARVEST_SKIP_LIVE=1：实弹用例跳过")
        pytest.skip("[live-skip] KB_HARVEST_SKIP_LIVE=1")
    bridge = pb.ProductionBridge()
    metas = bridge.search_channel("国际工程EPC", 5)
    rep = bridge.last_report
    print(f"[live] per_site={json.dumps(rep.per_site, ensure_ascii=False)}")
    print(f"[live] total={rep.total}")
    # wenku 免登录配方实测在役（WENKU_SPEC FR2.AC1）——真网下应真产
    assert rep.per_site["wenku"]["status"] == "ok"
    assert rep.per_site["wenku"]["count"] >= 1
    assert rep.per_site["doc88"]["status"] == "ok"      # T46 post.do 免登录真产
    assert rep.per_site["doc88"]["count"] >= 1
    assert all(isinstance(m, FileMeta) for m in metas)
    for m in metas[:3]:
        row = pb.to_pool_evidence(m)
        assert REQUIRED_POOL_KEYS <= set(row)
        json.dumps(row, ensure_ascii=False)
