# -*- coding: utf-8 -*-
"""微信公众号 RSS 采集器——做法移植自 We-AIPO（We-AIPO 侧只读，绝不回写）。

移植来源 E:\\CPOPC\\We-AIPO\\src\\plugins\\input\\rss_source.py：
- OPML 唯一基准 + 账号名修复去重（FIX-0822a）
- 自适应节拍器：错误率驱动指数退避、健康收敛、全局起始间隔锁（T2）
- feed 健康制：连败≥3 且 7 天未成功→休眠；休眠≠永眠，周探针 7 天内至多 1 次（TQ8）
- 条件拉取 If-Modified-Since/ETag→304 跳过（T1；源站零验证器时自然退化全量）
- 编码修复：iso-8859-1 假头 → apparent_encoding
- 风控信号即停：单轮尝试≥BREAKER_MIN 且错误率>BREAKER_RATE → 停轮（0908 铁律）

复用方差异（比主人更客气，账号安全第一）：
- 串行不并行（We-AIPO 16 路）；节拍基线 0.8s（主人 0.15s）
- 持久化日限额（跨进程 survive，We-AIPO 进程内无此件）
- feedparser 解析替代手写 XML（agent-reach rss 渠道同款内核）
"""
from __future__ import annotations

import hashlib
import json
import logging
import re
import time
import xml.etree.ElementTree as ET
from dataclasses import dataclass, field
from html.parser import HTMLParser
from pathlib import Path

# ── 常量（全部可被 harvest() 参数覆盖） ──────────────────────────────
PACER_BASE_S = 0.8          # 串行基线间隔（主人 0.15s；复用方更保守）
PACER_MAX_S = 4.0
FAIL_DORMANT_N = 3          # 连败≥3 且 7 天未成功 → 休眠
DORMANT_AFTER_S = 7 * 86400
PROBE_EVERY_S = 7 * 86400   # 休眠源周探针
SEEN_BOUND = 500            # 每 feed 保留最近 N 条 guid 哈希（防 state 无限膨胀）
DAILY_CAP = 2500            # 日请求硬顶（2 轮全量 1810 + 余量）
BREAKER_MIN = 20            # 风控熔断最小样本
BREAKER_RATE = 0.5          # 错误率过半即停轮
FETCH_TIMEOUT_S = 15
_ILLEGAL_FN = re.compile(r'[\\/:*?"<>|\r\n\t]+')


def slugify(text: str, limit: int = 50) -> str:
    """文件名安全化：去 Windows 非法字符与首尾空白，保 CJK。"""
    s = _ILLEGAL_FN.sub("_", (text or "").strip())
    return s[:limit].strip(" ._") or "untitled"


def _h8(guid: str) -> str:
    return hashlib.sha1(guid.encode("utf-8", "ignore")).hexdigest()[:8]


# ── OPML：源清单唯一基准 ────────────────────────────────────────────
@dataclass(frozen=True)
class FeedRef:
    name: str
    url: str


def parse_opml(path: Path) -> list[FeedRef]:
    """OPML → [FeedRef...]；URL 去重，账号名取 title→text 兜底（FIX-0822a 同款）。"""
    tree = ET.parse(path)
    seen: set[str] = set()
    feeds: list[FeedRef] = []
    for ol in tree.iter("outline"):
        url = (ol.get("xmlUrl") or "").strip()
        if not url:
            continue
        if url in seen:
            continue
        seen.add(url)
        name = (ol.get("title") or ol.get("text") or "").strip() or url.rsplit("/", 1)[-1][:12]
        feeds.append(FeedRef(name=name, url=url))
    return feeds


@dataclass
class SyncReport:
    changed: bool = False
    total: int = 0
    added: list[str] = field(default_factory=list)
    removed: list[str] = field(default_factory=list)
    sha256: str = ""

    def brief(self) -> str:
        if not self.changed:
            return f"OPML 未变({self.total} 源, {self.sha256[:8]})"
        return (f"OPML 更新: {self.total} 源 (+{len(self.added)}/-{len(self.removed)})"
                f" 新增如 {self.added[:3]!r}")


