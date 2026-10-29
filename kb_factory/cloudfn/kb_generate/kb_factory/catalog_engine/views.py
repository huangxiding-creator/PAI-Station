# -*- coding: utf-8 -*-
"""一份数据三棵树视图（v2.7 #12，巨人 obsidian-dataview + Wiki.js——一树多导航模式）。

设计蓝本（双巨人，均 MIT）：
  - obsidian-dataview：笔记本体只有一份（vault=磁盘真相），「视图」=对同一份
    元数据的不同查询投影——不复制、不搬家、不回写；
  - Wiki.js：一棵内容树配多套导航入口（按类目/按标签/按时间），导航层是薄壳，
    内容层零改动。
本模块即该模式的三棵投影树：文件本体在原蓝图树上只有一份，三视图只存
「文件引用 + 结构化元数据标注」，互相独立、原树零改动。

交付入口（纯 stdlib、零 LLM、零网络；无随机源无时钟，同输入必同输出）：
  build_views(bp)   一份蓝图 → {"by_topic", "by_phase", "by_type", "metrics"}
      by_topic 主题视图（=现有树）：L1→L2 组名 + 文件引用的轻量镜像
                （分拆组拍平回所属 L2 组——受控扇出是存储机制非主题层）
      by_phase 阶段视图：前期报批/勘察设计/施工建造/质量验收/运维检修——按
                「文件名+tier+组名」关键词映射，映射表显式=PHASE_ORDER×PHASE_KEYWORDS
                （模块常量；组名口径=v2.7 #12 规约全名，非缩写）
      by_type  类型视图：标准规范/合同范本/研究报告/案例实录/数据报表——fmt 优先
                （xlsx/csv/tsv→数据报表）+ 标题启发，规则表显式=
                TYPE_ORDER×TYPE_KEYWORDS+STD_NO_RE（组名口径同上=v2.7 #12 规约全名）
      两表未命中一律 → 「待归类」（UNMAPPED，如实不编造：宁缺勿假）
      每文件在三视图各恰属一个主组（分区律）；metrics 是全档分布账
      （含 0 档如实计数），树节点滤空组（轻量）。
  attach_views(bp, views=None)
                provenance.views_available 如实记录三视图可用（files 守恒数/
                两视图分布/未命中数/tree_touched=False）+ stage_log 追加「S10
                视图层」行；只写 provenance，原 tree/槽位/stats/quote 零改动；
                幂等（重复挂载不重复记账）；树缺失原样返回（防御）。

消费纪律（任务规约：不新增键只消费）：
  文件引用的 meta 标注只读槽位既有键——catalog.clc_no（编目四件套）、
  fmt（v2 槽；v1 槽的同义既有键 ext 回退）、tier（v1 槽自带；v2 槽无此键
  → None 如实）、L2 组名（树上下文）。本模块绝不向 slot/l1/l2 写任何键。
  引用键 ref = L2.path + 槽位文件名（引擎不变量：组内文件名唯一，validate_tree
  守护；全库路径前缀互异 → ref 全库唯一）。

零漂移纪律：本模块不被 engine/blueprint 引用（【禁碰】件零触碰），
  不 import 任何可变全局；引擎缺省输出逐字节不变，既有测试钉子不破。

收口波接线说明（本轮 engine.py/blueprint.py 禁碰，收口波统一接线防互踩）：
  1. engine.build_blueprint 统一出口：在 attach_guided_layer(...) 之后追加
     `from . import views as _views; _views.attach_views(bp)`。注意 attach 会
     写 provenance → canonical_json 全蓝图哈希会变：要么按 KB_GUIDED_LAYER
     三态开关模式加 KB_VIEWS 开关（建议，默认关=零漂移），要么同步刷新
     test_guided_layer.PINNED 并在提交说明注明变更来源（防静默漂移）。
  2. 视图本体【不建议】嵌入蓝图 JSON（payload≈N×3 份引用，蓝图会虚胖）：
     展示层按需调 build_views(bp) 即时重算（纯函数、一次树遍历的开销，
     云函数/端上皆可），或服务端预算后随蓝图单独下发 bp 之外的 views 字段。
  3. cloudfn/kb_generate：把本文件同步进 vendored
     kb_factory/catalog_engine/ 目录（云函数吃同一份引擎代码）。
  4. 小程序蓝图页 UI（收口波）：页面顶部加三 tab（主题/阶段/类型，文案=
     VIEW_LABELS），数据源=build_views(bp)；每个 tab 渲染 view["groups"]
     （by_topic 为 L1→L2 两级嵌套，by_phase/by_type 为平铺组；组名一律
     verbatim 取 PHASE_ORDER/TYPE_ORDER=v2.7 #12 规约全名，UI 不得另起缩写），
     文件行展示 meta 标注（fmt/tier/clc_no/所属组），「待归类」组恒排尾部并
     如实计数——UI 侧禁止二次猜测补映射（映射只在 PHASE_KEYWORDS/
     TYPE_KEYWORDS 显式表内，改表即改口径，单一事实源）。
"""
from __future__ import annotations

