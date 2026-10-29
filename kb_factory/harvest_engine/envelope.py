# -*- coding: utf-8 -*-
"""错误信封统一判定（四站信封子类）——R12「信封陷阱」收口一处（T02；SYNTHESIS §2-10）。

各站响应第一层「信封」（状态壳）的陷阱形态不同，历史上散在各适配器各判各的（R12）；
本件把四站信封判定收进一处，统一输出三态：

- EnvelopeOK         信封过（facts 携带站点侧事实，供 fetch_ladder/audit/ledger 消费）
- EnvelopeFail       信封败（kind=机器可读失败类，站间可比；wall_status 落 NFR1 统一标记位）
- EnvelopeNeedVerify 待人机校验态（wenku tri_cap；不判死——熔断退避由下游消费，R13/FR8）

规格依据（判定口径与样本全部取自各 SPEC 实测留档）：
- WENKU_SPEC §6.3（2026-10-22 匿名活探针）：ndocview/readerinfo 信封=status.code/status.msg，
  code:0 不代表成功——须按 data.tri_cap + data.htmlUrls 判定：tri_cap=true 即验证码信封
  （msg="need to verify pop-up window!"，data 含 tri_reason/svcp_url=seccaptcha.baidu.com…）；
  htmlUrls 在场才算页数据到手。
- BOOK118_SPEC §1/§5坑3：openapi getPreview 信封=status==200 且 data 含本批首键
  str(page)；空 data/缺本批首键即失败（源码 5 次重试闸门，防跳页漏页）。
- DOC88_SPEC §1.2/§1.3：响应体含特征字「网络环境安全验证」=WAF 拦截（FR4.AC2 →
  blocked_waf）；解密后配置字段 p_404=1=文档不存在；p_download=1=免费文档。
- CSDN_SPEC §1.1/§1.2/§4（DOM 判定形态）：column_download 一律拒；标题含 404=页面不存在；
  按钮「会员价」或不含「VIP专享下载|立即下载」=付费墙（FR5.1 → paid_wall，只做 VIP 免费件；
  §4 死代码闸门 hasPaid 且非 isVipFree 被主闸吸收，价格元素/.paid 仅入 facts 佐证）。

边界：本件纯函数、零 I/O——不剥 JSONP（parse/jsonp.py）、不挖内联变量（parse/inline_var.py）、
不管 HTTP 状态层（HTTP≥400 连续判定属 FR1.2 should_degrade）；只吃已到手的信封体。
"""
from __future__ import annotations

import re
from collections.abc import Mapping
from dataclasses import dataclass, field
from typing import Any

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 tests 双导入法）
    from kb_factory.harvest_engine.adapters.base import WALL_BLOCKED_WAF, WALL_PAID
except ImportError:
    from harvest_engine.adapters.base import WALL_BLOCKED_WAF, WALL_PAID

__all__ = [
    "EnvelopeOK", "EnvelopeFail", "EnvelopeNeedVerify", "EnvelopeError", "EnvelopeVerdict",
    "SITES", "judge", "judge_wenku", "judge_book118", "judge_doc88", "judge_csdn",
    "DOC88_WAF_MARKER", "STATE_OK", "STATE_FAIL", "STATE_NEED_VERIFY",
]

# —— 统一三态词表（三态唯一名；词面勿再派生同义词）——
STATE_OK = "ok"
STATE_FAIL = "fail"
STATE_NEED_VERIFY = "need_verify"

SITES = ("wenku", "book118", "doc88", "csdn")  # 四站信封子类注册序

# —— wenku（WENKU_SPEC §6.3）——
WENKU_TRI_CAP_KIND = "tri_cap"  # 验证码信封（R12 主陷阱）
# —— book118（BOOK118_SPEC §1）——
BOOK118_OK_STATUS = 200
# —— doc88（DOC88_SPEC §1.2/§1.3）——
DOC88_WAF_MARKER = "网络环境安全验证"  # WAF 页特征字（原文，勿改写）
DOC88_P404_FIELD = "p_404"  # =1 文档不存在（XML 出 "1"/m_main JSON 出 1，两法字段等价）
# —— csdn（CSDN_SPEC §1.1/§4）——
CSDN_FREE_BUTTON_MARKS = ("VIP专享下载", "立即下载")  # isVipFree 判据（任一在场）
CSDN_PAID_BUTTON_MARK = "会员价"  # isPaid 判据（按钮文案）
CSDN_PRICE_RE = re.compile(r"\d+(?:\.\d+)?\s*(?:积分|C币|元)")  # 价格元素 N积分/N C币/N元


@dataclass(frozen=True)
class EnvelopeOK:
    """信封过：facts 携带站点侧事实页（fetch_ladder/audit/ledger 直接消费）。"""

    site: str
    facts: Mapping[str, Any] = field(default_factory=dict)
    state: str = STATE_OK


