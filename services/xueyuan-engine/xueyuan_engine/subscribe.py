# -*- coding: utf-8 -*-
"""订阅消息域 [P2]——FR-P2-02 scaffold：关注省份/主题 + 上新一次性订阅消息。

模板未配置（XY_SUBSCRIBE_TEMPLATES 空或无任何非空 template_id）→ 端点 501
SUBSCRIBE_NOT_CONFIGURED 自拒（与 /refund/callback 同款 idiom：宁可不发，
不裸奔）。配置形态（密钥外置，代码零密钥）：

  XY_SUBSCRIBE_TEMPLATES='{"new_report_province":
      {"template_id":"AbCd…","page":"pages/index/index"}}'

send_subscribe(user, tmpl_key, data)：
- XY_FAKE_NOTIFY=1 且端口∈DEV_FAKE_PAY_PORTS → 确定性假回执（不触网；
  携闸但端口非 dev → RuntimeError 生产自拒，照 XY_FAKE_REFUND 纪律；
  app.assert_fake_pay_allowed 启动腿同查本闸）；
- 模板键未配置 → 记日志返回 None（静默跳过不重发，FR-P2-02 验收）；
- 真发送腿：wechat.get_access_token()（内存缓存）+ 官方 subscribe/send。
  无 template_id 前不实测真实发送（本域测试零真实外呼：真腿全部 monkeypatch）。
  一次性订阅授权次数由微信侧扣减（引擎无法核余次）——发送失败（如 43101
  用户未授权/拒绝）只记结果摘要，绝不重发轰炸。

notify_new_report(report)：上新钩子（content_pipeline/运营侧调用）——按
省份匹配订阅者逐人一次（subscribe_sends UNIQUE(user,tmpl_key,report_id)
去重=「收到一次」判据；同报告重放→skipped 不重发）。
"""
from __future__ import annotations

import hashlib
import json
import logging
import os
import sys

from curl_cffi import requests as cr
from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, store, wechat
from .errors import ApiError
from .me import _uid

router = APIRouter(prefix="/api/v1", tags=["subscribe"])
logger = logging.getLogger("xueyuan.subscribe")

TEMPLATES_ENV = "XY_SUBSCRIBE_TEMPLATES"   # JSON：{tmpl_key: {template_id, page}}
FAKE_ENV = "XY_FAKE_NOTIFY"                # 假回执 dev 闸（生产禁启自检在 app 启动腿）
KINDS = ("province", "topic")
NEW_REPORT_TEMPLATE = "new_report_province"  # 上新（省份订阅）模板键（契约锚点）


# ── 模板配置（env JSON；未配置=功能整体熄火 501）────────────────────
def templates() -> dict:
    raw = os.environ.get(TEMPLATES_ENV, "").strip()
    if not raw:
        return {}
    try:
        d = json.loads(raw)
    except ValueError:
        logger.warning("%s 非法 JSON，按未配置处理", TEMPLATES_ENV)
        return {}
    return d if isinstance(d, dict) else {}


def template_id(tmpl_key: str) -> str:
    tpl = templates().get(tmpl_key)
    if not isinstance(tpl, dict):
        return ""
    return str(tpl.get("template_id") or "").strip()


def template_page(tmpl_key: str) -> str:
    tpl = templates().get(tmpl_key)
    return str((tpl or {}).get("page") or "pages/index/index") if isinstance(tpl, dict) \
        else "pages/index/index"


def configured() -> bool:
    return any(template_id(k) for k in templates())


def _require_configured() -> None:
    if not configured():
        raise ApiError(501, "SUBSCRIBE_NOT_CONFIGURED",
                       "订阅消息模板未配置（P2 未开通）")


# ── 订阅关系 CRUD ────────────────────────────────────────────
class SubscribeIn(BaseModel):
    provinces: list[str] = []
    topics: list[str] = []


def _items(uid: str) -> list[dict]:
    with store._db() as c:
        rows = c.execute(
            "SELECT kind,value,created_at FROM subscriptions WHERE user_id=?"
            " AND status='active' ORDER BY kind,value", (uid,)).fetchall()
    return [dict(r) for r in rows]


def _normalize(values: list[str], kind: str) -> list[str]:
    out: list[str] = []
    for v in values or []:
        s = str(v).strip()
        if s and s not in out:
            out.append(s)
    if len(out) > config.SUBSCRIBE_MAX_PER_KIND:
        raise ApiError(400, "INVALID_PARAM",
                       f"{kind} 订阅数超上限 {config.SUBSCRIBE_MAX_PER_KIND}")
    return out


@router.post("/subscriptions")
def subscribe_set(body: SubscribeIn, request: Request):
    """设置订阅（幂等：UNIQUE(user,kind,value) 重复静默合并）。"""
    uid = _uid(request)
    _require_configured()
    pairs = [("province", v) for v in _normalize(body.provinces, "province")]
    pairs += [("topic", v) for v in _normalize(body.topics, "topic")]
    if not pairs:
        raise ApiError(400, "INVALID_PARAM", "provinces/topics 至少一项非空")
    with store._LOCK, store._db() as c:
        for kind, v in pairs:
            c.execute(
                "INSERT OR IGNORE INTO subscriptions(user_id,kind,value,status,"
                "created_at) VALUES(?,?,?,'active',?)", (uid, kind, v, store.now()))
    return {"items": _items(uid), "configured": True}


@router.get("/subscriptions")
def subscribe_get(request: Request):
    uid = _uid(request)
    _require_configured()
    return {"items": _items(uid), "configured": True}


class UnsubscribeIn(BaseModel):
    kind: str
    value: str


