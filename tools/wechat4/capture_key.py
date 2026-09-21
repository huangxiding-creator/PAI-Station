r"""微信 4.x 密钥抓取就位件（须用户在场执行）。

⚠️ 此脚本会重启微信（taskkill Weixin.exe → 重新拉起 → Frida attach →
pywinauto 自动点登录），必须用户在场点头后才运行——总原则「运行过程要
最大程度不影响用户操作电脑」。成功后密钥自动落位 data/secrets/ 并验签。

流程（vendor wechat-ai-memory 的 capture_account_key）:
  1. 关闭运行中的微信
  2. 重新启动微信（定位 Weixin.exe）
  3. Frida attach + SHA-512 K常量表特征码定位 + hook ipad 块还原密钥
  4. pywinauto 自动点击登录（若需扫码等用户手机确认）
  5. 密钥写入 secrets + 对 session.db 验签

用法（用户在场时）:
  python tools/wechat4/capture_key.py [--account wxid_xxx]
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

STATION_ROOT = Path(__file__).resolve().parents[2]
VENDOR_SRC = STATION_ROOT / "vendor" / "wechat-ai-memory" / "src"

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")

if str(VENDOR_SRC) not in sys.path:
    sys.path.insert(0, str(VENDOR_SRC))

from wechat_context_exporter.sources.wechat4_discovery import (  # noqa: E402
    discover_wechat4_accounts,
)
from wechat_context_exporter.sources.wechat4_crypto import verify_account_key  # noqa: E402
from wechat_context_exporter.sources.wechat4_key_capture import capture_account_key  # noqa: E402


def main() -> None:
    parser = argparse.ArgumentParser(description="微信 4.x 密钥抓取（用户在场执行）")
    parser.add_argument("--account", help="目标账户 id（默认最近活跃账户）")
    parser.add_argument("--timeout", type=int, default=300, help="秒，默认 300")
    args = parser.parse_args()

    accounts = discover_wechat4_accounts()
    if not accounts:
        raise SystemExit("未发现本机微信 4.x 数据目录")
    account = next(
        (a for a in accounts if a.id == args.account), accounts[0]
    )
    print(f"目标账户: {account.id}")
    print(f"账户目录: {account.account_dir}")
    print()
    print("=" * 60)
    print("即将重启微信以抓取数据库密钥：")
    print("  1. 微信会被关闭并重新启动（约 10-30 秒）")
    print("  2. 若需扫码/手机确认，请在 5 分钟内完成")
    print("  3. 成功后微信恢复运行，密钥落位 data/secrets/")
    print("=" * 60)
    answer = input("确认现在执行？(y/N) ").strip().lower()
    if answer != "y":
        print("已取消。")
        return

    def progress(current: int, total: int, text: str) -> None:
        print(f"  [{current}/{total}] {text}")

    try:
        raw_key = capture_account_key(
            account.account_dir, timeout=args.timeout, progress=progress
        )
    except Exception as exc:  # noqa: BLE001 - 就位件须把失败如实给人看
        raise SystemExit(f"抓取失败: {exc}")

    secrets_dir = STATION_ROOT / "data" / "secrets"
    secrets_dir.mkdir(parents=True, exist_ok=True)
    key_file = secrets_dir / f"wechat4_key_{account.id}.hex"
    key_file.write_text(raw_key.hex(), encoding="utf-8")

    session_db = account.db_dir / "session" / "session.db"
    first_page = session_db.open("rb").read(4096) if session_db.is_file() else b""
    verified = verify_account_key(raw_key, first_page)
    print()
    print(f"密钥已保存: {key_file}")
    print(f"session.db 验签: {'✅ 通过' if verified else '❌ 失败（密钥可能不匹配）'}")
    if not verified:
        raise SystemExit(2)


if __name__ == "__main__":
    main()
