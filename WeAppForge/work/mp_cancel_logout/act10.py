# -*- coding: utf-8 -*-
"""act10.py — 直调 /publicpoc/wxaacctclose {action:cancelclose} 完成取消注销。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402
from act6 import DOM_PROBE, INDEX  # noqa: E402

CALL = """
async function main() {
  var url = '/publicpoc/wxaacctclose?action=cancelclose&token=91558662&lang=zh_CN';
  try {
    var resp = await fetch(url, {
      method: 'POST',
      credentials: 'same-origin',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify({action: 'cancelclose'})
    });
    var text = await resp.text();
    return JSON.stringify({status: resp.status, body: text.slice(0, 400)});
  } catch (e) {
    return JSON.stringify({err: String(e).slice(0, 120)});
  }
}
return main();
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    if "wxamp" not in (tab.url or ""):
        tab.get(INDEX)
        time.sleep(3)

    r = tab.run_js(CALL, timeout=30)
    out("ACT10_api_call", resp=json.loads(r or "{}"), shot=shot(tab, "act10_call"))

    # 等服务端状态扩散，再全新导航终审
    time.sleep(3)
    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(DOM_PROBE) or "{}")
    gone = (not v.get("real0")) and (not v.get("live_texts"))
    out("RESTORED" if gone else "ACT10_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act10_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
