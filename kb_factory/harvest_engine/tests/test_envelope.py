# -*- coding: utf-8 -*-
"""FR1.2/R12 单测：四站错误信封统一判定 envelope.py（T02；SYNTHESIS §2-10）。

被测物=纯函数判定器（零网络、零 mock 框架、零 I/O；实弹属下游适配器任务 T-wenku/T-account_pool）。
样本全部取自各 SPEC 实测留档（数字零造假：fixture 只用规格原文标注过的值，构造形态处已注明）：
- wenku tri_cap 信封：WENKU_SPEC §6.3 2026-10-22 匿名活探针原文（code:0 陷阱本体）
- book118 openapi 信封：BOOK118_SPEC §1 线上金样（全文=_repos/book118/_probe_openapi_p1.txt，
  view_token 跨月稳定复用实测）+ §1-④ 6页/批 + §5坑3 首键闸门
- doc88：DOC88_SPEC §1.2 WAF 特征字「网络环境安全验证」+ §1.3 实测样例 p_code=69091550288
  （p_pagecount=119、p_swfcount=3、p_swf、p_ebthost 原文值；p_download 规格未标→按预览形态 0）
- csdn：CSDN_SPEC §1.1 URL 分类 + §1.2-6 标题404 + §4 付费三闸门（DOM 判定形态）
用例名需求号：FR1.2（envelope 判失败=降级判定输入）/R12（wenku code:0 陷阱）/
FR4.AC2（doc88 blocked_waf 标记）/FR5.1（csdn paid_wall DOM 判定拒绝）。
"""
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine
if not (_KB_DIR / "channel_adapters" / "base.py").exists():
    # worker worktree：kb_factory 未入 git → channel_adapters 只读复用主仓真身（kb_factory. 前缀解析）
    for _anc in _KB_DIR.parents:
        if (_anc / "kb_factory" / "channel_adapters" / "base.py").exists():
            sys.path.insert(1, str(_anc))
            break

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名（同 test_base_four_stage）
    from kb_factory.harvest_engine.adapters.base import WALL_BLOCKED_WAF, WALL_PAID
    from kb_factory.harvest_engine.envelope import (
        DOC88_WAF_MARKER, SITES, EnvelopeError, EnvelopeFail, EnvelopeNeedVerify, EnvelopeOK,
        judge, judge_book118, judge_csdn, judge_doc88, judge_wenku)
except ImportError:
    from harvest_engine.adapters.base import WALL_BLOCKED_WAF, WALL_PAID  # noqa: E402
    from harvest_engine.envelope import (  # noqa: E402
        DOC88_WAF_MARKER, SITES, EnvelopeError, EnvelopeFail, EnvelopeNeedVerify, EnvelopeOK,
        judge, judge_book118, judge_csdn, judge_doc88, judge_wenku)

# ============ 样本（SPEC 实测留档；构造形态处已注明） ============

# WENKU_SPEC §6.3 活探针原文（2026-10-22 匿名请求；URL 中 ak/ts/sign 规格即以省略号留档）
WENKU_TRI_CAP_PROBE = {
    "status": {"code": 0, "msg": "need to verify pop-up window!"},
    "data": {"tri_reason": "ymg", "tri_cap": True,
             "svcp_url": "https://seccaptcha.baidu.com/v1/webapi/verint/svcp.html"
                          "?ak=...&subid=wenku_pc_readerinfo_bfe&ts=...&sign=..."},
}
# 成功形态按 §1 类型2（htmlUrls=图片URL数组）+ §3.2 游标字段构造（showPage 每轮推进）
WENKU_OK_TYPE2 = {
    "status": {"code": 0, "msg": "success"},
    "data": {"showPage": 50, "htmlUrls": [
        "https://wkretype.bdimg.com/retype/pipe/storeid0?pn=51&rn=50",
        "https://wkretype.bdimg.com/retype/pipe/storeid0?pn=52&rn=50"]},
}

