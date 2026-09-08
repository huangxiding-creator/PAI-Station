"""mss 截图 + 黑名单窗口过滤 + 滚动缓冲（提案 4.3 感知层）。

黑名单命中（窗口标题关键词）→ 完全跳过（不落盘任何像素）；
滚动缓冲自动清理超期文件（默认 10 分钟窗口）。
截图失败静默（无显示器/会话锁定）——感知缺席不崩。
"""
import os
import time


def mss_capture() -> bytes:
    """mss 主显示器截图 → PNG bytes。"""
    import mss  # 延迟导入：服务环境可能无显示

    with mss.mss() as sct:
        shot = sct.grab(sct.monitors[1])
        from mss.tools import to_png
        return to_png(shot.rgb, shot.size)


class ScreenMonitor:
    """周期截图器：interval 节流 + 黑名单 + 滚动缓冲。capture/fg 可注入。"""

    def __init__(self, interval_sec: int, blacklist: tuple,
                 buffer_dir: str, *, now_fn=time.time, capture_fn=mss_capture,
                 fg_fn=None):
        self._interval = interval_sec
        self._blacklist = tuple(k.lower() for k in blacklist)
        self._dir = buffer_dir
        self._now = now_fn
        self._capture = capture_fn
        self._fg = fg_fn
        self._last_shot = 0.0
        os.makedirs(self._dir, exist_ok=True)

    def _blacklisted(self) -> bool:
        if not self._fg or not self._blacklist:
            return False
        try:
            title = (self._fg().get("title") or "").lower()
        except Exception:
            return False
        return any(k in title for k in self._blacklist)

    def tick(self) -> str | None:
        """单步：间隔未到/黑名单/失败 → None；成功返回落盘路径。"""
        now = self._now()
        if now - self._last_shot < self._interval:
            return None
        if self._blacklisted():
            return None
        try:
            data = self._capture()
        except Exception:
            return None
        self._last_shot = now
        path = os.path.join(self._dir, f"screen_{int(now * 1000)}.png")
        try:
            with open(path, "wb") as fh:
                fh.write(data)
        except OSError:
            return None
        self._evict(now)
        return path

    def _evict(self, now: float) -> None:
        """滚动缓冲：删除超过 interval*3（下限 600s）的旧截图。"""
        window = max(self._interval * 3, 600)
        try:
            names = os.listdir(self._dir)
        except OSError:
            return
        for name in names:
            if not name.startswith("screen_") or not name.endswith(".png"):
                continue
            try:
                ts = int(name[7:-4]) / 1000.0
            except ValueError:
                continue
            if now - ts > window:
                try:
                    os.remove(os.path.join(self._dir, name))
                except OSError:
                    pass
