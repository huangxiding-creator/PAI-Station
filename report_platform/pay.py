# -*- coding: utf-8 -*-
"""pay — 全自动企业支付模块 (F5a-2: 微信支付v3 + 支付宝, 凭证缺席=stub).

设计: 凭证从 secret.ini 读 (绝不进仓/备份); 缺席时 pay_ready()=False,
平台退回个人码半自动流程零影响; 凭证一到填入重启即全自动:
  下单 → 用户付 → 渠道回调 → 验签 → mark_paid 幂等核销 → 解锁阅读+PDF.

微信支付 v3 (Native 扫码, 手机微信内长按识别可付):
  签名串 METHOD\nURL(path?query)\nTS\nNONCE\nBODY\n → RSA-SHA256 → Authorization
  下单 POST /v3/pay/transactions/native → code_url (自绘二维码)
  回调 POST notify_url → 平台证书验签 → resource AES-256-GCM 解密
  兜底 GET /v3/pay/transactions/out-trade-no/{no}?mchid= (回调丢失查单)
支付宝 (手机网站支付 wap):
  参数 sorted k=v& → SHA256withRSA 签名 → 跳转表单
  回调 notify → 支付宝公钥 RSA2 验签
"""
from __future__ import annotations

import base64
import configparser
import hashlib
import json
import os
import sqlite3
import time
import uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parent
INI = ROOT / "secret.ini"
CERTS = ROOT / "certs"

try:
    from cryptography.hazmat.primitives import hashes, serialization
    from cryptography.hazmat.primitives.asymmetric import padding
    from cryptography.hazmat.primitives.ciphers.aead import AESGCM
    _CRYPTO = True
except ImportError:                                       # ECS 极端降级
    _CRYPTO = False


# ---------------------------------------------------------- 凭证装载

def load_secrets() -> dict:
    """secret.ini [wxpay]/[alipay]/[pay] → dict; 段缺席=None (stub 模式).

    健壮性: 裸键格式 (无 [section] 头, 如 admin_token=xx) 或解析异常
    一律降级为空凭证 — 平台主流程绝不因凭证文件形态崩溃.
    """
    cp = configparser.ConfigParser()
    if INI.is_file():
        try:
            cp.read(INI, encoding="utf-8")
        except (configparser.MissingSectionHeaderError,
                configparser.Error, UnicodeDecodeError):
            pass                      # 裸键/损坏文件 → 全 stub
    out: dict = {"notify_base": "", "wxpay": None, "alipay": None}
    if cp.has_section("pay"):
        out["notify_base"] = (cp.get("pay", "notify_base", fallback="")
                              .rstrip("/"))
    if cp.has_section("wxpay"):
        w = dict(cp.items("wxpay"))
        need = ("mchid", "appid", "api_v3_key", "serial_no",
                "private_key_pem")
        w["_ok"] = all(w.get(k) for k in need) and _CRYPTO
        out["wxpay"] = w
    if cp.has_section("alipay"):
        a = dict(cp.items("alipay"))
        need = ("app_id", "private_key_pem", "alipay_public_pem")
        a["_ok"] = all(a.get(k) for k in need) and _CRYPTO
        out["alipay"] = a
    return out


def pay_ready(sec: dict | None = None) -> dict:
    sec = sec or load_secrets()
    return {"wxpay": bool(sec["wxpay"] and sec["wxpay"].get("_ok")),
            "alipay": bool(sec["alipay"] and sec["alipay"].get("_ok"))}


# ---------------------------------------------------------- 通用签名件

def rsa_sign_sha256(private_pem: str, message: str) -> str:
    key = serialization.load_pem_private_key(
        private_pem.encode(), password=None)
    sig = key.sign(message.encode(), padding.PKCS1v15(), hashes.SHA256())
    return base64.b64encode(sig).decode()


