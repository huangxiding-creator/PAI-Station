# -*- coding: utf-8 -*-
"""sogou_r4 — 1028 三门冲线·r4 搜狗微信腿 (E2 反证位定向补).

照腿6 sogou_wx_supply.py 同型 (纯HTTP复刻件, 零浏览器), 但查询按 r4 覆盖账
钦定: 4 个单源 E2 槽 (Q3-E2/Q10-E2/Q11-E2/Q21-E2, 现源 host=
tbea/sina/vip.stock/cbda) — 微信全文落 mp.weixin.qq.com = 天然异源, 一件即饱和。

诚实纪律: 每件过 judge 战役 21 词硬门 (off_topic 废弃如实); 0 产出也落账;
antispider 3 连即熔断 (复刻件限流纪律)。
用法: py -X utf8 sogou_r4.py [--top 2]
"""
from __future__ import annotations

import argparse
import io
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
REPLICA = r"E:\AI-Station\逆向工程\sogou-weixin-reverse\replica\sogou_weixin_api.py"
AMMO = REPO / "reforge_factory" / "ammo_pool.py"
STAGE = REPO / "ammo_pool" / "EPC-TOP50" / "staging" / "sogou_wechat" / time.strftime("%Y%m%d_%H%M%S")
STAGE.mkdir(parents=True, exist_ok=True)
LOG = REPO / "reforge_factory" / "epc_top50_supply" / "logs" / ("sogou_r4_%s.log" % time.strftime("%Y%m%d_%H%M%S"))

#: (查询词串, 主挂树 EEI) — r4 钦定 4 个单源 E2 槽
QUERIES: list[tuple[str, str]] = [
    ("设计院 排名 下滑 出局", "Q3-E2"),
    ("化工工程 EPC 亏损 风险", "Q10-E2"),
    ("中材国际 冶金工程 亏损 风险", "Q11-E2"),
    ("设计院 裁员 降薪 困境", "Q21-E2"),
]


def run_query(q: str, top: int):
    cmd = ["py", "-X", "utf8", REPLICA, *q.split(), "--top", str(top), "--json"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace", timeout=300)
    so = (r.stdout or "").strip()
    i = so.find("{")
    if i < 0:
        return None, f"no_json:{so[-120:]}|{(r.stderr or '')[-120:]}"
    try:
        return json.loads(so[i:]), None
    except Exception as e:                      # noqa: BLE001
        return None, f"json_fail:{e}"


def ingest(md: Path, url: str, tree: str):
    cmd = ["py", "-X", "utf8", str(AMMO), "ingest", "EPC-TOP50",
           "--file", str(md), "--engine", "sogou_wechat", "--url", url,
           "--cred", "media", "--tree", tree, "--stance", "against"]
    r = subprocess.run(cmd, capture_output=True, text=True, encoding="utf-8",
                       errors="replace")
    return r.returncode, ((r.stdout or "") + (r.stderr or ""))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--top", type=int, default=2)
    ns = ap.parse_args()
    out = open(LOG, "a", encoding="utf-8")

    def emit(s):
        print(s, flush=True)
        out.write(s + "\n")
        out.flush()

    tot = totc = blocked = 0
    for q, tree in QUERIES:
        data, err = run_query(q, ns.top)
        if data is None:
            emit(json.dumps({"ok": False, "q": q, "tree": tree, "why": err},
                            ensure_ascii=False))
            if "antispider" in err or "Blocked" in err or "blocked" in err:
                blocked += 1
                time.sleep(150)
                if blocked >= 3:
                    emit(json.dumps({"abort": "3x_blocked"}, ensure_ascii=False))
                    break
            time.sleep(8)
            continue
        arts = data.get("full") or data.get("articles") or []
        if not arts and data.get("hits"):
            emit(json.dumps({"info": "list_only", "q": q,
                             "hits": len(data["hits"])}, ensure_ascii=False))
        n = 0
        for a in arts[:ns.top]:
            text = (a.get("text") or a.get("content") or "").strip()
            title = (a.get("title") or "").strip() or f"{q}微信文章"
            if len(text) < 800:
                continue
            md = STAGE / (re.sub(r"\W+", "_", title)[:60] + ".md")
            head = (f"# {title}\n\n"
                    f"来源: 微信公众号 {a.get('account', '')} (搜狗微信检索, "
                    f"engine=sogou_wechat, 纯HTTP复刻件 r4 腿).\n"
                    f"发布: {a.get('publish_time', '')}  链接: {a.get('url', '')}\n"
                    f"campaign EPC-TOP50, tree {tree}, cred media, stance against. "
                    f"正文零改动, 实测{len(text)}字.\n\n---\n\n")
            md.write_text(head + text, encoding="utf-8")
            rc, msg = ingest(md, a.get("url", ""), tree)
            ok = rc == 0 and "硬拒" not in msg
            if ok:
                tot += 1
                totc += len(text)
                n += 1
            emit(json.dumps({"ok": ok, "q": q, "tree": tree,
                             "title": title[:40], "chars": len(text),
                             "msg": msg.strip()[-110:]}, ensure_ascii=False))
        time.sleep(6)
    emit(json.dumps({"SUMMARY": True, "ingested": tot, "chars_sum": totc,
                     "blocked": blocked}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    main()
