# -*- coding: utf-8 -*-
"""T42 验收件：E2E 端到端 1 单全链 + 单站故障韧性（FR9.AC1 + NFR5）——发布门前最后一验。

验收口径（任务卡）：
- FR9.AC1：端到端 1 单全链（蓝图→交付）实弹全过——≥2 站订单项（book118+doc88，
  wenku verify 段4 未实装=qc_fail 隔离口径（T40 下游3），本次不接 wenku 槽位：
  default_adapters 注册在案、订单不派槽，如实记录），产物过质检门 + 镜像树 +
  交付链回执（BuildResult：树+manifest+zip 落盘断言；deliver/SMTP 不在射程）；
- NFR5：kill 一个适配器进程故障注入——3 站订单（doc88+book118+csdn 拒入站）执行中
  ``taskkill /T /F`` 真杀 doc88 适配器子进程（FFDec JVM/presse，T37 教训：bash
  timeout 杀不净 Windows 树，必用 taskkill /T /F；ProcessLookupError 注入形态仅作
  备胎不启用），断言同单 book118 订单项照常完成 + 镜像树含 book118 产物 +
  doc88 项如实 failed（ladder 腿折如实入账）+ csdn 槽位 not_routable（W8 拒入）；
- progress_events 事件序断言：order_start → plan → collect_start/collect_done →
  browser_close → dispatch_start/dispatch_done → qc → mirror → chain → order_done
  全序（引擎槽位逐槽单调；NFR5 单断言 book118 qc 在 doc88 折腿之后=事后完成实证）；
- 汇总 JSON + 台账（harvest_audit.jsonl）+ 事件件（progress_events.jsonl）落
  artifacts/full_chain/；退出码 0 = 全过。

装配口径（施工要点①③的如实落法）：
- 入口 = ``Orchestrator(default_adapters(), audit=…, progress=…)``——registry_fn
  缺省=真 sources_registry 实判（red_check 双检查点吃真注册表：wenku 双闸 OFF 等
  状态如实入账；book118/doc88 不在注册表键内=引擎渠道放行）；W8 准入另以
  「csdn 键+已过验收适配器实身注册 → ValueError」实判（CsdnAdapter 实身构造需
  BrowserKit 点击流件，不入本验射程，如实注记）；
- book118/doc88 两站自 default_adapters() 基座换装为**同真类实身**（断点台账/
  工作区注入）：doc88=Doc88DownloadAdapter(store=T39 Store 复用+T39 配置 memo
  只读复用)——41271313373639（4 页/1 层，Store PH+4PK 全在）零网络；book118=
  7062125153011162（2/2 全预览短档，T37 shtm memo+页图盘缓存在位）首跳零网络+
  openapi 批真发（响应易变不 memo，T37 口径）+图床盘缓存零网络；
- **book118 单段全链位形**：orchestrator 单段契约要求 fetch_ladder 吐终态产物
  （mirror_phase 吃 artifact_path），而 Book118Adapter.fetch_ladder 本体只产预览页
  清单（T19 口径，artifact_path=None 如实）、PDF 腿=T23 ``harvest_preview_pdf``
  独立真方法——本件在 E2E 装配层以子类串联两真腿（fetch_ladder=真页清单腿→真
  T23 图床拼 PDF+OCR 四门腿；verify=verify_pdf 真门），适配器/编排器本体零改动，
  如实记录为装配层接线（非 mock：全程真方法真产物真质检门）。

命令：py -3 kb_factory/harvest_engine/e2e/full_chain_accept.py
退出码 0 = FR9.AC1 端到端全链实弹全过 且 NFR5 故障注入韧性断言全过；
KB_HARVEST_SKIP_LIVE=1 时实弹用例跳过并明示（CI 场景，公约第4条）。
"""
from __future__ import annotations

import json
import os
import shutil
import subprocess
import sys
import threading
import time
from pathlib import Path

_E2E_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(_E2E_DIR.parents[2]))  # 仓库根（kb_factory 包导入）

from kb_factory.harvest_engine.adapters.base import LadderResult  # noqa: E402
from kb_factory.harvest_engine.adapters.book118 import (  # noqa: E402
    CHALLENGE_MARKER, CHALLENGE_WAIT_S, HOME_URL, HTTP_TIMEOUT_S, OPENAPI_URL,
    Book118Adapter, image_url_pair)
from kb_factory.harvest_engine.adapters.csdn import CsdnAdapter  # noqa: E402
from kb_factory.harvest_engine.adapters.doc88 import (  # noqa: E402
    Doc88DownloadAdapter, _curl_cffi_get, _curl_cffi_get_bytes)
from kb_factory.harvest_engine.audit import HarvestAudit  # noqa: E402
from kb_factory.harvest_engine.orchestrator import (  # noqa: E402
    ACCEPTED_SITES, FAILED_STATUSES, GUIDE_STATUSES, HarvestBudget, HarvestOrder,
    Orchestrator, STATUS_DELIVERED, STATUS_FAILED, STATUS_NOT_ROUTABLE,
    STATUS_PARTIAL, default_adapters)
from kb_factory.harvest_engine.progress_events import ProgressEvents  # noqa: E402
from kb_factory.harvest_engine.store.ledger import Store  # noqa: E402
from kb_factory.harvest_engine.tools.fetch_toolchain import (  # noqa: E402
    ToolchainError, default_toolchain_root, locate_ffdec, locate_java, locate_presse)

ARTIFACTS = _E2E_DIR / "artifacts" / "full_chain"
SUMMARY_PATH = ARTIFACTS / "full_chain_summary.json"

#: T37/T39 验收件产物位（缓存件复用的事实源：标题/URL/页数一律从汇总实测值取，零手填）
T37_ROOT = _E2E_DIR / "artifacts" / "book118"
T37_SUMMARY = T37_ROOT / "book118_accept_summary.json"
T37_SHTM_MEMO = T37_ROOT / "book118_shtm_memo.json"
T37_STORE_DIR = T37_ROOT / "book118_store"
T39_ROOT = _E2E_DIR / "artifacts"
T39_SUMMARY = T39_ROOT / "doc88_accept_summary.json"
T39_MEMO = T39_ROOT / "doc88_fetch_memo.json"
T39_STORE_DIR = T39_ROOT / "doc88_store"

