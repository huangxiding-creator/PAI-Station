# -*- coding: utf-8 -*-
"""mkdocs 可预览导出器（v2.6 #5）——蓝图 dict → mkdocs 站点骨架（纯 stdlib 手写 yaml 文本）。

输入 bp=engine.build_blueprint 产物（dict 或其 JSON 反序列化形态），输出可直接
`mkdocs build --strict` 的站点骨架：

    out_dir/
      mkdocs.yml      # site_name/site_description/nav（逐级嵌套，纯 stdlib 手写）
      docs/<树路径>/  # 目录树映射（见映射律）+ about.md

映射律（判据①）：
  - L1 → nav 分节（一级 section）
  - L2 → 子目录（二级 section；带 readme_slot 则落 index.md 且置组首——
    组内另有真实 index_md 时按原文落盘，无才走占位模板）
  - 分拆目录（split_dirs，单 L2 超 200 槽的受控扇出）→ 再下一级 section
  - 文件槽 → md 占位页：YAML 头只写真值（title/fmt/pages/source_url——
    槽里没有的键不编造、不补默认数字），正文=目录行+「占位·付费解锁」一句
  - 带真实 content 的槽（导览层索引页等）按原文落盘（真实内容非占位）
  - 导览层组（00-导览）如存在则置首（引擎本就首插；手工改造树也强制归首）
  - quote/provenance → docs/about.md：报价逐键真值＋来源徽章统计（实测自树扫描）
    ＋真实文件率（real=True 槽占比，实测不手填）

纪律（对齐 fulfillment/bagit_export）：
  - 确定性：无时钟无随机——同蓝图两次导出逐字节一致
  - 不覆盖：out_dir 已存在且非空即拒（ValueError），绝不删除既有产物
  - 先验后写：路径安全/重名全验完才落盘，失败不留半成品
  - 数字零造假：徽章统计/真实文件率/槽数全实测自树扫描

【接线说明（收口波专用——本模块自身不接线，收口波统一接入防互踩）】
收口波在蓝图页加「预览站点」入口时，服务端三步（零浏览器、零动态运行时）：
  ① 生成：receipt = export_mkdocs(bp_dict, out_dir)   # bp_dict=蓝图 JSON 反序列化
  ② 构建：subprocess.run([sys.executable, "-m", "mkdocs", "build", "--strict",
                          "--site-dir", site_dir], cwd=out_dir, check=True)
     （判据②=--strict 必零错误；运行环境需 pip install mkdocs）
  ③ 挂载：site/ 静态目录放对象存储/CDN，蓝图页「预览站点」入口链到 site/index.html
  命令行等效：py -3 -m export_mkdocs <蓝图.json> <out_dir>（回执 JSON 打 stdout）
"""
from __future__ import annotations

from pathlib import Path

try:  # 导览层组名与编目引擎同源（单一事实来源；独立部署时回退同值常量）
    from catalog_engine.blueprint import GUIDED_L1 as _GUIDED_L1

    GUIDED_L1_NAME = _GUIDED_L1[0]
except ImportError:  # pragma: no cover - 独立部署回退（值同 blueprint.GUIDED_L1[0]）
    GUIDED_L1_NAME = "00-导览"

ABOUT_TITLE = "关于本库"   # nav 殿后入口名（about.md 真值页）
ABOUT_MD = "about.md"     # 报价真值+来源徽章统计+真实文件率（docs/ 根层）
PLACEHOLDER_NOTE = "占位·付费解锁"  # 占位页正文必现的一句（判据口径）
NO_BADGE = "(无徽章)"     # 槽缺 badge 键时的如实占位（不编造来源）

# Windows 保留名（目录/文件名禁用，防御外部回流蓝图）
_WIN_RESERVED = ({"con", "prn", "aux", "nul"}
                 | {f"com{i}" for i in range(1, 10)}
                 | {f"lpt{i}" for i in range(1, 10)})


# ── 纯文本工具（无第三方依赖；yaml 文本全部手写）──────────────────────────

