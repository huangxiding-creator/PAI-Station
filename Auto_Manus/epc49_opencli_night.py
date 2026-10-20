# -*- coding: utf-8 -*-
"""EPC49 opencli 夜腿 — 1003 全渠道令 (19825 换防借道).

时序: 等 SouGouWeDown2 :3000 idle (kw2 22:47 起约40min) → 杀 19825 headless
msedge → 起 opencli daemon (CREATE_NO_WINDOW) → OpencliChannel 4 词变体 ×
路由表 24 站 → 杀 daemon → epc_sougo_browser_headless.cmd 幂等还原三位一体.
守则: 只按端口属主杀且验进程名; 不碰 9333/9222 (WeAIPO metaso); 还原必跑.
"""
import io
import json
import subprocess
import sys
import time
import urllib.request
from pathlib import Path
from types import SimpleNamespace

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
import epc49_topics as T  # noqa: E402

SCRIPTS = r"E:\AI-Station\ResearchFactory-Eng\engineering-research.skill\scripts"

CODE_VERSION = "v6"      # 不跑旧码铁律: 起跑必打横幅, 早验收 grep "[v6]"
# v3 (1004 白班): restore() 死锁根治 (capture_output 孙进程持管道→join 永久
#   阻塞, 实锤 47min; 改落文件+有界等待+超时不杀树) + kill_port_owner 30s
#   重试 + cmdline 截段留证 (空 cmdline=wmic 查证失败也是证据)
# v4 (1004 白班二连): cmdline_of wmic 空 → CIM 兜底 (bb-browser 孤儿 chrome
#   明带 --remote-debugging-port=19825 标记, wmic 却只回空表头 → 误拒杀)
# v5 (1004 白班三连·总根因): opencli daemon 自己就是 127.0.0.1:19825 的
#   WebSocket 服务端 — 旧版只杀 netstat 第一条属主(单栈), [::1] 侧与
#   bb-browser 换代复活属主全漏 → daemon EADDRINUSE **无声死**(无任何日志)
#   → 桥永远连不上. 总修: ①桥已在位→零换防直扫 ②杀尽全栈属主
#   ③三层拉起=桥Chromium(vbs)+daemon(输出落文件留证) ④扫描段抽函数
# v6 (1004 白班四连): save_gated 文件名只带 site 不带词 (opencli_<site>.md
#   同名**覆盖写**) — 四词共用一个 out 目录时词间互相覆盖, v5 实锤 files=8
#   实落 1 件. 修: 每词独立子目录 _opencli_night/<词>/ (入账 rglob 递归扫,
#   映射按一级目录不变, 零入账侧改动); 词内同 site 多命中覆盖属快照语义保留.
sys.path.insert(0, SCRIPTS)
sys.path.insert(0, SCRIPTS + r"\channels")

DAEMON = Path(r"C:\Users\91216\AppData\Roaming\npm\node_modules"
              r"\@jackwener\opencli\dist\src\daemon.js")
RESTORE_CMD = r"E:\AI-Station\Auto_Manus\epc_sougo_browser_headless.cmd"
BRIDGE_VBS = r"C:\Users\91216\.opencli\bridge_chrome.vbs"
WORDS = ["四川电力设计咨询", "中电建四川院", "电力设计院EPC", "输变电EPC"]
IDLE_WAIT_S = 1800          # kw2 让路窗上限: 超时明晚再扫
CREATE_NO_WINDOW = 0x08000000

BATTLE = T.BATTLE
TWO = [d for d in BATTLE.iterdir() if d.name.startswith("02")][0]


def http_json(url: str, timeout: int = 8) -> dict:
    with urllib.request.urlopen(url, timeout=timeout) as r:
        return json.loads(r.read().decode("utf-8", errors="replace"))


def port_listeners(port: int) -> list:
    r = subprocess.run(["netstat", "-ano"], capture_output=True)
    return [ln for ln in r.stdout.decode("gbk", errors="replace").splitlines()
            if f":{port}" in ln and "LISTENING" in ln]


def port_owner(port: int) -> str:
    ls = port_listeners(port)
    return ls[0].split()[-1] if ls else ""


def proc_name(pid: str) -> str:
    r = subprocess.run(["tasklist", "/fi", f"PID eq {pid}"],
                       capture_output=True)
    for ln in r.stdout.decode("gbk", errors="replace").splitlines():
        parts = ln.split()
        # tasklist 列序: 名称 PID 会话名 会话# 内存 — 末列是内存("K")非 PID,
        # 须按第2列(索引1)对 pid, 否则永不命中→拒杀换防
        if len(parts) >= 2 and parts[1] == pid:
            return parts[0].lower()
    return ""


