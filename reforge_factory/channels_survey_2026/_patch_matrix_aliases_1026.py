# -*- coding: utf-8 -*-
"""channel_matrix.py CHANNEL_ALIASES 只增5键 (1026 B级数据集波; bak先行; 幂等)."""
import shutil, time
from pathlib import Path
P = Path(r"E:/AI-Station/reforge_factory/completeness/channel_matrix.py")
BAK = P.with_suffix(".py.bak_1026_pre_btier_ds")
src = P.read_text(encoding="utf-8")
NEW_KEYS = ["opensanctions", "common_crawl", "overture_maps", "aiddata", "ofac_sdn"]
BLOCK = (
    '    # --- 1026 B级数据集波: 数据集形态引擎别名 (腿=legs/*_ds_leg.py; 渠道建渠走T-015, 先注册防by_engine漏记) ---\n'
    '    "opensanctions": ["opensanctions", "opensanctions_ds"],\n'
    '    "common_crawl": ["common_crawl", "commoncrawl", "common_crawl_2", "commoncrawl_ds"],\n'
    '    "overture_maps": ["overture_maps", "overture", "overture_maps_foundation", "overture_ds"],\n'
    '    "aiddata": ["aiddata", "aiddata_gcdf", "aiddata_gcdf_ds"],\n'
    '    "ofac_sdn": ["ofac_sdn", "ofac_sdn_ds"],\n'
)
MARK = "1026 B级数据集波"
if MARK in src:
    print("ALREADY_PATCHED idempotent-skip")
else:
    anchor = "CHANNEL_ALIASES: dict[str, list[str]] = {"
    i = src.index(anchor) + len(anchor)
    depth, j = 1, i
    while depth > 0:
        c = src[j]
        if c == "{": depth += 1
        elif c == "}": depth -= 1
        j += 1
    close = j - 1                      # 匹配闭括号位置
    new = src[:close] + BLOCK + src[close:]
    if not BAK.exists():
        shutil.copyfile(P, BAK)
        print("BAK %s bytes=%d" % (BAK.name, BAK.stat().st_size))
    P.write_text(new, encoding="utf-8")
    print("PATCHED bytes=%d -> %d (+%d)" % (len(src.encode('utf-8')), P.stat().st_size, P.stat().st_size - len(src.encode('utf-8'))))
for k in NEW_KEYS:
    print("KEY %s present=%s" % (k, ('"%s": [' % k) in P.read_text(encoding="utf-8")))
