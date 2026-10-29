# -*- coding: utf-8 -*-
"""wechat_rss_bus — P1-6 公众号 RSS 监测总线 (终极提案 P1-6, 1028 用户已批).

思想来源: rachelos/we-mp-rss (5k★) 的「公众号→RSS」思路 + 在役资产复刻:
本机已有 wechat2rss 订阅面 (We-AIPO 矩阵, 镜像 OPML 在
data/rss_harvest/opml/wechat2rss_subscriptions.opml, 916 源) → 零部署零浏览器,
直接把它升级为「弹药池监测总线」:

  init   镜像 OPML × 监控名单 → legs/wechat_rss_feeds.json (订阅面只读不回写);
  run    逐源拉 feed (纯HTTP, 直连优先代理兜底) → 状态件去重 (guid, 只增) →
         新文章拉全文 (feed description 优先, 短则 mp.weixin.qq.com 页面抽取) →
         staging md → 入池 engine=wechat_rss (cred=media) → 台账只增。

监控名单 (1028 任务书): 总包之声 / 全球工程经营 / 国工论坛 / 华东勘测设计研究院
(全部在 wechat2rss 订阅面在册 — 实测见 feeds json)。

用法:
  py reforge_factory/legs/wechat_rss_bus.py init
  py reforge_factory/legs/wechat_rss_bus.py run --campaign EPC-TOP50 [--backfill 3]
铁律: 免费宪法 (we-mp-rss 自托管免) / 数字零造假 (每源命中/失败如实落账) /
只增不删 / 浏览器零开 (纯 HTTP) / ≤4 并发 (串行拉源)。
"""
from __future__ import annotations

import argparse
import hashlib
import html as html_mod
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
LEGDIR = Path(__file__).resolve().parent
sys.path.insert(0, str(LEGDIR))
sys.path.insert(0, str(LEGDIR.parent))
import http_api_leg_core as core                 # noqa: E402 (fetch/代理兜底)
import api_replica_bridge as arb                 # noqa: E402 (台账只增)
import ammo_pool                                 # noqa: E402 (入池)

REPO = LEGDIR.parents[1]                          # E:\AI-Station
OPML_MIRROR = REPO / "data" / "rss_harvest" / "opml" / "wechat2rss_subscriptions.opml"
FEEDS = LEGDIR / "wechat_rss_feeds.json"
STATE = LEGDIR / "wechat_rss_state.json"
BUSLOG = LEGDIR / "wechat_rss_log.jsonl"
#: 监控名单 (P1-6 任务书; OPML text 属性精确匹配)
MONITORED = ["总包之声", "全球工程经营", "国工论坛", "华东勘测设计研究院"]


def _slug(s: str) -> str:
    return re.sub(r"[^0-9A-Za-z\u4e00-\u9fa5]+", "_", s).strip("_")[:40] or "feed"


def cmd_init(ns) -> int:
    if not OPML_MIRROR.is_file():
        print("[rss_bus] 镜像 OPML 不存在: %s (先跑 tools/rss_harvest_run.py "
              "--sync-only)" % OPML_MIRROR, file=sys.stderr)
        return 2
    xml = OPML_MIRROR.read_text(encoding="utf-8", errors="replace")
    found = []
    for m in re.finditer(r"<outline[^>]*>", xml):
        tag = m.group(0)
        tm = re.search(r'text="([^"]*)"', tag)
        um = re.search(r'xmlUrl="([^"]*)"', tag)
        if not (tm and um):
            continue
        name = tm.group(1).strip()
        if name in MONITORED:
            found.append({"account": name, "xml_url": um.group(1)})
    missing = [a for a in MONITORED if a not in {f["account"] for f in found}]
    FEEDS.write_text(json.dumps(
        {"ts": time.strftime("%Y-%m-%d %H:%M"), "source_opml": str(OPML_MIRROR),
         "service": "wechat2rss (We-AIPO 订阅面只读复用, 零浏览器)",
         "monitored": MONITORED, "missing_in_opml": missing,
         "feeds": found}, ensure_ascii=False, indent=1), encoding="utf-8")
    print("[rss_bus] 订阅面在册 %d/%d: %s | 缺: %s"
          % (len(found), len(MONITORED), [f["account"] for f in found], missing))
    return 0 if len(found) >= 3 else 1