def sync_opml(src: Path, dst: Path) -> tuple[list[FeedRef], SyncReport]:
    """只读同步：src=We-AIPO OPML（绝不写），dst=本地镜像。

    sha256 相同 → 零拷贝；不同 → 原子拷贝 + 增删源差分报告。
    src 不存在时若镜像在位则退化为镜像（主人目录不可用时采集不断粮）。
    """
    if not src.exists():
        if not dst.exists():
            raise FileNotFoundError(f"OPML 源与镜像均不存在: {src}")
        feeds = parse_opml(dst)
        fallback = SyncReport(total=len(feeds),
                              sha256=hashlib.sha256(dst.read_bytes()).hexdigest())
        return feeds, fallback  # 镜像退化为基准，零拷贝
    data = src.read_bytes()
    digest = hashlib.sha256(data).hexdigest()
    rep = SyncReport(sha256=digest)
    old_urls: set[str] = set()
    if dst.exists():
        old = parse_opml(dst)
        old_urls = {f.url for f in old}
    if not dst.exists() or hashlib.sha256(dst.read_bytes()).hexdigest() != digest:
        dst.parent.mkdir(parents=True, exist_ok=True)
        tmp = dst.with_suffix(".tmp")
        tmp.write_bytes(data)
        tmp.replace(dst)
        rep.changed = True
    feeds = parse_opml(dst)
    new_urls = {f.url for f in feeds}
    rep.total = len(feeds)
    by_url = {f.url: f.name for f in feeds}
    rep.added = sorted(by_url[u] for u in new_urls - old_urls)
    rep.removed = sorted(
        {f.url: f.name for f in (old if old_urls else [])}.get(u, u[-16:])
        for u in old_urls - new_urls) if old_urls else []
    return feeds, rep


# ── 节拍器（We-AIPO _AdaptivePacer 移植，可注入钟/睡） ─────────────
class AdaptivePacer:
    def __init__(self, *, base_interval: float = PACER_BASE_S,
                 max_interval: float = PACER_MAX_S,
                 clock=time.monotonic, sleep=time.sleep):
        self._base = base_interval
        self._max = max_interval
        self._interval = base_interval
        self._last_start = float("-inf")
        self._clock = clock
        self._sleep = sleep

    def record(self, ok: bool) -> None:
        if not ok:                      # 失败 → 指数退避
            self._interval = min(self._max, self._interval * 2)
        elif self._interval > self._base:  # 健康 → 收敛回落
            self._interval = max(self._base, self._interval / 2)

    def delay(self) -> None:
        """请求前调用：保证全局请求起始间隔 ≥ 当前 interval（串行下即逐请求间隔）。"""
        now = self._clock()
        wait = self._last_start + self._interval - now
        if wait > 0:
            self._sleep(wait)
            now = self._clock()
        self._last_start = max(now, self._last_start + self._interval)

    @property
    def interval(self) -> float:
        return self._interval


# ── HTML→文本（stdlib，无新依赖） ──────────────────────────────────
class _TextExtract(HTMLParser):
    _BLOCK = {"p", "div", "br", "li", "tr", "section", "h1", "h2", "h3",
              "h4", "h5", "h6", "blockquote", "pre", "table", "ul", "ol"}
    _DROP = {"script", "style"}

    def __init__(self) -> None:
        super().__init__(convert_charrefs=True)
        self._parts: list[str] = []
        self._dropped = 0

    def handle_starttag(self, tag, attrs):
        if tag in self._DROP:
            self._dropped += 1
        elif tag in self._BLOCK:
            self._parts.append("\n")

    def handle_endtag(self, tag):
        if tag in self._DROP:
            self._dropped -= 1
        elif tag in self._BLOCK:
            self._parts.append("\n")

    def handle_data(self, data):
        if not self._dropped:
            self._parts.append(data)

    def text(self) -> str:
        raw = "".join(self._parts)
        lines = [ln.strip() for ln in raw.splitlines()]
        return re.sub(r"\n{3,}", "\n\n", "\n".join(lines)).strip()


