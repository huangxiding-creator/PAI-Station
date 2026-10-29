# -*- coding: utf-8 -*-
import os, sys
sys.stdout.reconfigure(encoding="utf-8")
ROOT = r"E:\AI-Station"

def lp(p):
    return "\\\\?\\" + os.path.abspath(p)

sizes = {}
for e in os.scandir(ROOT):
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
        sizes[e.name] = t

for k, v in sorted(sizes.items(), key=lambda x: -x[1])[:15]:
    print(f"{v/1024**3:8.2f} GB  {k}")
print(f"Total dirs: {sum(sizes.values())/1024**3:.1f} GB")
