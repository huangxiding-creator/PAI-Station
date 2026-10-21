# -*- coding: utf-8 -*-
"""W7 履约流水线：付费订单 → 可交付知识库包。

产物（按蓝图 L1/L2 建目录树，镜像树根名=知识库名）：
  - 绿源匹配到的真实文件**复制**进对应目录（copy 非 move，源不动）
  - 每目录 _INDEX.md（路径编号/主题/文件表）
  - 获取指引清单.md（未取得槽位一条不漏，建议获取路径按合规三级）
  - manifest.json（订单/统计/渠道状态/每文件：来源徽章/权限级/来源URL/哈希槽）
  - 使用与来源说明.md（免责与来源说明页）
  - 打包 zip 写 outbox/<订单号>.zip
纪律：数字零造假——缺什么如实标什么；任何分支不删除文件。
"""
import json
import re
import shutil
import time
import zipfile
from dataclasses import dataclass, field
from pathlib import Path

from ..convert.import_pack import make_import_pack
from ..convert.md_convert import REPORT_NAME, convert_package
from .order import parse_selections
from .sources_local import LocalCorpus
from .sources_registry import advice_for, manifest_channels, registry

MODULE_DIR = Path(__file__).resolve().parent
GREEN_LOCAL_BADGES = {"self_owned", "green_free"}  # 优先本地直取

# 转换报告末行机器可读汇总（W8 契约）：成功转换 X｜原样复制 Y｜占位 Z｜合计 T
_REPORT_SUMMARY_RE = re.compile(r"成功转换 (\d+)｜原样复制 (\d+)｜占位 (\d+)｜合计 (\d+)")


@dataclass
class BuildResult:
    order_id: str
    kb_name: str
    build_dir: str        # outbox/<订单号>/（树根在此之下）
    zip_path: str
    stats: dict = field(default_factory=dict)
    manifest: dict = field(default_factory=dict)


def load_blueprint(ref) -> dict:
    """加载蓝图（json 路径或已加载的 dict）。"""
    if isinstance(ref, dict):
        return ref
    p = Path(ref)
    if not p.is_file():
        raise FileNotFoundError(f"蓝图文件不存在: {ref}")
    try:
        return json.loads(p.read_text(encoding="utf-8"))
    except ValueError as e:
        raise ValueError(f"蓝图 JSON 非法: {p}: {e}") from e


def _now() -> str:
    return time.strftime("%Y-%m-%dT%H:%M:%S")


def _render_l2_index(l2: dict, l1: dict, rows: list) -> str:
    delivered = sum(1 for r in rows if r["status"] == "delivered")
    lines = [
        f"# _INDEX.md · {l2['path']}",
        f"- 路径编号: {l2['path']}",
        f"- 主题: {l2['name']}",
        f"- 一句话主题: {l2.get('theme', '')}",
        f"- 上级枢纽: {l1['path']} {l1['name']}",
        f"- 槽位: {len(rows)} | 已交付: {delivered} | 获取指引: {len(rows) - delivered}",
        "",
        "## 文件表",
        "| # | 槽位 | 状态 | 交付文件 | 徽章 | 权限 |",
        "|---|------|------|----------|------|------|",
    ]
    for i, r in enumerate(rows, 1):
        got = r["delivered_name"] if r["status"] == "delivered" else "—"
        status = "已交付" if r["status"] == "delivered" else "获取指引"
        lines.append(f"| {i} | {r['slot']} | {status} | {got} | {r['badge']} | {r['perm']} |")
    return "\n".join(lines) + "\n"


