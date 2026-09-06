# -*- coding: utf-8 -*-
r"""借鉴 We-AIPO network_orchestrator/sched_guard 的 Clash API 配方做自动切点推送。

流程（CD1b 分类 + 切活节点自愈，简化版）：
1) 发现 Clash API 端口（候选表 + GET /version 探活）
2) GET /configs 看模式；GET /rules 定位 github 流量走哪个选择器组
3) 对该组候选节点做 GitHub 延迟探测
4) 逐个切活节点 → git push → 成功即停
5) 恢复原节点选择（系统状态不变），输出结果

运行: python tools/clash_push.py [--keep]   # --keep=成功后不恢复原节点
"""
import configparser
import json
import os
import subprocess
import sys
import time
from urllib.parse import quote
from urllib.request import Request, urlopen

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SECRET_INI = os.path.join(ROOT, "config", "clash.secret.ini")
DELAY_URL = "https://github.com"
PUSH_TIMEOUT = 120


def _conf():
    parser = configparser.ConfigParser()
    parser.read(SECRET_INI, encoding="utf-8")
    secret = parser.get("clash", "secret", fallback="")
    ports = [int(p) for p in parser.get("clash", "ports", fallback="20225,9090").split(",") if p.strip()]
    return secret, ports


def _api(method, url, secret, payload=None, timeout=6):
    headers = {"Authorization": f"Bearer {secret}", "Content-Type": "application/json"}
    data = json.dumps(payload).encode() if payload is not None else None
    req = Request(url, data=data, headers=headers, method=method)
    with urlopen(req, timeout=timeout) as resp:
        return resp.status, json.loads(resp.read().decode("utf-8", "ignore") or "{}")


def discover_api(secret, ports):
    """静态候选表 + 动态发现（借 We-AIPO：7890 属主进程的监听端口反查 API）。

    本机实况：external-controller 会漂移（20225→11704→…→19763），
    静态表必失效；按流量端口 7890 的 PID 反查核心监听端口才是根治。
    """
    for port in ports + _ports_of_pid7890():
        base = f"http://127.0.0.1:{port}"
        try:
            status, body = _api("GET", f"{base}/version", secret, timeout=2)
            if status == 200 and body.get("version"):
                return base, body["version"]
        except Exception:
            continue
    return None, None


def _ports_of_pid7890():
    """netstat（GBK 解码）找 7890 属主 PID，返回该 PID 全部监听端口。"""
    try:
        import subprocess
        out = subprocess.run(["netstat", "-ano"], capture_output=True).stdout.decode("gbk", "ignore")
        rows = [p.split() for p in out.splitlines() if "LISTENING" in p and len(p.split()) >= 5]
        pids = {r[4] for r in rows if r[1].endswith(":7890")}
        return sorted({int(r[1].rsplit(":", 1)[-1]) for r in rows
                       if r[4] in pids and r[1].rsplit(":", 1)[-1].isdigit()})
    except Exception:
        return []


def find_github_group(base, secret):
    """global 模式→GLOBAL；rule 模式→查 /rules 里 github.com 真正命中的组。

    实测坑：规则表 3 万条里第一条含 github 的是 github-cloud.s3.amazonaws.com
    →微软服务（错组）；github.com push 流量实际走 DomainKeyword github → 🚀 手动切换。
    策略：按优先级选——payload 精确 github.com > DomainKeyword github > 其余含 github。
    """
    _, cfg = _api("GET", f"{base}/configs", secret)
    mode = cfg.get("mode", "rule")
    if mode == "global":
        return "GLOBAL", mode
    try:
        _, rules = _api("GET", f"{base}/rules", secret)
        best = (None, 0)  # (group, score)
        for r in rules.get("rules", []):
            payload = str(r.get("payload", "")).lower()
            if "github" not in payload:
                continue
            score = 3 if payload == "github.com" else (2 if payload == "github" else 1)
            if score > best[1]:
                best = (r.get("proxy"), score)
        if best[0]:
            return best[0], mode
    except Exception:
        pass
    return "GLOBAL", mode


def group_info(base, secret, group):
    _, g = _api("GET", f"{base}/proxies/{quote(str(group), safe='')}", secret)
    return g


def switch(base, secret, group, node):
    status, _ = _api("PUT", f"{base}/proxies/{quote(str(group), safe='')}", secret, {"name": node}, timeout=5)
    return status in (200, 204)


def node_alive(base, secret, node):
    try:
        url = f"{base}/proxies/{quote(node, safe='')}/delay?timeout=5000&url={quote(DELAY_URL, safe='')}"
        status, body = _api("GET", url, secret, timeout=8)
        return status == 200, body.get("delay")
    except Exception:
        return False, None


def git_push():
    proc = subprocess.run(["git", "push", "origin", "main"], cwd=ROOT,
                          capture_output=True, timeout=PUSH_TIMEOUT, text=True,
                          encoding="utf-8", errors="ignore")
    return proc.returncode == 0, (proc.stdout + proc.stderr).strip()[-300:]


def remote_head():
    try:
        proc = subprocess.run(["git", "ls-remote", "origin", "main"], cwd=ROOT,
                              capture_output=True, timeout=30, text=True,
                              encoding="utf-8", errors="ignore")
        return proc.stdout.strip().split()[0][:8]
    except Exception:
        return "?"


def main():
    keep = "--keep" in sys.argv
    secret, ports = _conf()
    local_head = subprocess.run(["git", "rev-parse", "--short", "HEAD"], cwd=ROOT,
                                capture_output=True, text=True, encoding="utf-8").stdout.strip()
    print(f"[1] local HEAD={local_head} remote={remote_head()}")
    base, ver = discover_api(secret, ports)
    if not base:
        print("[1] FAIL: no live Clash API on", ports)
        return 1
    print(f"[1] Clash API={base} (core {ver})")
    group, mode = find_github_group(base, secret)
    g = group_info(base, secret, group)
    current = g.get("now", "")
    nodes = [n for n in (g.get("all") or [])
             if n and n not in ("DIRECT", "REJECT", "REJECT-DROP", "PASS", current)
             and not str(n).upper().startswith(("AUTO", "LOAD"))]
    print(f"[2] mode={mode} group={group} current={current!r} candidates={len(nodes)}")
    tried = 0
    for node in nodes[:10]:
        ok, delay = node_alive(base, secret, node)
        if not ok:
            continue
        tried += 1
        print(f"[3] try node={node!r} delay={delay}ms")
        if not switch(base, secret, group, node):
            print("[3] switch FAILED, next")
            continue
        time.sleep(1)
        pushed, log = git_push()
        print(f"[4] push -> {'OK' if pushed else 'FAIL'} | {log.splitlines()[-1] if log else ''}")
        if pushed or remote_head() == local_head:
            print(f"[5] SUCCESS via {node!r} remote={remote_head()}")
            if not keep and current and current != node:
                switch(base, secret, group, current)
                print(f"[6] restored group to {current!r}")
            subprocess.run([sys.executable, os.path.join(ROOT, "tools", "notify_wecom.py"),
                            "PAI-Station 推送成功",
                            f"Clash API 自动切点[{node}]推送成功，本地{local_head}=远端，含Word成果V2.1"],
                           cwd=ROOT, capture_output=True)
            return 0
        if tried >= 12:
            break
    if current:
        switch(base, secret, group, current)
        print(f"[6] exhausted {tried} live nodes, restored {current!r}")
    return 1


if __name__ == "__main__":
    sys.exit(main())
