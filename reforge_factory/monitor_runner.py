# -*- coding: utf-8 -*-
"""monitor_runner.py — P0-5 (1028) 免费盯梢运行器 (changedetection.io watcher 模型).

铁律内嵌:
  * 纯 HTTP 零浏览器 (铁律: 浏览器不必要不开) — 直连优先→代理兜底
    (复用 legs/http_api_leg_core.fetch);
  * 无常驻进程 — 幂等单跑 (cron/任务计划/会话按需调), 状态只增不删;
  * 首跑=基线不告警 (防装机轰炸); 变更才触发回调链:
      ① channel_invocations 落账 (api_replica_bridge.append_invocation,
         站级台账 reforge_factory/channel_invocations.jsonl, 只增);
      ② 企微通知 (复用 tools/notify_approval_wecom.py 的 webhook 位,
         监控模板非批准模板 — webhook() 函数级复用, 原件不动).
  * 数字零造假 — 状态/事件全为真实抓取实测哈希, 失败如实记 fail 不伪造.

用法:
  py reforge_factory/monitor_runner.py                  # 全量巡检一轮
  py reforge_factory/monitor_runner.py --watch ceca_org_cn   # 单源
  py reforge_factory/monitor_runner.py --no-notify      # 不发企微 (只落账)
  py reforge_factory/monitor_runner.py --status         # 看状态不抓取
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
RF = Path(__file__).resolve().parent
REPO = RF.parent
sys.path.insert(0, str(RF / "legs"))
from http_api_leg_core import fetch                    # noqa: E402 (直连→代理兜底)
import api_replica_bridge as arb                       # noqa: E402 (台账只增)

CONFIG_PATH = RF / "monitor_config.json"


def _load_config() -> dict:
    return json.loads(CONFIG_PATH.read_text(encoding="utf-8"))


def _load_state(cfg: dict) -> dict:
    sp = Path(cfg["state_file"])
    if sp.is_file():
        return json.loads(sp.read_text(encoding="utf-8"))
    return {"watchers": {}}


def _save_state(cfg: dict, st: dict) -> None:
    sp = Path(cfg["state_file"])
    tmp = sp.with_suffix(".tmp")
    tmp.write_text(json.dumps(st, ensure_ascii=False, indent=1), encoding="utf-8")
    tmp.replace(sp)


def _append_event(cfg: dict, row: dict) -> None:
    ep = Path(cfg["events_log"])
    with ep.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")


def _normalize(text: str) -> str:
    """去空白差异再哈希 (页面重排/缩进噪声不误报; 内容级变更才触发)."""
    return re.sub(r"\s+", "", text or "")


def _wecom_notify(cfg: dict, title: str, detail: str) -> bool:
    """企微通知 (webhook 位函数级复用 notify_approval_wecom, 监控模板)."""
    try:
        sys.path.insert(0, str(REPO / "tools"))
        from notify_approval_wecom import webhook
        u = webhook()
        if not u:
            print("[monitor] 企微: 无 webhook 配置, 如实跳过")
            return False
        md = (f"📡 **免费源监控变更**\n> {title}\n"
              + (f"\n{detail}\n" if detail else "")
              + "\n(自动盯梢 P0-5 · 回调链: channel_invocations 已落账)")
        req = urllib.request.Request(
            u, data=json.dumps({"msgtype": "markdown",
                                "markdown": {"content": md}}).encode(),
            headers={"Content-Type": "application/json"})
        with urllib.request.urlopen(req, timeout=10) as r:
            print("[monitor] 企微已推:", r.read().decode()[:60])
        return True
    except Exception as e:                             # noqa: BLE001 — fail-soft
        print(f"[monitor] 企微推送失败 (如实): {type(e).__name__}: {str(e)[:120]}")
        return False


def check_one(cfg: dict, w: dict, st: dict, notify: bool = True) -> dict:
    wid = w["id"]
    status, text, via = fetch(w["url"], proxy=cfg.get("proxy_mode", "auto"))
    ts = time.strftime("%Y-%m-%dT%H:%M:%S")
    if status != 200 or not text:
        row = {"ts": ts, "watcher": wid, "event": "fetch_fail", "status": status,
               "via": via, "url": w["url"]}
        _append_event(cfg, row)
        print(f"[monitor] {wid}: 如实失败 HTTP {status} via {via}")
        return row
    digest = hashlib.sha256(_normalize(text).encode("utf-8")).hexdigest()[:16]
    prev = st["watchers"].get(wid)
    if prev is None:                                   # 首跑 = 基线, 不告警
        st["watchers"][wid] = {"hash": digest, "url": w["url"],
                               "first_seen": ts, "last_checked": ts,
                               "changes": 0}
        row = {"ts": ts, "watcher": wid, "event": "baseline", "hash": digest,
               "bytes": len(text), "via": via}
        _append_event(cfg, row)
        print(f"[monitor] {wid}: 基线落档 {digest} ({len(text):,}B via {via})")
        return row
    st["watchers"][wid]["last_checked"] = ts
    if digest == prev["hash"]:
        row = {"ts": ts, "watcher": wid, "event": "unchanged", "hash": digest}
        _append_event(cfg, row)
        print(f"[monitor] {wid}: 无变更 ({digest})")
        return row
    # ---- 变更! 回调链: ①台账 ②企微 ----
    old = prev["hash"]
    prev.update(hash=digest, last_changed=ts, changes=prev.get("changes", 0) + 1)
    row = {"ts": ts, "watcher": wid, "event": "change", "old_hash": old,
           "new_hash": digest, "url": w["url"], "name": w.get("name", "")}
    _append_event(cfg, row)
    yld = f"变更 {old}->{digest} @ {w['url']}"
    ok_ledger = arb.append_invocation(
        cfg.get("engine", "changedetection_monitor"),
        "monitor_runner:changedetection-model (纯HTTP零浏览器)",
        w["id"], yld,
        note="1028 P0-5 免费盯梢: " + w.get("name", "") +
             "; 回调链=channel_invocations+企微",
        ledger=cfg.get("channel_invocations_ledger"))
    print(f"[monitor] {wid}: ⚡变更 {old} -> {digest} | 台账落账={'OK' if ok_ledger else 'FAIL'}")
    if notify:
        _wecom_notify(cfg, f"{w.get('name', wid)} 检测到变更",
                      f"- 监控源: {w['url']}\n- 哈希: {old} → {digest}"
                      f"\n- 时间: {ts}\n- 台账: {cfg.get('channel_invocations_ledger')}")
    return row


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="P0-5 免费盯梢 (changedetection.io 模型)")
    ap.add_argument("--watch", action="append", default=[], help="只查指定 id")
    ap.add_argument("--no-notify", action="store_true", help="不发企微 (只落账)")
    ap.add_argument("--status", action="store_true", help="只看状态不抓取")
    ns = ap.parse_args(argv)
    cfg = _load_config()
    if ns.status:
        print(json.dumps(_load_state(cfg), ensure_ascii=False, indent=1))
        return 0
    st = _load_state(cfg)
    todo = [w for w in cfg["watchers"]
            if not ns.watch or w["id"] in ns.watch]
    events = [check_one(cfg, w, st, notify=not ns.no_notify) for w in todo]
    _save_state(cfg, st)
    n_change = sum(1 for e in events if e.get("event") == "change")
    n_fail = sum(1 for e in events if e.get("event") == "fetch_fail")
    print(json.dumps({"watchers": len(todo), "changes": n_change,
                      "fails": n_fail,
                      "notify": not ns.no_notify}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
