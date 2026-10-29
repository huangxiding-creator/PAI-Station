# -*- coding: utf-8 -*-
"""T38 验收件：wenku 实弹 10 份三型渲染 + 边界 + needs_vip_candidate 验收（FR2.AC2/AC3/AC4+FR2.3）。

验收口径（任务卡）：
- **FR2.AC2**（10 份三型+质检门）：SYNTHESIS §3-W1 加严参考 3/3/2 → 按类型分布采样修订为
  **6/2/2**（裁定依据：T26/T31/T35 三轮探针 60+60+18 份检索面全 type3，类型1/2 真件
  今日站方在架寻不得——修订过程与采样证据记 ledger ``quota_revision`` 行）：
  - 类型3 真件 ≥6 份**全真**验收（真 docId→ndview 真取 readerInfo→三腿真资产→printToPDF）；
  - 类型2 ≥2 份走 T31 合成口径（**真 readerInfo**（真 docId 真链采集）+ **真 wenku CDN 图
    直链**组 htmlUrls 数组，图片腿真下载真判件——站方检索面全量 html_view 化，真类型2
    寻件困难，口径逐份如实记录）；
  - 类型1 ≥2 份走 T35 组合口径（editor 腿=离线 fixture 页 route 本地 fulfill + **真 Chromium
    真节拍**跑 §7.4 全时序≈30.5s；XML 降级腿=**真实 wkrtcs getbdjson 端点**合成令牌实弹，
    端点实测 200+rtcs(params error) 如实记零桶——口径逐份如实记录）；
  - 10/10 过质检门（NFR-GATE 四门；类型3 由本件补写 manifest：ref_chars=pageJson 实测、
    ref_chars_source=type3；部分收割件走 preview_limit=部分收割合法形态）。
- **FR2.AC3**（边界两件）：>400 页真件（syncmrecall 大页数词实测检索 1160 页件）按 §8-2
  拒绝并提示「超出最大支持页数 400 页，暂不支持下载」；无效 docId（构造 40-hex）报
  「无法提取 pageData」（ndview 实测 200 空壳页→§8-1 文案；view 页 403 同源证据
  WENKU_SPEC §6.1 在案）。
- **FR2.AC4+FR2.3**（≥2 份 VIP 专享件，非 VIP 匿名）：①ab57a08d…（T22 实弹过：showPage=2/
  page=20 连续 3 轮零推进→needs_vip_candidate，_t22_live_audit.jsonl 在案）**复用** T22 墙
  证据 + 本 run 重取 readerInfo（2/20 复现）+ 真资产产部分覆盖 PDF；②再选 1 件 Q1 检索面
  VIP 墙件（真 signer 补页 3 轮零推进→断言 needs_vip_candidate+部分覆盖 PDF+coverage
  showPage/page 如实）。
- **预算**：净网络请求 ≤ --budget（默认 40）发，Store 字节缓存复用（--resume 断点续跑缓存
  命中零重下）；每一真发/缓存命中如实一行入 ledger（e2e/artifacts/wenku_accept_ledger.jsonl）。
  汇总落 e2e/artifacts/wenku_accept_summary.json。退出码 0=三 AC 全过且净请求 ≤ 预算。

预算模型（数字零造假，2026-10-22 校准）：检索 2 发 + 探针（选件 ndview，缓存即收割复用）
≤10 发 + VIP 墙件补页 3 发 + 6×类型3 资产（选 png 缺席件≈2 发/件）+ VIP 部分件资产 4~6+2
发 + 类型2 CDN 图 2 发 + 类型1 XML 端点 1~2 发 + 边界 3 发 ≈ 38~40 发；超预算如实停
（BudgetExceeded 熔断，退出码 1）。

命令：py -3 kb_factory/harvest_engine/e2e/wenku_accept.py [--resume] [--budget 40]
"""
from __future__ import annotations

import argparse
import json
import os
import re
import sys
import time
from pathlib import Path

_E2E_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(_E2E_DIR.parents[2]))  # 仓库根（kb_factory 包导入）

from kb_factory.channel_adapters.base import FileMeta  # noqa: E402
import kb_factory.channel_adapters.wenku_meta as _wm  # noqa: E402
from kb_factory.harvest_engine import quality_gate  # noqa: E402
from kb_factory.harvest_engine.adapters.base import (  # noqa: E402
    WALL_NEEDS_VIP_CANDIDATE, mark_wall_status)
from kb_factory.harvest_engine.adapters.wenku import (  # noqa: E402
    DOC_ID_RE, NDVIEW_URL_TMPL, WENKU_PAGE_LIMIT, ReaderInfoLegResult,
    WenkuDownloadAdapter, WenkuPageDataError, canonical_view_url,
    fetch_page_data, fetch_xml_blocks, html_urls_to_pages, judge_doc_type,
    reader_show_pages, reader_total_pages, sanitize_title, _httpx_fetch_asset,
    _httpx_fetch_html, _view_headers)
from kb_factory.harvest_engine.audit import HarvestAudit  # noqa: E402
from kb_factory.harvest_engine.parse.inline_var import extract_page_data  # noqa: E402
from kb_factory.harvest_engine.store.ledger import Store  # noqa: E402

ARTIFACTS = _E2E_DIR / "artifacts"
SUMMARY_PATH = ARTIFACTS / "wenku_accept_summary.json"
LEDGER_PATH = ARTIFACTS / "wenku_accept_ledger.jsonl"
STORE_DIR = ARTIFACTS / "wenku_store"
OUT_DIR = ARTIFACTS / "wenku_out"
PAGES_DIR = ARTIFACTS / "wenku_pages"
FIXTURES = _E2E_DIR.parent / "tests" / "fixtures"
T22_AUDIT = FIXTURES / "_t22_live_audit.jsonl"

#: 配额裁定（任务卡）：SYNTHESIS §3-W1 参考 3/3/2 → 修订 6/2/2（检索面全 type3 实况）。
QUOTA = {"type3": 6, "type2": 2, "type1": 2}
#: 检索词（2026-10-22 校准：Q1=12/12 小件（10×1页）；Q2 含 1160 页大件；
#: FALLBACK=「(完整版)」族墙件词（T26 实弹墙件 6657e2be 2/3 同族），Q1 无墙件时兜底）。
QUERY_SMALL = "水利工程施工组织设计内容包括"
QUERY_BIG = "理论力学教材"
QUERY_FALLBACK = "水利施工组织设计"
#: T22 实弹复用件（showPage=2/page=20 连续3轮零推进→needs_vip_candidate，_t22_live_audit 在案）。
VIP_REUSE_DOC_ID = "ab57a08dd6bbfd0a79563c1ec5da50e2524dd18e"
#: 无效 docId（40-hex 形态合法、内容无效；实弹实测 ndview 回 200 空壳页→§8-1 文案）。
INVALID_DOC_ID = "0123456789abcdef0123456789abcdef01234567"
#: >400 页大件（T38 工人会话 syncmrecall 校准实测发现：词「理论力学教材」12 条含
#: 1160 页件——预算紧时脚本内直探此 docId 并在 ledger 引用该发现，ndview 现场验真）。
BIG_DOC_ID = "88b59688320cba1aa8114431b90d6c85ed3a8873"
#: 类型1 组合口径合成 docId（T35 40-hex 合成形态惯例）+ 确定性 getbdjson 时钟（共用一份）。
T1_DOC_IDS = ("5f31c0de11a1b2c3d4e5f60718293a4b5c6d7e8f",
              "7e53a1cf22b4c5d6e7f80718293a4b5c6d7e8f90")
T1_XML_NOW_MS = 1780000000000
#: 类型2 合成口径图源：ndview 页静态资产图直链（edu-wenku.bdimg.com=wenku 自有 CDN；T31 同源）。
_CDN_IMG_RE = re.compile(
    r"https://edu-wenku\.bdimg\.com/v1/wkSmallApp/continueRead/[A-Za-z0-9/._-]+?\.png")
_CDN_IMG_FALLBACK_RE = re.compile(
    r"https://edu-wenku\.bdimg\.com/v1/pc/[A-Za-z0-9/._-]+?\.png")

