# -*- coding: utf-8 -*-
"""harvest_zh_search_pro — zh_search_pro 免key中文检索收割腿 (C 轴渠道).

链路: .claude/skills/zh-search-pro/scripts/search.py (curl_cffi impersonate,
免key多引擎) 面词查询出 URL 清单 (SERP 清单本身只作路标, 不入池) → 按权威度
排序选 URL → urllib/ProxyHandler({}) 直取网页全文 (绕代理, 失败跳过, 备胎
curl_cffi) → 双重相关门 (标题命中面词 ∧ 标题/正文命中域词 ∧ >300字非SERP)
→ 落 data/harvest/zh_search_pro/<cid>/*.md + _records_zh_search_pro.json。

纪律:
  1. 绝不 import / 写 ammo_pool — 本腿只产文件 (收割编排方自取);
  2. engine 标签含渠道 id: zh_search_pro:<引擎键>;
  3. 串行 + 礼貌间隔 (查询 1.3s / 抓取 1.6s) + 连续 6 次抓取失败即停 (账号安全);
  4. 限流/验证码/零结果=如实报 blockers, 绝不凑数; 免key渠道无密钥可泄;
  5. 相关门: 标题命中面词正则 ∧ 标题命中域词 ∧ 正文命中域词 ∧ 正文>300字。

用法: py reforge_factory/harvest_zh_search_pro.py --campaign EPC-BID26
        [--max-files 14] [--dry] [--limit-queries N] [--engines bing_cn]
"""
from __future__ import annotations

import argparse
import base64
import html as html_mod
import importlib.util
import json
import re
import sys
import time
import urllib.request
from pathlib import Path
from urllib.parse import urlparse

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
SKILL = (REPO / ".claude" / "skills" / "zh-search-pro" / "scripts" / "search.py")
OUT_BASE = REPO / "data" / "harvest" / "zh_search_pro"

# (查询词, 备胎查询, 面, 面词正则, 目标 EEI) — 四面优先, 域词兜底.
# 1015 实测病理: 必应中国对"概念长词/泛词面"降级为诱饵结果 (查Bing自己/词典/
# 无关实体), 对"精确法规全名/实体名"稳定直给 gov.cn 原文 → 全部用实测金查询,
# 备胎同型. 已实测降级放弃: 世界银行采购/互联网+招标采购/智慧评标/远程异地
# 评标/工程总承包管理办法(泛) — 详见 blockers 如实报.
PLAN: list[tuple[str, str, str, str, str]] = [
    ("FIDIC银皮书", "FIDIC合同条件", "国际对标",
     r"FIDIC|菲迪克|银皮书|红皮书", "Q23-E1"),
    ("FIDIC合同条件", "FIDIC 合同", "国际对标",
     r"FIDIC|菲迪克", "Q23-E1"),
    ("对外承包工程项目备案和立项管理办法", "对外承包工程", "国际对标",
     r"对外承包|备案|立项|海外工程|国际工程", "Q24-E1"),
    ("对外承包工程", "对外承包工程管理条例", "国际对标",
     r"对外承包|海外工程|国际工程", "Q24-E1"),
    ("评标委员会和评标方法暂行规定", "评标专家和评标专家库管理暂行办法",
     "技术方案", r"评标委员会|评标方法|评标专家", "Q18-E1"),
    ("电子招投标", "BIM招投标", "技术方案",
     r"电子招投标|电子招标|BIM|建筑信息模型|电子保函", "Q19-E1"),
    ("BIM招投标", "BIM 招投标应用", "技术方案",
     r"BIM|建筑信息模型", "Q19-E1"),
    ("标准施工招标文件", "标准设备采购招标文件", "技术方案",
     r"标准[^\s]{0,6}招标文件|标准文件|九部委", "Q20-E1"),
    ("简明标准施工招标文件", "标准勘察设计招标文件", "技术方案",
     r"标准[^\s]{0,6}招标文件|标准文件", "Q20-E1"),
    ("评标专家和评标专家库管理暂行办法", "评标专家库", "组织人事",
     r"评标专家|专家库", "Q21-E1"),
    ("造价工程师", "注册造价工程师", "组织人事",
     r"造价工程师|造价师|工程造价", "Q21-E1"),
    ("中国招标投标协会", "招标投标协会", "组织人事",
     r"招标投标协会|行业协会|CTBA", "Q22-E1"),
    ("招标代理机构", "工程建设项目招标代理机构管理暂行办法", "渠道生态",
     r"招标代理|代理机构", "Q25-E1"),
    ("政府采购代理机构管理暂行办法", "政府采购代理机构", "渠道生态",
     r"政府采购|代理机构", "Q25-E1"),
    ("公共资源交易平台管理暂行办法", "公共资源交易平台", "渠道生态",
     r"公共资源交易|交易平台", "Q26-E1"),
    ("中国招标投标公共服务平台", "招标投标公共服务平台", "渠道生态",
     r"公共服务平台|交易平台|公共资源交易", "Q26-E1"),
    ("房屋建筑和市政基础设施项目工程总承包管理办法", "工程总承包管理办法 建市",
     "域词兜底", r"工程总承包|总承包|EPC", "Q1-E1"),
    ("招标投标统计", "全国招标投标数据", "域词兜底",
     r"统计|数据|报告", "Q5-E1"),
]
DOMAIN_RE = re.compile(r"招标|投标|评标|工程|EPC|采购|承包|造价|FIDIC|BIM|供应链")
CHROME_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
             "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
