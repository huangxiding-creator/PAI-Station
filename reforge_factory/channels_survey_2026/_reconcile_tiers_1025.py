# -*- coding: utf-8 -*-
"""1025 渠道普查注册表终局调和 (两级判差修复)

判差背景: 22:06 八路全量重建脚本的自动分级把原425条精判(A142/B96/C181/D6)冲掉
(现 A45/B93/C479/D3), 且新并入 ~195 条未判级。本脚本:
  ① 恢复原425条精判 — 权威源 _ab_entries_tmp.json (238条A/B原判+dedup_key) +
     svc:键吸收映射 (重建时 svc: 命名空间键塌缩成 gh:/dom:/name: 键, 按URL/名称
     确定性回映射) + 6条D名单 + 其余= C
  ② 新并入 218 纯新条目按 access 字段实判 (A=免登录API/CLI/免key可直采 /
     B=需key或注册或数据集形态登记可用 / C=自托管引擎框架方法论资产 / D=纯无关),
     脚本粗判只作参考; enterprise 7个实测200免key API / paidfree 平替族 /
     searchengines 免key引擎族 纠偏为 A/B
  ③ 写回 MASTER_REGISTRY.json (每条 tier + tier_basis) 并更新 stats
用法: _reconcile_tiers_1025.py [--dry]   (dry=只出评审清单不写回)
"""
from __future__ import annotations
import json, re, sys, io
from pathlib import Path
from collections import Counter

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).resolve().parent
REG = HERE / "MASTER_REGISTRY.json"
AB = HERE / "_ab_entries_tmp.json"
DRY = "--dry" in sys.argv

ORIG_LANES = {"sweep_localregistry", "数据集/学术文献/专利/标准/统计门户",
              "sweep_topic_hn", "deepresearch-agents-and-orchestration"}
NEW_LANES = {"enterprise", "paidfree_free_equiv", "sweep_osint_geo",
             "sweep_searchengines（搜索引擎/元搜索/SERP API/免登录检索API族清扫路）"}

# ---------- 原案 6 条 D 名单 (原注册表 D 级, 集成台账/原建表脚本在案) ----------
D_KEYS = {"gh:mikf/gallery-dl", "dom:prices.eu.org", "gh:freecodecamp/devdocs",
          "dom:yimeizhushou.com", "dom:ai.wps.cn", "dom:shiliu.ai"}

# ---------- enterprise 路 7 个实测 200 免key API (sweep_enterprise notes 明文在案) ----------
# (SEC EDGAR / 世行项目API v2 / USAspending / 上交所query / 深交所api / 巨潮POST / 政采search POST)
ENT_A_KEYS = {"dom:efts.sec.gov", "dom:projects.worldbank.org", "dom:sse.com.cn",
              "dom:szse.cn", "dom:cninfo.com.cn", "dom:ccgp.gov.cn"}
# USAspending(dom:usaspending.gov) 与原425条合并, 走原判恢复, 不在此列。

def norm_url(u):
    if not u:
        return None
    u = u.strip()
    if u.startswith("tool://"):
        return "tool:" + u[7:].strip("/").lower()
    m = re.match(r"^https?://([^/]+)(/[^\s]*)?", u)
    if not m:
        return None
    host = m.group(1).lower()
    path = (m.group(2) or "").strip("/")
    host_n = re.sub(r"^(www|api|export)\.", "", host)
    for fh, pre in (("github.com", "gh"), ("gitlab.com", "gl")):
        if host_n == fh and path:
            seg = [s for s in path.split("/") if s and not s.endswith(".git")]
            if len(seg) >= 2:
                return pre + ":" + seg[0].lower() + "/" + seg[1].lower()
    return "dom:" + host_n

def nname(s):
    return re.sub(r"[\s（）()【】\[\]·:：,，.。/\\\-—|]+", "", str(s)).lower()

# ---------- 载入 ----------
reg = json.loads(REG.read_text(encoding="utf-8"))
ents = reg["entries"]
bykey = {e["dedup_key"]: e for e in ents}
byname = {}
for e in ents:
    byname.setdefault(nname(e["name"]), []).append(e)
