# -*- coding: utf-8 -*-
"""evidence_cli —— 真调研编目树 CLI 与 evidence 链编排（W3 集成接线）。

用户令（铁律）：编目树必须基于真实调研生成（非种子预置）——本模块把研究报告
生产线 API 化的调研搜集能力（channel_adapters 五适配器经 pool 收割元数据）
接进知识库蓝图三级编目树生成（evidence_tree 建树），并给 engine.build_blueprint
提供 evidence 开关的链路入口（engine 侧只加接线，本件承链）。

CLI 真入口：
    py -3 -m kb_factory.evidence_cli "一句话" [-o out.json] [--channels wenku,djyanbao]
链路：expand_queries → harvest_pool → relevance 滤池(A2) → build_evidence_tree
     → 落盘 + provenance 摘要（pool_size / real_file_ratio / 各渠道命中数）。

A2 相关性滤池（KB-FACTORY 2.0 轴②×3，接线位=pool 后、建树前）：收割池先过
    kb_factory.catalog_engine.relevance（标题命中/摘要语料/权威度三权打分 +
    广告词·空标题·纯数字·超短标题惩罚，KB_RELEVANCE 开关默认开）再进
    evidence_tree——噪声件不混编目树；淘汰账如实落 provenance.relevance
    （kept/dropped/top_score/avg + 原因分布），关开关=零调用零漂移。
    evidence_tree.py 域外不碰（滤池只改树输入，不改建树件）。

契约（W1/W2 钉死；模块未落地=如实降级，禁编造）：
    pool.harvest_pool(...)                    → {channel: [FileMeta dict]}
    evidence_tree.build_evidence_tree(text, metas_flat, need=None) → 蓝图 dict
    （空池 ValueError=如实计 0；W1 建树按 top-level channel 读渠道锚——本件扁平化
    时补注入 channel 键，渠道归属不因拍平丢失）
    契约模块可能落位（并行开发，逐一探测）：kb_factory/pool.py ·
    kb_factory/channel_adapters/pool.py · kb_factory/evidence_tree.py ·
    kb_factory/catalog_engine/evidence_tree.py（及 sys.path 直入形态的同名顶层模块）。

零造假纪律：检索不到如实计 0（退出码 1，不产树）；渠道异常如实报错不静默吞；
real_file_ratio 以树内文件槽 real 键实测计数，空树记 None 不记 0.0 冒充。

测试针位（生产禁设；生效即在输出打印告知行，全程可审计）：
    KB_EVIDENCE_CHAIN_DIR=<目录>              契约替身目录（优先于真模块装载，
                                              仅测试显式覆盖用）
    KB_EVIDENCE_HARVEST_MODULE=<py路径>::<函数名>  注入收割函数（FakeAdapter 针位，
                                              签名 harvest(queries, channels=None)
                                              → {channel: [FileMeta dict]}）
    KB_RELEVANCE=0|false|off|no               A2 相关性滤池显式关（默认开；
                                              三态口径同 engine._flag_on）
"""
from __future__ import annotations

import argparse
import hashlib
import importlib
import importlib.util
import inspect
import json
import os
import sys
from pathlib import Path

EVIDENCE_CLI_VERSION = "evidence-cli/1.1.0-a2"

# 契约模块候选位（并行开发期逐一探测：先包名全路径，后 sys.path 直入顶层名）
_POOL_CANDIDATES = ("kb_factory.pool", "kb_factory.channel_adapters.pool",
                    "channel_adapters.pool", "pool")
_TREE_CANDIDATES = ("kb_factory.evidence_tree", "kb_factory.catalog_engine.evidence_tree",
                    "kb_factory.channel_adapters.evidence_tree",
                    "catalog_engine.evidence_tree", "evidence_tree")

CHAIN_DIR_ENV = "KB_EVIDENCE_CHAIN_DIR"          # 测试针位：契约替身目录
HARVEST_MODULE_ENV = "KB_EVIDENCE_HARVEST_MODULE"  # 测试针位：收割函数注入
ONTOLOGY_ALIGN_ENV = "KB_ONTOLOGY_ALIGN"          # B1 轴③：本体对齐校准开关（默认开）
RELEVANCE_ENV = "KB_RELEVANCE"                   # A2 相关性滤池开关（默认开）

