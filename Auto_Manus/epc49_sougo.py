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
import subprocess
import sys
import time
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
API = "http://127.0.0.1:3000"
HOLD_STATE = Path(r"E:\AI-Station\hold_state.json")

CODE_VERSION = "v2"      # 不跑旧码铁律: 起跑必打横幅, 早验收 grep "[v2]"

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
    # 1004 夜班扩容令新增 (词 13-24): 补未采维度 — 全过程咨询/勘测设计/
    # 项目管理/经营业绩/国际合作/安全质量/数字化交付/绿色低碳/组织人才/
    # 风电光伏/电网工程/产业协同. 每词历史产出 ~10-30万字 (合并档).
    "四川电力设计咨询 全过程工程咨询",
    "四川院 勘测设计",
    "四川电力设计咨询 项目管理",
    "四川电力设计咨询 经营业绩",
    "中国电建四川院 国际合作",
    "四川电力设计咨询 安全质量",
    "四川院 数字化交付",
    "四川电力设计咨询 绿色低碳",
    "四川院 风电 光伏",
    "四川电力设计咨询 电网工程",
    "四川电力设计咨询 工程总承包 中标",
    "中国电建四川院 改革",
    # 1004 渠道总动员令: 官微定向词 (官微名三源交叉确证, 搜狗只召回
    # 近期/已索引文章作持续增量; 全历史靠 exporter 全量腿待用户授权).
    "四川电力设计咨询公司",
    "中国电建四川院 企业动态",
    "四川院 工程纪实",
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
    """等服务空闲. 1001 事故根修: 服务死→原版无限静默重试, 整腿无声挂死.

    max_wait 内服务始终不可达 → 打印原因并退出 (让夜腿日志可诊断,
    schtask 下次再战), 绝不无限挂.

    1004 增: 验证码死锁探测 — 服务端 waitForCaptcha 只认手动「验证完成」
    按钮, headless 无人点 → pipeline 永挂 + isRunning 卡 true → 后续词
    全 409 (1003 夜实锤: 词9-12 全灭 + opencli 腿陪等 3h). 卡 captcha
    视同服务死: 杀 :3000 属主 + headless.cmd 幂等重建, 一次即放手.
    """
    t0 = time.time()
    n_miss = n_captcha = 0
    while True:
        try:
            st = get_status()
        except Exception:
            n_miss += 1
            if n_miss == 1:
                print("[wait] SouGouWeDown2 :3000 不可达, 轮询等待中"
                      f" (上限 {max_wait // 60}min)...", flush=True)
            if time.time() - t0 > max_wait:
                print(f"[wait] 服务 {max_wait // 60}min 未复活, 本批放弃退出",
                      flush=True)
                raise SystemExit(1)
            time.sleep(poll)
            continue
        ph = st.get("progress", {}).get("phase", "idle")
        if ph == "captcha":
            n_captcha += 1
            if n_captcha >= 3:            # ~90s 无人解 = headless 死锁
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
    """captcha 死锁解卡: 杀 :3000 服务属主 → headless.cmd 三位一体重建.

    只按端口属主杀 (服务是 SGDIR 的 node, 不误伤); 重建含 busy-guard
    (此时服务已死 guard 必过) → msedge@19825 + 服务 + daemon 全归位.
    1004 夜班扩容令: 与 headless.cmd 同配方, 单一真源.
    """
    pid = port_owner(3000)
    if pid:
        subprocess.run(["taskkill", "/f", "/pid", pid], capture_output=True)
        print(f"[unstick] 已杀 :3000 服务属主 pid={pid} (captcha 死锁)",
              flush=True)
    time.sleep(3)
    r = subprocess.run(
        ["cmd", "/c", r"E:\AI-Station\Auto_Manus"
                       r"\epc_sougo_browser_headless.cmd"],
        capture_output=True, creationflags=0x08000000, timeout=180)
    print("[unstick] headless.cmd 重建完毕", flush=True)