GATE_OK_N = len(quality_gate.GATES)  # 四门


class BudgetExceeded(RuntimeError):
    """净请求预算硬顶熔断（超预算如实停，不静默继续）。"""


def _put_retry(store: Store, key: str, data: bytes, *, doc: str) -> str:
    """Store.put_asset 竞态重试（Windows 杀软/索引器短暂锁 → WinError 5；doc88 同型）。"""
    for i in range(12):
        try:
            return store.put_asset(key, data, doc=doc)
        except PermissionError:
            if i == 11:
                raise
            time.sleep(0.25)


class NetCache:
    """真网络腿计数+Store 字节缓存（委托真符号非 mock）：net 只计真发；缓存命中零网络。

    三条注入面（与 doc88 CountingFetch 同构造思想，改字节缓存主责给 Store）：
    - ``text_leg``：fetch_html 注入面（ndview 初始腿）；
    - ``asset_leg``：asset_fetch 注入面（类型3 三腿/类型2 图片腿/类型1 getbdjson 桶腿）；
    - ``search``：wenku_meta._fetch 注入面（syncmrecall 检索）。
    仅 2xx 入缓存（403/WAF 体不固化）；硬顶熔断 BudgetExceeded。
    """

    def __init__(self, store: Store, ledger_path: Path, *, cap: int, start_net: int = 0):
        self.store = store
        self.cap = int(cap)
        self.net = int(start_net)
        self.by_kind: dict[str, int] = {}
        self.cache_hits = 0
        self.current = "-"
        self._audit = HarvestAudit(path=str(ledger_path))

    # ---- 核心：取缓存/真发/落账 ----
    def _guard(self, what: str):
        if self.net + 1 > self.cap:
            raise BudgetExceeded(
                f"预算硬顶：net={self.net}+1 > cap={self.cap}（{what}）")

    def _log(self, kind: str, url: str, status: int, n: int, ms: int, *, net: bool):
        if net:
            self.by_kind[kind] = self.by_kind.get(kind, 0) + 1
        else:
            self.cache_hits += 1
        self._audit.request(
            site="wenku", event=kind, query_or_docid=self.current, count=n,
            status="ok" if 200 <= status < 300 else "fail",
            detail=(f"http={status} bytes={n} elapsed_ms={ms} "
                    f"net={'true' if net else 'false'}"
                    + ("" if net else " cache=store") + f" url={url[:180]}"))

    def _cached(self, key: str, kind: str, url: str) -> bytes | None:
        data = self.store.get_asset(key)
        if data is not None:
            self._log(kind, url, 200, len(data), 0, net=False)
            return data
        return None

    def _fetch_cached(self, key: str, kind: str, url: str, real_fetch, *, ok_check):
        """缓存优先→真发→2xx 落 Store。real_fetch() → (status, payload)（真 status 透传，
        零造假：非 2xx 的真实状态码原样返回调用方入报错文案）；ok_check 判 2xx。

        返回 (data|None, true_status)：命中=(bytes, 200)；真发 2xx=(bytes, status)；
        真发非 2xx=(None, status)（不固化）。
        """
        hit = self._cached(key, kind, url)
        if hit is not None:
            return hit, 200
        self._guard(url[:80])
        t0 = time.time()
        status, payload = real_fetch()
        self.net += 1
        body = payload if isinstance(payload, (bytes, bytearray)) else str(payload).encode(
            "utf-8", "replace")
        self._log(kind, url, status if isinstance(status, int) else 0, len(body),
                  int((time.time() - t0) * 1000), net=True)
        if ok_check(status):
            _put_retry(self.store, key, bytes(body), doc=self.current)
            return bytes(body), status
        return None, status  # 非 2xx 不固化（零造假：不产假缓存）

    # ---- 注入面①：fetch_html（ndview） ----
    def text_leg(self, url: str, headers: dict, timeout: float) -> tuple[int, str]:
        data, status = self._fetch_cached(
            "ndview:" + url, "ndview", url,
            lambda: _httpx_fetch_html(url, headers, timeout),
            ok_check=lambda st: st == 200)
        if data is None:
            return status, ""  # 真实状态透传（fetch_page_data 文案如实入账）
        return status, data.decode("utf-8", "replace")

    def get_ndview_html(self, doc_id: str, timeout: float = 20.0) -> str:
        """探针/复用件直取 ndview HTML（同一缓存键——探针即收割，零重复发）。"""
        status, html = self.text_leg(NDVIEW_URL_TMPL.format(doc_id=doc_id),
                                     _view_headers(None, ""), timeout)
        return html if status == 200 else ""

    # ---- 注入面②：asset_fetch（三型资产腿） ----
    def asset_leg(self, url: str, headers: dict, timeout: float, *, binary: bool = False):
        kind = ("img" if "/wkSmallApp/" in url or "/v1/pc/" in url
                else "xml" if "wkrtcs" in url
                else "ttf" if "wkretype" in url
                else "json" if ".json" in url else "png")
        data, status = self._fetch_cached(
            "asset:" + url, kind, url,
            lambda: _httpx_fetch_asset(url, headers, timeout, binary=binary),
            ok_check=lambda st: isinstance(st, int) and 200 <= st < 300)
        if data is None:
            return (status, b"" if binary else "")
        return (status, data if binary else data.decode("utf-8", "replace"))

    # ---- 注入面③：syncmrecall 检索（wenku_meta._fetch 单一定义点） ----
    def search(self, word: str, pn: int, timeout: float):
        def _real():
            try:  # 真符号委托（urllib POST→dict→(200, bytes)；网络异常如实 (0, b"")）
                return 200, json.dumps(_wm._urllib_fetch(word, pn, timeout),
                                       ensure_ascii=False).encode("utf-8")
            except Exception:
                return 0, b""

        raw, _ = self._fetch_cached(
            f"search:{word}|pn{pn}", "syncmrecall", f"{_wm._URL}?word={word}&pn={pn}",
            _real, ok_check=lambda st: st == 200)
        return json.loads(raw.decode("utf-8", "replace")) if raw else None

    # ---- 补页腿（真 signer 经 Chromium，无法走 httpx 缓存：逐发计数） ----
    def count_acs(self, doc_id: str, pn: int) -> None:
        self._guard(f"acs_readerinfo doc={doc_id} pn={pn}")
        self.net += 1
        self.by_kind["acs_fill"] = self.by_kind.get("acs_fill", 0) + 1
        self._audit.request(
            site="wenku", event="acs_fill", query_or_docid=doc_id, count=1,
            status="ok", detail=f"signed fetch_readerinfo pn={pn} net=true "
            f"（Chromium 签名窗腿，浏览器内发，无字节缓存）")


class CountingSigner:
    """PageSigner 计数代理（鸭子型透传）：fetch_readerinfo 每发=net+1+ledger 行+硬顶守门。"""

    def __init__(self, inner, cache: NetCache):
        self._inner = inner
        self._cache = cache

    def fetch_readerinfo(self, doc_id: str, *, pn: int = 1, rn: int = 50, referer: str = ""):
        self._cache.count_acs(doc_id, pn)
        return self._inner.fetch_readerinfo(doc_id, pn=pn, rn=rn, referer=referer)

    def __getattr__(self, name):  # closed/context/ready 等真 signer 属性透传
        return getattr(self._inner, name)


# ---------------- 选件：探针分类（ndview 缓存即收割） ----------------

def probe_classify(doc_id: str, html: str) -> dict | None:
    """ndview HTML → 分类事实（型/页数/游标/桶长/CDN 图池）；坏页如实 None。"""
    page_data = extract_page_data(html) if isinstance(html, str) else None
    if not isinstance(page_data, dict) or not isinstance(page_data.get("readerInfo"), dict):
        return None
    ri = page_data["readerInfo"]
    hu = ri.get("htmlUrls")
    hu = hu if isinstance(hu, dict) else {}
    imgs = _CDN_IMG_RE.findall(html) or _CDN_IMG_FALLBACK_RE.findall(html)
    page = reader_total_pages(ri)
    show = reader_show_pages(ri)
    return {
        "doc_id": doc_id,
        "title": str(page_data.get("title") or ""),
        "type": judge_doc_type(ri),
        "page": page,
        "show_page": show,
        "full": page > 0 and show >= page,
        "vip_wall": page > 0 and 0 < show < page,
        "over_limit": page > WENKU_PAGE_LIMIT,
        "json_len": len(hu.get("json") or []),
        "png_len": len(hu.get("png") or []),
        "ttf_len": len(hu.get("ttf") or []),
        "rtcs_len": len(ri.get("rtcsRangeInfo") or []),
        "cdn_imgs": list(dict.fromkeys(imgs))[:8],
    }


