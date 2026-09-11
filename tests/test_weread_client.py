"""M2.5 铸造厂：微信读书客户端 + 解混淆黄金向量测试。"""
import json
import os

import pytest

from paistation.forge import weread
from paistation.forge.weread import (
    CircuitBreakerError,
    WeReadApiError,
    WeReadAuthError,
    WeReadClient,
    deobfuscate,
    extract_book,
)
from paistation.forge.weread_sign import calc_hash

_VECTORS = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                        "weread_golden_vectors.json")


def _golden():
    with open(_VECTORS, encoding="utf-8") as fh:
        return json.load(fh)


# ---------- 解混淆（TS 原版 wire 向量） ----------

def test_deobfuscate_golden_wires():
    for name, vec in _golden()["wire"].items():
        assert deobfuscate(vec["wire"]) == vec["plain"], f"wire {name} 还原失败"


def test_deobfuscate_bad_md5_header():
    assert deobfuscate("0" * 32 + "XYZ") == ""


def test_deobfuscate_empty():
    assert deobfuscate("") == ""


# ---------- 假件 ----------

class FakeResponse:
    def __init__(self, payload, set_cookies=None):
        self._payload = payload
        self._set_cookies = set_cookies or []

    def read(self):
        if isinstance(self._payload, (bytes, str)):
            return (self._payload.encode("utf-8")
                    if isinstance(self._payload, str) else self._payload)
        return json.dumps(self._payload, ensure_ascii=False).encode("utf-8")

    @property
    def status(self):
        return 200

    def headers_get_all(self, name):
        return self._set_cookies if name.lower() == "set-cookie" else []

    class _Headers:
        def __init__(self, set_cookies):
            self._set_cookies = set_cookies

        def get_all(self, name):
            return self._set_cookies if name.lower() == "set-cookie" else []

    @property
    def headers(self):
        return self._Headers(self._set_cookies)

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


class FakeOpener:
    """按序出队：记录请求，回放响应（支持 HTTPError 注入）。"""

    def __init__(self, responses):
        self.responses = list(responses)
        self.requests = []

    def open(self, req, timeout=None):
        self.requests.append(req)
        item = self.responses.pop(0)
        if isinstance(item, Exception):
            raise item
        return FakeResponse(*item) if isinstance(item, tuple) else FakeResponse(item)


def make_client(opener, cookie="wr_skey=S1; wr_vid=123"):
    return WeReadClient(cookie=cookie, opener=opener, fast=True)


def body_of(req):
    return json.loads(req.data.decode("utf-8"))


# ---------- 登录态 ----------

def test_auth_error_on_2012():
    cli = make_client(FakeOpener([{"errCode": -2012}]))
    with pytest.raises(WeReadAuthError):
        cli.search("测试")


def test_load_cookie_missing_file(tmp_path):
    with pytest.raises(WeReadAuthError):
        WeReadClient(auth_path=str(tmp_path / "none.json"))


def test_load_cookie_ok(tmp_path):
    auth = tmp_path / "auth.json"
    auth.write_text(json.dumps({"cookie": "wr_skey=K; wr_vid=1"}),
                    encoding="utf-8")
    cli = WeReadClient(auth_path=str(auth), fast=True)
    assert cli.cookie.startswith("wr_skey=K")


def test_is_logged_in_true():
    cli = make_client(FakeOpener([{"accountsets": {"synckey": 1}}]))
    assert cli.is_logged_in() is True


def test_is_logged_in_false_on_auth_error():
    cli = make_client(FakeOpener([{"errCode": -2012}]))
    assert cli.is_logged_in() is False


# ---------- 业务 API ----------

def test_search_returns_books_and_hits_endpoint():
    """新版 /api/store/search：results[].books[].bookInfo 扁平化。"""
    payload = {"sid": "x", "results": [
        {"title": "电子书", "books": [
            {"bookInfo": {"bookId": "1", "title": "智能商业"}},
            {"bookInfo": {"bookId": "2", "title": "智能战略"}}]},
        {"title": "有声书", "books": [{"bookInfo": {"bookId": "3"}}]},
    ]}
    opener = FakeOpener([payload])
    cli = make_client(opener)
    assert cli.search("曾鸣") == [{"bookId": "1", "title": "智能商业"},
                                  {"bookId": "2", "title": "智能战略"},
                                  {"bookId": "3"}]
    req = opener.requests[0]
    assert "/api/store/search" in req.full_url
    assert "keyword=" in req.full_url