# BOOK118_SPEC §1 金样（线上原样、缩略号照规格；全文=_repos/book118/_probe_openapi_p1.txt）
BOOK118_P1 = {
    "status": 200, "message": "ok",
    "data": {"1": "//view-cache.book118.com/view1/M04/35/16/wKh2....png",
             "2": "//view-cache.book118.com/view1/M01/.../view_1_xxx@yyy=.png?v=20231026"},
    "pages": {"preview": "101", "actual": "101", "filetype": "pdf"},
}
# i=7 批次形态（§1-④：每批从 page=N 起连续 6 页；构造样，键形如规格）
BOOK118_P7 = {
    "status": 200, "message": "ok",
    "data": {"7": "//view-cache.book118.com/view1/M05/xx/xx/wKh2....png",
             "12": "//view-cache.book118.com/view1/M05/xx/xx/wKh2....png"},
    "pages": {"preview": "101", "actual": "101", "filetype": "pdf"},
}

# DOC88_SPEC §1.3 实测样例（p_code=69091550288）解密后配置字段原文值；
# p_download 规格未给该样例取值 → 按预览形态 "0"（免费文档=1 的语义另在用例内以 "1" 验）
DOC88_OK_CFG = {
    "p_code": "69091550288", "p_pagecount": "119", "p_swfcount": "3",
    "p_swf": "63-20110912-20110912175543_7SOoC87j",
    "p_ebthost": "https://ebt143.doc88.com", "p_download": "0",
}
# §1.2：页面命中「网络环境安全验证」字样 = WAF 拦截（特征字原文；包体为构造样）
DOC88_WAF_BODY = ("<html><head><title>安全验证</title></head>"
                  "<body>网络环境安全验证，请完成验证后继续访问。</body></html>")

# CSDN_SPEC §1.1/§1.2/§4 DOM 事实样本（按钮/价格文案取自 §4 表格原文判据）
CSDN_DOM_VIP_FREE = {"url_type": "download", "title": "某资源页", "button_text": "VIP专享下载",
                     "price_text": "", "has_paid_class": False}
CSDN_DOM_LIJI = {"url_type": "doc", "title": "某资源页", "button_text": "立即下载",
                  "price_text": "", "has_paid_class": False}
CSDN_DOM_MEMBER_PRICE = {"url_type": "download", "title": "某资源页", "button_text": "会员价：5元",
                         "price_text": "", "has_paid_class": False}
CSDN_DOM_LOGIN_ONLY = {"url_type": "download", "title": "某资源页", "button_text": "登录后下载",
                       "price_text": "", "has_paid_class": False}
CSDN_DOM_PRICE_ELEM = {"url_type": "download", "title": "某资源页", "button_text": "登录后下载",
                       "price_text": "30积分", "has_paid_class": True}
CSDN_DOM_VIP_PRICE_ELEM = {"url_type": "download", "title": "某资源页",
                           "button_text": "VIP专享下载", "price_text": "30积分",
                           "has_paid_class": False}
CSDN_DOM_COLUMN = {"url_type": "column_download", "title": "某专栏", "button_text": ""}
CSDN_DOM_TITLE_404 = {"url_type": "doc", "title": "404页面不存在", "button_text": "VIP专享下载"}
CSDN_DOM_TITLE_EMPTY = {"url_type": "doc", "title": "", "button_text": "VIP专享下载"}

# ============ wenku（R12：code:0 陷阱；FR1.2 降级判定输入） ============

def test_r12_wenku_tri_cap_probe_need_verify():
    v = judge_wenku(WENKU_TRI_CAP_PROBE)
    assert isinstance(v, EnvelopeNeedVerify)
    assert v.state == "need_verify" and v.site == "wenku" and v.kind == "tri_cap"
    assert v.detail == "need to verify pop-up window!"
    assert v.facts["tri_reason"] == "ymg"
    assert v.facts["svcp_url"].startswith("https://seccaptcha.baidu.com/")
    assert v.facts["svcp_url"].find("subid=wenku_pc_readerinfo_bfe") > 0
    assert v.facts["code"] == 0  # R12 本体：code:0 仍判验证码信封，不得当成功

