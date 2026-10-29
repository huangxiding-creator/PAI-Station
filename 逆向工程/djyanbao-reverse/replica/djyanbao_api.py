# -*- coding: utf-8 -*-
"""洞见研报 (djyanbao.com) API 复刻件 — 检索/卡片列表/详情/摘要 纯 HTTP 客户端

逆向结论 (2026-10-24, 逆向工程/djyanbao-reverse):
  全链走 api.djyanbao.com (前端 axios baseURL, withCredentials=false → 零 Cookie),
  仅凭三枚自定义头 + 可选 Bearer:
    client-ver: v2.0.14 / client-type: pc / client-id: <uuid4>
    Authorization: Bearer <JWT>   (仅签名 PDF 端点需要; 来自 www 页 localStorage['token'])
  段 1  GET /api/report?page=1&limit=10&q=<urlenc>&sort=publish_at&order=DESC&matchPhrase=false
        → {data:{data:[卡片×N],meta:{itemCount}},code:0}  [匿名 200]
        卡片: id/typeId/businessId/title/authors/orgName/publishAt/pageTotal/fileSize/
              uploaderName/indexImageUrl/stockName/canConvert/hasDownloaded/
              highlight{title[],content[]←摘要片段}/score/reportScore←AI评分
  段 2  GET /api/report/{id}  → 详情元数据(+fileUrl 裸链)  [匿名 200]
  段 3  GET /api/report/{id}/report-ai-analysis?all=true
        → title/institution/date/author/reportType/industry/swclass/outline[]/
          summary←全文摘要/reportBrief/aiSearchSummary/figureTableList{figures,tables}/
          reportScore/fieldConfidence{metadata,classification,content}  [匿名 200 ★免费面核心]
  段 4  GET /api/report/{id}/download/info?action=view&format=pdf  [匿名 401 / Bearer 200]
        → {fileUrl: storage.djyanbao.com/...pdf?u=<uid>&t=<ms>&token=<hex>, validSeconds:300}
        → GET 签名链即 VIP 合法 PDF (5 分钟时效, 解出后立即用)
  分页: page/limit (meta.itemCount, 观测上限 10000); 排序 sort=publish_at&order=DESC
  风控: x-ratelimit — /report 检索 300/h (reset 3600s), 其余 1500/10min (reset 600s)
  登录态: JWT HS256, payload={id:<uid>, iat:<epoch>} 无 exp — 服务端会话型;
          实测 iat=2026-10-15 的 token 至 10-24 仍有效; 失效表现 = download/info 401。
          刷新法: A) 重导 profile localStorage (浏览器登录一次后 captures/profile_localstorage.json)
                  B) POST /auth/login {phone,password} (凭据文件 01 账号授权/洞见研报密码登录账号.txt)

纪律: 节流 ≥2s/req; 429/401 不硬刚如实抛; token/uuid 状态文件不进仓(.gitignore);
      只读 GET 优先; PDF 走 VIP 合法签名链, 不破付费墙。
"""
from __future__ import annotations

import argparse
import json
import random
import re
import sys
import time
import uuid as uuid_mod
from dataclasses import dataclass, asdict
from pathlib import Path
from urllib.parse import quote

from curl_cffi import requests

if sys.platform == "win32":
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass

BASE = "https://api.djyanbao.com/api"
WEB = "https://www.djyanbao.com"
CLIENT_VER = "v2.0.14"
STATE_FILE = Path(__file__).resolve().parent / "djyanbao_state.json"
PROFILE_LS = Path(__file__).resolve().parents[1] / "captures" / "profile_localstorage.json"
_TAG = re.compile(r"</?em>")

THROTTLE_S = 2.0
_last_req = [0.0]


class DjAuthError(RuntimeError):
    """401 — Bearer token 失效或缺失 (刷新法见模块 docstring)。"""


class DjRateLimited(RuntimeError):
    """429 — 触顶 x-ratelimit, 冷却后重试。"""


def _throttle():
    dt = time.time() - _last_req[0]
    if dt < THROTTLE_S:
        time.sleep(THROTTLE_S - dt + random.uniform(0, 0.4))
    _last_req[0] = time.time()


@dataclass
class ReportCard:
    id: int
    title: str
    org: str
    authors: str
    publish_at: str
    page_total: int
    file_size: int
    uploader: str
    type_id: int
    stock_name: str | None
    report_score: int | None
    snippet: str                 # highlight.content 首段(剥 <em> 高亮)
    web_url: str


@dataclass
class ReportDetail:
    id: int
    title: str
    org: str
    authors: str
    publish_at: str
    page_total: int
    file_size: int
    file_url: str                # 裸 OSS 链(未签名, 元数据自带)
    index_image: str
    ai_status: int
    web_url: str


