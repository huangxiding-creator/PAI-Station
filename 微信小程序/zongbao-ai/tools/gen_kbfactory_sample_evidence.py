# -*- coding: utf-8 -*-
"""W3 evidence 真调研样本生成器——真跑 evidence 链（渠道实调→证据树）产小程序演示样本。

用户令（铁律）：编目树必须基于真实调研生成——本件对 sample_evidence.json 的每一枚
文件槽都来自渠道适配器实测 FileMeta（真网络实调，非种子预置、非手拼）；检索不足
如实报错退出，绝不降级编造。

与 gen_kbfactory_samples.py 同纪律：样本是给 UI 看的视图数据（槽位瘦身/每组截断/
统计与报价为全量真值）；本件另加小程序包合规脱敏——渠道名/链接/标识不进包
（verify_kbfactory 敏感词门），脱敏动作与计数如实落 _sample.sanitized（数字零造假：
pool_size/real_file_ratio 等全部为真调研实测值）。

收割来源（真网络，逐级如实降级）：pool.harvest_pool（W2 在役优先）→ 渠道适配器
直采（零登录配方优先：文库→doc88→洞见研报；不济如实退出不产样本）。

用法：py -3 tools/gen_kbfactory_sample_evidence.py [--limit 20] [--dry]
产物：pages/kbfactory/samples/sample_evidence.json + .js 包装（DevTools 不收 json require）
"""
import argparse
import json
import re
import sys
from dataclasses import asdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]          # 仓库根（tools/→zongbao-ai/→微信小程序/→ROOT）
sys.path.insert(0, str(ROOT))                       # 仓库根入 path（kb_factory 包全限定导入）

from kb_factory import evidence_cli                 # noqa: E402

OUT_DIR = Path(__file__).resolve().parents[1] / "pages" / "kbfactory" / "samples"
MAX_BYTES = 200 * 1024
KEEPS = (3, 2, 1)  # 每主题组保留条目数（超 200KB 逐档收紧，1 仍超才报错）

# 与 sample_water 同源需求（页面演示一致性；证据链按此真调研）
NEED = {"domain": "水利EPC工程", "keywords": ["水利水电", "EPC总承包", "施工组织设计", "工程监理", "工程造价"],
        "intent": "施工与项目管理", "size_hint": "small"}

# 小程序包敏感词（与 verify_kbfactory.py BANNED 同源同法：英文词字母边界匹配）
BANNED = ["ima", "wenku", "文库", "飞书", "feishu", "api"]
BANNED_RE = {w: re.compile(r"(?<![a-zA-Z])" + w + r"(?![a-zA-Z])", re.IGNORECASE)
             for w in BANNED if w.isascii()}

BADGE_DISPLAY = {"green_free": ("🟢", "公开资料"), "wenku_vip": ("🟡", "会员资料"),
                 "ima_public": ("🔵", "共享资料"), "gb_free": ("🏛️", "官方标准"),
                 "self_owned": ("🟢", "自有资料"), "seed_fallback": ("○", "示例占位")}
PERM_DISPLAY = {"green": "可自由使用", "yellow": "会员可用", "red": "单独审批"}


def _hits(text: str) -> bool:
    return any(BANNED_RE[w].search(text) if w in BANNED_RE else w in text for w in BANNED)


def fmt_size(kb) -> str:
    kb = kb or 0
    return f"{kb / 1024:.1f}MB" if kb >= 1024 else f"{kb}KB"


# ── 真收割（真网络腿全在渠道适配器内；本件只编排）─────────────────────────

def build_direct_adapters():
    """直采适配器编队（零登录配方，W5 在役件；频控默认值不动）。"""
    from kb_factory.channel_adapters.base import AuditLog
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    adapters = [WenkuMetaAdapter(audit=AuditLog())]
    try:
        from kb_factory.channel_adapters.doc88_meta import Doc88Adapter
        adapters.append(Doc88Adapter(audit=AuditLog()))
    except Exception:
        pass
    try:
        from kb_factory.channel_adapters.djyanbao_meta import DjyanbaoAdapter
        adapters.append(DjyanbaoAdapter(audit=AuditLog()))
    except Exception:
        pass
    return adapters


