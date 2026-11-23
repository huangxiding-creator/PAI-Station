# -*- coding: utf-8 -*-
"""kb_chain_watch.py — P0→P1 自动接力链（1123）。
等 kb_dedupe_safe.py 退出 → 回收站清空（A1，用户令）→ 配额实测 →
kb_build update（379 挂载位补完，50GiB 闸门）→ index → kb_engine_data（C1/C2 数据面）。
日志 _kb_build/chain_watch.log；任何一步失败不阻断下一步（update 闸门自带保护）。"""
import sys, os, time, subprocess, datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
LOG = os.path.join(HERE, "_kb_build", "chain_watch.log")
DEDUPE_PID = int(sys.argv[1]) if len(sys.argv) > 1 else None
BATCH = 300          # 回收站清空批大小（分批防超限）
DEADLINE_H = 8       # 最长等 8 小时


def log(m):
    line = f"[{datetime.datetime.now():%m-%d %H:%M:%S}] {m}"
    print(line, flush=True)
    with open(LOG, "a", encoding="utf-8") as f:
        f.write(line + "\n")


def pid_alive(pid):
    if not pid:
        return False
    try:
        out = subprocess.run(["tasklist", "/FI", f"PID eq {pid}"], capture_output=True,
                             text=True, encoding="utf-8", errors="replace").stdout
        return str(pid) in out
    except Exception:
        return False


def run(cmd, timeout=3600, show_last=6):
    log("$ " + " ".join(os.path.basename(c) if os.sep in str(c) else str(c) for c in cmd[:3]))
    p = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", cwd=HERE, timeout=timeout)
    out = (p.stdout or "").strip()
    err = (p.stderr or "").strip()
    tail = out[-1500:] if out else ""
    if tail:
        log("  " + tail.replace("\n", "\n  ")[:1500])
    if err:
        log("  [stderr] " + err[-500:])
    log(f"  exit={p.returncode}")
    return p.returncode, out


def recycle_clear():
    """清空回收站：整箱 clear 循环到空（服务端异步，可能需多轮）。"""
    import json
    sys.path.insert(0, HERE)
    from bdncore import BdnApi, BdnSession, RoutedApi, BdnApiError
    api = RoutedApi(BdnApi(BdnSession()))
    rounds = 0
    while rounds < 60:
        try:
            r = api.recycle_list(page=1, num=1)
            entries = r.get("entries") or []
            total = r.get("total") or len(entries)
            if not entries and not total:
                log(f"回收站已空（轮 {rounds}）")
                return True
            api.recycle_clear()
            rounds += 1
            log(f"  清箱轮 {rounds}（清前剩余≈{total}）")
            time.sleep(5)
        except BdnApiError as ex:
            log(f"  清箱失败 errno={ex.errno}，冷却 15s 重试")
            time.sleep(15)
        except Exception as ex:
            log(f"  清箱异常 {str(ex)[:80]}，冷却 15s")
            time.sleep(15)
    return False


def main():
    log(f"接力链启动（dedupe pid={DEDUPE_PID}，最长等 {DEADLINE_H}h）")
    t0 = time.time()
    while pid_alive(DEDUPE_PID) and (time.time() - t0) < DEADLINE_H * 3600:
        time.sleep(120)
    log(f"dedupe 结束等待（存活={pid_alive(DEDUPE_PID) if DEDUPE_PID else False}）")

    # 1) 回收站清空
    log("── 步骤1：回收站清空（A1）──")
    recycle_clear()

    # 2) 配额实测
    log("── 步骤2：配额实测 ──")
    run([sys.executable, "-I", "bdn.py", "quota"])

    # 3) 挂载位补完（50GiB 闸门，不够会自动暂缓不出错）
    log("── 步骤3：kb_build update（379 挂载位）──")
    run([sys.executable, "-I", "kb_build.py", "update", "--reserve-gb", "50"],
        timeout=6 * 3600)

    # 4) 索引刷新上传
    log("── 步骤4：kb_build index ──")
    run([sys.executable, "-I", "kb_build.py", "index"], timeout=1800)

    # 5) 引擎数据面刷新
    log("── 步骤5：kb_engine_data ──")
    run([sys.executable, "-I", "kb_engine_data.py"])

    # 6) 电子书城检索层镜像（45 库，44 件 8MB）
    log("── 步骤6：ebook city mirror ──")
    stage = os.path.join(HERE, "_kb_build", "ebook_city")
    dst = "/超级总包知识库（动态更新）/45. 总承包电子书库/90 扩充专题库/中文电子书城_24071册检索层"
    run([sys.executable, "-I", "bdn.py", "mirror", stage, dst, "--json"], timeout=3600)

    log("接力链全部收口")


if __name__ == "__main__":
    main()