BOOK118_DOC_ID = "7062125153011162"   # 2/2 全预览短档（T37 pass 件，shtm memo+页图缓存全在位）
DOC88_P_CODE = "41271313373639"       # 4 页/1 层（T39 pass 件，Store PH+4PK 全在位）

BUYER_EMAIL = "buyer@demo-buyer.cn"   # 非 RFC2606 保留域（deliver 硬护栏口径同 W7 测试）
BUDGET_REQUESTS = 12                  # 编排层腿预算（每槽每梯队级 1；宽松硬顶，真净发另计台账）


# ---------------------------------------------------------------- 事实装载（零手填）

def _read_json(path: Path, default=None):
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {} if default is None else default


def load_site_facts() -> dict:
    """从 T37/T39 汇总实测值取两站订单件事实（标题/URL/页数；缺位如实炸）。"""
    b = _read_json(T37_SUMMARY)
    d = _read_json(T39_SUMMARY)
    b_doc = next((x for x in b.get("docs") or []
                  if x.get("doc_id") == BOOK118_DOC_ID), None)
    d_doc = next((x for x in d.get("docs") or []
                  if x.get("p_code") == DOC88_P_CODE), None)
    if not b_doc or b_doc.get("status") != "pass":
        raise SystemExit(f"[事实] T37 汇总缺 {BOOK118_DOC_ID} pass 件（先跑 book118_accept）")
    if not d_doc or d_doc.get("status") != "pass":
        raise SystemExit(f"[事实] T39 汇总缺 {DOC88_P_CODE} pass 件（先跑 doc88_accept）")
    return {
        "book118": {"doc_id": b_doc["doc_id"], "title": str(b_doc.get("title") or ""),
                    "shtm_url": str(b_doc.get("shtm_url") or ""),
                    "preview": int(b_doc["preview"]), "actual": int(b_doc["actual"]),
                    "pages_cached": len(b_doc.get("page_urls") or {})},
        "doc88": {"p_code": d_doc["p_code"], "title": str(d_doc.get("p_name") or ""),
                  "pages": int(d_doc["pages"]), "levels": int(d_doc.get("levels") or 0)},
    }


# ---------------------------------------------------------------- 蓝图（真蓝图槽位）

def _slot(name: str, title: str, *, path: str, site: str, doc_id: str,
          source_url: str, pages: int, badge: str = "green_free",
          perm: str = "green") -> dict:
    """蓝图槽位 dict（编目层形态；site 显式路由引擎站，badge/perm 驱动交付侧绿源匹配）。"""
    return {"name": name, "title": title, "ext": "pdf", "path": path,
            "tier": "core", "badge": badge, "perm": perm, "site": site,
            "pages": pages, "doc_id": doc_id, "source_url": source_url,
            "identifier": "T-" + name.rsplit(".", 1)[0], "checksum_slot": None}


def build_blueprint(facts: dict, *, with_csdn: bool, root: str) -> Path:
    """蓝图 JSON（pipeline.run 真消费的树形态；槽位自带引擎路由事实）。"""
    b, d = facts["book118"], facts["doc88"]
    l2 = [
        {"code": "E2E-01/01", "dir": "01", "path": "E2E-01/01/", "name": "book118 收割组",
         "theme": "book118 收割组：全预览短档实测件", "file_count": 1, "files": [
             _slot("收割组_core_001.pdf", b["title"], path="E2E-01/01/", site="book118",
                   doc_id=b["doc_id"], source_url=b["shtm_url"], pages=b["preview"])]},
        {"code": "E2E-01/02", "dir": "02", "path": "E2E-01/02/", "name": "doc88 收割组",
         "theme": "doc88 收割组：4 页小件实测件", "file_count": 1, "files": [
             _slot("收割组_core_002.pdf", d["title"], path="E2E-01/02/", site="doc88",
                   doc_id=d["p_code"], source_url=f"https://www.doc88.com/p-{d['p_code']}.html",
                   pages=d["pages"])]},
    ]
    if with_csdn:  # NFR5 第三站：W8 未过验收站=引擎层不路由（not_routable 归交付层，零网络）
        l2.append({"code": "E2E-01/03", "dir": "03", "path": "E2E-01/03/", "name": "csdn 拒入站组",
                   "theme": "csdn 拒入站组：W8 准入门外（计划在案、引擎不路由）",
                   "file_count": 1, "files": [
                       _slot("拒入站组_core_001.pdf", "csdn 拒入站占位（非交付件）",
                             path="E2E-01/03/", site="csdn", doc_id="csdn-e2e",
                             source_url="https://blog.csdn.net/e2e_not_routable.html", pages=1)]})
    bp = {
        "domain": "端到端验收",
        "need": {"domain": "端到端验收", "keywords": ["收割", "端到端"],
                 "intent": "e2e", "size_hint": "small"},
        "tree": {"mode": "harvest_e2e", "root": root, "l1": [{
            "code": "E2E", "dir": "E2E-01", "path": "E2E-01/", "name": "收割交付库",
            "theme": "收割交付库：KB-HARVEST 端到端实测", "source": "kb-harvest-e2e",
            "l2": l2}]},
        "stats": {"files": sum(x["file_count"] for x in l2)},
    }
    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    path = ARTIFACTS / ("blueprint_nfr5.json" if with_csdn else "blueprint_e2e.json")
    path.write_text(json.dumps(bp, ensure_ascii=False, indent=1), encoding="utf-8")
    return path


def flatten_slots(bp_path: Path) -> list:
    """蓝图树 → HarvestOrder.blueprint_slots 平铺（编目层事实原样传入）。"""
    bp = _read_json(bp_path)
    return [dict(s) for l1 in bp["tree"]["l1"] for l2 in l1["l2"] for s in l2["files"]]


# ---------------------------------------------------------------- 真网络计数/断点复用件

