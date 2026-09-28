# -*- coding: utf-8 -*-
"""EPC50 让路守护 — 用户令 09-24: 本项目 24h 全天候运行, 唯一避开自媒永动机.

判据 (复用 EPC100 工厂同款): WeAIPO 心跳文件 10 分钟内更新 = 引擎在线.
  忙 → 收线让路: 停军团派发链 (bash fill 循环+python corps+9333 浏览器)
       + 切回国内直连. 轻腿照常 (收割 api 直连轮询/weread 夜提取/cnki
       国内线/sougo 服务闲置态) — 同 EPC100「NB让路 pre-NB照常」.
  闲 → 自动开窗: rule (登记 changelog) + probe_nodes 浏览器级节点验证
       (判 stdout「命中节点」, probe 退出码恒0不可信) + fill 全账号 collect;
       fill 收官 (待派0/发出0) → 标记 quota_done 至下一 08:05 (积分刷新),
       切回 direct. 心跳再来 → 再让路, 循环往复.

防互踩 (H6 教训):
  - 外部把 mode 切 direct 而 fill 在跑 → 杀孤儿军团 + 冷却 60min 不开窗
    (尊重用户/推送脚本的手动切网).
  - 状态落 data/yield_guard_state.json 供外部观测.
统一替代: yield_1500 / morning_blitz / netback watch 三器 (单一调度源).
"""
import datetime as dt
import io
import json
import os
import re
import subprocess
import sys
import time
import urllib.request as u
from pathlib import Path

ROOT = Path(__file__).parent
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"
BASH = r"C:\Program Files\Git\bin\bash.exe"
WEAIPO_HEARTBEAT = Path(r"E:\CPOPC\We-AIPO\data\state\production_heartbeat")
WEAIPO_STALE_S = 600
STATE = ROOT / "data" / "yield_guard_state.json"
CORPS_LOCK = ROOT / "data" / "epc50_corps.lock"   # 0926: corps 原子锁 (真值源)
CHANGELOG = Path(r"E:\AI-Station\data\state\network_changelog.jsonl")
FILL_LOG = Path("/tmp/epc50_corps_fill_guard.log")
TICK = 600  # 0928 用户令: 检查间隔 300→600s (fill 重拉链降频)
CLASH_SECRET = "d42f2047-3a9e-45a1-9e1c-b6a91441588f"
# 已知口 + 动态发现: controller 口已三漂 (20225→40233→15198), 硬编码必失明 (H11)
PORTS = (15198, 20225, 40233, 29069, 11845)


def _discover_controller_ports() -> list[int]:
    """7890 监听进程的 127.0.0.1 回环监听口 = controller 候选 (口漂移自愈)."""
    try:
        out = subprocess.check_output(["netstat", "-ano"], timeout=15,
                                      text=True, errors="replace")
        pid = next((ln.split()[-1] for ln in out.splitlines()
                    if "LISTENING" in ln and ":7890 " in ln), None)
        if not pid:
            return []
        cands = []
        for ln in out.splitlines():
            f = ln.split()
            if (len(f) >= 5 and f[3] == "LISTENING" and f[-1] == pid
                    and f[1].startswith("127.0.0.1:")):
                cands.append(int(f[1].rsplit(":", 1)[1]))
        return cands
    except Exception:
        return []


# ---------------------------------------------------------------- 探测
def weaipo_busy() -> bool:
    try:
        return time.time() - WEAIPO_HEARTBEAT.stat().st_mtime < WEAIPO_STALE_S
    except FileNotFoundError:
        return False   # 无心跳文件 = 引擎未部署/未跑
    except Exception:
        return True    # 探测异常 = 保守视为忙


def _pids_matching(pattern: str, only_python: bool) -> list[str] | None:
    """按命令行特征查 PID (只查我们自己的标记, 绝不匹配用户进程).

    None = 查询失败 (超时/PowerShell 异常), 调用方须保守处理 —
    0925 实锤: 异常假阴性 → guard 误判军团已死 → 重复拉 fill →
    双 python 共享 9333 互踩. 宁可漏判死, 不可误判活.
    """
    filt = "Name like 'python%'" if only_python else "Name like '%'"
    try:
        out = subprocess.check_output(
            ["powershell", "-NoProfile", "-Command",
             f"Get-CimInstance Win32_Process -Filter \"{filt}\" | "
             f"Where-Object {{$_.CommandLine -match '{pattern}'}} | "
             f"Select -ExpandProperty ProcessId"],
            timeout=60, text=True)
        return [x.strip() for x in out.strip().splitlines()
                if x.strip().isdigit()]
    except Exception:
        return None


