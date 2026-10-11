# -*- coding: utf-8 -*-
"""卷一 1-9 时效 bank: F1 池 cross:rss 件筛 2026-07..10 (Q3+Q4至今) EPC 相关
-> vol1_bank_q3.txt (锚 P1000+, m2_gate2 直验; 头部=完备门过账统计供章内披露).
纪律: 池内已判有效件, 非新采; 每件截正文头 ~1400 字; 幂等.
"""
import json
import os
import re
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = os.path.dirname(os.path.abspath(__file__))
POOL = r"E:\AI-Station\ammo_pool\F1-BLUEBOOK\manifest.jsonl"

DATE_RE = re.compile(r"articles[\\/](2026-(?:0[789]|10))-[0-9]{2}[\\/]")
TITLE_RE = re.compile(r'title:\s*"([^"]+)"')
ACCT_RE = re.compile(r"account:\s*(\S+)")
KW_RE = re.compile(
    r"EPC|总承包|工程承包|设计施工一体化|交钥匙"
    r"|管理办法|指导意见|实施细则|条例|规划|行动方案|政策"
    r"|中标|签约|开工|投产|并网|核准|批复|可行性研究|初步设计"
)
# 明确噪音号 (律师号/招聘号等与行业时效无关) — 标题不滤号, 靠关键词+人工抽检
BAD_TITLE_RE = re.compile(r"招聘|诚聘|讲座|培训报名|招标公告|询价|废标")


def build(out_path, max_items=140):
    if os.path.exists(out_path):
        print("skip (exists)")
        return
    items, total_rss, total_q3 = [], 0, 0
    with open(POOL, encoding="utf-8") as f:
        for line in f:
            if not line.strip():
                continue
            it = json.loads(line)
            if it.get("engine") != "cross:rss" or it.get("judge") != "valid":
                continue
            total_rss += 1
            sp = it.get("source_path", "")
            dm = DATE_RE.search(sp)
            if not dm:
                continue
            total_q3 += 1
            head = it.get("text_head", "")
            tm = TITLE_RE.search(head)
            title = tm.group(1) if tm else os.path.basename(sp)[:60]
            if not KW_RE.search(title) or BAD_TITLE_RE.search(title):
                continue
            items.append((dm.group(1), it))
    items.sort(key=lambda x: x[0])          # 按月分桶时序
    items = items[-max_items:]
    parts = [
        "[P100000] ◆时效件包=F1池cross:rss已判有效件筛2026年9-10月EPC相关, "
        "非新采(完备门过账: 池内rss有效件{r}件中2026-09..10时段{q}件, "
        "标题关键词命中取未{n}件, 每件截正文头约1400字)".format(
            r=total_rss, q=total_q3, n=len(items))
    ]
    kept = 0
    for i, (mon, it) in enumerate(items):
        sp = it["source_path"]
        try:
            raw = open(sp, encoding="utf-8", errors="replace").read()
        except OSError:
            continue
        body = raw.split("---", 2)[-1].strip()          # 剥 frontmatter
        body = re.sub(r"\s+", " ", body)[:1400]
        am = ACCT_RE.search(it.get("text_head", ""))
        acct = am.group(1) if am else "?"
        parts.append(f"[P{100001 + 2 * i}] ◆{mon}|{acct}|{os.path.basename(sp)[:70]}")
        parts.append(f"[P{100002 + 2 * i}] {body}")
        kept += 1
    out = "\n".join(parts) + "\n"
    open(out_path, "w", encoding="utf-8").write(out)
    print(f"rss_valid={total_rss} in_window={total_q3} kept={kept} "
          f"-> {out_path} ({len(out)} chars)")


if __name__ == "__main__":
    build(os.path.join(HERE, "vol1_bank_q3.txt"))
