"""飞书通道：自定义机器人 webhook（提案 4.2 channels / 第 5 章手册）。

域名白名单 open.feishu.cn；兼容新版 {"code":0} 与旧版
{"StatusCode":0} 两种成功契约；ensure_ascii 免疫 GBK 传输乱码。
"""
import json
import logging
import urllib.error
import urllib.parse
import urllib.request

_log = logging.getLogger("paistation.channels.feishu")

_ALLOWED_HOSTS = ("open.feishu.cn",)
_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


class FeishuChannel:
    """text 消息 webhook 通道：send(title, body) -> {ok, code, msg}。"""

    def __init__(self, webhook: str, timeout: int = 10, _opener=None):
        host = urllib.parse.urlsplit(webhook).hostname or ""
        if host not in _ALLOWED_HOSTS:
            raise ValueError(f"webhook 域名不被允许：{host}（仅 {_ALLOWED_HOSTS}）")
        self._webhook = webhook
        self._timeout = timeout
        self._opener = _opener or _OPENER

    def send(self, title: str, body: str) -> dict:
        text = f"【{title}】\n{body}"
        payload = json.dumps({"msg_type": "text", "content": {"text": text}},
                             ensure_ascii=True).encode("ascii")
        req = urllib.request.Request(self._webhook, data=payload,
                                     headers={"Content-Type": "application/json"})
        try:
            with self._opener.open(req, timeout=self._timeout) as resp:
                data = json.loads(resp.read().decode("utf-8"))
            ok = data.get("code", data.get("StatusCode", -1)) == 0
            if not ok:
                _log.warning("飞书拒绝：%s", data)
            return {"ok": ok, "code": data.get("code"),
                    "msg": data.get("msg", "")}
        except (urllib.error.URLError, OSError, ValueError) as exc:
            _log.error("飞书发送失败：%s", exc)
            return {"ok": False, "code": -1, "msg": str(exc)}
