# -*- coding: utf-8 -*-
r"""FR2.1/FR3.1 支撑件单测：JSONP 剥壳三步链（剥 callback 壳→括号配平截取→json.loads）。

- 零网络零桩：全部本地合成样本；回调名/壳形态/键名/转义逐字对齐规格真实形态——
  wenku wkrtcs getbdjson `sf_edu_wenku_rtcs_doc_jsonp_1_{桶序号}`（WENKU_SPEC §6.4，
  壳内 document.xml=页对象数组）；book118 openapi `jsonpReturn` + 键名带引号 + 值内
  `\/` 转义（BOOK118_SPEC §1，标准 json 天然兼容）。
- 失败路径全覆盖：无壳形态/回调名不符/配平破缺（缺闭合、错配、串未终止、多闭）/
  闭合后残留/壳内纯串（非 JSON，含风控文案与 JS 单引号串）。
"""
import json
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.parse.jsonp import (  # noqa: E402
        JsonpError, jsonp_payload, strip_jsonp)
except ImportError:
    from harvest_engine.parse.jsonp import (  # noqa: E402
        JsonpError, jsonp_payload, strip_jsonp)


def _wenku_getbdjson_body(bucket: int) -> str:
    """WENKU_SPEC §6.4 真实壳形态：桶序号 1 起逐桶递增；rn=3 每桶 3 页、document.xml=页对象数组。"""
    pages = [{"c": [f"第{bucket}桶·页{i + 1}", "正文节点"], "style": {"fontSize": 16}}
             for i in range(3)]
    payload = {"err_no": 0, "errMsg": "", "document.xml": pages,
               "moduleInfo": {"bucketNum": "30"}}
    inner = json.dumps(payload, ensure_ascii=False, separators=(",", ":"))
    return f"sf_edu_wenku_rtcs_doc_jsonp_1_{bucket}({inner})"


_BOOK118_BODY = (
    'jsonpReturn({"status":200,"message":"ok",'
    '"data":{"1":"//view-cache.book118.com/view1/M04/35/16/wKh2S1....png",'
    '"2":"https:\\/\\/view-cache.book118.com\\/view1\\/M01\\/wKh2S2....png?v=20231026",'
    '"7":"//view-cache.book118.com/view1/M02/view_7_xxx@yyy=.png"},'
    '"pages":{"preview":"101","actual":"101","filetype":"pdf"}});'
)


@pytest.mark.parametrize("bucket", [1, 2, 3])
def test_fr2_1_wenku_getbdjson_shell_by_bucket(bucket):
    """FR2.1：wenku getbdjson 真实壳（桶序号逐桶递增）剥壳→配平→loads，页对象数组完整。"""
    body = _wenku_getbdjson_body(bucket)
    cb = f"sf_edu_wenku_rtcs_doc_jsonp_1_{bucket}"
    obj = strip_jsonp(body, callback=cb)
    assert obj["err_no"] == 0 and obj["errMsg"] == ""
    pages = obj["document.xml"]
    assert len(pages) == 3  # rn=3：每桶 3 页（§6.4）
    assert pages[0]["c"] == [f"第{bucket}桶·页1", "正文节点"]
    assert all(p["style"]["fontSize"] == 16 for p in pages)
    assert obj["moduleInfo"]["bucketNum"] == "30"
    assert strip_jsonp(body, callback=None) == obj  # 免校验路同果
    name, raw = jsonp_payload(body)
    assert name == cb and raw.startswith("{") and raw.endswith("}")


def test_fr3_1_book118_jsonp_return_with_slash_escape():
    r"""FR3.1：book118 jsonpReturn 壳 + 键名带引号 + `\/` 转义（标准 json 天然兼容）+ 尾分号。"""
    obj = strip_jsonp(_BOOK118_BODY, callback="jsonpReturn")
    assert obj["status"] == 200 and obj["message"] == "ok"
    assert obj["pages"] == {"preview": "101", "actual": "101", "filetype": "pdf"}
    assert set(obj["data"]) == {"1", "2", "7"}  # data 键=页码字符串（纯数字键收集口径归适配器）
    assert obj["data"]["2"] == ("https://view-cache.book118.com/view1/M01/"
                                "wKh2S2....png?v=20231026")  # `\/` 解析即普通斜杠


def test_payload_slice_is_verbatim_extract():
    """等价抽取：payload 原文切片原样返回（含内部空白/换行，不重排不加料）。"""
    payload = '{\n  "k" : [1, 2],\n  "s": "中文"\n}'
    body = f"jsonpReturn({payload})"
    name, raw = jsonp_payload(body)
    assert (name, raw) == ("jsonpReturn", payload)
    assert strip_jsonp(body) == {"k": [1, 2], "s": "中文"}


