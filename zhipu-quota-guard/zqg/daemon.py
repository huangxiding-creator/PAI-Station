# -*- coding: utf-8 -*-
"""zqg.daemon — 守护主循环（T-11）。

单进程轮询：provider 额度/卡库存 → predictor 烧速 → policy 决策 →
resetter 执行（auto 模式）→ notify 企微 → panel 渲染 → ledger 全程留痕。

入口: python -m zqg.daemon [--once] [--mode auto|dry_run|notify_only]
单例: state/daemon.lock（pid+心跳，10 分钟无心跳视为陈旧可抢占）
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

from . import __version__
from .cards import fetch_cards
from .config import load_config, resolve_secrets
from .ledger import Ledger
from .notify import Notifier
from .panel import render as panel_render
from .policy import decide
from .predictor import scan_jsonl
from .providers.base import ContractDriftError, ProviderError, QuotaSnapshot
from .providers.bigmodel import BigmodelProvider
from .providers.zai import ZaiProvider
from .resetter import ResetClient

ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"
CAPACITY_POINTS = {"max": 28000.0, "pro": 12000.0, "lite": 2000.0}
CARDS_TTL_SEC = 1800          # 卡库存 30 分钟缓存
LOCK_STALE_SEC = 600          # 单例锁心跳超时
KINDS = ("poll", "decision", "reset_exec", "reset_result", "notify",
         "heartbeat", "login", "drift", "error")


class Daemon:
    def __init__(self, cfg=None, *, providers=None, reset_client=None,
                 notifier=None, ledger=None, burn_fn=None, decide_fn=None,
                 render_fn=None, now=None, sleep=None, telemetry_root=None):
        self.cfg = cfg or load_config(ROOT / "config.yaml")
        self.now = now or time.time
        self.sleep = sleep or time.sleep
        self.ledger = ledger or Ledger(ROOT / "ledger", now=self.now)
        self.notifier = notifier or Notifier(ledger=self.ledger, now=self.now)
        self.burn_fn = burn_fn or scan_jsonl
        self.decide_fn = decide_fn or decide
        self.render_fn = render_fn or panel_render
        self.telemetry_root = telemetry_root
        self._cards_cache = None
        self._cards_ts = 0.0
        self._drift_notified_at = 0.0
        if providers is None:
            sec = resolve_secrets(self.cfg)
            order = [ZaiProvider, BigmodelProvider] if self.cfg.providers.get("zai") is not None else \
                    [BigmodelProvider]
            providers = []
            for cls in order:
                pcfg = self.cfg.providers.get(cls.name)
                if pcfg is not None and getattr(pcfg, "enabled", True):
                    providers.append(cls(sec.plan_key, base_url=getattr(pcfg, "base_url", None) or None))
        self.providers = providers or [ZaiProvider(resolve_secrets(self.cfg).plan_key)]
        self.reset_client = reset_client or ResetClient(
            plan_key=resolve_secrets(self.cfg).plan_key,
            mode=getattr(self.cfg.policy, "mode", "dry_run"),
            ledger=self.ledger, state_dir=STATE, now=self.now)

    # ------------------------------------------------------------ 单例锁
    def _acquire_lock(self) -> bool:
        STATE.mkdir(exist_ok=True)
        lock = STATE / "daemon.lock"
        if lock.exists():
            try:
                info = json.loads(lock.read_text(encoding="utf-8"))
                if self.now() - info.get("hb", 0) < LOCK_STALE_SEC and info.get("pid") != _pid():
                    return False                       # 活实例在跑
            except Exception:                          # noqa: BLE001 — 损坏锁视为陈旧
                pass
        lock.write_text(json.dumps({"pid": _pid(), "hb": self.now()}), encoding="utf-8")
        return True

    def _heartbeat_lock(self):
        lock = STATE / "daemon.lock"
        if lock.exists():
            lock.write_text(json.dumps({"pid": _pid(), "hb": self.now()}), encoding="utf-8")

    # ------------------------------------------------------------ 轮询
    def _poll_quota(self) -> QuotaSnapshot | None:
        """主站优先，失败漂移逐级降级（EARS3：漂移不崩溃）。"""
        for prov in self.providers:
            try:
                snap = prov.fetch_quota()
                self.ledger.append("poll", {"provider": prov.name, "window_pct": snap.window_pct,
                                            "next_reset_at": snap.next_reset_at,
                                            "remaining": snap.remaining})
                return snap
            except ContractDriftError as e:
                self.ledger.append("drift", {"provider": prov.name, "diffs": str(e)[:400]})
                if self.now() - self._drift_notified_at > 1800:
                    self._safe_notify("契约漂移告警", f"{prov.name}: {str(e)[:200]}", "drift")
                    self._drift_notified_at = self.now()
            except ProviderError as e:
                self.ledger.append("error", {"provider": prov.name, "err": str(e)[:200]})
        return None

    def _cards(self) -> dict:
        if self._cards_cache and self.now() - self._cards_ts < CARDS_TTL_SEC:
            return self._cards_cache
        sec = resolve_secrets(self.cfg)
        for base in (self.providers[0].base_url, self.providers[-1].base_url):
            try:
                inv = fetch_cards(base, sec.plan_key)
                self._cards_cache, self._cards_ts = inv, self.now()
                return inv
            except Exception as e:                     # noqa: BLE001
                self.ledger.append("error", {"cards": str(base), "err": str(e)[:200]})
        return self._cards_cache or {"five_hour": [], "weekly": [], "fetched_at": 0}

    def _safe_notify(self, title, detail, kind):
        try:
            self.notifier.send(title, detail, kind)
        except Exception as e:                         # noqa: BLE001
            self.ledger.append("error", {"notify": kind, "err": str(e)[:200]})

    # ------------------------------------------------------------ 主迭代
    def run_once(self) -> dict:
        snap = self._poll_quota()
        if snap is None:
            self._safe_notify("额度查询全线失败", "双站 quota/limit 均不可达，见账本", "drift")
            return {"action": "poll_failed"}
        cards = self._cards()
        burn = self.burn_fn(self.telemetry_root, now=self.now()) \
            if self.telemetry_root is not None else self.burn_fn(now=self.now())
        recent = self.ledger.read(kinds=["decision", "reset_exec", "reset_result"], limit=50)
        d = self.decide_fn(snap, burn, cards, self.cfg, recent, now=self.now())
        self.ledger.append("decision", {"action": d.action, "reason": getattr(d, "reason", ""),
                                        "predicted_exhaust_at": getattr(d, "predicted_exhaust_at", None),
                                        "card_to_use": getattr(d, "card_to_use", None),
                                        "simulated": bool(getattr(d, "simulated", False))})
        if d.action == "reset":
            card = getattr(d, "card_to_use", None) or "five_hour"
            if getattr(self.cfg.policy, "mode", "dry_run") == "auto" and not (STATE / "zcode_jwt.txt").exists():
                # 浏览器最小出场（铁律）：仅缺 JWT 且确需重置时唤起自愈登录
                self.ledger.append("login", {"event": "jwt_missing_relogin_attempt"})
                try:
                    from .browser_relogin import main as _relogin
                    _relogin(["--max-rounds", "4"])
                except Exception as e:                 # noqa: BLE001
                    self.ledger.append("error", {"relogin": str(e)[:200]})
                    self._safe_notify("需要您一次性人工登录", "自动过验证码未成，请到 Chrome 窗口点『登录』过一次点选验证码（仅此一次，之后保活）", "login_invalid")
            try:
                # CN 域执行器优先（协议=skill bigmodel-console-protocol；JWT=cookie）
                try:
                    from . import resetter_cn
                    res = resetter_cn.execute(card, mode=getattr(self.cfg.policy, "mode", "auto"),
                                              ledger=self.ledger)
                except Exception as e:                     # noqa: BLE001 — CN 失败回退 zcode 腿
                    self.ledger.append("error", {"reset_cn": str(e)[:200]})
                    res = self.reset_client.execute(card)
                self.ledger.append("reset_result", {"card": card, "ok": True, "res": str(res)[:200],
                                                    "simulated": bool(getattr(d, "simulated", False))})
                self._safe_notify("额度已重置" if not getattr(d, "simulated", False) else "额度重置(演练)",
                                  getattr(d, "reason", ""), "reset_result")
            except Exception as e:                     # noqa: BLE001
                self.ledger.append("reset_result", {"card": card, "ok": False, "err": str(e)[:300]})
                self._safe_notify("额度重置失败", str(e)[:200], "drift")
        elif d.action == "notify_only":
            self._safe_notify("额度预警", getattr(d, "reason", ""), "low_quota")
        try:
            self.render_fn(self.ledger, cards, snap, d)
        except Exception as e:                         # noqa: BLE001
            self.ledger.append("error", {"panel": str(e)[:200]})
        self.ledger.append("heartbeat", {"v": __version__})
        self._heartbeat_lock()
        busy = snap.window_pct >= float(getattr(self.cfg.poll, "threshold_pct", 90)) - 10
        return {"action": d.action, "pct": snap.window_pct, "busy": busy}

    def run(self):
        if not self._acquire_lock():
            print("[daemon] 另一实例在跑，退出（计划任务会保活真实例）")
            return
        self.ledger.append("login", {"event": "daemon_start", "v": __version__})
        idle = int(getattr(self.cfg.poll, "idle_min", 10))
        busy_min = int(getattr(self.cfg.poll, "busy_min", 2))
        while True:
            try:
                r = self.run_once()
                wait = busy_min if r.get("busy") else idle
            except KeyboardInterrupt:
                raise
            except Exception as e:                     # noqa: BLE001 — fail loud 但不退场
                self.ledger.append("error", {"loop": str(e)[:300]})
                self._safe_notify("守护循环异常", str(e)[:200], "drift")
                wait = idle
            self.sleep(wait * 60)


def _pid() -> int:
    import os
    return os.getpid()


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="zqg.daemon")
    ap.add_argument("--once", action="store_true", help="单次迭代（冒烟/调试）")
    ap.add_argument("--mode", choices=["auto", "dry_run", "notify_only"], default=None)
    args = ap.parse_args(argv)
    if args.mode:
        from .config import load_config as _lc
        cfg = _lc(ROOT / "config.yaml")
        cfg.policy.mode = args.mode
        d = Daemon(cfg)
    else:
        d = Daemon()
    if args.once:
        print(json.dumps(d.run_once(), ensure_ascii=False))
        return 0
    d.run()
    return 0


if __name__ == "__main__":
    sys.exit(main())
