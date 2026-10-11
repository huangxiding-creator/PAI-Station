# -*- coding: utf-8 -*-
"""卷五融合/判断章数字包: 从已验收 md 抽「带数字句+标题」-> 每章一包.
包=写手弹药 (句已逐字来自源章, 挂 见N-N 引用即 gate3_vol5 可验); 幂等.
"""
import glob
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
BB = r"E:\AI-Station\_proposals\flagship-paid-report-1007\bluebook"

NUM = re.compile(r"\d[\d,]*(?:\.\d+)?(?=\s*(?:亿|万|％|%|个百分点))|(?<![\d.])(?:19|20)\d{2}(?![\d.])")

SPECS = {
    # slug: (源章清单 [(卷, 章号)], 每章句上限, 说明)
    "54": ([(2, n) for n in range(0, 29)], 60,
           "5-4 跨库判断I 组织与模式: 卷二 28 家+2-0/2-29 融合章全量 (梯队/模式迁移/病理)"),
    "55": ([(3, n) for n in range(0, 18)] + [(4, n) for n in range(1, 9)], 60,
           "5-5 跨库判断II 区域与赛道: 卷三 17 省+3-0 × 卷四 8 专题 (选择矩阵)"),
    "57": ([(1, n) for n in range(2, 10)] + [(2, n) for n in range(0, 29)]
           + [(3, n) for n in range(0, 18)] + [(4, n) for n in range(0, 10)], 20,
           "5-7 预判清单 20 条: 四卷全部章基线数 (每章限量 20 句防包爆炸)"),
}


def chap_path(vol, num):
    hits = glob.glob(os.path.join(BB, f"vol{vol}", f"{vol}-{num}-*.md"))
    return hits[0] if len(hits) == 1 else None


def build(slug, sources, per_cap, note):
    out_path = os.path.join(HERE, f"vol5_pack_{slug}.txt")
    if os.path.exists(out_path):
        print(f"[{slug}] skip (exists)")
        return
    parts = [f"◆数字包={note}; 每行=源章逐字句, 行首[卷-章]=引用号 (写手挂「见N-N」)",
             f"◆源章数={len(sources)}"]
    total = 0
    for vol, num in sources:
        p = chap_path(vol, num)
        if not p:
            parts.append(f"◆MISSING {vol}-{num}")
            continue
        md = open(p, encoding="utf-8").read()
        heads = [l.strip() for l in md.splitlines() if re.match(r"^#{1,3} ", l)]
        sents, seen = [], set()
        for s in re.split(r"[。；\n]", md):
            s = s.strip()
            if not s or len(s) < 12 or "own_calc" in s or s in seen:
                continue
            if NUM.search(s):
                sents.append(s[:200])
                seen.add(s)
        sents = sents[:per_cap]
        parts.append(f"\n==== [{vol}-{num}] {os.path.basename(p)} ====")
        parts += [f"  H| {h}" for h in heads[:10]]
        parts += [f"[{vol}-{num}] {s}" for s in sents]
        total += len(sents)
    open(out_path, "w", encoding="utf-8").write("\n".join(parts) + "\n")
    print(f"[{slug}] {len(sources)} 源 -> {total} 句 ({os.path.getsize(out_path)} bytes)")


if __name__ == "__main__":
    for slug, (srcs, cap, note) in SPECS.items():
        build(slug, srcs, cap, note)
    print("DONE")
