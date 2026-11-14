# -*- coding: utf-8 -*-
"""push_staged_v3.py — 剩余 16.6G 长跑分段推（真值切组+代理自愈+断点续推）。
真值法：逐 commit rev-list --objects c^..c 增量对象去重累计（修 rename 虚标）。
代理自愈：每段失败先重启 clash 再重试（无限轮，段间落账即进度）。"""
import subprocess, sys, json, os, time

REPO = r"E:\AI-Station"
SEG_MB = 500
PROG = os.path.join(REPO, "_push_progress_v3.json")
SSH = "ssh -o ProxyCommand='connect -H 127.0.0.1:7890 %h %p'"
CLASH = r"C:/Users/91216/.claude/skills/super-skill/skills/clash-proxy/scripts/clash_proxy.py"

def git(*args, timeout=900):
    r = subprocess.run(["git", "-C", REPO] + list(args), capture_output=True, text=True,
                       timeout=timeout, encoding="utf-8", errors="replace")
    return r.returncode, r.stdout.strip(), r.stderr.strip()

def remote_main():
    r = subprocess.run(["git", "-C", REPO, "-c", f"core.sshCommand={SSH}", "ls-remote", "origin", "refs/heads/main"],
                       capture_output=True, text=True, timeout=120, encoding="utf-8", errors="replace")
    return (r.stdout or "").split()[0] if r.stdout.strip() else None

def clash_start():
    subprocess.run(["py", "-3", "-X", "utf8", CLASH, "start"], capture_output=True, timeout=300)

# 1. 远端基点+剩余 commits
base = remote_main() or git("rev-list", "--max-parents=0", "main")[1].splitlines()[0]
print(f"[base] remote main={base[:10]}")
rc, out, _ = git("rev-list", "--reverse", f"{base}..main")
commits = out.split()
print(f"[plan] {len(commits)} commits to push")

# 2. 真值切组（增量对象去重累计，进度档缓存）
cache = json.load(open(PROG, encoding="utf-8")) if os.path.exists(PROG) else {"seen": [], "sizes": {}}
seen = set(cache["seen"]); sizes = cache["sizes"]
def save():
    cache["seen"] = list(seen); cache["sizes"] = sizes
    json.dump(cache, open(PROG, "w", encoding="utf-8"))

def new_objs(c):
    rc, out, _ = git("rev-list", "--objects", f"{c}^..{c}", timeout=300)
    fresh = []
    for ln in out.splitlines():
        s = ln.split()[0] if ln.strip() else ""
        if s and s not in seen:
            fresh.append(s); seen.add(s)
    if not fresh:
        return 0
    p = subprocess.run(["git", "-C", REPO, "cat-file", "--batch-check=%(objectsize)"],
                       input="\n".join(fresh), capture_output=True, text=True, timeout=600,
                       encoding="utf-8", errors="replace")
    return sum(int(x) for x in p.stdout.split() if x.isdigit())

segs = []; cur = 0; cur_start = commits[0] if commits else None
for c in commits:
    if c not in sizes:
        sizes[c] = new_objs(c); save()
    cur += sizes[c]
    if cur >= SEG_MB * 1024 * 1024:
        segs.append((cur_start, c)); cur_start = c; cur = sizes[c]; save()
if cur_start:
    segs.append((cur_start, commits[-1]))
print(f"[plan] {len(segs)} 段")
json.dump({"segs": [[a, b] for a, b in segs]}, open(PROG + ".segs.json", "w", encoding="utf-8"))

# 3. 循环推（代理自愈+无限重试）
for i, (a, b) in enumerate(segs):
    while True:
        try:
            rc, out, err = git("-c", f"core.sshCommand={SSH}", "push", "origin",
                               f"{b}:refs/heads/main", timeout=2700)
            if rc == 0:
                print(f"[seg {i+1}/{len(segs)}] OK -> {b[:10]}", flush=True)
                break
            print(f"[seg {i+1}] FAIL: {err[-120:]} — 重启代理重试", flush=True)
        except Exception as e:
            print(f"[seg {i+1}] timeout/{type(e).__name__} — 重启代理重试", flush=True)
        clash_start(); time.sleep(10)
print("[ALL-DONE]")