class RunNet:
    """run 级真网络腿计数+台账（委托真符号非 mock；缓存命中=零净发、台账如实记 cache 行）。"""

    def __init__(self, audit: HarvestAudit, *, doc_memo: dict | None = None):
        self.net = 0
        self.by_kind: dict[str, int] = {}
        self._audit = audit
        self._doc_memo = doc_memo or {}
        self.current_doc = "-"

    def _log(self, kind: str, target: str, n: int, status: str, detail: str, *,
             net: bool) -> None:
        if net:
            self.net += 1
            self.by_kind[kind] = self.by_kind.get(kind, 0) + 1
        self._audit.request(
            site="e2e_net", event=kind, query_or_docid=self.current_doc,
            count=int(n), status=status,
            detail=(f"net={'true' if net else 'false'}"
                    + ("" if net else " cache=hit") + f" {detail} target={target[:160]}"))

    # ---- doc88 配置面文本腿（T39 memo 只读复用；miss=真 curl_cffi 发） ----
    def doc88_text(self, url: str, timeout: float) -> tuple[int, str]:
        hit = self._doc_memo.get(url)
        if hit is not None:
            body = str(hit[1])
            self._log("doc88_text", url, len(body.encode("utf-8", "replace")),
                      "ok" if int(hit[0]) == 200 else "fail",
                      f"http={hit[0]} memo=T39", net=False)
            return int(hit[0]), body
        t0 = time.time()
        status, body = _curl_cffi_get(url, timeout)
        self._log("doc88_text", url, len(body.encode("utf-8", "replace")),
                  "ok" if status == 200 else "fail",
                  f"http={status} elapsed_ms={int((time.time() - t0) * 1000)}", net=True)
        return status, body

    def doc88_bytes(self, url: str, timeout: float) -> tuple[int, bytes]:
        t0 = time.time()
        status, data = _curl_cffi_get_bytes(url, timeout)
        self._log("doc88_bytes", url, len(data), "ok" if status == 200 else "fail",
                  f"http={status} elapsed_ms={int((time.time() - t0) * 1000)}", net=True)
        return status, data

    # ---- book118 openapi 批（真 httpx；响应易变不 memo=T37 口径） ----
    def book118_openapi(self, params: dict) -> tuple[int, str]:
        import httpx
        t0 = time.time()
        with httpx.Client(timeout=HTTP_TIMEOUT_S, trust_env=False, headers={
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                              "AppleWebKit/537.36 (KHTML, like Gecko) "
                              "Chrome/139.0.0.0 Safari/537.36",
                "Referer": HOME_URL}) as client:
            r = client.get(OPENAPI_URL, params=params)
        self._log("book118_openapi", f"page={params.get('page')}",
                  len(r.text.encode("utf-8", "replace")),
                  "ok" if r.status_code == 200 else "fail",
                  f"http={r.status_code} elapsed_ms={int((time.time() - t0) * 1000)}",
                  net=True)
        return r.status_code, r.text

    # ---- book118 图床直下（真 httpx；盘缓存在外层闭包） ----
    def book118_image(self, url: str) -> tuple[int, bytes]:
        import httpx
        t0 = time.time()
        with httpx.Client(timeout=HTTP_TIMEOUT_S, trust_env=False, follow_redirects=True,
                          headers={"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                                                 "AppleWebKit/537.36 (KHTML, like Gecko) "
                                                 "Chrome/139.0.0.0 Safari/537.36"}) as client:
            r = client.get(url)
        self._log("book118_image", url, len(r.content),
                  "ok" if r.status_code == 200 else "fail",
                  f"http={r.status_code} elapsed_ms={int((time.time() - t0) * 1000)}",
                  net=True)
        return r.status_code, r.content


class BrowserHolder:
    """Playwright 浏览器惰性持有（book118 首跳 fallback 用；memo 命中则永不启动）。"""

    def __init__(self):
        self._pw = None
        self.browser = None

    def get(self):
        if self.browser is None:
            from playwright.sync_api import sync_playwright
            self._pw = sync_playwright().start()
            self.browser = self._pw.chromium.launch(headless=True,
                                                    args=["--proxy-server=direct://"])
        return self.browser

    def close(self):
        if self.browser is not None:
            try:
                self.browser.close()
            finally:
                self.browser = None
        if self._pw is not None:
            try:
                self._pw.stop()
            except Exception:
                pass
            self._pw = None


def make_book118_page_loader(net: RunNet, shtm_memo: dict,
                             holder: BrowserHolder):
    """.shtm 首跳注入点①：T37 shtm memo 命中=零网络；miss=真 Playwright 过 SafeLine。"""

    def load(url: str) -> str:
        hit = shtm_memo.get(url)
        if isinstance(hit, str) and hit:
            net._log("book118_browser", url, len(hit.encode("utf-8", "replace")),
                     "ok", "shtm_memo_hit memo=T37", net=False)
            return hit
        browser = holder.get()
        t0 = time.time()
        ctx = browser.new_context(user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                                             "AppleWebKit/537.36 (KHTML, like Gecko) "
                                             "Chrome/139.0.0.0 Safari/537.36")
        try:
            pg = ctx.new_page()
            pg.goto(url, timeout=HTTP_TIMEOUT_S * 1000, wait_until="domcontentloaded")
            deadline = time.monotonic() + CHALLENGE_WAIT_S
            html = pg.content()
            while CHALLENGE_MARKER in html[:4000] and time.monotonic() < deadline:
                time.sleep(1.0)
                html = pg.content()
        finally:
            ctx.close()
        net._log("book118_browser", url, len(html.encode("utf-8", "replace")), "ok",
                 f"elapsed_ms={int((time.time() - t0) * 1000)}", net=True)
        return html

    return load


def make_book118_image_transport(net: RunNet, page_urls: dict, pages_dir: Path):
    """图床 HTTP 层注入点③：页图盘缓存（run 自有目录，种子=T37 验收产物）命中零网络。"""
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
                    net._log("book118_image", url, len(data), "ok",
                             f"disk_hit page={page} file={hit.name} seed=T37", net=False)
                    mem[url] = data
                    return 200, data
        status, data = net.book118_image(url)
        if status == 200 and data:
            mem[url] = data
        return status, data

    return transport


# ---------------------------------------------------------------- book118 单段全链装配

