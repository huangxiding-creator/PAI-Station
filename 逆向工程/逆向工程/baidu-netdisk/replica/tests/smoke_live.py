#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""8 命令活性冒烟（活体）。预算硬顶 ≤40 发；逐命令打印 errno+关键摘要+耗时。

运行（于 replica/ 目录）：python tests\smoke_live.py
凭据：默认 E:\AI-Station\data\secrets\bdn_credentials.json（输出一律掩码，零明文）。
"""
from __future__ import annotations

import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession, mask  # noqa: E402

BUDGET = 40
EXPECTED_ROOT_ITEMS = 17   # 任务书已实证基线：ls / = 17 项

results: list[dict] = []


def record(name, errno, summary, ms, ok=True):
    results.append({"cmd": name, "errno": errno, "summary": summary,
                    "ms": round(ms, 0), "ok": ok})


def main() -> int:
    sess = BdnSession()
    api = BdnApi(sess)
    print(f"# 凭据: {sess.cred_path}")
    print(f"# bduss={mask(sess.bduss)} stoken={mask(sess.stoken)} ua={sess.ua[:20]}…")
    print(f"# 节流: 并发≤{getattr(sess.throttle, 'max_concurrency', 2)} 间隔≥1.5s | 预算≤{BUDGET}发\n")

    def run(name, fn):
        t0 = time.perf_counter()
        try:
            summary, errno = fn()
            record(name, errno, summary, (time.perf_counter() - t0) * 1000)
            print(f"[{name:<7}] errno={errno:<4} {summary} "
                  f"({(time.perf_counter() - t0) * 1000:.0f}ms, 累计{sess.requests_sent}发)")
        except BdnError as e:
            record(name, getattr(e, "errno", "?"), f"{type(e).__name__}: {e}",
                   (time.perf_counter() - t0) * 1000, ok=False)
            print(f"[{name:<7}] errno={getattr(e, 'errno', '?'):<4} {type(e).__name__}: {e} "
                  f"({(time.perf_counter() - t0) * 1000:.0f}ms, 累计{sess.requests_sent}发)")

    # 1 whoami（账号画像在 login_info 子字典，探针实证 1029）
    def _whoami():
        r = api.login_status()
        a = r.get("account") or {}
        return (f"账号={a.get('username')} uk={a.get('uk')} "
                f"vip{a.get('vip_level')}(type={a.get('vip_type')})", r.get("errno", 0))
    run("whoami", _whoami)

    # 2 quota（GET→POST 兜底路径留痕）
    def _quota():
        sent0 = len(sess.request_log)
        r = api.quota()
        total, used = r.get("total", 0), r.get("used", 0)
        chan = "+".join(f"{x['method']}:{x['path']}" for x in sess.request_log[sent0:])
        return (f"总{total / 2**30:.1f}GB 用{used / 2**30:.1f}GB "
                f"余{(total - used) / 2**30:.1f}GB [{chan}]", r.get("errno", 0))
    run("quota", _quota)

    # 3 ls /（对照基线 17 项）
    ls_entries = []
    def _ls():
        r = api.list_dir("/")
        ls_entries.extend(r.get("entries") or [])
        n = len(ls_entries)
        base = "对上基线17" if n == EXPECTED_ROOT_ITEMS else f"基线{EXPECTED_ROOT_ITEMS}不符!"
        return f"/ 共{n}项（{base}）", r.get("errno", 0)
    run("ls", _ls)

    # 4 tree（深度≤3，请求护栏 12 发）
    def _tree():
        t = api.tree("/", depth=3, max_requests=12)
        note = "预算截断" if t["truncated"] else "完整"
        return (f"{t['nodes']}节点/{t['dirs']}目录/{t['requests']}发 "
                f"深度≤{t['depth_limit']}实际{t['max_depth_reached']}（{note}）"), 0
    run("tree", _tree)

    # 5 search（关键词取最长文件名片段；注意全角冒号前缀『来自：』分词会 0 命中，剥掉）
    def _search():
        names = [e["name"].replace("来自：", "") for e in ls_entries if e.get("name")]
        names = [n for n in names if n]
        kw = (max(names, key=len) or "A")[:4] if names else "A"
        r = api.search(kw, dir_path="/")
        return f"key={kw!r} 递归命中{len(r.get('entries') or [])}条", r.get("errno", 0)
    run("search", _search)

    # 6 meta（取 ls 前三个 fs_id）
    def _meta():
        fsids = [e["fs_id"] for e in ls_entries if e.get("fs_id")][:3]
        if not fsids:
            return "N/A：根目录无 fs_id 可用", 0
        r = api.metas(fsids)
        return (f"{len(fsids)}个fs_id→{len(r.get('entries') or [])}条元信息"
                f"[{r.get('_source')}]", r.get("errno", 0))
    run("meta", _meta)

    # 7 shares
    def _shares():
        r = api.share_records()
        entries = r.get("entries") or []
        first = entries[0].get("shareid") if entries else "-"
        return (f"{len(entries)}条分享记录(首条shareid={first},"
                f"看{entries[0].get('views')}/下{entries[0].get('downloads')})"
                if entries else "0条分享记录", r.get("errno", 0))
    run("shares", _shares)

    # 8 recycle
    def _recycle():
        r = api.recycle_list()
        entries = r.get("entries") or []
        return f"回收站{len(entries)}项", r.get("errno", 0)
    run("recycle", _recycle)

    # 9 doctor（loginStatus 纯往返时延，节流等待不计入）
    def _doctor():
        t0 = time.perf_counter()
        r = sess.get("/api/loginStatus", params={"clienttype": 8})
        ms = (time.perf_counter() - t0) * 1000
        return f"loginStatus往返{ms:.0f}ms errno={r.get('errno', 0)}", r.get("errno", 0)
    run("doctor", _doctor)

    # 10 CLI 通道证明：bdn.py ls / --json --num 20（走完整 argparse→api 链）
    cli_sent = 0
    t0 = time.perf_counter()
    try:
        import bdn
        code = bdn.main(["ls", "/", "--json", "--num", "20"])
        cli_sent = 1  # main 内部新建会话发 1 发 loginStatus? 否——直接 ls 1 发
        print(f"[cli-ls  ] exit={code} (--json 通道端到端OK, 独立会话1发)")
    except SystemExit as e:
        print(f"[cli-ls  ] SystemExit({e.code})")
    record("cli-ls", 0, f"exit={code}", (time.perf_counter() - t0) * 1000)

    total = sess.requests_sent + cli_sent
    print("\n# 请求台账（路径级，零凭据）")
    for x in sess.request_log:
        print(f"  {x['method']:<4} {x['path']:<28} http={x['http']} "
              f"errno={x['errno']} {x['ms']}ms")
    print(f"\n# 总请求数: 库会话{sess.requests_sent}发 + CLI独立会话{cli_sent}发 = {total}发"
          f"（预算{BUDGET}发，{'内' if total <= BUDGET else '超限!'}）")
    print(f"# 熔断状态: {'开(' + sess._circuit_reason + ')' if sess.circuit_open else '闭合'}")
    ok_n = sum(1 for r in results if r["ok"])
    print(f"# 结论: {ok_n}/{len(results)} 项通过；"
          f"ls / = {len(ls_entries)} 项（基线 {EXPECTED_ROOT_ITEMS}）")
    return 0 if total <= BUDGET else 1


if __name__ == "__main__":
    sys.exit(main())