TAG_RE = re.compile(r"<[^>]+>|<!--.*?-->", re.S)
NOISE_RE = re.compile(
    r"<(script|style|nav|header|footer|aside)[^>]*>.*?</\1>|<svg[^>]*>.*?</svg>",
    re.S | re.I)

QUERY_SLEEP = 1.3
FETCH_SLEEP = 1.6
PER_EEI_CAP = 2
FETCH_FAIL_STOP = 6


def load_skill():
    spec = importlib.util.spec_from_file_location("zhsp_search", SKILL)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def cjk_len(s: str) -> int:
    return sum(1 for ch in s if "一" <= ch <= "鿿")


def unwrap_bing(url: str) -> str:
    """bing 有时包 /ck/a?...&u=a1<base64> 跳转链 — 解出直链."""
    if "/ck/a" not in url:
        return url
    m = re.search(r"[?&]u=a1([^&]+)", url)
    if not m:
        return url
    try:
        pad = m.group(1) + "=" * (-len(m.group(1)) % 4)
        raw = base64.urlsafe_b64decode(pad).decode("utf-8", "replace")
        return raw if raw.startswith("http") else url
    except Exception:
        return url


def host_rank(url: str) -> int:
    """权威度排序: gov.cn 最优, weixin 次之(公众号长文), org/edu 再次."""
    h = (urlparse(url).hostname or "").lower()
    if h.endswith(".gov.cn") or h == "gov.cn":
        return 0
    if h == "mp.weixin.qq.com" or h.endswith(".weixin.qq.com"):
        return 1
    if h.endswith((".org.cn", ".edu.cn", ".ac.cn")):
        return 2
    return 3


def host_cred(url: str, title: str) -> str:
    h = (urlparse(url).hostname or "").lower()
    if h.endswith(".gov.cn"):
        return "official"
    if h.endswith((".org.cn",)) or "协会" in title:
        return "official"                      # 行业协会 = 半官方权威
    if h.endswith((".edu.cn", ".ac.cn")) or "学报" in title or "期刊" in title:
        return "research"
    return "media"


def fetch_html(url: str) -> str:
    """urllib 直取 (ProxyHandler({}) 绕代理); 失败备胎 curl_cffi impersonate."""
    try:
        req = urllib.request.Request(url, headers={
            "User-Agent": CHROME_UA,
            "Accept-Language": "zh-CN,zh;q=0.9",
            "Accept": "text/html,application/xhtml+xml,*/*;q=0.8",
        })
        opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
        with opener.open(req, timeout=20) as resp:
            raw = resp.read()
            enc = "utf-8"
            m = re.search(rb"charset=[\"']?([\w-]+)", raw[:2000], re.I)
            if m:
                enc = m.group(1).decode("ascii", "replace")
            return raw.decode(enc, "replace")
    except Exception:
        pass
    try:
        from curl_cffi import requests as cffi_requests
        r = cffi_requests.get(url, impersonate="chrome", timeout=20,
                              headers={"User-Agent": CHROME_UA,
                                       "Accept-Language": "zh-CN,zh;q=0.9"})
        if r.status_code == 200:
            return r.text
    except Exception:
        pass
    return ""


