# -*- coding: utf-8 -*-
"""RSS 采集器测试：We-AIPO 做法移植验收（全部 fake transport，零真网）。"""
import json
import time
from pathlib import Path

import pytest

from paistation.sense.rss import (
    AdaptivePacer, harvest, html_to_text, parse_opml, slugify, sync_opml,
)

OPML_A = """<?xml version="1.0" encoding="UTF-8"?>
<opml version="2.0"><body>
<outline text="混沌学园" type="rss" title="混沌学园"
  xmlUrl="https://wechat2rss.gcblog.net/feed/aaaa.xml" htmlUrl="x"/>
<outline text="机器之心" type="rss" title="机器之心Plus"
  xmlUrl="https://wechat2rss.gcblog.net/feed/bbbb.xml" htmlUrl="x"/>
<outline text="机器之心dup" type="rss" title="dup"
  xmlUrl="https://wechat2rss.gcblog.net/feed/bbbb.xml" htmlUrl="x"/>
</body></opml>"""

OPML_B = """<?xml version="1.0" encoding="UTF-8"?>
<opml version="2.0"><body>
<outline text="混沌学园" type="rss" title="混沌学园"
  xmlUrl="https://wechat2rss.gcblog.net/feed/aaaa.xml" htmlUrl="x"/>
<outline text="新智元" type="rss" title="新智元"
  xmlUrl="https://wechat2rss.gcblog.net/feed/cccc.xml" htmlUrl="x"/>
</body></opml>"""

RSS_OK = """<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0"><channel><title>t</title>
<item><title>AI 上新</title><link>https://mp.weixin.qq.com/s/abc</link>
<guid isPermaLink="false">guid-1</guid><pubDate>Wed, 16 Sep 2026 08:00:00 GMT</pubDate>
<description>&lt;p&gt;正文第一段&lt;/p&gt;&lt;script&gt;evil()&lt;/script&gt;&lt;p&gt;第二段&lt;/p&gt;</description>
</item></channel></rss>"""


class FakeClock:
    def __init__(self):
        self.t = 1000.0

    def __call__(self):
        return self.t


class FakeSleep:
    def __init__(self, clock):
        self.clock = clock
        self.slept = 0.0

    def __call__(self, s):
        self.slept += s
        self.clock.t += s


@pytest.fixture()
def opml_file(tmp_path):
    p = tmp_path / "src.opml"
    p.write_text(OPML_A, encoding="utf-8")
    return p


# ── OPML 解析与同步 ────────────────────────────────────────────────
def test_parse_opml_dedup_and_names(opml_file):
    feeds = parse_opml(opml_file)
    assert [f.name for f in feeds] == ["混沌学园", "机器之心Plus"]  # URL 去重+title 优先
    assert all(f.url.startswith("https://wechat2rss.gcblog.net/feed/") for f in feeds)


def test_sync_opml_first_copy_then_unchanged(opml_file, tmp_path):
    dst = tmp_path / "mirror" / "sub.opml"
    feeds, rep = sync_opml(opml_file, dst)
    # 首次同步=初始导入：全部源计 added
    assert rep.changed and rep.total == 2 and rep.added == ["机器之心Plus", "混沌学园"]
    stamp = dst.stat().st_mtime_ns
    feeds2, rep2 = sync_opml(opml_file, dst)
    assert not rep2.changed and not rep2.total == 0
    assert dst.stat().st_mtime_ns == stamp  # 未变零重写
    assert [f.url for f in feeds] == [f.url for f in feeds2]


def test_sync_opml_diff_on_change(opml_file, tmp_path):
    dst = tmp_path / "m.opml"
    sync_opml(opml_file, dst)
    opml_file.write_text(OPML_B, encoding="utf-8")
    feeds, rep = sync_opml(opml_file, dst)
    assert rep.changed and rep.total == 2
    assert rep.added == ["新智元"] and rep.removed == ["机器之心Plus"]  # bbbb 随 dup 行退场


def test_sync_opml_src_missing_falls_back_to_mirror(opml_file, tmp_path):
    dst = tmp_path / "m.opml"
    sync_opml(opml_file, dst)
    opml_file.unlink()
    feeds, rep = sync_opml(opml_file, dst)
    assert not rep.changed and len(feeds) == 2  # 镜像退化为基准，不断粮


# ── 节拍器 ─────────────────────────────────────────────────────────
def test_pacer_spacing_backoff_recover():
    ck, sl = FakeClock(), None
    slept = []

    def sleep_rec(s):
        slept.append(round(s, 3))
        ck.t += s

    p = AdaptivePacer(base_interval=1.0, max_interval=8.0, clock=ck, sleep=sleep_rec)
    p.delay(); ck.t += 5; p.delay()
    assert slept == []  # 间隔充足零等待
    p.delay()           # 距上次 <1s → 睡
    assert slept and slept[-1] > 0
    base = p.interval
    p.record(False); p.record(False)
    assert p.interval == min(8.0, base * 4)
    p.record(True); p.record(True)
    assert p.interval < base * 4  # 健康收敛


# ── HTML→文本 ─────────────────────────────────────────────────────
def test_html_to_text_strips_script_and_tags():
    assert "evil" not in html_to_text("<p>一</p><script>evil()</script><p>二</p>")
    assert "一" in html_to_text("<p>一</p><br/><p>二</p>")
    assert html_to_text("") == ""


def test_slugify_illegal_chars():
    assert "/" not in slugify('a/b:c*d?"<>|e')
    assert slugify("混沌学园") == "混沌学园"


