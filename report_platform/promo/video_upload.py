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
                """v3: 补填描述 (r4 取证: 可选字段全空+三键全灰禁用 —
                描述/贴图疑为就绪门; emitter 实证其流程显式填描述)."""
                if not text:
                    return
                for fr in self.page.frames:
                    for sel in ("textarea[placeholder*='描述']",
                                ".input-editor",
                                "textarea[placeholder*='介绍']"):
                        try:
                            loc = fr.locator(sel).first
                            if await loc.count() > 0 and await loc.is_visible():
                                cur = (await loc.input_value() or "").strip()
                                if not cur:
                                    await loc.fill(text)
                                    print(f"[vup] P3: 已补填描述 {len(text)}字 ✓")
                                    return
                        except Exception:
                            continue

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

            async def submit_video(self) -> bool:
                print("[vup] P3: 发表流程 (补丁v3: 描述补填+就绪轮询+真鼠标+toast时序)")
                await self._dismiss_dialogs()
                await self._scroll_all_bottom()
                await asyncio.sleep(1.5)
                # P-贴图闸 lite: 等 8s 让封面帧稳定 (emitter 实锤 上传完成≠贴图就绪)
                await asyncio.sleep(8)
                # v3-a: 补填描述 (r4 取证: 三键全灰=禁用态, 疑必填缺失)
                await self._fill_desc(getattr(self, "extra_desc", ""))
                # v3-b: 就绪轮询 — 键真亮才点, 不再硬点灰键 (r4 教训)
                ready, info = await self._wait_publish_ready()
                if not ready:
                    print(f"[vup] P3: {info} — 判失败 (不硬点灰键)")
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / "forensics_btn_disabled.png"),
                        full_page=True)
                    return False
                btn, sel = await self._publish_btn()
                # v3-c: 真鼠标点击 (emitter _iclick_el 同理: CDP Input 事件,
                # Vue handler 可能忽略无 isTrusted 的 DOM click)
                box = await btn.bounding_box()
                if box:
                    await self.page.mouse.click(
                        box["x"] + box["width"] / 2, box["y"] + box["height"] / 2)
                    print(f"[vup] P3: 已真鼠标点「发表」 ({sel})")
                else:
                    await btn.click(timeout=30000)
                    print(f"[vup] P3: 已DOM点「发表」 ({sel})")
                # v3-d: toast 时序取证 (r4 教训: +2s 单张截图错过易逝 toast)
                for tag, dt in (("t05", 0.5), ("t15", 1.0), ("t30", 1.5)):
                    await asyncio.sleep(dt)
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / f"forensics_{tag}.png"))
                # 确认弹窗 (主文档 weui dialog; r2 实锤文案不止两种)
                dlg = self.page.locator(".weui-desktop-dialog__wrp:visible")
                if await dlg.count() > 0:
                    txt = (await dlg.first.inner_text() or "")[:200]
                    print(f"[vup] P3 弹窗文本: {txt!r}")
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / "forensics_dialog.png"))
                    for t in ("确认发表", "确认发布", "确定", "确认", "知道了"):
                        cb = self.page.locator(
                            ".weui-desktop-dialog__wrp:visible"
                            f" button:has-text('{t}')")
                        if await cb.count() > 0:
                            await cb.first.click(timeout=10000)
                            print(f"[vup] P3: 已点弹窗按钮「{t}」✓")
                            await asyncio.sleep(3)
                            break
                else:
                    print("[vup] P3: 发表后无弹窗")
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / "forensics_after_click.png"))
                # 终验1: 成功文案 (帧感知)
                text = await self._frame_text()
                for kw in ("发表成功", "发布成功", "审核中", "已提交审核",
                           "提交审核", "内容已提交"):
                    if kw in text:
                        print(f"[vup] P3: 成功文案「{kw}」✓")
                        return True
                # 终验2: 发表管理列表 (FIX: 须扫 iframe — 列表正文在
                # micro/content/post/list 帧里, 主文档只有SPA壳)
                try:
                    await self.page.goto(
                        "https://channels.weixin.qq.com/platform/post/list",
                        timeout=30000, wait_until="domcontentloaded")
                    await asyncio.sleep(6)
                    body = await self._frame_text()
                    if self.title[:12] in body:
                        print("[vup] P3: 发表管理列表含标题前12字 ✓")
                        return True
                    await self.page.screenshot(
                        path=str(PROMO / "videos" / "forensics_list.png"))
                    print(f"[vup] P3: 列表未见标题 — 判失败 (不假绿). "
                          f"帧文尾300字: {body[-300:]!r}")
                except Exception as exc:
                    print(f"[vup] P3: 列表验证异常: {exc}")
                return False

        up = PatchedUploader(
            title=title,
            file_path=mp4,
            tags=tags,
            publish_date=None,          # 立即发表
            account_file=STATE_FILE,
            category=None,              # 跳过分类选择 (选择器脆, 内容默认即可)
            is_draft=False,
        )
        # v3: 补填描述文案 (emitter 实证其流程显式填描述; r4 疑其为锁键必填)
        up.extra_desc = " ".join(f"#{t}" for t in tags) + " 深度研报全文公众号可试读"
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