def _yq(s) -> str:
    """YAML 双引号标量：转义反斜杠/引号，控制换行折叠为空格（跨平台确定性）。"""
    t = str(s).replace("\\", "\\\\") .replace('"', '\\"')
    t = t.replace("\r", " ").replace("\n", " ").replace("\t", " ")
    return f'"{t}"'


def _one_line(s) -> str:
    """md 正文用的单行化（标题/目录行禁换行，防破版）。"""
    return str(s).replace("\r", " ").replace("\n", " ").strip()


def _safe_component(comp: str, what: str) -> str:
    """路径段安全门：非空、无 \\ 、无 Windows 保留名、不以点/空格收尾（先验后写）。"""
    c = str(comp)
    if not c or c in (".", "..") or "\\" in c or c.strip() != c or c.endswith("."):
        raise ValueError(f"{what} 路径段非法: {c!r}")
    if c.lower() in _WIN_RESERVED:
        raise ValueError(f"{what} 路径段撞 Windows 保留名: {c!r}")
    for ch in ':*?"<>|':
        if ch in c:
            raise ValueError(f"{what} 路径段含非法字符 {ch!r}: {c!r}")
    return c


def _dir_components(node: dict) -> list:
    """节点 path（如 'MK-01/01/'）→ 安全路径段列表（['MK-01', '01']）。"""
    p = str(node.get("path") or "")
    parts = [x for x in p.split("/") if x]
    if not parts:
        raise ValueError(f"节点缺 path（无法映射目录树）: {node.get('name') or node.get('code') or '?'}")
    return [_safe_component(x, "目录") for x in parts]


def _slot_md_name(slot: dict) -> str:
    """槽名 → 占位 md 文件名：已是 .md 原样（导览页等），其余剥原扩展名换 .md。"""
    name = str(slot.get("name") or slot.get("title") or "untitled")
    if name.lower().endswith(".md"):
        return _safe_component(name, "文件")
    stem = name.rsplit(".", 1)[0] if "." in name else name
    return _safe_component(f"{stem}.md", "文件")


def _slot_title(slot: dict) -> str:
    """槽标题真值：title 键优先，缺则文件名去扩展（绝不编造书名）。"""
    name = str(slot.get("name") or "")
    stem = name.rsplit(".", 1)[0] if "." in name else name
    return _one_line(slot.get("title") or stem or "未命名槽位")


def _slot_fmt(slot: dict) -> str:
    """槽格式真值：fmt 键（document_driven/导览页）优先，回落 ext（taxonomy）。"""
    return str(slot.get("fmt") or slot.get("ext") or "").strip()


def _slot_pages(slot: dict):
    """页数真值：仅槽自带 pages（document_driven 检索件）才返回，占位槽如实 None。"""
    v = slot.get("pages")
    if isinstance(v, bool) or v is None:
        return None
    if isinstance(v, (int, float)):
        return v
    s = str(v).strip()
    return s or None


def _slot_source_url(slot: dict) -> str:
    """来源链接真值：source_url/url 键任一非空即取（taxonomy 占位槽无链接=空）。"""
    for k in ("source_url", "url"):
        v = slot.get(k)
        if v:
            return _one_line(v)
    return ""


# ── 占位页 / README / about 渲染 ───────────────────────────────────────────

def _placeholder_md(slot: dict, crumb: str) -> str:
    """文件槽占位页：YAML 头只写真值（缺的键不写），正文=目录行+占位句。"""
    head = ["---", f"title: {_yq(_slot_title(slot))}"]
    fmt = _slot_fmt(slot)
    if fmt:
        head.append(f"fmt: {_yq(fmt)}")
    pages = _slot_pages(slot)
    if pages is not None:
        head.append(f"pages: {pages if isinstance(pages, (int, float)) else _yq(pages)}")
    url = _slot_source_url(slot)
    if url:
        head.append(f"source_url: {_yq(url)}")
    head.append("---")
    body = ["", f"# {_slot_title(slot)}", "",
            f"- 目录行：{crumb}", "",
            f"> 本页为文件槽{PLACEHOLDER_NOTE}——完整文件随付费交付包提供。", ""]
    return "\n".join(head + body)


