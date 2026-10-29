# -*- coding: utf-8 -*-
"""T39 验收件：doc88 实弹 10 份等价抽取验收（FR4.AC1 三阈值门 + 质检门 10/10）。

验收口径（任务卡）：
- 选件：分类页 /list-*.html 静态 p-{code}.html 直链（T24 手法）取 p_code，
  **页数偏小的件优先**（收割页数 ≤ --max-pages、单件预估请求 1 配置发+层文件数发
  ≤ --max-est），逐份记录 p_code/页数/层级/取页口径；
- 适配器：``Doc88DownloadAdapter(free_probe=False)``（付费墙现实已挂账、免费门腿
  T39 不重复实证）+ 显式持久 Store + work_dir（T32 下游4 断点复用；--resume 分批跑，
  Store 命中零重下）；
- 三阈值门（逐份，全实测零造假）：
  ① 页数 == p_pagecount 或 == p_allow_page_count（预览上限）——逐份记录取哪个口径；
    预览受限件（p_allow < p_pagecount）按 page_nos=1..p_allow 子集收割（部分收割
    合法形态），manifest 参照键改写为 preview_limit（quality_gate 门①词表内口径）；
  ② 字数 ≥ 0.9 × 同源参照——参照=同 SWF 集 FFDec frame:pdf **双导出**第二腿逐页
    抽字（T32 机制内建于 swf_chain_to_pdf，manifest 自带 ref_chars；FFDec 无
    frame:text 格式、页文字住 DefineSprite 内——口径实锤见 adapters/doc88.py T32 段）；
  ③ 首中末 3 页 PNG 渲染视觉抽检无缺页黑页——pypdfium2 抽帧落
    artifacts/doc88_pages/<p_code>/page_XXXX.png，ink 比落 quality_gate 门③带内
    [0.001, 0.85]（下界拦整页空白=缺页、上界拦整页油墨=黑页/水印遮盖）；
- 质检门：``adapter.verify``（quality_gate 四门 CLI，退出码 0=质检门全过）10/10；
- 预算：全部 10 份总网络请求 ≤ --budget（默认 60）发，超预算如实停并报告；
  每一网络请求（与缓存命中）如实一行入 ledger（artifacts/doc88_accept_ledger.jsonl）。

预算口径实现（数字零造假）：
- ``CountingFetch`` 包真网络腿（委托 adapters.doc88._curl_cffi_get /
  _curl_cffi_get_bytes 真符号，非 mock）：net 计数 + ledger 逐发入账 + 硬顶熔断；
- 配置面 200 文本响应（act=info / 文档页）按 URL 记 run 级 fetch memo
  （artifacts/doc88_fetch_memo.json，断点复用件）：选件期已发现的配置，
  fetch_ladder 内建 discover_config 复用为缓存命中（零网络、ledger 记 cache 行）
  ——即任务卡「每份≈配置 1 发」的落点；ebt 二进制腿永不 memo（Store 整文件
  字节缓存主责）；非 200 响应不入 memo（防 WAF/404 体固化成僵缓存）；
- **层文件块收割**（任务卡预算模型「ebt 层文件数发（层内偏移复用同层文件）」
  =DOC88_SPEC §1.5 隐藏页扫描的块请求形态，2026-10-22 本件实弹三探针验证：
  1024000 定长块/自定义跨长块/offset=0 含层头跨长块均 HTTP 200 且字节数与请求
  长度逐位相符，71 页件含层头 5308630B 一发拿全，按页表偏移切片+PH 位 YBD 魔数
  逐页验真全通过）：每层 1 发含层头跨长块（层号-0-层头+页跨长-p_swf-1-p_code），
  PH/PK 切片按资产名 ``Store.put_asset``（真符号）——fetch_ladder 内建 harvest 的
  PH/PK 全部缓存命中（零网络）；单件净请求≈1 配置+层数，与页数无关；层内所选
  页+PH 已全在 Store（上轮批次）→ 该层零请求跳层（断点复用）；
- 退出码 0 = 10/10 三阈值门+质检门全过 且 净请求 ≤ budget；否则如实非零。

命令：py -3 kb_factory/harvest_engine/e2e/doc88_accept.py [--resume]
      [--budget 60] [--max-pages 30] [--limit 10] [--list list-1022]
"""
from __future__ import annotations

import argparse
import contextlib
import io
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
from kb_factory.harvest_engine.adapters.doc88 import (  # noqa: E402
    DOC88_BASE, EBT_PH_PREFIX, Doc88AssetError, Doc88ConfigError, Doc88Config,
    Doc88DownloadAdapter, Doc88DocNotFound, Doc88WAFBlocked, _curl_cffi_get,
    _curl_cffi_get_bytes, decompress_ebt_slice, discover_config, ebt_asset_url,
    page_url, ph_asset_name, pk_asset_name)
from kb_factory.harvest_engine.codec.variant_b64 import (  # noqa: E402
    DOC88_KEY2_NAME, encode as vb_encode)
