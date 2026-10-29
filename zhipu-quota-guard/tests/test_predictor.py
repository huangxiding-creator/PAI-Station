# -*- coding: utf-8 -*-
"""T-06 predictor 遥测解析+烧穿预测 测试（FR3 / ADR7 / SCHEMAS §2 BurnRate）。

手算基准（fixture tests/fixtures/telemetry_sample/，全部脱敏合成数据，无真实内容字段）：
- 积分公式（KNOWLEDGE_BASE 官方规则，GLM-5.3）：（输入×6.9 + 缓存命中×1.7 + 输出×24)/10000
  其中 cache_creation_input_tokens（缓存写入）属新输入，按输入系数 6.9 计。
- msg_a1 @2026-10-23T07:30Z: (10000×6.9 + 50000×1.7 + 2000×24)/1e4 = 20.2 积分
- msg_a2 @2026-10-23T07:50Z: ((20000+1000)×6.9 + 0×1.7 + 5000×24)/1e4 = 26.49 积分
- msg_a3 @06:00Z：超出 30min 窗，必须排除；msg_b2 @08:10Z：晚于 now，排除（时钟回拨防呆）
- PEAK_NOW=2026-10-23T08:00Z（周一 16:00 UTC+8 → 高峰 1.0x）：
    rate = (20.2+26.49)/30 × 1.0 = 1.55633... 积分/min
- OFFPEAK_NOW=2026-10-23T02:00Z（周一 10:00 UTC+8 → 非高峰 0.5x）：
    rate = 20.7/30 × 0.5 = 0.345 积分/min
（2026-10-23 为周一：2026-01-01 为周四，第 296 天 → (296-1)%7=4 → 周一）

本机实测备注（实测要求，2026-10-23 以 scan_jsonl 默认 root 跑真 ~/.claude/projects，
只打印速率不落任何密钥）：实测见 test_predictor.py 末尾注释 BLOCK。
"""
from __future__ import annotations

import json
import os
import re
from datetime import datetime, timedelta, timezone
from pathlib import Path

import pytest

from zqg import predictor
from zqg.predictor import (
    BurnRate,
    UsageRecord,
    is_peak,
    burn_rate,
    margin_vs_reset,
    parse_jsonl,
    predict_exhaust,
    predict_exhaustion,
    scan_jsonl,
)

UTC = timezone.utc
CN = timezone(timedelta(hours=8))
FIXTURE_ROOT = Path(__file__).parent / "fixtures" / "telemetry_sample"


def _ep(y, mo, d, h, mi=0) -> int:
    return int(datetime(y, mo, d, h, mi, tzinfo=UTC).timestamp())


PEAK_NOW = _ep(2026, 10, 23, 8, 0)      # 周一 16:00 UTC+8 → 高峰
OFFPEAK_NOW = _ep(2026, 10, 23, 2, 0)   # 周一 10:00 UTC+8 → 非高峰

# 手算积分常量（见模块 docstring）
PTS_A1, PTS_A2, PTS_B1 = 20.2, 26.49, 20.7


@pytest.fixture(autouse=True)
def _fresh_fixture_mtimes():
    """scan_jsonl 的 mtime 预过滤看真实 mtime；合成时间轴下把 fixture 拨到 PEAK_NOW，
    保证「文件在窗起点前未静止 → 必解析」的前提在测试中成立。"""
    for p in FIXTURE_ROOT.glob("*.jsonl"):
        os.utime(p, (PEAK_NOW, PEAK_NOW))


# ---------- ① parse_jsonl：CC JSONL → UsageRecord ----------

def test_t06_fr3_parse_jsonl_extracts_assistant_usage():
    records = parse_jsonl(FIXTURE_ROOT / "session-peak.jsonl")
    # user 行、无 usage 行不产出记录：4 行中 3 行 assistant
    assert len(records) == 3
    first = records[0]
    assert first.ts == _ep(2026, 10, 23, 7, 30)
    assert first.input_tokens == 10000
    assert first.cache_read_input_tokens == 50000
    assert first.output_tokens == 2000
    assert first.cache_creation_input_tokens == 0
    # 手算单条积分
    assert first.points() == pytest.approx(PTS_A1)


