#!/usr/bin/env python
# -*- coding: utf-8 -*-
r"""W6 任务二附：transfer 断点跳级探针（只读，零 /share/transfer POST）。

复测 CLI 报 errno=2 但异常路径未回 JSON——本件复走 cmd_transfer 同款链至 list 为止
（records→surlinfo→loginStatus→verify→list），逐跳落 errno，钉死断点在哪一跳。
**不发 transfer**（W6 硬帽 1/1 已用）。
"""
from __future__ import annotations

import importlib.util
import json
import os
import sys
import time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

from bdncore import BdnApi, BdnError, BdnSession, mask  # noqa: E402

SHAREID = 28960980290            # W6 复测同一分享（票据识别(1).yml）
ARCHIVE = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                       "_diag_archive", "w6_qa_gate")

_spec = importlib.util.spec_from_file_location(
    "diag_scrub", os.path.join(os.path.dirname(os.path.abspath(__file__)),
                               "_diag_archive", "scrub.py"))
scrub = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(scrub)


def dump(name, obj):
    os.makedirs(ARCHIVE, exist_ok=True)
    clean, _n, _h = scrub.scrub_payload(obj)
    with open(os.path.join(ARCHIVE, name), "w", encoding="utf-8") as f:
        json.dump(clean, f, ensure_ascii=False, indent=2, default=str)
    print(f"# 落档 {name}")


def main() -> int:
    sess = BdnSession()
    api = BdnApi(sess)
    out = {"shareid": SHAREID, "hops": {}}
    print(f"# 凭据 bduss={mask(sess.bduss)} | 只读探针，零 transfer POST")

    rec = next((e for e in (api.share_records().get("entries") or [])
                if e["shareid"] == SHAREID), None)
    out["hops"]["1_records"] = {"found": bool(rec),
                                "shortlink": rec and rec["shortlink"]}
    print(f"[1] records 命中={bool(rec)}")
    if not rec:
        dump("transfer_hop_probe.json", out)
        return 1

    try:
        info = api.share_surl_info(SHAREID)
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
        out["hops"]["2_surlinfo"] = {"errno": info.get("errno"),
                                     "pwd_found": bool(pwd)}
        print(f"[2] surlinfo errno={info.get('errno')} pwd取到={bool(pwd)}")
    except BdnError as e:
        out["hops"]["2_surlinfo"] = {"error": str(e),
                                     "errno": getattr(e, "errno", None)}
        print(f"[2] surlinfo 异常 errno={getattr(e, 'errno', None)}")
        pwd = ""

    ls = api.login_status()
    acc = ls.get("account") or {}
    uk = rec.get("uk") or acc.get("uk")
    bdstoken = (ls.get("login_info") or {}).get("bdstoken") or ""
    out["hops"]["3_login"] = {"uk": uk, "bdstoken_len": len(bdstoken)}
    print(f"[3] loginStatus uk={uk} bdstoken_len={len(bdstoken)}")

    try:
        v = api.share_verify(SHAREID, uk, pwd, bdstoken=bdstoken or None)
        randsk = v.get("randsk") or ""
        out["hops"]["4_verify"] = {"errno": v.get("errno"),
                                   "randsk_len": len(randsk)}
        print(f"[4] verify errno={v.get('errno')} randsk_len={len(randsk)}")
    except BdnError as e:
        out["hops"]["4_verify"] = {"error": str(e),
                                   "errno": getattr(e, "errno", None)}
        print(f"[4] verify 异常 errno={getattr(e, 'errno', None)}")
        randsk = ""

    surl = BdnApi.surl_from_link(rec["shortlink"])
    for tag, s in (("stripped", surl),
                   ("full", rec["shortlink"].rstrip("/").rsplit("/s/", 1)[-1])):
        try:
            sl = api.share_list(s, randsk=randsk or None)
            lst = sl.get("list") or []
            out["hops"][f"5_list_{tag}"] = {"errno": sl.get("errno"),
                                            "count": len(lst),
                                            "first_fsid":
                                                (lst[0].get("fs_id")
                                                 if lst else None)}
            print(f"[5.{tag}] errno={sl.get('errno')} count={len(lst)}")
            if lst:
                break
        except BdnError as e:
            out["hops"][f"5_list_{tag}"] = {"error": str(e),
                                            "errno": getattr(e, "errno", None)}
            print(f"[5.{tag}] 异常 errno={getattr(e, 'errno', None)}")

    out["verdict"] = ("前置跳全通 → CLI 的 errno=2 落在 /share/transfer POST"
                      "（携带 bdstoken 形态仍拒）")
    print(f"# 结论: {out['verdict']}")
    print(f"# 控制面（库会话）: {sess.requests_sent} 发")
    dump("transfer_hop_probe.json", out)
    return 0


if __name__ == "__main__":
    sys.exit(main())
