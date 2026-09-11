"""微信读书 web 端纯 API 客户端（M2.5 铸造厂·电子书源，提案第 19 章源①）。

逆向自 weread.qq.com web 端（对照 touchFish TS 原版移植，黄金向量对拍）：
- 登录态：cookie（wr_skey/wr_vid…）由 scripts/weread_login.py 扫码落盘
  data/weread/_auth/weread_auth.json；renew() 成功后原子写回该文件
  （2026-09-11 修复：原先只更新内存，进程退出即丢→下个进程 -2012）
- 搜索/详情/目录：GET/POST /web/book/*，cookie 认证、无签名
- 章节正文：POST /web/book/chapter/e_0..e_3（epub/pdf）或 t_0/t_1（txt），
  签名见 weread_sign.py；响应 = md5 头 32 位 + 混淆体（chk 剥离 →
  交换表还原 → base64 解码）
- 续期：POST /web/login/renewal，succ==1 时从 Set-Cookie 更新 wr_skey

安全红线（账号安全宪法 R8/R10——违者熔断）：
- 节流：请求间隔 uniform(1.5, 3.5)s，可注入 time_func 供测试
- 熔断：连续 3 次异常 / 登录失效码（-2012/-2013/-12013/401）即抛错停止
- 永不调用 /web/book/read（写操作）与安卓 chapterdownload
- 内容只写 data/weread/；凭据不落本模块
"""
import base64
import json
import os
import random
import time
import urllib.error
import urllib.parse
import urllib.request

from paistation.forge.weread_sign import (
    USER_AGENT,
    calc_hash,
    current_time,
    sign,
)

BASE = "https://weread.qq.com"
AUTH_CODES = {-2012, -2013, -12013}
THROTTLE_RANGE = (1.5, 3.5)      # 章节请求随机间隔（秒）
BREAKER_LIMIT = 3                # 连续异常熔断阈值


class WeReadAuthError(RuntimeError):
    """登录失效（需重新扫码）。"""


class WeReadApiError(RuntimeError):
    """接口业务错误（errCode != 0）。"""


class CircuitBreakerError(RuntimeError):
    """连续异常熔断——立即停止，人工检查后再继续。"""


# ---------- 解混淆（touchFish decrypt.ts 移植） ----------

def _strip_md5_header(data: str) -> str:
    """chk()：前 32 位为 md5(body) 大写；不匹配返回空串。"""
    if not data or len(data) <= 32:
        return data
    header, body = data[:32], data[32:]
    import hashlib
    ok = header == hashlib.md5(body.encode("utf-8")).hexdigest().upper()
    return body if ok else ""