def html_to_text(page: str) -> tuple[str, str]:
    """(页面title, 正文纯文本); script/style/nav 先剥, 标签再剥, 实体还原."""
    mt = re.search(r"<title[^>]*>(.*?)</title>", page, re.S | re.I)
    title = html_mod.unescape(TAG_RE.sub("", mt.group(1))).strip() if mt else ""
    body = NOISE_RE.sub(" ", page)
    text = html_mod.unescape(TAG_RE.sub(" ", body))
    text = re.sub(r"[ \t\r\f ]+", " ", text)
    text = re.sub(r"\n\s*\n+", "\n", text)
    return title, text.strip()


SKIP_HOSTS = (                              # 文档预览站 (全文墙) / 登录墙站
    "doc88.com", "book118.com", "docin.com", "renrendoc.com", "taodocs.com",
    "max.book118", "wenku.baidu.com", "douyin.com", "weibo.com",
)
SKIP_EXT = (".pdf", ".doc", ".docx", ".xls", ".xlsx", ".zip", ".rar", ".jpg")


def _candidates(hits: list[dict], facet_re: str,
                seen_urls: set[str]) -> list[tuple[str, str]]:
    """双重门第一道 (标题面词 ∧ 标题域词) + 壳/首页/预览站过滤, 按权威度排序."""
    fre, dre = re.compile(facet_re), DOMAIN_RE
    out: list[tuple[str, str]] = []
    local_seen: set[str] = set()
    for h in hits:
        url = unwrap_bing(h["url"].strip())
        title = h["title"]
        host = (urlparse(url).hostname or "").lower()
        key = url.rstrip("/").lower()
        if (key in seen_urls or "weixin.sogou.com" in url
                or "/search?" in url or urlparse(url).path in ("", "/")
                or url.lower().endswith(SKIP_EXT)
                or any(s in host for s in SKIP_HOSTS)):
            continue                                   # 跳转壳/首页/SERP/二进制/预览站
        if not (fre.search(title) and dre.search(title)):
            continue
        if key in local_seen:
            continue
        local_seen.add(key)
        out.append((url, title))
    out.sort(key=lambda c: host_rank(c[0]))
    return out


