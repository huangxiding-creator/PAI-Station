# -*- coding: utf-8 -*-
"""kb_generate —— TCB Python 云函数（小程序知识库蓝图实时化·首版）。

职责：event={"text": str, "depth"?, "guided"?} → 真跑 kb_factory.catalog_engine
（stdlib only 纯规则引擎，零第三方依赖、零 LLM 调用）→ 蓝图 bp dict 返回。

收口波B 开关面（env 详表见 DEPLOY.md；缺省全关=输出逐字节零漂移）：
- event.guided → build_blueprint(guided=) 三态透传（导览层，v2.6 #7）；
- KB_PURPOSE / KB_VIEWS 生产建议开（纯代码路径，引擎自读 env，包内无 seeds
  数据时 purpose.route_seeds 如实记 unavailable_skipped、词池回退内置表）。

铁律（与站内一致）：
- 云函数首版=纯引擎：mode 固定 "taxonomy"，不打包 channel_adapters（渠道 enrich
  留服务器侧后续）；不打真网络，同输入必同输出（确定性）。
- 传输瘦身照抄 tools/gen_kbfactory_samples.py 的视图口径（样本=同构契约）：
  槽位只留展示字段（name/tier/ext/size/icon/src/perm 标签），每主题组截断到
  keep 条（200KB 预算逐档收紧），统计/报价恒为引擎全量真值。
- 数字零造假：quote/lstats 全部来自引擎实测，键名适配 UI（import_add）。

入口：main(event, context=None)（别名 main_handler 兼容 SCF 命名）；
text 为空 → raise ValueError（客户端 callFunction 视为失败走本地兜底）。
"""
from __future__ import annotations

import json
import os
import re
import sys

# ── 打包形态：kb_factory 子集与本文件同目录；本地开发形态：从仓库 kb_factory 根直跑 ──
_HERE = os.path.dirname(os.path.abspath(__file__))
if _HERE not in sys.path:
    sys.path.insert(0, _HERE)
try:
    from kb_factory.catalog_engine import ENGINE_VERSION, build_blueprint
except ImportError:  # 未 pack 时的仓库内直跑（sys.path 指到 kb_factory 根）
    _KB_ROOT = os.path.dirname(os.path.dirname(_HERE))
    if os.path.isdir(os.path.join(_KB_ROOT, "catalog_engine")):
        sys.path.insert(0, _KB_ROOT)
        from catalog_engine import ENGINE_VERSION, build_blueprint
    else:
        raise

# ── depth → size_hint 映射（SIZE_PLANS 键即权威口径）──
_SIZE_ORDER = ("small", "medium", "large", "huge")
_DEPTH_ALIAS = {"s": "small", "m": "medium", "l": "large", "h": "huge"}
DEFAULT_SIZE_HINT = "large"  # 与本地旗舰演示样本同档（demo 对齐，非手填数字）

# ── 视图映射（逐字照抄 gen_kbfactory_samples.py：样本即 UI 契约）──
BADGE_DISPLAY = {"green_free": ("🟢", "公开资料"), "wenku_vip": ("🟡", "会员资料"),
                 "ima_public": ("🔵", "共享资料"), "gb_free": ("🏛️", "官方标准"),
                 "self_owned": ("🟢", "自有资料")}
PERM_DISPLAY = {"green": "可自由使用", "yellow": "会员可用", "red": "单独审批"}

MAX_TRANSPORT_BYTES = 200 * 1024  # 与包内样本同一预算（≤200KB）
KEEPS = (3, 2, 1)                 # 每主题组保留条目数（超预算逐档收紧）

_SPLIT_RE = re.compile(r"[，。、,.;；:：!！?？·/\\\s()\[\]（）【】]+")


def _depth_to_size(depth) -> str:
    """depth（small/medium/large/huge | s/m/l/h | 1..4）→ SIZE_PLANS 键；非法一律默认档。"""
    if depth is None or isinstance(depth, bool):
        return DEFAULT_SIZE_HINT
    if isinstance(depth, int):
        return _SIZE_ORDER[depth - 1] if 1 <= depth <= 4 else DEFAULT_SIZE_HINT
    s = str(depth).strip().lower()
    if s in _SIZE_ORDER:
        return s
    if s in _DEPTH_ALIAS:
        return _DEPTH_ALIAS[s]
    if s.isdigit():
        n = int(s)
        return _SIZE_ORDER[n - 1] if 1 <= n <= 4 else DEFAULT_SIZE_HINT
    return DEFAULT_SIZE_HINT