def rsa_verify_sha256(public_pem: str, message: str, sig_b64: str) -> bool:
    try:
        key = serialization.load_pem_public_key(public_pem.encode())
        key.verify(base64.b64decode(sig_b64), message.encode(),
                   padding.PKCS1v15(), hashes.SHA256())
        return True
    except Exception:
        return False


def aes_gcm_decrypt(key: str, nonce: str, ciphertext_b64: str,
                    aad: str = "") -> bytes:
    """微信 v3 resource 解密: key=APIv3密钥(32B) nonce=12B aad=关联数据."""
    ct = base64.b64decode(ciphertext_b64)
    return AESGCM(key.encode()).decrypt(nonce.encode(), ct,
                                        aad.encode() or None)


# ---------------------------------------------------------- 微信支付 v3

WX_HOST = "https://api.mch.weixin.qq.com"


def _wx_auth_header(w: dict, method: str, url_path: str, body: str) -> str:
    ts = str(int(time.time()))
    nonce = uuid.uuid4().hex
    msg = f"{method.upper()}\n{url_path}\n{ts}\n{nonce}\n{body}\n"
    sig = rsa_sign_sha256(w["private_key_pem"], msg)
    return (f'WECHATPAY2-SHA256-RSA2048 mchid="{w["mchid"]}",'
            f'nonce_str="{nonce}",signature="{sig}",'
            f'timestamp="{ts}",serial_no="{w["serial_no"]}"')


def _wx_call(w: dict, method: str, path: str, payload: dict | None,
             timeout: float = 10.0) -> tuple[int, dict]:
    import urllib.request
    body = json.dumps(payload, ensure_ascii=False) if payload is not None \
        else ""
    req = urllib.request.Request(WX_HOST + path, method=method.upper(),
                                 data=body.encode() if body else None,
                                 headers={"Accept": "application/json",
                                          "Content-Type": "application/json",
                                          "User-Agent": "rp-f5a/1.0",
                                          "Authorization":
                                          _wx_auth_header(w, method, path,
                                                          body)})
    try:
        with urllib.request.urlopen(req, timeout=timeout) as r:
            data = r.read().decode("utf-8", "replace")
            return r.status, (json.loads(data) if data.strip() else {})
    except urllib.error.HTTPError as e:
        data = e.read().decode("utf-8", "replace")
        try:
            return e.code, json.loads(data)
        except json.JSONDecodeError:
            return e.code, {"raw": data[:400]}


def wx_native_order(sec: dict, w: dict, out_trade_no: str,
                    total_fen: int, desc: str) -> dict:
    """Native 下单 → {ok, code_url?}."""
    if not sec["notify_base"]:
        return {"ok": False, "error": "notify_base 未配置 (需 https 域名)"}
    code, r = _wx_call(w, "POST", "/v3/pay/transactions/native", {
        "appid": w["appid"], "mchid": w["mchid"],
        "description": desc[:120], "out_trade_no": out_trade_no,
        "notify_url": f"{sec['notify_base']}/api/pay/notify/wx",
        "amount": {"total": total_fen, "currency": "CNY"}})
    if code == 200 and r.get("code_url"):
        return {"ok": True, "code_url": r["code_url"]}
    return {"ok": False, "error": f"wx {code}: {json.dumps(r, ensure_ascii=False)[:200]}"}


def wx_query(w: dict, out_trade_no: str) -> dict:
    """主动查单 (回调丢失兜底) → {ok, trade_state?}."""
    path = (f"/v3/pay/transactions/out-trade-no/{out_trade_no}"
            f"?mchid={w['mchid']}")
    code, r = _wx_call(w, "GET", path, None)
    if code == 200:
        return {"ok": True, "trade_state": r.get("trade_state"),
                "transaction_id": r.get("transaction_id", "")}
    return {"ok": False, "error": f"wx {code}"}


# ------------------------------------------------ 微信内一键支付 (JSAPI)

