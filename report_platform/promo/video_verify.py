# -*- coding: utf-8 -*-
"""video_verify — 只读核验: 视频号发表管理列表是否已含指定标题.

零发表动作 (只开浏览器看列表 — emitter FIX-0827b 同款判据:
题名前12字命中即真, 且必须扫 iframe — 列表正文在 frame 里,
主页面 inner_text 只能拿到 SPA 壳 '视频号 · 助手').

用法 (We-AIPO venv python, playwright 在那边):
  E:/CPOPC/We-AIPO/.venv/Scripts/python.exe -X utf8 promo/video_verify.py \
      --title "全国唯一能总承包整座核电站的公司，凭什么？"
退出码: 0=已发布命中 1=未命中 2=登录态失效
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
    ap.add_argument("--title", required=True, help="完整标题 (取前12字命中)")
    ns = ap.parse_args()
    key = ns.title.strip()[:12]

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