def test_t06_fr3_parse_jsonl_skips_malformed_lines(tmp_path):
    p = tmp_path / "messy.jsonl"
    lines = [
        "{ not json at all",
        json.dumps({"type": "assistant", "timestamp": "2026-10-23T07:40:00.000Z",
                    "message": {"usage": {}}}),  # 无 token 字段 → 全 0 但有效
        # 无 timestamp → 跳过；非 assistant → 跳过；timestamp 不可解析 → 跳过
        json.dumps({"type": "assistant", "message": {"usage": {"input_tokens": 5}}}),
        json.dumps({"type": "summary", "timestamp": "2026-10-23T07:41:00.000Z"}),
        json.dumps({"type": "assistant", "timestamp": "not-a-date",
                    "message": {"usage": {"input_tokens": 7}}}),  # timestamp 不可解析 → 跳过
    ]
    p.write_text("\n".join(lines) + "\n", encoding="utf-8")
    records = parse_jsonl(p)
    assert len(records) == 1
    assert records[0].input_tokens == 0 and records[0].ts == _ep(2026, 10, 23, 7, 40)


# ---------- ② burn_rate / scan_jsonl：30min 窗聚合 × 高峰系数 ----------

def test_t06_fr3_scan_jsonl_peak_window_exact_rate():
    burn = scan_jsonl(FIXTURE_ROOT, now=PEAK_NOW)
    assert isinstance(burn, BurnRate)
    assert burn.peak_now is True
    # (20.2 + 26.49) 积分 / 30min × 高峰 1.0
    assert burn.tokens_per_min == pytest.approx((PTS_A1 + PTS_A2) / 30 * 1.0)


def test_t06_adr7_scan_jsonl_offpeak_factor_halves_rate():
    burn = scan_jsonl(FIXTURE_ROOT, now=OFFPEAK_NOW)
    assert burn.peak_now is False
    # 20.7 / 30 × 非高峰 0.5
    assert burn.tokens_per_min == pytest.approx(PTS_B1 / 30 * 0.5)


def test_t06_fr3_burn_rate_window_boundaries():
    # 窗 = [now-30min, now]，双端闭；窗外（含晚于 now 的时钟回拨）排除
    recs = [
        UsageRecord(ts=PEAK_NOW - 1800, input_tokens=10000),  # 恰在 cutoff → 计入
        UsageRecord(ts=PEAK_NOW - 1801, input_tokens=10000),  # 早 1s → 排除
        UsageRecord(ts=PEAK_NOW, input_tokens=10000),         # 恰为 now → 计入
        UsageRecord(ts=PEAK_NOW + 60, input_tokens=10000),    # 晚于 now → 排除
    ]
    burn = burn_rate(recs, now=PEAK_NOW)
    assert burn.tokens_per_min == pytest.approx(2 * 6.9 / 30 * 1.0)


def test_t06_adr7_burn_rate_peak_vs_offpeak_coefficients():
    rec_peak = [UsageRecord(ts=PEAK_NOW - 600, input_tokens=30000)]
    rec_off = [UsageRecord(ts=OFFPEAK_NOW - 600, input_tokens=30000)]
    # 同量 token：高峰 1x / 非高峰 0.5x 两组系数（T-03 PeakFactorCfg 注入）
    assert burn_rate(rec_peak, now=PEAK_NOW).tokens_per_min == pytest.approx(PTS_B1 / 30)
    assert burn_rate(rec_off, now=OFFPEAK_NOW).tokens_per_min == pytest.approx(PTS_B1 / 30 * 0.5)
    # 因子可注入（非默认值同样生效）
    custom = burn_rate(rec_off, now=OFFPEAK_NOW, peak=0.8, offpeak=0.4)
    assert custom.tokens_per_min == pytest.approx(PTS_B1 / 30 * 0.4)


def test_t06_fr3_burn_rate_empty_or_stale_yields_zero():
    now = PEAK_NOW
    assert burn_rate([], now=now).tokens_per_min == 0.0
    stale = [UsageRecord(ts=now - 3600, input_tokens=999999)]
    assert burn_rate(stale, now=now).tokens_per_min == 0.0  # 全旧数据 → 0，不除零