def direct_harvest(queries, channels=None, limit=20):
    """渠道适配器直采（pool 缺席时的如实降级腿，非 mock）：逐渠道逐查询实调，
    熔断/不可用如实跳过；返回契约形状 {channel: [FileMeta dict]}。"""
    from kb_factory.channel_adapters.base import CircuitOpenError, RateLimitExceeded
    out = {}
    for ad in build_direct_adapters():
        if channels and ad.channel not in channels:
            continue
        if not ad.available():
            print(f"[sample] 渠道不可用（如实跳过）: {ad.channel}: {ad.reason()}")
            continue
        metas = []
        for q in queries:
            try:
                metas.extend(ad.metadata(q, limit))
            except (RateLimitExceeded, CircuitOpenError) as e:
                print(f"[sample] 渠道熔断（如实跳过）: {ad.channel}: {type(e).__name__}")
                break
            except Exception as e:  # 渠道单点异常如实跳过（不打断其他渠道）
                print(f"[sample] 渠道异常（如实跳过）: {ad.channel}: {type(e).__name__}: {e}")
                break
        if metas:
            out[ad.channel] = [asdict(m) for m in metas]
        if sum(len(v) for v in out.values()) >= 2 * limit:
            break
    return out


def run_evidence_chain(limit: int):
    """evidence 链真跑：pool 在役走 pool 收割；缺席走适配器直采（如实记账来源）。"""
    pool_mod, tree_mod, note = evidence_cli.load_chain()
    text = evidence_cli._text_of(NEED)
    if tree_mod is None:
        print("[sample] evidence_tree 缺席（W1 未落地），无法真调研建树（如实退出）")
        return None
    if pool_mod is not None:
        print(f"[sample] 收割来源: pool（{note.get('pool')}）")
        return evidence_cli.build_evidence_blueprint(NEED)
    print("[sample] 收割来源: 渠道适配器直采（pool 未落地，如实降级非 mock）")
    return evidence_cli.build_evidence_blueprint(
        NEED, harvest=lambda q, channels=None: direct_harvest(q, channels, limit))


# ── 样本化（瘦身/截断/合规脱敏；统计与报价恒为全量真值）────────────────────

def slim_slot(s: dict) -> dict:
    real = s.get("real") is True
    icon, src = ("○", "示例占位") if not real else BADGE_DISPLAY.get(s.get("badge"), ("🟢", "资料"))
    perm = s.get("perm", "green")
    return {"name": s.get("name", ""), "tier": s.get("tier", "guide"),
            "ext": s.get("ext", "md"), "size": fmt_size(s.get("size_kb") or 0),
            "icon": icon, "src": src, "perm": PERM_DISPLAY.get(perm, perm), "real": real}


def sanitize_provenance(prov: dict, dropped: dict) -> dict:
    """provenance 合规脱敏（泛化清扫 + 定点改形；动作计数如实）：
    渠道名映射/模块路径键定点摘除，字符串值命中敏感词的键整键摘除。"""
    prov = json.loads(json.dumps(prov, ensure_ascii=False))  # 深拷贝（不动真跑原档）
    ev = prov.get("evidence")
    if isinstance(ev, dict):  # 渠道名映射→只留渠道数（names 不进包）
        ev.pop("channels", None)
        ev.pop("chain", None)
        dropped["keys"] += 2
        ev["channels_n"] = ev.get("channels_n", 0)
    et = prov.get("evidence_tree")
    if isinstance(et, dict) and isinstance(et.get("per_channel_counts"), dict):
        et["per_channel_counts"] = {"channels_n": len(et["per_channel_counts"])}
        dropped["keys"] += 1

    def clean(obj):
        if isinstance(obj, dict):
            out = {}
            for k, v in obj.items():
                if _hits(str(k)):
                    dropped["keys"] += 1
                    continue
                if isinstance(v, str) and _hits(v):
                    dropped["keys"] += 1
                    continue
                out[k] = clean(v)
            return out
        if isinstance(obj, list):
            out = []
            for v in obj:
                if isinstance(v, str) and _hits(v):
                    dropped["lines"] += 1
                    continue
                out.append(clean(v))
            return out
        return obj

    return clean(prov)


