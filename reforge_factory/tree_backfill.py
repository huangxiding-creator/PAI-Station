# -*- coding: utf-8 -*-
"""tree_backfill — 存量证据判挂树 (T-023 收尾件: B/P 轴解锁的前置腿).

问题树晚于池内证据生成时 (BID26 实况: 5,279 条 valid 先入池, 树 1015 才
generate), manifest 行 tree_node 全空 → coverage_facets (B 轴) 与
depth_ladder (P 轴) 均以挂树行为分母, 两轴恒 0 分。本件做**确定性回填**:

  规则 (零造假铁律 — 全部可复算, 无模型调用):
  1. 只填空: tree_node 非空的行一律不动 (只升不逆);
  2. 只认 valid: pending/rejected 行不挂树;
  3. 判挂 = 关键词计分: 子问题文本抽取 token (≥2 字 CJK 片段, 去) +
     维度扩展词表 (与 coverage_facets FACET_KEYWORDS 同族) + 引擎弱信号
     (engine 标签 → 维度, 如 cross:policy→政策监管), 分最高子问题胜出;
     最高分 < min-score → 诚实留空 (计入 unattached);
  4. EEI 槽位选择 (子问题内三槽 E1正/E2反/E3权威):
     行命中反证词表 (风险/处罚/纠纷/串标…) → E2 (stance=against);
     行有权威信号 (credibility=official / url 含 gov / engine 含
     govlist|cnki|standards) → E3; 其余 → E1;
  5. 落盘: 先备份 manifest.pre-tree-backfill.bak.jsonl (只一次, 只增),
     原子 tmp+replace 重写 manifest (行序/字段保持, 仅填两键)。

用法:
  py reforge_factory/tree_backfill.py --campaign EPC-BID26 [--dry] [--min-score 1]
退出码: 0=跑完 (dry 亦 0); 2=战役池/树缺失。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# ---------- 维度扩展词表 (question_tree v0 六维; 与 FACET_KEYWORDS 同族) ----------
DIM_KEYWORDS: dict[str, tuple[str, ...]] = {
    "政策监管": ("政策", "监管", "法规", "法律", "合规", "制度", "准入",
               "资质", "规章", "招标投标法", "评标", "定标", "两阶段",
               "政府采购", "主管", "框架", "改革", "规划", "46号令",
               "行政法规", "规范性文件"),
    "市场规模": ("市场", "规模", "行情", "需求", "价格", "增速", "趋势",
               "合同额", "新签", "统计", "口径", "数据源", "天花板",
               "驱动", "份额趋势", "万亿", "亿"),
    "竞争格局": ("竞争", "格局", "对手", "份额", "排名", "头部", "央企",
               "国企", "民企", "战略", "分层", "玩家", "梯队", "市场地位"),
    "项目案例": ("案例", "项目", "工程", "典型", "标志", "示范", "合同",
               "业主", "金额", "工期", "计价", "超概算", "失败", "中标",
               "签约", "落地"),
    "风险事件": ("风险", "纠纷", "事故", "处罚", "司法", "诉讼", "败诉",
               "仲裁", "安全", "围标", "串标", "违规", "违法", "行政处罚",
               "失信", "黑名单", "质疑", "投诉", "通报", "整改"),
    "财务经营": ("财务", "营收", "收入", "毛利", "现金流", "应收", "经营",
               "业绩", "盈亏", "基本面", "年报", "利润"),
    # ---- EPC-JIAGE 计价域十维 (1025 增补; 只增键, 既有六维零改动) ----
    "政策法规与定额体系": ("住建部", "标准定额", "造价管理", "定额体系",
                       "建办标", "工程造价改革", "38号文", "法规", "规章",
                       "规范性文件", "总站", "定额站", "发布管理"),
    "计价依据与定额测定": ("定额测定", "编制规程", "消耗量", "定额水平",
                        "企业定额", "测算", "现场测定", "基础定额",
                        "预算定额", "施工定额", "全国统一"),
    "信息价与市场价基准": ("信息价", "市场价", "网刊", "造价指数", "价差",
                        "调价", "调值", "材料价", "人工单价", "台班",
                        "采价", "加权", "品牌规格", "造价指标"),
    "投标编制实务": ("招标控制价", "最高投标限价", "投标报价", "组价",
                   "不平衡报价", "综合单价", "全费用", "措施项目",
                   "暂列金额", "计日工", "清单编制", "报价策略"),
    "结算核对实务": ("竣工结算", "结算审核", "结算书", "对量", "核对",
                   "签证", "变更计价", "新增项目", "重新组价", "审计",
                   "结算争议", "工程价款"),
    "合同解除结算": ("合同解除", "解除合同", "已完工程", "解除后结算",
                   "合同终止", "违约解除", "协商解除", "索赔", "损失赔偿",
                   "可得利益"),
    "造价鉴定与争议": ("造价鉴定", "鉴定意见", "司法鉴定", "GB/T 51262",
                     "司法解释", "裁判规则", "判决书", "争议解决", "计价争议",
                     "诉讼", "鉴定规范"),
    "清单与定额计价模式": ("清单计价", "定额计价", "GB50500", "50500",
                         "计价规范", "工程量清单", "两种模式", "计价模式",
                         "估算", "概算", "预算", "全过程计价", "限额设计"),
    "造价咨询与职业": ("造价咨询", "造价工程师", "造价员", "执业",
                     "资质", "职业资格", "咨询企业", "收费", "注册造价"),
    "数据源与工具生态": ("造价信息", "数据源", "广联达", "鲁班", "计价软件",
                       "算量", "数字化", "平台", "指标库", "数据库",
                       "材价网", "造价网"),
}

# 引擎标签 → 维度弱信号 (来源渠道即主题族, 可追溯)
ENGINE_DIM_HINTS: tuple[tuple[str, str], ...] = (
    ("policy", "政策监管"), ("govlist", "政策监管"), ("standards", "政策监管"),
    ("bidding", "政策监管"), ("hbba", "政策监管"),
    ("stats", "市场规模"), ("rss", "市场规模"),
    ("stock", "财务经营"), ("corps", "竞争格局"),
    ("cnki", "政策监管"), ("academic", "市场规模"),
    # EPC-JIAGE 计价域 (1025 增补; 追加在尾=既有战役先匹配零影响)
    ("court", "造价鉴定与争议"), ("std_samr", "清单与定额计价模式"),
    ("kb_harvest", "数据源与工具生态"),
)

# EEI 槽位词表 (子问题内三槽)
AGAINST_KW = ("风险", "处罚", "纠纷", "败诉", "事故", "违规", "违法",
              "串标", "围标", "诉讼", "仲裁", "质疑", "投诉", "通报",
              "黑名单", "失信", "整改", "失败", "超概算")
AUTHORITY_ENG = ("govlist", "cnki", "standards", "policy", "gov")
AUTHORITY_URL = (".gov.cn", "gov.cn", ".org.cn")

_STOP = {"全国", "层面", "动向", "清单", "趋势", "因素", "研判", "实践",
         "信号", "重大", "主要", "近三年", "口径", "分层"}


def subq_tokens(text: str) -> list[str]:
    """子问题文本 → 判挂 token (CJK 片段≥2 字, 去停用/泛词)."""
    toks = re.findall(r"[\u4e00-\u9fff]{2,6}", str(text))
    return [t for t in dict.fromkeys(toks) if t not in _STOP]


def load_tree(pool: Path) -> dict:
    for name in ("question_tree_v2.json", "question_tree.json"):
        p = pool / name
        if p.is_file():
            return json.loads(p.read_text(encoding="utf-8"))
    raise FileNotFoundError(f"question_tree 缺失: {pool}")


def build_matchers(tree: dict) -> list[dict]:
    """树子问题 → 匹配器列表 [{id, dim, tokens(带权重), eei 正/反/权}]."""
    out = []
    for q in tree.get("subquestions", []):
        dim = str(q.get("dim", ""))
        toks = subq_tokens(q.get("text", ""))
        ext = [k for k in DIM_KEYWORDS.get(dim, ()) if k not in toks]
        slots = {"support": "", "against": "", "authority": ""}
        for e in q.get("eeis", []):
            st = str(e.get("stance", "support"))
            if st in ("against", "contradict"):
                slots["against"] = slots["against"] or str(e.get("id", ""))
            elif any(a in str(e.get("need", "")) for a in ("权威", "官方")):
                slots["authority"] = slots["authority"] or str(e.get("id", ""))
            else:
                slots["support"] = slots["support"] or str(e.get("id", ""))
        out.append({"id": str(q.get("id", "")), "dim": dim,
                    "tokens": toks, "ext": ext, "slots": slots})
    return out


def _haystack(row: dict) -> str:
    sp = Path(str(row.get("source_path") or ""))
    return " ".join((str(row.get("text_head") or ""), sp.stem,
                     sp.parent.name, str(row.get("url_norm") or "")))


def _engine_dim(engine: str) -> str:
    e = str(engine or "").lower()
    for tag, dim in ENGINE_DIM_HINTS:
        if tag in e:
            return dim
    return ""


def pick_subq(row: dict, matchers: list[dict]) -> tuple[dict, int]:
    """行 → (最佳子问题匹配器, 分数). 平分取靠前者 (确定性)."""
    hay = _haystack(row)
    best, best_s = None, 0
    hint = _engine_dim(row.get("engine"))
    for m in matchers:
        s = 0
        for t in m["tokens"]:            # 子问题专属 token: 权重=长度档
            if t in hay:
                s += 2 if len(t) >= 4 else 1
        for k in m["ext"]:               # 维度扩展词: 各 1 分
            if k in hay:
                s += 1
        if hint and hint == m["dim"]:
            s += 1                        # 引擎弱信号
        if s > best_s:
            best, best_s = m, s
    return best or matchers[0], best_s


def pick_eei(row: dict, m: dict) -> tuple[str, str]:
    """子问题内选 EEI 槽 → (eei_id, stance). 无对应槽回退 support 槽."""
    hay = _haystack(row)
    eng = str(row.get("engine") or "").lower()
    url = str(row.get("url_norm") or "")
    cred = str(row.get("credibility") or "")
    if any(k in hay for k in AGAINST_KW) and m["slots"]["against"]:
        return m["slots"]["against"], "against"
    if ((cred == "official" or any(u in url for u in AUTHORITY_URL)
         or any(t in eng for t in AUTHORITY_ENG))
            and m["slots"]["authority"]):
        return m["slots"]["authority"], "support"
    return m["slots"]["support"], "support"


def backfill(cid: str, dry: bool = False, min_score: int = 1,
             pool_root: Path = POOL_ROOT) -> dict:
    pool = Path(pool_root) / cid
    if not pool.is_dir():
        raise FileNotFoundError(f"战役池不存在: {pool}")
    tree = load_tree(pool)
    matchers = build_matchers(tree)
    mp = pool / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]

    n_attached = n_kept = n_skip_judge = n_below = 0
    by_dim: Counter = Counter()
    by_eei: Counter = Counter()
    for r in rows:
        if r.get("tree_node"):
            n_kept += 1
            continue
        if r.get("judge") != "valid":
            n_skip_judge += 1
            continue
        m, s = pick_subq(r, matchers)
        if s < min_score:
            n_below += 1
            continue
        eei, stance = pick_eei(r, m)
        if not eei:                        # 树槽缺失 (理论不发生): 诚实跳过
            n_below += 1
            continue
        r["tree_node"], r["stance"] = eei, stance
        n_attached += 1
        by_dim[m["dim"]] += 1
        by_eei[eei] += 1

    rep = {"campaign": cid, "ran": time.strftime("%Y-%m-%dT%H:%M:%S"),
           "rows": len(rows), "attached": n_attached, "kept_existing": n_kept,
           "skip_not_valid": n_skip_judge, "below_min_score": n_below,
           "min_score": min_score, "by_dim": dict(by_dim),
           "by_eei_top": dict(by_eei.most_common(12)), "dry": dry}
    if not dry and n_attached:
        bak = pool / "manifest.pre-tree-backfill.bak.jsonl"
        if not bak.is_file():             # 备份只一次 (只增)
            mp.replace(bak)
        else:
            bak = None
        tmp = mp.with_suffix(".jsonl.tmp")
        tmp.write_text(
            "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows),
            encoding="utf-8")
        tmp.replace(mp)
        rep["backup"] = str(bak) if bak else "(已存在, 沿用)"
    return rep


def _main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="存量证据判挂树 (B/P 轴解锁前置)")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--min-score", type=int, default=1)
    ns = ap.parse_args(argv)
    try:
        rep = backfill(ns.campaign, ns.dry, ns.min_score, Path(ns.pool_root))
    except (FileNotFoundError, json.JSONDecodeError) as e:
        print(f"[backfill] 错误: {e}", file=sys.stderr)
        return 2
    print(f"[backfill] {ns.campaign} ({'DRY' if ns.dry else 'APPLY'}): "
          f"行 {rep['rows']} | 挂树 +{rep['attached']} | 保留既有 "
          f"{rep['kept_existing']} | 非valid跳过 {rep['skip_not_valid']} | "
          f"分不足留空 {rep['below_min_score']} (min_score={rep['min_score']})")
    for dim, n in sorted(rep["by_dim"].items(), key=lambda x: -x[1]):
        print(f"  {dim:<6} +{n}")
    for eei, n in rep["by_eei_top"].items():
        print(f"  {eei:<8} +{n}")
    if rep.get("backup"):
        print(f"[backfill] 备份: {rep['backup']}")
    return 0


if __name__ == "__main__":
    sys.exit(_main())