def jsapi_ready(w: dict | None) -> bool:
    """JSAPI 可用 = 商户五件套齐 + 公众号 oauth_secret 配了."""
    return bool(w and w.get("_ok") and w.get("oauth_secret"))


def wx_oauth_authorize_url(w: dict, redirect_uri: str,
                           state: str = "rp") -> str:
    """snsapi_base 静默授权跳转 (服务端 302 用, 前端零外域 URL)."""
    from urllib.parse import quote
    return ("https://open.weixin.qq.com/connect/oauth2/authorize"
            f"?appid={w['appid']}&redirect_uri={quote(redirect_uri, safe='')}"
            f"&response_type=code&scope=snsapi_base&state={state}"
            "#wechat_redirect")


def wx_oauth_code2openid(w: dict, code: str) -> dict:
    """OAuth code → openid (公众号侧, 独立域名 api.weixin.qq.com)."""
    import urllib.request
    url = ("https://api.weixin.qq.com/sns/oauth2/access_token"
           f"?appid={w['appid']}&secret={w['oauth_secret']}"
           f"&code={code}&grant_type=authorization_code")
    try:
        with urllib.request.urlopen(url, timeout=10) as r:
            d = json.loads(r.read().decode("utf-8", "replace"))
    except Exception as e:                                   # noqa: BLE001
        return {"ok": False, "error": f"oauth net: {str(e)[:120]}"}
    if d.get("openid"):
        return {"ok": True, "openid": d["openid"]}
    return {"ok": False, "error": f"oauth {d.get('errcode')}: "
                                  + str(d.get("errmsg", ""))[:120]}


def wx_jsapi_order(sec: dict, w: dict, out_trade_no: str,
                   total_fen: int, desc: str, openid: str) -> dict:
    """JSAPI 下单 (微信内拉起支付) → {ok, prepay_id?}."""
    if not sec["notify_base"]:
        return {"ok": False, "error": "notify_base 未配置 (需 https 域名)"}
    code, r = _wx_call(w, "POST", "/v3/pay/transactions/jsapi", {
        "appid": w["appid"], "mchid": w["mchid"],
        "description": desc[:120], "out_trade_no": out_trade_no,
        "notify_url": f"{sec['notify_base']}/api/pay/notify/wx",
        "amount": {"total": total_fen, "currency": "CNY"},
        "payer": {"openid": openid}})
    if code == 200 and r.get("prepay_id"):
        return {"ok": True, "prepay_id": r["prepay_id"]}
    return {"ok": False, "error": f"wx {code}: "
                                  + json.dumps(r, ensure_ascii=False)[:200]}


def wx_jsapi_params(w: dict, prepay_id: str) -> dict:
    """prepay_id → WeixinJSBridge.invoke 支付参数 (RSA 签名)."""
    ts = str(int(time.time()))
    nonce = uuid.uuid4().hex
    pkg = f"prepay_id={prepay_id}"
    msg = f"{w['appid']}\n{ts}\n{nonce}\n{pkg}\n"
    return {"appId": w["appid"], "timeStamp": ts, "nonceStr": nonce,
            "package": pkg, "signType": "RSA",
            "paySign": rsa_sign_sha256(w["private_key_pem"], msg)}


def wx_verify_notify(w: dict, headers: dict, body: str,
                     platform_pub_pem: str) -> dict | None:
    """回调验签+解密 → 通知 dict; 失败 None. platform_pub_pem=平台证书公钥."""
    sig = headers.get("wechatpay-signature", "")
    ts = headers.get("wechatpay-timestamp", "")
    nonce = headers.get("wechatpay-nonce", "")
    if not (sig and ts and nonce):
        return None
    if abs(time.time() - int(ts or 0)) > 300:            # 防重放窗口
        return None
    msg = f"{ts}\n{nonce}\n{body}\n"
    if not rsa_verify_sha256(platform_pub_pem, msg, sig):
        return None
    try:
        env = json.loads(body).get("resource", {})
        raw = aes_gcm_decrypt(w["api_v3_key"], env["nonce"],
                              env["ciphertext"],
                              env.get("associated_data", ""))
        return json.loads(raw.decode("utf-8"))
    except Exception:
        return None