ab = json.loads(AB.read_text(encoding="utf-8"))
abmap = {e["dedup_key"]: e["tier"] for e in ab}          # 238 原判 A/B (dedup_key=原svc:/gh:/dom:键)
assert Counter(abmap.values()) == {"A": 142, "B": 96}, "ab 临时件口径异常"

# ---------- ① svc: 键吸收映射 (43条) ----------
absorb: dict[str, list[str]] = {}     # 现键 -> [原svc键名...]
svc_remap = {}
for abe in ab:
    k = abe["dedup_key"]
    if k in bykey:
        continue
    hit = None
    k2 = norm_url(abe.get("entry", ""))
    if k2 and k2 in bykey:
        hit = bykey[k2]
    if hit is None:
        cands = [x for x in byname.get(nname(abe["name"]), [])
                 if set(x["source_lanes"]) & ORIG_LANES]
        if cands:
            hit = cands[0]
    assert hit is not None, "svc 吸收映射未解: " + abe["name"]
    svc_remap[k] = hit["dedup_key"]
    absorb.setdefault(hit["dedup_key"], []).append(k)
assert len(svc_remap) == 43, f"svc remap {len(svc_remap)} != 43"

# ---------- ② 原判恢复 (orig-lane 条目) ----------
def orig_tier(e):
    """返回 (tier, basis) 或 None(非原案条目)"""
    if not (set(e["source_lanes"]) & ORIG_LANES):
        return None
    cands = []                                     # 该现条目承载的原判
    if e["dedup_key"] in abmap:
        cands.append(abmap[e["dedup_key"]])
    cands += [abmap[k] for k in absorb.get(e["dedup_key"], [])]
    if cands:
        best = "A" if "A" in cands else ("B" if "B" in cands else cands[0])
        note = "原案精判恢复" + ("(含svc吸收%d条)" % len(cands) if len(cands) > 1 else "")
        return best, note
    if e["dedup_key"] in D_KEYS:
        return "D", "原案D名单恢复"
    return "C", "原案C恢复(方法论资产, 归并员精判)"

# ---------- ③ 新并入条目 access 实判 ----------
NEED_KEY = re.compile(r"需key|需 key|需注册|免费注册|注册账号|需账号|需订阅|订阅\(|付费|购买|会员|积分|需申请|需登录")
FREE_API = re.compile(r"免登录API|免费API|免登录接口|免key API|Instant Answer|RSS|FDSN|CKAN|SDMX|SPARQL|Overpass|检索API|索引API|/json|json/|API\(限速\)|免登录API\(限速")
FREE_DATA = re.compile(r"免登录下载|数据集\(免登录|公开数据文件|PDF直下|数据文件下载|数据下载|免登录CSV|S3/Azure免登录|GCS免登录|GitHub分发")
FREE_LIB = re.compile(r"开源库\(|pip安装|免费接口|非官方公开")
FREE_PAGE = re.compile(r"免登录网页|免登录检索|免费页面|浏览器|免登录\)")
SELFHOST_ONLY = re.compile(r"^自托管|自托管\(本地|自托管/公共实例|自托管/参与")
AWESOME = re.compile(r"awesome|OSINT Framework|Public APIs|Toolkit|清单|目录形态")

