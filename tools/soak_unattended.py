"""M8 无人值守浸泡壳：信号服务 + 意图服务 无 daemon 长跑（7 天级）。

用法（默认 7 天 × 60s 一轮，晚间执行更稳；随时 Ctrl-C，重跑断点续）：
  python tools/soak_unattended.py --data-dir <目录> [--hours 168]
      [--interval 60] [--journal <路径>]

journal 落 data_dir（gitignored）；每轮 = signals.tick + intents.tick，
单轮异常记 error 行不杀长跑。无 profile/LLM 网关时意图层自动 L1 降级。
"""
from __future__ import annotations

import argparse
import logging
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

_log = logging.getLogger("paistation.tools.soak")


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(prog="soak_unattended")
    parser.add_argument("--data-dir", required=True)
    parser.add_argument("--hours", type=float, default=168.0)  # 7 天
    parser.add_argument("--interval", type=float, default=60.0)
    parser.add_argument("--journal",
                        default=None)  # 缺省 data_dir/soak_journal.jsonl
    args = parser.parse_args(argv)
    logging.basicConfig(level=logging.INFO,
                        format="%(asctime)s %(levelname)s %(name)s "
                               "%(message)s")

    from paistation.intent.service import IntentService
    from paistation.ops.soak import SoakRunner
    from paistation.sense.signal_service import SignalService
    from paistation.sense.voice_events import EventStream

    stream = EventStream(data_dir=args.data_dir)
    signals = SignalService(stream=stream)
    intents = IntentService(stream=stream, interval=0)  # 壳层自管节拍
    signals.start()
    intents.start()

    def step(i: int) -> str:
        signals.tick()
        intents.tick()
        return f"intents={len(intents.intents)}"

    journal = args.journal or str(Path(args.data_dir) / "soak_journal.jsonl")
    cycles = max(1, int(args.hours * 3600 / max(args.interval, 1.0)))
    runner = SoakRunner(cycles=cycles, step_fn=step, journal_path=journal,
                        interval_sec=args.interval)
    try:
        rep = runner.run()
    except KeyboardInterrupt:
        _log.info("用户中断（断点已留 journal，重跑即续）")
        return 0
    _log.info("浸泡跑结束: %s", rep)
    print(rep)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