def select_pieces(metas: list[FileMeta], cache: NetCache, state: dict,
                  *, probe_cap: int = 10) -> dict:
    """Q1 候选 → 探针分类 → 确定性选件（排序键=(pages, doc_id) 保证 --resume 同选）。

    选件目标：类型3 全真配额 6（全免费+页数≤2+png 缺席优先，补页零 signer）+
    VIP 墙件 1（showPage<page 小件）+ 类型2 合成基件 2（配额落选的全免费件复用探针）。
    每发探针即该件收割 ndview（缓存复用，零重复发）；类型分布逐份记 quota 采样台账。
    """
    cands = []
    for m in metas:
        did = (m.extra.get("doc_id") or "")
        if isinstance(did, str) and DOC_ID_RE.match(did):
            cands.append({"doc_id": did, "pages": int(m.pages or 99),
                          "title": m.title, "perm": m.perm})
    cands.sort(key=lambda c: (c["pages"], c["doc_id"]))  # 小件优先+确定性
    seen_types: dict[str, int] = {}
    probes: list[dict] = []
    quota_pool, wall_pool, base_pool = [], [], []
    for c in cands:
        if len(quota_pool) >= QUOTA["type3"] and wall_pool and len(base_pool) >= QUOTA["type2"]:
            break
        if len(probes) >= probe_cap:  # 探针硬顶（预算自律；缺口由调用方兜底腿补）
            break
        cache.current = c["doc_id"]
        time.sleep(0.6)  # §9 速率自律（探针间隔）
        html = cache.get_ndview_html(c["doc_id"])
        info = probe_classify(c["doc_id"], html)
        probes.append(info or {"doc_id": c["doc_id"], "type": "unparseable"})
        if info is None:
            continue
        seen_types[info["type"]] = seen_types.get(info["type"], 0) + 1
        if info["over_limit"]:
            continue
        if info["vip_wall"] and not wall_pool:
            wall_pool.append({**info, "perm": c["perm"]})   # VIP 墙件（AC4 第②件）
            continue
        if (info["type"] == "type3" and info["full"] and info["page"] <= 2
                and len(quota_pool) < QUOTA["type3"]):
            quota_pool.append(info)                          # 类型3 全真配额
            continue
        if info["full"] and len(base_pool) < QUOTA["type2"] and info["cdn_imgs"]:
            base_pool.append(info)                           # 类型2 合成基件（真 readerInfo）
    state.setdefault("selection", {})["probes"] = [
        {k: p.get(k) for k in ("doc_id", "type", "page", "show_page", "full", "vip_wall")}
        for p in probes]
    state["selection"]["seen_types"] = seen_types
    return {"quota": quota_pool, "wall": wall_pool, "bases": base_pool,
            "probe_count": len(probes)}


# ---------------- 类型1 editor fixture 页（T35 组合口径：真 Chromium 真节拍） ----------------

def _t1_fixture_html(slot: str, n_pre: int = 8, n_post: int = 8) -> str:
    """离线 .ql-editor fixture 页（任务卡口径）：三文案展开挂容器（els[0]=外层容器，
    真实站点同型委托——T35 实弹同缝）+ ql-editor 初始段落；点击容器追加 post 段落。"""
    pre = "".join(
        f"<p>水利工程施工组织设计内容包括{slot}编号第{i}段：导流、截流、度汛与现场平面布置"
        f"是施工组织设计的核心内容，须结合水文气象条件与工期目标综合论证。</p>"
        for i in range(1, n_pre + 1))
    post_lines = [f"展开后新增段落{slot}-{i}：进度计划横道图、资源需用量曲线与场地临建布置"
                  f"应随主体工程施工阶段动态调整并留档备查。" for i in range(1, n_post + 1)]
    post_js = json.dumps(post_lines, ensure_ascii=False)
    return f"""<!doctype html><html><head><meta charset="utf-8"><title>T38 fixture {slot}</title></head>
<body>
<div id="expand-wrap" onclick="expandFn()"><span>查看剩余全文</span></div>
<div class="ql-editor" id="qled">{pre}</div>
<script>
function expandFn() {{
  var q = document.querySelector('.ql-editor');
  {post_js}.forEach(function (t) {{
    var p = document.createElement('p'); p.textContent = t; q.appendChild(p);
  }});
  document.getElementById('expand-wrap').style.display = 'none';
}}
</script>
</body></html>"""


def _fixture_route_handler(body: str):
    """route handler 工厂（单参 def——本 Playwright 版按 handler 形参个数切片实参，
    lambda 双参会把 request 对象错绑进 body 位，T35 单参 def 同型）。"""
    def _handle(route):
        route.fulfill(status=200, content_type="text/html; charset=utf-8", body=body)
    return _handle


def _t1_synth_reader_info(slot: str) -> dict:
    """类型1 合成 readerInfo（T35 组合口径：真 XML 端点实弹的合成令牌形态）。"""
    return {"showPage": 1, "page": 1, "tplKey": "editor", "htmlUrls": [],
            "rtcsRangeInfo": [{"page": 1, "range": f"t38-{slot}-range-0"}],
            "bucketNum": f"t38{slot}", "rsign": f"t38-{slot}-rsign",
            "md5sum": f"t38{slot}md5"}


def _t1_xml_reader_info() -> dict:
    """XML 端点腿共用合成令牌（两件同一 URL → 第二件 Store 缓存命中零重发；端点
    transport 证据=一次真发实测，令牌本为合成、件间无独立性可失）。"""
    return {"showPage": 1, "page": 1, "tplKey": "editor", "htmlUrls": [],
            "rtcsRangeInfo": [{"page": 1, "range": "t38-xml-shared-range-0"}],
            "bucketNum": "t38xml", "rsign": "t38-xml-rsign", "md5sum": "t38xmlmd5"}


def _bundle(doc_id: str, reader_info: dict, *, title_raw: str, page: int, show_page: int,
            stop_kind: str, wall_status: str | None = None, detail: str = "") -> ReaderInfoLegResult:
    """手工组装 ReaderInfoLegResult（类型1 合成件/VIP 复用件——字段全实测或如实引用）。"""
    return ReaderInfoLegResult(
        doc_id=doc_id, title_raw=title_raw, title_clean=sanitize_title(title_raw, doc_id),
        page=page, show_page=show_page, page_data={"title": title_raw, "readerInfo": reader_info},
        reader_info=reader_info, fill_needed=show_page < page, fill=None, stop_kind=stop_kind,
        tri_cap_seen=False, html_urls_pages=html_urls_to_pages(reader_info.get("htmlUrls")),
        wall_status=wall_status, coverage=f"{show_page}/{page}", detail=detail)


# ---------------- 质检门（类型3 补写 manifest；类型2/1 复用适配器 manifest） ----------------

def _gate_record(manifest: dict, pages_dir: Path) -> dict:
    """写 manifest→schema 校验→四门真跑（render_dir 留档抽帧 PNG）→门结果记录。

    manifest 参照不合格（如 ref_chars<1）= 四门实测不可得 → 如实 fail（不崩栈）。
    """
    pages_dir.mkdir(parents=True, exist_ok=True)
    manifest = dict(manifest)
    manifest["pages_render_dir"] = str(pages_dir)
    mpath = pages_dir / "manifest.json"
    mpath.write_text(json.dumps(manifest, ensure_ascii=False, indent=1), encoding="utf-8")
    try:
        checked = quality_gate.load_manifest(mpath)
    except ValueError as exc:
        return {"pass": False, "gates": "schema_fail",
                "detail": [f"manifest 不合格：{exc}"],
                "manifest_ref": "-"}
    outcomes = quality_gate.run_gate(checked, render_dir=pages_dir)
    return {"pass": all(o.passed for o in outcomes),
            "gates": "/".join(f"{o.name}:{'P' if o.passed else 'F'}" for o in outcomes),
            "detail": [o.detail for o in outcomes],
            "manifest_ref": ("expected_pages" if manifest.get("expected_pages")
                             else "preview_limit")}


