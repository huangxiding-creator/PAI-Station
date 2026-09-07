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
# 2026-09-07 实测：大 payload（约 >100KB b64）经 7890 代理 POST 会被机场污染成
# 400 "malformed request"；api.github.com 直连可用（gh CLI 同为直连）。故走直连。
opener = u.build_opener(u.ProxyHandler({}))


def token():
    p = subprocess.run(["git", "credential", "fill"], cwd=ROOT,
                       input=b"protocol=https\nhost=github.com\n\n",
                       capture_output=True, timeout=10)
    creds = dict(line.split("=", 1) for line in p.stdout.decode().splitlines()
                 if "=" in line)
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

    # 远端树逐文件比对本地 HEAD 树（blob sha）——远端可能含本地未知的 API 提交，
    # git diff 对未知 SHA 会静默失败返回空；树比对不依赖共同历史。
    # CJK 路径必须 -c core.quotepath=false（否则 \347\253\236 转义致 isfile 失败静默跳过）。
    _, rt = call("GET", f"/repos/{REPO}/git/trees/{base_tree}?recursive=1", tok)
    remote_blobs = {e["path"]: e["sha"] for e in rt.get("tree", []) if e.get("type") == "blob"}
    ls = subprocess.run(["git", "-c", "core.quotepath=false", "ls-tree", "-r", "HEAD"],
                        cwd=ROOT, capture_output=True, text=True,
                        encoding="utf-8", errors="replace").stdout.splitlines()
    local_blobs = {}
    for line in ls:
        meta, path = line.split("\t", 1)
        local_blobs[path] = meta.split()[2]
    files = [p for p, sha in local_blobs.items() if remote_blobs.get(p) != sha]
    deleted = [p for p in remote_blobs if p not in local_blobs]
    print(f"changed files vs remote: {len(files)}, deleted: {len(deleted)}")

    tree = []
    # 删除传播：sha=None 从 base_tree 摘除条目（否则本地删除的文件在远端永生）
    for path in deleted:
        tree.append({"path": path.replace("\\", "/"), "mode": "100644",
                     "type": "blob", "sha": None})
        print(f"  delete {path}")
    for path in files:
        # 上传 HEAD 的 blob 原始字节而非工作区文件——autocrlf 环境下工作区可能是
        # CRLF 而 HEAD 对象是 LF，读工作区会造成"上传 blob sha ≠ 本地树 sha"的幻影差异
        p = subprocess.run(["git", "cat-file", "blob", f"HEAD:{path}"],
                           cwd=ROOT, capture_output=True, timeout=30)
        if p.returncode != 0:
            continue
        content = base64.b64encode(p.stdout).decode()
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
    # 提交信息自动取本地 HEAD 的 message——推送内容即本地提交内容，信息天然一致
    msg = subprocess.run(["git", "log", "-1", "--pretty=%B"], cwd=ROOT,
                         capture_output=True, text=True, encoding="utf-8",
                         errors="replace").stdout.strip()
    trailer = ("\n\n（GitHub API 通道直连推送：api.github.com 大 payload 经代理会被污染为 400，"
               "故此提交由 Git Data API 创建，与本地提交内容等价）")
    _, c = call("POST", f"/repos/{REPO}/git/commits", tok,
                {"message": msg + trailer,
                 "tree": t["sha"], "parents": [remote_sha]})
    _, rr = call("PATCH", f"/repos/{REPO}/git/refs/heads/main", tok,
                 {"sha": c["sha"], "force": False})
    _, verify = call("GET", f"/repos/{REPO}/git/ref/heads/main", tok)
    ref_ok = verify["object"]["sha"] == c["sha"]
    # 硬校验：远端提交树必须与本地 HEAD 树逐 sha 等价（ref 相同≠内容等价）
    local_tree = subprocess.run(["git", "rev-parse", "HEAD^{tree}"], cwd=ROOT,
                                capture_output=True, text=True).stdout.strip()
    _, vc = call("GET", f"/repos/{REPO}/git/commits/{verify['object']['sha']}", tok)
    ok = ref_ok and vc.get("tree", {}).get("sha") == local_tree
    if not ok:
        print(f"TREE MISMATCH remote={vc.get('tree', {}).get('sha')} local={local_tree}")
    print(f"api push {'SUCCESS' if ok else 'FAILED'} remote_main={verify['object']['sha'][:8]}")
    if ok:
        subject = msg.splitlines()[0]
        subprocess.run([sys.executable, os.path.join(ROOT, "tools", "notify_wecom.py"),
                        "PAI-Station 已推送（GitHub API 通道）",
                        f"{subject}；remote main={verify['object']['sha'][:8]}，"
                        f"{len(tree)}个文件变更"],
                       cwd=ROOT, capture_output=True)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
