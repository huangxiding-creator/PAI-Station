# -*- coding: utf-8 -*-
"""T43 单测：RELEASE.md 四章 + 发布门四件（FR11.AC1 / NFR3 / NFR6 发布门扫描）。

被测物 = kb_factory/harvest_engine/tools/release_gate.py（发布门四门机检器）
+ kb_factory/harvest_engine/RELEASE.md（FR11.1 四章发布文档）：
- 章① 发布说明（含六条如实披露账——任务卡口径）；
- 章② 安全门报告（沿 kb_factory/SECURITY_CHECKLIST.md 9 项清单逐项报状态）；
- 章③ E2E 报告（FR9/NFR5 + 三链验收数据引用）；
- 章④ 合规声明（PROPOSAL §6 四条红线 + 四标记映射 needs_vip_candidate/
  paid_wall/blocked_waf/blocked_mirror_policy + 黄线透明标注口径）。

发布门四门（REQUIREMENTS W8→W10 准入）：
- G1 NFR3 密钥明文扫描 0 未豁免命中（豁免=sha256 表，值不复制进本件）；
- G2 NFR6 license 扫描零 GPL import（FFDec/presse=GPL-3.0 仅子进程不进仓注记）；
- G3 check_p0 子进程 PASS（engine/PENTAGI/ 4 份研判 P0 全清）；
- G4 pytest 全套（KB_HARVEST_SKIP_LIVE=1 实弹跳过须明示）——本测件用
  ``--skip-pytest`` 快测档验证门器骨架，不递归跑全套（全套=验收命令本体）。
"""
import hashlib
import json
import subprocess
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine

_SAMPLES = json.loads((Path(__file__).resolve().parent / "fixtures" / "_nfr3_scan_samples.json")
                      .read_text(encoding="utf-8"))
_POS = [(s["file"], s["line"]) for s in _SAMPLES["positives"]]
_NEG = [(s["file"], s["line"]) for s in _SAMPLES["negatives"]]

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.tools import release_gate as rg
except ImportError:  # pragma: no cover - worktree 回退
    from harvest_engine.tools import release_gate as rg  # type: ignore

_ENGINE = Path(rg.__file__).resolve().parents[1]
_RELEASE_MD = _ENGINE / "RELEASE.md"


# ---------------------------------------------------------------------------
# FR11.AC1 —— 四章齐（章①-④ 标题 + 各章硬锚点）
# ---------------------------------------------------------------------------

def test_fr11_ac1_release_md_four_chapters_present():
    """章①发布说明/②安全门报告(9项清单)/③E2E报告/④合规声明——四标题齐。"""
    text = _RELEASE_MD.read_text(encoding="utf-8")
    for anchor in ("① 发布说明", "② 安全门报告", "③ E2E 报告", "④ 合规声明"):
        assert anchor in text, f"FR11.1 缺章锚点: {anchor}"


def test_fr11_ac1_chapter2_alongs_security_checklist_nine_items():
    """章② 沿 kb_factory/SECURITY_CHECKLIST.md 9 项清单逐项报状态（9 项名全在场）。"""
    text = _RELEASE_MD.read_text(encoding="utf-8")
    assert "SECURITY_CHECKLIST" in text
    for item in ("凭据零入仓", "零删除红线", "频控参数在位", "黄源双闸", "敏感词门",
                 "网络面白名单", "日志无凭据打印", "测试覆盖入口", "生产开关人工核"):
        assert item in text, f"章② 缺 9 项清单条目: {item}"


def test_fr11_ac1_chapter4_four_redlines_and_marker_mapping():
    """章④ 合规声明=PROPOSAL §6 四条红线 + 四标记映射全在场。"""
    text = _RELEASE_MD.read_text(encoding="utf-8")
    for marker in ("needs_vip_candidate", "paid_wall", "blocked_waf", "blocked_mirror_policy"):
        assert marker in text, f"章④ 缺标记映射: {marker}"
    # 四红线（§6 要义词：付费墙不破/绿黄红分级/判例不二传/GPL 隔离）
    for word in ("付费墙", "绿", "GPL 隔离"):
        assert word in text, f"章④ 缺红线要义: {word}"


def test_fr11_ac1_chapter1_six_disclosures():
    """章① 六条如实披露账全在场（任务卡口径逐条锚定）。"""
    text = _RELEASE_MD.read_text(encoding="utf-8")
    for anchor in (
        "verify 段4",            # ① wenku verify 段4 未实装（编排隔离口径）
        "fetch_ladder",          # ② book118 fetch_ladder→PDF 正式接线欠账
        "KB_CSDN_COOKIE",       # ③ CSDN VIP cookie 挂账（供给即转 live）
        "第二 wenku 账号",        # ④ 第二账号挂账（单账号+槽位单测口径）
        "62 页",                 # ⑤ 长档 OCR 小时级+切片模式必用
        "换栈",                  # ⑥ 双栈换栈=中期路线已记档
    ):
        assert anchor in text, f"章① 缺披露账锚点: {anchor}"