def _tasklist_alive(pid: int) -> bool:
    """tasklist 探活 — 不走 CIM (命令行查询间歇空回是 0926 连环事故根因)."""
    try:
        r = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"],
                           capture_output=True, text=True, timeout=20)
        return bool(re.search(rf"^\S+\s+{pid}\s", r.stdout or "",
                              re.MULTILINE))
    except Exception:
        return True   # 查不清 = 保守视为活


def corps_running() -> bool:
    """0926 v2: 优先信 corps 原子锁 (O_EXCL 抢占 + Win32 pid + atexit
    释放). CIM 命令行查询 10:27 实锤间歇空回: 活军团被判停 → dormant
    分支 --force 切 direct → 军团断网暴毙 → 下轮 running=True+direct
    反被当孤儿屠杀 (09:37 屠杀同源). 锁在+pid活 = 铁证在跑; 无锁/死锁
    退回原 CIM 查询 (None=保守活)."""
    try:
        pid = int(CORPS_LOCK.read_text(encoding="utf-8").strip())
        if pid and _tasklist_alive(pid):
            return True
    except (OSError, ValueError):
        pass
    pids = _pids_matching("epc50_corps", only_python=True)
    return True if pids is None else bool(pids)   # 未知=保守视为活


def kill_heavy() -> list[str]:
    """忙时收线: fill bash 循环 + corps python + metaso + 9333 浏览器."""
    killed = []
    # bash/sh 包装循环必须先杀 (否则下轮 respawn python)
    for pat in ("epc50_corps_fill", "epc50_corps", "epc50_metaso"):
        for pid in (_pids_matching(pat, only_python=False) or []):
            subprocess.run(["taskkill", "/F", "/PID", pid],
                           capture_output=True, timeout=15)
            killed.append(f"{pat}:{pid}")
    for pid in (_pids_matching("9333", only_python=False) or []):
        # 浏览器进程名 chrome/msedge 才杀 (命令行含 9333 的其他进程不动)
        try:
            name = subprocess.check_output(
                ["powershell", "-NoProfile", "-Command",
                 f"(Get-CimInstance Win32_Process -Filter "
                 f"\"ProcessId={pid}\").Name"], timeout=15, text=True).strip()
            if name.lower().startswith(("chrome", "msedge")):
                subprocess.run(["taskkill", "/F", "/PID", pid],
                               capture_output=True, timeout=15)
                killed.append(f"browser9333:{pid}")
        except Exception:
            pass
    return killed


# ---------------------------------------------------------------- 网络
def clash_base() -> str | None:
    hdr = {"Authorization": "Bearer " + CLASH_SECRET}
    for p in tuple(PORTS) + tuple(_discover_controller_ports()):
        base = f"http://127.0.0.1:{p}"
        try:
            u.urlopen(u.Request(base + "/version", headers=hdr),
                      timeout=2).read()
            return base
        except Exception:
            continue
    return None


def get_mode(base: str) -> str:
    hdr = {"Authorization": "Bearer " + CLASH_SECRET}
    d = json.loads(u.urlopen(u.Request(base + "/configs", headers=hdr),
                             timeout=4).read())
    return d.get("mode", "?")


def set_mode(base: str, mode: str) -> None:
    hdr = {"Authorization": "Bearer " + CLASH_SECRET,
           "Content-Type": "application/json"}
    u.urlopen(u.Request(base + "/configs",
                        data=json.dumps({"mode": mode}).encode(),
                        method="PATCH", headers=hdr), timeout=4).read()


