# -*- coding: utf-8 -*-
"""M1 DoD 批跑 v2：10 个种子需求 → 引擎蓝图 → wenku 免登录真灌（限速守卫版）→ 落档 seeds/。
v1 教训：3s 连发百次触发文库侧速度软拒（单发探针正常）→ v2 守卫：每种子只灌前3个L2组、
间隔 6s、种子间冷却 30s、空返熔断（单次30s重试→再空则本种子止损）。"""
import json, os, sys, time

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from kb_factory.catalog_engine.engine import build_blueprint
from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
from kb_factory.channel_adapters.enrich import enrich_blueprint

SEEDS = [
    {"domain": "律师事务所知识库", "keywords": ["诉讼", "合规", "合同审查"], "intent": "执业与团队培训", "size_hint": "small"},
    {"domain": "初中数学教师备课库", "keywords": ["备课", "教案", "中考"], "intent": "日常备课与教研", "size_hint": "small"},
    {"domain": "企业财务管理知识库", "keywords": ["财务分析", "预算", "税务"], "intent": "财务部工作参考", "size_hint": "small"},
    {"domain": "EHS安全管理知识库", "keywords": ["安全检查", "隐患排查", "应急预案"], "intent": "企业EHS管理", "size_hint": "small"},
    {"domain": "水利EPC工程知识库", "keywords": ["EPC", "水利水电", "总承包"], "intent": "项目部技术管理", "size_hint": "small"},
    {"domain": "工程项目管理P6知识库", "keywords": ["P6", "Primavera", "进度计划"], "intent": "计划工程师进阶", "size_hint": "small"},
    {"domain": "工程造价咨询知识库", "keywords": ["工程计量", "定额", "结算"], "intent": "造价员实务", "size_hint": "small"},
    {"domain": "跨境电商运营知识库", "keywords": ["选品", "listing", "广告投放"], "intent": "运营团队 SOP", "size_hint": "small"},
    {"domain": "科研课题组文献管理库", "keywords": ["文献综述", "实验记录", "基金申请"], "intent": "课题组知识沉淀", "size_hint": "small"},
    {"domain": "建筑施工安全知识库", "keywords": ["施工方案", "危大工程", "安全教育"], "intent": "安全员现场检查", "size_hint": "small"},
]

OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "seeds")
os.makedirs(OUT, exist_ok=True)
os.environ["KB_WENKU_MIN_INTERVAL"] = "6"  # v2：6s 间隔（v1=3s 连发触发速度软拒）
GROUPS_PER_SEED = 3
COOLDOWN_BETWEEN = 30
adapter = WenkuMetaAdapter()


def enrich_guarded(bp, seed_idx):
    """限速守卫式真灌：只灌前 GROUPS_PER_SEED 个 L2 组；空返→30s重试一次→再空止损。
    v2教训：L2 字段名是 name 不是 title（空查询词→全线空返，隐式字段假设翻车）。"""
    from kb_factory.channel_adapters.enrich import strip_numbering
    picked = []
    for l1 in bp["tree"].get("l1", []):
        for l2 in l1.get("l2") or []:
            picked.append(l2)
            if len(picked) >= GROUPS_PER_SEED:
                break
        if len(picked) >= GROUPS_PER_SEED:
            break
    filled = throttle_hits = 0
    for g in picked:
        q = strip_numbering(g.get("name") or g.get("theme") or "")[:20].strip()
        if not q:
            continue
        got = 0
        for attempt in (1, 2):
            try:
                items = adapter.metadata(q, limit=12)
            except Exception:
                items = []
            if items:
                got = len(items)
                slots = g.get("files", [])
                for i, meta in enumerate(items):
                    if i >= len(slots):
                        break
                    slots[i]["name"] = f"{meta.title}.{meta.fmt}"
                    slots[i]["badge"] = meta.badge
                    slots[i]["perm"] = meta.perm
                    if getattr(meta, "source_url", None):
                        slots[i]["url"] = meta.source_url
                filled += min(got, len(slots))
                break
            if attempt == 1:
                time.sleep(COOLDOWN_BETWEEN)  # 空返冷却后重试一次
        if got == 0:
            throttle_hits += 1
    return filled, throttle_hits


rows, fails = [], []
for i, seed in enumerate(SEEDS, 1):
    t0 = time.time()
    try:
        bp = build_blueprint(dict(seed))
        filled, throttled = enrich_guarded(bp, i)
        slug = seed["domain"].replace("知识库", "").replace("库", "")[:10]
        out = os.path.join(OUT, f"{i:02d}_{slug}.json")
        json.dump(bp, open(out, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
        gb = bp["stats"]["gb"]
        expect = round(29 + gb * 2, 1)
        ok_quote = abs(bp["quote"]["total"] - expect) < 0.11
        ok_real = filled > 0
        rows.append({"idx": i, "domain": seed["domain"], "slots": bp["stats"]["files"], "filled": filled,
                     "throttle_hits": throttled, "gb": gb, "quote": bp["quote"]["total"], "ok": bool(ok_quote and ok_real)})
        if not (ok_quote and ok_real):
            fails.append((i, seed["domain"], ok_quote, ok_real))
        print(f"[{i:02d}] {seed['domain']}: slots={bp['stats']['files']} filled={filled} throttle={throttled} "
              f"gb={gb} quote={bp['quote']['total']} ({time.time()-t0:.0f}s) {'✓' if ok_quote and ok_real else '✗'}")
        if i < len(SEEDS):
            time.sleep(COOLDOWN_BETWEEN)
    except Exception as e:
        fails.append((i, seed["domain"], "EXC", str(e)[:80]))
        print(f"[{i:02d}] {seed['domain']}: EXCEPTION {e}")

print("\n==== 汇总 ====")
print(f"成功(含真灌) {sum(1 for r in rows if r['ok'])}/10；失败 {len(fails)}：{fails if fails else '无'}")
json.dump(rows, open(os.path.join(OUT, "_summary.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=1)
sys.exit(0 if not fails else 1)
