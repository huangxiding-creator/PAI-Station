# -*- coding: utf-8 -*-
r"""GitHub Git Data API 推送——绕开 github.com receive-pack（机场中转坏）。

api.github.com 与 github.com 是不同 CDN 通道，实测经 7890 代理可用。
流程：凭据管理器取令牌 → 逐文件建 blob → base_tree 建树 → 建提交 → 快进 ref。
产生一个包含全部变更的原子提交，等价于 git push 单提交。
运行: python tools/api_push.py
"""
import base64
import json
import os
import subprocess
import sys
import urllib.request as u

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
REPO = "huangxiding-creator/PAI-Station"
API = "https://api.github.com"
PROXY = {"http": "http://127.0.0.1:7890", "https": "http://127.0.0.1:7890"}
opener = u.build_opener(u.ProxyHandler(PROXY))


def token():
    p = subprocess.run(["git", "credential", "fill"], cwd=ROOT,
                       input=b"protocol=https\nhost=github.com\n\n",
                       capture_output=True, timeout=10)
    creds = dict(l.split("=", 1) for l in p.stdout.decode().splitlines() if "=" in l)
    tok = creds.get("password", "")
    if not tok:
        raise SystemExit("no credential token")
    return tok


def call(method, path, tok, payload=None, raw=None):
    data = raw if raw is not None else (json.dumps(payload).encode() if payload else None)
    headers = {"Authorization": f"Bearer {tok}", "User-Agent": "PAI-Station",
               "Accept": "application/vnd.github+json"}
    if data is not None:
        headers["Content-Type"] = "application/json"
    req = u.Request(f"{API}{path}", data=data, headers=headers, method=method)
    with opener.open(req, timeout=60) as r:
        body = r.read().decode("utf-8", "ignore")
        return r.status, (json.loads(body) if body else {})


def main():
    tok = token()
    _, ref = call("GET", f"/repos/{REPO}/git/ref/heads/main", tok)
    remote_sha = ref["object"]["sha"]
    _, rc = call("GET", f"/repos/{REPO}/git/commits/{remote_sha}", tok)
    base_tree = rc["tree"]["sha"]
    local_head = subprocess.run(["git", "rev-parse", "HEAD"], cwd=ROOT,
                                capture_output=True, text=True).stdout.strip()[:8]
    print(f"remote={remote_sha[:8]} base_tree={base_tree[:8]} local={local_head}")

    out = subprocess.run(["git", "diff", "--name-only", remote_sha + "..HEAD"],
                         cwd=ROOT, capture_output=True, text=True,
                         encoding="utf-8", errors="replace").stdout.split()
    files = [f for f in out if f.strip()]
    print(f"changed files vs remote: {len(files)}")

    tree = []
    for path in files:
        full = os.path.join(ROOT, path)
        if not os.path.isfile(full):
            continue
        content = base64.b64encode(open(full, "rb").read()).decode()
        _, blob = call("POST", f"/repos/{REPO}/git/blobs", tok,
                       {"content": content, "encoding": "base64"})
        tree.append({"path": path.replace("\\", "/"), "mode": "100644",
                     "type": "blob", "sha": blob["sha"]})
        print(f"  blob ok {path} ({len(content)//1024}KB b64)")
    if not tree:
        print("nothing to push")
        return 0

    _, t = call("POST", f"/repos/{REPO}/git/trees", tok,
                {"base_tree": base_tree, "tree": tree})
    _, c = call("POST", f"/repos/{REPO}/git/commits", tok,
                {"message": "feat: 提案V2.1——曾鸣智能复利调研+第15章智能复利引擎设计（GitHub API 通道）\n\n"
                            "任务域级60分奇点判据/责任转移协议L1-L3/意图引擎/复利仪表盘/北极星变更；\n"
                            "思维模型库29→32（曾鸣三部曲）；附录B.6 DDL、附录Q11、README理论底座；\n"
                            "PROPOSAL.md 112,048字符（12.2×V1.0）；Word V2.1 1,689段/41表。\n"
                            "含 tools/merge_proposal.py、tools/clash_push.py（Clash API 自动切点推送）。",
                 "tree": t["sha"], "parents": [remote_sha]})
    _, rr = call("PATCH", f"/repos/{REPO}/git/refs/heads/main", tok,
                 {"sha": c["sha"], "force": False})
    _, verify = call("GET", f"/repos/{REPO}/git/ref/heads/main", tok)
    ok = verify["object"]["sha"] == c["sha"]
    print(f"api push {'SUCCESS' if ok else 'FAILED'} remote_main={verify['object']['sha'][:8]}")
    if ok:
        subprocess.run([sys.executable, os.path.join(ROOT, "tools", "notify_wecom.py"),
                        "PAI-Station GitHub 推送成功",
                        f"GitHub API 通道原子提交完成，remote main={verify['object']['sha'][:8]}，"
                        f"含 Word 成果 V2.1 全部 {len(tree)} 个文件"],
                       cwd=ROOT, capture_output=True)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
