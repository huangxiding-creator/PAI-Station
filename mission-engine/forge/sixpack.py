# -*- coding: utf-8 -*-
"""forge/sixpack.py — W4.3 SCORECARD门固化+六件套铸模（草案→成品→审批闸）。

铁律来源(1023用户令): 提案只认三族(研究报告/解决方案/线上部署工具服务)·KB禁区·
四重门(对抗校验已在W4.1草案内/本件=②SCORECARD+③DeltaIndex铸模+④审批闸推送)·
DeltaIndex计数轴必须锚Outcome(seq指针),禁无锚倍率(数字零造假)·Σlog10≥2·
六件套缺一不可·推送默认关(--push须显式,且须--live真评分,离线桩分禁推)。

链: 草案md(解析标题/能力/评分/seq证据) + spec.json(族/轴/WBS/成本/风险)
→ 门1产品族(白名单+KB禁区扫描) → 门2SCORECARD(feasibility/value/monetization/
tenx加权, 0.25/0.35/0.25/0.15, 加权≥6.0且单维≥3) → 门3DeltaIndex(计数轴
multiplier≥2+anchor含seqN+falsifiable非空; Σlog10≥2; 期权轴不计Σ)
→ 渲染六件套md落proposals/ → (--push)调approval_gate.py request --body-file。
W4.2附挂: 过门后自动附Jev判断层advisory(res['jev'],不过门;离线=offline零外呼)。

CLI: py -X utf8 -m forge.sixpack cast <draft.md> --spec spec.json
        [-o 名] [--live] [--push] [--task W4.4] [--benefit 一句话]
     py -X utf8 -m forge.sixpack demo-spec        # spec模板(字段自释)
离线默认StubScorecardLm确定性桩；门禁不过=零输出零推送退出码2。
"""
from __future__ import annotations

import argparse
import json
import math
import re
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PROPOSALS = ROOT / "proposals"
FORGE_LEDGER = ROOT / "ledger" / "forge.jsonl"

FAMILIES = ("research_report", "solution", "deployed_tool")
FAMILY_CN = {"research_report": "研究报告", "solution": "解决方案",
             "deployed_tool": "线上部署工具/服务"}
KB_BAN = (re.compile(r"知识库"), re.compile(r"\bKB\b", re.I))
WEIGHTS = {"feasibility": 0.25, "value": 0.35, "monetization": 0.25, "tenx": 0.15}
CARD_MIN_AVG = 6.0
CARD_MIN_DIM = 3.0
DELTA_MIN_SUM = 2.0          # Σlog10 ≥ 2 ⇔ 100×（1023铁律）
SEQ_PTR = re.compile(r"seq\d+")

SCORECARD_SYSTEM = (
    "你是SCORECARD门评审官(0-10整数分,数字零造假:每分须给rationale依据)。"
    "对下述提案草案与证据打四维分并只输出JSON:"
    '{"feasibility":用站内现成件落地的可行性,"value":对目标用户Job的改善幅度,'
    '"monetization":三族变现路径清晰度(上架/订阅/服务),"tenx":相对现状的量级差证据强度,'
    '"rationale":"一句话依据"}')


class StubScorecardLlm:
    """离线确定性桩：默认过门分值；dims 可注入以测门禁失败分支。"""

    def __init__(self, dims: dict | None = None):
        self.dims = dims or {"feasibility": 7, "value": 8,
                             "monetization": 7, "tenx": 8}
        self.calls = 0

    def chat_json(self, system, user, temperature=0.2, timeout=60):
        self.calls += 1
        return {**self.dims, "rationale": "离线桩评分（测试专用，禁推送）"}


