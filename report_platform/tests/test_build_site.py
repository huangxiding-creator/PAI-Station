# -*- coding: utf-8 -*-
"""build_site 单测 — 发布平台生成器 (F5a).

覆盖: ①md mini renderer ②index 要件 (徽章/目录/试读卡/购买区/吸底栏)
③sample 转化钩子 ④admin 生成 ⑤QR 缺席占位/在场复制 ⑥幂等重建+content 零触碰
⑦ast 零网络根模块 (build_site/template).
"""
from __future__ import annotations

import ast
import json
import struct
import sys
import tempfile
import zlib
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import build_site as BS   # noqa: E402


def _tiny_png() -> bytes:
    """合法 1x1 灰度 PNG (struct+zlib 精确构造, 免手拼 hex)."""
    def chunk(tag: bytes, data: bytes) -> bytes:
        return (struct.pack(">I", len(data)) + tag + data
                + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF))
    ihdr = struct.pack(">IIBBBBB", 1, 1, 8, 0, 0, 0, 0)
    idat = zlib.compress(b"\x00\xff")
    return (b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr)
            + chunk(b"IDAT", idat) + chunk(b"IEND", b""))


def _content(tmp: Path) -> Path:
    c = tmp / "content"
    (c / "sample").mkdir(parents=True)
    cfg = {"site_name": "t", "reports": [
        {"sku": "R1", "title": "《测试报告》", "subtitle": "副题", "price": 1999,
         "price_label": "首发 ¥1,999", "words_wan": 10,
         "badges": [{"k": "文档", "v": "867 份"}, {"k": "语料", "v": "1294 万字"}],
         "sample_file": "s.md", "sample_label": "样章",
         "chapters": [{"id": "ch1", "title": "第一章 甲", "desc": "定位甲"},
                      {"id": "ch2", "title": "第二章 乙", "desc": "定位乙"}]},
        {"sku": "S1", "title": "预售", "subtitle": "编制中", "price": 10000,
         "price_label": "¥10,000", "words_wan": 50, "badges": [], "chapters": [],
         "coming_soon": True, "volumes": ["卷一", "卷二"]}]}
    (c / "report.json").write_text(json.dumps(cfg, ensure_ascii=False),
                                   encoding="utf-8")
    (c / "sample" / "s.md").write_text(
        "# 摘要\n\n段落一**加粗**。\n\n## 1.1 小节\n\n- 要点甲\n- 要点乙\n",
        encoding="utf-8")
    return c


# ------------------------------------------------ ① md renderer
def test_01_md_to_html():
    h = BS.md_to_html("# 大题\n\n段落。\n\n- 甲\n- 乙\n\n## 小题\n\n尾段")
    assert "<h1>大题</h1>" in h and "<h2>小题</h2>" in h
    assert "<li>甲</li>" in h and "<p>段落。</p>" in h
    assert "<strong>加粗</strong>" in BS.md_to_html("**加粗**")
    assert h.count("<ul>") == 1 and h.count("</ul>") == 1   # 列表闭合


# ------------------------------------------------ ② index 要件
def test_02_index_essentials():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    html = BS.build_index(json.loads((c / "report.json").read_text(
        encoding="utf-8")), c)
    for key in ("867 份", "1294 万字", "第一章 甲", "第二章 乙", "首发 ¥1,999",
                "开始试读", "sample.html", "立即购买", "收款码待接入",
                "微信收款", "支付宝收款", "重磅预售", "提交支付凭证", "data-ev"):
        assert key in html, key
    assert "cdn" not in html.lower() and "http://" not in html   # 零外链


# ------------------------------------------------ ③ sample 钩子
def test_03_sample_cta():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    html = BS.build_sample(json.loads((c / "report.json").read_text(
        encoding="utf-8"))["reports"][0],
        json.loads((c / "report.json").read_text(encoding="utf-8")), c)
    assert "返回详情" in html and "解锁完整版 ¥1,999" in html
    assert "<h1>《测试报告》</h1>" in html and "<li>要点甲</li>" in html


# ------------------------------------------------ ④ admin
def test_04_admin():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    html = BS.build_admin({"reports": [{}]})
    assert "数据台" in html and "token" in html and "/api/stats" in html


# ------------------------------------------------ ⑤ QR 占位/在场
def test_05_qr_slots():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    cfg = json.loads((c / "report.json").read_text(encoding="utf-8"))
    assert "收款码待接入" in BS.build_index(cfg, c)          # 缺席=占位
    png = _tiny_png()
    (c / "qr_wechat.png").write_bytes(png)
    out = tmp / "site"
    r = BS.build(c, out)
    assert r["qr"] == ["wechat"]                              # 在场=复制+登记
    assert (out / "assets" / "qr_wechat.png").read_bytes() == png
    idx = (out / "index.html").read_text(encoding="utf-8")
    assert 'src="assets/qr_wechat.png"' in idx
    assert "收款码待接入" in idx                              # alipay 仍占位


# ------------------------------------------------ ⑥ 幂等+content 零触碰
def test_06_idempotent_build():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    snap = (c / "report.json").read_text(encoding="utf-8")
    out = tmp / "site"
    r1 = BS.build(c, out)
    h1 = (out / "index.html").read_text(encoding="utf-8")
    r2 = BS.build(c, out)
    h2 = (out / "index.html").read_text(encoding="utf-8")
    assert r1["pages"] == r2["pages"] == ["admin.html", "index.html",
                                          "reader.html", "sample.html"]
    assert h1 == h2                                            # 确定性输出
    assert (c / "report.json").read_text(encoding="utf-8") == snap


# ------------------------------------------------ ⑥b reader 页要件
def test_06b_reader_page():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    html = BS.build_reader(json.loads((_content(tmp) / "report.json")
                                      .read_text(encoding="utf-8")))
    for key in ("读者解锁", "lookupForm", "reader/content", "read_chapter",
                "fbForm", "退款政策", "质量问题", "改进建议", "fbChapter",
                "full.pdf", "feedback_sent"):
        assert key in html, key
    assert "cdn" not in html.lower() and "http://" not in html   # 零外链


# ------------------------------------------------ ⑦ ast 零网络
def test_07_ast_no_network():
    for mod in (BS,):
        tree = ast.parse(Path(mod.__file__).read_text(encoding="utf-8"))
        mods = set()
        for n in ast.walk(tree):
            if isinstance(n, ast.Import):
                mods.update(a.name.split(".")[0] for a in n.names)
            elif isinstance(n, ast.ImportFrom) and n.module:
                mods.add(n.module.split(".")[0])
        assert not (mods & {"urllib", "requests", "httpx", "curl_cffi",
                            "socket"}), f"网络根模块混入: {mods}"


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
