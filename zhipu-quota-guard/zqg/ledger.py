"""run-ledger 账本：ledger/*.jsonl 唯一事实源（SCHEMAS §2 RunLedgerEntry / §4 账本文件，C10）。

行为契约（T-02，covers FR8/NFR4）：
- append(kind, payload) 以单次 O_APPEND 系统调用原子追加一行 {"ts","kind","payload"}；
  ts=epoch 毫秒；按日分文件 ledger/run-YYYYMMDD.jsonl（本地时区）。
- kind 枚举=poll|decision|reset_exec|reset_result|notify|heartbeat|login|drift|error，
  非法 kind 抛 InvalidKindError（不落行）。
- payload 落盘前经 redact() 深度脱敏：敏感字段（key/token/secret/...）仅留前 4 位，
  正文中 sk- 串 / Bearer 凭据 / 32+ 位十六进制全部清洗。
- 写失败（目录不可写/磁盘等 OSError）异常原样上抛，fail loud 不静默——
  进程退出交由计划任务拉起（NFR4，EARS6）。序列化失败同理，不落半行。
- read(kinds=None, since=None, limit=None) 跨日文件按时间序读取，
  limit=最近 N 条；read_tail(n)/read_range(kind) 为常用薄封装；容忍崩溃撕裂尾行。
- cards.json 为卡库存缓存（T-05 写入），save_cards 原子替换写，load_cards 缺省回 default。

时钟可注入（now=callable→epoch 秒），供测试与 T-06/T-11 时钟注入复用。
Python 3.11 标准库 only。
"""
from __future__ import annotations

import json
import os
import re
import time
from pathlib import Path
from typing import Any, Callable

KINDS = ("poll", "decision", "reset_exec", "reset_result", "notify",
         "heartbeat", "login", "drift", "error")

_RUN_PREFIX = "run-"
_RUN_SUFFIX = ".jsonl"
_CARDS_NAME = "cards.json"
_ENTRY_KEYS = {"ts", "kind", "payload"}

# 敏感字段名（子串匹配，大小写不敏感）：值仅保留前 4 位
_SENSITIVE_KEY = re.compile(
    r"(?:key|token|secret|password|passwd|authorization|auth|cookie|credential|bearer)",
    re.IGNORECASE,
)
# 正文密钥串形态（与 T-01 脱敏验收同族：sk- 串 / Bearer 凭据 / 32+ 位十六进制）
_SK_TOKEN = re.compile(r"sk-[A-Za-z0-9_\-]{8,}")
_BEARER = re.compile(r"bearer\s+[A-Za-z0-9._\-+/=]+", re.IGNORECASE)
_LONG_HEX = re.compile(r"\b[0-9a-fA-F]{32,}\b")

_REDACTED = "***"


class InvalidKindError(ValueError):
    """kind 不在 KINDS 枚举内（SCHEMAS §2）。"""


def _truncate(value: Any) -> str:
    """敏感字段的值仅保留前 4 位（与 T-01 fixture 脱敏约定一致）。"""
    if isinstance(value, str) and len(value) > 4:
        return value[:4] + _REDACTED
    return _REDACTED


def _scrub_text(text: str) -> str:
    text = _SK_TOKEN.sub("sk-" + _REDACTED, text)
    text = _BEARER.sub("Bearer " + _REDACTED, text)
    return _LONG_HEX.sub(lambda m: m.group(0)[:4] + _REDACTED, text)


def redact(value: Any) -> Any:
    """深度脱敏：敏感字段截断 + 全字符串内容清洗。返回新结构，不改入参。"""
    if isinstance(value, dict):
        return {
            k: (_truncate(v) if _SENSITIVE_KEY.search(str(k)) else redact(v))
            for k, v in value.items()
        }
    if isinstance(value, (list, tuple)):
        return [redact(v) for v in value]
    if isinstance(value, str):
        return _scrub_text(value)
    return value