def test_chapter_infos_matches_book():
    """旧形态 data[].chapters 仍兼容。"""
    chapters = [{"chapterUid": 1, "title": "第一章"}]
    opener = FakeOpener([{"data": [{"bookId": "B1", "chapters": chapters}]}])
    cli = make_client(opener)
    assert cli.chapter_infos("B1") == chapters


def test_chapter_infos_new_updated_shape():
    """wrweb-next 新形态 data[].updated[]（2026-09-10 实测）。"""
    chapters = [{"chapterUid": 1, "title": "封面", "level": 1}]
    opener = FakeOpener([{"data": [{"bookId": "B1", "updated": chapters}]}])
    cli = make_client(opener)
    assert cli.chapter_infos("B1") == chapters


def test_chapter_html_epub_pipeline():
    """e_0+e_1+e_3（同一加密单元的三段）拼接解混淆，e_2 为独立样式单元。"""
    plain = ("<h1>第一章 智能商业</h1><p>网络协同与数据智能双螺旋。"
             "</p><p>第二章内容预览：数据流动。</p>")
    e0, e1, e3 = _obfuscate_split(plain, parts=3)
    e2 = _golden()["wire"]["css"]["wire"]                # 样式是独立单元
    opener = FakeOpener([e0, e1, e2, e3])
    cli = make_client(opener)
    got = cli.chapter_html("3300029037", 1, "epub")
    assert got["html"] == plain
    assert got["style"] == "p { margin: 0 }"
    # 四个请求均带签名字段 s 与 b/c hash；ps/pc 为 ct 邻近时间戳哈希（2026-09 实测）
    for req in opener.requests:
        body = body_of(req)
        assert body["s"] and body["b"] == calc_hash("3300029037")
        assert body["ct"] > 0 and body["sc"] == 0
        assert body["ps"] == calc_hash(body["ct"] - 3)
        assert body["pc"] == calc_hash(body["ct"] - 1)


def test_chapter_html_missing_chunk_raises():
    opener = FakeOpener(["", "", "", ""])           # chk 对短串返回原串
    cli = make_client(opener)
    with pytest.raises(WeReadApiError):
        cli.chapter_html("B", 1, "epub")


def test_circuit_breaker_after_consecutive_errors():
    import urllib.error
    errs = [urllib.error.HTTPError("u", 500, "boom", None, None)] * 3
    opener = FakeOpener(errs)
    cli = make_client(opener)
    with pytest.raises((WeReadApiError, CircuitBreakerError)):
        for _ in range(3):
            cli.search("x")