def _readme_md(l2: dict, l1_name: str) -> str:
    """L2 的 00-README → index.md：组内带真实 index_md（枢纽卡）按原文落盘，
    无才走占位模板（readme_slot 是索引指针卡，本就极小）。"""
    real = l2.get("index_md")
    if isinstance(real, str) and real.strip():
        return real
    slot = l2.get("readme_slot") or {}
    return _placeholder_md(slot, f"{l1_name} / {l2.get('name', '')} / {slot.get('name', '00-README')}")


def _about_md(bpd: dict, m: dict) -> str:
    """about.md：报价逐键真值＋来源徽章统计（实测）＋真实文件率（实测）＋溯源摘要。"""
    domain = str(bpd.get("domain") or (bpd.get("tree") or {}).get("root") or "知识库")
    lines = [f"# 关于本知识库 · {domain}", "",
             "> 本站为 KB-FACTORY 编目蓝图的 mkdocs 预览导出：导航与目录为蓝图真结构，",
             f"> 文件页为占位页（{PLACEHOLDER_NOTE}）；本页报价与统计字段全部为实测真值。", "",
             "## 报价（真值）"]
    quote = bpd.get("quote") if isinstance(bpd.get("quote"), dict) else {}
    if quote:
        lines += [f"- {k}: {v}" for k, v in quote.items()]
    else:
        lines.append("- （蓝图未含 quote 字段，如实省略）")
    stats = bpd.get("stats") if isinstance(bpd.get("stats"), dict) else {}
    if stats:
        lines += ["", "## 规模（蓝图 stats 快照）"]
        lines += [f"- {k}: {v}" for k, v in stats.items()]
    lines += ["", "## 来源徽章统计（实测自树扫描）"]
    if m["badges"]:
        lines += ["| 徽章 | 件数 |", "|---|---:|"]
        lines += [f"| {b} | {n} |" for b, n in m["badges"].items()]
        lines.append(f"| 合计 | {m['slots']} |")
    else:
        lines.append("- （树内无文件槽）")
    lines += ["", "## 真实文件率"]
    if m["slots"]:
        rate = m["real"] / m["slots"]
        lines.append(f"- 真实检索文件: {m['real']} / {m['slots']}（{rate:.2%}，real=True 槽实测）")
        lines.append(f"- 工厂自产内容页: {m['content']} 件（导览层索引页等，带真实正文非占位）")
        lines.append(f"- README 索引槽: {m['readme']} 粒（目录指针卡，不入文件槽数）")
    else:
        lines.append("- （树内无文件槽，N/A）")
    prov = bpd.get("provenance") if isinstance(bpd.get("provenance"), dict) else {}
    lines += ["", "## 溯源（provenance 摘要）"]
    picks = [f"- {k}: {prov[k]}" for k in ("engine_version", "engine", "depth", "node_schema",
                                           "guided_layer", "doc_count", "fallback_from") if k in prov]
    if isinstance(prov.get("sources"), list) and prov["sources"]:
        picks.append(f"- sources: {', '.join(str(x) for x in prov['sources'])}")
    lines += picks or ["- （蓝图未含 provenance 摘要键）"]
    return "\n".join(lines) + "\n"


# ── 树 → nav（判据①核心：nav 层级=树结构）────────────────────────────────

def _ordered_l1(bpd: dict) -> list:
    """L1 序：导览层组（00-导览）如存在则置首，其余保树序（引擎自产序=已首插）。"""
    l1s = [x for x in (bpd.get("tree") or {}).get("l1") or [] if isinstance(x, dict)]
    guided = [x for x in l1s if x.get("name") == GUIDED_L1_NAME]
    return guided + [x for x in l1s if x.get("name") != GUIDED_L1_NAME]