# ── 草案解析 ──────────────────────────────────────────────────────────
def parse_draft(text: str) -> dict:
    m = re.search(r"【锻造厂草案·(R[\d\-]+)】", text)
    if not m:
        raise ValueError("草案头【锻造厂草案·R…】未命中——本铸模只吃W4.1草案")
    run_id = m.group(1)

    def section(mark):
        mm = re.search(re.escape(mark) + r"[^\n]*\n(.+?)(?=\n\n|\n[①②③④⑤]|\Z)",
                       text, re.S)
        return mm.group(1).strip() if mm else ""

    s1 = section("① 标题+一句话")
    lines = [x.strip() for x in s1.splitlines() if x.strip()]
    if len(lines) < 2:
        raise ValueError("①段缺标题或一句话")
    title, one_liner = lines[0], lines[1]
    cap = next((x.strip() for x in section("② 能力单元").splitlines()
                if x.strip()), "")
    sc = re.search(r"→\s*综合\s*([\d.]+)", text)
    seqs = list(dict.fromkeys(int(x) for x in re.findall(r"seq(\d+)｜", text)))
    if not seqs:
        raise ValueError("④段无seq指针——零造假铁律,无溯源不铸模")
    return {"run_id": run_id, "title": title, "one_liner": one_liner,
            "capability": cap, "score": float(sc.group(1)) if sc else None,
            "seqs": seqs}


# ── 门1 产品族 ────────────────────────────────────────────────────────
def gate_family(spec: dict, draft: dict) -> tuple[bool, str]:
    fam = spec.get("family", "")
    if fam not in FAMILIES:
        return False, f"族外不推: {fam!r} 不在三族白名单{list(FAMILIES)}"
    blob = " ".join([str(spec.get(k, "")) for k in
                     ("one_liner", "signal_anchor")]
                    + [spec.get(k, "") or "" for k in ("title_override",)]
                    + [draft["title"], draft["one_liner"], draft["capability"]]
                    + [str(a.get("anchor", "")) for a in spec.get("axes", [])])
    for pat in KB_BAN:
        hit = pat.search(blob)
        if hit:
            return False, f"KB禁区(1023令): 命中 {hit.group(0)!r}"
    return True, FAMILY_CN[fam]


# ── 门2 SCORECARD ─────────────────────────────────────────────────────
def gate_scorecard(llm, draft: dict, spec: dict) -> tuple[bool, dict]:
    user = json.dumps({"title": draft["title"],
                       "one_liner": spec.get("one_liner", draft["one_liner"]),
                       "capability": draft["capability"],
                       "family": spec.get("family"),
                       "seqs": draft["seqs"]}, ensure_ascii=False)
    card = llm.chat_json(SCORECARD_SYSTEM, user)
    for k in WEIGHTS:
        card[k] = float(card.get(k, 0))
    avg = sum(card[k] * w for k, w in WEIGHTS.items())
    worst = min(card[k] for k in WEIGHTS)
    ok = avg >= CARD_MIN_AVG and worst >= CARD_MIN_DIM
    card.update({"weighted": round(avg, 2), "worst": worst, "pass": ok})
    return ok, card


# ── 门3 DeltaIndex ────────────────────────────────────────────────────
def gate_delta(axes: list[dict]) -> tuple[bool, dict]:
    if not axes:
        return False, {"sigma": 0.0, "fail": "零轴——DeltaIndex强制附件缺失"}
    sigma, fails = 0.0, []
    for a in axes:
        name = a.get("axis", "?")
        if not a.get("counted", True):                 # 期权轴: 只查锚与判据
            if not (a.get("anchor") and a.get("falsifiable")):
                fails.append(f"{name}: 期权轴也须anchor+falsifiable")
            continue
        m = float(a.get("multiplier") or 0)
        if m < 2:
            fails.append(f"{name}: 倍率{m}×<2×(log10无意义)")
        if not a.get("anchor") or not SEQ_PTR.search(str(a.get("anchor", ""))):
            fails.append(f"{name}: anchor缺seq指针——禁无锚倍率")
        if not str(a.get("falsifiable", "")).strip():
            fails.append(f"{name}: 无可证伪判据")
        sigma += math.log10(m) if m > 0 else 0.0
    sigma = round(sigma, 3)
    ok = not fails and sigma >= DELTA_MIN_SUM
    return ok, {"sigma": sigma, "claim_x": 10 ** int(sigma),
                "fails": fails, "pass": ok}


