"""M2.5 铸造厂：混沌学园纯 API 客户端（Sign V3 逆向复刻）。"""
import hashlib
import hmac
import json

from paistation.forge.hundun import (
    HundunClient,
    extract_course,
    md5_hex,
    sign_v3,
    to_markdown,
)


class FakeResponse:
    def __init__(self, payload):
        self._payload = payload

    def read(self):
        return json.dumps(self._payload, ensure_ascii=False).encode("utf-8")

    @property
    def status(self):
        return 200

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


class FakeOpener:
    """按序出队的假 opener：记录请求，回放响应。"""

    def __init__(self, responses):
        self.responses = list(responses)
        self.requests = []

    def open(self, req, timeout=None):
        self.requests.append(req)
        return FakeResponse(self.responses.pop(0))


def make_client(opener):
    return HundunClient(phone="13800000000", password="pw123",
                        opener=opener)


def hdr(req, name):
    """urllib 会 capitalize 头键：大小写不敏感取值。"""
    canon = {k.lower(): v for k, v in req.header_items()}
    return canon[name.lower()]


def test_sign_v3_formula():
    # 算法逆向自前端 ea7544c.js：仅 clientType/ts/user_id 三键按字母序
    # 拼接 k=v&，HMAC-SHA1(key=token)；实测与线上样本逐字节一致
    ts, uid = "1788764167891", "3aa088417bdbf61a004a9fb4a16e0e1a"
    expect = hmac.new(b"tok", f"clientType=pcweb&ts={ts}&user_id={uid}".encode(),
                      hashlib.sha1).hexdigest()
    assert sign_v3("tok", ts, uid) == expect


def test_md5_hex():
    assert md5_hex("abc") == "900150983cd24fb0d6963f7d28e17f72"


def test_login_stores_session_and_signs_requests():
    resp = {"error_no": 0, "data": {
        "uid": "UID1", "name": "总包君",
        "session": {"token": "TOKEN9", "sid": "SID7"}}}
    opener = FakeOpener([resp,
                         {"error_no": 0, "data": {"directory": []}}])
    cli = make_client(opener)
    profile = cli.login()
    assert profile["name"] == "总包君" and cli.uid == "UID1"
    # 登录请求：passwd 是 md5
    login_req = opener.requests[0]
    body = json.loads(login_req.data.decode())
    assert body["passwd"] == md5_hex("pw123")
    assert body["phone"] == "13800000000"
    # 后续请求带 Sign/Sid 头
    cli.get("course", "/course/get_course_directory", course_id="C1")
    req2 = opener.requests[1]
    assert hdr(req2, "Sid") == "SID7"
    assert hdr(req2, "SignVersion") == "V3"
    ts = hdr(req2, "X-Ts")
    assert hdr(req2, "Sign") == sign_v3("TOKEN9", ts, "UID1")


def test_get_merges_default_params_and_user():
    opener = FakeOpener([{"error_no": 0, "data": {"directory": []}}])
    cli = make_client(opener)
    cli.token, cli.sid, cli.uid = "T", "S", "U1"
    cli.get("course", "/course/get_course_directory", course_id="C9")
    url = opener.requests[0].full_url
    assert "clientType=pcweb" in url and "user_id=U1" in url
    assert "course_id=C9" in url


def test_error_no_nonzero_raises():
    opener = FakeOpener([{"error_no": 403, "error_msg": "凭证失效"}])
    cli = make_client(opener)
    cli.token, cli.sid, cli.uid = "T", "S", "U1"
    try:
        cli.get("user", "/get_user_info")
        raise AssertionError("should raise")
    except RuntimeError as exc:
        assert "403" in str(exc) and "凭证失效" in str(exc)


def test_extract_course_full_elements():
    detail = {"error_no": 0, "course_detail": {"course_meta": {
        "title": "GEO品牌营销", "teacher_name": "白鸦",
        "teacher_position": "有赞创始人/CEO", "course_duration": 3600,
        "tag_list": [{"tag_name": "营销"}]},
        "v2_introduce": {"content": "课程简介正文"},
        "course_good_words": {"good_words_list": [
            {"content": "金句一"}], "title": "金句"}}}
    directory = {"error_no": 0, "data": {"directory": [
        {"title": "导入", "video_id": "V1", "duration": 253, "video_no": 1},
        {"title": "正课", "video_id": "V2", "duration": 1800, "video_no": 2}]}}
    sub1 = {"error_no": 0, "data": {"title": "导入", "video_subtitles": [
        {"start_time": 0, "end_time": 5000, "content": "第一句"},
        {"start_time": 5000, "end_time": 9000, "content": "第二句"}]}}
    sub2 = {"error_no": 0, "data": {"title": "正课", "video_subtitles": []}}
    opener = FakeOpener([detail, directory, sub1, sub2])
    cli = make_client(opener)
    cli.token, cli.sid, cli.uid = "T", "S", "U1"
    got = extract_course(cli, "C1")
    assert got["title"] == "GEO品牌营销" and got["teacher"] == "白鸦"
    assert got["intro"] == "课程简介正文"
    assert [c["title"] for c in got["chapters"]] == ["导入", "正课"]
    assert got["chapters"][0]["transcript"] == "第一句\n第二句"
    assert got["golden_words"] == ["金句一"]


def test_extract_course_subtitle_failure_tolerated():
    detail = {"error_no": 0, "course_detail": {"course_meta": {
        "title": "T", "teacher_name": "X"},
        "v2_introduce": {"content": ""}}}
    directory = {"error_no": 0, "data": {"directory": [
        {"title": "c1", "video_id": "V1", "duration": 10}]}}
    opener = FakeOpener([detail, directory,
                         {"error_no": 500, "error_msg": "server boom"}])
    cli = make_client(opener)
    cli.token, cli.sid, cli.uid = "T", "S", "U1"
    got = extract_course(cli, "C1")
    assert got["chapters"][0]["transcript"] == ""  # 失败不挡整体


def test_to_markdown_sections():
    got = {"course_id": "C1", "title": "课程A", "teacher": "白鸦",
           "teacher_position": "CEO", "duration": 3600, "tags": ["营销"],
           "intro": "简介内容", "golden_words": ["金句一"],
           "chapters": [{"title": "导入", "video_id": "V1", "duration": 253,
                         "transcript": "第一句\n第二句"}]}
    md = to_markdown(got)
    assert "# 课程A" in md and "白鸦" in md and "CEO" in md
    assert "## 第一章 导入" in md
    assert "第一句" in md and "金句一" in md
    assert "（04:13）" in md  # 253s → mm:ss 时长标注