def log_change(frm: str, to: str, reason: str) -> None:
    CHANGELOG.parent.mkdir(parents=True, exist_ok=True)
    rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "actor": "epc50-guard",
           "action": "mode", "from": frm, "to": to, "reason": reason,
           "verify": "pending"}
    with CHANGELOG.open("a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


# ---------------------------------------------------------------- 军团
def node_verified() -> bool:
    """浏览器级节点验证. probe_nodes 退出码恒 0 → 判 stdout 命中标记."""
    try:
        r = subprocess.run([PY311, str(ROOT / "probe_nodes.py")],
                           cwd=str(ROOT), capture_output=True, text=True,
                           encoding="utf-8", errors="replace", timeout=1800)
        return "命中节点" in (r.stdout or "")
    except Exception:
        return False


def start_fill() -> None:
    FILL_LOG.parent.mkdir(parents=True, exist_ok=True)
    subprocess.Popen(
        [BASH, str(ROOT / "epc50_corps_fill.sh")],
        cwd=str(ROOT),
        stdout=open(FILL_LOG, "ab"),
        stderr=subprocess.STDOUT,
        creationflags=0x08000000)   # CREATE_NO_WINDOW


def _last_finale_line() -> str:
    """fill 日志 tail-40 里最后一条收官行 (无则空串)."""
    try:
        lines = FILL_LOG.read_text(encoding="utf-8",
                                   errors="replace").splitlines()[-40:]
        fin = [ln for ln in lines if "收官" in ln]
        return fin[-1] if fin else ""
    except Exception:
        return ""


def fill_done_today() -> bool:
    """今日收官行 (待派0) = 额度真用完 (quota → 08:05).

    0924 夜修: 必须带今日日期 — 旧标记无日期会永久滞留 tail-40, 次日
    08:05 过期后又被旧行误判 → 守护假休眠死循环.
    """
    last = _last_finale_line()
    return bool(last) and "待派0=1" in last \
        and time.strftime("%Y-%m-%d") in last


def fill_loginwall() -> bool:
    """今日收官(登录墙 发出=0) = 有账号发不出 ≠ 额度尽 → 冷却后重试."""
    last = _last_finale_line()
    return bool(last) and "登录墙" in last \
        and time.strftime("%Y-%m-%d") in last


def next_0805(now: float) -> float:
    """下一个 08:05 (积分刷新后) 的时间戳."""
    t = dt.datetime.fromtimestamp(now)
    tgt = t.replace(hour=8, minute=5, second=0, microsecond=0)
    if t >= tgt:
        tgt += dt.timedelta(days=1)
    return tgt.timestamp()


def save_state(d: dict) -> None:
    STATE.parent.mkdir(parents=True, exist_ok=True)
    STATE.write_text(json.dumps(d, ensure_ascii=False, indent=1),
                     encoding="utf-8")


def load_state() -> dict:
    try:
        return json.loads(STATE.read_text(encoding="utf-8"))
    except Exception:
        return {}


# ---------------------------------------------------------------- 主循环
PID_FILE = ROOT / "data" / "yield_guard.pid"


def pid_is_guard(pid: int) -> bool:
    """pid 活着且宿主是 python 系 → 视为守护在役 (PID 闸, H6 双启防护)."""
    import ctypes
    k = ctypes.windll.kernel32
    h = k.OpenProcess(0x1000, False, pid)   # QUERY_LIMITED_INFORMATION
    if not h:
        return False
    try:
        buf = ctypes.create_unicode_buffer(512)
        n = ctypes.c_uint32(512)
        if not k.QueryFullProcessImageNameW(h, 0, buf, ctypes.byref(n)):
            return False
        return "python" in buf.value.lower()
    finally:
        k.CloseHandle(h)


def claim_or_exit() -> None:
    """PID 闸: 已有活的守护 (keeper/手动竞态) → 本实例立即退, 不双写."""
    try:
        old = int(PID_FILE.read_text().strip())
        if old != os.getpid() and pid_is_guard(old):
            print(f"[guard] PID 闸: {old} 在役, 本实例退出 (防双启)", flush=True)
            sys.exit(0)
    except (FileNotFoundError, ValueError):
        pass
    PID_FILE.parent.mkdir(parents=True, exist_ok=True)
    PID_FILE.write_text(str(os.getpid()))


def main() -> int:
    # wrap 放 main 内: 模块被 import (yield_1500 复用 kill_heavy) 时无副作用
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                                  errors="replace")
    claim_or_exit()
    HALTED = (ROOT / "data" / "MANUS_CORPS_HALTED").exists()
    st = load_state()
    last_action = st.get("last_action", "boot")
    # 0928 读侧防御: 旧 state 存过显示串 → 类型归一 (str/None → 0)
    cooldown_until = st.get("cooldown_until", 0) or 0
    if not isinstance(cooldown_until, (int, float)):
        cooldown_until = 0
    quota_done_until = st.get("quota_done_until", 0) or 0
    if not isinstance(quota_done_until, (int, float)):
        quota_done_until = 0
    fill_started_at = st.get("fill_started_at", 0) or 0
    if not isinstance(fill_started_at, (int, float)):
        fill_started_at = 0
    lw_retried = bool(st.get("lw_retried"))
    direct_streak = int(st.get("direct_streak", 0))
    while True:
        busy = weaipo_busy()
        running = corps_running()
        base = clash_base()
        mode = get_mode(base) if base else "?"
        now = time.time()
        rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
               "weaipo_busy": busy, "corps_running": running, "mode": mode,
               "last_action": last_action,
               # 0928 修: 这里曾 save 显示串 ("09-28 08:21"/"-"), 下轮恢复成
               # str 与 float now 比较炸 TypeError → 永久崩溃环. 存原始 float,
               # 显示格式化只在 print 层做.
               "quota_done_until": quota_done_until if
               quota_done_until > now else 0,
               "cooldown_until": cooldown_until if
               cooldown_until > now else 0}
        save_state(rec)
        _fmt = lambda v: dt.datetime.fromtimestamp(v).strftime(
            "%m-%d %H:%M") if v > now else "-"
        print(f"[guard] weaipo={'忙' if busy else '闲'} corps="
              f"{'跑' if running else '停'} mode={mode} "
              f"quota_done={_fmt(quota_done_until)} "
              f"cd={_fmt(cooldown_until)} last={last_action}", flush=True)
        if not base:
            time.sleep(TICK)
            continue
        try:
            if busy:
                if running or mode != "direct":
                    k = kill_heavy() if running else []
                    if mode != "direct":
                        subprocess.call(
                            [PY311, str(ROOT / "epc50_net_back_direct.py"),
                             "--force"], cwd=str(ROOT))
                    last_action = f"yielded(killed={len(k)})"
                    print(f"[guard] → 让路收线 {k or '(进程已停, 仅切网)'}",
                          flush=True)
            elif HALTED:
                # 0928 HALT 闸: 平台滚动暂停实锤, 军团链停用整改 (非弃用,
                # v3 章程+用户点头后小队重启) — 不开窗/不 probe/不拉 fill
                # (probe 也访问 manus.im, 一并禁). 让路收线 (busy 分支) 保留.
                # 0928 v3 试点: corps_v3 小队在跑 (锁活) 时它自己管网
                # (rule+节点+收官还原 direct), 本守护不抢网不误杀.
                v3_pid = 0
                try:
                    v3_pid = int((ROOT / "data" / "corps_v3.lock")
                                 .read_text(encoding="utf-8").strip())
                except (OSError, ValueError):
                    pass
                v3_alive = bool(v3_pid) and _tasklist_alive(v3_pid)
                if mode == "rule" and not v3_alive:
                    subprocess.call(
                        [PY311, str(ROOT / "epc50_net_back_direct.py"),
                         "--force"], cwd=str(ROOT))
                last_action = ("corps_v3_running(让网)"
                               if v3_alive else "corps_halted(停用整改)")
            elif running:
                if mode == "direct":
                    # 外部把网切走了: 杀孤儿防空转 (13:01 事故重演防护)
                    # 0926 根修: 须连续两拍 direct (10min) 才杀 — EPC100 NB
                    # 隧道开道时 nb_node_pick 会留数分钟 direct 瞬态, 单拍
                    # 直杀=误杀友军 (12:39 实锤 k=11, 军团靠 CIM 漏查幸免).
                    if direct_streak >= 1:
                        k = kill_heavy()
                        cooldown_until = now + 3600
                        last_action = f"killed_orphan(k={len(k)},cd1h)"
                        print(f"[guard] → 外部切 direct 连续双拍, 孤儿军团"
                              f"已停 {k} 冷却60min", flush=True)
                        direct_streak = 0
                    else:
                        direct_streak += 1
                        last_action = "direct_seen(等第二拍确认)"
                        print("[guard] → direct 首见, 下拍复核 (NB 隧道开道"
                              "瞬态防护)", flush=True)
                else:
                    direct_streak = 0
                # mode=rule/global 且在跑 = 正常, 交给 fill 自己跑完
            else:
                if now < cooldown_until or now < quota_done_until:
                    if mode == "rule":
                        subprocess.call(
                            [PY311, str(ROOT / "epc50_net_back_direct.py"),
                             "--force"], cwd=str(ROOT))
                        last_action = "window_closed(dormant)"
                    # direct 且休眠 = 正常躺平
                elif fill_done_today():
                    quota_done_until = next_0805(now)
                    if mode == "rule":
                        subprocess.call(
                            [PY311, str(ROOT / "epc50_net_back_direct.py"),
                             "--force"], cwd=str(ROOT))
                    last_action = f"quota_done(until {rec['ts'][:5]})"
                    print(f"[guard] → 今日额度收官, 休眠至 08:05", flush=True)
                elif fill_loginwall():
                    # 0924 夜修: 冷却后必须**重试** fill — 旧版每 tick 重判
                    # 同一条旧行再冷却, 永不重试 (守护假休眠一整夜实锤).
                    # lw_retried 状态: 首遇→冷却1h; 冷却满后遇→真重试.
                    if st.get("lw_retried"):
                        # 0925 区域墙滚动收紧 (港→美→新加坡逐区点名, 可用窗
                        # 45min→5min 递减) — 重试前先 probe 轮换节点, 死节点
                        # 上重试 fill = 纯白磨; 无活节点继续冷却下小时再探.
                        try:
                            r = subprocess.run(
                                [PY311, str(ROOT / "probe_nodes.py")],
                                cwd=str(ROOT), capture_output=True,
                                text=True, encoding="utf-8",
                                errors="replace", timeout=900)
                            hit = "命中节点" in (r.stdout or "")
                            print(f"[guard] 重试前 probe: "
                                  f"{'✓ 换到活节点' if hit else '✗ 全灭'}",
                                  flush=True)
                            if not hit:
                                cooldown_until = now + 3600
                                last_action = "probe_all_dead(cd1h)"
                                continue
                        except Exception as e:
                            print(f"[guard] probe 异常 {type(e).__name__} "
                                  f"(仍重试 fill)", flush=True)
                        start_fill()
                        fill_started_at = time.time()
                        last_action = "fill_retry(after_loginwall)"
                        lw_retried = False
                        print("[guard] → 登录墙冷却已满, 重试 fill", flush=True)
                    else:
                        cooldown_until = now + 3600
                        lw_retried = True
                        if mode == "rule":
                            subprocess.call(
                                [PY311, str(ROOT / "epc50_net_back_direct.py"),
                                 "--force"], cwd=str(ROOT))
                        last_action = "login_wall(cd1h,will_retry)"
                        print(f"[guard] → 登录墙收官 (非额度尽), "
                              f"冷却60min后将重试", flush=True)
                elif mode == "direct":
                    set_mode(base, "rule")
                    log_change("direct", "rule",
                               "EPC50让路守护: WeAIPO心跳老化, 闲窗开窗派发")
                    if node_verified():
                        start_fill()
                        fill_started_at = time.time()
                        last_action = "window_opened+fill_started"
                        print("[guard] → 闲窗开窗 + fill 启动", flush=True)
                    else:
                        set_mode(base, "direct")
                        log_change("rule", "direct",
                                   "EPC50让路守护: 无可用海外节点 fail-safe")
                        cooldown_until = now + 3600
                        last_action = "node_dead(cd1h)"
                        print("[guard] → 节点全灭, 收线冷却60min", flush=True)
                else:   # mode=rule 且 fill 死了 (中途崩/被杀)
                    # 0928 用户令弹窗降频: fill 秒死场景下每 tick 硬重拉
                    # = 周期性窗口/浏览器风暴 → 上次启动 <15min 内不重拉
                    if now - fill_started_at < 900:
                        last_action = "fill_backoff(15min)"
                    else:
                        start_fill()
                        fill_started_at = time.time()
                        last_action = "fill_restarted(window_alive)"
                        print("[guard] → fill 中途退出, 窗内重启", flush=True)
        except Exception as e:
            print(f"[guard] 拍异常 {type(e).__name__}: {str(e)[:60]}",
                  flush=True)
        st = {"last_action": last_action, "cooldown_until": cooldown_until,
              "quota_done_until": quota_done_until,
              "fill_started_at": fill_started_at,
              "lw_retried": lw_retried,
              "direct_streak": direct_streak,
              "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}
        save_state({**st, "weaipo_busy": busy, "corps_running": running,
                    "mode": mode})
        time.sleep(TICK)
    return 0


if __name__ == "__main__":
    sys.exit(main())
