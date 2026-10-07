# -*- coding: utf-8 -*-
"""promo_guard — 宣传文守门器 (F5b): 平台侧补上 We-AIPO 内容闸等效防线.

七门 (设计 §3, 全部有实证教训背书):
  ① 标题 hash 24h 跨号去重 (R83 教训: 标题变体双发)
  ② 同 SKU 跨号 7 天冷却 (同报告不轰炸三号)
  ③ 每号日帽 2-2-1 (总包之声/总包说/工程行业大脑)
  ④ digest 第 2 行非空 (push_article 取 md 第 2 行, 空则 digest==title 回退)
  ⑤ 正文 ≥2000 字 (We-AIPO 3000→2000 过审先例)
  ⑥ 渲染 HTML ≤18000 字符 (20000 硬上限 + 广告预留 400)
  ⑦ 对照 We-AIPO published_topics.json 只读查重 + 标题 ≤64 字节

台账 promo_ledger.jsonl (date/title_hash/sku/account/src/media_id) 只追加.
入口: check() 推前查 → push 成功后 record() 过账.
"""
from __future__ import annotations

import hashlib
import json
import os
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
LEDGER = ROOT / "promo" / "promo_ledger.jsonl"

DAILY_CAPS = {"总包之声": 2, "总包说": 2, "工程行业大脑": 1}
TITLE_DEDUP_HOURS = 24
SKU_COOLDOWN_DAYS = 7
MIN_BODY_CHARS = 2000
MAX_HTML_CHARS = 18000
MAX_TITLE_BYTES = 64
# We-AIPO 已发主题 (只读对照, 缺席=跳过该门)
WEAIPO_PUBLISHED_TOPICS = Path(
    r"E:\CPOPC\We-AIPO\data\published_topics.json")
# autopub 发表金标准库 (只读, gate ⑧)
AUTOPUB_STATE_DB = Path(r"E:\CPOPC\We-AIPO\autopub\data\state.db")


def title_hash(title: str) -> str:
    return hashlib.sha1(title.strip().encode("utf-8")).hexdigest()[:12]


def _entries(ledger: Path | None = None) -> list[dict]:
    p = ledger or _ledger_path()
    if not p.exists():
        return []
    out = []
    for line in p.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line:
            try:
                out.append(json.loads(line))
            except json.JSONDecodeError:
                continue          # 损坏行不阻断守门, 只跳过
    return out


def _ledger_path() -> Path:
    env = os.environ.get("PROMO_LEDGER")
    return Path(env) if env else LEDGER


def _now() -> float:
    return time.time()


def _weaipo_titles() -> list[str]:
    """We-AIPO published_topics.json 只读拉标题 (结构漂移=安静跳过)."""
    try:
        data = json.loads(WEAIPO_PUBLISHED_TOPICS.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError, UnicodeDecodeError):
        return []
    out: list[str] = []

    def _walk(node) -> None:
        if isinstance(node, dict):
            for k, v in node.items():
                if k in ("title", "topic") and isinstance(v, str):
                    out.append(v.strip())
                else:
                    _walk(v)
        elif isinstance(node, list):
            for it in node:
                _walk(it)

    _walk(data)
    return out


def _normalize_title(t: str) -> str:
    """归一化: 去全部空白 + 去尾部标点 (R83 教训: 全角/半角问号变体双发)."""
    t = re.sub(r"\s+", "", t or "")
    return t.rstrip("？?。．.!！~～")


def _state_db_titles() -> list[tuple[str, str]]:
    """autopub state.db publish_records 只读全历史 (账号, 标题).

    侦察E-1 verify 修正案: 跨号24h + 自家7天冷却都不够 —— We-AIPO
    state.db 是发表金标准, 同号同标题全历史命中即拒. 库缺席=安静跳过
    (We-AIPO 侧文件漂移不应炸死平台侧管线).
    """
    try:
        import sqlite3
        db = sqlite3.connect(f"file:{AUTOPUB_STATE_DB}?mode=ro", uri=True)
        try:
            return db.execute(
                "select account, title from publish_records").fetchall()
        finally:
            db.close()
    except Exception:
        return []


