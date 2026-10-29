# -*- coding: utf-8 -*-
"""captcha_solver2 — v2 求解器：投影定位字形框 → 紧裁剪 ddddocr + 字体模板相关 双通道识别。
离线可测：python scripts/captcha_solver2.py <image> <target1> <target2> <target3>
"""
from __future__ import annotations

import io
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]

import ddddocr
from PIL import Image, ImageDraw, ImageFont

_cls = None


def ocr():
    global _cls
    if _cls is None:
        _cls = ddddocr.DdddOcr(show_ad=False)
    return _cls


def find_boxes(img: Image.Image) -> list[tuple[int, int, int, int]]:
    """候选字形框：ddddocr 检测模型 ∪ 网格滑窗识别位（80px 邻域去重）。"""
    boxes = []
    try:
        det = ddddocr.DdddOcr(det=True, show_ad=False)
        b = io.BytesIO()
        img.save(b, format="PNG")
        for x1, y1, x2, y2 in det.detection(b.getvalue()):
            boxes.append((x1, y1, x2, y2))
    except Exception:                            # noqa: BLE001
        pass
    # 网格滑窗识别位补充（det 漏检时兜底）
    try:
        for ch, cx, cy in _grid_positions(img):
            boxes.append((int(cx - 55), int(cy - 55), int(cx + 55), int(cy + 55)))
    except Exception:                            # noqa: BLE001
        pass
    keep = []
    for x1, y1, x2, y2 in boxes:                 # 邻域去重（中心距 <70 合并，留大框）
        cx, cy = (x1 + x2) / 2, (y1 + y2) / 2
        if any((cx - (a + c) / 2) ** 2 + (cy - (b + d) / 2) ** 2 < 70 ** 2
               for a, b, c, d in keep):
            continue
        keep.append((x1, y1, x2, y2))
    return keep


def _grid_positions(img: Image.Image, win=110, stride=55):
    W, H = img.size
    out = []
    c = ocr()
    for y in range(0, max(1, H - win), stride):
        for x in range(0, max(1, W - win), stride):
            b = io.BytesIO()
            img.crop((x, y, x + win, y + win)).save(b, format="PNG")
            ch = (c.classification(b.getvalue()) or "").strip()
            if len(ch) == 1 and "一" <= ch <= "鿿":
                out.append((ch, x + win / 2, y + win / 2))
    return out


def _tight(img: Image.Image, box, pad=None) -> Image.Image:
    x1, y1, x2, y2 = box
    if pad is None:
        w, h = x2 - x1, y2 - y1
        pad = int(max(w, h) * 0.22) + 4
    return img.crop((max(0, x1 - pad), max(0, y1 - pad), x2 + pad, y2 + pad))


def classify_box(img: Image.Image, box) -> str:
    """多档 padding 取最佳（紧裁剪会切偏旁：舶→舟）。"""
    best = ""
    for f in (0.0, 0.22, 0.45):
        b = io.BytesIO()
        _tight(img, box, pad=int(max(box[2] - box[0], box[3] - box[1]) * f) + 2).save(b, format="PNG")
        ch = (ocr().classification(b.getvalue()) or "").strip()
        if len(ch) == 1 and "一" <= ch <= "鿿":
            return ch
        if len(best) < len(ch):
            best = ch
    return best


def template_locate(img: Image.Image, target: str, win=200, stride=24, ds=64):
    """全图模板滑窗：返回 [(score, cx, cy)] 峰值（降序）。直接回答 target 在哪。"""
    tpl = _render(target, 160)
    bb = tpl.getbbox()
    tpl = tpl.crop(bb) if bb else tpl
    tpl = tpl.resize((ds, ds))
    W, H = img.size
    small = img.convert("L")
    peaks = []
    for y in range(0, max(1, H - win), stride):
        for x in range(0, max(1, W - win), stride):
            crop = small.crop((x, y, x + win, y + win)).resize((ds, ds))
            peaks.append((_norm_corr(tpl, crop), x + win / 2, y + win / 2))
    peaks.sort(key=lambda p: -p[0])
    out = []
    for s, cx, cy in peaks:                      # 峰间去重 70px
        if all((cx - a) ** 2 + (cy - b) ** 2 > 70 ** 2 for _, a, b in out):
            out.append((s, cx, cy))
        if len(out) >= 3:
            break
    return out


_FONTS = ["C:/Windows/Fonts/msyh.ttc", "C:/Windows/Fonts/simhei.ttf",
          "C:/Windows/Fonts/Deng.ttf", "C:/Windows/Fonts/simsun.ttc"]


def _render(ch: str, size: int) -> Image.Image:
    for fp in _FONTS:
        try:
            f = ImageFont.truetype(fp, size)
            im = Image.new("L", (size * 2, size * 2), 0)
            d = ImageDraw.Draw(im)
            d.text((size // 2, size // 2), ch, fill=255, font=f)
            return im
        except Exception:                        # noqa: BLE001
            continue
    raise RuntimeError("无可用字体")


def _norm_corr(a: Image.Image, b: Image.Image) -> float:
    """归一化相关（纯PIL实现，尺寸对齐到 b）。"""
    a = a.convert("L").resize(b.size)
    b = b.convert("L")
    da, db = list(a.getdata()), list(b.getdata())
    n = len(da)
    ma, mb = sum(da) / n, sum(db) / n
    num = sum((da[i] - ma) * (db[i] - mb) for i in range(n))
    den = (sum((da[i] - ma) ** 2 for i in range(n)) * sum((db[i] - mb) ** 2 for i in range(n))) ** 0.5
    return num / den if den else 0.0


def template_score(target: str, img: Image.Image, box) -> float:
    x1, y1, x2, y2 = box
    w = max(1, x2 - x1)
    tpl = _render(target, max(64, min(160, w)))
    # 模板裁到紧界
    bb = tpl.getbbox()
    tpl = tpl.crop(bb) if bb else tpl
    return _norm_corr(tpl, _tight(img, box))


def solve(img: Image.Image, targets: list[str]):
    """返回 [(target, box)]，不足 len(targets) 视为失败。"""
    boxes = find_boxes(img)
    cands = []
    for box in boxes:
        ch = classify_box(img, box)
        cands.append({"box": box, "ocr": ch})
    picked = []
    used = set()
    for t in targets:
        best, best_s = None, -1.0
        for i, c in enumerate(cands):
            if i in used:
                continue
            s_ocr = 1.0 if t == c["ocr"] else (0.6 if t in c["ocr"] or c["ocr"] in t else 0.0)
            s_tpl = template_score(t, img, c["box"])
            score = s_ocr * 1.2 + s_tpl
            if score > best_s:
                best_s, best = score, i
        if best is not None and best_s >= 0.9:
            used.add(best)
            picked.append((t, cands[best]["box"], round(best_s, 2), cands[best]["ocr"]))
    return picked, cands


if __name__ == "__main__":
    img_path, tg = sys.argv[1], sys.argv[2:]
    im = Image.open(img_path).convert("RGB")
    picked, cands = solve(im, tg)
    print("boxes:", [(c["ocr"], c["box"]) for c in cands])
    print("picked:", picked)
    print("VERDICT:", "PASS" if len(picked) == len(tg) else "FAIL")
