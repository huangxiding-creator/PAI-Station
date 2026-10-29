# -*- coding: utf-8 -*-
"""反模式 lint 发布门（P0 #10，调研 Top #10：TaxonomyForge/termgenie/NVIDIA auto-ontology）。

发布前自动检查本体/蓝图反模式：空节点、深度不均、重复文件、孤儿节点、
命名超长、真实文件覆盖率、标准号格式、层级合理性。

纪律：stdlib only；确定性（无随机源、无时钟）；lint 结果入 provenance 供决策，
不阻断蓝图输出（硬失败=空节点，其余为 warning/info）。
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field

# 检查状态三态半：pass / fail / warning / info（info 不计入 passed/failed/warnings）
PASS, FAIL, WARN, INFO = "pass", "fail", "warning", "info"

# 标准号前缀（长前缀在前，避免 GB 吞掉 GB/T）：前缀紧跟数字=缺空格（如 GB50300）
_STD_PREFIX = ("GB/Z", "GB/T", "DL/T", "CJ/T", "NB/T", "YB/T", "JGJ/T", "TB/T", "JT/T",
               "GB", "SL", "JGJ", "DL", "JT", "TB", "CJJ", "CJ", "WS", "YY", "NB",
               "SY", "SH", "HG", "YB", "QB")
_STD_GLUE_RE = re.compile(
    r"(?<![A-Za-z])(?:" + "|".join(re.escape(p) for p in _STD_PREFIX) + r")\d")

MAX_NAME_CHARS = 30   # e: L1/L2 名称长度上限
MIN_L1, MAX_L1 = 2, 8  # h: L1 总数合理区间
MAX_EXAMPLES = 5      # 详情里最多点名条数（防刷屏，确定性截断）


@dataclass
class LintCheck:
    """单项检查结果。"""
    check_id: str   # 稳定标识（供测试/追溯引用）
    name: str       # 人类可读检查名
    status: str     # pass / fail / warning / info
    detail: str     # 详细信息（违规定位或通过说明）


@dataclass
class LintReport:
    """lint 总报告。"""
    checks: list[LintCheck] = field(default_factory=list)
    passed: int = 0
    failed: int = 0
    warnings: int = 0
    overall_pass: bool = True   # = (failed == 0)
    summary: str = ""

    @classmethod
    def build(cls, checks: list[LintCheck]) -> "LintReport":
        passed = sum(1 for c in checks if c.status == PASS)
        failed = sum(1 for c in checks if c.status == FAIL)
        warnings = sum(1 for c in checks if c.status == WARN)
        infos = sum(1 for c in checks if c.status == INFO)
        verdict = "通过" if failed == 0 else "未通过"
        summary = (f"{len(checks)} 项检查: 通过 {passed} · 警告 {warnings} · 失败 {failed}"
                   + (f" · 信息 {infos}" if infos else "")
                   + f" → 总体{verdict}")
        return cls(checks=checks, passed=passed, failed=failed, warnings=warnings,
                   overall_pass=failed == 0, summary=summary)


def _iter_l2(bp: dict):
    """产出 (l1, l2)；容错缺键。"""
    tree = bp.get("tree") or {}
    for l1 in tree.get("l1") or []:
        for l2 in l1.get("l2") or []:
            yield l1, l2


def _iter_file_names(l2: dict):
    for f in l2.get("files") or []:
        name = f.get("name") if isinstance(f, dict) else f
        if name:
            yield name
    for sd in l2.get("split_dirs") or []:
        for f in sd.get("files") or []:
            name = f.get("name") if isinstance(f, dict) else f
            if name:
                yield name


def _examples(items: list[str]) -> str:
    shown = "、".join(items[:MAX_EXAMPLES])
    return shown + (f" 等{len(items)}处" if len(items) > MAX_EXAMPLES else "")


# ── 各检查项 ──────────────────────────────────────────────────────────────

def _check_empty_nodes(bp: dict) -> LintCheck:
    """a 空节点：L2 files=0 且 split_dirs=0（含分拆目录全空）→ fail。"""
    empties = []
    for l1, l2 in _iter_l2(bp):
        n_files = len(l2.get("files") or [])
        splits = l2.get("split_dirs") or []
        n_split_files = sum(len(sd.get("files") or []) for sd in splits)
        if n_files + n_split_files == 0:
            empties.append(f"{l2.get('code', '?')} {l2.get('name', '')}")
    if empties:
        return LintCheck("empty_nodes", "空节点检查", FAIL,
                         f"空节点(files=0, split_dirs=0): {_examples(empties)}")
    return LintCheck("empty_nodes", "空节点检查", PASS, "无空节点（每个 L2 均有文件或分拆目录）")


def _check_depth_imbalance(bp: dict) -> LintCheck:
    """b 深度不均：某 L1 下 L2<3 且其他 L1 下 L2>10 → warning。"""
    counts = [(l1.get("name", "?"), len(l1.get("l2") or []))
              for l1 in (bp.get("tree") or {}).get("l1") or []]
    thin = [f"{n}={k}" for n, k in counts if k < 3]
    fat = [f"{n}={k}" for n, k in counts if k > 10]
    if thin and fat:
        return LintCheck("depth_imbalance", "深度不均检查", WARN,
                         f"L2 数差异悬殊: 少(<3): {_examples(thin)}；多(>10): {_examples(fat)}")
    return LintCheck("depth_imbalance", "深度不均检查", PASS,
                     "各 L1 下 L2 数无 <3 与 >10 并存的失衡")


def _check_duplicate_files(bp: dict) -> LintCheck:
    """c 重复文件：同一文件名出现在多个 L2 → warning（可能需要交叉引用）。"""
    seen: dict[str, set] = {}
    for _, l2 in _iter_l2(bp):
        for name in _iter_file_names(l2):
            seen.setdefault(name, set()).add(l2.get("code", "?"))
    dups = [f"{name} → {'/'.join(sorted(codes))}"
            for name, codes in sorted(seen.items()) if len(codes) > 1]
    if dups:
        return LintCheck("duplicate_files", "重复文件检查", WARN,
                         f"同名文件出现在多个 L2（考虑交叉引用）: {_examples(dups)}")
    return LintCheck("duplicate_files", "重复文件检查", PASS, "无跨 L2 同名文件")


def _check_orphan_l1(bp: dict) -> LintCheck:
    """d 孤儿节点：L1 下只有 1 个 L2 → warning（考虑合并到相邻 L1）。"""
    orphans = [l1.get("name", "?") for l1 in (bp.get("tree") or {}).get("l1") or []
               if len(l1.get("l2") or []) == 1]
    if orphans:
        return LintCheck("orphan_l1", "孤儿节点检查", WARN,
                         f"仅含 1 个 L2 的 L1（考虑合并到相邻 L1）: {_examples(orphans)}")
    return LintCheck("orphan_l1", "孤儿节点检查", PASS, "无孤儿 L1（均含 ≥2 个 L2）")


def _check_naming_length(bp: dict) -> LintCheck:
    """e 命名一致性：L1/L2 名称 >30 字符 → warning（太长不利于展示）。"""
    long_names = []
    for l1 in (bp.get("tree") or {}).get("l1") or []:
        if len(l1.get("name") or "") > MAX_NAME_CHARS:
            long_names.append(f"L1「{l1['name']}」({len(l1['name'])}字)")
        for l2 in l1.get("l2") or []:
            if len(l2.get("name") or "") > MAX_NAME_CHARS:
                long_names.append(f"L2「{l2.get('name')}」({len(l2['name'])}字)")
    if long_names:
        return LintCheck("naming_length", "命名一致性检查", WARN,
                         f"名称超 {MAX_NAME_CHARS} 字符: {_examples(long_names)}")
    return LintCheck("naming_length", "命名一致性检查", PASS,
                     f"L1/L2 名称均 ≤{MAX_NAME_CHARS} 字符")


def _check_coverage(bp: dict) -> LintCheck:
    """f 覆盖率：stats.real_docs / stats.files < 0.5 → warning（真实文件占比低）。"""
    stats = bp.get("stats") or {}
    files, real = stats.get("files"), stats.get("real_docs")
    if real is None:
        return LintCheck("coverage", "覆盖率检查", PASS, "stats 无 real_docs 字段（taxonomy 占位模式），跳过")
    if not files:
        return LintCheck("coverage", "覆盖率检查", PASS, "stats.files=0，无法计算覆盖率")
    ratio = real / files
    if ratio < 0.5:
        return LintCheck("coverage", "覆盖率检查", WARN,
                         f"真实文件占比 {ratio:.0%} < 50%（{real}/{files}），占位槽过多")
    return LintCheck("coverage", "覆盖率检查", PASS, f"真实文件占比 {ratio:.0%}（{real}/{files}）")


def _check_std_number_format(bp: dict) -> LintCheck:
    """g 标准号格式：含 GB/SL/JGJ 等前缀但紧跟数字缺空格（GB50300）→ info。"""
    glued = []
    for _, l2 in _iter_l2(bp):
        for name in _iter_file_names(l2):
            m = _STD_GLUE_RE.search(name)
            if m:
                glued.append(f"{m.group(0)}（{name}）")
    if glued:
        return LintCheck("std_number_format", "标准号格式检查", INFO,
                         f"标准号疑似缺空格（规范如 \"GB 50300\"）: {_examples(glued)}")
    return LintCheck("std_number_format", "标准号格式检查", PASS, "无缺空格标准号")


def _check_l1_count(bp: dict) -> LintCheck:
    """h 层级合理性：L1 总数 <2 或 >8 → warning（太少不够分类/太多信息过载）。"""
    n = len((bp.get("tree") or {}).get("l1") or [])
    if n < MIN_L1:
        return LintCheck("l1_count", "层级合理性检查", WARN,
                         f"L1 总数 {n} < {MIN_L1}，分类过少")
    if n > MAX_L1:
        return LintCheck("l1_count", "层级合理性检查", WARN,
                         f"L1 总数 {n} > {MAX_L1}，信息过载")
    return LintCheck("l1_count", "层级合理性检查", PASS, f"L1 总数 {n} 在 [{MIN_L1},{MAX_L1}] 内")


_CHECKS = (_check_empty_nodes, _check_depth_imbalance, _check_duplicate_files,
           _check_orphan_l1, _check_naming_length, _check_coverage,
           _check_std_number_format, _check_l1_count)


def lint_blueprint(bp: dict) -> LintReport:
    """对蓝图跑全部 8 项反模式检查（确定性，不修改入参）。"""
    return LintReport.build([fn(bp) for fn in _CHECKS])


def render_lint_report(report: LintReport) -> str:
    """Markdown 格式 lint 报告（表格 + 摘要）。"""
    marks = {PASS: "PASS", FAIL: "FAIL", WARN: "WARN", INFO: "INFO"}
    infos = sum(1 for c in report.checks if c.status == INFO)
    lines = [
        "# 蓝图 Lint 报告",
        "",
        f"- **总体**: {'通过' if report.overall_pass else '未通过'}（overall_pass = failed==0）",
        f"- **统计**: 通过 {report.passed} · 警告 {report.warnings} · 失败 {report.failed}"
        + (f" · 信息 {infos}" if infos else ""),
        "",
        "| # | 检查项 | 结果 | 详情 |",
        "|---|--------|------|------|",
    ]
    for i, c in enumerate(report.checks, 1):
        detail = c.detail.replace("|", "\\|").replace("\n", " ")
        lines.append(f"| {i} | {c.name} | {marks.get(c.status, c.status)} | {detail} |")
    lines += ["", f"> {report.summary}"]
    return "\n".join(lines) + "\n"
