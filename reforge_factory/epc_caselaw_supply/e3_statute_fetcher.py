# -*- coding: utf-8 -*-
"""e3_statute_fetcher — EPC-CASELAW E3 权威位定向补采件 (1031 饱和冲门·三).

任务书: 司法解释原文+理解与适用 / 新仲裁法 2026 修订全文 / GB 51262 /
50500-2024 / 人民法院案例库·指导案例 → E3 槽。flk.npc.gov.cn 新版 SPA
API 匿名面参数锁+验证码 (probe 留档), 本件走同权威级官方域:
gov.cn / court.gov.cn / mohurd.gov.cn / mof.gov.cn / ndrc.gov.cn /
npc.gov.cn / policy.mofcom.gov.cn (全球法规网=商务部官网镜像)。

机制 (零造假铁律):
  · 每目标: anysearch SERP(实名真调) → 官方域优先选链 → urllib GET →
    html2text → 锚词校验(标题锚+实质锚, 不过即弃不硬灌) → 落盘带源头
    头 → ammo_pool.ingest (engine=website:gov_statute, tree=E3);
  · 逐目标台账 e3_statute_ledger.jsonl (查询/URL/字数/锚校验/结果);
  · 收益另计: 抓不到=如实 miss, 绝不编字数。

用法: py -X utf8 e3_statute_fetcher.py [--dry] [--only id1,id2]
"""
from __future__ import annotations

import argparse
import html as htmllib
import json
import re
import sys
import time
import urllib.parse
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng")
sys.path.insert(0, r"E:\AI-Station\ResearchFactory-Eng\EPC100")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import ammo_pool as AP  # noqa: E402
from collectors.anysearch.client import AnySearchClient  # noqa: E402

CID = "EPC-CASELAW"
OUT = Path(r"E:\AI-Station\data\harvest\statute\EPC-CASELAW")
LEDGER = AP.POOL_ROOT / CID / "e3_statute_ledger.jsonl"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36")
OFFICIAL = (".gov.cn",)

#: 采集计划: id, SERP词, 文件名, 锚词(须全含), EEI, 信级
PLAN = [
    ("zcf2026", "中华人民共和国仲裁法 2025修订 全文 施行", "仲裁法2025修订全文",
     ["仲裁", "仲裁委员会", "裁决"], "Q25-E3", "official"),
    ("zcjszxpgx", "最高人民法院 仲裁裁决执行 司法解释 法释 2018 全文",
     "最高法仲裁裁决执行规定法释2018", ["仲裁", "执行", "法释"], "Q25-E3",
     "official"),
    ("mfd", "中华人民共和国民法典 全文 第三编 合同",
     "民法典全文合同编", ["民法典", "合同", "第一百"], "Q21-E3", "official"),
    ("zbtbf", "中华人民共和国招标投标法 全文 2017修正",
     "招标投标法全文", ["招标", "投标", "中标"], "Q18-E3", "official"),
    ("bxzbgc", "必须招标的工程项目规定 发改委令 第16号 全文",
     "必须招标的工程项目规定16号令", ["必须招标", "项目", "规定"], "Q20-E3",
     "official"),
    ("rmtjf", "中华人民共和国人民调解法 全文",
     "人民调解法全文", ["调解", "人民调解", "委员会"], "Q23-E3", "official"),
    ("jsjsh", "建设工程价款结算暂行办法 财建 2004 369 全文",
     "建设工程价款结算暂行办法369号", ["结算", "工程", "价款"], "Q7-E3",
     "official"),
    ("sfbw", "建设工程施工合同 示范文本 GF-2017-0201 全文 通用条款",
     "施工合同示范文本GF20170201", ["合同", "通用条款", "发包人"], "Q9-E3",
     "official"),
    ("nmg", "保障农民工工资支付条例 全文 总理令",
     "保障农民工工资支付条例", ["农民工", "工资", "条例"], "Q22-E3",
     "official"),
    ("zxqy", "保障中小企业款项支付条例 全文",
     "保障中小企业款项支付条例", ["中小企业", "款项", "逾期"], "Q22-E3",
     "official"),
    ("msf", "中华人民共和国民事诉讼法 全文 2023修正",
     "民事诉讼法全文", ["民事诉讼", "管辖", "证据"], "Q26-E3", "official"),
    ("alss", "最高人民法院 统一法律适用 加强类案检索 指导意见 法发 2020 24",
     "最高法类案检索指导意见法发2020", ["类案", "检索", "法发"], "Q2-E3",
     "official"),
    ("dgax", "最高人民法院 发布 建设工程施工合同纠纷 典型案例 全文",
     "最高法建工施工合同纠纷典型案例", ["典型", "案例", "施工合同"], "Q1-E3",
     "official"),
    ("jdsc", "最高人民法院 民事诉讼 委托鉴定 审查 若干问题 规定 2021",
     "最高法委托鉴定审查规定", ["鉴定", "审查", "人民法院"], "Q14-E3",
     "official"),
    ("zjgd", "最高人民法院 民事诉讼证据 司法解释 法释 2019 19号 全文",
     "最高法民事诉讼证据规定", ["证据", "鉴定", "法释"], "Q26-E3",
     "official"),
    ("czps", "最高人民法院 财政评审 审计结论 结算 答复 建设工程",
     "最高法财政评审审计答复", ["审计", "结算", "最高人民法院"], "Q8-E3",
     "official"),
    ("jygl", "建筑工程施工发包与承包计价管理办法 住建部令 16号 全文",
     "计价管理办法住建部令16号", ["计价", "发包", "承包"], "Q16-E3",
     "official"),
    ("gb51262", "建设工程造价鉴定规范 GB/T 51262-2017 全文 条文",
     "造价鉴定规范GBT51262全文", ["鉴定", "工程造价", "51262"], "Q13-E3",
     "research"),
    ("gb50500", "建设工程工程量清单计价标准 GB/T 50500-2024 全文",
     "清单计价标准GBT50500全文", ["工程量清单", "计价", "50500"], "Q4-E3",
     "research"),
]

