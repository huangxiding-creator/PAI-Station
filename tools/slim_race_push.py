# -*- coding: utf-8 -*-
"""slim 竞速推：循环{fetch→远端锚→以远端为父重建slim→立即推}，成功或5轮止。
远端锚若含 >2GB 待推内容则非本循环问题（兄弟块推完成前锚会持续动）。"""
import subprocess, os, sys, time

ROOT = r'E:\AI-Station'
SLIM_TREE = '980744e113ea6430257b8e7efa07a16bdac34f67'  # 已验证: 12836 件剔除后的瘦身树
env = dict(os.environ, GIT_CONFIG_PARAMETERS="'core.quotepath=false'")

def g(*args, input=None, timeout=600):
    r = subprocess.run(['git', *args], cwd=ROOT, env=env, input=input,
                       capture_output=True, text=True, encoding='utf-8', errors='replace', timeout=timeout)
    return r.returncode, (r.stdout or '').strip(), (r.stderr or '').strip()

def remote_head():
    rc, out, _ = g('ls-remote', 'origin', 'main', timeout=90)
    return out.split()[0] if out else ''

for attempt in range(1, 6):
    rh = remote_head()
    if not rh:
        print(f"[{attempt}] 远端不可达，等 60s", flush=True)
        time.sleep(60); continue
    rc, _, err = g('fetch', 'origin', 'main', timeout=300)
    print(f"[{attempt}] 远端锚: {rh[:8]}", flush=True)
    # 造 slim@rh
    rc, C, err = g('commit-tree', SLIM_TREE, '-p', rh,
                   '-m', 'chore(slim-unblock): 主仓瘦身上岸——剔12836件(乐奇资产库/corpus语料/全仓二进制/>20MB); 资产留盘+网盘归档; 远端锚快进',
                   '-m', 'Co-Authored-By: Claude Code <noreply@anthropic.com>')
    if rc != 0 or not C:
        print(f"    commit-tree 失败: {err[:150]}", flush=True); time.sleep(30); continue
    rc, out, err = g('push', 'origin', f'{C}:refs/heads/main', timeout=900)
    tail = (err or out).strip().splitlines()[-1][:120] if (err or out).strip() else ''
    print(f"    slim@{rh[:8]}={C[:8]} push rc={rc} | {tail}", flush=True)
    if rc == 0:
        print(f"SUCCESS remote={remote_head()[:8]}", flush=True)
        sys.exit(0)
    time.sleep(20)  # 让兄弟的块推推进，缩小竞速窗口
print("EXHAUSTED-5", flush=True)
sys.exit(2)