# ---------------------------------------------------------- 支付宝 (RSA2)

def _ali_pem(s: str) -> str:
    return s if "-----BEGIN" in s else (
        "-----BEGIN RSA PRIVATE KEY-----\n" + s + "\n"
        "-----END RSA PRIVATE KEY-----")


def ali_signed_params(a: dict, biz: dict, method: str,
                      return_url: str = "", notify_url: str = "") -> dict:
    """组装已签名网关参数 (手机网站支付 alipay.trade.wap.pay)."""
    p = {"app_id": a["app_id"], "method": method,
         "format": "JSON", "charset": "utf-8",
         "sign_type": "RSA2", "timestamp":
         time.strftime("%Y-%m-%d %H:%M:%S"),
         "version": "1.0", "nonce_str": uuid.uuid4().hex[:16],
         "biz_content": json.dumps(biz, ensure_ascii=False)}
    if return_url:
        p["return_url"] = return_url
    if notify_url:
        p["notify_url"] = notify_url
    raw = "&".join(f"{k}={p[k]}" for k in sorted(p) if p[k] and k != "sign")
    p["sign"] = rsa_sign_sha256(_ali_pem(a["private_key_pem"]), raw)
    return p


def ali_wap_form(a: dict, sec: dict, out_trade_no: str, total_yuan: str,
                 subject: str) -> str:
    """手机网站支付 → 自提交表单 HTML (网关跳转)."""
    p = ali_signed_params(
        a, {"out_trade_no": out_trade_no, "total_amount": total_yuan,
            "subject": subject[:120], "product_code": "QUICK_WAP_WAY"},
        "alipay.trade.wap.pay",
        return_url=f"{sec['notify_base']}/reader.html",
        notify_url=f"{sec['notify_base']}/api/pay/notify/ali")
    inputs = "".join(f'<input type="hidden" name="{k}" value="{v}">'
                     for k, v in p.items())
    return ('<form id="af" method="POST" '
            'action="https://openapi.alipay.com/gateway.do">'
            f'{inputs}</form><script>document.getElementById("af").submit()'
            '</script>')


def ali_verify_notify(a: dict, params: dict) -> bool:
    """异步通知验签 (支付宝公钥, RSA2)."""
    sign = params.pop("sign", "")
    params.pop("sign_type", None)
    raw = "&".join(f"{k}={params[k]}" for k in sorted(params)
                   if params[k] and not isinstance(params[k], (list, dict)))
    return bool(sign) and rsa_verify_sha256(
        _ali_pem(a["alipay_public_pem"]).replace(
            "RSA PRIVATE KEY", "PUBLIC KEY"), raw, sign)


# ---------------------------------------------------------- 订单状态机

def ensure_columns(db: sqlite3.Connection) -> None:
    """orders 表增列 (旧库兼容, 幂等)."""
    cols = {r[1] for r in db.execute("PRAGMA table_info(orders)")}
    for col, ddl in (("channel", "TEXT"), ("txn_id", "TEXT"),
                     ("paid_at", "TEXT"), ("access_token", "TEXT"),
                     ("ck_hash", "TEXT")):
        if col not in cols:
            db.execute(f"ALTER TABLE orders ADD COLUMN {col} {ddl}")


def new_out_trade_no(sku: str) -> str:
    """商户单号: sku8 + 随机8 + 时间10 = 26 位 (纯时间序可被枚举套 reader_url,
    加 8 位随机熵后不可猜; wx 上限 32 位内)."""
    return (f"{sku.replace('-', '')[:8]}{uuid.uuid4().hex[:8]}"
            f"{int(time.time() * 100) % 10**10:010d}")


