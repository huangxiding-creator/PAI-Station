# -*- coding: utf-8 -*-
"""forge/jev_gate.py — W4.2 Jev判断层接线（E2召回1.00/E1意图p50实锤，不幻想接线）。

实锤出处（勿凭空，src/paistation/judgment/client.py 文档账, 2026-09-19 实验
tmp/jev_exp{1,2}_*.jsonl）:
  E2 任务请求 Noul: 对抗集召回1.00/误报0.00（规则基线0.27/0.42）
  E1 意图   Choice: p50 1.3s, $0.0001/次, conf(对)0.92 vs conf(错)0.70 可路由
本件=同形复用开两个新位（措辞钉死,证据组装纪律承jev_legs V1/V2教训）:
  forge_demand  Noul   信号→「真实的人被卡住正在求助」概率（taskcards同形族）
  forge_family  Choice 候选→三族意图分类（intent同形族）
新位未过平价门 → 主引擎走jev.ini全局默认, laya影子免费攒agree（P1渐进纪律）;
advisory只记录不过门——未过门位禁做闸门（不幻想接线）。

契约（继承paistation判断层三令,09-19深度融合谱系）:
  ①一键开关 PAI_JEV env硬关 > jev.ini enabled > key缺失 → 全腿惰性
  ②故障跳过 一切故障返回None,调用方降级回原行为,绝不炸锻造主链
  ③熔断器   连续失败进冷却半开试探
铁律: 免费模型优先——确定性检查(正则白名单)留在sixpack代码,Jev只占语义位;
数字零造假——带位名必落traj(data/traj/),无traj不主张。

CLI: py -X utf8 -m forge.jev_gate status
     py -X utf8 -m forge.jev_gate advisory --seq 757
     py -X utf8 -m forge.jev_gate advisory --draft 草案.md --spec spec.json
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]              # mission-engine/
STATION = Path("E:/AI-Station")
SIGNALS_LEDGER = ROOT / "ledger" / "signals.jsonl"

for p in (str(ROOT), str(STATION / "src")):
    if p not in sys.path:
        sys.path.insert(0, p)

try:
    from paistation.judgment.client import JudgmentClient  # noqa: E402
except ImportError:                                     # 站外裸仓 → 腿惰性
    JudgmentClient = None

POSITION_DEMAND = "forge_demand"
POSITION_FAMILY = "forge_family"
TH = 0.5          # 分离缝（E3谱系+融合V2实测: 两侧零跨界）; advisory标注用,非闸门
MAX_STATE_CHARS = 1200

# ── 问句措辞（钉死; 改措辞=换模型,须重过门） ─────────────────────────
_DEMAND_INSTR = ("这条信息是否反映一个真实的人当前被某件事卡住、"
                 "正在寻求解决办法或求助？")
_DEMAND_CRIT = {
    "true": "有具体的人或角色，遇到具体困难、提出具体求助/求推荐/求资料，"
            "期待得到解决；常见于群聊提问、工作卡点求助",
    "false": "闲聊、新闻转发、观点评论、广告、过去的叙述、一般性感慨，"
             "没有具体待解决的困难",
}
_FAMILY_INSTR = "把这个产品想法归入最合适的变现产品族（或都不合适）。"
_FAMILY_CRIT = {
    "research_report": "深度研究报告/行业白皮书/资料汇编，以内容本身变现",
    "solution": "针对客户具体问题的解决方案/咨询服务/定制交付",
    "deployed_tool": "可线上部署使用的工具或服务，用户自助使用并付费",
    "none": "都不合适：内部基建、无产品形态、或知识库构建类",
}

_clients: dict = {}


def set_client(position: str, client) -> None:
    """测试注入口：换掉指定位的单例（离线桩/假transport用）。"""
    _clients[position] = client


def _client(position: str):
    if position in _clients:
        return _clients[position]
    if JudgmentClient is None:
        return None
    try:
        c = JudgmentClient(position=position)
    except Exception:                                  # noqa: BLE001 - fail-soft
        c = None
    c = c if (c and c.enabled) else None               # 禁用/缺key归一为None
    _clients[position] = c
    return c


def available() -> bool:
    return (_client(POSITION_DEMAND) is not None
            or _client(POSITION_FAMILY) is not None)


# ── 证据组装（V1教训: 证据缺席≠模型错误——全文/定向段进state） ────────
def _signal_text(signal_like: dict) -> tuple:
    """(source_type, 尽量全的文本)——容忍ledger整行/内层signal/裸payload三种形。"""
    sig = signal_like.get("signal") if isinstance(
        signal_like.get("signal"), dict) else signal_like
    payload = sig.get("payload") or {}
    text = ""
    for k in ("quote", "content", "text", "summary", "question",
              "record_text", "transcript", "title"):
        v = payload.get(k) or sig.get(k)
        if isinstance(v, str) and v.strip():
            text = v.strip()
            break
    if not text:
        text = json.dumps(payload, ensure_ascii=False) if payload else str(sig)
    return str(sig.get("source_type", "?")), text[:MAX_STATE_CHARS]


def demand_noul(signal_like: dict, *, client=None):
    """信号 → 真实被卡需求概率。None=Jev缺席（不筛,保持原行为）。"""
    c = client or _client(POSITION_DEMAND)
    if c is None:
        return None
    src, text = _signal_text(signal_like)
    return c.ask_noul({"来源类型": src, "信息文本": text,
                       "语境": "微信群聊/朋友圈/语音转写信号,雷达锻造前置筛选"},
                      _DEMAND_INSTR, _DEMAND_CRIT)


def family_choice(draft: dict, spec: dict, *, client=None):
    """候选(草案+spec) → (族名, {probabilities, confidence}) | None。"""
    c = client or _client(POSITION_FAMILY)
    if c is None:
        return None
    return c.ask_choice(
        {"标题": draft.get("title", ""),
         "一句话": spec.get("one_liner", draft.get("one_liner", "")),
         "能力单元": draft.get("capability", ""),
         "信号指针": ["seq%s" % s for s in draft.get("seqs", [])][:8],
         "语境": "商机锻造厂候选,推送审批前的第二意见(advisory)"},
        _FAMILY_INSTR, _FAMILY_CRIT)


def load_signal_by_seq(seq, signals_file=SIGNALS_LEDGER):
    """倒序扫主账本找 seq（append-only, 尾部最新）。"""
    p = Path(signals_file)
    if not p.is_file():
        return None
    rows = p.read_text(encoding="utf-8", errors="replace").splitlines()
    for line in reversed(rows):
        if not line.strip():
            continue
        try:
            row = json.loads(line)
        except ValueError:
            continue
        if str(row.get("seq")) == str(seq):
            return row
    return None


def advisory(draft: dict, spec: dict, *, signals_file=SIGNALS_LEDGER,
             clients=None) -> dict:
    """候选级判断层第二意见（advisory不过门）。sixpack live铸模自动附挂。

    返回 {available, family{choice,confidence,agree_with_spec},
    demand{seq,p,verdict}, engine{...}}；Jev缺席=available:False带原因。
    """
    def _live(c):
        return c if (c is not None and getattr(c, "enabled", False)) else None

    out = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"),
           "note": "advisory不过门(未过门位禁闸,不幻想接线)"}
    if clients is None:            # 生产: 位单例(真config,惰性)
        fam_c = _client(POSITION_FAMILY)
        dem_c = _client(POSITION_DEMAND)
    else:                          # 显式注入: 只用所给,禁止单例回落(离线测试零外呼铁律)
        fam_c = _live(clients.get(POSITION_FAMILY))
        dem_c = _live(clients.get(POSITION_DEMAND))
    if fam_c is None and dem_c is None:
        out["available"] = False
        out["reason"] = ("判断层关/密钥缺/站外裸仓(PAI_JEV>jev.ini>key三令)"
                         if JudgmentClient is not None else "paistation不在站内")
        return out
    out["available"] = True

    if fam_c is not None:
        r = family_choice(draft, spec, client=fam_c)
        if r:
            choice, meta = r
            out["family"] = {"choice": choice,
                             "confidence": meta.get("confidence"),
                             "probabilities": meta.get("probabilities"),
                             "agree_with_spec": choice == spec.get("family")}
        else:
            out["family"] = None                        # fail-soft单腿缺席

    if dem_c is not None and draft.get("seqs"):
        seq = draft["seqs"][0]
        row = load_signal_by_seq(seq, signals_file)
        if row:
            p = demand_noul(row, client=dem_c)
            if p is None:
                out["demand"] = {"seq": seq, "p": None, "verdict": "unknown"}
            else:
                out["demand"] = {"seq": seq, "p": p,
                                 "verdict": "demand" if p >= TH else "noise"}
        else:
            out["demand"] = {"seq": seq, "verdict": "seq_not_found"}
    out["engine"] = {POSITION_DEMAND: getattr(dem_c, "engine", None),
                     POSITION_FAMILY: getattr(fam_c, "engine", None)}
    return out


def status() -> dict:
    """两位引擎/开关快照（CLI status用,零外呼）。"""
    st = {"positions": {}}
    if JudgmentClient is None:
        st["available"] = False
        st["reason"] = "paistation不在站内(站外裸仓腿惰性)"
        return st
    from paistation.judgment.client import engine_status, switch_status
    sw = switch_status(STATION / "config")
    st["switch"] = sw
    for pos in (POSITION_DEMAND, POSITION_FAMILY):
        c = _client(pos)
        st["positions"][pos] = {"client_enabled": bool(c),
                                "engine": engine_status(STATION / "config", pos)}
    st["available"] = available()
    return st


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="forge.jev_gate",
                                 description="W4.2 Jev判断层(advisory不过门)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("status", help="开关/引擎快照(零外呼)")
    a = sub.add_parser("advisory", help="信号位或候选位判断(真外呼)")
    a.add_argument("--seq", type=int, help="主账本seq→信号位demand Noul")
    a.add_argument("--draft", help="草案md→候选位family Choice(+锚信号demand)")
    a.add_argument("--spec", help="spec.json(与--draft配)")
    a.add_argument("--signals", default=str(SIGNALS_LEDGER))
    args = ap.parse_args(argv)

    if args.cmd == "status":
        print(json.dumps(status(), ensure_ascii=False, indent=1))
        return 0

    if args.seq is not None:
        row = load_signal_by_seq(args.seq, Path(args.signals))
        if not row:
            print(json.dumps({"error": "seq%s不在主账本" % args.seq},
                             ensure_ascii=False))
            return 2
        src, text = _signal_text(row)
        p = demand_noul(row)
        if p is None:
            verdict = "unknown"
        else:
            verdict = "demand" if p >= TH else "noise"
        print(json.dumps({"seq": args.seq, "p": p, "verdict": verdict,
                          "source_type": src, "text_head": text[:120]},
                         ensure_ascii=False, indent=1))
        return 0

    if args.draft:
        from forge.sixpack import parse_draft
        draft = parse_draft(Path(args.draft).read_text(encoding="utf-8"))
        spec = json.loads(Path(args.spec).read_text(encoding="utf-8")) \
            if args.spec else {}
        print(json.dumps(advisory(draft, spec,
                                  signals_file=Path(args.signals)),
                         ensure_ascii=False, indent=1))
        return 0
    ap.error("advisory须给--seq或--draft")
    return 2


if __name__ == "__main__":
    sys.exit(main())