def test_balancer_skips_brackets_and_escapes_inside_strings():
    """字符串感知配平：串内 ()[]{} 与 \\" \\\\ \\/ 转义不破计数（裸计数必错的本例必须通过）。"""
    body = ('cb({"t":"串内括号 ) ] } ( [ { 与转义 \\" \\\\ \\/ 不破配平",'
            '"arr":[{"k":"(x)"}],"n":1})')
    obj = strip_jsonp(body)
    assert obj["n"] == 1 and obj["arr"][0]["k"] == "(x)"
    assert obj["t"] == '串内括号 ) ] } ( [ { 与转义 " \\ / 不破配平'


def test_callback_identifier_shapes():
    """壳识别通用性：点分名 window.a.cb / $ 名 / 数组 payload / 名后空白（两类真实回调之外兼容）。"""
    assert strip_jsonp('window.a.cb({"x":9})', callback="window.a.cb") == {"x": 9}
    assert strip_jsonp('jsonp$cb({"y":1})') == {"y": 1}
    assert strip_jsonp('cb ([1,{"a":2}])') == [1, {"a": 2}]


def test_bom_whitespace_and_trailing_semicolon_tolerated():
    """BOM/首尾空白/闭合后分号与换行容忍；载荷内空白交给 json.loads。"""
    body = "﻿\r\n  sf_edu_wenku_rtcs_doc_jsonp_1_2( {\"k\": [1, 2]} )  ; \n"
    assert strip_jsonp(body) == {"k": [1, 2]}


def test_callback_name_mismatch_rejected():
    """回调名不符硬拒（桶序号串桶/WAF 换壳均不得误吞）。"""
    with pytest.raises(JsonpError, match="回调名不符"):
        strip_jsonp(_wenku_getbdjson_body(1), callback="sf_edu_wenku_rtcs_doc_jsonp_1_2")
    with pytest.raises(JsonpError, match="回调名不符"):
        strip_jsonp(_BOOK118_BODY, callback="sf_edu_wenku_rtcs_doc_jsonp_1_1")


@pytest.mark.parametrize("body", [
    '{"status":200}',        # 纯 JSON 无壳
    "",                      # 空响应
    "   \r\n ",              # 纯空白
    "jsonpReturn",           # 无开括号
    "请求频繁，请稍后再试",     # 风控纯文案无壳
])
def test_no_shell_shape_rejected(body):
    """失败路径：无「标识符(」壳形态一律 JsonpError，不猜不吞。"""
    with pytest.raises(JsonpError, match="callback 壳"):
        strip_jsonp(body)


@pytest.mark.parametrize("body", [
    'cb({"a":[1,2}',           # 缺闭合
    'cb({"a":]})',             # 闭括号错配
    'cb(',                     # 壳开而无内容无闭合
    'cb({"s":"字符串未终止})',   # 未终止串吞掉闭合括号
    'cb({"a":1}})',            # 多余闭括号（错配门拦）
])
def test_unbalanced_rejected(body):
    """失败路径：配平破缺各形态（缺闭合/错配/串未终止/多闭）一律 JsonpError。"""
    with pytest.raises(JsonpError):
        strip_jsonp(body)


def test_trailing_garbage_after_close_rejected():
    """失败路径：闭合括号后仅容忍空白+至多一个分号，脚本残留即拒。"""
    with pytest.raises(JsonpError, match="残留"):
        strip_jsonp('jsonpReturn({"a":1});alert(1)')
    with pytest.raises(JsonpError, match="残留"):
        strip_jsonp("cb({}) )")


def test_pure_string_payload_non_json_fails():
    """失败路径（任务卡明示）：壳内纯串非 JSON——剥壳成功但 loads 必败，JsonpError 链原始因。"""
    bodies = [
        "sf_edu_wenku_rtcs_doc_jsonp_1_1(document not found)",  # 裸英文串
        "jsonpReturn('单引号 JS 串非 JSON')",                     # JS 单引号串
        "jsonpReturn(请求频繁，请稍后再试)",                        # 风控中文文案
    ]
    with pytest.raises(JsonpError, match="payload 非 JSON") as ei:
        strip_jsonp(bodies[0])
    assert isinstance(ei.value.__cause__, json.JSONDecodeError)  # json.loads 步真跑且链上因
    for body in bodies[1:]:
        with pytest.raises(JsonpError, match="payload 非 JSON"):
            strip_jsonp(body)


def test_quoted_json_string_payload_succeeds():
    """边界对照：带引号纯串/null 是合法 JSON（loads 得 str/None），与裸串失败路径相区分。"""
    assert strip_jsonp('jsonpReturn("ok")') == "ok"
    assert strip_jsonp('sf_edu_wenku_rtcs_doc_jsonp_1_3(null)') is None