def mark_paid(db: sqlite3.Connection, order_no: str, channel: str,
              txn_id: str) -> bool:
    """幂等核销: pending→paid+access_token; 已 paid 返回 True 零动作."""
    row = db.execute("SELECT id, state FROM orders WHERE order_no=?",
                     (order_no,)).fetchone()
    if not row:
        return False
    if row[1] == "paid":
        return True
    tok = hashlib.sha256(f"{order_no}:{uuid.uuid4().hex}".encode()).hexdigest()[:32]
    db.execute("UPDATE orders SET state='paid', channel=?, txn_id=?, "
               "paid_at=?, access_token=? WHERE id=?",
               (channel, txn_id, time.strftime("%Y-%m-%d %H:%M:%S"),
                tok, row[0]))
    return True


def mark_refunded(db: sqlite3.Connection, order_no: str,
                  refund_id: str) -> bool:
    """全额退款落地: paid→refunded+吊销 access_token (访问权失效)."""
    cur = db.execute("UPDATE orders SET state='refunded', access_token='', "
                     "refund_id=?, refunded_at=? WHERE order_no=? "
                     "AND state IN ('paid','partial_refunded')",
                     (refund_id, time.strftime("%Y-%m-%d %H:%M:%S"),
                      order_no))
    return cur.rowcount > 0


# ---------------------------------------------------- 反馈精细评价 (比例退款)

_SEVERE_WORDS = ("缺失", "没有", "空白", "与描述不符", "严重错误", "货不对板",
                 "完全是假的", "乱码", "缺章", "没写")
_MID_WORDS = ("错误", "过时", "数据不对", "引用", "质量差", "不值", "重复")


def grade_feedback(rating: int, category: str,
                   content: str) -> dict:
    """反馈→精细评价→退款比例 (规则版 v1, 可解释零成本; LLM 精评升级位留).

    档位: 严重问题→100% | 局部缺陷→40% | 轻微问题→20% | 建议改进→0%.
    """
    rating = int(rating or 0)
    txt = content or ""
    if category != "quality":
        return {"severity": "none", "pct": 0, "reason": "建议类反馈→质量飞轮"}
    if rating <= 2 and any(w in txt for w in _SEVERE_WORDS):
        return {"severity": "high", "pct": 100,
                "reason": "严重质量问题(内容缺失/严重不符)→全额退"}
    if rating <= 2 and any(w in txt for w in _MID_WORDS):
        return {"severity": "medium", "pct": 40, "reason": "局部缺陷→退40%"}
    if rating <= 2:
        return {"severity": "medium", "pct": 40, "reason": "低分质量反馈→退40%"}
    if rating == 3 and any(w in txt for w in _MID_WORDS + _SEVERE_WORDS):
        return {"severity": "light", "pct": 20, "reason": "轻微问题→退20%"}
    return {"severity": "light", "pct": 0, "reason": "评价尚可→0% (谢反馈)"}


MAX_REFUND_ROUNDS = 3          # 挤牙膏式多次薅的护栏


def refund_history(db: sqlite3.Connection, order_no: str) -> tuple[int, int]:
    """(已累计退款分, 已退次数)."""
    row = db.execute("SELECT refunded_fen, refund_rounds FROM orders "
                     "WHERE order_no=?", (order_no,)).fetchone()
    return (row[0] or 0, row[1] or 0) if row else (0, 0)


# ---------------------------------------------------------- 退款 (实时·比例)

def wx_refund(w: dict, out_trade_no: str, refund_no: str,
               refund_fen: int, total_fen: int, reason: str) -> dict:
    """微信 v3 退款 (支持部分退款) → {ok, refund_id?}."""
    code, r = _wx_call(w, "POST", "/v3/refund/domestic/refunds", {
        "out_trade_no": out_trade_no, "out_refund_no": refund_no,
        "reason": reason[:80],
        "amount": {"refund": refund_fen, "total": total_fen,
                   "currency": "CNY"}})
    if code in (200, 202) and r.get("refund_id"):
        return {"ok": True, "refund_id": r["refund_id"],
                "state": r.get("status", "")}
    return {"ok": False, "error": f"wx {code}: "
            + json.dumps(r, ensure_ascii=False)[:200]}


