# -*- coding: utf-8 -*-
"""登录页结构探针：枚举页签/输入框/按钮 + 双页签截图，不提交。"""
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
STATE = ROOT / "state"

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402


def dump(page, tag):
    print(f"===== {tag} url={page.url}")
    for inp in page.eles("css:input"):
        try:
            print(f"  input type={inp.attr('type')} placeholder={inp.attr('placeholder')!r} "
                  f"visible={inp.states.is_displayed}")
        except Exception as e:  # noqa: BLE001
            print(f"  input ? {e!r}")
    for b in page.eles("css:button"):
        try:
            print(f"  button text={b.text!r} displayed={b.states.is_displayed}")
        except Exception:  # noqa: BLE001
            pass
    for t in page.eles("xpath://div[@role='tab' or contains(@class,'tab')]"):
        try:
            if t.text.strip():
                print(f"  tab text={t.text!r}")
        except Exception:  # noqa: BLE001
            pass
    page.get_screenshot(path=str(STATE / f"w2_probe_{tag}.png"), full_page=False)


def main() -> int:
    co = ChromiumOptions()
    co.set_local_port(9341)
    co.set_user_data_path(str(ROOT / ".chrome-profile"))
    co.headless(False)
    page = ChromiumPage(co)
    try:
        page.get("https://bigmodel.cn/login?redirect=%2Fusercenter%2Fsettings%2Faccount")
        time.sleep(3)
        dump(page, "default")
        # 逐个点页签（邮箱登录等），看表单变化
        for tab_text in ["邮箱登录", "账号登录", "密码登录"]:
            try:
                t = page.ele(f"text:{tab_text}", timeout=2)
            except Exception:  # noqa: BLE001
                t = None
            if t:
                print(f">>> 点击页签 {tab_text!r}")
                t.click()
                time.sleep(1.5)
                dump(page, tab_text)
        return 0
    finally:
        for cleanup in (lambda: page.quit(),):
            try:
                cleanup()
            except Exception:  # noqa: BLE001
                pass


if __name__ == "__main__":
    raise SystemExit(main())
