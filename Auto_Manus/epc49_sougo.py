# -*- coding: utf-8 -*-
"""EPC49 搜狗微信腿 — 四川电力设计咨询(中国电建四川院) 关键词批提交器 (0930).

复刻 epc50_sougo.py 已验证模式:
- SouGouWeDown2 (:3000) 单任务锁天然串行; 中文 UTF-8 文件体 (GBK 铁律走 API body);
- 每词 2 页 (工具内建反爬: 每 2 搜索页长停 60-120s + 页内 3-6s);
- 词间冷却 600s (账号安全: IP 级节流).
新增: 让路条件闸 — hold_state.json 最近一条为 pause (用户让路/暂停未恢复) 则整批跳过,
符合「预备就位+自动触发」拍板模式 (夜间窗自跑, 用户喊停零动作).
产物在 ResearchFactory-Eng/SouGouWeDown2/output/, 由 epc49_sougo_harvest.py 归位+回灌.
用法: python epc49_sougo.py [--limit N] [--cooldown 秒]
"""
import argparse
import json
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
API = "http://127.0.0.1:3000"
HOLD_STATE = Path(r"E:\AI-Station\hold_state.json")

KEYWORDS = [
    "四川电力设计咨询有限责任公司",
    "四川电力设计咨询 EPC",
    "中国电建四川院 总承包",
    "四川院 输变电",
    "四川电力设计咨询 中标",
    "四川电力设计咨询 新能源",
    "四川院 抽水蓄能",
    "四川电力设计咨询 储能",
    "四川院 特高压",
    "四川电力设计咨询 海外项目",
    "四川院 低空经济",
    "四川电力设计咨询 数字化",
]


def paused_by_user() -> bool:
    """让路/暂停条件闸: hold_state 最近一条为 pause = 用户暂停态未恢复."""
    try:
        st = json.loads(HOLD_STATE.read_text(encoding="utf-8"))
        ents = st.get("entries", [])
        return bool(ents) and ents[-1].get("kind") == "pause"
    except Exception:
        return False


def post(url: str, body: dict | None = None, timeout: int = 30) -> dict:
    data = (json.dumps(body, ensure_ascii=False).encode("utf-8")
            if body is not None else None)
    req = urllib.request.Request(url, data=data, method="POST",
                                 headers={"Content-Type":
                                          "application/json; charset=utf-8"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read().decode("utf-8"))


def get_status() -> dict:
    with urllib.request.urlopen(f"{API}/api/status", timeout=15) as r:
        return json.loads(r.read().decode("utf-8"))


def wait_idle(poll: int = 30) -> None:
    while True:
        try:
            st = get_status()
        except Exception:
            time.sleep(poll)
            continue
        ph = st.get("progress", {}).get("phase", "idle")
        if not st.get("running") or ph in ("idle", "done", "error"):
            return
        time.sleep(poll)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--from", dest="from_n", type=int, default=1)
    ap.add_argument("--cooldown", type=int, default=600)
    args = ap.parse_args()
    if paused_by_user():
        print("[gate] hold_state 最近一条=pause (用户让路/暂停未恢复), 本批跳过")
        return 0
    kws = KEYWORDS[args.from_n - 1:]
    if args.limit:
        kws = kws[:args.limit]
    print(f"[epc49 sougo] {len(kws)} 词 (冷却 {args.cooldown}s)", flush=True)
    wait_idle()
    for i, kw in enumerate(kws, 1):
        print(f"[{i}/{len(kws)}] 提交: {kw}", flush=True)
        try:
            r = post(f"{API}/api/search",
                     {"keyword": kw, "pages": 2, "delayMin": 3, "delayMax": 6})
            if not r.get("success"):
                print(f"    拒绝: {r}", flush=True)
        except Exception as e:
            print(f"    EXC {type(e).__name__}: {str(e)[:60]}", flush=True)
            time.sleep(60)
            continue
        t0 = time.time()
        last_phase = ""
        while True:
            time.sleep(30)
            try:
                st = get_status()
                ph = st.get("progress", {}).get("phase", "?")
                msg = st.get("progress", {}).get("message", "")[:60]
                if ph != last_phase:
                    print(f"    [{int(time.time()-t0)}s] {ph} {msg}", flush=True)
                    last_phase = ph
                if ph == "captcha":
                    print("    !! 验证码卡住 (headless 无法解), 跳词", flush=True)
                    break
                if not st.get("running") or ph in ("done", "error", "idle"):
                    print(f"    终态 {ph}: {msg}", flush=True)
                    break
            except Exception:
                pass
        if i < len(kws):
            print(f"    冷却 {args.cooldown}s", flush=True)
            time.sleep(args.cooldown)
    print("[epc49 sougo 批] 完", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
