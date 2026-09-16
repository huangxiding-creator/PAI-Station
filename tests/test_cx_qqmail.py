# -*- coding: utf-8 -*-
"""QQ 邮箱渠道：信封解析 + 工作/消费分类（目的边界）+ 实体登记。"""

from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_qqmail import (  # noqa: E402
    classify_mail,
    collect_mail_events,
    parse_envelopes,
    register_mail_contacts,
)

_SAMPLE = """{"ok":true,"data":{"envelopes":[
 {"id":"m1_aaa","subject":"《知识增强视觉推理的水利工程施工安全隐患识别新方法》退改催稿单--《人民黄河》",
  "from":[{"name":"","email":"rmhh2010@163.com"}],
  "to":[{"email":"51817@qq.com"}],"date":"2026-08-21T15:44:23+08:00"},
 {"id":"m1_bbb","subject":"腾讯微信广告流量主结算",
  "from":[{"name":"腾讯微信广告","email":"wxad_statement@tencent.com"}],
  "to":[{"email":"51817@qq.com"}],"date":"2026-09-10T13:14:06+08:00"},
 {"id":"m1_ccc","subject":"广发信用卡 2026年08月电子账单",
  "from":[{"name":"广发银行","email":"creditcard@cgbchina.com.cn"}],
  "to":[{"email":"51817@qq.com"}],"date":"2026-08-28T09:28:45+08:00"},
 {"id":"m1_ddd","subject":"美团-开票申请处理成功通知",
  "from":[{"name":"美团电票平台","email":"it_fapiao@meituan.com"}],
  "to":[{"email":"51817@qq.com"}],"date":"2026-08-27T19:39:09+08:00"}
]},"error":null}"""


class TestParseEnvelopes:
    def test_fields(self):
        mails = parse_envelopes(_SAMPLE)
        assert len(mails) == 4
        assert mails[0]["from_email"] == "rmhh2010@163.com"
        assert mails[1]["from_name"] == "腾讯微信广告"
        assert mails[0]["date"].startswith("2026-08-21T15:44")

    def test_bad_json(self):
        assert parse_envelopes("not json") == []
        assert parse_envelopes('{"ok":false}') == []


class TestClassifyMail:
    """目的边界：个人消费类不入图谱。"""

    def test_academic_work(self):
        assert classify_mail(
            "《知识增强…》退改催稿单--《人民黄河》",
            "rmhh2010@163.com") == "work"

    def test_flow_income_work(self):
        assert classify_mail("腾讯微信广告流量主结算",
                             "wxad_statement@tencent.com") == "work"

    def test_miit_work(self):
        assert classify_mail("工业和信息化部网站备案系统邮件通知",
                             "zwfw-info@miit.gov.cn") == "work"

    def test_credit_card_personal(self):
        assert classify_mail("广发信用卡 2026年08月电子账单",
                             "creditcard@cgbchina.com.cn") == "personal"

    def test_invoice_personal(self):
        assert classify_mail("【电子发票】上海三快智送科技有限公司",
                             "it_fapiao@meituan.com") == "personal"

    def test_airline_points_personal(self):
        assert classify_mail("南航会员积分变动通知",
                             "skypearl@edm.csair.com") == "personal"

    def test_unknown_promo(self):
        assert classify_mail("限时优惠全场五折", "news@shop.com") == "promo"

    def test_single_char_subject_personal(self):
        # 主题"1"（文件中转/私人）不算工作面，即使来自 qq.com
        assert classify_mail("1", "634698572@qq.com") == "personal"


class TestRegisterAndEvents:
    def test_work_only_registered(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        store.register("person", "总包君", source="test")
        mails = parse_envelopes(_SAMPLE)
        registered = register_mail_contacts(store, mails)
        # 只有 work 类两封入图谱（学术期刊 + 腾讯广告）
        assert registered == 2
        # 域名→org 实体，email 为强标识别名
        assert store.lookup_by_alias("rmhh2010@163.com")
        assert store.lookup_by_alias("wxad_statement@tencent.com")
        # 个人消费发件方不入
        assert not store.lookup_by_alias("creditcard@cgbchina.com.cn")
        store.close()

    def test_events_for_timeline(self, tmp_path):
        mails = parse_envelopes(_SAMPLE)
        evs = collect_mail_events(mails)
        # 只有 work 邮件产生时间轴事件
        assert len(evs) == 2
        assert evs[0].type == "email.receive"
        assert evs[0].payload["subject"].startswith("《知识增强")
