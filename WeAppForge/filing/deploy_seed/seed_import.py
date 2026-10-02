# -*- coding: utf-8 -*-
"""一次性锅圈数据导入：ECS SQLite 导出 → CloudBase MySQL。

幂等：INSERT IGNORE，重复执行零副作用。跑完打印 SEED_DONE 报告行。
"""
import json
import sys

from qianwen_engine import store

A_COLS = ("id,openid,question,answer_full,citations,via,status,unlocked,"
          "liked,criticized,elapsed_sec,views,shares,created_at")


def main() -> int:
    with open("/app/pot_export.json", encoding="utf-8") as fh:
        obj = json.load(fh)
    answers = obj.get("answers") or []
    pots = obj.get("pot_items") or []
    print(f"[seed] loaded export: answers={len(answers)} pot_items={len(pots)}", flush=True)

    store.init()

    a_ph = ",".join(["?"] * 14)
    sql_a = f"INSERT IGNORE INTO answers({A_COLS}) VALUES({a_ph})"
    sql_p = "INSERT IGNORE INTO pot_items(aid, sort) VALUES(?,?)"

    ins_a = ins_p = 0
    with store._db() as c:
        for r in answers:
            cur = c.execute(sql_a, (
                r.get("id"), r.get("openid"), r.get("question"), r.get("answer_full"),
                r.get("citations"), r.get("via"), r.get("status"), r.get("unlocked"),
                r.get("liked"), r.get("criticized"), r.get("elapsed_sec"),
                r.get("views"), r.get("shares"), r.get("created_at")))
            ins_a += cur.rowcount if cur and cur.rowcount and cur.rowcount > 0 else 0
        for r in pots:
            cur = c.execute(sql_p, (r.get("aid"), r.get("sort")))
            ins_p += cur.rowcount if cur and cur.rowcount and cur.rowcount > 0 else 0
        c.commit()

    print(f"SEED_DONE answers_inserted={ins_a} pot_inserted={ins_p} "
          f"(skipped existing: a={len(answers) - ins_a} p={len(pots) - ins_p})", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main())
