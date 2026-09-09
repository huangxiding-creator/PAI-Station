"""混沌学园课件图片 → 每课一份 PDF（用户指令：课件图片合并为 PDF）。

图源（从章节文稿按出现顺序提取）：
- ppt_<ts>.jpg（yxs-app/snapshot/...）——视频翻页事件快照 = PPT 页
- oss yxs-app 内嵌图——文稿插图/图表
排除：vod.hundun.cn 视频时间轴缩略图。
幂等：已生成 _课件.pdf 跳过；下载失败单图跳过不挡整册。
用法: python scripts/hundun_slides_pdf.py [--limit N] [--only AI课程]
"""
import glob
import io
import json
import os
import re
import sys
import time
from concurrent.futures import ThreadPoolExecutor

import urllib.request

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BASE = os.path.join(ROOT, "data", "hundun")
_UA = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}
_IMG_RE = re.compile(r'https://[^\s"\']+?\.(?:jpg|jpeg|png)', re.IGNORECASE)
_EXCLUDE = ("vod.hundun.cn",)  # 视频时间轴缩略图不是课件


def course_images(course: dict) -> list:
    """按章节/时间线顺序提取课件图 URL（全局去重）。"""
    seen, out = set(), []
    for ch in course.get("chapters") or []:
        for url in _IMG_RE.findall(ch.get("transcript") or ""):
            if any(host in url for host in _EXCLUDE):
                continue
            if url not in seen:
                seen.add(url)
                out.append(url)
    return out


def fetch(url: str, retries: int = 2) -> bytes | None:
    opener = urllib.request.build_opener(urllib.request.ProxyHandler({}))
    for _ in range(retries + 1):
        try:
            with opener.open(urllib.request.Request(url, headers=_UA),
                             timeout=20) as resp:
                return resp.read()
        except Exception:
            time.sleep(1)
    return None


def make_pdf(urls: list, out_path: str) -> tuple:
    """并发下载 → Pillow 合成 PDF。返回 (页数, 失败数)。"""
    from PIL import Image
    pages, fails = [], 0
    with ThreadPoolExecutor(max_workers=8) as pool:
        for blob in pool.map(fetch, urls):
            if blob:
                try:
                    img = Image.open(io.BytesIO(blob))
                    pages.append(img.convert("RGB"))
                except Exception:  # noqa: BLE001 - 坏图跳过
                    fails += 1
            else:
                fails += 1
    if not pages:
        return 0, fails
    # 先写 pid 临时文件再原子替换：Pillow save_all 对已存在文件是「追加」
    # 语义，并行进程/重跑撞上会得到翻倍页数或半写文件崩溃；
    # format 必须显式指定——Pillow 按扩展名推断格式，.tmp 会 unknown
    tmp = f"{out_path}.{os.getpid()}.tmp"
    pages[0].save(tmp, format="PDF", save_all=True, append_images=pages[1:],
                  resolution=96.0)
    os.replace(tmp, out_path)
    for p in pages:
        p.close()
    return len(pages), fails


def pdf_name(json_path: str, course: dict) -> str:
    slug = re.sub(r"[^\w一-鿿-]+", "_", course.get("title", "")).strip("_")
    return os.path.join(os.path.dirname(json_path),
                        f"{slug[:60] or 'course'}_课件.pdf")


def main(argv: list) -> int:
    limit = int(argv[argv.index("--limit") + 1]) if "--limit" in argv else 0
    only = argv[argv.index("--only") + 1] if "--only" in argv else ""
    jsons = [f for f in sorted(glob.glob(os.path.join(
        BASE, "**", "*.json"), recursive=True)) if "_recon" not in f]
    if only:
        jsons = [f for f in jsons if f"\\{only}\\" in f or f"/{only}/" in f]
    done = skipped = empty = 0
    t0 = time.time()
    for i, jp in enumerate(jsons, 1):
        out = None
        try:
            course = json.load(open(jp, encoding="utf-8"))
            out = pdf_name(jp, course)
        except (OSError, ValueError):
            continue
        if os.path.exists(out):
            skipped += 1
            continue
        urls = course_images(course)
        if not urls:
            empty += 1
            continue
        try:
            pages, fails = make_pdf(urls, out)
        except Exception as exc:  # noqa: BLE001 - 单课失败不挡批
            print(f"[{i}/{len(jsons)}] FAIL {os.path.basename(out)[:40]}: "
                  f"{str(exc)[:80]}", flush=True)
            continue
        if pages:
            done += 1
            size = os.path.getsize(out) // 1024
            print(f"[{i}/{len(jsons)}] {os.path.basename(out)[:44]} "
                  f"{pages}页 {size}KB (缺{fails})", flush=True)
        else:
            empty += 1
        if limit and done >= limit:
            break
        if i % 25 == 0:
            print(f"[progress] {i}/{len(jsons)} pdf={done} skip={skipped} "
                  f"空={empty} {(time.time() - t0) / 60:.1f}min", flush=True)
    print(f"[slides] 完成：pdf {done} 跳过 {skipped} 无图 {empty} "
          f"耗时 {(time.time() - t0) / 60:.1f} 分钟", flush=True)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