def html_to_text(html: str) -> str:
    p = _TextExtract()
    try:
        p.feed(html or "")
        p.close()
        return p.text()
    except Exception:
        return re.sub(r"<[^>]+>", "", html or "").strip()


# ── 采集主循环 ─────────────────────────────────────────────────────
@dataclass
class HarvestReport:
    feeds_total: int = 0
    attempted: int = 0
    ok: int = 0
    fail: int = 0
    not_modified: int = 0
    dormant_skipped: int = 0
    probed: int = 0
    new_articles: int = 0
    alerts: int = 0
    breaker_tripped: bool = False
    daily_cap_hit: bool = False
    duration_s: float = 0.0

    def brief(self) -> str:
        flags = []
        if self.breaker_tripped:
            flags.append("⚠️风控熔断停轮")
        if self.daily_cap_hit:
            flags.append("日限额止")
        alert_s = f" 告警{self.alerts}" if self.alerts else ""
        return (f"源{self.feeds_total} 试{self.attempted} 成{self.ok} 败{self.fail} "
                f"304:{self.not_modified} 休眠跳过{self.dormant_skipped} 探针{self.probed} "
                f"新文{self.new_articles}{alert_s} {' '.join(flags)}").strip()


def _today(now_s: float) -> str:
    return time.strftime("%Y-%m-%d", time.localtime(now_s))


def _load_state(path: Path) -> dict:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception:
        return {"feeds": {}, "daily": {"day": "", "requests": 0}}


def _save_state(path: Path, state: dict) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(".tmp")
    tmp.write_text(json.dumps(state, ensure_ascii=False), encoding="utf-8")
    tmp.replace(path)


