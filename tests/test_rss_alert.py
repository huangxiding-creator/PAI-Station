# -*- coding: utf-8 -*-
"""RSS 信息级告警测试（G12）：关键词命中/jsonl 只增/digest 追加/推送静默/上限截断。

全部零网络零企微：fetch 全 fake，wecom-cli 走注入 runner 或 monkeypatch。
"""
import json
import time
from pathlib import Path

import pytest

from paistation.sense.rss import (
    AlertEngine,
    harvest,
    match_keywords,
    parse_keywords,
    parse_opml,
)

OPML = """<?xml version="1.0" encoding="UTF-8"?>
<opml version="2.0"><body>
<outline text="能源观察" type="rss" title="能源观察"
  xmlUrl="https://wechat2rss.gcblog.net/feed/dddd.xml" htmlUrl="x"/>
</body></opml>"""


def _feed_xml(guid: str, title: str, desc: str = "普通正文") -> str:
    return f"""<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"><channel><title>t</title>
<item><title>{title}</title><link>https://mp.weixin.qq.com/s/{guid}</link>
<guid isPermaLink="false">{guid}</guid><pubDate>Thu, 17 Sep 2026 08:00:00 GMT</pubDate>
<description>&lt;p&gt;{desc}&lt;/p&gt;</description>
</item></channel></rss>"""


NOW = time.mktime(time.strptime("2026-09-17 10:00", "%Y-%m-%d %H:%M"))


@pytest.fixture()
def opml_file(tmp_path):
    p = tmp_path / "src.opml"
    p.write_text(OPML, encoding="utf-8")
    return p


class FakeRunner:
    """记录企微推送命令，绝不触网。"""

    def __init__(self, returncode=0):
        self.calls: list[list[str]] = []
        self.returncode = returncode

    def __call__(self, cmd, **kwargs):
        self.calls.append(list(cmd))
        import types
        return types.SimpleNamespace(returncode=self.returncode,
                                     stdout="", stderr="")


# ── 关键词解析与匹配（纯确定性） ───────────────────────────────────
def test_parse_keywords_half_full_width_and_trim():
    assert parse_keywords("东方电气, 核电，华龙一号") == \
        ["东方电气", "核电", "华龙一号"]
    assert parse_keywords(",, ，,") == []
    assert parse_keywords("") == []


def test_match_keywords_or_semantics_records_hits():
    kws = ["东方电气", "核电", "华龙一号"]
    assert match_keywords("华龙一号机组获批", "正文无关", kws) == ["华龙一号"]
    # 命中词按传入清单顺序返回（确定性）
    assert match_keywords("周报", "提到核电与东方电气", kws) == ["东方电气", "核电"]
    assert match_keywords("周报", "全文无关词", kws) == []
    # casefold：英文关键词大小写不敏感但仍确定性
    assert match_keywords("Weekly", "", ["weekly"]) == ["weekly"]


def test_match_keywords_body_only_first_2k_scanned():
    body = "水" * 2000 + "核电"
    assert match_keywords("标题无词", body, ["核电"]) == []  # 2k 之外不扫
    assert match_keywords("标题无词", "核电" + body, ["核电"]) == ["核电"]


def test_engine_requires_keywords():
    with pytest.raises(ValueError):
        AlertEngine([], base=Path("."))


# ── jsonl 只增 + 格式 ─────────────────────────────────────────────
def test_jsonl_append_only_and_entry_format(tmp_path):
    eng = AlertEngine(["核电"], base=tmp_path)
    assert eng.on_article(feed="能源观察", title="核电新进展",
                          body="正文含核电", link="https://mp/1",
                          published="Thu", path=tmp_path / "a.md", now=NOW)
    assert eng.on_article(feed="能源观察", title="无关文",
                          body="无关", now=NOW + 60) is False
    p = tmp_path / "alerts.jsonl"
    lines = [ln for ln in p.read_text(encoding="utf-8").splitlines() if ln]
    assert len(lines) == 1  # 未命中不落盘
    e = json.loads(lines[0])
    assert e["type"] == "hit" and e["day"] == "2026-09-17"
    assert e["account"] == "能源观察" and e["title"] == "核电新进展"
    assert e["keywords"] == ["核电"] and e["link"] == "https://mp/1"
    assert e["file"] == str(tmp_path / "a.md")
    # 只增：再命中一条 → 两条，第一条原样仍在
    eng.on_article(feed="能源观察", title="又见核电", body="x",
                   now=NOW + 120)
    lines2 = [ln for ln in p.read_text(encoding="utf-8").splitlines() if ln]
    assert len(lines2) == 2 and lines2[0] == lines[0]


