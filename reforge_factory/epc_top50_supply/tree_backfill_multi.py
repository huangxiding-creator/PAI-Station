# -*- coding: utf-8 -*-
"""tree_backfill_multi — EPC-TOP50 存量弹药批量归挂 (每件可挂多 EEI, 1..5).

任务令 (1028 三门冲线·一): 把池内 28.5M 字 valid 弹药按领域匹配挂到
question_tree 78 EEI 上 — 数据已在池, 只差 tree_node。

模式 (EPC50-SNEI 先例: pool_state note "manifest 行=文件×问题对(qmatch),
行累加=虚账"): 一行×N EEI → 展开 N 行 (dedup_key 同键; reledger/
tier_report 按 dedup_key 去重, 字数账不受行数影响, 零虚账)。

匹配规则 (零造假铁律 — 全部确定性可复算, 无模型调用):
  三层词表:
    L1 专属词 (权重 10): 子问题主题短语/实体词 (公司名/榜单词/赛道词);
    L2 强泛词 (权重 3): 子问题维度词 (营收/毛利率/应收/BIM/人才...);
    L3 弱泛词 (权重 1): 工程/总承包/EPC/项目 — 只参与平票排序,
      永不单独构成挂树 (防"什么都沾"的虚挂)。
  资格: 命中 ≥1 L1 词, 或 ≥2 个不同 L2 词 (段落级在场, 长文查全文,
    短文查 text_head) — 匹配不上的留空 (unattached, 如实)。
  槽位: E2 反证槽仅当反证词在场 (风险/亏损/纠纷/败诉/处罚...);
        E3 权威槽仅当权威信号 (credibility=official / chinca notice·stats
        ·research 栏 / url 含 gov.cn|chinca.org|org.cn);
        其余 → E1 正面槽 (stance=support)。
  平票按 EEI 序 (树序); 每件上限 5 EEI (任务令 2-5)。
  落盘: 先备份 manifest.pre-tree-backfill.bak.jsonl (只一次, 只增),
    原子 tmp+replace; 行序保持, 原 tree_node 非空的行其原挂树保留在
    候选首位 (只增不逆, tree_backfill 同规)。

用法: py -X utf8 tree_backfill_multi.py EPC-TOP50 [--dry] [--max-eei 5]
退出码: 0=跑完; 2=池/树缺失。
"""
from __future__ import annotations

import argparse
import json
import re
import shutil
import sys
import time
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from ammo_pool import read_text_safe  # noqa: E402  (盘上全文读取, 同 reledger 通道)

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# ---------- L1 专属词表 (Q → 主题短语/实体词) ----------
TOPIC_L1: dict[str, tuple[str, ...]] = {
    "Q1": ("总量格局", "集中度", "50强", "五十强", "门槛值", "榜单",
           "对外承包工程发展报告"),
    "Q2": ("排名口径", "统计口径", "口径", "联合体", "设计牵头", "排名发布"),
    "Q3": ("历年榜单", "历年", "近5年", "近五年", "进榜", "出榜", "进退场",
           "榜单变动"),
    "Q4": ("国有设计院", "设计院转型", "电力设计院", "勘测设计",
           "转型升级", "转型"),
    "Q5": ("民营", "地方设计院", "差异化"),
    "Q6": ("施工企业", "施工总承包", "切入", "工程局", "中建"),
    "Q7": ("电建", "能建", "电力集团军"),
    "Q8": ("中石油", "中石化", "石化", "寰球", "石油工程", "能源化工"),
    "Q9": ("中冶", "国机", "中化学", "中核", "集团军", "中国化学", "核建"),
    "Q10": ("化工", "天辰", "五环", "华陆", "成达", "寰球"),
    "Q11": ("冶金", "建材", "中冶南方", "中材", "恩菲", "赛迪", "中钢"),
    "Q12": ("交通", "公路", "铁路", "市政", "信息产业", "核工程",
            "中铁", "交建", "铁建", "勘察设计院"),
    "Q13": ("勘测设计研究院", "华东院", "中南院", "西北院", "成都院",
            "昆明院"),
    "Q14": ("省级电力设计院", "电力设计院", "山东电力", "广西电力",
            "贵州电力", "广东电力", "浙江电力"),
    "Q15": ("项目管理", "交付", "设计采购施工", "一体化", "项目经理",
            "管理实务", "交钥匙", "管理手册", "管理规范"),
    "Q16": ("中标", "业绩", "重大项目", "签约", "获奖", "国家优质工程",
            "詹天佑", "优质工程"),
    "Q17": ("营收", "营业收入", "合同额", "营业额", "营收序列"),
    "Q18": ("盈利", "毛利率", "成本控制"),
    "Q19": ("应收", "垫资", "纠纷", "诉讼", "索赔", "结算", "亏损",
            "尾款", "赔偿", "陷阱", "保函", "裁判", "诉讼实务"),
    "Q20": ("人才", "培养", "培训", "领军", "复合型"),
    "Q21": ("组织架构", "事业部", "区域公司", "组织变革"),
    "Q22": ("数字化", "BIM", "智能建造", "数智", "人工智能", "AI",
            "大语言模型"),
    "Q23": ("专利", "工法", "科技创新", "科学技术进步奖", "标准话语权"),
    "Q24": ("1-20名", "头部档", "画像", "竞争壁垒"),
    "Q25": ("21-40名", "中坚档", "追赶"),
    "Q26": ("41-50名", "尾部档", "候补", "保位"),
}