def to_sample(bp: dict, keep: int) -> tuple:
    """蓝图 → 演示样本（每组截断 keep + 槽位瘦身 + 敏感槽如实摘除）。
    返回 (sample_dict, omitted_slots)；统计/报价为全量真值不截断。"""
    dropped = {"keys": 0, "lines": 0}
    omitted = 0
    kept = 0
    l1_out = []
    for l1 in bp["tree"]["l1"]:
        l2_out = []
        for l2 in l1["l2"]:
            pool = l2.get("files") or (l2["split_dirs"][0]["files"] if l2.get("split_dirs") else [])
            files = []
            for s in pool[:keep]:
                slim = slim_slot(s)
                if _hits(json.dumps(slim, ensure_ascii=False)):  # 真实标题含敏感词→整槽摘除
                    omitted += 1
                    continue
                files.append(slim)
            kept += len(files)
            l2_out.append({"code": l2.get("code", ""), "name": l2.get("name", ""),
                           "path": l2.get("path", ""), "file_count": l2.get("file_count", 0),
                           "source": l2.get("source", ""), "files": files})
        l1_out.append({"code": l1.get("code", ""), "dir": l1.get("dir", ""),
                       "name": l1.get("name", ""), "theme": l1.get("theme", ""),
                       "l2_count": len(l1.get("l2", [])), "l2": l2_out})
    tree = {"mode": bp["tree"].get("mode", ""), "root": bp["tree"].get("root", ""), "l1": l1_out}
    q = dict(bp.get("quote") or {})
    if "ima_add" in q:  # 键名适配 UI（同 gen_kbfactory_samples 口径）
        q["import_add"] = q.pop("ima_add")
    st = dict(bp.get("stats") or {})
    st.setdefault("files", kept)
    st.setdefault("gb", 0.0)
    st.setdefault("l1_count", len(l1_out))
    st.setdefault("l2_count", sum(x["l2_count"] for x in l1_out))
    ev_raw = (bp.get("provenance") or {}).get("evidence") or {}
    sample = {"domain": bp.get("domain", ""), "need": bp.get("need") or {},
              "tree": tree, "ratio": bp.get("ratio") or {},
              "stats": st, "quote": q,
              "provenance": sanitize_provenance(bp.get("provenance") or {}, dropped),
              "_sample": {"engine_version": (bp.get("provenance") or {}).get("engine_version", ""),
                          "demo": True, "truncated": True, "kept_per_group": keep,
                          "kept_files": kept, "files_total": st["files"],
                          "research": "真调研实调（渠道元数据实测收割→证据树）",
                          "evidence": {"pool_size": ev_raw.get("pool_size"),
                                       "real_file_ratio": ev_raw.get("real_file_ratio")},
                          "sanitized": {**dropped, "slots_dropped": omitted},
                          "note": "真调研样本：文件槽由渠道实测元数据供弹（统计/报价为全量"
                                  "真值）；为小程序包合规已脱敏渠道名/链接并按组截断展示，"
                                  "完整溯源以产线蓝图 provenance 为准"}}
    sample["_sample"]["sanitized"]["slots_dropped"] = omitted
    return sample, omitted


def main() -> int:
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    ap = argparse.ArgumentParser(description="W3 evidence 真调研样本生成（真网络实调）")
    ap.add_argument("--limit", type=int, default=20, help="直采腿每查询元数据上限")
    ap.add_argument("--dry", action="store_true", help="只打印收割计划，不落样本")
    args = ap.parse_args()

    bp = run_evidence_chain(args.limit)
    if bp is None:
        print("[sample] evidence 链无果（检索 0 件/建树失败，如实计 0），不产样本")
        return 1
    ev = (bp.get("provenance") or {}).get("evidence") or {}
    st = bp.get("stats") or {}
    print(f"[sample] 真调研收割: pool_size={ev.get('pool_size')} "
          f"real_file_ratio={ev.get('real_file_ratio')} "
          f"L1={st.get('l1_count')} L2={st.get('l2_count')}")
    if args.dry:
        return 0

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    for keep in KEEPS:
        sample, omitted = to_sample(bp, keep)
        text = json.dumps(sample, ensure_ascii=False, indent=1)
        if _hits(text):  # 兜底门：非槽位处（组名/说明等）命中 → 收紧一档重试
            print(f"[sample] 敏感词兜底门命中（keep={keep}），逐档收紧重试")
            continue
        if len(text.encode("utf-8")) > MAX_BYTES:
            continue
        (OUT_DIR / "sample_evidence.json").write_text(text, encoding="utf-8")
        compact = json.dumps(sample, ensure_ascii=False, separators=(",", ":"))
        (OUT_DIR / "sample_evidence.js").write_text(
            "// W3 evidence 真调研样本（gen_kbfactory_sample_evidence 产物；"
            "DevTools 不收 json require 同律）\nmodule.exports = " + compact + ";\n",
            encoding="utf-8")
        size_kb = len(text.encode("utf-8")) / 1024
        print(f"[sample] 已落盘: sample_evidence.json（{size_kb:.0f}KB, keep={keep}, "
              f"omitted_slots={omitted}）+ sample_evidence.js 包装")
        return 0
    print("[sample] 收紧到 keep=1 仍超限/含敏感词，如实报错不硬产（请降 limit 重跑）")
    return 1


if __name__ == "__main__":
    sys.exit(main())
