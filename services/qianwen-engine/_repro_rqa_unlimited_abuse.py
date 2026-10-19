# -*- coding: utf-8 -*-
"""code-repro：解锁用户 report_ask 无限问 → 唯一节流=全链共享智谱闸（滥用轨迹）。

复现主张（对应 finding）：
P1   解锁后 50 连发全 200 / left=999 / 旧计数器 report_asks 零行（死代码）/
     RQA_DAILY_LIMIT=1（ENV）不生效（死旋钮）；对照：未解锁受害者 6/日即 429。
P1b  report_ask_log 每问一行，无修剪（遥测表有修剪，此表没有）。
P2   滥用者在生成期间独占 zhipu._CALL_LOCK → 无辜用户 question_optimize（咨询腿）
     被迫排队等滥用者在途生成完成（全特性串行）。
P3   滥用者打出 429 → 1 key × 3 模型全部进 120s 冷却（共享账号态）→
     其他用户 report_ask=503 / question_optimize=502（全链免费通道被一个人打瘫）。
P3b  失败链（超时/5xx）整梯在锁内：1 key × 3 模型 × 每次 _post 时限 →
     单次失败链持锁 ≈3×单次时长（真实 ZHIPU_TIMEOUT_SEC=30 → ~90s/key）。

运行：py -3.11 _repro_rqa_unlimited_abuse.py
"""
from __future__ import annotations

import json
import os
import sqlite3
import sys
import tempfile
import threading
import time
from pathlib import Path

os.environ["RQA_DAILY_LIMIT"] = "1"  # 运营侧想收紧成本硬顶 → 证明该 ENV 无任何效果

ENGINE = Path(__file__).resolve().parent
sys.path.insert(0, str(ENGINE))

from qianwen_engine import config, report_catalog, wechat, zhipu, store  # noqa: E402

TMP = Path(tempfile.mkdtemp(prefix="rqa_repro_"))
config.DB_PATH = TMP / "t.sqlite"
config.DATA_DIR = TMP
SEC = TMP / "secrets"
SEC.mkdir()
config.ZHIPU_SECRET_FILE = SEC / "zhipu.secret"
config.ZHIPU_SECRET_FILE.write_text("api_key=fake-key-1\n", encoding="utf-8")

# ── 迷你目录（与 tests/test_report_ask.py 同构）──
cdir = TMP / "content"
(cdir / "full").mkdir(parents=True)
(cdir / "sample").mkdir(parents=True)
chapters = [(1, "合同体系", "合同类型与条款要点"), (2, "计价规则", "计价方式与调价机制"),
            (3, "风险管理", "风险分担与应对措施"), (4, "结算流程", "进度结算与付款节点"),
            (5, "变更签证", "变更签证的办理流程"), (6, "索赔实务", "索赔证据与时效管理")]
cdir.joinpath("report.json").write_text(json.dumps({"reports": [{
    "sku": "SKU-A", "title": "甲报告对话官测试", "subtitle": "副题", "price": 498,
    "price_label": "¥498", "words_wan": 5, "badges": [], "cat": "ent",
    "cat_name": "企业研究", "intro_lede": "导语", "intro": "简介", "audience": "从业者",
    "chapters": [{"id": i, "title": f"第{i}章 {kw}", "desc": d} for i, kw, d in chapters],
    "sample_file": "sku-a.md", "sample_label": "试读"}]}, ensure_ascii=False),
    encoding="utf-8")