@router.delete("/subscriptions")
def subscribe_del(body: UnsubscribeIn, request: Request):
    """退订（幂等：删行即退；不存在亦 200）。"""
    uid = _uid(request)
    _require_configured()
    if body.kind not in KINDS:
        raise ApiError(400, "INVALID_PARAM", f"kind 仅支持 {'|'.join(KINDS)}")
    with store._LOCK, store._db() as c:
        c.execute("DELETE FROM subscriptions WHERE user_id=? AND kind=? AND value=?",
                  (uid, body.kind, body.value.strip()))
    return {"items": _items(uid), "configured": True}


# ── 发送封装（假闸/静默跳过/真腿三态）──────────────────────────
def _dev_port(env: dict, argv: list | None = None) -> int | None:
    """XY_FAKE_NOTIFY 允许端口探测（app.detect_port 同口径局部只读复刻，
    避免 subscribe→app 循环导入；端口未知=按生产对待）。"""
    argv = sys.argv if argv is None else argv
    for i, a in enumerate(argv):
        if a == "--port" and i + 1 < len(argv) and argv[i + 1].isdigit():
            return int(argv[i + 1])
        if a.startswith("--port=") and a[7:].isdigit():
            return int(a[7:])
    for k in ("XY_PORT", "PORT"):
        if str(env.get(k, "")).isdigit():
            return int(env[k])
    return None


def _fake_gate_open() -> bool:
    """XY_FAKE_NOTIFY=1 仅 dev 端口可出假回执（生产携闸=拒绝执行）。"""
    if os.environ.get(FAKE_ENV) != "1":
        return False
    port = _dev_port(dict(os.environ), sys.argv)
    if port not in config.DEV_FAKE_PAY_PORTS:
        raise RuntimeError(
            f"XY_FAKE_NOTIFY=1 仅允许 dev 端口 {sorted(config.DEV_FAKE_PAY_PORTS)}"
            f"（当前 {port}）——生产进程严禁假回执，拒绝执行"
        )
    return True


def send_subscribe(user: dict, tmpl_key: str, data: dict) -> dict | None:
    """订阅消息发送封装（唯一外呼腿；成功/失败回执 dict，未配置→None 跳过）。

    openid/touser 绝不进日志；失败（errcode≠0，如 43101 未授权）回执照返，
    由调用方记结果摘要且不重发（一次性语义）。
    """
    openid = str(user.get("openid") or "")
    uid = str(user.get("id") or "")
    if not openid:
        logger.warning("send_subscribe 缺 openid（uid=%s），跳过", uid)
        return None
    if _fake_gate_open():
        return {"errcode": 0, "fake": True,
                "msgid": "fakenotify-" + hashlib.sha256(
                    f"{uid}:{tmpl_key}".encode()).hexdigest()[:16]}
    tid = template_id(tmpl_key)
    if not tid:
        logger.info("[subscribe] 模板 %s 未配置，静默跳过（uid=%s）", tmpl_key, uid)
        return None
    token = wechat.get_access_token()  # 内存缓存；token 不落日志不落盘
    r = cr.post(
        f"https://api.weixin.qq.com/cgi-bin/message/subscribe/send?access_token={token}",
        json={"touser": openid, "template_id": tid, "page": template_page(tmpl_key),
              "data": data},
        timeout=15,
    )
    try:
        return r.json()
    except Exception:  # noqa: BLE001 —— 非 JSON 回执按发送失败处理
        return {"errcode": -1, "errmsg": "non-json response"}


def _new_report_data(report: dict) -> dict:
    """上新模板 data 字段（真实模板字段未定，Scaffold 通用位；实测后随模板调整）。"""
    title = str(report.get("title") or "")[:20]
    return {"thing1": {"value": title},
            "thing2": {"value": str(report.get("province") or "")[:5]}}


def notify_new_report(report: dict) -> dict:
    """上新钩子：订阅该报告省份的用户逐人一次（subscribe_sends 去重不重发）。"""
    rid = str(report.get("id") or "")
    prov = str(report.get("province") or "")
    if not rid:
        return {"sent": 0, "skipped": 0, "aborted": "no_report_id"}
    tmpl_key = NEW_REPORT_TEMPLATE
    if not _fake_gate_open() and not template_id(tmpl_key):
        return {"sent": 0, "skipped": 0, "aborted": "template_not_configured"}
    with store._db() as c:
        uids = [r["user_id"] for r in c.execute(
            "SELECT DISTINCT user_id FROM subscriptions WHERE kind='province'"
            " AND value=? AND status='active' ORDER BY user_id", (prov,)).fetchall()]
    sent = skipped = 0
    for subscriber_uid in uids:
        user = store.get_user(subscriber_uid)
        if not user:
            continue
        with store._LOCK, store._db() as c:
            cur = c.execute(
                "INSERT OR IGNORE INTO subscribe_sends(user_id,tmpl_key,report_id,"
                "result,created_at) VALUES(?,?,?,'',?)",
                (subscriber_uid, tmpl_key, rid, store.now()))
            if cur.rowcount == 0:  # 已发过：一次性语义，不重发
                skipped += 1
                continue
        res = send_subscribe(user, tmpl_key, _new_report_data(report))
        ok = bool(res) and res.get("errcode") == 0
        summary = ("ok" if ok else
                   f"errcode={res.get('errcode')}" if res else "skipped")
        with store._LOCK, store._db() as c:
            c.execute("UPDATE subscribe_sends SET result=? WHERE user_id=? AND"
                      " tmpl_key=? AND report_id=?",
                      (summary, subscriber_uid, tmpl_key, rid))
        sent += 1 if ok else 0
    return {"sent": sent, "skipped": skipped}
