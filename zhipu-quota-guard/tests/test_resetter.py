# -*- coding: utf-8 -*-
"""T-10 resetter 测试 — 全程 fake transport + mock JWT，零真请求、零真延迟。

对齐任务验收（KNOWLEDGE_BASE/reset-protocol.md 为契约源）：
- fetch_status: GET /status 解析可用卡槽 + 最近使用历史
- execute: POST /use 携 uuid4 幂等键 + 双凭证头；动作前后各一次 3-8s 随机抖动
- dry_run: transport 调用计数=0，账本 reset_exec/reset_result 附 simulated=true
- 失败分类: 429→ThrottledError(退避) / code!=0→BizError(msg) / 网络→重试3次后 RetryableError
- 同卡 24h 冷却: >2 次失败拒发 RefuseRetry（state/reset_cooldown.json 持久化）
"""
import json
import uuid

import pytest

from zqg.ledger import Ledger
from zqg.resetter import (
    COOLDOWN_WINDOW_S,
    JITTER_MAX_S,
    JITTER_MIN_S,
    BizError,
    RefuseRetry,
    ResetClient,
    RetryableError,
    ThrottledError,
    default_jwt_provider,
)

NOW = 1_791_000_000.0  # 固定时钟（2026-10-23 之后, 可注入）
JWT = "fake-jwt.header.sig"
PLAN_KEY = "pk-test-123"


class RecordingTransport:
    """fake transport: 按脚本回放响应/异常，记录全部调用与事件序。"""

    def __init__(self, script, events):
        self.script = list(script)
        self.events = events
        self.calls = []

    def __call__(self, url, headers, data=None):
        self.calls.append({"url": url, "headers": dict(headers), "data": data})
        self.events.append(("transport", url.rsplit("/", 1)[-1]))  # "use"/"status"
        item = self.script.pop(0) if self.script else (200, {"code": 0, "data": {"used": True}})
        if isinstance(item, Exception):
            raise item
        return item


def make_client(state_dir, script=(), mode="auto", rng_seq=(0.0,), ledger=None,
                retries=3, jwt_provider=None):
    events = []
    transport = RecordingTransport(script, events)
    rng = iter(rng_seq)
    return ResetClient(
        jwt_provider=jwt_provider or (lambda: JWT),
        plan_key=PLAN_KEY,
        transport=transport,
        rng=lambda: next(rng, 0.5),   # 序列耗尽回落 0.5（仍在 [0,1)）
        sleep=lambda s: events.append(("sleep", s)),
        now=lambda: NOW,
        mode=mode,
        state_dir=state_dir,
        ledger=ledger,
        retries=retries,
    ), transport, events


def ok_body():
    return (200, {"code": 0, "data": {"used": True}})


def write_cooldown(state_dir, mapping):
    path = state_dir / "reset_cooldown.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(mapping), encoding="utf-8")
    return path


# ---------------- fetch_status ----------------

def test_t10_fetch_status_parses_slots_and_history(tmp_path):
    body = {"code": 0, "data": {
        "available_five_hour_resets": [{"recordId": 6}, {"recordId": 7}],
        "available_week_resets": [],
        "latest_five_hour_reset_history": {"usedAt": "2026-10-23 10:00:00"},
        "latest_week_reset_history": None,
    }}
    client, transport, _ = make_client(tmp_path, script=[(200, body)])
    st = client.fetch_status()
    assert st["available_five_hour_resets"][0]["recordId"] == 6
    assert len(st["available_five_hour_resets"]) == 2
    assert st["available_week_resets"] == []
    assert st["latest_five_hour_reset_history"]["usedAt"] == "2026-10-23 10:00:00"
    assert st["fetched_at"] == int(NOW)
    # GET /status + 双凭证头（Authorization=登录态 JWT, X-Bigmodel-Authorization=套餐Key）
    call = transport.calls[0]
    assert call["url"].endswith("/status") and call["data"] is None
    assert call["headers"]["Authorization"] == f"Bearer {JWT}"
    assert call["headers"]["X-Bigmodel-Authorization"] == PLAN_KEY
    assert call["headers"]["Bigmodel-Target-Type"] == "PERSONAL"


def test_t10_fetch_status_error_mapping(tmp_path):
    # 429 → ThrottledError（上层退避）
    client, _, _ = make_client(tmp_path, script=[(429, {"code": 429, "message": "rate limited"})])
    with pytest.raises(ThrottledError):
        client.fetch_status()
    # code != 0 → BizError 带站方 message
    client2, _, _ = make_client(tmp_path, script=[(200, {"code": 1001, "message": "unauthorized"})])
    with pytest.raises(BizError) as ei:
        client2.fetch_status()
    assert "unauthorized" in str(ei.value)