import re

__all__ = ["VIEWS", "VIEW_LABELS", "UNMAPPED", "DESIGN_ORIGIN",
           "PHASE_ORDER", "PHASE_KEYWORDS", "TYPE_ORDER", "TYPE_KEYWORDS",
           "DATA_TABLE_FMTS", "STD_NO_RE", "phase_for", "type_for",
           "build_views", "attach_views"]

DESIGN_ORIGIN = "obsidian-dataview + Wiki.js 一树多导航（均 MIT）"

VIEWS = ("by_topic", "by_phase", "by_type")
VIEW_LABELS = {"by_topic": "主题", "by_phase": "阶段", "by_type": "类型"}
UNMAPPED = "待归类"  # 两张映射表的诚实兜底桶：未命中即入此，禁编造归类

# ── 阶段视图映射表（显式；匹配文本=文件名+tier+组名，PHASE_ORDER 声明序首中胜）──
# 词表刻意用组合词防跨阶段误抢：「施工组织设计」不含「初步设计/施工图设计」→
# 落施工建造；「初步设计报告」先在「勘察设计」档命中「初步设计」（声明序
# 勘察设计先于施工建造，「施工图设计」类词不致被裸「施工」抢走）。词表不含
# tier 值（core/field/guide 是质量档非阶段信号，映射即编造）；tier 计入匹配
# 文本只为调用方可见其参与（零命中时它不提供任何伪信号）。
PHASE_ORDER = ("前期报批", "勘察设计", "施工建造", "质量验收", "运维检修")
PHASE_KEYWORDS = {
    "前期报批": ("立项", "项目建议书", "可行性研究", "可研", "预可研", "报批",
               "审批", "核准", "备案", "环评", "环境影响", "水土保持", "征地",
               "移民安置", "规划", "许可", "申请书", "招标", "投标", "评估"),
    "勘察设计": ("勘察设计", "初步设计", "施工图设计", "技术设计", "方案设计",
               "设计报告", "设计说明", "设计计算", "图纸", "地质勘察", "工程测绘",
               "枢纽布置"),
    "施工建造": ("施工", "建造", "浇筑", "灌浆", "基坑", "安装", "进度", "工序",
               "工艺", "质量控制", "质量检测", "试验检测", "安全生产", "安全专项",
               "监理", "应急预案"),
    "质量验收": ("验收", "竣工", "结算", "决算", "审计", "移交", "质量评定"),
    "运维检修": ("运行维护", "运行管理", "运维", "检修", "养护", "维修", "后评价",
               "调度运用"),
}

# ── 类型视图规则表（显式；fmt 优先=xlsx/csv/tsv 直判数据报表，余按声明序标题启发）──
TYPE_ORDER = ("标准规范", "合同范本", "研究报告", "案例实录", "数据报表")
DATA_TABLE_FMTS = ("xlsx", "csv", "tsv")  # 电子表格=强格式信号（fmt 优先档）
TYPE_KEYWORDS = {
    "标准规范": ("标准", "规范", "规程", "导则", "定额", "图集"),
    "合同范本": ("范本", "模板", "合同", "协议", "文书", "示范文本"),
    "研究报告": ("研究报告", "调研报告", "行业报告", "市场报告", "市场分析",
               "白皮书", "蓝皮书", "专题研究", "趋势报告"),
    "案例实录": ("案例", "实例", "实战", "实务"),
    "数据报表": ("清单", "台账", "数据表", "数据集", "统计表", "报表", "明细表"),
}
# 标准号正则（标准规范档加成）：GB/SL/DL/JGJ/ISO… 编号起头（前置字母防误吞英文词）
STD_NO_RE = re.compile(r"(?<![A-Za-z])(?:GB/Z|GB/T|GB|SL|DL/T|DL|JGJ|JT|TB|CJJ|"
                       r"NB|WS|YY|HG|SH|SY|QB|YB|ISO|IEC|ASTM|EN|DIN|JIS|BS)\s*\d")


