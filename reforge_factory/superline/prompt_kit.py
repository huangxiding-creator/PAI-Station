# -*- coding: utf-8 -*-
"""S0-4 解析腿标准件三件 (超级生产线).

  ① 复述纪律: 解析腿 SYSTEM 提示词焊死「首步复述」, 复述进 Charter 草案
     首栏 (restatement — S0-3 已落字段, 本件落提示词面与发码钩子)
  ② 反例问题: 必产 ≥3 条 (「X 为什么是错的/X 被谁取代」) 落战役 04 网络
     调研指令文件 — S2 ACH 假设对抗的对立面弹药预埋
  ③ 英文意图词剥离 + 释义扇出: 英文报告名过剥离表 → 核心词; 每个 T1/T2
     英文词带 ≥3 释义扇出变体 (内置术语表 + 模板兜底, 零付费零检索).

验收 (三项逐条 grep 可验): Charter 草案含复述栏 / 战役 04 指令含反例问题
文件 / 英文战役词表带扇出 ≥3 变体.

用法:
  python superline/prompt_kit.py --battle-dir D [--title "英文 title"]
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

import superline as _sl
from superline import charter_gate as CG
from superline import tier_expander as TE

# 英文意图词剥离表 (功能词/问式词 — 剥离后余=核心实体词)
STRIP_EN = frozenset({
    "how", "to", "why", "what", "when", "which", "who", "whom", "whose",
    "is", "are", "was", "were", "the", "a", "an", "of", "for", "in", "on",
    "and", "or", "with", "about", "analysis", "analyses", "research",
    "report", "study", "deep", "dive", "review", "overview", "guide",
    "exploring", "understanding", "understand", "explain", "explains",
    "using", "use", "wins", "win", "beating", "beat", "do", "does", "did",
    "matters", "matter", "works", "work", "insight", "insights", "means",
    "mean", "meaning", "secrets", "secret", "playbook", "vs", "versus",
    "company", "companies", "corporation", "inc", "ltd", "llc", "co",})

# 内置术语释义表 (常见行业缩略语; 未知词走模板兜底)
GLOSSARY_EN = {
    "EPC": ("工程总承包", "engineering procurement construction"),
    "PMC": ("项目管理承包", "project management contract"),
    "FIDIC": ("国际咨询工程师联合会合同体系", "international federation of consulting engineers"),
    "BIM": ("建筑信息模型", "building information modeling"),
    "BOT": ("建设-运营-移交", "build operate transfer"),
    "PPP": ("政府和社会资本合作", "public private partnership"),
    "ESG": ("环境社会治理", "environmental social governance"),
    "OEM": ("代工生产", "original equipment manufacturer"),
    "REITs": ("不动产投资信托", "real estate investment trusts"),
    "LNG": ("液化天然气", "liquefied natural gas"),
}

COUNTER_FILE = "反例问题清单.md"        # 战役 04 调研指令件
EN_FANOUT_FILE = "英文词表扇出.md"      # 战役 04 调研指令件
SYSTEM_PROMPT_PATH = Path(__file__).resolve().parent / "prompts" / "parser_leg.md"

SYSTEM_PROMPT = """# 解析腿 SYSTEM 提示词 (标准件, 焊死三条)

## 规则一: 首步复述 (防自说自话)
接到报告名的第一步: 用自己的话复述这份报告要回答什么、给谁看、体量多大。
复述写入 Charter 草案首栏 (restatement 字段), 未复述不进任何后续步骤。

## 规则二: 反例问题必产 (ACH 对立面弹药)
立题必产 ≥3 条反例问题: 「X 为什么可能是错的 / X 被谁取代 / X 的失败
案例与质疑」。反例问题清单落战役 04 网络调研指令文件, 检索腿正面查完
必查反面 (风险/纠纷/处罚/失败案例/质疑)。