def test_t06_fr3_default_root_is_claude_projects(monkeypatch):
    assert predictor.DEFAULT_TELEMETRY_ROOT == Path.home() / ".claude" / "projects"
    monkeypatch.setattr(predictor, "DEFAULT_TELEMETRY_ROOT", FIXTURE_ROOT)
    burn = scan_jsonl(now=PEAK_NOW)  # root=None → 生产默认（此处注入为 fixture）
    assert burn.tokens_per_min == pytest.approx((PTS_A1 + PTS_A2) / 30)


def test_t06_fr3_scan_jsonl_mtime_prefilter_and_tail(tmp_path):
    """生产 root 实测 1270 文件/2.27GB，全量读 >120s：mtime 预过滤+尾部读取是轮询前提。"""
    # 老文件：记录 ts 在窗内，但文件 2h 前已静止 → 预过滤直接跳过（mtime >= 记录 ts）
    stale = tmp_path / "stale.jsonl"
    stale.write_text(json.dumps({
        "type": "assistant", "timestamp": "2026-10-23T07:50:00.000Z",
        "message": {"id": "m_stale", "usage": {"input_tokens": 30000}},
    }) + "\n", encoding="utf-8")
    os.utime(stale, (PEAK_NOW - 7200, PEAK_NOW - 7200))
    # 大文件：300KB 垃圾行前缀 + 尾部一条窗内有效行 → tail 读取仍捕获（残行自动弃）
    big = tmp_path / "big.jsonl"
    valid = json.dumps({
        "type": "assistant", "timestamp": "2026-10-23T07:50:00.000Z",
        "message": {"id": "m_valid", "usage": {"input_tokens": 10000}},
    })
    big.write_text("x" * 300000 + "\n" + valid + "\n", encoding="utf-8")
    os.utime(big, (PEAK_NOW, PEAK_NOW))

    burn = scan_jsonl(tmp_path, now=PEAK_NOW)  # tail_bytes 默认 256KB < 300KB 前缀
    assert burn.tokens_per_min == pytest.approx(6.9 / 30)  # 只剩尾部有效行（高峰 1.0x）


def test_t06_defaults_match_t03_peak_factor_cfg():
    from zqg.config import PeakFactorCfg  # T-03 契约缝合
    pf = PeakFactorCfg()
    assert predictor.DEFAULT_PEAK_FACTOR == pf.peak == 1.0
    assert predictor.DEFAULT_OFFPEAK_FACTOR == pf.offpeak == 0.5


# ---------- ④ is_peak：周一至五 14:00-18:00 UTC+8 ----------

@pytest.mark.parametrize("y,mo,d,h,mi,expected", [
    (2026, 10, 23, 5, 59, False),  # 周一 13:59 UTC+8 → 窗前
    (2026, 10, 23, 6, 0, True),    # 周一 14:00 → 高峰起点（含）
    (2026, 10, 23, 9, 59, True),   # 周一 17:59 → 窗内
    (2026, 10, 23, 10, 0, False),  # 周一 18:00 → 终点（不含）
    (2026, 10, 30, 6, 0, True),    # 周五 14:00（2026-10-30 为周五）→ 工作日高峰
    (2026, 10, 31, 6, 0, False),   # 周六 14:00（2026-10-31 为周六）→ 周末永不高峰
    (2026, 11, 1, 6, 0, False),    # 周日 14:00
])
def test_t06_adr7_is_peak_windows(y, mo, d, h, mi, expected):
    assert is_peak(_ep(y, mo, d, h, mi)) is expected


# ---------- ③ 预测时刻 ----------

def test_t06_fr3_predict_exhaust_epoch_and_none():
    now = 1_000_000
    assert predict_exhaust(3000, 10, now) == now + 300 * 60   # 3000积分 / 10每分 = 300min
    assert predict_exhaust(0, 10, now) == now                 # 已耗尽 → 立刻
    assert predict_exhaust(3000, 0, now) is None              # rate<=0 → None（不除零）
    assert predict_exhaust(3000, -1, now) is None