def _txt(block: str, tag: str) -> str:
    m = re.search(r"<%s>(?:<!\[CDATA\[)?(.*?)(?:\]\]>)?</%s>" % (tag, tag),
                  block, re.S)
    if not m:
        return ""
    t = re.sub(r"<[^>]+>", " ", m.group(1))
    return html_mod.unescape(re.sub(r"\s+", " ", t)).strip()


def _strip_html(s: str) -> str:
    t = re.sub(r"<br\s*/?>|</p>|</section>", "\n", s, flags=re.I)
    t = re.sub(r"<[^>]+>", "", t)
    lines = [html_mod.unescape(re.sub(r"[ \t]+", " ", ln)).strip()
             for ln in t.splitlines()]
    return "\n".join(ln for ln in lines if ln)


def _fulltext(link: str, desc: str) -> str:
    body = _strip_html(desc or "")
    if len(body) >= 600:
        return body
    try:                                   # mp.weixin.qq.com 直拉 (纯HTTP)
        status, text, via = core.fetch(link, proxy="auto")
        m = re.search(r'id="js_content"[^>]*>(.*?)<script', text, re.S) \
            or re.search(r"id=\"js_content\"[^>]*>(.*)", text, re.S)
        if status == 200 and m:
            page = _strip_html(m.group(1))
            return page if len(page) > len(body) else (body or page)
    except Exception:
        pass
    return body or "(全文拉取失败: feed 描述过短且页面抽取未成, 如实留短样)"


def load_state() -> dict:
    if STATE.is_file():
        return json.loads(STATE.read_text(encoding="utf-8"))
    return {"feeds": {}}


def save_state(st: dict) -> None:
    STATE.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                     encoding="utf-8")


