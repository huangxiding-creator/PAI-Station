# -*- coding: utf-8 -*-
"""EPC50 军团调度器 — 主题树 × 账号池矩阵下发 (0923).

路线考古: api.manus.im 无 CreateTask REST (404×3 实锤), web 端走 WebSocket,
API key 走企业合规面 → 浏览器 composer 是唯一实证派发路.
双形态: ①bootcamp 内挂钩 dispatch_on_page (账号登录瞬间顺手派发, 零冲突);
②独立浏览器轮 (token 账号补派, bootcamp 收工后跑).
纪律: 每账号每日 DAILY_PER_ACCOUNT 帽 (现行=1, 放宽须批); 账号间 20-40s;
派发全留痕; 完成通知→webhook 自动收割 (hook_harvest).
轮次: 第 0 轮 = 主题树 manus_use (规划类, 盘家底方法论); 第 1+ 轮 = collect
+ 查询词轮转 (弹药量产).
"""
import argparse
import atexit
import json
import os
import random
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
# 0928 永久闸: 平台封号实锤, 用户令永久停用军团链 (见 data/MANUS_CORPS_HALTED)
HALT = Path(__file__).parent / "data" / "MANUS_CORPS_HALTED"
if HALT.exists():
    print(f"[HALT] 军团永久停用中: "
          f"{HALT.read_text(encoding='utf-8').splitlines()[0]}")
    sys.exit(0)
import manus_api as api
import manus_lib as lib

BATTLE = Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics"
              r"\《中石化南京工程有限公司怎么干EPC总承包？》")
TREE = BATTLE / "_pipeline" / "epc50_topic_tree.json"
TREE2 = BATTLE / "_pipeline" / "epc50_topic_tree_v2.json"  # 560 问库
# 0924 用户令: 调研问题树也可以交给 Manus 生成 — survey_plan 种子队列,
# 军团轮内优先派发, 产出收割后抽问题并入问库 (feed 下日额度)
SURVEY_SEEDS = BATTLE / "_pipeline" / "epc50_survey_seeds.json"
SAT_OUT = BATTLE / "_pipeline" / "epc50_saturation.json"  # 0925 饱和门饥饿清单
LEDGER = Path("data/dispatch_ledger.json")
LOCK = Path("data/epc50_corps.lock")   # 0926: corps 级单实例锁 (Win32 pid)
DAILY_PER_ACCOUNT = 2  # 2026-09-23 用户明示授权: 300积分/日 → ≤2任务/日
CORPS_LOG = Path("data/epc50_corps_log.jsonl")
# 0924 机制保留: 特例账号禁用入口 (当前空集; 51817@qq.com 经用户
# 12:5x 明示解禁可用)
EXCLUDE_EMAILS: set[str] = set()
# 0924 夜实锤 (probe_send_forensic): 「获取更多积分」弹窗 = 账号当日
# 额度尽 (GetAvailableCredits totalCredentials=-10) — 派发前 API 预检,
# 不足即跳过不烧登录; 连续 LOW_STREAK_CAP 个不足 = 军团当日额度尽.
MIN_CREDITS = 60          # 一单 collect/research_plan 实耗 30-55
LOW_STREAK_CAP = 15
LOW_STATE = Path("data/epc50_credits_low.json")   # 当日已判低账号 (重启免重登)


def _low_today() -> dict:
    """当日已判积分不足的账号 {email: credits}; 隔日自动清零."""
    try:
        d = json.loads(LOW_STATE.read_text(encoding="utf-8"))
        if d.get("day") == time.strftime("%Y-%m-%d"):
            return d.get("low", {})
    except Exception:
        pass
    return {}


def _mark_low(email: str, credits: int) -> None:
    d = {"day": time.strftime("%Y-%m-%d"), "low": _low_today()}
    d["low"][email] = credits
    _atomic_write_json(LOW_STATE, d)