def check(md_text: str, html: str, title: str, account: str,
          sku: str, ledger: Path | None = None) -> tuple[bool, list[str]]:
    """推前守门: 返回 (ok, 拒因列表). 任一门破 → ok=False."""
    reasons: list[str] = []
    rows = _entries(ledger)
    now = _now()

    # ⑧ We-AIPO state.db 发表金标准全历史对照 (verify 修正案)
    nt = _normalize_title(title)
    for acct, t in _state_db_titles():
        if acct == account and _normalize_title(t) == nt:
            reasons.append(f"⑧撞已发金标准: 「{title[:24]}」已在 "
                           f"{account} 发表过 (state.db 全历史)")
            break

    # ⑧b 同号同 SKU 全历史禁重投 (不止 7 天)
    if sku:
        for r in rows:
            if (r.get("account") == account and r.get("sku") == sku):
                reasons.append(
                    f"⑧同号SKU已投: {sku} 已在 {account} 投过 "
                    f"({r.get('date')}) — 同号同SKU全历史只投一次")
                break

    # ① 标题 hash 24h 跨号去重
    th = title_hash(title)
    for r in rows:
        ts = r.get("ts_epoch", 0)
        if (r.get("title_hash") == th and now - ts < TITLE_DEDUP_HOURS * 3600):
            reasons.append(
                f"①标题24h撞车: 「{title[:24]}…」已投 {r.get('account')} "
                f"({int((now-ts)/3600)}h前)")
            break

    # ② 同 SKU 跨号 7 天冷却
    for r in rows:
        ts = r.get("ts_epoch", 0)
        if (r.get("sku") == sku and sku and r.get("sku")
                and now - ts < SKU_COOLDOWN_DAYS * 86400):
            reasons.append(
                f"②SKU冷却中: {sku} 已投 {r.get('account')} "
                f"({int((now-ts)/86400)}d前, 冷却7d)")
            break

    # ③ 每号日帽
    today = time.strftime("%Y-%m-%d")
    used = sum(1 for r in rows
               if r.get("account") == account and r.get("date") == today)
    cap = DAILY_CAPS.get(account, 1)
    if used >= cap:
        reasons.append(f"③日帽: {account} 今日已投 {used}/{cap}")

    # ④ digest 第 2 行非空 (与 push_article 同口径: md 第 2 行)
    lines = [ln for ln in md_text.split("\n")]
    digest_line = lines[1].strip() if len(lines) > 1 else ""
    if not digest_line:
        reasons.append("④digest: md 第 2 行为空 (digest 将回退为标题)")

    # ⑤ 正文 ≥2000 字 (非空白字符计)
    body_chars = len(re.sub(r"\s", "", md_text))
    if body_chars < MIN_BODY_CHARS:
        reasons.append(f"⑤正文过短: {body_chars} < {MIN_BODY_CHARS} 字")

    # ⑥ 渲染 HTML ≤18000 字符
    if len(html) > MAX_HTML_CHARS:
        reasons.append(f"⑥HTML超限: {len(html)} > {MAX_HTML_CHARS} 字符")

    # ⑦ We-AIPO 已发主题查重 + 标题字节长
    if len(title.encode("utf-8")) > MAX_TITLE_BYTES:
        reasons.append(f"⑦标题超64字节: {len(title.encode('utf-8'))}B")
    for t in _weaipo_titles():
        if t and t == title.strip():
            reasons.append(f"⑦撞We-AIPO已发主题: 「{title[:24]}」")
            break

    return (not reasons), reasons


def record(title: str, account: str, sku: str, src: str,
           media_id: str = "", ledger: Path | None = None) -> None:
    """push 成功后过账 (只追加)."""
    p = ledger or _ledger_path()
    row = {
        "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
        "ts_epoch": int(_now()),
        "date": time.strftime("%Y-%m-%d"),
        "title": title,
        "title_hash": title_hash(title),
        "account": account,
        "sku": sku,
        "src": src,
        "media_id": media_id,
    }
    with p.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")