_TRUTHY = ("1", "true", "on", "yes")             # 判真值集（口径同 engine._TRUTHY）


def _relevance_on(flag) -> bool:
    """A2 滤池开关三态归一：显式传参优先（bool / '1'/'0'/'true'…）；否则看
    KB_RELEVANCE——与 engine 众开关默认关不同，本开关默认开（任务令：
    KB_RELEVANCE=1 开关默认开）：unset/空串=开，显式 0/false/off/no=关。"""
    if flag is not None:
        if isinstance(flag, bool):
            return flag
        return str(flag).strip().lower() in _TRUTHY
    val = str(os.environ.get(RELEVANCE_ENV, "")).strip().lower()
    return True if not val else val in _TRUTHY


def _p(text: str) -> None:
    """统一打印（Windows 控制台宽容：编码受限时降级替换不崩）。"""
    try:
        print(text)
    except UnicodeEncodeError:
        print(text.encode("ascii", "replace").decode("ascii"))


def _load_module_from_file(name: str, path: Path):
    """从文件装载模块（spec 法；文件缺席返回 None）。"""
    if not path.is_file():
        return None
    spec = importlib.util.spec_from_file_location(name, str(path))
    if spec is None or spec.loader is None:
        return None
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def _probe_candidates(candidates, attr: str):
    """按候选名逐一试载，返回首个具备 attr 可调用属性的模块；全败返回 None。"""
    for cand in candidates:
        try:
            mod = importlib.import_module(cand)
        except ImportError:
            continue
        if callable(getattr(mod, attr, None)):
            return mod
    return None


def load_chain():
    """装载 W1/W2 契约模块（pool / evidence_tree），返回 (pool_mod, tree_mod,
    provenance_note)。真模块在场永远优先于测试针位目录中「同契约定件」缺席时的
    兜底——具体次序：KB_EVIDENCE_CHAIN_DIR 显式覆盖（测试）→ 包名候选 → 顶层名。
    装载事实（模块名/路径）如实入 provenance_note 供审计。"""
    note = {}
    chain_dir = os.environ.get(CHAIN_DIR_ENV, "").strip()
    pool_mod = tree_mod = None
    if chain_dir:
        _p(f"[evidence] 测试针位生效: {CHAIN_DIR_ENV}={chain_dir}（契约替身优先装载）")
        d = Path(chain_dir)
        m = _load_module_from_file("kb_evidence_stub_pool", d / "pool.py")
        if m is not None and callable(getattr(m, "harvest_pool", None)):
            pool_mod = m
            note["pool"] = f"stub:{d / 'pool.py'}"
        t = _load_module_from_file("kb_evidence_stub_tree", d / "evidence_tree.py")
        if t is not None and callable(getattr(t, "build_evidence_tree", None)):
            tree_mod = t
            note["tree"] = f"stub:{d / 'evidence_tree.py'}"
    if pool_mod is None:
        pool_mod = _probe_candidates(_POOL_CANDIDATES, "harvest_pool")
        if pool_mod is not None:
            note["pool"] = getattr(pool_mod, "__name__", "pool")
    if tree_mod is None:
        tree_mod = _probe_candidates(_TREE_CANDIDATES, "build_evidence_tree")
        if tree_mod is not None:
            note["tree"] = getattr(tree_mod, "__name__", "evidence_tree")
    return pool_mod, tree_mod, note


def _text_of(raw) -> str:
    """入参规整为一句话文本：str 原样；dict（引擎 need）按 domain/intent/keywords
    确定性拼接（口径同 engine._prepare_purpose）。"""
    if isinstance(raw, str):
        return raw.strip()
    if isinstance(raw, dict):
        return " ".join(x for x in (
            [str(raw.get("domain") or ""), str(raw.get("intent") or "")]
            + [str(k) for k in (raw.get("keywords") or [])]) if x).strip()
    return ""


