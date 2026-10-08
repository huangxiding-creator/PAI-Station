# -*- coding: utf-8 -*-
"""_probe_list_today — 只读探测: 发表管理列表里今天(2026-10-08)的全部条目.

背景: r12/r13 实际都发布成功 (列表 09:26/09:31 两条同文案), 但 video_verify
按标题搜索 — 列表渲染的是描述文案 → 永远查不到 → r12 误判失败 → r13 重复
发布. 本脚本按日期行dump今天全部条目上下文, 供去重决策. 零写入零删除.
"""
from __future__ import annotations

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

sys.path.insert(0, str(VENDOR_ROOT))
mod_path = VENDOR_ROOT / "uploader" / "tencent_uploader" / "main.py"
spec = importlib.util.spec_from_file_location("tencent_main", mod_path)
mod = importlib.util.module_from_spec(spec)
spec.loader.exec_module(mod)


async def run() -> int:
    up = mod.TencentVideo(
        title="probe", file_path=PROMO / "videos" / "cnnec_v1.mp4",
        tags=["EPC"], publish_date=None, account_file=STATE_FILE,
        category=None, is_draft=False)
    await up.init_browser()
    try:
        await up.page.goto(LIST_URL, timeout=30000, wait_until="domcontentloaded")
        await asyncio.sleep(6)
        for fr in up.page.frames:
            try:
                body = await fr.evaluate(
                    "document.body ? (document.body.innerText||'') : ''")
            except Exception:
                continue
            lines = (body or "").splitlines()
            dates = [ln for ln in lines if "2026年" in ln]
            if not dates:
                continue
            print(f"== 帧 {(fr.url or 'blank')[:70]} ==")
            for idx, ln in enumerate(lines):
                if "2026年10月08日" in ln:
                    ctx = lines[max(0, idx - 4):idx + 4]
                    print("--- 今日条目 @行{} ---".format(idx))
                    for c in ctx:
                        print("   ", c.strip()[:110])
            print("== 该帧前10个日期行 ==")
            for d in dates[:10]:
                print("   ", d.strip()[:70])
        await up.page.screenshot(path=str(PROMO / "videos" / "probe_list.png"))
        print("[probe] 截图 probe_list.png")
        return 0
    finally:
        await up.close_browser()


if __name__ == "__main__":
    sys.exit(asyncio.run(run()))
