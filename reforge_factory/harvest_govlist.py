# -*- coding: utf-8 -*-
"""harvest_govlist — 政府名录/公示/处罚通报收割腿 (1015 BID26 四面补采 · govlist 渠道).

链路: GovListChannel 基座 (ResearchFactory-Eng/engineering-research.skill/
  scripts/channels/gov_list_channel.py, "声明 SITES 即成渠道") → 三站 BID26
  相关列表页 (住建部官网 / 全国公共资源交易平台 / 中国政府采购网·政采动态)
  → 提取 (标题,链接) → 双重相关门 (标题命中面词 ∧ 命中域词, 缺一不入)
  → 条目详情页 → strip_page_chrome 清洗 → 落
  data/harvest/govlist/EPC-BID26/*.md (>300 实字, 非 SER 形)。

纪律:
  1. 绝不 import ammo_pool / 绝不写 ammo_pool — 本腿只产文件与台账;
  2. 双重相关门 + gate_decision 质量门 (错误页/百科页/正文过短全拒, 留痕);
  3. engine=govlist:<站> (C 轴 resolve_engine 子串命中 govlist 渠道),
     cred=official, tree 按 标题面词 → Q21/Q22/Q25/Q26(+Q1/Q5 兜底) EEI,
     处罚/违规/失信类自动挂对应面 E2 (against 槽);
  4. 串行 + 每详情页 1s 礼貌间隔, 单站超时即跳 (gov 站免打扰);
  5. 限流/失败/零结果如实计入 blockers, 绝不凑数。

用法: py reforge_factory/harvest_govlist.py --campaign EPC-BID26 [--dry] [--max 15]
"""
from __future__ import annotations

import argparse
import html as _html
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
CH_DIR = (REPO / "ResearchFactory-Eng" / "engineering-research.skill"
          / "scripts" / "channels")
sys.path.insert(0, str(CH_DIR))
sys.path.insert(0, str(CH_DIR.parent))
from gov_list_channel import GovListChannel, _get, _make_session  # noqa: E402
from collect_gate import gate_decision                            # noqa: E402

# ---- 站点清单 (2026-10-15 探活: 三站 requests 直连 200 且列表 SSR) ----
# mohurd 栏目页为 JS 壳 → 用官网首页 (62KB SSR) + art 文章链接过滤;
# ggzy 首页直出监管政策 /SIC/web/details.po 条目; ccgp 政采动态列表页。
SITES: list[dict] = [
    {"name": "住建部", "url": "https://www.mohurd.gov.cn/",
     "link_pattern": r"art_[0-9a-f]{6,}", "engine": "govlist:mohurd"},
    {"name": "全国公共资源交易平台", "url": "https://www.ggzy.gov.cn/",
     "link_pattern": r"/SIC/web/details\.po\?id=", "engine": "govlist:ggzy"},
    {"name": "中国政府采购网", "url": "http://www.ccgp.gov.cn/zxdt/index.htm",
     "link_pattern": r"t\d{8}_\d+\.htm", "engine": "govlist:ccgp"},
]

# ---- 双重相关门 ----
# 面词 (BID26 四面 + 名录/公示/处罚形态词)
FACE_RE = re.compile(
    r"评标专家|评标委员会|专家库|招标师|造价工程师|建造师|从业|职业资格|注册"
    r"|资质|招标代理|代理机构|采购代理|公共资源交易|交易平台|采购平台"
    r"|电子招投标|电子保函|盲评|暗标|远程异地|名录|公示|处罚|通报|失信|违规"
    r"|整治|信用|人工智能|数字化|招标投标|评标")
# 域词 (任务契约第 6 条原文)
DOMAIN_RE = re.compile(r"招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链")

# 面词 → 树槽 (govlist 主槽 Q21/Q22, 渠道生态 Q25/Q26, 兜底 Q1/Q5)
TREE_RULES: list[tuple[str, str]] = [
    (r"评标专家|评标委员会|专家库", "Q22-E1"),
    (r"招标师|造价工程师|建造师|从业|职业资格|注册|资质", "Q21-E1"),
    (r"人工智能|数字化|智能化|电子招投标|电子保函|评标系统", "Q19-E1"),
    (r"招标代理|代理机构|采购代理", "Q25-E1"),
    (r"公共资源交易|交易平台|采购平台|盲评|暗标|远程异地", "Q26-E1"),
    (r"统计|数据|名单|名录|清单|公报", "Q5-E1"),
]
AGAINST_RE = re.compile(r"处罚|通报|失信|违规|整治|吊销|暂停|整治")
MIN_SUBSTANTIVE = 300            # 契约: >300 字


def pick_tree(title: str) -> str:
    """标题 → EEI 槽: 面词规则匹配, 反面词 (处罚/失信) 挂同面 E2。"""
    for pat, slot in TREE_RULES:
        if re.search(pat, title):
            return slot.replace("-E1", "-E2") if AGAINST_RE.search(title) else slot
    return "Q1-E2" if AGAINST_RE.search(title) else "Q1-E1"


