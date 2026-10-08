# -*- coding: utf-8 -*-
"""video_verify — 只读核验: 视频号发表管理列表是否已含指定标题.

零发表动作 (只开浏览器看列表 — emitter FIX-0827b 同款判据:
题名前12字命中即真, 且必须扫 iframe — 列表正文在 frame 里,
主页面 inner_text 只能拿到 SPA 壳 '视频号 · 助手').

用法 (We-AIPO venv python, playwright 在那边):
  E:/CPOPC/We-AIPO/.venv/Scripts/python.exe -X utf8 promo/video_verify.py \
      --key "设计+施工合并了，为什么"   (描述前缀, 1008 实锤列表只渲染描述)
  或 --title "标题" (兼容旧用法, 但标题不出现在列表 — 会永远 miss)
退出码: 0=已发布命中 1=未命中 2=登录态失效

1008 根因实锤: 发表管理列表行的 .post-title 渲染的是视频**描述**文案,
不是发布页的标题 → 按标题前12字搜索永远 miss → r12 误判失败 → r13
重复发布. 判定键一律用描述前缀 (--key).
"""
from __future__ import annotations

import argparse
import asyncio
import importlib.util
import io
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
PROMO = Path(__file__).resolve().parent
STATE_FILE = PROMO / "video_account_state.json"
VENDOR_ROOT = Path(r"E:\CPOPC\We-AIPO\src\vendor\video_autopub")
LIST_URL = "https://channels.weixin.qq.com/platform/post/list"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--key", help="列表判定键 (描述前缀, 优先)")
    ap.add_argument("--title", help="标题 (兼容旧参数; 列表不渲染标题)")
    ns = ap.parse_args()
    if not ns.key and not ns.title:
        ap.error("--key (描述前缀) 或 --title 至少给一个")
    key = (ns.key or ns.title).strip()[:12]

    sys.path.insert(0, str(VENDOR_ROOT))
    mod_path = VENDOR_ROOT / "uploader" / "tencent_uploader" / "main.py"
    spec = importlib.util.spec_from_file_location("tencent_main", mod_path)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)

    mp4 = PROMO / "videos" / "cnnec_v1.mp4"   # 仅占位, 不调用上传

    async def run() -> int:
        up = mod.TencentVideo(
            title=ns.title, file_path=mp4, tags=["EPC"],
            publish_date=None, account_file=STATE_FILE,
            category=None, is_draft=False)
        await up.init_browser()
        try:
            await up.page.goto(LIST_URL, timeout=30000,
                               wait_until="domcontentloaded")
            await asyncio.sleep(6)
            # 登录自检 (vendor main() 同款判据: 跳登录页/出二维码 = 失效)
            if ("login" in up.page.url
                    or await up.page.locator(".login-qrcode").count() > 0):
                print(f"[verify] 登录态失效 (url={up.page.url[:60]}) — 须重新导出")
                return 2
            shot = PROMO / "videos" / "verify_list.png"
            try:
                await up.page.screenshot(path=str(shot), full_page=False)
                print(f"[verify] 截图: {shot.name}")
            except Exception as _se:
                print(f"[verify] 截图失败(忽略): {_se}")
            hit_frames: list[str] = []
            for fr in up.page.frames:
                try:
                    body = await fr.evaluate(
                        "document.body ? (document.body.innerText||'') : ''")
                except Exception:
                    continue
                if key in (body or ""):
                    hit_frames.append(fr.url[:80] or "(about:blank iframe)")
                    for line in (body or "").splitlines():
                        if key in line:
                            print(f"[verify] 命中行: {line.strip()[:80]}")
                            break
            if hit_frames:
                print(f"[verify] ✓ 列表已含「{key}…」 frames={hit_frames}")
                return 0
            # 兜底取证: 各帧体尾摘要, 便于诊断列表是否根本没渲染
            for fr in up.page.frames:
                try:
                    body = await fr.evaluate(
                        "document.body ? (document.body.innerText||'') : ''")
                except Exception:
                    continue
                tail = (body or "").strip()[-160:].replace("\n", "␤")
                print(f"[verify] 帧尾 ({(fr.url or 'blank')[:60]}): {tail!r}")
            print(f"[verify] ✗ 未命中「{key}…」(共扫 {len(up.page.frames)} 帧)")
            return 1
        finally:
            await up.close_browser()

    return asyncio.run(run())


if __name__ == "__main__":
    sys.exit(main())
