# -*- coding: utf-8 -*-
"""卷一 1-3 政策包: 17省 bank 政策段 + 合规指南(沉思录bank P500000+区)政策节
-> vol1_bank_policy.txt (真身 bank, 锚点 6 位槽位制, m2_gate2 直验)

槽位: 省 k(0起) = 100000 + 50000*k, 容量 49999/省 (各 bank 段锚 << 此数)
      合规指南 = 950000 起 (原 P500000+ 区只取政策相关段, 重编号)
段筛选: 段文本命中政策正则 (文号/办法/意见/通知/规划 等) 且含数字 (年份/文号)
幂等: 输出存在即跳过 (--force 重跑).
"""
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))

PROVINCES = [
    ("湘", "hunan"), ("黔", "guizhou"), ("琼", "hainan"), ("皖", "anhui"),
    ("新", "xinjiang"), ("川", "sichuan"), ("浙", "zhejiang"), ("宁", "ningxia"),
    ("冀", "hebei"), ("青", "qinghai"), ("黑", "heilongjiang"), ("闽", "fujian"),
    ("鲁", "shandong"), ("晋", "shanxi"), ("津", "tianjin"), ("鄂", "hubei"),
    ("滇", "yunnan"),
]

POLICY_RE = re.compile(
    r"〔\d{4}〕|号文|国办发|住建部|发改委|发展改革委|交通运输部|水利部|能源局"
    r"|管理办法|指导意见|实施细则|实施方案|若干政策|行动计划|工作方案|管理条例"
    r"|招投标|必须招标|政府投资项目|审批制|核准制|备案制|总承包.{0,6}(推行|试点|推广)"
)
NUM_RE = re.compile(r"\d")
ANCHOR_RE = re.compile(r"\[P(\d{1,6})\]")


def paragraphs(bank_path, lo=None, hi=None):
    """bank -> [(orig_anchor:int, text:str)] 可选锚点区间过滤."""
    txt = open(os.path.join(HERE, bank_path), encoding="utf-8").read()
    out, buf, cur = [], [], None
    for tok in re.split(r"(\[P\d{1,6}\])", txt):
        m = re.fullmatch(r"\[P(\d{1,6})\]", tok)
        if m:
            if cur is not None:
                out.append((cur, "".join(buf).strip()))
            cur, buf = int(m.group(1)), []
        elif cur is not None:
            buf.append(tok)
    if cur is not None:
        out.append((cur, "".join(buf).strip()))
    if lo is not None:
        out = [(a, t) for a, t in out if lo <= a < hi]
    return out


def build(out_path, force=False):
    if os.path.exists(out_path) and not force:
        print("skip (exists)")
        return
    parts, stats = [], []
    # --- 17 省: 政策段 (省章重编号 P100000+50k*k) ---
    for k, (cn, slug) in enumerate(PROVINCES):
        base = 100000 + 50000 * k
        paras = paragraphs(f"{slug}.txt")
        keep = [(a, t) for a, t in paras
                if len(t) >= 20 and POLICY_RE.search(t) and NUM_RE.search(t)]
        # 每省上限 500 段防失控
        keep = keep[:500]
        seg = [f"[P{base}] ◆省={cn} 源=hunan类bank:{slug} 原锚区间 P{keep[0][0]}-P{keep[-1][0]}"
               if keep else ""]
        for i, (a, t) in enumerate(keep):
            seg.append(f"[P{base + 1 + i}] {t}")
        seg = [s for s in seg if s]
        parts.append("\n".join(seg) + "\n")
        stats.append((cn, slug, len(keep)))
    # --- 合规指南政策节 (fengcheng bank P500000+ 区, 重编号 P950000+) ---
    guide = paragraphs("topic_fengcheng.txt", lo=500000, hi=10 ** 7)
    keep_g = [(a, t) for a, t in guide
              if len(t) >= 20 and POLICY_RE.search(t) and NUM_RE.search(t)][:800]
    if keep_g:
        seg = [f"[P950000] ◆源=工程总承包招投标合规工作指南 (bank 原锚 P500000+ 区)"]
        for i, (a, t) in enumerate(keep_g):
            seg.append(f"[P950001 + {i}]".replace(" + ", "") + f" {t}")
        # 上一行 replace 保守写法可能仍带空格, 直接重写:
        seg = [f"[P950000] ◆源=工程总承包招投标合规工作指南"]
        seg += [f"[P{950001 + i}] {t}" for i, (a, t) in enumerate(keep_g)]
        parts.append("\n".join(seg) + "\n")
        stats.append(("指南", "fengcheng", len(keep_g)))
    open(out_path, "w", encoding="utf-8").write("".join(parts))
    for cn, slug, n in stats:
        print(f"  {cn}({slug}): {n} 段")
    total = sum(n for _, _, n in stats)
    print(f"-> {out_path} ({sum(len(p) for p in parts)} chars, {total} 段)")


if __name__ == "__main__":
    force = "--force" in sys.argv
    build(os.path.join(HERE, "vol1_bank_policy.txt"), force=force)
