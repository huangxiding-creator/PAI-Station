"""混沌学园纯 API 客户端（M2.5 铸造厂原料入口）。

逆向自前端 bundle（pc-static/client/ea7544c.js）的请求签名协议：
- 登录：POST user.hundun.cn/login，passwd 为密码 MD5
- 签名：Sign = HMAC-SHA1(key=token, msg="clientType=pcweb&ts=..&user_id=..")
  仅 clientType/ts/user_id 三键、按字母序、& 连接、无尾随符；
  头部 Sid=会话ID、SignVersion=V3。实测与线上样本逐字节一致。
- 直连（不走系统代理——国内站点，代理反而污染 POST）。

安全红线：凭据只从 config/hundun.secret.ini（gitignored）读取；
本模块不落盘任何凭据；transcript 等课程内容仅写入 data/ 目录。
"""
import hashlib
import hmac
import json
import time
import urllib.parse
import urllib.request

HOSTS = {"user": "https://user.hundun.cn",
         "course": "https://course.hundun.cn",
         "capi": "https://capi.hundun.cn"}

_DEFAULTS = {"clientType": "pcweb", "device_type": "pcweb", "versionName": "",
             "pcVersionName": "20240830164257", "imei": "", "net": ""}

_UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
       "(KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36")


def md5_hex(text: str) -> str:
    return hashlib.md5(text.encode("utf-8")).hexdigest()


def sign_v3(token: str, ts, user_id: str) -> str:
    """Sign V3：三键字母序拼接后 HMAC-SHA1。"""
    msg = f"clientType=pcweb&ts={ts}&user_id={user_id}"
    return hmac.new(token.encode("utf-8"), msg.encode("utf-8"),
                    hashlib.sha1).hexdigest()


def _fmt(duration) -> str:
    """时长兼容 int 秒与 '119分53秒' 字符串两种形态。"""
    if isinstance(duration, str):
        import re
        m = re.match(r"(?:(\d+)时)?(?:(\d+)分)?(?:(\d+)秒)?", duration.strip())
        if m and any(m.groups()):
            h, mi, s = (int(g or 0) for g in m.groups())
            total = h * 3600 + mi * 60 + s
            return f"{total // 60:02d}:{total % 60:02d}"
        return duration
    s = int(duration or 0)
    return f"{s // 60:02d}:{s % 60:02d}"


class HundunClient:
    """登录态 API 客户端：login() 一次，之后 get/post 全自动签名。"""

    def __init__(self, phone: str, password: str, opener=None):
        self._phone = phone
        self._password = password
        self._opener = opener or urllib.request.build_opener(
            urllib.request.ProxyHandler({}))  # 直连：国内站点免疫代理污染
        self.token = ""
        self.sid = ""
        self.uid = ""

    # ---------- 底层 ----------

    def login(self) -> dict:
        body = dict(_DEFAULTS, ts=int(time.time() * 1000),
                    phone=self._phone, passwd=md5_hex(self._password))
        data = self._raw("POST", "user", "/login", body).get("data") or {}
        session = data.get("session") or {}
        self.token = str(session.get("token", ""))
        self.sid = str(session.get("sid", ""))
        self.uid = str(data.get("uid", ""))
        if not (self.token and self.sid and self.uid):
            raise RuntimeError("混沌学园登录失败：响应缺 session/uid")
        return data

    def _auth_headers(self, ts) -> dict:
        return {"Sign": sign_v3(self.token, ts, self.uid),
                "Sid": self.sid, "SignVersion": "V3", "X-Ts": str(ts)}

    def get(self, host: str, path: str, **params) -> dict:
        merged = dict(_DEFAULTS, ts=int(time.time() * 1000), **params)
        if self.uid:
            merged.setdefault("user_id", self.uid)
        query = urllib.parse.urlencode(merged)
        url = f"{HOSTS[host]}{path}?{query}"
        req = urllib.request.Request(
            url, headers=dict(self._auth_headers(merged["ts"]),
                              Referer="https://www.hundun.cn/",
                              **{"User-Agent": _UA}))
        return self._open(req)

    def post(self, host: str, path: str, **data) -> dict:
        merged = dict(_DEFAULTS, ts=int(time.time() * 1000), **data)
        if self.uid:
            merged.setdefault("user_id", self.uid)
        req = urllib.request.Request(
            f"{HOSTS[host]}{path}", data=json.dumps(merged).encode("utf-8"),
            headers=dict(self._auth_headers(merged["ts"]),
                         **{"Content-Type": "application/json",
                            "Origin": "https://www.hundun.cn",
                            "Referer": "https://www.hundun.cn/",
                            "User-Agent": _UA}))
        return self._open(req)

    def _raw(self, method: str, host: str, path: str, body: dict) -> dict:
        req = urllib.request.Request(
            f"{HOSTS[host]}{path}", data=json.dumps(body).encode("utf-8"),
            headers={"Content-Type": "application/json",
                     "Origin": "https://www.hundun.cn",
                     "Referer": "https://www.hundun.cn/",
                     "User-Agent": _UA}, method=method)
        return self._open(req)

    def _open(self, req) -> dict:
        with self._opener.open(req, timeout=30) as resp:
            payload = json.loads(resp.read().decode("utf-8", "ignore"))
        if payload.get("error_no") not in (0, "0"):
            raise RuntimeError(
                f"hundun API {req.full_url.split('?')[0]} "
                f"error_no={payload.get('error_no')} {payload.get('error_msg')}")
        return payload

    # ---------- 业务 ----------

    def course_detail(self, course_id: str) -> dict:
        return self.get("course", "/get_course_detail", course_id=course_id)

    def course_directory(self, course_id: str) -> list:
        data = self.get("course", "/course/get_course_directory",
                        course_id=course_id)
        return (data.get("data") or {}).get("directory") or []

    def subtitles(self, course_id: str, video_id: str) -> list:
        data = self.post("capi", "/video_subtitles_effects",
                         course_id=course_id, video_id=video_id,
                         original_type=1)
        return (data.get("data") or {}).get("video_subtitles") or []


