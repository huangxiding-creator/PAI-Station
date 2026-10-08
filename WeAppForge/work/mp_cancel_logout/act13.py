# -*- coding: utf-8 -*-
"""act13.py — form-encoded POST /publicpoc/wxaacctclose action=cancelclose。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402
from act6 import INDEX  # noqa: E402

CALL_FORM = """
async function main() {
  var url = '/publicpoc/wxaacctclose?action=cancelclose&token=91558662&lang=zh_CN';
  try {
    var resp = await fetch(url, {
      method: 'POST',
      credentials: 'same-origin',
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: 'action=cancelclose'
    });
    var text = await resp.text();
    return JSON.stringify({form: {status: resp.status, body: text.slice(0, 300)}});
  } catch (e) {
    return JSON.stringify({err: String(e).slice(0, 120)});
  }
}
return main();
"""

QUERY = """
async function main() {
  try {
    var resp = await fetch('/publicpoc/wxaacctclose?action=querycloseinfo&token=91558662&lang=zh_CN', {method: 'GET', credentials: 'same-origin'});
    return JSON.stringify((await resp.text()).slice(0, 250));
  } catch (e) { return JSON.stringify({err: String(e).slice(0, 80)}); }
}
return main();
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    if "wxamp" not in (tab.url or ""):
        tab.get(INDEX)
        time.sleep(3)

    r = json.loads(tab.run_js(CALL_FORM, timeout=30) or "{}")
    out("ACT13_form_post", r=r, shot=shot(tab, "act13_post"))
    time.sleep(2)

    q = tab.run_js(QUERY, timeout=30)
    out("ACT13_requery", api=q)
    print(json.dumps({"post": r, "requery": q}, ensure_ascii=True))
    return 0


if __name__ == "__main__":
    sys.exit(main())