def _render_l1_index(l1: dict, l2_rows: dict) -> str:
    rows = [r for l2 in l1["l2"] for r in l2_rows[id(l2)]]
    delivered = sum(1 for r in rows if r["status"] == "delivered")
    lines = [
        f"# _INDEX.md · {l1['path']}",
        f"- 路径编号: {l1['path']}",
        f"- 主题: {l1['name']}",
        f"- 一句话主题: {l1.get('theme', '')}",
        f"- 来源: {l1.get('source', '')}",
        f"- 槽位: {len(rows)} | 已交付: {delivered} | 获取指引: {len(rows) - delivered}",
        "",
        "## 下级条目表",
        "| # | 编号 | 主题组 | 槽位 | 已交付 | 指引 |",
        "|---|------|--------|------|--------|------|",
    ]
    for i, l2 in enumerate(l1["l2"], 1):
        rs = l2_rows[id(l2)]
        d = sum(1 for r in rs if r["status"] == "delivered")
        lines.append(f"| {i} | {l2['code']} | {l2['name']} | {len(rs)} | {d} | {len(rs) - d} |")
    lines += ["", "## 文件表（本库汇总）",
              "| # | 槽位 | 目录 | 状态 | 徽章 | 权限 |",
              "|---|------|------|------|------|------|"]
    for i, r in enumerate(rows, 1):
        status = "已交付" if r["status"] == "delivered" else "获取指引"
        lines.append(f"| {i} | {r['slot']} | {r['dir']} | {status} | {r['badge']} | {r['perm']} |")
    return "\n".join(lines) + "\n"


def _render_guide(kb_name: str, order, guide_rows: list, stats: dict) -> str:
    lines = [
        f"# 获取指引清单 · {kb_name}",
        "",
        "> 数字零造假：以下槽位本期未取得真实文件，一条不漏如实列出，未以占位文件充数。",
        "> 建议获取路径按合规三级给出：绿=扩源计划；黄=需会员权益；红=建议官方购买。",
        "",
        f"- 订单号: {order.id}",
        f"- 生成时间: {_now()}",
        f"- 槽位: {stats['slots']} | 已交付: {stats['delivered']} | 未取得: {stats['guide']}",
        "",
        "| # | 槽位 | 目录 | 徽章 | 权限 | 建议获取路径 |",
        "|---|------|------|------|------|--------------|",
    ]
    for i, r in enumerate(guide_rows, 1):
        lines.append(f"| {i} | {r['slot']} | {r['dir']} | {r['badge']} | {r['perm']} | {r['advice']} |")
    return "\n".join(lines) + "\n"


def _render_readme(kb_name: str, order, stats: dict, channels: list) -> str:
    ch_lines = "\n".join(
        f"- {c['name']}（{c['badge']}，权限 {c['perm']}）：{'启用' if c['on'] else '关闭'}"
        + (f" — {c['reason']}" if c['reason'] else "")
        for c in channels)
    return "\n".join([
        f"# 使用与来源说明 · {kb_name}",
        "",
        f"- 出品：总包智库研究团队",
        f"- 订单号：{order.id} · 交付版本：{order.version_selection}",
        f"- 交付统计：槽位 {stats['slots']}，已交付 {stats['delivered']}，获取指引 {stats['guide']}",
        "",
        "## 来源说明",
        "- 已交付文件均取自绿色通道（自有研报与知识件、公开可自由使用资料），逐文件哈希见 manifest.json。",
        "- 文库会员（黄）资料本期未代取，列于获取指引清单，可在文库按标题搜索获取。",
        "- 红色（受版权严格保护）资料不代取，仅提代购建议。",
        "- 国标类文件由 std-samr-gb 渠道批处理获取，本期列于获取指引清单。",
        "",
        "## 渠道状态",
        ch_lines,
        "",
        "## 免责声明",
        "- 本知识库为资料汇编服务，所含文件版权归原作者所有；买家权益仅限本人学习研究使用，请勿转售或公开传播。",
        "- 每份文件的真实来源、权限级与完整性校验值以 manifest.json 为准；未取得的文件在获取指引清单中如实标注，绝无占位充数。",
        "",
    ])


def _zip_tree(root: Path, zip_path: Path) -> Path:
    """把 root 目录树打包为 zip（相对路径=root 内位置），返回 zip 路径。"""
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
        for p in sorted(root.rglob("*")):
            if p.is_file():
                z.write(p, p.relative_to(root).as_posix())
    return zip_path


