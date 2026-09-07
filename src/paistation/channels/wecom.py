"""企业微信通道（提案 4.2 channels）：webhook 直连起步。

- ensure_ascii=True：传输层免疫 GBK 乱码（notify_wecom 实战配方）
- ProxyHandler({})：国内 API 直连铁律（We-AIPO R1-S1）
- 域名白名单 qyapi.weixin.qq.com：防 webhook 被指向任意地址
"""
import json
import logging
import urllib.error
import urllib.parse
import urllib.request

_log = logging.getLogger("paistation.channels.wecom")

_ALLOWED_HOSTS = ("qyapi.weixin.qq.com",)
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


class WeComChannel:
    """markdown 消息 webhook 通道：send(title, body) -> {ok, errcode, errmsg}。"""

    def __init__(self, webhook: str, timeout: int = 10, _opener=None):
        host = urllib.parse.urlsplit(webhook).hostname or ""
        if host not in _ALLOWED_HOSTS:
            raise ValueError(f"webhook 域名不被允许：{host}（仅 {_ALLOWED_HOSTS}）")
        self._webhook = webhook
        self._timeout = timeout
        self._opener = _opener or _OPENER

    def send(self, title: str, body: str) -> dict:
        content = f"**{title}**\n{body}"
        payload = json.dumps({"msgtype": "markdown",
                              "markdown": {"content": content}},
                             ensure_ascii=True).encode("ascii")
        req = urllib.request.Request(self._webhook, data=payload,
                                     headers={"Content-Type": "application/json"})
        try:
            with self._opener.open(req, timeout=self._timeout) as resp:
                data = json.loads(resp.read().decode("utf-8"))
            ok = data.get("errcode") == 0
            if not ok:
                _log.warning("企微拒绝：%s", data)
            return {"ok": ok, "errcode": data.get("errcode"),
                    "errmsg": data.get("errmsg")}
        except (urllib.error.URLError, OSError, ValueError) as exc:
            _log.error("企微发送失败：%s", exc)
            return {"ok": False, "errcode": -1, "errmsg": str(exc)}