class Book118ChainAdapter(Book118Adapter):
    """book118 单段全链实身（E2E 装配层接线，适配器本体零改动）：

    fetch_ladder = 真页清单腿（T19）→ 真 T23 图床拼 PDF+OCR 四门腿
    （harvest_preview_pdf）；verify = verify_pdf 真门（四门 gate_outcomes +
    实测页数==页清单页数）。两腿全为 Book118Adapter 自有真方法，非 mock。
    """

    def __init__(self, *, store: Store, work_dir: Path, page_loader, transport,
                 net: RunNet):
        super().__init__(store=store, page_loader=page_loader, transport=transport,
                         audit=net._audit)
        self._chain_work = Path(work_dir)
        self._chain_net = net
        self._chain_work.mkdir(parents=True, exist_ok=True)
        self.last_pdf_result = None

    def fetch_ladder(self, plan):
        base = super().fetch_ladder(plan)          # 真腿①：预览页清单（openapi 真发）
        meta = plan.meta
        if not base.ok or not meta.extra.get("book118_page_urls"):
            return base
        doc_id = str(meta.extra.get("book118_doc_id") or "")
        work = self._chain_work / (doc_id or "book118")
        work.mkdir(parents=True, exist_ok=True)
        # 种子页图（T37 验收产物断点复用：work/pages 在盘即零网络）
        seed = T37_ROOT / "work" / doc_id / "pages"
        if seed.is_dir():
            shutil.copytree(seed, work / "pages", dirs_exist_ok=True)
        self._chain_net.current_doc = doc_id
        transport = make_book118_image_transport(
            self._chain_net, meta.extra["book118_page_urls"], work / "pages")
        try:                                        # 真腿②：T23 图床拼 PDF+OCR+四门
            pdf = self.harvest_preview_pdf(meta, work, image_transport=transport,
                                           ocr_layer=True)
        except Exception as exc:  # 腿折如实入 LadderResult（不裸抛编排层）
            return LadderResult(
                ok=False, pages=base.pages, coverage=base.coverage,
                detail=f"book118 全链 T23 腿折 {type(exc).__name__}: {exc}")
        self.last_pdf_result = pdf
        preview, actual = (meta.extra.get("book118_pages_preview"),
                           meta.extra.get("book118_pages_actual"))
        coverage = f"{pdf.pages}/{pdf.pages}" if not (
            preview is not None and actual is not None and int(preview) < int(actual)) \
            else f"{preview}/{actual}"
        return LadderResult(
            ok=True, ladder_used="L1",
            artifact_path=str(pdf.searchable_pdf or pdf.image_pdf),
            pages=pdf.pages, chars=pdf.ref_chars, coverage=coverage,
            detail=(f"book118 单段全链（T19 页清单→T23 拼PDF+OCR 四门）：doc={doc_id} "
                    f"pages={pdf.pages} ref_chars={pdf.ref_chars} "
                    f"gate={'四门全过' if all(g.passed for g in pdf.gate_outcomes) else '折'}"
                    f"；{base.detail}"))

    def verify(self, result) -> bool:
        if self.last_pdf_result is not None and result.artifact_path:
            return self.verify_pdf(self.last_pdf_result)   # T23 真门（四门+页数）
        return super().verify(result)                      # 页清单门（T19 口径）


# ---------------------------------------------------------------- NFR5 kill 注入件

class AdapterChildKiller(threading.Thread):
    """doc88 适配器子进程真杀器：轮询本进程直接子进程，首见 FFDec JVM/presse 即
    ``taskkill /T /F``（T37 教训：树杀必 /T /F）；一次性，杀后自停。"""

    POLL_S = 0.1

    def __init__(self, deadline_s: float = 420.0):
        super().__init__(daemon=True, name="t42-nfr5-killer")
        self.deadline = time.monotonic() + float(deadline_s)
        self.killed: dict | None = None
        self.candidates: list = []
        self._stop = threading.Event()

    def _match(self, proc) -> str | None:
        try:
            name = (proc.name() or "").lower()
            cmd = " ".join(proc.cmdline()).lower()
        except Exception:  # 进程已退/权限拒绝：如实跳过
            return None
        if name == "java.exe" and "ffdec" in cmd:
            return "java.exe(ffdec)"
        if name.endswith("presse.exe"):
            return "presse.exe"
        return None

    def run(self):
        import psutil
        me = psutil.Process(os.getpid())
        while not self._stop.is_set() and time.monotonic() < self.deadline:
            try:
                kids = me.children(recursive=False)
            except Exception:
                return
            for proc in kids:
                what = self._match(proc)
                if what is None:
                    continue
                self.candidates.append({"pid": proc.pid, "what": what})
                r = subprocess.run(["taskkill", "/T", "/F", "/PID", str(proc.pid)],
                                   capture_output=True, text=True)
                self.killed = {
                    "pid": proc.pid, "target": what, "rc": r.returncode,
                    "cmd": f"taskkill /T /F /PID {proc.pid}",
                    "out": ((r.stdout or "") + (r.stderr or "")).strip()[:160],
                    "ts": time.strftime("%Y-%m-%dT%H:%M:%S")}
                self._stop.set()
                return
            time.sleep(self.POLL_S)

    def stop(self):
        self._stop.set()


# ---------------------------------------------------------------- 事件序断言（⑥）

_ENGINE_SEQ_OK = ["plan", "collect_start", "collect_done", "dispatch_start",
                  "dispatch_done", "qc"]
_ENGINE_SEQ_FAIL = ["plan", "collect_start"]


def rows_of_current_run(rows: list) -> list:
    """取本 run 事件段（事件件 append 模式跨 run 累积：末个 order_start 起切片）。"""
    starts = [i for i, r in enumerate(rows) if r.get("event") == "order_start"]
    return rows[starts[-1]:] if starts else rows