def _assemble_versions(order, *, base: Path, kb_root: Path, order_dir: Path) -> dict:
    """W10 发货腿：按 version_selection 组装各版本产物（原包恒在；组合全都要）。

    - markdown：convert_package 产 MD 版目录 + zip（转换报告随附，计数取报告末行实测值）
    - import_pack：make_import_pack 产导入包 zip，与原包并列 outbox（库名命名）
    - 全部产物落 outbox 层，不入 order_dir（原包 zip 保持纯净）
    manifest.versions 记录各版本产物路径与计数——数字零造假：MD 计数=转换报告末行，
    导入包计数=zip 实测条数，原包计数=order_dir 实测文件数。
    """
    sel = parse_selections(order.version_selection)
    outbox = base / "outbox"
    versions = {"selection": order.version_selection,
                "original": {"zip": str(outbox / f"{order.id}.zip"),
                             "files": sum(1 for p in order_dir.rglob("*") if p.is_file())}}
    if "markdown" in sel:
        md_dir = outbox / f"{order.id}_md"
        dst = convert_package(kb_root, dst_dir=md_dir)
        report = dst / REPORT_NAME
        m = _REPORT_SUMMARY_RE.search(report.read_text(encoding="utf-8"))
        if not m:
            raise RuntimeError(f"转换报告缺机器可读汇总行: {report}")
        conv, copied, ph, total = (int(x) for x in m.groups())
        md_zip = _zip_tree(dst, outbox / f"{order.id}_md.zip")
        versions["markdown"] = {
            "dir": str(dst), "zip": str(md_zip), "report": str(report),
            "files": total, "converted": conv, "copied": copied,
            "placeholders": ph, "total": total}
    if "import_pack" in sel:
        iz = make_import_pack(kb_root, out_dir=outbox)
        with zipfile.ZipFile(iz) as z:
            n_import = len(z.namelist())
        versions["import_pack"] = {"zip": str(iz), "files": n_import}
    return versions