class DjYanbao:
    """洞见研报 API 会话 (curl_cffi chrome 指纹 + uuid client-id + 可选 Bearer)."""

    def __init__(self, state_file: Path | None = None, use_token: bool = True):
        self.state_file = state_file or STATE_FILE
        self.token = ""
        self.client_id = ""
        if use_token:
            self._load_state()
        if not self.client_id:
            self.client_id = str(uuid_mod.uuid4())
        self.sess = requests.Session(impersonate="chrome")

    # ---------- state ----------
    def _load_state(self):
        src = self.state_file
        if not src.exists() and PROFILE_LS.exists():      # 首跑自动从抓包导出件导入
            try:
                ls = json.loads(PROFILE_LS.read_text(encoding="utf-8"))
                self.token = ls.get("token", "")
                self.client_id = ls.get("uuid", "")
                self.save_state()
                return
            except Exception:
                pass
        if src.exists():
            try:
                st = json.loads(src.read_text(encoding="utf-8"))
                self.token = st.get("token", "")
                self.client_id = st.get("uuid", "") or str(uuid_mod.uuid4())
            except Exception:
                pass

    def save_state(self):
        self.state_file.write_text(
            json.dumps({"token": self.token, "uuid": self.client_id},
                       ensure_ascii=False, indent=1), encoding="utf-8")

    def has_token(self) -> bool:
        return bool(self.token)

    # ---------- core ----------
    def _headers(self, auth: bool | None = None) -> dict:
        h = {"Content-Type": "application/json", "client-ver": CLIENT_VER,
             "client-type": "pc", "client-id": self.client_id,
             "Origin": WEB, "Referer": WEB + "/"}
        use_auth = self.has_token() if auth is None else (auth and self.has_token())
        if use_auth:
            h["Authorization"] = "Bearer " + self.token
        return h

    def _get(self, path: str, auth: bool | None = None):
        _throttle()
        r = self.sess.get(BASE + path, headers=self._headers(auth), timeout=20)
        if r.status_code == 401:
            raise DjAuthError("401 " + path[:60] + " — token 失效或缺失")
        if r.status_code == 429:
            raise DjRateLimited("429 " + path[:60] + " — ratelimit 顶格")
        r.raise_for_status()
        j = r.json()
        if j.get("code") not in (0, "0"):
            raise RuntimeError("code=%s msg=%s %s" % (j.get("code"), j.get("message"), path[:60]))
        return j.get("data")

    # ---------- 段 1: 检索 → 卡片列表 ----------
    def search(self, query: str, page: int = 1, limit: int = 10,
               sort: str = "publish_at", order: str = "DESC"):
        path = ("/report?page=%d&limit=%d&q=%s&sort=%s&order=%s&matchPhrase=false"
                % (page, limit, quote(query), sort, order))
        d = self._get(path) or {}
        cards = []
        for it in d.get("data") or []:
            hl = it.get("highlight") or {}
            snip = _TAG.sub("", (hl.get("content") or [""])[0]).strip()
            cards.append(ReportCard(
                id=it["id"], title=it.get("title", ""), org=it.get("orgName", ""),
                authors=it.get("authors", ""), publish_at=(it.get("publishAt") or "")[:10],
                page_total=it.get("pageTotal") or 0, file_size=it.get("fileSize") or 0,
                uploader=it.get("uploaderName", ""), type_id=it.get("typeId") or 0,
                stock_name=it.get("stockName"),
                report_score=it.get("reportScore"),
                snippet=snip, web_url="%s/report/%d" % (WEB, it["id"])))
        return cards, (d.get("meta") or {}).get("itemCount", -1)

    # ---------- 段 2: 详情元数据 ----------
    def detail(self, report_id: int) -> ReportDetail:
        it = self._get("/report/%d" % report_id) or {}
        return ReportDetail(
            id=it["id"], title=it.get("title", ""), org=it.get("orgName", ""),
            authors=it.get("authors", ""), publish_at=(it.get("publishAt") or "")[:10],
            page_total=it.get("pageTotal") or 0, file_size=it.get("fileSize") or 0,
            file_url=it.get("fileUrl", ""), index_image=it.get("indexImageUrl", ""),
            ai_status=it.get("aiStatus"), web_url="%s/report/%d" % (WEB, report_id))

    # ---------- 段 3: AI 分析 (摘要+图表清单, 匿名可取 = 免费面核心) ----------
    def ai_analysis(self, report_id: int) -> dict:
        return self._get("/report/%d/report-ai-analysis?all=true" % report_id) or {}

    # ---------- 段 4: 签名 PDF 直链 (VIP 合法下载面) ----------
    def signed_pdf(self, report_id: int, action: str = "view", fmt: str = "pdf"):
        d = self._get("/report/%d/download/info?action=%s&format=%s"
                      % (report_id, action, fmt), auth=True) or {}
        return d.get("fileUrl", ""), int(d.get("validSeconds", 0))

    def download_pdf(self, report_id: int, out_path: Path):
        url, _vs = self.signed_pdf(report_id)
        if not url:
            raise RuntimeError("empty signed url")
        _throttle()
        r = self.sess.get(url, headers={"Referer": WEB + "/"}, timeout=60)
        r.raise_for_status()
        out_path.parent.mkdir(parents=True, exist_ok=True)
        out_path.write_bytes(r.content)
        return str(out_path), len(r.content)

    # ---------- 编排 ----------
    def fullchain(self, query: str, top: int = 3, with_pdf: bool = False) -> dict:
        cards, total = self.search(query)
        out = {"query": query, "itemCount": total,
               "cards": [asdict(c) for c in cards], "details": []}
        for c in cards[:top]:
            det = self.detail(c.id)
            ai = self.ai_analysis(c.id)
            rec = {"detail": asdict(det),
                   "ai": {k: ai.get(k) for k in
                          ("summary", "reportBrief", "outline", "figureTableList",
                           "reportScore", "industry", "swclass", "reportType",
                           "topicTags", "region")}}
            if with_pdf and self.has_token():
                try:
                    u, vs = self.signed_pdf(c.id)
                    rec["signed_pdf"] = {"url": u, "validSeconds": vs}
                except (DjAuthError, DjRateLimited):
                    rec["signed_pdf"] = None
            out["details"].append(rec)
        return out


