# -*- coding: utf-8 -*-
"""video_upload — 视频号自主发布腿 v1 (F5b · 用户令「视频也是自己发布」).

复用 We-AIPO vendor tencent_uploader (Playwright 独立实例 + storage_state,
不碰其 9222 浏览器/锁 — 侦察实证 vendor 无在役调用方) + 从其 live channels
浏览器只读导出的登录态 (video_account_state.json).

防撞四件套 (账号安全红线全继承):
  ① We-AIPO RUNLOG 45min 内有视频发表记录 → 让路退出
  ② 自家锁 video_upload.lock (O_EXCL)
  ③ 自家日帽 1 条/日 (promo_ledger src=sph)
  ④ 失败/登录失效 → 退出上报, 绝不重试轰炸

用法 (必须用 We-AIPO venv python 跑 — playwright 在那边):
  E:/CPOPC/We-AIPO/.venv/Scripts/python.exe -X utf8 video_upload.py \
      --slug cnnec_v1 [--go]
默认 dry-run: 只做预检+参数打印.
"""
from __future__ import annotations

import argparse
import asyncio
import importlib.util
import io
import json
import re
import sys
import time
from pathlib import Path

sys.stdout = io.TextIOWrapper(
    sys.stdout.buffer, encoding="utf-8", errors="replace")

PROMO = Path(__file__).resolve().parent
STATE_FILE = PROMO / "video_account_state.json"
LOCK = PROMO / "video_upload.lock"
LEDGER = PROMO / "promo_ledger.jsonl"
VENDOR_ROOT = Path(r"E:\CPOPC\We-AIPO\src\vendor\video_autopub")
RUNLOG_DIR = Path(r"E:\CPOPC\We-AIPO\data\run_logs")
RUNLOG_RECHECK_MIN = 45          # We-AIPO 最近发表 → 让路窗口


def _recent_weaipo_video_publish_min() -> float | None:
    """扫最近两份 RUNLOG, 返回最近一次视频号发表距今分钟数 (无=None)."""
    logs = sorted(RUNLOG_DIR.glob("RUNLOG-*.md"))[-2:]
    best: float | None = None
    pat = re.compile(r"(\d{1,2}:\d{2})[^%\n]{0,80}(视频号|发表成功|发布成功)")
    now = time.localtime()
    now_m = now.tm_hour * 60 + now.tm_min
    for lg in logs:
        try:
            text = lg.read_text(encoding="utf-8", errors="ignore")
        except OSError:
            continue
        for line in text.splitlines():
            if ("视频" not in line and "发表" not in line and "发布" not in line):
                continue
            m = pat.search(line)
            if not m:
                continue
            hh, mm = int(m.group(1)[:2]), int(m.group(1)[3:5])
            # 同日近似: 早于当前时刻视为今天, 否则昨天
            t = hh * 60 + mm
            delta = now_m - t if t <= now_m else now_m - t + 1440
            if "视频" in line and (best is None or delta < best):
                best = delta
    return best