def test_fr11_ac1_release_md_publishes_gate_commands():
    """NFR3/NFR6 发布门扫描命令入章②（发布门=release_gate.py 四门）。"""
    text = _RELEASE_MD.read_text(encoding="utf-8")
    assert "tools/release_gate.py" in text
    assert "NFR3" in text and "NFR6" in text
    assert "check_p0" in text and "pytest" in text


# ---------------------------------------------------------------------------
# NFR3 门器 —— 密钥明文模式扫描（合成样本：因正确原因命中/不命中）
# ---------------------------------------------------------------------------

def test_nfr3_scan_flags_cred_literal_assignment():
    """R1：凭据名=字面量 赋值形态命中（password/token/cookie 字面量；合成样本在夹具）。"""
    hits = rg.nfr3_scan_lines(_POS[:2])
    assert len(hits) == 2
    assert all(h.rule == "R1" for h in hits)


def test_nfr3_scan_flags_bduss_cookie_literal():
    """R2：BDUSS/STOKEN/BAIDUID cookie 字面量形态命中（baidu 登录凭据）。"""
    hits = rg.nfr3_scan_lines(_POS[2:])
    assert len(hits) == 1 and hits[0].rule == "R2"


def test_nfr3_scan_ignores_env_lookup_and_placeholder():
    """环境读取/占位值/非字面量不命中（零造假：env 名≠明文凭据；stub/xxx=占位）。"""
    hits = rg.nfr3_scan_lines(_NEG)
    assert hits == []


def test_nfr3_exemption_table_is_hash_only():
    """豁免表只存 sha256（值不复制进本件——自扫描不自杀）。"""
    for key in rg.NFR3_EXEMPT:
        assert hashlib.sha256(b"").hexdigest() != key
        assert len(key) == 64 and all(c in "0123456789abcdef" for c in key), \
            f"豁免键非 sha256 hex: {key[:8]}…"
    assert len(rg.NFR3_EXEMPT) >= 2  # T19 探针样本 token + 上游公开金样 token


def test_nfr3_scan_exempt_sample_by_sha256():
    """已豁免样本值（sha256 表内）扫描不报未豁免命中。"""
    sample = next(iter(rg.NFR3_EXEMPT))  # 任意一把豁免键=某样本值的 sha256
    # 反查样本值不可能（单向）；此处验证：豁免路径计数=扫描器出口参数
    hits = rg.nfr3_scan_lines([("f.py", 'token = "Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi"')])
    assert hits == []  # 上游 DocumentBrowserTest.PREVIEW_PAGE 公开金样（豁免在案）


def test_nfr3_engine_tree_zero_unexplained_hits():
    """G1 主判：引擎树实测未豁免命中=0（扫描面排除夹具/运行件如实打印）。"""
    ok, detail = rg.gate1_nfr3_secrets()
    assert ok, detail
    assert "未豁免命中 0" in detail


# ---------------------------------------------------------------------------
# NFR6 门器 —— license 扫描（零 GPL import；FFDec/presse=子进程注记）
# ---------------------------------------------------------------------------

def test_nfr6_import_roots_flags_banned_gpl():
    """禁根命中：fitz(AGPL)/doc88_extractor(原 GPL 码)/presse/ffdec 模块面。"""
    roots = rg.import_roots("import fitz\nfrom doc88_extractor import x\nimport pypdfium2\n")
    assert rg.GPL_BANNED_ROOTS & roots == {"fitz", "doc88_extractor"}
    assert "pypdfium2" in roots


def test_nfr6_engine_runtime_zero_gpl_import():
    """G2 主判：引擎运行面 import 实测零禁根 + GPL-3.0 子进程注记在场。"""
    ok, detail = rg.gate2_nfr6_license()
    assert ok, detail
    assert "GPL-3.0" in detail and "子进程" in detail


# ---------------------------------------------------------------------------
# 发布门骨架 —— 四门编排（快测档 --skip-pytest：G4 显式 SKIPPED 不冒充 PASS）
# ---------------------------------------------------------------------------

def test_release_gate_quick_mode_reports_four_gates():
    """快测档子进程：G1/G2/G3 判定 + G4=SKIPPED（明示）+ 汇总行 + rc=0。"""
    proc = subprocess.run(
        [sys.executable, str(_ENGINE / "tools" / "release_gate.py"), "--skip-pytest"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        cwd=str(_KB_DIR.parent), timeout=600,
    )
    assert proc.returncode == 0, proc.stdout + proc.stderr
    assert "G1" in proc.stdout and "G2" in proc.stdout and "G3" in proc.stdout
    assert "SKIPPED" in proc.stdout and "skip-pytest" in proc.stdout
    assert "release_gate: PASS" in proc.stdout


def test_release_gate_check_p0_gate_passes_on_cleared_reports():
    """G3 主判：check_p0 子进程 4 份研判 P0 全清（T41 清偿后口径）。"""
    ok, detail = rg.gate3_check_p0()
    assert ok, detail
    assert "P0 全清" in detail or "PASS" in detail