# ── 槽位只读小件（不 import 引擎私有件；只消费既有键，零回写）────────────────

def _slots_of(l2: dict) -> list:
    """L2 组文件槽列表（files 优先，分拆组拍平；只读不改）。"""
    if l2.get("files"):
        return l2["files"]
    return [f for sd in l2.get("split_dirs") or [] for f in sd.get("files") or []]


def _fmt_of(slot: dict) -> str:
    """格式标注：v2 槽 fmt 优先，v1 槽同义既有键 ext 回退，再无则从文件名尾
    扩展名解析（口径同 cataloging._ext_of，纯既有键推导）；缺 → ""（如实）。"""
    fmt = str(slot.get("fmt") or slot.get("ext") or "").strip().lower()
    if not fmt:
        stem, _, tail = str(slot.get("name") or "").rpartition(".")
        if stem and tail and 1 <= len(tail) <= 5 and tail.isascii() and tail.isalnum():
            fmt = tail.lower()
    return fmt


def _title_of(slot: dict) -> str:
    """类型启发用题名：catalog.clean_title（编目四件套净题名）> title > name。"""
    cat = slot.get("catalog")
    if isinstance(cat, dict) and str(cat.get("clean_title") or "").strip():
        return str(cat["clean_title"])
    return str(slot.get("title") or slot.get("name") or "")


def phase_for(name: str, tier, group: str) -> str:
    """阶段归类：匹配文本=文件名+tier+组名，PHASE_ORDER 声明序首个命中关键词的
    阶段胜；全未命中 → 「待归类」（如实不编造）。纯函数，确定性。"""
    text = f"{name or ''} {tier or ''} {group or ''}"
    for phase in PHASE_ORDER:
        if any(k in text for k in PHASE_KEYWORDS[phase]):
            return phase
    return UNMAPPED


def type_for(slot: dict) -> str:
    """类型归类：① fmt ∈ DATA_TABLE_FMTS → 数据报表（电子表格强信号）；
    ② TYPE_ORDER 声明序标题启发（标准规范档另加标准号正则 STD_NO_RE）；
    全未命中 → 「待归类」。纯函数，确定性。"""
    if _fmt_of(slot) in DATA_TABLE_FMTS:
        return "数据报表"
    title = _title_of(slot)
    for t in TYPE_ORDER:
        if t == "标准规范" and STD_NO_RE.search(title):
            return t
        if any(k in title for k in TYPE_KEYWORDS[t]):
            return t
    return UNMAPPED


def _ref(slot: dict, l2: dict) -> dict:
    """文件引用 + 结构化元数据标注：只读槽位既有键（catalog.clc_no / fmt|ext /
    tier）与 L2 组名，不向 slot 新增任何键（消费侧投影，零回写）。缺键如实 None。"""
    cat = slot.get("catalog")
    return {
        "ref": f"{l2.get('path') or ''}{slot.get('name') or ''}",  # 全库唯一引用键
        "name": str(slot.get("name") or ""),
        "meta": {
            "clc_no": cat.get("clc_no") if isinstance(cat, dict) else None,
            "fmt": _fmt_of(slot) or None,
            "tier": slot.get("tier"),            # v2 槽无此键 → None 如实
            "group": str(l2.get("name") or ""),  # 原树 L2 主组名
        },
    }


# ── 三视图主入口 ───────────────────────────────────────────────────────────