def test_r12_wenku_code0_without_htmllurls_fails():
    v = judge_wenku({"status": {"code": 0, "msg": "success"}, "data": {}})
    assert isinstance(v, EnvelopeFail) and v.kind == "no_page_data"
    assert v.state == "fail" and v.facts["code"] == 0
    v2 = judge_wenku({"status": {"code": 0}, "data": {"showPage": 3}})  # 有游标无页数据同败
    assert isinstance(v2, EnvelopeFail) and v2.kind == "no_page_data"

def test_fr1_2_wenku_htmllurls_ok():
    v = judge_wenku(WENKU_OK_TYPE2)
    assert isinstance(v, EnvelopeOK) and v.state == "ok" and v.site == "wenku"
    assert v.facts["show_page"] == 50
    assert len(v.facts["html_urls"]) == 2

def test_fr1_2_wenku_nonzero_code_fails():
    v = judge_wenku({"status": {"code": 6, "msg": "not login"}, "data": {}})
    assert isinstance(v, EnvelopeFail) and v.kind == "status"
    assert v.facts["code"] == 6 and v.facts["msg"] == "not login"

# ============ book118（FR1.2：status200 + data 本批首键） ============

def test_fr1_2_book118_golden_first_batch_ok():
    v = judge_book118(BOOK118_P1)
    assert isinstance(v, EnvelopeOK) and v.state == "ok"
    assert v.facts["page_urls"] == {1: BOOK118_P1["data"]["1"], 2: BOOK118_P1["data"]["2"]}
    assert v.facts["pages_preview"] == "101" and v.facts["pages_actual"] == "101"
    assert v.facts["filetype"] == "pdf"

def test_fr1_2_book118_batch_first_key_gate():
    assert isinstance(judge_book118(BOOK118_P7, expect_first_page=7), EnvelopeOK)
    v = judge_book118(BOOK118_P7, expect_first_page=13)  # limit%6==1 末批只此键在场
    assert isinstance(v, EnvelopeFail) and v.kind == "missing_first_key"
    assert v.facts["expect_first_page"] == 13

def test_fr1_2_book118_empty_data_and_bad_status():
    empty = judge_book118({"status": 200, "message": "ok", "data": {}})
    assert isinstance(empty, EnvelopeFail) and empty.kind == "empty_data"
    bad = judge_book118({"status": 403, "message": "forbidden", "data": {"1": "//x.png"}})
    assert isinstance(bad, EnvelopeFail) and bad.kind == "status" and bad.facts["status"] == 403

# ============ doc88（FR4.AC2 WAF 标记；p_404） ============

def test_fr4_ac2_doc88_waf_marker_fail():
    v = judge_doc88(body=DOC88_WAF_BODY)
    assert isinstance(v, EnvelopeFail) and v.kind == "waf"
    assert v.wall_status == WALL_BLOCKED_WAF
    assert DOC88_WAF_MARKER in v.detail
    # config 正常但 body 命中 WAF → WAF 优先（解密前即可判，省一次白解密）
    v2 = judge_doc88(dict(DOC88_OK_CFG), body=DOC88_WAF_BODY)
    assert isinstance(v2, EnvelopeFail) and v2.kind == "waf"

def test_fr4_doc88_p404_fail_both_shapes():
    v_xml = judge_doc88(dict(DOC88_OK_CFG, p_404="1"))   # doc.php XML 形态（CDATA 字符串）
    assert isinstance(v_xml, EnvelopeFail) and v_xml.kind == "doc_not_found"
    assert v_xml.facts["p_code"] == "69091550288"
    v_json = judge_doc88({"p_404": 1, "p_code": "0"})    # m_main JSON 形态（int 1）
    assert isinstance(v_json, EnvelopeFail) and v_json.kind == "doc_not_found"

def test_fr4_doc88_config_ok_and_empty_config():
    v = judge_doc88(DOC88_OK_CFG)
    assert isinstance(v, EnvelopeOK) and v.state == "ok"
    assert v.facts["p_code"] == "69091550288"
    assert v.facts["p_pagecount"] == "119"
    assert v.facts["p_swf"] == "63-20110912-20110912175543_7SOoC87j"
    assert v.facts["p_ebthost"] == "https://ebt143.doc88.com"
    assert v.facts["p_download"] is False
    free = judge_doc88(dict(DOC88_OK_CFG, p_download="1"))  # 免费文档直下分支
    assert isinstance(free, EnvelopeOK) and free.facts["p_download"] is True
    empty = judge_doc88(body="<html>普通页面</html>")
    assert isinstance(empty, EnvelopeFail) and empty.kind == "empty_config"

