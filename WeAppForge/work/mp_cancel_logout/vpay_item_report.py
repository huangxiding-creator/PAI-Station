# -*- coding: utf-8 -*-
"""vpay_item_report.py — 建报告分档道具（¥498/¥598/¥698/¥1999），vpay_item_create.py 配方参数化。

道具ID=report_<档>（自填串，服务端 _report_product 查 report_product_<档> 对齐）。
用法: python vpay_item_report.py 498|598|698|1999
"""
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402
from vpay_item_create import CLICK_WORD, FIND_INPUT_OK, DISPATCH_CHANGE, DUMP, click, cdp_upload  # noqa: E402

PRICE = sys.argv[1] if len(sys.argv) > 1 else ""
assert PRICE in ("498", "598", "698", "1999"), "usage: vpay_item_report.py 498|598|698|1999"
PRODUCT_ID = f"report_{PRICE}"
ITEM_NAME = f"研究报告解锁-{PRICE}元"
REMARK = f"解锁单份研究报告（{PRICE}元档）"
SECRET = Path(r"E:\AI-Station\data\secrets\virtual_pay.secret")

FILL_TMPL = r"""
function fillByPh(doc, phPrefix, val, depth) {
  if (!doc || depth > 4) return false;
  var done = false;
  try {
    var inputs = doc.querySelectorAll('input[type=text],textarea');
    for (var i = 0; i < inputs.length; i++) {
      var el = inputs[i];
      if ((el.placeholder || '').indexOf(phPrefix) === 0) {
        var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
        setter.call(el, val);
        el.dispatchEvent(new Event('input', {bubbles: true}));
        el.dispatchEvent(new Event('change', {bubbles: true}));
        done = true;
      }
    }
  } catch (e) {}
  if (done) return true;
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) if (fillByPh(frs[j].contentDocument, phPrefix, val, depth + 1)) return true;
  } catch (e) {}
  return false;
}
var r1 = fillByPh(document, '\u8bf7\u586b\u5199\u9053\u5177ID', '__PID__', 0);
var r2 = fillByPh(document, '\u8bf7\u586b\u5199\u9053\u5177\u540d\u79f0', '__NAME__', 0);
var r3 = fillByPh(document, '\u8bf7\u586b\u5199\u9053\u5177\u4ef7\u683c', '__PRICE__', 0);
var r4 = fillByPh(document, '\u5907\u6ce8\u4ec5\u81ea\u5df1\u4f7f\u7528', '__REMARK__', 0);
return JSON.stringify({id: r1, name: r2, price: r3, remark: r4});
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(10)
    res = {"token": token, "price": PRICE}
    res["c_base"] = click(tab, "基本配置")
    time.sleep(6)
    res["c_itemcfg"] = click(tab, "道具配置")
    time.sleep(5)
    res["c_add"] = click(tab, "添加道具")
    time.sleep(4)
    fill_js = (FILL_TMPL.replace("__PID__", PRODUCT_ID).replace("__NAME__", ITEM_NAME)
               .replace("__PRICE__", PRICE).replace("__REMARK__", REMARK))
    res["fill"] = json.loads(tab.run_js(fill_js) or "{}")
    time.sleep(1)
    res["c_normal"] = click(tab, "普通道具")
    time.sleep(1)
    res["c_custom"] = click(tab, "自定义")
    time.sleep(1)
    print("== stage: cdp upload ==", file=sys.stderr, flush=True)
    res["cdp"] = cdp_upload(tab)
    time.sleep(1)
    res["change"] = tab.run_js(DISPATCH_CHANGE)
    time.sleep(3)
    res["shot_pre"] = shot(tab, f"vpay_report{PRICE}_ready")
    print("== stage: submit ==", file=sys.stderr, flush=True)
    res["submit"] = click(tab, "提交审核")
    time.sleep(8)
    res["docs_after"] = json.loads(tab.run_js(DUMP) or "[]")
    res["shot_post"] = shot(tab, f"vpay_report{PRICE}_submitted")
    joined = "\n".join(p.get("txt", "") for p in res["docs_after"])
    res["row_seen"] = PRODUCT_ID in joined
    if "我知道了" in joined and PRODUCT_ID not in joined:
        click(tab, "我知道了")
        time.sleep(3)
        parts2 = json.loads(tab.run_js(DUMP) or "[]")
        joined2 = "\n".join(p.get("txt", "") for p in parts2)
        res["row_seen2"] = PRODUCT_ID in joined2
        joined = joined2
    if PRODUCT_ID in joined:
        cur_txt = SECRET.read_text(encoding="utf-8")
        key = f"report_product_{PRICE}="
        if key not in cur_txt:
            cur_txt = cur_txt.rstrip() + f"\n{key}{PRODUCT_ID}\n"
            SECRET.write_text(cur_txt, encoding="utf-8")
        res["secret_written"] = True
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