# ---------- L2 强泛词表 (Q → 维度词, 段落级在场 ≥2 才算) ----------
TOPIC_L2: dict[str, tuple[str, ...]] = {
    "Q1": ("格局", "排名", "集中度", "总量", "榜单"),
    "Q2": ("排名", "口径", "统计", "方法论", "联合体"),
    "Q3": ("历年", "变动", "进榜", "出榜", "驱动力"),
    "Q4": ("转型", "设计院", "成效", "路径"),
    "Q5": ("民营", "地方", "生存", "差异化"),
    "Q6": ("施工", "多元主体", "切入", "工程局"),
    "Q7": ("中国电建", "中国能建", "子公司", "协同"),
    "Q8": ("中国石油", "中国石化", "工程建设板块"),
    "Q9": ("中冶", "国机", "中国化学", "中核", "板块"),
    "Q10": ("化工", "天辰", "五环", "华陆", "成达", "寰球", "赛队"),
    "Q11": ("冶金", "建材", "中材", "中钢", "赛迪", "恩菲"),
    "Q12": ("电力设计院", "公路", "铁路", "信息", "核工程", "市政"),
    "Q13": ("勘测设计", "华东院", "中南院", "成都院", "昆明院", "梯队"),
    "Q14": ("省级", "电力设计院", "地方院", "梯队"),
    "Q15": ("项目管理", "交付", "一体化", "采购施工", "项目经理"),
    "Q16": ("中标", "业绩", "重大项目", "签约"),
    "Q17": ("营业收入", "合同额", "营收", "营业额"),
    "Q18": ("毛利率", "盈利", "成本", "营业成本"),
    "Q19": ("应收账款", "垫资", "纠纷", "风险", "经营风险"),
    "Q20": ("人才", "培养", "培训", "员工"),
    "Q21": ("组织架构", "事业部", "区域", "机构"),
    "Q22": ("数字化", "BIM", "智能", "信息化"),
    "Q23": ("专利", "工法", "标准", "科技进步"),
    "Q24": ("头部", "排名", "画像", "壁垒"),
    "Q25": ("中坚", "排名", "画像", "追赶"),
    "Q26": ("尾部", "排名", "保位", "候补"),
}

# L3 弱泛词 (只参与平票, 不构成资格)
L3_WEAK = ("工程", "总承包", "EPC", "项目", "企业", "公司")

# 光匹配子问 (L1 只认标题层, 禁全文回退): 排名带位/口径类槽冒认=造假 —
# 年报深文出现"统计口径"不等于排名口径证据; 专著写"画像"不等于 1-20 名档画像
LIGHT_ONLY_L1 = {"Q1", "Q2", "Q24", "Q25", "Q26"}