def _expand_queries(pool_mod, tree_mod, text: str):
    """查询扩展：pool.expand_queries 优先（契约配套件），缺席兜底原文单查——
    如实返回 (queries, expander) 供 provenance 记账，不虚报扩展来源。"""
    for mod, tag in ((pool_mod, "pool.expand_queries"), (tree_mod, "evidence_tree.expand_queries")):
        fn = getattr(mod, "expand_queries", None) if mod is not None else None
        if callable(fn):
            try:
                qs = fn(text)
            except Exception as e:  # 扩展腿异常如实降级原文单查（不吞错：打印留痕）
                _p(f"[evidence] 警告: {tag} 异常，降级原文单查: {type(e).__name__}: {e}")
                continue
            if isinstance(qs, list) and qs and all(isinstance(q, str) and q.strip() for q in qs):
                return [q.strip() for q in qs], tag
    return [text], "raw_text_fallback"


def _load_harvest_override():
    """测试针位：KB_EVIDENCE_HARVEST_MODULE=<py路径>::<函数名> → 收割函数。
    签名宽容：harvest(queries, channels=None) 或 harvest(queries)。"""
    spec_val = os.environ.get(HARVEST_MODULE_ENV, "").strip()
    if not spec_val:
        return None
    _p(f"[evidence] 测试针位生效: {HARVEST_MODULE_ENV}={spec_val}（FakeAdapter 收割注入）")
    try:
        path_s, _, func = spec_val.partition("::")
        mod = _load_module_from_file("kb_evidence_harvest_override", Path(path_s.strip()))
        fn = getattr(mod, func.strip(), None)
        if not callable(fn):
            raise ValueError(f"函数缺席: {func}")
        return fn
    except Exception as e:
        raise RuntimeError(f"{HARVEST_MODULE_ENV} 装载失败: {type(e).__name__}: {e}") from e


def _normalize_channels(channels):
    """渠道白名单归一：str 原样；ChannelAdapter 实例取 .channel（W2 pool 契约
    显式收适配器实例作注入针位，本层透传不吞）。"""
    out = []
    for c in channels or []:
        if isinstance(c, str):
            name = c.strip()
        else:
            name = str(getattr(c, "channel", "") or "").strip()
        if name:
            out.append(name)
    return out


def _harvest_accepts_channels(harvest) -> bool:
    """签名探测（非异常探测）：收割函数是否收 channels 形参/ **kwargs。
    绝不用 try/except TypeError 兜签名——真 TypeError（如收割内部 bug）会被吞
    并触发无参重放（等于意外重跑全渠道真网络），签名探测零此风险。"""
    try:
        sig = inspect.signature(harvest)
    except (TypeError, ValueError):      # 内建/不可探测对象：按契约首选形态宽容传
        return True
    return ("channels" in sig.parameters
            or any(p.kind == inspect.Parameter.VAR_KEYWORD
                   for p in sig.parameters.values()))


def _call_harvest(harvest, queries, channels):
    """收割调用：按签名探测决定传不传 channels（ TypeError 一律如实上抛不重放）。
    显式指定 channels 时对结果键做如实过滤（收割函数不认 channels 的场合，
    过滤在调用侧收口）。返回值形状校验：{channel: [FileMeta dict]}。"""
    if channels and _harvest_accepts_channels(harvest):
        result = harvest(queries, channels=channels)
    else:
        result = harvest(queries)
    if not isinstance(result, dict):
        raise TypeError(f"harvest 返回非 dict: {type(result).__name__}（契约={channel: [FileMeta dict]}）")
    cleaned = {}
    for ch, lst in result.items():
        if not isinstance(lst, list):
            raise TypeError(f"harvest 返回值 {ch!r} 非 list（契约={channel: [FileMeta dict]}）")
        cleaned[str(ch)] = lst
    if channels:
        keep = set(_normalize_channels(channels))
        cleaned = {ch: lst for ch, lst in cleaned.items() if ch in keep}
    return cleaned