def _assemble(bpd: dict):
    """蓝图 → (nav 结构, {docs相对路径: 文本}, 实测指标)。纯内存组装零落盘：
    路径安全/重名在此全验，export_mkdocs 验完才写（失败不留半成品）。"""
    files: dict = {}
    m = {"l1": 0, "l2_groups": 0, "split_dirs": 0, "slots": 0, "readme": 0,
         "real": 0, "content": 0, "badges": {}}

    def _put(rel: str, text: str) -> None:
        if rel in files:
            raise ValueError(f"导出路径重复（蓝图内重名/撞车）: {rel}")
        files[rel] = text

    def _file_entry(l1_name: str, group_label: str, comps: list, slot: dict) -> dict:
        rel = "/".join(comps) + "/" + _slot_md_name(slot)
        crumb = f"{l1_name} / {group_label} / {slot.get('name', '')}"
        content = slot.get("content")
        if isinstance(content, str) and content:  # 真实内容页（导览索引页等）
            _put(rel, content)
            m["content"] += 1
        else:
            _put(rel, _placeholder_md(slot, crumb))
        m["slots"] += 1
        if slot.get("real") is True:
            m["real"] += 1
        badge = str(slot.get("badge") or NO_BADGE)
        m["badges"][badge] = m["badges"].get(badge, 0) + 1
        return {"title": _slot_title(slot), "path": rel}

    nav = []
    for l1 in _ordered_l1(bpd):
        l1_name = str(l1.get("name") or "")
        sec = {"name": l1_name, "pages": [], "children": []}
        for l2 in l1.get("l2") or []:
            if not isinstance(l2, dict):
                continue
            l2_name = str(l2.get("name") or "")
            try:
                comps = _dir_components(l2)
            except ValueError:
                continue  # 缺 path 的组无位可挂（防御，不破整库导出）
            grp = {"name": l2_name, "pages": [], "children": []}
            if l2.get("readme_slot"):  # README 槽 → index.md 且置组首
                rel = "/".join(comps) + "/index.md"
                _put(rel, _readme_md(l2, l1_name))
                m["readme"] += 1
                grp["pages"].append({"title": str(l2["readme_slot"].get("title") or "00-README"),
                                     "path": rel})
            for f in l2.get("files") or []:
                if isinstance(f, dict):
                    grp["pages"].append(_file_entry(l1_name, l2_name, comps, f))
            for sd in l2.get("split_dirs") or []:
                if not isinstance(sd, dict) or not sd.get("files"):
                    continue
                try:
                    sd_comps = _dir_components(sd)
                except ValueError:
                    continue
                sd_name = str(sd.get("name") or sd_comps[-1])
                sub = {"name": sd_name, "pages": [
                    _file_entry(l1_name, f"{l2_name} / {sd_name}", sd_comps, f)
                    for f in sd["files"] if isinstance(f, dict)], "children": []}
                grp["children"].append(sub)
                m["split_dirs"] += 1
            if grp["pages"] or grp["children"]:
                sec["children"].append(grp)
                m["l2_groups"] += 1
        if sec["children"]:
            nav.append(sec)
            m["l1"] += 1
    nav.append({"name": ABOUT_TITLE, "pages": [{"title": ABOUT_TITLE, "path": ABOUT_MD}],
                "children": []})  # 关于本库殿后（about 页必入 nav，防 strict 未列页）
    files[ABOUT_MD] = _about_md(bpd, m)
    return nav, files, m


def build_nav(bpd: dict) -> list:
    """蓝图树 → mkdocs nav 数据（嵌套 section：name/pages/children；只读不改蓝图）。
    层级=树结构：L1 分节 → L2 组（readme index.md 组首）→ 分拆目录再一级 → 文件页。"""
    return _assemble(bpd)[0]


# ── mkdocs.yml 手写渲染（纯 stdlib，不 import yaml）────────────────────────