def harvest(feeds: list[FeedRef], state_path: Path, out_dir: Path, *,
            fetch, parse=None, now=None, clock=time.monotonic,
            sleep=time.sleep, daily_cap: int = DAILY_CAP,
            max_requests: int | None = None,
            keep_going_after_breaker: bool = False,
            alert=None) -> HarvestReport:
    """串行收割一轮。fetch(url, headers) -> (status, text, resp_headers)。

    状态=持久 JSON：feed 健康/guid 去重/日请求数（跨进程）。断点=按 feed
    幂等（新文去重、失败计数），整轮可随时中断重跑零重复。

    alert=AlertEngine 时逐篇新文章做关键词观测（G12 观测层：只旁挂，
    任何告警层异常只记日志，绝不改收割节拍/限额行为）。
    """
    import feedparser
    parse = parse or feedparser.parse
    now = now or time.time()
    state = _load_state(state_path)
    fstates: dict = state.setdefault("feeds", {})
    daily = state.setdefault("daily", {"day": "", "requests": 0})
    if daily.get("day") != _today(now):
        daily.update(day=_today(now), requests=0)
    budget = daily_cap - daily["requests"] if max_requests is None \
        else min(max_requests, max(0, daily_cap - daily["requests"]))
    pacer = AdaptivePacer(clock=clock, sleep=sleep)
    rep = HarvestReport(feeds_total=len(feeds))
    day_dir = out_dir / _today(now)
    t0 = clock()

    for feed in feeds:
        fs = fstates.setdefault(feed.url, {})
        last_success = fs.get("last_success", 0)
        fail_count = fs.get("fail_count", 0)
        # TQ8 健康闸：休眠源周探针制（休眠≠永眠）
        if fail_count >= FAIL_DORMANT_N and (now - last_success) >= DORMANT_AFTER_S:
            if now - fs.get("last_probe", 0) < PROBE_EVERY_S:
                rep.dormant_skipped += 1
                continue
            fs["last_probe"] = now
            rep.probed += 1
        if budget <= 0:
            rep.daily_cap_hit = True
            break
        # 风控熔断：样本足够且错误率过半 → 即停（0908 铁律；按 feed 成败比判）
        feeds_done = rep.ok + rep.fail
        if (not keep_going_after_breaker and feeds_done >= BREAKER_MIN
                and rep.fail > BREAKER_RATE * feeds_done):
            rep.breaker_tripped = True
            break
        # 条件拉取头（T1；源站无验证器时自然为空 → 全量）
        stored = fs.get("validator") or {}
        headers = {}
        if stored.get("lm"):
            headers["If-Modified-Since"] = stored["lm"]
        elif stored.get("etag"):
            headers["If-None-Match"] = stored["etag"]
        pacer.delay()
        status, text, rheaders = 0, None, {}
        for attempt in range(2):
            budget -= 1
            daily["requests"] += 1
            rep.attempted += 1
            try:
                status, text, rheaders = fetch(feed.url, headers)
            except Exception:
                status = 0
            if status in (200, 304):
                break
            if attempt == 0:
                sleep(2.0)  # 5xx/网络错一次短退避重试（We-AIPO 同款）
        if status == 304:
            fs["fail_count"] = 0
            fs["last_success"] = now
            rep.ok += 1
            rep.not_modified += 1
            pacer.record(True)
            continue
        if status != 200 or text is None:
            fs["fail_count"] = fail_count + 1
            rep.fail += 1
            pacer.record(False)
            continue
        # 200：解析 + 新文收割
        parsed = parse(text)
        validator: dict = {}
        if rheaders.get("Last-Modified"):
            validator = {"lm": rheaders["Last-Modified"]}
        elif rheaders.get("ETag"):
            validator = {"etag": rheaders["ETag"]}
        seen: list = fs.get("seen", [])
        seen_set = set(seen)
        written = 0
        for entry in getattr(parsed, "entries", []):
            guid = (entry.get("id") or entry.get("link") or
                    f"{feed.url}#{entry.get('title', '')}")
            hh = _h8(guid)
            if hh in seen_set:
                continue
            seen_set.add(hh)
            seen.append(hh)
            content = ""
            ce = entry.get("content") or []
            if ce:
                content = ce[0].get("value", "")
            content = content or entry.get("summary", "")
            title = entry.get("title", "") or "(无标题)"
            link = entry.get("link", "")
            pub = entry.get("published", "") or entry.get("updated", "")
            day_dir.mkdir(parents=True, exist_ok=True)
            fn = f"{slugify(feed.name, 30)}_{slugify(title, 40)}-{hh}.md"
            body = html_to_text(content)
            title_safe = title.replace('"', "'")
            front = (
                "---\n"
                f"account: {feed.name}\n"
                f'title: "{title_safe}"\n'
                f"link: {link}\n"
                f"published: {pub}\n"
                f"guid: {guid}\n"
                f"source: wechat2rss-mirror\n"
                f"fetched_at: {time.strftime('%F %T', time.localtime(now))}\n"
                "---\n\n"
                f"# {title}\n\n{body}\n")
            (day_dir / fn).write_text(front, encoding="utf-8")
            written += 1
            if alert is not None:  # G12 观测层：命中即告警（旁挂，绝不反噬收割）
                try:
                    if alert.on_article(feed=feed.name, title=title, body=body,
                                        link=link, published=pub,
                                        path=day_dir / fn, now=now):
                        rep.alerts += 1
                except Exception as e:
                    logging.getLogger("rss_alert").warning(
                        "告警层异常(忽略): %s", e)
        rep.new_articles += written
        fs["seen"] = seen[-SEEN_BOUND:]
        fs["fail_count"] = 0
        fs["last_success"] = now
        if validator:
            fs["validator"] = validator
        rep.ok += 1
        pacer.record(bool(getattr(parsed, "entries", [])) or True)

    state["last_run"] = time.strftime("%F %T", time.localtime(now))
    _save_state(state_path, state)
    rep.duration_s = round(clock() - t0, 1)
    return rep