@dataclass(frozen=True)
class EnvelopeFail:
    """信封败：kind=机器可读失败类；wall_status=NFR1 统一标记位之一或 None。"""

    site: str
    kind: str
    detail: str = ""
    wall_status: str | None = None
    facts: Mapping[str, Any] = field(default_factory=dict)
    state: str = STATE_FAIL


@dataclass(frozen=True)
class EnvelopeNeedVerify:
    """待人机校验态：不判死（tri_cap 等）——熔断退避由下游 account_pool/RateLimiter 消费。"""

    site: str
    kind: str
    detail: str = ""
    facts: Mapping[str, Any] = field(default_factory=dict)
    state: str = STATE_NEED_VERIFY


EnvelopeError = EnvelopeFail  # 任务书别名（EnvelopeError/EnvelopeOK 判定函数）
EnvelopeVerdict = EnvelopeOK | EnvelopeFail | EnvelopeNeedVerify


def _is_one(value: Any) -> bool:
    """doc88「=1」判定：XML CDATA 出 "1"、m_main JSON 出 1（DOC88_SPEC §1.3 两法等价）。"""
    return str(value).strip() == "1"


def judge_wenku(payload: Mapping[str, Any]) -> EnvelopeVerdict:
    """wenku ndocview/readerinfo 信封（WENKU_SPEC §6.3；R12：code:0 不代表成功）。

    判定序（成败只认 data 字段，status 仅作失败注脚）：
    1. data.tri_cap 真 → NeedVerify（facts 带 code/tri_reason/svcp_url）
    2. data.htmlUrls 在场（非空）→ OK（facts 带 show_page 游标）
    3. 其余 → Fail：code 不为 0/None → kind="status"；code==0 仍无页数据 → kind="no_page_data"
    """
    if not isinstance(payload, Mapping):
        return EnvelopeFail("wenku", "bad_payload", "信封体非映射: " + type(payload).__name__)
    status = payload.get("status")
    status = status if isinstance(status, Mapping) else {}
    code, msg = status.get("code"), str(status.get("msg") or "")
    data = payload.get("data")
    data = data if isinstance(data, Mapping) else {}

    if data.get("tri_cap"):  # R12 主陷阱：此处 code 常为 0，成败与 code 无关
        return EnvelopeNeedVerify(
            "wenku", WENKU_TRI_CAP_KIND, msg or "need to verify pop-up window!",
            facts={"code": code, "tri_reason": data.get("tri_reason"),
                   "svcp_url": data.get("svcp_url")})
    html_urls = data.get("htmlUrls")  # 类型2=图片URL数组/类型3=文字页映射，在场即页数据到手
    if html_urls:
        return EnvelopeOK("wenku", facts={"code": code, "html_urls": html_urls,
                                          "show_page": data.get("showPage")})
    if code not in (0, None):
        return EnvelopeFail("wenku", "status", f"code={code} msg={repr(msg)}",
                            facts={"code": code, "msg": msg})
    return EnvelopeFail("wenku", "no_page_data",
                        "code:0 且无 tri_cap 无 htmlUrls（code:0 不代表成功，R12）",
                        facts={"code": code, "msg": msg})


def judge_book118(payload: Mapping[str, Any], expect_first_page: int = 1) -> EnvelopeVerdict:
    """book118 openapi getPreview 信封（BOOK118_SPEC §1；§5坑3 本批首键闸门）。

    过= status==200 且 data 含本批首键 str(expect_first_page)（每批返回从 page=N 起的连续
    6 页；空 data/缺首键即失败进重试，防跳页漏页）。facts.page_urls 键转 int（§5坑6 "10"<"2"）。
    """
    if not isinstance(payload, Mapping):
        return EnvelopeFail("book118", "bad_payload", "信封体非映射: " + type(payload).__name__)
    status, message = payload.get("status"), str(payload.get("message") or "")
    data = payload.get("data")
    data = data if isinstance(data, Mapping) else {}
    pages = payload.get("pages")
    pages = pages if isinstance(pages, Mapping) else {}

    if status != BOOK118_OK_STATUS:
        return EnvelopeFail("book118", "status", f"status={repr(status)} message={repr(message)}",
                            facts={"status": status, "message": message})
    first_key = str(expect_first_page)
    if not data:
        return EnvelopeFail("book118", "empty_data",
                            "status 200 但 data 空（频控形态，进源码重试闸门）",
                            facts={"expect_first_page": expect_first_page})
    if first_key not in data or not data.get(first_key):
        return EnvelopeFail("book118", "missing_first_key",
                            f"缺本批首键 page={expect_first_page}（防跳页漏页）",
                            facts={"expect_first_page": expect_first_page,
                                   "data_keys": sorted(k for k in map(str, data) if k.isdigit())})
    return EnvelopeOK("book118", facts={
        "page_urls": {int(k): v for k, v in data.items() if str(k).isdigit()},
        "pages_preview": pages.get("preview"), "pages_actual": pages.get("actual"),
        "filetype": pages.get("filetype")})


