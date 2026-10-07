# -*- coding: utf-8 -*-
"""build_site 单测 — 发布平台生成器 (F5a, 多商品目录架构).

覆盖: ①md mini renderer ②目录首页要件 (分组/卡片/旗舰/预售带/购买须知)
③详情页要件 (徽章/目录手风琴+平铺/试读卡/购买区/吸底栏)
④sample 转化钩子 ⑤admin ⑥QR 缺席占位/在场复制 ⑦幂等+content 零触碰
⑦b reader 页 ⑧ast 零网络根模块.
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
        {"sku": "F1", "cat": "flagship", "cat_name": "旗舰深度",
         "title": "《旗舰报告》", "subtitle": "副题", "price": 1999,
         "price_label": "首发 ¥1,999", "words_wan": 10,
         "intro_lede": "旗舰引导语", "intro": "旗舰正文介绍", "src_appendix": True,
         "badges": [{"k": "底稿", "v": "867 份"}, {"k": "资料", "v": "1294 万字"}],
         "sample_file": "f1.md", "sample_label": "关键问题 + 写法片段",
         "chapters": [{"id": "ch1", "title": "第一章 甲", "desc": "定位甲"},
                      {"id": "ch2", "title": "第二章 乙", "desc": "定位乙"}]},
        {"sku": "B1", "cat": "ent", "cat_name": "企业全景洞察",
         "title": "《批量报告》", "subtitle": "3 章拆解某企业的打法",
         "price": 698, "price_label": "电子版 ¥698", "words_wan": 8,
         "intro_lede": "批量引导语", "intro": "批量正文介绍",
         "badges": [{"k": "万字成稿", "v": "8"}, {"k": "章", "v": "3"}],
         "sample_file": "b1.md", "sample_label": "目录全览 + 开篇片段",
         "chapters": [{"id": "ch1", "title": "第一章 丙"},
                      {"id": "ch2", "title": "第二章 丁"}]},
        {"sku": "S1", "title": "预售", "subtitle": "编制中", "price": 10000,
         "price_label": "¥10,000", "words_wan": 50, "badges": [], "chapters": [],
         "coming_soon": True, "volumes": ["卷一", "卷二"]}]}

    def _skel(r: dict) -> dict:
        return {"intro_lede": "", "intro": "", "audience": "", "cat": "",
                "cat_name": "", "chapters": r["chapters"]}
    (c / "report.json").write_text(json.dumps(cfg, ensure_ascii=False),
                                   encoding="utf-8")
    (c / "sample" / "f1.md").write_text(
        "# 摘要\n\n段落一**加粗**。\n\n## 1.1 小节\n\n- 要点甲\n- 要点乙\n",
        encoding="utf-8")
    (c / "sample" / "b1.md").write_text(
        "# 先看清楚\n\n一句话。\n\n# 报告目录\n\n- 第一章 丙\n\n# 第 1 章开篇\n\n片段。",
        encoding="utf-8")
    return c


# ------------------------------------------------ ① md renderer
def test_01_md_to_html():
    h = BS.md_to_html("# 大题\n\n段落。\n\n- 甲\n- 乙\n\n## 小题\n\n尾段")
    assert "<h1>大题</h1>" in h and "<h2>小题</h2>" in h
    assert "<li>甲</li>" in h and "<p>段落。</p>" in h
    assert "<strong>加粗</strong>" in BS.md_to_html("**加粗**")
    assert h.count("<ul>") == 1 and h.count("</ul>") == 1   # 列表闭合


# ------------------------------------------------ ② 目录首页
def test_02_catalog_essentials():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    cfg = json.loads((c / "report.json").read_text(encoding="utf-8"))
    html = BS.build_catalog(cfg, c)
    for key in ("旗舰深度", "企业全景洞察", "《旗舰报告》", "批量报告",   # 卡片剥书名号
                "¥1,999", "¥698", "sample_f1.html", "sample_b1.html",
                "f1.html", "b1.html", "在售研究报告", "蓝皮书预售" if "蓝皮书" in html else "预售",
                "退款", "免费试读", "详情"):
        assert key in html, key
    assert "cdn" not in html.lower() and "http://" not in html   # 零外链


# ------------------------------------------------ ③ 详情页
def test_03_report_pages():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    cfg = json.loads((c / "report.json").read_text(encoding="utf-8"))
    flag = BS.build_report(cfg["reports"][0], cfg, c)
    for key in ("867 份", "第一章 甲", "定位甲", "首发 ¥1,999", "开始试读",
                "sample_f1.html", "立即购买", "提交支付凭证", "data-ev",
                "来源清单", "旗舰引导语", "全部报告", "toc-body"):
        assert key in flag, key
    bat = BS.build_report(cfg["reports"][1], cfg, c)
    assert '<div class="toc-flat">' in bat               # 无 desc=平铺目录
    assert '<details class="toc"' not in bat             # 不出现手风琴行
    assert "第一章 丙" in bat and "批量引导语" in bat
    assert "来源清单" not in bat                          # 批量无附录
    assert "http://" not in flag and "http://" not in bat


# ------------------------------------------------ ④ sample 钩子
def test_04_sample_cta():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    cfg = json.loads((c / "report.json").read_text(encoding="utf-8"))
    html = BS.build_sample(cfg["reports"][1], cfg, c)
    assert "b1.html" in html and "解锁完整版 ¥698" in html
    assert "<h1>《批量报告》</h1>" in html and "第 1 章开篇" in html


# ------------------------------------------------ ⑤ admin
def test_05_admin():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    html = BS.build_admin({"reports": [{}]})
    assert "数据台" in html and "token" in html and "/api/stats" in html


# ------------------------------------------------ ⑥ QR 占位/在场
def test_06_qr_slots():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    cfg = json.loads((c / "report.json").read_text(encoding="utf-8"))
    assert "收款码待接入" in BS.build_report(cfg["reports"][0], cfg, c)
    png = _tiny_png()
    (c / "qr_wechat.png").write_bytes(png)
    out = tmp / "site"
    r = BS.build(c, out)
    assert r["qr"] == ["wechat"]                              # 在场=复制+登记
    assert (out / "assets" / "qr_wechat.png").read_bytes() == png
    f1 = (out / "f1.html").read_text(encoding="utf-8")
    assert 'src="assets/qr_wechat.png"' in f1
    assert "收款码待接入" not in f1                           # alipay 不再占位 (1007 令)
    assert "alipay" not in f1 and "支付宝" not in f1          # 全站只留微信收款


# ------------------------------------------------ ⑦ 幂等+content 零触碰
def test_07_idempotent_build():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    c = _content(tmp)
    snap = (c / "report.json").read_text(encoding="utf-8")
    out = tmp / "site"
    r1 = BS.build(c, out)
    h1 = (out / "index.html").read_text(encoding="utf-8")
    r2 = BS.build(c, out)
    h2 = (out / "index.html").read_text(encoding="utf-8")
    assert r1["pages"] == r2["pages"] == [
        "admin.html", "b1.html", "f1.html", "index.html", "reader.html",
        "sample_b1.html", "sample_f1.html"]
    assert h1 == h2                                            # 确定性输出
    assert (c / "report.json").read_text(encoding="utf-8") == snap


# ------------------------------------------------ ⑦b reader 页要件
def test_07b_reader_page():
    tmp = Path(tempfile.mkdtemp(prefix="rp_test_"))
    html = BS.build_reader(json.loads((_content(tmp) / "report.json")
                                      .read_text(encoding="utf-8")))
    for key in ("读者解锁", "lookupForm", "reader/content", "read_chapter",
                "fbForm", "退款政策", "质量问题", "改进建议", "fbChapter",
                "full.pdf", "feedback_sent"):
        assert key in html, key
    assert "cdn" not in html.lower() and "http://" not in html   # 零外链


# ------------------------------------------------ ⑧ ast 零网络
def test_08_ast_no_network():
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
