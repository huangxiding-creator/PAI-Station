# -*- coding: utf-8 -*-
"""KB-CAT v1 编目引擎核心（stdlib only，规则引擎，零 LLM）。

确定性纪律：无随机源、无时钟；同输入必同输出。
需要抖动时以 sha256(规范化输入) 为种子（本版未使用抖动，接口已备：need_hash8）。

收口波统一接线（波A）：purpose 前置 / 冷门域兜底 / 校验器门禁 / 结构 lint 后置 /
三视图统一出口 五件全 env 开关默认关（KB_PURPOSE / KB_COLD_EXPAND /
KB_TAXONOMY_GATE / KB_VIEWS）——缺省输出逐字节零漂移是最高优先级，开则如实
记账（provenance.purpose / cold_expand / views_available）；SKOS 可选导出
（KB_SKOS_EXPORT）因 build 是内存函数只留接线注释位（见 build_blueprint 尾部），
导出归 CLI/云函数产物落盘处挂 export_blueprint。
"""
from __future__ import annotations

from typing import Optional

# 规模计划（size_hint → L1 数 / 每 L1 的 L2 数 / 每 L2 槽数）：
#     small  10/10/10 = 1,000 槽
#     medium 12/12/12 = 1,728 槽
#     large  16/14/14 = 3,136 槽
#     huge   20/10/250 = 50,000 槽
# phi-1 配比：small 50/35/15 · medium 55/35/10 · large|huge 58/34/8
# 报价（A 档）：base 29.0 + gb×2.0
import hashlib
import json
import os
import re
from pathlib import Path

from . import blueprint as bp
from . import clc_layer
from . import dendron
from . import storm_breadth
from . import taxonomy
from .blueprint import (MAX_FILES_PER_DIR, TIERS, attach_guided_layer, split_files,
                        tier_counts, validate_tree)
from .lint import lint_blueprint
from .metadata import (BADGES, EXT_BYTES, PERM_BY_BADGE, badge_for_index, make_slot,
                       pick_ext, sanitize_filename)

ENGINE_VERSION = "kb-cat/1.0.0"
MAX_L1 = 22
MIN_L1 = 8

SIZE_PLANS = {
    "small": {"l1": 10, "l2": 10, "fpg": 10},
    "medium": {"l1": 12, "l2": 12, "fpg": 12},
    "large": {"l1": 16, "l2": 14, "fpg": 14},
    "huge": {"l1": 20, "l2": 10, "fpg": 250},
}
RATIO_BY_SIZE = {
    "small": {"core": 50, "field": 35, "guide": 15},
    "medium": {"core": 55, "field": 35, "guide": 10},
    "large": {"core": 58, "field": 34, "guide": 8},
    "huge": {"core": 58, "field": 34, "guide": 8},
}
QUOTE_PARAMS = {"base": 29.0, "per_gb": 2.0, "md_factor": 1.5, "ima_add": 19.0}

# ── 收口波统一接线开关（波A）：全默认关=输出逐字节零漂移（最高优先级）─────────
PURPOSE_ENV = "KB_PURPOSE"              # ① purpose 前置（v2.7 #11）+ ④ 结构 lint 后置联动
COLD_EXPAND_ENV = "KB_COLD_EXPAND"      # ② 冷门域兜底：clc_layer 优先 / dendron 兜底
TAXONOMY_GATE_ENV = "KB_TAXONOMY_GATE"  # ③ 种子分类法校验器门禁（build 前置）
VIEWS_ENV = "KB_VIEWS"                  # ⑥ 三视图统一出口（照 KB_GUIDED_LAYER 三态模式）
EVIDENCE_TREE_ENV = "KB_EVIDENCE_TREE"  # ⑦ evidence 真调研链（W3 接线：pool 收割+建树
                                        #    替代 taxonomy 主链；默认关=逐字节零漂移）
# ⑤ KB_SKOS_EXPORT：见 build_blueprint 尾部「SKOS 可选导出位」接线注释留位。

_TRUTHY = ("1", "true", "on", "yes")    # 判真值集（口径同 blueprint._flag_truthy）


def _env_flag(name: str) -> bool:
    """env 开关判真（str 大小写宽容；口径同 blueprint._flag_truthy——engine 本件
    自持一份，不跨模块引私名，云函数 vendored 副本漂移时亦不受波及）。"""
    return str(os.environ.get(name, "")).strip().lower() in _TRUTHY


def _flag_on(flag, env_name: str) -> bool:
    """三态开关归一：显式传参优先（bool / '1'/'0'/'true'…），否则看环境变量；
    默认关（口径照 blueprint.guided_layer_enabled 的 KB_GUIDED_LAYER 模式）。"""
    if flag is not None:
        if isinstance(flag, bool):
            return flag
        return str(flag).strip().lower() in _TRUTHY
    return _env_flag(env_name)


def validate_need(need: dict) -> dict:
    """需求 JSON 门：{domain:str, keywords:[str], intent:str, size_hint:str}。"""
    if not isinstance(need, dict):
        raise ValueError("need 必须是 dict")
    for k in ("domain", "intent", "size_hint"):
        if not isinstance(need.get(k), str) or not need[k].strip():
            raise ValueError(f"need.{k} 必须是非空 str")
    kws = need.get("keywords", [])
    if not isinstance(kws, list) or not all(isinstance(x, str) and x.strip() for x in kws):
        raise ValueError("need.keywords 必须是 [str]")
    if need["size_hint"] not in SIZE_PLANS:
        raise ValueError(f"size_hint 越界: {need['size_hint']}，可选 {sorted(SIZE_PLANS)}")
    return {"domain": need["domain"].strip(), "keywords": [x.strip() for x in kws],
            "intent": need["intent"].strip(), "size_hint": need["size_hint"]}