def check_event_sequence(rows: list, engine_ok: list, engine_fail: list,
                         not_routable: list, *, with_chain: bool,
                         problems: list) -> dict:
    """事件件全序断言：order_start 首行/order_done 末行 + 阶段序 + 逐槽单调。

    返回索引证据（验收记录用）；问题写 problems（不抛异常，收口统一判）。
    """
    ev: dict = {"rows": len(rows), "checks": {}}

    def fail(msg):
        problems.append(f"[events] {msg}")

    if not rows:
        fail("事件件空")
        return ev
    if rows[0]["event"] != "order_start":
        fail(f"首事件={rows[0]['event']!r}≠order_start")
    if rows[-1]["event"] != "order_done":
        fail(f"末事件={rows[-1]['event']!r}≠order_done")
    # 阶段序（order 级事件按首次出现位置单调）
    order_rows = [(r["event"], i) for i, r in enumerate(rows)
                  if r["slot"] == "" and r["site"] in ("order", "fulfillment")]
    names = [e for e, _ in order_rows]
    core = ["order_start", "browser_close", "mirror"] \
        + (["chain"] if with_chain else []) + ["order_done"]
    for n in core:
        if n not in names:
            fail(f"order 级缺事件 {n}（实有 {names}）")
    pos = {n: names.index(n) for n in core if n in names}
    seq = [pos[n] for n in core if n in pos]
    if seq != sorted(seq):
        fail(f"阶段序乱：{[(n, pos[n]) for n in core if n in pos]}")
    ev["phase_pos"] = pos
    bc_idx = next((i for i, r in enumerate(rows) if r["event"] == "browser_close"), None)

    def slot_events(slot: str) -> list:
        return [(r["event"], i) for i, r in enumerate(rows) if r["slot"] == slot]

    for slot in engine_ok:
        evs = slot_events(slot)
        events = [e for e, _ in evs]
        for want in _ENGINE_SEQ_OK:
            if want not in events:
                fail(f"槽位 {slot} 缺事件 {want}（实有 {events}）")
        idxs = [next(i for e, i in evs if e == w) for w in _ENGINE_SEQ_OK
                if w in events]
        if idxs != sorted(idxs):
            fail(f"槽位 {slot} 事件序乱：{events}")
        if bc_idx is not None:  # 两段式阶段边界：采集毕→收口浏览器→重组（T38 约束）
            if "collect_done" in events:
                cd = next(i for e, i in evs if e == "collect_done")
                if cd > bc_idx:
                    fail(f"槽位 {slot} collect_done 在 browser_close 之后")
            if "dispatch_start" in events:
                ds = next(i for e, i in evs if e == "dispatch_start")
                if ds < bc_idx:
                    fail(f"槽位 {slot} dispatch_start 早于 browser_close")
    for slot in engine_fail:
        evs = slot_events(slot)
        events = [e for e, _ in evs]
        for want in _ENGINE_SEQ_FAIL:
            if want not in events:
                fail(f"失败槽位 {slot} 缺事件 {want}（实有 {events}）")
        for bad in ("collect_done", "qc"):
            if bad in events:
                fail(f"失败槽位 {slot} 不应出现 {bad}")
    for slot in not_routable:
        evs = slot_events(slot)
        if "not_routable" not in [e for e, _ in evs]:
            fail(f"拒入槽位 {slot} 缺 not_routable 事件（实有 {[e for e, _ in evs]}）")
    ev["checks"]["ok"] = not any(p.startswith("[events]") for p in problems)
    return ev


# ---------------------------------------------------------------- FR9.AC1 一单全链

