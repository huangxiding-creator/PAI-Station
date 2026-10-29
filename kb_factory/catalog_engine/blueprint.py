# -*- coding: utf-8 -*-
"""蓝图 JSON 构造：三级树节点、路径编号（如 F-03/02/）、_INDEX.md 枢纽卡、
>200 分拆、配比分档、规范化输出、导览层标配挂载。

节点 schema 立法（v2.6 #4，巨人 Docusaurus+BookStack 双 MIT）：
  schema="v2"（或 env KBCAT_NODE_SCHEMA=v2，缺省关=零漂移）时 L1/L2 容器节点
  增量带 position/kind/icon/color/duty（一句职责≤20字，从种子主题描述派生，
  无来源留空禁编造），每 L2 组挂一粒「00-README」索引文档槽（readme_slot 键，
  不入 files 不计 stats）；排序算子四连（position → 数字前缀 → 字母序 → 原序
  稳定）；防环护栏 validate_tree 四查（环/孤儿/断裂/无归属）build 末尾自动跑。

导览层（v2.6 #7，巨人 kepano-obsidian MIT——拥有感设计）：
  生成管线可标配挂载「00-导览」首 L1 组（position 最前）：📥-收件箱
  （kepano Inbox 分型律首目录）+ 五类实体索引页 01-行业标准索引 /
  02-案例库索引 / 03-合同范本索引 / 04-机构名录 / 05-项目台账
  （kind=container 各带一句职责；内容槽=索引页 md）。
  开启方式（【默认关】——既有测试与蓝图契约零漂移；蓝图页/云函数后续接线时再开）：
    1) 环境变量：KB_GUIDED_LAYER=1（进程级开关；"0"/"false"/"off"/其他值=关）
    2) 调用参数：engine.build_blueprint(..., guided=True)（脚本/调用方显式开启，
       优先级高于环境变量；guided=False 可强制关闭压过环境变量）
  挂载点=engine.build_blueprint 统一出口（反模式 lint 门之后挂载：lint 评估
  领域内容结构，导览层是固定模板层，由 test_guided_layer.py 专属保障）；
  开启时 provenance.guided_layer=true 如实可查；depth 各档（含 standard）
  照常挂载——导览是标配交付物，非深度档位特权。"""
import json
import os
import re

MAX_FILES_PER_DIR = 200  # 受控扇出律：单目录文件硬上限，超出自动分拆
TIERS = ("core", "field", "guide")

# 蓝图深度三档（轨A4）：standard=现状零漂移；pro/flagship 逐档放大文件槽计划。
# factor=文件槽总量放大倍数（每 L2 组槽数 ×factor 后 round，tier 数随配比同比放大）；
# min_per_l2=每 L2 组槽位下限（再小的组也保底，防空组）。
DEPTH_MODES = {
    "standard": {"factor": 1.0, "min_per_l2": 0},
    "pro": {"factor": 1.4, "min_per_l2": 4},
    "flagship": {"factor": 1.8, "min_per_l2": 6},
}


# ── 导览层（v2.6 #7）：巨人 kepano-obsidian（MIT）拥有感设计 ────────────────
# Inbox 分型律：一切新件先进收件箱，判定实体类型后归入对应索引页，收件箱清空
# 即完成一次入库；五类实体=KB-FACTORY 通用实体模型（标准/案例/合同/机构/项目）。
GUIDED_ENV = "KB_GUIDED_LAYER"  # 环境变量开关名（默认关=既有输出零漂移）
GUIDED_DESIGN_ORIGIN = "kepano-obsidian (MIT)"  # 设计蓝本出处（如实在案）
GUIDED_L1 = ("00-导览", "全库导览与拥有感入口：新件先进收件箱，分型归位到五类实体索引。")
GUIDED_INBOX = ("📥-收件箱", "一切新进文件先落收件箱，分型归位后清空——入库唯一入口。")
# (目录名, 实体短名, 一句职责)——职责句是导览层标配交付物，测试逐句断言齐全
GUIDED_ENTITIES = (
    ("01-行业标准索引", "标准", "汇集库内引用的标准编号与现行版本，一处查全、作废即标。"),
    ("02-案例库索引", "案例", "按主题串起可复用的真实案例，同类问题先看前人怎么解。"),
    ("03-合同范本索引", "合同", "收录经实战检验的合同范本与条款要点，起草签署前先对表。"),
    ("04-机构名录", "机构", "登记主管机关、参建单位与对接人，找对人、走对门。"),
    ("05-项目台账", "项目", "项目全周期档案总入口，一件事一条线从立项看到交付。"),
)


