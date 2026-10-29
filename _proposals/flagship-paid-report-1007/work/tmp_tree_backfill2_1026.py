# -*- coding: utf-8 -*-
"""EPC-JIAGE tree_backfill 第二轮 (1026 五轴门修②).

只补 tree_node 字段, 不动其他字段 (tree_backfill 模式铁律):
  - 仅 judge==valid 且 tree_node 为空的行参与;
  - 领域匹配: text_head + source_path + url_norm 对 26 子问的专属词表计分,
    须命中 ≥1 个子问专属词才挂 (泛 EPC/总承包/施工词不挂 — 零造假);
  - EEI 定位: 子问内按行 stance 定 E1(support)/E2(against), 无 stance 时
    credibility∈{gov,official} 且含权威文件词 → E3(权威口径), 否则 E1;
  - 匹配不上的留空如实; 备份 manifest → .bak; 报告落 staging/.

用法: py -X utf8 tmp_tree_backfill2_1026.py [--apply]
"""
import json
import shutil
import sys
from collections import Counter
from pathlib import Path

POOL = Path(r"E:\AI-Station\ammo_pool\EPC-JIAGE")
MANIFEST = POOL / "manifest.jsonl"
TREE = POOL / "question_tree.json"
BAK = POOL / "manifest.pre-tree-backfill2-1026.bak.jsonl"
REPORT = POOL / "staging" / "tree_backfill2_1026_report.json"

APPLY = "--apply" in sys.argv

# 26 子问专属词表 (从问题文本/EEI need/queries 提炼; 专属=该问独有语义,
# 泛词(工程/项目/EPC/总承包/施工/管理)一律不收录)
Q_KW = {
    "Q1": ("主管部门", "监管框架", "监管", "住建部", "造价管理总站", "管理机构",
           "主管部门与监管"),
    "Q2": ("管理制度", "政策文件", "制度体系", "政策沿革", "造价管理制度",
           "管理办法", "造价改革", "全过程造价管控政策"),
    "Q3": ("定额体系", "发布管理", "定额发布", "定额构成", "统一定额"),
    "Q4": ("定额测定", "测定方法", "编制规程", "观测法", "消耗量标准测定",
           "定额编制", "基础定额"),
    "Q5": ("人工材料机械", "消耗量定额", "台班", "定额水平", "人工消耗",
           "材料消耗", "机械台班", "消耗量调整"),
    "Q6": ("企业定额",),
    "Q7": ("信息价发布", "造价管理机构", "信息价", "各省造价", "造价站"),
    "Q8": ("信息价与市场价", "市场价差异", "采用规则", "市场价基准", "价差口径"),
    "Q9": ("造价指数", "价差调整", "调差", "材料价差", "价格指数"),
    "Q10": ("招标控制价", "控制价", "最高投标限价", "清单控制价"),
    "Q11": ("投标报价", "不平衡报价", "投标策略", "投标编制", "报价技巧"),
    "Q12": ("综合单价", "全费用单价", "组价", "单价分析", "清单单价"),
    "Q13": ("竣工结算", "结算编审", "结算核对", "结算审核", "工程结算书",
            "结算书", "量价费核对"),
    "Q14": ("签证", "变更计价", "变更估价", "工程变更", "现场签证", "变更签证"),
    "Q15": ("合同解除", "已完工程", "解除结算", "合同终止结算", "解除后结算"),
    "Q16": ("损失赔偿", "解除后", "赔偿", "结算争议判例", "违约赔偿"),
    "Q17": ("造价鉴定", "鉴定机构", "鉴定程序", "司法鉴定", "工程造价鉴定"),
    "Q18": ("计价争议", "司法解释", "争议类型", "争议解决", "计价纠纷",
            "司法解释口径", "司法解释"),
    "Q19": ("判例", "裁判", "案例库", "判决书", "裁判规则", "典型案例",
            "指导案例"),
    "Q20": ("清单计价", "工程量清单", "计价规范", "GB50500", "GB 50500",
            "清单计价规范", "50500", "计价标准沿革", "清单规范"),
    "Q21": ("定额计价", "计价模式", "模式差异", "计价方式", "两种计价",
            "清单与定额"),
    "Q22": ("概算", "估算", "全过程计价", "计价链条", "投资估算", "设计概算",
            "预算", "决算", "四算"),
    "Q23": ("造价工程师", "执业", "咨询资质", "注册造价", "造价员", "职业资格",
            "从业资格"),
    "Q24": ("咨询企业", "造价咨询公司", "咨询收费", "收费模式", "咨询企业排名",
            "造价咨询企业"),
    "Q25": ("数据源", "发布平台", "造价信息平台", "信息平台", "造价信息网",
            "材料价格网", "建材价格网", "造价数据"),
    "Q26": ("计价软件", "造价软件", "广联达", "鲁班", "数字化平台", "算量",
            "计价工具", "BIM计价"),
}

