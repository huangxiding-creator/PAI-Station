# -*- coding: utf-8 -*-
import os, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"E:\AI-Station"

def lp(p):
    return "\\\\?\\" + os.path.abspath(p)

def dir_size(path):
    t = 0
    try:
        for dp, dns, fns in os.walk(lp(path)):
            for fn in fns:
                try:
                    t += os.path.getsize(os.path.join(dp, fn))
                except OSError:
                    pass
    except OSError:
        pass
    return t

# 顶层对比（上次 vs 现在）
LAST = {"ResearchFactory-Eng":148, ".claude":84, "data":74, "tools":48, "EngOpp-Mining":31,
        "乐奇AI眼镜":18, ".git":16, "Auto_Manus":12, "_proposals":11, "IdeaDig":7,
        "04 智库":6, "services":5, "逆向工程":5, "corpus":5, "ZBZK":5}

sizes = {}
for e in os.scandir(ROOT):
    if e.is_dir(follow_symlinks=False):
        sizes[e.name] = dir_size(e.path)

print("=== 增量对比（GB）===")
for k, v in sorted(sizes.items(), key=lambda x: -x[1])[:20]:
    prev = LAST.get(k, 0)
    delta = v/1024**3 - prev
    flag = "🔴" if delta > 2 else ("🟡" if delta > 0.5 else "")
    print(f"  {v/1024**3:8.2f} GB ({delta:+7.2f}) {flag} {k}")

# 快速检查已知嫌疑犯
print("\n=== 嫌疑犯检查 ===")
suspects = [
    (r"tools\_repo_backup_tmp", "repo备份暂存"),
    (r".claude\worktrees", "agent工作树"),
    (r"Auto_Manus\data\profiles_v3", "Manus军团profile"),
    (r"data\local_index", "本地索引DB"),
]
for path, label in suspects:
    if os.path.exists(path):
        sz = dir_size(os.path.join(ROOT, path))
        cnt = sum(1 for _ in os.scandir(path)) if os.path.isdir(path) else 0
        print(f"  {sz/1024**3:8.2f} GB  {label} ({cnt} 项) ← {path}")
    else:
        print(f"     不存在  {label}")
