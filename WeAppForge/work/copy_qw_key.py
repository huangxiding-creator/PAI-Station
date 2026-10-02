# -*- coding: utf-8 -*-
import shutil
from pathlib import Path

root = Path(r"E:\AI-Station")
src = None
for d in root.iterdir():
    if d.is_dir() and "小程序" in d.name:
        cand = d / "private.wxd096fc6994ef6f48.key"
        if cand.exists():
            src = cand
            break
if src is None:
    # 全盘兜底：根下任意位置找该 key
    for cand in root.rglob("private.wxd096fc6994ef6f48.key"):
        src = cand
        break
assert src, "key 未找到"
dst = root / "data" / "secrets" / "private.wxd096fc6994ef6f48.key"
shutil.copy2(src, dst)
print("OK", src, "->", dst, dst.stat().st_size, "bytes")
