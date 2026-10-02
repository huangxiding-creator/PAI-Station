"""OCR the TCB algorithm filing certificate via WinRT (subprocess-isolated per memory rule)."""
import asyncio
import json
import sys

from PIL import Image

CERT_PNG = r"E:\AI-Station\WeAppForge\filing\tcb_algorithm_cert.png"
CERT_JPG = r"E:\AI-Station\WeAppForge\filing\cert_ocr.jpg"


async def main() -> None:
    from winsdk.windows.globalization import Language
    from winsdk.windows.graphics.imaging import BitmapDecoder
    from winsdk.windows.media.ocr import OcrEngine
    from winsdk.windows.storage import StorageFile

    Image.open(CERT_PNG).convert("RGB").save(CERT_JPG, quality=95)
    f = await StorageFile.get_file_from_path_async(CERT_JPG)
    s = await f.open_read_async()
    dec = await BitmapDecoder.create_async(s)
    bmp = await dec.get_software_bitmap_async()
    eng = OcrEngine.try_create_from_language(Language("zh-CN")) or OcrEngine.try_create_from_user_profile_languages()
    r = await eng.recognize_async(bmp)
    print(json.dumps({"text": r.text}, ensure_ascii=False))


if __name__ == "__main__":
    try:
        asyncio.run(main())
    except Exception as exc:  # noqa: BLE001 - diagnostic script, surface everything
        print(json.dumps({"error": repr(exc)}, ensure_ascii=False), file=sys.stderr)
        sys.exit(1)