_KW = ("造价", "结算", "工程", "索赔", "变更", "签证", "优先受偿", "仲裁",
       "调解", "鉴定", "合同", "招标", "工期", "施工", "价款", "司法解释")

#: 主词空手时的备选 SERP 词 (官方站点长尾)
ALT_QUERIES: dict[str, list[str]] = {
    "zcf2026": ["仲裁法 2025修订 全文 npc.gov.cn"],
    "zcjszxpgx": ["法释 2018 5号 仲裁裁决执行 全文 court.gov.cn"],
    "mfd": ["民法典 全文 2020 人大 npc.gov.cn"],
    "zbtbf": ["招标投标法 2017修正 全文 gov.cn 政策"],
    "bxzbgc": ["必须招标的工程项目规定 2018 第16号令 全文 ndrc"],
    "rmtjf": ["人民调解法 2010 主席令 全文 gov.cn",
              "中华人民共和国人民调解法 全文 中国人大网"],
    "jsjsh": ["建设工程价款结算暂行办法 369号 全文 mof.gov.cn",
              "财政部 建设部 价款结算 暂行办法 全文",
              "建设工程价款结算暂行办法 全文 建设工程"],
    "sfbw": ["GF-2017-0201 建设工程施工合同 示范文本 住建部 全文",
             "建设工程施工合同示范文本 2017 通用条款 全文"],
    "nmg": ["保障农民工工资支付条例 2020 国务院令 全文 gov.cn"],
    "zxqy": ["保障中小企业款项支付条例 2020 全文 gov.cn"],
    "msf": ["民事诉讼法 2023修正 全文 npc.gov.cn",
            "中华人民共和国民事诉讼法 全文"],
    "alss": ["最高人民法院 关于统一法律适用加强类案检索的指导意见 试行 全文 cqn",
             "最高人民法院 统一法律适用 类案检索 指导意见 试行 印发"],
    "dgax": ["最高法发布建设工程质量保护典型案例 2025 全文",
             "最高人民法院 发布 建设工程 典型案例 chinapeace",
             "人民法院案例库 首批 建设工程施工合同 裁判要旨 34件"],
    "jdsc": ["人民法院 委托鉴定 审查 规定 法 2021 117 全文",
             "最高人民法院 司法鉴定 委托鉴定 审查工作 规定"],
    "zjgd": ["最高人民法院 民事诉讼证据的若干规定 法释 2019 19号 全文",
             "民事诉讼证据 规定 2019 修改 全文"],
    "czps": ["最高人民法院 关于建设工程 档案 审计 答复",
             "最高法 审计结论 与 工程结算 答复 复函"],
    "jygl": ["建筑工程施工发包与承包计价管理办法 住建部令 第16号 全文",
             "住建部 计价管理办法 16号令 全文"],
    "gb51262": ["GB/T 51262-2017 建设工程造价鉴定规范 全文 免费阅读",
                "建设工程造价鉴定规范 51262 全文 造价站"],
    "gb50500": ["GB/T 50500-2024 建设工程工程量清单计价标准 发布 全文",
                "工程量清单计价标准 50500-2024 全文 住建部公告"],
}


