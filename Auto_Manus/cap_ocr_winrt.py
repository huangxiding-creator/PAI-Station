# -*- coding: utf-8 -*-
"""搜狗点选验证码字定位 — WinRT OCR 子进程隔离 (每次调用新进程, 无累积态死锁).

输入: 图片路径 [目标字列表]
输出: JSON [{text, x, y, w, h}] 坐标为原图像素 (内部放大3倍后已换算回).
"""
import asyncio
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SCALE = 3  # 310x155 原图太小, 放大助 OCR


async def ocr_bytes(png_bytes: bytes) -> list[dict]:
    from winsdk.windows.globalization import Language
    from winsdk.windows.graphics.imaging import (
        BitmapDecoder, SoftwareBitmap, BitmapAlphaMode, BitmapPixelFormat)
    from winsdk.windows.media.ocr import OcrEngine
    from winsdk.windows.storage.streams import (
        DataWriter, InMemoryRandomAccessStream)

    lang = Language("zh-CN")
    engine = (OcrEngine.try_create_from_language(lang)
              or OcrEngine.try_create_from_user_profile_languages())
    if engine is None:
        raise RuntimeError("无 zh-CN OCR 引擎 (需语言包)")

    stream = InMemoryRandomAccessStream()
    writer = DataWriter(stream.get_output_stream_at(0))
    writer.write_bytes(png_bytes)
    await writer.store_async()

    bmp = await BitmapDecoder.create_async(stream)
    soft = await bmp.get_software_bitmap_async()
    if soft.bitmap_pixel_format != BitmapPixelFormat.GRAY8:
        soft = SoftwareBitmap.convert(soft, BitmapPixelFormat.GRAY8,
                                      BitmapAlphaMode.IGNORE)

    result = await engine.recognize_async(soft)
    words = []
    for line in result.lines:
        for w in line.words:
            r = w.bounding_rect
            words.append({"text": w.text, "x": r.x / SCALE, "y": r.y / SCALE,
                          "w": r.width / SCALE, "h": r.height / SCALE})
    return words


def main() -> int:
    from PIL import Image

    img = Image.open(sys.argv[1]).convert("RGB")
    img = img.resize((img.width * SCALE, img.height * SCALE), Image.LANCZOS)
    buf = io.BytesIO()
    img.save(buf, format="PNG")

    words = asyncio.run(ocr_bytes(buf.getvalue()))
    targets = sys.argv[2:]
    print(json.dumps({"size": [img.width // SCALE, img.height // SCALE],
                      "words": words, "targets": targets},
                     ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