def wait_opencli_done(max_wait: int = 3600) -> None:
    """等 opencli 夜腿收官 (1004 夜班扩容: 04:20 二班不抢 19825).

    锁文件属主进程已死 = 僵尸锁, 直接越过; 上限 1h 让明晚再战.
    """
    lock = Path(__file__).parent / "data" / "epc49_opencli.lock"
    t0 = time.time()
    warned = False
    while time.time() - t0 < max_wait:
        try:
            pid = int(lock.read_text().strip())
        except (OSError, ValueError):
            return
        r = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                           capture_output=True)
        alive = str(pid) in (r.stdout or b"").decode("gbk", errors="replace")
        if not alive:
            print(f"[gate] opencli 锁属主 {pid} 已死 (僵尸锁), 越过", flush=True)
            return
        if not warned:
            print(f"[gate] opencli 夜腿在跑 (pid {pid}), 等收官 "
                  f"(上限 {max_wait // 60}min)...", flush=True)
            warned = True
        time.sleep(60)
    print("[gate] opencli 等待超时, 本批放弃 (浏览器让路优先)", flush=True)
    raise SystemExit(1)


def main() -> int:
    print(f"[{CODE_VERSION}] 搜狗夜腿启动 {time.strftime('%F %T')}",
          flush=True)
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--from", dest="from_n", type=int, default=1)
    ap.add_argument("--next", dest="next_n", type=int, default=0,
                    help="自动取词模式: 从游标 (data/sougo_kw_cursor.json) "
                         "取下 N 词, 批完推进游标. 夜班 schtask 用这个, "
                         "词池自动前进无须手工换批 (1004 夜班扩容令)")
    ap.add_argument("--cooldown", type=int, default=600)
    args = ap.parse_args()
    if paused_by_user():
        print("[gate] hold_state 最近一条=pause (用户让路/暂停未恢复), 本批跳过")
        return 0
    wait_opencli_done()
    cursor_file = Path(__file__).parent / "data" / "sougo_kw_cursor.json"
    if args.next_n > 0:
        try:
            cursor = json.loads(cursor_file.read_text(encoding="utf-8"))["done"]
        except Exception:
            cursor = 8          # 词 1-8 已实跑 (kw1 六词 + kw2 词7-8)
        kws = KEYWORDS[cursor:cursor + args.next_n]
        print(f"[cursor] 词 {cursor + 1}-{cursor + len(kws)} "
              f"(池 {len(KEYWORDS)} 词, 剩 {len(KEYWORDS) - cursor})",
              flush=True)
    else:
        kws = KEYWORDS[args.from_n - 1:]
        if args.limit:
            kws = kws[:args.limit]
    if not kws:
        print("[批] 词池已尽, 收工 (扩词请编辑 KEYWORDS)", flush=True)
        return 0
    print(f"[epc49 sougo] {len(kws)} 词 (冷却 {args.cooldown}s)", flush=True)
    wait_idle()
    for i, kw in enumerate(kws, 1):
        print(f"[{i}/{len(kws)}] 提交: {kw}", flush=True)
        # 1004: 409 重试不弃词 (1003 夜实锤: 词8 验证码把 isRunning 卡死,
        # 词9-12 连续 409 全灭). 重试前若探测到 captcha 死锁先 unstick.
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
                break               # 400 类参数错: 重试无意义
            except urllib.error.HTTPError as e:
                if e.code == 409:
                    print(f"    409 忙 (试 {attempt + 1}/3), "
                          f"查死锁后续等重提", flush=True)
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
                    # 1004: 跳词前先解卡 — 留死锁服务=后续词全 409
                    # (1003 夜词9-12 全灭根因). 本词放弃, 服务还活.
                    print("    !! 验证码卡住 (headless 无法解), 解卡后跳词",
                          flush=True)
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
    print("[epc49 sougo 批] 完", flush=True)
    if args.next_n > 0 and kws:
        try:
            done = json.loads(cursor_file.read_text(encoding="utf-8"))["done"]
        except Exception:
            done = 8
        new_done = max(done, KEYWORDS.index(kws[-1]) + 1)
        cursor_file.parent.mkdir(parents=True, exist_ok=True)
        cursor_file.write_text(
            json.dumps({"done": new_done,
                        "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}),
            encoding="utf-8")
        print(f"[cursor] 推进至 {new_done} 词", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
