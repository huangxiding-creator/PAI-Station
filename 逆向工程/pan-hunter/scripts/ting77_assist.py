# -*- coding: utf-8 -*-
r"""ting77 人工辅助过墙腿（W3 遗留 → 1031 尾巴令落件）

背景：ting77.com = Cloudflare Turnstile + reCAPTCHA 交互墙（W3_CF_BROWSER.md 定性），
      自动绕行不做（检测规避红线）；本腿=**用户明示发起时**开可见窗口，人工过盾一次，
      随后在同一浏览器上下文内探搜索端点形态，把结果落档供配方化评估。

跑法：
  python -I scripts/ting77_assist.py            # 交互腿：开窗 → 你过盾 → 回车 → 探测 → 关窗
  python -I scripts/ting77_assist.py --smoke    # 冒烟：只验证开/关浏览器管线，不访问站点

纪律：仅 ting77 一站；用完即关（Chrome 进守门：退出后进程数回基线）；结果仅落
      analysis/ting77_probe_<ts>.json；不写任何凭据；不自动重试过盾。
"""
from __future__ import annotations

import io
import json
import sys
import time
from datetime import datetime
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")
ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "analysis"

PROBE_JS = """
(async () => {
  const q = encodeURIComponent('民法典');
  const out = {};
  for (const u of [
    `https://ting77.com/search?q=${q}`,
    `https://ting77.com/api/search?q=${q}`,
  ]) {
    try {
      const r = await fetch(u, {credentials: 'include'});
      const text = (await r.text()).slice(0, 400);
      out[u] = {status: r.status, head: text};
    } catch (e) { out[u] = {status: -1, head: String(e)}; }
  }
  return JSON.stringify(out);
})()
"""


def main() -> int:
    smoke = "--smoke" in sys.argv
    try:
        from DrissionPage import ChromiumPage, ChromiumOptions
    except ModuleNotFoundError:
        # 系统解释器无 DrissionPage → 转仓 .venv（既账：DrissionPage 4.1.1.4 @ .venv）
        venv_py = Path(r"E:/AI-Station/.venv/Scripts/python.exe")
        if venv_py.exists() and Path(sys.executable) != venv_py:
            import subprocess
            raise SystemExit(subprocess.call([str(venv_py), "-I", __file__, *sys.argv[1:]]))
        raise

    co = ChromiumOptions()
    co.set_argument("--window-size=1100,800")
    if smoke:
        co.headless()
    page = ChromiumPage(co)
    try:
        if smoke:
            print("[smoke] 浏览器管线 OK（headless 起落），退出")
            return 0
        page.get("https://ting77.com")
        print("[ting77] 已开窗——请在浏览器里完成 Turnstile/reCAPTCHA，然后回到本窗口按回车…")
        input()
        page.get("https://ting77.com/search?q=%E6%B0%91%E6%B3%95%E5%85%B8")
        time.sleep(2)
        result = page.run_js(PROBE_JS)
        ts = datetime.now().strftime("%Y%m%d_%H%M%S")
        OUT.mkdir(exist_ok=True)
        (OUT / f"ting77_probe_{ts}.json").write_text(
            json.dumps({"ts": ts, "probe": json.loads(result) if result else None},
                       ensure_ascii=False, indent=2), encoding="utf-8")
        print(f"[ting77] 探测结果 → analysis/ting77_probe_{ts}.json（供配方化评估）")
        return 0
    finally:
        page.quit()
        print("[hygiene] 浏览器已关；请核对 Chrome 进程回基线")


if __name__ == "__main__":
    raise SystemExit(main())
