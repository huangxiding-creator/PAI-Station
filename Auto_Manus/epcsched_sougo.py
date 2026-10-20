# -*- coding: utf-8 -*-
"""EPC-SCHED 搜狗微信腿 — 工期管理/延误索赔 关键词批提交器 (1020).

复刻 epc49_sougo.py 已验证模式, 三处按 1020 现实修:
- 浏览器口 19825→19826 (opencli daemon 长驻占用 19825, 抢绑必败);
- 不再 wait opencli 夜腿 (端口已分家, 零竞争);
- 游标文件独立 (data/sougo_kw_cursor_sched.json), 与 epc49 游标互不干扰.

词表 = EPC-SCHED 池 12 核心词 (pool_state kws / tiers T1+T2核心)。
产物在 E:\AI-Station\ResearchFactory-Eng\SouGouWeDown2\output\,
由 epcsched_sougo_harvest.py 归位+回灌 (engine=wechat:sogou)。
用法: python epcsched_sougo.py [--limit N] [--from N] [--next N] [--cooldown 秒]
"""
import argparse
import json
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
API = "http://127.0.0.1:3000"
HOLD_STATE = Path(r"E:\AI-Station\hold_state.json")
CURSOR = Path(__file__).parent / "data" / "sougo_kw_cursor_sched.json"

CODE_VERSION = "sched-v1"   # 不跑旧码铁律: 起跑必打横幅, 早验收 grep "[sched-v1]"

KEYWORDS = [
    "工期延误 索赔",
    "工期顺延 签证",
    "赶工 费用",
    "停工损失",
    "工期签证",
    "网络计划 关键线路",
    "进度偏差 纠偏",
    "施工组织设计 工期",
    "EPC 工期管理",
    "工程总承包 进度管理",
    "工期争议 判决",
    "延误责任 划分",
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


def wait_idle(poll: int = 30, max_wait: int = 1800) -> None:
    """等服务空闲; captcha 死锁→unstick; 超时放弃绝不无限挂 (1001 根修)."""
    t0 = time.time()
    n_miss = n_captcha = 0
    while True:
        try:
            st = get_status()
        except Exception:
            n_miss += 1
            if n_miss == 1:
                print(f"[wait] :3000 不可达, 轮询 (上限 {max_wait // 60}min)...",
                      flush=True)
            if time.time() - t0 > max_wait:
                print(f"[wait] 服务 {max_wait // 60}min 未复活, 本批放弃",
                      flush=True)
                raise SystemExit(1)
            time.sleep(poll)
            continue
        ph = st.get("progress", {}).get("phase", "idle")
        if ph == "captcha":
            n_captcha += 1
            if n_captcha >= 3:
                unstick_service()
                n_captcha = 0
            time.sleep(poll)
            continue
        if not st.get("running") or ph in ("idle", "done", "error"):
            return
        time.sleep(poll)


def port_owner(port: int) -> str:
    r = subprocess.run(["netstat", "-ano"], capture_output=True)
    for ln in r.stdout.decode("gbk", errors="replace").splitlines():
        if f":{port}" in ln and "LISTENING" in ln:
            return ln.split()[-1]
    return ""


def unstick_service() -> None:
    """captcha 死锁解卡: 杀 :3000 属主 → headless.cmd (已修 19826) 重建."""
    pid = port_owner(3000)
    if pid:
        subprocess.run(["taskkill", "/f", "/pid", pid], capture_output=True)
        print(f"[unstick] 已杀 :3000 属主 pid={pid} (captcha 死锁)", flush=True)
    time.sleep(3)
    subprocess.run(
        ["cmd", "/c", r"E:\AI-Station\Auto_Manus"
                       r"\epc_sougo_browser_headless.cmd"],
        capture_output=True, creationflags=0x08000000, timeout=300)
    print("[unstick] headless.cmd 重建完毕", flush=True)


def main() -> int:
    print(f"[{CODE_VERSION}] SCHED 搜狗腿启动 {time.strftime('%F %T')}",
          flush=True)
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--from", dest="from_n", type=int, default=1)
    ap.add_argument("--next", dest="next_n", type=int, default=0,
                    help="游标模式: 取下 N 词, 批完推进游标")
    ap.add_argument("--cooldown", type=int, default=600)
    args = ap.parse_args()
    if paused_by_user():
        print("[gate] hold_state=pause (用户让路未恢复), 本批跳过")
        return 0
    if args.next_n > 0:
        try:
            cursor = json.loads(CURSOR.read_text(encoding="utf-8"))["done"]
        except Exception:
            cursor = 0
        kws = KEYWORDS[cursor:cursor + args.next_n]
        print(f"[cursor] 词 {cursor + 1}-{cursor + len(kws)} "
              f"(池 {len(KEYWORDS)}, 剩 {len(KEYWORDS) - cursor})", flush=True)
    else:
        kws = KEYWORDS[args.from_n - 1:]
        if args.limit:
            kws = kws[:args.limit]
    if not kws:
        print("[批] 词池已尽, 收工", flush=True)
        return 0
    print(f"[sched sougo] {len(kws)} 词 (冷却 {args.cooldown}s)", flush=True)
    wait_idle()
    for i, kw in enumerate(kws, 1):
        print(f"[{i}/{len(kws)}] 提交: {kw}", flush=True)
        submitted = False
        for attempt in range(3):
            try:
                r = post(f"{API}/api/search",
                         {"keyword": kw, "pages": 2,
                          "delayMin": 3, "delayMax": 6})
                if r.get("success"):
                    submitted = True
                    break
                print(f"    拒绝: {r}", flush=True)
                break
            except urllib.error.HTTPError as e:
                if e.code == 409:
                    print(f"    409 忙 (试 {attempt + 1}/3)", flush=True)
                    try:
                        st = get_status()
                        if st.get("progress", {}).get("phase") == "captcha":
                            unstick_service()
                    except Exception:
                        pass
                    time.sleep(90)
                    continue
                print(f"    EXC {type(e).__name__}: {str(e)[:60]}", flush=True)
                time.sleep(60)
                break
            except Exception as e:
                print(f"    EXC {type(e).__name__}: {str(e)[:60]}", flush=True)
                time.sleep(60)
                break
        if not submitted:
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
                    print("    !! 验证码卡住, 解卡后跳词", flush=True)
                    unstick_service()
                    break
                if not st.get("running") or ph in ("done", "error", "idle"):
                    print(f"    终态 {ph}: {msg}", flush=True)
                    break
            except Exception:
                pass
        if i < len(kws):
            print(f"    冷却 {args.cooldown}s", flush=True)
            time.sleep(args.cooldown)
    print("[sched sougo 批] 完", flush=True)
    if args.next_n > 0 and kws:
        try:
            done = json.loads(CURSOR.read_text(encoding="utf-8"))["done"]
        except Exception:
            done = 0
        new_done = max(done, KEYWORDS.index(kws[-1]) + 1)
        CURSOR.parent.mkdir(parents=True, exist_ok=True)
        CURSOR.write_text(
            json.dumps({"done": new_done,
                        "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}),
            encoding="utf-8")
        print(f"[cursor] 推进至 {new_done} 词", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