def _emit(obj):
    print(json.dumps(obj, ensure_ascii=False, indent=1))


def main() -> int:
    ap = argparse.ArgumentParser(description="洞见研报 纯HTTP API 复刻件")
    sub = ap.add_subparsers(dest="cmd", required=True)
    p1 = sub.add_parser("search", help="关键词检索→卡片列表")
    p1.add_argument("query")
    p1.add_argument("--page", type=int, default=1)
    p1.add_argument("--limit", type=int, default=10)
    p2 = sub.add_parser("detail", help="报告详情元数据")
    p2.add_argument("id", type=int)
    p3 = sub.add_parser("ai", help="AI分析: 摘要/大纲/图表清单/评分")
    p3.add_argument("id", type=int)
    p4 = sub.add_parser("pdf", help="VIP签名PDF直链(+可选下载)")
    p4.add_argument("id", type=int)
    p4.add_argument("--save", default="")
    p5 = sub.add_parser("fullchain", help="检索→列表→详情→摘要 全链")
    p5.add_argument("query")
    p5.add_argument("--top", type=int, default=3)
    p5.add_argument("--pdf", action="store_true")
    p6 = sub.add_parser("selftest", help="5次独立会话贯通实测")
    p6.add_argument("--query", default="国际工程")
    ns = ap.parse_args()

    dj = DjYanbao()
    if ns.cmd == "search":
        cards, total = dj.search(ns.query, ns.page, ns.limit)
        _emit({"itemCount": total, "n": len(cards), "cards": [asdict(c) for c in cards]})
    elif ns.cmd == "detail":
        _emit(asdict(dj.detail(ns.id)))
    elif ns.cmd == "ai":
        _emit(dj.ai_analysis(ns.id))
    elif ns.cmd == "pdf":
        if ns.save:
            fp, n = dj.download_pdf(ns.id, Path(ns.save))
            url, vs = dj.signed_pdf(ns.id)
            _emit({"signed_url": url, "validSeconds": vs, "saved": fp, "bytes": n})
        else:
            url, vs = dj.signed_pdf(ns.id)
            _emit({"signed_url": url, "validSeconds": vs})
    elif ns.cmd == "fullchain":
        _emit(dj.fullchain(ns.query, ns.top, ns.pdf))
    elif ns.cmd == "selftest":
        ok = 0
        results = []
        for i in range(5):                       # 5 次全新独立会话
            try:
                c = DjYanbao()                   # 新 client-id + 新 TLS 会话
                cards, total = c.search(ns.query, limit=5)
                assert cards, "empty list"
                ai_ok, walked = False, 0
                for card in cards[:5]:           # aiStatus=0 的件无 AI 分析(数据态) — 走到有分析的件
                    det = c.detail(card.id)
                    assert det.id == card.id
                    walked += 1
                    if det.ai_status != 4:
                        continue
                    ai = c.ai_analysis(card.id)
                    assert (ai.get("summary") or ai.get("outline")
                            or ai.get("reportBrief") or ai.get("reportScore")), "empty ai @status4"
                    ai_ok = True
                    break
                assert ai_ok, "no aiStatus=4 card in page (data condition)"
                extra = ""
                if i == 0 and c.has_token():     # 登录态面只首会话验一次(省额度)
                    u, vs = c.signed_pdf(cards[0].id)
                    assert u.startswith("https://storage.djyanbao.com/"), "bad signed url"
                    extra = " +signed_pdf(%ds)" % vs
                results.append("S%d: OK cards=%d total=%d walked=%d%s"
                               % (i + 1, len(cards), total, walked, extra))
                ok += 1
                c.sess.close()
            except Exception as e:
                results.append("S%d: FAIL %s" % (i + 1, str(e)[:90]))
        _emit({"pass": ok, "of": 5, "results": results,
               "token_present": dj.has_token()})
        return 0 if ok == 5 else 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
