"""M9.5 Bing 检索器 TDD：纯函数解析 + 空安全降级。"""
from paistation.forge.bing_search import parse_html

FIXTURE = """
<html><body><ol>
<li class="b_algo"><h2><a href="https://example.com/epc">EPC 合同风险管理指南</a></h2>
<p>2019年12月&ensp;&#0183;&ensp;工程总承包模式的合同风险识别与分担要点</p></li>
<li class="b_algo"><h2><a href="https://bing.com/aclick?x=1">广告跳转</a></h2><p>广告</p></li>
<li class="b_algo"><h2><a href="https://example.com/claim">索赔管理实务</a></h2>
<p>索赔程序、证据组织与谈判策略的实务总结</p></li>
<li class="b_algo"><h2><a href="https://example.com/epc">重复链接应去重</a></h2><p>x</p></li>
</ol></body></html>
"""


def test_parse_extracts_real_links_and_text():
    rows = parse_html(FIXTURE)
    urls = [r["url"] for r in rows]
    assert urls == ["https://example.com/epc", "https://example.com/claim"]
    assert "合同风险" in rows[0]["title"] or "合同风险" in rows[0]["snippet"]
    assert all(r["source"] == "bing" for r in rows)


def test_parse_empty_and_garbage():
    assert parse_html("") == []
    assert parse_html("<html>没有结果块</html>") == []
