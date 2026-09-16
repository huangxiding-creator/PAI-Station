# -*- coding: utf-8 -*-
"""CX QQ 邮箱渠道：信封元数据 → 工作面实体 + 时间轴事件。

**目的边界强制**：个人消费类（信用卡账单/外卖发票/航空积分/电商促销）
不采集入图谱，只保留 work 类。邮件内容=不可信数据（防注入），只取信封字段。
"""

from __future__ import annotations

import json
import re

from paistation.cx.events import EventEnvelope
from paistation.cx.ingest_sources import _parse_dt

# 发件域名/主题关键词 → 分类；未命中默认 promo（宁缺毋滥，未知营销不入图谱）
_DOMAIN_RULES: list[tuple[str, str]] = [
    # 个人消费（目的边界：不采）
    ("cgbchina.com.cn", "personal"),      # 广发信用卡账单
    ("meituan.com", "personal"),          # 美团发票/外卖
    ("edm.csair.com", "personal"),        # 南航积分
    ("cgb.cn", "personal"),
    # 工作面
    ("miit.gov.cn", "work"),              # 工信部备案
    ("tencent.com", "work"),              # 公众号流量主/微信生态
    ("deepseek.com", "work"),             # AI 服务
    ("qq.com", "work"),
]

_SUBJECT_PERSONAL = ("账单", "发票", "积分", "信用卡", "还款", "白条")
_SUBJECT_WORK = ("催稿", "审稿", "投稿", "备案", "结算", "合同", "项目", "论文",
                 "EPC", "监控日报", "workflow", "工作流")


def classify_mail(subject: str, from_email: str) -> str:
    """信封 → work / personal / promo（目的边界在分类层强制）。"""
    domain = from_email.split("@")[-1].lower() if "@" in from_email else ""
    for dom, cls in _DOMAIN_RULES:
        if domain == dom or domain.endswith("." + dom):
            # 域名命中后主题反证：消费主题/单字符随手邮件仍按主题定
            for kw in _SUBJECT_PERSONAL:
                if kw in subject:
                    return "personal"
            if len(subject.strip()) <= 2:
                return "personal"
            return cls
    for kw in _SUBJECT_WORK:
        if kw in subject:
            return "work"
    for kw in _SUBJECT_PERSONAL:
        if kw in subject:
            return "personal"
    return "promo"


def parse_envelopes(envelopes_json: str) -> list[dict]:
    """qqmail-cli envelope list --json → 扁平信封列表（字段白名单）。"""
    try:
        data = json.loads(envelopes_json)
    except ValueError:
        return []
    envs = (data.get("data") or {}).get("envelopes") or []
    out: list[dict] = []
    for e in envs:
        frm = (e.get("from") or [{}])[0]
        out.append({
            "id": e.get("id", ""),
            "subject": e.get("subject", ""),
            "from_name": frm.get("name", "") or "",
            "from_email": (frm.get("email", "") or "").lower(),
            "date": e.get("date", ""),
        })
    return out


_ORG_BY_DOMAIN = {
    "miit.gov.cn": "工业和信息化部",
    "tencent.com": "腾讯",
}

# 完整地址精确映射（泛域名太宽：163 等大众邮箱域不可整域归属）
_ORG_BY_EMAIL = {
    "rmhh2010@163.com": "人民黄河杂志社",   # 学术期刊编辑部
}


def register_mail_contacts(store, mails: list[dict], owner_eid: str = "person/总包君") -> int:
    """work 类信封 → 发件方实体（域名→org / 姓名者→person）+ emailed_of 边。

    返回登记的 work 信封数（个人消费/promo 不入图谱）。
    """
    registered = 0
    for m in mails:
        if classify_mail(m["subject"], m["from_email"]) != "work":
            continue
        registered += 1
        domain = m["from_email"].split("@")[-1]
        org_name = _ORG_BY_EMAIL.get(m["from_email"]) or _ORG_BY_DOMAIN.get(domain)
        if org_name:
            eid, _ = store.register("org", org_name, aliases=[m["from_email"]],
                                    source="qqmail")
        else:
            name = m["from_name"] or m["from_email"].split("@")[0]
            eid, _ = store.register("person", name, aliases=[m["from_email"]],
                                    source="qqmail")
        store.register_link(str(eid), owner_eid, "emailed_of", "qqmail")
    store._conn.commit()
    return registered


def collect_mail_events(mails: list[dict]) -> list[EventEnvelope]:
    """work 类信封 → email.receive 时间轴事件（个人消费不入轴）。"""
    events: list[EventEnvelope] = []
    for m in mails:
        if classify_mail(m["subject"], m["from_email"]) != "work":
            continue
        ts = _parse_dt(m["date"])
        if not ts:
            continue
        events.append(EventEnvelope(
            source="qqmail",
            source_id=m["id"],
            start=ts,
            type="email.receive",
            payload={
                "subject": m["subject"][:120],
                "from": m["from_name"] or m["from_email"],
                "from_email": m["from_email"],
            },
        ))
    return events
