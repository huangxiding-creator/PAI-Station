#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""W4 写命令+传输引擎 活体验收（a-h 全序）。

铁律（测试代码内强制）：
- 一切写操作限定 /API复刻测试_1029/ 内——guard() 前缀断言，越界即 AssertionError 中止；
- rm 只删该目录内测试文件；其余测试产物一律保留（零删除纪律）；
- 控制面预算 ≤80 发（库会话+CLI 子进程分账）；数据面分片请求计数单列如实报；
- 遇 31119/31329/20012/31034 熔断器全停（bdncore 内置）；
- 200MB 测试文件造在 %TEMP%；凭据输出一律掩码。

运行（于 replica/ 目录）：python tests\smoke_w4_live.py
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import tempfile
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import (BdnApi, BdnCircuitOpen, BdnError, BdnSession,  # noqa: E402
                     DownloadEngine, UploadEngine, mask, md5_file)

PREFIX = "/API复刻测试_1029"
CONTROL_BUDGET = 80
KILL_AT_PARTS = 25          # 200MB/4MB=50 片，≈50% 处杀
KILL_WAIT_S = 480           # 等到 50% 的耐心上限
RUNID = time.strftime("%H%M%S")   # 每轮唯一名：围栏内遗留产物零冲突（零删除纪律，产物全保留）

REPLICA_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BDN_PY = os.path.join(REPLICA_DIR, "bdn.py")
TMP = tempfile.gettempdir()

results = []
control_cli = 0             # CLI 子进程控制面（解析其 --json 输出 requests 字段）
data_req_total = 0
data_bytes_total = 0


def guard(path: str, what: str):
    """写面路径前缀断言：一切写操作必须落在 /API复刻测试_1029/ 内。"""
    ok = path == PREFIX or path.startswith(PREFIX + "/")
    if not ok:
        raise AssertionError(f"[guard] 写操作越界({what}): {path!r}")
    return path


def step(name, errno, summary, ms, ok=True, control=0, data=0, dbytes=0):
    results.append({"step": name, "errno": errno, "summary": summary,
                    "ms": round(ms), "ok": ok, "control": control,
                    "data": data, "data_bytes": dbytes})
    print(f"[{name:<3}] errno={errno:<4} {summary} ({ms:.0f}ms, "
          f"控制面+{control} 数据面+{data}/{dbytes}B)")


def cli(args, timeout=None):
    """跑 bdn.py 子进程，返回 (rc, payload|None)。控制面按其自报 requests 计账。
    --json 输出为多行缩进 JSON：取最后一个行首 '{' 起的完整对象。"""
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
        control_cli += int(payload.get("requests") or payload.get("control_requests") or 0)
    return proc.returncode, payload


def make_local(name: str, size: int) -> str:
    p = os.path.join(TMP, name)
    blk = os.urandom(1024 * 1024)
    with open(p, "wb") as f:
        left = size
        while left > 0:
            n = min(left, len(blk))
            f.write(blk[:n])
            left -= n
    return p