def cmd_run(ns) -> int:
    if not FEEDS.is_file():
        print("[rss_bus] 先跑 init 生成订阅面", file=sys.stderr)
        return 2
    cfg = json.loads(FEEDS.read_text(encoding="utf-8"))
    feeds = [f for f in cfg["feeds"]
             if not ns.accounts or f["account"] in ns.accounts]
    st = load_state()
    ts = time.strftime("%Y%m%d_%H%M%S")
    stage = REPO / "ammo_pool" / ns.campaign / "staging" / "wechat_rss" / ts
    stage.mkdir(parents=True, exist_ok=True)
    tot_new = tot_ing = tot_chars = 0
    per = []
    for f in feeds:
        fs = st["feeds"].setdefault(
            f["xml_url"], {"account": f["account"], "seen": [], "runs": 0})
        fs["runs"] += 1
        status, text, via = core.fetch(f["xml_url"], proxy="auto")
        if status != 200 or not text:
            per.append({"account": f["account"], "status": status, "via": via,
                        "new": 0})
            with BUSLOG.open("a", encoding="utf-8") as fh:
                fh.write(json.dumps({"ts": ts, "account": f["account"],
                                     "status": status, "via": via},
                                    ensure_ascii=False) + "\n")
            print("  [fail] %s: HTTP %s via %s (如实)" % (f["account"], status, via))
            continue
        items = re.findall(r"<item>(.*?)</item>", text, re.S)
        seen = set(fs["seen"])
        fresh = []
        for it in items:
            link = _txt(it, "link") or _txt(it, "guid")
            g = hashlib.md5((link or _txt(it, "title")).encode(
                "utf-8")).hexdigest()[:8]
            if g in seen:
                continue
            # 全文优先级: content:encoded (wechat2rss 全文位, 实测64K级) > description (摘要位)
            ce = re.search(
                r"<content:encoded>(?:<!\[CDATA\[)?(.*?)(?:\]\]>)?"
                r"</content:encoded>", it, re.S)
            de = re.search(
                r"<description>(?:<!\[CDATA\[)?(.*?)(?:\]\]>)?</description>",
                it, re.S)
            raw = (ce.group(1) if ce else "") or (de.group(1) if de else "")
            fresh.append({"g": g, "title": _txt(it, "title"), "link": link,
                          "pub": _txt(it, "pubDate"), "desc": raw})
        # feed 序=最新在前: 首见源只回填最新 backfill 篇, 常规轮全量入池
        if fs["runs"] == 1 and len(fresh) > ns.backfill:
            fresh = fresh[: ns.backfill]
        # 当前 feed 全部 guid 标记已读 (状态只增; 防旧文被逐轮回踩成"新文")
        fs["seen"].extend(gg for gg in dict.fromkeys(
            [hashlib.md5(((_txt(it, "link") or _txt(it, "guid"))
                          or _txt(it, "title")).encode("utf-8")).hexdigest()[:8]
             for it in items]) if gg not in seen)
        ing_n = chars_n = 0
        for art in fresh:
            body = _fulltext(art["link"], art["desc"])
            md = ["---", "account: %s" % f["account"], 'title: "%s"'
                  % art["title"].replace('"', ""), "link: %s" % art["link"],
                  "published: %s" % art["pub"], "engine: wechat_rss",
                  "fetched_at: %s" % time.strftime("%Y-%m-%d %H:%M"), "---", "",
                  "# %s" % art["title"], "", body, "",
                  "> 来源: 公众号「%s」RSS 流 (wechat2rss 订阅面, engine=wechat_rss, "
                  "cred=media); 全文=%s。" % (f["account"],
                          "feed全文" if len(body) >= 600 else "短样/页面抽取")]
            mdp = stage / ("%s_%s.md" % (_slug(f["account"]), art["g"]))
            mdp.write_text("\n".join(md), encoding="utf-8")
            added, skipped = ammo_pool.ingest_files(ns.campaign, [{
                "file": str(mdp), "engine": "wechat_rss",
                "cred": "media", "tree": ""}])
            ing_n += added
            chars_n += len(body)
        tot_new += len(fresh)
        tot_ing += ing_n
        tot_chars += chars_n
        per.append({"account": f["account"], "status": status, "via": via,
                    "items": len(items), "new": len(fresh), "ingested": ing_n,
                    "chars": chars_n})
        print("  [ok] %s: 源内%d条 | 新%d | 入池%d (%d字, via %s)"
              % (f["account"], len(items), len(fresh), ing_n, chars_n, via))
        time.sleep(2.0)                            # 源间节流
    save_state(st)
    yld = "%d源%d新文/%d件入池%s字" % (len(feeds), tot_new, tot_ing,
                                       format(tot_chars, ","))
    arb.append_invocation(
        "wechat_rss", "wechat_rss_bus (公众号RSS监测总线, wechat2rss订阅面只读)",
        "; ".join(f["account"] for f in feeds), yld,
        note="P1-6 (1028): 纯HTTP零浏览器; 新文章拉全文入池 engine=wechat_rss; "
             "源状态与回填策略如实落 wechat_rss_log.jsonl",
        campaign=ns.campaign)
    with BUSLOG.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps({"ts": ts, "campaign": ns.campaign, "yield": yld,
                             "per_feed": per}, ensure_ascii=False) + "\n")
    print("[rss_bus] %s | 台账已落" % yld)
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="公众号 RSS 监测总线 (P1-6)")
    sub = ap.add_subparsers(dest="cmd", required=True)
    sub.add_parser("init")
    r = sub.add_parser("run")
    r.add_argument("--campaign", default="EPC-TOP50")
    r.add_argument("--accounts", nargs="*", default=[],
                   help="只跑指定公众号 (默认全监控名单)")
    r.add_argument("--backfill", type=int, default=3,
                   help="首见源最多回填几篇新文 (防首跑灌池)")
    ns = ap.parse_args()
    return cmd_init(ns) if ns.cmd == "init" else cmd_run(ns)


if __name__ == "__main__":
    raise SystemExit(main())