# 明细纠偏表 (规则难覆盖的逐条裁决, 判据=access 实文; 键=dedup_key 精确匹配)
OVERRIDE_NEW = {
    # searchengines: 公共免key面 vs 纯自托管
    "name:Bing": "B",             # RSS仅新闻面(独立条目A), 通用搜索API已退役勿登记 → 网页面B
    "name:SearXNG": "A",          # 与原案 SearXNG(gh) 同项目同判 A(公共实例+JSON)
    "name:百度": "A",              # 免登录网页(可HTTP复刻) + baidu-serp-api 原案A同源
    "name:搜狗(含微信垂直)": "A",   # 微信垂直已复刻API化(sogou_weixin_api.py 免key)
    "name:zh-search-pro(本仓技能资产)": "A",  # 免登录URL模板, 与原案 zh-search-pro 同判
    "name:LibreY": "B",           # 公共实例(浏览器)面在, 自托管另案
    "name:RSSHub": "B",           # 公共实例面在, 自托管另案
    "name:4get": "B",             # 4get.ca 公共实例免登录网页
    # osint_geo
    "dom:openownership.org": "A",   # 免费数据集下载+免登录网页
    "dom:fao.org": "A",             # AQUASTAT 浏览器(免登录)+数据集
    "dom:globalenergymonitor.org": "B",  # 浏览器+数据集(部分需注册)
    "dom:open-contracting.org": "B",     # 组织面(OCDS注册表另案A)
    "dom:espacenet.com": "B",       # OPS API需免费key
    # paidfree
    "dom:data.eastmoney.com": "B",  # 免费页面+部分公开XHR(页面为主)
    "dom:pkulaw.com": "B",          # 免费面(部分), 深度面付费
    "gh:waditu/tushare": "B",       # 免费注册积分面
    "dom:hq.sinajs.cn": "A",        # 免费接口(非官方公开, 需Referer) 免key直取
    "dom:qt.gtimg.cn": "A",         # 同上
    "gh:akfamily/akshare": "A",     # 开源库(pip, 聚合免费源) 免key直采
    "gh:micro-sheep/efinance": "A", # 开源库
    "dom:shfe.com.cn": "A", "dom:dce.com.cn": "A", "dom:czce.com.cn": "A",
    "dom:cffex.com.cn": "A", "dom:yield.chinabond.com.cn": "A",  # 公开数据文件直下
    "dom:opec.org": "A", "dom:miga.org": "A",                     # 出版物PDF直下
    "dom:mofcom.gov.cn": "A",        # 国别指南PDF直下
    "dom:investmentpolicy.unctad.org": "A",  # 免费页面+数据下载
    "dom:www1.hkexnews.hk": "B",    # 免费页面 (enterprise路同判)
    "dom:hkexnews.hk": "B",
    "dom:data.sh.gov.cn": "A",      # 浏览器(免登录)+数据集
    # enterprise (除 ENT_A_KEYS 外其余走规则= B: 免费面+付费面/注册/浏览器/网页面)
}

def new_tier(e):
    if e.get("existing_match"):
        return "A", "现役确认(existing_match)"
    k = e["dedup_key"]
    if k in ENT_A_KEYS:
        return "A", "enterprise路实测200免key API(sweep notes在案)"
    if k in OVERRIDE_NEW:
        return OVERRIDE_NEW[k], "access实判·明细纠偏表"
    acc = str(e.get("access", ""))
    if NEED_KEY.search(acc) and not FREE_API.search(acc) and not FREE_DATA.search(acc):
        return "B", "access实判(需key/注册/付费面)"
    if FREE_API.search(acc) or FREE_LIB.search(acc) or FREE_DATA.search(acc):
        return "A", "access实判(免登录API/库/数据直下)"
    if AWESOME.search(acc) or AWESOME.search(e["name"]):
        return "B", "access实判(目录/清单形态)"
    if SELFHOST_ONLY.search(acc) or "自托管" in acc and not FREE_PAGE.search(acc):
        return "C", "access实判(自托管/方法论资产)"
    if FREE_PAGE.search(acc) or "检索" in acc or "网页" in acc:
        return "B", "access实判(免登录网页/浏览器面登记)"
    return "C", "access实判兜底(引擎/基建)"

# ---------- 执行 ----------
n_orig = n_new = 0
placement_fail = []
for e in ents:
    r = orig_tier(e)
    if r:
        e["_tier"], e["_basis"] = r
        n_orig += 1
    else:
        e["_tier"], e["_basis"] = new_tier(e)
        n_new += 1

# 原案 A/B 238 条落位校验 (每条原判都必须落在一个现条目上)
placed = {}
for e in ents:
    if e["dedup_key"] in abmap:
        placed[e["dedup_key"]] = True
    for k in absorb.get(e["dedup_key"], []):
        placed[k] = True