# ── 铸模渲染 ──────────────────────────────────────────────────────────
def render(draft: dict, spec: dict, card: dict, delta: dict,
           family_cn: str, live: bool) -> str:
    seqs = "、".join(f"seq{s}" for s in draft["seqs"][:12])
    ax_lines = [f"- 需求实测锚（非倍率）: {spec['signal_anchor']}"]
    for a in spec["axes"]:
        if a.get("counted", True):
            ax_lines.append(f"- {a['axis']} {a['multiplier']}×: {a['anchor']}"
                            f"｜判据：{a['falsifiable']}")
        else:
            ax_lines.append(f"- {a['axis']}（期权不计入Σ）: {a['anchor']}"
                            f"｜判据：{a['falsifiable']}")
    wbs = "\n".join(
        f"{w['step']}: {w['what']}｜现成件: {w.get('reuse', '—')}"
        f"｜{w.get('hours', '—')}h｜验收: {w['acceptance']}"
        for w in spec["wbs"]) or "（WBS空）"
    risks = "\n".join(f"- {r}" for r in spec.get("risks", [])) or "- （无）"
    grade = "GLM评分实测" if live else "离线桩评分(禁推送)"
    return f"""【信号源】草案{draft['run_id']}({draft['score'] or '—'}分)+{seqs}真信号指针可回查主账本·门禁: 族={family_cn}✓ SCORECARD={card['weighted']}/10(f{card['feasibility']:.0f}/v{card['value']:.0f}/m{card['monetization']:.0f}/t{card['tenx']:.0f},{grade}) ΔΣlog10={delta['sigma']:.2f}

① 标题+一句话
{spec.get('title_override') or draft['title']}
{spec['one_liner']}

② Ten× Delta Index（Σlog10={delta['sigma']:.2f} ≥ 2，主张≈{delta['claim_x']}×，判据全可证伪）
{chr(10).join(ax_lines)}

③ 实施方案（WBS·每步=做什么/现成件/耗时/验收）
{wbs}

④ 资源与成本
{spec['cost']}

⑤ 风险与红线对齐
{risks}

⑥ 回复选项
{spec['reply_opts']}

（W4.3铸模成品·门1/2/3全过自动生成；数字零造假:分值为{grade},轴锚全含seq指针）
"""


def _jev_advisory(draft: dict, spec: dict, *, live: bool, jev):
    """W4.2判断层第二意见附挂: 注入jev可调用优先(测试桩);live才惰性真调;
    离线=明确offline(零外呼纪律)。advisory不过门——未过门位禁闸。"""
    if callable(jev):
        try:
            return jev(draft, spec)
        except Exception as e:                          # noqa: BLE001
            return {"available": False, "error": str(e)[:120]}
    if not live:
        return {"available": False, "reason": "offline"}
    try:
        from forge.jev_gate import advisory as _adv
        return _adv(draft, spec)
    except Exception as e:                              # noqa: BLE001
        return {"available": False, "error": str(e)[:120]}


# ── 主链 ──────────────────────────────────────────────────────────────
def cast(draft_path: Path, spec: dict, *, llm=None, live: bool = False,
         out_dir: Path = PROPOSALS, ledger_file: Path = FORGE_LEDGER,
         push: bool = False, task: str = "W4.4",
         benefit: str = "", jev=None) -> dict:
    draft = parse_draft(Path(draft_path).read_text(encoding="utf-8"))
    res = {"draft": str(draft_path), "run_id": draft["run_id"], "gates": {}}

    ok1, why1 = gate_family(spec, draft)
    res["gates"]["family"] = {"pass": ok1, "detail": why1}
    if not ok1:
        return _fail(res, ledger_file)

    llm = llm or StubScorecardLlm()
    ok2, card = gate_scorecard(llm, draft, spec)
    res["gates"]["scorecard"] = card
    if not ok2:
        return _fail(res, ledger_file)

    ok3, delta = gate_delta(spec.get("axes") or [])
    res["gates"]["delta"] = delta
    if not ok3:
        return _fail(res, ledger_file)

    body = render(draft, spec, card, delta, why1, live)
    slug = spec.get("slug") or f"seq{draft['seqs'][0]}"
    out = Path(out_dir) / (
        spec.get("outfile")
        or f"{time.strftime('%Y%m%d')}-{slug}-六件套.md")
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(body, encoding="utf-8")
    res["out"] = str(out)
    res["pass"] = True
    res["jev"] = _jev_advisory(draft, spec, live=live, jev=jev)

    if push:
        if not live:
            res["pushed"] = False
            res["push_error"] = "离线桩分禁推(数字零造假)——须--live"
        else:
            cmd = build_push_cmd(draft, spec, out, task, benefit)
            r = subprocess.run(cmd, capture_output=True, text=True,
                               encoding="utf-8", cwd=str(ROOT))
            res["pushed"] = r.returncode == 0
            res["push_cmd"] = " ".join(cmd)
            res["push_tail"] = (r.stdout or r.stderr).strip()[-300:]
    _ledger(ledger_file, res)
    return res


