# -*- coding: utf-8 -*-
"""EPC50 搜狗微信腿 — 关键词批提交器 (0923).

SouGouWeDown2 (:3000) 单任务锁天然串行; 中文必须 UTF-8 文件体 (GBK 铁律);
每词 2 页 (工具内建反爬: 每 2 搜索页自动长停 60-120s + 页内 3-6s);
词间冷却 600s (账号安全: IP 级节流). 产物在 SouGouWeDown2/output/,
由后续归位器拷入战场 04 目录.
用法: python epc50_sougo.py [--limit N] [--cooldowm 秒]
"""
import argparse
import json
import sys
import time
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
API = "http://127.0.0.1:3000"
COMPANY = "中石化南京工程"

KEYWORDS = [
    "中石化南京工程有限公司",
    "中石化南京工程 EPC",
    "南京工程公司 总承包",
    "中石化南京工程 中标",
    "中石化南京工程 煤化工",
    "中石化南京工程 炼化",
    "中石化南京工程 项目管理",
    "中石化南京工程 设计",
    "中石化南京工程 海外项目",
    "中石化南京工程 安全生产",
    "中石化南京工程 数字化转型",
    "中石化南京工程 科技创新",
]


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
    """等当前任务跑完 (done/error/idle)."""
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
    ap.add_argument("--keywords-file", type=str, default="",
                    help="外部词表 UTF-8 每行一词 (0924 增量腿)")
    args = ap.parse_args()
    if args.keywords_file:            # 0924 增: 外部词表 (UTF-8 每行一词)
        kws = [l.strip() for l in
               Path(args.keywords_file).read_text(encoding="utf-8").splitlines()
               if l.strip()]
    else:
        kws = KEYWORDS[args.from_n - 1:]
        if args.limit:
            kws = kws[:args.limit]

    wait_idle()
    for i, kw in enumerate(kws, 1):
        print(f"[{i}/{len(kws)}] 提交: {kw}", flush=True)
        try:
            r = post(f"{API}/api/search",
                     {"keyword": kw, "pages": 2, "delayMin": 3, "delayMax": 6})
            if not r.get("success"):
                print(f"    拒绝: {r}", flush=True)
        except urllib.error.HTTPError as e:
            print(f"    HTTP {e.code} (占用? 等 120s)", flush=True)
            time.sleep(120)
            continue
        except Exception as e:
            print(f"    EXC {type(e).__name__}: {str(e)[:60]}", flush=True)
            time.sleep(60)
            continue
        # 等这个词跑完
        t0 = time.time()
        last_phase = ""
        while True:
            time.sleep(30)
            try:
                st = get_status()
                ph = st.get("progress", {}).get("phase", "?")
                msg = st.get("progress", {}).get("message", "")[:60]
                if ph != last_phase:
                    print(f"    [{int(time.time()-t0)}s] {ph} {msg}",
                          flush=True)
                    last_phase = ph
                if ph == "captcha":
                    print("    !! 验证码卡住 (headless 无法解), 跳词",
                          flush=True)
                    break
                if not st.get("running") or ph in ("done", "error", "idle"):
                    print(f"    终态 {ph}: {msg}", flush=True)
                    break
            except Exception:
                pass
        if i < len(kws):
            print(f"    冷却 {args.cooldown}s", flush=True)
            time.sleep(args.cooldown)
    print("[sougo 批] 完", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
