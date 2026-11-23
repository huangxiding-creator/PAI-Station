# -*- coding: utf-8 -*-
"""kb_cycle.py — 知识库收口循环：三扫核删 → 清箱 → 挂载位续跑 → 直到干涸。
每轮：kb_dedupe_pass3（安全核删已满挂载的源）→ recycle_clear → kb_build update
（50GiB 闸门）→ 台账计数。连续两轮 0 新增 → 收口退出（硬上限 8 轮）。"""
import sys, os, json, time, subprocess, datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
LOG = os.path.join(HERE, "_kb_build", "cycle.log")
MAX_CYCLES = 8


def log(m):
    line = f"[{datetime.datetime.now():%m-%d %H:%M:%S}] {m}"
    print(line, flush=True)
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(line + "\n")


def run(cmd, timeout):
    log("$ " + " ".join(os.path.basename(str(c)) for c in cmd[:3]))
    p = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", cwd=HERE, timeout=timeout)
    out = (p.stdout or "").strip()
    if out:
        log("  " + out[-1200:].replace("\n", "\n  "))
    if p.stderr:
        log("  [stderr] " + p.stderr[-400:])
    log(f"  exit={p.returncode}")
    return p.returncode, out


def recycle_clear():
    sys.path.insert(0, HERE)
    from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError
    api = RoutedApi(BdnApi(BdnSession()))
    for r in range(60):
        try:
            lst = api.recycle_list(page=1, num=1)
            if not (lst.get("entries") or []) and not (lst.get("total") or 0):
                log(f"  回收站已空（轮 {r}）")
                return True
            api.recycle_clear()
            log(f"  清箱轮 {r}")
            time.sleep(5)
        except Exception as ex:
            log(f"  清箱异常 {str(ex)[:80]}，冷却 15s")
            time.sleep(15)
    return False


def copied_count():
    led = [json.loads(l) for l in open(os.path.join(HERE, "_kb_build", "ledger.jsonl"), encoding="utf-8")]
    return len({(x["src"], x.get("dst_dir")) for x in led if x.get("status") == "copied"})


def main():
    log("收口循环启动")
    prev_new = -1
    for cyc in range(1, MAX_CYCLES + 1):
        log(f"═══ 轮 {cyc} ═══")
        before = copied_count()
        run([sys.executable, "-I", "kb_dedupe_pass3.py"], timeout=4 * 3600)
        recycle_clear()
        rc, out = run([sys.executable, "-I", "kb_build.py", "update", "--reserve-gb", "50"],
                      timeout=6 * 3600)
        after = copied_count()
        log(f"轮 {cyc} 收口: 挂载位 {before} → {after}（+{after-before}）")
        if after - before == 0:
            if prev_new == 0:
                log("连续两轮 0 新增 → 干涸收口")
                break
            prev_new = 0
        else:
            prev_new = after - before
        time.sleep(30)
    log(f"循环结束 · 终态挂载位 {copied_count()}/510")


if __name__ == "__main__":
    main()
