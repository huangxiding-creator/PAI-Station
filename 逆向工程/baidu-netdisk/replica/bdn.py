#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""bdn — 百度网盘 CLI（bdncore 之上；W3 只读 + W4 写命令与传输 + W5 路由/体检/镜像/分享）。

命令：whoami | quota | ls | tree | search | meta | shares | recycle | doctor
     | mkdir | rename | mv | cp | rm | upload | download
     | mirror | share-create | share-cancel | transfer
约定：全部支持 --json；远端路径一律 / 开头全盘绝对路径；
     退出码 0=成功 / 1=业务错 / 2=熔断或凭据错 / 3=rm 未加 --confirm（只列清单未执行）。
铁律：rm 必须显式 --confirm，执行前逐条打印待删清单；无 --confirm 只列清单退出 3；
     mirror 远端只增不删；share-cancel 仅用于取消自建分享。
"""
from __future__ import annotations

import argparse
import json
import os
import sys
import time

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")   # 防 GBK 控制台乱码
if hasattr(sys.stderr, "reconfigure"):
    sys.stderr.reconfigure(encoding="utf-8")

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from bdncore import (BdnApi, BdnApiError, BdnError, BdnSession,  # noqa: E402
                     DownloadEngine, MirrorEngine, PullEngine, RoutedApi,
                     UploadEngine, mask, run_doctor)


def human_size(n) -> str:
    try:
        n = float(n or 0)
    except (TypeError, ValueError):
        return "-"
    for unit in ("B", "KB", "MB", "GB", "TB", "PB"):
        if n < 1024 or unit == "PB":
            return f"{n:.2f}{unit}" if unit != "B" else f"{int(n)}B"
        n /= 1024


def _emit(args, payload: dict):
    if getattr(args, "json", False):
        print(json.dumps(payload, ensure_ascii=False, indent=2))
    return payload


def _cred_summary(sess: BdnSession) -> dict:
    return {"cred_path": sess.cred_path, "bduss": mask(sess.bduss),
            "stoken": mask(sess.stoken), "ua": sess.ua}


# ---------------- 命令实现 ----------------

def cmd_whoami(api, args):
    r = api.login_status()
    info = r.get("account") or {}
    _emit(args, info)
    if not args.json:
        print(f"账号: {info.get('username')}  uk={info.get('uk')}  "
              f"VIP{info.get('vip_level')}(type={info.get('vip_type')})  "
              f"bdstoken=<masked>")
    return info


def cmd_quota(api, args):
    r = api.quota()
    total, used = r.get("total", 0), r.get("used", 0)
    info = {"total": total, "used": used, "free": total - used,
            "total_h": human_size(total), "used_h": human_size(used),
            "free_h": human_size(total - used)}
    _emit(args, info)
    if not args.json:
        print(f"总容量 {info['total_h']}  已用 {info['used_h']}  剩余 {info['free_h']}")
    return info


def cmd_ls(api, args):
    r = api.list_dir(args.path, page=args.page, num=args.num)
    entries = r.get("entries") or []
    info = {"dir": args.path, "count": len(entries),
            "entries": [{"isdir": e["isdir"], "size": e["size"],
                         "name": e["name"], "fs_id": e["fs_id"]} for e in entries]}
    _emit(args, info)
    if not args.json:
        for e in entries:
            mark = "d" if e["isdir"] else "-"
            print(f"{mark} {human_size(e['size']):>10}  {e['name']}")
        print(f"共 {len(entries)} 项（{args.path}）")
    return info


def cmd_tree(api, args):
    t = api.tree(args.path, depth=args.depth, max_requests=args.max_requests,
                 num=args.num)

    def walk(nodes, indent=0):
        for n in nodes:
            mark = "d" if n["isdir"] else "-"
            tip = " …(深度剪枝)" if n.get("pruned_depth") else ""
            print(f"{'  ' * indent}{mark} {n['name']}{tip}")
            if n.get("children"):
                walk(n["children"], indent + 1)

    if not args.json:
        walk(t["tree"])
    info = {"root": t["root"], "nodes": t["nodes"], "dirs": t["dirs"],
            "requests": t["requests"], "truncated": t["truncated"],
            "depth_limit": t["depth_limit"], "max_depth_reached": t["max_depth_reached"],
            "tree": t["tree"]}
    _emit(args, info)
    if not args.json:
        note = "（预算截断）" if t["truncated"] else ""
        print(f"共 {t['nodes']} 节点/{t['dirs']} 目录, 请求 {t['requests']} 发, "
              f"深度≤{t['depth_limit']}{note}")
    return info


def cmd_search(api, args):
    r = api.search(args.key, dir_path=args.dir,
                   recursion=0 if args.no_recursion else 1, num=args.num)
    entries = r.get("entries") or []
    info = {"key": args.key, "dir": args.dir,
            "recursion": 0 if args.no_recursion else 1,
            "count": len(entries),
            "entries": [{"path": e["path"], "size": e["size"],
                         "isdir": e["isdir"]} for e in entries]}
    _emit(args, info)
    if not args.json:
        for e in entries:
            print(f"{'d' if e['isdir'] else '-'} {human_size(e['size']):>10}  {e['path']}")
        print(f"命中 {len(entries)} 条（key={args.key}）")
    return info


def cmd_meta(api, args):
    fsids = []
    for part in args.fsids:
        fsids.extend(int(x) for x in str(part).split(",") if str(x).strip())
    r = api.metas(fsids)
    entries = r.get("entries") or []
    info = {"fsids": fsids, "source": r.get("_source"), "count": len(entries),
            "entries": [{"fs_id": e["fs_id"], "path": e["path"],
                         "size": e["size"], "isdir": e["isdir"],
                         "category": e["category"]} for e in entries]}
    _emit(args, info)
    if not args.json:
        for e in entries:
            print(f"fs_id={e['fs_id']}  {'d' if e['isdir'] else '-'}"
                  f" {human_size(e['size']):>10}  {e['path']}")
        print(f"{len(entries)} 条元信息（来源 {r.get('_source')}）")
    return info


def cmd_shares(api, args):
    r = api.share_records(page=args.page)
    entries = r.get("entries") or []
    info = {"page": args.page, "count": len(entries), "entries": entries}
    _emit(args, info)
    if not args.json:
        for e in entries:
            print(f"shareid={e['shareid']}  提取码={e['passwd'] or '无'}  "
                  f"看{e['views']}/下{e['downloads']}  {e['typical_path']}")
            print(f"    {e['shortlink']}")
        print(f"共 {len(entries)} 条分享记录（第 {args.page} 页）")
    return info


def cmd_recycle(api, args):
    r = api.recycle_list(page=args.page, num=args.num)
    entries = r.get("entries") or []
    rows = [{"fs_id": e.get("fs_id"),
             "name": e.get("server_filename") or e.get("filename") or e.get("name"),
             "size": e.get("size"), "isdir": bool(e.get("isdir", 0))} for e in entries]
    info = {"page": args.page, "count": len(rows), "entries": rows}
    _emit(args, info)
    if not args.json:
        for e in rows:
            print(f"{'d' if e['isdir'] else '-'} {human_size(e['size']):>10}  {e['name']}")
        print(f"回收站 {len(rows)} 项（第 {args.page} 页）")
    return info


# ---------------- W7：回收站写面 / pull / clean ----------------

def _recycle_find(api, target: str) -> dict:
    """fsid 或路径 → 回收站条目（路径=在回收站列表中按 path 尾段匹配）。"""
    if str(target).isdigit():
        want = int(target)
        for page in range(1, 4):                       # 翻 ≤3 页护栏
            r = api.recycle_list(page=page, num=200)
            for e in r.get("entries") or []:
                if int(e.get("fs_id") or 0) == want:
                    return e
            if len(r.get("entries") or []) < 200:
                break
        raise BdnApiError(-9, f"回收站中无此 fs_id: {target}")
    # 路径形态：按 path 匹配（回收站条目带原始 path）
    tgt = str(target).rstrip("/")
    for page in range(1, 4):
        r = api.recycle_list(page=page, num=200)
        for e in r.get("entries") or []:
            if (e.get("path") or "").rstrip("/") == tgt:
                return e
        if len(r.get("entries") or []) < 200:
            break
    raise BdnApiError(-9, f"回收站中无此路径: {target}")


def _recycle_row(e: dict) -> dict:
    return {"fs_id": e.get("fs_id"), "path": e.get("path"),
            "name": e.get("server_filename") or e.get("filename") or e.get("name"),
            "size": e.get("size"), "isdir": bool(e.get("isdir", 0))}


def cmd_recycle_restore(api, args):
    """回收站还原（双确认：先列目标清单，--confirm 才执行；未加=退出码 3）。"""
    sent0 = api.s.requests_sent
    e = _recycle_find(api, args.target)
    row = _recycle_row(e)
    print("# 待还原清单（回收站 → 原位置）:")
    print(f"  {'d' if row['isdir'] else '-'} fs_id={row['fs_id']}  "
          f"{human_size(row['size']):>10}  {row['path']}")
    if not args.confirm:
        info = {"errno": 0, "executed": False, "exit": 3,
                "entries": [row], "requests": api.s.requests_sent - sent0,
                "note": "未加 --confirm：只列清单，未执行任何还原"}
        _emit(args, info)
        if not args.json:
            print("未加 --confirm，未执行（退出码 3）")
        return 3
    r = api.recycle_restore([row["fs_id"]])
    info = {"errno": r.get("errno", 0), "executed": True,
            "restored": [row["fs_id"]], "entries": [row],
            "response": r, "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        ok = info["errno"] == 0
        print(f"{'已还原' if ok else '还原失败 errno=' + str(info['errno'])}: "
              f"{row['path']}（fs_id={row['fs_id']}）")
    return 0 if info["errno"] == 0 else 1


def cmd_recycle_delete(api, args):
    """回收站彻底删除（不可逆；必须 --confirm）。"""
    sent0 = api.s.requests_sent
    e = _recycle_find(api, args.target)
    row = _recycle_row(e)
    print("# 待彻底删除清单（**不可逆**，回收站直接抹除）:")
    print(f"  {'d' if row['isdir'] else '-'} fs_id={row['fs_id']}  "
          f"{human_size(row['size']):>10}  {row['path']}")
    if not args.confirm:
        info = {"errno": 0, "executed": False, "exit": 3,
                "entries": [row], "requests": api.s.requests_sent - sent0,
                "note": "未加 --confirm：只列清单，未执行任何删除"}
        _emit(args, info)
        if not args.json:
            print("未加 --confirm，未执行（退出码 3）")
        return 3
    r = api.recycle_delete([row["fs_id"]])
    info = {"errno": r.get("errno", 0), "executed": True,
            "deleted": [row["fs_id"]], "entries": [row],
            "response": r, "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        print(f"彻底删除 errno={info['errno']}: {row['path']}")
    return 0 if info["errno"] == 0 else 1


def cmd_recycle_clear(api, args):
    """清空回收站（整箱不可逆）——默认拒绝；仅 --i-mean-it 才执行（本战役不活测）。"""
    if not args.i_mean_it:
        info = {"errno": 0, "executed": False, "exit": 3,
                "note": "清空回收站=整箱不可逆：默认拒绝。确认整箱清空请加 --i-mean-it"}
        _emit(args, info)
        if not args.json:
            print(info["note"])
        return 3
    r = api.recycle_clear()
    info = {"errno": r.get("errno", 0), "executed": True, "response": r}
    _emit(args, info)
    return 0 if info["errno"] == 0 else 1


def cmd_pull(api, args):
    """pull 恢复腿：远端目录 → 本地（mirror 反向件；本地多余只报告不删）。"""
    eng = PullEngine(api, max_scan_requests=args.max_scan_requests)
    r = eng.run(args.remote, args.local, dry_run=args.dry_run)
    _emit(args, r)
    if not args.json:
        head = "dry-run 计划" if args.dry_run else "拉取完成"
        print(f"{head}: {args.remote} → {args.local}")
        print(f"  远端 {r['remote_files']} 文件/{human_size(r['bytes_total'])} "
              f"扫描 {r['scan_used']}/{r['scan_limit']} 发"
              + ("（预算耗尽截断）" if r["scan_truncated"] else ""))
        print(f"  下载 {r['downloads_done']}/{r['downloads_planned']} "
              f"({human_size(r['bytes_received'])}, 数据面 {r['data_requests']} 发) "
              f"未变 {r['unchanged']}")
        if r["local_only_count"]:
            print(f"  本地多余 {r['local_only_count']} 项（**只报告不删**，样本 "
                  f"{r['local_only_sample'][:5]}）")
        if r["unscanned_count"]:
            print(f"  未扫目录 {r['unscanned_count']} 个（详见 --json unscanned_dirs）")
        if r["downloads_failed"]:
            print(f"  失败 {len(r['downloads_failed'])} 件（详见 --json）")
    return 0 if not r["downloads_failed"] else 1


# bdn clean 残留状态件清单/清理（W7 B9；对齐删除铁律：--confirm 才删）
_RESIDUE_PATTERNS = (".bdn_upload_state.json", ".bdn_dl_state.json")


def _scan_residue(root: str) -> list:
    import re
    mirror_re = re.compile(r"^\.bdn_mirror_[0-9a-f]{8}\.json$")
    out = []
    for dirpath, _dirnames, filenames in os.walk(root):
        for fn in filenames:
            full = os.path.join(dirpath, fn)
            kind = None
            if fn.endswith(_RESIDUE_PATTERNS):
                kind = "transfer_state"
            elif mirror_re.match(fn):
                kind = "mirror_state"
            elif fn == ".bdn_circuit.json":
                kind = "circuit_marker"
            if kind:
                try:
                    sz = os.path.getsize(full)
                except OSError:
                    sz = -1
                out.append({"path": full, "kind": kind, "size": sz})
    return out


def cmd_clean(api, args):
    """bdn clean：列本地残留状态件；--confirm 才删（无网络零请求，api 不用）。"""
    rows = _scan_residue(args.dir)
    print(f"# 残留状态文件清单（{args.dir} 下共 {len(rows)} 件）:")
    for r in rows:
        print(f"  [{r['kind']:<15}] {human_size(r['size']):>10}  {r['path']}")
    if not rows:
        info = {"errno": 0, "count": 0, "deleted": [], "note": "无残留"}
        _emit(args, info)
        return 0
    if not args.confirm:
        info = {"errno": 0, "executed": False, "exit": 3, "count": len(rows),
                "entries": rows,
                "note": "未加 --confirm：只列清单，未删除任何文件"}
        _emit(args, info)
        if not args.json:
            print(f"共 {len(rows)} 件；未加 --confirm，未删除（退出码 3）")
        return 3
    deleted, failed = [], []
    for r in rows:
        try:
            os.remove(r["path"])
            deleted.append(r["path"])
        except OSError as e:
            failed.append({"path": r["path"], "error": str(e)})
    info = {"errno": 0 if not failed else 1, "executed": True,
            "count": len(rows), "deleted": deleted, "failed": failed}
    _emit(args, info)
    if not args.json:
        print(f"已删除 {len(deleted)}/{len(rows)} 件断点残留"
              + (f"；失败 {len(failed)} 件" if failed else ""))
    return 0 if not failed else 1


def cmd_doctor(api, args):
    """W5 复验器：八针体检（凭据活性/读探针/配额/协议指纹漂移）→ ok/degraded/dead。
    W7 B8：--reset 先清跨进程熔断标记（内存+标记文件双清）再体检。"""
    sess = api.s
    reset_info = None
    if getattr(args, "reset", False):
        reset_info = sess.reset_circuit()
        if not args.json:
            prev = reset_info["previous_reason"] or "无"
            print(f"熔断复位: 标记文件删除={reset_info['marker_removed']} "
                  f"（此前: {prev}）")
    rep = run_doctor(api)
    if reset_info is not None:
        rep["circuit_reset"] = reset_info
    rep["credentials"] = _cred_summary(sess)
    rep["requests_total_session"] = sess.requests_sent
    _emit(args, rep)
    if not args.json:
        print(f"体检结论: {rep['verdict']}  控制面 {rep['requests_sent']} 发  "
              f"熔断={'开' if rep['circuit_open'] else '闭'}  "
              f"凭据: bduss={mask(sess.bduss)} stoken={mask(sess.stoken)}")
        for name, c in rep["checks"].items():
            bits = [f"{k}={c[k]}" for k in ("errno", "ms", "entries", "count",
                                            "servers", "return_type")
                    if k in c]
            print(f"  [{c['status']:<8}] {name:<22} {' '.join(bits)}")
        for fp in rep["fingerprints"]:
            if fp["status"] != "ok":
                print(f"  指纹漂移: {fp['probe']} 缺 {fp['missing'] or fp['sub_missing']}")
        if rep["drift"]:
            print(f"  漂移项 {len(rep['drift'])} 条（详见 --json）")
    return 0 if rep["verdict"] != "dead" else 1


# ---------------- 写命令（W4） ----------------

def cmd_mkdir(api, args):
    sent0 = api.s.requests_sent
    r = api.mkdir(args.path)
    info = {"errno": r.get("errno", 0), "path": args.path,
            "exists": bool(r.get("exists")),
            "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        print(f"{'已存在（幂等）' if info['exists'] else '已创建'}: {args.path}")
    return info


def cmd_rename(api, args):
    sent0 = api.s.requests_sent
    r = api.rename(args.path, args.newname)
    info = {"errno": r.get("errno", 0), "path": args.path, "newname": args.newname,
            "info": r.get("info"), "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        print(f"已重命名: {args.path} → {args.newname}")
    return info


def _mv_cp(api, args, op):
    sent0 = api.s.requests_sent
    r = api.move(args.src, args.dst) if op == "move" else api.copy(args.src, args.dst)
    info = {"errno": r.get("errno", 0), "op": op, "src": args.src, "dst": args.dst,
            "info": r.get("info"), "taskid": r.get("taskid"),
            "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        task = f"（异步任务 taskid={r.get('taskid')}）" if r.get("taskid") else ""
        print(f"已{('移动' if op == 'move' else '复制')}: {args.src} → {args.dst}{task}")
    return info


def cmd_mv(api, args):
    return _mv_cp(api, args, "move")


def cmd_cp(api, args):
    return _mv_cp(api, args, "copy")


def _resolve_paths(api, paths):
    """逐条解析远端路径 → 待操作清单（ls 父目录定位 fs_id/size）。找不到的标记 missing。"""
    rows = []
    for p in paths:
        if not p.startswith("/"):
            raise BdnError(f"远端路径必须以 / 开头: {p!r}")
        parent, _, name = p.rstrip("/").rpartition("/")
        parent = parent or "/"
        row = {"path": p, "name": name, "fs_id": None, "size": None,
               "missing": True}
        try:
            r = api.list_dir(parent)
            for e in r.get("entries") or []:
                if e.get("name") == name:
                    row.update({"fs_id": e["fs_id"], "size": e["size"],
                                "isdir": e["isdir"], "missing": False})
                    break
        except BdnError:
            pass                          # 父目录列不出 → 保持 missing，删除阶段会报
        rows.append(row)
    return rows


def cmd_rm(api, args):
    """rm 铁律：无 --confirm 只列清单退出 3；有 --confirm 先打印清单再执行。"""
    sent0 = api.s.requests_sent
    rows = _resolve_paths(api, args.paths)
    print("# 待删清单（删除=移入回收站）:")
    for row in rows:
        mark = "?" if row["missing"] else ("d" if row.get("isdir") else "-")
        print(f"  {mark} fs_id={row['fs_id']}  {human_size(row['size']):>10}  {row['path']}")
    if not args.confirm:
        info = {"errno": 0, "executed": False, "exit": 3, "count": len(rows),
                "entries": rows, "requests": api.s.requests_sent - sent0,
                "note": "未加 --confirm：只列清单，未执行任何删除"}
        _emit(args, info)
        if not args.json:
            print(f"共 {len(rows)} 条；未加 --confirm，未执行（退出码 3）")
        return 3                            # main 以返回值为退出码
    targets = [row["path"] for row in rows if not row["missing"]]
    missing = [row["path"] for row in rows if row["missing"]]
    r = api.delete(targets) if targets else {"errno": 0, "info": []}
    info = {"errno": r.get("errno", 0), "executed": bool(targets),
            "deleted": targets, "missing_skipped": missing,
            "info": r.get("info"), "taskid": r.get("taskid"),
            "count": len(targets), "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        print(f"已删除 {len(targets)} 条（回收站可还原）；跳过缺失 {len(missing)} 条")
    return info


def cmd_upload(api, args):
    sent0 = api.s.requests_sent
    eng = UploadEngine(api, allow_empty=args.allow_empty)
    try:
        r = eng.upload(args.local, args.remote, rtype=3)
    finally:
        eng.close()  # judge W7-#1：短命进程无害，长命宿主防连接池积累
    r["control_requests"] = api.s.requests_sent - sent0
    r["requests"] = api.s.requests_sent - sent0
    _emit(args, r)
    if not args.json:
        kind = "秒传（零传输）" if r["rapid"] else "三段上传"
        print(f"{kind}: {args.local} → {args.remote} "
              f"size={human_size(r['size'])} 数据面={r['data_requests']}发/"
              f"{human_size(r['bytes_sent'])} 用时{r['elapsed_s']}s")
    return r


def cmd_download(api, args):
    sent0 = api.s.requests_sent
    eng = DownloadEngine(api)
    uid = None
    if args.svip:
        acc = (api.login_status().get("account") or {})
        uid = acc.get("uk")
    try:
        r = eng.download(args.remote, args.local, use_locatedl=args.svip, uid=uid)
    finally:
        eng.close()  # judge W7-#1：同 upload
    r["control_requests"] = api.s.requests_sent - sent0
    r["requests"] = api.s.requests_sent - sent0
    _emit(args, r)
    if not args.json:
        src = r.get("dlink_source") or "web_dlink"
        print(f"已下载[{src}]: {args.remote} → {args.local} "
              f"size={human_size(r['size'])} 块={r['chunks_this_run']}/{r['chunks_total']} "
              f"md5校验={'通过' if r['md5_ok'] else '未比对'} "
              f"{r['speed_mb_s']}MB/s 用时{r['elapsed_s']}s")
    return r


# ---------------- W5：镜像 / 分享 / 转存 ----------------

def guard_mirror_remote(remote: str, allow_root: bool = False):
    """W6 judge #3 远端目标护栏：remote 为 / 或一级根目录时拒绝——防误把镜像
    铺到根（MirrorEngine 远端只增不删，铺根=大面积污染难回收）。--allow-root 放行。
    纯客户端判定，零请求发出。"""
    if not isinstance(remote, str) or not remote.startswith("/"):
        raise BdnApiError(-7, f"远端路径必须以 / 开头: {remote!r}")
    segs = [s for s in remote.split("/") if s]
    if not allow_root and len(segs) <= 1:
        raise BdnApiError(
            -7, f"镜像远端目标过浅: {remote!r}（/ 或一级根目录拒绝，防误铺根；"
            "确需请加 --allow-root）")


def cmd_mirror(api, args):
    guard_mirror_remote(args.remote, getattr(args, "allow_root", False))
    eng = MirrorEngine(api, max_scan_requests=args.max_scan_requests)
    r = eng.run(args.local, args.remote, dry_run=args.dry_run)
    _emit(args, r)
    if not args.json:
        head = "dry-run 计划" if args.dry_run else "镜像完成"
        print(f"{head}: {args.local} → {args.remote}")
        print(f"  本地 {r['files_scanned']} 文件/{human_size(r['bytes_total'])} "
              f"(md5 重哈希 {r['md5_rehashed']})  远端扫描 {r['remote_scan_requests']} 发"
              + (f"（预算耗尽 {r['scan_used']}/{r['scan_limit']}，未扫 "
                 f"{r['unscanned_count']} 目录）" if r["scan_truncated"] else ""))
        print(f"  上传 {r['uploads_done']}/{r['uploads_planned']} "
              f"({human_size(r['bytes_uploaded'])}, 数据面 {r['data_requests']} 发) "
              f"未变 {r['unchanged']} 补账 {r['assumed_unchanged']} "
              f"空文件跳过 {len(r['zero_byte_skipped'])}")
        if r["remote_only_count"]:
            print(f"  远端多余 {r['remote_only_count']} 项（**只报告不删**，样本 "
                  f"{r['remote_only_sample'][:5]}）")
        if r["dirs_created"]:
            print(f"  建目录 {len(r['dirs_created'])} 段")
        if r["uploads_failed"]:
            print(f"  失败 {len(r['uploads_failed'])} 件（详见 --json）")
    return 0 if not r["uploads_failed"] else 1


def cmd_share_create(api, args):
    """创建分享（≤2 发：蓝本形态被参数拒时换 web 形态一次）。"""
    sent0 = api.s.requests_sent
    attempts, payload, err = [], None, None
    for variant in (0, 1):
        try:
            payload = api.share_create(args.path, pwd=args.pwd or "",
                                       period=args.period, variant=variant)
            attempts.append({"variant": variant, "errno": payload.get("errno", 0)})
            err = None
            break
        except BdnApiError as e:
            attempts.append({"variant": variant, "errno": e.errno})
            err = e
            if e.errno not in (2, -7):        # 非形态问题（风控/下线）不换形态硬闯
                break
    info = {"errno": (payload or {}).get("errno", getattr(err, "errno", None)),
            "path": args.path,
            "shareid": (payload or {}).get("shareid") or (payload or {}).get("shareId"),
            "link": (payload or {}).get("link") or (payload or {}).get("shortlink")
            or (payload or {}).get("short_url"),
            "period": args.period,
            "pwd": mask(args.pwd) if args.pwd else "",
            "attempts": attempts, "attempts_sent": len(attempts),
            "requests": api.s.requests_sent - sent0}
    if payload:
        info["response"] = {k: v for k, v in payload.items()}   # 无凭据字段
    _emit(args, info)
    if not args.json:
        if info["errno"] == 0:
            print(f"已创建分享: {info['link']}  shareid={info['shareid']}  "
                  f"提取码={info['pwd'] or '无'}  period={info['period']}")
        else:
            print(f"创建失败: errno={info['errno']}（{len(attempts)} 发；"
                  f"详见 --json）")
    return 0 if info["errno"] == 0 else 1


def cmd_share_cancel(api, args):
    """取消分享（W6 judge #1 属主护栏）：执行前 share_records() 校验目标 shareid
    ∈ 本账号自建列表（对齐 cmd_transfer 的记录校验模式）；任一非自建 → 打印该 id
    归属信息并退出码 3，零取消请求发出（对齐 rm 无 --confirm 的「只列不执行」语义）。"""
    sent0 = api.s.requests_sent
    recs = api.share_records()
    mine = {e["shareid"]: e for e in recs.get("entries") or []}
    rejected = []
    for x in args.shareids:
        if int(x) not in mine:
            rejected.append({
                "shareid": int(x), "in_my_records": False,
                "ownership": "不在本账号分享记录中（非自建或已失效——拒绝执行）"})
    if rejected:
        info = {"errno": -9, "executed": False, "exit": 3,
                "cancelled": [], "rejected": rejected,
                "requests": api.s.requests_sent - sent0,
                "note": "属主护栏：目标 shareid 不在本账号分享记录，未执行任何取消"}
        _emit(args, info)
        if not args.json:
            for row in rejected:
                print(f"  拒绝 shareid={row['shareid']}: {row['ownership']}")
            print(f"属主护栏拦截 {len(rejected)} 条；未执行（退出码 3）")
        return 3
    r = api.share_cancel(args.shareids)
    info = {"errno": r.get("errno", 0), "cancelled": [int(x) for x in args.shareids],
            "response": r, "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        print(f"已取消分享 {info['cancelled']}（errno={info['errno']}）")
    return 0 if info["errno"] == 0 else 1


def _extract_pwd(payload) -> str:
    """从 surlinfoinrecord 响应中容错提取提取码（形态待活测定型；输出侧须掩码）。"""
    def walk(o):
        if isinstance(o, dict):
            for k, v in o.items():
                if str(k).lower() in ("passwd", "pwd") and isinstance(v, str) and v:
                    return v
                got = walk(v)
                if got:
                    return got
        elif isinstance(o, list):
            for x in o:
                got = walk(x)
                if got:
                    return got
        return ""
    return walk(payload)


def cmd_transfer(api, args):
    """转存自有分享 → 远端目录（旧链：记录解析→取码→verify→list→transfer；≤2 发 transfer）。"""
    sent0 = api.s.requests_sent
    surl = BdnApi.surl_from_link(args.share)
    recs = api.share_records()
    rec = next((e for e in recs.get("entries") or []
                if BdnApi.surl_from_link(e.get("shortlink") or "") == surl), None)
    if rec is None:
        raise BdnApiError(-9, f"分享 {args.share} 不在本账号分享记录中"
                             "（本版转存限自有分享；他人分享需 share 页抓取腿，W6+）")
    shareid = rec["shareid"]
    pwd = args.pwd or ""
    pwd_source = "--pwd"
    if not pwd:
        try:                                   # 详情端点生死未证（W5 首测）——失败不拦链
            pwd = _extract_pwd(api.share_surl_info(shareid))
            pwd_source = "surlinfoinrecord"
        except BdnError:
            pwd, pwd_source = "", "surlinfoinrecord(未取到,空码直试)"
    ls = api.login_status()
    acc = ls.get("account") or {}
    uk = rec.get("uk") or acc.get("uk")
    bdstoken = (ls.get("login_info") or {}).get("bdstoken") or None

    v = api.share_verify(shareid, uk, pwd, bdstoken=bdstoken)
    randsk = v.get("randsk") or ""
    try:
        sl = api.share_list(surl, randsk=randsk or None)
    except BdnApiError:
        full_tail = str(args.share).rstrip("/").rsplit("/s/", 1)[-1]
        if full_tail and full_tail != surl:      # 前导 '1' 口径二择（蓝本去 1 先试）
            sl = api.share_list(full_tail, randsk=randsk or None)
        else:
            raise
    entries = [e for e in (sl.get("list") or []) if e.get("fs_id")]
    files = [e for e in entries if not int(e.get("isdir") or 0)] or entries
    fsids = [int(e["fs_id"]) for e in (files if args.all else files[:1])]
    if not fsids:
        raise BdnApiError(-9, f"分享列表为空: {args.share}")
    try:
        r = api.share_transfer(fsids, args.remote, shareid=shareid,
                               share_uk=uk, randsk=randsk or None,
                               bdstoken=bdstoken or None)
    except BdnApiError as e:
        # W6：失败也回 JSON（errno+响应原文可归档——复测失败曾因异常路径吞 payload）
        r = {"errno": e.errno, "error": str(e),
             "payload": getattr(e, "payload", None)}
    info = {"errno": r.get("errno", 0), "share": args.share, "surl": surl,
            "shareid": shareid, "pwd": mask(pwd) if pwd else "",
            "pwd_source": pwd_source, "remote": args.remote,
            "fsidlist": fsids, "transferred": len(fsids),
            "response": r, "requests": api.s.requests_sent - sent0}
    _emit(args, info)
    if not args.json:
        print(f"转存 errno={info['errno']}: {args.share} → {args.remote} "
              f"({len(fsids)} 项; 提取码来源 {pwd_source}={info['pwd'] or '无'})")
    return 0 if info["errno"] == 0 else 1


# ---------------- 参数与入口 ----------------

def build_parser() -> argparse.ArgumentParser:
    p = argparse.ArgumentParser(
        prog="bdn", description="百度网盘 CLI（bdncore W3 只读 + W4 写/传输）—— 全盘绝对路径，/ 开头")
    p.add_argument("--cred", default=None, help="凭据 JSON 路径（默认环境变量 BDN_CREDENTIALS 或内置路径）")
    sub = p.add_subparsers(dest="cmd", required=True)

    def common(sp):
        sp.add_argument("--json", action="store_true", help="输出 JSON")

    sp = sub.add_parser("whoami", help="登录态/账号画像")
    common(sp); sp.set_defaults(fn=cmd_whoami)

    sp = sub.add_parser("quota", help="网盘配额（只读语义）")
    common(sp); sp.set_defaults(fn=cmd_quota)

    sp = sub.add_parser("ls", help="列目录（/api/list，翻页保护 num≤1000）")
    sp.add_argument("path", nargs="?", default="/", help="远端绝对路径，如 / 或 /来自：分享")
    sp.add_argument("--page", type=int, default=1)
    sp.add_argument("--num", type=int, default=1000)
    common(sp); sp.set_defaults(fn=cmd_ls)

    sp = sub.add_parser("tree", help="递归树（默认深度≤3，带请求预算）")
    sp.add_argument("path", nargs="?", default="/")
    sp.add_argument("--depth", type=int, default=3)
    sp.add_argument("--max-requests", type=int, default=20)
    sp.add_argument("--num", type=int, default=1000)
    common(sp); sp.set_defaults(fn=cmd_tree)

    sp = sub.add_parser("search", help="搜索（xpan，默认递归）")
    sp.add_argument("key", help="关键词")
    sp.add_argument("--dir", default="/", help="限定目录（默认全盘 /）")
    sp.add_argument("--no-recursion", action="store_true", help="不递归")
    sp.add_argument("--num", type=int, default=100)
    common(sp); sp.set_defaults(fn=cmd_search)

    sp = sub.add_parser("meta", help="文件元信息（fs_id 列表）")
    sp.add_argument("fsids", nargs="+", help="fs_id，空格或逗号分隔")
    common(sp); sp.set_defaults(fn=cmd_meta)

    sp = sub.add_parser("shares", help="我的分享记录（只读）")
    sp.add_argument("--page", type=int, default=1)
    common(sp); sp.set_defaults(fn=cmd_shares)

    sp = sub.add_parser("recycle", help="回收站（默认列表；restore/delete/clear 写面子命令）")
    sp.add_argument("--page", type=int, default=1)
    sp.add_argument("--num", type=int, default=100)
    common(sp); sp.set_defaults(fn=cmd_recycle)
    rsub = sp.add_subparsers(dest="recycle_cmd")
    rsp = rsub.add_parser("restore", help="还原回收站条目（双确认：先列清单，--confirm 才执行）")
    rsp.add_argument("target", help="fs_id 或原始路径（/ 开头）")
    rsp.add_argument("--confirm", action="store_true")
    common(rsp); rsp.set_defaults(fn=cmd_recycle_restore, page=1, num=100)
    rsp = rsub.add_parser("delete", help="彻底删除回收站条目（不可逆，必须 --confirm）")
    rsp.add_argument("target", help="fs_id 或原始路径")
    rsp.add_argument("--confirm", action="store_true")
    common(rsp); rsp.set_defaults(fn=cmd_recycle_delete, page=1, num=100)
    rsp = rsub.add_parser("clear", help="清空回收站（整箱不可逆；默认拒绝，仅 --i-mean-it）")
    rsp.add_argument("--i-mean-it", dest="i_mean_it", action="store_true")
    common(rsp); rsp.set_defaults(fn=cmd_recycle_clear)

    sp = sub.add_parser("doctor", help="链路体检（W5 复验器：八针+协议指纹漂移，全只读）")
    sp.add_argument("--reset", action="store_true",
                    help="先清跨进程熔断标记（凭据同目录 .bdn_circuit.json）再体检")
    common(sp); sp.set_defaults(fn=cmd_doctor)

    # ---- 写命令（W4）----
    sp = sub.add_parser("mkdir", help="新建目录（xpan create isdir=1；已存在=幂等）")
    sp.add_argument("path", help="远端绝对路径，如 /API复刻测试_1029")
    common(sp); sp.set_defaults(fn=cmd_mkdir)

    sp = sub.add_parser("rename", help="重命名（同目录，newname 为纯文件名）")
    sp.add_argument("path", help="远端绝对路径")
    sp.add_argument("newname", help="新文件名（不带路径）")
    common(sp); sp.set_defaults(fn=cmd_rename)

    sp = sub.add_parser("mv", help="移动到目标目录（ondup=newcopy）")
    sp.add_argument("src", help="远端源路径")
    sp.add_argument("dst", help="目标目录（远端绝对路径）")
    common(sp); sp.set_defaults(fn=cmd_mv)

    sp = sub.add_parser("cp", help="复制到目标目录（ondup=newcopy）")
    sp.add_argument("src", help="远端源路径")
    sp.add_argument("dst", help="目标目录（远端绝对路径）")
    common(sp); sp.set_defaults(fn=cmd_cp)

    sp = sub.add_parser("rm", help="删除（进回收站）。铁律：必须 --confirm 才执行；"
                                   "否则只列待删清单退出码 3")
    sp.add_argument("paths", nargs="+", help="远端绝对路径（多条）")
    sp.add_argument("--confirm", action="store_true",
                    help="显式确认执行删除（无此旗标只列清单）")
    common(sp); sp.set_defaults(fn=cmd_rm)

    sp = sub.add_parser("upload", help="上传（三段+秒传+断点续传；分片并发≤8）")
    sp.add_argument("local", help="本地文件路径")
    sp.add_argument("remote", help="远端绝对路径（含文件名）")
    sp.add_argument("--allow-empty", dest="allow_empty", action="store_true",
                    help="放行 0 字节文件（precreate 恒定 md5 d41d8…+空 block_list）")
    common(sp); sp.set_defaults(fn=cmd_upload)

    sp = sub.add_parser("download", help="下载（dlink+Range 多线程≤8+分片4MB+md5 校验+断点续传）")
    sp.add_argument("remote", help="远端绝对路径")
    sp.add_argument("local", help="本地落盘路径")
    sp.add_argument("--svip", action="store_true",
                    help="走安卓腿 locatedownload 直链（LocateDownloadSign；失败自动回退 dlink）")
    common(sp); sp.set_defaults(fn=cmd_download)

    # ---- W5：镜像 / 分享 / 转存 ----
    sp = sub.add_parser("mirror", help="增量镜像 本地目录→远端（远端只增不删；"
                                       "size+mtime+md5 缓存增量；走传输引擎断点续传）")
    sp.add_argument("local", help="本地目录")
    sp.add_argument("remote", help="远端绝对目录（如 /API复刻测试_1029/mirror_test）")
    sp.add_argument("--dry-run", action="store_true", help="只出计划零上传")
    sp.add_argument("--max-scan-requests", dest="max_scan_requests", type=int,
                    default=100,
                    help="远端递归扫描预算（默认 100 发；耗尽如实报已用/上限+未扫目录清单）")
    sp.add_argument("--allow-root", action="store_true",
                    help="显式放行远端目标为 / 或一级根目录（默认拒绝防误铺根）")
    common(sp); sp.set_defaults(fn=cmd_mirror)

    sp = sub.add_parser("pull", help="拉取恢复 远端目录→本地（mirror 反向件；"
                                    "本地多余只报告不删；下载带 md5 校验+断点续传）")
    sp.add_argument("remote", help="远端绝对目录（如 /API复刻测试_1030）")
    sp.add_argument("local", help="本地落盘目录（不存在自动建）")
    sp.add_argument("--dry-run", action="store_true", help="只出计划零下载")
    sp.add_argument("--max-scan-requests", dest="max_scan_requests", type=int,
                    default=100, help="远端递归扫描预算（默认 100 发）")
    common(sp); sp.set_defaults(fn=cmd_pull)

    sp = sub.add_parser("clean", help="列本地残留断点/状态文件清单（--confirm 才删；零网络）")
    sp.add_argument("dir", help="本地目录（递归扫 .bdn_*_state/.bdn_mirror_*/.bdn_circuit）")
    sp.add_argument("--confirm", action="store_true",
                    help="显式确认删除清单内残留文件（无此旗标只列清单退出码 3）")
    common(sp); sp.set_defaults(fn=cmd_clean)

    sp = sub.add_parser("share-create", help="创建分享（/share/pset 旧代写面；≤2 发）")
    sp.add_argument("path", help="远端绝对路径（文件/目录）")
    sp.add_argument("--pwd", default="", help="提取码（4 位；缺省=公开分享）")
    sp.add_argument("--period", type=int, default=0, help="有效期天数（0=永久）")
    common(sp); sp.set_defaults(fn=cmd_share_create)

    sp = sub.add_parser("share-cancel", help="取消分享（仅用于取消自建分享，留记录）")
    sp.add_argument("shareids", nargs="+", type=int, help="shareid（多条）")
    common(sp); sp.set_defaults(fn=cmd_share_cancel)

    sp = sub.add_parser("transfer", help="转存自有分享→远端目录（旧链三步；"
                                         "提取码缺省自动查 surlinfoinrecord）")
    sp.add_argument("share", help="分享短链或 surl（须在本账号分享记录中）")
    sp.add_argument("remote", help="远端落盘目录（绝对路径）")
    sp.add_argument("--pwd", default="", help="提取码（缺省自动查）")
    sp.add_argument("--all", action="store_true", help="转存全部分享项（默认首个文件）")
    common(sp); sp.set_defaults(fn=cmd_transfer)

    return p


def main(argv=None) -> int:
    args = build_parser().parse_args(argv)
    try:
        sess = BdnSession(cred_path=args.cred)
        # W5 起读面走 RoutedApi（api→xpan 降级链）；写面/未路由方法直通 BdnApi（/api 唯一）
        api = RoutedApi(BdnApi(sess))
        rc = args.fn(api, args)
        return int(rc) if isinstance(rc, int) else 0
    except BdnError as e:
        print(f"bdn: {e}", file=sys.stderr)
        return e.exit_code
    except KeyboardInterrupt:
        print("bdn: 中断", file=sys.stderr)
        return 130


if __name__ == "__main__":
    sys.exit(main())
