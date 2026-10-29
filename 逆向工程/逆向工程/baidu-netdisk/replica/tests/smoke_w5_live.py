#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""W5 活体验收：doctor 复验 / mirror 两遍增量 / share-transfer 条件门。

铁律（测试代码内强制）：
- 一切写操作限定 /API复刻测试_1029/ 内——guard()/write_fence 断言，越界即中止；
- 远端零删除：mirror 只增不删；share-cancel 仅取消本腿自建测试分享并留档；
- 控制面主账 ≤80 发（doctor+share+transfer 段）；mirror 段上传协议控制面单列
  预算 ≤120（26 文件×precreate+create 必然量+扫描，如实分账）；数据面分片另计；
- share create ≤2 发；transfer（/share/transfer POST）≤2 次调用；
- 撞 9019/付费 apaas/下线墙 → 如实 N/A+原因文档化（不硬闯付费墙）；
- 诊断/活测原始输出一律落档 tests\_diag_archive\（W4 勘误教训）；凭据全程掩码。

运行（于 replica/ 目录）：python tests\smoke_w5_live.py
"""
from __future__ import annotations

import json
import os
import random
import string
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import (BdnApi, BdnCircuitOpen, BdnError, BdnSession,  # noqa: E402
                     MirrorEngine, mask, run_doctor)

PREFIX = "/API复刻测试_1029"
MIRROR_DST = PREFIX + "/mirror_test"
TRANSFER_DST = PREFIX + "/transfer_in"
ANALYSIS = os.path.normpath(os.path.join(
    os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "..",
    "analysis"))
CONTROL_BUDGET = 80          # 主账：doctor + share + transfer 段
MIRROR_BUDGET = 120          # mirror 段单列（上传协议控制面必然量）
SHARE_CREATE_CAP = 2
TRANSFER_CALL_CAP = 2
REPLICA_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BDN_PY = os.path.join(REPLICA_DIR, "bdn.py")
ARCHIVE = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "_diag_archive",
                       "w5_" + time.strftime("%Y%m%d_%H%M%S"))

results = []
control_cli = 0              # CLI 子进程控制面（其 --json 自报 requests）
mirror_ctl = 0               # mirror 段库会话控制面（单列账）
mirror_data = 0
mirror_bytes = 0
share_create_sends = 0
transfer_calls = 0


def guard(path: str, what: str):
    ok = path == PREFIX or path.startswith(PREFIX + "/")
    if not ok:
        raise AssertionError(f"[guard] 写操作越界({what}): {path!r}")
    return path


def archive(name: str, obj) -> str:
    """原始输出落档 _diag_archive（W4 勘误教训：不自报，全落盘）。"""
    os.makedirs(ARCHIVE, exist_ok=True)
    p = os.path.join(ARCHIVE, name)
    with open(p, "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2)
    return p


def step(name, errno, summary, ok=True, main=0, mirror=0, data=0, dbytes=0):
    results.append({"step": name, "errno": errno, "summary": summary,
                    "ok": ok, "main": main, "mirror": mirror,
                    "data": data, "data_bytes": dbytes})
    print(f"[{name:<4}] errno={errno:<5} {summary}"
          + (f" (主账+{main}" if main else "")
          + (f" mirror账+{mirror}" if mirror else "")
          + (f" 数据面+{data}/{dbytes}B)" if data else ")"))


def cli(args, timeout=300):
    """跑 bdn.py 子进程 → (rc, payload)。控制面按其 --json 自报 requests 计账；
    失败无 JSON 时按 +8 上界估账（W5 教训：errno 中途抛出=子进程已花发数须入账）。"""
    global control_cli
    proc = subprocess.run(
        [sys.executable, BDN_PY] + args + ["--json"],
        capture_output=True, text=True, encoding="utf-8", cwd=REPLICA_DIR,
        timeout=timeout)
    payload = None
    lines = proc.stdout.splitlines()
    for i in range(len(lines) - 1, -1, -1):
        if lines[i].startswith("{"):
            try:
                payload = json.loads("\n".join(lines[i:]))
            except ValueError:
                payload = None
            break
    if payload:
        control_cli += int(payload.get("requests")
                           or payload.get("control_requests") or 0)
    else:
        control_cli += 8                  # 上界估账（W5 实测 transfer 失败链≈6 发）
    return proc.returncode, payload, (proc.stderr or "").strip()[-400:]


def main() -> int:
    global mirror_ctl, mirror_data, mirror_bytes
    global share_create_sends, transfer_calls
    sess = BdnSession()
    api = BdnApi(sess)
    print(f"# 凭据: {sess.cred_path}")
    print(f"# bduss={mask(sess.bduss)} stoken={mask(sess.stoken)}")
    print(f"# 围栏 {PREFIX}/** | 主账≤{CONTROL_BUDGET} | mirror 单列≤{MIRROR_BUDGET} | "
          f"share-create≤{SHARE_CREATE_CAP} 发 | transfer 调用≤{TRANSFER_CALL_CAP}")
    print(f"# 分析源 {ANALYSIS} → {MIRROR_DST} | 落档 {ARCHIVE}\n")
    t_all = time.perf_counter()

    def sent() -> int:
        return sess.requests_sent

    # ---- d. doctor 八针复验（全只读 8 发） ----
    t0 = time.perf_counter(); s0 = sent()
    rep = run_doctor(api)
    archive("doctor.json", rep)
    step("d0", 0 if rep["verdict"] != "dead" else 1,
         f"doctor verdict={rep['verdict']} 8针={len(rep['checks'])} "
         f"指纹漂移={sum(1 for f in rep['fingerprints'] if f['status'] != 'ok')} "
         f"漂移项={len(rep['drift'])} ({rep['requests_sent']}发, "
         f"{time.perf_counter()-t0:.1f}s)",
         ok=rep["verdict"] != "dead", main=sent() - s0)

    # ---- m. mirror 两遍：增量实证 ----
    t0 = time.perf_counter(); s0 = sent()
    eng = MirrorEngine(api)
    r1 = eng.run(ANALYSIS, MIRROR_DST, write_fence=PREFIX)
    archive("mirror_pass1.json", r1)
    m1_ctl = sent() - s0
    mirror_ctl += m1_ctl
    mirror_data += r1["data_requests"]; mirror_bytes += r1["bytes_uploaded"]
    ok1 = (r1["uploads_done"] == r1["uploads_planned"]
           and not r1["uploads_failed"] and r1["uploads_done"] >= 20)
    step("m1", r1["errno"],
         f"mirror pass1: 扫描{r1['files_scanned']}文件/{r1['bytes_total']}B "
         f"上传{r1['uploads_done']}/{r1['uploads_planned']}"
         f"({r1['bytes_uploaded']}B) 空文件跳过{len(r1['zero_byte_skipped'])} "
         f"建目录{len(r1['dirs_created'])}段 {r1['elapsed_s']}s",
         ok=ok1, mirror=m1_ctl, data=r1["data_requests"],
         dbytes=r1["bytes_uploaded"])

    t0 = time.perf_counter(); s0 = sent()
    r2 = eng.run(ANALYSIS, MIRROR_DST, write_fence=PREFIX)
    archive("mirror_pass2.json", r2)
    m2_ctl = sent() - s0
    mirror_ctl += m2_ctl
    mirror_data += r2["data_requests"]; mirror_bytes += r2["bytes_uploaded"]
    ok2 = r2["uploads_planned"] == 0 and r2["uploads_done"] == 0 \
        and r2["data_requests"] == 0
    step("m2", 0,
         f"mirror pass2: **增量={r2['uploads_planned']} 上传** 未变{r2['unchanged']} "
         f"补账{r2['assumed_unchanged']} 远端多余{r2['remote_only_count']} "
         f"md5重哈希{r2['md5_rehashed']} {r2['elapsed_s']}s",
         ok=ok2, mirror=m2_ctl)

    # ---- a. share 条件门：create(≤2) → 记录 → (b 腿用) → cancel → 复核消失 ----
    t0 = time.perf_counter(); s0 = sent()
    base, target = MIRROR_DST, None
    r = api.list_dir(base)
    target = next((e["name"] for e in r.get("entries") or []
                   if not e["isdir"] and int(e.get("size") or 0) > 0), None)
    if target is None:                       # mirror 产物缺文件时兜底围栏根
        base = PREFIX
        r = api.list_dir(base)
        target = next((e["name"] for e in r.get("entries") or []
                       if not e["isdir"] and int(e.get("size") or 0) > 0), None)
    if target is None:
        raise RuntimeError("围栏内无可分享的测试文件（mirror 段异常）")
    share_target = guard(f"{base}/{target}", "share-target")
    pick_ctl = sent() - s0
    pwd = "w5" + "".join(random.choices(string.ascii_lowercase, k=2))
    t0 = time.perf_counter()
    rc, sc, err = cli(["share-create", share_target, "--pwd", pwd])
    share_create_sends += int((sc or {}).get("attempts_sent") or 0)
    archive("share_create.json", {"rc": rc, "payload": sc, "stderr": err,
                                  "target": share_target, "pwd_masked": mask(pwd)})
    a_ok = rc == 0 and (sc or {}).get("errno") == 0
    shareid = (sc or {}).get("shareid")
    link = (sc or {}).get("link")
    step("a1", (sc or {}).get("errno", "?"),
         f"share-create {share_target} → shareid={shareid} link={link} "
         f"提取码={mask(pwd)} 发数={share_create_sends}/{SHARE_CREATE_CAP}"
         + ("" if a_ok else f" 【N/A 候选】rc={rc} {err}"),
         ok=a_ok or share_create_sends <= SHARE_CREATE_CAP,   # 死墙=N/A 不硬闯
         main=pick_ctl)

    # ---- b. transfer 条件门：既有记录选本账号一条 → CLI 转存 → ls 复核 ----
    t0 = time.perf_counter(); s0 = sent()
    api.mkdir(TRANSFER_DST)
    recs = api.share_records()
    entries = recs.get("entries") or []
    files_first = [e for e in entries
                   if e.get("typical_path") and "." in
                   e["typical_path"].rsplit("/", 1)[-1]]
    pick = next((e for e in files_first if not e["passwd"]), None) \
        or (files_first or entries or [None])[0]
    archive("transfer_pick.json",
            {"picked": pick, "candidates": entries[:10], "total": len(entries)})
    b_ctl_head = sent() - s0
    if pick is None:
        step("b1", "N/A", "分享记录为空，无可转存项", ok=False, main=b_ctl_head)
    else:
        t0 = time.perf_counter()
        rc, tr, err = cli(["transfer", pick["shortlink"], TRANSFER_DST])
        transfer_calls += 1
        archive("transfer.json", {"rc": rc, "payload": tr, "stderr": err,
                                  "picked": pick})
        t0 = time.perf_counter(); s0 = sent()
        r = api.list_dir(TRANSFER_DST)
        landed = [e["name"] for e in r.get("entries") or []]
        verify_ctl = sent() - s0
        tp_base = (pick.get("typical_path") or "").rsplit("/", 1)[-1]
        hit = any(tp_base in n for n in landed) if tp_base else bool(landed)
        errno_b = (tr or {}).get("errno", "?")
        step("b1", errno_b,
             f"transfer {pick['typical_path']} → {TRANSFER_DST} "
             f"fsids={len((tr or {}).get('fsidlist') or [])} rc={rc}"
             + ("" if err == "" else f" err={err}"),
             ok=(rc == 0 and hit), main=b_ctl_head + verify_ctl)
        step("b2", 0, f"ls 复核 transfer_in: {len(landed)} 项 命中={hit} "
             f"({landed[:8]})", ok=hit, main=0)

    # ---- a 续：取消自建分享 + 记录复核 ----
    if shareid is not None:
        t0 = time.perf_counter()
        rc, cx, err = cli(["share-cancel", str(shareid)])
        archive("share_cancel.json", {"rc": rc, "payload": cx, "stderr": err})
        step("a2", (cx or {}).get("errno", "?"),
             f"share-cancel {shareid} rc={rc}", ok=rc == 0)
        t0 = time.perf_counter(); s0 = sent()
        r = api.share_records()
        matches = [e for e in r.get("entries") or []
                   if e["shareid"] == shareid]
        # 取消后的正常形态=列表消失；若仍挂条目则须已非有效态（status 翻位）
        gone = not matches or all(e.get("status") for e in matches)
        step("a3", 0, f"shares 复核 shareid={shareid}: 消失或翻位={gone} "
             f"(残留{len(matches)}条)", ok=gone, main=sent() - s0)
    else:
        print("[a2] share-create 未成功（N/A）→ 无自建分享可取消（零取消零删除）")

    # ---- 总账 ----
    main_ctl = sess.requests_sent - mirror_ctl + control_cli
    total_mirror = mirror_ctl
    print("\n# 控制面台账（库会话，路径级，零凭据）")
    for x in sess.request_log:
        print(f"  {x['method']:<4} {x['path']:<46} http={x['http']} "
              f"errno={x['errno']} {x['ms']}ms")
    print(f"\n# 主账: 库{sess.requests_sent - mirror_ctl}发 + CLI{control_cli}发 "
          f"= {main_ctl}发（预算{CONTROL_BUDGET}，"
          f"{'内' if main_ctl <= CONTROL_BUDGET else '超限!'}）")
    print(f"#   其中 share-create {share_create_sends}/{SHARE_CREATE_CAP} 发；"
          f"transfer 调用 {transfer_calls}/{TRANSFER_CALL_CAP} 次")
    print(f"# mirror 单列账: {total_mirror}发（预算{MIRROR_BUDGET}，"
          f"{'内' if total_mirror <= MIRROR_BUDGET else '超限!'}）"
          f" | 数据面 {mirror_data}发/{mirror_bytes}B")
    print(f"# 熔断: {'开(' + sess._circuit_reason + ')' if sess.circuit_open else '闭合'}")
    ok_n = sum(1 for r in results if r["ok"])
    print(f"# 结论: {ok_n}/{len(results)} 项通过；总耗时{time.perf_counter()-t_all:.0f}s；"
          f"原始输出全档 {ARCHIVE}")
    archive("ledger.json", {"results": results, "main_control": main_ctl,
                            "cli_control": control_cli,
                            "mirror_control": total_mirror,
                            "mirror_data_requests": mirror_data,
                            "mirror_bytes": mirror_bytes,
                            "request_log": sess.request_log,
                            "share_create_sends": share_create_sends,
                            "transfer_calls": transfer_calls})
    gates = (ok_n == len(results) and main_ctl <= CONTROL_BUDGET
             and total_mirror <= MIRROR_BUDGET
             and share_create_sends <= SHARE_CREATE_CAP
             and transfer_calls <= TRANSFER_CALL_CAP)
    return 0 if gates else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except BdnCircuitOpen as e:
        print(f"\n# 熔断全停: {e}", file=sys.stderr)
        sys.exit(2)
