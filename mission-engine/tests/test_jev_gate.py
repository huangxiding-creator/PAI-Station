# -*- coding: utf-8 -*-
"""tests/test_jev_gate.py — W4.2 Jev判断层契约测试（离线零网络）。

三令契约(开关/故障跳过/熔断) + 两腿(forge_demand Noul / forge_family Choice)
+ advisory复合(agree_with_spec/seq锚) + sixpack附挂(离线=offline/注入桩)。
私有tmp目录,不碰真config/真账本/网络。
运行: py -X utf8 tests/test_jev_gate.py
"""
from __future__ import annotations

import json
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, "E:/AI-Station/src")

from forge import jev_gate as J                                   # noqa: E402
from forge.sixpack import StubScorecardLlm, cast, parse_draft     # noqa: E402

DRAFT = """【锻造厂草案·R20261024-052230】状态: draft(W4.1)——未过SCORECARD门与审批闸，勿直接执行

① 标题+一句话
规范条文即查工具
输入标准号或关键词秒级返回适用版本与条文定位及免费原文PDF。

② 能力单元（最小可行AI能力）
标准号/关键词→适用版本+条文定位+原文PDF
- 现状替代: 群里求人/搜百度 → AI价值: 秒级直查

③ 对抗校验+评分（IdeaDig五阶段·第3/4段）
- SCORECARD: 价值9 难度8 共性7
  证据9 时效0.95
  → 综合 201.6

④ 证据溯源（全部指针可回查主账本）
- seq757｜wechat_insight｜2026-10-24 05:12:01｜{"signal_id": "s757"}
- seq775｜wechat_insight｜2026-10-24 05:12:09｜{"signal_id": "s775"}

⑤ 下一步（W4.3/W4.4 人工+门禁链）
对抗校验复核 → 六件套 → 审批闸
"""


def expect(label, cond, detail=""):
    print("[%s] %s %s" % (label, "OK" if cond else "NG", str(detail)[:160]))
    assert cond, "%s: %s" % (label, detail)


class FakeTransport:
    """罐头应答: 按body里question键回noul/choice; raise=True全炸。"""

    def __init__(self, noul=0.83, choice="deployed_tool", conf=0.91,
                 raise_=False):
        self.noul, self.choice = noul, choice
        self.conf, self.raise_ = conf, raise_
        self.calls = 0

    def __call__(self, data: bytes) -> dict:
        self.calls += 1
        if self.raise_:
            raise ConnectionError("fake outage")
        body = json.loads(data.decode("utf-8"))
        answers = {}
        for qid, q in body.get("questions", {}).items():
            if q.get("type") == "noul":
                answers[qid] = {"type": "noul", "noul": self.noul}
            elif q.get("type") == "choice":
                answers[qid] = {"type": "choice", "choice": self.choice,
                                "probabilities": {self.choice: 0.8,
                                                  "none": 0.2},
                                "confidence": self.conf}
        return {"answers": answers}


def mkclient(tmp: Path, position: str, transport, enabled="1"):
    from paistation.judgment.client import JudgmentClient
    cfg = tmp / "config"
    cfg.mkdir(exist_ok=True)
    (cfg / "jev.ini").write_text(
        "[jev]\nenabled = %s\nengine = laya\n" % enabled, encoding="utf-8")
    return JudgmentClient(config_dir=cfg, transport=transport,
                          position=position)


SIG_ROW = {"seq": 757, "ingested_at": "2026-10-24 05:13:01",
           "dedup_key": "x" * 40,
           "signal": {"source_type": "wechat_insight",
                      "payload": {"quote": "这个隐患排查表违反了哪个规范？"
                                           "求准确条文和适用版本"}}}