missing_ab = [k for k in abmap if k not in placed]
assert not missing_ab, "原判A/B未落位: %d %s" % (len(missing_ab), missing_ab[:5])

dist_all = Counter(e["_tier"] for e in ents)
dist_orig = Counter(e["_tier"] for e in ents if set(e["source_lanes"]) & ORIG_LANES)
dist_new = Counter(e["_tier"] for e in ents if not (set(e["source_lanes"]) & ORIG_LANES))
print("orig-lane:", n_orig, dict(dist_orig))
print("new-lane :", n_new, dict(dist_new))
print("ALL 620  :", dict(dist_all), "| sum:", sum(dist_all.values()))
print("svc absorb map:", len(svc_remap), "| dom:github.com 承载原条目:",
      len(absorb.get("dom:github.com", [])) + 1)

if DRY:
    out = io.open(HERE / "_recon_dry.txt", "w", encoding="utf-8")
    out.write("== NEW-LANE 218 条实判评审清单 ==\n")
    for e in ents:
        if set(e["source_lanes"]) & ORIG_LANES:
            continue
        out.write("%s | %-46s | %-58s | %s\n" % (
            e["_tier"], e["name"][:44], str(e.get("access", ""))[:56], e["_basis"]))
    out.write("\n== ORIG-LANE 恢复抽检 (非C的) ==\n")
    for e in ents:
        if (set(e["source_lanes"]) & ORIG_LANES) and e["_tier"] != "C":
            out.write("%s | %-40s | %s\n" % (e["_tier"], e["name"][:38], e["_basis"]))
    out.close()
    print("DRY 模式: 评审清单 -> _recon_dry.txt; 未写回")
    sys.exit(0)

# ---------- 写回 ----------
now = "2026-10-25 22:40 UTC"
for e in ents:
    e["tier"] = e["_tier"]
    e["tier_basis"] = e["_basis"]
    del e["_tier"], e["_basis"]

new_only = [e for e in ents if not e.get("existing_match")]
reg["stats"]["by_tier_all"] = {t: dist_all.get(t, 0) for t in ("A", "B", "C", "D")}
reg["stats"]["by_tier_new_only"] = {t: sum(1 for e in new_only if e["tier"] == t)
                                    for t in ("A", "B", "C", "D")}
reg["tier_reconciliation"] = {
    "date": "2026-10-25",
    "cause": "22:06 八路sweep全量重建的自动分级冲掉原425条精判(A142/B96/C181/D6)+新并入218条未判级",
    "method": "①原判恢复: _ab_entries_tmp.json 238条A/B原判(dedup_key直配195+svc:键吸收映射43, 全落位) + 6条D名单 + 其余orig-lane=C; ②新并入218条access实判(enterprise 7实测200免keyAPI=A, paidfree平替/searchengines免key引擎族纠偏A/B); 脚本粗判仅参考",
    "orig_lane_entries": n_orig,
    "new_lane_entries": n_new,
    "orig_tier_restored": dict(dist_orig),
    "new_lane_tier": dict(dist_new),
    "known_damage": "重建塌缩键: dom:github.com 吸收17条原svc:聚合条目(RSS舰队/opencli舰队/rion微信/KB-HARVEST/NB MD/GovList线/本地文件库/微信本地数据/媒体情报组/官网爬虫/工商金融注册表线/政策法规线/电子书渠道族/兄弟院站册线/古德白/EngOpp-Mining), tier按原判A整体恢复, 条目拆分留主会话裁定",
    "svc_absorb_map": svc_remap,
}
reg["inputs"] = ["sweep_datasets.json(72)", "sweep_deepresearch.json(106)",
                 "sweep_localregistry.json(180)", "sweep_topic_hn.json(112)",
                 "sweep_enterprise.json(56)", "sweep_paidfree.json(61)",
                 "sweep_searchengines.json(78)", "sweep_osint_geo.json(81)"]
reg["_doc"] += "; 1025终局调和: 原案精判恢复+新并入access实判(tier_basis逐条在案)"
reg["generated"] = now
json.dump(reg, io.open(REG, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("写回完成:", REG.name)