def run_fr9(facts: dict, bp_path: Path, problems: list) -> dict:
    """端到端 1 单全链实弹：计划→采集→收口→重组→质检→镜像树→交付链→事件件。"""
    run_dir = ARTIFACTS / "run_fr9"
    work_root = run_dir / "work"
    run_dir.mkdir(parents=True, exist_ok=True)
    audit = HarvestAudit(path=str(run_dir / "harvest_audit.jsonl"))
    progress = ProgressEvents(str(run_dir / "progress_events.jsonl"),
                              order_id="ORD-T42-FR9-1")
    net = RunNet(audit, doc_memo=_read_json(T39_MEMO))

    # default_adapters() 基座（W8 准入口径）→ book118/doc88 换装断点注入实身（要点①③）
    adapters = default_adapters()
    adapters["doc88"] = Doc88DownloadAdapter(
        timeout=30.0, fetch=net.doc88_text, fetch_bytes=net.doc88_bytes,
        store=Store(str(T39_STORE_DIR)), work_dir=run_dir / "doc88_work")
    b_fact = facts["book118"]
    holder = BrowserHolder()
    adapters["book118"] = Book118ChainAdapter(
        store=Store(str(T37_STORE_DIR)), work_dir=run_dir / "book118_work",
        page_loader=make_book118_page_loader(net, _read_json(T37_SHTM_MEMO), holder),
        transport=net.book118_openapi, net=net)
    orch = Orchestrator(adapters, audit=audit, progress=progress,
                        work_root=work_root)   # registry_fn 缺省=真 sources_registry 实判

    slots = flatten_slots(bp_path)
    order = HarvestOrder(order_id="ORD-T42-FR9-1", blueprint_slots=slots,
                         budget=HarvestBudget(net_requests=BUDGET_REQUESTS))
    t0 = time.time()
    try:
        report = orch.run(order, blueprint_ref=str(bp_path), email=BUYER_EMAIL,
                          base_dir=run_dir / "fulfill")
    finally:
        holder.close()
    elapsed = round(time.time() - t0, 1)
    counts = report.counts()

    # ---- 断言：两站订单项实弹全过（质检门+镜像树+交付链回执） ----
    if counts != {"slots": 2, "delivered": 2, "partial": 0, "guide": 0, "failed": 0}:
        problems.append(f"[fr9] counts={counts} ≠ 2 站全交付（zero-partial/zero-guide）")
    slot_by_site = {r.site: r for r in report.slots}
    for site in ("book118", "doc88"):
        rec = slot_by_site.get(site)
        if rec is None:
            problems.append(f"[fr9] 缺 {site} 槽位记录")
            continue
        if rec.status != STATUS_DELIVERED:
            problems.append(f"[fr9] {site} status={rec.status} reason={rec.reason}")
        if not (rec.qc or {}).get("verify"):
            problems.append(f"[fr9] {site} 质检门 verify={(rec.qc or {}).get('verify')}")
        art = rec.artifact
        if art is None or not Path(art.path).is_file():
            problems.append(f"[fr9] {site} 镜像产物缺位 path={getattr(art, 'path', None)}")
        elif (art.pages or 0) < 1:
            problems.append(f"[fr9] {site} 产物页数 {art.pages}<1（零造假）")
    # 镜像树
    mirror = report.mirror or {}
    if not Path(mirror.get("manifest", "")).is_file():
        problems.append("[fr9] 镜像树 harvest_manifest 缺位")
    entries = mirror.get("entries") or []
    if len(entries) != 2 or {e["site"] for e in entries} != {"book118", "doc88"}:
        problems.append(f"[fr9] 镜像树 entries={[e.get('site') for e in entries]} ≠ 两站")
    for e in entries:
        if not Path(e["dest"]).is_file():
            problems.append(f"[fr9] 镜像文件缺位 {e['dest']}")
    # 交付链回执（BuildResult：树+manifest+zip 落盘）
    chain = report.chain
    if not chain:
        problems.append("[fr9] 交付链回执缺位（chain=None）")
    else:
        zip_path = Path(chain.get("zip_path", ""))
        if not zip_path.is_file() or zip_path.stat().st_size == 0:
            problems.append(f"[fr9] 交付 zip 缺位/空 {zip_path}")
        stats = chain.get("stats") or {}
        if stats.get("slots") != 2 or stats.get("delivered") != 2:
            problems.append(f"[fr9] 交付链 stats={stats} ≠ slots=2/delivered=2")
        kb_root = Path(chain.get("build_dir", "")) / str(chain.get("kb_name", ""))
        if not (kb_root / "manifest.json").is_file():
            problems.append(f"[fr9] 交付树 manifest.json 缺位 {kb_root}")
        if zip_path.is_file():
            import zipfile
            with zipfile.ZipFile(zip_path) as z:
                names = z.namelist()
            for e in entries:
                want = Path(e["dest"]).name
                if not any(n.endswith("/" + want) or n == want for n in names):
                    problems.append(f"[fr9] 交付 zip 缺镜像文件 {want}")
            if not any(n.endswith("manifest.json") for n in names):
                problems.append("[fr9] 交付 zip 缺 manifest.json")
    # 事件序（⑥）
    ev = check_event_sequence(rows_of_current_run(progress.rows()),
                              engine_ok=["收割组_core_001.pdf", "收割组_core_002.pdf"],
                              engine_fail=[], not_routable=[], with_chain=True,
                              problems=problems)
    # 台账与预算
    audit_rows = [json.loads(x) for x in
                  (run_dir / "harvest_audit.jsonl").read_text(encoding="utf-8").splitlines()
                  if x.strip()]
    if not any(r.get("event") == "order_start" for r in audit_rows) \
            or not any(r.get("event") == "order_done" for r in audit_rows):
        problems.append("[fr9] 台账缺 order_start/order_done 行")
    if not any(r.get("event") == "red_check" for r in audit_rows):
        problems.append("[fr9] 台账缺 red_check 行（registry_fn 缺省=真 sources_registry 实判）")
    if net.net > BUDGET_REQUESTS:
        problems.append(f"[fr9] 真净发 {net.net}>{BUDGET_REQUESTS}（预算口径如实停未触发？）")

    return {"order_id": order.order_id, "counts": counts, "elapsed_s": elapsed,
            "slots": [{"slot": r.slot, "site": r.site, "status": r.status,
                       "ladder_used": r.ladder_used, "qc": r.qc,
                       "artifact": None if r.artifact is None else {
                           "path": r.artifact.path, "pages": r.artifact.pages,
                           "chars": r.artifact.chars, "fmt": r.artifact.fmt,
                           "ladder_used": r.artifact.ladder_used}}
                      for r in report.slots],
            "budget": report.budget, "mirror": {"root": mirror.get("root"),
                                                "manifest": mirror.get("manifest"),
                                                "entries": entries},
            "chain": chain, "net": {"requests": net.net, "by_kind": net.by_kind},
            "events": ev, "audit_rows": len(audit_rows),
            "events_path": report.events_path, "ledger_ref": report.ledger_ref}


# ---------------------------------------------------------------- NFR5 单站故障韧性

