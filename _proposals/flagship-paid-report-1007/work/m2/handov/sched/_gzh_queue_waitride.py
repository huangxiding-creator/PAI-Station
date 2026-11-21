# -*- coding: utf-8 -*-
"""_gzh_queue_waitride — 多号队列等待式投递器: 永动机活口出现即骑会话投稿.
队列: acct05[JES2之声, TAX之声] / acct01[TAX说] / acct07[TAX脑]
每号活口出现时投该号队列; 全部落箱即退出. 轮询最长8小时.
用法: py -X utf8 _gzh_queue_waitride.py
"""
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
PY = r"E:\AI-Station\.venv\Scripts\python.exe"
PUSH = r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\handov\sched\_handov_gzh_draft.py"
PROMO = r"E:\AI-Station\report_platform\promo"
POSTER = PROMO + r"\posters"

QUEUE = {
    "acct05": [
        (PROMO + r"\2026-11-20_zbzs_jes2_launch.md", "发布| 《建工司法解释二逐条实务与多立场应对实战研究报告》", POSTER + r"\JES2-2026.png"),
        (PROMO + r"\2026-11-21_zbzs_tax_launch.md", "发布| 《EPC工程税务实务与跨境税务实战研究报告》", POSTER + r"\TAX-2026.png"),
    ],
    "acct01": [
        (PROMO + r"\2026-11-21_zbshuo_tax_clause.md", "合同里一个「含」字，结算时差出一笔税", POSTER + r"\TAX-2026.png"),
    ],
    "acct07": [
        (PROMO + r"\2026-11-21_dt_tax_invoice.md", "业主说「先开票后付款」，法院支持吗？", POSTER + r"\TAX-2026.png"),
    ],
}
done = set()


def find_port(acct: str):
    try:
        out = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "(Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
             f"Where-Object {{$_.CommandLine -match 'remote-debugging-port=(\\\\d+) --user-data-dir=\"?F:\\\\We-AIPO\\\\autopub\\\\data\\\\browser_profiles\\\\{acct}\"?'}} "
             "| Select-Object -First 1).CommandLine"],
            capture_output=True, text=True, timeout=30)
        m = re.search(r"remote-debugging-port=(\d+)", out.stdout or "")
        return int(m.group(1)) if m else None
    except Exception:
        return None


def main() -> int:
    t0 = time.time()
    total = sum(len(v) for v in QUEUE.values())
    print(f"[wait] 多号队列 {total} 篇, 轮询最长8h...", flush=True)
    while time.time() - t0 < 8 * 3600 and len(done) < total:
        for acct, items in QUEUE.items():
            port = find_port(acct)
            if not port:
                continue
            for idx, (md, title, img) in enumerate(items):
                key = f"{acct}:{idx}"
                if key in done:
                    continue
                print(f"[ride] {acct}@{port} 投: {title[:30]}", flush=True)
                try:
                    r = subprocess.run(
                        [PY, "-X", "utf8", PUSH, acct, md, title, img, str(port)],
                        capture_output=True, text=True, timeout=420, encoding="utf-8", errors="replace")
                    out = (r.stdout or "") + (r.stderr or "")
                except Exception as e:
                    out = f"timeout {e}"
                for ln in out.splitlines():
                    if any(k in ln for k in ("paste", "save", "verify", "fatal")):
                        print("   ", ln[:90], flush=True)
                if "落箱验证: PASS" in out:
                    done.add(key)
                    print(f"[ok] {acct} #{idx+1} 落箱 ({len(done)}/{total})", flush=True)
                else:
                    print("[retry] 该号稍后重试", flush=True)
                    break  # 该号本轮失败, 不连投下一篇
                time.sleep(20)
        if len(done) >= total:
            break
        time.sleep(120)
    print(f"[end] 完成 {len(done)}/{total}", flush=True)
    return 0 if len(done) >= total else 1


if __name__ == "__main__":
    raise SystemExit(main())