# ---------------- execute: 请求形状 ----------------

def test_t10_execute_posts_use_with_uuid_idempotency_and_dual_headers(tmp_path):
    client, transport, _ = make_client(tmp_path, script=[ok_body(), ok_body()])
    res = client.execute("five_hour")
    assert res["ok"] is True and res["simulated"] is False
    assert res["used"] is True and res["http_status"] == 200

    call = transport.calls[0]
    assert call["url"].endswith("/use")
    payload = json.loads(call["data"])
    assert payload["reset_type"] == "five_hour"
    uuid.UUID(payload["idempotency_key"])  # 合法 uuid4 形
    assert call["headers"]["Authorization"] == f"Bearer {JWT}"
    assert call["headers"]["X-Bigmodel-Authorization"] == PLAN_KEY
    assert call["headers"]["Bigmodel-Target-Type"] == "PERSONAL"
    assert call["headers"]["Content-Type"] == "application/json"

    # 每次执行幂等键新生成; weekly 别名归一为线上值 week
    res2 = client.execute("weekly")
    payload2 = json.loads(transport.calls[1]["data"])
    assert payload2["reset_type"] == "week"
    assert payload2["idempotency_key"] != payload["idempotency_key"]


def test_t10_execute_rejects_unknown_reset_type(tmp_path):
    client, transport, _ = make_client(tmp_path)
    with pytest.raises(ValueError):
        client.execute("monthly")
    assert transport.calls == []


# ---------------- execute: 拟人抖动 ----------------

def test_t10_execute_jitter_bounds_and_order(tmp_path):
    # rng 序列 [0.0, 1.0] → 延迟恰为 [3.0, 8.0]，动作前/后各一次（注入点可断言）
    client, _, events = make_client(tmp_path, script=[ok_body()], rng_seq=[0.0, 1.0])
    client.execute("five_hour")
    assert events == [("sleep", 3.0), ("transport", "use"), ("sleep", 8.0)]
    for kind, val in events:
        if kind == "sleep":
            assert JITTER_MIN_S <= val <= JITTER_MAX_S

    # 中点 rng → 5.5s，仍落在 [3,8]
    client2, _, events2 = make_client(tmp_path, script=[ok_body()], rng_seq=[0.5, 0.5])
    client2.execute("five_hour")
    assert events2 == [("sleep", 5.5), ("transport", "use"), ("sleep", 5.5)]


# ---------------- execute: dry_run ----------------

def test_t10_dry_run_zero_network_and_simulated_ledger(tmp_path):
    ledger = Ledger(tmp_path / "ledger")
    client, transport, events = make_client(
        tmp_path, script=[ok_body()], mode="dry_run", ledger=ledger)
    res = client.execute("five_hour")
    assert transport.calls == []          # 零网络
    assert events == []                    # 零延迟（无动作即无抖动/退避）
    assert res["simulated"] is True and res["ok"] is True

    entries = ledger.read(kinds={"reset_exec", "reset_result"})
    assert [e["kind"] for e in entries] == ["reset_exec", "reset_result"]
    assert all(e["payload"]["simulated"] is True for e in entries)
    assert entries[1]["payload"]["ok"] is True


# ---------------- execute: 失败分类 ----------------

def test_t10_throttled_on_429_not_counted_as_card_failure(tmp_path):
    client, _, _ = make_client(tmp_path, script=[(429, {"code": 429, "message": "限流"})])
    with pytest.raises(ThrottledError):
        client.execute("five_hour")
    # 429=限流退避, 不计入同卡失败冷却（未写冷却文件或其中无失败记录）
    cd_path = tmp_path / "reset_cooldown.json"
    mapping = json.loads(cd_path.read_text(encoding="utf-8")) if cd_path.exists() else {}
    assert mapping.get("five_hour", []) == []


def test_t10_biz_error_on_nonzero_code_records_cooldown(tmp_path):
    client, _, _ = make_client(tmp_path, script=[(200, {"code": 1213, "message": "无可用卡"})])
    with pytest.raises(BizError) as ei:
        client.execute("five_hour")
    assert "无可用卡" in str(ei.value)
    mapping = json.loads((tmp_path / "reset_cooldown.json").read_text(encoding="utf-8"))
    assert len(mapping["five_hour"]) == 1
    assert mapping["five_hour"][0]["ts"] == int(NOW)