# ---------------------------------------------------------------- 账本
def _load_ledger() -> dict:
    day = time.strftime("%Y-%m-%d")
    if LEDGER.is_file():
        # 0926 崩溃残留容错: 进程被杀时 write_text 截断成空白/半行,
        # 坏账本不该杀派发链 — 视同过期重置 (当日账从零, 语义正确).
        try:
            led = json.loads(LEDGER.read_text(encoding="utf-8"))
            if led.get("day") == day:
                return led
        except (json.JSONDecodeError, UnicodeDecodeError):
            pass
    return {"day": day, "dispatched": {}}


def _atomic_write_json(path: Path, obj) -> None:
    """0926 用户令固化: 原子写. 今晨三连环实锤 (ledger 空白 / corps_log
    半行 / tree2 NUL 空洞 191KB) 全是进程被杀时 write_text 缓冲未刷盘
    截断 — 状态文件半态直接杀派发链. tmp + os.replace 保证任意时刻
    被杀, 落盘要么旧版要么新版, 永不半态."""
    tmp = path.with_suffix(path.suffix + ".tmp")
    tmp.write_text(json.dumps(obj, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    os.replace(tmp, path)


def _save_ledger(led: dict) -> None:
    _atomic_write_json(LEDGER, led)


def _pid_alive(pid: int) -> bool:
    """Win32 pid 探活 (tasklist, 快且不依赖 WMI/PowerShell 冷启动 —
    0926 实锤 CIM 查询在并发窗可超时失明 → 双军团漏网)."""
    try:
        r = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                           capture_output=True, text=True, timeout=20)
        return bool(re.search(rf"^\S+\s+{pid}\s", r.stdout or "",
                              re.MULTILINE))
    except Exception:
        return True    # 查询失败 = 保守视为活 (让位, 宁可等下轮)


def _acquire_corps_lock() -> bool:
    """0926 双军团竞态根修 (三连实锤 09:51/10:09/10:16). fill 级闸对
    「守卫重开×手动重拉」清场空窗有秒级缝隙; v1 锁的 pid 查证依赖
    PowerShell CIM 冷启动, 并发窗失明漏网. v2 = O_EXCL 原子创建抢占
    (OS 级保证唯一赢家, 零查询依赖) + tasklist 死锁接管 + 6h 锁龄兜底."""
    if LOCK.is_file():
        take_over = False
        try:
            old = int(LOCK.read_text(encoding="utf-8").strip())
        except ValueError:
            old = 0
            take_over = True
        try:
            age = time.time() - LOCK.stat().st_mtime
        except OSError:
            age = 0.0
        if not take_over:
            if old == os.getpid():
                return True   # 重入 (已在跑的持有者)
            if age > 6 * 3600:
                take_over = True   # 锁龄兜底 (pid 复用盲区)
            elif not _pid_alive(old):
                take_over = True   # 死锁接管 (taskkill 无 atexit)
            else:
                print(f"[corps] 单实例: 活军团 pid={old} 在跑, "
                      f"本实例让位退出 (fill 下轮重试)", flush=True)
                return False
        if take_over:
            try:
                LOCK.unlink()
            except OSError:
                pass
    try:
        fd = os.open(str(LOCK), os.O_CREAT | os.O_EXCL | os.O_WRONLY)
    except FileExistsError:
        print("[corps] 单实例: 锁被并发抢占, 本实例让位退出", flush=True)
        return False
    with os.fdopen(fd, "w", encoding="utf-8") as f:
        f.write(str(os.getpid()))
    return True


def account_dispatched_today(email: str) -> bool:
    led = _load_ledger()
    return led["dispatched"].get(email, 0) >= DAILY_PER_ACCOUNT


# ---------------------------------------------------------------- 主题分配
def next_assignment(tree: dict) -> tuple:
    """→ (topic, round). 优先 v1 pending (规划层); 之后 v2 子问题 collect."""
    pend = [t for t in tree["topics"] if t["status"] == "pending"]
    if pend:
        return pend[0], 0
    return min(tree["topics"], key=lambda x: x.get("rounds", 0)), 1


def _hungry_ids() -> set:
    """0925 饱和门饥饿问 id 集 (zero/单源 子问题) — 军团定向优先队列."""
    try:
        sat = json.loads(SAT_OUT.read_text(encoding="utf-8"))
        return {h["id"] for h in sat.get("hungry", [])}
    except Exception:
        return set()


def _next_question(tree2: dict) -> dict | None:
    """v2 问库取下一个 pending 子问题 (生成时已按维度轮转, 取首个即散).
    0925 饥饿优先: 证据零/单源的子问题先派 (PRIMARY 瘸腿定向补采 —
    军团是最高产能泵, 511 企业专属问里 158 饥饿问先吃额度)."""
    hungry = _hungry_ids()
    first_pending = None
    for tp in tree2["topics"]:
        for q in tp["questions"]:
            if q["status"] != "pending":
                continue
            if first_pending is None:
                first_pending = q
            if q["id"] in hungry:
                return q
    return first_pending


def _next_survey_seed() -> dict | None:
    """0924 用户令: 问题树也交给 Manus 生成 — 取下一个 pending 种子."""
    if not SURVEY_SEEDS.is_file():
        return None
    seeds = json.loads(SURVEY_SEEDS.read_text(encoding="utf-8"))
    for s in seeds["seeds"]:
        if s["status"] == "pending":
            return s
    return None


def _dispatch_seed(page, email: str, tree: dict, seed: dict) -> str | None:
    """派发一条 survey_plan 种子 (Manus 生成问题树), 成功回 sid."""
    try:
        sid, _hits = lib.send_task(page, lib.build_prompt(
            "survey_plan", seed["scope"],
            f"聚焦{tree['company']}（{tree['short']}），{seed['angle']}，"
            f"问题要具体、可检索、按主题分组，并标注每题建议来源渠道"))
    except Exception as e:
        print(f"[corps] seed send_task EXC {email} {type(e).__name__}: "
              f"{str(e)[:60]}", flush=True)
        return None
    if not sid:
        print(f"[corps] seed send_task 无 sid {email}", flush=True)
        return None
    led = _load_ledger()
    led["dispatched"][email] = led["dispatched"].get(email, 0) + 1
    _save_ledger(led)
    seeds = json.loads(SURVEY_SEEDS.read_text(encoding="utf-8"))
    for s in seeds["seeds"]:
        if s["id"] == seed["id"]:
            s["status"] = "dispatched"
            s["sid"] = sid
            s["account"] = email
    _atomic_write_json(SURVEY_SEEDS, seeds)
    with CORPS_LOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps({
            "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "email": email,
            "sid": sid, "topic": seed["id"], "round": "survey",
            "q": None, "title": seed["scope"][:60],
            "use": "survey_plan"}, ensure_ascii=False) + "\n")
    print(f"[corps] ✓ {seed['id']} survey {email} → {sid}", flush=True)
    return sid