# 公司/主体名 → 家族 EEI (L1 层, 排他映射; 名字在 text_head/stem 命中即挂)
COMPANY_FAMILY: tuple[tuple[str, tuple[str, ...]], ...] = (
    ("中国电建", ("Q7-E1", "Q13-E1")),
    ("电建集团", ("Q7-E1", "Q13-E1")),
    ("中国能建", ("Q7-E1",)),
    ("能源建设集团", ("Q7-E1",)),
    ("中石化", ("Q8-E1",)),
    ("中国石化", ("Q8-E1",)),
    ("寰球", ("Q8-E1",)),
    ("石油工程建设", ("Q8-E1",)),
    ("中石油", ("Q8-E1",)),
    ("中国石油", ("Q8-E1",)),
    ("中国化学", ("Q9-E1", "Q10-E1")),
    ("中国中冶", ("Q9-E1", "Q11-E1")),
    ("中冶南方", ("Q9-E1", "Q11-E1")),
    ("中冶", ("Q9-E1", "Q11-E1")),
    ("中国核建", ("Q9-E1", "Q12-E1")),
    ("中工国际", ("Q9-E1",)),
    ("国机", ("Q9-E1",)),
    ("中国联合工程", ("Q9-E1",)),
    ("天辰", ("Q10-E1", "Q4-E1")),
    ("五环", ("Q10-E1", "Q4-E1")),
    ("华陆", ("Q10-E1", "Q4-E1")),
    ("东华科技", ("Q10-E1", "Q4-E1")),
    ("成达", ("Q10-E1", "Q4-E1")),
    ("中材国际", ("Q11-E1",)),
    ("中材节能", ("Q11-E1",)),
    ("中钢国际", ("Q11-E1",)),
    ("中国交建", ("Q12-E1", "Q6-E1")),
    ("中铁第四勘察设计院", ("Q12-E1",)),
    ("铁四院", ("Q12-E1",)),
    ("中国铁建", ("Q6-E1",)),       # 综合施工央企 → Q6 (施工切入), 不冒认 Q12 专业赛道
    ("中国中铁", ("Q6-E1",)),
    ("隧道股份", ("Q6-E1",)),
    ("山东路桥", ("Q12-E1", "Q6-E1")),
    ("四川路桥", ("Q12-E1", "Q6-E1")),
    ("公路工程咨询", ("Q12-E1",)),
    ("汽车工业工程", ("Q12-E1",)),
    ("市政工程设计", ("Q12-E1", "Q5-E1")),
    ("上海市政", ("Q12-E1", "Q5-E1")),
    ("中国建筑", ("Q6-E1",)),
    ("中建三局", ("Q6-E1",)),
    ("中建八局", ("Q6-E1",)),
    ("中建六局", ("Q6-E1",)),
    ("中建五局", ("Q6-E1",)),
    ("中建二局", ("Q6-E1",)),
    ("上海建工", ("Q6-E1",)),
    ("安徽建工", ("Q6-E1",)),
    ("明阳", ("Q5-E1",)),
    ("精工钢构", ("Q5-E1",)),
    ("江河集团", ("Q5-E1",)),
    ("湖南省建筑设计院", ("Q5-E1",)),
    ("铭扬", ("Q5-E1",)),
    ("中城科泽", ("Q5-E1",)),
    ("中国海诚", ("Q4-E1",)),
    ("华东勘测设计研究院", ("Q13-E1", "Q7-E1")),
    ("华东院", ("Q13-E1",)),
    ("中南勘测设计研究院", ("Q13-E1", "Q7-E1")),
    ("成都勘测设计研究院", ("Q13-E1", "Q7-E1")),
    ("昆明勘测设计研究院", ("Q13-E1", "Q7-E1")),
    ("勘测设计研究院", ("Q13-E1",)),
    ("中南电力设计院", ("Q14-E1", "Q7-E1")),
    ("山东电力工程咨询院", ("Q14-E1",)),
    ("广西电力", ("Q14-E1", "Q7-E1")),
    ("贵州电力", ("Q14-E1", "Q7-E1")),
    ("电力工程顾问集团", ("Q7-E1", "Q14-E1")),
)

# 反证硬词 (E2 槽资格 — 只认标题层: 件的主旨就是负面事件/判例/争议;
# 深文正文里出现"风险"不算 — 风险管理/风险防控类文章是正面案例非反例)
AGAINST_HARD = ("亏损", "亏掉", "失败", "纠纷", "败诉", "处罚", "举报",
                "隐患", "偷工减料", "陷阱", "赔偿", "失信", "黑名单",
                "事故", "违规", "违法", "串标", "围标", "诉讼", "仲裁",
                "质疑", "投诉", "通报", "整改", "被砍", "诉讼实务",
                "裁判指引", "指导案例")
# 权威信号 (E3 槽资格): 官方 cred+政府域 / govlist·std_samr 引擎 /
# chinca 的 notice·stats·research 公报性栏目 (member/intl 行业新闻不算)
AUTHORITY_URL = (".gov.cn", "gov.cn", "chinca.org", ".org.cn")
AUTHORITY_ENG = ("govlist", "std_samr", "standards")
CHINCA_OFFICIAL_COLS = ("notice栏目", "stats栏目", "research栏目")


def load_tree(pool: Path) -> dict:
    p = pool / "question_tree.json"
    if not p.is_file():
        raise FileNotFoundError(f"question_tree 缺失: {pool}")
    return json.loads(p.read_text(encoding="utf-8"))