def need_hash8(need: dict) -> str:
    """输入规范化哈希（确定性种子/标识符用；zh 文本不转义以稳定哈希）。"""
    blob = json.dumps(need, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
    return hashlib.sha256(blob.encode("utf-8")).hexdigest()[:8]


def build_blueprint(raw_need: dict, mode: str = "document_driven", depth: str | None = None,
                    guided: "bool | str | None" = None,
                    schema: str | None = None,
                    views: "bool | str | None" = None,
                    evidence: "bool | str | None" = None) -> dict:
    """蓝图生成入口——mode 选择引擎：
    - document_driven: 检索真实法规/标准 → 从文件体系提炼框架（1022 用户令）
    - taxonomy: 通用分类法扇出（v1 原始模式，fallback）

    depth 蓝图深度档（轨A4）：standard(默认) | pro | flagship ——
    文件槽总量按档放大（pro ×1.4 / flagship ×1.8，round）、每 L2 组下限 4/6，
    实际档位如实记入 provenance.depth；非法值与缺参一律按 standard（输出逐字节一致）。

    guided 导览层开关（v2.6 #7，kepano-obsidian MIT 拥有感设计）：
    None=看环境变量 KB_GUIDED_LAYER，默认关（输出零漂移）；True/False 显式
    开/关（优先于环境变量）。开启时在统一出口为两种模式挂「00-导览」首 L1 组
    （📥-收件箱+五类实体索引），provenance.guided_layer=true 如实可查——
    详见 blueprint 模块 docstring（开启方式与挂载口径）。

    schema 节点 schema 立法档（v2.6 #4，Docusaurus+BookStack 双 MIT）：
    "v2"（或 env KBCAT_NODE_SCHEMA=v2）时 L1/L2 容器节点增量带
    position/kind/icon/color/duty + 每 L2 组一粒 00-README 索引槽
    （l2["readme_slot"]，不入 files 不计 stats），档位如实记
    provenance.node_schema；缺参/非法 → 旧 schema，输出逐字节零漂移。

    views 三视图开关（v2.7 #12，收口波接线，照 guided 三态模式）：None=看环境
    变量 KB_VIEWS（默认关=输出零漂移），True/False 显式开/关（优先于环境变量）；
    开时统一出口（导览层之后）挂 views.attach_views——只写
    provenance.views_available + stage_log S10 行，原树/槽位/stats/quote 零改动。

    evidence 真调研链开关（W3 接线，1026 用户令「编目树必须基于真实调研生成」）：
    默认关（False 语义）；None=看环境变量 KB_EVIDENCE_TREE，True/False 显式开/关
    （三态口径同 guided/views）。开时 taxonomy 主链被 evidence 链替代——经
    kb_factory.evidence_cli 承链（pool 渠道收割 + evidence_tree 建树，编目树三级
    结构由真实调研元数据供弹）；链上无果（契约模块缺席/检索 0 件）如实降级
    taxonomy 兜底。默认关=既有输出逐字节零漂移（test_engine/test_wiring_gates
    钉子原值过）。

    生成后自动过反模式 lint 发布门（P0 #10）+ 防环护栏 validate_tree（v2.6 #4）：
    结果入 provenance.lint 供决策，lint 失败/树结构有问题均不阻止输出，仅打印
    警告；导览层在 lint 门之后挂载（lint 评估领域内容结构，导览为固定模板层，
    由 test_guided_layer.py 保障）。

    收口波接线前置（波A，全 env 开关默认关=逐字节零漂移）：
    - KB_TAXONOMY_GATE=1：build 前置种子分类法门禁——check_taxonomy.validate_library()
      全库 0 错才放行（首跑缓存；非 0 错 raise ValueError 拒产蓝图并报明细）。
    - KB_PURPOSE=1：purpose 前置（v2.7 #11）——derive_purpose+route_seeds+
      suggest_need 供 mode/种子路由参考（match_seed 仍为权威路由，前置只记参考
      不改路由）；一句话(str)入参由 suggest_need 桥接成引擎 need；产出后置
      purpose.lint_blueprint 结构体检，provenance.purpose 落三元组+seed_routes+
      structure_lint（lint 后置随 _attach_lint 旁挂，KB_PURPOSE 联动，关则不跑）。
    - KB_COLD_EXPAND=1：冷门域兜底——taxonomy 匹配弱（clc 模式且 22 大类相关分
      全零=冷门词）时 L2 供弹 ①clc_layer.clc_expand 真实层优先 ②dendron.expand
      模板兜底（①②互斥），provenance.cold_expand 如实记账；都无果维持现状。
    """
    _taxonomy_gate_guard()             # ③ 门禁前置（KB_TAXONOMY_GATE，默认关=零调用）
    pctx = _prepare_purpose(raw_need)  # ① purpose 前置（KB_PURPOSE，默认关=None）
    if pctx is not None and isinstance(raw_need, str):
        raw_need = pctx["need"]        # 一句话(str)入参 → suggest_need 桥接为引擎 need
    s = bp.normalize_schema(schema)
    if mode == "document_driven":
        bpd = _try_document_driven(raw_need, depth)
        if bpd is not None:
            if s:  # 节点 schema 立法（v2.6 #4）：增量键+README槽+排序落图
                bp.legislate_nodes(bpd["tree"]["l1"])
                bpd["provenance"]["node_schema"] = s
            # 统一出口：lint 门（含④ purpose 结构体检联动）→ 导览层 → 三视图
            return _maybe_attach_views(attach_guided_layer(_attach_lint(bpd, pctx), guided),
                                       views)
        # 降级：检索不足 → fallback 到 taxonomy
    bpe = _try_evidence_tree(raw_need, evidence)  # ⑦ evidence 链替代 taxonomy 主链（W3）
    if bpe is not None:
        return _maybe_attach_views(attach_guided_layer(_attach_lint(bpe, pctx), guided), views)
    return _maybe_attach_views(
        attach_guided_layer(
            _attach_lint(_build_blueprint_taxonomy(raw_need, depth, schema=schema), pctx),
            guided),
        views)


def _try_evidence_tree(raw_need, flag) -> "dict | None":
    """⑦ evidence 真调研链接线（W3，KB_EVIDENCE_TREE 默认关=零调用零漂移）：
    开时经 kb_factory.evidence_cli.build_evidence_blueprint 走 pool（渠道收割）
    + evidence_tree（建树）链替代 taxonomy 主链；契约模块缺席/检索 0 件/链上
    异常 → None（降级 taxonomy 兜底，原因如实打印，不编造）。engine 零网络
    纪律不变——网络腿全在 pool/适配器层，本函数只做开关与惰性装载。"""
    if not _flag_on(flag, EVIDENCE_TREE_ENV):
        return None
    try:
        from .. import evidence_cli as _ec          # kb_factory 作包（-m 入口/云端常态）
    except ImportError:
        try:
            import evidence_cli as _ec              # kb_factory/ 直入 sys.path（tests 接线法）
        except ImportError:
            print("[evidence] 警告: evidence_cli 缺席，evidence 链降级 taxonomy")
            return None
    try:
        return _ec.build_evidence_blueprint(raw_need)
    except Exception as e:  # 链上异常如实降级（打印留痕，不吞错不编造）
        print(f"[evidence] 警告: evidence 链异常降级 taxonomy: {type(e).__name__}: {e}")
        return None


# ── ⑤ SKOS 可选导出位（收口波接线注释留位，v2.7 #15）────────────────────────
# build_blueprint 是纯内存函数（引擎零 IO 纪律），导出落 CLI/云函数「产物落盘处」
# 更合适，不强改 build 签名。在蓝图落盘侧（与 cataloging.dump_group_tsv /
# schema_synth.save_schema 同位；云函数实位=cloudfn/kb_generate/index.py 的
# build_blueprint 调用后、to_view 传输瘦身前）可选挂：
#     if str(os.environ.get("KB_SKOS_EXPORT", "")).strip().lower() in ("1","true","on","yes"):
#         from catalog_engine.skos_export import export_blueprint
#         skos_path = export_blueprint(bp, out_dir)      # → <域>-skos.jsonld，返回路径
#         bp["provenance"].setdefault("stage_log", []).append(f"S11 SKOS导出: {skos_path}")
# 默认关（不挂=既有 build 输出零漂移）；provenance 记账由落盘侧自落——
# skos_export 独立模块纪律：本模块不动 provenance。


def _attach_lint(bp: dict, pctx: "dict | None" = None) -> dict:
    """反模式 lint 发布门 + 防环护栏：结果记入 provenance.lint（确定性，不阻断输出）。
    v2.6 #4 追加 validate_tree 四查（父子环/孤儿/断裂/无归属），有问题并入
    lint.tree_problems；健康树不写该键（既有输出零漂移）。
    收口波接线（④）：pctx 非 None（KB_PURPOSE=1 前置产物）时，旁挂
    purpose.lint_blueprint 结构体检并落 provenance.purpose；开关关=不跑零漂移。"""
    report = lint_blueprint(bp)
    bp["provenance"]["lint"] = {"passed": report.passed, "failed": report.failed,
                                "warnings": report.warnings, "overall_pass": report.overall_pass}
    tree_problems = validate_tree(bp)
    if tree_problems:
        bp["provenance"]["lint"]["tree_problems"] = tree_problems
        print(f"[tree] 警告: 树结构护栏发现 {len(tree_problems)} 处问题"
              "（环/孤儿/断裂/无归属，不阻断）")
    if not report.overall_pass:
        print(f"[lint] 警告: 蓝图反模式 lint 未全过 — {report.summary}")
    if pctx is not None:  # ④ purpose 结构 lint 后置（KB_PURPOSE 开关联动）
        _attach_purpose(bp, pctx)
    return bp


# ── ③ 校验器门禁（KB_TAXONOMY_GATE，默认关；首跑缓存）───────────────────────

_TAXONOMY_GATE_CACHE: dict = {}   # 首跑缓存：{"module": 校验器模块, "errors": 错误清单}


def _load_check_taxonomy():
    """惰性装载种子分类法校验器（seeds/taxonomy/check_taxonomy.py；装载法同
    tests/test_check_taxonomy.py 的 spec_from_file_location，仓库内直定位不依赖
    sys.path 形态）。校验器缺席 → ImportError 带路径（门禁开而执法件缺席=配置
    错误，如实崩不静默放行）。"""
    import importlib.util
    if "module" in _TAXONOMY_GATE_CACHE:
        return _TAXONOMY_GATE_CACHE["module"]
    path = Path(__file__).resolve().parents[1] / "seeds" / "taxonomy" / "check_taxonomy.py"
    if not path.exists():
        raise ImportError(f"种子分类法校验器缺席: {path}（KB_TAXONOMY_GATE 门禁无法执法）")
    spec = importlib.util.spec_from_file_location("kb_seeds_check_taxonomy", path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    _TAXONOMY_GATE_CACHE["module"] = mod
    return mod


def _taxonomy_gate_guard() -> None:
    """③ 校验器门禁（收口波接线）：KB_TAXONOMY_GATE=1 时 build 前置跑
    check_taxonomy.validate_library()（seeds/taxonomy/*.yaml 全库五律），首跑
    缓存（重复 build 不重校——性能考虑，库是磁盘静态真源）；错误非空 →
    ValueError 拒产蓝图并报前 5 条明细。默认关=零调用零漂移。"""
    if not _env_flag(TAXONOMY_GATE_ENV):
        return
    if "errors" not in _TAXONOMY_GATE_CACHE:
        _TAXONOMY_GATE_CACHE["errors"] = _load_check_taxonomy().validate_library()
    errors = _TAXONOMY_GATE_CACHE["errors"]
    if errors:
        head = "；".join(str(e) for e in errors[:5])
        raise ValueError(f"种子分类法校验未过：{len(errors)} 错"
                         f"（KB_TAXONOMY_GATE 门禁拒产蓝图）: {head}")


def reset_taxonomy_gate_cache() -> None:
    """清门禁首跑缓存（测试用：换库重校 / 重载校验器；生产链路无需调用）。"""
    _TAXONOMY_GATE_CACHE.clear()


# ── ①④ purpose 前置 + 结构 lint 后置（KB_PURPOSE，默认关）──────────────────

def _prepare_purpose(raw_need) -> "dict | None":
    """① purpose 前置（v2.7 #11 收口波接线；KB_PURPOSE=1 才跑，默认关返回 None
    =零漂移）：derive_purpose 三元组 + route_seeds 种子路由 + suggest_need 桥接
    （三者供 mode/种子路由参考；match_seed 仍为权威路由，前置只记参考不改路由）。
    一句话(str)入参 → suggest_need 产出直接充当引擎 need（build_blueprint 换参）；
    dict 需求 → 由 domain/intent/keywords 确定性拼一句话现场派生，原 need 原样
    喂引擎不替换（桥接产出仅作参考入档）。
    返回 {"purpose": p, "routes": routes, "need": suggest_need 产出}。"""
    if not _env_flag(PURPOSE_ENV):
        return None
    from . import purpose as _purpose          # 惰性载入：开关关时零 import 开销
    if isinstance(raw_need, str):
        p = _purpose.derive_purpose(raw_need)
    elif isinstance(raw_need, dict):
        text = " ".join(x for x in (
            [str(raw_need.get("domain") or ""), str(raw_need.get("intent") or "")]
            + [str(k) for k in (raw_need.get("keywords") or [])]) if x)
        p = _purpose.derive_purpose(text)
    else:  # 非法入参：交既有 validate_need 原口径报错，purpose 只记空文本不拦
        p = _purpose.derive_purpose("")
    return {"purpose": p, "routes": _purpose.route_seeds(p),
            "need": _purpose.suggest_need(p)}


def _attach_purpose(bp_dict: dict, pctx: dict) -> None:
    """④ purpose 意图层落 provenance（随 _attach_lint 旁挂后置跑）：
    三元组 + seed_routes + structure_lint + need_suggested/purpose_md 审计附件
    （结构体检用模块限定名 purpose.lint_blueprint——与 lint.lint_blueprint
    同名不同义，防互踩）；stage_log 记 S7c 行（无 stage_log 的 provenance 跳过
    记日志不崩，键照落）。"""
    from . import purpose as _purpose
    report = _purpose.lint_blueprint(bp_dict)  # 模块限定名！（同名不同义，防互踩）
    p, routes = pctx["purpose"], pctx["routes"]
    bp_dict["provenance"]["purpose"] = {
        "text": p["text"], "domain_guess": p["domain_guess"],
        "keywords": p["keywords"], "intent": p["intent"],
        "seed_routes": routes["routes"], "mode_hint": routes["mode_hint"],
        "need_suggested": pctx["need"],       # suggest_need 桥接参考（供路由/审计）
        "purpose_md": p["purpose_md"],        # purpose.md 文本随附可审计
        "structure_lint": report.as_dict()}
    log = bp_dict["provenance"].get("stage_log")
    if isinstance(log, list):
        dom = (p["domain_guess"] or {}).get("name")
        log.append(f"S7c purpose 意图层: domain_guess={dom} "
                   f"mode_hint={routes['mode_hint']} 种子路由 {routes['seed_count']} 条"
                   f" · 结构体检 {report.summary}")


# ── ⑥ 三视图统一出口（KB_VIEWS，照 KB_GUIDED_LAYER 三态模式，默认关）────────

def _maybe_attach_views(bpd: dict, flag: "bool | str | None" = None) -> dict:
    """⑥ 三视图统一出口（v2.7 #12 收口波接线）：三态开关（显式传参优先，否则 env
    KB_VIEWS；默认关=原样返回零漂移）。开时挂 views.attach_views——只写
    provenance.views_available + stage_log S10 行，原树/槽位/stats/quote 零改动
    （幂等、树缺失防御）；挂载位在 attach_guided_layer 之后（views 接线说明口径）。"""
    if not _flag_on(flag, VIEWS_ENV):
        return bpd
    from . import views as _views_mod
    return _views_mod.attach_views(bpd)


def _try_document_driven(raw_need: dict, depth: str | None = None) -> Optional[dict]:
    """文件驱动模式：检索真实文件 → 提炼框架。检索不足返回 None（降级）。"""
    try:
        from .doc_search import search_all_sources
        from .document_engine import build_blueprint_document_driven
    except ImportError:
        return None

    docs = search_all_sources(raw_need)
    if len(docs) < 10:  # 少于 10 件真实文件 → 降级到 taxonomy
        return None

    bp = build_blueprint_document_driven(raw_need, docs, depth)
    bp["provenance"]["fallback_from"] = None
    bp["provenance"]["doc_count"] = len(docs)
    return bp


# ── ② 冷门域兜底（KB_COLD_EXPAND，默认关）──────────────────────────────────

COLD_WEAK_SCORE = 2   # 冷门判定线：22 大类相关分最高 <2（即 0=别名零命中）视为冷门


def _cold_expand_active(need: dict, match: dict) -> bool:
    """② 冷门域兜底触发判定（收口波接线）：KB_COLD_EXPAND=1 且 clc 模式且 22 大类
    相关分全零（taxonomy 匹配弱=pick_l1 无从择类）。six_domains 模式=强别名命中
    不触发；taxonomy._clc_scores 为 dendron 接线说明明示可用的 l1_code 建议来源。"""
    if not _env_flag(COLD_EXPAND_ENV) or match.get("mode") != "clc":
        return False
    scored = taxonomy._clc_scores(need)
    return bool(scored) and (-scored[0][0]) < COLD_WEAK_SCORE


def _tree_l2_names(tree) -> list:
    """展开树 → L2 组名清单（l1 各根节点的 l2 子层 name，只读）。"""
    return [ch.get("name") for grp in ((tree or {}).get("l1") or [])
            for ch in (grp.get("l2") or []) if ch.get("name")]


def _cold_expand_topics(spec: dict, plan_l2: int):
    """冷门域 L2 供弹兜底（②收口波接线，触发条件见 _cold_expand_active）：
    ① clc_layer.clc_expand(spec 类号) 真实层优先（pip 包缺席/类号无效 → None，
    fail-soft 不抛）；② 类号首字母在 dendron.SCHEMA_22 时 dendron.expand(首字母)
    模板兜底。①②互斥不同时入树（①命中即返回，dendron 接线说明口径）；都无果
    返回 None（维持现状=现状即最终兜底）。组名截到 plan_l2 保既有扇出律。
    返回 (组名列表, 溯源 mode) 或 None。"""
    code = str(spec.get("code") or "")
    tree = clc_layer.clc_expand(code)         # ① 真实层优先
    if tree is not None:
        names = _tree_l2_names(tree)
        if names:
            return names[:plan_l2], "clc_expand"
    if code[:1] in dendron.SCHEMA_22:         # ② 模板兜底（与①互斥）
        tree = dendron.expand(code[:1])
        if tree is not None:
            names = _tree_l2_names(tree)
            if names:
                return names[:plan_l2], "dendron_expand"
    return None


def _build_blueprint_taxonomy(raw_need: dict, depth: str | None = None,
                              schema: str | None = None) -> dict:
    """原 taxonomy 模式（v1 逻辑保持不变；depth 仅放大每 L2 组槽数，结构零改动；
    schema="v2" 时节点增量键落图——见 blueprint.legislate_nodes，缺省零漂移）。

    v2.7 #13：depth=pro/flagship 时叠加 STORM 多视角广度腿（storm_breadth）——
    L2 主题组尾部换入多视角增强组（组数/编号零漂移、只换名）；
    standard/None 不启用（输出与无 STORM 逐字节一致）。

    收口波接线（②冷门域兜底）：KB_COLD_EXPAND=1 且种子匹配弱（clc 模式且 22 大类
    相关分全零=冷门词）时，L2 主题组供弹逐 L1 换 ①clc_layer 真实层 ②dendron 模板
    兜底（互斥），provenance.cold_expand 如实记账；都无果维持现状；默认关零漂移。"""
    need = validate_need(raw_need)
    d = bp.normalize_depth(depth)  # None=standard 兼容：无参输出零漂移
    plan = SIZE_PLANS[need["size_hint"]]
    fpg = bp.scale_slots(plan["fpg"], d) if d else plan["fpg"]
    ratio = RATIO_BY_SIZE[need["size_hint"]]
    h8 = need_hash8(need)
    stage_log = [f"S1 需求解析: domain={need['domain']} size_hint={need['size_hint']} keywords={len(need['keywords'])}"]

    match = taxonomy.match_seed(need)
    stage_log.append(f"S2 种子匹配: mode={match['mode']} seeds={match['seed_taxonomy']}")

    # ② 冷门域兜底（收口波接线）：弱匹配才启用（判定见 _cold_expand_active）
    cold_expand = _cold_expand_active(need, match)
    cold_used: list = []
    if cold_expand:
        stage_log.append("S2c 冷门域兜底: KB_COLD_EXPAND=1 且种子匹配弱（clc 相关分全零）"
                         "→ L2 供弹 clc_layer 优先/dendron 兜底（逐 L1 见 cold_expand 记账）")

    # v2.7 #13 STORM 多视角广度腿：depth=pro/flagship 自动启用（standard/None 零漂移）
    storm_ctx = (storm_breadth.breadth_expand(need["domain"], need["keywords"])
                 if d in ("pro", "flagship") else None)
    storm_blended = 0
    if storm_ctx is not None:
        sm = storm_ctx["metrics"]
        stage_log.append(f"S2b STORM多视角广度: industry={storm_ctx['industry']} "
                         f"视角 {sm['perspectives_used']} → 并集 {sm['union_groups']} 组"
                         f"（单路 {sm['single_path_groups']}，+{sm['breadth_gain']}）")

    l1_specs = taxonomy.pick_l1(need, plan, match["mode"])
    if len(l1_specs) < MIN_L1:  # 防御：极小计划也不破 L1≥8 下限
        l1_specs = taxonomy.pick_l1(need, {"l1": MIN_L1}, match["mode"])
    stage_log.append(f"S3 L1 选类: {len(l1_specs)} 个（上限 {MAX_L1}）")

    ctx = {"idx": 0, "bytes": 0, "files": 0, "dirs": 0, "splits": 0,
           "by_tier": {"core": 0, "field": 0, "guide": 0}, "by_ext": {}}
    l1_nodes = []
    for i, spec in enumerate(l1_specs, 1):
        l1_dir = f"{spec['code']}-{i:02d}"
        l1_node = {"code": spec["code"], "dir": l1_dir, "path": f"{l1_dir}/",
                   "name": spec["name"], "theme": spec["theme"], "source": spec["source"], "l2": []}
        topics = taxonomy.build_l2_topics(spec, need, plan["l2"])
        if cold_expand:  # ② 冷门域兜底：真实层/模板层供弹换入（互斥；无果维持原题）
            cold = _cold_expand_topics(spec, plan["l2"])
            if cold is not None:
                cold_topics, cold_mode = cold
                seen = set(cold_topics)
                # 兜底组名优先，原 build_l2_topics 产出补位到扇出计划（保 L2 组数）
                cold_topics += [t for t in topics if t not in seen]
                topics = cold_topics[:plan["l2"]]
                cold_used.append(f"{spec['code']}:{cold_mode}")
        if storm_ctx is not None:
            topics, added = storm_breadth.blend_topics(spec, topics, plan["l2"], storm_ctx)
            storm_blended += added
        for j, topic in enumerate(topics, 1):
            nn = f"{j:02d}"
            path = f"{l1_dir}/{nn}/"
            slots = _make_slots(topic, spec["name"], need["domain"], path,
                                bp.tier_counts(fpg, ratio), ctx, h8)
            l2 = {"code": f"{l1_dir}/{nn}", "dir": nn, "path": path, "name": topic,
                  "theme": f"{topic}：{spec['name']}主题组文件槽", "file_count": len(slots)}
            if len(slots) > bp.MAX_FILES_PER_DIR:
                safe = sanitize_filename(topic)
                l2["split_dirs"] = bp.split_files(safe, slots, base_path=path)
                l2["files"] = []
                ctx["splits"] += len(l2["split_dirs"])
                ctx["dirs"] += len(l2["split_dirs"])
            else:
                l2["files"] = slots
                ctx["dirs"] += 1
            l1_node["l2"].append(l2)
        stage = f"S4 L2 主题组[{spec['code']}]: {len(l1_node['l2'])} 组"
        if i == 1:
            stage_log.append(stage)
        l1_node["index_md"] = bp.render_l1_index(l1_node)
        for l2 in l1_node["l2"]:
            l2["index_md"] = bp.render_l2_index(l2, l1_node)
        l1_nodes.append(l1_node)
    stage_log.append(f"S5 槽位配比: core/field/guide={ratio['core']}/{ratio['field']}/{ratio['guide']} "
                     f"共 {ctx['files']} 槽")
    if d:  # 轨A4 深度档：如实入日志（无档位时不写，保无参输出零漂移）
        stage_log.append(f"S5b 深度档位: depth={d} 每组槽位 {plan['fpg']}→{fpg} "
                         f"(×{bp.DEPTH_MODES[d]['factor']:g}，下限 {bp.DEPTH_MODES[d]['min_per_l2']})")
    stage_log.append(f"S6 分拆检查: 上限 {bp.MAX_FILES_PER_DIR}/目录，分拆目录 {ctx['splits']} 个")

    s = bp.normalize_schema(schema)
    if s:  # 节点 schema 立法（v2.6 #4）：增量键+README槽+排序落图；枢纽卡随新序重渲染
        n_readme = bp.legislate_nodes(l1_nodes)
        for l1_node in l1_nodes:
            l1_node["index_md"] = bp.render_l1_index(l1_node)
            for l2 in l1_node["l2"]:
                l2["index_md"] = bp.render_l2_index(l2, l1_node)
        stage_log.append(f"S6b 节点 schema 立法: schema={s} L1/L2 增量键 + 00-README槽 {n_readme} 粒"
                         "（README 不入 files 不计 stats）")

    gb = round(ctx["bytes"] / 1024 ** 3, 2)
    stats = {"files": ctx["files"], "bytes": ctx["bytes"], "gb": gb,
             "by_tier": ctx["by_tier"], "by_ext": ctx["by_ext"],
             "l1_count": len(l1_nodes), "l2_count": sum(len(x["l2"]) for x in l1_nodes),
             "dir_count": ctx["dirs"], "split_dir_count": ctx["splits"]}
    quote = dict(QUOTE_PARAMS, total=round(QUOTE_PARAMS["base"] + gb * QUOTE_PARAMS["per_gb"], 1))
    stage_log.append(f"S7 统计与报价: gb={gb} quote.total={quote['total']}")
    provenance = {"engine_version": ENGINE_VERSION, "seed_taxonomy": match["seed_taxonomy"],
                  "stage_log": stage_log}
    if d:
        provenance["depth"] = d  # 轨A4：实际档位如实记录（无参不写键，保零漂移）
    if storm_ctx is not None:  # v2.7 #13：STORM 增强入档（standard/None 不写键）
        sm = storm_ctx["metrics"]
        provenance["storm"] = {"enabled": True, "industry": storm_ctx["industry"],
                               "perspectives": storm_ctx["perspectives"],
                               "union_groups": sm["union_groups"],
                               "single_path_groups": sm["single_path_groups"],
                               "breadth_gain": sm["breadth_gain"],
                               "groups_blended": storm_blended}
    if cold_used:  # ② 冷门域兜底实绩如实入档（未触发/都无果不写键）
        provenance["cold_expand"] = {"enabled": True, "l1_source": cold_used}
    if s:
        provenance["node_schema"] = s  # v2.6 #4：节点 schema 档位如实记录（无参不写键）
    tree = {"mode": match["mode"], "root": need["domain"], "l1": l1_nodes}
    return bp.assemble_blueprint(need["domain"], need, tree, ratio, stats, quote, provenance)


def _make_slots(topic, l1_name, domain, path, counts, ctx, h8):
    """按配比造占位槽：{主题}_{类型}_{序号}.{ext}；徽章按全局序轮转（确定性）。"""
    slots = []
    for tier in bp.TIERS:
        for k in range(1, counts[tier] + 1):
            ext = pick_ext(tier, k)
            name = f"{sanitize_filename(topic)}_{tier}_{k:03d}.{ext}"
            badge = badge_for_index(ctx["idx"])
            perm = PERM_BY_BADGE[badge]
            slot = {"name": name, "path": path, "tier": tier, "ext": ext}
            slot.update(make_slot(name=name, tier=tier, ext=ext, theme=topic, l1_name=l1_name,
                                  domain=domain, path=path, badge=badge, perm=perm,
                                  idx=ctx["idx"], need_hash8=h8))
            slots.append(slot)
            ctx["idx"] += 1
            ctx["bytes"] += EXT_BYTES[ext]
            ctx["by_tier"][tier] += 1
            ctx["by_ext"][ext] = ctx["by_ext"].get(ext, 0) + 1
    ctx["files"] += len(slots)
    return slots


# ── 证据回流加权（W5.5：蓝图结构 × 渠道真实命中联动）────────────────────
# 数据来源：channel_adapters.enrich.enrich_blueprint 把 per-L2 渠道命中数写进
# bp.provenance.hit_counts（L2 组名 → int）；本函数按 hot/cold 双阈缩放组文件槽
# 并重算全局 ratio（最大余数法，和恒=100）。纯蓝图结构操作：零网络、零下载。

_SLOT_ID_RE = re.compile(r"^KBC1-([0-9a-f]{8})-(\d{6})$")
_MIN_SLOTS = 3  # cold 缩减下限保底（再冷的主题组也保 3 槽，防空节点）


def _l2_slots(l2: dict) -> list:
    """L2 组文件槽列表（files 优先，分拆组拍平；只取引用不改结构）。"""
    if l2.get("files"):
        return l2["files"]
    return [f for sd in l2.get("split_dirs", []) for f in sd.get("files", [])]


def _scan_identifiers(bp_dict: dict, l1_nodes: list) -> tuple:
    """扫全蓝图槽位 identifier（KBC1-{h8}-{idx:06d}）：返回 (h8, 下一全局 idx)。
    无既有 identifier 时 h8 退回 need_hash8(bp.need)，idx 从 0 起（确定性）。"""
    h8, best = None, -1
    for l1 in l1_nodes:
        for l2 in l1.get("l2", []):
            for s in _l2_slots(l2):
                m = _SLOT_ID_RE.match(s.get("identifier") or "")
                if m:
                    h8 = h8 or m.group(1)
                    best = max(best, int(m.group(2)))
    if h8 is None:
        need = bp_dict.get("need")
        h8 = need_hash8(need) if isinstance(need, dict) else "00000000"
    return h8, best + 1


def _grow_group(l2: dict, slots: list, target: int, ratio: dict, domain: str,
                l1_name: str, h8: str, start_idx: int) -> int:
    """组尾追加占位槽至 target 个：tier 配额 = tier_counts(target, ratio) 与组内
    现有三档实数的正差（TIERS 序派发）；占位槽造法与 _make_slots 同款（确定性）。
    追加不触碰既有槽（渠道回填的真实值原样保留）。返回追加后的全局 idx。"""
    now = {t: sum(1 for s in slots if s.get("tier") == t) for t in TIERS}
    tgt = tier_counts(target, ratio)
    used = {s.get("name") for s in slots}
    stem = sanitize_filename(l2.get("name", ""))
    path, theme = l2.get("path", ""), l2.get("name", "")
    idx = start_idx
    for t in TIERS:
        k = now[t]
        for _ in range(max(0, tgt[t] - now[t])):
            k += 1
            ext = pick_ext(t, k)
            name = f"{stem}_{t}_{k:03d}.{ext}"
            while name in used:  # 防与渠道回填的真实文件名撞车
                k += 1
                ext = pick_ext(t, k)
                name = f"{stem}_{t}_{k:03d}.{ext}"
            badge = badge_for_index(idx)
            slot = {"name": name, "path": path, "tier": t, "ext": ext}
            slot.update(make_slot(name=name, tier=t, ext=ext, theme=theme,
                                  l1_name=l1_name, domain=domain, path=path,
                                  badge=badge, perm=PERM_BY_BADGE[badge],
                                  idx=idx, need_hash8=h8))
            slots.append(slot)
            used.add(name)
            idx += 1
    return idx


def _ratio_from_tiers(counts: dict) -> dict:
    """三档槽位实数 → 百分比配比（最大余数法，和恒=100；口径同 tier_counts）。"""
    total = sum(counts.get(t, 0) for t in TIERS)
    floors = {t: counts.get(t, 0) * 100 // total for t in TIERS}
    rem = 100 - sum(floors.values())
    order = sorted(TIERS, key=lambda t: (-(counts.get(t, 0) * 100 / total - floors[t]),
                                         TIERS.index(t)))
    for t in order[:rem]:
        floors[t] += 1
    return floors


def adjust_structure(bp: dict, hit_counts: dict | None, hot: int = 8, cold: int = 2) -> dict:
    """证据回流加权：按 per-L2 渠道命中数（provenance.hit_counts，组名→int）
    缩放组文件槽，并重算 bp.ratio 配比段使总和仍=100%。

    - 命中 ≥hot 的 L2 组：文件槽 ×1.5（round）；≤cold 的组：×0.7 且下限保底 3 槽
      （0 槽组与中间带不动）；阈值区间重叠时 hot 规则优先（规格顺序）。
      round 为 Python 内建（银行家舍入，奇数组 ×1.5 取偶）。
    - 增删只动组尾：新增为确定性占位槽（tier 配额按 tier_counts(target, ratio)
      派发，真实回填槽原样保留）；缩减从组尾丢弃。
    - 组槽数变化后同步 l2.file_count，超 200 按受控扇出律重新分拆；
      stats/quote 是引擎 S7 快照，不在此重算（改结构不改价）。
    - hit_counts 为 None/空、树缺失、或无任何组实际变化 → 原样返回 bp（零副作用）。
    - 同名 L2 组（跨 L1）共享同一命中计数，会被同等加权（引擎生成名带序号，基本唯一）。

    纯函数式契约：就地修改并返回同一 bp（与 enrich_blueprint 同风格）；
    无随机源、无时钟，同输入必同输出。
    """
    if not hit_counts:
        return bp
    l1_nodes = (bp.get("tree") or {}).get("l1") or []
    if not l1_nodes:
        return bp
    domain = bp.get("domain", "")
    ratio = bp.get("ratio") or {"core": 50, "field": 35, "guide": 15}
    h8, idx = _scan_identifiers(bp, l1_nodes)
    grew = shrunk = 0
    for l1 in l1_nodes:
        for l2 in l1.get("l2", []):
            hits = hit_counts.get(l2.get("name", ""))
            if hits is None:
                continue  # 未覆盖组原样不动
            slots = _l2_slots(l2)
            n = len(slots)
            if n == 0:
                continue  # 空组不参与缩放（空节点是引擎/lint 议题）
            if hits >= hot:
                target = round(n * 1.5)
            elif hits <= cold:
                target = max(_MIN_SLOTS, round(n * 0.7))
            else:
                continue  # 中间带不动
            if target == n:
                continue
            if target > n:
                idx = _grow_group(l2, slots, target, ratio, domain,
                                  l1.get("name", ""), h8, idx)
                grew += 1
            else:
                del slots[target:]  # 组尾丢弃（占位尾先走，真实回填槽在前段）
                shrunk += 1
            l2["file_count"] = len(slots)  # 组内结构落账
            if len(slots) > MAX_FILES_PER_DIR:
                l2["files"] = []
                l2["split_dirs"] = split_files(sanitize_filename(l2.get("name", "")),
                                               slots, base_path=l2.get("path", ""))
            else:
                l2["files"] = slots
                l2.pop("split_dirs", None)
    if not (grew or shrunk):
        return bp
    counts = {}
    for l1 in l1_nodes:
        for l2 in l1.get("l2", []):
            for s in _l2_slots(l2):
                t = s.get("tier", "guide")
                counts[t] = counts.get(t, 0) + 1
    if sum(counts.get(t, 0) for t in TIERS) > 0:
        bp["ratio"] = _ratio_from_tiers(counts)  # 实际三档构成 → 和恒=100
    prov = bp.get("provenance")
    if isinstance(prov, dict):
        prov["evidence_weighting"] = {"hot": hot, "cold": cold,
                                      "groups_grew": grew, "groups_shrunk": shrunk}
        log = prov.get("stage_log")
        if isinstance(log, list):
            log.append(f"S9 证据回流加权: hot>={hot}×1.5 {grew}组 / cold<={cold}×0.7 "
                       f"{shrunk}组 → ratio {bp['ratio'].get('core')}/"
                       f"{bp['ratio'].get('field')}/{bp['ratio'].get('guide')}")
    return bp