def _swap_table(result: str) -> list:
    """从串尾字符编码推导交换位置表（尾部区域不被交换，故对合成立）。"""
    length = len(result)
    if length < 4:
        return []
    if length < 11:
        return [0, 2]
    n = min(4, -(-length // 10))          # ceil
    binstr = ""
    for i in range(length - 1, length - 1 - n, -1):
        # JS: parseInt(charCode.toString(2), 4)
        binstr += str(int(format(ord(result[i]), "b"), 4))
    limit = length - n - 2
    width = len(str(limit))
    positions = []
    i = 0
    while len(positions) < 10 and i + width < len(binstr):
        positions.append(int(binstr[i:i + width]) % limit)
        positions.append(int(binstr[i + 1:i + 1 + width]) % limit)
        i += width
    return positions


def _apply_swap(chars: list, positions: list) -> list:
    """解密侧交换：i 降序步长 -2、j 1→0（加密侧为其严格逆序）。"""
    for i in range(len(positions) - 1, -1, -2):
        for j in (1, 0):
            a, b = positions[i] + j, positions[i - 1] + j
            chars[a], chars[b] = chars[b], chars[a]
    return chars


def _b64_decode(text: str) -> str:
    """宽松 base64（JS Buffer.from 语义：容忍缺 padding）。"""
    padded = text + "=" * (-len(text) % 4)
    try:
        return base64.b64decode(padded).decode("utf-8", errors="replace")
    except Exception:                       # noqa: BLE001 - 与 JS 宽松语义对齐
        return ""


def decrypt_body(body: str) -> str:
    """混淆体 → 原文：首字符剥离 + 交换还原 + base64 解码。

    注意：md5 头已由 chk（_strip_md5_header）在上游逐分片剥离；
    e_0+e_1+e_3 拼接后只做本函数（对齐 touchFish dH 语义）。
    """
    if not body or len(body) <= 1:
        return ""
    result = body[1:]
    result = "".join(_apply_swap(list(result), _swap_table(result)))
    return _b64_decode(result)


def deobfuscate(data: str) -> str:
    """完整线格式 → 原文：md5 头剥离 + decrypt_body。"""
    return decrypt_body(_strip_md5_header(data))


# ---------- 客户端 ----------

class WeReadClient:
    """cookie 认证的微信读书 web API 客户端（节流 + 熔断内置）。"""

    def __init__(self, cookie: str = "", auth_path: str = "", opener=None,
                 time_func=time.time, sleep_func=time.sleep, fast: bool = False):
        self._opener = opener or urllib.request.build_opener(
            urllib.request.ProxyHandler({}))          # 直连：国内站点铁律
        self._time = time_func
        self._sleep = sleep_func
        self._last_request = 0.0
        self._consecutive_errors = 0
        self._fast = fast                             # 测试关节流
        self._auth_path = auth_path
        if not cookie and auth_path:
            cookie = self._load_cookie(auth_path)
        self.cookie = cookie

    # ----- 登录态 -----

    @staticmethod
    def _load_cookie(auth_path: str) -> str:
        if not os.path.exists(auth_path):
            raise WeReadAuthError(
                f"登录态文件不存在：{auth_path}，请先运行 scripts/weread_login.py 扫码")
        with open(auth_path, encoding="utf-8") as fh:
            auth = json.load(fh)
        cookie = auth.get("cookie", "")
        if not cookie or "wr_skey=" not in cookie:
            raise WeReadAuthError("登录态文件缺 wr_skey，请重新扫码登录")
        return cookie

    def _headers(self, referer: str = f"{BASE}/") -> dict:
        return {"Cookie": self.cookie, "User-Agent": USER_AGENT,
                "Referer": referer, "Accept": "application/json"}

    def _check_auth(self, payload) -> None:
        code = payload.get("errCode") if isinstance(payload, dict) else None
        if code in AUTH_CODES:
            raise WeReadAuthError(f"登录失效 errCode={code}（请重新扫码）")

    # ----- 底层请求（节流 + 熔断 + JSON/文本双形态） -----

    def _guard(self) -> None:
        if self._fast:
            return
        wait = self._last_request + random.uniform(*THROTTLE_RANGE) - self._time()
        if wait > 0:
            self._sleep(wait)
        self._last_request = self._time()

    def _breaker_hit(self, exc: Exception) -> None:
        self._consecutive_errors += 1
        if self._consecutive_errors >= BREAKER_LIMIT:
            raise CircuitBreakerError(
                f"连续 {self._consecutive_errors} 次异常，熔断停止（最后：{exc}）"
            ) from exc

    def _open(self, req, as_text: bool = False):
        """发请求并规约错误；成功清零连续异常计数。"""
        self._guard()
        try:
            resp = self._opener.open(req, timeout=30)
            raw = resp.read().decode("utf-8", errors="replace")
            self._consecutive_errors = 0
            return raw if as_text else self._parse_json(raw, req)
        except WeReadAuthError:
            raise
        except urllib.error.HTTPError as exc:               # noqa: PERF203
            if exc.code == 401:
                raise WeReadAuthError("HTTP 401 登录失效") from exc
            self._breaker_hit(exc)
            raise WeReadApiError(f"HTTP {exc.code}") from exc
        except (urllib.error.URLError, TimeoutError, OSError) as exc:
            self._breaker_hit(exc)
            raise WeReadApiError(f"网络异常：{exc}") from exc

    def _parse_json(self, raw: str, req):
        try:
            payload = json.loads(raw)
        except ValueError as exc:
            raise WeReadApiError(
                f"非 JSON 响应（疑似验证页/风控）：{raw[:120]}") from exc
        self._check_auth(payload)
        return payload

    def _get(self, path: str, **params) -> dict:
        query = urllib.parse.urlencode(params)
        req = urllib.request.Request(
            f"{BASE}{path}?{query}", headers=self._headers())
        return self._open(req)

    def _post(self, path: str, body: dict, as_text: bool = False,
              referer: str = f"{BASE}/web/"):
        req = urllib.request.Request(
            f"{BASE}{path}", data=json.dumps(body).encode("utf-8"),
            headers=dict(self._headers(referer),
                         **{"Content-Type": "application/json",
                            "Origin": BASE}), method="POST")
        return self._open(req, as_text=as_text)

    # ----- 业务 API -----

    def is_logged_in(self) -> bool:
        """GET /api/user/config 校验 cookie 有效性。

        勘误（2026-09-10 实测）：wrweb-next 改版后 /web/user 恒返 -2003
        （登录态也返），已不可用作登录检查；/api/user/config 登录时返
        accountsets 账号配置。
        """
        try:
            info = self._get("/api/user/config")
            return "accountsets" in info or info.get("errCode") == 0
        except WeReadAuthError:
            return False

    def renew(self, origin_path: str = "/web/shelf") -> bool:
        """POST /web/login/renewal 续期 wr_skey（~30 天一续）。"""
        req = urllib.request.Request(
            f"{BASE}/web/login/renewal",
            data=json.dumps({"rq": urllib.parse.quote(
                f"{BASE}{origin_path}", safe=""), "ql": False}).encode("utf-8"),
            headers=dict(self._headers(f"{BASE}/web/"),
                         **{"Content-Type": "application/json",
                            "Origin": BASE}), method="POST")
        self._guard()
        try:
            resp = self._opener.open(req, timeout=30)
            data = json.loads(resp.read().decode("utf-8"))
            if data.get("succ") != 1:
                self._check_auth(data)
                return False
            set_cookies = resp.headers.get_all("Set-Cookie") or []
            pairs = {}
            for item in set_cookies:
                kv = item.split(";", 1)[0]
                if "=" in kv:
                    k, v = kv.split("=", 1)
                    pairs[k.strip()] = v
            merged = {}
            for kv in self.cookie.split(";"):
                if "=" in kv:
                    k, v = kv.split("=", 1)
                    merged[k.strip()] = v
            merged.update({k: v for k, v in pairs.items() if v})
            self.cookie = "; ".join(f"{k}={v}" for k, v in merged.items())
            self._persist_auth()
            return "wr_skey" in pairs
        except urllib.error.HTTPError as exc:
            raise WeReadApiError(f"renewal HTTP {exc.code}") from exc

    def _persist_auth(self) -> None:
        """renew 成功后把合并 cookie 原子写回登录态文件。

        2026-09-11 实测：renew 只更新内存 cookie，进程退出即丢——
        下个进程重读旧 wr_skey 仍 -2012。schema 与 weread_login.py 一致
        （cookie/vid/name/saved_at）；无 auth_path（显式传 cookie）或
        落盘失败均不阻断（内存 cookie 本轮仍有效，失败仅降级）。
        """
        if not self._auth_path:
            return
        try:
            auth: dict = {}
            if os.path.exists(self._auth_path):
                with open(self._auth_path, encoding="utf-8") as fh:
                    auth = json.load(fh)
            pairs = {}
            for kv in self.cookie.split(";"):
                if "=" in kv:
                    k, v = kv.split("=", 1)
                    pairs[k.strip()] = v
            auth.update({
                "cookie": self.cookie,
                "vid": pairs.get("wr_vid", auth.get("vid", "")),
                "saved_at": time.strftime("%Y-%m-%dT%H:%M:%S")})
            tmp = self._auth_path + ".tmp"
            with open(tmp, "w", encoding="utf-8") as fh:
                json.dump(auth, fh, ensure_ascii=False, indent=1)
            os.replace(tmp, self._auth_path)
        except (OSError, ValueError) as exc:
            print(f"[weread] 续期落盘失败（不阻断，内存 cookie 仍有效）: {exc}",
                  flush=True)

    def search(self, keyword: str, count: int = 20) -> list:
        """关键词搜索书单（bookId/标题/作者/简介/封面）。

        勘误（2026-09-10 实测）：wrweb-next 改版后 /web/book/search 已 404，
        新端点 GET /api/store/search?keyword=，返回 results[].books[].bookInfo。
        """
        payload = self._get("/api/store/search", keyword=keyword)
        books = []
        for group in payload.get("results") or []:
            for item in group.get("books") or []:
                info = item.get("bookInfo")
                if info:
                    books.append(info)
        return books[:count]

    def book_info(self, book_id: str) -> dict:
        return self._get("/web/book/info", bookId=book_id)

    def chapter_infos(self, book_id: str) -> list:
        """章节目录树（chapterUid/title/level/wordCount）。

        勘误（2026-09-10 实测）：wrweb-next 返回 data[].updated[]
        （touchFish 时代为 data[].chapters），双形态兼容。
        """
        payload = self._post("/web/book/chapterInfos", {"bookIds": [book_id]})
        data = payload.get("data") or []
        for item in data:
            if item.get("bookId") == book_id:
                return item.get("updated") or item.get("chapters") or []
        if data:
            return data[0].get("updated") or data[0].get("chapters") or []
        return []

    # ----- 章节正文（签名直调） -----

    def _chapter_payload(self, book_id: str, chapter_uid: int, st: int) -> dict:
        """签名 payload（2026-09-10 实测抓包对拍）。

        勘误：ps/pc 不再是 touchFish 时代的固定魔串，而是请求构造瞬间的
        连续时间戳哈希（实测 ps=calcHash(ct-3)、pc=calcHash(ct-1)），
        且新增字段 sc=0 并纳入签名 —— 离线复算抓包 s 逐字节一致。
        """
        ct = current_time()
        payload = {"b": calc_hash(book_id), "c": calc_hash(chapter_uid),
                   "r": random.randint(0, 9999) ** 2, "st": st,
                   "ct": ct, "ps": calc_hash(ct - 3), "pc": calc_hash(ct - 1),
                   "sc": 0}
        payload["s"] = sign(payload)
        return payload

    def _fetch_chunk(self, path: str, book_id: str, chapter_uid: int,
                     st: int) -> str:
        """取单个分片并 chk 剥离 md5 头（空串=无此分片/校验失败）。

        文本形态仍可能是鉴权失败 JSON（对齐 TS assertWeReadTextAuthenticated）。
        """
        raw = self._post(path, self._chapter_payload(book_id, chapter_uid, st),
                         as_text=True)
        stripped = raw.lstrip()
        if stripped.startswith("{"):
            try:
                self._check_auth(json.loads(stripped))
            except ValueError:
                pass                                # 恰好以 { 开头的正文，放行
        return _strip_md5_header(raw)

    def chapter_html(self, book_id: str, chapter_uid: int,
                     fmt: str) -> dict:
        """整章正文：epub/pdf 走 e_0+e_1+e_3（e_2 为样式），txt 走 t_0+t_1。"""
        if fmt in ("epub", "pdf"):
            e0 = self._fetch_chunk("/web/book/chapter/e_0", book_id,
                                   chapter_uid, 0)
            e1 = self._fetch_chunk("/web/book/chapter/e_1", book_id,
                                   chapter_uid, 0)
            e2 = self._fetch_chunk("/web/book/chapter/e_2", book_id,
                                   chapter_uid, 1)
            e3 = self._fetch_chunk("/web/book/chapter/e_3", book_id,
                                   chapter_uid, 0)
            if not (e0 and e1 and e3):
                raise WeReadApiError(
                    f"章节分片缺失 e0/e1/e3（uid={chapter_uid}，可能无权限或签名失效）")
            return {"html": decrypt_body(e0 + e1 + e3),
                    "style": decrypt_body(e2) if e2 else "", "format": fmt}
        if fmt == "txt":
            t0 = self._fetch_chunk("/web/book/chapter/t_0", book_id,
                                   chapter_uid, 0)
            t1 = self._fetch_chunk("/web/book/chapter/t_1", book_id,
                                   chapter_uid, 1)
            if not (t0 and t1):
                raise WeReadApiError(f"txt 分片缺失（uid={chapter_uid}）")
            return {"html": decrypt_body(t0 + t1), "style": "",
                    "format": fmt}
        raise WeReadApiError(f"暂不支持格式 {fmt}")


def _membership_probe(cli: WeReadClient, book_id: str, fmt: str,
                      chapters_meta: list, max_free: int) -> bool:
    """会员（无限卡）权限探测：试取免费范围外第一章。

    2026-09-10 实测：会员账号 paid=0/maxFreeChapter=7 仍可读全本——
    paid 只反映单本购买，不含会员阅读权。一次探测请求判定，不可读
    则回落免费范围（账号安全：不对无权章节反复试探）。
    """
    if max_free <= 0 or len(chapters_meta) <= max_free:
        return False
    probe_meta = chapters_meta[max_free]
    try:
        got = cli.chapter_html(book_id, probe_meta["chapterUid"], fmt)
        return bool(got.get("html", "").strip())
    except WeReadApiError:
        return False


def extract_book(cli: WeReadClient, book_id: str,
                 on_progress=None) -> dict:
    """整书提取 → Book 结构化对象（book.json 原料）。

    权限预检：未购买时探测会员阅读权；两者皆无则 maxFreeChapter 之外
    章节标记不可读，partial=True。
    """
    info = cli.book_info(book_id)
    fmt = info.get("format", "epub")
    max_free = int(info.get("maxFreeChapter") or 0)
    paid = bool(info.get("paid"))
    chapters_meta = cli.chapter_infos(book_id)
    if paid:
        limit = None
    elif _membership_probe(cli, book_id, fmt, chapters_meta, max_free):
        limit = None                                   # 会员全本可读
    else:
        limit = max_free if max_free else 0
    chapters, partial_reasons = [], []
    for idx, meta in enumerate(chapters_meta, 1):
        uid = meta["chapterUid"]
        title = meta.get("title", f"章节{uid}")
        if limit is not None and idx > limit:
            partial_reasons.append(
                f"第{idx}章《{title}》超出免费范围（maxFreeChapter={max_free}）")
            chapters.append({"chapterUid": uid, "title": title,
                             "level": meta.get("level", 1), "html": "",
                             "text": "", "images": [],
                             "skipped": "free-limit"})
            continue
        got = cli.chapter_html(book_id, uid, fmt)
        chapters.append({"chapterUid": uid, "title": title,
                         "level": meta.get("level", 1),
                         "html": got["html"], "text": "", "images": []})
        if on_progress:
            on_progress(idx, len(chapters_meta), title)
    return {"bookId": book_id, "title": info.get("title", book_id),
            "author": info.get("author", ""), "cover": info.get("cover", ""),
            "intro": info.get("intro", ""), "format": fmt,
            "totalWords": info.get("totalWords", 0),
            "paid": paid, "maxFreeChapter": max_free,
            "partial": bool(partial_reasons),
            "partialReasons": partial_reasons[:10],
            "chapterCount": len(chapters_meta),
            "fetchedAt": time.strftime("%Y-%m-%dT%H:%M:%S"),
            "chapters": chapters}
