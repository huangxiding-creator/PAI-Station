#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""W5 转存链诊断探针（b1 errno=2 断点定位）。

逐环节落档原始响应（_diag_archive）：record 选条 → surlinfoinrecord → share/verify →
share/list（去前导1/带1 两形态）→（list 通才发）share/transfer（≤2 发硬帽）。
不硬闯：任何环节非零 errno 即停，如实落档。/share/transfer POST 计数≤2。
"""
from __future__ import annotations

import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession, mask

ARCHIVE = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "_diag_archive", "w5_transfer_diag_"
                       + time.strftime("%Y%m%d_%H%M%S"))
TRANSFER_DST = "/API复刻测试_1029/transfer_in"
EXCLUDE = {65048642201}          # a 腿已取消的测试分享（避免误用）
transfer_posts = 0


def dump(name, obj):
    os.makedirs(ARCHIVE, exist_ok=True)
    with open(os.path.join(ARCHIVE, name), "w", encoding="utf-8") as f:
        json.dump(obj, f, ensure_ascii=False, indent=2, default=str)
    print(f"# 落档 {name}")


def main() -> int:
    sess = BdnSession()
    api = BdnApi(sess)
    out = {}
    print(f"# 凭据 bduss={mask(sess.bduss)} | 落档 {ARCHIVE}")

    r = api.share_records()
    entries = [e for e in r.get("entries") or []
               if e["shareid"] not in EXCLUDE]
    cand = next((e for e in entries
                 if e.get("typical_path") and "." in
                 e["typical_path"].rsplit("/", 1)[-1]), None)
    pick = cand or entries[0]
    out["pick"] = pick
    print(f"[1] 选中 shareid={pick['shareid']} {pick['typical_path']}"
          f" passwd={'有' if pick['passwd'] else '无'}")

    # [2] surlinfoinrecord
    try:
        info = api.share_surl_info(pick["shareid"])
        out["surlinfo"] = {"errno": info.get("errno"), "keys": list(info.keys())}
        pwd = ""
        def walk(o):
            if isinstance(o, dict):
                for k, v in o.items():
                    if str(k).lower() in ("passwd", "pwd") and isinstance(v, str) and v:
                        return v
                    g = walk(v)
                    if g:
                        return g
            elif isinstance(o, list):
                for x in o:
                    g = walk(x)
                    if g:
                        return g
            return ""
        pwd = walk(info)
        out["surlinfo"]["pwd_found"] = bool(pwd)
        print(f"[2] surlinfo errno={info.get('errno')} keys={list(info.keys())[:8]} "
              f"pwd取到={bool(pwd)}")
    except BdnError as e:
        out["surlinfo"] = {"error": str(e), "errno": getattr(e, "errno", None)}
        pwd = ""
        print(f"[2] surlinfo 异常: {e}")
    dump("02_surlinfo.json", out["surlinfo"])

    # [3] loginStatus 拿 uk/bdstoken
    ls = api.login_status()
    acc = ls.get("account") or {}
    uk = acc.get("uk")
    bdstoken = (ls.get("login_info") or {}).get("bdstoken") or ""
    out["login"] = {"uk": uk, "bdstoken_len": len(bdstoken)}
    print(f"[3] uk={uk} bdstoken_len={len(bdstoken)}")

    # [4] share/verify
    try:
        v = api.share_verify(pick["shareid"], uk, pwd, bdstoken=bdstoken or None)
        randsk = v.get("randsk") or ""
        out["verify"] = {"errno": v.get("errno"), "keys": list(v.keys()),
                         "randsk_len": len(randsk)}
        print(f"[4] verify errno={v.get('errno')} keys={list(v.keys())} "
              f"randsk_len={len(randsk)}")
    except BdnError as e:
        out["verify"] = {"error": str(e), "errno": getattr(e, "errno", None)}
        randsk = ""
        print(f"[4] verify 异常: errno={getattr(e, 'errno', None)} {e}")
    dump("04_verify.json", out["verify"])

    # [5] share/list 两形态
    surl = BdnApi.surl_from_link(pick["shortlink"])
    full_tail = pick["shortlink"].rstrip("/").rsplit("/s/", 1)[-1]
    usable = None
    for tag, s in (("stripped", surl), ("full", full_tail)):
        try:
            sl = api.share_list(s, randsk=randsk or None)
            lst = sl.get("list") or []
            out[f"list_{tag}"] = {"surl": s, "errno": sl.get("errno"),
                                  "count": len(lst), "entries": lst,
                                  "keys": list(sl.keys())}
            print(f"[5.{tag}] surl={s} errno={sl.get('errno')} count={len(lst)} "
                  f"首条={json.dumps(lst[0], ensure_ascii=False)[:120] if lst else '无'}")
            dump(f"05_list_{tag}.json", out[f"list_{tag}"])
            if lst:
                usable = out[f"list_{tag}"]
                break
        except BdnError as e:
            out[f"list_{tag}"] = {"surl": s, "error": str(e),
                                  "errno": getattr(e, "errno", None)}
            print(f"[5.{tag}] surl={s} 异常 errno={getattr(e, 'errno', None)}")
            dump(f"05_list_{tag}.json", out[f"list_{tag}"])
    if not usable:
        print("# list 未通 → 不发 transfer（硬帽 0/2 未动）")
        dump("06_transfer.json", {"skipped": "list 未通"})
        return 1

    # [6] share/transfer（≤2 发硬帽；list 通了才发）
    global transfer_posts
    files = [e for e in usable["entries"] if not int(e.get("isdir") or 0)] \
        or usable["entries"]
    fsids = [int(e["fs_id"]) for e in files[:1]]
    try:
        transfer_posts += 1
        tr = api.share_transfer(fsids, TRANSFER_DST, randsk=randsk or None)
        out["transfer"] = {"errno": tr.get("errno"), "fsids": fsids,
                           "response": tr, "posts": transfer_posts}
        print(f"[6] transfer errno={tr.get('errno')} fsids={fsids} "
              f"posts={transfer_posts}/2")
    except BdnError as e:
        out["transfer"] = {"error": str(e), "errno": getattr(e, "errno", None),
                           "fsids": fsids, "posts": transfer_posts}
        print(f"[6] transfer 异常 errno={getattr(e, 'errno', None)} posts={transfer_posts}/2")
    dump("06_transfer.json", out["transfer"])

    # [7] ls 复核
    if out["transfer"].get("errno") == 0:
        r = api.list_dir(TRANSFER_DST)
        out["ls_verify"] = [e["name"] for e in r.get("entries") or []]
        print(f"[7] ls 复核 transfer_in: {out['ls_verify']}")
        dump("07_ls_verify.json", out["ls_verify"])
    print(f"# 控制面总发数（库会话）: {sess.requests_sent}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
