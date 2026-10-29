# -*- coding: utf-8 -*-
import os, sys
sys.stdout.reconfigure(encoding="utf-8")

def lp(p):
    return "\\\\?\\" + os.path.abspath(p)

def scan(root, label):
    print(f"\n== {label} ==")
    entries = []
    for e in os.scandir(lp(root)):
        if e.is_dir(follow_symlinks=False):
            t = 0
            try:
                for dp, dns, fns in os.walk(lp(e.path)):
                    for fn in fns:
                        try:
                            t += os.path.getsize(os.path.join(dp, fn))
                        except OSError:
                            pass
            except OSError:
                pass
            entries.append((t, e.name, "dir"))
        else:
            try:
                entries.append((e.stat().st_size, e.name, "file"))
            except OSError:
                pass
    for sz, name, kind in sorted(entries, reverse=True)[:15]:
        print(f"  {sz/1024**3:8.2f} GB  [{kind}]  {name}")

scan(r"E:\AI-Station\.claude", ".claude (84.7GB)")
scan(r"E:\AI-Station\tools", "tools (48.7GB)")
scan(r"E:\AI-Station\data", "data (74.1GB)")
