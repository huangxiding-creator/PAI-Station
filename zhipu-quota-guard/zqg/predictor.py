# -*- coding: utf-8 -*-
"""T-06 predictor：CC JSONL 遥测聚合 × 积分系数 → BurnRate + 烧穿预测时刻（FR3/ADR7）。

契约：
- BurnRate = SCHEMAS §2（tokens_per_min=加权积分当量/分钟·高峰系数折算后, peak_now）；
- 积分公式 = KNOWLEDGE_BASE/rules-and-endpoints.md 官方规则（GLM-5.3）：
  （输入Token×6.9 + 缓存命中×1.7 + 输出×24）/10000 积分；
  cache_creation_input_tokens（缓存写入）属新输入，按输入系数计。
- 高峰 = 周一至五 14:00-18:00 UTC+8（含起点不含终点）；系数 V3：高峰 1.0x / 非高峰 0.5x，
  默认值与 zqg.config.PeakFactorCfg（T-03）一致，可注入。
- 遥测源 = ~/.claude/projects/**/*.jsonl assistant 行 message.usage
  （input_tokens/cache_creation_input_tokens/cache_read_input_tokens/output_tokens + timestamp）。

纯函数 + 可注入时钟（now 一律 epoch 秒）；坏行/非 assistant 行静默跳过（遥测扫描不许崩）。
预测时刻供 T-07 与 nextResetTime（ADR6 调度权威）比对。
"""
from __future__ import annotations

import json
import time
from dataclasses import dataclass
from datetime import datetime, timedelta, timezone
from pathlib import Path

# ---- GLM-5.3 积分系数（KNOWLEDGE_BASE 官方规则节，做成常量） ----
GLM_INPUT_COEFF = 6.9    # 输入 Token（含缓存写入=新输入）
GLM_CACHE_COEFF = 1.7    # 缓存命中
GLM_OUTPUT_COEFF = 24.0  # 输出
POINTS_DIVISOR = 10_000.0

# ---- 高峰窗与系数（KB V3；默认与 zqg.config.PeakFactorCfg 一致，T-03 注入覆盖） ----
CN_TZ = timezone(timedelta(hours=8))
PEAK_START_HOUR = 14  # 含
PEAK_END_HOUR = 18    # 不含
DEFAULT_PEAK_FACTOR = 1.0
DEFAULT_OFFPEAK_FACTOR = 0.5

DEFAULT_WINDOW_MIN = 30
DEFAULT_TELEMETRY_ROOT = Path.home() / ".claude" / "projects"

# ---- 扫描性能（生产 root 实测 1270 文件/2.27GB，全量读一轮 >120s，不可用于轮询） ----
# JSONL 为 append-only：近窗记录必在文件尾端 → 只读尾部 TAIL_BYTES；
# mtime 预过滤：文件未在窗起点前最后修改过 → 不可能含窗内记录（mtime >= 记录 ts），
# MTIME_SKEW_SEC 为恢复/拷贝致 mtime 失真的兜底冗余（宁可多读不漏读）。
TAIL_BYTES = 256 * 1024
MTIME_SKEW_SEC = 3600


@dataclass(frozen=True)
class UsageRecord:
    """一条 assistant 消息的用量（CC JSONL 归一化）。"""
    ts: int                       # epoch 秒
    input_tokens: int = 0
    cache_creation_input_tokens: int = 0
    cache_read_input_tokens: int = 0
    output_tokens: int = 0

    def points(self) -> float:
        """token → 积分当量（GLM-5.3 系数）。"""
        return ((self.input_tokens + self.cache_creation_input_tokens) * GLM_INPUT_COEFF
                + self.cache_read_input_tokens * GLM_CACHE_COEFF
                + self.output_tokens * GLM_OUTPUT_COEFF) / POINTS_DIVISOR


@dataclass(frozen=True)
class BurnRate:  # SCHEMAS §2
    tokens_per_min: float  # 加权积分当量/分钟（高峰系数折算后）
    peak_now: bool         # 是否处于高峰时段
    last_record_at: float = 0.0  # 窗内最近一条遥测的 epoch 秒（0=无记录）— CC 活跃度门用


# ---- ④ 高峰判定 ----

def is_peak(now: float | int) -> bool:
    """周一至五 14:00-18:00 UTC+8（含 14:00，不含 18:00）。"""
    local = datetime.fromtimestamp(float(now), tz=CN_TZ)
    return local.weekday() < 5 and PEAK_START_HOUR <= local.hour < PEAK_END_HOUR


# ---- ① 单文件解析 ----

def _parse_ts(v) -> int | None:
    if not isinstance(v, str):
        return None
    s = v.strip()
    if s.endswith(("Z", "z")):
        s = s[:-1] + "+00:00"
    try:
        dt = datetime.fromisoformat(s)
    except ValueError:
        return None
    if dt.tzinfo is None:  # 裸时间戳按 UTC
        dt = dt.replace(tzinfo=timezone.utc)
    return int(dt.timestamp())


def _int(v) -> int:
    return v if isinstance(v, int) and not isinstance(v, bool) else 0


def _read_text(path: Path, tail_bytes: int | None) -> str:
    """读文件文本；tail_bytes 给定时只读尾部并丢弃首个残行（append-only 近窗在尾端）。"""
    if not tail_bytes:
        return path.read_text(encoding="utf-8", errors="replace")
    with path.open("rb") as f:
        f.seek(0, 2)
        size = f.tell()
        f.seek(max(0, size - tail_bytes))
        chunk = f.read()
    text = chunk.decode("utf-8", errors="replace")
    if len(chunk) < size and "\n" in text:  # 起点在行中 → 弃首个残行
        text = text.split("\n", 1)[1]
    return text