# ============ csdn（FR5.1：DOM 判定形态三闸门） ============

def test_fr5_1_csdn_vip_free_ok():
    for dom in (CSDN_DOM_VIP_FREE, CSDN_DOM_LIJI):
        v = judge_csdn(dom)
        assert isinstance(v, EnvelopeOK) and v.state == "ok"
        assert v.facts["is_vip_free"] is True

def test_fr5_1_csdn_member_price_paid_wall():
    v = judge_csdn(CSDN_DOM_MEMBER_PRICE)
    assert isinstance(v, EnvelopeFail) and v.kind == "paid_wall"
    assert v.wall_status == WALL_PAID
    assert "该资源需要额外收费" in v.detail
    assert v.facts["is_paid"] is True and v.facts["is_vip_free"] is False

def test_fr5_1_csdn_not_vip_free_paid_wall():
    v = judge_csdn(CSDN_DOM_LOGIN_ONLY)  # 无会员价也无 VIP 按钮：主闸 非 isVipFree 即拒
    assert isinstance(v, EnvelopeFail) and v.kind == "paid_wall"
    assert v.wall_status == WALL_PAID
    assert "该资源需要额外收费" in v.detail
    assert v.facts["is_paid"] is False and v.facts["is_vip_free"] is False
    assert v.facts["has_paid"] is False

def test_fr5_1_csdn_price_element_detail():
    v = judge_csdn(CSDN_DOM_PRICE_ELEM)  # 价格元素 30积分 + .paid 类：收费资源文案分支
    assert isinstance(v, EnvelopeFail) and v.kind == "paid_wall"
    assert "该资源为收费资源" in v.detail and "30积分" in v.detail
    assert v.facts["has_paid"] is True

def test_fr5_1_csdn_price_elem_with_vip_button_only_facts():
    v = judge_csdn(CSDN_DOM_VIP_PRICE_ELEM)  # §4 死代码闸门被主闸吸收：VIP 免费件仅记 facts
    assert isinstance(v, EnvelopeOK) and v.facts["is_vip_free"] is True
    assert v.facts["has_paid"] is True

def test_fr5_1_csdn_column_and_title_404():
    col = judge_csdn(CSDN_DOM_COLUMN)  # §1.1 URL 分类即拒
    assert isinstance(col, EnvelopeFail) and col.kind == "column"
    assert col.detail == "图文专栏暂不支持下载"
    t404 = judge_csdn(CSDN_DOM_TITLE_404)  # §1.2-6 标题含 404
    assert isinstance(t404, EnvelopeFail) and t404.kind == "page_404"
    tempty = judge_csdn(CSDN_DOM_TITLE_EMPTY)  # §1.2-6 标题为空
    assert isinstance(tempty, EnvelopeFail) and tempty.kind == "page_404"

# ============ 统一入口 judge（适配器契约第六口） ============

def test_t02_judge_dispatch_alias_and_unknown_site():
    assert judge("wenku", payload=WENKU_TRI_CAP_PROBE) == judge_wenku(WENKU_TRI_CAP_PROBE)
    assert judge("book118", payload=BOOK118_P1) == judge_book118(BOOK118_P1)
    assert judge("book118", payload=BOOK118_P7, expect_first_page=13).kind == "missing_first_key"
    assert judge("doc88", payload=DOC88_OK_CFG) == judge_doc88(DOC88_OK_CFG)
    assert judge("doc88", body=DOC88_WAF_BODY).kind == "waf"
    assert judge("csdn", dom=CSDN_DOM_VIP_FREE) == judge_csdn(CSDN_DOM_VIP_FREE)
    with pytest.raises(ValueError):
        judge("unknown_site")
    assert EnvelopeError is EnvelopeFail  # 任务书别名
    assert SITES == ("wenku", "book118", "doc88", "csdn")