def _find_manifest(out_dir: Path, stem: str) -> dict | None:
    p = out_dir / f"{stem}_manifest.json"
    if not p.is_file():
        return None
    return json.loads(p.read_text(encoding="utf-8"))


# ---------------- 单件 runners ----------------

def _meta_of(info: dict, *, perm: str = "yellow") -> FileMeta:
    return FileMeta(title=info.get("title") or info["doc_id"], fmt="doc",
                    pages=info.get("page"), perm=perm,
                    source_url=canonical_view_url(info["doc_id"]),
                    extra={"doc_id": info["doc_id"]})


def run_render_piece(adapter: WenkuDownloadAdapter, cache: NetCache, slot: str,
                     meta: FileMeta, *, kind: str, save) -> dict:
    """通用收割+门件：fetch_ladder 全链（缓存注入）→ 质检门四门 → 记录+逐行输出。"""
    t0 = time.time()
    net0 = cache.net
    out = OUT_DIR / slot
    cache.current = meta.extra["doc_id"]
    result = adapter.fetch_ladder(adapter.plan(meta), fetch_html=cache.text_leg,
                                  asset_fetch=cache.asset_leg, out_dir=out,
                                  asset_min_interval=0.5)
    bundle = adapter.last_reader_info
    rec = {"slot": slot, "doc_id": meta.extra["doc_id"], "kind": kind,
           "title": bundle.title_clean, "page": bundle.page, "show_page": bundle.show_page,
           "coverage": bundle.coverage, "result_ok": bool(result.ok),
           "pages": result.pages, "chars": result.chars,
           "artifact_path": result.artifact_path, "wall_status": result.wall_status,
           "approach": save.get("approach", "real-full"),
           "detail": result.detail, "net": cache.net - net0}
    if not result.ok or not result.artifact_path:
        rec.update(status="fail", fail_stage="fetch_ladder")
        _print_line(rec)
        return rec
    if kind == "type3":  # 类型3 manifest 本件补写（ref=pageJson 实测；部分收割=preview_limit）
        manifest = {"pdf_path": result.artifact_path, "ref_chars": int(result.chars or 0),
                    "ref_chars_source": "type3"}
        if result.pages == bundle.page:
            manifest["expected_pages"] = bundle.page
        else:
            manifest["preview_limit"] = int(result.pages or 0)
        gate = _gate_record(manifest, PAGES_DIR / slot)
    else:                # 类型2/1：适配器已落 manifest（ref_chars_source=type2/type1）
        manifest = _find_manifest(out, bundle.title_clean or meta.extra["doc_id"])
        if manifest is None:
            found = sorted(out.glob("*_manifest.json"))
            manifest = (json.loads(found[0].read_text(encoding="utf-8"))
                        if found else None)
        if manifest is None:
            rec.update(status="fail", fail_stage="manifest_missing")
            _print_line(rec)
            return rec
        gate = _gate_record(manifest, PAGES_DIR / slot)
    rec.update(status="pass" if gate["pass"] else "fail",
               gate=gate["gates"], gate_pass=gate["pass"], manifest_ref=gate["manifest_ref"],
               ref_chars_source=manifest.get("ref_chars_source"),
               elapsed_s=round(time.time() - t0, 1))
    _print_line(rec)
    return rec


def _print_line(rec: dict, *, note: str = ""):
    """逐份行：docId/型/页数/字数/gate/口径/耗时/净请求（任务卡口径）。"""
    ok = "过" if rec.get("status") == "pass" else "折"
    print("[%s] docId=%s 型=%s | %s | 页数=%s/%s | 字数=%s | gate=%s | 口径=%s | "
          "耗时=%ss | 净请求=%s%s" % (
              rec.get("slot", "-"), str(rec.get("doc_id"))[:20], rec.get("kind", "-"), ok,
              rec.get("pages"), rec.get("page"),
              rec.get("chars"), rec.get("gate", "-"), rec.get("approach", "-"),
              rec.get("elapsed_s", "-"), rec.get("net", "-"),
              (" | " + note) if note else ""), flush=True)


# ---------------- T22 复用证据 ----------------

def t22_wall_evidence() -> dict | None:
    """读 _t22_live_audit.jsonl：VIP_REUSE_DOC_ID 的 wall_status 行（真网络证据 2026-10-22）。"""
    try:
        rows = [json.loads(x) for x in T22_AUDIT.read_text(encoding="utf-8").splitlines() if x]
    except (OSError, ValueError):
        return None
    wall = [r for r in rows if r.get("query_or_docid") == VIP_REUSE_DOC_ID
            and r.get("event") == "wall_status"]
    fill = [r for r in rows if r.get("query_or_docid") == VIP_REUSE_DOC_ID
            and r.get("event") == "readerinfo_fill"]
    if not wall:
        return None
    return {"wall": wall[-1], "fill": fill[-1] if fill else None,
            "ts": wall[-1].get("ts"), "ledger": str(T22_AUDIT)}


# ---------------- 主流程 ----------------

