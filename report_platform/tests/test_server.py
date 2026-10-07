# -*- coding: utf-8 -*-
"""server 单测 — 发布平台后端 (F5a). 离线件 (不起网络): 输入白名单+sqlite schema.
在线冒烟另由部署脚本 curl 三页三 API 覆盖 (真判据).
"""
from __future__ import annotations

import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from server import _db, _SAFE_EVENT, _SAFE_TEXT   # noqa: E402


# ------------------------------------------------ ① 合法联系字段
def test_01_contact_forms():
    ok = ["test@x.com", "wx_id_2026", "13800138000", "订单 2610071234567",
          "张三", "", "paid@163.com; 备注-尾号88"]
    for s in ok:
        assert _SAFE_TEXT.match(s), s


# ------------------------------------------------ ② 非法输入拒收
def test_02_reject_hostile():
    bad = ["<script>", "'; DROP TABLE orders;--", "a" * 201,
           '{"inject":1}']
    for s in bad:
        assert not _SAFE_TEXT.match(s), s
    for e in ("visit", "click_buy", "scroll_90"):
        assert _SAFE_EVENT.match(e)
    for e in ("<script>", "a b", "EV;EV", ""):
        assert not _SAFE_EVENT.match(e), e


# ------------------------------------------------ ③ sqlite schema
def test_03_db_schema():
    tmp = Path(tempfile.mkdtemp(prefix="rp_db_"))
    db = tmp / "t.db"
    with _db(db) as con:                       # 首建
        con.execute("INSERT INTO events(ts,event,sku,extra) VALUES(?,?,?,?)",
                    ("t", "visit", "R1", ""))
        con.execute("INSERT INTO orders(created,sku,order_no,contact,note) "
                    "VALUES(?,?,?,?,?)", ("t", "R1", "1", "a@b.c", ""))
    with _db(db) as con:                       # 重开=幂等, 数据在
        assert con.execute("SELECT COUNT(*) FROM events").fetchone()[0] == 1
        assert con.execute("SELECT COUNT(*) FROM orders").fetchone()[0] == 1
        assert con.execute(
            "SELECT state FROM orders LIMIT 1").fetchone()[0] == "pending"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