def run(order, *, base_dir=None, corpus: LocalCorpus | None = None,
        channels: dict | None = None) -> BuildResult:
    """履约主链：蓝图→建树→绿源复制→INDEX/清单/manifest→zip。"""
    t0 = time.perf_counter()
    bp = load_blueprint(order.blueprint_ref)
    kb_name = bp["tree"]["root"]

    if corpus is None:
        corpus = LocalCorpus()
    if not corpus.available and corpus.size() == 0:
        corpus.scan()
    if channels is None:
        channels = registry(corpus_available=corpus.available)

    base = Path(base_dir) if base_dir else MODULE_DIR
    order_dir = base / "outbox" / order.id
    kb_root = order_dir / kb_name
    kb_root.mkdir(parents=True, exist_ok=True)

    file_entries: list = []      # manifest 每文件条目
    guide_rows: list = []        # 获取指引清单行
    l2_rows_by_l1: dict = {}     # L1 id -> {l2 id -> rows}

    for l1 in bp["tree"]["l1"]:
        l1_dir = kb_root / l1["path"].rstrip("/")
        l1_dir.mkdir(parents=True, exist_ok=True)
        l2_rows_by_l1[id(l1)] = {}
        for l2 in l1["l2"]:
            # 分拆目录（>200 受控扇出）等同普通子目录处理
            sub_dirs = l2.get("split_dirs") or \
                [{"name": l2["dir"], "path": l2["path"], "files": l2.get("files", [])}]
            rows = []
            for sd in sub_dirs:
                sd_dir = l1_dir / sd["name"]
                sd_dir.mkdir(parents=True, exist_ok=True)
                sd_rows = []  # judge-W7#1修复：分拆目录各自记行、各写各的 _INDEX
                for slot in sd.get("files", []):
                    r = _process_slot(slot, sd, sd_dir, kb_root, corpus,
                                      file_entries, guide_rows)
                    sd_rows.append(r)
                    rows.append(r)
                (sd_dir / "_INDEX.md").write_text(
                    _render_l2_index(l2, l1, sd_rows), encoding="utf-8")
            l2_rows_by_l1[id(l1)][id(l2)] = rows
        l1_dir.joinpath("_INDEX.md").write_text(
            _render_l1_index(l1, l2_rows_by_l1[id(l1)]), encoding="utf-8")

    slots = len(file_entries)
    delivered = sum(1 for e in file_entries if e["status"] == "delivered")
    stats = {"slots": slots, "delivered": delivered, "guide": slots - delivered,
             "delivered_bytes": sum(e.get("size_bytes", 0) or 0 for e in file_entries),
             "corpus_items": corpus.size(), "elapsed_s": 0.0}
    channels_list = manifest_channels(channels)

    # 获取指引清单 + 免责与来源说明页 + manifest
    (kb_root / "获取指引清单.md").write_text(
        _render_guide(kb_name, order, guide_rows, stats), encoding="utf-8")
    (kb_root / "使用与来源说明.md").write_text(
        _render_readme(kb_name, order, stats, channels_list), encoding="utf-8")
    manifest = {
        "order": order.to_dict(),
        "kb": {"name": kb_name, "domain": bp.get("domain", ""),
               "blueprint_ref": str(order.blueprint_ref),
               "generated_at": _now(), "version_selection": order.version_selection},
        "stats": stats,
        "channels": channels_list,
        "files": file_entries,
    }
    (kb_root / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")

    # W10 发货腿：按 version_selection 组装 MD 版/导入包（产物落 outbox，先于打包计入 manifest）
    manifest["versions"] = _assemble_versions(order, base=base, kb_root=kb_root,
                                              order_dir=order_dir)
    (kb_root / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")

    # 打包：镜像树根名=知识库名，zip 写 outbox/<订单号>.zip
    zip_path = base / "outbox" / f"{order.id}.zip"
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
        for p in sorted(order_dir.rglob("*")):
            if p.is_file():
                z.write(p, p.relative_to(order_dir).as_posix())

    stats["elapsed_s"] = round(time.perf_counter() - t0, 3)
    stats["zip_bytes"] = zip_path.stat().st_size
    manifest["stats"] = stats
    (kb_root / "manifest.json").write_text(
        json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
    # zip 内 manifest 与盘上一致：重打包一次（确定性优先，包体积小可接受）
    with zipfile.ZipFile(zip_path, "w", zipfile.ZIP_DEFLATED) as z:
        for p in sorted(order_dir.rglob("*")):
            if p.is_file():
                z.write(p, p.relative_to(order_dir).as_posix())

    return BuildResult(order_id=order.id, kb_name=kb_name, build_dir=str(order_dir),
                       zip_path=str(zip_path), stats=stats, manifest=manifest)


def _process_slot(slot: dict, sd: dict, sd_dir: Path, kb_root: Path,
                  corpus: LocalCorpus, file_entries: list, guide_rows: list) -> dict:
    """单槽位履约：绿源命中→复制；否则进指引清单（建议获取路径按合规三级）。"""
    badge = slot.get("badge", "")
    perm = slot.get("perm", "green")
    slot_name = slot.get("name", "")
    rel_dir = sd.get("path", "")
    row = {"slot": slot_name, "dir": rel_dir, "badge": badge, "perm": perm,
           "status": "guide", "delivered_name": ""}

    hit = None
    if perm != "red" and corpus.available:
        # 绿源优先本地直取（self_owned/green_free；ima/gb 槽若恰有本地同题绿件亦可交付）
        if badge in GREEN_LOCAL_BADGES or badge in ("ima_public", "gb_free"):
            hits = corpus.match(slot.get("title", slot_name), limit=1)
            if hits and Path(hits[0].path).suffix.lower().lstrip(".") == slot.get("ext", ""):
                hit = hits[0]

    if hit is not None:
        dst = sd_dir / Path(hit.path).name
        shutil.copy2(hit.path, dst)          # copy 非 move：语料源文件不动
        entry = {"slot": slot_name, "slot_title": slot.get("title", ""),
                 "path": f"{kb_root.name}/{rel_dir}{Path(hit.path).name}".replace("//", "/"),
                 "dir": rel_dir, "status": "delivered", "badge": badge, "perm": perm,
                 "source_url": slot.get("source_url"),
                 "sha256": hit.sha256(),       # 哈希槽回填（真实文件实测值）
                 "source_path": hit.path, "size_bytes": hit.size_bytes,
                 "advice": None}
        file_entries.append(entry)
        row["status"] = "delivered"
        row["delivered_name"] = Path(hit.path).name
        return row

    advice = advice_for(badge, perm)
    entry = {"slot": slot_name, "slot_title": slot.get("title", ""),
             "path": None, "dir": rel_dir, "status": "guide", "badge": badge, "perm": perm,
             "source_url": slot.get("source_url"),
             "sha256": None, "source_path": None, "size_bytes": None,
             "advice": advice}
    file_entries.append(entry)
    guide_rows.append({"slot": slot_name, "dir": rel_dir, "badge": badge,
                       "perm": perm, "advice": advice})
    return row
