# -*- coding: utf-8 -*-
"""_switch_exit — nb_lane(48899) 美国组出口切换器 (1105 用户授权: 网络自主处置).
用法: py -3 -X utf8 _switch_exit.py [目标节点名, 默认含'02'的美国节点]
"""
import json
import sys
import urllib.request
from urllib.parse import quote

sys.path.insert(0, r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2")
import sched_nblm_run as base  # noqa: E402

PORT = 48899
GROUP_KEY = "美国节点"


def req(path, method="GET", body=None):
    r = urllib.request.Request(
        "http://127.0.0.1:" + str(PORT) + path, method=method,
        headers={"Authorization": "Bearer " + base.CLASH_SECRET,
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    with urllib.request.urlopen(r, timeout=8) as resp:
        body = resp.read().decode("utf-8", "replace")
        return json.loads(body) if body.strip() else {}


def main() -> int:
    target_hint = sys.argv[1] if len(sys.argv) > 1 else "02"
    px = req("/proxies")
    gname = ginfo = None
    for name, info in px.get("proxies", {}).items():
        if info.get("all") and GROUP_KEY in name:
            gname, ginfo = name, info
            break
    if not gname:
        print("[!] 未找到美国组")
        return 1
    members = [m for m in ginfo["all"] if "美国" in m]
    cur = ginfo.get("now", "")
    tgt = next((m for m in members if target_hint in m), None)
    print(f"[grp] {gname} | 当前: {cur} | 成员: {members}")
    if not tgt:
        print("[!] 无匹配目标节点")
        return 1
    if cur == tgt:
        print(f"[=] 已在 {tgt}")
        return 0
    req("/proxies/" + quote(gname), "PUT", {"name": tgt})
    after = req("/proxies").get("proxies", {}).get(gname, {}).get("now", "")
    print(f"[OK] 切换 {cur} -> {tgt} | 回读: {after} "
          + ("(确认)" if after == tgt else "(未生效!)"))
    return 0 if after == tgt else 1


if __name__ == "__main__":
    raise SystemExit(main())
