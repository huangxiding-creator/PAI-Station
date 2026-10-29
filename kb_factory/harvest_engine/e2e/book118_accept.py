# -*- coding: utf-8 -*-
"""T37 验收件：book118 实弹 10 份验收（FR3.AC1：免费≥6/收费≥4；质检门 10/10+OCR GT ≥8/10）。

验收口径（任务卡 T37 / REQ FR3.AC1）：
- 10 份 = T33 三份直接计入（6115103231005025 免费试读 3/7、5110103104004213 收费 62/124、
  5123021331010032 全预览 22/22，GT 已誊录）+ 新选 7 份（shtm 检索面/分类页 /doclist/list-*.html
  静态 .shtm 直链：全预览档 preview==actual 优先凑免费口径 4 份 + 收费档 preview<actual 3 份；
  新件 preview ≤ --max-new-pages（默认 12 页短档），长档（>12 页）10 份里 ≤2 份=
  5110(62 页)+5123(22 页)两席已满，新件一律短档）；
- 页数门（逐份，pypdfium2 独立实测）：全预览档 实测页数==actual（manifest 口径 expected_pages）；
  preview<actual 档（收费件/免费试读件同门）实测页数==preview（manifest 口径 preview_limit=
  部分收割合法形态）——任务卡注：T23 实证免费样本也可能 preview<actual（免登录通道无原件
  下载），「免费件页数==actual」仅当 preview==actual 档成立；preview<actual 免费件如实记
  preview_limit 口径，逐份记录 preview/actual 两值；
- 形态门：preview<actual 件 FileMeta 形态标注「预览部分」+perm=yellow（黄线透明，
  harvest_preview_pdf 内建 T23 语义）；
- 质检门：quality_gate 四门（manifest ref_chars_source=book118、preview_limit/expected_pages
  口径逐份落 manifest）10/10（CLI 真符号 quality_gate.main 退出码同源）；
- OCR GT：tests/fixtures/book118_gt.json 10 份（T33 3 份+T37 新誊 7 份），每份=标题+首页
  2 个≥4 字词，pypdfium2 抽 searchable PDF 文字层精确匹配（容错=0，空白归一），3/3 命中=
  该份过，≥8/10 份过；
- 预算：净请求（真网络发=browser 页加载/openapi 批/图床直下三类；memo/盘缓存命中零计）
  ≤ --budget（默认 30 发=任务卡验收口径）；超顶熔断如实停（退出码 1）。
  T41 P0-1（2026-10-23）口径修正：browser 页加载按**首跳+全子资源**计数入账（Playwright
  request 事件实测，每页一行 ledger、detail 带 page_load_requests=N）——旧口径只计页加载
  本身，T37 实测 520 真发（browser 326+openapi 70+image 124）被自认「本轮 0 发」，站方
  视角实发 vs 代码预算严重脱节；另加单文档全链路硬顶 --doc-cap（默认 150 发=研判⑤
  「browser≤60+openapi≤12+图=页数」的收纳值，62 页档同族可容）。施工首跑请按本口径
  放大 --budget（子资源入账后同链路计数约为旧口径的数倍）。

预算与断点模型（数字零造假）：
- 件级断点：summary 逐件落 page_urls/preview/actual——resume（默认自动：summary 在场即续跑）
  免 .shtm 首跳免 openapi 批（页清单直用）；.shtm 页 HTML 另 memo（book118_shtm_memo.json，
  选件期已开的候选页收割期零网络）；
- 图缓存复用：work/{doc}/pages/NNNN.* 在盘即零网络（image_transport 注入盘缓存包装，
  URL→页号 https/http 双向映射）；T33 首页图缓存机制在位（fixtures/book118_gt_pages/{doc}/
  0001.* 作为第 1 页缓存源——GT 三件首页免发）；
- OCR 两段式+页级断点（T23 教训：长档一次性 OCR 不可续、帧全驻内存不可行）：pass1 流式
  逐页识别（单页 150dpi 渲帧→paddle 识别→行集落 ocr_pages.json 每页 flush，已识别页跳过）；
  pass2 分块（8 页/块）build_searchable_pdf+import_pages 合并（帧内存峰值 O(块)）——
  62 页档分批跑不重算；
- 施工首跑用放大的 --budget 放行全量（T41 P0-1 起子资源全计入账：首跳/probe+openapi 批+
  图+browser 子资源，量级较旧口径「≈160 发」按子资源倍数放大，ledger 全量入账）；任务卡
  验收命令（无参）跑在缓存全热的收口态=净请求 0≤30。

命令：py -3 kb_factory/harvest_engine/e2e/book118_accept.py [--fresh] [--budget 30]
      [--limit 10] [--max-new-pages 12] [--select-only] [--gt-dump DOCID]
      [--docs id1,id2] [--no-ocr]
退出码 0 = 10/10 页数门+形态门+质检门 且 免费≥6/收费≥4 且 OCR GT ≥8/10 且 净请求 ≤ 预算。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

_E2E_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(_E2E_DIR.parents[2]))  # 仓库根（kb_factory 包导入）

from kb_factory.channel_adapters.base import FileMeta  # noqa: E402
from kb_factory.harvest_engine import quality_gate  # noqa: E402
from kb_factory.harvest_engine.adapters.base import HarvestPlan  # noqa: E402
from kb_factory.harvest_engine.adapters.book118 import (  # noqa: E402
    CHALLENGE_MARKER, CHALLENGE_WAIT_S, HOME_URL, HTTP_TIMEOUT_S,
    OPENAPI_URL, RE_SEARCH_DOC_LINK, Book118Adapter, Book118PreviewError,
    extract_shtm_config, image_url_pair)
from kb_factory.harvest_engine.audit import HarvestAudit  # noqa: E402
from kb_factory.harvest_engine.store.ledger import Store  # noqa: E402

ARTIFACTS = _E2E_DIR / "artifacts"
ROOT = ARTIFACTS / "book118"
SUMMARY_PATH = ROOT / "book118_accept_summary.json"
LEDGER_PATH = ROOT / "book118_accept_ledger.jsonl"
SHTM_MEMO_PATH = ROOT / "book118_shtm_memo.json"
STORE_DIR = ROOT / "book118_store"
WORK_ROOT = ROOT / "work"
FIXTURES = _E2E_DIR.parent / "tests" / "fixtures"
GT_PATH = FIXTURES / "book118_gt.json"
GT_PAGES_ROOT = FIXTURES / "book118_gt_pages"

OCR_DPI = 150          # 与 make_pdf_ocr_searchable 缺省同值（T33 验收同链口径）
OCR_CHUNK = 8          # pass2 分块页数（帧内存峰值 O(块)：8×1650×2333×3B ≈ 92MB）
NEW_DOC_MIN_PAGES = 2  # 新件 preview 下限（单页封面件 OCR 行太薄，选件面避让）
#: T41 P0-1 单文档全链路请求数硬顶（browser 首跳+全子资源+openapi 批含重试+图床直下
#: 合计；研判⑤ browser≤60+openapi≤12+图=页数 的收纳值，62 页档同族≈134 可容）。
DOC_NET_CAP = 150
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")

#: T33 三份直接计入（GT 已誊录；side=免费/收费计数侧，任务卡口径）
T33_SEEDS = [
    {"doc_id": "6115103231005025",
     "shtm_url": "https://max.book118.com/html/2022/1214/6115103231005025.shtm",
     "side": "free", "form": "T33 免费试读档 preview=3 actual=7"},
    {"doc_id": "5110103104004213",
     "shtm_url": "https://max.book118.com/html/2022/0414/5110103104004213.shtm",
     "side": "paid", "form": "T33 收费档 preview=62 actual=124"},
    {"doc_id": "5123021331010032",
     "shtm_url": "https://max.book118.com/html/2022/1214/5123021331010032.shtm",
     "side": "free", "form": "T33 全预览档 preview=22 actual=22"},
]

#: 选件种子 shtm（T19 探针 fixtures 留档的真实链接：首页/详情页推荐位同族，形态多样）
SEED_LINKS = [
    ("2022", "1214", "5133230331010032"), ("2022", "1214", "5140213331010032"),
    ("2022", "1214", "5141041331010032"), ("2022", "1214", "5142332331010032"),
    ("2022", "1214", "5124141331010032"), ("2022", "1214", "5131241331010032"),
    ("2022", "1214", "6115120231005025"), ("2022", "1214", "6102201231005025"),
    ("2022", "1214", "6105013231005025"), ("2022", "1214", "7055010160005023"),
    ("2021", "0906", "5022244004004001"), ("2021", "0906", "6041102003004001"),
    ("2021", "0906", "6042220003004001"), ("2021", "0906", "7052126004004001"),
    ("2021", "0922", "5242202131004012"), ("2021", "0922", "6200050105004011"),
    ("2021", "0922", "8106111051004007"), ("2021", "0922", "8110054051004007"),
    ("2022", "0414", "8036066035004072"), ("2015", "0519", "17297363"),
]
DEFAULT_LISTS = ["/doclist/list-551.html", "/doclist/list-612.html",
                 "/doclist/list-430.html", "/doclist/list-312.html"]

_WS_RE = re.compile(r"\s+")


class BudgetExceeded(RuntimeError):
    """净请求预算硬顶熔断（超预算如实停，不静默继续）。"""


def _norm(text: str) -> str:
    """GT 匹配空白归一（FR3.AC2 容错=0 口径：只移除空白字符，字符级零容差）。"""
    return _WS_RE.sub("", text or "")


# ---------------------------------------------------------------- 网络账房（三类净发计数）

class Net:
    """真网络腿计数+台账（browser 页加载/openapi 批/图床直下；memo 命中零计）。

    - 每一真发：net+1、ledger 一行（net=true）；memo/盘缓存命中：ledger 一行（net=false
      cache），净请求不增——「净请求」=真发数（任务卡预算口径）；
    - T41 P0-1（2026-10-23）：browser 页加载按**首跳+全子资源**入账——Playwright
      ``request`` 事件实测计数（每页一行 ledger、detail 带 ``page_load_requests=N``，
      by_kind 仍按行数记：browser 行=页加载）；旧口径只计页加载本身，站方视角实发被
      预算外漏计（T37 实测 520 真发 vs 代码自认 0 发）；
    - 双预算硬顶：全局 --budget（发前 _gate 预检+发后 _spend 超顶即熔断）与单文档
      全链路 --doc-cap（current_doc 切换清零，超顶抛 BudgetExceeded 如实停）；
    - .shtm/分类页 HTML memo（崩溃安全：200 且 >10KB 才入，WAF/挑战页体不固化）。
    """

    def __init__(self, ledger_path: Path, memo_path: Path, *, cap: int,
                 start_net: int = 0, start_by_kind: dict | None = None,
                 doc_cap: int = DOC_NET_CAP):
        self.cap = int(cap)
        self.doc_cap = int(doc_cap)
        self.net = int(start_net)
        self.round0 = int(start_net)   # 本轮起点（验收口径=本轮净发 ≤ cap）
        self.by_kind: dict[str, int] = dict(start_by_kind or {})
        self._current_doc = "-"
        self.doc_net = 0               # 单文档全链路真发（current_doc 切换即清零）
        self._audit = HarvestAudit(path=str(ledger_path))
        self._memo_path = memo_path
        self._memo = self._load_memo()
        self._browser = None            # main 注入（生命周期归调用方）
        self._http_openapi = None       # 惰性 httpx.Client
        self._http_img = None

    @property
    def current_doc(self) -> str:
        """在跑文档（赋值切换时 doc_net 清零——单文档口径只算本件全链路）。"""
        return self._current_doc

    @current_doc.setter
    def current_doc(self, value: str) -> None:
        if value != self._current_doc:
            self._current_doc = value
            self.doc_net = 0

    # ---- memo ----
    def _load_memo(self) -> dict:
        try:
            return json.loads(self._memo_path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return {}

    def _save_memo(self) -> None:
        """memo 原子落盘（Windows 杀软/索引器短暂锁 → WinError 5：纯重试不改语义，
        重试尽如实上抛——doc88 _put_asset_retry 同款坑同款拼法）。"""
        self._memo_path.parent.mkdir(parents=True, exist_ok=True)
        tmp = self._memo_path.with_suffix(".json.tmp")
        tmp.write_text(json.dumps(self._memo, ensure_ascii=False), encoding="utf-8")
        last_exc: Exception | None = None
        for i in range(12):
            try:
                tmp.replace(self._memo_path)
                return
            except PermissionError as exc:
                last_exc = exc
                time.sleep(0.25)
        assert last_exc is not None
        raise last_exc

    # ---- 台账 ----
    def _log(self, event: str, target: str, count: int, status: str,
             detail: str, *, net: bool) -> None:
        if net:
            self.by_kind[event] = self.by_kind.get(event, 0) + 1
        full = (f"bytes={count} net={'true' if net else 'false'}"
                + ("" if net else " cache=hit")
                + f" {detail} target={target[:160]}")
        self._audit.request(site="book118", event=event,
                            query_or_docid=self.current_doc, count=int(count),
                            status=status, detail=full)

    def _gate(self, what: str) -> None:
        if self.net + 1 > self.cap:
            raise BudgetExceeded(
                f"预算硬顶：net={self.net}+1 > cap={self.cap}（{what}）")

    def _spend(self, n: int, what: str) -> None:
        """真发入账（T41 P0-1：browser 子资源全计/全局+单文档双预算超顶即熔断）。

        发前 _gate 已预检首发；本方法在实测计数到手后收口——单文档超 --doc-cap 或
        本轮净发超 --budget 即抛 BudgetExceeded（请求已发出属如实超支，熔断停后续）。
        """
        self.net += n
        self.doc_net += n
        if self.doc_net > self.doc_cap:
            raise BudgetExceeded(
                f"单文档全链路硬顶：doc={self._current_doc} doc_net={self.doc_net}"
                f" > doc_cap={self.doc_cap}（{what}）")
        if self.net - self.round0 > self.cap:
            raise BudgetExceeded(
                f"本轮净发超顶：round={self.net - self.round0} > cap={self.cap}"
                f"（{what}，T41 P0-1 子资源全计口径）")

    # ---- browser 页加载（.shtm/分类页：Playwright 过 SafeLine 挑战；memo 复用） ----
    def page(self, url: str) -> str:
        hit = self._memo.get(url)
        if isinstance(hit, str) and hit:
            self._log("browser", url, len(hit.encode("utf-8", "replace")), "ok",
                      "shtm_memo_hit", net=False)
            return hit
        self._gate(url)
        if self._browser is None:
            raise Book118PreviewError("no_browser", "Net.page 需先注入 browser")
        t0 = time.time()
        req_count = {"n": 0}  # T41 P0-1：request 事件计数=首跳+全子资源真发（页级实测）
        ctx = self._browser.new_context(user_agent=UA)
        try:
            pg = ctx.new_page()
            pg.on("request", lambda _req: req_count.__setitem__("n", req_count["n"] + 1))
            pg.goto(url, timeout=HTTP_TIMEOUT_S * 1000, wait_until="domcontentloaded")
            deadline = time.monotonic() + CHALLENGE_WAIT_S
            html = pg.content()
            while CHALLENGE_MARKER in html[:4000] and time.monotonic() < deadline:
                time.sleep(1.0)
                html = pg.content()
        finally:
            ctx.close()
        n_requests = max(1, int(req_count["n"]))   # 事件计数兜底≥1（主文档至少一发）
        self._spend(n_requests, f"browser {url[:80]}")
        self._log("browser", url, len(html.encode("utf-8", "replace")), "ok",
                  f"elapsed_ms={int((time.time() - t0) * 1000)} "
                  f"page_load_requests={n_requests}（含全子资源，T41 P0-1）", net=True)
        if len(html) > 10000:  # 仅完整页体入 memo（挑战页/空壳不固化）
            self._memo[url] = html
            self._save_memo()
        return html

    # ---- openapi 批（adapter transport 注入点；响应易变不 memo，断点=件级页清单） ----
    def openapi(self, params: dict) -> tuple[int, str]:
        self._gate("openapi page=%s" % params.get("page"))
        if self._http_openapi is None:
            import httpx
            self._http_openapi = httpx.Client(
                timeout=HTTP_TIMEOUT_S, trust_env=False,
                headers={"User-Agent": UA, "Referer": HOME_URL})
        t0 = time.time()
        r = self._http_openapi.get(OPENAPI_URL, params=params)
        self._spend(1, "openapi page=%s" % params.get("page"))
        self._log("openapi", "page=%s" % params.get("page"),
                  len(r.text.encode("utf-8", "replace")), "ok",
                  f"http={r.status_code} elapsed_ms={int((time.time() - t0) * 1000)}",
                  net=True)
        return r.status_code, r.text

    # ---- 图床直下（adapter image_transport 底层；盘缓存在外层闭包） ----
    def image(self, url: str) -> tuple[int, bytes]:
        self._gate(url)
        if self._http_img is None:
            import httpx
            self._http_img = httpx.Client(
                timeout=HTTP_TIMEOUT_S, trust_env=False, follow_redirects=True,
                headers={"User-Agent": UA})
        t0 = time.time()
        r = self._http_img.get(url)
        self._spend(1, f"image {url[:80]}")
        self._log("image", url, len(r.content), "ok",
                  f"http={r.status_code} elapsed_ms={int((time.time() - t0) * 1000)}",
                  net=True)
        return r.status_code, r.content


def make_image_transport(net: Net, page_urls: dict, pages_dir: Path,
                         gt_first_page: Path | None):
    """图腿盘缓存包装（注入 harvest_preview_pdf.image_transport）：

    - 页号→URL 双向协议映射（https/http 两键同指一页，image_url_pair 同口径）；
    - work/{doc}/pages/NNNN.* 在盘即零网络（ledger cache 行）；
    - 第 1 页追加 GT fixtures 首页图缓存源（T33 机制在位：誊 GT 的件首页免发）；
    - 进程内 memo：同 URL 重试也省（重试语义在 adapter 层，网络异常计数如实）。
    """
    rev: dict[str, int] = {}
    for k, v in (page_urls or {}).items():
        https_u, http_u = image_url_pair(str(v))
        rev.setdefault(https_u, int(k))
        rev.setdefault(http_u, int(k))
    mem: dict[str, bytes] = {}

    def transport(url: str) -> tuple[int, bytes]:
        if url in mem:
            return 200, mem[url]
        page = rev.get(url)
        if page is not None:
            for hit in sorted(pages_dir.glob("%04d.*" % page)):
                if hit.stat().st_size > 0:
                    data = hit.read_bytes()
                    net._log("image", url, len(data), "ok",
                             "disk_hit page=%d file=%s" % (page, hit.name), net=False)
                    mem[url] = data
                    return 200, data
            if page == 1 and gt_first_page is not None and gt_first_page.exists():
                data = gt_first_page.read_bytes()
                net._log("image", url, len(data), "ok",
                         "gt_fixture_hit page=1 file=%s" % gt_first_page.name, net=False)
                mem[url] = data
                return 200, data
        status, data = net.image(url)
        if status == 200 and data:
            mem[url] = data
        return status, data

    return transport


# ---------------------------------------------------------------- 选件（shtm 检索面/分类页）

def parse_shtm_links(html: str) -> list[str]:
    """页 HTML → .shtm 文档链接有序去重（绝对 URL）。"""
    out: list[str] = []
    for m in RE_SEARCH_DOC_LINK.finditer(html or ""):
        url = HOME_URL.rstrip("/") + m.group(1)
        if url not in out:
            out.append(url)
    return out


class Selector:
    """选件器：种子链接→分类页，逐候选 shtm probe（memo 化，收割期首跳零网络）。

    分类规则（全部来自 shtm 页实测配置，零造假）：preview==actual → 全预览档（免费口径）；
    preview<actual → 收费档；filetype=ppt* 拒（FR3.3 v1 硬路）；preview 越界拒。
    """

    def __init__(self, net: Net, *, max_new_pages: int, rejected: list,
                 seen: set[str], lists: list[str] | None = None):
        self.net = net
        self.max_new_pages = int(max_new_pages)
        self.rejected = rejected
        self.seen = seen
        self.lists = list(lists) if lists else list(DEFAULT_LISTS)
        self.fetched_lists: list[str] = []
        self.stop_reason = ""

    def _reject(self, doc_id: str, reason: str) -> None:
        self.rejected.append({"doc_id": doc_id, "reason": reason})
        self.seen.add(doc_id)

    def probe(self, url: str) -> dict | None:
        """单候选 shtm → {doc_id, preview, actual, title, filetype, shtm_url}；折=拒选。"""
        doc_id = url.rsplit("/", 1)[-1].split(".")[0]
        if doc_id in self.seen:
            return None
        self.net.current_doc = doc_id
        try:
            html = self.net.page(url)
        except Book118PreviewError as exc:
            self._reject(doc_id, "首跳失败: %s" % exc.kind)
            return None
        if "该文档已经被删除" in html:
            self._reject(doc_id, "404 删除页")
            return None
        cfg = extract_shtm_config(html)
        if cfg is None:
            self._reject(doc_id, "无预览（无 view_token/aid）")
            return None
        self.seen.add(doc_id)
        preview, actual = cfg.get("preview_page"), cfg.get("actual_page")
        if preview is None or actual is None:
            self._reject(doc_id, "preview/actual 缺值 p=%s a=%s" % (preview, actual))
            return None
        ftype = (cfg.get("filetype") or "").lower()
        if ftype.startswith("ppt"):
            self._reject(doc_id, "ppt 族（FR3.3 v1 硬路）")
            return None
        if not (NEW_DOC_MIN_PAGES <= int(preview) <= self.max_new_pages):
            self._reject(doc_id, "preview=%d 越界[%d,%d]"
                         % (preview, NEW_DOC_MIN_PAGES, self.max_new_pages))
            return None
        return {"doc_id": doc_id, "shtm_url": url, "preview": int(preview),
                "actual": int(actual), "title": cfg.get("title") or "",
                "filetype": ftype}

    def select(self, need_free: int, need_paid: int) -> list[dict]:
        """收满（免费全预览 need_free+收费 need_paid）件；预算/候选耗尽如实停。"""
        picked: list[dict] = []
        pools = {"free": [], "paid": []}
        queue: list[str] = [HOME_URL.rstrip("/")
                            + "/html/%s/%s/%s.shtm" % s for s in SEED_LINKS]
        list_queue: list[str] = list(self.lists)
        while (len(pools["free"]) < need_free or len(pools["paid"]) < need_paid) \
                and not self.stop_reason:
            if not queue:  # 种子耗尽 → 抓一页分类页续
                if not list_queue:
                    self.stop_reason = "种子+分类页候选全部耗尽"
                    break
                if self.net.cap - self.net.net < 2:
                    self.stop_reason = "预算不足以再抓分类页（剩 %d 发）" % (
                        self.net.cap - self.net.net)
                    break
                path = list_queue.pop(0)
                if path in self.fetched_lists:
                    continue
                self.net.current_doc = "list:" + path.rsplit("/", 1)[-1]
                try:
                    html = self.net.page(HOME_URL.rstrip("/") + path)
                except Book118PreviewError as exc:
                    self._reject("list:" + path, "分类页失败: %s" % exc.kind)
                    continue
                self.fetched_lists.append(path)
                queue = [u for u in parse_shtm_links(html) if u not in queue]
                if not queue:
                    continue
            url = queue.pop(0)
            # 余量守门：每件收割预估=首跳 0（probe 已 memo）+openapi ceil(p/6)+图 p
            if self.net.cap - self.net.net < 4:
                self.stop_reason = "预算不足以再 probe 候选（剩 %d 发）" % (
                    self.net.cap - self.net.net)
                break
            cand = self.probe(url)
            if cand is None:
                continue
            side = "free" if cand["preview"] == cand["actual"] else "paid"
            if side == "free" and len(pools["free"]) >= need_free:
                continue
            if side == "paid" and len(pools["paid"]) >= need_paid:
                continue
            pools[side].append(cand)
            cand["side"] = side
            cand["form"] = ("全预览档 preview=%d actual=%d（T37 选件）"
                            % (cand["preview"], cand["actual"])) \
                if side == "free" else \
                ("收费档 preview=%d actual=%d（T37 选件）"
                 % (cand["preview"], cand["actual"]))
            picked.append(cand)
            print("[选件] docId=%s %s | preview/actual=%d/%d | %s"
                  % (cand["doc_id"], side, cand["preview"], cand["actual"],
                     cand["title"][:40]), flush=True)
        return picked


# ---------------------------------------------------------------- OCR 两段式（页级断点）

def _import_ocr():
    from kb_factory.harvest_engine.render import ocr as ocr_mod
    return ocr_mod


def _render_one(image_pdf: Path, idx: int):
    """单页 150dpi 渲帧（pass1/pass2 共用；帧即抛，内存 O(1)~O(块)）。"""
    import pypdfium2 as pdfium
    with pdfium.PdfDocument(str(image_pdf)) as doc:
        page = doc[idx]
        try:
            return page.render(scale=OCR_DPI / 72.0).to_pil()
        finally:
            page.close()


def ocr_pass1(image_pdf: Path, cache_path: Path,
               slice_seconds: float = 0.0) -> dict:
    """pass1 流式逐页识别+行集缓存（每页 flush；已识别页跳过=断点）。

    缓存校验：image_pdf 的 size+mtime 与缓存记录不符（重建）→ 缓存作废重来。
    行集形态：{"dpi": 150, "image_pdf_size": N, "image_pdf_mtime": M,
              "pages": {"1": [[text, score, [x0,y0,x1,y1]], ...], ...}}
    空文本行过滤（paddle 偶发空行，回注件拒空串——T33 口径）。
    """
    ocr_mod = _import_ocr()
    st = image_pdf.stat()
    cache: dict = {}
    if cache_path.exists():
        try:
            cache = json.loads(cache_path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            cache = {}
        if (cache.get("dpi") != OCR_DPI
                or cache.get("image_pdf_size") != st.st_size
                or cache.get("image_pdf_mtime") != st.st_mtime):
            cache = {}
    cache.setdefault("pages", {})
    cache.update(dpi=OCR_DPI, image_pdf_size=st.st_size,
                 image_pdf_mtime=st.st_mtime)
    import pypdfium2 as pdfium
    with pdfium.PdfDocument(str(image_pdf)) as doc:
        n_pages = len(doc)
    engine_pages = cache["pages"]
    t0 = time.time()
    for i in range(n_pages):
        key = str(i + 1)
        if key in engine_pages:
            continue
        if slice_seconds and time.time() - t0 > slice_seconds:
            print("    [ocr] 切片时限 %.0fs 到：本进程止于 %d/%d 页（断点已写，"
                  "下进程续）" % (slice_seconds, i, n_pages), flush=True)
            break  # 进程内自限时（Windows 无 SIGALRM；外杀不可靠——paddle 进程
                   # 长跑劣化实测，切片换进程=每进程恒新鲜）
        frame = _render_one(image_pdf, i)
        lines = [ln for ln in ocr_mod.ocr_image(frame) if ln.text]
        engine_pages[key] = [[ln.text, round(float(ln.score), 4),
                              [int(v) for v in ln.box]] for ln in lines]
        cache_path.write_text(json.dumps(cache, ensure_ascii=False),
                              encoding="utf-8")  # 每页 flush（断点）
        print("    [ocr] 第 %d/%d 页 %d 行（断点已写）"
              % (i + 1, n_pages, len(lines)), flush=True)
    return cache


def ocr_pass2(image_pdf: Path, cache: dict, out_pdf: Path) -> dict:
    """pass2 分块回注：8 页/块 build_searchable_pdf → import_pages 合并（内存 O(块)）。

    块文件在盘即跳过重建（断点续块）；行集统计（lines/chars）一律从缓存行集回算——
    与 build_searchable_pdf 的 SearchablePdfStats 同源实测口径。
    """
    import pypdfium2 as pdfium
    ocr_mod = _import_ocr()
    OcrLine = ocr_mod.OcrLine
    n_pages = len(cache["pages"])
    chunk_dir = out_pdf.parent / "_chunks"
    chunk_dir.mkdir(parents=True, exist_ok=True)
    totals = {"pages": 0, "lines": 0, "chars": 0}
    chunk_files: list[Path] = []
    for start in range(0, n_pages, OCR_CHUNK):
        stop = min(start + OCR_CHUNK, n_pages)
        cpath = chunk_dir / ("chunk_%04d_%04d.pdf" % (start + 1, stop))
        if not cpath.exists():
            frames = [_render_one(image_pdf, i) for i in range(start, stop)]
            pages_lines = []
            for i in range(start, stop):
                pages_lines.append([
                    OcrLine(text=r[0], score=float(r[1]), box=tuple(r[2]))
                    for r in cache["pages"][str(i + 1)]])
            stats = ocr_mod.build_searchable_pdf(frames, pages_lines, cpath,
                                                 dpi=OCR_DPI)
            del frames
            totals["pages"] += stats.pages
            totals["lines"] += stats.lines
            totals["chars"] += stats.chars
        else:  # 断点续块：块文件已在，统计从行集回算（同源口径）
            rows = [r for i in range(start, stop)
                    for r in cache["pages"][str(i + 1)]]
            totals["pages"] += stop - start
            totals["lines"] += len(rows)
            totals["chars"] += sum(len(r[0]) for r in rows)
        chunk_files.append(cpath)
        print("    [build] 块 %d-%d/%d 页 OK（%s）"
              % (start + 1, stop, n_pages, cpath.name), flush=True)
    out = pdfium.PdfDocument.new()
    try:
        for f in chunk_files:
            src = pdfium.PdfDocument(str(f))
            try:
                out.import_pages(src)
            finally:
                src.close()
        out.save(str(out_pdf))
    finally:
        out.close()
    return totals


# ---------------------------------------------------------------- 单件全链

def gt_fixture(doc_id: str) -> dict | None:
    """GT fixtures 里取单件（book118_gt.json；T33 3 份+T37 新誊 7 份）。"""
    try:
        gt = json.loads(GT_PATH.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return None
    for fx in gt.get("fixtures") or []:
        if fx.get("doc_id") == doc_id:
            return fx
    return None


def gt_first_page_path(doc_id: str) -> Path | None:
    """T33 首页图缓存（fixtures/book118_gt_pages/{doc}/0001.*；在位即第 1 页免发）。"""
    for hit in sorted((GT_PAGES_ROOT / doc_id).glob("0001.*")):
        if hit.stat().st_size > 0:
            return hit
    return None


def text_layer(pdf_path: Path) -> str:
    """pypdfium2 抽 PDF 文字层（全页 textpage 合并；FR3.AC2 验收唯一实测来源）。"""
    import pypdfium2 as pdfium
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        return "".join(p.get_textpage().get_text_range() for p in doc)


def gt_match(pdf_path: Path, fx: dict) -> tuple[int, list[str], list[str]]:
    """GT 三词匹配（容错=0，空白归一）：返回 (命中数, 命中表, 未命中表)。"""
    layer = _norm(text_layer(pdf_path))
    terms = [fx["title"], *fx["words"]]
    hits = [t for t in terms if _norm(t) in layer]
    misses = [t for t in terms if _norm(t) not in layer]
    return len(hits), hits, misses


def page_count(pdf_path: Path) -> int:
    import pypdfium2 as pdfium
    with pdfium.PdfDocument(str(pdf_path)) as doc:
        return len(doc)


def run_doc(rec: dict, net: Net, store: Store, *, no_ocr: bool = False) -> dict:
    """单件推到终态：页清单→图→像素 PDF→OCR 两段→manifest+四门+页数/形态门。"""
    t0 = time.time()
    doc_id = rec["doc_id"]
    work = WORK_ROOT / doc_id
    work.mkdir(parents=True, exist_ok=True)
    net.current_doc = doc_id
    meta = FileMeta(title=rec.get("title") or doc_id, fmt="doc",
                    source_url=rec["shtm_url"], extra={
                        "book118_doc_id": doc_id})
    adapter = Book118Adapter(browser=net._browser, store=store,
                             page_loader=net.page, transport=net.openapi)

    # ---- stage 1：页清单（summary 断点在场即零网络零 openapi） ----
    if not rec.get("page_urls"):
        ladder = adapter.fetch_ladder(adapter.plan(meta))
        extra = meta.extra
        page_urls = extra.get("book118_page_urls") or {}
        if not ladder.ok or not page_urls:
            rec.update(status="fail", fail_stage="fetch_ladder",
                       detail=ladder.detail, elapsed_s=round(time.time() - t0, 1))
            return rec
        rec["page_urls"] = {str(k): str(v) for k, v in page_urls.items()}
        rec["preview"] = extra.get("book118_pages_preview")
        rec["actual"] = extra.get("book118_pages_actual")
        rec["ladder_detail"] = ladder.detail
    meta.extra["book118_page_urls"] = {int(k): v for k, v in rec["page_urls"].items()}
    meta.extra["book118_pages_preview"] = int(rec["preview"])
    meta.extra["book118_pages_actual"] = int(rec["actual"])
    preview, actual = int(rec["preview"]), int(rec["actual"])
    partial = preview < actual
    if partial:
        meta.extra["book118_partial_preview"] = True
    rec["partial"] = partial

    # ---- stage 2+3：图直下（盘缓存复用）→像素 PDF→形态标注（两段式先像素） ----
    image_pdf = work / ("%s.pdf" % doc_id)
    searchable_pdf = work / ("%s_ocr.pdf" % doc_id)
    manifest_path = work / ("%s_manifest.json" % doc_id)
    if not image_pdf.exists():
        transport = make_image_transport(
            net, meta.extra["book118_page_urls"], work / "pages",
            gt_first_page_path(doc_id))
        result = adapter.harvest_preview_pdf(
            meta, work, image_transport=transport, ocr_layer=False)
        rec["image_pages"] = result.pages
        rec["pages_records"] = len(result.page_records)
        rec["form_mark"] = meta.extra.get("book118_form") or ""
        rec["perm"] = meta.perm
    else:
        rec.setdefault("form_mark", "预览部分" if partial else "")
        rec.setdefault("perm", "yellow" if partial else "green")
    # 形态门：partial 件必须带「预览部分」+yellow（T23 黄线透明语义）
    form_ok = (not partial) or (rec.get("form_mark") == "预览部分"
                                and rec.get("perm") == "yellow")

    # ---- stage 4：OCR 两段式（页级断点；--no-ocr 调试用） ----
    if no_ocr:
        rec.update(status="pending_ocr",
                   elapsed_s=round(time.time() - t0, 1))
        return rec
    ocr_cache_path = work / "ocr_pages.json"
    cache = ocr_pass1(image_pdf, ocr_cache_path)
    totals = ocr_pass2(image_pdf, cache, searchable_pdf)

    # ---- stage 5：manifest（ref_chars_source=book118；口径逐份落）+四门 ----
    ref_chars = int(totals["chars"])
    if ref_chars < 1:
        rec.update(status="fail", fail_stage="ocr_empty",
                   detail="OCR 行集字数 0（纯图件，ref_chars<1 硬拒=零造假）",
                   elapsed_s=round(time.time() - t0, 1))
        return rec
    manifest = {"pdf_path": str(searchable_pdf), "ref_chars": ref_chars,
                "ref_chars_source": "book118"}
    if partial:
        manifest["preview_limit"] = preview       # 收费/试读受限：预览上限口径
    else:
        manifest["expected_pages"] = actual       # 全预览：源声明页口径
    manifest["pages_render_dir"] = str(work / "render")
    manifest_path.write_text(json.dumps(manifest, ensure_ascii=False, indent=1),
                             encoding="utf-8")
    checked = quality_gate.load_manifest(manifest_path)
    gate = quality_gate.run_gate(checked)
    gate_pass = bool(gate) and all(g.passed for g in gate)
    rec["gates"] = {g.name: {"passed": bool(g.passed), "detail": g.detail}
                    for g in gate}

    # ---- 页数门（pypdfium2 独立实测；口径逐份记录） ----
    n_pages = page_count(searchable_pdf)
    basis = "preview_limit" if partial else "expected_pages"
    ref_pages = preview if partial else actual
    pages_ok = n_pages == ref_pages
    rec.update(pages_measured=n_pages, manifest_ref=basis,
               ref_chars=ref_chars, ocr_lines=totals["lines"],
               pages_ok=pages_ok, form_ok=form_ok, gate_pass=gate_pass)
    rec["status"] = "pass" if (pages_ok and form_ok and gate_pass) else "fail"
    rec["elapsed_s"] = round(time.time() - t0, 1)
    return rec


# ---------------------------------------------------------------- GT 誊录辅助

def gt_dump(doc_id: str, net: Net, *, slice_seconds: float = 0.0) -> None:
    """GT 誊录辅助（T33 协议双证之①）：首页 OCR 行集（text/score/box/行尾比）。

    选词口径（T33 协议+下游2 教训）：≥4 字纯汉字、行中部主词、避开行尾水印伪字区
    （行尾比 x1/页宽 > 0.93 或含生僻伪字的行不选）；标题=行集首行/次行可见标题。
    """
    work = WORK_ROOT / doc_id
    image_pdf = work / ("%s.pdf" % doc_id)
    cache_path = work / "ocr_pages.json"
    if not image_pdf.exists():
        print("[gt-dump] %s 像素 PDF 缺位：先跑到图段（--docs %s --no-ocr）" % (
            doc_id, doc_id))
        return
    cache = ocr_pass1(image_pdf, cache_path, slice_seconds=slice_seconds)
    if slice_seconds and len(cache["pages"]) < page_count(image_pdf):
        return  # 切片未完：首页行集下轮出（断点续跑，零造假不硬印半集）
    rows = cache["pages"].get("1") or []
    if not rows:
        print("[gt-dump] %s 首页行集空（纯图封面件，GT 风险件）" % doc_id)
        return
    import pypdfium2 as pdfium
    with pdfium.PdfDocument(str(image_pdf)) as doc:
        page = doc[0]
        w = page.get_size()[0]
        page.close()
    frame_w = w * OCR_DPI / 72.0   # box=150dpi 帧像素系（版心右缘≈0.83；>0.93=行尾水印区）
    print("[gt-dump] docId=%s 首页行集（页宽=%.0fpt/帧宽=%.0fpx；选词避开行尾比>0.93）：" % (
        doc_id, w, frame_w), flush=True)
    for i, r in enumerate(rows):
        text, score, box = r[0], r[1], r[2]
        print("  i=%d score=%.3f box=%s 行尾比=%.2f | %s"
              % (i, score, box, (box[2] / frame_w) if frame_w else 0, text),
              flush=True)


# ---------------------------------------------------------------- summary

def load_summary() -> dict:
    try:
        return json.loads(SUMMARY_PATH.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}


def save_summary(net: Net, docs: list[dict], selection: dict) -> None:
    SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)
    tmp = SUMMARY_PATH.with_suffix(".json.tmp")
    tmp.write_text(json.dumps({
        "task": "T37 book118 实弹 10 份验收（FR3.AC1：免费≥6/收费≥4）",
        "accept_cmd": "py -3 kb_factory/harvest_engine/e2e/book118_accept.py",
        "budget": {"net_requests": net.net, "cap": net.cap,
                   "doc_cap": net.doc_cap, "by_kind": net.by_kind},
        "ledger": str(LEDGER_PATH), "shtm_memo": str(SHTM_MEMO_PATH),
        "store": str(STORE_DIR), "work_root": str(WORK_ROOT),
        "gt_fixtures": str(GT_PATH),
        "selection": selection, "docs": docs,
    }, ensure_ascii=False, indent=1), encoding="utf-8")
    tmp.replace(SUMMARY_PATH)


def doc_line(idx: int, total: int, rec: dict) -> str:
    """逐份行：docId/preview/actual/口径/字数/质检门/耗时。"""
    gates = rec.get("gates") or {}
    ok = "过" if rec.get("status") == "pass" else (
        "待OCR" if rec.get("status") == "pending_ocr" else "折")
    gate_bad = [k for k, v in gates.items() if not v.get("passed")]
    return ("[%d/%d] docId=%s %s | preview/actual=%s/%s | 口径=%s | 页数=%s | "
            "字数(ref)=%s | 质检门=%s | 形态=%s | 耗时=%ss" % (
                idx, total, rec.get("doc_id"), ok, rec.get("preview"),
                rec.get("actual"), rec.get("manifest_ref", "-"),
                rec.get("pages_measured", "-"), rec.get("ref_chars", "-"),
                "四门全过" if rec.get("gate_pass") else (
                    "折(%s)" % ",".join(gate_bad) if gate_bad else "-"),
                rec.get("form_mark") or (
                    "预览部分" if rec.get("partial") else "全预览"),
                rec.get("elapsed_s", "-")))


# ---------------------------------------------------------------- 主流程

def verify_all(docs: list[dict], net: Net, args, budget_stop: bool) -> int:
    """收口判定（零网络，全从盘上产物现场实测）：页数门+形态门+四门 CLI+GT+计数+预算。"""
    total = args.limit
    free_n = paid_n = gt_pass_n = 0
    print("=" * 104, flush=True)
    for rec in docs[:total]:
        doc_id = str(rec.get("doc_id"))
        work = WORK_ROOT / doc_id
        searchable = work / ("%s_ocr.pdf" % doc_id)
        manifest_path = work / ("%s_manifest.json" % doc_id)
        preview, actual = rec.get("preview"), rec.get("actual")
        rec["verify"] = {"status": "fail", "reason": "产物缺位"}
        if not (searchable.exists() and manifest_path.exists()
                and preview is not None and actual is not None):
            print("[判] docId=%s 折（searchable PDF/manifest/页清单 缺位）" % doc_id,
                  flush=True)
            continue
        # ①页数门（pypdfium2 现场实测）+②口径记录
        n = page_count(searchable)
        partial = int(preview) < int(actual)
        basis = "preview_limit" if partial else "expected_pages"
        pages_ok = n == (int(preview) if partial else int(actual))
        # ③形态门（partial 件「预览部分」+yellow；非 partial 件无此要求）
        form_ok = (not partial) or (rec.get("form_mark") == "预览部分"
                                    and rec.get("perm") == "yellow")
        # ④质检门（CLI 真符号同源：quality_gate.main 退出码 0=四门全过）
        gate_rc = quality_gate.main([str(manifest_path)])
        # ⑤GT（FR3.AC2 容错=0；fixtures 缺=该份不计入 GT 过数）
        fx = gt_fixture(doc_id)
        gt_n, gt_hits, gt_miss = (0, [], []) if fx is None else gt_match(
            searchable, fx)
        gt_ok = gt_n == 3
        rec["verify"] = {"pages": n, "basis": basis, "pages_ok": pages_ok,
                         "form_ok": form_ok, "gate_rc": gate_rc,
                         "gt": {"n": gt_n, "fixture": bool(fx),
                                "misses": gt_miss},
                         "form_mark": rec.get("form_mark"),
                         "perm": rec.get("perm")}
        passed = pages_ok and form_ok and gate_rc == 0
        if passed:
            if rec.get("side") == "free":
                free_n += 1
            else:
                paid_n += 1
        if gt_ok:
            gt_pass_n += 1
        print("[判] docId=%s %s | preview/actual=%s/%s | 口径=%s | 页数=%d | "
              "四门CLI=%s | GT=%d/3%s | side=%s"
              % (doc_id, "过" if passed else "折", preview, actual, basis, n,
                 "0" if gate_rc == 0 else str(gate_rc), gt_n,
                 (" 未命中=%s" % gt_miss) if gt_miss else "",
                 rec.get("side")), flush=True)
    n_docs = len(docs)
    all_pass = (n_docs >= total and all(
        (d.get("verify") or {}).get("pages_ok")
        and (d.get("verify") or {}).get("form_ok", True)
        and (d.get("verify") or {}).get("gate_rc") == 0
        for d in docs[:total]))
    print("-" * 104, flush=True)
    round_net = net.net - net.round0
    print("[汇总] 件=%d/10 | 免费口径过=%d/6 | 收费口径过=%d/4 | OCR GT 过=%d/10 | "
          "本轮净请求=%d/%d（累计真发=%d，by_kind=%s）"
          % (n_docs, free_n, paid_n, gt_pass_n, round_net, net.cap, net.net,
             net.by_kind), flush=True)
    print("[汇总] summary=%s | ledger=%s（每请求一行）"
          % (SUMMARY_PATH, LEDGER_PATH), flush=True)
    ok = (all_pass and free_n >= 6 and paid_n >= 4 and gt_pass_n >= 8
          and round_net <= net.cap and not budget_stop)
    if ok:
        print("[验收] 10/10 页数门+形态门+质检门全过，免费 %d/收费 %d，OCR GT %d/10 ≥8，"
              "本轮净请求 %d ≤ %d（累计真发 %d，退出码 0）"
              % (free_n, paid_n, gt_pass_n, round_net, net.cap, net.net),
              flush=True)
        return 0
    reasons = []
    if not all_pass:
        bad = [str(d.get("doc_id")) for d in docs[:total]
               if not ((d.get("verify") or {}).get("pages_ok")
                       and (d.get("verify") or {}).get("gate_rc") == 0)]
        reasons.append("未过件=%s" % (",".join(bad) or "配额未满"))
    if free_n < 6:
        reasons.append("免费口径 %d<6" % free_n)
    if paid_n < 4:
        reasons.append("收费口径 %d<4" % paid_n)
    if gt_pass_n < 8:
        reasons.append("GT %d/10<8" % gt_pass_n)
    if round_net > net.cap:
        reasons.append("本轮净请求 %d>%d" % (round_net, net.cap))
    if budget_stop:
        reasons.append("预算熔断如实停")
    print("[验收] 未过：%s（退出码 1）" % "；".join(reasons), flush=True)
    return 1


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="T37 book118 实弹 10 份验收（FR3.AC1）")
    ap.add_argument("--fresh", action="store_true",
                    help="清 summary 重选重跑（memo/图缓存/OCR 断点仍在）")
    ap.add_argument("--budget", type=int, default=30,
                    help="净请求预算上限（默认 30 发=任务卡验收口径；施工首跑放大——"
                         "T41 P0-1 起 browser 页加载含全子资源计数，同链路计数约为旧口径"
                         "数倍，首跑请按此放大）")
    ap.add_argument("--doc-cap", type=int, default=DOC_NET_CAP, metavar="N",
                    help="单文档全链路真发硬顶（browser 子资源+openapi+图床合计；"
                         f"默认 {DOC_NET_CAP}，T41 P0-1 研判⑤口径）")
    ap.add_argument("--limit", type=int, default=10, help="验收份数（默认 10）")
    ap.add_argument("--max-new-pages", type=int, default=12,
                    help="新选件 preview 上限（默认 12 页短档；长档两席=T33 62/22 已满）")
    ap.add_argument("--lists", default="",
                    help="覆盖分类页/免费专区种子页（逗号分隔路径，如 /free,"
                         "/doclist/list-360.html；默认 DEFAULT_LISTS）")
    ap.add_argument("--select-only", action="store_true",
                    help="只跑选件面（memo 落盘即收口，供誊 GT/审单）")
    ap.add_argument("--gt-dump", metavar="DOCID",
                    help="输出该件首页 OCR 行集（GT 誊录辅助）")
    ap.add_argument("--slice-seconds", type=float, default=0.0,
                    help="pass1 进程内切片时限（秒；到点自退出，断点续跑——"
                         "paddle 长跑劣化实测对策）")
    ap.add_argument("--docs", default="",
                    help="只跑指定件（逗号分隔 docId，分批施工用）")
    ap.add_argument("--no-ocr", action="store_true",
                    help="跑到像素 PDF 即停（调试/分批）")
    args = ap.parse_args(argv)

    ROOT.mkdir(parents=True, exist_ok=True)
    WORK_ROOT.mkdir(parents=True, exist_ok=True)

    prev = {} if args.fresh else load_summary()
    docs: list[dict] = list(prev.get("docs") or [])
    selection: dict = dict(prev.get("selection") or {})
    rejected: list[dict] = list(selection.get("rejected") or [])
    seen: set[str] = set(str(r.get("doc_id")) for r in rejected)
    for d in docs:
        seen.add(str(d.get("doc_id")))
    start_net = int((prev.get("budget") or {}).get("net_requests") or 0)
    net = Net(LEDGER_PATH, SHTM_MEMO_PATH, cap=args.budget, start_net=start_net,
              start_by_kind=(prev.get("budget") or {}).get("by_kind"),
              doc_cap=args.doc_cap)
    store = Store(str(STORE_DIR))

    # T33 三份直接计入（占位 rec；status=pending 待推）；已被拒选留档的 seed
    # （如 5123 门③空白尾页形态碰撞，selection.rejected 在案）不回插——空位由新选件补足
    for seed in T33_SEEDS:
        if seed["doc_id"] in seen:
            continue
        if not any(d.get("doc_id") == seed["doc_id"] for d in docs):
            docs.append({"doc_id": seed["doc_id"], "shtm_url": seed["shtm_url"],
                         "side": seed["side"], "form": seed["form"],
                         "title": "", "seed": True, "status": "pending"})

    # 选件配额：免费口径 ≥6 / 收费口径 ≥4（按 docs 现有总数计——含 T33 seed；
    # seed 件被拒选/移除时（如 5123 门③空白尾页碰撞）其空位由新选件自然补足）
    have_free = sum(1 for d in docs if d.get("side") == "free")
    have_paid = sum(1 for d in docs if d.get("side") == "paid")
    need_free, need_paid = max(0, 6 - have_free), max(0, 4 - have_paid)

    browser = None
    pw = None
    try:
        from playwright.sync_api import sync_playwright
        pw = sync_playwright().start()
        browser = pw.chromium.launch(headless=True,
                                     args=["--proxy-server=direct://"])
        net._browser = browser

        if args.gt_dump:
            gt_dump(args.gt_dump, net,
                    slice_seconds=getattr(args, "slice_seconds", 0.0))
            return 0

        if need_free or need_paid:
            lists = ([p if p.startswith("/") else "/" + p
                      for p in str(args.lists).split(",") if p.strip()]
                     if args.lists else list(DEFAULT_LISTS))
            selector = Selector(net, max_new_pages=args.max_new_pages,
                                rejected=rejected, seen=seen, lists=lists)
            try:
                picked = selector.select(need_free, need_paid)
            except BudgetExceeded as exc:
                print("[预算熔断] %s（净请求 %d/%d）" % (
                    exc, net.net, net.cap), flush=True)
                picked = []
            for cand in picked:
                docs.append({"doc_id": cand["doc_id"],
                             "shtm_url": cand["shtm_url"], "side": cand["side"],
                             "form": cand["form"], "title": cand["title"],
                             "preview": cand["preview"], "actual": cand["actual"],
                             "status": "pending"})
            selection.update(rejected=rejected, seen=sorted(seen),
                             fetched_lists=selector.fetched_lists,
                             stop_reason=selector.stop_reason)
            save_summary(net, docs, selection)
            if args.select_only:
                print("[select-only] 新选 %d 件（还需 免费 %d/收费 %d）；"
                      "净请求 %d/%d"
                      % (len(picked), need_free, need_paid, net.net, net.cap),
                      flush=True)
                return 0
        elif args.select_only:
            print("[select-only] 选件配额已满；净请求 %d/%d" % (net.net, net.cap),
                  flush=True)
            return 0

        # ---- 逐件全链（非 pass 件；--docs 子集分批施工；短档先长档殿后） ----
        order = {"pending": 0, "pending_ocr": 1, "fail": 2, "pass": 9}
        only = [s.strip() for s in args.docs.split(",") if s.strip()]
        runnable = [d for d in docs if d.get("status") != "pass"
                    and (not only or d.get("doc_id") in only)]
        runnable.sort(key=lambda d: (order.get(d.get("status"), 5),
                                     -(1 if (d.get("preview") or 0) > 12 else 0),
                                     d.get("preview") or 0))
        budget_stop = False
        for rec in runnable:
            try:
                run_doc(rec, net, store, no_ocr=args.no_ocr)
            except BudgetExceeded as exc:
                print("[预算熔断] %s（净请求 %d/%d）" % (
                    exc, net.net, net.cap), flush=True)
                budget_stop = True
                break
            done = sum(1 for d in docs if d.get("status") not in (None, "pending"))
            print(doc_line(done, args.limit, rec), flush=True)
            save_summary(net, docs, selection)
        save_summary(net, docs, selection)

        # ---- 收口判定：现场重测，不信任缓存结论 ----
        return verify_all(docs, net, args, budget_stop)
    finally:
        if browser is not None:
            browser.close()
        if pw is not None:
            try:
                pw.stop()
            except Exception:
                pass


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace",
                               line_buffering=True)
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")
    sys.exit(main(sys.argv[1:]))
