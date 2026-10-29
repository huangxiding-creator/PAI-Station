"""T-02 ledger 账本测试（covers FR8 观测 / NFR4 fail-loud）。

契约源：SCHEMAS §2 RunLedgerEntry {ts,kind,payload}、§4 账本文件、
kind 枚举=poll|decision|reset_exec|reset_result|notify|heartbeat|login|drift|error。
"""
import json
import re
from datetime import datetime
from pathlib import Path

import pytest

from zqg.ledger import KINDS, InvalidKindError, Ledger, redact

# 注入时钟锚点：naive datetime → epoch 秒（本地时区），与实现内 localtime 往返一致
FIXED = datetime(2026, 1, 1, 12, 0, 0).timestamp()
FIXED_DAY = "run-20260101.jsonl"

SECRET_KEY = "sk-1234567890abcdefWXYZ"
HEX32 = "1234567890abcdef1234567890abcdef"


@pytest.fixture
def ledger(tmp_path):
    return Ledger(tmp_path / "ledger")


def _clock_seq(base, step=1.0):
    """返回逐步推进的时钟闭包（epoch 秒），供 ts 单调递增的追加。"""
    state = {"t": base}

    def now():
        val = state["t"]
        state["t"] += step
        return val

    return now


def _day_path(ledger):
    return Path(ledger.base_dir) / FIXED_DAY


# ---------------------------------------------------------------- append/文件
def test_req_008_ac1_append_writes_jsonl_line_with_ms_ts(ledger):
    ledger._now = lambda: FIXED
    entry = ledger.append("poll", {"provider": "zai", "window_pct": 12.5})

    day = _day_path(ledger)
    assert day.exists(), "按日分文件 ledger/run-YYYYMMDD.jsonl"
    lines = day.read_text(encoding="utf-8").splitlines()
    assert len(lines) == 1, "append 一次一行"

    obj = json.loads(lines[0])
    assert obj == {"ts": int(FIXED * 1000), "kind": "poll",
                   "payload": {"provider": "zai", "window_pct": 12.5}}
    assert isinstance(obj["ts"], int) and 1e12 < obj["ts"] < 4.7e12, "ts=epoch 毫秒"
    assert entry["ts"] == obj["ts"]


def test_req_008_ac2_day_rollover_splits_files(tmp_path):
    led = Ledger(tmp_path / "ledger")
    d1 = datetime(2026, 1, 31, 23, 59, 0).timestamp()
    d2 = datetime(2026, 2, 1, 0, 1, 0).timestamp()

    led._now = lambda: d1
    led.append("poll", {"i": 1})
    led._now = lambda: d2
    led.append("poll", {"i": 2})

    names = sorted(p.name for p in (tmp_path / "ledger").glob("run-*.jsonl"))
    assert names == ["run-20260131.jsonl", "run-20260201.jsonl"]
    assert len(json.loads((tmp_path / "ledger" / names[0]).read_text(
        encoding="utf-8").splitlines()[0])["payload"]) == 1


# --------------------------------------------------------------------- read
def test_req_008_ac3_read_filters_kinds_since_limit(ledger):
    ledger._now = _clock_seq(FIXED)
    kinds_seq = ["poll", "poll", "decision", "heartbeat", "poll"]
    for k in kinds_seq:
        ledger.append(k, {"k": k})
    ts = [int((FIXED + i) * 1000) for i in range(5)]

    all_e = ledger.read()
    assert [e["kind"] for e in all_e] == kinds_seq
    assert [e["ts"] for e in all_e] == ts, "时间序"

    assert [e["kind"] for e in ledger.read(kinds={"poll"})] == ["poll"] * 3
    assert [e["ts"] for e in ledger.read(since=ts[2])] == ts[2:], "since 含等于时刻"
    tail2 = ledger.read(limit=2)
    assert [e["kind"] for e in tail2] == ["heartbeat", "poll"], "limit=最近N条"


