"""M2.5 铸造厂：微信读书 HTML→MD 转换器金标准测试。"""
from paistation.forge.weread_html import escape_md, html_to_md, html_to_text


def test_headings_and_paragraphs():
    md, imgs = html_to_md("<h1>第一章</h1><p>段落一。</p><p>段落二。</p>")
    assert md == "# 第一章\n\n段落一。\n\n段落二。"
    assert imgs == []


def test_nested_heading_levels():
    md, _ = html_to_md("<h1>卷</h1><h2>章</h2><h3>节</h3>")
    assert md == "# 卷\n\n## 章\n\n### 节"


def test_bold_italic_inline():
    md, _ = html_to_md("<p>普通<b>加粗</b>与<i>斜体</i></p>")
    assert md == "普通**加粗**与*斜体*"


def test_image_collected_and_rendered():
    md, imgs = html_to_md('<p>前文</p><img src="https://x/1.jpg" alt="图1">')
    assert "![图1](https://x/1.jpg)" in md
    assert imgs == [{"src": "https://x/1.jpg", "alt": "图1"}]


def test_blockquote():
    md, _ = html_to_md("<blockquote><p>引用内容</p></blockquote>")
    assert md == "> 引用内容"


def test_unordered_list():
    md, _ = html_to_md("<ul><li>甲</li><li>乙</li></ul>")
    assert md == "- 甲\n\n- 乙"


def test_ordered_list():
    md, _ = html_to_md("<ol><li>第一</li><li>第二</li></ol>")
    assert md == "1. 第一\n\n2. 第二"


def test_line_break():
    md, _ = html_to_md("<p>上行<br/>下行</p>")
    assert "上行\n下行" in md


def test_unknown_tag_degrades_to_text():
    """未识别标签透明放行——降级不丢内容铁律。"""
    md, _ = html_to_md("<custom-tag>正文保留</custom-tag>")
    assert "正文保留" in md


def test_div_wrapper_transparent():
    md, _ = html_to_md('<div class="readerChapterContent"><p>内容</p></div>')
    assert md == "内容"


def test_empty_input():
    assert html_to_md("") == ("", [])


def test_html_to_text_strips_markers():
    text = html_to_text("<h1>标题</h1><p>含<b>粗</b>字<img src='s' alt='插图'></p>")
    # 块单换行连接；图片保留 alt 占位
    assert text == "标题\n含粗字\n[插图]"


def test_escape_md():
    assert escape_md("a*b_c[d]") == r"a\*b\_c\[d\]"
