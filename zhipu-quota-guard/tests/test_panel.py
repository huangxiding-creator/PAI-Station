# -*- coding: utf-8 -*-
"""T-12 panel 单文件状态面板测试（covers FR8 观测：本地面板 + 每日汇总）。

契约源：SCHEMAS §2（QuotaSnapshot/CardInventory/Decision/RunLedgerEntry）、
ARCHITECTURE「panel.py 读账本→panel/index.html」、T-02 账本脱敏复用。
数据全部来自 fixture 账本（C10：面板不直连 API，仅读 run-ledger + cards 缓存）。
"""
import time
from datetime import date, datetime
from pathlib import Path

from zqg.ledger import Ledger
from zqg.panel import daily_digest, render

FIXED = datetime(2026, 1, 1, 12, 0, 0).timestamp()          # 2026-01-01 12:00 本地
DAY_BEFORE = datetime(2025, 12, 30, 9, 0, 0).timestamp()     # 7 日窗内的前一天
SECRET_KEY = "sk-1234567890abcdefWXYZ"
HEX32 = "1234567890abcdef1234567890abcdef"


def _at(ts):
    return lambda: ts


def _build(tmp_path) -> Ledger:
    led = Ledger(tmp_path / "ledger")
    plan = [
        # (ts, kind, payload) —— 时间序追加，跨两日文件
        (DAY_BEFORE, "reset_exec", {"card_to_use": "five_hour", "no": 0}),
        (FIXED - 600, "poll", {"provider": "zai", "window_pct": 12.5,
                               "remaining": 888.8, "next_reset_at": FIXED + 1800,
                               "api_key": SECRET_KEY}),
    ]
    plan += [(FIXED - 540 + i, "notify", {"tag": f"ev-{i:02d}"}) for i in range(25)]
    plan += [
        (FIXED - 300, "heartbeat", {"alive": True}),
        (FIXED - 290, "heartbeat", {"alive": True}),
        (FIXED - 280, "heartbeat", {"alive": True}),
        (FIXED - 240, "decision", {
            "action": "reset", "reason": "预测烧穿早于自然刷新30分钟，卡余6张",
            "predicted_exhaust_at": FIXED + 1500, "card_to_use": "five_hour"}),
        (FIXED - 200, "reset_exec", {"card_to_use": "five_hour", "no": 1}),
        (FIXED - 100, "poll", {"provider": "zai", "window_pct": 87.5,
                               "remaining": 123.4, "next_reset_at": FIXED + 1800}),
        (FIXED - 90, "error", {"msg": "quota 拉取失败", "trace": HEX32}),
    ]
    for ts, kind, payload in plan:
        led._now = _at(ts)
        led.append(kind, payload)
    exp1, exp2, exp3 = FIXED + 86400 * 5, FIXED + 86400 * 9, FIXED + 86400 * 20
    led.save_cards({"five_hour": [{"count": 5, "expire_at": exp1},
                                  {"count": 2, "expire_at": exp2}],
                    "weekly": [{"count": 3, "expire_at": exp3}],
                    "fetched_at": FIXED - 60})
    return led


# ------------------------------------------------------------- render 四区块
def test_req_t12_ac1_render_shows_water_cards_burn_events(tmp_path):
    html = render(_build(tmp_path), now=FIXED + 600)

    # 区块1 水位：最近 poll 的 window_pct + 下次自然刷新时刻
    assert "87.5" in html, "水位取最近一条 poll"
    assert time.strftime("%m-%d %H:%M", time.localtime(FIXED + 1800)) in html
    assert "zai" in html

    # 区块2 预测烧穿线：predicted_exhaust_at 早于 next_reset_at → 烧穿提示 + 决策文案
    assert time.strftime("%m-%d %H:%M", time.localtime(FIXED + 1500)) in html
    assert "烧穿" in html
    assert "卡余6张" in html, "T-07 Decision.reason 原文上板"

    # 区块3 卡库存：5h 总张数 5+2=7、周卡 3、预算 7-1=6、最近过期日期
    assert "5h" in html and ">7<" in html
    assert "<b>3</b>" in html, "周卡总数 3"
    assert "<b>6</b>" in html, "卡预算 = 5h 可用 7 − 预留 1"
    assert time.strftime("%Y-%m-%d", time.localtime(FIXED + 86400 * 5)) in html

    # 区块4 最近动作：账本尾 20 条（7 条尾部事件 + ev-12..ev-24）
    assert "ev-24" in html and "ev-12" in html
    assert "ev-11" not in html and "ev-00" not in html, "只展示最近 20 条"
    assert "heartbeat" in html and "decision" in html

    # 七日重置次数：12-30 与 01-01 各 1 次
    assert ">2<" in html


def test_req_t12_ac2_single_file_no_external_refs(tmp_path):
    html = render(_build(tmp_path), now=FIXED + 600)
    assert "http://" not in html and "https://" not in html, "零外链"
    assert "<script src" not in html and "<link" not in html, "零外部资源"


def test_req_t12_ac3_no_secret_material_in_html(tmp_path):
    html = render(_build(tmp_path), now=FIXED + 600)
    assert SECRET_KEY not in html, "T-02 redact 后的账本不再含原始 sk- 串"
    assert "Bearer " not in html
    assert HEX32 not in html, "32+ 位十六进制已被账本脱敏"


def test_req_t12_ac4_writes_index_html_and_returns_same_string(tmp_path):
    led = _build(tmp_path)
    html = render(led, now=FIXED + 600)
    out = Path(led.base_dir).parent / "panel" / "index.html"
    assert out.exists(), "默认写出 ledger 兄弟目录 panel/index.html"
    assert out.read_text(encoding="utf-8") == html
    assert html.lstrip().startswith("<!DOCTYPE html>")


def test_req_t12_ac5_inline_json_injected_for_frontend(tmp_path):
    html = render(_build(tmp_path), now=FIXED + 600)
    assert "PANEL_DATA" in html, "inline JSON 注入供前端自刷新"
    assert '"window_pct"' in html and "87.5" in html


def test_req_t12_ac6_empty_ledger_renders_placeholders(tmp_path):
    html = render(Ledger(tmp_path / "empty"), now=FIXED)
    assert "无数据" in html, "空账本不崩溃，占位符展示"


# ------------------------------------------------------------ daily_digest
def test_req_t12_ac7_daily_digest_counts_per_day(tmp_path):
    led = _build(tmp_path)
    md = daily_digest(date(2026, 1, 1), led)
    assert "2026-01-01" in md
    assert "12.5" in md and "87.5" in md, "水位区间取当日 poll min/max"
    assert "决策次数: 1" in md
    assert "重置次数: 1" in md
    assert "心跳计数: 3" in md

    md2 = daily_digest("20251230", led)
    assert "重置次数: 1" in md2, "跨日事件归到各自日期"
    assert "无数据" in md2, "当日无 poll 时水位区间占位"
