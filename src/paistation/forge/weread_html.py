"""微信读书章节 HTML → 块模型转换器（stdlib html.parser，零依赖）。

块模型是导出层的公共中间表示（ADR-6）：
  {kind: heading|para|quote|li|img, text, level?, src?, alt?}
- html_to_md / html_to_text / html_to_blocks 三视图共用一个解析器
- 书内元素集合：h1-h6 / p / b,strong,i,em / img / blockquote / ul,ol,li /
  table（降级保真）；未识别标签透明放行——降级不丢内容是铁律（ADR-5）
- 图片单独成块并收集清单，供批量层下载本地化
"""
import re
from html.parser import HTMLParser

_HEADINGS = {"h1": 1, "h2": 2, "h3": 3, "h4": 4, "h5": 5, "h6": 6}
_BOLD = {"b", "strong"}
_ITALIC = {"i", "em"}
_LIST = {"ul", "ol"}
_SKIP = {"script", "style"}           # e_2 样式分片不会进来，防御性跳过


class _BlockParser(HTMLParser):
    """状态机：块级上下文栈 + 行内格式直插，输出块序列。"""

    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.blocks: list[dict] = []
        self._line: list[str] = []        # 当前块累积（含行内标记）
        self._kind = "para"
        self._level = 0
        self._list_stack: list[str] = []
        self._ol_counters: list[int] = []
        self._in_quote = False
        self._skip_depth = 0
        self.images: list[dict] = []

    def _flush(self) -> None:
        text = re.sub(r"[ \t]+", " ", "".join(self._line)).strip()
        self._line = []
        if not text:
            return
        if self._kind == "heading":
            self.blocks.append({"kind": "heading", "text": text,
                                "level": self._level or 1})
        elif self._kind == "li":
            self.blocks.append({"kind": "li", "text": text,
                                "ordered": self._list_stack[-1] == "ol",
                                "index": self._ol_counters[-1]})
        else:
            self.blocks.append({"kind": "quote" if self._in_quote else "para",
                                "text": text})

    def handle_starttag(self, tag, attrs):
        if tag in _SKIP:
            self._skip_depth += 1
            return
        if self._skip_depth:
            return
        if tag in _HEADINGS:
            self._flush()
            self._kind, self._level = "heading", _HEADINGS[tag]
        elif tag == "p":
            self._flush()
            self._kind = "para"
        elif tag == "br":
            self._line.append("\n")
        elif tag in _BOLD:
            self._line.append("**")
        elif tag in _ITALIC:
            self._line.append("*")
        elif tag == "img":
            attrs_d = dict(attrs)
            src = attrs_d.get("src", "")
            alt = attrs_d.get("alt", "")
            if src:
                self._flush()
                self.blocks.append({"kind": "img", "src": src, "alt": alt})
                self.images.append({"src": src, "alt": alt})
        elif tag == "blockquote":
            self._flush()
            self._in_quote = True
        elif tag in _LIST:
            self._flush()
            self._list_stack.append(tag)
            self._ol_counters.append(0)
        elif tag == "li":
            self._flush()
            self._kind = "li"
            if self._list_stack and self._list_stack[-1] == "ol":
                self._ol_counters[-1] += 1
        elif tag == "tr":
            self._flush()
        elif tag in ("td", "th"):
            self._line.append(" ")

    def handle_endtag(self, tag):
        if tag in _SKIP:
            self._skip_depth = max(0, self._skip_depth - 1)
            return
        if self._skip_depth:
            return
        if tag in _HEADINGS:
            self._flush()
            self._kind, self._level = "para", 0
        elif tag == "p":
            self._flush()
            self._kind = "para"
        elif tag in _BOLD:
            self._line.append("**")
        elif tag in _ITALIC:
            self._line.append("*")
        elif tag == "blockquote":
            self._flush()
            self._in_quote = False
        elif tag in _LIST:
            self._flush()
            if self._list_stack:
                self._list_stack.pop()
                self._ol_counters.pop()

    def handle_data(self, data):
        if self._skip_depth or not data.strip():
            return
        self._line.append(data)


def html_to_blocks(html_text: str) -> tuple:
    """HTML → (blocks, images)。空输入返回 ([], [])。"""
    if not html_text:
        return [], []
    parser = _BlockParser()
    parser.feed(html_text)
    parser.close()
    parser._flush()
    return parser.blocks, parser.images


def html_to_md(html_text: str) -> tuple:
    """HTML → (markdown, images)。"""
    blocks, images = html_to_blocks(html_text)
    lines = []
    for blk in blocks:
        kind = blk["kind"]
        if kind == "heading":
            lines.append("#" * min(blk["level"], 6) + " " + blk["text"])
        elif kind == "li":
            marker = (f"{blk['index']}. " if blk.get("ordered") else "- ")
            lines.append(marker + blk["text"])
        elif kind == "quote":
            lines.append("> " + blk["text"])
        elif kind == "img":
            lines.append(f"![{blk['alt']}]({blk['src']})")
        else:
            lines.append(blk["text"])
    return "\n\n".join(lines), images


def html_to_text(html_text: str) -> str:
    """HTML → 纯文本（无格式标记，供 .text 字段与字数统计）。"""
    blocks, _ = html_to_blocks(html_text)
    parts = []
    for blk in blocks:
        if blk["kind"] == "img":
            parts.append(f"[{blk['alt']}]" if blk["alt"] else "[图]")
        else:
            text = blk["text"].replace("**", "").replace("*", "")
            parts.append(text)
    return "\n".join(parts).strip()


def escape_md(text: str) -> str:
    """转义 Markdown 特殊字符（章节标题入 MD 时防注入语法）。"""
    return re.sub(r"([*_`\[\]])", r"\\\1", text)
