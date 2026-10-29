# -*- coding: utf-8 -*-
"""zqg.notify — 企微 webhook 通知（T-08，covers FR6/NFR4）。

契约（与 ARCHITECTURE notify 节「复用 station webhook 机制」逐字对齐）：
- webhook() 解析机制照抄 tools/notify_approval_wecom.py：
  E:/AI-Station（按本模块位置 parents[2] 推算）/data/secrets/invoice_wecom_webhook.txt
  → 兜底 F:/We-AIPO/.env 的 WECOM_WEBHOOK_URL= 行；都没有返回 ""。
- Notifier.send(title, detail, kind)：POST {"msgtype":"markdown",
  "markdown":{"content":...}}，timeout=10s；网络/HTTP/企微 errcode!=0 均先重试
  2 次再抛 NotifyError（fail loud——失败绝不静默，由调用方/daemon 决定处置）。
- 去重节流：同 kind+同标题 15 分钟内只发一次（内存 dict + state/notify_dedup.json
  持久化，进程重启后仍生效）；被节流返回 False，不触网、不抛错。
- 七类事件 kind（FR6）：reset_exec/reset_result/low_quota/login_invalid/
  card_short/drift/heartbeat，各带固定标题前缀 [ZQG][<标签>]；未知 kind 抛
  ValueError（契约外事件 fail loud）。
- 正文经 redact_text() 脱敏（sk- 串 / Bearer 凭据 / 32+ 位十六进制），与 T-02
  redact 同族规则；本模块不 import zqg.ledger（保持单文件可独立测试），
  账本缝合走构造注入的鸭子类型 ledger.append(kind, payload)：
  发送成功写 notify 条目、最终失败写 error 条目（写账本本身失败不掩盖主错误）。

时钟可注入（now=callable→epoch 秒）。Python 3.11 标准库 only。
"""
from __future__ import annotations

import json
import os
import re
import time
import urllib.request
from pathlib import Path
from typing import Any, Callable, Protocol

# E:/AI-Station（zqg/notify.py → parents[0]=zqg, [1]=zhipu-quota-guard, [2]=AI-Station）
REPO = Path(__file__).resolve().parents[2]
FALLBACK_ENV = Path(r"F:\We-AIPO\.env")
_WEBHOOK_FILE = Path("data") / "secrets" / "invoice_wecom_webhook.txt"

DEFAULT_STATE_PATH = Path(__file__).resolve().parents[1] / "state" / "notify_dedup.json"

TIMEOUT_SEC = 10
RETRIES = 2                      # 失败后的重试次数（总尝试 = 1 + RETRIES）
DEDUP_WINDOW_SEC = 15 * 60       # 同 kind+同标题 15 分钟内只发一次

#: FR6 七类事件及固定标题前缀标签（[ZQG][<标签>] <标题>）
TITLE_PREFIX = {
    "reset_exec": "[重置执行]",
    "reset_result": "[重置结果]",
    "low_quota": "[低水位]",
    "login_invalid": "[登录失效]",
    "card_short": "[重置卡不足]",
    "drift": "[契约漂移]",
    "heartbeat": "[心跳]",
}
EVENTS = tuple(TITLE_PREFIX)

# 与 T-02 redact 同族的正文密钥形态清洗
_SK_TOKEN = re.compile(r"sk-[A-Za-z0-9_\-]{8,}")
_BEARER = re.compile(r"bearer\s+[A-Za-z0-9._\-+/=]+", re.IGNORECASE)
_LONG_HEX = re.compile(r"\b[0-9a-fA-F]{32,}\b")
_REDACTED = "***"


class NotifyError(RuntimeError):
    """企微发送最终失败（重试耗尽 / 无 webhook 配置 / errcode!=0）。"""


class _LedgerLike(Protocol):
    def append(self, kind: str, payload: Any) -> Any: ...


def redact_text(text: str) -> str:
    """清洗正文中可直接读出的密钥形态：sk- 串 / Bearer 凭据 / 32+ 位十六进制。"""
    text = _SK_TOKEN.sub("sk-" + _REDACTED, text)
    text = _BEARER.sub("Bearer " + _REDACTED, text)
    return _LONG_HEX.sub(lambda m: m.group(0)[:4] + _REDACTED, text)


def webhook() -> str:
    """企微 webhook URL：station secrets 文件 → We-AIPO .env 兜底；无配置返回 ""。"""
    wf = REPO / _WEBHOOK_FILE
    if wf.exists():
        u = wf.read_text(encoding="utf-8").strip()
        if u.startswith("http"):
            return u
    if FALLBACK_ENV.exists():
        for line in FALLBACK_ENV.read_text(encoding="utf-8").splitlines():
            if line.startswith("WECOM_WEBHOOK_URL="):
                return line.split("=", 1)[1].strip()
    return ""