def run_nfr5(facts: dict, bp_path: Path, problems: list) -> dict:
    """故障注入单：3 站订单（doc88 首槽=杀点/book118 次槽/csdn 拒入第三站），
    执行中 taskkill /T /F 真杀 doc88 适配器子进程——同单他站照常完成即韧性实证。"""
    run_dir = ARTIFACTS / "run_nfr5"
    run_dir.mkdir(parents=True, exist_ok=True)
    audit = HarvestAudit(path=str(run_dir / "harvest_audit.jsonl"))
    progress = ProgressEvents(str(run_dir / "progress_events.jsonl"),
                              order_id="ORD-T42-NFR5-1")
    net = RunNet(audit, doc_memo=_read_json(T39_MEMO))
    adapters = default_adapters()
    # doc88 首槽=杀点：全新工作区（FFDec/presse 子进程必新起，杀窗在位）
    adapters["doc88"] = Doc88DownloadAdapter(
        timeout=30.0, fetch=net.doc88_text, fetch_bytes=net.doc88_bytes,
        store=Store(str(T39_STORE_DIR)), work_dir=run_dir / "doc88_work")
    holder = BrowserHolder()
    adapters["book118"] = Book118ChainAdapter(
        store=Store(str(T37_STORE_DIR)), work_dir=run_dir / "book118_work",
        page_loader=make_book118_page_loader(net, _read_json(T37_SHTM_MEMO), holder),
        transport=net.book118_openapi, net=net)
    orch = Orchestrator(adapters, audit=audit, progress=progress,
                        work_root=run_dir / "work")

    slots = flatten_slots(bp_path)
    order_ids = {"doc88": "收割组_core_002.pdf", "book118": "收割组_core_001.pdf",
                 "csdn": "拒入站组_core_001.pdf"}
    by_slot = {s["name"]: s for s in slots}
    ordered = [by_slot[order_ids["doc88"]], by_slot[order_ids["book118"]],
               by_slot[order_ids["csdn"]]]   # doc88 首槽：杀点先跑，book118 事后完成=韧性
    order = HarvestOrder(order_id="ORD-T42-NFR5-1", blueprint_slots=ordered,
                         budget=HarvestBudget(net_requests=BUDGET_REQUESTS))
    killer = AdapterChildKiller()
    killer.start()
    t0 = time.time()
    try:
        report = orch.run(order)             # 链不入 NFR5 射程（不传 blueprint_ref/email）
    finally:
        killer.stop()
        killer.join(timeout=3.0)
        holder.close()
    elapsed = round(time.time() - t0, 1)
    counts = report.counts()

    # ---- 断言：真杀在案 ----
    if killer.killed is None:
        problems.append("[nfr5] 故障注入未生效：kill 窗内未见 doc88 适配器子进程"
                        "（candidates=%s）" % killer.candidates)
    elif killer.killed.get("rc") != 0:
        problems.append(f"[nfr5] taskkill rc={killer.killed.get('rc')} "
                        f"out={killer.killed.get('out')}")
    # ---- 断言：doc88 如实 failed（腿折入账）+ 不入镜像 ----
    slot_by_site = {r.site: r for r in report.slots}
    d88 = slot_by_site.get("doc88")
    if d88 is None or d88.status != STATUS_FAILED:
        problems.append(f"[nfr5] doc88 status={getattr(d88, 'status', None)} "
                        f"≠ failed（故障注入后应如实腿折）")
    else:
        if not d88.attempts or all(a.get("ok") for a in d88.attempts):
            problems.append("[nfr5] doc88 attempts 全 ok（腿折未入账）")
        if d88.ladder_used is not None:
            problems.append(f"[nfr5] doc88 ladder_used={d88.ladder_used}（全败应 None）")
        if not d88.reason:
            problems.append("[nfr5] doc88 失败 reason 缺位")
    # ---- 断言：book118 同单照常完成 + 镜像树含 book118 产物 ----
    b118 = slot_by_site.get("book118")
    if b118 is None or b118.status != STATUS_DELIVERED:
        problems.append(f"[nfr5] book118 status={getattr(b118, 'status', None)} "
                        f"≠ delivered（同单他站不受影响断言折）")
    elif b118.artifact is None or not Path(b118.artifact.path).is_file():
        problems.append("[nfr5] book118 镜像产物缺位")
    elif not (b118.qc or {}).get("verify"):
        problems.append(f"[nfr5] book118 质检门 verify={(b118.qc or {}).get('verify')}")
    # ---- 断言：csdn 拒入站=计划在案、引擎不路由 ----
    cs = next((r for r in report.slots if r.slot == order_ids["csdn"]), None)
    if cs is None or cs.status != STATUS_NOT_ROUTABLE:
        problems.append(f"[nfr5] csdn status={getattr(cs, 'status', None)} ≠ not_routable")
    # ---- 镜像树：只含 book118（doc88 隔离不入交付） ----
    mirror = report.mirror or {}
    entries = mirror.get("entries") or []
    entry_sites = [e["site"] for e in entries]
    if entry_sites != ["book118"]:
        problems.append(f"[nfr5] 镜像树 entries={entry_sites} ≠ [book118]（doc88 须隔离）")
    manifest = _read_json(Path(mirror.get("manifest", "")), default={})
    if manifest.get("summary", {}).get("shipped") != 1:
        problems.append(f"[nfr5] manifest shipped={manifest.get('summary')} ≠ 1")
    # ---- 事件序 + 事后完成实证（book118 qc 在 doc88 折腿之后） ----
    rows = rows_of_current_run(progress.rows())
    ev = check_event_sequence(rows, engine_ok=[order_ids["book118"]],
                              engine_fail=[order_ids["doc88"]],
                              not_routable=[order_ids["csdn"]], with_chain=False,
                              problems=problems)
    d88_fail_idx = next((i for i, r in enumerate(rows)
                         if r["slot"] == order_ids["doc88"] and r["event"] == "collect_start"), None)
    b118_qc_idx = next((i for i, r in enumerate(rows)
                        if r["slot"] == order_ids["book118"] and r["event"] == "qc"), None)
    if d88_fail_idx is not None and b118_qc_idx is not None and b118_qc_idx < d88_fail_idx:
        problems.append("[nfr5] book118 qc 早于 doc88 折腿（事后完成实证不成立）")
    if counts != {"slots": 3, "delivered": 1, "partial": 0, "guide": 1, "failed": 1}:
        problems.append(f"[nfr5] counts={counts} ≠ slots=3/delivered=1/guide=1(csdn)/failed=1(doc88)")

    return {"order_id": order.order_id, "counts": counts, "elapsed_s": elapsed,
            "kill": killer.killed, "kill_candidates": killer.candidates,
            "doc88": None if d88 is None else {
                "status": d88.status, "reason": d88.reason,
                "attempts": d88.attempts, "ladder_used": d88.ladder_used},
            "book118": None if b118 is None else {
                "status": b118.status, "artifact": None if b118.artifact is None
                else b118.artifact.path, "pages": b118.artifact.pages
                if b118.artifact else None, "qc": b118.qc},
            "csdn": None if cs is None else {"status": cs.status, "reason": cs.reason},
            "mirror": {"root": mirror.get("root"), "entries": entries},
            "post_fault_proof": {"doc88_collect_start_idx": d88_fail_idx,
                                 "book118_qc_idx": b118_qc_idx},
            "events": ev, "net": {"requests": net.net, "by_kind": net.by_kind},
            "budget": report.budget}


# ---------------------------------------------------------------- W8 拒入门实判

def registration_gate_check(problems: list) -> dict:
    """W8 准入实判：csdn 键+已过验收适配器实身注册 → ValueError（零网络）。

    CsdnAdapter 实身构造需 BrowserKit（点击流浏览器件），不入本验射程——拒入门
    键控口径（注册键∉ACCEPTED_SITES 即拒）与实身类无关，如实注记。
    """
    audit = HarvestAudit(path=str(ARTIFACTS / "registration_gate_audit.jsonl"))
    progress = ProgressEvents(str(ARTIFACTS / "registration_gate_events.jsonl"))
    try:
        Orchestrator({"csdn": Book118Adapter()}, audit=audit, progress=progress)
    except ValueError as exc:
        if "csdn" not in str(exc):
            problems.append(f"[w8] 拒入异常未点名 csdn: {exc}")
        return {"csdn_key_rejected": True, "message": str(exc)[:200],
                "accepted_sites": list(ACCEPTED_SITES)}
    problems.append("[w8] csdn 键注册未拒（W8 准入门失效）")
    return {"csdn_key_rejected": False, "accepted_sites": list(ACCEPTED_SITES)}


# ---------------------------------------------------------------- 主流程

