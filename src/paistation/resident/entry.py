"""M1 总装入口：python -m paistation.resident.entry daemon|tray。

看护器重拉命令的落点（watchdog.main 里引用）。daemon=主控进程；
tray=托盘壳（独立进程，纯客户端）。模型按在位情况装配，缺件自动
降级（降级矩阵）——首启后置下载由 M6 分发器补齐。
"""
from __future__ import annotations

import argparse
import logging
import os
import sys

_log = logging.getLogger("paistation.resident.entry")


def default_data_dir() -> str:
    env = os.environ.get("PAI_STATION_DATA_DIR")
    if env:
        return env
    return os.path.join(os.path.expandvars(r"%APPDATA%"), "PAI-Station")


def build_daemon(data_dir: str, with_mic: bool = False,
                 with_loopback: bool = False, tick_interval: float = 30.0):
    """按在位模型装配感知管线+主控（缺件降级不阻塞）。"""
    from paistation.resident.daemon import Daemon
    from paistation.resident.ipc import load_or_create_authkey
    from paistation.intent.service import IntentService
    from paistation.sense.asr import ModelManager
    from paistation.sense.pipeline import VoicePipeline
    from paistation.sense.signal_service import SignalService
    from paistation.sense.voice_events import EventStream

    os.makedirs(data_dir, exist_ok=True)
    authkey = load_or_create_authkey(data_dir)
    stream = EventStream(data_dir=data_dir)

    silero = None
    for root in ("models", os.path.join(data_dir, "models")):
        cand = os.path.join(root, "silero_vad.onnx")
        if os.path.exists(cand):
            silero = cand
            break
    model_dir = ModelManager(roots=("models",
                                    os.path.join(data_dir, "models"))
                             ).sensevoice_path()
    pipeline = VoicePipeline(stream=stream, vad_model=silero,
                             model_dir=model_dir, mic=with_mic,
                             loopback=with_loopback)
    signals = SignalService(stream=stream)
    # M8 意图常驻件：默认 L1 口径（无 profile/网关配置时安全降级，
    # 读当日事件流增量提取意图）
    intents = IntentService(stream=stream)
    # M9 云感知：三连接器注册+授权持久化回灌（默认 opt-in 全关，
    # 未授权 tick 零调用）；wih 产物目录约定 data_dir/wih/
    from paistation.sense.cloud.base import ConnectorRegistry, WatermarkStore
    from paistation.sense.cloud.grants import GrantsStore
    from paistation.sense.cloud.service import CloudSensingService
    from paistation.sense.cloud.tencent import TencentMeetingConnector
    from paistation.sense.cloud.bdpan import BaiduDriveConnector
    from paistation.sense.cloud.wih import WeChatIntelConnector
    registry = ConnectorRegistry()
    for conn in (TencentMeetingConnector(),
                 BaiduDriveConnector(),
                 WeChatIntelConnector(
                     out_dir=os.path.join(data_dir, "wih"))):
        registry.register(conn)
    GrantsStore(os.path.join(data_dir, "cloud_grants.json")).load_into(registry)
    cloud = CloudSensingService(
        stream=stream, registry=registry,
        watermarks=WatermarkStore(os.path.join(data_dir, "cloud_watermarks.json")))
    return Daemon(data_dir=data_dir, services=[pipeline, signals, intents, cloud],
                  pipe_name="pai-station", authkey=authkey,
                  tick_interval=tick_interval)


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="paistation.resident.entry")
    sub = parser.add_subparsers(dest="cmd", required=True)

    p_daemon = sub.add_parser("daemon", help="主控进程")
    p_daemon.add_argument("--data-dir", default=default_data_dir())
    p_daemon.add_argument("--with-mic", action="store_true")
    p_daemon.add_argument("--with-loopback", action="store_true")

    p_tray = sub.add_parser("tray", help="托盘壳（纯客户端）")
    p_tray.add_argument("--data-dir", default=default_data_dir())

    args = parser.parse_args(argv)
    logging.basicConfig(level=logging.INFO,
                        format="%(asctime)s %(levelname)s %(name)s %(message)s")

    if args.cmd == "daemon":
        daemon = build_daemon(args.data_dir, with_mic=args.with_mic,
                              with_loopback=args.with_loopback)
        daemon.run()  # 前台常驻（Mutex 失败即退）
        return 0
    if args.cmd == "tray":
        from paistation.resident.tray import run_gui
        return run_gui()
    return 2


if __name__ == "__main__":
    sys.exit(main())
