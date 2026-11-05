# -*- coding: utf-8 -*-
"""judgment_corpus_slicer — EPC-CASELAW 判决语料细粒度归挂件 (1031 饱和冲门·一).

任务书: 4.03 亿字 CONTRACT 判例语料 (判决_2009~2021_20.md, 13 件年合并卷)
需细粒度归挂 — 按争议类型关键词分挂到对应 EEI。

机制 (零造假铁律):
  · 源卷只读; 流式按 '---' 分隔符切判决块, 每块只按**优先级词表**归入
    恰好一个争议类型桶 (互斥分派, 同一块绝不重复计数);
  · 每类型 × 两时段 (2009-2016 / 2017-2021) 各出一卷 (文件名不同 →
    独立 host), 每卷上限 --cap-chars 字, 超出即停 (块完整保留);
  · 切片落 data/harvest/judgment_slices/EPC-CASELAW/, 经 ammo_pool.ingest
    正道入池 (engine=corpus_stores:judgment_slice, tree=<EEI>, 实测字数);
  · 台账 corpus_slice_ledger.jsonl 逐类型留痕 (块数/字数/年份/命中规则)。

用法:
  py -X utf8 reforge_factory/epc_caselaw_supply/judgment_corpus_slicer.py \
      [--dry] [--cap-chars 1200000] [--only-scan]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP  # noqa: E402

CID = "EPC-CASELAW"
POOL = AP.POOL_ROOT / CID
OUT = Path(r"E:\AI-Station\data\harvest\judgment_slices\EPC-CASELAW")
LEDGER = POOL / "corpus_slice_ledger.jsonl"
ERA1, ERA2 = (2009, 2016), (2017, 2021)

#: 争议类型 → (目标EEI, 优先级序, 关键词正则). 顺序即优先级: 专属在前, 泛词殿后。
#: 一块只进第一个命中的桶 (互斥)。未命中任何桶 = 不切片 (不重复计数)。
TOPICS: list[tuple[str, str, str]] = [
    ("优先受偿权",   "Q21-E1", r"优先受偿"),
    ("以审计为结算", "Q8-E1",  r"以审计为准|以审计.{0,4}(结果|结论)|审计(结果|结论).{0,8}结算依据"),
    ("视为认可送审", "Q9-E1",  r"视为认可|逾期未答|送审价"),
    ("清单缺项漏项", "Q6-E1",  r"缺项|漏项|漏算|量差"),
    ("索赔期限失权", "Q11-E1", r"索赔期限|索赔时效|索赔失权|丧失索赔|索赔通知"),
    ("停窝工赶工",   "Q17-E1", r"停窝工|停工损失|窝工|停工费|赶工"),
    ("黑白合同",     "Q18-E1", r"黑白合同|实质性变更|另行签订"),
    ("必须招标无效", "Q20-E1", r"必须招标|中标无效|应当招标|应招标而未招标"),
    ("工期延误顺延", "Q16-E1", r"工期延误|工期顺延|顺延工期|误期|逾期竣工"),
    ("固定总价调价", "Q5-E1",  r"固定总价|固定价格|情势变更|价格波动|材料价格|调价|下浮率"),
    ("变更签证",     "Q10-E1", r"工程变更|现场签证|签证单|设计变更|变更签证|口头签证"),
    ("重新鉴定质证", "Q14-E1", r"重新鉴定|鉴定程序违法|鉴定意见.{0,12}(质证|异议|缺陷)"),
    ("鉴定范围依据", "Q15-E1", r"鉴定范围|鉴定依据"),
    ("利息起算垫资", "Q22-E1", r"垫资|利息起算|工程款利息|欠付工程款.{0,6}利息"),
    ("调解司法确认", "Q23-E1", r"调解协议|司法确认|人民调解"),
    ("仲裁与管辖",   "Q26-E1", r"仲裁条款|仲裁协议|专属管辖|管辖权异议|仲裁委员会"),
    ("无效折价补偿", "Q19-E1", r"折价补偿|合同无效|无效合同"),
    ("造价鉴定程序", "Q13-E1", r"造价鉴定|司法鉴定|鉴定机构|鉴定意见|鉴定费"),
    ("竣工结算审减", "Q7-E1",  r"竣工结算|结算审核|送审|审减|高估冒算|结算书|工程结算"),
]
_RX = [(name, eei, re.compile(rx)) for name, eei, rx in TOPICS]
_YEAR = re.compile(r"判决_(\d{4})_20")
_CASENO = re.compile(r"案号[:：]\s*(\S+)")

def year_rows() -> list[dict]:
    rows = [json.loads(x) for x in
            (POOL / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    out = [r for r in rows if r.get("judge") == "valid"
           and _YEAR.search(Path(r.get("source_path", "")).name)]
    return sorted(out, key=lambda r: r["source_path"])


def iter_blocks(path: Path):
    """流式产出 (block_text, ) — 以整行 '---' 为分隔符, 跳过卷首标题块。"""
    buf: list[str] = []
    first = True
    with path.open(encoding="utf-8", errors="replace") as fh:
        for line in fh:
            if line.rstrip("\r\n") == "---":
                blk = "\n".join(buf).strip()
                buf = []
                if first:               # 卷首 '# 裁判文书 YYYY_20' 标题块
                    first = False
                    continue
                if blk:
                    yield blk
                continue
            buf.append(line)
    blk = "\n".join(buf).strip()
    if blk and not first:
        yield blk


def classify(block: str) -> tuple[str, str] | tuple[None, None]:
    head = block[:4000]                 # 案由/诉讼请求/裁判要点集中在块首
    for name, eei, rx in _RX:
        if rx.search(head):
            return name, eei
    return None, None


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--cap-chars", type=int, default=1_200_000)
    ap.add_argument("--only-scan", action="store_true",
                    help="只统计分派分布, 不写切片不入池")
    ns = ap.parse_args()

    rows = year_rows()
    print(f"[slicer] 源年卷 {len(rows)} 件 | 总 "
          f"{sum(r['chars'] for r in rows):,} 字")
    stats: dict[tuple[str, str], dict] = {}
    for r in rows:
        p = Path(r["source_path"])
        yr = int(_YEAR.search(p.name).group(1))
        era = "2009-2016" if yr <= ERA1[1] else "2017-2021"
        t0 = time.time()
        n = 0
        for blk in iter_blocks(p):
            n += 1
            name, eei = classify(blk)
            if not name:
                continue
            k = (name, era)
            st = stats.setdefault(k, {"eei": eei, "blocks": 0, "chars": 0,
                                      "samples": [], "years": set()})
            st["blocks"] += 1
            st["chars"] += len(blk)
            st["years"].add(yr)
            if len(st["samples"]) < 3:
                m = _CASENO.search(blk)
                st["samples"].append(m.group(1)[:28] if m else blk[:24])
        print(f"  扫 {p.name}: 块 {n:,} | {time.time()-t0:.1f}s", flush=True)

    # ---- 分布报告 ----
    print("\n[slicer] 分派分布 (类型×时段 → 块数/字数):")
    for (name, era) in sorted(stats):
        st = stats[(name, era)]
        print(f"  {name:<6s} {era} → {st['eei']:<7s} 块 {st['blocks']:>6,} "
              f"字 {st['chars']:>12,} 例 {st['samples'][:2]}")

    if ns.only_scan:
        return 0

    # ---- 写切片 (单遍重扫, 互斥分派 + cap 截断) ----
    OUT.mkdir(parents=True, exist_ok=True)
    src_rows = {Path(r["source_path"]).name: r for r in rows}
    written: dict[tuple[str, str], Path] = {}
    for r in rows:
        p = Path(r["source_path"])
        yr = int(_YEAR.search(p.name).group(1))
        era = "2009-2016" if yr <= ERA1[1] else "2017-2021"
        for blk in iter_blocks(p):
            name, eei = classify(blk)
            if not name:
                continue
            k = (name, era)
            f = written.get(k)
            if f is None:
                f = OUT / f"判决语料切片_{name}_{era}.md"
                f.write_text("", encoding="utf-8")
                written[k] = f
            cur = f.stat().st_size
            if cur >= ns.cap_chars:
                continue
            with f.open("a", encoding="utf-8") as fh:
                if cur:
                    fh.write("\n\n---\n\n")
                fh.write(blk)

    print(f"\n[slicer] 切片落盘 {len(written)} 卷 → {OUT}")
    if ns.dry:
        for f in sorted(written.values()):
            print(f"  (dry) {f.name}  {f.stat().st_size:,}B")
        return 0

    n_ing = 0
    with LEDGER.open("a", encoding="utf-8") as lf:
        lf.write(json.dumps({"ts": time.strftime("%F %T"), "phase": "plan",
                             "cap_chars": ns.cap_chars,
                             "distribution": {f"{k[0]}|{k[1]}":
                                              {"eei": v["eei"],
                                               "blocks": v["blocks"],
                                               "chars": v["chars"],
                                               "years": sorted(v["years"])}
                                              for k, v in stats.items()}},
                             ensure_ascii=False) + "\n")
        for (name, era), f in sorted(written.items()):
            eei = next(v["eei"] for k, v in stats.items()
                       if k[0] == name and k[1] == era)
            src = src_rows.get(f"判决_{era.split('-')[0]}_20.md") or \
                next(iter(src_rows.values()))
            rc = AP.ingest(CID, str(f),
                           engine="corpus_stores:judgment_slice",
                           url="", cred=src.get("credibility") or "research",
                           tree=eei, stance="support", band="gap")
            txt = f.read_text(encoding="utf-8", errors="replace")
            n_blocks = txt.count("\n\n---\n\n") + 1
            rec = {"ts": time.strftime("%F %T"), "file": str(f),
                   "topic": name, "era": era, "eei": eei,
                   "bytes": f.stat().st_size, "blocks_written": n_blocks,
                   "ingest_rc": rc,
                   "source_corpus": "EPC-CONTRACT 判决_2009~2021 年卷 "
                                    "(crosspool 4.03亿字, 源卷只读)"}
            lf.write(json.dumps(rec, ensure_ascii=False) + "\n")
            n_ing += 1
            print(f"  +{f.name} → {eei} (rc={rc}, 块 {n_blocks})")
    print(f"[slicer] 入池 {n_ing} 卷 (判层留 judge)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
