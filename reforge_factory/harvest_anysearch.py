# -*- coding: utf-8 -*-
"""harvest_anysearch — AnySearch 实时搜索收割腿 (BID26 四面补采).

链路: 复用 EPC100 collectors.anysearch.client (限流/熔断/日限四件套齐备:
匿名 10/窗 6s 步进 日限200 429冷却900s 熔断连败5) → POST /v1/search 面
词查询 (每查询 top3) → POST /v1/extract 取全文 markdown → 落
data/harvest/anysearch/<cid>/*.md。

纪律 (产线契约):
- 绝不 import ammo_pool / 绝不 ingest — 本腿只产文件+manifest;
- 双重相关门: 标题命中面词 ∧ 命中域词 (招标|投标|评标|工程|EPC|采购|
  承包|造价|FIDIC|BIM|供应链), 不相关不入;
- extract 全文 <300 字或失败 = 如实 skip, 绝不拿 SERP snippet 凑数;
- URL 去重; 串行+礼貌间隔 (client 内建 6s 地板); 失败即停该查询。

用法: py reforge_factory/harvest_anysearch.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
from collectors.anysearch.client import AnySearchClient, AnySearchError  # noqa: E402

REPO = Path(__file__).resolve().parents[1]
ENGINE = "anysearch:web"

# (面词查询, 目标EEI, 面词正则) — 四面优先: 国际对标Q23/Q24, 技术方案Q19,
# 组织人事Q21, 渠道生态Q25; 域词兜底 Q1-E1
PLAN: list[tuple[str, str, str]] = [
    ("FIDIC 合同条件 EPC 银皮书",         "Q23-E1", r"FIDIC|银皮书|合同条件"),
    ("世界银行 工程采购 招标 规则",       "Q23-E1", r"世界银行|世行|银行"),
    ("对外承包工程 ENR 国际工程承包商",   "Q24-E1", r"对外承包|ENR|国际工程"),
    ("电子招投标平台 评标系统",           "Q19-E1", r"电子招投标|评标系统|电子招标"),
    ("评标专家库 管理办法 资格",          "Q21-E1", r"评标专家|专家库"),
    ("招标代理机构 资质 管理",            "Q25-E1", r"招标代理|代理机构"),
    ("世界银行采购指南 工程货物 招标",    "Q23-E1", r"采购指南|世界银行|世行|投标书"),
    ("造价工程师 招标师 资格",            "Q21-E1", r"造价工程师|招标师"),
    ("公共资源交易平台 整合 交易规则",    "Q26-E1", r"公共资源交易|交易平台"),
    # 1017 饱和冲刺追加 (EPC49 E2/E3 缺口定向: 公司风险面+权威原文面)
    ("四川电力设计咨询 行政处罚 通报",     "Q3-E2",  r"处罚|通报|违规"),
    ("四川院 净利润 应收账款 现金流",      "Q17-E2", r"净利润|应收|现金流|亏损"),
    ("设计院 EPC 转型 亏损 风险",          "Q8-E2",  r"亏损|风险|转型"),
    ("电力设计 专利 纠纷 无效",            "Q20-E2", r"专利|无效|纠纷"),
    ("海外 EPC 项目 亏损 教训",            "Q24-E2", r"海外|亏损|风险"),
    ("电子招投标平台 违规 通报",           "Q26-E2", r"违规|通报|处罚"),
    ("电力建设 政策 调整 项目 风险",       "Q2-E2",  r"政策|调整|风险"),
    ("建设工程质量管理条例 全文",          "Q18-E3", r"质量管理|条例|验收"),
    ("招标投标法实施条例 全文",            "Q26-E3", r"招标投标|条例"),
    ("中国电力企业联合会 标准 发布 公告",  "Q20-E3", r"标准|公告|发布"),
]
DOMAIN_RE = re.compile(
    r"招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链")
PER_QUERY = 3

CRED_RULES = [
    (re.compile(r"gov\.cn|adb\.org|worldbank|mofcom|ndrc|court|fidic\.org"),
     "official"),
    (re.compile(r"edu\.cn|baike\.baidu|zhihu|zhuanlan|org\.cn|academy|研究|协会|学会"),
     "research"),
]


def cred_of(url: str) -> str:
    for rx, tag in CRED_RULES:
        if rx.search(url):
            return tag
    return "media"


def slug(t: str) -> str:
    return re.sub(r"[^\w一-鿿-]+", "_", t)[:50]


def run(cid: str, dry: bool = False) -> int:
    out_dir = REPO / "data" / "harvest" / "anysearch" / cid
    out_dir.mkdir(parents=True, exist_ok=True)
    cli = AnySearchClient()
    mf = out_dir / "_manifest.jsonl"
    records: list[dict] = []
    seen_url: set[str] = set()
    # 断点续跑: 旧 manifest 里仍存在的件直接沿用, 不再耗配额重抓
    if mf.is_file():
        for line in mf.read_text(encoding="utf-8").splitlines():
            try:
                r0 = json.loads(line)
            except json.JSONDecodeError:
                continue
            if Path(r0["file"]).is_file():
                records.append(r0)
                seen_url.add(r0["url"])
    n_skip = n_fail = 0
    blockers: list[str] = []

    for query, eei, face_rx in PLAN:
        face_re = re.compile(face_rx)
        try:
            resp = cli.search(query, max_results=PER_QUERY)
        except AnySearchError as e:                       # 失败即停该查询
            msg = f"search '{query}' 失败: {e}"
            print(f"[anysearch] {msg}")
            blockers.append(msg)
            continue
        hits = (resp.get("data") or {}).get("results") or []
        print(f"[anysearch] '{query}' → {len(hits)} 结果")
        took = 0
        for it in hits:
            title = str(it.get("title", "")).strip()
            url = str(it.get("url", "")).strip()
            if took >= PER_QUERY:
                break
            if not title or not url or url in seen_url:
                continue
            seen_url.add(url)
            # ---- 双重相关门: 面词 ∧ 域词 (标题判) ----
            if not face_re.search(title) or not DOMAIN_RE.search(title):
                n_skip += 1
                print(f"  [skip门] {title[:44]}")
                continue
            fp = out_dir / (slug(title) + ".md")
            if fp.exists():                       # 已收割过的件不重抓
                print(f"  [已存] {title[:48]}")
                took += 1
                continue
            if dry:
                print(f"  [dry] {eei} {title[:48]}")
                took += 1
                continue
            # ---- extract 全文 (非 SERP 形硬门) ----
            try:
                ex = cli.extract(url)
            except AnySearchError as e:
                n_fail += 1
                print(f"  [extract失败] {title[:40]}: {str(e)[:60]}")
                continue
            md = str(((ex.get("data") or {}).get("content")) or "")
            time.sleep(1.0)                               # 礼貌附加间隔
            if len(md) < 300:
                n_skip += 1
                print(f"  [skip<300字] {title[:40]} (len={len(md)})")
                continue
            head = (f"# {title}\n\n> 来源: {url}\n> 频道: {ENGINE} "
                    f"查询='{query}'\n\n---\n\n{md}")
            fp.write_text(head, encoding="utf-8")
            rec = {"file": str(fp), "url": url, "engine": ENGINE,
                   "tree": eei, "cred": cred_of(url)}
            records.append(rec)
            took += 1
            print(f"  [存件] {eei} {title[:48]} ({len(md)}字, {rec['cred']})")

    if not dry:
        mf.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                                for r in records) + "\n", encoding="utf-8")
        print(f"\n[anysearch] manifest → {mf} ({len(records)} 件; "
              f"skip={n_skip} 失败={n_fail})")
        for b in blockers:
            print(f"[blocker] {b}")
    else:
        print(f"\n[anysearch dry] 件≈{len(records)} skip={n_skip} 失败={n_fail}")
    return 0 if records or dry else 1


if __name__ == "__main__":
    ap = argparse.ArgumentParser(description="AnySearch BID26 收割腿")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    a = ap.parse_args()
    raise SystemExit(run(a.campaign, a.dry))