def read_full(row: dict) -> str:
    """盘上全文 (reledger 同通道); 失联回退 text_head (短文即全文)."""
    sp = str(row.get("source_path") or "")
    try:
        if sp and Path(sp).is_file():
            t = read_text_safe(Path(sp))
            if t:
                return t
    except Exception:
        pass
    return str(row.get("text_head") or "")


# 年报引擎 (任务令钦定挂树族: Q4-Q6转型/Q17-Q19营收/Q7-Q9央企 — Q16 中标
# 格局不在此列, 让位 Q18 盈利槽, 防五帽挤占)
ANNUAL_ENG = {"cninfo_com_cn"}
ANNUAL_SKIP_EEI = {"Q16-E1", "Q16-E2", "Q16-E3"}


def score_row(row: dict, eei_index: list[dict],
              orig: str = "") -> list[tuple[str, float, str]]:
    """行 → [(eei_id, score, stance)] 候选, 按分排序; 平票按树序 (稳定)."""
    light = " ".join((str(row.get("text_head") or ""),
                      Path(str(row.get("source_path") or "")).stem,
                      str(row.get("url_norm") or "")))
    full = read_full(row)
    # E2 只认标题层硬词 (主旨即负面事件); E1 收编风险案例类 (风险应对/防控)
    is_against = any(k in light for k in AGAINST_HARD)
    eng = str(row.get("engine") or "").lower()
    url = str(row.get("url_norm") or "")
    is_authority = (str(row.get("credibility")) == "official"
                    and (any(u in url for u in AUTHORITY_URL)
                         or any(t in eng for t in AUTHORITY_ENG))
                    ) or any(t in eng for t in AUTHORITY_ENG) or (
                        eng == "chinca"
                        and any(c in light for c in CHINCA_OFFICIAL_COLS))
    weak_hits = sum(1 for w in L3_WEAK if w in light)

    # 家族映射 (L1 专属, 公司名排他)
    family: set[str] = set()
    for name, eids in COMPANY_FAMILY:
        if name in light:
            family.update(eids)

    cands: dict[str, tuple[float, str]] = {}
    annual = str(row.get("engine") or "") in ANNUAL_ENG
    for e in eei_index:
        qid, eid, stance_slot = e["qid"], e["eid"], e["stance"]
        if annual and eid in ANNUAL_SKIP_EEI:
            continue                      # 年报族: 任务令钦定 Q17-Q19, 让位 Q18
        if stance_slot == "against" and not is_against:
            continue                      # E2 槽: 反证词不在场 → 不候选
        if stance_slot == "authority" and not is_authority:
            continue                      # E3 槽: 无权威信号 → 不候选
        # 光域原则: 短件 (<50k 字) 标题/头部即主旨 — 深文偶词不算匹配;
        # 长文 (年报/专著) 允许全文段落级匹配, 但仅限 E1 正面槽 —
        # E2 反证/E3 权威槽一律标题层 (年报≠反例, 通知题外词≠公报)
        long_doc = len(full) >= 50000
        stance_light_only = stance_slot != "support"
        scope_l1 = (light if (qid in LIGHT_ONLY_L1 or stance_light_only
                              or not long_doc) else light + "\n" + full)
        scope_l2 = scope_l1
        l1 = [w for w in TOPIC_L1[qid] if w in scope_l1]
        l2 = [w for w in TOPIC_L2[qid] if w in scope_l2]
        if not l1 and len(l2) < 2:
            continue                      # 资格: ≥1 L1 或 ≥2 L2 (L3 不算)
        s = 10.0 * len(set(l1)) + 3.0 * len(set(l2)) + min(weak_hits, 2)
        if stance_slot == "against":
            s += 5.0                      # 反证词在场对反证槽加权
        if stance_slot == "authority" and is_authority:
            s += 4.0
        if eid in family:
            s += 15.0                     # 公司家族排他加成
        if annual and eid in ("Q17-E1", "Q18-E1", "Q19-E1"):
            s += 6.0                      # 年报任务令钦定营收族三槽
        if e["topic"] in light or e["topic"] in full:
            s += 8.0                      # 主题短语整串命中 (API 简报件)
        cands[eid] = (s, stance_slot)
    # 原挂树作加分候选 (非钉死): 前一轮粗挂 (169 件 Q17-E1) 本轮重匹配,
    # 原槽 +10 稳定分 — 合法则留, 被更专槽压过则让位 (只增不逆指不丢槽位
    # 类型, 非保具体堆积)
    if orig and orig in cands:
        s0, st0 = cands[orig]
        cands[orig] = (s0 + 10.0, st0)
    out = sorted(cands.items(), key=lambda kv: (-kv[1][0], kv[0]))
    return [(k, v[0], v[1]) for k, v in out]