def ali_refund(a: dict, out_trade_no: str, refund_no: str,
               refund_yuan: str, reason: str) -> dict:
    """支付宝 alipay.trade.refund (同步, 支持部分退款)."""
    p = ali_signed_params(
        a, {"out_trade_no": out_trade_no, "out_request_no": refund_no,
            "refund_amount": refund_yuan, "refund_reason": reason[:80]},
        "alipay.trade.refund")
    import urllib.request
    import urllib.parse
    qs = urllib.parse.urlencode(p)
    try:
        with urllib.request.urlopen(
                "https://openapi.alipay.com/gateway.do?" + qs,
                timeout=12) as resp:
            data = json.loads(resp.read().decode("utf-8", "replace"))
        node = (data.get("alipay_trade_refund_response") or {})
        if node.get("code") == "10000":
            return {"ok": True, "refund_id": node.get("trade_no", ""),
                    "state": "REFUND_SUCCESS"}
        return {"ok": False, "error": f"ali {node.get('code')}: "
                + node.get("sub_msg", node.get("msg", ""))[:160]}
    except Exception as e:
        return {"ok": False, "error": f"ali net: {str(e)[:120]}"}


def apply_refund(db: sqlite3.Connection, order_no: str, refund_fen: int,
                 refund_id: str) -> None:
    """按累计额更新订单态: 满 100%→refunded+吊销; 否则 partial_refunded."""
    done_fen, rounds = refund_history(db, order_no)
    total_fen = db.execute("SELECT price FROM pay_amounts WHERE order_no=?",
                           (order_no,)).fetchone()
    total_fen = total_fen[0] if total_fen else 0
    new_total = done_fen + refund_fen
    full = total_fen and new_total >= total_fen
    db.execute("UPDATE orders SET refunded_fen=?, refund_rounds=?, "
               "state=?, access_token=CASE WHEN ?=1 THEN '' ELSE "
               "access_token END, refund_id=? WHERE order_no=?",
               (new_total, rounds + 1,
                "refunded" if full else "partial_refunded",
                1 if full else 0, refund_id, order_no))


def auto_refund(db: sqlite3.Connection, sec: dict, order_no: str,
                reason: str, pct: int = 100) -> dict:
    """反馈触发的实时退款 (按比例): 护栏=累计封顶实付+次数≤3+仅 paid 族."""
    row = db.execute("SELECT state, channel FROM orders WHERE order_no=?",
                     (order_no,)).fetchone()
    if not row:
        return {"ok": False, "error": "订单不存在"}
    state, channel = row
    if state == "refunded":
        return {"ok": False, "error": "已全额退款 (终态)"}
    if state not in ("paid", "partial_refunded"):
        return {"ok": False, "error": f"订单态 {state} 不可退款"}
    done_fen, rounds = refund_history(db, order_no)
    if rounds >= MAX_REFUND_ROUNDS:
        return {"ok": False, "error": f"已达 {MAX_REFUND_ROUNDS} 次退款上限"}
    amt = db.execute("SELECT price FROM pay_amounts WHERE order_no=?",
                     (order_no,)).fetchone()
    total_fen = amt[0] if amt else 0
    remain = total_fen - done_fen
    refund_fen = min(round(total_fen * pct / 100), remain)
    if refund_fen <= 0:
        return {"ok": True, "refund_fen": 0, "note": "比例归零或余款已尽"}
    refund_no = f"RF{order_no[-14:]}R{rounds + 1}"
    if channel == "wxpay" and sec["wxpay"]:
        r = wx_refund(sec["wxpay"], order_no, refund_no, refund_fen,
                      total_fen, reason)
    elif channel == "alipay" and sec["alipay"]:
        r = ali_refund(sec["alipay"], order_no, refund_no,
                       f"{refund_fen / 100:.2f}", reason)
    else:
        return {"ok": False,
                "error": f"渠道 {channel} 未配置或个人码单 (人工通道)"}
    if r["ok"]:
        apply_refund(db, order_no, refund_fen, r.get("refund_id", ""))
        return {"ok": True, "refund_fen": refund_fen, "pct": pct,
                "refund_id": r.get("refund_id", "")}
    return r


