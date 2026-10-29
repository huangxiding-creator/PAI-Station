# -*- coding: utf-8 -*-
"""osint_sop — P2-5 OSINT 尽调 SOP 编排器 (终极提案 P2-5, 1028 用户已批).

思想来源: OpenCTI / SpiderFoot (开源情报自动化) 的结构化调查流程 —
目标 → 线索 → 交叉验证 → 结论链; 本件移植为企业尽调六面编排:
  工商 / 资质 / 业绩 / 司法 / 舆情 / 股权穿透
每面: 自动生成尽调清单 (查什么/口径) → 调用在库渠道腿 (reforge_factory/legs,
subprocess 串行, ≤4 并发天然合规) → 汇总命中与缺口 (无在库实装腿的面如实标
「腿缺口+人工查证指针」, 不伪造结果) → 尽调报告 md/json + 台账 jsonl。

腿实况 (1028 腿库盘点, 如实):
  舆情     bing_news_rss(实装) + google_news_rss(实装)
  司法     courtlistener_recap(实装·海外面; 国内裁判文书无在库腿→缺口)
  股权穿透 wikidata(实装) + open_ownership_register(骨架·如实试跑可败)
  业绩     ccgp_gov_cn(半实装·解析TODO, 如实试跑可败)
  工商     无在库API腿 → 清单+人工指针 (信用中国/国家企业信用信息公示系统)
  资质     无在库API腿 → 清单+人工指针 (住建部四库一平台/行业协会)

用法:
  py reforge_factory/osint_sop.py --target 中国电建集团华东勘测设计研究院有限公司 \
      [--alias 华东院,PowerChina Huadong] [--campaign OSINT-HD] \
      [--facets 舆情,司法,股权穿透,业绩] [--rows 6] [--run-legs|--checklist-only]
产物: reforge_factory/completeness/osint_<hash>.md/.json + osint_sop_log.jsonl (只增)
      + ammo_pool/<campaign>/staging/<engine>/<ts>/*.md (腿证据件, 只增)。
铁律: 免费宪法 / 数字零造假 (命中/失败/零命中全如实) / 只增不删 / 浏览器不开。
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))

REPO = Path(__file__).resolve().parents[1]
LEGS = Path(__file__).resolve().parent / "legs"
LOG = Path(__file__).resolve().parent / "osint_sop_log.jsonl"
OUTDIR = Path(__file__).resolve().parent / "completeness"

#: 六面定义: 面 → (清单查证口径, 在库腿[engine, 实况, 查询模板], 人工指针)
FACETS: dict[str, dict] = {
    "工商": {
        "checklist": ["统一社会信用代码/注册号", "注册资本与实缴", "法定代表人与高管",
                      "成立日期与登记状态", "经营范围(工程总承包/勘察设计资质相关条目)",
                      "分支机构与变更记录"],
        "legs": [],
        "manual": ["国家企业信用信息公示系统 gsxt.gov.cn (官方唯一源)",
                   "信用中国 creditchina.gov.cn (行政处罚/失信名单)",
                   "企查查/天眼查 (工商快照交叉验证, 商业库)"],
    },
    "资质": {
        "checklist": ["工程勘察/设计资质等级与有效期", "施工总承包/专业承包资质",
                      "安全生产许可证", "行业会员与信用评级 (AA/A级)",
                      "资质动态核查/整改记录"],
        "legs": [],
        "manual": ["住建部四库一平台 (建设工程企业资质查询)",
                   "全国建筑市场监管公共服务平台 jzsc.mohurd.gov.cn",
                   "中国建筑业协会/中国勘察设计协会会员名录"],
    },
    "业绩": {
        "checklist": ["近年中标项目 (业主/金额/工期)", "在建与已完工 EPC 项目",
                      "代表性工程与获奖", "海外项目足迹"],
        "legs": [
            {"engine": "ccgp_gov_cn", "status": "半实装(解析TODO)",
             "queries": ["{t}"]},
        ],
        "manual": ["中国招标投标公共服务平台", "各省市公共资源交易中心成交公示",
                   "ENR 最大承包商榜单"],
    },
    "司法": {
        "checklist": ["涉诉案件 (角色: 原告/被告)", "被执行/失信记录",
                      "裁判文书要旨 (工程合同纠纷类)", "行政处罚",
                      "海外司法面 (制裁/海外诉讼)"],
        "legs": [
            {"engine": "courtlistener_recap", "status": "实装(海外面)",
             "queries": ["{en}"]},
        ],
        "manual": ["中国裁判文书网 wenshu.court.gov.cn (无在库腿→缺口, 如实)",
                   "中国执行信息公开网 zxgk.court.gov.cn"],
    },
    "舆情": {
        "checklist": ["近90天新闻面 (正面/负面)", "重大事故/质量通报",
                      "高管变动与战略发布", "社交媒体与微信生态讨论"],
        "legs": [
            {"engine": "bing_news_rss", "status": "实装", "queries": ["{t}"]},
            {"engine": "google_news_rss", "status": "实装", "queries": ["{t}"]},
        ],
        "manual": ["应急管理部/住建部事故通报", "地方住建厅通报文件"],
    },
    "股权穿透": {
        "checklist": ["控股母公司链条 (直至最终控制人)", "子公司/参股公司",
                      "实益所有权与关联企业", "国有资本监管关系 (国资委体系)"],
        "legs": [
            {"engine": "wikidata", "status": "实装", "queries": ["{en}", "{t}"]},
            {"engine": "open_ownership_register", "status": "骨架(API直连待验)",
             "queries": ["{en}"]},
        ],
        "manual": ["国家企业信用信息公示系统股权链条逐层点开",
                   "国务院国资委央企名录 (国企体系定位)"],
    },
}
FACET_ORDER = ("工商", "资质", "业绩", "司法", "舆情", "股权穿透")


def build_queries(tpl: str, target: str, en: str) -> str:
    return tpl.replace("{t}", target).replace("{en}", en or target)


def run_leg(engine: str, campaign: str, queries: list[str],
            rows: int) -> dict:
    """subprocess 串行调腿 (py -X utf8 legs/<engine>_leg.py --no-ingest)。
    --no-ingest: 只落 staging 证据件不入池 — 冒烟不污染战役池, 如实。"""
    leg_py = LEGS / ("%s_leg.py" % engine)
    if not leg_py.is_file():
        return {"engine": engine, "rc": 9, "note": "腿文件不存在"}
    cmd = ["py", "-X", "utf8", str(leg_py), "--campaign", campaign,
           "--queries", *queries, "--rows", str(rows), "--no-ingest"]
    t0 = time.time()
    try:
        r = subprocess.run(cmd, capture_output=True, text=True,
                           encoding="utf-8", errors="replace",
                           timeout=240, cwd=str(REPO))
        out = (r.stdout or "") + (r.stderr or "")
        hit = re.search(r"合计\s+(\d+)\s+条命中", out)
        if hit is None:                       # 腿 JSON 汇总面 (零命中时不建md)
            m2 = re.search(r'"hits"\s*:\s*(\d+)', out)
            hit = m2
        staged = re.findall(r"staging[/\\]\S+\.md", out)
        return {"engine": engine, "rc": r.returncode,
                "hits": int(hit.group(1)) if hit else None,
                "staged_files": staged[:8],
                "tail": out.strip().splitlines()[-3:] if out.strip() else [],
                "elapsed_sec": round(time.time() - t0, 1)}
    except subprocess.TimeoutExpired:
        return {"engine": engine, "rc": 8, "note": "超时240s (如实)"}


def run(target: str, alias: str, campaign: str, facets: list[str],
        rows: int, checklist_only: bool) -> int:
    aliases = [a.strip() for a in alias.split(",") if a.strip()]
    en = next((a for a in aliases if re.match(r"^[A-Za-z ]+$", a)), "")
    short = next((a for a in aliases if a and a != en), "")
    t0 = time.time()
    facet_rows = []
    for f in FACET_ORDER:
        if f not in facets:
            continue
        spec = FACETS[f]
        row = {"facet": f, "checklist": spec["checklist"],
               "manual_pointers": spec["manual"], "legs": []}
        if spec["legs"] and not checklist_only:
            for leg in spec["legs"]:
                qs = [build_queries(t, target if "{t}" in t else "", en)
                      for t in leg["queries"]]
                qs = [q for q in qs if q]
                print("[osint] %s ← %s: %s" % (f, leg["engine"], qs))
                r = run_leg(leg["engine"], campaign, qs, rows)
                r["status_declared"] = leg["status"]
                r["queries"] = qs
                row["legs"].append(r)
        elif spec["legs"]:
            row["legs"] = [{"engine": l["engine"], "rc": None,
                            "status_declared": l["status"],
                            "note": "checklist-only 模式未调腿"} for l in
                           spec["legs"]]
        else:
            row["legs"] = []
            row["note"] = "无在库API腿 → 腿缺口, 人工查证指针见上 (如实)"
        facet_rows.append(row)
    h = hashlib.md5(target.encode("utf-8")).hexdigest()[:8]
    hits_total = sum(x.get("hits") or 0 for fr in facet_rows
                     for x in fr["legs"])
    legs_ok = sum(1 for fr in facet_rows for x in fr["legs"]
                  if x.get("rc") == 0 and (x.get("hits") or 0) > 0)
    legs_ran = sum(1 for fr in facet_rows for x in fr["legs"]
                   if x.get("rc") is not None)
    rec = {"ts": time.strftime("%Y-%m-%d %H:%M"), "target": target,
           "alias": aliases, "campaign": campaign, "facets": facet_rows,
           "legs_ran": legs_ran, "legs_ok": legs_ok, "hits_total": hits_total,
           "elapsed_sec": round(time.time() - t0, 1)}
    out_md = OUTDIR / ("osint_%s.md" % h)
    out_json = OUTDIR / ("osint_%s.json" % h)
    md = ["# OSINT 尽调报告 | %s" % target, "",
          "- 六面 SOP (OpenCTI/SpiderFoot 思想蒸馏): 腿实跑 %d (有命中 %d) | "
          "命中合计 %d | 耗时 %.0fs | 目标签名 %s"
          % (legs_ran, legs_ok, hits_total, time.time() - t0,
             "/".join(aliases) or "-"), ""]
    for fr in facet_rows:
        md.append("## %s 面" % fr["facet"])
        md.append("")
        md.append("**尽调清单:**")
        for c in fr["checklist"]:
            md.append("- [ ] %s" % c)
        if fr["legs"]:
            md.append("")
            md.append("**渠道腿实测:**")
            for x in fr["legs"]:
                if x.get("rc") is None:
                    md.append("- %s (%s): 未跑 (%s)" % (
                        x["engine"], x.get("status_declared", ""),
                        x.get("note", "")))
                    continue
                hits = x.get("hits")
                hit_s = ("命中 %s 条" % hits) if hits is not None else \
                    "结果待人工读staging件"
                md.append("- %s (%s, 声明状态: %s): rc=%s, %s, %.0fs%s"
                          % (x["engine"], x.get("status_declared", ""),
                             "", x["rc"], hit_s, x.get("elapsed_sec", 0),
                             (" — 失败如实: %s" % x["note"])
                             if x.get("note") else ""))
                for q in x.get("queries", []):
                    md.append("  - 查询词: %s" % q)
                for sf in x.get("staged_files", []):
                    md.append("  - 证据件: %s" % sf)
        if fr.get("note"):
            md.append("")
            md.append("> %s" % fr["note"])
        md.append("")
        md.append("**人工查证指针 (腿外):**")
        for m in fr["manual_pointers"]:
            md.append("- %s" % m)
        md.append("")
    md += ["> 数字零造假: 命中数/失败/零命中全如实; 腿声明状态与实测 rc 并陈;",
           "> 证据件落 ammo_pool/%s/staging/ (只增)。本报告为内部尽调工作件。" % campaign]
    out_md.write_text("\n".join(md), encoding="utf-8")
    out_json.write_text(json.dumps(rec, ensure_ascii=False, indent=1),
                        encoding="utf-8")
    with LOG.open("a", encoding="utf-8") as fh:          # 台账只增
        fh.write(json.dumps({k: v for k, v in rec.items()
                             if k != "facets"}, ensure_ascii=False) + "\n")
    print("[osint] 尽调报告: %s | 腿实跑%d(命中%d) 合计命中%d → %s"
          % (target, legs_ran, legs_ok, hits_total, out_md))
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="OSINT 尽调 SOP (P2-5)")
    ap.add_argument("--target", required=True, help="目标企业全称")
    ap.add_argument("--alias", default="", help="别名/英文名, 逗号分隔")
    ap.add_argument("--campaign", default="OSINT-SMOKE",
                    help="staging 落账战役 (默认 OSINT-SMOKE, 不入生产池)")
    ap.add_argument("--facets", default=",".join(FACET_ORDER),
                    help="跑哪几面 (默认全部六面)")
    ap.add_argument("--rows", type=int, default=6)
    ap.add_argument("--checklist-only", action="store_true",
                    help="只生成清单不调腿")
    ns = ap.parse_args()
    facets = [f.strip() for f in ns.facets.split(",") if f.strip()]
    bad = [f for f in facets if f not in FACET_ORDER]
    if bad:
        print("未知面: %s (合法: %s)" % (bad, "/".join(FACET_ORDER)),
              file=sys.stderr)
        return 2
    return run(ns.target, ns.alias, ns.campaign, facets, ns.rows,
               ns.checklist_only)


if __name__ == "__main__":
    raise SystemExit(main())