def build_eei_index(tree: dict) -> list[dict]:
    idx = []
    for q in tree.get("subquestions", []):
        qid = str(q.get("id", ""))
        # 主题短语 = 子问题文本 TOP50 之后的一段
        topic = str(q.get("text", "")).split("TOP50")[-1].strip()[:14]
        for e in q.get("eeis", []):
            eid = str(e.get("id", ""))
            slot = ("against" if str(e.get("stance")) in ("against",
                                                          "contradict")
                    else "authority" if "权威" in str(e.get("need", ""))
                    else "support")
            idx.append({"qid": qid, "eid": eid, "stance": slot,
                        "topic": topic})
    return idx


def backfill(cid: str, dry: bool, max_eei: int) -> int:
    pool = POOL_ROOT / cid
    if not pool.is_dir():
        print(f"[backfill-multi] 战役池不存在: {pool}", file=sys.stderr)
        return 2
    tree = load_tree(pool)
    idx = build_eei_index(tree)
    mp = pool / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]

    out_rows: list[dict] = []
    n_attach = n_multi = n_blank = n_skip = 0
    by_eei: Counter = Counter()
    for r in rows:
        if r.get("judge") != "valid":
            out_rows.append(r)
            n_skip += 1
            continue
        orig = str(r.get("tree_node") or "")
        cands = score_row(r, idx, orig)
        keep: list[str] = []
        # 均衡选取 (tree_spread 精神): 资格不变, 只在近分带 (≥0.8×最高分)
        # 内优先补全局低覆盖 EEI — 堆积是计分副产物, 非归属真相;
        # 单 EEI 软帽 12 (再多不增信息, 让帽位给其他 EEI — 选取序非归属变更)
        if cands:
            top = cands[0][1]
            band = [c for c in cands if c[1] >= 0.8 * top]
            band.sort(key=lambda c: (by_eei.get(c[0], 0), c[0]))
            rest = [c for c in cands if c[1] < 0.8 * top]
            for eid, _s, _st in band + rest:
                if len(keep) >= max_eei:
                    break
                if eid in keep or by_eei.get(eid, 0) >= 12:
                    continue
                keep.append(eid)
            if not keep:                  # 全槽满帽 → 补全局最低覆盖合格槽
                keep.append(min(cands, key=lambda c: (by_eei.get(c[0], 0),
                                                      c[0]))[0])
        if not keep:
            out_rows.append(r)
            n_blank += 1
            continue
        for eid in keep:
            nr = dict(r)
            nr["tree_node"] = eid
            slot = next(x["stance"] for x in idx if x["eid"] == eid)
            nr["stance"] = "against" if slot == "against" else "support"
            out_rows.append(nr)
            by_eei[eid] += 1
        n_attach += len(keep)
        if len(keep) > 1:
            n_multi += 1

    rep = {"campaign": cid, "ran": time.strftime("%F %T"), "dry": dry,
           "rows_in": len(rows), "rows_out": len(out_rows),
           "attachments": n_attach, "multi_items": n_multi,
           "unattached": n_blank, "skip_not_valid": n_skip,
           "distinct_eei_hit": len(by_eei)}
    print(f"[backfill-multi] {cid} ({'DRY' if dry else 'APPLY'}): "
          f"行 {rep['rows_in']}→{rep['rows_out']} | 挂树 {n_attach} "
          f"(多挂件 {n_multi}) | 留空 {n_blank} | 非valid {n_skip} | "
          f"覆盖 EEI {len(by_eei)}/78")
    for eid, n in by_eei.most_common():
        print(f"  {eid:<7} {n}")

    if dry:
        return 0
    bak = pool / "manifest.pre-tree-backfill.bak.jsonl"
    if not bak.is_file():                 # 备份先行, 只一次
        shutil.copy2(mp, bak)
    tmp = mp.with_suffix(".jsonl.tmp")
    tmp.write_text(
        "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in out_rows),
        encoding="utf-8")
    tmp.replace(mp)
    print(f"[backfill-multi] 备份: {bak.name}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="EPC-TOP50 批量归挂 (多EEI)")
    ap.add_argument("cid", nargs="?", default="EPC-TOP50")
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--max-eei", type=int, default=5)
    ns = ap.parse_args()
    try:
        return backfill(ns.cid, ns.dry, ns.max_eei)
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"[backfill-multi] 错误: {e}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    sys.exit(main())