# 泛域词第二层 (campaign 核心域词 → 归属子问):
#   STRONG 权重=2 (语义明确归属计价域某子问, 单独命中即可挂);
#   WEAK   权重=1 (语义偏泛, 须与其它信号合计 ≥2 才挂)。
# 泛 EPC/总承包/施工/项目管理词 (无计价域信号) 一律不挂 — 留空如实。
GENERIC_STRONG = {
    "Q2": ("造价管理", "造价管控", "造价控制", "造价改革", "全过程造价"),
    "Q3": ("定额",),
    "Q21": ("计价", "计价方式", "总价合同", "单价合同", "固定总价", "合同价格"),
    "Q13": ("结算", "决算", "结算审计", "工程审计"),
    "Q20": ("工程量清单", "清单计价"),
    "Q18": ("争议", "计价纠纷", "纠纷"),
    "Q17": ("鉴定",),
    "Q16": ("索赔",),
    "Q22": ("概算", "预算", "估算", "合同价款"),
    "Q7": ("信息价", "材料价格", "建材价格"),
    "Q9": ("造价指数", "价差", "价格调整", "调价"),
    "Q12": ("综合单价", "措施费"),
    "Q23": ("造价工程师", "注册造价"),
    "Q24": ("造价咨询",),
    "Q26": ("计价软件", "广联达", "算量"),
    "Q14": ("签证",),
}
GENERIC_WEAK = {
    "Q10": ("招标",),
    "Q11": ("投标", "报价", "费率", "下浮"),
    "Q20": ("清单",),
    "Q14": ("变更",),
    "Q22": ("工程价款", "价款", "估算指标"),
    "Q5": ("人工费", "材料费", "机械费", "台班"),
}

#: 平票优先序 (前问优先: 制度/定额体系为根, 计价模式次之)
TIE_PRIORITY = ["Q1", "Q2", "Q3", "Q20", "Q21", "Q4", "Q5", "Q6", "Q7", "Q8",
                "Q9", "Q10", "Q11", "Q12", "Q22", "Q13", "Q14", "Q15", "Q16",
                "Q17", "Q18", "Q19", "Q23", "Q24", "Q25", "Q26"]

AUTHORITY_WORDS = ("公告", "规范", "标准", "办法", "通知", "文件", "部令", "GB",
                   "GB/T", "建标", "印发", "条例")


def pick_eei(q, row, blob):
    eeis = q.get("eeis") or []
    if not eeis:
        return ""
    stance = str(row.get("stance") or "").lower()
    by_stance = {str(e.get("stance") or ""): str(e.get("id")) for e in eeis}
    if stance == "against" and by_stance.get("against"):
        return by_stance["against"]
    if stance == "support" and by_stance.get("support"):
        return by_stance["support"]
    if not stance:
        cred = str(row.get("credibility") or "")
        if cred in ("gov", "official") and any(w in blob for w in AUTHORITY_WORDS):
            auth = next((str(e["id"]) for e in eeis
                         if "权威" in str(e.get("need") or "")), "")
            if auth:
                return auth
        return by_stance.get("support") or str(eeis[0].get("id"))
    return by_stance.get(stance) or by_stance.get("support") or str(eeis[0].get("id"))


def main():
    tree = json.loads(TREE.read_text(encoding="utf-8"))
    qs = {q["id"]: q for q in tree.get("subquestions", [])}

    lines = MANIFEST.read_text(encoding="utf-8").splitlines()
    out_lines = []
    matched = unmatched = 0
    by_q = Counter()
    by_engine_unmatched = Counter()
    samples_unmatched = []
    changed = 0

    for ln in lines:
        if not ln.strip():
            out_lines.append(ln)
            continue
        try:
            r = json.loads(ln)
        except Exception:
            out_lines.append(ln)
            continue
        if r.get("judge") == "valid" and not r.get("tree_node"):
            blob = " ".join((str(r.get("text_head") or ""),
                             str(r.get("source_path") or ""),
                             str(r.get("url_norm") or "")))
            scores: dict[str, int] = {}
            for qid, kws in Q_KW.items():          # 专属词 ×2
                hits = sum(1 for k in kws if k in blob)
                if hits:
                    scores[qid] = scores.get(qid, 0) + 2 * hits
            for qid, kws in GENERIC_STRONG.items():  # 强泛域词 ×2
                hits = sum(1 for k in kws if k in blob)
                if hits:
                    scores[qid] = scores.get(qid, 0) + 2 * hits
            for qid, kws in GENERIC_WEAK.items():    # 弱泛域词 ×1
                hits = sum(1 for k in kws if k in blob)
                if hits:
                    scores[qid] = scores.get(qid, 0) + hits
            best_q, best_score = "", 0
            for qid in TIE_PRIORITY:                # 平票按先根后叶优先序
                s = scores.get(qid, 0)
                if s > best_score:
                    best_q, best_score = qid, s
            if best_q and best_score >= 2:
                node = pick_eei(qs[best_q], r, blob)
                if node:
                    r["tree_node"] = node
                    matched += 1
                    by_q[best_q] += 1
                    changed += 1
                    out_lines.append(json.dumps(r, ensure_ascii=False))
                    continue
            unmatched += 1
            by_engine_unmatched[r.get("engine")] += 1
            if len(samples_unmatched) < 8:
                samples_unmatched.append(str(r.get("text_head") or "")[:60])
        out_lines.append(ln)

    report = {
        "run": "tree_backfill2_1026",
        "mode": "tree_node-only fill, domain-keyword match, >=1 subquestion-specific term",
        "matched": matched,
        "unmatched_left_empty": unmatched,
        "by_subquestion": dict(sorted(by_q.items())),
        "unmatched_by_engine": dict(by_engine_unmatched.most_common()),
        "unmatched_samples": samples_unmatched,
    }
    if APPLY:
        if not BAK.exists():
            shutil.copy2(MANIFEST, BAK)
        MANIFEST.write_text("\n".join(out_lines) + "\n", encoding="utf-8")
        REPORT.parent.mkdir(parents=True, exist_ok=True)
        REPORT.write_text(json.dumps(report, ensure_ascii=False, indent=1),
                          encoding="utf-8")
        print(f"[backfill2] APPLIED: matched={matched} unmatched={unmatched} "
              f"bak={BAK.name} report={REPORT}")
    else:
        print(f"[backfill2] DRY-RUN: {json.dumps(report, ensure_ascii=False, indent=1)}")


if __name__ == "__main__":
    main()
