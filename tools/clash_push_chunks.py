# -*- coding: utf-8 -*-
r"""clash_push 长效分块版：复用 clash_push 的切点逻辑 + 逐提交推送（单笔 30 分钟超时）。

差异 vs tools/clash_push.py：
- PUSH_TIMEOUT 120s → 1800s（巨物提交 4.2GB 级需要长传）
- 整 main 一把推 → 逐提交 sha:main 分块（单笔失败不殃及全局，断点可续）
- 成功后不恢复原节点（--keep 语义：推送窗口内保持活点）
运行: python tools/clash_push_chunks.py
"""
import subprocess, sys, time

sys.path.insert(0, r"E:\AI-Station\tools")
import clash_push as cp

ROOT = cp.ROOT


def ensure_alive_node():
    """发现 API + 定位 github 组 + 挑活节点切上；返回 (base, secret, group, node) 或 None。"""
    secret, ports = cp._conf()
    base, ver = cp.discover_api(secret, ports)
    if not base:
        print("[0] NO_API (候选+7890反查均未命中)")
        return None
    print(f"[0] API {base} clash/{ver}")
    group, mode = cp.find_github_group(base, secret)
    print(f"[1] github 组: {group} (mode={mode})")
    g = cp.group_info(base, secret, group)
    now = g.get("now")
    cands = [n for n in g.get("all", []) if n not in ("DIRECT", "REJECT")]
    # 当前节点先探活，活则不折腾
    if now and now not in ("DIRECT", "REJECT"):
        ok, d = cp.node_alive(base, secret, now)
        if ok:
            print(f"[2] 当前节点存活: {now} ({d}ms) — 沿用")
            return base, secret, group, now
    # 逐个候选探活并切换
    tried = 0
    for n in cands:
        ok, d = cp.node_alive(base, secret, n)
        tried += 1
        if ok:
            if cp.switch(base, secret, group, n):
                print(f"[2] 切活节点: {n} ({d}ms, 探测{tried}个)")
                return base, secret, group, n
        if tried >= 15:
            break
    print(f"[2] 无活节点 (探测{tried}个)")
    return None


def push_chunk(sha):
    try:
        proc = subprocess.run(["git", "push", "origin", f"{sha}:refs/heads/main"],
                              cwd=ROOT, capture_output=True, timeout=1800,
                              text=True, encoding="utf-8", errors="ignore")
        out = (proc.stdout or "") + (proc.stderr or "")
        ok = proc.returncode == 0
        tail = out.strip().splitlines()[-1][:120] if out.strip() else ""
        return ok, tail
    except subprocess.TimeoutExpired:
        return False, "timeout-1800s"


def remote_head():
    try:
        proc = subprocess.run(["git", "ls-remote", "origin", "main"], cwd=ROOT,
                              capture_output=True, timeout=60, text=True)
        return (proc.stdout or "").split()[0] if proc.stdout.strip() else ""
    except Exception:
        return ""


def main():
    ctx = ensure_alive_node()
    if not ctx:
        return 1
    shas = subprocess.run(["git", "log", "--reverse", "--format=%H", "origin/main..HEAD"],
                          cwd=ROOT, capture_output=True, text=True).stdout.split()
    print(f"[3] 待推 {len(shas)} 笔，逐块推送（每笔最长 30 分钟）")
    ok_n, fail_n = 0, 0
    for i, sha in enumerate(shas, 1):
        ok, tail = push_chunk(sha)
        mark = "✓" if ok else "✗"
        print(f"  [{i}/{len(shas)}] {mark} {sha[:8]} {tail}", flush=True)
        if ok:
            ok_n += 1
        else:
            fail_n += 1
            # 失败即重切活节点一次再试本笔
            ctx2 = ensure_alive_node()
            if ctx2:
                ok2, tail2 = push_chunk(sha)
                print(f"      重试 {sha[:8]}: {'✓' if ok2 else '✗'} {tail2}", flush=True)
                if ok2:
                    ok_n += 1; fail_n -= 1
                else:
                    print("      连续失败 — 停，断点在案")
                    break
            else:
                print("      无活节点可切 — 停")
                break
    rh = remote_head()
    print(f"[4] 完成: 推成 {ok_n} / 失败 {fail_n} | remote HEAD: {rh[:8] if rh else '?'}")
    return 0 if fail_n == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