def _sph_count_today() -> int:
    today = time.strftime("%Y-%m-%d")
    n = 0
    if LEDGER.exists():
        for line in LEDGER.read_text(encoding="utf-8").splitlines():
            if line.strip():
                try:
                    r = json.loads(line)
                except json.JSONDecodeError:
                    continue
                if r.get("src") == "sph" and r.get("date") == today:
                    n += 1
    return n


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--slug", required=True, help="videos/<slug>.mp4 + .json")
    ap.add_argument("--go", action="store_true", help="真发布 (默认 dry-run)")
    ns = ap.parse_args()

    mp4 = PROMO / "videos" / f"{ns.slug}.mp4"
    meta_p = PROMO / "videos" / f"{ns.slug}.json"
    for p, what in ((mp4, "视频文件"), (meta_p, "meta"), (STATE_FILE, "登录态")):
        if not p.exists():
            print(f"[vup] 缺 {what}: {p}")
            return 1
    meta = json.loads(meta_p.read_text(encoding="utf-8"))
    title, tags = meta["title"], meta["tags"]

    # ---- 预检四件套 ----
    if _sph_count_today() >= 1:
        print("[vup] ③日帽: 今日已发 1 条 (sph 日帽=1) — 明天再来")
        return 1
    recent = _recent_weaipo_video_publish_min()
    if recent is not None and recent < RUNLOG_RECHECK_MIN:
        print(f"[vup] ①让路: We-AIPO {recent:.0f} 分钟内发过视频 — 退出")
        return 2
    if not ns.go:
        print(f"[vup] DRY-RUN: title={title!r} tags={tags} video={mp4.name} "
              f"({mp4.stat().st_size // 1024}KB) state=自导出 "
              f"(recent_weaipo={recent and int(recent)}min前)")
        print("      加 --go 真发布 (Playwright 独立 chromium, 有头 ~2-3min)")
        return 0

    # ---- 锁 ----
    try:
        fd = open(LOCK, "x")
        fd.write(str(time.time()))
        fd.close()
    except FileExistsError:
        print("[vup] ②锁: video_upload.lock 在 — 退出")
        return 2

    try:
        # ---- 加载 vendor uploader ----
        sys.path.insert(0, str(VENDOR_ROOT))
        mod_path = VENDOR_ROOT / "uploader" / "tencent_uploader" / "main.py"
        spec = importlib.util.spec_from_file_location("tencent_main", mod_path)
        mod = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(mod)

        class PatchedUploader(mod.TencentVideo):
            """v1-v3 金测四轮实锤的 vendor 补丁 (不改动 vendor 文件):

            P1 上传等待: 四探针全盲 600s (130KB 秒传但成功文案漂移) →
               emitter 实证探针「标题输入框可见=上传完成」+ 150s 上限.
            P2 声明原创: vendor `text:` 选择器语法错 (SyntaxError) → v1 跳过.
            P3 发表链 (r4 取证驱动): 弹窗清扫 → 滚底 → 贴图闸 8s →
               补填描述 → 「发表」键就绪轮询 (r4 实锤三键全灰=禁用态,
               DOM 硬点零效果) → 真鼠标 CDP 点击 (Vue isTrusted) →
               toast +0.5/+1.5/+3s 时序取证 → 确认弹窗 → 终验=成功文案
               ∨ 发表管理列表含标题前12字 — 未确认返回 False 绝不假绿.
            """

            async def wait_for_upload_complete(self) -> None:
                deadline = time.monotonic() + 150
                probes = ("textarea[placeholder*='标题']",
                          "input[placeholder*='标题']",
                          "input[placeholder*='好标题']")
                while time.monotonic() < deadline:
                    await asyncio.sleep(3)
                    try:
                        if await self.page.locator("text=上传成功").count() > 0:
                            print("[vup] P1: 上传成功文案 ✓")
                            return
                        for p in probes:
                            loc = self.page.locator(p)
                            if await loc.count() > 0 and await loc.first.is_visible():
                                print(f"[vup] P1: 标题框可见 → 上传完成 ({p[:30]})")
                                return
                        for kw in ("上传失败", "请重新上传", "格式不支持"):
                            if await self.page.locator(f"text={kw}").count() > 0:
                                print(f"[vup] P1: 失败信号「{kw}」")
                                return
                    except Exception as exc:
                        print(f"[vup] P1 探针异常(忽略): {exc}")
                print("[vup] P1: 150s 超时 — 继续填表尝试")

            async def declare_original(self) -> None:
                print("[vup] P2: 跳过声明原创 (vendor 选择器语法错, v1 不修)")

            async def _scroll_all_bottom(self) -> None:
                """emitter 同款: 主窗+全部滚动容器滚到底 (发表键在页尾)."""
                try:
                    await self.page.evaluate(
                        "window.scrollTo(0, 999999)")
                except Exception:
                    pass
                try:
                    await self.page.evaluate(
                        'document.querySelectorAll("*").forEach(e=>{'
                        "if(e.scrollHeight>e.clientHeight+50&&"
                        '(getComputedStyle(e).overflowY=="auto"||'
                        'getComputedStyle(e).overflowY=="scroll"))'
                        "e.scrollTop=e.scrollHeight})")
                except Exception:
                    pass

            async def _frame_text(self) -> str:
                """主文档+全部iframe正文合并 (成功文案/列表核验用)."""
                parts = []
                try:
                    parts.append(await self.page.inner_text("body"))
                except Exception:
                    pass
                for fr in self.page.frames:
                    try:
                        parts.append(await fr.evaluate(
                            "document.body?(document.body.innerText||''):''"))
                    except Exception:
                        continue
                return "\n".join(parts)

            async def _publish_btn(self):
                """v3: 定位精确「发表」键 (r4 实锤 button:text-is 命中)."""
                for s in ("button:text-is('发表')",
                          "[role=button]:text-is('发表')",
                          "div.weui-btn:text-is('发表')",
                          "a.weui-btn:text-is('发表')"):
                    try:
                        loc = self.page.locator(s)
                        if (await loc.count() > 0
                                and await loc.first.is_visible()):
                            return loc.first, s
                    except Exception:
                        continue
                return None, None

            async def _fill_desc(self, text: str) -> None:
                """v4 (1008 r7 取证: 发布页描述框是 contenteditable div,
                placeholder「添加描述」— v3 的 textarea 探针全空 → r7 描述
                空发, 疑风控贡献因素). 探针梯: 带描述 placeholder 的
                contenteditable → 任意可见 contenteditable (标题是 input,
                不会误中) → 老 textarea 兜底; 填后回读 innerText 验证,
                不符换下一探针, 绝不假绿."""
                if not text:
                    return
                for fr in self.page.frames:
                    for sel in (
                            "div[contenteditable='true']"
                            "[data-placeholder*='描述']",
                            "div[contenteditable='true']"
                            "[placeholder*='描述']",
                            "[contenteditable='true']"
                            "[aria-label*='描述']",
                            "div[contenteditable='true']",
                            ".input-editor",
                            "textarea[placeholder*='描述']"):
                        try:
                            loc = fr.locator(sel).first
                            if (await loc.count() == 0
                                    or not await loc.is_visible()):
                                continue
                            cur = (await loc.inner_text() or "").strip()
                            if cur:          # 已有内容, 不覆盖
                                continue
                            await loc.click(timeout=3000)
                            try:
                                await loc.fill(text)
                            except Exception:
                                await self.page.keyboard.type(text)
                            await asyncio.sleep(0.5)
                            got = (await loc.inner_text() or "").strip()
                            if text[:8] in got:
                                print(f"[vup] P3: 已补填描述 {len(text)}字 ✓ "
                                      f"({sel[:44]})")
                                return
                            print(f"[vup] P3: {sel[:44]} 回读不符 "
                                  f"({got[:20]!r}) — 换下探针")
                        except Exception:
                            continue
                print("[vup] P3: 描述框探针梯全空 — 未填上 (如实上报)")

            async def _wait_publish_ready(
                    self, timeout_s: float = 90) -> tuple[bool, str]:
                """v3: 轮询发表键就绪再点 (r4 取证实锤: 存草稿/预览/发表
                三键全灰=禁用态, DOM click 落空且无任何报错 — 静默锁键).

                就绪 = 原生 enabled ∧ aria-disabled≠true ∧ class 不含 disable.
                禁用根因 (按概率): 封面贴图未就绪 / 转码未完成 / 必填缺描述.
                """
                t0 = time.monotonic()
                while time.monotonic() - t0 < timeout_s:
                    btn, sel = await self._publish_btn()
                    if btn is None:
                        return False, "定位不到「发表」键"
                    try:
                        enabled = await btn.is_enabled()
                        st = await btn.evaluate(
                            "el=>((el.getAttribute('aria-disabled')||'')"
                            "+'|'+(el.className||'')).toLowerCase()")
                        aria, _, cls = st.partition("|")
                        if (enabled and aria != "true"
                                and "disable" not in cls):
                            return True, sel
                        print(f"[vup] P3: 发表键未就绪 (enabled={enabled} "
                              f"aria={aria!r} cls含disable="
                              f"{'disable' in cls}) — 5s后再探")
                    except Exception as exc:
                        print(f"[vup] P3: 状态探针异常(忽略): {exc}")
                    await asyncio.sleep(5)
                return False, (f"{timeout_s:.0f}s 内发表键未就绪 "
                               "(疑封面贴图/转码未完成或必填缺失)")

            async def _dismiss_dialogs(self) -> None:
                for _ in range(3):
                    dlg = self.page.locator(".weui-desktop-dialog__wrp:visible")
                    if await dlg.count() == 0:
                        return
                    btn = self.page.locator(
                        ".weui-desktop-dialog__wrp:visible button:has-text('确定'),"
                        ".weui-desktop-dialog__wrp:visible button:has-text('知道了'),"
                        ".weui-desktop-dialog__wrp:visible button:has-text('确认'),"
                        ".weui-desktop-dialog__wrp:visible button:has-text('取消')")
                    try:
                        if await btn.count() > 0:
                            await btn.first.click(timeout=5000)
                            print("[vup] P3: 关闭拦路弹窗 ✓")
                        else:
                            await self.page.keyboard.press("Escape")
                            print("[vup] P3: Escape 关闭弹窗")
                    except Exception:
                        await self.page.keyboard.press("Escape")
                    await asyncio.sleep(1)

            async def _rmouse_click(self, loc) -> bool:
                """真鼠标点击 (emitter _iclick_el 移植: CDP Input 事件;
                Vue handler 不认无 isTrusted 的 DOM click. Playwright 的
                page.mouse 即 CDP Input.dispatchMouseEvent, 且 bounding_box
                已含 iframe 偏移, 与 _iclick_el 的 oX/oY 补偿等价)."""
                try:
                    await loc.scroll_into_view_if_needed(timeout=4000)
                except Exception:
                    pass
                try:
                    bb = await loc.bounding_box()
                except Exception:
                    bb = None
                if bb and bb["width"] > 0 and bb["height"] > 0:
                    await self.page.mouse.click(
                        bb["x"] + bb["width"] / 2, bb["y"] + bb["height"] / 2)
                    print(f"[vup] P3: 真鼠标点击 @{bb['x']:.0f},{bb['y']:.0f}")
                    return True
                try:
                    await loc.click(timeout=5000, force=True)
                    return True
                except Exception:
                    return False

            async def _click_frame_button(self, text: str) -> bool:
                """emitter _click_frame_button 移植: 遍历主文档+全部iframe,
                button 优先 (避免SPAN误点) → btn类 div/a/[role=button]/
                .weui-btn 兜底, 文字含匹配 → 真鼠标点击."""
                for fr in self.page.frames:
                    try:
                        els = fr.locator("button")
                        for i in range(await els.count()):
                            el = els.nth(i)
                            try:
                                if text in ((await el.inner_text()) or "").strip():
                                    if await self._rmouse_click(el):
                                        return True
                            except Exception:
                                continue
                    except Exception:
                        continue
                for fr in self.page.frames:
                    for sel in ("div[class*='btn']", "div[class*='submit']",
                                "a[class*='btn']", "[role='button']",
                                ".weui-btn"):
                        try:
                            els = fr.locator(sel)
                            for i in range(await els.count()):
                                el = els.nth(i)
                                try:
                                    if text in ((await el.inner_text())
                                                or "").strip():
                                        if await self._rmouse_click(el):
                                            return True
                                except Exception:
                                    continue
                        except Exception:
                            continue
                return False

            async def _declare_original_pre(self) -> None:
                """v5 (emitter 法移植): 声明原创在点「发表」之前 — 表单区
                checkbox 流: .declare-original-checkbox → 勾「我已阅读」→
                点「声明原创」按钮. 找不到 checkbox 整块跳过 (emitter 同款).
                先声明后发表, 点「发表」后就不会撞「广告分成挽留弹窗」的
                歧义双键 (r9-r12 五轮取证的主障碍)."""
                await self._scroll_all_bottom()
                await asyncio.sleep(1.5)
                loc = self.page.locator(".declare-original-checkbox").first
                if await loc.count() == 0:
                    print("[vup] P3: 无 .declare-original-checkbox — 跳过预声明")
                    return
                if not await self._rmouse_click(loc):
                    print("[vup] P3: 预声明 checkbox 点击失败 — 跳过")
                    return
                await asyncio.sleep(2)
                for sel in (".original-proto-wrapper .ant-checkbox-input",
                            ".original-proto-wrapper .ant-checkbox-wrapper",
                            ".original-proto-wrapper input[type=checkbox]",
                            ".original-proto-wrapper"):
                    c = self.page.locator(sel).first
                    if await c.count() > 0 and await self._rmouse_click(c):
                        break
                await asyncio.sleep(1.5)
                if await self._click_frame_button("声明原创"):
                    print("[vup] P3: 预声明原创完成 ✓ (emitter 法: 发表前)")
                await asyncio.sleep(2)

            async def submit_video(self) -> bool:
                print("[vup] P3: 发表流程 (v5=We-AIPO emitter 法移植)")
                # v5-0 (用户令1008「借鉴We-AIPO方法」核心件): JS alert/confirm
                # 自动 accept. Playwright 默认 dismiss 未处理弹窗 = confirm()
                # 被按「取消」= 发表被平台静默取消 (r9-r12: 弹窗点掉了但视频
                # 从未上架的头号嫌疑). 等价 emitter 的
                # Page.handleJavaScriptDialog(accept=True)+auto_handle_alert.
                def _on_dialog(d):
                    print(f"[vup] P3: JS原生弹窗({d.type})→accept: "
                          f"{(d.message or '')[:80]!r}")
                    asyncio.ensure_future(d.accept())
                self.page.on("dialog", _on_dialog)

                await self._dismiss_dialogs()
                await self._scroll_all_bottom()
                await asyncio.sleep(1.5)
                # P-贴图闸 lite: 等 8s 让封面帧稳定 (emitter 实锤 上传完成≠贴图就绪)
                await asyncio.sleep(8)
                # v3-a: 补填描述 (r7 取证: 发布页描述框是 contenteditable div)
                await self._fill_desc(getattr(self, "extra_desc", ""))
                # v3-b: 就绪轮询 — 键真亮才点, 不硬点灰键 (r4 教训)
                ready, info = await self._wait_publish_ready()
                if not ready:
                    print(f"[vup] P3: {info} — 判失败 (不硬点灰键)")
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / "forensics_btn_disabled.png"),
                        full_page=True)
                    return False
                # v5-1 (emitter 法): 声明原创在点「发表」之前
                await self._declare_original_pre()
                ready2, _ = await self._wait_publish_ready(timeout_s=30)
                if not ready2:
                    print("[vup] P3: 预声明后发表键未就绪 — 仍按 emitter 法点击")
                # v5-2 (emitter 法): 滚底 → 帧遍历找「发表」键真鼠标点击
                print("[vup] P3: 发表", flush=True)
                await self._scroll_all_bottom()
                await asyncio.sleep(1.5)
                if not await self._click_frame_button("发表"):
                    btn, sel = await self._publish_btn()
                    if btn is None:
                        print("[vup] P3: 定位不到「发表」键 — 判失败")
                        return False
                    # v4 (r8): 填描述后页尾键被推出视口 → 滚入+真鼠标
                    await btn.scroll_into_view_if_needed(timeout=8000)
                    await asyncio.sleep(0.5)
                    box = await btn.bounding_box()
                    if box:
                        await self.page.mouse.click(
                            box["x"] + box["width"] / 2,
                            box["y"] + box["height"] / 2)
                        print(f"[vup] P3: 已真鼠标点「发表」({sel}) "
                              f"@y={box['y']:.0f}")
                    else:
                        await btn.click(timeout=30000)
                await asyncio.sleep(2)
                # v3-d: toast 时序取证 (r4 教训: +2s 单张截图错过易逝 toast)
                for tag, dt in (("t05", 0.5), ("t15", 1.0), ("t30", 1.5)):
                    await asyncio.sleep(dt)
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / f"forensics_{tag}.png"))
                # v5-3 (emitter 法): 发表后立即试「确认发表」二次确认
                _confirm_clicked = False
                for t in ("确认发表", "确认发布"):
                    if await self._click_frame_button(t):
                        print(f"[vup] P3: ✓点确认弹窗「{t}」")
                        _confirm_clicked = True
                        await asyncio.sleep(2)
                        break
                # v5-4 (emitter 法): 30×2s 帧轮询验证 — URL跳转/成功文案/
                # 失败文案 + weui弹窗清扫(声明原创挽留弹窗) + 延迟确认弹窗
                _SUCCESS_KW = ("发布成功", "已发布", "提交成功", "发表成功",
                               "内容已提交", "审核中", "已提交审核", "提交审核")
                _FAIL_KW = ("上传失败", "格式不支持", "发布失败", "内容违规",
                            "请重新上传", "视频处理失败", "审核未通过",
                            "文件过大", "超过限制")
                confirmed, fail_reason = False, None
                for i in range(30):
                    await asyncio.sleep(2)
                    try:
                        url = self.page.url or ""
                        if any(k in url for k in ("manage/video",
                                                  "manage/content",
                                                  "post/list")):
                            confirmed = True
                            print(f"[vup] P3: ✓确认 URL跳转 ({url[:60]})")
                            break
                        body = await self._frame_text()
                        hit = next((k for k in _SUCCESS_KW if k in body), None)
                        if hit:
                            confirmed = True
                            print(f"[vup] P3: ✓确认 页面文字({hit})")
                            break
                        fail_hit = next((k for k in _FAIL_KW if k in body), None)
                        if fail_hit:
                            fail_reason = fail_hit
                            break
                        # weui 弹窗清扫 (r9-r12 常客: 广告分成挽留弹窗;
                        # r11 取证=两独立键, r12 实锤真鼠标点「直接发表」可关)
                        dlg = self.page.locator(
                            ".weui-desktop-dialog__wrp:visible")
                        if await dlg.count() > 0:
                            txt = (await dlg.first.inner_text() or "")[:150]
                            print(f"[vup] P3 弹窗文本: {txt!r}")
                            await self.page.screenshot(path=str(
                                PROMO / "videos" / f"forensics_dialog{i}.png"))
                            if await self._click_frame_button("直接发表"):
                                print("[vup] P3: ✓weui弹窗点「直接发表」")
                                await asyncio.sleep(2)
                        # 延迟确认弹窗 (只试一次, emitter 同款)
                        if not _confirm_clicked and i >= 2:
                            for t in ("确认发表", "确认发布"):
                                if await self._click_frame_button(t):
                                    print(f"[vup] P3: ✓延迟确认弹窗「{t}」")
                                    _confirm_clicked = True
                                    await asyncio.sleep(2)
                                    break
                    except Exception as exc:
                        print(f"[vup] P3: 轮询探针异常(忽略): {exc}")
                if fail_reason:
                    print(f"[vup] P3: ✗平台拒绝: {fail_reason}")
                    await self.page.screenshot(path=str(
                        PROMO / "videos" / "forensics_rejected.png"))
                    return False
                if not confirmed:
                    # FIX-0827b 法 (emitter) + 1008 根因修正: 列表行的
                    # .post-title 渲染的是**描述**不是标题 (r12 误判→r13
                    # 重复发布的根因) → 判定键改用描述前12字, 标题兜底.
                    try:
                        await self.page.goto(
                            "https://channels.weixin.qq.com/platform/post/list",
                            timeout=30000, wait_until="domcontentloaded")
                        await asyncio.sleep(6)
                        body = await self._frame_text()
                        key = (getattr(self, "extra_desc", "")
                               or self.title).strip()[:12]
                        if key and key in body:
                            print(f"[vup] P3: ✓确认 列表核验命中"
                                  f"(desc键「{key}」)")
                            confirmed = True
                        else:
                            await self.page.screenshot(path=str(
                                PROMO / "videos" / "forensics_list.png"))
                            print(f"[vup] P3: 列表未见desc键「{key}」— "
                                  f"判失败 (不假绿). "
                                  f"帧文尾300字: {body[-300:]!r}")
                    except Exception as exc:
                        print(f"[vup] P3: 列表验证异常: {exc}")
                return confirmed

        up = PatchedUploader(
            title=title,
            file_path=mp4,
            tags=tags,
            publish_date=None,          # 立即发表
            account_file=STATE_FILE,
            category=None,              # 跳过分类选择 (选择器脆, 内容默认即可)
            is_draft=False,
        )
        # v3: 描述文案 — 1008用户令「视频描述可以长一点」: 长文案住 desc,
        # 短标题只留钩子 (r6实锤: 超字数=发表键锁灰)
        desc = meta.get("desc", "").strip()
        up.extra_desc = (desc + " " if desc else "") + \
            " ".join(f"#{t}" for t in tags)
        ok = asyncio.run(up.main())
        print(f"[vup] main() -> {'成功' if ok else '失败'}: {title[:40]}")
        if ok:
            with LEDGER.open("a", encoding="utf-8") as f:
                f.write(json.dumps({
                    "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
                    "ts_epoch": int(time.time()),
                    "date": time.strftime("%Y-%m-%d"),
                    "title": title,
                    "title_hash": __import__("hashlib").sha1(
                        title.encode("utf-8")).hexdigest()[:12],
                    "account": "视频号",
                    "sku": "", "src": "sph", "media_id": ns.slug,
                }, ensure_ascii=False) + "\n")
            print("[vup] 过账 promo_ledger (src=sph)")
        return 0 if ok else 1
    finally:
        try:
            LOCK.unlink()
        except OSError:
            pass


if __name__ == "__main__":
    sys.exit(main())