# ── 采集主循环 ─────────────────────────────────────────────────────
def _make_feed_xml(guid="guid-1", title="AI 上新"):
    return RSS_OK.replace("guid-1", guid).replace("AI 上新", title)


def test_harvest_new_article_then_dedup(opml_file, tmp_path):
    feeds = parse_opml(opml_file)
    state, out = tmp_path / "state.json", tmp_path / "articles"
    calls = []

    def fetch(url, headers):
        calls.append(url)
        return 200, _make_feed_xml(), {}

    rep = harvest(feeds, state, out, fetch=fetch, now=time.mktime(
        time.strptime("2026-09-17 10:00", "%Y-%m-%d %H:%M")))
    assert rep.ok == 2 and rep.new_articles == 2 and not rep.breaker_tripped
    day_dir = out / "2026-09-17"
    files = list(day_dir.glob("*.md"))
    assert len(files) == 2
    body = files[0].read_text(encoding="utf-8")
    assert body.startswith("---") and "account: " in body and "source: wechat2rss-mirror" in body
    assert "正文第一段" in body and "第二段" in body and "evil" not in body
    # 二轮：同内容 → 304 语义由 200+同 guid 去重承接，零新文
    rep2 = harvest(feeds, state, out, fetch=fetch, now=time.mktime(
        time.strptime("2026-09-17 12:00", "%Y-%m-%d %H:%M")) + 7200)
    assert rep2.new_articles == 0 and rep2.ok == 2
    assert len(list(day_dir.glob("*.md"))) == 2
    st = json.loads(state.read_text(encoding="utf-8"))
    assert st["daily"]["requests"] == 4 and len(st["feeds"]) == 2


def test_harvest_304_skips_and_counts_ok(opml_file, tmp_path):
    feeds = parse_opml(opml_file)[:1]
    state, out = tmp_path / "s.json", tmp_path / "a"

    def fetch(url, headers):
        assert headers == {} or "If-Modified-Since" in headers
        return 304, None, {}

    rep = harvest(feeds, state, out, fetch=fetch)
    assert rep.ok == 1 and rep.not_modified == 1 and rep.new_articles == 0
    assert not list(out.rglob("*.md"))


def test_harvest_retry_then_success(opml_file, tmp_path):
    feeds = parse_opml(opml_file)[:1]
    n = {"i": 0}

    def fetch(url, headers):
        n["i"] += 1
        if n["i"] == 1:
            return 500, None, {}
        return 200, _make_feed_xml(), {"ETag": "W/xyz"}

    rep = harvest(feeds, state_path := tmp_path / "s.json", tmp_path / "a",
                  fetch=fetch, clock=FakeClock(), sleep=lambda s: None)
    assert rep.ok == 1 and rep.attempted == 2 and rep.new_articles == 1
    st = json.loads(state_path.read_text(encoding="utf-8"))
    assert st["feeds"][feeds[0].url]["validator"] == {"etag": "W/xyz"}


def test_harvest_failure_counts_and_daily_cap(opml_file, tmp_path):
    feeds = parse_opml(opml_file)
    state = tmp_path / "s.json"
    state.write_text(json.dumps(
        {"feeds": {}, "daily": {"day": time.strftime("%Y-%m-%d"), "requests": 2499}}),
        encoding="utf-8")

    def fetch(url, headers):
        return 200, _make_feed_xml(), {}

    rep = harvest(feeds, state, tmp_path / "a", fetch=fetch, daily_cap=2500)
    assert rep.daily_cap_hit  # 余额 1 → 第一源后停
    assert rep.attempted == 1


def test_harvest_breaker_trips_on_error_burst(tmp_path):
    from paistation.sense.rss.harvester import FeedRef
    feeds = [FeedRef(name=f"源{i}", url=f"https://x/{i}.xml") for i in range(60)]
    ck = FakeClock()

    def fetch(url, headers):
        return 503, None, {}

    rep = harvest(feeds, tmp_path / "s.json", tmp_path / "a", fetch=fetch,
                  clock=ck, sleep=lambda s: None)
    assert rep.breaker_tripped and rep.fail >= 10
    assert rep.ok + rep.fail < len(feeds)  # 提前停轮（其余源未再尝试）


def test_harvest_dormant_skip_and_weekly_probe(opml_file, tmp_path):
    feeds = parse_opml(opml_file)[:1]
    url = feeds[0].url
    state = tmp_path / "s.json"
    now0 = time.mktime(time.strptime("2026-09-10 10:00", "%Y-%m-%d %H:%M"))
    # 造休眠：连败 3 + 上次成功 8 天前 + 3 天前刚探针过 → 本轮跳过
    state.write_text(json.dumps({"feeds": {url: {
        "fail_count": 3, "last_success": now0 - 8 * 86400,
        "last_probe": now0 - 3 * 86400, "seen": []}},
        "daily": {"day": "", "requests": 0}}), encoding="utf-8")
    called = []

    def fetch(u, h):
        called.append(u)
        return 200, _make_feed_xml(), {}

    rep = harvest(feeds, state, tmp_path / "a", fetch=fetch, now=now0)
    assert rep.dormant_skipped == 1 and not called
    # 8 天后（距探针 >7d）→ 探针放行一次，成功复活
    rep2 = harvest(feeds, state, tmp_path / "a", fetch=fetch, now=now0 + 8 * 86400)
    assert rep2.probed == 1 and rep2.ok == 1
    st = json.loads(state.read_text(encoding="utf-8"))
    assert st["feeds"][url]["fail_count"] == 0