# ── digest：同日一份、追加段落不重写 ───────────────────────────────
def test_digest_same_day_append_sections(tmp_path):
    eng = AlertEngine(["核电"], base=tmp_path)
    eng.on_article(feed="能源观察", title="核电一", body="x", now=NOW)
    eng.finalize(push=False, now=NOW)
    eng.on_article(feed="能源观察", title="核电二", body="x", now=NOW + 7200)
    eng.finalize(push=False, now=NOW + 7200)
    p = tmp_path / "alert_digest_2026-09-17.md"
    text = p.read_text(encoding="utf-8")
    assert text.count("# RSS 情报告警 2026-09-17") == 1  # 主标题只一次
    assert "核电一" in text and "核电二" in text          # 两班次段落共存
    assert text.count("命中 1 条") == 2                    # 两段落头


def test_digest_no_hits_no_file(tmp_path):
    eng = AlertEngine(["核电"], base=tmp_path)
    assert eng.finalize(push=False, now=NOW) == 0
    assert not (tmp_path / "alert_digest_2026-09-17.md").exists()
    assert not (tmp_path / "alerts.jsonl").exists()


# ── 推送纪律：默认零调用；开则班次恰 1 条、形态正确、500 截断 ──────
def test_push_disabled_runner_never_called(tmp_path, monkeypatch):
    # 未开 --push-alerts：真 subprocess.run 也必须零触达
    import paistation.sense.rss.alert as alert_mod
    monkeypatch.setattr(alert_mod.subprocess, "run",
                        lambda *a, **k: pytest.fail("subprocess.run 不得触达"))
    eng = AlertEngine(["核电"], base=tmp_path)
    eng.on_article(feed="能源观察", title="核电快讯", body="x", now=NOW)
    n = eng.finalize(push=False, now=NOW)  # 默认静默
    assert n == 1


def test_push_one_summary_per_shift_and_command_shape(tmp_path):
    runner = FakeRunner()
    eng = AlertEngine(["核电", "华龙一号"], base=tmp_path, runner=runner)
    for i in range(5):
        eng.on_article(feed=f"源{i}", title=f"核电快讯{i}", body="x",
                       now=NOW + i)
    eng.finalize(push=True, now=NOW + 10)
    assert len(runner.calls) == 1  # 每班次至多 1 条，绝不逐篇推
    cmd = runner.calls[0]
    assert cmd[:4] == ["wecom-cli", "message", "aibot", "send"]
    assert cmd[4:6] == ["--text", cmd[5]] and len(cmd) == 6
    text = cmd[5]
    assert text.startswith("RSS 情报告警 5 条：核电快讯0(核电)|核电快讯1(核电)")
    assert len(text) <= 500


def test_push_text_truncated_at_500(tmp_path):
    runner = FakeRunner()
    eng = AlertEngine(["核电"], base=tmp_path, runner=runner)
    for i in range(60):
        eng.on_article(feed="源", title=f"超长标题占位之核电快讯第{i}条",
                       body="x", now=NOW + i)
    eng.finalize(push=True, now=NOW)
    assert len(runner.calls) == 1 and len(runner.calls[0][5]) == 500


def test_push_failure_no_retry_no_raise(tmp_path):
    calls = []

    def bad_runner(cmd, **kw):
        calls.append(cmd)
        raise FileNotFoundError("wecom-cli not found")  # 探活失败形态

    eng = AlertEngine(["核电"], base=tmp_path, runner=bad_runner)
    eng.on_article(feed="源", title="核电", body="x", now=NOW)
    eng.finalize(push=True, now=NOW)  # 不炸
    assert len(calls) == 1  # 不重试