## 规则三: 英文意图词剥离 + 释义扇出
英文报告名先过剥离表 (STRIP_EN), 剥掉功能词与问式词, 余下=核心实体词;
每个 T1/T2 英文词带 ≥3 释义扇出变体 (中文释义/全称展开/语境词), 查询池
用扇出面不用裸词 — 治「非英语原创研究信源」盲区。
"""


# ---------- ① SYSTEM 提示词落盘 (幂等) ----------
def ensure_system_prompt() -> Path:
    SYSTEM_PROMPT_PATH.parent.mkdir(parents=True, exist_ok=True)
    if not SYSTEM_PROMPT_PATH.is_file():
        SYSTEM_PROMPT_PATH.write_text(SYSTEM_PROMPT, encoding="utf-8")
    return SYSTEM_PROMPT_PATH


# ---------- ③ 英文剥离 + 释义扇出 ----------
def en_core_terms(title: str) -> list[str]:
    """英文报告名 → 核心实体词 (过 STRIP_EN 剥离表)."""
    words = re.findall(r"[A-Za-z][A-Za-z0-9&.-]{1,}", title or "")
    return [w for w in dict.fromkeys(words)
            if w.lower().strip(".-") not in STRIP_EN]


def en_fanout(word: str) -> list[str]:
    """英文词 → ≥3 释义扇出变体 (内置术语表优先, 模板兜底). 零检索."""
    w = word.strip()
    if w in GLOSSARY_EN:
        zh, full = GLOSSARY_EN[w]
        return [w, f"{w} {zh}", f"{w} {full}", f"{zh} {w} 模式"]
    return [w, f'"{w}"', f"{w} 公司 案例", f"{w} China case study"]


def is_en_battle(title: str) -> bool:
    ascii_n = sum(1 for c in (title or "") if c.isascii() and c.isalpha())
    cjk_n = sum(1 for c in (title or "") if "一" <= c <= "鿿")
    return ascii_n > cjk_n * 2 and ascii_n >= 4


# ---------- ②③ 战役 04 指令件落盘 ----------
def _dir04(battle_dir: str) -> Path:
    bd = Path(battle_dir) if battle_dir else Path(".")
    hit = next((s for s in sorted(bd.iterdir())
                if s.is_dir() and s.name.startswith("04")), None) if bd.is_dir() else None
    out = hit or bd / "04 网络调研搜集的资料"
    out.mkdir(parents=True, exist_ok=True)
    return out


def emit_battle_prompts(battle_dir: str, title: str = "") -> dict[str, Path]:
    """Charter 草案 → 战役 04 两指令件 (反例问题清单 + 英文词表扇出).

    复述栏由 S0-3 build 落进 charter_draft (本件保证读取链通 + 提示词在位)."""
    ensure_system_prompt()
    out00 = CG._out_dir(battle_dir)
    ch = CG._read_json(out00 / CG.DRAFT) or CG._read_json(out00 / CG.SUBMITTED)
    title = title or (ch.get("report_title") or "")
    company = ch.get("company") or TE.extract_company_name(title) or title
    if not ch:                       # 无 charter 也能发码 (规则面兜底)
        ch = {"counter_questions": CG._counter_questions(company, title),
              "tiers": {"T1": TE.name_variants(company)[0]["word"],
                        "T2": []}}

    d04 = _dir04(battle_dir)
    # ② 反例问题清单 (ACH 对立面, 检索腿正面查完必查反面)
    lines = ["# 反例问题清单 (ACH 对立面弹药 — 检索腿必查反面)", "",
             "> 来源: Charter counter_questions (S0-4 标准件②);",
             "> 正面查完必查反面: 风险/纠纷/处罚/失败案例/质疑。", ""]
    lines += [f"{i}. {q}" for i, q in enumerate(ch.get("counter_questions")
                                                 or [], 1)]
    lines += ["", "## 反面检索词 (每条反例问题至少配一组)", ""]
    lines += [f"- {company} 纠纷|处罚|败诉|失败案例",
              f"- {company} 质疑|争议|风险|亏损",
              f"- {company} 被取代|丢失订单|市场份额下滑"]
    p_counter = d04 / COUNTER_FILE
    p_counter.write_text("\n".join(lines) + "\n", encoding="utf-8")

    # ③ 英文词表扇出 (英文战役必带; 中文战役诚实标注零英文词)
    words = sorted({w for w in (ch.get("tiers", {}).get("T1", [])
                                + ch.get("tiers", {}).get("T2", []))
                    if w.isascii() and any(c.isalpha() for c in w)})
    flines = ["# 英文词表释义扇出 (S0-4 标准件③)", ""]
    if words:
        flines += [f"> 战役英文词 {len(words)} 个, 每词 ≥3 扇出变体 "
                   f"(查询池用扇出面不用裸词)。", ""]
        for w in words:
            vs = en_fanout(w)
            assert len(vs) >= 3
            flines.append(f"- **{w}**: " + " | ".join(vs))
    else:
        flines += ["> 查无英文词 (中文战役) — 剥离表与扇出器在位, "
                   "英文词入表即自动扇出。"]
    p_en = d04 / EN_FANOUT_FILE
    p_en.write_text("\n".join(flines) + "\n", encoding="utf-8")
    return {"counter": p_counter, "en_fanout": p_en,
            "system_prompt": SYSTEM_PROMPT_PATH}


def verify_grep(battle_dir: str) -> dict[str, bool]:
    """三项逐条 grep 验收: 复述栏/反例问题文件/扇出 ≥3 变体."""
    out00 = CG._out_dir(battle_dir)
    d04 = _dir04(battle_dir)
    ch = CG._read_json(out00 / CG.DRAFT) or CG._read_json(out00 / CG.SUBMITTED)
    rest = bool((ch.get("restatement") or "").strip()) and "复述" in (
        ch.get("restatement") or "")
    cfile = d04 / COUNTER_FILE
    n_counter = len(re.findall(r"^\d+\. ", cfile.read_text(
        encoding="utf-8"), flags=re.M)) if cfile.is_file() else 0
    efile = d04 / EN_FANOUT_FILE
    fan_ok = False
    if efile.is_file():
        txt = efile.read_text(encoding="utf-8")
        rows = re.findall(r"^- \*\*(\S+)\*\*: (.+)$", txt, flags=re.M)
        fan_ok = all(len(v.split(" | ")) >= 3 for _, v in rows) and bool(
            rows) or ("查无英文词" in txt and not rows)
    return {"restatement": rest, "counter_file": n_counter >= 3,
            "en_fanout": fan_ok, "n_counter": n_counter}


def main(argv: list[str] | None = None) -> int:
    import argparse
    ap = argparse.ArgumentParser(description="S0-4 解析腿标准件三件")
    ap.add_argument("--battle-dir", default="")
    ap.add_argument("--title", default="")
    ap.add_argument("--verify", action="store_true")
    args = ap.parse_args(argv)
    print(f"[s0-4] superline {_sl.__version__} 解析腿标准件 "
          f"(复述/反例/英文剥离)")
    if args.verify:
        v = verify_grep(args.battle_dir)
        print(f"[s0-4] grep 验收: 复述栏={v['restatement']} "
              f"反例文件({v['n_counter']}条)={v['counter_file']} "
              f"扇出={v['en_fanout']}")
        return 0 if all((v["restatement"], v["counter_file"],
                         v["en_fanout"])) else 1
    if not args.battle_dir:
        print("[s0-4] 须 --battle-dir", file=sys.stderr)
        return 2
    paths = emit_battle_prompts(args.battle_dir, args.title)
    print(f"[s0-4] 落盘: {paths['counter']}\n       {paths['en_fanout']}\n"
          f"       {paths['system_prompt']}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
