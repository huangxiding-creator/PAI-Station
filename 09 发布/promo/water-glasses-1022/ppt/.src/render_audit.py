# -*- coding: utf-8 -*-
"""渲染审计 — headless Chromium 渲染 .src/index.html, 逐 slide 截 PNG(2x), 跑验收门:
矩形越界(真裁切) / broken_images / cover_no_image / 占位符残留。
浏览器用完即关(铁律)。非零退出 = 不可交付。
"""
import asyncio
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SRC = Path(__file__).resolve().parent
VAL = SRC / "validate"
VAL.mkdir(exist_ok=True)

AUDIT_JS = """node => {
  const out = {overflow: [], broken: [], placeholders: []};
  const nr = node.getBoundingClientRect();
  const walk = e => {
    const r = e.getBoundingClientRect();
    if (e !== node && (r.bottom > nr.bottom + 2 || r.right > nr.right + 2
        || r.top < nr.top - 2 || r.left < nr.left - 2)) {
      out.overflow.push(e.tagName + '.' + String(e.className).slice(0, 30)
        + ' b' + Math.round(r.bottom) + '/r' + Math.round(r.right));
    }
    if (e.tagName === 'IMG' && (!e.complete || e.naturalWidth === 0)) out.broken.push(e.src.slice(0, 40));
    if (e.children.length === 0 && /TODO|lorem|placeholder|\\[insert|xxx/i.test(e.textContent || ''))
      out.placeholders.push((e.textContent || '').slice(0, 30));
    for (const c of e.children) walk(c);
  };
  walk(node);
  return out;
}"""


async def main() -> int:
    from playwright.async_api import async_playwright
    report = {"gates": {}, "failures": []}
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page(viewport={"width": 1280, "height": 720}, device_scale_factor=2)
        await page.goto((SRC / "index.html").resolve().as_uri(), wait_until="networkidle")
        await page.evaluate("""async () => {
          await document.fonts.ready;
          await Promise.all([...document.images].map(i => i.decode().catch(() => {})));
        }""")
        slides = page.locator("section.slide")
        n = await slides.count()
        report["slide_count"] = n
        for i in range(n):
            el = slides.nth(i)
            sid = await el.get_attribute("id")
            await el.screenshot(path=str(VAL / f"page-{i + 1:02d}.png"))
            audit = await el.evaluate(AUDIT_JS)
            if audit["overflow"]:
                report["failures"].append(f"{sid}: overflow -> {audit['overflow'][:5]}")
            if audit["broken"]:
                report["failures"].append(f"{sid}: broken_images -> {audit['broken'][:4]}")
            if audit["placeholders"]:
                report["failures"].append(f"{sid}: placeholder -> {audit['placeholders'][:4]}")
            if sid == "cover":
                has_img = await el.locator("img").count()
                report["gates"]["cover_no_image"] = has_img == 0
                if has_img == 0:
                    report["failures"].append("cover: 无真图")
        await browser.close()
    (VAL / "report.json").write_text(json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")
    print(json.dumps({"slides": report["slide_count"], "failures": report["failures"]}, ensure_ascii=False))
    return 1 if report["failures"] else 0


if __name__ == "__main__":
    sys.exit(asyncio.run(main()))