def cmdline_of(pid: str) -> str:
    """进程命令行 (自动化标记判定的根据).

    v4: wmic 对部分进程 (bb-browser 孤儿 chrome 等) 只回空表头
    ('\r\r\n\r\r\n', 1004 白班两连实锤) → 空被误判「非我方」拒杀.
    空=查证失败≠非我方, 必须走 PowerShell CIM 兜底再判."""
    r = subprocess.run(["wmic", "process", f"where processid={pid}",
                        "get", "commandline"], capture_output=True)
    cl = r.stdout.decode("gbk", errors="replace")
    body = "".join(cl.splitlines()[1:]).strip()      # 去表头看正文
    if body:
        return body.lower()
    ps = ("(Get-CimInstance Win32_Process -Filter "
          f"'ProcessId={pid}').CommandLine")
    r2 = subprocess.run(["powershell", "-NoProfile", "-Command", ps],
                        capture_output=True, timeout=30)
    return r2.stdout.decode("gbk", errors="replace").lower()


def is_our_automation_browser(pid: str, name: str) -> bool:
    """我方自动化浏览器判据 (1004 换主拒杀根修).

    1003 夜实锤: 19825 属主是 chrome.exe (搜狗腿自起实例) 而非预期
    msedge → 按进程名一刀切拒杀 → 整腿空转. 真判据看命令行:
    --headless / --remote-debugging-port=19825 / bb_profile_headless
    任一命中 = 我方无人值守实例 (chrome/msedge 皆是), 杀之安全;
    全不命中 = 用户桌面浏览器, 维持拒杀.
    v3: 未命中时打印 cmdline 截段留证 (空 cmdline=wmic 失败也是证据),
        供事后判「真用户浏览器」还是「查证失败误拒」.
    """
    cl = cmdline_of(pid)
    ours = any(m in cl for m in ("--headless", "19825",
                                 "bb_profile_headless"))
    if ours:
        print(f"[swap] {name} pid={pid} 命中我方自动化标记 (cmdline), "
              f"准杀", flush=True)
    else:
        print(f"[swap] {name} pid={pid} cmdline 无自动化标记: "
              f"{cl[:160]!r}", flush=True)
    return ours


def kill_all_port_owners(port: int, expect: str) -> bool:
    """杀尽 :port 全部 LISTENING 属主 (v5 双栈漏杀根修).

    旧版只杀 netstat 第一条 — [::1] 侧 msedge 与 bb-browser 换代复活的
    IPv4 chrome 全漏 → opencli daemon EADDRINUSE 无声死 (v5 总根因).
    每个属主单独过自动化标记门, 有一个拒杀即整体失败 (安全优先)."""
    for _ in range(3):
        pids = {ln.split()[-1] for ln in port_listeners(port)}
        if not pids:
            return True
        for pid in sorted(pids):
            name = proc_name(pid)
            if expect in name or is_our_automation_browser(pid, name):
                subprocess.run(["taskkill", "/f", "/pid", pid],
                               capture_output=True)
                print(f"[swap] 已杀 {name} pid={pid} (:{port})", flush=True)
            else:
                print(f"[swap] :{port} 属主 {pid}({name}) 非我方实例, 拒杀",
                      flush=True)
                return False
        time.sleep(2)                     # 等换代复活者再露头
    return not port_listeners(port)


def kill_sogou_service() -> None:
    """杀 :3000 服务属主 (captcha 死锁解卡, 与 sougo 腿同配方)."""
    pid = port_owner(3000)
    if pid:
        subprocess.run(["taskkill", "/f", "/pid", pid], capture_output=True)
        print(f"[wait] 已杀 :3000 服务属主 pid={pid} (死锁解卡)", flush=True)


def wait_sogou_idle(deadline_s: int) -> bool:
    """等搜狗 idle — 1004 增死锁探测.

    1003 夜实锤: 词8 验证码把服务 isRunning 卡 true (waitForCaptcha 只认
    手动按钮) → 本腿「搜狗在跑 phase=None 续等」陪挂 3h. 判据升级:
    running=true 且 phase ∈ (None,'captcha','') 连续 ≥10 次 (~5min)
    = 死锁非真忙 → 杀服务属主放行 (19825 上的浏览器随后换防接管).
    """
    t0 = time.time()
    n_stuck = 0
    while time.time() - t0 < deadline_s:
        try:
            st = http_json("http://127.0.0.1:3000/api/status")
        except Exception:  # noqa: BLE001  服务不在=更没人占 19825
            print("[wait] :3000 不可达, 视为 idle", flush=True)
            return True
        if not st.get("running"):
            print("[wait] 搜狗 idle", flush=True)
            return True
        ph = st.get("phase") or (st.get("progress", {}) or {}).get("phase")
        if ph in (None, "", "captcha"):
            n_stuck += 1
            if n_stuck >= 10:
                print(f"[wait] running=true 但 phase={ph!r} 持续 ~5min "
                      f"= captcha 死锁非真忙, 杀服务放行", flush=True)
                kill_sogou_service()
                return True
        else:
            n_stuck = 0
        print(f"[wait] 搜狗在跑 phase={ph} 续等", flush=True)
        time.sleep(30)
    print("[wait] 超时仍在跑, 放弃本轮 (浏览器让路优先)", flush=True)
    return False


