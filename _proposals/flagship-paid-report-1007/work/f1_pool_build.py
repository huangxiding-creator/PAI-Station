# -*- coding: utf-8 -*-
"""F1-BLUEBOOK 弹药池建档 + 存量语料分层判定 — 1010 用户令「三件事全部完成」之一。

四步 (幂等, manifest 按 source_path+dedup_key 去重, 重跑零重复):
  1. init ammo_pool/F1-BLUEBOOK (kws = judge 相关性判据 + T3 词面);
  2. 写 tiers.json 分层词表 (T1=研究对象本体; T2=同业对标; 标题级下界);
  3. 存量语料 67 目录 docx 全量入池 engine=stock:corpus cred=research
     (口径与 f1_inventory.json 严格对齐: 只入 docx, PDF 留档防双计);
  4. judge 全量判定 → rebuild 对账 → tier_report 分层账持久化进
     pool_state.json (collection_gate.measure 读的真源键 t1_chars/t2_chars)。

用法: python f1_pool_build.py             # 全链
      python f1_pool_build.py --rejudge   # 只重判+重落账 (词表改后)
"""
import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.path.insert(0, r"E:\AI-Station\reforge_factory")
import ammo_pool as ap                                   # noqa: E402

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
CID = "F1-BLUEBOOK"
CORPUS = Path(r"F:\新建文件夹\AI总包创新院\总包研报")


def norm_title(name: str) -> str:
    """同题归并键: 剥版本饰词 (副本/排版稿/中间成果/日期戳/院署名)。

    一份报告只计一次 — 同题多版本只入最大主稿, 其余留档不入池
    (字数门防自欺: 副本重复计数 = 虚账, 1010 建池首轮实锤
    核电指南正本+副本双入 31.8 万字)。"""
    s = Path(name).stem
    s = re.sub(r"（总包创研院）|\(总包创研院\)|电子书：", "", s)
    s = re.sub(r"[-－—\s]*(副本|最终版|终稿|完整版|中间成果|初稿|"
               r"电子书|排版\s*\d*|\d{6}|\d{8}|A?)", "", s)
    return re.sub(r"\s+", "", s)

# 分层词表 (tier_report 按文件标题匹配, 标题级下界 — EPC49 惯例):
#   T1 = 研究对象本体 (蓝皮书 = 中国 EPC 产业全景 → EPC 族词)
#   T2 = 同业对标 (行业主体/领域对标面)
#   kws 命中 = T3 行业框架 (封顶 5000 万); 无命中 = T0 不计。
TIERS = {
    "T1": ["EPC", "工程总承包", "总承包", "设计采购施工"],
    "T2": ["设计院", "电力设计", "工程咨询", "中国电建", "中国能建",
           "中国建筑", "中建", "中铁", "中交", "中冶", "电建", "能建",
           "水利工程", "水利", "核电", "电厂", "建筑", "施工", "市政",
           "公路", "铁路", "电力", "能源", "市场机会"],
    "_note": ("1005 用户定调: 有效=对当前研究报告有帮助。T1=研究对象本体"
              "(蓝皮书=EPC产业 → EPC族词), T2=同业对标, kws命中=T3 行业"
              "框架(封顶5000万), 无命中=T0 不计。1010 建档; 词表变更须"
              " GOAL_LEDGER 留痕。"),
}
KWS = ("工程总承包 EPC 总承包 设计院 建筑业 施工 中标 招标 投资 "
       "工程项目 项目管理 工程建设 电力 水利 能源 建筑企业")


def persist_tier_keys(cid: str = CID) -> dict:
    """tier_report 结果写回 pool_state (collection_gate.measure 的真源)."""
    tr = ap.tier_report(cid)
    d = ap._camp_dir(cid)
    with ap._pool_lock(d):
        s = ap._load_state(d)
        ns = {**s, "t1_chars": tr["t1"], "t2_chars": tr["t2"],
              "t3_chars": tr["t3"], "t0_chars": tr["t0"],
              "t1_items": tr["n1"], "t2_items": tr["n2"],
              "t3_items": tr["n3"], "t0_items": tr["n0"],
              "gate_chars": tr["gate_chars"], "tier_gate_ok": tr["gate_ok"],
              "tiers_configured": tr["tiers_configured"],
              "last_tier_persist": time.strftime("%Y-%m-%d %H:%M")}
        ap._save_state(d, ns)
    return tr


def build(rejudge_only: bool = False) -> int:
    if not rejudge_only:
        # ①② init + tiers 词表
        d = ap._camp_dir(CID)
        s = ap._load_state(d)
        ap._save_state(d, {**s, "campaign": CID, "kws": ap.parse_kws(KWS)})
        (d / "tiers.json").write_text(
            json.dumps(TIERS, ensure_ascii=False, indent=1),
            encoding="utf-8")
        print(f"[init] {CID} kws={len(ap.parse_kws(KWS))} 词 + "
              f"tiers T1={len(TIERS['T1'])}/T2={len(TIERS['T2'])}")
        # ③ 存量语料 docx 入池 — 同题归并只入最大主稿 (00 目录与
        #    f1_inventory 口径一致地跳过; 副本/排版/中间成果留档不计)
        cand = [p for d in sorted(CORPUS.iterdir())
                if d.is_dir() and not d.name.startswith("00")
                for p in d.rglob("*.docx") if not p.name.startswith("~$")]
        best: dict[str, tuple[int, Path]] = {}
        for p in cand:
            ch = ap.count_chars(ap.read_text_safe(p))
            k = norm_title(p.name)
            if k not in best or ch > best[k][0]:
                best[k] = (ch, p)
        files = sorted((p for _, p in best.values()))
        print(f"[ingest] 候选 {len(cand)} docx → 同题归并后主稿 "
              f"{len(files)} 件 (副本/排版/中间成果留档不入池)")
        for i, fp in enumerate(files, 1):
            ap.ingest(CID, file=str(fp), engine="stock:corpus",
                      cred="research")
            if i % 25 == 0:
                print(f"  … {i}/{len(files)}", flush=True)
        # ④ 判定 + 对账
        ap.judge(CID, limit=0)
    else:
        ap.judge(CID, limit=0)
    ap.rebuild(CID)
    tr = persist_tier_keys()
    t12 = tr["t1"] + tr["t2"]
    print(f"\n[分层账] T1={tr['t1']:,} ({tr['n1']}件) | T2={tr['t2']:,} "
          f"({tr['n2']}件) | T3={tr['t3']:,} ({tr['n3']}件) | "
          f"T0={tr['t0']:,} ({tr['n0']}件)")
    print(f"[字数门] T1 {'✅' if tr['t1'] >= ap.T1_MIN_CHARS else '⏳'} "
          f"{tr['t1']:,}/{ap.T1_MIN_CHARS:,} ∧ "
          f"T1+T2 {'✅' if t12 >= ap.T12_MIN_CHARS else '⏳'} "
          f"{t12:,}/{ap.T12_MIN_CHARS:,} → "
          f"{'PASS' if tr['gate_ok'] else 'FAIL'}")
    return 0


def main() -> int:
    apx = argparse.ArgumentParser()
    apx.add_argument("--rejudge", action="store_true",
                     help="只重判+重落分层账 (跳过入池)")
    args = apx.parse_args()
    return build(rejudge_only=args.rejudge)


if __name__ == "__main__":
    sys.exit(main())