def _prompt_for(tree: dict, topic: dict, rnd: int,
                question: dict | None = None) -> str:
    """第 0 轮 = 主题树规划 (盘家底); 第 1+ 轮 = v2 子问题 collect."""
    if rnd == 0 or question is None:
        pick = topic["queries"][:3]
        use = topic["manus_use"] if rnd == 0 else "collect"
        return lib.build_prompt(use, f"{topic['title']}（{tree['company']}）",
                                "; ".join(pick))
    return lib.build_prompt(
        "collect", f"{question['text']}",
        f"聚焦{tree['company']}（{tree['short']}），优先一手与权威来源，"
        f"数据注明出处与年份")


def available_credits(page, email: str = "") -> int | None:
    """现役账号可用积分 (GetAvailableCredits); 查不到返回 None.

    0925 夜修: 优先用 login() 刚落盘的 token 文件 (页面静默时二次
    capture_token 常失败 → None 误重置低积分连击); 浏览器活捕仅兜底.
    """
    tok = None
    if email:
        try:
            tok = api.load_token(email)   # login() 刚固化的 token 文件
        except Exception:
            tok = None
    if not tok:
        try:
            tok = api.capture_token(page)
        except Exception:
            return None
    try:
        st, text = api.api_call(
            None, "POST", "/user.v1.UserService/GetAvailableCredits",
            tok, body={})
        if st == 200:
            return int(json.loads(text).get("totalCredits", -1))
    except Exception:
        pass
    return None