def main() -> int:
    global data_req_total, data_bytes_total, control_cli
    sess = BdnSession()
    api = BdnApi(sess)
    print(f"# 凭据: {sess.cred_path}")
    print(f"# bduss={mask(sess.bduss)} stoken={mask(sess.stoken)}")
    print(f"# 写面围栏: {PREFIX}/** | 控制面预算≤{CONTROL_BUDGET} | "
          f"数据面并发≤8、上传分块4MB、下载分片4MB\n")
    t_all = time.perf_counter()

    # 清理本冒烟自己上次遗留的 %TEMP% 断点状态文件（陈旧 uploadid 会让续传开局即拒）
    for _n in ("bdnw4_1k.bin", "bdnw4_10m.bin", "bdnw4_10m_instant.bin",
               "bdnw4_200m.bin", "bdnw4_dl_10m_back.bin"):
        for _sfx in (".bdn_upload_state.json", ".bdn_dl_state.json"):
            _p = os.path.join(TMP, _n + _sfx)
            if os.path.exists(_p):
                os.remove(_p)

    def sent() -> int:
        return sess.requests_sent

    # ---- 0 doctor：链路在位 ----
    t0 = time.perf_counter(); s0 = sent()
    api.login_status()
    step("d0", 0, "loginStatus 链路在位", (time.perf_counter() - t0) * 1000,
         control=sent() - s0)

    # ---- a. mkdir + filediff 游标（跨家族交叉验证） ----
    cursor0 = None
    t0 = time.perf_counter(); s0 = sent()
    try:
        r = api.filediff_bootstrap()
        cursor0 = r.get("cursor") or ""
        step("a1", r.get("errno", 0), f"filediff 冷启动 cursor len={len(cursor0)}",
             (time.perf_counter() - t0) * 1000, control=sent() - s0)
    except BdnError as e:
        step("a1", getattr(e, "errno", "?"), f"冷启动未激活: {e}",
             (time.perf_counter() - t0) * 1000, ok=False, control=sent() - s0)

    guard(PREFIX, "mkdir")
    t0 = time.perf_counter(); s0 = sent()
    r = api.mkdir(PREFIX)
    step("a2", r.get("errno", 0), f"mkdir {PREFIX} exists={r.get('exists')}",
         (time.perf_counter() - t0) * 1000, control=sent() - s0)

    t0 = time.perf_counter(); s0 = sent()
    r = api.list_dir(PREFIX)
    n0 = len(r.get("entries") or [])
    step("a3", r.get("errno", 0), f"ls 交叉可见: {PREFIX} 共{n0}项",
         (time.perf_counter() - t0) * 1000, control=sent() - s0)

    if cursor0:
        t0 = time.perf_counter(); s0 = sent()
        r = api.filediff(cursor0)
        cur1 = r.get("cursor") or ""
        hit = any("API复刻测试_1029" in json.dumps(x, ensure_ascii=False)
                  for x in (r.get("entries") or []) if not isinstance(x, str)) \
            or "API复刻测试_1029" in json.dumps(r.get("entries") or [], ensure_ascii=False)
        step("a4", r.get("errno", 0),
             f"filediff 增量: 游标变化={cur1 != cursor0} entries含新目录={hit}",
             (time.perf_counter() - t0) * 1000, control=sent() - s0)

    # ---- b/c. 1KB + 10MB 上传 + metas 核对 ----
    def upload_verify(tag, local_name, size, remote_name=None):
        global data_req_total, data_bytes_total
        local = os.path.join(TMP, local_name)
        make_local(local_name, size)      # 每轮重造新随机内容：确保走真三段流（防上轮秒传）
        stem = (remote_name or local_name).replace(".bin", f"_{RUNID}.bin")
        remote = guard(f"{PREFIX}/{stem}", f"upload-{tag}")
        lmd5 = md5_file(local)
        t0 = time.perf_counter(); s0 = sent()
        eng = UploadEngine(api)
        u = eng.upload(local, remote, rtype=3)
        ms = (time.perf_counter() - t0) * 1000
        ctl = sent() - s0
        data_req_total += u["data_requests"]; data_bytes_total += u["bytes_sent"]
        step(f"{tag}1", 0,
             f"upload {size/1024:.0f}KB rapid={u['rapid']} 数据面={u['data_requests']}发/"
             f"{u['bytes_sent']}B 块{u['blocks_uploaded']}/{u['blocks_total']} "
             f"rt={u.get('return_type')} {u['elapsed_s']}s",
             ms, control=ctl, data=u["data_requests"], dbytes=u["bytes_sent"])
        t0 = time.perf_counter(); s0 = sent()
        m = api.meta_by_path(remote)
        size_ok = int(m.get("size") or 0) == size
        rmd5 = (m.get("md5") or "").lower()
        md5_ok = rmd5 == lmd5          # 信息项：百度混淆 md5 可为 False（size 已硬验）
        step(f"{tag}2", 0,
             f"metas 核对 size={m.get('size')}/{size}匹配={size_ok} "
             f"md5(信息)={rmd5[:8]}…本地{lmd5[:8]}…匹配={md5_ok}",
             (time.perf_counter() - t0) * 1000, ok=size_ok, control=sent() - s0)
        return local, remote, lmd5, u

    local_1k, remote_1k, md5_1k, _ = upload_verify("b", "bdnw4_1k.bin", 1024)
    local_10m, remote_10m, md5_10m, _ = upload_verify("c", "bdnw4_10m.bin", 10 * 1024 * 1024)

    # ---- d. 200MB：中途 kill → 重跑续传 ----
    local_200 = os.path.join(TMP, "bdnw4_200m.bin")
    if not os.path.exists(local_200) or os.path.getsize(local_200) != 200 * 1024 * 1024:
        t0 = time.perf_counter()
        make_local("bdnw4_200m.bin", 200 * 1024 * 1024)
        print(f"# 造 200MB 测试文件 {local_200} ({time.perf_counter()-t0:.0f}s)")
    remote_200 = guard(f"{PREFIX}/bdnw4_200m_{RUNID}.bin", "upload-d")
    state_200 = local_200 + ".bdn_upload_state.json"

    t0 = time.perf_counter()
    child = subprocess.Popen(
        [sys.executable, BDN_PY, "upload", local_200, remote_200, "--json"],
        stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True,
        encoding="utf-8", cwd=REPLICA_DIR)
    killed_at = None
    deadline = time.time() + KILL_WAIT_S
    while time.time() < deadline:
        if child.poll() is not None:
            print(f"# 警告: 子进程提前结束 rc={child.returncode}（速度过快或失败）")
            break
        st = None
        try:
            with open(state_200, "r", encoding="utf-8") as f:
                st = json.load(f)
        except (OSError, ValueError):
            st = None
        if st and len(st.get("done") or []) >= KILL_AT_PARTS:
            child.kill()
            killed_at = len(st["done"])
            break
        time.sleep(2)
    else:
        child.kill()
        try:
            with open(state_200, "r", encoding="utf-8") as f:
                killed_at = len(json.load(f).get("done") or [])
        except (OSError, ValueError):
            killed_at = 0
    child.wait()
    p1_bytes = (killed_at or 0) * 4 * 1024 * 1024
    # 被杀段控制面无输出：按代码路径推算=precreate+locateupload 各1
    control_cli += 2
    step("d1", 0,
         f"kill@{killed_at}/50 片（p1≈{p1_bytes}B≈{p1_bytes/2**20:.0f}MB）",
         (time.perf_counter() - t0) * 1000, data=killed_at or 0, dbytes=p1_bytes)
    data_req_total += killed_at or 0
    data_bytes_total += p1_bytes

    t0 = time.perf_counter(); s0 = sent()
    eng = UploadEngine(api)
    u = eng.upload(local_200, remote_200, rtype=3)      # 断点续传（幂等）
    ms = (time.perf_counter() - t0) * 1000
    step("d2", 0,
         f"续传完成 resumed={u['resumed']} 本段数据面={u['data_requests']}发/"
         f"{u['bytes_sent']}B（全量209715200B，续传段占比"
         f"{u['bytes_sent']/209715200*100:.0f}%）{u['elapsed_s']}s",
         ms, control=sent() - s0, data=u["data_requests"], dbytes=u["bytes_sent"])
    data_req_total += u["data_requests"]; data_bytes_total += u["bytes_sent"]
    t0 = time.perf_counter(); s0 = sent()
    m = api.meta_by_path(remote_200)
    ok = int(m.get("size") or 0) == 200 * 1024 * 1024
    step("d3", 0, f"metas 核对 size={m.get('size')} 匹配={ok}",
         (time.perf_counter() - t0) * 1000, ok=ok, control=sent() - s0)

    # ---- e. 秒传实证：10MB 换名再传 ----
    local_10m_e = os.path.join(TMP, "bdnw4_10m_instant.bin")
    if not os.path.exists(local_10m_e):
        with open(local_10m_e, "wb") as f, open(local_10m, "rb") as src:
            f.write(src.read())
    remote_e = guard(f"{PREFIX}/bdnw4_10m_instant_{RUNID}.bin", "upload-e")
    t0 = time.perf_counter(); s0 = sent()
    eng = UploadEngine(api)
    u = eng.upload(local_10m_e, remote_e, rtype=3)
    step("e1", 0,
         f"秒传探测 return_type={u.get('return_type')} rapid={u['rapid']} "
         f"实际传输={u['bytes_sent']}B（预期0；miss=服务端md5混淆阻断索引，遗留）"
         f"数据面={u['data_requests']}发",
         (time.perf_counter() - t0) * 1000, ok=u["rapid"] and u["bytes_sent"] == 0,
         control=sent() - s0, data=u["data_requests"], dbytes=u["bytes_sent"])
    data_req_total += u["data_requests"]; data_bytes_total += u["bytes_sent"]

    # ---- f. 下载 10MB 回本地新名 + md5 比对 ----
    dl_dst = os.path.join(TMP, "bdnw4_dl_10m_back.bin")
    for p in (dl_dst, dl_dst + ".bdn_dl_state.json"):
        if os.path.exists(p):
            os.remove(p)
    t0 = time.perf_counter(); s0 = sent()
    eng = DownloadEngine(api)
    d = eng.download(remote_10m, dl_dst, expected_md5=md5_10m)
    step("f1", 0,
         f"下载10MB 块={d['chunks_this_run']}/{d['chunks_total']} md5_ok={d['md5_ok']} "
         f"{d['speed_mb_s']}MB/s 数据面={d['data_requests']}发/{d['bytes_received']}B "
         f"{d['elapsed_s']}s",
         (time.perf_counter() - t0) * 1000, ok=d["md5_ok"],
         control=sent() - s0, data=d["data_requests"], dbytes=d["bytes_received"])
    data_req_total += d["data_requests"]; data_bytes_total += d["bytes_received"]

    # ---- g. rename + mv + cp → ls 逐项核对 ----
    sub = guard(f"{PREFIX}/sub_dir_{RUNID}", "mkdir-g")
    t0 = time.perf_counter(); s0 = sent()
    r = api.mkdir(sub)
    step("g1", r.get("errno", 0), f"mkdir {sub}", (time.perf_counter() - t0) * 1000,
         control=sent() - s0)

    renamed = f"bdnw4_1k_renamed_{RUNID}.bin"
    t0 = time.perf_counter(); s0 = sent()
    r = api.rename(guard(remote_1k, "rename-src"), renamed)
    step("g2", r.get("errno", 0), f"rename → {renamed}",
         (time.perf_counter() - t0) * 1000, control=sent() - s0)

    t0 = time.perf_counter(); s0 = sent()
    r = api.move(guard(remote_10m, "mv-src"), guard(sub, "mv-dst"))
    step("g3", r.get("errno", 0), f"mv 10MB → {sub}",
         (time.perf_counter() - t0) * 1000, control=sent() - s0)

    name_10m = f"bdnw4_10m_{RUNID}.bin"
    t0 = time.perf_counter(); s0 = sent()
    r = api.copy(guard(f"{sub}/{name_10m}", "cp-src"), guard(PREFIX, "cp-dst"))
    step("g4", r.get("errno", 0), f"cp 10MB → {PREFIX}",
         (time.perf_counter() - t0) * 1000, control=sent() - s0)

    t0 = time.perf_counter(); s0 = sent()
    r = api.list_dir(PREFIX)
    names = [e["name"] for e in r.get("entries") or []]
    r2 = api.list_dir(sub)
    sub_names = [e["name"] for e in r2.get("entries") or []]
    ok = (renamed in names) and (name_10m in sub_names) \
        and (name_10m in names) and (f"bdnw4_1k_{RUNID}.bin" not in names)
    step("g5", 0,
         f"ls 核对: 根={sorted(names)} sub={sub_names} 逐项匹配={ok}",
         (time.perf_counter() - t0) * 1000, ok=ok, control=sent() - s0)

    # ---- h. rm --confirm 流（CLI 子进程）→ ls 消失 + recycle 确认 ----
    rm_target = guard(f"{PREFIX}/{renamed}", "rm")
    t0 = time.perf_counter()
    rc, payload = cli(["rm", rm_target])
    step("h1", payload.get("errno", "?") if payload else "?",
         f"rm 无--confirm → exit={rc}（应3）executed={payload.get('executed') if payload else '?'}",
         (time.perf_counter() - t0) * 1000, ok=rc == 3)
    t0 = time.perf_counter()
    rc, payload = cli(["rm", rm_target, "--confirm"])
    step("h2", payload.get("errno", "?") if payload else "?",
         f"rm --confirm → exit={rc} deleted={payload.get('deleted') if payload else '?'}",
         (time.perf_counter() - t0) * 1000, ok=rc == 0)
    t0 = time.perf_counter(); s0 = sent()
    r = api.list_dir(PREFIX)
    gone = renamed not in [e["name"] for e in r.get("entries") or []]
    step("h3", 0, f"ls 确认消失 gone={gone}", (time.perf_counter() - t0) * 1000,
         ok=gone, control=sent() - s0)
    t0 = time.perf_counter(); s0 = sent()
    r = api.recycle_list(page=1, num=100)
    in_recycle = renamed in json.dumps(r.get("entries") or [], ensure_ascii=False)
    step("h4", 0, f"recycle 确认进回收站={in_recycle}",
         (time.perf_counter() - t0) * 1000, ok=in_recycle, control=sent() - s0)

    # ---- 总账 ----
    lib_ctl = sess.requests_sent
    total_ctl = lib_ctl + control_cli
    print("\n# 控制面台账（库会话，路径级，零凭据）")
    for x in sess.request_log:
        print(f"  {x['method']:<4} {x['path']:<44} http={x['http']} "
              f"errno={x['errno']} {x['ms']}ms")
    print(f"\n# 控制面: 库会话{lib_ctl}发 + CLI子进程{control_cli}发(含被杀段按代码路径推算2发) "
          f"= {total_ctl}发（预算{CONTROL_BUDGET}，{'内' if total_ctl <= CONTROL_BUDGET else '超限!'}）")
    print(f"# 数据面: {data_req_total}发 / {data_bytes_total}B "
          f"(≈{data_bytes_total/2**20:.0f}MB)")
    print(f"# 熔断: {'开(' + sess._circuit_reason + ')' if sess.circuit_open else '闭合'}")
    ok_n = sum(1 for r in results if r["ok"])
    print(f"# 结论: {ok_n}/{len(results)} 项通过；总耗时{time.perf_counter()-t_all:.0f}s；"
          f"测试产物保留于云端 {PREFIX}/（零删除纪律，待用户处置）")
    return 0 if (ok_n == len(results) and total_ctl <= CONTROL_BUDGET) else 1


if __name__ == "__main__":
    try:
        sys.exit(main())
    except BdnCircuitOpen as e:
        print(f"\n# 熔断全停: {e}", file=sys.stderr)
        sys.exit(2)
