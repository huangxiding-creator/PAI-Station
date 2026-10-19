# -*- coding: utf-8 -*-
"""复现审查发现（commit 23a48173 审查 / lens=code-repro）：

  report_ask 在 app.py:1103 consume_one 扣次后，退款只挂在 `if not conclusion`
  分支（app.py:1125-1129，仅覆盖 zhipu.deep_answer 抛错/空解析）。consume 与
  响应之间的任何其它异常——典型如 store.log_report_ask 的 INSERT
  （app.py:1110 未命中腿 / app.py:1132 成功腿）遇 MySQL 抖动——会以未处理
  异常直穿为 500，扣次已提交、无退款。与咨询流 _run_answer（app.py:202-205
  全程 try/except 失败必退）不对称，违背 v0.9.23「非成功出口不扣次」契约。

验证法：真实 app + 真实 store（临时 sqlite）+ TestClient(raise_server_exceptions=
False) 走完整 HTTP 栈。在 store.log_report_ask 这一 DB 边界注入
sqlite3.OperationalError——正是生产 MySQL 路径 pymysql.OperationalError 经
_MyConn._run（store.py:134-135）翻译后抛出的同一类型（连接抖动/锁等待超时/
池耗尽），也是 sqlite 真实「database is locked」的类型。三腿对照：
  腿1 对照-成功：无注入 → 200，left 6→5（正常扣次）；
  腿2 对照-LLM失败：zhipu 抛错 → 503，left 6→6（退款分支正常工作）；
  腿3 命中+INSERT抖动：log_report_ask 抛 OperationalError → 500，left 6→5
      （扣次 standing，无退款，用户两手空空）；
  腿4 未命中+INSERT抖动：app.py:1110 同样 500 + 扣次无退款。
"""
from __future__ import annotations

import json
import sqlite3
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

_TMP = Path(tempfile.mkdtemp(prefix="qw_rqa_logfail_"))
from qianwen_engine import config  # noqa: E402

config.DATA_DIR = _TMP
config.DB_PATH = _TMP / "db.sqlite"

from qianwen_engine import report_catalog, store, wechat, zhipu  # noqa: E402
from qianwen_engine import app as qwapp  # noqa: E402
from fastapi.testclient import TestClient  # noqa: E402

U = "repro-user"
SKU = "SKU-REPRO"
Q_HIT = "变更签证怎么办理"          # 语料 2-gram 命中（tests 同款）
Q_MISS = "量子纠缠是什么原理"        # 语料零重叠 → 未命中腿（app.py:1105-1112）
FAKE_REPLY = "结论行\n第1章：论据一\n第2章：论据二"


def _mk_content() -> None:
    cdir = _TMP / "content"
    (cdir / "full").mkdir(parents=True)
    (cdir / "sample").mkdir(parents=True)
    chapters = [
        (1, "合同体系", "合同类型与条款要点"),
        (2, "计价规则", "计价方式与调价机制"),
        (5, "变更签证", "变更签证的办理流程"),
    ]
    r = {"reports": [{
        "sku": SKU, "title": "复现报告", "subtitle": "", "price": 1,
        "price_label": "¥1", "words_wan": 1, "badges": [], "cat": "ent",
        "cat_name": "企业研究", "intro_lede": "", "intro": "", "audience": "",
        "chapters": [{"id": i, "title": f"第{i}章 {kw}", "desc": desc}
                     for i, kw, desc in chapters],
        "sample_file": "s.md", "sample_label": "试读",
    }]}
    (cdir / "report.json").write_text(json.dumps(r, ensure_ascii=False), encoding="utf-8")
    (cdir / "full" / f"{SKU}.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
    (cdir / "sample" / "s.md").write_text("# 试读\n合同计价与变更签证。", encoding="utf-8")
    config.REPORT_CONTENT_DIR = cdir
    report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})


def _quota() -> int:
    return store.quota_left(U)["total_left"]


def main() -> int:
    _mk_content()
    store._init_done = False
    store.init()
    token = wechat.issue_token(U)
    ok = True

    # 腿1 对照-成功：200 + 正常扣次 6→5
    zhipu.deep_answer = lambda s, p, **k: FAKE_REPLY
    with TestClient(qwapp.app, raise_server_exceptions=False) as c:
        c.headers.update({"Authorization": f"Bearer {token}"})
        b = _quota()
        r = c.post(f"/api/report/{SKU}/ask", json={"q": Q_HIT})
        a = _quota()
        print(f"[腿1 成功对照] http={r.status_code} quota {b}->{a} body={r.json()}")
        ok &= (r.status_code == 200 and a == b - 1)

        # 腿2 对照-LLM失败：503 + 退款（现契约内分支）
        b2 = _quota()
        zhipu.deep_answer = lambda s, p, **k: (_ for _ in ()).throw(RuntimeError("GLM 全失败"))
        r2 = c.post(f"/api/report/{SKU}/ask", json={"q": Q_HIT})
        a2 = _quota()
        print(f"[腿2 LLM失败对照] http={r2.status_code} quota {b2}->{a2} body={r2.json()}")
        ok &= (r2.status_code == 503 and a2 == b2)
        zhipu.deep_answer = lambda s, p, **k: FAKE_REPLY

        # 腿3 命中腿 INSERT 抖动（app.py:1132 log_report_ask 抛 MySQL 翻译型错误）
        real_log = store.log_report_ask

        def boom(*args, **kwargs):
            raise sqlite3.OperationalError(
                "(1205, 'Lock wait timeout exceeded; try restarting transaction')")
        store.log_report_ask = boom
        b3 = _quota()
        r3 = c.post(f"/api/report/{SKU}/ask", json={"q": Q_HIT})
        a3 = _quota()
        print(f"[腿3 命中+log INSERT 抖动] http={r3.status_code} quota {b3}->{a3} "
              f"body={r3.text[:60]!r}")
        ok &= (r3.status_code == 500 and a3 == b3 - 1)   # 500 且扣次未退 = 缺陷实锤

        # 腿4 未命中腿 INSERT 抖动（app.py:1110）
        b4 = _quota()
        r4 = c.post(f"/api/report/{SKU}/ask", json={"q": Q_MISS})
        a4 = _quota()
        print(f"[腿4 未命中+log INSERT 抖动] http={r4.status_code} quota {b4}->{a4} "
              f"body={r4.text[:60]!r}")
        ok &= (r4.status_code == 500 and a4 == b4 - 1)
        store.log_report_ask = real_log

    print("REPRO", "FIRES (defect confirmed)" if ok else "did not fire")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())