# ---------------------------------------------------------------- 派发
def dispatch_on_page(page, email: str) -> str | None:
    """在已登录该账号的页面上派发一个任务 (bootcamp 挂钩/独立轮共用).
    遵守日限额账本; 成功回 sid, 跳过/失败回 None. 全留痕.
    """
    if account_dispatched_today(email):
        return None
    # 回主界面再开新单: 发完上单 URL 停在 /app/<sid>, 不回去会把
    # 提示词喂给正在跑的任务 (chat 输入框) 而不是新建任务
    try:
        if "/app/" in (page.url or ""):
            page.get("https://manus.im/")
            time.sleep(3)
    except Exception:
        pass
    tree = json.loads(TREE.read_text(encoding="utf-8"))
    seed = _next_survey_seed()  # 0924 用户令: 问题树生成优先外包给 Manus
    if seed is not None:
        return _dispatch_seed(page, email, tree, seed)
    topic, rnd = next_assignment(tree)
    question = None
    if rnd >= 1 and TREE2.is_file():
        tree2 = json.loads(TREE2.read_text(encoding="utf-8"))
        question = _next_question(tree2)
    try:
        sid, _hits = lib.send_task(
            page, _prompt_for(tree, topic, rnd, question))
    except Exception as e:
        print(f"[corps] send_task EXC {email} {type(e).__name__}: "
              f"{str(e)[:60]}", flush=True)
        return None
    if not sid:
        print(f"[corps] send_task 无 sid {email}", flush=True)
        return None
    led = _load_ledger()
    led["dispatched"][email] = led["dispatched"].get(email, 0) + 1
    _save_ledger(led)
    if question is not None:
        question["status"] = "dispatched"
        question["sid"] = sid
        question["account"] = email
        _atomic_write_json(TREE2, tree2)
    else:
        topic["status"] = "dispatched"
        topic["rounds"] = rnd + 1
        topic["last_sid"] = sid
        topic["last_account"] = email
        _atomic_write_json(TREE, tree)
    with CORPS_LOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps({
            "ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "email": email,
            "sid": sid, "topic": topic["id"], "round": rnd,
            "q": question["id"] if question else None,
            "title": (question["text"][:60] if question
                      else topic["title"]),
            "use": topic["manus_use"] if rnd == 0 else "collect"},
            ensure_ascii=False) + "\n")
    print(f"[corps] ✓ {topic['id']} r{rnd} {email} → {sid}", flush=True)
    return sid


def token_accounts() -> list:
    return sorted(Path("data/tokens").glob("*.json"))