def _iter_tree_slots(blueprint: dict):
    """产出树内全部文件槽（files 优先，分拆组拍平；只读不改）。"""
    for l1 in ((blueprint.get("tree") or {}).get("l1") or []):
        for l2 in l1.get("l2") or []:
            if l2.get("files"):
                yield from l2["files"]
            else:
                for sd in l2.get("split_dirs") or []:
                    yield from sd.get("files") or []


def real_file_stats(blueprint: dict):
    """实测树内文件槽 real 键：返回 (real_count, total, ratio)——ratio=real/total，
    空树（0 槽）记 None（无槽可评，不记 0.0 冒充实测）。"""
    real = total = 0
    for s in _iter_tree_slots(blueprint):
        total += 1
        if s.get("real") is True:
            real += 1
    return real, total, (round(real / total, 4) if total else None)


def _align_clusters_before_tree(tree_mod, metas_flat):
    """B1 轴③：建树前对簇跑本体对齐校准（KB_ONTOLOGY_ALIGN=1 默认开）。
    返回 (对齐簇|None, 总账|None)；开关关/契约树无 cluster_pool/对齐链异常
    → (None, None) 如实降级并打印原因，绝不阻断 evidence 主链。"""
    if not metas_flat:
        return None, None
    cluster_pool_fn = getattr(tree_mod, "cluster_pool", None)
    if not callable(cluster_pool_fn):
        return None, None  # 契约树（stub 等）无簇接口，如实跳过
    try:
        from kb_factory.catalog_engine import ontology_align
    except ImportError:
        try:
            from catalog_engine import ontology_align
        except ImportError:
            return None, None  # 对齐件缺席：如实降级（不硬造）
    if not ontology_align.align_enabled():
        return None, None
    try:
        raw_clusters = cluster_pool_fn(metas_flat)
        aligned = ontology_align.align_clusters(raw_clusters, metas_flat)
    except Exception as exc:  # 对齐链异常如实告知，不阻断主链
        _p(f"[ontology_align] 警告: 对齐异常如实跳过: {type(exc).__name__}: {exc}")
        return None, None
    summary = ontology_align.align_summary(aligned, clusters_in=len(raw_clusters))
    _p("[ontology_align] 建树前三重校准: " + str(summary.get("stage", "")))
    return aligned, summary