def ensure_toolchain() -> None:
    root = default_toolchain_root()
    missing = [n for n, found in (
        ("java", locate_java(root)), ("ffdec", locate_ffdec(root)),
        ("presse", locate_presse(root))) if not found]
    if missing:
        raise ToolchainError(
            "工具链缺位: " + ",".join(missing)
            + "；先 py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain"
            " --ensure ffdec,presse")


def main(argv: list | None = None) -> int:
    t_start = time.time()
    if str(os.environ.get("KB_HARVEST_SKIP_LIVE", "")).strip() == "1":
        print("[验收] KB_HARVEST_SKIP_LIVE=1：实弹用例跳过（明示，公约第4条；退出码 0）",
              flush=True)
        SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)
        SUMMARY_PATH.write_text(json.dumps({
            "task": "T42 E2E 端到端 1 单全链+单站故障韧性（FR9.AC1+NFR5）",
            "skipped": True, "reason": "KB_HARVEST_SKIP_LIVE=1"}, ensure_ascii=False,
            indent=1), encoding="utf-8")
        return 0

    ARTIFACTS.mkdir(parents=True, exist_ok=True)
    ensure_toolchain()
    facts = load_site_facts()
    bp_e2e = build_blueprint(facts, with_csdn=False, root="端到端验收知识库")
    bp_nfr5 = build_blueprint(facts, with_csdn=True, root="端到端韧性验收知识库")
    problems: list = []

    w8 = registration_gate_check(problems)
    print("[W8] csdn 键注册拒入=%s（accepted=%s）" % (w8["csdn_key_rejected"],
                                                    w8["accepted_sites"]), flush=True)

    fr9 = run_fr9(facts, bp_e2e, problems)
    print("[FR9.AC1] counts=%s | 真净发=%s（by_kind=%s）| 耗时=%ss"
          % (fr9["counts"], fr9["net"]["requests"], fr9["net"]["by_kind"],
             fr9["elapsed_s"]), flush=True)
    for s in fr9["slots"]:
        art = s.get("artifact") or {}
        print("  - %s %s ladder=%s pages=%s chars=%s qc_verify=%s"
              % (s["site"], s["status"], s["ladder_used"], art.get("pages"),
                 art.get("chars"), (s.get("qc") or {}).get("verify")), flush=True)
    if fr9.get("chain"):
        ch = fr9["chain"]
        print("  - 交付链回执: kb=%s zip=%s stats=%s"
              % (ch.get("kb_name"), ch.get("zip_path"), ch.get("stats")), flush=True)

    nfr5 = run_nfr5(facts, bp_nfr5, problems)
    print("[NFR5] counts=%s | kill=%s | book118=%s doc88=%s csdn=%s | 耗时=%ss"
          % (nfr5["counts"], nfr5["kill"],
             (nfr5.get("book118") or {}).get("status"),
             (nfr5.get("doc88") or {}).get("status"),
             (nfr5.get("csdn") or {}).get("status"), nfr5["elapsed_s"]), flush=True)
    if nfr5.get("doc88"):
        print("  - doc88 如实腿折: reason=%s" % (nfr5["doc88"].get("reason") or "")[:160],
              flush=True)
    pf = nfr5.get("post_fault_proof") or {}
    print("  - 事后完成实证: doc88_collect_start@%s < book118_qc@%s"
          % (pf.get("doc88_collect_start_idx"), pf.get("book118_qc_idx")), flush=True)

    summary = {
        "task": "T42 E2E 端到端 1 单全链+单站故障韧性（FR9.AC1+NFR5）",
        "accept_cmd": "py -3 kb_factory/harvest_engine/e2e/full_chain_accept.py",
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "elapsed_s": round(time.time() - t_start, 1),
        "sites": {
            "book118": {"doc_id": BOOK118_DOC_ID, **facts["book118"],
                        "wiring": "Book118ChainAdapter=T19 页清单腿+T23 拼PDF/OCR 四门腿"
                                  "（真方法串联，E2E 装配层接线，适配器本体零改动）"},
            "doc88": {"p_code": DOC88_P_CODE, **facts["doc88"],
                      "wiring": "Doc88DownloadAdapter 实身+T39 Store/memo 断点复用"},
            "wenku": {"registered": True, "slots": 0,
                      "note": "verify 段4 未实装=qc_fail 隔离不入交付（T40 下游3）——"
                              "本次不接（任务卡②：可作第三站仅验 collect 段或干脆不做，"
                              "如实记录口径=不做）"},
            "csdn": {"w8_gate": w8, "nfr5_slot": "not_routable（计划在案、引擎不路由）"}},
        "blueprints": {"fr9": str(bp_e2e), "nfr5": str(bp_nfr5)},
        "entry": "Orchestrator(default_adapters(), audit=…, progress=…)"
                 "（registry_fn 缺省=真 sources_registry 实判；book118/doc88 换装"
                 "断点注入同真类实身）",
        "fr9": fr9, "nfr5": nfr5,
        "scope_excluded": ["deliver/SMTP 发送腿（不在本件射程，归发布链）"],
        "problems": problems,
    }
    tmp = SUMMARY_PATH.with_suffix(".json.tmp")
    tmp.write_text(json.dumps(summary, ensure_ascii=False, indent=1), encoding="utf-8")
    tmp.replace(SUMMARY_PATH)

    print("=" * 104, flush=True)
    print("[汇总] summary=%s | FR9 台账=%s | NFR5 台账=%s"
          % (SUMMARY_PATH, ARTIFACTS / "run_fr9" / "harvest_audit.jsonl",
             ARTIFACTS / "run_nfr5" / "harvest_audit.jsonl"), flush=True)
    if problems:
        for p in problems:
            print("[未过] %s" % p, flush=True)
        print("[验收] 未过（退出码 1）", flush=True)
        return 1
    print("[验收] FR9.AC1 端到端 1 单全链实弹全过（book118+doc88 两站：质检门+镜像树+"
          "交付链回执）+ NFR5 单站故障韧性（taskkill /T /F 真杀 doc88 子进程，同单 "
          "book118 照常完成、doc88 如实腿折隔离、csdn 拒入）+ 事件序全序断言过"
          "（退出码 0）", flush=True)
    return 0


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace", line_buffering=True)
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")
    sys.exit(main(sys.argv[1:]))