def _extract_keywords(text: str, limit: int = 5) -> list:
    """自由文本 → 关键词列表（分隔符切词，2..12 字保留，去重保序，确定性）。"""
    out, seen = [], set()
    for tok in _SPLIT_RE.split(text):
        tok = tok.strip()
        if 2 <= len(tok) <= 12 and tok not in seen:
            seen.add(tok)
            out.append(tok)
        if len(out) >= limit:
            break
    return out or [text[:12]]


def _need_from_text(text: str, depth) -> dict:
    """自由文本 → 引擎需求 JSON（validate_need 四键）。"""
    domain = re.sub(r"\s+", " ", text.strip())[:30]
    return {"domain": domain, "keywords": _extract_keywords(text),
            "intent": "知识库建设", "size_hint": _depth_to_size(depth)}


def _fmt_size(kb) -> str:
    kb = kb or 0
    return f"{kb / 1024:.1f}MB" if kb >= 1024 else f"{kb}KB"


def _slim_slot(s: dict) -> dict:
    icon, src = BADGE_DISPLAY.get(s.get("badge"), ("🟢", "公开资料"))
    return {"name": s["name"], "tier": s["tier"], "ext": s["ext"],
            "size": _fmt_size(s.get("size_kb")), "icon": icon, "src": src,
            "perm": PERM_DISPLAY.get(s.get("perm"), "可自由使用")}


def to_view(bp: dict, keep: int) -> dict:
    """引擎蓝图 → 传输视图（与包内样本同构）：槽位瘦身+每组截断+报价键适配。"""
    kept = 0
    l1_out = []
    for l1 in bp["tree"]["l1"]:
        l2_out = []
        for l2 in l1["l2"]:
            pool = l2.get("files") or (l2["split_dirs"][0]["files"] if l2.get("split_dirs") else [])
            files = [_slim_slot(s) for s in pool[:keep]]
            kept += len(files)
            l2_out.append({"code": l2["code"], "name": l2["name"], "path": l2["path"],
                           "file_count": l2["file_count"], "files": files})
        l1_out.append({"code": l1["code"], "dir": l1["dir"], "name": l1["name"],
                       "theme": l1["theme"], "l2_count": len(l1["l2"]), "l2": l2_out})
    tree = {"mode": bp["tree"]["mode"], "root": bp["tree"]["root"], "l1": l1_out}
    q = dict(bp["quote"])
    q["import_add"] = q.pop("ima_add")
    return {"domain": bp["domain"], "need": bp["need"], "tree": tree, "ratio": bp["ratio"],
            "stats": bp["stats"], "quote": q, "provenance": bp["provenance"],
            "_remote": {"engine_version": ENGINE_VERSION, "truncated": True,
                        "kept_per_group": keep, "kept_files": kept,
                        "files_total": bp["stats"]["files"],
                        "note": "实时蓝图：每主题组仅保留前 %d 个条目并精简为展示字段；"
                                "统计与报价为引擎全量真值，完整蓝图由编目引擎按需再生" % keep}}


def main(event, context=None):
    event = event or {}
    text = str(event.get("text") or "").strip()
    if not text:
        raise ValueError("text 不能为空")
    need = _need_from_text(text, event.get("depth"))
    # depth 双口径：standard/pro/flagship=蓝图深度档（轨A4）透传引擎按档放大文件槽；
    # small..huge 等旧规模值由引擎归一为 standard（现状零漂移），规模仍由 size_hint 承担
    # guided 三态透传（v2.6 #7 导览层）：True/False/"1"/"0" 显式开/关优先，
    # 缺省 None=引擎看环境变量 KB_GUIDED_LAYER（默认关=输出零漂移）——
    # 开启时首 L1 前插「00-导览」（📥收件箱+五类实体索引），视图层同构兼容
    bp = build_blueprint(need, mode="taxonomy", depth=event.get("depth"),
                         guided=event.get("guided"))
    for keep in KEEPS:  # 200KB 预算逐档收紧（与样本同一纪律）
        view = to_view(bp, keep)
        if len(json.dumps(view, ensure_ascii=False, separators=(",", ":")).encode("utf-8")) \
                <= MAX_TRANSPORT_BYTES:
            return view
    return view  # keep=1 仍超：如实返回（极限长域名才会发生）


main_handler = main  # SCF/TCB 双入口命名兼容