class Ledger:
    """run-ledger JSONL 账本（每实例绑定一个 base_dir，如 <root>/ledger）。"""

    def __init__(self, base_dir, *, now: Callable[[], float] | None = None):
        self.base_dir = Path(base_dir)
        self._now = now or time.time

    # ------------------------------------------------------------------ 写
    def append(self, kind: str, payload: Any) -> dict:
        """原子追加一条 {ts,kind,payload}（ts=epoch 毫秒），返回落盘条目。"""
        self._check_kind(kind)
        # 序列化先行：payload 不可序列化时在开文件前抛出，绝不落半行
        ts = int(self._now() * 1000)
        entry = {"ts": ts, "kind": kind, "payload": redact(payload)}
        line = json.dumps(entry, ensure_ascii=False, separators=(",", ":"))
        self._append_bytes(self._day_file(ts), (line + "\n").encode("utf-8"))
        return entry

    def save_cards(self, cards: Any) -> None:
        """卡库存缓存原子写 ledger/cards.json（tmp + os.replace）。"""
        self.base_dir.mkdir(parents=True, exist_ok=True)
        path = self.base_dir / _CARDS_NAME
        tmp = path.with_name(_CARDS_NAME + ".tmp")
        tmp.write_text(
            json.dumps(cards, ensure_ascii=False, separators=(",", ":")),
            encoding="utf-8",
        )
        os.replace(tmp, path)

    def _day_file(self, ts_ms: int) -> Path:
        day = time.strftime("%Y%m%d", time.localtime(ts_ms / 1000))
        return self.base_dir / f"{_RUN_PREFIX}{day}{_RUN_SUFFIX}"

    def _append_bytes(self, path: Path, data: bytes) -> None:
        """O_APPEND 单调用追加——同目录多进程/多句柄下按行不交错。异常原样上抛。"""
        self.base_dir.mkdir(parents=True, exist_ok=True)
        fd = os.open(path, os.O_WRONLY | os.O_CREAT | os.O_APPEND)
        try:
            written = os.write(fd, data)
            while written < len(data):  # 常规文件通常一次写满；防御性补写
                written += os.write(fd, data[written:])
        finally:
            os.close(fd)

    # ------------------------------------------------------------------ 读
    def read(self, kinds=None, since=None, limit=None) -> list[dict]:
        """跨日文件按时间序读取；kinds 过滤、since=ts(ms) 含等值、limit=最近 N 条。"""
        kind_set = None
        if kinds is not None:
            kind_set = {kinds} if isinstance(kinds, str) else set(kinds)
            bad = kind_set - set(KINDS)
            if bad:
                raise InvalidKindError(f"非法 kinds 过滤: {sorted(bad)}; 合法枚举={KINDS}")
        out: list[dict] = []
        for path in sorted(self.base_dir.glob(f"{_RUN_PREFIX}*{_RUN_SUFFIX}")):
            try:
                text = path.read_text(encoding="utf-8")
            except FileNotFoundError:  # 目录不存在=空账本
                return []
            for raw in text.splitlines():
                raw = raw.strip()
                if not raw:
                    continue
                try:
                    entry = json.loads(raw)
                except ValueError:
                    continue  # 崩溃残留的撕裂尾行：跳过，读路径不 fail
                if not (isinstance(entry, dict) and _ENTRY_KEYS <= set(entry)):
                    continue
                if kind_set is not None and entry["kind"] not in kind_set:
                    continue
                if since is not None and entry["ts"] < since:
                    continue
                out.append(entry)
        if limit is not None:
            out = out[-limit:] if limit > 0 else []
        return out

    def read_tail(self, n: int) -> list[dict]:
        """最近 n 条（panel「最近动作」等）。"""
        return self.read(limit=n)

    def read_range(self, kind: str, since=None, limit=None) -> list[dict]:
        """按 kind 读取（decision 回放 / reset 失败冷却查询等）。"""
        return self.read(kinds={kind}, since=since, limit=limit)

    def load_cards(self, default: Any = None) -> Any:
        """读卡库存缓存；文件缺失返回 default。"""
        path = self.base_dir / _CARDS_NAME
        try:
            return json.loads(path.read_text(encoding="utf-8"))
        except FileNotFoundError:
            return default

    # --------------------------------------------------------------- 校验
    @staticmethod
    def _check_kind(kind: str) -> None:
        if kind not in KINDS:
            raise InvalidKindError(f"非法 ledger kind: {kind!r}; 合法枚举={KINDS}")
