# -*- coding: utf-8 -*-
"""v0.7.4 海报重设计预览：真实 poster.build + 确定性伪码占位 → PNG 落盘。"""
import io
import random
import sys

sys.path.insert(0, r"E:\AI-Station\services\qianwen-engine")
from qianwen_engine import poster  # noqa: E402
from PIL import Image, ImageDraw  # noqa: E402


def fake_qr(n=29, seed=42):
    rng = random.Random(seed)
    s = 12
    img = Image.new("RGB", ((n + 4) * s, (n + 4) * s), (255, 255, 255))
    d = ImageDraw.Draw(img)
    # 三个定位角 + 伪数据模块
    for (ox, oy) in ((0, 0), (n - 7, 0), (0, n - 7)):
        for i in range(7):
            for j in range(7):
                if i in (0, 6) or j in (0, 6) or (2 <= i <= 4 and 2 <= j <= 4):
                    d.rectangle([(ox + i + 2) * s, (oy + j + 2) * s,
                                 (ox + i + 3) * s - 1, (oy + j + 3) * s - 1], fill=(7, 22, 42))
    for y in range(n):
        for x in range(n):
            in_eye = (x < 9 and y < 9) or (x >= n - 9 and y < 9) or (x < 9 and y >= n - 9)
            if not in_eye and rng.random() < 0.46:
                d.rectangle([(x + 2) * s, (y + 2) * s, (x + 3) * s - 1, (y + 3) * s - 1],
                            fill=(7, 22, 42))
    out = io.BytesIO()
    img.save(out, format="PNG")
    return out.getvalue()


png = poster.build(
    "EPC总承包合同中，业主指定的分包商出现工期延误，总包单位能否主张免责？",
    ["书面留存业主指定指令原件，是免责抗辩的第一证据链",
     "总承包合同示范文本对指定分包风险有明确分配规则",
     "需同步发出工期签证与费用影响通知，逾期视为认可"],
    fake_qr(),
    {"chars": 3842, "cites": 6},
)
p = r"E:\AI-Station\WeAppForge\work\poster_v074_preview.png"
open(p, "wb").write(png)
print("OK", p, len(png), "bytes")

# 最坏情形：4 行问题 + 3 条满宽要点（锚点挤压极限）
png2 = poster.build(
    "EPC总承包合同履行中，业主指定的分包商出现严重工期延误与质量问题，"
    "总包单位能否据此主张工期免责与费用补偿，具体需要准备哪些证据材料？",
    ["书面留存业主指定指令原件与往来函件，是免责抗辩的第一证据链，缺一不可",
     "总承包合同示范文本对指定分包的风险分配有明确规则，签约时应重点核对条款",
     "需同步发出工期签证与费用影响通知，逾期未发将被视为认可相应损失"],
    fake_qr(seed=7),
    {"chars": 12846, "cites": 12},
)
p2 = r"E:\AI-Station\WeAppForge\work\poster_v074_preview_worst.png"
open(p2, "wb").write(png2)
print("OK", p2, len(png2), "bytes")