def main() -> int:
    tmp = Path(tempfile.mkdtemp(prefix="jev_gate_t_"))
    sig_file = tmp / "signals.jsonl"
    sig_file.write_text(json.dumps(SIG_ROW, ensure_ascii=False) + "\n",
                        encoding="utf-8")
    draft = parse_draft(DRAFT)
    spec = {"family": "deployed_tool", "one_liner": "秒级直查规范条文"}

    # ① 三令之开关: enabled=0 → 腿全None, advisory不可用且零外呼
    ft_off = FakeTransport()
    c_off = mkclient(tmp, J.POSITION_DEMAND, ft_off, enabled="0")
    expect("switch_off_demand_none", J.demand_noul(SIG_ROW, client=c_off) is None)
    adv_off = J.advisory(draft, spec, signals_file=sig_file,
                         clients={J.POSITION_DEMAND: c_off,
                                  J.POSITION_FAMILY: c_off})
    expect("switch_off_advisory_unavailable", adv_off["available"] is False,
           adv_off)
    expect("switch_off_zero_calls", ft_off.calls == 0)

    # ② demand腿: 真值float + traj落位(位名/引擎/审计行)
    ft_d = FakeTransport(noul=0.83)
    c_d = mkclient(tmp, J.POSITION_DEMAND, ft_d)
    p = J.demand_noul(SIG_ROW, client=c_d)
    expect("demand_float_083", p == 0.83, p)
    traj = tmp / "data" / "traj" / ("jev-%s.jsonl" % J.POSITION_DEMAND)
    expect("demand_traj_written", traj.is_file())
    row = json.loads(traj.read_text(encoding="utf-8").splitlines()[-1])
    expect("demand_traj_position", row["position"] == J.POSITION_DEMAND, row)
    expect("demand_traj_engine_laya", row["engine"] == "laya", row)
    expect("demand_traj_state_hash_only",
           isinstance(row["state_hash"], str) and len(row["state_hash"]) == 16)

    # ③ family腿: (choice, meta) 元组 + confidence/probabilities
    ft_f = FakeTransport(choice="deployed_tool", conf=0.91)
    c_f = mkclient(tmp, J.POSITION_FAMILY, ft_f)
    r = J.family_choice(draft, spec, client=c_f)
    expect("family_tuple", isinstance(r, tuple) and r[0] == "deployed_tool", r)
    expect("family_meta", r[1]["confidence"] == 0.91
           and "probabilities" in r[1], r[1])

    # ④ advisory复合: agree=True(同族) + demand锚seq757
    adv = J.advisory(draft, spec, signals_file=sig_file,
                     clients={J.POSITION_DEMAND: c_d,
                              J.POSITION_FAMILY: c_f})
    expect("adv_available", adv["available"] is True, adv)
    expect("adv_family_agree", adv["family"]["agree_with_spec"] is True, adv)
    expect("adv_demand_seq757", adv["demand"]["seq"] == 757
           and adv["demand"]["p"] == 0.83
           and adv["demand"]["verdict"] == "demand", adv["demand"])
    expect("adv_note_not_gate", "不过门" in adv["note"])

    # ⑤ 分离缝: p<0.5 → noise; 族不合 → agree=False
    c_dn = mkclient(tmp, J.POSITION_DEMAND, FakeTransport(noul=0.12))
    adv2 = J.advisory(draft, spec, signals_file=sig_file,
                      clients={J.POSITION_DEMAND: c_dn,
                               J.POSITION_FAMILY: c_f})
    expect("adv_noise_verdict", adv2["demand"]["verdict"] == "noise",
           adv2["demand"])
    c_fm = mkclient(tmp, J.POSITION_FAMILY,
                    FakeTransport(choice="research_report"))
    adv3 = J.advisory(draft, spec, signals_file=sig_file,
                      clients={J.POSITION_DEMAND: c_d,
                               J.POSITION_FAMILY: c_fm})
    expect("adv_family_disagree", adv3["family"]["agree_with_spec"] is False)

    # ⑥ seq缺席: 锚信号不在账本 → seq_not_found(fail-soft不炸)
    adv4 = J.advisory(draft, spec, signals_file=tmp / "empty.jsonl",
                      clients={J.POSITION_DEMAND: c_d,
                               J.POSITION_FAMILY: c_f})
    expect("adv_seq_not_found", adv4["demand"]["verdict"] == "seq_not_found")

    # ⑦ 三令之熔断: transport全炸(重试sleep打桩)→None×3→breaker开
    import paistation.judgment.client as pjc
    _sleep = pjc.time.sleep
    pjc.time.sleep = lambda s: None
    try:
        ft_x = FakeTransport(raise_=True)
        c_x = mkclient(tmp, J.POSITION_DEMAND, ft_x)
        for i in range(3):
            expect("breaker_fail_soft_%d" % i,
                   J.demand_noul(SIG_ROW, client=c_x) is None)
        expect("breaker_open_after3", c_x.breaker_open is True)
        expect("breaker_attempts_9", ft_x.calls == 9, ft_x.calls)  # 3次x3发
    finally:
        pjc.time.sleep = _sleep

    # ⑧ sixpack附挂: 离线=offline零外呼; 注入jev桩→真附挂入res+账本
    spec_full = {"family": "deployed_tool", "slug": "t-seq757",
                 "one_liner": "秒级直查规范条文",
                 "signal_anchor": "跨2窗9群9条实测(seq757/775)",
                 "axes": [{"axis": "时效", "multiplier": 15, "counted": True,
                           "anchor": "群里求人半天→秒级(seq757)",
                           "falsifiable": "任抽10条实测复现<X秒=伪"},
                          {"axis": "覆盖", "multiplier": 10, "counted": True,
                           "anchor": "百群规范问答聚合→全库直查(seq775)",
                           "falsifiable": "抽20问命中率<基线2倍=伪"},
                          {"axis": "成本", "multiplier": 5, "counted": True,
                           "anchor": "人工检索人力→API调用计费(seq757)",
                           "falsifiable": "单查成本>人工1/5=伪"}],
                 "wbs": [{"step": "S1", "what": "接线现成件",
                          "reuse": "std-samr-gb", "hours": 4,
                          "acceptance": "10/10贯通"}],
                 "cost": "额度$0.01级", "risks": ["kill开关"],
                 "reply_opts": "批准/否决/修改"}
    dpath = tmp / "draft.md"
    dpath.write_text(DRAFT, encoding="utf-8")
    out_dir = tmp / "proposals"
    res = cast(dpath, spec_full, llm=StubScorecardLlm(), out_dir=out_dir,
               ledger_file=tmp / "forge.jsonl")
    expect("cast_offline_pass", res["pass"] is True, res.get("gates"))
    expect("cast_offline_jev", res["jev"] == {"available": False,
                                              "reason": "offline"}, res["jev"])

    def fake_adv(d, s):
        return {"available": True, "family": {"choice": "deployed_tool",
                                              "agree_with_spec": True}}

    res2 = cast(dpath, spec_full, llm=StubScorecardLlm(), out_dir=out_dir,
                ledger_file=tmp / "forge.jsonl", jev=fake_adv)
    expect("cast_injected_jev_attached",
           res2["jev"]["available"] is True
           and res2["jev"]["family"]["agree_with_spec"] is True, res2["jev"])
    led = [json.loads(x) for x in
           (tmp / "forge.jsonl").read_text(encoding="utf-8").splitlines()]
    expect("cast_jev_in_ledger", led[-1]["detail"]["jev"]["available"] is True)

    print("ALL jev_gate asserts OK")
    return 0


if __name__ == "__main__":
    sys.exit(main())
