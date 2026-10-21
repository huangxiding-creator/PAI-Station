# -*- coding: utf-8 -*-
"""蓝图 JSON 构造：三级树节点、路径编号（如 F-03/02/）、_INDEX.md 枢纽卡、
>200 分拆、配比分档、规范化输出。"""
import json

MAX_FILES_PER_DIR = 200  # 受控扇出律：单目录文件硬上限，超出自动分拆
TIERS = ("core", "field", "guide")


def tier_counts(n: int, ratio: dict) -> dict:
    """n 个槽按配比分三档（最大余数法，和恒等于 n，确定性）。"""
    floors = {t: n * ratio[t] // 100 for t in TIERS}
    rem = n - sum(floors.values())
    order = sorted(TIERS, key=lambda t: (-(n * ratio[t] / 100 - floors[t]), TIERS.index(t)))
    for t in order[:rem]:
        floors[t] += 1
    return floors


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


def assemble_blueprint(domain, need, tree, ratio, stats, quote, provenance) -> dict:
    """按 FR2 顶层 schema 组装蓝图（键序固定，输出确定性）。"""
    return {"domain": domain, "need": need, "tree": tree, "ratio": ratio,
            "stats": stats, "quote": quote, "provenance": provenance}


def canonical_json(bp: dict) -> str:
    """规范化输出：排序键+紧凑分隔，供确定性比对与留档。"""
    return json.dumps(bp, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
