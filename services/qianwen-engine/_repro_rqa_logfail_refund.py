# -*- coding: utf-8 -*-
"""code-repro：v0.9.23 report_ask 扣次(consume_one)后、LLM try/except 之外的
异常不退款缺陷复现（commit 23a48173, app.py:1082-1134）。

场景C（最强，app.py:1132）：LLM 成功 → store.log_report_ask 落库失败 → 500，
扣次保留、无退款、答案不交付。注入点 = store._db 抛 sqlite3.OperationalError
——与 MySQL 模式真实失败同型：_my_borrow 连接/ping 失败原样外抛（store.py:169），
_MyConn._run 把 pymysql OperationalError 翻译为 sqlite3.OperationalError
（store.py:134-135），_db() except → rollback → raise（store.py:204-206）。

场景B（app.py:1110）：未命中分支落库失败同理。

场景A 证伪检查：report_qa.retrieve 的文件 IO（sample_text）OSError 被吞，
不会传播到 1104。

运行：python _repro_rqa_logfail_refund.py
"""
from __future__ import annotations

import json
import sqlite3
import sys
import tempfile
from contextlib import contextmanager
from pathlib import Path

ENGINE = Path(__file__).resolve().parent
sys.path.insert(0, str(ENGINE))

from qianwen_engine import config, report_catalog, report_qa, store, wechat, zhipu  # noqa: E402

FAKE_REPLY = "结论行\n第1章：论据一\n第2章：论据二"
HIT_Q = "变更签证怎么办理"          # 与第5章 2-gram 命中
MISS_Q = "量子纠缠是什么原理"       # 语料无重叠 → no hit

TMP = Path(tempfile.mkdtemp(prefix="rqa_repro_"))
config.DB_PATH = TMP / "t.sqlite"
config.DATA_DIR = TMP

# ── 迷你目录（同 tests/test_report_ask.py::_mk_content）──
cdir = TMP / "content"
(cdir / "full").mkdir(parents=True)
(cdir / "sample").mkdir(parents=True)
chapters = [(1, "合同体系", "合同类型与条款要点"), (2, "计价规则", "计价方式与调价机制"),
            (3, "风险管理", "风险分担与应对措施"), (4, "结算流程", "进度结算与付款节点"),
            (5, "变更签证", "变更签证的办理流程"), (6, "索赔实务", "索赔证据与时效管理")]
r = {"reports": [{"sku": "SKU-A", "title": "测试报告", "subtitle": "副题",
                  "price": 498, "price_label": "¥498", "words_wan": 5, "badges": [],
                  "cat": "ent", "cat_name": "企业研究", "intro_lede": "导语",
                  "intro": "简介", "audience": "从业者",
                  "chapters": [{"id": i, "title": f"第{i}章 {kw}", "desc": d}
                               for i, kw, d in chapters],
                  "sample_file": "sku-a.md", "sample_label": "试读"}]}
(cdir / "report.json").write_text(json.dumps(r, ensure_ascii=False), encoding="utf-8")
(cdir / "full" / "SKU-A.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
(cdir / "sample" / "sku-a.md").write_text("# 试读\n合同计价与变更签证。", encoding="utf-8")
config.REPORT_CONTENT_DIR = cdir
report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
store._init_done = False

zhipu.deep_answer = lambda system, prompt, **k: FAKE_REPLY   # LLM 恒成功（钱已花）

from fastapi.testclient import TestClient  # noqa: E402
from qianwen_engine import app as app_mod  # noqa: E402

REAL_DB = store._db


class _AskLogFailConn:
    """连接代理：仅 report_ask_log 的 INSERT 失败（其余语句走真库）。
    模拟 MySQL 模式 _my_borrow 借出瞬间连接失败——异常同型：
    sqlite3.OperationalError（store.py:134-135 由 pymysql OperationalError 翻译）。"""

    def __init__(self, real):
        self._real = real

    def execute(self, sql, params=()):
        if "report_ask_log" in sql:
            raise sqlite3.OperationalError("(2003, \"Can't connect to MySQL server\")")
        return self._real.execute(sql, params)

    def __getattr__(self, name):
        return getattr(self._real, name)


@contextmanager
def _db_asklog_down():
    with REAL_DB() as c:
        yield _AskLogFailConn(c)


def _free_used() -> int:
    with REAL_DB() as c:
        return c.execute("SELECT free_used FROM users WHERE openid='open-t1'").fetchone()["free_used"]


def _log_rows() -> int:
    with REAL_DB() as c:
        return c.execute("SELECT COUNT(*) n FROM report_ask_log").fetchone()["n"]


results: list = []

with TestClient(app_mod.app, raise_server_exceptions=False) as client:
    client.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
    ask = lambda q: client.post("/api/report/SKU-A/ask", json={"q": q})  # noqa: E731

    # ── 基线：正常一问，扣 1 次（left 6→5），落 1 行日志 ──
    r0 = ask(HIT_Q)
    results.append(("baseline 200", r0.status_code == 200, r0.json().get("left"),
                    _free_used(), _log_rows()))

    # ── 场景C：LLM 成功后（1132）落库失败 → 500，扣次保留无退款 ──
    store._db = _db_asklog_down
    rc = ask(HIT_Q)                       # LLM 被真实调用且成功，随后 log_report_ask 抛
    store._db = REAL_DB
    results.append(("C: hit+LLM-ok, log fail → 500, quota kept",
                    rc.status_code == 500, None, _free_used(), _log_rows()))

    # ── 场景B：未命中分支（1110）落库失败 → 500，扣次保留 ──
    store._db = _db_asklog_down
    rb = ask(MISS_Q)
    store._db = REAL_DB
    results.append(("B: miss-branch log fail → 500, quota kept",
                    rb.status_code == 500, None, _free_used(), _log_rows()))

    # 对照：退款入口 refund_one 在两条失败轨迹中均未执行（free_used 未回退）
    results.append(("no refund: free_used 1→3 (not 1)", _free_used() == 3,
                    None, _free_used(), None))

# ── 场景A 证伪：retrieve 的文件 IO OSError 被吞，不传播 ──
(cdir / "sample" / "sku-a.md").unlink()   # 文件消失 → read_text FileNotFoundError(OSError)
try:
    ch, hit = report_qa.retrieve("SKU-A", HIT_Q)
    a_ok = isinstance(ch, list) and isinstance(hit, bool)   # 正常返回，无异常
    a_err = None
except Exception as exc:  # pragma: no cover
    a_ok, a_err = False, repr(exc)
results.append(("A: sample file gone → retrieve still returns (OSError swallowed)",
                a_ok, a_err, None, None))

print("=" * 78)
for name, ok, extra, used, logs in results:
    print(f"[{'PASS' if ok else 'FAIL'}] {name}  extra={extra} free_used={used} log_rows={logs}")
print("=" * 78)
c_ok = results[1][1] and results[1][3] == 2 and results[1][4] == 1
b_ok = results[2][1] and results[2][3] == 3 and results[2][4] == 1
verdict = c_ok and b_ok and results[3][1] and results[4][1]
print("DEFECT REPRODUCED:" , verdict)
print("  C(hit+LLM-ok→log fail): 500 + free_used kept (charged, no refund, no answer delivered)")
print("  B(miss→log fail):       500 + free_used kept")
print("  A(retrieve OSError):    NOT reproducible — sample_text swallows OSError")
sys.exit(0 if verdict else 1)
