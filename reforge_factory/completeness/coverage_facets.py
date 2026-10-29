# -*- coding: utf-8 -*-
"""B 轴完备性传感器 coverage_facets — 十面×facet 点亮矩阵 (T-007B / REQ-024).

REQ-024: 当 B 轴广度评估时, 系统应输出十面×facet 点亮矩阵 (每面证据≥L2
才算亮, L1 仅记提及), 并计算点亮面数十分比.

十面 = 政策法规 / 市场行情 / 竞争格局 / 案例实践 / 风险纠纷 / 财务经营
       + 扩展四面 技术方案 / 组织人事 / 国际对标 / 渠道生态
与 question_tree.py v0 六维 SUBQ_TEMPLATES 一一对齐 (政策监管→政策法规,
市场规模→市场行情, 竞争格局/财务经营同名, 项目案例→案例实践,
风险事件→风险纠纷); 扩展四面同名恒等; 异版树 (如 epc50 十维) 走
DIM_EXACT→关键词回退, 未映射维显式记 note 不入面 (零造假).

深度近似口径 (防伪 Goodhart 对策, KB-COMPLETENESS-SPEC):
  L0 = 零有效证据
  L1 = 单条有效证据 (仅提及 — 不点亮)
  L2 = ≥2 条但独立 host=1 (有数据, 单源) — 点亮
  L3 = ≥2 条且 ≥2 独立 host (双源交叉) — 点亮
  lit = best_depth ∈ {L2, L3};  green = 十面全亮 (lit_count==10).
独立 host = url_norm 域名 (缺 url 用 source_path 文件名), 同文多站经
syndicate.effective_hosts 折叠 (5 份通稿=1 票; 不可导入时退化朴素域名口径).
证据只认 judge==valid (门槛账铁律); 挂树 = manifest.tree_node ↔ 树 EEI id.

输出 (只增不删, 一源两锚):
  ammo_pool/<战役>/coverage_facets.json      — REQ-024.AC1 机检锚点
  ammo_pool/<战役>/completeness/B_axis.json  — 五轴账本 B 轴节 (同负载)
记录本体即合法 completeness_ledger 单行 (axis/sensor/facets/green 齐备).

用法: py reforge_factory/completeness/coverage_facets.py scan <cid>
      [--pool-root PATH] [--out-dir PATH] [--no-write]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from collections import Counter
from pathlib import Path
from urllib.parse import urlsplit

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # 脚本模式
try:
    from syndicate import effective_hosts    # FT-4 同文多站折叠 (可选地基)
except Exception:                            # 缺件退化, 不阻断 B 轴
    effective_hosts = None

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# ---------- 十面与映射 (question_tree 六维 + 扩展四面) ----------

TEN_FACETS: list[str] = [
    "政策法规", "市场行情", "竞争格局", "案例实践", "风险纠纷", "财务经营",
    "技术方案", "组织人事", "国际对标", "渠道生态",
]

# question_tree.py v0 六维精确表 + 十面名恒等
DIM_EXACT: dict[str, str] = {
    "政策监管": "政策法规", "市场规模": "市场行情", "竞争格局": "竞争格局",
    "项目案例": "案例实践", "风险事件": "风险纠纷", "财务经营": "财务经营",
    **{f: f for f in TEN_FACETS},
    # 1026 EPC-JIAGE 树十维精确映射 (五轴门修①): 异版树十维逐一入面,
    # 关键词回退对计价域维度(投标编制/结算核对/造价鉴定争议等)不命中,
    # 致 6 维 9+6+9+9+6+9=48 EEIs / 2,519 条有效证据不计入十面 (零虚报修复)。
    # 领域对位: 投标=竞标竞争行为→竞争格局; 结算核对=工程款财务面→财务经营;
    # 造价鉴定与争议=司法纠纷面→风险纠纷; 计价模式/定额测定=计价技术方法
    # 体系→技术方案; 造价咨询与职业=职业资格人事面→组织人事;
    # 数据源与工具生态=渠道生态面(同"生态"恒等)。
    "政策法规与定额体系": "政策法规",
    "计价依据与定额测定": "技术方案",
    "信息价与市场价基准": "市场行情",
    "投标编制实务": "竞争格局",
    "结算核对实务": "财务经营",
    "合同解除结算": "案例实践",
    "造价鉴定与争议": "风险纠纷",
    "清单与定额计价模式": "技术方案",
    "造价咨询与职业": "组织人事",
    "数据源与工具生态": "渠道生态",
    # 1028 EPC-TOP50 树十维精确映射 (同 JIAGE 门修① 先例, 只增不改):
    # 异版树十维逐一入面 — 格局方法论(总量/排名/口径)=市场行情;
    # 转型/集团军/专业赛道/区域梯队/分档画像=玩家竞争格局;
    # 项目管理与交付=案例实践; 营收盈利=财务经营; 人才与组织=组织人事;
    # 数字化与技术创新=技术方案。(政策法规/风险纠纷面由 E3 政策件与
    # Q19 风险维的关键词回退点亮; 国际对标/渠道生态本树无对应维,
    # 豁免走 1026 轴级豁免显式记录。)
    "总承包营业额格局与排名方法论": "市场行情",
    "设计院转型EPC的路径与模式": "竞争格局",
    "央企集团军作战体系": "竞争格局",
    "专业工程公司赛道": "竞争格局",
    "区域勘测设计院梯队": "竞争格局",
    "总承包项目管理与交付能力": "案例实践",
    "营收结构盈利与风险": "财务经营",
    "人才与组织": "组织人事",
    "数字化与技术创新": "技术方案",
    "50强名单企业分档画像": "竞争格局",
}

# 1028 EPC-TOP50 EEI 级精修 (十面映射门修①续, 战役限定零跨役影响):
# 维级映射粒度不足两处 — ① Q19 (应收垫资纠纷与经营风险) 本体即风险纠纷
# 面, 其维已整维映财务经营, 拆回风险面; ② 全树 26 个 -E3 槽 = need 钦定
# 「官方文件/规范/公报原文」槽, 证据即政策法规面 (E3 优先于维面)。
EEI_FACET_OVERRIDE: dict[str, dict[str, str]] = {
    "EPC-TOP50": {
        "Q19-E1": "风险纠纷",
        "Q19-E2": "风险纠纷",
        **{f"Q{n}-E3": "政策法规" for n in range(1, 27)},
    },
}

# 关键词回退 (异版树): 先专后泛 — 国际/海外先于市场 (国际市场→国际对标),
# 对标不等于国际 (10_市场与对标→市场行情), 战略归竞争, 施工/设计归技术.
FACET_KEYWORDS: list[tuple[str, tuple[str, ...]]] = [
    ("国际对标", ("国际", "海外", "全球", "跨国", "出海", "国外", "境外")),
    ("政策法规", ("政策", "监管", "法规", "法律", "合规", "制度", "准入",
                 "资质", "规章")),
    ("竞争格局", ("竞争", "格局", "对手", "份额", "排名", "头部", "战略",
                 "分层")),
    ("风险纠纷", ("风险", "纠纷", "事故", "处罚", "司法", "诉讼", "败诉",
                 "仲裁", "安全")),
    ("财务经营", ("财务", "营收", "收入", "毛利", "现金流", "应收", "经营",
                 "基本面", "业绩", "盈亏")),
    ("技术方案", ("技术", "工艺", "方案", "设计", "创新", "专利", "施工",
                 "工法", "数字化", "智能")),
    ("组织人事", ("组织", "人事", "人才", "团队", "人员", "员工", "管理层",
                 "领导", "用工", "岗位")),
    ("渠道生态", ("渠道", "生态", "供应链", "产业链", "采购", "伙伴", "代理",
                 "分销")),
    ("案例实践", ("案例", "项目", "实践", "工程", "典型", "标志", "示范",
                 "合同")),
    ("市场行情", ("市场", "规模", "行情", "需求", "价格", "增速", "趋势",
                 "客户", "定位")),
]


def dim_to_facet(dim: str) -> str | None:
    """树维度 → 十面 (精确表 → 关键词回退 → None=未映射, 显式不猜)."""
    dim = str(dim).strip()
    if dim in DIM_EXACT:
        return DIM_EXACT[dim]
    for facet, kws in FACET_KEYWORDS:
        if any(k in dim for k in kws):
            return facet
    return None


def load_axis_waiver(cid: str, pool_root=None, out_dir=None) -> dict:
    """重跑保留: 读池内已有 coverage_facets.json / completeness/B_axis.json
    的轴级豁免 (waived 真值 + waiver_note), 供 scan 输出携带 — 同
    entity_timeline.load_existing_waivers 范式 (人工登记不因重跑抹除,
    1026 五轴门修③配链)."""
    root = Path(pool_root) if pool_root else POOL_ROOT
    out = Path(out_dir) if out_dir else root / cid
    for name in ("coverage_facets.json", "completeness/B_axis.json"):
        p = out / name
        if p.is_file():
            try:
                prev = json.loads(p.read_text(encoding="utf-8"))
            except Exception:
                continue
            if isinstance(prev, dict) and prev.get("waived"):
                return {"waived": True,
                        "waiver_note": str(prev.get("waiver_note") or "")}
    return {}


# ---------- host 口径 (与 ammo_pool.coverage 同式 + 可选辛迪加折叠) ----------

def _row_host(r: dict) -> str:
    h = urlsplit(str(r.get("url_norm") or "")).netloc
    return h or Path(str(r.get("source_path") or "?")).stem or "?"


def _host_set(ev: list[dict]) -> frozenset | set:
    if effective_hosts is not None:
        try:
            return effective_hosts(ev)
        except Exception:
            pass                                  # 折叠失败退朴素口径
    return {_row_host(r) for r in ev}


def _depth(n_ev: int, n_hosts: int) -> str:
    """L0 零证据 / L1 单条提及 / L2 数据(单源) / L3 双源."""
    if n_ev == 0:
        return "L0"
    if n_ev == 1:
        return "L1"
    return "L3" if n_hosts >= 2 else "L2"


# ---------- scan: 十面点亮矩阵 ----------

def scan(cid: str, pool_root=None, out_dir=None, write: bool = True) -> dict:
    """扫描战役池 → B 轴记录 (dict); write=True 时一源两锚落盘.

    真实池只读 (manifest/question_tree 只读不改); 输出文件只增不删.
    树缺失/解析失败 → fail-soft: 十面全 unlit + note, 不虚报不炸.
    """
    root = Path(pool_root) if pool_root else POOL_ROOT
    d = root / cid
    if not d.is_dir():
        raise FileNotFoundError(f"战役池不存在: {d}")

    notes: list[str] = []
    eei_facet: dict[str, str | None] = {}         # EEI id → 面 (None=未映射维)
    unmapped_ids: dict[str, str] = {}             # 未映射维 EEI id → dim
    unmapped_eeis: dict[str, int] = {}            # dim → 该维 EEIs 数
    facet_eei_total: Counter = Counter()
    eei_total = 0

    tp = d / "question_tree.json"
    if not tp.is_file():
        notes.append("问题树缺失 (question_tree.json 不在池内): "
                     "十面全 unlit (fail-soft, 不虚报)")
    else:
        try:
            tree = json.loads(tp.read_text(encoding="utf-8"))
        except Exception as e:
            notes.append(f"question_tree.json 解析失败({e}): 十面全 unlit")
            tree = None
        if not isinstance(tree, dict):
            tree = None
        if tree:
            ovr = EEI_FACET_OVERRIDE.get(cid, {})
            for q in tree.get("subquestions", []):
                dim = str(q.get("dim", ""))
                facet = dim_to_facet(dim)
                eeis = q.get("eeis", []) or []
                eei_total += len(eeis)
                if facet is None:
                    unmapped_eeis[dim] = unmapped_eeis.get(dim, 0) + len(eeis)
                for e in eeis:
                    eid = str(e.get("id", ""))
                    f2 = ovr.get(eid, facet)      # EEI 级精修优先
                    if eid:
                        eei_facet[eid] = f2
                        if f2 is not None:
                            facet_eei_total[f2] += 1
                        else:
                            unmapped_ids[eid] = dim

    # manifest 挂树证据 (只认 valid; 坏行跳过透明计数)
    buckets: dict[str, list[dict]] = {f: [] for f in TEN_FACETS}
    n_bad = n_unattached = n_off_tree = n_unmapped_ev = 0
    unmapped_ev_by_dim: dict[str, int] = {}
    mp = d / "manifest.jsonl"
    if mp.is_file():
        for ln in mp.read_text(encoding="utf-8").splitlines():
            if not ln.strip():
                continue
            try:
                r = json.loads(ln)
            except Exception:
                n_bad += 1
                continue
            if r.get("judge") != "valid":          # 门槛账只认 valid
                continue
            node = str(r.get("tree_node") or "")
            if not node:
                n_unattached += 1
                continue
            if node not in eei_facet:
                n_off_tree += 1
                continue
            facet = eei_facet[node]
            if facet is None:
                n_unmapped_ev += 1
                dim = unmapped_ids.get(node, "?")
                unmapped_ev_by_dim[dim] = unmapped_ev_by_dim.get(dim, 0) + 1
                continue
            buckets[facet].append(r)

    facets: dict[str, dict] = {}
    for f in TEN_FACETS:
        ev = buckets[f]
        hosts = _host_set(ev)
        st = Counter(str(r.get("stance") or "") for r in ev if r.get("stance"))
        depth = _depth(len(ev), len(hosts))
        facets[f] = {
            "evidence": len(ev),                   # KB 账本 schema 键名
            "evidence_count": len(ev),             # 任务口径键名 (同值双锚)
            "hosts": len(hosts),
            "stance": dict(st),
            "eei_total": facet_eei_total.get(f, 0),
            "eei_with_evidence": len({r.get("tree_node") for r in ev}),
            "best_depth": depth,
            "lit": depth in ("L2", "L3"),          # ≥L2 才亮, L1 仅记提及
        }

    lit_count = sum(1 for f in TEN_FACETS if facets[f]["lit"])
    rec = {
        "axis": "B",
        "sensor": "coverage_facets",
        "campaign": cid,
        "checked": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "eei_total": eei_total,
        "facets": facets,
        "lit_count": lit_count,
        "lit_ratio": round(lit_count / len(TEN_FACETS), 4),
        "lit_rule": ("L1=单条提及不点亮; L2=≥2条且独立host=1(数据); "
                     "L3=≥2条且≥2独立host(双源); lit=best_depth∈{L2,L3}"),
        "green": lit_count == len(TEN_FACETS),
        "notes": notes,
    }
    # 1026 轴级豁免重跑保留 (五轴门修③): B green=十面全亮; 战役树无对应维
    # 的面 (如 EPC-JIAGE 国内计价专题无国际对标维) 不可点亮, 豁免须显式
    # 在案 (waived+waiver_note), cidx/完备门按 all_green_or_waived 消费.
    waiver = load_axis_waiver(cid, root, out_dir)
    if waiver.get("waived"):
        rec["waived"] = True
        if waiver.get("waiver_note"):
            rec["waiver_note"] = waiver["waiver_note"]
    if n_bad:
        notes.append(f"manifest 坏行 {n_bad} 条已跳过")
    for dim, n_eei in sorted(unmapped_eeis.items()):
        notes.append(f"树维度未映射十面: {dim} ({n_eei} EEIs, "
                     f"有效证据 {unmapped_ev_by_dim.get(dim, 0)} 条不计入)")
    if n_off_tree:
        notes.append(f"{n_off_tree} 条有效证据挂到树外节点 (未计入十面)")
    if n_unattached:
        notes.append(f"{n_unattached} 条有效证据未挂树 (tree_node 为空, "
                     f"未计入十面)")

    if write:
        out = Path(out_dir) if out_dir else d
        out.mkdir(parents=True, exist_ok=True)
        payload = json.dumps(rec, ensure_ascii=False, indent=1)
        (out / "coverage_facets.json").write_text(payload, encoding="utf-8")
        bdir = out / "completeness"
        bdir.mkdir(parents=True, exist_ok=True)
        (bdir / "B_axis.json").write_text(payload, encoding="utf-8")
    return rec


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="B 轴十面点亮矩阵传感器 (REQ-024)")
    ap.add_argument("cmd", choices=["scan"])
    ap.add_argument("cid", help="战役池 id (如 EPC-BID26)")
    ap.add_argument("--pool-root", default=None, help="池根 (默认 E:/AI-Station/ammo_pool)")
    ap.add_argument("--out-dir", default=None, help="输出目录 (默认=战役池目录)")
    ap.add_argument("--no-write", action="store_true", help="只扫不落盘")
    args = ap.parse_args(argv)
    try:
        rec = scan(args.cid, pool_root=args.pool_root, out_dir=args.out_dir,
                   write=not args.no_write)
    except FileNotFoundError as e:
        print(f"[B] {e}", file=sys.stderr)
        return 2
    print(f"[B] {args.cid} 十面点亮 {rec['lit_count']}/10 "
          f"({rec['lit_ratio']:.0%}) green={rec['green']}")
    for f in TEN_FACETS:
        v = rec["facets"][f]
        mark = "✓" if v["lit"] else ("△" if v["best_depth"] == "L1" else "✗")
        print(f"  {mark} {f:<4} {v['best_depth']} 证据{v['evidence']:>4} "
              f"host{v['hosts']:>3} EEI {v['eei_with_evidence']}/"
              f"{v['eei_total']}")
    for n in rec["notes"]:
        print(f"  · {n}")
    return 0


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.exit(main())
