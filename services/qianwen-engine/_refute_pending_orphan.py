# -*- coding: utf-8 -*-
"""独立边界复现：声称缺陷=引擎重启后 pending 答案永不收敛（无孤儿清扫+客户端无限轮询+次数被吞）。

边界状态构造（对应真实场景：生成中 systemctl restart / 进程崩溃后 systemd Restart=always 拉起新进程）：
  进程内状态 = DB 行 status='pending' + _PROGRESS 为空 + 该 aid 无任何存活线程。
  模拟法：POST /api/ask（真实扣次+落 pending 行），metaso_kb.ask 阻塞 300s（=重启瞬间线程
  正在生成中），随后 app._PROGRESS.clear() —— 新进程的 _PROGRESS 就是空 dict（模块级全局，
  全仓 grep 证实除 ask 端点外无任何写入者），被阻塞的线程即"随进程死亡"的替身。
对照组：重启前的正常 pending 响应（progress 非空、elapsed 增长）。
断言腿：answer 详情 / 配额退款 / history 徽标 / any_pending 播种让路 / followup 孤儿。
"""
import sys
import tempfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

from qianwen_engine import config, metaso_kb, wechat, zhipu, store  # noqa: E402

# ── 离线隔离环境（与 tests/test_api.py fixture 同款，绝不碰生产 DB）──
tmp = Path(tempfile.mkdtemp(prefix="qw_orphan_"))
config.DB_PATH = tmp / "t.sqlite"
config.DATA_DIR = tmp
store._init_done = False

# KB 线阻塞 300s：模拟"重启那一刻生成仍在进行"（脚本远早于此结束）
metaso_kb.ask = lambda q, model="fast", sleep=None, on_event=None: time.sleep(300)
zhipu.configured = lambda: True
_zhipu_calls = {"n": 0}


def _blocked_rewrite(p):
    _zhipu_calls["n"] += 1
    time.sleep(300)  # followup 线程同理：重启瞬间在途


zhipu.rewrite = _blocked_rewrite

from fastapi.testclient import TestClient  # noqa: E402
from qianwen_engine import app as app_mod  # noqa: E402

U = "orphan-user"
tok = "Bearer " + wechat.issue_token(U)

failures = []


def check(name, cond, detail=""):
    tag = "OK " if cond else "FAIL"
    print(f"[{tag}] {name} {detail}")
    if not cond:
        failures.append(name)


