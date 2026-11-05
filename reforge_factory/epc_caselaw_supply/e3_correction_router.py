# -*- coding: utf-8 -*-
"""e3_correction_router — EPC-CASELAW E3 归挂纠偏件 (1031 饱和冲门·六).

背景: e3_authority_router 首版把 8 件 bdn「检索简报」(网盘命中面收割,
非规范/司法解释原文) 误挂 E3 权威位 — 违反归挂不造假, 本件纠偏:
  A. 撤挂: 8 件 bdn 简报 E3→空槽 (交回 tree_backfill 泛词重挂 E1/E2);
  B. 误抓件处理: dqmt(河南建科院首页, 内容与计划不符)→空槽;
     sgrq/gb50500j(论坛实务解读, 非原文)→Q9-E1/Q4-E1 正面位;
     sfdsj(court.gov.cn 司法解释二发布页, 原计划"大数据报告"未命中,
     内容重定性=司法解释发布原文)→Q1-E3;
  C. 判例原文归 E3: 判决语料切片 (判决书全文 = E3 need 三允许之一
  "判例原文") 成对移挂对应 E3 槽; E1 槽保留其余件 (饱和不破)。

每条改动落 e3_correction_ledger.jsonl。用法:
  py -X utf8 e3_correction_router.py [--dry]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP  # noqa: E402

CID = "EPC-CASELAW"
POOL = AP.POOL_ROOT / CID
LEDGER = POOL / "e3_correction_ledger.jsonl"

#: A. 撤挂 (bdn 检索简报 8 件): stem 精确匹配 → tree_node 置空
UNDO = [
    "建设工程造价鉴定规范-GB-T-51262",
    "最高人民法院-优先受偿权-司法解释",
    "最高人民法院-竣工结算-司法解释",
    "最高人民法院-工程变更-签证-索赔-裁判规则",
    "人民法院案例库-索赔-判例",
    "最高人民法院-调解协议司法确认-规定",
    "最高人民法院-工期延误-顺延-裁判规则",
    "最高人民法院-固定总价合同-结算-裁判规则",
]

#: B. 误抓件重定: (stem 子串, 新tree, 理由)
REFILE = [
    ("最高法民一庭庭长答记者问建工解释", "",
     "误抓: 内容=河南建科院首页 (锚词误命中), 与答记者问计划不符 → 空槽交回泛词"),
    ("逾期视为认可送审价规则文", "Q9-E1",
     "论坛实务解读 (按送审价认定价款) 非原文 → 正面位"),
    ("清单计价标准50500解读固定总价", "Q4-E1",
     "论坛标准解读 (新版清单6大变化) 非原文 → 正面位"),
    ("必须招标规定解读建工语境", "",
     "误抓: 嘉善县实施意见解读, 非必须招标规定原文 → 空槽交回泛词"),
    ("建工合同纠纷司法大数据报告", "Q1-E3",
     "原计划大数据报告未命中; 实抓=court.gov.cn 司法解释二发布页 "
     "(最高法权威发布原文) → 内容重定性挂 Q1-E3"),
]

#: C. 判例原文 (判决语料切片) 移挂 E3: (切片文件名子串, 新tree, 理由)
SLICE_MOVES = [
    ("判决语料切片_固定总价调价_2009-2016", "Q4-E3",
     "固定总价判决书全文 → Q4-E3 判例原文 (E1 保留 6 件)"),
    ("判决语料切片_固定总价调价_2017-2021", "Q5-E3",
     "固定总价判决书全文 → Q5-E3 判例原文"),
    ("判决语料切片_竣工结算审减_2009-2016", "Q7-E3",
     "竣工结算判决书全文 → Q7-E3 判例原文 (E1 保留 _2017-2021 切片+11件)"),
    ("判决语料切片_变更签证_2009-2016", "Q10-E3",
     "变更签证判决书全文 → Q10-E3 判例原文 (E1 保留 8 件)"),
    ("判决语料切片_变更签证_2017-2021", "Q10-E3",
     "变更签证判决书全文 → Q10-E3 判例原文第二独立件"),
    ("判决语料切片_视为认可送审_2009-2016", "Q9-E3",
     "视为认可送审判决书全文 → Q9-E3 判例原文 (与示范文本全文成对)"),
    ("判决语料切片_重新鉴定质证_2009-2016", "Q14-E3",
     "重新鉴定质证判决书全文 → Q14-E3 判例原文 (E1 保留 _2017-2021+4件)"),
    ("判决语料切片_黑白合同_2009-2016", "Q18-E3",
     "黑白合同判决书全文 → Q18-E3 判例原文 (与司法解释一全文成对)"),
    ("判决语料切片_无效折价补偿_2009-2016", "Q19-E3",
     "无效折价判决书全文 → Q19-E3 判例原文"),
    ("判决语料切片_无效折价补偿_2017-2021", "Q19-E3",
     "无效折价判决书全文 → Q19-E3 判例原文第二独立件"),
    ("判决语料切片_利息起算垫资_2009-2016", "Q22-E3",
     "利息垫资判决书全文 → Q22-E3 判例原文 (与农民工工资条例成对)"),
    ("判决语料切片_调解司法确认_2009-2016", "Q23-E3",
     "调解司法确认判决书全文 → Q23-E3 判例原文 (与人民调解法成对)"),
    ("判决语料切片_造价鉴定程序_2009-2016", "Q13-E3",
     "造价鉴定判决书全文 → Q13-E3 判例原文 (E1 保留 _2017-2021+32件)"),
    ("判决语料切片_优先受偿权_2009-2016", "Q21-E3",
     "优先受偿权判决书全文 → Q21-E3 判例原文 (E1 保留 33 件)"),
    ("判决语料切片_优先受偿权_2017-2021", "Q21-E3",
     "优先受偿权判决书全文 → Q21-E3 判例原文第二独立件"),
    ("判决语料切片_停窝工赶工_2017-2021", "Q12-E3",
     "停窝工判决书全文 → Q12-E3 反索赔判例原文 (E1 保留 _2009-2016+2件)"),
    ("判决语料切片_索赔期限失权_2009-2016", "Q11-E3",
     "索赔期限判决书全文 → Q11-E3 判例原文 (E1 保留 _2017-2021+4件)"),
    ("判决语料切片_索赔期限失权_2017-2021", "Q11-E3",
     "索赔期限判决书全文 → Q11-E3 判例原文第二独立件"),
    ("判决语料切片_鉴定范围依据_2009-2016", "Q15-E3",
     "鉴定范围判决书全文 → Q15-E3 判例原文 (E1 保留 _2017-2021+4件)"),
    ("判决语料切片_鉴定范围依据_2017-2021", "Q15-E3",
     "鉴定范围判决书全文 → Q15-E3 判例原文第二独立件"),
    ("判决语料切片_必须招标无效_2009-2016", "Q20-E3",
     "必须招标判决书全文 → Q20-E3 判例原文 (E1 保留 _2017-2021+3件)"),
    ("判决语料切片_必须招标无效_2017-2021", "Q20-E3",
     "必须招标判决书全文 → Q20-E3 判例原文第二独立件"),
    ("判决语料切片_工期延误顺延_2009-2016", "Q17-E3",
     "工期延误判决书全文 → Q17-E3 判例原文 (E1 保留 _2017-2021+2件)"),
    ("判决语料切片_仲裁与管辖_2009-2016", "Q26-E3",
     "管辖判决书全文 → Q26-E3 判例原文第三独立件 (E1 保留 _2017-2021+1件)"),
]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    mp = POOL / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]

    ops: list[tuple[int, str, str]] = []        # (idx, new_tree, reason)
    with LEDGER.open("a", encoding="utf-8") as lf:
        def find(sub: str, eng: str = "") -> int | None:
            for i, r in enumerate(rows):
                st = Path(r.get("source_path", "")).stem
                if sub in st and (not eng or eng in str(r.get("engine", ""))):
                    if not any(o[0] == i for o in ops):
                        return i
            return None

        lf.write(json.dumps({"ts": time.strftime("%F %T"),
                             "phase": "undo-bdn-simbao",
                             "n": len(UNDO)}, ensure_ascii=False) + "\n")
        for stem in UNDO:
            i = find(stem, "bdn")
            if i is None:
                print(f"  × 未命中 {stem[:40]}")
                continue
            ops.append((i, "", f"撤挂: bdn检索简报非权威原文 {stem[:30]}"))
        for sub, tree, why in REFILE:
            i = find(sub, "website:gov_statute")
            if i is None:
                print(f"  × 未命中 {sub[:40]}")
                continue
            ops.append((i, tree, why))
        for sub, tree, why in SLICE_MOVES:
            i = find(sub, "corpus_stores")
            if i is None:
                print(f"  × 未命中 {sub[:44]}")
                continue
            ops.append((i, tree, why))

    print(f"[correct] 计划改动 {len(ops)} 行")
    for i, tree, why in ops:
        print(f"  {'→' + tree if tree else '→(空)':10s} "
              f"{Path(rows[i]['source_path']).stem[:44]} | {why[:46]}")
    if ns.dry:
        return 0

    for i, tree, _ in ops:
        rows[i]["tree_node"] = tree
        rows[i]["stance"] = "against" if tree.endswith("-E2") else "support"
    with LEDGER.open("a", encoding="utf-8") as lf:
        for i, tree, why in ops:
            lf.write(json.dumps(
                {"ts": time.strftime("%F %T"), "file": rows[i]["source_path"],
                 "old": "…", "new": tree, "reason": why},
                ensure_ascii=False) + "\n")
    tmp = mp.with_suffix(".jsonl.tmp")
    tmp.write_text("".join(json.dumps(r, ensure_ascii=False) + "\n"
                           for r in rows), encoding="utf-8")
    tmp.replace(mp)
    print(f"[correct] 落盘 {len(ops)} 行 (空槽行交回 tree_backfill 泛词重挂)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