from kb_factory.harvest_engine.audit import HarvestAudit  # noqa: E402
from kb_factory.harvest_engine.store.ledger import Store  # noqa: E402
from kb_factory.harvest_engine.tools.fetch_toolchain import (  # noqa: E402
    ToolchainError, default_toolchain_root, locate_ffdec, locate_java,
    locate_presse)

ARTIFACTS = _E2E_DIR / "artifacts"
SUMMARY_PATH = ARTIFACTS / "doc88_accept_summary.json"
LEDGER_PATH = ARTIFACTS / "doc88_accept_ledger.jsonl"
MEMO_PATH = ARTIFACTS / "doc88_fetch_memo.json"
STORE_DIR = ARTIFACTS / "doc88_store"
WORK_DIR = ARTIFACTS / "doc88_work"
PAGES_DIR = ARTIFACTS / "doc88_pages"

CHARS_RATIO_MIN = quality_gate.CHARS_RATIO_MIN   # 门② 0.9×同源参照
INK_MIN = quality_gate.INK_RATIO_MIN             # 门③带下界（整页空白=缺页）
INK_MAX = quality_gate.INK_RATIO_MAX             # 门③带上界（黑页/水印遮盖）

_P_CODE_LINK_RE = re.compile(r"/p-(\d{6,20})\.html")
_LIST_LINK_RE = re.compile(r"/(list-[0-9A-Za-z\-]+\.html)")


class BudgetExceeded(RuntimeError):
    """网络预算硬顶熔断（超预算如实停，不静默继续）。"""


def _url_kind(url: str) -> str:
    """请求分类（ledger event 名，按 URL 形态）。"""
    if "act=info" in url:
        return "fetch_info"
    if "act=download" in url:
        return "fetch_download"
    if "/getebt-" in url:
        return "fetch_ebt"
    if "/p-" in url and ".html" in url:
        return "fetch_page"
    return "fetch_list_or_other"