def judge_doc88(config: Mapping[str, Any] | None = None,
                *, body: str | None = None) -> EnvelopeVerdict:
    """doc88 信封（DOC88_SPEC §1.2/§1.3）：WAF 特征字在 body → blocked_waf；p_404=1 → 不存在。

    body=方法1/方法2 原始响应体（解密前即可判 WAF，str）；config=解密后的配置映射
    （doc.php?act=info 的 XML 与 m_main JSON 字段等价）。facts.p_download=True 即免费文档直下。
    """
    if body is not None and DOC88_WAF_MARKER in body:
        return EnvelopeFail("doc88", "waf",
                            "响应体含 WAF 特征字「" + DOC88_WAF_MARKER + "」（JA3/行为指纹拦截）",
                            wall_status=WALL_BLOCKED_WAF)
    cfg = config if isinstance(config, Mapping) else None
    if cfg is None:
        return EnvelopeFail("doc88", "empty_config",
                            "无配置可用（body 无 WAF 特征字但未给 config）")
    if _is_one(cfg.get(DOC88_P404_FIELD, "")):
        return EnvelopeFail("doc88", "doc_not_found", "p_404=1 文档不存在",
                            facts={"p_code": cfg.get("p_code")})
    return EnvelopeOK("doc88", facts={
        "p_code": cfg.get("p_code"), "p_name": cfg.get("p_name"),
        "p_pagecount": cfg.get("p_pagecount"),
        "p_allow_page_count": cfg.get("p_allow_page_count"),
        "p_swf": cfg.get("p_swf"), "p_ebthost": cfg.get("p_ebthost"),
        "p_download": _is_one(cfg.get("p_download", ""))})


def judge_csdn(dom: Mapping[str, Any]) -> EnvelopeVerdict:
    """csdn DOM 判定形态（CSDN_SPEC §1.1/§1.2/§4；FR5.1 只做 VIP 免费件）。

    dom=资源页 DOM 抽好的事实（选择器逻辑不入本件）：url_type（download/doc/
    column_download/…）、title（h1.title-article 回退 document.title）、button_text
    （下载按钮全文）、price_text（价格元素文本）、has_paid_class（.paid 类在场）。
    拒绝序：column_download → 标题 404 → 付费墙（isPaid=按钮「会员价」或 非 isVipFree=
    按钮不含「VIP专享下载|立即下载」）；价格元素/.paid 仅入 facts 佐证（不单独定死）。
    """
    if not isinstance(dom, Mapping):
        return EnvelopeFail("csdn", "bad_payload", "DOM 事实体非映射: " + type(dom).__name__)
    url_type = str(dom.get("url_type") or dom.get("type") or "")
    title = dom.get("title")
    button_text = str(dom.get("button_text") or "")
    price_text = str(dom.get("price_text") or "")
    has_paid_class = bool(dom.get("has_paid_class"))

    if url_type == "column_download":  # §1.1 URL 分类即拒（页面都不开）
        return EnvelopeFail("csdn", "column", "图文专栏暂不支持下载")
    if title is not None and (not str(title).strip() or "404" in str(title)):  # §1.2-6
        return EnvelopeFail("csdn", "page_404", "页面不存在(404)，请检查链接是否正确")
    is_vip_free = any(mark in button_text for mark in CSDN_FREE_BUTTON_MARKS)
    is_paid = CSDN_PAID_BUTTON_MARK in button_text
    has_paid = has_paid_class or bool(CSDN_PRICE_RE.search(price_text))
    if is_paid or not is_vip_free:  # §4 主闸：isPaid 或 非 isVipFree
        if has_paid and not is_paid:
            detail = "该资源为收费资源（" + repr(price_text) + "），暂不支持下载"
        else:
            detail = "该资源需要额外收费，暂不支持下载"
        return EnvelopeFail("csdn", "paid_wall", detail, wall_status=WALL_PAID,
                            facts={"is_paid": is_paid, "is_vip_free": is_vip_free,
                                   "has_paid": has_paid})
    return EnvelopeOK("csdn", facts={"is_vip_free": True, "button_text": button_text,
                                     "url_type": url_type, "has_paid": has_paid})


def judge(site: str, payload: Mapping[str, Any] | None = None, *,
          expect_first_page: int = 1, body: str | None = None,
          dom: Mapping[str, Any] | None = None) -> EnvelopeVerdict:
    """统一入口：按站点分派信封子类（适配器契约第六口 envelope，SYNTHESIS §2）。

    payload 语义随站：wenku=readerinfo 已解析 JSON；book118=JSONP 剥壳后对象；
    doc88=config 映射（body 另给原始响应体判 WAF）；csdn 不用 payload、用 dom 事实。
    """
    if site == "wenku":
        return judge_wenku(payload or {})
    if site == "book118":
        return judge_book118(payload or {}, expect_first_page=expect_first_page)
    if site == "doc88":
        return judge_doc88(payload, body=body)
    if site == "csdn":
        return judge_csdn(dom or {})
    raise ValueError("未知站点信封子类: " + repr(site) + "（合法=" + repr(list(SITES)) + "）")