def restore() -> None:
    """还原: msedge@19825 + SouGouWeDown2 服务 + bb-browser daemon 三位一体.

    v3 死锁根治 (1004 白班实锤 47min): capture_output 的 reader 线程会被
    还原 cmd 派生的孙进程 (服务本体) 持有的管道句柄永久阻塞 — timeout 杀掉
    直接子进程也救不回 join. 改 stdout 落文件 + 有界等待; 超时不杀树
    (服务可能还在拉起), 记日志放行."""
    log_f = Path(__file__).parent / "data" / "restore_headless.out"
    log_f.parent.mkdir(parents=True, exist_ok=True)
    with open(log_f, "ab") as fh:
        p = subprocess.Popen(["cmd", "/c", RESTORE_CMD], stdout=fh,
                             stderr=subprocess.STDOUT,
                             creationflags=CREATE_NO_WINDOW)
        try:
            p.wait(timeout=180)
            print(f"[restore] headless.cmd exit={p.returncode}", flush=True)
        except subprocess.TimeoutExpired:
            print(f"[restore] headless.cmd 180s 未退 (服务孙进程在拉起), "
                  f"放行不杀树, 输出→ {log_f.name}", flush=True)


def main() -> int:
    print(f"[{CODE_VERSION}] opencli 夜腿启动 {time.strftime('%F %T')}",
          flush=True)
    # 1004 夜班扩容: 显式锁 — 04:20 搜狗二班据此等待, 不抢 19825
    import os
    lock = Path(__file__).parent / "data" / "epc49_opencli.lock"
    lock.parent.mkdir(parents=True, exist_ok=True)
    lock.write_text(str(os.getpid()))
    try:
        return _run()
    finally:
        lock.unlink(missing_ok=True)


def _scan() -> int:
    from channels import get_channel
    cfg = SimpleNamespace(domain_dir=BATTLE, research_target=T.COMPANY)
    ch = get_channel("opencli", cfg)
    for w in WORDS:
        # v6: 每词独立子目录 — save_gated 同名覆盖写 (opencli_<site>.md),
        # 共用一个 out 目录时后词覆盖前词 (v5 实锤 files=8 实落 1)
        out = TWO / "_opencli_night" / w
        out.mkdir(parents=True, exist_ok=True)
        r = ch.collect([{"keywords": {"opencli": w},
                         "dimension_name": "opencli_night",
                         "expected_channels": ["opencli"]}], out)
        print(f"[scan] {w}: ok={r.success} files={len(r.files_collected)} "
              f"err={r.error}", flush=True)
        time.sleep(10)  # 词间礼貌间隔
    return 0


def _run() -> int:
    import opencli_bridge as ob
    # v5 快路径: 桥已在位 (daemon@19825 + 扩展桥 Chromium 常驻态) →
    # 零换防直扫, 不碰搜狗栈, 不还原 (常驻态本来就该留着)
    if ob.bridge_available():
        print("[swap] 桥已在位, 零换防直扫", flush=True)
        return _scan()
    if not wait_sogou_idle(IDLE_WAIT_S):
        return 2
    if not kill_all_port_owners(19825, "msedge"):
        restore()
        return 3
    time.sleep(2)

    # v5 三层拉起: 桥 Chromium(扩展, vbs 幂等跳过已在跑) + daemon(ws 服务端
    # @19825, 输出落文件 — EADDRINUSE 无声死从此有尸检证据)
    subprocess.run(["wscript", BRIDGE_VBS], capture_output=True)
    dlog = open(Path(__file__).parent / "data" / "opencli_daemon.log", "ab")
    daemon = subprocess.Popen(["node", str(DAEMON)], stdout=dlog,
                              stderr=subprocess.STDOUT,
                              creationflags=CREATE_NO_WINDOW)
    print(f"[swap] 桥Chromium(vbs) + opencli daemon pid={daemon.pid}", flush=True)
    try:
        ok = False
        for _ in range(30):
            time.sleep(2)
            if ob.bridge_available():
                ok = True
                break
        if not ok:
            print("[scan] 桥 60s 未连上, 跳过扫描直接还原", flush=True)
            return 0
        return _scan()
    finally:
        subprocess.run(["taskkill", "/f", "/pid", str(daemon.pid)],
                       capture_output=True)
        for _ in range(10):
            if not port_owner(19825):
                break
            time.sleep(2)
        restore()


if __name__ == "__main__":
    raise SystemExit(main())
