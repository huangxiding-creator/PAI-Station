# -*- coding: utf-8 -*-
"""RSS 采集·运行载体（pythonw 零弹窗，schtasks 调度）。

复用 We-AIPO RSS 订阅源（只读）：
1. sync_opml：We-AIPO OPML → 本地镜像（sha256 比对，源清单保持最新）
2. harvest：串行收割 → data/rss_harvest/articles/YYYY-MM-DD/*.md

用法：
  python tools/rss_harvest_run.py                 # 全量一轮
  python tools/rss_harvest_run.py --max-requests 5  # 冒烟
  python tools/rss_harvest_run.py --sync-only     # 只同步清单不采集
  python tools/rss_harvest_run.py --alert-keywords "东方电气,核电,华龙一号"  # 命中即告警
  python tools/rss_harvest_run.py --alert-keywords "..." --push-alerts    # 班次汇总推企微
"""
import argparse
import logging
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT / "src"))

from paistation.sense.rss import harvest, sync_opml  # noqa: E402

# We-AIPO 侧资产：只读，绝不回写
WE_AIPO_OPML = Path(r"E:\CPOPC\We-AIPO\公众号RSS\wechat2rss_subscriptions.opml")
MIRROR = ROOT / "data" / "rss_harvest" / "opml" / "wechat2rss_subscriptions.opml"
STATE = ROOT / "data" / "rss_harvest" / "state.json"
OUT = ROOT / "data" / "rss_harvest" / "articles"
LOG = ROOT / "data" / "rss_harvest" / "run.log"


def _setup_log() -> logging.Logger:
    LOG.parent.mkdir(parents=True, exist_ok=True)
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s %(levelname)s %(message)s",
        handlers=[logging.FileHandler(LOG, encoding="utf-8")],
        force=True)
    return logging.getLogger("rss_harvest")


def _real_fetch(timeout: float):
    import requests
    s = requests.Session()
    s.headers.update({"User-Agent": "PAI-Station-RSS/1.0 (research mirror)"})

    def fetch(url, headers):
        r = s.get(url, timeout=timeout, headers=headers)
        text = None
        if r.status_code == 200:
            if (r.encoding or "").lower() in ("iso-8859-1", "latin-1"):
                r.encoding = r.apparent_encoding or "utf-8"  # We-AIPO 同款编码修复
            text = r.text
        return r.status_code, text, dict(r.headers)

    return fetch


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--opml", default=str(WE_AIPO_OPML))
    ap.add_argument("--mirror", default=str(MIRROR))
    ap.add_argument("--state", default=str(STATE))
    ap.add_argument("--out", default=str(OUT))
    ap.add_argument("--max-requests", type=int, default=None)
    ap.add_argument("--timeout", type=float, default=15.0)
    ap.add_argument("--sync-only", action="store_true")
    ap.add_argument("--alert-keywords", default=None,
                    help='逗号分隔告警关键词（多词 OR），如 "东方电气,核电,华龙一号"'
                         "；不给则整层关闭")
    ap.add_argument("--push-alerts", action="store_true",
                    help="班次告警汇总推企微（默认静默不推；每班次至多 1 条）")
    args = ap.parse_args()

    log = _setup_log()
    log.info("=" * 60)
    t0 = time.time()
    try:
        feeds, rep = sync_opml(Path(args.opml), Path(args.mirror))
        log.info("OPML 同步: %s", rep.brief())
    except FileNotFoundError as e:
        log.error("OPML 不可达: %s", e)
        return 2
    if args.sync_only:
        return 0
    # G12 信息级告警：--alert-keywords 给了才装配（默认整层关闭，零行为变化）
    alert = None
    if args.alert_keywords:
        from paistation.sense.rss.alert import AlertEngine, parse_keywords
        kws = parse_keywords(args.alert_keywords)
        if not kws:
            log.error("--alert-keywords 全为空白，无法装配告警层")
            return 2
        alert = AlertEngine(kws, base=ROOT / "data" / "rss_harvest")
        log.info("告警层就绪: %d 关键词 %s | 推送=%s | 落盘=%s",
                 len(kws), kws, bool(args.push_alerts), alert.alerts_path)
    elif args.push_alerts:
        log.warning("--push-alerts 需与 --alert-keywords 同用，本忽略（零推送）")
    report = harvest(feeds, Path(args.state), Path(args.out),
                     fetch=_real_fetch(args.timeout),
                     max_requests=args.max_requests, alert=alert)
    log.info("收割完成 [%d]: %s", round(time.time() - t0), report.brief())
    if alert is not None:
        n = alert.finalize(push=bool(args.push_alerts))
        log.info("告警班次收口: 命中 %d 条（digest=%s）", n, alert.digest_dir)
    if report.breaker_tripped:
        log.warning("⚠️ 风控熔断触发——本轮提前停止，下轮自动恢复（连败源走休眠探针制）")
        return 3
    return 0


if __name__ == "__main__":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass
    raise SystemExit(main())