# ---------- 全要素提取 ----------

def extract_course(cli: HundunClient, course_id: str) -> dict:
    """详情 + 目录 + 逐章字幕 → 结构化课程对象。单章失败不挡整体。"""
    detail = cli.course_detail(course_id).get("course_detail") or {}
    meta = detail.get("course_meta") or {}
    intro = ((detail.get("v2_introduce") or {}).get("content") or "").strip()
    words = ((detail.get("course_good_words") or {}).get("good_words_list")
             or [])
    chapters = []
    for ch in cli.course_directory(course_id):
        item = {"title": ch.get("title", ""),
                "video_id": ch.get("video_id", ""),
                "duration": ch.get("duration", 0),
                "video_no": ch.get("video_no", len(chapters) + 1)}
        try:
            subs = cli.subtitles(course_id, ch.get("video_id", ""))
            item["transcript"] = "\n".join(s.get("content", "").strip()
                                           for s in subs
                                           if s.get("content"))
        except Exception:  # noqa: BLE001 - 单章字幕失败降级为空
            item["transcript"] = ""
        chapters.append(item)
    return {"course_id": course_id,
            "title": meta.get("title", ""),
            "teacher": meta.get("teacher_name", ""),
            "teacher_position": meta.get("teacher_position", ""),
            "duration": meta.get("course_duration", 0),
            "tags": [t.get("tag_name") for t in meta.get("tag_list") or []
                     if t.get("tag_name")],
            "intro": intro,
            "golden_words": [w.get("content", "") for w in words
                             if w.get("content")],
            "chapters": chapters}


def to_markdown(course: dict) -> str:
    """课程对象 → 全要素 markdown（入秘塔专题/技能卡蒸馏的原料格式）。"""
    lines = [f"# {course.get('title', '')}", ""]
    teacher = course.get("teacher", "")
    pos = course.get("teacher_position", "")
    if teacher:
        lines.append(f"讲师：{teacher}{'｜' + pos if pos else ''}")
    lines.append(f"时长：{_fmt(course.get('duration'))}")
    tags = course.get("tags") or []
    if tags:
        lines.append(f"标签：{'、'.join(tags)}")
    intro = course.get("intro", "")
    if intro:
        lines += ["", "## 课程简介", "", intro]
    words = course.get("golden_words") or []
    if words:
        lines += ["", "## 金句", ""]
        lines += [f"- {w}" for w in words]
    for i, ch in enumerate(course.get("chapters") or [], 1):
        lines += ["", f"## 第{_cn(i)}章 {ch.get('title', '')}"
                  f"（{_fmt(ch.get('duration'))}）", ""]
        if ch.get("transcript"):
            lines.append(ch["transcript"])
        else:
            lines.append("（本章字幕未获取）")
    lines.append("")
    return "\n".join(lines)


_CN = "零一二三四五六七八九十"


def _cn(n: int) -> str:
    if n <= 10:
        return _CN[n]
    if n < 20:
        return "十" + (_CN[n - 10] if n % 10 else "")
    return str(n)