def build_push_cmd(draft: dict, spec: dict, out: Path,
                   task: str, benefit: str) -> list[str]:
    return [sys.executable, "-X", "utf8", "approval_gate.py", "request",
            "--task", task,
            "--title", (spec.get("push_title")
                        or f"提案：{spec.get('title_override') or draft['title']}"),
            "--summary", spec["one_liner"],
            "--benefit", benefit or spec.get("benefit", ""),
            "--body-file", str(out)]


def _fail(res: dict, ledger_file: Path) -> dict:
    res["pass"] = False
    res["out"] = None
    _ledger(ledger_file, res)
    return res


def _ledger(ledger_file: Path, res: dict) -> None:
    ledger_file.parent.mkdir(parents=True, exist_ok=True)
    with ledger_file.open("a", encoding="utf-8") as f:
        f.write(json.dumps({"ts": time.strftime("%Y-%m-%d %H:%M:%S"),
                            "event": "w43_cast", "detail": res},
                           ensure_ascii=False, separators=(",", ":")) + "\n")


DEMO_SPEC = {
    "family": "research_report",
    "slug": "seqNN-主题短名",
    "one_liner": "①段那句话的定稿版(铸模可改写草案原句)",
    "signal_anchor": "需求实测锚:同诉求N群M日观测K次(seqNn…urgency=…)—非倍率",
    "title_override": "《报告全名》(可选,不填用草案标题)",
    "axes": [
        {"axis": "时效", "multiplier": 10, "counted": True,
         "anchor": "锚Outcome指标+seq指针,如:自行汇编以工作日计→一次到手(seq49)",
         "falsifiable": "可证伪判据:任抽N条自行复现合计<X时间=伪"},
        {"axis": "变现", "multiplier": 0, "counted": False,
         "anchor": "期权锚:上架即走既有发布链(实测在役)",
         "falsifiable": "判据:发布链五段实测齐备"}
    ],
    "wbs": [{"step": "S1 定纲", "what": "做什么", "reuse": "现成件",
             "hours": 4, "acceptance": "验收标准"}],
    "cost": "额度/依赖/账号/你侧耗时",
    "risks": ["kill开关/定位护栏/红线对齐各一条"],
    "reply_opts": "「批准」=排产(串行令:在制任务收官后接续)｜「否决」=弃案｜「修改 你的意见」=按意见重铸",
    "benefit": "推送用预期收益一句话(--push时必填或此字段)",
}


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="forge.sixpack",
                                 description="W4.3 SCORECARD门+六件套铸模")
    sub = ap.add_subparsers(dest="cmd", required=True)
    c = sub.add_parser("cast", help="草案+spec→三门→六件套(→--push)")
    c.add_argument("draft")
    c.add_argument("--spec", required=True)
    c.add_argument("-o", "--outfile", help="输出名(默认proposals/日期-slug-六件套.md)")
    c.add_argument("--live", action="store_true", help="真GLM评分(默认离线桩)")
    c.add_argument("--push", action="store_true", help="过门后真推送微信审批闸")
    c.add_argument("--task", default="W4.4")
    c.add_argument("--benefit", default="")
    sub.add_parser("demo-spec", help="打印spec模板JSON")
    args = ap.parse_args(argv)

    if args.cmd == "demo-spec":
        print(json.dumps(DEMO_SPEC, ensure_ascii=False, indent=1))
        return 0

    spec = json.loads(Path(args.spec).read_text(encoding="utf-8"))
    if args.outfile:
        spec["outfile"] = args.outfile
    llm = None
    if args.live:
        from forge.glm_json import GlmJson
        llm = GlmJson()
    res = cast(Path(args.draft), spec, llm=llm, live=args.live,
               push=args.push, task=args.task, benefit=args.benefit)
    print(json.dumps(res, ensure_ascii=False, indent=1))
    return 0 if res.get("pass") else 2


if __name__ == "__main__":
    sys.exit(main())