# ---------------------------------------------------------- 反馈 (质量飞轮)

def ensure_feedback_table(db: sqlite3.Connection) -> None:
    db.execute("CREATE TABLE IF NOT EXISTS feedback("
               "id INTEGER PRIMARY KEY, created TEXT, order_no TEXT, "
               "sku TEXT, rating INTEGER, chapter TEXT, category TEXT, "
               "content TEXT, action TEXT DEFAULT 'improve')")
    db.execute("CREATE TABLE IF NOT EXISTS pay_amounts("
               "order_no TEXT PRIMARY KEY, price INTEGER)")
    cols = {r[1] for r in db.execute("PRAGMA table_info(feedback)")}
    for col, ddl in (("severity", "TEXT"), ("refund_pct", "INTEGER"),
                     ("read_verified", "INTEGER DEFAULT 0")):
        if col not in cols:                      # 取证存证列 (真实可信协议)
            db.execute(f"ALTER TABLE feedback ADD COLUMN {col} {ddl}")
    ocols = {r[1] for r in db.execute("PRAGMA table_info(orders)")}
    for col, ddl in (("refunded_fen", "INTEGER DEFAULT 0"),
                     ("refund_rounds", "INTEGER DEFAULT 0"),
                     ("refunded_at", "TEXT"), ("refund_id", "TEXT")):
        if col not in ocols:                     # 比例退款累计列
            db.execute(f"ALTER TABLE orders ADD COLUMN {col} {ddl}")


def save_feedback(db: sqlite3.Connection, order_no: str, sku: str,
                  rating: int, chapter: str, category: str, content: str,
                  severity: str = "", refund_pct: int = 0,
                  read_verified: bool = False) -> None:
    db.execute("INSERT INTO feedback(created,order_no,sku,rating,chapter,"
               "category,content,action,severity,refund_pct,read_verified) "
               "VALUES(?,?,?,?,?,?,?,?,?,?,?)",
               (time.strftime("%Y-%m-%d %H:%M:%S"), order_no, sku,
                max(1, min(5, int(rating))), chapter[:60], category[:20],
                content[:1000],
                "refund" if category == "quality" else "improve",
                severity[:16], int(refund_pct), 1 if read_verified else 0))


def quality_pulse(db: sqlite3.Connection) -> dict:
    """质量飞轮聚合: 差评章节榜+类别计数 (admin 视图/报告修订输入)."""
    rows = db.execute("SELECT chapter, rating, category FROM feedback "
                      "ORDER BY id DESC LIMIT 500").fetchall()
    by_chapter: dict[str, list[int]] = {}
    by_cat: dict[str, int] = {}
    for ch, rating, cat in rows:
        if ch:
            by_chapter.setdefault(ch, []).append(rating)
        by_cat[cat] = by_cat.get(cat, 0) + 1
    worst = sorted(((sum(v) / len(v), len(v), k)
                    for k, v in by_chapter.items()), key=lambda x: x[0])
    return {"n_feedback": len(rows),
            "avg_rating": round(sum(r for _, r, _ in rows) / len(rows), 2)
            if rows else None,
            "by_category": by_cat,
            "worst_chapters": [{"chapter": k, "avg": round(avg, 2),
                                "n": n}
                               for avg, n, k in worst[:10]]}
