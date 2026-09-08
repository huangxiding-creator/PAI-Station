"""钉钉通道：自定义机器人 webhook + 加签（提案 4.2 channels / 第 5 章）。

签名 = base64(HMAC-SHA256(secret, f"{timestamp}\\n{secret}"))；
域名白名单 oapi.dingtalk.com；无 secret 时纯 token 模式。
"""
import base64
import hashlib
import hmac
import json
import logging
import time
import urllib.error
import urllib.parse
import urllib.request

_log = logging.getLogger("paistation.channels.dingtalk")

_ALLOWED_HOSTS = ("oapi.dingtalk.com",)
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


class DingTalkChannel:
    """markdown 消息 webhook 通道：send(title, body) -> {ok, errcode, errmsg}。"""

    def __init__(self, webhook: str, secret: str = "", timeout: int = 10,
                 _opener=None, _now=time.time):
        host = urllib.parse.urlsplit(webhook).hostname or ""
        if host not in _ALLOWED_HOSTS:
            raise ValueError(f"webhook 域名不被允许：{host}（仅 {_ALLOWED_HOSTS}）")
        self._webhook = webhook
        self._secret = secret
        self._timeout = timeout
        self._opener = _opener or _OPENER
        self._now = _now

    @staticmethod
    def _sign(secret: str, timestamp_ms: int) -> str:
        digest = hmac.new(secret.encode("utf-8"),
                          f"{timestamp_ms}\n{secret}".encode(),
                          hashlib.sha256).digest()
        return urllib.parse.quote_plus(base64.b64encode(digest).decode("ascii"))

    def _signed_url(self) -> str:
        if not self._secret:
            return self._webhook
        ts = int(self._now() * 1000)
        return (f"{self._webhook}&timestamp={ts}"
                f"&sign={self._sign(self._secret, ts)}")

    def send(self, title: str, body: str) -> dict:
        content = f"### {title}\n\n{body}"
        payload = json.dumps({"msgtype": "markdown",
                              "markdown": {"title": title, "text": content}},
                             ensure_ascii=True).encode("ascii")
        req = urllib.request.Request(self._signed_url(), data=payload,
                                     headers={"ContentType": "application/json"})
        try:
            with self._opener.open(req, timeout=self._timeout) as resp:
                data = json.loads(resp.read().decode("utf-8"))
            ok = data.get("errcode") == 0
            if not ok:
                _log.warning("钉钉拒绝：%s", data)
            return {"ok": ok, "errcode": data.get("errcode"),
                    "errmsg": data.get("errmsg")}
        except (urllib.error.URLError, OSError, ValueError) as exc:
            _log.error("钉钉发送失败：%s", exc)
            return {"ok": False, "errcode": -1, "errmsg": str(exc)}