def run(cid: str, engines: list[str], max_files: int, dry: bool,
        limit_queries: int) -> int:
    skill = load_skill()
    out_dir = OUT_BASE / cid
    out_dir.mkdir(parents=True, exist_ok=True)
    plan = PLAN[:limit_queries] if limit_queries else PLAN
    records: list[dict] = []
    blockers: list[str] = []
    n_search_hit = n_gate_skip = n_fetch_fail = consec_fail = 0
    seen_urls: set[str] = set()
    eei_n: dict[str, int] = {}
    stopped = False
    rec_fp = out_dir / "_records_zh_search_pro.json"
    if rec_fp.is_file():                      # 增量续跑: 已收 URL 不重复 (同 localfiles 纪律)
        try:
            records = json.loads(rec_fp.read_text(encoding="utf-8"))
            for r in records:
                seen_urls.add(r["url"].rstrip("/").lower())
                eei_n[r["tree"]] = eei_n.get(r["tree"], 0) + 1
            print(f"[zsp] 续跑基线: 已有 {len(records)} 件, EEI {eei_n}")
        except json.JSONDecodeError:
            records = []

    for qi, (q, alt, facet, facet_re, eei) in enumerate(plan):
        if stopped or len(records) >= max_files:
            break
        if eei_n.get(eei, 0) >= PER_EEI_CAP:
            continue
        if qi:
            time.sleep(QUERY_SLEEP)
        hits: list[dict] = []
        for ek in engines:
            if hits:
                time.sleep(QUERY_SLEEP)
            hits += skill.search_engine(ek, q, 8)
        cand = _candidates(hits, facet_re, seen_urls)
        if not cand and alt:                               # 主查询降级 → 备胎一次
            time.sleep(QUERY_SLEEP)
            hits = []
            for ek in engines:
                if hits:
                    time.sleep(QUERY_SLEEP)
                hits += skill.search_engine(ek, alt, 8)
            cand = _candidates(hits, facet_re, seen_urls)
        took = 0
        for url, title in cand:
            if len(records) >= max_files or eei_n.get(eei, 0) >= PER_EEI_CAP:
                break
            if took >= 2:
                break
            n_search_hit += 1
            key = url.rstrip("/").lower()
            if dry:
                print(f"  [dry] {eei} {facet} | {title[:44]} | {url[:72]}")
                took += 1
                seen_urls.add(key)
                continue
            page = fetch_html(url)
            if not page:
                n_fetch_fail += 1
                consec_fail += 1
                print(f"  [skip] 抓取失败: {title[:40]} | {url[:64]}")
                if consec_fail >= FETCH_FAIL_STOP:
                    blockers.append(
                        f"连续 {FETCH_FAIL_STOP} 次抓取失败 → 即停 (疑似出口被墙/限流)")
                    stopped = True
                    break
                continue
            consec_fail = 0
            ptitle, text = html_to_text(page)
            if (len(text) < 300 or not DOMAIN_RE.search(text)
                    or (cjk_len(text) < 150 and len(text) < 800)):
                n_gate_skip += 1
                print(f"  [skip] 正文门不过 ({len(text)}字): {title[:40]}")
                continue
            seen_urls.add(key)
            cred = host_cred(url, title)
            safe = re.sub(r'[\\/:*?"<>|\s]+', "_", title)[:44]
            fp = out_dir / f"{eei}_{safe}_{abs(hash(key)) % 99991:05d}.md"
            head = (f"# {title}\n\n> 来源: {url}\n> engine: "
                    f"zh_search_pro:{'+'.join(engines)} | tree: {eei} | "
                    f"cred: {cred} | 面: {facet}\n> 采集: "
                    f"harvest_zh_search_pro.py @ 2026-10-15 (SERP→直取全文)\n\n")
            fp.write_text(head + text, encoding="utf-8")
            records.append({"file": str(fp), "url": url,
                            "engine": f"zh_search_pro:{'+'.join(engines)}",
                            "tree": eei, "cred": cred})
            eei_n[eei] = eei_n.get(eei, 0) + 1
            took += 1
            print(f"  [ok] {eei} | {cred} | {len(text)}字 | {title[:40]}")
            time.sleep(FETCH_SLEEP)
        print(f"[zsp] '{q}' → 门过 {n_search_hit} | 累计件 {len(records)} "
              f"| 累计跳 {n_gate_skip} | 抓败 {n_fetch_fail}")

    if not dry:
        rec_fp.write_text(
            json.dumps(records, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[zsp] {'DRY' if dry else 'APPLY'}: 件 {len(records)} | 标题门过 "
          f"{n_search_hit} | 门跳 {n_gate_skip} | 抓败 {n_fetch_fail} | "
          f"EEI分布 {eei_n}")
    if blockers:
        for b in blockers:
            print(f"[zsp][blocker] {b}")
    print("=== RECORDS ===")
    print(json.dumps(records, ensure_ascii=False, indent=1))
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="zh_search_pro 免key检索收割腿")
    ap.add_argument("--campaign", default="EPC-BID26")
    ap.add_argument("--engines", default="bing_cn",
                    help="逗号分隔引擎键 (1015 实测仅 bing_cn 稳定)")
    ap.add_argument("--max-files", type=int, default=14)
    ap.add_argument("--dry", action="store_true")
    ap.add_argument("--limit-queries", type=int, default=0)
    ns = ap.parse_args()
    return run(ns.campaign, [k.strip() for k in ns.engines.split(",")],
               ns.max_files, ns.dry, ns.limit_queries)


if __name__ == "__main__":
    sys.exit(main())
