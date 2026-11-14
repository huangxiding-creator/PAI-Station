# -*- coding: utf-8 -*-
"""push_staged.py — 16G 仓分段推送器（filter-repo 新历史 force 推 GitHub）。
原理：新历史按对象增量累计切组（≤SEG_MB），逐组 push origin <sha>:refs/heads/main
（首组 --force 定基点，余组 fast-forward），断点续推（进度档 _push_progress.json）。
用法：py -3 -X utf8 tools/push_staged.py [--seg-mb 1200]"""
import subprocess, sys, json, os, time

REPO = r"E:\AI-Station"
SEG_MB = int(sys.argv[sys.argv.index("--seg-mb") + 1]) if "--seg-mb" in sys.argv else 500
PUSH_TIMEOUT = 2400
PROG = os.path.join(REPO, "_push_progress.json")
SSH = "ssh -o ProxyCommand='connect -H 127.0.0.1:7890 %h %p'"

def git(*args, timeout=900):
    r = subprocess.run(["git", "-C", REPO] + list(args), capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    return r.returncode, r.stdout.strip(), r.stderr.strip()

# 1. 全历史 commit 序（旧→新）
rc, out, _ = git("rev-list", "--reverse", "main")
commits = out.split()
print(f"[plan] {len(commits)} commits on main")

# 2. 每 commit 新增对象体积（diff 对象级增量：ls-tree 对比父——用 rev-list --objects 分段太重，
#    改用每 commit 的 tree 变更近似：git diff-tree -r --no-commit-id --name-only <c>^ <c> 的对象大小）
def commit_bytes(c):
    """变更 blob 体积：diff-tree --raw 拿 sha（短，无中文路径）→ cat-file --batch-check 走 stdin。"""
    rc, raw, _ = git("diff-tree", "-r", "--no-commit-id", "--raw", "-M", c)
    shas = []
    for ln in raw.splitlines():
        parts = ln.split()
        if len(parts) >= 4 and len(parts[3]) == 40:
            shas.append(parts[3])
    if not shas:
        return 0
    p = subprocess.run(["git", "-C", REPO, "cat-file", "--batch-check=%(objectsize)"],
                       input="\n".join(shas), capture_output=True, text=True,
                       timeout=180, encoding="utf-8", errors="replace")
    total = 0
    for ln in p.stdout.splitlines():
        try:
            total += int(ln)
        except ValueError:
            pass
    return total

# 3. 切组（含进度缓存避免重算）
cache = {}
if os.path.exists(PROG):
    cache = json.loads(open(PROG, encoding="utf-8").read())
sizes = cache.get("sizes", {})
segs = []
cur_bytes = 0; cur_start = None
for idx, c in enumerate(commits):
    if c not in sizes:
        sizes[c] = commit_bytes(c)
        cache["sizes"] = sizes; json.dump(cache, open(PROG, "w", encoding="utf-8"))
    if cur_start is None:
        cur_start = c
    cur_bytes += sizes[c]
    if cur_bytes >= SEG_MB * 1024 * 1024:
        segs.append((cur_start, c, cur_bytes)); cur_start = None; cur_bytes = 0
if cur_start:
    segs.append((cur_start, commits[-1], cur_bytes))
print(f"[plan] {len(segs)} 段（≤{SEG_MB}MB/段）")
cache["segs"] = [[a, b, n] for a, b, n in segs]; json.dump(cache, open(PROG, "w", encoding="utf-8"))

# 4. 远端 sha 对齐（避免旧切点 done 失配）：拿远端 main 当前位置，跳过其前的段
r = subprocess.run(["git", "-C", REPO, "-c", f"core.sshCommand={SSH}", "ls-remote", "origin", "refs/heads/main"],
                   capture_output=True, text=True, timeout=120, encoding="utf-8", errors="replace")
remote_sha = (r.stdout or "").split()[0] if r.stdout.strip() else None
print(f"[remote] main={remote_sha[:10] if remote_sha else 'EMPTY'}")
start_idx = 0
if remote_sha:
    for i, (a, b, n) in enumerate(segs):
        if b == remote_sha:
            start_idx = i + 1; break
        # 远端 sha 在段 i 内（上次切点不同）→ 从该段重推
    else:
        # 远端不在任何段终点：找远端 sha 在 commit 序中的位置，落在哪段就从哪段起
        try:
            pos = commits.index(remote_sha)
            for i, (a, b, n) in enumerate(segs):
                if commits.index(a) <= pos < commits.index(b):
                    start_idx = i; break
        except ValueError:
            start_idx = 0  # 远端是旧历史 sha → 全量从头（force）

for i in range(start_idx, len(segs)):
    a, b, nbytes = segs[i]
    force = ["--force"] if (i == 0 and (not remote_sha or remote_sha not in commits)) else []
    ok = False
    for attempt in (1, 2):
        try:
            rc, out, err = git("-c", f"core.sshCommand={SSH}", "push", *force, "origin",
                               f"{b}:refs/heads/main", timeout=PUSH_TIMEOUT)
            ok = rc == 0
            if not ok:
                print(f"  err({attempt}):", (err or out)[-200:])
        except Exception as e:
            print(f"  timeout({attempt}) {type(e).__name__}")
        if ok:
            break
    print(f"[seg {i+1}/{len(segs)}] {'OK' if ok else 'FAIL'} {nbytes/1048576:.0f}MB -> {b[:10]}")
    if not ok:
        sys.exit(1)
    cache["done"] = i + 1; json.dump(cache, open(PROG, "w", encoding="utf-8"))
print("[ALL-DONE]")