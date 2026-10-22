# -*- coding: utf-8 -*-
"""W7 履约流水线 CLI。

用法（仓库根）：
  py -3 -m kb_factory.fulfillment --once              # 扫一轮 inbox/
  py -3 -m kb_factory.fulfillment --watch             # 轮询 60s，Ctrl-C 停
  py -3 -m kb_factory.fulfillment --once --base DIR   # 指定产线目录（冒烟用）
  py -3 -m kb_factory.fulfillment --cloud-pull --base DIR   # W11：云端拉桥单轮
  py -3 -m kb_factory.fulfillment --watch + env KB_CLOUD_POLL=1    # watch 并入云拉（300s/轮）

run-ledger：fulfillment/ledger.jsonl（订单/耗时/结果/缺配原因）。
铁律：任何分支绝不删除文件（failed 也只移动）。
"""
import argparse
import json
import os
import sys
import time
from pathlib import Path

from . import deliver, pipeline
from .cloud_pull import BridgeError, pull_once
from .order import Order, OrderInbox

MODULE_DIR = Path(__file__).resolve().parent
SLA_TARGET_MIN = 30    # 目标 30 分钟
SLA_PROMISE_MIN = 120  # 承诺 2 小时
CLOUD_POLL_SEC = 300   # W11 云拉桥轮询间隔（env KB_CLOUD_POLL=1 时并入 --watch）


def _ledger_path(base_dir) -> Path:
    return Path(base_dir) / "ledger.jsonl"


def append_ledger(base_dir, entry: dict) -> None:
    with open(_ledger_path(base_dir), "a", encoding="utf-8") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")


def process_one(order_path, inbox: OrderInbox, *, base_dir=None, corpus=None) -> dict:
    """处理单订单：认领→建包→投递→done/；任何失败→failed/ 带原因。返回 ledger 条目。"""
    base = Path(base_dir) if base_dir else MODULE_DIR
    path = Path(order_path)
    t0 = time.perf_counter()
    try:
        order = Order.from_json(path)
    except ValueError as e:
        inbox.fail(path, str(e))
        entry = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "order": path.stem,
                 "elapsed_s": round(time.perf_counter() - t0, 3), "result": "failed",
                 "error": str(e)}
        append_ledger(base, entry)
        return entry

    try:
        build = pipeline.run(order, base_dir=base, corpus=corpus)
        vs = build.manifest.get("versions") or {}
        # W10：所选版本的产物 zip 随件投递（markdown 版/导入包与原包一起发）
        extras = [vs[k]["zip"] for k in ("markdown", "import_pack") if k in vs]
        d = deliver.deliver(order, build.zip_path, extras=extras)
        inbox.complete(path)
        missing = [c["reason"] for c in build.manifest["channels"] if not c["on"]]
        if d.mode != "email":
            missing.append(d.detail)
        # judge-W7#5修复：result 如实反映投递态，静默未发不再记 "ok"
        d_ok = bool(getattr(d, "ok", d.mode == "email"))
        if d_ok and d.mode == "email":
            result = "ok"
        elif d_ok:
            result = "ok_wecom_fallback"
        else:
            result = "degraded_not_delivered"
        entry = {
            "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "order": order.id,
            "elapsed_s": round(time.perf_counter() - t0, 3), "result": result,
            "build": {"kb": build.kb_name, "slots": build.stats["slots"],
                      "delivered": build.stats["delivered"], "guide": build.stats["guide"],
                      "zip": build.zip_path, "zip_kb": build.stats.get("zip_bytes", 0)},
            "deliver": {"mode": d.mode, "detail": d.detail},
            "versions": {k: {"path": v.get("zip") or v.get("dir"), "files": v.get("files")}
                         for k, v in vs.items() if k != "selection"},
            "sla": {"target_min": SLA_TARGET_MIN, "promise_min": SLA_PROMISE_MIN,
                    "elapsed_min": round((time.perf_counter() - t0) / 60, 2),
                    "within_target": (time.perf_counter() - t0) <= SLA_TARGET_MIN * 60},
            "missing": missing,
        }
        append_ledger(base, entry)
        return entry
    except Exception as e:  # 缺什么如实标什么：失败原因进 ledger + failed sidecar
        reason = f"{type(e).__name__}: {e}"
        inbox.fail(path, reason)
        entry = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "order": order.id,
                 "elapsed_s": round(time.perf_counter() - t0, 3), "result": "failed",
                 "error": reason}
        append_ledger(base, entry)
        return entry


def run_once(base_dir=None, corpus=None) -> list:
    """扫一轮 inbox/。"""
    base = Path(base_dir) if base_dir else MODULE_DIR
    inbox = OrderInbox(base)
    inbox.ensure_dirs()
    return [process_one(p, inbox, base_dir=base, corpus=corpus)
            for p in inbox.pending()]


def _cloud_pull_quiet(base_dir) -> None:
    """云拉一轮（watch 模式内嵌）：桥不可用如实打点，不崩主轮询。"""
    try:
        s = pull_once(base_dir)
        if s["pulled"] or s["unresolved"]:
            print("[cloud-pull] " + json.dumps(s, ensure_ascii=False), flush=True)
    except BridgeError as e:
        print(f"[cloud-pull] {e}", flush=True)


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="kb_factory.fulfillment",
                                 description="KB-FACTORY W7 履约流水线")
    ap.add_argument("--once", action="store_true", help="扫一轮 inbox 后退出")
    ap.add_argument("--watch", action="store_true", help="轮询 inbox（默认 60s，Ctrl-C 停）")
    ap.add_argument("--interval", type=int, default=60, help="watch 轮询秒数（默认 60）")
    ap.add_argument("--base", default=None, help="产线目录（默认 kb_factory/fulfillment/）")
    ap.add_argument("--cloud-pull", action="store_true", dest="cloud_pull",
                    help="W11：从引擎履约桥拉一轮 accepted 订单写 inbox 后退出"
                         "（凭据 env KB_ENGINE_URL/KB_BRIDGE_KEY）")
    args = ap.parse_args(argv)

    if args.cloud_pull:
        try:
            s = pull_once(args.base)
        except BridgeError as e:
            print(f"[cloud-pull] FAIL {e}", file=sys.stderr)
            return 1
        print("[cloud-pull] " + json.dumps(s, ensure_ascii=False))
        return 0
    if not (args.once or args.watch):
        ap.print_help()
        return 2
    if args.once:
        entries = run_once(args.base)
        for e in entries:
            print(json.dumps(e, ensure_ascii=False))
        return 0
    # --watch：付费触发履约，SLA 目标 30 分钟 → 60s 轮询；
    # env KB_CLOUD_POLL=1 时并入云端拉桥（默认每 300s 一轮）
    cloud_poll = (os.environ.get("KB_CLOUD_POLL") or "").strip() == "1"
    print(f"[watch] base={args.base or MODULE_DIR} interval={args.interval}s，Ctrl-C 停"
          + (f"，cloud-pull 每 {CLOUD_POLL_SEC}s" if cloud_poll else ""), flush=True)
    last_pull = 0.0
    try:
        while True:
            if cloud_poll and time.time() - last_pull >= CLOUD_POLL_SEC:
                _cloud_pull_quiet(args.base)
                last_pull = time.time()
            for e in run_once(args.base):
                print(json.dumps(e, ensure_ascii=False), flush=True)
            time.sleep(max(5, args.interval))
    except KeyboardInterrupt:
        print("[watch] 收到 Ctrl-C，正常退出（未处理订单留在 inbox/）", flush=True)
        return 0


if __name__ == "__main__":
    sys.exit(main())