def _obfuscate_split(plain, parts=3, prefix="Z"):
    """构造真实形态线格式：整体加密→切分→每段配 md5 头。

    服务端对整章 base64+swap 后切为 e_0/e_1/e_3 三段（每段独立 chk 头），
    客户端 chk 逐段剥离、拼接后整体 decrypt——夹具必须同构。
    """
    import base64 as b64mod
    import hashlib
    b64 = b64mod.b64encode(plain.encode("utf-8")).decode("ascii")
    table = weread._swap_table(b64)                      # noqa: SLF001 - 测试内构造
    chars = list(b64)
    for i in range(1, len(table), 2):                    # 加密序：i 升序、j 0→1
        for j in (0, 1):
            a, b = table[i] + j, table[i - 1] + j
            chars[a], chars[b] = chars[b], chars[a]
    body = prefix + "".join(chars)
    size = -(-len(body) // parts)                        # ceil 均分
    segments = [body[k:k + size] for k in range(0, len(body), size)]
    wires = []
    for seg in segments:
        head = hashlib.md5(seg.encode("utf-8")).hexdigest().upper()
        wires.append(head + seg)
    return wires


# ---------- 整书提取 ----------

def _book_fixtures():
    info = {"errCode": 0, "bookId": "B1", "title": "智能商业",
            "author": "曾鸣", "format": "epub", "paid": True,
            "maxFreeChapter": 1, "totalWords": 100, "cover": "c.jpg"}
    chapters = {"data": [{"bookId": "B1", "chapters": [
        {"chapterUid": 1, "title": "第一章", "level": 1},
        {"chapterUid": 2, "title": "第二章", "level": 1}]}]}
    # 每章请求序：e_0, e_1, e_2(样式), e_3 —— 夹具必须按此序排列
    w0, w1, w3 = _obfuscate_split("<h1>第一章</h1><p>正文甲。</p>", parts=3)
    css_wire = _golden()["wire"]["css"]["wire"]
    return info, chapters, [w0, w1, css_wire, w3]


def test_extract_book_full_for_paid():
    info, chapters, wires = _book_fixtures()
    opener = FakeOpener([info, chapters] + wires * 2)     # 2 章 × 4 分片
    cli = make_client(opener)
    progress = []
    book = extract_book(cli, "B1",
                        on_progress=lambda i, n, t: progress.append((i, n)))
    assert book["title"] == "智能商业" and book["partial"] is False
    assert len(book["chapters"]) == 2
    assert book["chapters"][0]["html"].startswith("<h1>第一章")
    assert progress == [(1, 2), (2, 2)]


def test_extract_book_membership_reads_full():
    """会员（无限卡）：paid=0/maxFree=1 但探测章可读 → 全本提取。"""
    info, chapters, wires = _book_fixtures()
    info = dict(info, paid=False, maxFreeChapter=1)
    # 序：探测第 2 章(4) → 第 1 章(4) → 第 2 章(4)
    opener = FakeOpener([info, chapters] + wires * 3)
    cli = make_client(opener)
    book = extract_book(cli, "B1")
    assert book["partial"] is False
    assert len(book["chapters"]) == 2
    assert book["chapters"][1]["html"].startswith("<h1>第一章")


def test_extract_book_partial_for_free():
    info, chapters, wires = _book_fixtures()
    info = dict(info, paid=False, maxFreeChapter=1)
    # 序：探测第 2 章失败（4 空串）→ 仅第 1 章真实分片
    opener = FakeOpener([info, chapters] + ["", "", "", ""] + wires)
    cli = make_client(opener)
    book = extract_book(cli, "B1")
    assert book["partial"] is True
    assert book["chapters"][1]["skipped"] == "free-limit"
    assert book["chapters"][1]["html"] == ""
    assert "第二章" in book["partialReasons"][0]


# ---------- 覆盖补强：节流/错误规约/续期/txt/边界 ----------

def test_guard_throttles_between_requests():
    """标准节奏下第二次请求必须落入 1.5~3.5s 随机睡眠窗。"""
    now = {"t": 1000.0}
    slept = []
    cli = WeReadClient(cookie="wr_skey=S", opener=FakeOpener([]),
                       time_func=lambda: now["t"],
                       sleep_func=slept.append, fast=False)
    cli._guard()                                          # noqa: SLF001 - 直测节流
    assert slept == []                                    # 首次无等待
    cli._guard()                                          # noqa: SLF001
    assert len(slept) == 1 and 1.5 <= slept[0] <= 3.5


def test_circuit_breaker_error_propagates():
    """连续 3 次网络异常后，第 3 次必须升级为熔断（而非普通 ApiError）。"""
    import urllib.error
    err = urllib.error.URLError("connection reset")
    cli = make_client(FakeOpener([err, err, err]))
    breaker = None
    for _ in range(3):
        try:
            cli.search("x")
        except CircuitBreakerError as exc:
            breaker = exc
            break
        except WeReadApiError:
            continue                                 # 前两次：普通异常继续打点
    assert isinstance(breaker, CircuitBreakerError)


def test_http_401_maps_to_auth_error():
    import urllib.error
    cli = make_client(FakeOpener([
        urllib.error.HTTPError("u", 401, "unauth", None, None)]))
    with pytest.raises(WeReadAuthError):
        cli.search("x")


def test_network_error_maps_to_api_error():
    import urllib.error
    cli = make_client(FakeOpener([urllib.error.URLError("reset")]))
    with pytest.raises(WeReadApiError):
        cli.search("x")


def test_non_json_response_raises_api_error():
    """验证页/风控 HTML 必须显式报错，不允许静默空结果。"""
    cli = make_client(FakeOpener(["<html>请完成验证</html>"]))
    with pytest.raises(WeReadApiError, match="非 JSON"):
        cli.search("x")


def test_load_cookie_without_skey_raises(tmp_path):
    p = tmp_path / "auth.json"
    p.write_text(json.dumps({"cookie": "wr_vid=1"}), encoding="utf-8")
    with pytest.raises(WeReadAuthError, match="wr_skey"):
        WeReadClient(auth_path=str(p))


def test_renew_success_rotates_skey():
    opener = FakeOpener([({"succ": 1},
                          ["wr_skey=NEW; Path=/; HttpOnly",
                           "wr_gid=g1; Path=/"])])
    cli = make_client(opener)
    assert cli.renew() is True
    kv = dict(kv.split("=", 1) for kv in cli.cookie.split("; ") if "=" in kv)
    assert kv["wr_skey"] == "NEW"      # 新 skey 生效
    assert kv["wr_vid"] == "123"       # 旧键保留
    assert kv["wr_gid"] == "g1"        # 新增键合并
    body = body_of(opener.requests[0])
    assert body["ql"] is False and body["rq"].startswith("http")


def test_renew_success_persists_auth_file(tmp_path):
    auth = tmp_path / "auth.json"
    auth.write_text(json.dumps(
        {"cookie": "wr_skey=OLD; wr_vid=123", "vid": "123",
         "name": "me", "saved_at": "2026-09-10T00:00:00"}), encoding="utf-8")
    cli = WeReadClient(
        auth_path=str(auth), fast=True,
        opener=FakeOpener([({"succ": 1},
                            ["wr_skey=NEW; Path=/; HttpOnly"])]))
    assert cli.renew() is True
    saved = json.loads(auth.read_text(encoding="utf-8"))
    assert "wr_skey=NEW" in saved["cookie"]      # 新 skey 落盘
    assert saved["vid"] == "123"                 # 旧字段保留
    assert saved["name"] == "me"                 # name 不被抹掉
    assert saved["saved_at"] != "2026-09-10T00:00:00"


def test_renew_persist_failure_does_not_break(tmp_path):
    # auth_path 指向不可写目录：落盘失败但 renew 仍算成功（内存 cookie 有效）
    bad = tmp_path / "no_dir" / "auth.json"
    cli = WeReadClient(
        cookie="wr_skey=OLD; wr_vid=123", auth_path=str(bad), fast=True,
        opener=FakeOpener([({"succ": 1}, ["wr_skey=NEW"]) ]))
    assert cli.renew() is True
    assert "wr_skey=NEW" in cli.cookie


def test_renew_failure_returns_false():
    cli = make_client(FakeOpener([{"succ": 0}]))
    assert cli.renew() is False


def test_renew_http_error_raises():
    import urllib.error
    cli = make_client(FakeOpener([
        urllib.error.HTTPError("u", 500, "x", None, None)]))
    with pytest.raises(WeReadApiError, match="renewal"):
        cli.renew()


def test_chapter_infos_falls_back_to_first():
    chapters = [{"chapterUid": 1, "title": "第一章"}]
    opener = FakeOpener([{"data": [{"bookId": "OTHER", "chapters": chapters}]}])
    cli = make_client(opener)
    assert cli.chapter_infos("B1") == chapters


def test_fetch_chunk_auth_json_detected():
    """分片返回鉴权失败 JSON 时必须抛 WeReadAuthError 而非当正文。"""
    cli = make_client(FakeOpener(['{"errCode": -2012}']))
    with pytest.raises(WeReadAuthError):
        cli._fetch_chunk("/web/book/chapter/t_0", "B", 1, 0)  # noqa: SLF001


def test_fetch_chunk_brace_plain_text_passes():
    """恰好以 { 开头的合法正文放行（JSON 解析失败不误杀）。"""
    cli = make_client(FakeOpener(["{不是JSON的正文"]))
    got = cli._fetch_chunk("/web/book/chapter/t_0", "B", 1, 0)  # noqa: SLF001
    assert got == "{不是JSON的正文"


def test_chapter_html_txt_pipeline():
    plain = "第一回 楔子\n张三丰道：练拳不练功，到老一场空。"
    t0, t1 = _obfuscate_split(plain, parts=2)
    opener = FakeOpener([t0, t1])
    cli = make_client(opener)
    got = cli.chapter_html("B", 1, "txt")
    assert got["html"] == plain
    assert got["format"] == "txt" and got["style"] == ""


def test_chapter_html_txt_missing_chunk_raises():
    cli = make_client(FakeOpener(["", "x"]))
    with pytest.raises(WeReadApiError, match="txt"):
        cli.chapter_html("B", 1, "txt")


def test_chapter_html_unsupported_format():
    cli = make_client(FakeOpener([]))
    with pytest.raises(WeReadApiError, match="暂不支持"):
        cli.chapter_html("B", 1, "mobi")


def test_swap_table_short_string_empty():
    assert weread._swap_table("ab") == []            # noqa: SLF001 - 边界直测


def test_b64_decode_invalid_returns_empty():
    assert weread._b64_decode("a") == ""             # noqa: SLF001 - 宽松语义
