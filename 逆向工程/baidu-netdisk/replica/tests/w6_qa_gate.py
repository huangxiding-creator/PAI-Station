#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""W6 任务三：QA 总门——全命令面活体终验（逐命令 errno/耗时/关键摘要）。

铁律（W6 战书）：
- 写操作全在 /API复刻测试_1029/ 围栏（qa_gate_tmp 产物保留待用户处置）；
- 控制面 ≤50 发（W6 全局，含任务二已花 ~13 发——本脚本自账 ≤37）；
- share create≤1 / cancel≤1 / transfer≤1（transfer 硬帽已耗于任务二，本件只引证）；
- 远端 rm 仅围栏内 1 文件；零删除其余；归档前全过 scrub_payload；凭据掩码。
附：E1 搜索提速探针（xpan vs pcs 遗产各 1 发）+ E2 下载线程 4 vs 8（围栏 10MB，
数据面，测完即止不硬压）。
"""
from __future__ import annotations

import hashlib
import importlib.util
import json
import os
import subprocess
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import (BdnApi, BdnError, BdnSession, DownloadEngine,  # noqa: E402
                     mask, md5_file)

REPLICA = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BDN_PY = os.path.join(REPLICA, "bdn.py")
HERE = os.path.dirname(os.path.abspath(__file__))
ARCHIVE = os.path.join(HERE, "_diag_archive", "w6_qa_gate")
LOCAL = os.path.join(ARCHIVE, "local")            # 本地产物（保留待用户处置）
FENCE = "/API复刻测试_1029"
QA = FENCE + "/qa_gate_tmp"
QA_SUB = QA + "/sub"
MIRROR_PROBE_REMOTE = QA + "/mirror_probe"
SEARCH_KEY = "演讲"

_spec = importlib.util.spec_from_file_location(
    "diag_scrub", os.path.join(HERE, "_diag_archive", "scrub.py"))
scrub = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(scrub)

rows = []            # 汇总表：[{cmd, rc, errno, elapsed_s, requests, summary}]
cli_control = 0      # CLI 子进程控制面（--json 自报，缺 JSON 按 +8 上界估）


def dump(name: str, obj) -> str:
    os.makedirs(ARCHIVE, exist_ok=True)
    clean, _n, _h = scrub.scrub_payload(obj)
    p = os.path.join(ARCHIVE, name)
    with open(p, "w", encoding="utf-8") as f:
        json.dump(clean, f, ensure_ascii=False, indent=2, default=str)
    return p


def cli(args, timeout=300, fixed_requests=None):
    """跑 bdn.py 子进程 → (rc, payload, stderr, elapsed, requests)。
    fixed_requests：已知确切发数时直用（护栏负例零请求，不吃 +8 上界估账）。"""
    global cli_control
    t0 = time.perf_counter()
    proc = subprocess.run([sys.executable, BDN_PY] + args + ["--json"],
                          capture_output=True, text=True, encoding="utf-8",
                          cwd=REPLICA, timeout=timeout)
    elapsed = round(time.perf_counter() - t0, 1)
    payload = None
    lines = proc.stdout.splitlines()
    for i in range(len(lines) - 1, -1, -1):
        if lines[i].startswith("{"):
            try:
                payload = json.loads("\n".join(lines[i:]))
            except ValueError:
                payload = None
            break
    if fixed_requests is not None:
        req = fixed_requests
    else:
        req = int((payload or {}).get("requests")
                  or (payload or {}).get("control_requests")
                  or (payload or {}).get("requests_sent") or 0)
        if not payload:
            req = 8                                    # 上界估账（W5 教训）
    cli_control += req
    return proc.returncode, payload, (proc.stderr or "").strip()[-300:], elapsed, req


def gate(cmd, args, ok=None, summary_fn=None, timeout=300, fixed_requests=None):
    """跑一命令并落一行汇总。档案已存在（前次运行已过）→ 复用零重发。"""
    fn = "cmd_" + cmd.replace(" ", "_").replace("/", "_") + ".json"
    ap = os.path.join(ARCHIVE, fn)
    if os.path.exists(ap):                       # resume：该命令前次已活体验完
        try:
            with open(ap, encoding="utf-8") as f:
                st = json.load(f)
            rc, payload = st["rc"], st["payload"]
            okk = ok(rc, payload) if ok else (rc == 0)
            summ = summary_fn(payload, st.get("stderr", "")) if summary_fn else ""
            rows.append({"cmd": cmd, "rc": rc,
                         "errno": (payload or {}).get("errno", 0),
                         "elapsed_s": st.get("elapsed_s"),
                         "requests": st.get("requests"),
                         "ok": bool(okk), "summary": summ + "（档案复用）"})
            print(f"[{cmd:<18}] rc={rc:<2} errno={(payload or {}).get('errno', 0):<3} "
                  f"{'PASS' if okk else 'FAIL'}  {summ}（档案复用，零重发）")
            return payload
        except (OSError, ValueError, KeyError):
            pass                                 # 档案残缺 → 重跑
    rc, payload, err, elapsed, req = cli(args, timeout=timeout,
                                         fixed_requests=fixed_requests)
    errno = (payload or {}).get("errno", "?" if not payload else 0)
    okk = ok(rc, payload) if ok else (rc == 0)
    summ = summary_fn(payload, err) if summary_fn else (err or "")[:120]
    rows.append({"cmd": cmd, "rc": rc, "errno": errno, "elapsed_s": elapsed,
                 "requests": req, "ok": bool(okk), "summary": summ})
    print(f"[{cmd:<18}] rc={rc:<2} errno={errno:<3} {elapsed:>5}s 发={req:<2} "
          f"{'PASS' if okk else 'FAIL'}  {summ}")
    dump(fn, {"args": args, "rc": rc, "payload": payload, "stderr": err,
              "elapsed_s": elapsed, "requests": req})
    return payload


def main() -> int:
    os.makedirs(LOCAL, exist_ok=True)
    # 本地料件：100KB 上传源 + 1KB（mirror dry-run 用）
    src100k = os.path.join(LOCAL, "qa_100k.bin")
    with open(src100k, "wb") as f:
        f.write(os.urandom(100 * 1024))
    src1k = os.path.join(LOCAL, "qa_1k.bin")
    with open(src1k, "wb") as f:
        f.write(os.urandom(1024))
    src_md5 = md5_file(src100k)

    print(f"# W6 QA 总门 | 围栏 {FENCE}/** | 落档 {ARCHIVE}")
    print(f"# 读面 8 命令 → 写面 → 分享/镜像 → E1/E2\n")

    # ---------- 读面（读命令不自带 requests 自报 → fixed_requests=1 实计） ----------
    p = gate("whoami", ["whoami"], fixed_requests=1,
             summary_fn=lambda p, e: f"{(p or {}).get('username')} "
             f"uk={(p or {}).get('uk')} VIP{(p or {}).get('vip_level')}")
    gate("quota", ["quota"], fixed_requests=1,
         summary_fn=lambda p, e: f"总{(p or {}).get('total_h')} "
         f"用{(p or {}).get('used_h')} 余{(p or {}).get('free_h')}")
    gate("ls /", ["ls", "/"], fixed_requests=1,
         summary_fn=lambda p, e: f"{(p or {}).get('count')} 项")
    tree_p = gate("tree fence d1", ["tree", FENCE, "--depth", "1"],
                  summary_fn=lambda p, e:
                  f"{(p or {}).get('nodes')} 节点 请求{(p or {}).get('requests')}"
                  f" 发 截断={(p or {}).get('truncated')}")
    search_p = gate("search", ["search", SEARCH_KEY, "--num", "20"],
                    fixed_requests=1,
                    summary_fn=lambda p, e: f"命中 {(p or {}).get('count')} 条"
                    f"（key={SEARCH_KEY}）")
    gate("shares", ["shares"], fixed_requests=1,
         summary_fn=lambda p, e: f"{(p or {}).get('count')} 条记录")
    gate("recycle", ["recycle"], fixed_requests=1,
         summary_fn=lambda p, e: f"{(p or {}).get('count')} 项")
    gate("doctor", ["doctor"],
         ok=lambda rc, p: rc == 0 and (p or {}).get("verdict") in ("ok", "degraded"),
         summary_fn=lambda p, e: f"verdict={(p or {}).get('verdict')} "
         f"{len((p or {}).get('checks', {}))}针 漂移{len((p or {}).get('drift', []))}")

    # ---------- 写面（围栏 qa_gate_tmp） ----------
    gate("mkdir qa_gate_tmp", ["mkdir", QA])
    gate("mkdir sub", ["mkdir", QA_SUB])
    up_p = gate("upload 100KB", ["upload", src100k, QA + "/qa_100k.bin"],
                summary_fn=lambda p, e: f"size={(p or {}).get('size')} "
                f"rapid={(p or {}).get('rapid')} "
                f"数据面{(p or {}).get('data_requests')}发")
    gate("rename", ["rename", QA + "/qa_100k.bin", "qa_100k_rn.bin"])
    gate("mv", ["mv", QA + "/qa_100k_rn.bin", QA_SUB])
    gate("cp", ["cp", QA_SUB + "/qa_100k_rn.bin", QA],
         summary_fn=lambda p, e: f"ondup=newcopy → 同名副本落 {QA}")
    # 副本名（newcopy 自加后缀）：ls qa_gate_tmp 定位后删（围栏内单文件 rm）
    sess = BdnSession()
    api = BdnApi(sess)
    listing = api.list_dir(QA)
    entries_qa = listing.get("entries") or []
    dup = next((e["name"] for e in entries_qa
                if not e["isdir"] and e["name"].startswith("qa_100k_rn")), None)
    names = [e["name"] for e in entries_qa]
    if dup:
        gate("rm --confirm", ["rm", QA + "/" + dup, "--confirm"],
             summary_fn=lambda p, e: f"删除 {dup}（回收站）"
             f" executed={(p or {}).get('executed')}")
    else:
        rows.append({"cmd": "rm --confirm", "rc": None, "errno": "?", "ok": False,
                     "summary": f"副本未找到（cp 形态漂移？）现有={names}"})
        print("[rm --confirm     ] SKIP：cp 副本未找到")
    dl_local = os.path.join(LOCAL, "qa_100k_dl_back.bin")
    dl_p = gate("download+md5", ["download", QA_SUB + "/qa_100k_rn.bin", dl_local],
                summary_fn=lambda p, e: f"md5_ok={(p or {}).get('md5_ok')} "
                f"{(p or {}).get('speed_mb_s')}MB/s")
    dl_md5_match = (os.path.exists(dl_local)
                    and md5_file(dl_local) == src_md5)
    rows.append({"cmd": "download md5 本地比对", "rc": 0,
                 "errno": 0 if dl_md5_match else 1, "ok": dl_md5_match,
                 "elapsed_s": 0, "requests": 0,
                 "summary": f"源md5={src_md5[:8]}… 回传md5="
                 f"{(md5_file(dl_local)[:8] + '…') if os.path.exists(dl_local) else '无'}"})
    print(f"[download md5 比对 ] {'PASS' if dl_md5_match else 'FAIL'} "
          f"src={src_md5[:8]}… dl={md5_file(dl_local)[:8] if os.path.exists(dl_local) else '无'}…")

    # meta：fsid 直取 upload 回执（fs_id 跨 rename/mv 不变——顺带核验同一性，零新发）
    fsid = (up_p or {}).get("fs_id")
    if fsid:
        meta_p = gate("meta", ["meta", str(fsid)],
                      summary_fn=lambda p, e: f"{(p or {}).get('count')} 条 "
                      f"来源={(p or {}).get('source')} "
                      f"path={(p or {}).get('entries', [{}])[0].get('path')}")
    else:
        rows.append({"cmd": "meta", "rc": None, "errno": "?", "ok": False,
                     "summary": "upload 回执无 fs_id（形态漂移）"})
        print("[meta              ] SKIP：无 fs_id")

    # ---------- 分享（create≤1/cancel≤1，属主护栏真跑） ----------
    sc_p = gate("share-create", ["share-create", QA_SUB + "/qa_100k_rn.bin",
                                 "--pwd", "w6qa"],
                summary_fn=lambda p, e: f"shareid={(p or {}).get('shareid')} "
                f"发数={(p or {}).get('attempts_sent')}")
    shareid = (sc_p or {}).get("shareid")
    if shareid:
        cx_p = gate("share-cancel", ["share-cancel", str(shareid)],
                    summary_fn=lambda p, e: f"属主护栏放行自建 {shareid} "
                    f"requests={(p or {}).get('requests')}")
    # 属主护栏负例：零活体发（离线单测 3 件已证：非自建拒发退出 3/混入整批拒/
    # 自建放行——FakeTransport 零 cancel POST），此处只记引证行
    rows.append({"cmd": "share-cancel 护栏负例", "rc": 3, "errno": -9, "ok": True,
                 "elapsed_s": 0, "requests": 0,
                 "summary": "离线单测引证（tests/test_offline_w6.py 三件：非自建"
                            "拒发 rc3 零 POST/混入整批拒/自建放行）"})
    print("[share-cancel 护栏负例] PASS  离线单测引证，零活体发（省预算）")

    # ---------- transfer（任务二引证，零新发） ----------
    tr_path = os.path.join(ARCHIVE, "transfer_retest.json")
    tr = json.load(open(tr_path, encoding="utf-8")) if os.path.exists(tr_path) else {}
    tr_errno = (tr.get("payload") or {}).get("errno", "?")
    rows.append({"cmd": "transfer(引证任务二)", "rc": tr.get("rc"), "errno": tr_errno,
                 "ok": tr_errno == 0, "elapsed_s": tr.get("elapsed_s"),
                 "requests": (tr.get("payload") or {}).get("requests"),
                 "summary": f"errno={tr_errno}（bdstoken 携带形态；蓝本全参"
                 "shareid+from 已实装待 W7 复测）"})
    print(f"[transfer 引证     ] errno={tr_errno}（任务二 1/1 硬帽已用，零新发）")

    # ---------- 镜像 ----------
    mirror_local = os.path.join(LOCAL, "mirror_src")
    os.makedirs(mirror_local, exist_ok=True)
    with open(os.path.join(mirror_local, "m_100k.bin"), "wb") as f:
        f.write(os.urandom(100 * 1024))
    with open(os.path.join(mirror_local, "m_1k.bin"), "wb") as f:
        f.write(os.urandom(1024))
    gate("mirror --dry-run", ["mirror", mirror_local, MIRROR_PROBE_REMOTE,
                              "--dry-run"],
         summary_fn=lambda p, e: f"计划 {(p or {}).get('uploads_planned')} 件 "
         f"零上传 remote_scan={(p or {}).get('remote_scan_requests')}发")
    gate("mirror 护栏负例", ["mirror", mirror_local, "/备份", "--dry-run"],
         ok=lambda rc, p: rc != 0, fixed_requests=0,
         summary_fn=lambda p, e: (e or "")[:80] or "拒绝")

    # ---------- E1：搜索提速（xpan vs pcs 遗产，各 1 发） ----------
    e1 = {"xpan": {"elapsed_s": None, "count": (search_p or {}).get("count"),
                   "errno": (search_p or {}).get("errno", 0)}}
    try:                                            # pcs 遗产（PROTOCOL G4 B 级）
        t0 = time.perf_counter()
        pcs_r = api.s.post("https://pcs.baidu.com/rest/2.0/pcs/file",
                           params={"method": "search", "path": "/",
                                   "wd": SEARCH_KEY, "re": 1})
        e1["pcs_legacy"] = {"elapsed_s": round(time.perf_counter() - t0, 1),
                            "errno": pcs_r.get("errno"),
                            "keys": list(pcs_r.keys())[:6]}
    except BdnError as e:
        e1["pcs_legacy"] = {"error": str(e)[:160],
                            "errno": getattr(e, "errno", None)}
    e1["conclusion"] = ("pcs 遗产端点死亡/劣化 → xpan 维持唯一搜索通道（router 不动）"
                        if e1.get("pcs_legacy", {}).get("errno") != 0
                        else "pcs 遗产端点仍活——对比时延后定夺")
    dump("e1_search_probe.json", e1)
    print(f"[E1 搜索探针       ] pcs遗产 errno={e1['pcs_legacy'].get('errno')} "
          f"{e1['pcs_legacy'].get('elapsed_s', '-')}s vs xpan QA行 "
          f"→ {e1['conclusion'][:40]}…")

    # ---------- E2：下载线程 4 vs 8（围栏 10MB，数据面，测完即止） ----------
    # 10MB 样本从 tree 行结果按体积找（W4 产物 bdnw4_10m*，零新发发现）
    tree_entries = (tree_p or {}).get("tree") or []
    tenmb = next((n["name"] for n in tree_entries
                  if not n["isdir"] and 9 * 2 ** 20 < int(n.get("size") or 0)
                  <= 11 * 2 ** 20), None)
    e2 = {"sample": tenmb and (FENCE + "/" + tenmb), "runs": {}}
    if tenmb:

        class _MetaCache:
            """E2 测量壳：两次下载共用一次 meta_by_path（dlink 8h 有效；省 2 发）。"""
            def __init__(self, inner):
                self._inner = inner
                self._c = {}

            def __getattr__(self, name):
                return getattr(self._inner, name)

            def meta_by_path(self, remote, dlink=0):
                key = (remote, dlink)
                if key not in self._c:
                    self._c[key] = self._inner.meta_by_path(remote, dlink)
                return self._c[key]

        cached_api = _MetaCache(api)
        for workers in (4, 8):
            eng = DownloadEngine(cached_api, workers=workers)
            dst = os.path.join(LOCAL, f"e2_w{workers}.bin")
            try:
                r = eng.download(FENCE + "/" + tenmb, dst)
                e2["runs"][f"w{workers}"] = {
                    "speed_mb_s": r["speed_mb_s"], "elapsed_s": r["elapsed_s"],
                    "chunks": r["chunks_total"], "data_requests": r["data_requests"],
                    "md5_ok": r["md5_ok"]}
            except BdnError as e:
                e2["runs"][f"w{workers}"] = {"error": str(e)[:160]}
        r4 = e2["runs"].get("w4", {}).get("speed_mb_s")
        r8 = e2["runs"].get("w8", {}).get("speed_mb_s")
        if r4 and r8:
            e2["winner"] = "w8" if r8 > r4 else ("w4" if r4 > r8 else "tie")
            e2["delta_pct"] = round(abs(r8 - r4) / max(r4, r8) * 100, 1)
            e2["conclusion"] = (
                f"{e2['winner']} 快 {e2['delta_pct']}%（单次测量，网络波动在案；"
                "默认 8 线程维持/调整结论入 README）")
        dump("e2_download_threads.json", e2)
        print(f"[E2 下载线程       ] 4线程={r4}MB/s 8线程={r8}MB/s → "
              f"{e2.get('conclusion', '')[:60]}")
    else:
        e2["note"] = "围栏内未找到 10MB 样本（W4 产物名漂移？）"
        dump("e2_download_threads.json", e2)
        print("[E2 下载线程       ] SKIP：无 10MB 样本")

    # ---------- 总账 ----------
    total_lib = sess.requests_sent
    passed = sum(1 for r in rows if r["ok"])
    ledger = {
        "rows": rows,
        "cli_control": cli_control,
        "lib_control_e1e2_and_ls": total_lib,
        "lib_control_excluding_e2_download_meta": None,
        "note": "transfer 1/1 硬帽耗于任务二（引证零新发）；share create 1 cancel 1；"
                "rm 仅围栏内 1 文件；qa_gate_tmp 产物保留待用户处置",
        "e1": e1, "e2_summary": {k: v for k, v in e2.items() if k != "runs"}}
    dump("qa_gate_ledger.json", ledger)
    print(f"\n# 汇总: {passed}/{len(rows)} 绿 | CLI 控制面 {cli_control} 发 "
          f"+ 库会话（ls/meta 定位+E1+E2 metas）{total_lib} 发")
    print(f"# 全档 {ARCHIVE}")
    return 0 if passed == len(rows) else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except BdnError as e:
        print(f"\n# 失败: {e}", file=sys.stderr)
        sys.exit(1)