def parse_jsonl(path, tail_bytes: int | None = None) -> list[UsageRecord]:
    """解析单个 CC JSONL：只取 assistant 行的 message.usage；坏行/缺字段静默跳过。

    tail_bytes：只解析文件尾部 N 字节（None=全量；残行/半行因 JSON 不完整自动跳过）。
    """
    records: list[UsageRecord] = []
    try:
        text = _read_text(Path(path), tail_bytes)
    except OSError:
        return records
    for line in text.splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            obj = json.loads(line)
        except ValueError:
            continue
        if not isinstance(obj, dict) or obj.get("type") != "assistant":
            continue
        ts = _parse_ts(obj.get("timestamp"))
        if ts is None:
            continue
        usage = (obj.get("message") or {}).get("usage")
        if not isinstance(usage, dict):
            continue
        records.append(UsageRecord(
            ts=ts,
            input_tokens=_int(usage.get("input_tokens")),
            cache_creation_input_tokens=_int(usage.get("cache_creation_input_tokens")),
            cache_read_input_tokens=_int(usage.get("cache_read_input_tokens")),
            output_tokens=_int(usage.get("output_tokens")),
        ))
    return records


# ---- ② 速率聚合 ----

def burn_rate(records, window_min: int = DEFAULT_WINDOW_MIN, now: float | None = None,
              *, peak: float = DEFAULT_PEAK_FACTOR, offpeak: float = DEFAULT_OFFPEAK_FACTOR
              ) -> BurnRate:
    """窗口内积分当量/分钟 × 高峰系数。窗=[now-window_min, now] 双端闭；除数为窗长名义值。

    空遥测/全旧数据 → 0.0（绝不除零）；时钟缺省取真实当前时刻（测试必注入）。
    """
    t_now = float(time.time()) if now is None else float(now)
    cutoff = t_now - window_min * 60
    in_win = [r for r in records if cutoff <= r.ts <= t_now]
    total = sum(r.points() for r in in_win)
    peak_now = is_peak(t_now)
    factor = peak if peak_now else offpeak
    last = max((r.ts for r in in_win), default=0.0)
    return BurnRate(tokens_per_min=total / window_min * factor, peak_now=peak_now,
                    last_record_at=float(last))


def scan_jsonl(root=None, window_min: int = DEFAULT_WINDOW_MIN, now: float | None = None,
               *, peak: float = DEFAULT_PEAK_FACTOR, offpeak: float = DEFAULT_OFFPEAK_FACTOR,
               tail_bytes: int | None = TAIL_BYTES
               ) -> BurnRate:
    """聚合 root 下 **/*.jsonl 的近 window_min 分钟用量 → BurnRate。root=None 走生产默认。

    性能（生产 root 实测 1270 文件/2.27GB）：mtime 预过滤 + 尾部 TAIL_BYTES 读取，
    轮询周期（2-10min）内完成；tail_bytes=None 可退化为全量精确读。
    """
    t_now = float(time.time()) if now is None else float(now)
    cutoff = t_now - window_min * 60
    base = Path(root) if root is not None else DEFAULT_TELEMETRY_ROOT
    records: list[UsageRecord] = []
    if base.is_dir():
        for p in sorted(base.rglob("*.jsonl")):
            try:
                mtime = p.stat().st_mtime
            except OSError:
                continue
            if mtime < cutoff - MTIME_SKEW_SEC:  # 窗前已静止 → 不含窗内记录
                continue
            records.extend(parse_jsonl(p, tail_bytes=tail_bytes))
    return burn_rate(records, window_min=window_min, now=t_now, peak=peak, offpeak=offpeak)


# ---- ③ 预测时刻 ----

def predict_exhaust(remaining: float, rate: float, now: float) -> int | None:
    """剩余积分按恒定速率耗尽的 epoch；rate<=0 → None（不除零）。"""
    if rate <= 0:
        return None
    minutes = max(remaining, 0.0) / rate
    return int(round(now + minutes * 60))


def predict_exhaustion(snapshot_pct_used: float, capacity_points: float, rate: float,
                       next_reset_at: int, now: float,
                       peak_factor: float = DEFAULT_PEAK_FACTOR) -> dict:
    """烧穿三件套。snapshot_pct_used 与 QuotaSnapshot.window_pct 同标度（0-100）。

    rate=遥测原始积分/min；peak_factor=该时段计费系数（1.0 高峰/0.5 非高峰，is_peak 定夺）。
    返回 {predicted_exhaust_at: int|None, will_exhaust_before_reset: bool,
          minutes_to_exhaust: float|None}。
    """
    if not 0 <= snapshot_pct_used <= 100:
        raise ValueError(f"snapshot_pct_used: 应在 [0,100]，实为 {snapshot_pct_used}")
    if capacity_points <= 0:
        raise ValueError(f"capacity_points: 应 > 0，实为 {capacity_points}")
    if peak_factor <= 0:
        raise ValueError(f"peak_factor: 应 > 0，实为 {peak_factor}")
    effective = max(rate, 0.0) * peak_factor
    remaining = capacity_points * (1.0 - snapshot_pct_used / 100.0)
    exhaust_at = predict_exhaust(remaining, effective, now)
    minutes = None if exhaust_at is None else max(exhaust_at - now, 0.0) / 60.0
    will = exhaust_at is not None and exhaust_at < next_reset_at
    return {
        "predicted_exhaust_at": exhaust_at,
        "will_exhaust_before_reset": will,
        "minutes_to_exhaust": minutes,
    }


def margin_vs_reset(exhaust_at: int | None, next_reset_at: int) -> float | None:
    """烧穿早于自然刷新的分钟数（正=提前，负=晚于刷新）；无预测 → None。"""
    if exhaust_at is None:
        return None
    return (next_reset_at - exhaust_at) / 60.0
