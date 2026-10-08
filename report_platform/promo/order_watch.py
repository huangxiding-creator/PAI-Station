# -*- coding: utf-8 -*-
"""order_watch — 订单看门狗: 新订单/状态翻转 → 企微 OAuth 机器人即时告警.

背景 (1008): /api/order 半自动收款只入库、服务端无外呼通道 — 买家提交
¥1999 支付凭证后我方完全静默, 响应速度=信任=转化. 本腿在本地 OS 级
schtasks 轮询 (RP_OrderWatch 每 6 min), diff 出新行或 state 翻转即推
企微 (个人 OAuth aibot 通道, 同 superskill_weekly 实测配方).

护栏:
  - 首跑只记基线不告警 (重启不轰炸)
  - 网络失败静默退 0 (下轮再试), 连败 3 轮推一条诊断
  - 单实例 O_EXCL 锁; 零依赖 stdlib (urllib)
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
import urllib.request
from pathlib import Path

if sys.stdout:            # pythonw (schtasks 无窗) 下 stdout=None
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]          # report_platform/
PROMO = ROOT / "promo"
STATE = PROMO / "order_watch_state.json"
LOCK = PROMO / "order_watch.lock"
FAILS = PROMO / "order_watch_fails.txt"
BASE = "http://report.yrecepc.cn"
WECOM_JS = Path(os.environ.get("APPDATA", "")) / "npm" / "node_modules" \
    / "@wecom" / "cli" / "bin" / "wecom.js"


def _token() -> str:
    ini = ROOT / "secret.ini"
    if ini.is_file():
        for line in ini.read_text(encoding="utf-8").splitlines():
            if line.startswith("admin_token="):
                return line.split("=", 1)[1].strip()
    return os.environ.get("RP_ADMIN_TOKEN", "")


def _load_seen() -> dict[str, str]:
    if STATE.is_file():
        try:
            return json.loads(STATE.read_text(encoding="utf-8")).get(
                "seen", {})
        except (json.JSONDecodeError, OSError):
            pass
    return {}


def _save_seen(seen: dict[str, str]) -> None:
    STATE.write_text(json.dumps({"seen": seen, "ts": time.strftime(
        "%Y-%m-%d %H:%M:%S")}, ensure_ascii=False), encoding="utf-8")


def _fetch_orders(tok: str) -> list[dict] | None:
    url = f"{BASE}/api/stats?token={tok}"
    try:
        with urllib.request.urlopen(url, timeout=25) as resp:
            d = json.loads(resp.read().decode("utf-8"))
    except Exception as exc:                              # noqa: BLE001
        print(f"[ow] 拉取失败: {exc}")
        return None
    if not d.get("ok"):
        print(f"[ow] api 拒绝: {d}")
        return None
    return d.get("orders") or []


def _wecom_send(content: str) -> bool:
    """个人 OAuth aibot 通道 (whoami→chat_id→markdown)."""
    if not WECOM_JS.is_file():
        print("[ow] wecom-cli 未装 — 告警丢弃")
        return False
    r = subprocess.run(["node", str(WECOM_JS), "identity", "whoami"],
                       capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=40)
    import re
    m = re.search(r"授权真人用户身份.*?ID：([A-Za-z0-9_-]+)",
                  (r.stdout or "") + (r.stderr or ""))
    if not m:
        print(f"[ow] whoami 解析失败 rc={r.returncode}")
        return False
    payload = json.dumps({"chat_id": m.group(1), "msg_type": "markdown",
                          "markdown": {"content": content}},
                         ensure_ascii=False)
    r2 = subprocess.run(["node", str(WECOM_JS), "message", "aibot", "send",
                         "--json", payload], capture_output=True, text=True,
                        encoding="utf-8", errors="replace", timeout=40)
    ok = '"success": true' in (r2.stdout or "").replace(" ", " ")
    print(f"[ow] 企微推送 {'✓' if ok else '✗'}")
    return ok


def _alert_new(o: dict) -> str:
    return (f"**🚨 新支付凭证登记（¥1999 旗舰收款流）**\n"
            f"时间: {o.get('created', '-')}\n"
            f"报告: {o.get('sku', '-')}\n"
            f"订单号: {o.get('order_no', '-')}\n"
            f"联系方式: {o.get('contact', '-')}\n"
            f"备注: {o.get('note', '-') or '无'}\n"
            f"状态: {o.get('state', '-')}\n"
            f"→ 请尽快核对到账并解锁（核对入口: admin 台 /api/stats）")


def _alert_transition(o: dict, old: str) -> str:
    return (f"**订单状态翻转** {o.get('order_no', '-')}: "
            f"{old} → {o.get('state', '-')}\n"
            f"报告: {o.get('sku', '-')} · {o.get('created', '-')}")


def main() -> int:
    try:
        fd = open(LOCK, "x")
        fd.close()
    except FileExistsError:
        print("[ow] 锁在 — 上轮未退, 跳过")
        return 0
    try:
        tok = _token()
        if not tok:
            print("[ow] 无 admin_token — 无法拉取")
            return 0
        orders = _fetch_orders(tok)
        if orders is None:
            n = 0
            if FAILS.is_file():
                try:
                    n = int(FAILS.read_text().strip() or 0)
                except ValueError:
                    n = 0
            n += 1
            FAILS.write_text(str(n))
            if n == 3:
                _wecom_send(f"⚠️ 订单看门狗连败 {n} 轮 (拉取失败) — "
                            f"请查 report.yrecepc.cn 可达性/token")
                n = 0
                FAILS.write_text("0")
            return 0
        FAILS.write_text("0")
        seen = _load_seen()
        first_run = not seen and not STATE.is_file()
        alerts: list[str] = []
        for o in orders:                       # DESC 序, 新单在前
            no, st = o.get("order_no", ""), o.get("state", "")
            if not no:
                continue
            if no not in seen:
                if not first_run:
                    alerts.append(_alert_new(o))
            elif seen[no] != st:
                alerts.append(_alert_transition(o, seen[no]))
        for o in orders:
            seen[o.get("order_no", "")] = o.get("state", "")
        _save_seen(seen)
        if alerts:
            _wecom_send("\n\n".join(alerts[:5]))
            if len(alerts) > 5:
                print(f"[ow] 还有 {len(alerts) - 5} 条未推 (防刷屏截断)")
        print(f"[ow] orders={len(orders)} alerts={len(alerts)} "
              f"first_run={first_run}")
        return 0
    finally:
        try:
            LOCK.unlink()
        except OSError:
            pass


if __name__ == "__main__":
    sys.exit(main())
