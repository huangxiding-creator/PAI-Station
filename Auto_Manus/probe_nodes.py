# -*- coding: utf-8 -*-
"""多节点浏览器级轮换验证 (0924 建, 0925 v2 适配新订阅).

urllib 探针对 SPA 客户端重定向失明 → 每节点真浏览器加载 login, 判据=
URL 不跳 /unavailable 且 #email 出现. 命中即停并保留该节点.

0925 v2 (订阅漂移实锤): 组名「🚀 手动切换」在新配置 404 → 全部动态发现:
  组 = Selector/URLTest 型组按偏好序 (手动切换>漏网之鱼>Others>Proxy);
  候选 = 组内节点动态拉取, 排除本次实锤被收紧的香港区, 美新日台韩优先.
"""
import io
import json
import sys
import time
from pathlib import Path
from urllib.parse import quote

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
# 0928 永久闸: probe 会真访问 manus.im — 封号期禁一切平台访问 (同 fill/corps)
from pathlib import Path as _P
if (_P(__file__).parent / "data" / "MANUS_CORPS_HALTED").exists():
    print("[HALT] 军团永久停用中, probe 不访问平台, 退出", flush=True)
    sys.exit(0)
import manus_lib as lib

GROUP_PREF = ("手动切换", "漏网之鱼", "Others", "Proxy")
EXCLUDE_KEY = ("香港", "HK")           # 0925 13:2x 实锤: 港区渐进收紧
PREF_ORDER = ("美国", "新加坡", "日本", "台湾", "韩国", "新加坡",
              "SG", "US", "JP")


def _api(path, method="GET", data=None, parse=False):
    import urllib.request as u
    hdr = {"Authorization": "Bearer " + lib.CLASH_SECRET,
           "Content-Type": "application/json"}
    for p in lib.clash_ports():
        base = f"http://127.0.0.1:{p}"
        try:
            u.urlopen(u.Request(base + "/version", headers=hdr),
                      timeout=2).read()
        except Exception:
            continue
        req = u.Request(base + path,
                        data=json.dumps(data).encode() if data else None,
                        method=method, headers=hdr)
        raw = u.urlopen(req, timeout=4).read()
        return json.loads(raw) if parse else True
    return None


def ensure_rule_mode():
    """0925 实锤: direct 态下切组=纯空转 (出口IP恒家宽, 全节点假不可用)."""
    return _api("/configs", "PATCH", {"mode": "rule"}) is True


def discover_group() -> tuple[str, list[str]]:
    """→ (组名, 候选节点列表). 组按偏好序, 节点=组内 all 去香港按地区偏好排."""
    d = _api("/proxies", parse=True) or {}
    proxies = d.get("proxies", {})
    groups = {n: v for n, v in proxies.items()
              if v.get("type") in ("Selector", "URLTest", "Fallback")}
    group = None
    for pref in GROUP_PREF:
        for n in groups:
            if pref in n:
                group = n
                break
        if group:
            break
    if not group:                       # 兜底: 任一多选组
        for n, v in groups.items():
            if len(v.get("all", [])) > 1:
                group = n
                break
    if not group:
        return "", []
    nodes = [n for n in groups[group].get("all", [])
             if n not in ("DIRECT", "REJECT", "GLOBAL")
             and not any(k in n for k in EXCLUDE_KEY)]

    def rank(n):
        for i, k in enumerate(PREF_ORDER):
            if k in n:
                return i
        return 99
    return group, sorted(nodes, key=rank)


def switch(group: str, node: str) -> bool:
    r = _api("/proxies/" + quote(group), "PUT", {"name": node})
    return r is True


def main():
    ok_rule = ensure_rule_mode()
    print(f"[mode] rule 前置: "
          f"{'✓' if ok_rule else '✗ (direct 下切组=空转, 结果不可信)'}",
          flush=True)
    group, cands = discover_group()
    cands = cands[:5]  # 0928 弹窗降频: 每轮最多实测 5 节点, 缩短浏览器存活窗
    print(f"[group] {group!r} | 候选 {len(cands)}: {cands[:5]}", flush=True)
    if not group or not cands:
        print("[!] 未发现可用组/节点, 停", flush=True)
        return
    page = lib.make_page()
    results = []
    winner = None
    try:
        for node in cands:
            if not switch(group, node):
                print(f"[!] 切换失败 {node}, 停", flush=True)
                break
            time.sleep(2)
            page.get(lib.LOGIN_URL)
            time.sleep(7)
            url = page.url or ""
            email = bool(page.ele("#email", timeout=4))
            ok = email and "unavailable" not in url
            results.append((node, url))
            print(f"{'✓' if ok else '✗'} {node} | {url} | "
                  f"#email={'在' if email else '缺'}", flush=True)
            if ok:
                winner = node
                shot = Path(__file__).parent / "probe_net_OK.png"
                try:
                    page.get_screenshot(str(shot))
                except Exception:
                    pass
                print(f"[★] 命中节点: {node} (已保留, 组={group})",
                      flush=True)
                break
    finally:
        try:
            page.browser.quit()
        except Exception:
            pass
    print(f"[汇总] 测 {len(results)} | 命中: {winner}", flush=True)


if __name__ == "__main__":
    main()
