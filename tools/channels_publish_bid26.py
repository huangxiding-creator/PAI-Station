# -*- coding: utf-8 -*-
"""channels_publish_bid26 — 视频号发布·We-AIPO publish_one 复刻 + 本仓元数据.

复刻 F:/We-AIPO/scripts/publish_videos_now.py 的 publish_one (9222 挂载/
video input 上传/标题描述填写/发表确认/验证) — 标题与描述取本仓
promo/videos/<slug>.json (真数字元数据), 防封间隔 120s。

用法: F:/We-AIPO/.venv/Scripts/python.exe tools/channels_publish_bid26.py \
        --slug bid26_v3_h3 [--slug bid26_v1_am ...] [--dry]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import Chromium                    # noqa: E402
from DrissionPage.common import Settings             # noqa: E402

Settings.auto_handle_alert = True
PROMO = Path(__file__).resolve().parents[1] / "report_platform" / "promo"
VIDEOS = PROMO / "videos"
CREATE_URL = "https://channels.weixin.qq.com/platform/post/create"


def log(m):
    print(f"[{time.strftime('%H:%M:%S')}] {m}", flush=True)


def click_frame_button(tab, text):
    for target in [tab] + tab.get_frames():
        try:
            btn = target.ele(f"text:{text}", timeout=1)
            if btn:
                try:
                    btn.click()
                except Exception:
                    btn.click(by_js=True)
                return True
        except Exception:
            pass
    return False


def fill_field(tab, selectors, value, field_name):
    for s in selectors:
        try:
            el = tab.ele(s, timeout=2)
            if el:
                el.click()
                time.sleep(0.3)
                el.input(value)
                log(f"  {field_name}: {value[:30]}")
                return True
        except Exception:
            pass
    log(f"  ⚠ {field_name} 未找到控件")
    return False


def publish_one(tab, video_path: Path, title: str, desc: str) -> bool:
    """复刻 publish_videos_now.publish_one (9222 真机验证形态)."""
    try:
        log("导航发布页…")
        tab.get(CREATE_URL, timeout=20)
        time.sleep(6)
        log("上传视频…")
        for s in ('css:input[type=file][accept*="video"]', "css:input[type=file]"):
            try:
                fi = tab.ele(s, timeout=4)
                if fi:
                    fi.input(str(video_path))
                    break
            except Exception:
                continue
        log("等待上传完成…")
        for i in range(36):
            time.sleep(5)
            for fr in tab.get_frames():
                try:
                    body = fr.run_js('return document.body.innerText||""') or ""
                    if any(kw in body for kw in ("上传失败", "格式不支持", "文件过大")):
                        log("  ✗ 上传失败")
                        return False
                except Exception:
                    pass
            try:
                if tab.ele('css:input[placeholder*="标题"]', timeout=1) or \
                   tab.ele('css:textarea[placeholder*="标题"]', timeout=1):
                    log(f"  ✅ 上传完成 ({i*5}s)")
                    break
            except Exception:
                pass
            if i % 6 == 5:
                log(f"  上传中… ({(i+1)*5}s)")
        else:
            log("  ✗ 上传超时")
            return False
        fill_field(tab, ['css:textarea[placeholder*="标题"]',
                         'css:input[placeholder*="标题"]',
                         'css:input[placeholder*="好标题"]'], title, "标题")
        fill_field(tab, ['css:.input-editor',
                         'css:[contenteditable=true]',
                         'css:textarea[placeholder*="描述"]'], desc, "描述")
        time.sleep(2)
        for fr in [tab] + tab.get_frames():
            try:
                fr.run_js("window.scrollTo(0, document.body.scrollHeight)")
            except Exception:
                pass
        time.sleep(1.5)
        if click_frame_button(tab, "发表"):
            log("点击发表")
        else:
            log("⚠ 未找到发表按钮")
            return False
        time.sleep(3)
        for ct in ("确认发表", "确认发布"):
            if click_frame_button(tab, ct):
                log(f"确认: {ct}")
                time.sleep(2)
                break
        time.sleep(15)
        log("✅ 发表流程完成")
        return True
    except Exception as e:
        log(f"✗ 异常: {str(e)[:100]}")
        return False


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--slug", action="append", required=True)
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    b = Chromium("127.0.0.1:9222")
    tab = b.latest_tab
    tab.get("https://channels.weixin.qq.com/platform/", timeout=15)
    time.sleep(5)
    if "/login" in (tab.url or ""):
        log("❌ 未登录 (先跑 tools/channels_login_weaipo.py)")
        return 2
    log("✅ 已登录视频号助手")
    n_ok = 0
    for k, slug in enumerate(ns.slug):
        meta = json.loads((VIDEOS / f"{slug}.json").read_text(encoding="utf-8"))
        mp4 = VIDEOS / f"{slug}.mp4"
        title = meta.get("title", slug)[:30]
        desc = meta.get("desc", "")
        log(f"[{k+1}/{len(ns.slug)}] {slug}: {title}")
        if ns.dry:
            log(f"  dry: mp4={mp4.name} ({mp4.stat().st_size//1024}KB) desc={desc[:24]}")
            n_ok += 1
            continue
        n_ok += publish_one(tab, mp4, title, desc)
        if k < len(ns.slug) - 1:
            log("防封间隔 120s…")
            time.sleep(120)
    print(f"[pub] 完成 {n_ok}/{len(ns.slug)}")
    return 0 if n_ok == len(ns.slug) else 1


if __name__ == "__main__":
    raise SystemExit(main())