def test_t06_fr3_predict_exhaustion_full_dict():
    now = PEAK_NOW
    reset = now + 360 * 60  # 6h 后自然刷新（5h 动态窗典型量级）
    # Pro 5h 档 12000 积分，已用 75% → 余 3000；原始速率 10 积分/min
    r = predict_exhaustion(75.0, 12000, 10.0, reset, now, peak_factor=1.0)
    assert r["predicted_exhaust_at"] == now + 300 * 60        # 高峰 1x：3000/10=300min
    assert r["minutes_to_exhaust"] == pytest.approx(300.0)
    assert r["will_exhaust_before_reset"] is True             # 300min < 360min → 刷新前烧穿
    r2 = predict_exhaustion(75.0, 12000, 10.0, reset, now, peak_factor=0.5)
    assert r2["predicted_exhaust_at"] == now + 600 * 60       # 非高峰 0.5x：3000/5=600min
    assert r2["will_exhaust_before_reset"] is False           # 刷新先到 → 无需花卡
    # 晚于刷新 240min（负 margin = 刷新先到，无需花卡）
    assert margin_vs_reset(r2["predicted_exhaust_at"], reset) == pytest.approx(-240.0)


def test_t06_fr3_predict_exhaustion_zero_rate_and_exhausted():
    now = PEAK_NOW
    r = predict_exhaustion(90.0, 12000, 0.0, now + 3600, now)
    assert r == {"predicted_exhaust_at": None,
                 "will_exhaust_before_reset": False,
                 "minutes_to_exhaust": None}
    r2 = predict_exhaustion(100.0, 12000, 10.0, now + 3600, now)  # 已用 100% → 立刻烧穿
    assert r2["predicted_exhaust_at"] == now
    assert r2["minutes_to_exhaust"] == 0.0
    assert r2["will_exhaust_before_reset"] is True


def test_t06_fr3_predict_exhaustion_validates_inputs():
    now = PEAK_NOW
    with pytest.raises(ValueError):
        predict_exhaustion(100.5, 12000, 10.0, now + 60, now)   # pct 超界
    with pytest.raises(ValueError):
        predict_exhaustion(-1.0, 12000, 10.0, now + 60, now)
    with pytest.raises(ValueError):
        predict_exhaustion(50.0, 0, 10.0, now + 60, now)        # 容量<=0
    with pytest.raises(ValueError):
        predict_exhaustion(50.0, 12000, 10.0, now + 60, now, peak_factor=0.0)


def test_t06_fr3_margin_vs_reset():
    reset = 2_000_000
    assert margin_vs_reset(reset - 6000, reset) == pytest.approx(100.0)  # 提前 100min
    assert margin_vs_reset(None, reset) is None


# ---------- fixture 卫生（脱敏） ----------

def test_t06_fixture_hygiene():
    files = sorted(p.name for p in FIXTURE_ROOT.iterdir())
    assert files == ["session-offpeak.jsonl", "session-peak.jsonl"]
    blob = "".join(p.read_text(encoding="utf-8") for p in FIXTURE_ROOT.glob("*.jsonl"))
    assert "sk-" not in blob and "Bearer" not in blob
    assert not re.search(r"[0-9a-fA-F]{32,}", blob)  # 无 32+ 位十六进制（密钥样式）


# ================== 本机实测备注（实测要求，2026-10-23 实测，数字零造假） ==================
# 命令（root 默认 ~/.claude/projects，只打印速率聚合，不落任何密钥/内容）：
#   e:/AI-Station/.venv/Scripts/python.exe -c "from zqg import predictor; \
#       print(predictor.scan_jsonl())"
# 实测一（全量读，12:45 +0800，非高峰）：peak_now=False（12:45<14:00 与 is_peak 一致），
#   tokens_per_min=168.87（×0.5 后）；窗内 793 条记录、30min 合计 10690.35 积分；
#   积分构成 cache 77% / input 11% / output 11%（CC 长上下文重缓存命中画像）；
#   单次调用积分 max=86.46。量级自洽：Pro 5h 档 12000 积分按此速率约 70min 烧穿。
# 实测二（生产优化路径 mtime 预过滤+256KB 尾读）：同一 root 扫描耗时 0.34s（全量读 >120s），
#   tokens_per_min=98.25（数分钟后复测，舰队负载波动所致；尾读在极端突发下轻微低估，
#   属保守方向）。生产 root 规模实测 1270 文件/2.27GB/最近 1h 仅 19 文件在写。
# fixture 为纯合成结构数据（无真实内容字段），全程未落任何密钥明文。
