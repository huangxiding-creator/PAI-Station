"""7×24 主循环（M6 总装 + M10 深读）：每分钟 daily_tick + 在场探测。

用法：python tools/run_station.py（PAI_INI 可指配置，默认 config/pai.ini）
每分钟一拍：增量补扫 → 深读状态机（00:00-05:00 窗口内提醒/会话）→
在场探测刷新（让路红线）→ PDCA 复盘（pdca_time 后当日一次）。
Ctrl-C 优雅停机（stop + close）。
"""
import logging
import os
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "src"))

from paistation import config as cfg_mod          # noqa: E402
from paistation.runtime import Runtime            # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def main() -> int:
    logging.basicConfig(level=logging.INFO,
                        format="%(asctime)s %(levelname)s %(name)s %(message)s")
    ini = os.environ.get("PAI_INI") or os.path.join(ROOT, "config", "pai.ini")
    cfg = cfg_mod.load(ini)
    rt = Runtime.from_config(cfg, station_root=ROOT)
    rt.start()
    logging.getLogger("station").info(
        "PAI-Station 主循环启动：watch=%s data=%s", cfg["sense"]["watch_dirs"],
        cfg["privacy"]["data_dir"])
    try:
        while True:
            rt.refresh_presence()
            rt.daily_tick()
            time.sleep(60)
    except KeyboardInterrupt:
        logging.getLogger("station").info("收到停机信号，优雅退出")
    finally:
        rt.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