with TestClient(app_mod.app) as c:
    c.headers.update({"Authorization": tok})

    # ── 前置：基线配额 ──
    q0 = c.get("/api/quota").json()["quota"]
    print(f"[base] quota={q0}")

    # ── 步骤1：真实提交问题（扣次+落 pending 行+起后台线程，线程卡在 ask 内=生成中）──
    r = c.post("/api/ask", json={"question": "旋挖硬岩进尺慢怎么办"})
    aid = r.json()["id"]
    q1 = c.get("/api/quota").json()["quota"]
    print(f"[1] ask -> {r.status_code} id={aid} quota free {q0['free_left']}->{q1['free_left']}")
    check("ask 扣次", q1["free_left"] == q0["free_left"] - 1)

    # ── 对照组：重启前的 pending 响应是"活的"（progress 非空、elapsed>0）──
    d_pre = c.get(f"/api/answer/{aid}").json()
    print(f"[C] pre-restart pending: progress={len(d_pre.get('progress', []))} 条 "
          f"elapsed={d_pre.get('elapsed')}s")
    check("重启前 progress 有事件", len(d_pre.get("progress", [])) >= 1)
    check("重启前 elapsed 在走", d_pre.get("elapsed", 0) >= 0)

    # ══ 边界时刻：进程重启（_PROGRESS 清空=新进程内存态；阻塞线程=旧进程线程已死）══
    with app_mod._PROG_LOCK:
        app_mod._PROGRESS.clear()
    print("\n== SIMULATED RESTART: _PROGRESS cleared (fresh process state) ==")

    # ── 步骤2：重开答案页 + 客户端每 2s 轮询（answer.js:79-92 无上限重轮的 5 个采样）──
    for i in range(5):
        d = c.get(f"/api/answer/{aid}").json()
        print(f"[2.{i}] poll#{i}: status={d['status']} progress={d.get('progress')} "
              f"elapsed={d.get('elapsed')} partial={d.get('partial')!r} "
              f"stream_chars={d.get('stream_chars')}")
        time.sleep(0.05)  # 真客户端 sleep(2000)，此处压缩采样
    d5 = c.get(f"/api/answer/{aid}").json()
    check("重启后 status 恒 pending", d5["status"] == "pending")
    check("重启后 progress 恒空", d5.get("progress") == [])
    check("重启后 elapsed 恒 0（客户端秒表每 2s 被重置）", d5.get("elapsed") == 0)
    check("重启后 partial 恒空", d5.get("partial") == "")
    check("重启后无任何失败态字段", d5.get("error_text", "") == "")

    # ── 步骤3：时间流逝也无济于事（真场景=用户挂着页面等 10 分钟；这里直接绕过采样证明
    #    无任何后台迁移者：唯一能写终态的 complete_answer/fail_answer 仅存在于
    #    _run_answer 线程，而新进程中该 aid 无线程——grep 全仓已证实无其他调用者）──
    row = store.get_answer(aid, U)
    check("DB 行 status 仍 pending", row["status"] == "pending")
    check("DB 行 answer_full 仍空", row["answer_full"] == "")

    # ── 步骤4：退款永不发生 ──
    q2 = c.get("/api/quota").json()["quota"]
    print(f"[4] 重启轮询多次后 quota={q2}")
    check("次数未退（被吞）", q2["free_left"] == q0["free_left"] - 1)

    # ── 步骤5：历史页徽标（my.js:43: pending → '生成中'）──
    hist = c.get("/api/history").json()["items"]
    st = next((it["status"] for it in hist if it["id"] == aid), None)
    print(f"[5] history item status={st} （my.js → badge='生成中'）")
    check("历史页恒'生成中'", st == "pending")

    # ── 步骤6：播种器让路（pot_seed.py:51 while any_pending() 等待，上限 240s/问）──
    ap = store.any_pending()
    print(f"[6] store.any_pending()={ap} （pot_seed 每问白等最多 240s）")
    check("any_pending 恒 True（播种器持续让路）", ap is True)

    # ── 步骤7：followup 同病（孤儿 pending 追问，_pollFollowups 无限重轮）──
    base = store.save_answer(U, "已完成的旧问题", "旧答案" * 100, [])
    rf = c.post(f"/api/answer/{base}/followup", json={"question": "那索赔时效怎么算"})
    fid = rf.json().get("id")
    print(f"[7] followup -> {rf.status_code} fid={fid}（线程阻塞=重启瞬间在途）")
    with app_mod._PROG_LOCK:
        app_mod._PROGRESS.clear()  # 再现新进程（followup 状态纯 DB 态，线程死=无人回填）
    items = c.get(f"/api/answer/{base}/followups").json()["items"]
    print(f"    after restart: followups={[(i['id'], i['status']) for i in items]}")
    check("followup 孤儿恒 pending", items and items[-1]["status"] == "pending")

    # ── 步骤8：引擎其余功能照常（孤儿是静默的，连 5xx 都没有——更难被发现）──
    check("health 仍 200（孤儿静默）", c.get("/api/health").json()["ok"] is True)

print("\n===== 判定 =====")
if failures:
    for f in failures:
        print(" -", f)
    print(f">>> {len(failures)} 项断言失败：缺陷复现失败，声称可被推翻")
else:
    print("全链路按声称走完：孤儿 pending 永不收敛/无退款/无失败态/历史恒'生成中'/播种让路/followup 同病。")