def build_markdown(kind: str, title: str, detail: str = "") -> str:
    """七类事件固定格式：**[ZQG][<标签>] <标题>** + 空行 + 逐行脱敏后的 detail。"""
    head = f"[ZQG]{TITLE_PREFIX[kind]} {title}".strip()
    lines = [f"**{redact_text(head)}**"]
    if detail:
        lines.append("")
        lines.extend(redact_text(ln) for ln in detail.strip("\n").splitlines())
    return "\n".join(lines)


class Notifier:
    """企微 markdown 通知器（daemon 单实例使用；state 文件跨实例共享去重窗口）。"""

    def __init__(self, *, url: str | None = None,
                 state_path: str | os.PathLike | None = None,
                 ledger: _LedgerLike | None = None,
                 now: Callable[[], float] | None = None):
        self.url = webhook() if url is None else url
        self.state_path = Path(state_path) if state_path is not None else DEFAULT_STATE_PATH
        self.ledger = ledger
        self._now = now or time.time
        self._sent: dict[str, float] = self._load_state()

    # ------------------------------------------------------------------ API
    def send(self, title: str, detail: str = "", kind: str = "heartbeat") -> bool:
        """发送一条 kind 事件通知。

        Returns: True=实际发出；False=同 kind+标题 15 分钟内已被节流。
        Raises:  ValueError=未知 kind；NotifyError=重试耗尽后的发送失败（fail loud）。
        """
        if kind not in TITLE_PREFIX:
            raise ValueError(f"未知事件 kind: {kind!r}; 合法枚举={EVENTS}")
        key = f"{kind}\x00{title}"
        ts = self._now()
        last = self._sent.get(key)
        if last is not None and ts - last < DEDUP_WINDOW_SEC:
            return False  # 节流：不触网、不抛错、不写账本

        md = build_markdown(kind, title, detail)
        try:
            self._post(md)
        except NotifyError as exc:
            self._ledger_write("error", {"event": kind, "title": title,
                                         "ok": False, "error": str(exc)})
            raise
        self._sent[key] = ts
        self._save_state()
        self._ledger_write("notify", {"event": kind, "title": title, "ok": True})
        return True

    # -------------------------------------------------------------- transport
    def _post(self, md: str) -> None:
        """POST markdown 消息；网络/HTTP/errcode 失败重试 RETRIES 次后抛 NotifyError。"""
        data = json.dumps({"msgtype": "markdown",
                           "markdown": {"content": md}}).encode("utf-8")
        last_err: BaseException | None = None
        for _ in range(1 + RETRIES):
            try:
                req = urllib.request.Request(
                    self.url, data=data, headers={"Content-Type": "application/json"})
                # 直接引用 urllib.request.urlopen（调用时属性查找）→ 测试可 monkeypatch
                with urllib.request.urlopen(req, timeout=TIMEOUT_SEC) as r:
                    body = r.read().decode("utf-8", "replace")
                errcode = self._errcode(body)
                if errcode == 0:
                    return
                last_err = NotifyError(f"企微返回 errcode={errcode}")
            except Exception as exc:  # noqa: BLE001 — 统一重试后归一为 NotifyError
                last_err = exc
        raise NotifyError(f"企微通知发送失败(重试{RETRIES}次后): {last_err}")

    @staticmethod
    def _errcode(body: str) -> int:
        """解析企微响应 errcode；非 JSON 视为失败（fail loud，不猜）。"""
        try:
            parsed = json.loads(body)
        except ValueError:
            raise NotifyError(f"企微响应非 JSON: {body[:60]!r}") from None
        if isinstance(parsed, dict) and "errcode" in parsed:
            return int(parsed["errcode"])
        raise NotifyError(f"企微响应缺 errcode: {body[:60]!r}")

    # ------------------------------------------------------------------ dedup
    def _load_state(self) -> dict[str, float]:
        try:
            data = json.loads(self.state_path.read_text(encoding="utf-8"))
            return {k: float(v) for k, v in data.items()}
        except (FileNotFoundError, ValueError, OSError):
            return {}

    def _save_state(self) -> None:
        self.state_path.parent.mkdir(parents=True, exist_ok=True)
        tmp = self.state_path.with_name(self.state_path.name + ".tmp")
        tmp.write_text(json.dumps(self._sent), encoding="utf-8")
        os.replace(tmp, self.state_path)

    # ------------------------------------------------------------------ ledger
    def _ledger_write(self, kind: str, payload: dict) -> None:
        """账本写入为 best-effort：不掩盖发送主错误（无 ledger / 写失败均忽略）。"""
        if self.ledger is None:
            return
        try:
            self.ledger.append(kind, payload)
        except Exception:  # noqa: BLE001 — 通知模块不得因账本故障改变自身语义
            pass
