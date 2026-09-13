"""M2.6 首个示例连接器：飞书云文档（可注入 transport，不打真平台）。"""
from paistation.sense.cloud.feishu import FeishuDocsConnector
from paistation.sense.cloud.vault import SessionVault


class FakeTransport:
    """记录调用+回放 canned 响应。"""

    def __init__(self, responses):
        self.responses = list(responses)
        self.calls = []

    def request(self, method, url, *, headers=None, params=None, json_body=None):
        self.calls.append({"method": method, "url": url,
                           "headers": headers, "params": params})
        return self.responses.pop(0)


def _vault(tmp_path, session=None):
    v = SessionVault(tmp_path / "vault")
    if session:
        v.save("feishu", session)
    return v


def test_collect_pages_and_emits_doc_change_events(tmp_path):
    transport = FakeTransport([
        (200, {"data": {"files": [
            {"type": "doc", "name": "投标大纲", "token": "D1",
             "modified_time": "1800000002"},
            {"type": "sheet", "name": "报价表", "token": "S1",
             "modified_time": "1800000001"},
        ], "has_more": True, "page_token": "PT2"}}),
        (200, {"data": {"files": [
            {"type": "doc", "name": "会议纪要", "token": "D2",
             "modified_time": "1800000000"},
        ], "has_more": False}}),
    ])
    conn = FeishuDocsConnector(
        vault=_vault(tmp_path, {"user_access_token": "u-AT"}),
        transport=transport)
    events, new_wm = conn.collect(since_watermark=1799999999)
    assert len(events) == 3
    assert events[0]["type"] == "cloud.doc.change"
    assert "投标大纲" in events[0]["text"]
    assert events[0]["evidence"]["doc_token"] == "D1"
    assert new_wm == 1800000002               # 水位线=最大修改时间
    assert transport.calls[0]["headers"]["Authorization"] == "Bearer u-AT"
    assert transport.calls[1]["params"]["page_token"] == "PT2"


def test_collect_no_session_returns_empty(tmp_path):
    conn = FeishuDocsConnector(vault=_vault(tmp_path), transport=FakeTransport([]))
    events, new_wm = conn.collect(since_watermark=100)
    assert events == []
    assert new_wm == 100                      # 未登录不动水位线


def test_collect_filters_by_watermark(tmp_path):
    transport = FakeTransport([
        (200, {"data": {"files": [
            {"type": "doc", "name": "旧文档", "token": "D0",
             "modified_time": "100"},
            {"type": "doc", "name": "新文档", "token": "D1",
             "modified_time": "200"},
        ], "has_more": False}}),
    ])
    conn = FeishuDocsConnector(
        vault=_vault(tmp_path, {"user_access_token": "t"}),
        transport=transport)
    events, new_wm = conn.collect(since_watermark=150)
    assert len(events) == 1                   # 水位线以下不重报
    assert "新文档" in events[0]["text"]
    assert new_wm == 200


def test_collect_http_error_no_watermark_regression(tmp_path):
    transport = FakeTransport([(500, None)])
    conn = FeishuDocsConnector(
        vault=_vault(tmp_path, {"user_access_token": "t"}),
        transport=transport)
    events, new_wm = conn.collect(since_watermark=100)
    assert events == []
    assert new_wm == 100                      # 故障时水位线原地踏步


def test_test_session(tmp_path):
    ok = FeishuDocsConnector(
        vault=_vault(tmp_path, {"user_access_token": "t"}),
        transport=FakeTransport([(200, {"data": {"name": "我"}})]))
    assert ok.test_session() is True
    bad = FeishuDocsConnector(
        vault=_vault(tmp_path, {"user_access_token": "t"}),
        transport=FakeTransport([(401, None)]))
    assert bad.test_session() is False
    noauth = FeishuDocsConnector(vault=_vault(tmp_path / "空库"),
                                 transport=FakeTransport([]))
    assert noauth.test_session() is False


def test_login_flow_requires_app_config(tmp_path):
    conn = FeishuDocsConnector(vault=_vault(tmp_path), transport=FakeTransport([]))
    assert conn.login_flow() is False         # 无 app_id/secret 不装模作样
    assert conn.name == "feishu.docs"
    assert "cloud.docs.read" in conn.scopes