def main() -> int:
    """独立浏览器轮: 对 token 账号逐个登录+派发 (bootcamp 收工后跑)."""
    ap = argparse.ArgumentParser()
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--all", action="store_true",
                    help="0924 用户令: 主名单全账号上阵 (含无 token 现场登录)")
    ap.add_argument("--skip-healthcheck", action="store_true",
                    help="调试: 跳过启动前节点体检")
    args = ap.parse_args()

    # 0926 双军团竞态根修: corps 级单实例 (在浏览器体检前, 让位者零成本退出)
    if not _acquire_corps_lock():
        return 0
    atexit.register(lambda: LOCK.unlink(missing_ok=True))

    # 0926 用户令固化 (永远不要忘记): mode=rule ≠ 节点可用. 区域墙在
    # Manus 服务端按出口 IP 点名, curl 200 只证 Clash 链路通 — 昨晨实锤:
    # rule+200 拉起 fill → 267 账号白磨 login-None. 浏览器级 probe 验
    # 登录页 #email 才算节点活; 死则自动轮换, 全灭 exit 3 (登录墙语义).
    if not args.skip_healthcheck:
        try:
            r = subprocess.run(
                [sys.executable, str(Path(__file__).parent / "probe_nodes.py")],
                cwd=str(Path(__file__).parent), capture_output=True,
                text=True, encoding="utf-8", errors="replace", timeout=900)
            if "命中节点" not in (r.stdout or ""):
                print("[corps] ✗ 节点体检失败: probe 全灭, 拒绝白磨 "
                      "(fill 收官登录墙语义 → guard 冷却重试)")
                return 3
            print("[corps] ✓ 节点体检通过 (浏览器级验证)")
        except FileNotFoundError:
            print("[corps] ⚠ probe_nodes 缺失, 跳过体检继续")
        except subprocess.TimeoutExpired:
            print("[corps] ✗ 节点体检超时 (probe 900s), exit 3")
            return 3

    creds = dict(lib.load_accounts("Manus账号（全部）260922_干净版.txt"))
    if args.all:
        low_map = _low_today()
        todo = [e for e in creds
                if e not in EXCLUDE_EMAILS
                and not account_dispatched_today(e)
                and e not in low_map]
    else:
        accounts = token_accounts()
        todo = [a.stem.replace("_at_", "@") for a in accounts
                if not account_dispatched_today(a.stem.replace("_at_", "@"))]
    if args.limit:
        todo = todo[:args.limit]
    print(f"[corps] {'全名单' if args.all else 'token'} {len(creds)} 账号 "
          f"| 今日待派 {len(todo)}", flush=True)
    if not todo:
        return 0
    page = lib.make_page()
    lib.ensure_network(page)
    sent = failed = low = 0
    low_streak = 0
    login_fail_streak = 0   # 0925 修: 账号安全四件套之冷却 — 连续登录失败
    LOGIN_FAIL_CAP = 5      # 停批 (00:1x 登录墙 10 连败空磨实锤, corps 主
                            # 循环此前漏接 CircuitBreaker, 只 bootcamp 路有)
    quota_dead = False
    try:
        for i, email in enumerate(todo, 1):
            try:
                sess = lib.ensure_login(page, email, creds.get(email, ""))
                if sess is None:
                    raise RuntimeError("login-None")
                login_fail_streak = 0
                credits = available_credits(page, email)  # 派发前积分预检
                if credits is None:
                    # 查不到 ≠ 有积分: 不重置连击 (0925 修: None 曾把
                    # 15 连击清零致整夜空磨), 也不盲派 — 跳过并短歇
                    print(f"[{i}/{len(todo)}] ? {email} credits 查不到,"
                          f" 跳过本单", flush=True)
                    time.sleep(random.uniform(8, 15))
                    continue
                if credits < MIN_CREDITS:
                    low += 1
                    low_streak += 1
                    _mark_low(email, credits)
                    print(f"[{i}/{len(todo)}] ⏭ {email} credits={credits}"
                          f" 不足, 跳过 (不烧派发)", flush=True)
                    if low_streak >= LOW_STREAK_CAP:
                        quota_dead = True
                        print(f"[corps] 军团额度尽: 连续{low_streak}账号"
                              f"积分不足, 提前停 (08:00刷新, guard 自动重开)",
                              flush=True)
                        break
                    time.sleep(random.uniform(20, 40))
                    continue
                low_streak = 0
                sid = dispatch_on_page(page, email)
                if sid:
                    sent += 1
                else:
                    failed += 1
            except Exception as e:
                failed += 1
                is_login_fail = "login" in str(e)
                if is_login_fail:
                    login_fail_streak += 1
                print(f"[{i}/{len(todo)}] ✗ {email} {type(e).__name__}: "
                      f"{str(e)[:50]}", flush=True)
                if login_fail_streak >= LOGIN_FAIL_CAP:
                    print(f"[corps] 登录墙: 连续{login_fail_streak}账号登录"
                          f"失败, 停批冷却 (账号安全四件套)", flush=True)
                    break
            time.sleep(random.uniform(20, 40))
    finally:
        try:
            page.quit()
        except Exception:
            pass
    print(f"[corps 收] 发出 {sent} | 失败 {failed} | credits不足 {low}"
          + (" | 军团额度尽" if quota_dead else ""), flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
