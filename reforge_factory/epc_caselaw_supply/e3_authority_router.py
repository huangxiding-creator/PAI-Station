# -*- coding: utf-8 -*-
"""e3_authority_router — EPC-CASELAW E3 权威位定向归挂/切灌件 (1031 饱和冲门·二).

两件事 (零造假铁律: 每条改动留台账, 只动清单内行):
  A. 重挂: 池内已有的权威口径件 (司法解释/规范/案例库/裁判规则全文页,
     标题即权威词) 从泛词槽 (E1/E2) 或空槽 定向改挂到对应子问题的
     E3 权威位 — 依据 = E3 need 定义 "司法解释/规范/判例原文";
     E1 槽不动损失 (pan_hunter 孪件 + 判决切片仍留在 E1);
  B. 切灌: EPC-JIAGE 池的 GB 标准全文族 (GB/T 51262 三版本 +
     GB/T 50500-2024 应用指南/50500-2013 全文/核心条款变化) 经
     ammo_pool.ingest 正道入池 (engine=crosspool:EPC-JIAGE,
     tree=对应 E3)。

台账: e3_routing_ledger.jsonl 逐条 (行/旧槽/新槽/理由)。
用法: py -X utf8 e3_authority_router.py [--dry]
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
LEDGER = POOL / "e3_routing_ledger.jsonl"

#: A. 重挂清单: (stem 子串, 引擎限定, 新 EEI, 理由)
REROUTES: list[tuple[str, str, str, str]] = [
    ("建设工程造价鉴定规范-GB-T-51262", "bdn", "Q13-E3",
     "GB/T 51262 造价鉴定规范全文页 → 权威位 (E3 need=规范原文)"),
    ("最高人民法院-优先受偿权-司法解释", "bdn", "Q21-E3",
     "优先受偿权司法解释全文页 → 权威位"),
    ("最高人民法院-竣工结算-司法解释", "bdn", "Q7-E3",
     "竣工结算司法解释全文页 → 权威位"),
    ("最高人民法院-工程变更-签证-索赔-裁判规则", "bdn", "Q10-E3",
     "变更签证索赔裁判规则全文页 → 权威位"),
    ("人民法院案例库-索赔-判例", "bdn", "Q10-E3",
     "案例库索赔判例页 → 权威位 (判例原文)"),
    ("最高人民法院-调解协议司法确认-规定", "bdn", "Q23-E3",
     "调解协议司法确认规定全文页 → 权威位"),
    ("最高人民法院-工期延误-顺延-裁判规则", "bdn", "Q16-E3",
     "工期延误顺延裁判规则全文页 → 权威位"),
    ("最高人民法院-固定总价合同-结算-裁判规则", "bdn", "Q4-E3",
     "固定总价结算裁判规则全文页 → 权威位"),
    ("01_最高人民法院建工施工合同司法解释一", "crosspool", "Q18-E3",
     "建工司法解释一全文(法释〔2020〕25号) — 黑白合同/中标无效结算依据 "
     "第2、22条 → 权威位 (原 Q25-E2 泛挂纠正)"),
    ("02_最高人民法院建工施工合同司法解释二", "crosspool", "Q8-E3",
     "建工司法解释二全文(法释〔2026〕12号) — 第13条以审代结/审计时限 "
     "→ 权威位 (原 Q25-E2 泛挂纠正)"),
    ("03_中华人民共和国建筑法", "crosspool", "Q16-E3",
     "建筑法全文(2019修正) — 工期/竣工验收法定依据 → 权威位"),
    ("04_中华人民共和国招标投标法实施条例", "crosspool", "Q20-E3",
     "招标投标法实施条例全文 — 必须招标项目认定 → 权威位"),
]

#: B. JIAGE 切灌清单: (JIAGE manifest stem 子串, 新 EEI, 理由)
GRAFTS: list[tuple[str, str, str]] = [
    ("GBT51262-2017建设工程造价鉴定规范_全文OCR", "Q13-E3",
     "GB/T 51262-2017 规范全文OCR版 (24.6千字) — Q13-E3 第二独立件"),
    ("造价鉴定规范GB_T51262_2017附条文说明全文", "Q14-E3",
     "GB/T 51262 附条文说明全文 (30.4千字) — 鉴定意见质证/重新鉴定 "
     "条文说明 → Q14-E3"),
    ("建设工程造价鉴定规范_GB T51262-2017 1", "Q15-E3",
     "GB/T 51262 规范另一版本 (39.7千字) — 鉴定范围界定条文 → Q15-E3"),
    ("2024版建设工程工程量清单计价标准应用指南_(OCR)", "Q4-E3",
     "GB/T 50500-2024 应用指南 OCR 全文 (504.9千字) — 固定总价/总价包干 "
     "计价规范权威位"),
    ("建设工程工程量清单计价规范（GB50500-2013）", "Q5-E3",
     "GB50500-2013 清单计价规范全文 (42.3千字) — 物价波动调价/固定单价 "
     "条款沿革 → Q5-E3"),
    ("“核心条款变化”影响重大！《建设工程工程量清单计价标准》GB_T50500-2024",
     "Q6-E3",
     "GB/T 50500-2024 核心条款变化全文解读 (24.6千字) — 清单缺项漏项/"
     "风险范围条款 → Q6-E3"),
]


def load_rows() -> list[dict]:
    return [json.loads(x) for x in
            (POOL / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]


def jiage_row(stem_sub: str) -> dict | None:
    mp = AP.POOL_ROOT / "EPC-JIAGE" / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    cands = [r for r in rows if r.get("judge") == "valid"
             and stem_sub in Path(r.get("source_path", "")).stem]
    return max(cands, key=lambda r: r.get("chars", 0)) if cands else None


#: C. 本地法规库直采 (idle7_statute 官方线已抓全文, 尚未入本池):
#:    (glob 子串, 新 EEI, 理由) — engine=localfiles:statute, cred=official
LOCAL_STATUTE: list[tuple[str, str, str]] = [
    ("03_中华人民共和国建筑法", "Q16-E3",
     "建筑法全文(2019修正, 官方PDF提取 8.6千字) — 工期/竣工验收法定依据 "
     "→ Q16-E3 第二独立件 (本地法规库 idle7_statute 官方线)"),
    ("04_中华人民共和国招标投标法实施条例", "Q20-E3",
     "招标投标法实施条例全文(gov.cn公布版) — 必须招标项目认定 "
     "→ Q20-E3 第二独立件 (本地法规库 idle7_statute 官方线)"),
]
_STATUTE_DIR = (Path(r"E:\AI-Station\ResearchFactory-Eng\ResearchTopics")
                / "《四川电力设计咨询有限责任公司怎么干EPC总承包？》"
                / "02 初次网络调研" / "61_政策法规" / "idle7_statute")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()

    rows = load_rows()
    changes: list[tuple[int, str, str]] = []          # (idx, new_node, reason)
    with LEDGER.open("a", encoding="utf-8") as lf:
        lf.write(json.dumps({"ts": time.strftime("%F %T"),
                             "phase": "reroute-plan",
                             "entries": len(REROUTES)}, ensure_ascii=False)
                 + "\n")
        for stem_sub, eng, eei, why in REROUTES:
            hit = None
            for i, r in enumerate(rows):
                st = Path(r.get("source_path", "")).stem
                if (stem_sub in st and r.get("judge") == "valid"
                        and eng in str(r.get("engine", ""))
                        and not r.get("_done")):
                    hit = (i, r)
                    break
            if not hit:
                lf.write(json.dumps({"ts": time.strftime("%F %T"),
                                     "stem": stem_sub, "result": "not_found",
                                     "note": "行未命中如实跳过"},
                                    ensure_ascii=False) + "\n")
                print(f"  × {stem_sub[:40]} 未命中")
                continue
            i, r = hit
            old = r.get("tree_node") or "EMPTY"
            changes.append((i, eei, f"{stem_sub[:36]}: {old}->{eei} | {why}"))
            r["_done"] = True
            lf.write(json.dumps({"ts": time.strftime("%F %T"),
                                 "file": r["source_path"], "old": old,
                                 "new": eei, "engine": r.get("engine"),
                                 "reason": why},
                                ensure_ascii=False) + "\n")

        # ---- B. JIAGE 切灌 (先探源行, dry 时只报) ----
        graft_plan = []
        for stem_sub, eei, why in GRAFTS:
            src = jiage_row(stem_sub)
            if not src:
                lf.write(json.dumps({"ts": time.strftime("%F %T"),
                                     "stem": stem_sub, "result": "src_not_found"},
                                    ensure_ascii=False) + "\n")
                print(f"  × 源缺 {stem_sub[:40]}")
                continue
            graft_plan.append((src, eei, why))

    print(f"[router] 重挂 {len(changes)} 条; 切灌候选 {len(graft_plan)} 件")
    for _, eei, note in changes:
        print(f"  →{eei}  {note[:90]}")

    if ns.dry:
        return 0

    # ---- 落盘: 重挂 (原子替换, 行序/字段保持) ----
    for i, eei, _ in changes:
        rows[i]["tree_node"] = eei
        rows[i]["stance"] = "support"
    for r in rows:
        r.pop("_done", None)
    mp = POOL / "manifest.jsonl"
    tmp = mp.with_suffix(".jsonl.tmp")
    tmp.write_text("".join(json.dumps(r, ensure_ascii=False) + "\n"
                           for r in rows), encoding="utf-8")
    tmp.replace(mp)
    print(f"[router] manifest 重挂落盘 {len(changes)} 行")

    # ---- 切灌入池 ----
    with LEDGER.open("a", encoding="utf-8") as lf:
        for src, eei, why in graft_plan:
            rc = AP.ingest(CID, src["source_path"],
                           engine="crosspool:EPC-JIAGE",
                           url=src.get("url_norm") or "",
                           cred=src.get("credibility") or "research",
                           tree=eei, stance="support", band="gap")
            # ingest 入 pending+无tree二次确认: 回查 manifest 行
            row = None
            for x in (POOL / "manifest.jsonl").read_text(
                    encoding="utf-8").splitlines():
                if x.strip():
                    rr = json.loads(x)
                    if rr.get("source_path") == src["source_path"] \
                            and rr.get("engine") == "crosspool:EPC-JIAGE":
                        row = rr
                        break
            ok = bool(row and row.get("tree_node") == eei)
            lf.write(json.dumps(
                {"ts": time.strftime("%F %T"),
                 "file": src["source_path"], "eei": eei, "ingest_rc": rc,
                 "tree_confirmed": ok,
                 "chars_source": src.get("chars"), "reason": why},
                ensure_ascii=False) + "\n")
            print(f"  +graft {Path(src['source_path']).name[:44]} → {eei} "
                  f"(rc={rc}, tree_ok={ok})")

        # ---- C. 本地法规库直采入池 ----
        for stem_sub, eei, why in LOCAL_STATUTE:
            cands = sorted(_STATUTE_DIR.glob(stem_sub + "*.md"))
            if not cands:
                lf.write(json.dumps({"ts": time.strftime("%F %T"),
                                     "stem": stem_sub,
                                     "result": "file_not_found"},
                                    ensure_ascii=False) + "\n")
                print(f"  × 本地法规缺件 {stem_sub}")
                continue
            fp = cands[0]
            rc = AP.ingest(CID, str(fp), engine="localfiles:statute",
                           url="", cred="official", tree=eei,
                           stance="support", band="gap")
            lf.write(json.dumps(
                {"ts": time.strftime("%F %T"), "file": str(fp), "eei": eei,
                 "ingest_rc": rc, "reason": why},
                ensure_ascii=False) + "\n")
            print(f"  +statute {fp.name[:44]} → {eei} (rc={rc})")
    return 0


if __name__ == "__main__":
    sys.exit(main())