def _render_section(lines: list, sec: dict, indent: int) -> None:
    """nav 节点 → yaml 行（单页无子组用平铺形 `- "名": "路径"`，否则嵌套）。"""
    pad = " " * indent
    name = str(sec.get("name") or "?")
    pages = sec.get("pages") or []
    children = sec.get("children") or []
    if not children and len(pages) == 1:
        lines.append(f'{pad}- {_yq(name)}: {_yq(pages[0]["path"])}')
        return
    lines.append(f"{pad}- {_yq(name)}:")
    for p in pages:
        lines.append(f'{" " * (indent + 2)}- {_yq(p["title"])}: {_yq(p["path"])}')
    for ch in children:
        _render_section(lines, ch, indent + 2)


def render_mkdocs_yml(bpd: dict, nav: list) -> str:
    """mkdocs.yml 文本（UTF-8/LF，确定性；site_name/site_description/nav 三键足够）。"""
    domain = str(bpd.get("domain") or (bpd.get("tree") or {}).get("root") or "知识库")
    lines = [f"site_name: {_yq(f'{domain} · 知识库蓝图预览')}",
             f"site_description: {_yq('KB-FACTORY 编目蓝图预览站点：目录全览、报价与来源统计；'
                                     '文件页为占位，付费解锁后交付完整文件。')}",
             "nav:"]
    for sec in nav:
        _render_section(lines, sec, 2)
    return "\n".join(lines) + "\n"


# ── 导出入口（接线方唯一调用点）────────────────────────────────────────────

def export_mkdocs(bp, out_dir) -> dict:
    """蓝图 → mkdocs 站点骨架（mkdocs.yml + docs/ 树 + about.md）；返回实测回执。

    - bp：engine.build_blueprint 产物 dict（JSON 反序列化形态同）；
    - out_dir：目标目录（已存在且非空即拒——绝不覆盖既有产物，绝不删除任何文件）；
    - 回执全实测：md_pages=docs 内 md 总数（文件槽+README 槽+about），
      badges/real 自树扫描，禁手填；确定性：同蓝图两次导出逐字节一致。
    """
    if not isinstance(bp, dict):
        raise ValueError("bp 必须是蓝图 dict（engine.build_blueprint 产物）")
    l1_nodes = (bp.get("tree") or {}).get("l1") if isinstance(bp.get("tree"), dict) else None
    if not isinstance(l1_nodes, list) or not l1_nodes:
        raise ValueError("蓝图缺 tree.l1（空树不可导出）")
    out = Path(out_dir)
    if out.exists() and (out.is_file() or any(out.iterdir())):
        raise ValueError(f"out_dir 已存在且非空，拒绝覆盖: {out}")

    nav, files, m = _assemble(bp)          # ① 纯内存组装+全量校验（失败零落盘）
    yml_text = render_mkdocs_yml(bp, nav)  # ② yaml 文本（同一 nav，单一事实源）
    out.mkdir(parents=True, exist_ok=True)
    docs = out / "docs"
    for rel in sorted(files):              # ③ 确定性落盘（UTF-8 无 BOM + LF）
        dst = docs.joinpath(*rel.split("/"))
        dst.parent.mkdir(parents=True, exist_ok=True)
        with open(dst, "w", encoding="utf-8", newline="\n") as f:
            f.write(files[rel])
    yml_path = out / "mkdocs.yml"
    with open(yml_path, "w", encoding="utf-8", newline="\n") as f:
        f.write(yml_text)
    return {"out_dir": str(out), "mkdocs_yml": str(yml_path), "docs_dir": str(docs),
            "md_pages": len(files), "slot_pages": m["slots"], "readme_pages": m["readme"],
            "content_pages": m["content"], "about_page": "docs/" + ABOUT_MD,
            "l1_sections": m["l1"], "l2_groups": m["l2_groups"], "split_dirs": m["split_dirs"],
            "total_slots": m["slots"] + m["readme"], "real_files": m["real"],
            "badges": dict(m["badges"]),
            "build_hint": f'py -3 -m mkdocs build --strict -f "{yml_path}"'}