def http_get(url: str, timeout: int = 30) -> tuple[int, str]:
    req = urllib.request.Request(url, headers={
        "User-Agent": UA, "Accept": "text/html,application/json,*/*",
        "Accept-Language": "zh-CN,zh;q=0.9"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        raw = r.read(3_000_000)
        code = r.status
    for enc in ("utf-8", "gb18030"):
        try:
            return code, raw.decode(enc)
        except UnicodeDecodeError:
            continue
    return code, raw.decode("utf-8", "replace")


def html2text(h: str) -> str:
    h = re.sub(r"(?is)<(script|style)[^>]*>.*?</\1>", " ", h)
    h = re.sub(r"(?s)<!--.*?-->", " ", h)
    h = re.sub(r"(?i)</(p|div|tr|li|h[1-6]|section|article)>", "\n", h)
    h = re.sub(r"(?i)<br\s*/?>", "\n", h)
    h = re.sub(r"(?s)<[^>]+>", "", h)
    h = htmllib.unescape(h)
    h = re.sub(r"[ \t\u3000]+", " ", h)
    h = re.sub(r"\n\s*\n+", "\n\n", h)
    return h.strip()


def campaign_kw_hit(text: str) -> bool:
    return any(k in text for k in _KW)


def find_urls(query: str, cli) -> list[str]:
    """SERP → 候选 URL 列表 (官方域在前)."""
    try:
        r = cli.search(query, max_results=8) or {}
    except Exception:                                       # noqa: BLE001
        return []
    res = (r.get("data") or {}).get("results") or []
    urls, off = [], []
    for h in res:
        u = str(h.get("url") or "")
        if not u.startswith("http") or u in urls or u in off:
            continue
        (off if any(d in u for d in OFFICIAL) else urls).append(u)
    return off + urls


def fetch_one(item, cli, dry: bool) -> dict:
    iid, query, fname, anchors, eei, cred = item
    variants = [query] + ALT_QUERIES.get(iid, [])
    rec = {"ts": time.strftime("%F %T"), "id": iid, "query": query,
           "eei": eei, "tried": []}
    for qi, q in enumerate(variants):
        for url in find_urls(q, cli)[:4]:
            rec["tried"].append(url[:90])
            if dry:
                rec["result"] = "dry"
                return rec
            try:
                code, html = http_get(url)
            except Exception as e:                          # noqa: BLE001
                rec["tried"][-1] += f" ERR:{type(e).__name__}"
                continue
            text = html2text(html)
            tch = len(re.sub(r"\s", "", text))
            if tch < 1200:
                rec["tried"][-1] += f" short:{tch}"
                continue
            if not all(a in text for a in anchors):
                rec["tried"][-1] += " anchor_miss"
                continue
            if not campaign_kw_hit(text):
                rec["tried"][-1] += " kw_miss"
                continue
            fp = OUT / f"{fname}.md"
            fp.write_text(
                f"# {fname}\n\n> 来源: {url}\n> 抓取: "
                f"{time.strftime('%F %T')} (纯HTTP, e3_statute_fetcher)"
                f"\n> 信级: {cred}\n\n{text}",
                encoding="utf-8", newline="\n")
            rc = AP.ingest(CID, str(fp), engine="website:gov_statute",
                           url=url, cred=cred, tree=eei, stance="support",
                           band="gap")
            rec.update(result="ingested", file=str(fp), url=url,
                       http=code, text_chars=tch, variant=qi, ingest_rc=rc)
            return rec
        time.sleep(1.5)
    rec["result"] = "all_candidates_failed"
    return rec


#: 第二轮 (1031 冲门): 判词门感知定向 — 首轮 6 件法条全文因无战役判词
#: 被判 off_topic (如实), 本轮定向抓「原文+建工语境」页 (解读/答记者问/
#: 纪要/标准发布稿, 天然含判词) 补齐对应 E3 第二独立件。
PLAN2: list[tuple[str, str, str, list[str], str, str]] = [
    ("mfdq", "中华人民共和国民法典 全文 2020 gov.cn", "民法典全文官方版",
     ["民法典", "第二编"], "Q21-E3", "official"),
    ("bxzbb", "必须招标的工程项目规定 解读 发改委 合同效力",
     "必须招标规定解读建工语境", ["必须招标", "解读"], "Q20-E3", "research"),
    ("zxqyj", "保障中小企业款项支付条例 解读 工程款 逾期 利息",
     "中小企业款项支付条例解读工程款", ["中小企业", "逾期"], "Q22-E3",
     "research"),
    ("gb50500j", "GB/T 50500-2024 清单计价标准 解读 固定总价 结算 全文",
     "清单计价标准50500解读固定总价", ["清单计价", "固定总价"], "Q4-E3",
     "research"),
    ("sfdsj", "建设工程合同纠纷 司法大数据 专题报告 判例",
     "建工合同纠纷司法大数据报告", ["建设工程", "纠纷"], "Q3-E3",
     "research"),
    ("zbps", "九部委 标准施工招标文件 2007 通用条款 争议评审 全文",
     "标准施工招标文件争议评审通用条款", ["争议评审", "通用条款"], "Q24-E3",
     "research"),
    ("dqmt", "最高人民法院 民一庭 庭长 答记者问 建设工程施工合同 司法解释",
     "最高法民一庭庭长答记者问建工解释", ["答记者问", "施工合同"], "Q1-E3",
     "research"),
    ("sgrq", "建设工程施工合同 逾期不答复 视为认可 送审价 规定 全文",
     "逾期视为认可送审价规则文", ["视为认可", "送审"], "Q9-E3",
     "research"),
]
ALT_QUERIES.update({
    "mfdq": ["民法典 全文 中国政府网 公告", "中华人民共和国民法典 全文 人大网"],
    "bxzbb": ["必须招标的工程项目规定 16号令 解读 建设工程",
              "必须招标 规定 全文 附 解读 工程建设项目"],
    "zxqyj": ["保障中小企业款项支付条例 建设领域 解读 全文"],
    "gb50500j": ["2024清单计价标准 解读 住建部 公告 全文",
                 "建设工程工程量清单计价标准 解析 全文"],
    "sfdsj": ["中国司法大数据研究院 建设工程 纠纷 报告",
              "建设工程施工合同纠纷 大数据 分析 报告"],
    "zbps": ["标准施工招标文件 2007年版 通用条款 争议评审 全文",
             "2007标准施工招标文件 通用条款 全文"],
    "dqmt": ["陈宜芳 答记者问 建设工程施工合同司法解释 全文",
             "最高法 民一庭 建工司法解释 发布 答记者问"],
    "sgrq": ["建设工程价款结算 暂行办法 逾期 视为认可 全文",
             "施工合同 逾期未答复 视为认可 条款 解读"],
})


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--plan2", action="store_true",
                    help="跑第二轮判词门感知定向计划")
    ap.add_argument("--only", default="")
    ns = ap.parse_args()
    only = {x for x in ns.only.split(",") if x}
    plan = PLAN2 if ns.plan2 else PLAN
    OUT.mkdir(parents=True, exist_ok=True)
    cli = AnySearchClient()
    n_ok = 0
    with LEDGER.open("a", encoding="utf-8") as lf:
        lf.write(json.dumps({"ts": time.strftime("%F %T"),
                             "phase": "round2" if ns.plan2 else "round1",
                             "targets": len(plan)},
                            ensure_ascii=False) + "\n")
        for item in plan:
            if only and item[0] not in only:
                continue
            rec = fetch_one(item, cli, ns.dry)
            lf.write(json.dumps(rec, ensure_ascii=False) + "\n")
            ok = rec.get("result") == "ingested"
            n_ok += int(ok)
            print(f"  [{'+' if ok else '×'}] {item[0]:<10s} → {item[4]} "
                  f"{rec.get('result','')} "
                  f"{rec.get('text_chars', 0):>8,}字 {rec.get('url','')[:60]}",
                  flush=True)
            time.sleep(2)
    print(f"[statute] 入池 {n_ok}/{len(PLAN)} (判层留 judge)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