def load_summary() -> dict:
    try:
        return json.loads(SUMMARY_PATH.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(description="T38 wenku 实弹 10 份三型+边界+needs_vip_candidate 验收")
    ap.add_argument("--resume", action="store_true", help="续跑：跳过已 pass 件（Store 缓存复用）")
    ap.add_argument("--budget", type=int, default=40, help="总净请求预算上限（默认 40 发）")
    args = ap.parse_args(argv)

    for d in (ARTIFACTS, STORE_DIR, OUT_DIR, PAGES_DIR):
        d.mkdir(parents=True, exist_ok=True)
    prev = load_summary() if args.resume else {}
    state = prev if prev else {"task": "T38 wenku 实弹验收（FR2.AC2/AC3/AC4+FR2.3）",
                               "accept_cmd": "py -3 kb_factory/harvest_engine/e2e/wenku_accept.py"}
    docs: list[dict] = list(state.get("docs") or [])
    passed_slots = {d["slot"] for d in docs if d.get("status") == "pass"}
    extra: dict = dict(state.get("extra") or {})
    start_net = int((state.get("budget") or {}).get("net_requests") or 0)
    store = Store(str(STORE_DIR))
    cache = NetCache(store, LEDGER_PATH, cap=args.budget, start_net=start_net)
    adapter = WenkuDownloadAdapter(audit=HarvestAudit(path=str(LEDGER_PATH)),
                                   fill_min_interval=1.0)

    def save():
        # --resume 重跑折件按 slot 去重（保末次），文档序=slot 字典序（稳定可读）
        uniq = {d.get("slot"): d for d in docs}
        state["docs"] = [uniq[s] for s in sorted(uniq)]
        state["extra"] = extra
        state["budget"] = {"net_requests": cache.net, "cap": args.budget,
                           "by_kind": cache.by_kind, "cache_hits": cache.cache_hits}
        state["ledger"] = str(LEDGER_PATH)
        state["store"] = str(STORE_DIR)
        SUMMARY_PATH.parent.mkdir(parents=True, exist_ok=True)
        tmp = SUMMARY_PATH.with_suffix(".json.tmp")
        tmp.write_text(json.dumps(state, ensure_ascii=False, indent=1), encoding="utf-8")
        tmp.replace(SUMMARY_PATH)

    def skip(slot: str) -> bool:
        return slot in passed_slots

    budget_stop = ""
    try:
        # ========== ①检索+选件（Q1 小件面） ==========
        cache.current = "search:" + QUERY_SMALL
        time.sleep(3.2)  # syncmrecall 限速自律（KB_WENKU_MIN_INTERVAL=3）
        _orig_fetch = _wm._fetch
        _wm._fetch = cache.search  # 单一定义点注入（真符号委托+缓存）
        try:
            metas = _wm.WenkuMetaAdapter().metadata(QUERY_SMALL, 12)
        finally:
            _wm._fetch = _orig_fetch
        print("[选件] Q1=%s → %d 条候选" % (QUERY_SMALL, len(metas)), flush=True)
        sel = select_pieces(metas, cache, state, probe_cap=10)
        if not sel["wall"]:  # Q1 未现 VIP 墙件 → 兜底腿：换词检索「(完整版)」族（T26 墙件同族）
            cache.current = "search:" + QUERY_FALLBACK
            time.sleep(3.2)
            _wm._fetch = cache.search
            try:
                fmetas = _wm.WenkuMetaAdapter().metadata(QUERY_FALLBACK, 12)
            finally:
                _wm._fetch = _orig_fetch
            fcands = sorted((m for m in fmetas
                             if 3 <= (m.pages or 0) <= 12
                             and isinstance(m.extra.get("doc_id"), str)
                             and DOC_ID_RE.match(m.extra["doc_id"])),
                            key=lambda m: (m.pages, m.extra["doc_id"]))
            for fc in fcands[:3]:  # ≤3 探（预算自律）：找 showPage<page 墙件
                cache.current = fc.extra["doc_id"]
                time.sleep(0.6)
                info = probe_classify(fc.extra["doc_id"],
                                      cache.get_ndview_html(fc.extra["doc_id"]))
                if info and info["vip_wall"] and not info["over_limit"]:
                    info["perm"] = fc.perm
                    sel["wall"].append(info)
                    print("[选件] 兜底腿命中 VIP 墙件 %s（showPage=%d/page=%d）" % (
                        info["doc_id"], info["show_page"], info["page"]), flush=True)
                    break
        state["selection"] = state.get("selection") or {}
        state["selection"]["picked"] = {
            "quota": [q["doc_id"] for q in sel["quota"]],
            "wall": [w["doc_id"] for w in sel["wall"]],
            "bases": [b["doc_id"] for b in sel["bases"]]}
        save()

        # ========== ②配额修订记 ledger（30 份采样证据=T26/T31/T35 探针档+本 run 探针） ==========
        prior = {}
        for name, path in (("T26", FIXTURES / "_t26_probe_type3.json"),
                           ("T31", FIXTURES / "_t31_probe_type2.json"),
                           ("T35", FIXTURES / "_t35_probe_type1.json")):
            try:
                rows = json.loads(path.read_text(encoding="utf-8")).get("rows") or []
                types = {}
                for r in rows:
                    types[r.get("type")] = types.get(r.get("type"), 0) + 1
                prior[name] = {"n": len(rows), "types": types}
            except (OSError, ValueError):
                prior[name] = {"n": 0, "types": {}}
        prior_n = sum(v["n"] for v in prior.values())
        cache._audit.request(
            site="wenku", event="quota_revision", query_or_docid="-",
            count=prior_n + sel["probe_count"], status="6/2/2",
            detail=(f"SYNTHESIS §3-W1 参考 3/3/2 → 修订 6/2/2（任务卡裁定）：类型分布采样 "
                    f"{prior_n}(T26/T31/T35 探针档 {prior}) + 本run {sel['probe_count']} 探 "
                    f"{state['selection'].get('seen_types')}；检索面 60+ 探全 type3 → "
                    f"type3 真件≥6 全真 / type2=T31 合成口径(真readerInfo+真CDN图) / "
                    f"type1=T35 组合口径(fixture真节拍+真XML端点)"))

        # ========== ③FR2.AC2：类型3 全真配额 ×6 ==========
        for i, info in enumerate(sel["quota"], 1):
            slot = "t3-%d" % i
            if skip(slot):
                continue
            meta = _meta_of(info)
            docs.append(run_render_piece(adapter, cache, slot, meta, kind="type3",
                                         save={"approach": "real-full"}))
            save()

        # ========== ④FR2.AC4 件①：ab57a08d T22 复用（墙证据引用+真资产部分覆盖 PDF） ==========
        if not skip("vip-reuse"):
            t0 = time.time()
            net0 = cache.net
            ev = t22_wall_evidence()
            assert ev, "T22 复用证据缺失（fixtures/_t22_live_audit.jsonl 无 wall_status 行）"
            cache.current = VIP_REUSE_DOC_ID
            html = cache.get_ndview_html(VIP_REUSE_DOC_ID)
            pd = extract_page_data(html)
            assert isinstance(pd, dict) and isinstance(pd.get("readerInfo"), dict), (
                "VIP 复用件 ndview 挖取失败（零造假：如实折）")
            ri = pd["readerInfo"]
            page, show = reader_total_pages(ri), reader_show_pages(ri)
            meta = _meta_of({"doc_id": VIP_REUSE_DOC_ID, "title": str(pd.get("title") or ""),
                             "page": page})
            mark_wall_status(meta, WALL_NEEDS_VIP_CANDIDATE)
            meta.perm = (meta.perm + "|" if meta.perm else "") + \
                "needs_vip_candidate(复用:T22 实弹 showPage=2/page=20 连续3轮零推进)"
            bundle = _bundle(VIP_REUSE_DOC_ID, ri, title_raw=str(pd.get("title") or ""),
                             page=page, show_page=show, stop_kind="no_progress",
                             wall_status=WALL_NEEDS_VIP_CANDIDATE,
                             detail="T22 实弹复用（%s：fill stop=no_progress 连续3轮零推进 "
                                    "showPage=2/page=20 tri_cap=no）" % ev["ts"])
            cache._audit.request(
                site="wenku", event="wall_status", query_or_docid=VIP_REUSE_DOC_ID,
                count=0, status=WALL_NEEDS_VIP_CANDIDATE,
                detail="FR2.3 复用引用: T22 ledger %s 实弹（连续3轮零进展+showPage<page+"
                       "非tri_cap）；本run 重取 ndview showPage/page=%d/%d 复现" % (
                           ev["ts"], show, page))
            result = adapter.dispatch_reconstruction(
                bundle, asset_fetch=cache.asset_leg, out_dir=OUT_DIR / "vip-reuse",
                min_interval=0.5)
            kind = judge_doc_type(ri)
            rec = {"slot": "vip-reuse", "doc_id": VIP_REUSE_DOC_ID, "kind": kind,
                   "title": bundle.title_clean, "page": page, "show_page": show,
                   "coverage": bundle.coverage, "result_ok": bool(result.ok),
                   "pages": result.pages, "chars": result.chars,
                   "artifact_path": result.artifact_path,
                   "wall_status": WALL_NEEDS_VIP_CANDIDATE,
                   "approach": "vip-t22-reuse", "net": None,
                   "t22_evidence": {"ts": ev["ts"], "ledger": ev["ledger"],
                                    "fill_detail": (ev["fill"] or {}).get("detail", "")},
                   "detail": result.detail}
            if result.ok and result.artifact_path:
                if kind == "type3":
                    manifest = {"pdf_path": result.artifact_path,
                                "ref_chars": int(result.chars or 0),
                                "ref_chars_source": "type3",
                                "preview_limit": int(result.pages or 0)}  # 部分收割合法形态
                else:  # 类型2/1：适配器已落 manifest（OCR/editor-DOM 参照），复用之
                    manifest = _find_manifest(OUT_DIR / "vip-reuse", bundle.title_clean)
                    if manifest is None:
                        manifest = {"pdf_path": result.artifact_path,
                                    "ref_chars": int(result.chars or 0),
                                    "ref_chars_source": kind,
                                    "preview_limit": int(result.pages or 0)}
                gate = _gate_record(manifest, PAGES_DIR / "vip-reuse")
                # FR2.AC4 判定与质检门解耦：部分覆盖 PDF 产出+墙标记+coverage 如实即达标
                # （门③对 VIP 预览件常越上界——站方反拷贝整页油墨遮盖，如实记录不掩盖；
                #   门②文字层过=内容真实在案）。门结果作证据留档。
                ac4_ok = (0 < int(result.pages or 0) < page and show < page)
                rec.update(status="pass" if ac4_ok else "fail", gate=gate["gates"],
                           gate_pass=gate["pass"],
                           gate_note="VIP 预览件：门结果留档不作达标条件（FR2.AC4 无门要求）",
                           manifest_ref=gate["manifest_ref"],
                           ref_chars_source=manifest.get("ref_chars_source"),
                           fr23_criteria="复用T22: 连续3轮零进展+showPage<page+非tri_cap",
                           elapsed_s=round(time.time() - t0, 1), net=cache.net - net0)
            else:
                rec.update(status="fail", fail_stage="dispatch",
                           elapsed_s=round(time.time() - t0, 1), net=cache.net - net0)
            docs.append(rec)
            _print_line(rec, note="wall=%s(复用T22) coverage=%s" % (rec["wall_status"],
                                                                    rec["coverage"]))
            save()

        # ========== ⑤浏览器相位：VIP 墙件②真 signer 补页 + 类型1 fixture 真节拍 ==========
        wall_info = sel["wall"][0] if sel["wall"] else None
        if wall_info and "vip-live-bundle" not in extra and not skip("vip-live"):
            from playwright.sync_api import sync_playwright
            with sync_playwright() as pw:
                browser = pw.chromium.launch(
                    headless=True,
                    args=[] if os.environ.get("KB_HARVEST_KEEP_PROXY") == "1"
                    else ["--no-proxy-server"])
                try:
                    from kb_factory.harvest_engine.browser.kit import BrowserKit
                    from kb_factory.harvest_engine.signer.page_signer import PageSigner
                    kit = BrowserKit(browser)
                    signer = PageSigner(kit)
                    assert signer.ready, "ACS 签名窗未就绪（T17 件在位为前提）"
                    cache._audit.request(
                        site="wenku", event="signer_init", query_or_docid=wall_info["doc_id"],
                        count=0, status="ok",
                        detail="PageSigner 隐藏窗就绪（浏览器腿不计数：wenku 首页 warmup）")
                    meta = _meta_of(wall_info)
                    t0 = time.time()
                    net0 = cache.net
                    cache.current = wall_info["doc_id"]
                    bundle = adapter.collect_reader_info(
                        wall_info["doc_id"], meta=meta,
                        signer=CountingSigner(signer, cache), fetch_html=cache.text_leg)
                    extra["vip-live-bundle"] = {
                        "doc_id": wall_info["doc_id"], "title": bundle.title_raw,
                        "page": bundle.page, "show_page": bundle.show_page,
                        "stop_kind": bundle.stop_kind, "wall_status": bundle.wall_status,
                        "coverage": bundle.coverage, "reader_info": bundle.reader_info,
                        "fill_requests": bundle.fill.requests if bundle.fill else 0,
                        "perm": meta.perm, "meta_wall": meta.extra.get("wall_status"),
                        "elapsed_s": round(time.time() - t0, 1), "net": cache.net - net0}
                    print("[VIP②] %s fill=%s轮 wall=%s coverage=%s（净请求=%d）" % (
                        wall_info["doc_id"], extra["vip-live-bundle"]["fill_requests"],
                        bundle.wall_status, bundle.coverage, cache.net - net0), flush=True)
                    signer.close()
                    kit.close_all()
                finally:
                    browser.close()
            save()
        # 类型1 editor 腿（fixture 页 route 本地 fulfill + 真 Chromium 真节拍≈30.5s/件；
        # --resume 且两件皆 pass 时跳过——真节拍 61s 不白烧）
        if "editor" not in extra and not (skip("t1-fix-1") and skip("t1-fix-2")):
            from playwright.sync_api import sync_playwright
            with sync_playwright() as pw:
                browser = pw.chromium.launch(headless=True, args=["--no-proxy-server"])
                try:
                    editor_state = {}
                    for i, did in enumerate(T1_DOC_IDS):
                        slot = "t1-fix-%d" % (i + 1)
                        ctx = browser.new_context()
                        html = _t1_fixture_html(slot)
                        ctx.route("**/view/%s.html*" % did, _fixture_route_handler(html))
                        page = ctx.new_page()
                        t0 = time.monotonic()
                        got = adapter.extract_editor_html(did, page=page)  # 真节拍（缺省 time.sleep）
                        elapsed = time.monotonic() - t0
                        ctx.close()
                        editor_state[slot] = {"ql_html": got.ql_html,
                                              "clicked": got.clicked_text,
                                              "elapsed_s": round(elapsed, 1),
                                              "doc_id": did}
                        print("[editor] %s 真节拍 %.1fs clicked=%s ql_len=%d" % (
                            slot, elapsed, got.clicked_text, len(got.ql_html)), flush=True)
                    extra["editor"] = editor_state
                finally:
                    browser.close()
            save()

        # ========== ⑥FR2.AC4 件②：VIP 墙件 dispatch（部分覆盖 PDF） ==========
        vb = extra.get("vip-live-bundle")
        if vb and not skip("vip-live"):
            t0 = time.time()
            net0 = cache.net
            cache.current = vb["doc_id"]
            meta = FileMeta(title=vb["title"], fmt="doc", pages=vb["page"], perm="yellow",
                            source_url=canonical_view_url(vb["doc_id"]),
                            extra={"doc_id": vb["doc_id"]})
            mark_wall_status(meta, WALL_NEEDS_VIP_CANDIDATE)
            bundle = _bundle(vb["doc_id"], vb["reader_info"], title_raw=vb["title"],
                             page=vb["page"], show_page=vb["show_page"],
                             stop_kind=vb["stop_kind"], wall_status=vb["wall_status"],
                             detail="真 signer 补页 3 轮零推进（FR2.3 判据齐备）")
            result = adapter.dispatch_reconstruction(
                bundle, asset_fetch=cache.asset_leg, out_dir=OUT_DIR / "vip-live",
                min_interval=0.5)
            kind = judge_doc_type(vb["reader_info"])
            rec = {"slot": "vip-live", "doc_id": vb["doc_id"], "kind": kind,
                   "title": bundle.title_clean,
                   "page": vb["page"], "show_page": vb["show_page"], "coverage": vb["coverage"],
                   "result_ok": bool(result.ok), "pages": result.pages, "chars": result.chars,
                   "artifact_path": result.artifact_path,
                   "wall_status": vb["wall_status"],
                   "fill_requests": vb.get("fill_requests"),
                   "meta_wall": vb.get("meta_wall"), "perm_note": vb.get("perm"),
                   "approach": "vip-live-fill", "detail": result.detail}
            if result.ok and result.artifact_path:
                if kind == "type3":
                    manifest = {"pdf_path": result.artifact_path,
                                "ref_chars": int(result.chars or 0),
                                "ref_chars_source": "type3",
                                "preview_limit": int(result.pages or 0)}
                else:
                    manifest = _find_manifest(OUT_DIR / "vip-live", bundle.title_clean)
                    if manifest is None:
                        manifest = {"pdf_path": result.artifact_path,
                                    "ref_chars": int(result.chars or 0),
                                    "ref_chars_source": kind,
                                    "preview_limit": int(result.pages or 0)}
                gate = _gate_record(manifest, PAGES_DIR / "vip-live")
                # FR2.AC4 判定与质检门解耦（同 vip-reuse；门结果留档不作达标条件）
                ac4_ok = (vb["wall_status"] == WALL_NEEDS_VIP_CANDIDATE
                          and 0 < int(result.pages or 0) < vb["page"]
                          and vb["show_page"] < vb["page"])
                rec.update(status="pass" if ac4_ok else "fail", gate=gate["gates"],
                           gate_pass=gate["pass"],
                           gate_note="VIP 预览件：门结果留档不作达标条件（FR2.AC4 无门要求）",
                           manifest_ref=gate["manifest_ref"],
                           ref_chars_source=manifest.get("ref_chars_source"),
                           fr23_criteria="本run实测: fill=%s轮零进展+showPage=%s<page=%s+非tri_cap" % (
                               vb.get("fill_requests"), vb["show_page"], vb["page"]),
                           elapsed_s=round(time.time() - t0, 1), net=cache.net - net0)
            else:
                rec.update(status="fail", fail_stage="dispatch",
                           elapsed_s=round(time.time() - t0, 1), net=cache.net - net0)
            docs.append(rec)
            _print_line(rec, note="wall=%s fill=%s轮 coverage=%s" % (
                rec["wall_status"], rec.get("fill_requests"), rec["coverage"]))
            save()

        # ========== ⑦FR2.AC2：类型2 合成口径 ×2（真 readerInfo+真 CDN 图） ==========
        for i, base in enumerate(sel["bases"], 1):
            slot = "t2-syn-%d" % i
            if skip(slot):
                continue
            t0 = time.time()
            net0 = cache.net
            cache.current = base["doc_id"]
            html = cache.get_ndview_html(base["doc_id"])  # 探针缓存复用（零重发）
            pd = extract_page_data(html)
            ri = pd["readerInfo"]
            imgs = _CDN_IMG_RE.findall(html) or _CDN_IMG_FALLBACK_RE.findall(html)
            uniq = list(dict.fromkeys(imgs))
            assert uniq, "类型2 合成口径失败：基件 ndview 页无 CDN 图直链"
            n = max(1, min(reader_total_pages(ri) or 1, len(uniq), 1))  # 1 图/件（T31 实弹同 n）
            ri = dict(ri)  # 换 htmlUrls 数组样本（真 CDN 直链+pn= 页号键）→ 判型 type2
            ri["htmlUrls"] = ["%s%spn=%d" % (u, "&" if "?" in u else "?", k + 1)
                              for k, u in enumerate(uniq[:n])]
            ri["page"] = reader_total_pages(ri) or n
            ri["showPage"] = min(reader_show_pages(pd["readerInfo"]) or n, ri["page"])
            bundle = _bundle(base["doc_id"], ri, title_raw=str(pd.get("title") or ""),
                             page=ri["page"], show_page=ri["showPage"], stop_kind="not_needed",
                             detail="T31 合成口径：真 readerInfo（真链采集）+ 真 wenku CDN 图"
                                    "直链组 htmlUrls 数组（真类型2 今日寻件困难，如实记录）")
            meta = _meta_of({"doc_id": base["doc_id"], "title": str(pd.get("title") or ""),
                             "page": ri["page"]})
            result = adapter.dispatch_reconstruction(
                bundle, asset_fetch=cache.asset_leg, out_dir=OUT_DIR / slot, min_interval=0.5)
            rec = {"slot": slot, "doc_id": base["doc_id"], "kind": "type2",
                   "title": bundle.title_clean, "page": ri["page"], "show_page": ri["showPage"],
                   "coverage": bundle.coverage, "result_ok": bool(result.ok),
                   "pages": result.pages, "chars": result.chars,
                   "artifact_path": result.artifact_path, "approach": "synthetic-cdn",
                   "img_urls": ri["htmlUrls"], "detail": result.detail,
                   "elapsed_s": round(time.time() - t0, 1), "net": cache.net - net0}
            if result.ok and result.artifact_path:
                manifest = _find_manifest(OUT_DIR / slot, bundle.title_clean)
                if manifest is None:
                    found = sorted((OUT_DIR / slot).glob("*_manifest.json"))
                    manifest = (json.loads(found[0].read_text(encoding="utf-8"))
                                if found else None)
                if manifest is not None:
                    gate = _gate_record(manifest, PAGES_DIR / slot)
                    rec.update(status="pass" if gate["pass"] else "fail", gate=gate["gates"],
                               gate_pass=gate["pass"], manifest_ref=gate["manifest_ref"],
                               ref_chars_source=manifest.get("ref_chars_source"))
                else:
                    rec.update(status="fail", fail_stage="manifest_missing")
            else:
                rec.update(status="fail", fail_stage="dispatch")
            docs.append(rec)
            _print_line(rec)
            save()

        # ========== ⑧FR2.AC2：类型1 组合口径 ×2（fixture 真节拍+真 XML 端点） ==========
        editor_state = extra.get("editor") or {}
        for i, did in enumerate(T1_DOC_IDS):
            slot = "t1-fix-%d" % (i + 1)
            if skip(slot):
                continue
            ed = editor_state.get(slot) or {}
            t0 = time.time()
            net0 = cache.net
            cache.current = did
            ri = _t1_synth_reader_info(slot)
            bundle = _bundle(did, ri, title_raw="T38 类型1 %s 样例（fixture 真节拍）" % slot,
                             page=1, show_page=1, stop_kind="not_needed",
                             detail="T35 组合口径：editor 腿=fixture 页真 Chromium 真节拍 "
                                    "%.1fs；XML 降级腿=真实 wkrtcs 端点合成令牌实弹" %
                                    ed.get("elapsed_s", -1))
            meta = FileMeta(title=bundle.title_clean, fmt="doc", pages=1, perm="green",
                            source_url=canonical_view_url(did), extra={"doc_id": did})
            result = adapter.dispatch_reconstruction(
                bundle, editor_html=ed.get("ql_html"), editor_clicked=ed.get("clicked"),
                out_dir=OUT_DIR / slot)
            # XML 降级腿证据：真实端点合成令牌实弹（transport+信封实测，零桶如实；
            # 两件共用一份令牌 → 同 URL 第二件 Store 缓存命中零重发）
            xml_stats = {"requests": 0, "buckets_ok": 0, "buckets_empty": 0}
            if cache.net + 1 <= cache.cap:
                assets = fetch_xml_blocks(_t1_xml_reader_info(), asset_fetch=cache.asset_leg,
                                          now_ms=T1_XML_NOW_MS, min_interval=0.5)
                xml_stats = dict(assets.stats)
                xml_stats["blocks"] = len(assets.blocks)
            rec = {"slot": slot, "doc_id": did, "kind": "type1", "title": bundle.title_clean,
                   "page": 1, "show_page": 1, "coverage": "1/1",
                   "result_ok": bool(result.ok), "pages": result.pages, "chars": result.chars,
                   "artifact_path": result.artifact_path, "approach": "composite-fixture",
                   "editor_elapsed_s": ed.get("elapsed_s"),
                   "editor_clicked": ed.get("clicked"), "xml_leg": xml_stats,
                   "detail": result.detail, "net": cache.net - net0}
            if result.ok and result.artifact_path:
                manifest = _find_manifest(OUT_DIR / slot, bundle.title_clean)
                if manifest is None:
                    found = sorted((OUT_DIR / slot).glob("*_manifest.json"))
                    manifest = (json.loads(found[0].read_text(encoding="utf-8"))
                                if found else None)
                if manifest is not None:
                    gate = _gate_record(manifest, PAGES_DIR / slot)
                    rec.update(status="pass" if gate["pass"] else "fail", gate=gate["gates"],
                               gate_pass=gate["pass"], manifest_ref=gate["manifest_ref"],
                               ref_chars_source=manifest.get("ref_chars_source"),
                               elapsed_s=round(time.time() - t0, 1))
                else:
                    rec.update(status="fail", fail_stage="manifest_missing")
            else:
                rec.update(status="fail", fail_stage="dispatch",
                           elapsed_s=round(time.time() - t0, 1))
            docs.append(rec)
            _print_line(rec, note="editor真节拍=%ss xml端点=%s" % (
                ed.get("elapsed_s"), xml_stats.get("requests")))
            save()

        # ========== ⑨FR2.AC3 边界件①：无效 docId → 「无法提取 pageData」 ==========
        if "bnd_invalid" not in extra:
            t0 = time.time()
            net0 = cache.net
            cache.current = INVALID_DOC_ID
            try:
                fetch_page_data(INVALID_DOC_ID, fetch_html=cache.text_leg)  # 真报错路径
                msg, raised = "", False
            except WenkuPageDataError as exc:
                msg, raised = str(exc), True
            extra["bnd_invalid"] = {
                "doc_id": INVALID_DOC_ID, "raised": raised,
                "has_page_data_error": "无法提取 pageData" in msg,
                "has_en_text": "failed to extract pageData from HTML" in msg,
                "message_head": msg[:160], "net": cache.net - net0,
                "elapsed_s": round(time.time() - t0, 1)}
            print("[边界] 无效 docId：raised=%s 文案含「无法提取 pageData」=%s（净请求=%d）" % (
                raised, extra["bnd_invalid"]["has_page_data_error"], cache.net - net0),
                flush=True)
            save()

        # ========== ⑩FR2.AC3 边界件②：>400 页真件按 §8-2 拒绝 ==========
        if "bnd_over400" not in extra:
            bid = None
            if cache.net + 2 <= cache.cap:  # 预算够：脚本内 syncmrecall 现场发现
                cache.current = "search:" + QUERY_BIG
                time.sleep(3.2)
                _orig_fetch = _wm._fetch
                _wm._fetch = cache.search
                try:
                    bigs = _wm.WenkuMetaAdapter().metadata(QUERY_BIG, 12)
                finally:
                    _wm._fetch = _orig_fetch
                cands = sorted((m for m in bigs if (m.pages or 0) > WENKU_PAGE_LIMIT),
                               key=lambda m: -(m.pages or 0))
                if cands:
                    bid = cands[0].extra.get("doc_id")
                    big_title, big_pages = cands[0].title, cands[0].pages
                cache._audit.request(
                    site="wenku", event="big_doc_search", query_or_docid=QUERY_BIG,
                    count=len(bigs), status="ok" if cands else "miss",
                    detail="脚本内大页数件检索（>400 页）")
            if not bid:  # 预算紧：引用 T38 工人会话内 syncmrecall 校准实测发现（真检索，
                # 2026-10-23 词=理论力学教材 12 条含 1160 页件——发现证据在案，脚本内直探）
                bid = BIG_DOC_ID
                big_title, big_pages = "理论力学(第4版)(全套1160页PPT课件)", 1160
                cache._audit.request(
                    site="wenku", event="big_doc_search", query_or_docid=QUERY_BIG,
                    count=0, status="cited",
                    detail="预算紧未重发检索：引用 T38 工人会话 syncmrecall 校准实测（词=理论力学"
                           "教材，12 条含 1160 页件 doc_id=%s）；脚本内 ndview 直探验真" % bid)
            assert bid and DOC_ID_RE.match(bid), "大页数件 docId 形态非法"
            cache.current = bid
            t0 = time.time()
            net0 = cache.net
            html = cache.get_ndview_html(bid)
            pd = extract_page_data(html)
            assert isinstance(pd, dict) and isinstance(pd.get("readerInfo"), dict)
            meta = _meta_of({"doc_id": bid, "title": big_title, "page": big_pages})
            bundle = adapter.collect_reader_info(bid, meta=meta, fetch_html=cache.text_leg)
            extra["bnd_over400"] = {
                "doc_id": bid, "title": big_title, "meta_pages": big_pages,
                "reader_page": bundle.page, "show_page": bundle.show_page,
                "stop_kind": bundle.stop_kind,
                "rejected_8_2": bundle.stop_kind == "page_limit"
                and "超出最大支持页数" in bundle.detail and str(WENKU_PAGE_LIMIT) in bundle.detail,
                "detail": bundle.detail, "net": cache.net - net0,
                "elapsed_s": round(time.time() - t0, 1)}
            print("[边界] >400 页件 %s：page=%d stop=%s §8-2 拒绝=%s（净请求=%d）" % (
                bid, bundle.page, bundle.stop_kind, extra["bnd_over400"]["rejected_8_2"],
                cache.net - net0), flush=True)
            save()
    except BudgetExceeded as exc:
        budget_stop = str(exc)
        print("[预算熔断] %s（净请求 %d/%d）" % (exc, cache.net, args.budget), flush=True)
    finally:
        save()

    # ========== 汇总与三 AC 判定 ==========
    render = [d for d in docs if d.get("slot", "").startswith(("t3-", "t2-", "t1-"))]
    by_kind_counts: dict[str, int] = {}
    for d in render:
        if d.get("status") == "pass":
            by_kind_counts[d["kind"]] = by_kind_counts.get(d["kind"], 0) + 1
    ac2 = {"quota": QUOTA, "counts": by_kind_counts, "n_pass": sum(by_kind_counts.values()),
           "pass": (by_kind_counts.get("type3", 0) >= QUOTA["type3"]
                    and by_kind_counts.get("type2", 0) >= QUOTA["type2"]
                    and by_kind_counts.get("type1", 0) >= QUOTA["type1"]
                    and all(d.get("status") == "pass" for d in render) and len(render) >= 10)}
    bi, bo = extra.get("bnd_invalid") or {}, extra.get("bnd_over400") or {}
    ac3 = {"invalid": bi, "over400": bo,
           "pass": bool(bi.get("raised") and bi.get("has_page_data_error")
                        and bo.get("rejected_8_2"))}
    vips = [d for d in docs if d.get("slot") in ("vip-reuse", "vip-live")]
    vb = extra.get("vip-live-bundle") or {}
    ac4 = {
        "vip_reuse": {"doc_id": VIP_REUSE_DOC_ID,
                      "wall": next((d for d in vips if d["slot"] == "vip-reuse"), None),
                      "t22_evidence": t22_wall_evidence() is not None},
        "vip_live": {"doc_id": vb.get("doc_id"),
                     "wall_status": vb.get("wall_status"),
                     "fill_requests": vb.get("fill_requests"),
                     "meta_wall": vb.get("meta_wall"), "perm_note": vb.get("perm"),
                     "rec": next((d for d in vips if d["slot"] == "vip-live"), None)},
        "pass": (len([d for d in vips if d.get("status") == "pass"
                      and d.get("wall_status") == WALL_NEEDS_VIP_CANDIDATE
                      and d.get("pages") and 0 < d["pages"] < d["page"]
                      and d.get("coverage") == "%s/%s" % (d.get("show_page"), d.get("page"))])
                 >= 2)}
    state["ac"] = {"FR2.AC2": ac2, "FR2.AC3": ac3, "FR2.AC4": ac4}
    save()

    print("=" * 100, flush=True)
    print("[汇总] 渲染件 %d/%d 过（type3=%d/6 type2=%d/2 type1=%d/2）| VIP 件 %d/2 | "
          "边界 无效docId=%s >400页=%s | 净请求 %d/%d（by_kind=%s cache_hits=%d）" % (
              ac2["n_pass"], max(10, len(render)), by_kind_counts.get("type3", 0),
              by_kind_counts.get("type2", 0), by_kind_counts.get("type1", 0),
              len([d for d in vips if d.get("status") == "pass"]),
              "过" if ac3["pass"] else "折",
              "过" if (bo or {}).get("rejected_8_2") else "折",
              cache.net, args.budget, cache.by_kind, cache.cache_hits), flush=True)
    print("[汇总] ledger=%s | summary=%s" % (LEDGER_PATH, SUMMARY_PATH), flush=True)
    for d in docs:
        print("  - %s %s 型=%s %s页/%s字 gate=%s %s" % (
            d.get("slot"), d.get("status"), d.get("kind"), d.get("pages"), d.get("chars"),
            d.get("gate", "-"), d.get("approach", "")), flush=True)
    ok = ac2["pass"] and ac3["pass"] and ac4["pass"] and cache.net <= args.budget \
        and not budget_stop
    if ok:
        print("[验收] FR2.AC2+AC3+AC4+FR2.3 全过（退出码 0；净请求 %d/%d）" % (
            cache.net, args.budget), flush=True)
        return 0
    reasons = []
    if not ac2["pass"]:
        reasons.append("AC2 未过（%s）" % ac2["counts"])
    if not ac3["pass"]:
        reasons.append("AC3 未过")
    if not ac4["pass"]:
        reasons.append("AC4 未过（%d/2 VIP 件达标）" % len(
            [d for d in vips if d.get("status") == "pass"]))
    if budget_stop or cache.net > args.budget:
        reasons.append("预算%s（净请求 %d/%d）" % (
            "熔断" if budget_stop else "超限", cache.net, args.budget))
    print("[验收] 未过：%s（退出码 1）" % "；".join(reasons), flush=True)
    return 1


if __name__ == "__main__":
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace", line_buffering=True)
        sys.stderr.reconfigure(encoding="utf-8", errors="replace")
    sys.exit(main(sys.argv[1:]))
