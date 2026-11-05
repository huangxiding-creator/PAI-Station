# -*- coding: utf-8 -*-
"""ESS Chat 节流探针: 对框架本发最小 ask, 通=exit0, 节流=exit1.
1105 账号级 Chat 冷却(7章40+ask触发) — 每5min探一次, 恢复即拉跑者."""
import asyncio
import os
import sys

os.environ.setdefault("NBLM_PROXY", "http://127.0.0.1:7895")
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ess_nblm_run as run  # noqa: E402


async def main() -> int:
    st = run.base.load_state()
    async with await run.get_client() as client:
        try:
            res = await client.chat.ask(st["notebooks"]["framework"], "请只回复两个字：正常")
            ans = (getattr(res, "answer", "") or "")[:20]
            print("CHAT-OK", ans, flush=True)
            return 0
        except Exception as e:  # noqa: BLE001
            print("CHAT-BAD", type(e).__name__, str(e)[:90], flush=True)
            return 1


if __name__ == "__main__":
    try:
        code = asyncio.run(main())
    except Exception as e:  # noqa: BLE001
        print("PROBE-ERR", type(e).__name__, str(e)[:90], flush=True)
        code = 1
    raise SystemExit(code)