cdir.joinpath("full", "SKU-A.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
cdir.joinpath("sample", "sku-a.md").write_text("# 试读\n本报告围绕合同计价与变更签证展开。",
                                                encoding="utf-8")
config.REPORT_CONTENT_DIR = cdir
report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
store._init_done = False

ABUSER, VICTIM, VICTIM2 = "open-abuser", "open-victim", "open-victim2"

# ── 假智谱传输层（可控：延迟/429/5xx/正常）──
OK_BODY = json.dumps({"choices": [{"message": {"content":
    "这是一段足够长的结论行用于通过长度校验。\n第5章：论据一。\n第2章：论据二。"}}]},
    ensure_ascii=False)
CALLS = {"n": 0, "lock": threading.Lock(), "mode": "ok", "sleep": 0.0}


def fake_post(url, headers, payload, timeout):
    with CALLS["lock"]:
        CALLS["n"] += 1
    if CALLS["sleep"]:
        time.sleep(CALLS["sleep"])  # 模拟生成耗时/网络时限（真实 5-20s / 30s 超时）
    if CALLS["mode"] == "429":
        return 429, '{"error":{"code":"1302","message":"rate limited"}}'
    if CALLS["mode"] == "500":
        return 500, "internal error"
    return 200, OK_BODY


zhipu._post = fake_post
zhipu._MIN_CALL_INTERVAL = 0.05  # 真实 1.5s；等比缩放，不改变串行语义

from fastapi.testclient import TestClient  # noqa: E402
from qianwen_engine import app as app_mod  # noqa: E402


def db_count(table: str) -> int:
    conn = sqlite3.connect(config.DB_PATH)
    try:
        return conn.execute(f"SELECT COUNT(*) FROM {table}").fetchone()[0]
    finally:
        conn.close()


with TestClient(app_mod.app) as client:
    store.init()
    conn = sqlite3.connect(config.DB_PATH)
    conn.execute("INSERT INTO report_unlocks(openid, sku) VALUES(?, 'SKU-A')", (ABUSER,))
    conn.commit()
    conn.close()
    ha = {"Authorization": "Bearer " + wechat.issue_token(ABUSER)}
    hv = {"Authorization": "Bearer " + wechat.issue_token(VICTIM)}
    hv2 = {"Authorization": "Bearer " + wechat.issue_token(VICTIM2)}

    # ── P1：解锁用户 50 连发 ──
    t0 = time.time()
    codes, last = [], None
    for i in range(50):
        last = client.post("/api/report/SKU-A/ask", headers=ha,
                           json={"q": f"变更签证怎么办理{i}"})
        codes.append(last.status_code)
    print(f"[P1] 50连发 all200={all(c == 200 for c in codes)} left={last.json()['left']} "
          f"zhipu_calls={CALLS['n']} wall={time.time() - t0:.1f}s")
    print(f"[P1] 旧计数器 report_asks 行数={db_count('report_asks')}（零调用=死代码）"
          f" report_ask_log 行数={db_count('report_ask_log')}（每问一行）")
    print(f"[P1] RQA_DAILY_LIMIT ENV=1 实读={config.RQA_DAILY_LIMIT} → 对解锁用户 0 效果")
    # 对照：未解锁用户 8 问 → 6 过 1 429（FREE_PER_DAY=6）
    vc = [client.post("/api/report/SKU-A/ask", headers=hv,
                      json={"q": f"计价规则是什么{i}"}).status_code for i in range(8)]
    print(f"[P1-对照] 未解锁用户 8 问 codes={vc}")

    # ── P2：滥用生成独占全局锁 → 无辜用户咨询腿排队 ──
    CALLS["sleep"] = 0.5  # 单次生成 0.5s（真实 5-20s）
    stop = threading.Event()

    def hammer():
        while not stop.is_set():
            client.post("/api/report/SKU-A/ask", headers=ha,
                        json={"q": "变更签证怎么办理-连打"})

    th = threading.Thread(target=hammer)
    th.start()
    time.sleep(1.2)  # 等滥用者进入在途生成
    t = time.time()
    rv = client.post("/api/question/optimize", headers=hv,
                     json={"question": "变更签证如何办理更好"})
    vw = time.time() - t
    stop.set()
    th.join()
    print(f"[P2] 无辜用户 question_optimize status={rv.status_code} "
          f"wall={vw:.2f}s（自身生成 0.5s → 排队 {vw - 0.5:.2f}s 等滥用者在途生成）")

    # ── P3：滥用者打出 429 → 共享账号态 3 模型全冷却 → 全链瘫 ──
    CALLS["sleep"] = 0.0
    with zhipu._STATE_LOCK:
        zhipu._ACCOUNT_STATE.clear()
    CALLS["mode"] = "429"
    for i in range(2):
        ra = client.post("/api/report/SKU-A/ask", headers=ha,
                         json={"q": f"变更签证怎么办理-429-{i}"})
        print(f"[P3] 滥用者 ask#{i} status={ra.status_code}")
    key = zhipu.load_keys()[0]
    now = time.time()
    with zhipu._STATE_LOCK:
        cds = dict(zhipu._acct_nolock(key)["cooldown"])
    cd_disp = {m: f"{cd - now:.0f}s" for m, cd in cds.items()}
    print(f"[P3] 共享冷却态 model→剩余={cd_disp}（_COOLDOWN_SECONDS=120）")
    rv2 = client.post("/api/question/optimize", headers=hv2,
                      json={"question": "合同体系怎么理解"})
    print(f"[P3] 新用户 question_optimize status={rv2.status_code} "
          f"detail={str(rv2.json().get('detail'))[:70]}")
    rr2 = client.post("/api/report/SKU-A/ask", headers=hv2,
                      json={"q": "索赔实务怎么做"})
    print(f"[P3] 新用户 report_ask status={rr2.status_code} "
          f"detail={str(rr2.json().get('detail'))[:40]}")

    # ── P3b：失败链整梯持锁（超时/5xx 逐模型逐账号）──
    with zhipu._STATE_LOCK:
        zhipu._ACCOUNT_STATE.clear()
    CALLS["mode"] = "500"
    CALLS["sleep"] = 1.0  # 单次 _post 1s（真实 ZHIPU_TIMEOUT_SEC=30）
    t = time.time()
    client.post("/api/report/SKU-A/ask", headers=ha, json={"q": "变更签证怎么办理-梯"})
    aw = time.time() - t
    print(f"[P3b] 单账号失败链持锁 wall={aw:.2f}s ≈ 3模型×1s；"
          f"真实=3×{config.ZHIPU_TIMEOUT_SEC}s={3 * config.ZHIPU_TIMEOUT_SEC}s/账号，"
          f"锁内再乘账号数")

print("DONE")