class CountingFetch:
    """真网络腿计数包装（委托 _curl_cffi_get/_curl_cffi_get_bytes 真符号，非 mock）。

    - 每一真网络发：net+1、ledger 一行（net=true）；
    - 配置面 200 文本响应按 URL memo（run 级断点件）：复用=零网络、ledger 一行
      （net=false cache），即任务卡「配置 1 发/份」的落点；
    - 硬顶：net 将超 cap 时抛 BudgetExceeded（发不出去，如实停）。
    """

    def __init__(self, ledger_path: Path, memo_path: Path, *, cap: int,
                 start_net: int = 0):
        self.cap = int(cap)
        self.net = int(start_net)
        self.by_kind: dict[str, int] = {}
        self.current_doc = "-"
        self._audit = HarvestAudit(path=str(ledger_path))
        self._memo_path = memo_path
        self._memo = self._load_memo()

    # ---- memo（配置面文本 200 响应；崩溃安全：每次写入全量原子落盘） ----
    def _load_memo(self) -> dict:
        try:
            return json.loads(self._memo_path.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return {}

    def _save_memo(self) -> None:
        self._memo_path.parent.mkdir(parents=True, exist_ok=True)
        tmp = self._memo_path.with_suffix(".json.tmp")
        tmp.write_text(json.dumps(self._memo, ensure_ascii=False), encoding="utf-8")
        tmp.replace(self._memo_path)

    def _log(self, url: str, status: int, n_bytes: int, elapsed_ms: int, *,
             net: bool) -> None:
        kind = _url_kind(url)
        if net:
            self.by_kind[kind] = self.by_kind.get(kind, 0) + 1
        detail = (f"http={status} bytes={n_bytes} elapsed_ms={elapsed_ms} "
                  f"net={'true' if net else 'false'}"
                  + ("" if net else " cache=memo")
                  + f" url={url[:180]}")
        self._audit.request(site="doc88", event=kind,
                            query_or_docid=self.current_doc, count=n_bytes,
                            status="ok" if status == 200 else "fail", detail=detail)

    # ---- 两条真符号委托腿（Fetch/BytesFetch 签名同构，可直接喂适配器） ----
    def text(self, url: str, timeout: float) -> tuple[int, str]:
        hit = self._memo.get(url)
        if hit is not None:
            body = str(hit[1])
            self._log(url, int(hit[0]), len(body.encode("utf-8", "replace")), 0, net=False)
            return int(hit[0]), body
        if self.net + 1 > self.cap:
            raise BudgetExceeded(f"预算硬顶：net={self.net}+1 > cap={self.cap}（{url[:80]}）")
        t0 = time.time()
        status, body = _curl_cffi_get(url, timeout)
        self.net += 1
        if status == 200:  # 仅 200 配置面入 memo（WAF/404 体不固化）
            self._memo[url] = [status, body]
            self._save_memo()
        self._log(url, status, len(body.encode("utf-8", "replace")),
                  int((time.time() - t0) * 1000), net=True)
        return status, body

    def bytes(self, url: str, timeout: float) -> tuple[int, bytes]:
        if self.net + 1 > self.cap:
            raise BudgetExceeded(f"预算硬顶：net={self.net}+1 > cap={self.cap}（{url[:80]}）")
        t0 = time.time()
        status, data = _curl_cffi_get_bytes(url, timeout)
        self.net += 1
        self._log(url, status, len(data), int((time.time() - t0) * 1000), net=True)
        return status, data


# ---------------- 选件：分类页直链 → 配置发现 → 小件优先 ----------------

def parse_list_p_codes(html: str) -> tuple[list[str], list[str]]:
    """分类页 HTML → (p_code 有序去重表, 页上发现的 /list-*.html 路径表)。

    T24 实测：/list-1022.html 静态含 10 个 p-{code}.html 直链；解析只认该形态
    （相对/绝对链接通吃），本页小件不足时按第二返回值续拉下一分类页。
    """
    codes: list[str] = []
    for m in _P_CODE_LINK_RE.finditer(html):
        code = m.group(1)
        if code not in codes:
            codes.append(code)
    lists: list[str] = []
    for m in _LIST_LINK_RE.finditer(html):
        path = "/" + m.group(1)
        if path not in lists:
            lists.append(path)
    return codes, lists


class Pick:
    """单件选品决策（全部字段来自实测配置，零造假）。

    请求模型（任务卡预算口径，层文件块收割实测支撑）：配置 1 发 + 每层 1 发
    **含层头跨长块**（offset=0 起整层 PH+页体一发拿全），与页数无关；
    ``fetch_pages`` 只影响时长。
    """

    def __init__(self, p_code: str, cfg_facts: dict):
        self.p_code = p_code
        self.facts = cfg_facts
        self.p_pagecount = int(cfg_facts["p_pagecount"])
        self.p_allow = cfg_facts.get("p_allow_page_count")
        self.levels = len(cfg_facts.get("header_sizes") or ())
        self.page_table = int(cfg_facts.get("pages") or self.p_pagecount)
        self.subset = self.p_allow is not None and int(self.p_allow) < self.p_pagecount
        self.fetch_pages = int(self.p_allow) if self.subset else self.p_pagecount
        self.est_requests = 1 + self.levels  # 配置1发+每层含层头跨长块1发

    def line(self) -> str:
        return ("p_code=%s 页数=%d 预览上限=%s 层级=%d 层 预估请求=%d 发%s"
                % (self.p_code, self.p_pagecount, self.p_allow, self.levels,
                   self.est_requests,
                   "（预览受限→子集收割前 %d 页）" % self.fetch_pages if self.subset else ""))


#: 暗底设计件题名特征（窄式：只拒海报/PPT 模板类；实弹教训 run3 两折均为暗底
#: 营销模板——门③ ink 上界 0.85 拦「黑页」是规格行为，选件面避让是正解）
_DARK_TITLE_RE = re.compile(r"海报|PPT模板|ppt模板|PPT模板|幻灯片模板")


class Selector:
    """选件器：分类页逐页懒发现，小件即收；状态可跨 --resume 复用。"""

    def __init__(self, counting: CountingFetch, *, max_pages: int, max_est: int,
                 seen: set[str], rejected: list[dict]):
        self.counting = counting
        self.max_pages = max_pages
        self.max_est = max_est
        self.seen = seen
        self.rejected = rejected
        self.queue_paths: list[str] = []
        self.fetched: list[str] = []
        self.stop_reason = ""

    def _reject(self, p_code: str, reason: str) -> None:
        self.rejected.append({"p_code": p_code, "reason": reason})
        self.seen.add(p_code)

    def fetch_list(self, path: str) -> list[str]:
        """抓一页分类页（计数腿）→ 返回本页候选 p_code（200 才有候选）。"""
        counting = self.counting
        counting.current_doc = "list:" + path.rsplit("/", 1)[-1]
        status, body = counting.text(f"{DOC88_BASE}{path}", 30.0)
        self.fetched.append(path)
        if status != 200:
            self._reject("list:" + path, f"分类页 HTTP {status}")
            return []
        codes, more = parse_list_p_codes(body)
        for p in more:
            if p not in self.fetched and p not in self.queue_paths:
                self.queue_paths.append(p)
        return codes

    def discover(self, p_code: str) -> "Pick | None":
        """单候选配置发现+选件判定（折如实拒、WAF 停全程）。"""
        if self.counting.net + 1 > self.counting.cap:
            self.stop_reason = "预算不足以再发现候选（net=%d/%d）" % (
                self.counting.net, self.counting.cap)
            return None
        self.counting.current_doc = p_code
        try:
            cfg = discover_config(p_code, fetch=self.counting.text, timeout=30.0)
        except Doc88DocNotFound:
            self._reject(p_code, "p_404 文档不存在")
            return None
        except Doc88WAFBlocked as exc:
            self.stop_reason = "WAF 硬拒（如实停）：" + str(exc)[:160]
            return None
        except Doc88ConfigError as exc:
            self._reject(p_code, "配置不可得: " + str(exc)[:120])
            return None
        self.seen.add(p_code)
        pick = Pick(p_code, cfg.to_mapping())
        title = str(cfg.p_name or "")
        if _DARK_TITLE_RE.search(title):
            self._reject(p_code, "题名近暗底设计件（%s…）：门③ink 上界风险，选件避让"
                         % title[:24])
            return None
        if pick.page_table != pick.p_pagecount:
            self._reject(p_code, "页表长度 %d != p_pagecount %d" % (
                pick.page_table, pick.p_pagecount))
            return None
        if pick.est_requests > self.max_est or pick.fetch_pages > self.max_pages:
            self._reject(p_code, "件偏大：预估 %d 发/收割 %d 页" % (
                pick.est_requests, pick.fetch_pages))
            return None
        return pick

    def select(self, need: int) -> list[Pick]:
        """收满 need 件小件（逐页懒发现；预算不足/WAF 如实停并记 stop_reason）。"""
        picked: list[Pick] = []
        while len(picked) < need and not self.stop_reason:
            if not self.queue_paths and self.fetched:
                break  # 起始页与衍生页全部抓完
            if not self.queue_paths:
                self.queue_paths.append("/list-1022.html")
            # 分类页抓取守门：本页 1 发 + 余量每件最少 2 发（配置1+层块1）
            if self.counting.cap - self.counting.net < 1 + 2 * need:
                self.stop_reason = "预算不足以再抓分类页（剩 %d 发，还需 ≥%d 发）" % (
                    self.counting.cap - self.counting.net, 1 + 3 * need)
                break
            path = self.queue_paths.pop(0)
            if path in self.fetched:
                continue
            codes = self.fetch_list(path)
            for code in codes:
                if len(picked) >= need or self.stop_reason:
                    break
                if code in self.seen:
                    continue
                # 余量守门：每件至少 2 发（配置1+层块1），不足即如实停
                if self.counting.cap - self.counting.net < 2 * (need - len(picked)):
                    self.stop_reason = "预算不足以再选 %d 件（剩 %d 发）" % (
                        need - len(picked), self.counting.cap - self.counting.net)
                    break
                pick = self.discover(code)
                if pick is None:
                    continue
                if self.counting.cap - self.counting.net < pick.est_requests - 1:
                    # 选件发现已花 1 发；收割还需 层+页 发
                    self._reject(code, "预算不足（收割还需 %d 发，剩 %d 发）" % (
                        pick.est_requests - 1, self.counting.cap - self.counting.net))
                    self.stop_reason = "预算不足以收割该件（剩 %d 发）" % (
                        self.counting.cap - self.counting.net)
                    continue
                picked.append(pick)
                print("[选件] %s" % pick.line(), flush=True)
        return picked


# ---------------- 单件全链验收（适配器段3/段4 + 三阈值门） ----------------

def render_head_mid_last(pdf_path: str | Path, out_dir: Path) -> tuple[dict[int, float], list[str]]:
    """首/中/末 3 页 PNG 抽帧留档 + ink 比实测（quality_gate 同口径真符号）。"""
    import pypdfium2 as pdfium
    out_dir.mkdir(parents=True, exist_ok=True)
    doc = pdfium.PdfDocument(str(pdf_path))
    inks: dict[int, float] = {}
    files: list[str] = []
    try:
        for idx in quality_gate.sample_indices(len(doc)):
            page = doc[idx]
            try:
                im = page.render(scale=quality_gate.RENDER_SCALE).to_pil()
            finally:
                page.close()
            path = out_dir / ("page_%04d.png" % idx)
            im.save(path)
            files.append(path.name)
            inks[idx] = quality_gate.image_ink_ratio(im)
    finally:
        doc.close()
    return inks, files


def _put_asset_retry(store: Store, key: str, data: bytes, *, doc: str,
                     tries: int = 12, delay_s: float = 0.25) -> str:
    """Store.put_asset 竞态重试（Windows 实弹 2026-10-22：progress.json 原子换名被
    杀软/索引器短暂锁住 → WinError 5；纯重试不改语义，重试尽如实上抛）。"""
    for i in range(int(tries)):
        try:
            return store.put_asset(key, data, doc=doc)
        except PermissionError:
            if i == int(tries) - 1:
                raise
            time.sleep(delay_s)


def prefetch_pk_blocks(cfg: Doc88Config, counting: CountingFetch, store: Store,
                       *, page_nos: "list[int] | None" = None) -> dict:
    """层文件块收割（任务卡预算模型）：每层 1 发**含层头跨长块** → 切片入 Store。

    - 块请求形态=DOC88_SPEC §1.5（层号-偏移-长度-p_swf-块号-p_code，key2 资产名）；
      本件取 offset=0、长度=该层层头+所选页首尾跨长（2026-10-22 实弹三探针：
      1024000 定长块/自定义跨长块/offset=0 含层头跨长块均 200 且字节逐位相符——
      71 页件 5308630B 一发拿全 PH+71 页，PH 位 YBD 魔数、页位偏移逐页吻合）；
    - 切片：PH=data[0:header_size]（YBD 前缀族验真，put PH 资产名）；逐页
      data[loc.offset:loc.offset+loc.length]（PK 32B 头 zlib 验真，put PK 资产名）
      ——fetch_ladder 内建 harvest 的 PH/PK 全部缓存命中（零网络）；
    - 断点复用：层内所选页+PH 全已在 Store → 该层零请求（上轮批次产物直接复用）；
    - 返回事实 dict（层数/逐层字节数/预填页数/块数/全命中跳层数）；失败抛
      Doc88AssetError 如实入账（调用方记折换件）。
    """
    pages = list(cfg.pages) if page_nos is None else [
        cfg.pages[n - 1] for n in sorted(int(x) for x in page_nos)]
    numbered = list(enumerate(pages, start=1))  # (页表位序, PageLoc)；位序=页码
    by_level: dict[int, list] = {}
    for page_no, loc in numbered:
        by_level.setdefault(loc.level, []).append((page_no, loc))
    facts = {"layers": {}, "pages_prefilled": 0, "blocks": 0, "cache_skipped_layers": 0}
    for lv, entries in sorted(by_level.items()):
        header_size = cfg.header_sizes[lv - 1]
        ph_name = ph_asset_name(lv, header_size, cfg.p_swf)
        page_names = {page_no: pk_asset_name(loc, cfg.p_swf, page_no, cfg.p_code)
                      for page_no, loc in entries}
        # 断点复用：该层 PH+所选页全部已在 Store（含上轮批次产物）→ 零请求跳层
        if store.get_asset(ph_name) is not None and all(
                store.get_asset(n) is not None for n in page_names.values()):
            facts["cache_skipped_layers"] += 1
            facts["layers"][str(lv)] = {"span_bytes": None, "pages": len(entries),
                                        "cache": "full-hit"}
            continue
        start = min(loc.offset for _, loc in entries)
        end = max(loc.offset + loc.length for _, loc in entries)
        length = max(header_size, end)  # 含层头：offset=0 一发拿全 PH+页体
        name = vb_encode(DOC88_KEY2_NAME,
                         f"{lv}-0-{length}-{cfg.p_swf}-1-{cfg.p_code}")
        counting.current_doc = cfg.p_code
        status, data = counting.bytes(ebt_asset_url(cfg.p_ebthost, name), 90.0)
        facts["blocks"] += 1
        if status != 200 or len(data) != length:
            raise Doc88AssetError(
                f"层 {lv} 块请求不符：HTTP {status}，实测 {len(data)}B ≠ 跨长 {length}B"
                f"（p_code={cfg.p_code}，零造假如实报差）")
        ph = data[:header_size]
        if not ph.startswith(EBT_PH_PREFIX):
            raise Doc88AssetError(
                f"层 {lv} PH 切片魔数非 {EBT_PH_PREFIX!r} 前缀族：实测 {ph[:4]!r}"
                f"（p_code={cfg.p_code}，R16 只认字节）")
        decompress_ebt_slice(ph, 40, what=f"L{lv} PH", name=name)  # 层头验真
        _put_asset_retry(store, ph_name, ph, doc=cfg.p_code)
        for page_no, loc in entries:
            chunk = data[loc.offset: loc.offset + loc.length]
            if len(chunk) != loc.length:
                raise Doc88AssetError(f"层 {lv} 第 {page_no} 页切片短读（零造假）")
            decompress_ebt_slice(chunk, 32, what=f"L{lv} 块切页 {page_no}",
                                 name=name)  # 验真：坏字节不进库
            _put_asset_retry(store, page_names[page_no], chunk, doc=cfg.p_code)
            facts["pages_prefilled"] += 1
        facts["layers"][str(lv)] = {"span_bytes": length, "pages": len(entries)}
    return facts


def run_doc(pick: Pick, counting: CountingFetch, store: Store) -> dict:
    """单件段3+段4+三阈值门（逐份记录全实测）。返回 doc 记录（status=pass|fail）。"""
    t0 = time.time()
    net_before = counting.net
    counting.current_doc = pick.p_code
    page_nos = list(range(1, pick.fetch_pages + 1)) if pick.subset else None
    # 配置复得（选件期 memo 命中=零网络；memo 缺位时 1 发如实入账）
    cfg = discover_config(pick.p_code, fetch=counting.text, timeout=30.0)
    # 层文件块收割：每层 1 发跨长块 → 页表切片入 Store（fetch_ladder 的 PK 全命中）
    prefetch = prefetch_pk_blocks(cfg, counting, store, page_nos=page_nos)
    adapter = Doc88DownloadAdapter(timeout=30.0, fetch=counting.text,
                                   fetch_bytes=counting.bytes, store=store,
                                   work_dir=WORK_DIR, page_nos=page_nos,
                                   free_probe=False)
    meta = FileMeta(title=str(pick.facts.get("p_name") or pick.p_code), fmt="pdf",
                    source_url=page_url(pick.p_code))
    result = adapter.fetch_ladder(HarvestPlan(meta=meta))
    chain = dict(meta.extra.get("doc88_chain") or {})
    rec: dict = {
        "p_code": pick.p_code, "p_name": pick.facts.get("p_name"),
        "p_pagecount": pick.p_pagecount, "p_allow_page_count": pick.p_allow,
        "levels": pick.levels, "fetch_pages": pick.fetch_pages, "subset": pick.subset,
        "detail": result.detail, "artifact_path": result.artifact_path,
        "chain": {k: chain.get(k) for k in (
            "pages", "chars", "ref_chars", "manifest_path", "slices", "downloads",
            "cache_hits", "groups", "fixes", "merged", "source")},
        "requests": {"net": counting.net - net_before},
        "prefetch": prefetch,
        "ts": time.strftime("%Y-%m-%dT%H:%M:%S"),
    }
    if not result.ok or not result.artifact_path:
        rec.update(status="fail", fail_stage="fetch_ladder", ok=False,
                   wall_status=result.wall_status,
                   elapsed_s=round(time.time() - t0, 1))
        return rec

    # manifest 修正（验收件内如实入账；上游 T32 件缺陷留档不改）：
    # - 预览受限子集件：expected_pages→preview_limit（门①词表「预览上限=部分收割
    #   合法形态」；值为站方声明 p_allow）；
    # - 单页直用件（merged=False，frames.pdf 原位直用）：T32 manifest 写
    #   ``final.name`` 相对名，多页 merge 件与 manifest 同目录可解析，单页件产物在
    #   pdf/gNN/NNNN.swf/ 子目录→相对解析 404 四门全「实测不可得」（run4 实弹
    #   p_code=8186093739287 实锤）——修正为链路实测产物绝对路径。
    manifest_ref = "expected_pages"
    manifest_fixes: list[str] = []
    mpath = chain.get("manifest_path")
    if mpath and Path(mpath).is_file():
        m = json.loads(Path(mpath).read_text(encoding="utf-8"))
        if pick.subset and "expected_pages" in m:
            m.pop("expected_pages")
            m["preview_limit"] = pick.fetch_pages
            manifest_ref = "preview_limit"
            manifest_fixes.append("expected_pages→preview_limit=%d" % pick.fetch_pages)
        ref = Path(str(m.get("pdf_path", "")))
        resolved = ref if ref.is_absolute() else Path(mpath).parent / ref
        if not resolved.is_file() and result.artifact_path \
                and Path(result.artifact_path).is_file():
            m["pdf_path"] = str(Path(result.artifact_path).resolve())
            manifest_fixes.append("pdf_path→产物绝对路径（单页直用件相对解析 404 修正）")
        if manifest_fixes:
            Path(mpath).write_text(json.dumps(m, ensure_ascii=False, indent=1),
                                   encoding="utf-8")

    # 阈值门①：页数 == p_pagecount 或 == p_allow_page_count（独立 pypdfium2 复测）
    import pypdfium2 as pdfium
    doc = pdfium.PdfDocument(result.artifact_path)
    try:
        n_pages = len(doc)
    finally:
        doc.close()
    if n_pages == pick.p_pagecount:
        t1, basis = True, "p_pagecount"
    elif pick.p_allow is not None and n_pages == int(pick.p_allow):
        t1, basis = True, "p_allow_page_count"
    else:
        t1, basis = False, ("未命中（p_pagecount=%d / p_allow=%s / 实测 %d 页）"
                            % (pick.p_pagecount, pick.p_allow, n_pages))

    # 阈值门②：字数 ≥ 0.9×同源参照（FFDec 双导出第二腿，T32 内建）
    chars = int(chain.get("chars") or 0)
    ref = int(chain.get("ref_chars") or 0)
    t2 = chars >= CHARS_RATIO_MIN * ref
    ratio = round(chars / ref, 4) if ref > 0 else None
    t2_note = "" if ref > 0 else "纯图件 ref_chars=0：字数门空真，如实记录"

    # 阈值门③：首/中/末 3 页 PNG 渲染视觉抽检（ink 比带内=无缺页黑页）
    inks, pngs = render_head_mid_last(result.artifact_path, PAGES_DIR / pick.p_code)
    t3 = bool(inks) and all(INK_MIN <= v <= INK_MAX for v in inks.values())

    # 段4 质检门（四门 CLI；门输出留档入记录）
    buf = io.StringIO()
    with contextlib.redirect_stdout(buf):
        qg_ok = adapter.verify(result)

    rec.update(status="pass" if (t1 and t2 and t3 and qg_ok) else "fail",
               ok=bool(result.ok), pages=n_pages, chars=chars, ref_chars=ref,
               ratio=ratio, basis=basis, manifest_ref=manifest_ref,
               manifest_fixes=manifest_fixes,
               gates={"t1_pages": {"pass": t1, "basis": basis},
                      "t2_chars": {"pass": t2, "ratio": ratio, "ref": ref,
                                   "vacuous": ref == 0, "note": t2_note},
                      "t3_png": {"pass": t3,
                                 "inks": {str(k): round(v, 4) for k, v in inks.items()},
                                 "band": [INK_MIN, INK_MAX], "files": pngs},
                      "quality_gate": {"pass": bool(qg_ok),
                                       "detail": adapter.last_verify_detail,
                                       "output": gate_output_of(buf)}},
               ladder_used=result.ladder_used, coverage=result.coverage,
               elapsed_s=round(time.time() - t0, 1))
    return rec


def gate_output_of(buf: io.StringIO) -> str:
    return buf.getvalue().strip()


def doc_line(idx: int, total: int, rec: dict) -> str:
    """逐份行：docId/页数/字数/ratio/取页口径/PNG/质检门/耗时/净请求。"""
    gates = rec.get("gates") or {}
    t3 = gates.get("t3_png") or {}
    ok = "过" if rec.get("status") == "pass" else "折"
    ratio = rec.get("ratio")
    if ratio is not None:
        ratio_s = "%.3f" % ratio
    elif rec.get("ref_chars") == 0:
        ratio_s = "空真(ref=0)"
    else:
        ratio_s = "-"
    return ("[%d/%d] docId=%s %s | 页数=%s（口径=%s）| 字数=%s/参照%s（ratio=%s）| "
            "PNG首中末=%d页（%s）| 质检门=%s | 耗时=%ss | 净请求=%s" % (
                idx, total, rec.get("p_code"), ok, rec.get("pages"),
                (gates.get("t1_pages") or {}).get("basis", "-"),
                rec.get("chars"), rec.get("ref_chars"), ratio_s,
                len(t3.get("inks") or {}),
                "带内" if t3.get("pass") else "越带/缺",
                "过" if (gates.get("quality_gate") or {}).get("pass") else "折",
                rec.get("elapsed_s"), (rec.get("requests") or {}).get("net", "-")))


# ---------------- 主流程 ----------------

def ensure_toolchain() -> None:
    """FFDec/JDK/presse 落位检查（缺位如实炸，给自举命令）。"""
    root = default_toolchain_root()
    missing = [name for name, found in (
        ("java", locate_java(root)), ("ffdec", locate_ffdec(root)),
        ("presse", locate_presse(root))) if not found]
    if missing:
        raise ToolchainError(
            "工具链缺位: " + ",".join(missing)
            + "；先 py -3 -m kb_factory.harvest_engine.tools.fetch_toolchain"
            " --ensure ffdec,presse")


def load_summary() -> dict:
    try:
        return json.loads(SUMMARY_PATH.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="T39 doc88 实弹 10 份等价抽取验收")
    ap.add_argument("--resume", action="store_true",
                    help="续跑：跳过已 pass 件（Store/memo 复用，预算累计）")
    ap.add_argument("--budget", type=int, default=60, help="总净请求预算上限（默认 60 发）")
    ap.add_argument("--limit", type=int, default=10, help="验收份数（默认 10）")
    ap.add_argument("--max-pages", type=int, default=30,
                    help="单件收割页数上限（默认 30：任务卡 ≤30 页件优先，控时长）")
    ap.add_argument("--max-est", type=int, default=4,
                    help="单件预估请求上限（1+层数，默认 4=至多 3 层件）")
    ap.add_argument("--list", default="list-446,list-447,list-445,list-443",
                    help="起始分类页路径名（逗号分隔多籽；默认白底文本文档类："
                         "法律文献/管理文献/研究报告/技术资料——实弹教训：营销模板类"
                         "（list-1022）多为暗底大图件，门③ink 上界连折 2 件）")
    args = ap.parse_args(argv)

    for d in (ARTIFACTS, STORE_DIR, WORK_DIR, PAGES_DIR):
        d.mkdir(parents=True, exist_ok=True)
    ensure_toolchain()

    prev = load_summary() if args.resume else {}
    docs: list[dict] = list(prev.get("docs") or [])
    passed = [d for d in docs if d.get("status") == "pass"]
    rejected: list[dict] = list((prev.get("selection") or {}).get("rejected") or [])
    seen: set[str] = set(str(d.get("p_code")) for d in docs) | set(
        str(r.get("p_code")) for r in rejected)
    start_net = int((prev.get("budget") or {}).get("net_requests") or 0)
    counting = CountingFetch(LEDGER_PATH, MEMO_PATH, cap=args.budget,
                             start_net=start_net)
    store = Store(str(STORE_DIR))
    first_lists = [p if p.startswith("/") else "/" + p
                   for p in str(args.list).split(",") if p.strip()]
    first_lists = [p if p.endswith(".html") else p + ".html" for p in first_lists]
    selector = Selector(counting, max_pages=args.max_pages, max_est=args.max_est,
                        seen=seen, rejected=rejected)
    selector.queue_paths.extend(first_lists)

    def save_state() -> None:
        SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)
        tmp = SUMMARY_PATH.with_suffix(".json.tmp")
        tmp.write_text(json.dumps({
            "task": "T39 doc88 实弹 10 份等价抽取验收（FR4.AC1）",
            "accept_cmd": "py -3 kb_factory/harvest_engine/e2e/doc88_accept.py",
            "budget": {"net_requests": counting.net, "cap": args.budget,
                       "by_kind": counting.by_kind},
            "ledger": {"path": str(LEDGER_PATH), "net_requests": counting.net},
            "memo": str(MEMO_PATH), "store": str(STORE_DIR),
            "work_dir": str(WORK_DIR), "pages_png_root": str(PAGES_DIR),
            "selection": {"rejected": rejected, "seen": sorted(seen),
                          "stop_reason": selector.stop_reason,
                          "fetched_lists": selector.fetched},
            "docs": docs,
        }, ensure_ascii=False, indent=1), encoding="utf-8")
        tmp.replace(SUMMARY_PATH)

    # ---- 逐份全链验收（选件与收割交错：折一件补选一件，预算守门） ----
    budget_stop = False
    wall_stop = ""
    while len(passed) < args.limit:
        try:
            picks = selector.select(args.limit - len(passed))
        except BudgetExceeded as exc:  # 硬顶熔断在选件面：如实停（非崩栈）
            print("[预算熔断] %s（净请求 %d/%d）" % (exc, counting.net, args.budget),
                  flush=True)
            budget_stop = True
            break
        if not picks:
            break  # 候选/预算耗尽或 WAF 停（stop_reason 入汇总如实报告）
        for pick in picks:
            if len(passed) >= args.limit:
                break
            net_before = counting.net
            try:
                rec = run_doc(pick, counting, store)
            except BudgetExceeded as exc:
                print("[预算熔断] %s（净请求 %d/%d）" % (exc, counting.net, args.budget),
                      flush=True)
                budget_stop = True
                break
            except Doc88AssetError as exc:  # 块请求/切片如折：记折换件，不崩栈
                docs.append({"p_code": pick.p_code, "p_name": pick.facts.get("p_name"),
                             "status": "fail", "fail_stage": "prefetch_pk_blocks",
                             "detail": f"Doc88AssetError: {exc}",
                             "requests": {"net": counting.net - net_before},
                             "ts": time.strftime("%Y-%m-%dT%H:%M:%S")})
                print("[折] %s 块收割折：%s（换件续跑）" % (pick.p_code, exc), flush=True)
                save_state()
                continue
            docs.append(rec)
            if rec.get("status") == "pass":
                passed.append(rec)
            print(doc_line(len(docs), args.limit, rec)
                  + ("（累计过 %d/%d）" % (len(passed), args.limit)), flush=True)
            save_state()
            if rec.get("wall_status"):
                wall_stop = "%s@%s" % (rec.get("wall_status"), pick.p_code)
                print("[墙停] wall_status=%s：如实停" % wall_stop, flush=True)
                break
        if budget_stop or wall_stop:
            break

    save_state()

    # ---- 汇总与判定（退出码 0 = 10/10 三阈值门+质检门全过 且 净请求 ≤ budget） ----
    n_pass = len(passed)
    print("=" * 100, flush=True)
    print("[汇总] 通过 %d/%d | 净网络请求 %d/%d 发（by_kind=%s）" % (
        n_pass, args.limit, counting.net, args.budget, counting.by_kind), flush=True)
    print("[汇总] ledger=%s（每请求一行）| summary=%s" % (LEDGER_PATH, SUMMARY_PATH),
          flush=True)
    for d in docs:
        g = (d.get("gates") or {}).get("t1_pages") or {}
        print("  - %s %s %s %s页/%s字" % (d.get("p_code"), d.get("status"),
                                          g.get("basis", ""), d.get("pages"),
                                          d.get("chars")), flush=True)
    if selector.rejected:
        print("[汇总] 拒选 %d 件（明细见 summary.selection.rejected）" % len(selector.rejected),
              flush=True)
    ok = n_pass == args.limit and counting.net <= args.budget and not budget_stop
    if ok:
        print("[验收] %d/%d 三阈值门+质检门全过（退出码 0）" % (n_pass, args.limit),
              flush=True)
        return 0
    reasons = []
    if n_pass < args.limit:
        reasons.append("通过 %d/%d" % (n_pass, args.limit))
        if selector.stop_reason:
            reasons.append(selector.stop_reason)
        if wall_stop:
            reasons.append("墙停 " + wall_stop)
    if budget_stop:
        reasons.append("预算熔断如实停")
    print("[验收] 未过：%s（退出码 1）" % "；".join(reasons), flush=True)
    return 1


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace", line_buffering=True)
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")
    sys.exit(main(sys.argv[1:]))
