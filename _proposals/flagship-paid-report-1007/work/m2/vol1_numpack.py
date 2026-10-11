# -*- coding: utf-8 -*-
"""卷一融合章数字包: 从卷二/三/四已验收 md 抽「带数字句+标题」-> 每章一包.
包=写手弹药 (句已逐字来自源章, 挂 见N-N 引用即 gate3 可验); 幂等.
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
    # slug: (源章清单 [(卷, 章号)], 说明)
    "zongliang": ([(3, n) for n in range(1, 18)],
                  "1-2 总量与结构: 17省投资盘子段 own_calc 汇总"),
    "moshi": ([(2, n) for n in range(1, 29)] + [(4, 1), (4, 2)],
              "1-4 商业模式演变: 企业池模式共性段 + 储能/风电商业模式段"),
    "geju": ([(2, n) for n in range(1, 29)],
             "1-5 竞争格局四层: 卷二28家预聚合 (组织/资质/区域)"),
    "quyu": ([(3, n) for n in range(1, 18)],
             "1-6 区域市场梯度: 17省分层 own_calc 省际对比"),
    "saidao": ([(4, n) for n in range(1, 9)] + [(2, 1), (2, 2), (2, 8), (2, 14), (2, 26)],
               "1-7 细分赛道: 卷四8专题上卷 + 卷二补交通/化工/市政 (2-1公路/2-2寰球/2-8市政/2-14天辰/2-26华陆)"),
    "daolun": ([(1, n) for n in range(2, 10)],
               "1-1 导论: 卷一 1-2..1-9 兄弟章预聚合 (导论引用挂「见1-N」)"),
}


def chap_path(vol, num):
    hits = glob.glob(os.path.join(BB, f"vol{vol}", f"{vol}-{num}-*.md"))
    return hits[0] if len(hits) == 1 else None


def build(slug, sources, note):
    out_path = os.path.join(HERE, f"vol1_pack_{slug}.txt")
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
        sents = sents[:90]
        parts.append(f"\n==== [{vol}-{num}] {os.path.basename(p)} ====")
        parts += [f"  H| {h}" for h in heads[:14]]
        parts += [f"[{vol}-{num}] {s}" for s in sents]
        total += len(sents)
    open(out_path, "w", encoding="utf-8").write("\n".join(parts) + "\n")
    print(f"[{slug}] {len(sources)} 源 -> {total} 句 ({os.path.getsize(out_path)} bytes)")


if __name__ == "__main__":
    for slug, (srcs, note) in SPECS.items():
        build(slug, srcs, note)
    print("DONE")
