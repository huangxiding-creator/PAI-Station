# -*- coding: utf-8 -*-
"""海报 QC 渲染夹具（v0.9.8 重设计迭代用）。

本机 Python311 + PIL 直接调 poster.build()，假 QR 占位，
输出 PNG + JPG 双形态到 WeAppForge/work/ 供目视/analyze_image 通道。
用法: python qc_poster_gen.py [v2|cur]
"""
import io
import sys

sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")

from PIL import Image, ImageDraw  # noqa: E402

from qianwen_engine import poster  # noqa: E402

OUT_DIR = r"E:\AI-Station\WeAppForge\work"

QUESTION = ("EPC 固定总价合同下，钢材价格大幅上涨，承包商能否主张价款调整？"
            "主合同约定不调价，但投标时业主提供的清单存在缺项漏项。")

BULLETS = [
    "结论：固定总价原则不因市场波动调价",
    "依据：缺项漏项属业主风险，可据实结算",
    "操作：限期内提交书面签证与证据",
]

ANSWER = ("本解答分三个层次展开。首先，固定总价合同的价格风险原则上由承包商承担，"
          "主合同约定不调价条款在通常市场波动下对承包商具有约束力。其次，投标清单"
          "存在缺项漏项的，按照《建设工程工程量清单计价规范》，缺项漏项的风险应由"
          "招标人承担，承包商可就实际发生的漏项工程量主张据实结算。第三，钢材价格"
          "在合同履行期内涨幅显著超过正常商业风险范围的，可结合合同专用条款与地方"
          "调价文件，主张超出部分的价差补偿。建议立即固定证据链：进场验收单、采购"
          "合同与发票、逐月价格指数，并在合同约定的签证期限内书面提出，避免逾期"
          "失权。")


def fake_qr(size: int = 430) -> bytes:
    """假小程序码占位：灰底+网格线+三定位块（仅供版式 QC，不可扫）。"""
    img = Image.new("RGB", (size, size), (250, 250, 250))
    d = ImageDraw.Draw(img)
    step = size // 8
    for i in range(0, size, step):
        d.line([(i, 0), (i, size)], fill=(225, 225, 225), width=2)
        d.line([(0, i), (size, i)], fill=(225, 225, 225), width=2)

    def finder(x, y):
        s = step * 2
        d.rectangle([x, y, x + s, y + s], outline=(11, 31, 58), width=8)
        d.ellipse([x + s // 2 - 14, y + s // 2 - 14, x + s // 2 + 14, y + s // 2 + 14],
                  fill=(11, 31, 58))

    finder(10, 10)
    finder(size - 10 - step * 2, 10)
    finder(10, size - 10 - step * 2)
    d.ellipse([size // 2 - 26, size // 2 - 26, size // 2 + 26, size // 2 + 26],
              outline=(240, 122, 40), width=8)
    out = io.BytesIO()
    img.save(out, format="PNG")
    return out.getvalue()


def main() -> None:
    tag = sys.argv[1] if len(sys.argv) > 1 else "v2"
    kw = {}
    meta = {"chars": 4820, "cites": 12}
    if "answer" in poster.build.__code__.co_varnames or any(
            p.name == "answer" for p in __import__("inspect").signature(poster.build).parameters.values()):
        kw["answer"] = ANSWER
    png = poster.build(QUESTION, BULLETS, fake_qr(), meta=meta, **kw)
    p_png = OUT_DIR + "\\qc_poster_" + tag + ".png"
    with open(p_png, "wb") as f:
        f.write(png)
    img = Image.open(io.BytesIO(png)).convert("RGB")
    p_jpg = OUT_DIR + "\\qc_poster_" + tag + ".jpg"
    img.save(p_jpg, format="JPEG", quality=92)
    print(f"OK {tag}: {img.size[0]}x{img.size[1]}  png={len(png)}B")
    print(p_png)


if __name__ == "__main__":
    main()