def test_req_008_ac4_read_tail_and_read_range(ledger):
    ledger._now = _clock_seq(FIXED)
    for k in ["poll", "decision", "reset_exec", "decision"]:
        ledger.append(k, {})

    assert [e["kind"] for e in ledger.read_tail(2)] == ["reset_exec", "decision"]
    decisions = ledger.read_range("decision")
    assert [e["kind"] for e in decisions] == ["decision", "decision"]
    assert ledger.read_range("decision", limit=1) == decisions[-1:]


def test_req_008_ac8_read_tolerates_torn_tail_line(ledger):
    ledger._now = lambda: FIXED
    ledger.append("poll", {"ok": True})
    _day_path(ledger).open("a", encoding="utf-8").write('{"ts": 1, "kind": "pol')

    assert len(ledger.read()) == 1, "崩溃残留撕裂尾行跳过，不抛不静默写"


# ------------------------------------------------------------- kind 枚举校验
def test_req_008_ac5_kind_enum_exact_and_invalid_rejected(ledger):
    assert set(KINDS) == {"poll", "decision", "reset_exec", "reset_result",
                          "notify", "heartbeat", "login", "drift", "error"}
    for k in KINDS:
        ledger.append(k, {"x": 1})
    assert len(ledger.read()) == len(KINDS)

    with pytest.raises(InvalidKindError):
        ledger.append("bogus", {})
    with pytest.raises(InvalidKindError):
        ledger.read(kinds={"nope"})
    assert len(ledger.read()) == len(KINDS), "拒绝写入不产生任何行"


# ------------------------------------------------------------------ 脱敏
def test_req_008_ac6_redact_before_persist(ledger):
    ledger._now = lambda: FIXED
    payload = {
        "api_key": SECRET_KEY,
        "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.payload.sig",
        "plan_key": HEX32,
        "note": f"free text {SECRET_KEY} hash {HEX32} end",
        "nested": [{"session_token": "abcdef1234567890abcdef1234567890", "keep": 42}],
    }
    ledger.append("login", payload)

    raw = _day_path(ledger).read_text(encoding="utf-8")
    assert not re.search(r"sk-[A-Za-z0-9_\-]{8,}", raw), "无 sk- 串"
    assert not re.search(r"[0-9a-fA-F]{32,}", raw), "无 32+ 位十六进制"

    p = ledger.read()[0]["payload"]
    assert p["api_key"] == "sk-1***", "敏感字段仅留前4位"
    assert p["Authorization"] == "Bear***"
    assert p["plan_key"] == "1234***"
    assert p["nested"][0]["session_token"] == "abcd***"
    assert p["nested"][0]["keep"] == 42
    assert "hash 1234***" in p["note"] and "sk-***" in p["note"], "正文中密钥串清洗"
    assert payload["api_key"] == SECRET_KEY, "redact 不改调用方原对象"


def test_req_008_ac6b_redact_unit_non_string_secrets():
    out = redact({"TOKEN": None, "password": 12345, "ok": "plain"})
    assert out == {"TOKEN": "***", "password": "***", "ok": "plain"}


# ------------------------------------------------------------- cards.json 缓存
def test_req_008_ac7_cards_cache_roundtrip(ledger):
    cards = {"five_hour": [{"count": 2, "expire_at": 1790000000}],
             "weekly": [], "fetched_at": 1790000001}
    assert ledger.load_cards() is None, "缺省 default=None"
    assert ledger.load_cards(default={}) == {}

    ledger.save_cards(cards)
    assert (Path(ledger.base_dir) / "cards.json").exists()
    assert ledger.load_cards() == cards


# ----------------------------------------------------------------- fail loud
def test_nfr_004_ac1_write_failure_raises_not_swallowed(tmp_path):
    blocker = tmp_path / "blocker"
    blocker.write_text("目录位置被普通文件占用", encoding="utf-8")
    led = Ledger(blocker)

    with pytest.raises(OSError):
        led.append("poll", {})  # 写失败必须异常上抛（fail loud）


def test_nfr_004_ac2_unserializable_payload_raises_no_partial_write(ledger):
    with pytest.raises(TypeError):
        ledger.append("poll", object())
    assert not any(Path(ledger.base_dir).glob("run-*.jsonl")), "失败不落半行"