# ── 24h 上限护栏：超限记 cap_reached 一条后不再逐条 ────────────────
def test_cap_200_per_24h_then_single_marker(tmp_path):
    eng = AlertEngine(["核电"], base=tmp_path, daily_cap=3, window_s=86400)
    for i in range(5):
        eng.on_article(feed="源", title=f"核电{i}", body="x", now=NOW + i)
    lines = [json.loads(ln) for ln in
             (tmp_path / "alerts.jsonl").read_text(encoding="utf-8").splitlines()
             if ln]
    kinds = [e["type"] for e in lines]
    assert kinds == ["hit", "hit", "hit", "cap_reached"]  # 3 条即顶+1 标记
    assert lines[-1]["cap"] == 3 and lines[-1]["day"] == "2026-09-17"
    # 超限后的命中不逐条记；班次汇总也只含已落盘 3 条
    assert eng.finalize(push=False, now=NOW + 10) == 3


def test_cap_marker_once_per_window_and_recovers_after_rollover(tmp_path):
    eng = AlertEngine(["核电"], base=tmp_path, daily_cap=2, window_s=100)
    for i in range(4):
        eng.on_article(feed="源", title=f"核电{i}", body="x", now=NOW + i)
    later = NOW + 200  # 窗口整体滚过：旧 hit 全部出窗
    assert eng.on_article(feed="源", title="核电new", body="x", now=later)
    lines = [json.loads(ln) for ln in
             (tmp_path / "alerts.jsonl").read_text(encoding="utf-8").splitlines()
             if ln]
    assert [e["type"] for e in lines] == \
        ["hit", "hit", "cap_reached", "hit"]  # 恢复逐条，无重复标记


# ── harvest 集成：观测层旁挂不改收割行为 ──────────────────────────
def test_harvest_with_alert_engine_wires_hits(opml_file, tmp_path):
    feeds = parse_opml(opml_file)
    state, out = tmp_path / "s.json", tmp_path / "articles"
    runner = FakeRunner()
    eng = AlertEngine(["核电"], base=tmp_path, runner=runner)

    def fetch(url, headers):
        return 200, _feed_xml("g-1", "华龙一号核电工程开工", "正文提核电"), {}

    rep = harvest(feeds, state, out, fetch=fetch, now=NOW, alert=eng)
    assert rep.new_articles == 1 and rep.alerts == 1
    assert "告警1" in rep.brief()
    e = json.loads((tmp_path / "alerts.jsonl").read_text(encoding="utf-8"))
    assert e["account"] == "能源观察" and e["keywords"] == ["核电"]
    assert Path(e["file"]).exists() and e["file"].endswith(".md")
    eng.finalize(push=False, now=NOW)
    assert (tmp_path / "alert_digest_2026-09-17.md").exists()


def test_harvest_without_alert_engine_no_alert_files(opml_file, tmp_path):
    feeds = parse_opml(opml_file)

    def fetch(url, headers):
        return 200, _feed_xml("g-2", "核电快讯", "正文"), {}

    rep = harvest(feeds, tmp_path / "s.json", tmp_path / "a",
                  fetch=fetch, now=NOW)  # 不传 alert = 整层关闭
    assert rep.new_articles == 1 and rep.alerts == 0
    assert not (tmp_path / "alerts.jsonl").exists()


def test_harvest_alert_layer_failure_does_not_break_harvest(opml_file, tmp_path):
    feeds = parse_opml(opml_file)

    class BrokenEngine:
        def on_article(self, **kw):
            raise RuntimeError("观测层自爆")

    def fetch(url, headers):
        return 200, _feed_xml("g-3", "核电", "x"), {}

    rep = harvest(feeds, tmp_path / "s.json", tmp_path / "a",
                  fetch=fetch, now=NOW, alert=BrokenEngine())
    assert rep.ok == 1 and rep.new_articles == 1 and rep.alerts == 0