def build_evidence_blueprint(raw, channels=None, harvest=None, relevance=None):
    """evidence 链编排（engine.build_blueprint 开关开启时的承链入口）：
    expand_queries → harvest_pool → relevance 滤池(A2) → build_evidence_tree
    → provenance.evidence 记账。

    - raw：一句话 str 或引擎 need dict（dict 时原样传 tree 作 need）。
    - channels：渠道白名单（None=全渠道，收割函数/pool 自决）。
    - harvest：收割函数注入（默认 pool.harvest_pool；测试 FakeAdapter 针位）。
    - relevance：A2 滤池开关三态（None=看 KB_RELEVANCE，默认开；True/False 显式）。
    - 返回蓝图 dict；链上无果（契约模块缺席 / 检索 0 件 / 建树 None）返回 None，
      原因如实打印（零造假：检索不到如实计 0，禁编造）。
    """
    text = _text_of(raw)
    if not text:
        _p("[evidence] 入参为空，无法展开调研（如实拒绝，不编造）")
        return None
    need = raw if isinstance(raw, dict) else None

    pool_mod, tree_mod, chain_note = load_chain()
    if tree_mod is None:
        _p("[evidence] 契约模块 evidence_tree 缺席（W1 未落地），evidence 链降级")
        return None
    harvest_fn = harvest
    if harvest_fn is None:
        harvest_fn = _load_harvest_override()
    if harvest_fn is None:
        if pool_mod is None:
            _p("[evidence] 契约模块 pool 缺席（W2 未落地）且无收割注入，evidence 链降级")
            return None
        harvest_fn = pool_mod.harvest_pool

    queries, expander = _expand_queries(pool_mod, tree_mod, text)
    pool_result = _call_harvest(harvest_fn, queries, channels)
    per_channel = {ch: len(lst) for ch, lst in pool_result.items()}
    metas_flat, skipped = [], 0
    for ch, lst in pool_result.items():
        for m in lst:
            if isinstance(m, dict):
                # 扁平化补渠道锚：{channel: [...]} → 平铺后渠道信息会丢，W1 建树按
                # top-level channel → extra.channel 读渠道（缺失如实记 unknown）——
                # 此处浅拷贝注入 top-level channel（已有同名键不覆写，W2 自带则原样）。
                if m.get("channel") or (isinstance(m.get("extra"), dict)
                                        and m["extra"].get("channel")):
                    metas_flat.append(m)
                else:
                    flat = dict(m)
                    flat["channel"] = ch
                    metas_flat.append(flat)
            else:  # 非法形状如实剔除并计数（契约=FileMeta dict）
                skipped += 1
    if skipped:
        _p(f"[evidence] 警告: {skipped} 条收割结果非 dict 形状，如实剔除")

    # ── A2 相关性滤池（KB_RELEVANCE 默认开；pool 后、建树前）───────────────
    # 淘汰噪声件（广告词/空标题/纯数字/超短标题/零命中低分），kept 才进
    # evidence_tree；淘汰账如实落 provenance.relevance（关开关=零调用零漂移）。
    rel_ledger = None
    if _relevance_on(relevance):
        try:
            from kb_factory.catalog_engine import relevance as _relevance_mod
        except ImportError:  # pragma: no cover - sys.path 直挂 kb_factory/ 形态
            from catalog_engine import relevance as _relevance_mod
        metas_flat, _dropped_recs, rel_ledger = _relevance_mod.pool_ledger(
            metas_flat, raw)
        if _dropped_recs:
            _p(f"[evidence] 相关性滤池: 保留 {len(metas_flat)} / 淘汰 "
               f"{len(_dropped_recs)}（原因分布 {rel_ledger.get('drop_reasons')}；"
               "淘汰账如实，不静默）")

    # B1 轴③：建树前对簇跑本体对齐校准（KB_ONTOLOGY_ALIGN=1 默认开；
    # 契约树带 cluster_pool 才有簇可校准，stub/缺席如实跳过不阻断主链）
    aligned_clusters, align_prov = _align_clusters_before_tree(tree_mod, metas_flat)
    try:
        tree_bp = None
        if aligned_clusters is not None:
            try:
                tree_bp = tree_mod.build_evidence_tree(
                    text, metas_flat, need=need, clusters=aligned_clusters)
            except TypeError:  # 契约宽容：树不收 clusters 位 → 如实降级重试
                _p("[ontology_align] 契约树不收 clusters 位，对齐簇未入树（如实降级）")
        if tree_bp is None:
            try:
                tree_bp = tree_mod.build_evidence_tree(text, metas_flat, need=need)
            except TypeError:  # 契约宽容：need 缺省位形态
                tree_bp = tree_mod.build_evidence_tree(text, metas_flat)
    except ValueError as e:  # W1 空池契约：零造假拒空树 → 如实计 0（非链路错误）
        _p(f"[evidence] {e}")
        _p(f"[evidence] 检索不足（pool_size=0），未建编目树（如实计 0，禁编造）")
        return None
    if not isinstance(tree_bp, dict) or not (tree_bp.get("tree") or {}).get("l1"):
        _p(f"[evidence] 检索不足（pool_size={len(metas_flat)} 件真实元数据），"
           "未建编目树（如实计 0，禁编造）")
        return None

    # provenance.evidence 记账（setdefault 合并：不覆写 W1 已落的真实键值）
    real, total, ratio = real_file_stats(tree_bp)
    prov = tree_bp.setdefault("provenance", {})
    if not isinstance(prov, dict):
        prov = {}
        tree_bp["provenance"] = prov
    ev = prov.setdefault("evidence", {})
    if not isinstance(ev, dict):
        ev = {}
        prov["evidence"] = ev
    for k, v in (("pool_size", len(metas_flat)), ("real_file_ratio", ratio),
                 ("real_files", real), ("tree_slots", total),
                 ("channels", per_channel), ("channels_n", len(per_channel)),
                 ("queries", queries), ("expander", expander),
                 ("generated_by", EVIDENCE_CLI_VERSION)):
        ev.setdefault(k, v)
    ev.setdefault("chain", chain_note)
    if align_prov is not None:  # B1 轴③：本体对齐总账（setdefault 不覆写）
        oa_prov = prov.setdefault("ontology_align", {})
        if not isinstance(oa_prov, dict):
            oa_prov = {}
            prov["ontology_align"] = oa_prov
        for k, v in align_prov.items():
            oa_prov.setdefault(k, v)
    # A2 滤池淘汰账落 provenance.relevance（四钉键 kept/dropped/top_score/avg +
    # threshold/mode/原因分布审计键；空池 None 不记 0.0 冒充；关开关不落键）
    if rel_ledger is not None:
        rel_slot = prov.setdefault("relevance", {})
        if not isinstance(rel_slot, dict):
            rel_slot = {}
            prov["relevance"] = rel_slot
        for k, v in rel_ledger.items():
            rel_slot.setdefault(k, v)
    log = prov.get("stage_log")
    if isinstance(log, list):
        log.append(f"Se evidence 链: queries={len(queries)} expander={expander} "
                   f"pool_size={len(metas_flat)} channels={per_channel} "
                   f"real_file_ratio={ratio}")
        if align_prov is not None:
            log.append("Se ontology_align: " + str(align_prov.get("stage", "")))
        if rel_ledger is not None:
            log.append(f"Sf relevance 滤池: mode={rel_ledger.get('mode')} "
                       f"kept={rel_ledger.get('kept')} "
                       f"dropped={rel_ledger.get('dropped')} "
                       f"top={rel_ledger.get('top_score')} avg={rel_ledger.get('avg')}")
    return tree_bp


