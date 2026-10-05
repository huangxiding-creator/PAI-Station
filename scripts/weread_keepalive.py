# -*- coding: utf-8 -*-
"""weread_keepalive.py — 微信读书登录态续命巡检 (1005 用户令: 做好持久化).

根治「登录态静默死亡」: wr_skey ~30 天有效, 无人续命即 -2013 死透
(1005 实锤, 用户被迫再扫码). 本脚本挂 schtasks 每日一跑:

  探活 (/api/user/config) → 活且 >7 天未续 → renew() 原子写回
                         → 活且 <7 天 → 零动作 (探测优先, 频繁重登是风控信号)
                         → 死 → renew() 抢救 → 仍死 → 企微叫用户扫码 (30s 动作)

状态账: data/weread/_recon/keepalive_state.json (last_probe/last_renew/dead)
"""
import json
import os
import subprocess
import sys
import time

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

from paistation.forge.weread import WeReadClient   # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
AUTH = os.path.join(ROOT, "data", "weread", "_auth", "weread_auth.json")
RECON = os.path.join(ROOT, "data", "weread", "_recon")
STATE = os.path.join(RECON, "keepalive_state.json")
RENEW_INTERVAL = 7 * 86400        # 活着也 7 天一续 (30 天有效期内保新鲜)


def load_state() -> dict:
    s = {"last_probe": 0.0, "last_renew": 0.0, "dead": False,
         "notified": False}
    if os.path.exists(STATE):
        try:
            s.update(json.load(open(STATE, encoding="utf-8")))
        except Exception:                      # noqa: BLE001 — 状态账自愈
            pass
    return s


def save_state(s: dict) -> None:
    os.makedirs(RECON, exist_ok=True)
    tmp = STATE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(s, f, ensure_ascii=False, indent=1)
    os.replace(tmp, STATE)


def wecom_notify(text: str) -> None:
    """企微直达授权人 (个人 OAuth aibot 通道, 已实测). 失败仅日志不阻断."""
    try:
        subprocess.run(["wecom-cli", "message", "aibot", "send",
                        "--text", text],
                       capture_output=True, timeout=60)
    except Exception as e:                     # noqa: BLE001 — 通知尽力而为
        print(f"[keepalive] 企微通知失败: {e}", flush=True)


def main() -> int:
    s = load_state()
    now = time.time()
    s["last_probe"] = now

    if not os.path.exists(AUTH):
        _dead(s, "auth 文件不存在")
        return 1

    try:
        cli = WeReadClient(auth_path=AUTH)
        alive = cli.is_logged_in()
    except Exception as e:                     # noqa: BLE001 — 探活容错
        print(f"[keepalive] 探活异常: {e}", flush=True)
        return 0                               # 网络抖动不算死, 明天再看

    if alive:
        s["dead"] = s["notified"] = False
        if now - s.get("last_renew", 0) >= RENEW_INTERVAL:
            try:
                if cli.renew():
                    s["last_renew"] = now
                    print("[keepalive] 活 | renew 续期成功 (原子写回)",
                          flush=True)
                else:
                    print("[keepalive] 活 | renew 未换新 skey (不阻断)",
                          flush=True)
            except Exception as e:             # noqa: BLE001
                print(f"[keepalive] 活 | renew 异常: {e}", flush=True)
        else:
            print(f"[keepalive] 活 | 距上次续期 "
                  f"{(now - s.get('last_renew', 0)) / 3600:.0f}h, 零动作",
                  flush=True)
        save_state(s)
        return 0

    # 探活失败 → renew 抢救
    try:
        if cli.renew():
            s["last_renew"] = now
            s["dead"] = s["notified"] = False
            print("[keepalive] 死→活 | renew 抢救成功", flush=True)
            save_state(s)
            return 0
    except Exception as e:                     # noqa: BLE001
        print(f"[keepalive] renew 抢救异常: {e}", flush=True)
    _dead(s, "renew 无效 (-2013 死透)")
    return 1


def _dead(s: dict, why: str) -> None:
    s["dead"] = True
    save_state(s)
    if not s.get("notified"):                  # 死讯只发一次, 免轰炸
        s["notified"] = True
        save_state(s)
        wecom_notify("微信读书登录态已失效（wr_skey 死透），需要您扫码续命："
                     "回到 Claude 会话说一声即可，30 秒动作。原因: " + why)
    print(f"[keepalive] 死透 ({why}) — 企微已叫人", flush=True)


if __name__ == "__main__":
    sys.exit(main())