def _html2txt(s: str) -> str:
    """cleaned 残余标签剥除 + 实体还原 (md 可读性)。"""
    s = re.sub(r"<br\s*/?>|</p>|</div>|</tr>", "\n", s, flags=re.I)
    s = re.sub(r"<[^>]{1,300}>", " ", s)
    s = _html.unescape(s)
    s = re.sub(r"[ \t　]{2,}", " ", s)
    return re.sub(r"\n{3,}", "\n\n", s).strip()


def _safe_name(s: str) -> str:
    return "".join(c for c in s[:28] if c.isalnum() or "一" <= c <= "鿿") or "gov"


class BID26GovList(GovListChannel):
    """BID26 政府名录线渠道 — 声明 SITES 即成渠道 (基座复用)。"""
    SITES = SITES

    @property
    def name(self) -> str:
        return "govlist"

    def is_available(self) -> bool:
        return True


def run(cid: str, dry: bool = False, max_files: int = 15,
        per_site: int = 6) -> int:
    out_dir = REPO / "data" / "harvest" / "govlist" / cid
    # 独立收割腿无 ResearchFactory config → __new__ 跳过 BaseChannel.__init__
    # (只复用基座 _extract_links 列表提取, 质量门用 gate_decision 同源实现)
    ch = object.__new__(BID26GovList)
    session = _make_session()

    n_saved = n_skip = n_gate = 0
    records: list[dict] = []
    blockers: list[str] = []
    if not dry:
        out_dir.mkdir(parents=True, exist_ok=True)

    for site in SITES:
        html = _get(session, site["url"], timeout=15)
        if not html:
            blockers.append(f"{site['name']} 列表页不可达")
            print(f"[govlist] {site['name']} 列表页不可达", flush=True)
            continue
        links = ch._extract_links(html, site["url"], site)
        # 双重门在标题层: 面词 ∧ 域词 (缺一不入 — 不相关不入池)
        cands = [(u, t.strip()) for u, t in links
                 if FACE_RE.search(t) and DOMAIN_RE.search(t)]
        print(f"[govlist] {site['name']}: 链接 {len(links)} | 双门过 "
              f"{len(cands)}", flush=True)
        if not cands:
            blockers.append(f"{site['name']} 双门 0 命中")
            continue
        site_n = 0
        site_t0 = time.time()
        for url, title in cands[:per_site * 2]:
            if site_n >= per_site or n_saved >= max_files:
                break
            if time.time() - site_t0 > 210:       # 单站墙钟预算 (防慢站拖死)
                blockers.append(f"{site['name']} 单站 210s 预算耗尽 "
                                f"(落 {site_n} 件)")
                print(f"[govlist] {site['name']} 预算耗尽, 跳余下条目",
                      flush=True)
                break
            eei = pick_tree(title)
            if dry:
                print(f"  [dry] {site['engine']} {eei} {title[:50]}")
                site_n += 1
                n_saved += 1
                continue
            detail = _get(session, url)
            time.sleep(1.0)                    # 政府站礼貌间隔
            if not detail or len(detail) < 500:
                n_skip += 1
                blockers.append(f"详情页失败: {title[:24]}")
                continue
            d = gate_decision(title, detail, terms=(),
                              min_substantive=MIN_SUBSTANTIVE)
            if not d["save"]:
                n_gate += 1
                print(f"[gate:govlist] 拒 {title[:36]}: {d['reason']}",
                      flush=True)
                continue
            body = _html2txt(d["cleaned"])
            fp = out_dir / (_safe_name(f"{site['name']}_{title}") + ".md")
            head = (f"# {title}\n\n> 来源: {site['name']}官网  \n> URL: {url}"
                    f"  \n> 采集: harvest_govlist | engine={site['engine']}"
                    f" | tree={eei} | cred=official\n\n")
            fp.write_text(head + body + "\n", encoding="utf-8")
            records.append({"file": str(fp), "url": url,
                            "engine": site["engine"], "tree": eei,
                            "cred": "official"})
            site_n += 1
            n_saved += 1
            print(f"[govlist] + {site['engine']} {eei} {title[:44]}",
                  flush=True)

    if not dry and records:
        (out_dir / "records.jsonl").write_text(
            "\n".join(json.dumps(r, ensure_ascii=False) for r in records),
            encoding="utf-8")
    print(f"[govlist] {'DRY' if dry else 'APPLY'}: 落盘 {n_saved} | 质量门拒 "
          f"{n_gate} | 详情失败/跳过 {n_skip} | blockers "
          f"{len([b for b in blockers if '不可达' in b or '双门' in b])}")
    for b in blockers[:6]:
        print(f"  [blocker] {b}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="政府名录/公示/处罚通报收割腿 (govlist)")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--max", type=int, default=15)
    ns = ap.parse_args()
    return run(ns.campaign, ns.dry, ns.max)


if __name__ == "__main__":
    sys.exit(main())