# ── CLI ─────────────────────────────────────────────────────────────────

def main(argv=None) -> int:
    try:  # Windows 控制台 utf-8 宽容（同 verify_kbfactory 口径）
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    ap = argparse.ArgumentParser(
        prog="kb_factory.evidence_cli",
        description="真调研编目树生成（expand→harvest→tree；零造假：检索不到如实计 0）")
    ap.add_argument("text", help='一句话需求，如 "给水利工程公司建一个EPC行业知识库"')
    ap.add_argument("-o", "--out", help="输出蓝图 JSON 路径（缺省=当前目录 "
                                        "evidence_tree_<hash8>.json）")
    ap.add_argument("--channels", default=None,
                    help="渠道白名单（逗号分隔，如 wenku,djyanbao；缺省=收割层全渠道）")
    args = ap.parse_args(argv)

    channels = ([c.strip() for c in args.channels.split(",") if c.strip()]
                if args.channels else None)
    text = args.text.strip()
    if not text:
        _p("[evidence] 一句话需求为空（如实拒绝）")
        return 2

    try:
        bp = build_evidence_blueprint(text, channels=channels)
    except Exception as e:  # 链上异常如实报错（不吞不编造）
        _p(f"[evidence] 链路异常: {type(e).__name__}: {e}")
        return 2
    if bp is None:
        return 1

    ev = (bp.get("provenance") or {}).get("evidence") or {}
    out = args.out or f"evidence_tree_{hashlib.sha256(text.encode('utf-8')).hexdigest()[:8]}.json"
    with open(out, "w", encoding="utf-8") as f:
        json.dump(bp, f, ensure_ascii=False, indent=1)

    # provenance 摘要（任务口径：pool_size / real_file_ratio / 各渠道数）
    per_ch = ev.get("channels") or {}
    ch_txt = " ".join(f"{ch}={n}" for ch, n in sorted(per_ch.items())) or "（0 渠道命中）"
    ratio = ev.get("real_file_ratio")
    ratio_txt = "None" if ratio is None else f"{float(ratio):.2f}"
    _p(f"[evidence] 编目树已落盘: {out}")
    _p(f"[evidence] provenance 摘要: pool_size={ev.get('pool_size', 0)} "
       f"real_file_ratio={ratio_txt} 渠道数 {ch_txt}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
