# -*- coding: utf-8 -*-
"""tests/test_approval_gate.py — 微信审批闸测试（W4.3b-b 验收）。

私有目录 tests/.approval-work/（只增不删，站规）；env 重定向账本/spool/企微
（ME_WECOM 空串=禁兜底），全程离线不碰真桥真企微。RID 唯一后缀隔离残留。
覆盖: request落账+spool形态 / 回复解析全语义(批准/否决/修改/带id/宽标点)
/ 最老pending定位 / 幂等重复决议 / 已决/未知id/无待批 / wait决出与超时
/ status / unrecognized不误吞 / CLI退出码。
运行: py -X utf8 tests\\test_approval_gate.py
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RID = time.strftime("%H%M%S")
# per-RID 子目录: 每轮全新账本, 断言可绝对化; 父目录只增不删(站规)
WORK = Path(__file__).resolve().parent / ".approval-work" / f"rid-{RID}"
PY = sys.executable

ENV = {**os.environ,
       "ME_HOME": str(WORK),
       "ME_SPOOL_DIR": str(WORK / "spool"),
       "ME_WECOM": "",                      # 禁企微兜底(离线)
       "ME_BRIDGE_PID": str(WORK / "no.pid")}

PASS = FAIL = 0


def run(*args: str, env=ENV, timeout=60) -> subprocess.CompletedProcess:
    return subprocess.run(
        [PY, "-X", "utf8", str(ROOT / "approval_gate.py"), *args],
        capture_output=True, text=True, encoding="utf-8", env=env, timeout=timeout)


def jout(cp: subprocess.CompletedProcess) -> dict:
    return json.loads(cp.stdout.strip().splitlines()[-1])


def check(name: str, cond: bool, extra: str = "") -> None:
    global PASS, FAIL
    if cond:
        PASS += 1
        print(f"  ✓ {name}")
    else:
        FAIL += 1
        print(f"  ✗ {name} {extra}")


def request(title: str, push: bool = True) -> str:
    args = ["request", "--title", title, "--summary", "冒烟摘要",
            "--benefit", "冒烟收益", "--task", f"W-test-{RID}"]
    if not push:
        args.append("--no-push")
    return jout(run(*args))["approval_id"]


def main() -> int:
    print(f"== approval_gate 测试 RID={RID} ==")
    approvals = WORK / "ledger" / "approvals.jsonl"

    # -- 1. request: 落账 + spool 文件形态 --
    a1 = request(f"冒烟审批A-{RID}")
    cp1 = run("request", "--title", f"冒烟审批B-{RID}", "--summary", "带推送",
              "--benefit", "b", "--no-push")
    a2 = jout(cp1)["approval_id"]
    check("request rc=0 且输出 id/push", cp1.returncode == 0
          and a2.startswith("APPR-") and jout(cp1)["push"] == "none")
    rows = [json.loads(l) for l in approvals.read_text(encoding="utf-8").splitlines()]
    req_rows = [r for r in rows if r["event"] == "request"]
    check("两次 request 均落账且 id 唯一",
          len(req_rows) == 2 and len({r["approval_id"] for r in req_rows}) == 2)
    spool_file = WORK / "spool" / f"{a1}.json"
    check("推送版 request 生成 spool JSON",
          spool_file.exists() and "批准" in json.loads(
              spool_file.read_text(encoding="utf-8"))["text"])

    # -- 2. 回复解析全语义 --
    from importlib import import_module
    sys.path.insert(0, str(ROOT))
    for mod_name in [m for m in list(sys.modules) if m.startswith("approval_gate")]:
        del sys.modules[mod_name]
    for k, v in ENV.items():
        os.environ[k] = v
    ag = import_module("approval_gate")
    cases = [
        ("批准", "approve"), ("同意", "approve"), ("批", "approve"),
        ("批准！", "approve"), ("  yes ", "approve"), ("approve", "approve"),
        ("否决", "reject"), ("驳回", "reject"), ("拒绝，重做", "reject"),
        ("no", "reject"), ("修改 加一层对抗校验", "revise"),
        ("改一下 换尺", "revise"), ("revise: redo", "revise"),
        ("你好呀", None), ("查进度", None),
    ]
    ok = True
    for text, want in cases:
        got = ag.parse_reply(text)["decision"]
        if got != want:
            ok = False
            print(f"      parse_reply({text!r}) = {got}, 期望 {want}")
    check(f"回复解析 {len(cases)} 例全对", ok)
    p = ag.parse_reply(f"批准 {a2}")
    check("回复携带 id 被提取(大小写不敏感)", p["decision"] == "approve"
          and p["approval_id"].lower() == a2.lower())
    p = ag.parse_reply("修改：再加企微双通道")
    check("修改意见 note 提取", p["decision"] == "revise"
          and p["note"] == "再加企微双通道")

    # -- 3. consume: 最老 pending 定位 + 落账 --
    cp = run("consume", "--text", "批准")
    out = jout(cp)
    check("consume 批准 rc=0 且命中最老 pending", cp.returncode == 0
          and out["approval_id"] == a1 and out["decision"] == "approve"
          and "已批准" in out["reply_to_user"])
    rl = (WORK / "ledger" / "run-ledger.jsonl").read_text(encoding="utf-8")
    check("run-ledger 落 approval_requested+decided 事件",
          rl.count('"approval_requested"') == 2
          and '"approval_decided"' in rl)

    # -- 4. consume 修改带意见 / 指定 id --
    cp = run("consume", "--text", f"修改 加SCORECARD门 {a2}")
    out = jout(cp)
    check("consume 修改+指定id", out["decision"] == "revise"
          and out["approval_id"] == a2 and out["note"] == "加SCORECARD门")

    # -- 5. 幂等: 重复决议 / 已决 / 无待批 --
    cp = run("consume", "--text", f"批准 {a1}")
    out = jout(cp)
    check("重复决议幂等返回 already_decided", out.get("already_decided") is True
          and out["decision"] == "approve")
    cp = run("consume", "--id", f"APPR-19990101-000000-dead", "--decision", "approve")
    check("未知 id 友好返回", jout(cp)["result"] == "unknown_id")
    cp = run("consume", "--text", "批准")
    check("无待批 none_pending", jout(cp)["result"] == "none_pending")

    # -- 6. unrecognized 不误吞 --
    cp = run("consume", "--text", "今天天气如何")
    check("闲聊文本 unrecognized rc=0", cp.returncode == 0
          and jout(cp)["parsed"] == "unrecognized")

    # -- 7. status --
    a3 = request(f"冒烟审批C-{RID}", push=False)
    cp = run("status")
    check("status 文本列出待批", cp.returncode == 0
          and a3 in cp.stdout and "APPR-" in cp.stdout)
    cp = run("status", "--json")
    check("status --json 结构", isinstance(jout(cp), list)
          and jout(cp)[0]["approval_id"] == a3)

    # -- 8. wait: 决出与超时 --
    cp = run("wait", "--id", a3, "--timeout-sec", "12", "--poll-sec", "1")
    check("wait 未决超时 rc=1", cp.returncode == 1
          and "timeout" in cp.stderr)

    import threading

    def later_approve():
        time.sleep(3)
        run("consume", "--text", "批准", env=ENV)

    threading.Thread(target=later_approve, daemon=True).start()
    t0 = time.time()
    cp = run("wait", "--id", a3, "--timeout-sec", "30", "--poll-sec", "1")
    took = time.time() - t0
    check(f"wait 决出即返 rc=0 (实测{took:.1f}s<10s)", cp.returncode == 0
          and jout(cp)["decision"] == "approve" and took < 10)

    # -- 9. CLI 退出码 --
    cp = run("consume")
    check("consume 缺参 rc=2", cp.returncode == 2)
    cp = run("nosuchcmd")
    check("未知子命令 rc=2", cp.returncode == 2)

    print(f"\n结果: {PASS} 通过 / {FAIL} 失败")
    return 1 if FAIL else 0


if __name__ == "__main__":
    sys.exit(main())