def build_views(bp: dict) -> dict:
    """一份数据三棵树视图（纯只读消费：原树/槽位零改动，禁写回）。

    返回 {"by_topic", "by_phase", "by_type", "metrics", "origin"}：
    守恒律=三视图文件引用数恒等于原清单有效槽位数（每槽恰产一 ref，
    三视图共享同一批引用对象——文件本体一份，导航三份）。"""
    l1_nodes = ((bp or {}).get("tree") or {}).get("l1") or []
    topic = []
    phase_b = {p: [] for p in PHASE_ORDER}
    type_b = {t: [] for t in TYPE_ORDER}
    phase_b[UNMAPPED] = []
    type_b[UNMAPPED] = []
    total = 0
    for l1 in l1_nodes:
        sub = []
        for l2 in l1.get("l2") or []:
            refs = []
            for slot in _slots_of(l2):
                if not isinstance(slot, dict):
                    continue  # 防御：非 dict 槽不进视图（守恒口径=有效槽位数）
                r = _ref(slot, l2)
                refs.append(r)
                total += 1
                phase_b[phase_for(r["name"], slot.get("tier"), r["meta"]["group"])].append(r)
                type_b[type_for(slot)].append(r)
            sub.append({"name": str(l2.get("name") or ""), "path": str(l2.get("path") or ""),
                        "files": refs})
        topic.append({"name": str(l1.get("name") or ""), "path": str(l1.get("path") or ""),
                      "groups": sub})

    def _buckets(order, buckets):
        """声明序出非空组（待归类恒排尾部；空组滤除=轻量，0 档进 metrics 账）。"""
        return [{"name": g, "files": buckets[g]} for g in (*order, UNMAPPED) if buckets[g]]

    return {
        "origin": DESIGN_ORIGIN,
        "by_topic": {"key": "by_topic", "label": VIEW_LABELS["by_topic"],
                     "origin": "existing_tree（=现有树轻量镜像，分拆组拍平）",
                     "groups": topic},
        "by_phase": {"key": "by_phase", "label": VIEW_LABELS["by_phase"],
                     "origin": "keyword_map（PHASE_ORDER×PHASE_KEYWORDS：文件名+tier+组名）",
                     "groups": _buckets(PHASE_ORDER, phase_b)},
        "by_type": {"key": "by_type", "label": VIEW_LABELS["by_type"],
                    "origin": "fmt+title（TYPE_ORDER×TYPE_KEYWORDS+STD_NO_RE：fmt 优先）",
                    "groups": _buckets(TYPE_ORDER, type_b)},
        "metrics": {
            "files": total,
            "by_phase": {g: len(phase_b[g]) for g in (*PHASE_ORDER, UNMAPPED)},
            "by_type": {g: len(type_b[g]) for g in (*TYPE_ORDER, UNMAPPED)},
            "unmapped": {"by_phase": len(phase_b[UNMAPPED]),
                         "by_type": len(type_b[UNMAPPED])},
        },
    }


def attach_views(bp: dict, views: dict | None = None) -> dict:
    """三视图可用性进 provenance（附送感如实记账）：只写 provenance.views_available
    与 stage_log「S10 视图层」行——原 tree/槽位/stats/quote 零改动（tree_touched
    恒 False 是实测口径非承诺口径）；幂等；树缺失原样返回（防御，同 attach_guided_layer
    风格：就地修改并返回同一 dict）。"""
    l1_nodes = ((bp or {}).get("tree") or {}).get("l1")
    if not isinstance(l1_nodes, list) or not l1_nodes:
        return bp  # 无树无视图：不记账不动蓝图
    v = views if views is not None else build_views(bp)
    m = v["metrics"]
    prov = bp.setdefault("provenance", {})
    prov["views_available"] = {
        "views": list(VIEWS),
        "design_origin": DESIGN_ORIGIN,
        "files": m["files"],
        "by_phase": m["by_phase"],
        "by_type": m["by_type"],
        "unmapped": m["unmapped"],
        "tree_touched": False,  # build_views 纯只读的如实自证
    }
    log = prov.get("stage_log")
    if not isinstance(log, list):
        log = []
        prov["stage_log"] = log
    if not any(str(x).startswith("S10 视图层") for x in log):  # 幂等：不重复记账
        log.append(f"S10 视图层: 三视图可用 by_topic/by_phase/by_type · "
                   f"{m['files']} 件引用守恒 · 未命中待归类 by_phase="
                   f"{m['unmapped']['by_phase']}/by_type={m['unmapped']['by_type']} · 原树零改动")
    return bp