def normalize_depth(depth) -> "str | None":
    """深度档归一：standard/pro/flagship 原样通过（大小写/空白宽容）；
    None/非法值 → None（=standard 兼容，输出与无参数逐字节一致，既有契约零漂移）。"""
    if depth is None or isinstance(depth, bool):
        return None
    s = str(depth).strip().lower()
    return s if s in DEPTH_MODES else None


def scale_slots(n: int, depth: str) -> int:
    """组槽数按深度档放大：max(round(n × factor), min_per_l2)（确定性，只增不减）。"""
    spec = DEPTH_MODES[depth]
    return max(round(n * spec["factor"]), spec["min_per_l2"])


def tier_counts(n: int, ratio: dict) -> dict:
    """n 个槽按配比分三档（最大余数法，和恒等于 n，确定性）。"""
    floors = {t: n * ratio[t] // 100 for t in TIERS}
    rem = n - sum(floors.values())
    order = sorted(TIERS, key=lambda t: (-(n * ratio[t] / 100 - floors[t]), TIERS.index(t)))
    for t in order[:rem]:
        floors[t] += 1
    return floors


# ── 节点 schema 立法（v2.6 #4：巨人 Docusaurus 侧栏元数据 + BookStack 排序，双 MIT）──
# v2 档（build_blueprint(schema="v2") 或 env KBCAT_NODE_SCHEMA=v2）才落图，缺省=旧
# schema 输出逐字节零漂移。立法内容：
#   - L1/L2 容器节点增量键：position(float 排序位)/kind(container|leaf)/icon/color/
#     duty(≤20 字一句职责，从种子主题描述 theme 派生；无来源则如实留空，禁编造)
#   - 每 L2 组一粒「00-README」索引文档槽（Docusaurus category index 思想）：
#     落 l2["readme_slot"] 键，不入 files、不计 stats/quote——展示层指针卡非交付
#     内容，15 字段槽位契约与受控扇出分拆一概零扰动；旧渲染器（小程序 v1）只见
#     files 不受扰，新渲染器（v2）按需取用
#   - 排序算子四连（BookStack 思想）：position 优先 → 数字前缀剥离
#     （「01-堤防」→「堤防」+position=1）→ 字母序兜底 → 原序稳定兜底
#   - 防环护栏 validate_tree：父子环/孤儿/断裂/无归属四查，build 末尾自动跑不阻断
SCHEMA_MODES = {"v2"}             # 节点 schema 立法档（增量键集，现唯 v2 一档）
SCHEMA_ENV = "KBCAT_NODE_SCHEMA"  # env 兜底开关（参数优先，env 次之，均非法=旧输出）
DUTY_MAX_CHARS = 20               # duty 一句职责长度上限（字）
README_SIZE_KB = 1                # 00-README 索引槽体积（极小：纯指针卡不含正文）
NODE_COLORS = ("#2563eb", "#0891b2", "#059669", "#ca8a04", "#dc2626",
               "#7c3aed", "#db2777", "#0f766e")  # L1 组色环（确定性循环，纯展示层）
_NUM_PREFIX_SEP_RE = re.compile(r"^(\d{1,4})\s*[-_.、·:：]\s*(\S.*)$")  # 带分隔符：01-堤防
_NUM_PREFIX_GLUE_RE = re.compile(r"^(\d{1,4})(?=\D)(\S.*)$")  # 紧贴且尾起非数字：01堤防


def normalize_schema(schema) -> "str | None":
    """节点 schema 档归一：v2 原样通过（大小写/空白宽容，同 normalize_depth 纪律）；
    缺参回落 env KBCAT_NODE_SCHEMA；None/非法值 → None（=旧 schema，输出逐字节零漂移）。"""
    if isinstance(schema, bool):
        return None
    if schema is None:
        raw = str(os.environ.get(SCHEMA_ENV, "")).strip().lower()
        return raw if raw in SCHEMA_MODES else None
    s = str(schema).strip().lower()
    return s if s in SCHEMA_MODES else None


def derive_duty(source) -> str:
    """一句职责（≤20 字）：从种子主题描述（theme/desc）派生——空白压缩后截断；
    无来源则如实返回空串（禁编造：宁缺勿假，下游展示自会跳过空 duty）。"""
    text = re.sub(r"\s+", " ", str(source or "")).strip()
    return text[:DUTY_MAX_CHARS]


def make_readme_slot(group: dict) -> dict:
    """非叶节点（L2 组）的「00-README」索引文档槽：kind=leaf/fmt=doc/体积极小/
    position=0.0（组内恒排首位）。title=「00-README·<组名>」。"""
    return {"name": "00-README", "title": f"00-README·{group.get('name', '')}",
            "kind": "leaf", "fmt": "doc", "size_kb": README_SIZE_KB,
            "position": 0.0, "path": str(group.get("path") or "")}


# ── 排序算子（BookStack 四算子思想：显式序 > 命名序 > 字母序 > 原序稳定兜底）──

def strip_numeric_prefix(name: str) -> "tuple[str, float | None]":
    """数字前缀剥离：「01-堤防」→("堤防", 1.0)、「01堤防」→("堤防", 1.0)；
    纯数字名（如 L2 目录名「01」=编号本体）与无前缀 → (原名, None) 不剥。"""
    s = str(name or "")
    m = _NUM_PREFIX_SEP_RE.match(s) or _NUM_PREFIX_GLUE_RE.match(s)
    if m and m.group(2):
        return m.group(2), float(int(m.group(1)))
    return s, None


def node_sort_key(node: dict) -> tuple:
    """排序合成键（确定性，四算子逐级回落）：
    ① position 显式优先；② 名称数字前缀升序；③ 剥离前缀后字母序兜底；
    ④ 同键原序兜底（sorted 稳定，引擎既有序不被无谓打乱）。"""
    pos = node.get("position")
    if isinstance(pos, (int, float)) and not isinstance(pos, bool):
        return (0, float(pos), "")
    display, num = strip_numeric_prefix(node.get("name") or node.get("title") or "")
    if num is not None:
        return (1, num, display)
    return (2, 0.0, display)


def sort_nodes(nodes: list) -> list:
    """按 node_sort_key 稳定排序（返回新列表，不改入参序）。"""
    return sorted(nodes, key=node_sort_key)


def display_name(node: dict) -> str:
    """展示名：数字前缀剥离后的名称（「01-堤防」→「堤防」，前缀语义由 position 承接）。"""
    return strip_numeric_prefix(str(node.get("name") or node.get("title") or ""))[0]


def _decorate_node(node: dict, position: float, color: str, duty: str) -> None:
    """容器节点增量键落图（只增不改：既有键一概不动；icon=folder 为通用目录图例，
    非内容编造）。"""
    node["position"] = float(position)
    node["kind"] = "container"
    node["icon"] = "folder"
    node["color"] = color
    node["duty"] = duty[:DUTY_MAX_CHARS]


def legislate_nodes(l1_nodes: list) -> int:
    """节点 schema 立法落图（v2 档，就地增量键；纯规则确定性）：
    - L1/L2 容器节点带 position/kind/icon/color/duty（duty 从 theme 派生，无则空）
    - 每 L2 组挂 readme_slot（00-README 索引文档槽，不入 files 不计 stats）
    - L1 序与 L1 内 L2 序均按排序算子落图（引擎自产序=position 升序 → 通常零重排；
      名称带数字前缀时按前缀值重排——排完序的树才是立法后的规范形态）
    返回 README 槽落图数（=L2 组数）。"""
    groups = 0
    for i, l1 in enumerate(l1_nodes, 1):
        _, prefix = strip_numeric_prefix(l1.get("name") or "")
        _decorate_node(l1, position=float(prefix if prefix is not None else i),
                       color=NODE_COLORS[(i - 1) % len(NODE_COLORS)],
                       duty=derive_duty(l1.get("theme")))
        l2_list = l1.get("l2") or []
        for j, l2 in enumerate(l2_list, 1):
            _, p2 = strip_numeric_prefix(l2.get("name") or "")
            _decorate_node(l2, position=float(p2 if p2 is not None else j),
                           color=l1["color"], duty=derive_duty(l2.get("theme")))
            l2["readme_slot"] = make_readme_slot(l2)
            groups += 1
        l1["l2"] = sort_nodes(l2_list)
    l1_nodes[:] = sort_nodes(l1_nodes)
    return groups


# ── 防环护栏（v2.6 #4）：build 管线末尾自动跑，问题记 provenance.lint 不阻断 ──

_CHILD_KEYS = ("l2", "split_dirs")  # 树下行通道（files 为叶不入栈）


def _node_tag(n: dict) -> str:
    """问题清单里的节点定位标签：编号 → 名称 → 路径 → ?（确定性取首见）。"""
    return str(n.get("code") or n.get("name") or n.get("path") or "?")


def _check_file_owner(f, dirs: dict, group_path: str, group_tag: str, problems: list) -> None:
    """单文件归属判定：无显式 path 的槽（document_driven 真实件）由所在目录承担；
    有 path 须与所属组前缀自洽，否则查全树目录判「脱组（断裂）」或「无归属」。"""
    if not isinstance(f, dict):
        return
    fpath = str(f.get("path") or "")
    if not fpath or (group_path and fpath.startswith(group_path)):
        return
    name = f.get("name") or fpath
    if any(fpath == p or fpath.startswith(p) for p in dirs):
        problems.append(f"断裂: 文件「{name}」脱组（path={fpath} 挂在 {group_tag} 名下）")
    else:
        problems.append(f"无归属: 文件「{name}」path={fpath} 不属树上任何目录")


def validate_tree(bp: dict) -> list:
    """树结构四查护栏：父子环 / 孤儿节点 / 层级断裂 / 文件无归属 → 问题清单（空=健康）。

    引擎自产树为嵌套构造、路径链自洽，天然全绿；护栏防的是手工改造与外部回流
    （enrich 加权、fulfillment 落库、小程序编辑回流）的结构劣化——
    环=遍历死循环源；孤儿/断裂=目录树解析错位；无归属=交付丢文件。
    层级判据走路径前缀链（l2 路径 ⊂ l1 路径、分拆路径 ⊂ l2 路径），不查 code 与
    path 的字面等同（导览层 G-00/00 ↔ 00-导览/… 即合法的编号≠路径形态）。
    纯读不改入参；确定性（无随机源、无时钟）。"""
    problems = []
    tree = bp.get("tree")
    if not isinstance(tree, dict):
        return ["断裂: 蓝图缺 tree 层"]
    l1_nodes = tree.get("l1")
    if not isinstance(l1_nodes, list) or not l1_nodes:
        return ["断裂: 树缺 L1 层（tree.l1 为空或非列表）"]
    if tree.get("files"):
        problems.append(f"无归属: 根级散文件 {len(tree['files'])} 件未挂任何目录")

    # ① 父子环：同一对象（id）重现于自身子树，或编码与祖先编码相同（解析即死循环）
    def _walk(node, anc_ids, anc_codes):
        nid = id(node)
        if nid in anc_ids:
            problems.append(f"环: 节点「{_node_tag(node)}」对象重现于自身子树")
            return
        code = node.get("code")
        if code and code in anc_codes:
            problems.append(f"环: 编码 {code} 与祖先同码成环")
            return
        nxt_ids = anc_ids | {nid}
        nxt_codes = anc_codes | {code} if code else anc_codes
        for key in _CHILD_KEYS:
            for child in node.get(key) or []:
                if isinstance(child, dict):
                    _walk(child, nxt_ids, nxt_codes)

    try:
        for l1 in l1_nodes:
            if isinstance(l1, dict):
                _walk(l1, set(), set())
    except RecursionError:
        problems.append("断裂: 树深超限（疑似超长链或深层环）")

    # ② 目录登记：全树目录路径（L1/L2/分拆）→ 标签（重复路径检测 + 文件归属判据）
    dirs = {}
    for l1 in l1_nodes:
        nodes = [l1]
        for l2 in l1.get("l2") or []:
            nodes.append(l2)
            nodes.extend(l2.get("split_dirs") or [])
        for n in nodes:
            p = n.get("path")
            if p:
                if p in dirs:
                    problems.append(f"断裂: 目录路径重复 {p}（多节点同路径）")
                else:
                    dirs[p] = n.get("code") or p

    # ③ 逐层链检查：L1→L2→分拆→文件 的路径前缀链与文件通道
    for l1 in l1_nodes:
        l1_path = str(l1.get("path") or "")
        if l1.get("files"):
            problems.append(f"无归属: L1「{_node_tag(l1)}」直属散文件 {len(l1['files'])} 件"
                            "（文件须挂 L2/分拆目录）")
        for l2 in l1.get("l2") or []:
            path2 = str(l2.get("path") or "")
            tag2 = _node_tag(l2)
            if path2 and l1_path and not path2.startswith(l1_path):
                owner = max((p for p in dirs if p != path2 and path2.startswith(p)),
                            key=len, default=None)
                if owner:
                    problems.append(f"断裂: L2「{tag2}」挂错父（path 属 {owner}）")
                else:
                    problems.append(f"孤儿: L2「{tag2}」父目录不存在（path={path2}）")
            if "files" not in l2 and "split_dirs" not in l2:
                problems.append(f"孤儿: L2「{tag2}」无文件通道（缺 files/split_dirs 键）")
            for sd in l2.get("split_dirs") or []:
                sdp = str(sd.get("path") or "")
                if sdp and path2 and not sdp.startswith(path2):
                    problems.append(f"断裂: 分拆目录「{sdp}」越级（不以所属组 {path2} 为前缀）")
                if "files" not in sd:
                    problems.append(f"孤儿: 分拆目录「{_node_tag(sd)}」缺 files 键")
                for f in sd.get("files") or []:
                    _check_file_owner(f, dirs, path2, tag2, problems)
            for f in l2.get("files") or []:
                _check_file_owner(f, dirs, path2, tag2, problems)
    return problems


def split_files(theme_name: str, files: list, base_path: str = "") -> list:
    """单目录超 200 自动分拆为 主题-1 / 主题-2 / …（每盘 ≤200）。"""
    chunks = [files[i:i + MAX_FILES_PER_DIR] for i in range(0, len(files), MAX_FILES_PER_DIR)]
    out = []
    for k, ch in enumerate(chunks, 1):
        name = f"{theme_name}-{k}"
        path = f"{base_path}{name}/" if base_path else f"{name}/"
        out.append({"name": name, "path": path, "files": ch})
    return out


def render_l1_index(l1: dict) -> str:
    lines = [
        f"# _INDEX.md · {l1['path']}",
        f"- 路径编号: {l1['path']}",
        f"- 主题: {l1['name']}",
        f"- 一句话主题: {l1['theme']}",
        f"- 来源: {l1['source']}",
        f"- 条目数: {sum(x['file_count'] for x in l1['l2'])}",
        "",
        "## 下级条目表",
        "| # | 编号 | 主题组 | 条目数 |",
        "|---|------|--------|--------|",
    ]
    for j, l2 in enumerate(l1["l2"], 1):
        lines.append(f"| {j} | {l2['code']} | {l2['name']} | {l2['file_count']} |")
    return "\n".join(lines) + "\n"


def render_l2_index(l2: dict, l1: dict) -> str:
    lines = [
        f"# _INDEX.md · {l2['path']}",
        f"- 路径编号: {l2['path']}",
        f"- 主题: {l2['name']}",
        f"- 一句话主题: {l2['theme']}",
        f"- 条目数: {l2['file_count']}",
        f"- 上级枢纽: {l1['path']} {l1['name']}",
    ]
    if l2.get("split_dirs"):
        lines.append("- 分拆目录: " + " / ".join(f"{sd['name']}({len(sd['files'])})" for sd in l2["split_dirs"]))
        lines += ["", "## 下级条目表（分拆目录）", "| # | 条目 | 类型 | 条目数 |", "|---|------|------|--------|"]
        for j, sd in enumerate(l2["split_dirs"], 1):
            lines.append(f"| {j} | {sd['name']} | 目录 | {len(sd['files'])} |")
    else:
        lines += ["", "## 下级条目表", "| # | 条目 | 类型 | 扩展名 | 徽章 | 权限 |",
                  "|---|------|------|--------|------|------|"]
        for j, s in enumerate(l2["files"], 1):
            lines.append(f"| {j} | {s['name']} | {s['tier']} | {s['ext']} | {s['badge']} | {s['perm']} |")
    return "\n".join(lines) + "\n"


# ── 导览层（v2.6 #7）：开关 → 造层 → 挂载记账 ─────────────────────────────

def _flag_truthy(v) -> bool:
    """开关值归一：bool 原样；str 按 1/true/on/yes（大小写宽容）判真，其余为假。"""
    if isinstance(v, bool):
        return v
    return isinstance(v, str) and v.strip().lower() in ("1", "true", "on", "yes")


def guided_layer_enabled(flag=None) -> bool:
    """导览层开关三态：显式传参优先（True/False/'1'/'0'…），否则看环境变量
    KB_GUIDED_LAYER；默认关——不开即不触碰蓝图，既有输出逐字节零漂移。"""
    if flag is not None:
        return _flag_truthy(flag)
    return _flag_truthy(os.environ.get(GUIDED_ENV))


def _guided_page_md(title: str, duty: str, domain: str) -> str:
    """实体索引页正文：职责句必现（测试断言口径），用法与分型纪律为固定模板。"""
    lines = [
        f"# {title} · 导览索引页",
        "",
        f"> 职责：{duty}",
        "",
        f"- 所属知识库：{domain or '（待定域）'}",
        "- 所在导览层：00-导览（收件箱分型 → 五类实体索引）",
        "",
        "## 怎么用这一页",
        "- 从收件箱分型归位的同类条目，先在本页登记一行，再入对应主题卷",
        "- 取用前先在本页核对版本是否现行；发现作废或过期，先改本页再动主题卷",
        "",
        "## 分型纪律（收件箱律）",
        "新件一律先进「📥-收件箱」，按五类实体（标准/案例/合同/机构/项目）判断归属，",
        "登记进对应索引页后移入主题卷——收件箱清空，才算完成一次入库。",
    ]
    return "\n".join(lines) + "\n"


def _inbox_page_md(domain: str) -> str:
    """收件箱分型入口页：分型五问表由 GUIDED_ENTITIES 生成（口径同源不漂移）。"""
    lines = [
        f"# {GUIDED_INBOX[0]} · 分型入口",
        "",
        f"> 职责：{GUIDED_INBOX[1]}",
        "",
        f"- 所属知识库：{domain or '（待定域）'}",
        "- 所在导览层：00-导览（新件第一站）",
        "",
        "## 分型五问（一件新件去哪里）",
        "| 问 | 归入 |",
        "|----|------|",
    ]
    for name, short, _ in GUIDED_ENTITIES:
        lines.append(f"| 是{short}类内容吗？ | {name} |")
    lines += [
        "| 都不是 | 暂存原主题卷待分型，收件箱不长期存件 |",
        "",
        "## 收件箱律（kepano Inbox 分型律）",
        "1. 新件先落本目录，不直接散入主题卷；",
        "2. 按上表分型，登记进对应索引页后移入主题卷；",
        "3. 收件箱清空即完成一次入库——存件即待办。",
    ]
    return "\n".join(lines) + "\n"


def render_guided_l1_index(node: dict) -> str:
    """导览层 L1 枢纽卡：同 render_l1_index 口径，增量多一列「职责」。"""
    lines = [
        f"# _INDEX.md · {node['path']}",
        f"- 路径编号: {node['path']}",
        f"- 主题: {node['name']}",
        f"- 一句话主题: {node['theme']}",
        f"- 来源: guided_layer（{GUIDED_DESIGN_ORIGIN} 拥有感设计）",
        f"- 条目数: {sum(x['file_count'] for x in node['l2'])}",
        "",
        "## 下级条目表",
        "| # | 编号 | 主题组 | 职责 | 条目数 |",
        "|---|------|--------|------|--------|",
    ]
    for j, l2 in enumerate(node["l2"], 1):
        lines.append(f"| {j} | {l2['code']} | {l2['name']} | {l2['duty']} | {l2['file_count']} |")
    return "\n".join(lines) + "\n"


def _guided_page_slot(name: str, duty: str, content: str, path: str, kind: str) -> dict:
    """导览页内容槽=索引页 md：bytes 取正文实际 UTF-8 字节数（数字零造假，
    不用占位估算表）；badge/perm 走既有枚举（自有资料·绿色通道）。"""
    nbytes = len(content.encode("utf-8"))
    return {"name": f"{name}_INDEX.md", "path": path, "tier": "guide", "ext": "md",
            "fmt": "md", "kind": kind, "duty": duty, "content": content,
            "size_kb": max(1, nbytes // 1024), "bytes": nbytes,
            "badge": "self_owned", "perm": "green"}


def build_guided_layer(domain: str = "") -> dict:
    """造「00-导览」首 L1 组：📥-收件箱（kind=inbox，首目录）+ 五类实体索引
    （kind=container，各带一句职责，内容槽=索引页 md）。
    节点键对两种模式（taxonomy/document_driven）的 L1/L2 形态做并集兼容，
    kind/duty 为增量新键——旧渲染器（小程序 v1/v2）忽略未知键不破。"""
    l2_nodes = []
    # 首目录：📥-收件箱（kepano Inbox 分型律——新件第一站）
    inbox_dir, inbox_duty = GUIDED_INBOX
    inbox_path = f"{GUIDED_L1[0]}/{inbox_dir}/"
    inbox_md = _inbox_page_md(domain)
    l2_nodes.append({"code": "G-00/00", "dir": inbox_dir, "path": inbox_path,
                     "name": inbox_dir, "theme": inbox_duty, "source": "guided_layer",
                     "kind": "inbox", "duty": inbox_duty, "open": True,
                     "file_count": 1, "index_md": inbox_md,
                     "files": [_guided_page_slot(inbox_dir, inbox_duty, inbox_md,
                                                 inbox_path, "inbox_page")]})
    # 五类实体索引：01-…/05-…（kind=container，职责句即 theme）
    for i, (name, _short, duty) in enumerate(GUIDED_ENTITIES, 1):
        path = f"{GUIDED_L1[0]}/{name}/"
        content = _guided_page_md(name, duty, domain)
        l2_nodes.append({"code": f"G-00/{i:02d}", "dir": name, "path": path,
                         "name": name, "theme": duty, "source": "guided_layer",
                         "kind": "container", "duty": duty, "open": False,
                         "file_count": 1, "index_md": content,
                         "files": [_guided_page_slot(name, duty, content, path, "index_page")]})
    node = {"code": "G-00", "dir": GUIDED_L1[0], "path": f"{GUIDED_L1[0]}/",
            "name": GUIDED_L1[0], "theme": GUIDED_L1[1], "source": "guided_layer",
            "kind": "container", "open": True, "l2": l2_nodes}
    node["index_md"] = render_guided_l1_index(node)
    return node


def _iter_tree_files(l1_nodes: list):
    """产出树内全部文件槽（L2 files 优先，分拆组拍平；只读不改）。"""
    for l1 in l1_nodes:
        for l2 in l1.get("l2") or []:
            yield from l2.get("files") or []
            for sd in l2.get("split_dirs") or []:
                yield from sd.get("files") or []


def _apply_guided_stats(bpd: dict, node: dict) -> None:
    """导览 6 页如实计入统计（bytes=正文实际字节数，非估算表）：
    taxonomy 口径走 bytes→gb→quote 重算；document_driven 口径走 size_kb→gb；
    real_docs 不虚增（导览页为工厂自产模板页，非渠道检索文件）。"""
    stats = bpd.get("stats") or {}
    tree = bpd.get("tree") or {}
    l1_nodes = tree.get("l1") or []
    pages = [f for l2 in node["l2"] for f in l2.get("files") or []]
    nbytes = sum(f.get("bytes", 0) for f in pages)
    stats["files"] = stats.get("files", 0) + len(pages)
    stats["l1_count"] = len(l1_nodes)
    stats["l2_count"] = stats.get("l2_count", 0) + len(node["l2"])
    if tree.get("mode") == "document_driven":
        stats["dir_count"] = stats["l1_count"] + stats["l2_count"]  # 该模式口径=L1+L2
    else:
        stats["dir_count"] = stats.get("dir_count", 0) + len(node["l2"])  # 口径=目录数
    by_tier = stats.get("by_tier")
    if isinstance(by_tier, dict):
        by_tier["guide"] = by_tier.get("guide", 0) + len(pages)
    by_ext = stats.get("by_ext")
    if isinstance(by_ext, dict):
        by_ext["md"] = by_ext.get("md", 0) + len(pages)
    if "bytes" in stats:  # taxonomy 口径：字节→GB→报价重算
        stats["bytes"] += nbytes
        stats["gb"] = round(stats["bytes"] / 1024 ** 3, 2)
    else:  # document_driven 口径：按槽 size_kb 求和重算
        kb = sum(f.get("size_kb") or 0 for f in _iter_tree_files(l1_nodes))
        stats["gb"] = round(kb / 1024 / 1024, 2)
    quote = bpd.get("quote")
    if isinstance(quote, dict) and "base" in quote and "per_gb" in quote:
        quote["total"] = round(quote["base"] + stats["gb"] * quote["per_gb"], 1)


def attach_guided_layer(bpd: dict, flag=None) -> dict:
    """导览层挂载：首 L1 前插「00-导览」+ 统计/溯源如实记账
    （provenance.guided_layer=true、S8 日志、蓝本出处）。
    开关默认关：guided_layer_enabled=False 时原样返回（输出逐字节零漂移）；
    已挂载（首 L1 已是 00-导览）时幂等返回，不二次前插。
    就地修改并返回同一 dict（与 engine._attach_lint 同风格）。"""
    if not guided_layer_enabled(flag):
        return bpd
    tree = bpd.get("tree") or {}
    l1_nodes = tree.get("l1")
    if not isinstance(l1_nodes, list) or not l1_nodes:
        return bpd  # 树缺失/空树：无位可挂（防御，不动蓝图）
    if l1_nodes[0].get("name") == GUIDED_L1[0]:
        return bpd  # 幂等防重
    node = build_guided_layer(bpd.get("domain") or "")
    l1_nodes.insert(0, node)
    _apply_guided_stats(bpd, node)
    prov = bpd.setdefault("provenance", {})
    prov["guided_layer"] = True
    prov["guided_layer_info"] = {"design_origin": GUIDED_DESIGN_ORIGIN, "l1": GUIDED_L1[0],
                                 "pages": [l2["name"] for l2 in node["l2"]],
                                 "page_count": len(node["l2"])}
    log = prov.get("stage_log")
    if not isinstance(log, list):
        log = []
        prov["stage_log"] = log
    log.append(f"S8 导览层: {GUIDED_L1[0]}（{GUIDED_INBOX[0]}+{len(GUIDED_ENTITIES)}实体索引）"
               f"前插 · guided_layer=true · 蓝本 {GUIDED_DESIGN_ORIGIN}")
    return bpd


def assemble_blueprint(domain, need, tree, ratio, stats, quote, provenance) -> dict:
    """按 FR2 顶层 schema 组装蓝图（键序固定，输出确定性）。"""
    return {"domain": domain, "need": need, "tree": tree, "ratio": ratio,
            "stats": stats, "quote": quote, "provenance": provenance}


def canonical_json(bp: dict) -> str:
    """规范化输出：排序键+紧凑分隔，供确定性比对与留档。"""
    return json.dumps(bp, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