def test_t10_network_retry_then_retryable_error(tmp_path):
    client, transport, events = make_client(
        tmp_path, script=[OSError("conn reset")] * 4, rng_seq=[0.0])
    with pytest.raises(RetryableError) as ei:
        client.execute("five_hour")
    assert "重试 3 次" in str(ei.value)
    assert len(transport.calls) == 4        # 1 次 + 重试 3 次
    # 事件序: 前抖动一次 + 三次退避（2s/4s/6s），无后抖动（未获响应）
    assert events == [("sleep", 3.0), ("transport", "use"),
                      ("sleep", 2.0), ("transport", "use"),
                      ("sleep", 4.0), ("transport", "use"),
                      ("sleep", 6.0), ("transport", "use")]
    mapping = json.loads((tmp_path / "reset_cooldown.json").read_text(encoding="utf-8"))
    assert len(mapping["five_hour"]) == 1


def test_t10_network_retry_succeeds_second_attempt(tmp_path):
    client, transport, _ = make_client(
        tmp_path, script=[OSError("timeout"), ok_body()], rng_seq=[0.0, 0.0])
    res = client.execute("five_hour")
    assert res["ok"] is True and res["simulated"] is False
    assert len(transport.calls) == 2


# ---------------- 同卡 24h 冷却 ----------------

def test_t10_cooldown_refuses_after_three_failures_24h(tmp_path):
    write_cooldown(tmp_path, {"five_hour": [
        {"ts": NOW - 3600, "error": "BizError: 1"},
        {"ts": NOW - 1800, "error": "BizError: 2"},
        {"ts": NOW - 600, "error": "BizError: 3"},
    ]})
    client, transport, _ = make_client(tmp_path, script=[ok_body()])
    with pytest.raises(RefuseRetry) as ei:
        client.execute("five_hour")
    assert "3 次" in str(ei.value)
    assert transport.calls == []            # 拒发先于任何网络动作

    # dry_run 同规则（模拟行为与实弹一致，不因演练绕过冷却）
    client_dry, transport_dry, _ = make_client(
        tmp_path, script=[ok_body()], mode="dry_run")
    with pytest.raises(RefuseRetry):
        client_dry.execute("five_hour")
    assert transport_dry.calls == []


def test_t10_cooldown_prunes_entries_older_than_24h(tmp_path):
    write_cooldown(tmp_path, {"five_hour": [
        {"ts": NOW - COOLDOWN_WINDOW_S - 10, "error": "太老的失败"},  # 窗外剪枝
        {"ts": NOW - 100, "error": "BizError: 2"},
        {"ts": NOW - 50, "error": "BizError: 3"},
    ]})
    client, transport, _ = make_client(tmp_path, script=[ok_body()], rng_seq=[0.0, 0.0])
    res = client.execute("five_hour")
    assert res["ok"] is True and len(transport.calls) == 1


def test_t10_cooldown_cleared_on_success(tmp_path):
    write_cooldown(tmp_path, {"five_hour": [
        {"ts": NOW - 600, "error": "BizError: 1"},
        {"ts": NOW - 300, "error": "BizError: 2"},
    ]})
    client, transport, _ = make_client(tmp_path, script=[ok_body(), ok_body()],
                                       rng_seq=[0.0, 0.0, 0.0, 0.0])
    assert client.execute("five_hour")["ok"] is True
    mapping = json.loads((tmp_path / "reset_cooldown.json").read_text(encoding="utf-8"))
    assert mapping["five_hour"] == []       # 成功即清零（再失败从 1 重新累计）
    assert client.execute("five_hour")["ok"] is True   # 未因残留计数被拒


# ---------------- JWT 源 ----------------

def test_t10_default_jwt_provider_reads_state_file(tmp_path):
    (tmp_path / "zcode_jwt.txt").write_text("  abc.def.ghi  \n", encoding="utf-8")
    assert default_jwt_provider(tmp_path)() == "abc.def.ghi"


def test_t10_jwt_missing_raises_with_path_only(tmp_path):
    provider = default_jwt_provider(tmp_path)   # 无 zcode_jwt.txt
    with pytest.raises(Exception) as ei:
        provider()
    assert "zcode_jwt.txt" in str(ei.value)
    assert "abc" not in str(ei.value)           # 错误信息不携带任何令牌值
