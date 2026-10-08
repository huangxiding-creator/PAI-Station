# -*- coding: utf-8 -*-
"""vpay_item_recon.py — 虚拟支付货架页侦察：找「新增道具」入口与现有道具表（为 export_once 建项铺路）.

输出 JSON：页面文本切片 + 可点元素清单 + XHR API 面（道具列表接口常带 product_id）。
只读不动——绝不在侦察轮点任何提交类按钮。
"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

# own-text 可点元素清单（span 包 button 的翻译扩展坑：取自身文本节点命中的最近可点祖先）
DUMP_CLICKABLE = """
function ownText(el) {
  var s = '';
  try {
    for (var k = 0; k < el.childNodes.length; k++) {
      var n = el.childNodes[k];
      if (n.nodeType === 3) s += n.textContent;
    }
  } catch (e) {}
  return s.trim();
}
function collect(doc, out, depth) {
  if (!doc || depth > 3) return;
  var els = null;
  try { els = doc.querySelectorAll('button,a,[role=button],.weui-btn,.btn_primary,li.menu_item,span'); } catch (e) { return; }
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var t = ownText(el) || (el.getAttribute('aria-label') || '').trim();
    if (!t || t.length > 24) continue;
    var r = null;
    try { r = el.getBoundingClientRect(); } catch (e) {}
    if (!r || r.width === 0 || r.height === 0) continue;
    if (out.indexOf(t) < 0) out.push(t);
  }
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) collect(frs[j].contentDocument, out, depth + 1);
  } catch (e) {}
  return;
}
var out = [];
collect(document, out, 0);
return JSON.stringify(out.slice(0, 200));
"""


def grab_apis(tab, seconds=6):
    urls = []
    tab.listen.start(True)
    deadline = time.time() + seconds
    tab.get(tab.url)
    while time.time() < deadline:
        try:
            p = tab.listen.wait(timeout=1.0)
        except Exception:
            break
        if not p:
            continue
        u = p.url or ""
        if "weixin.qq.com" in u and (".json" in u or "cgi-bin" in u or "wxamp" in u or "wx.weixin" in u):
            body = ""
            try:
                body = (p.response.body or "")[:800]
            except Exception:
                pass
            urls.append({"url": u[:160], "body": body if isinstance(body, str) else ""})
    tab.listen.stop()
    return urls


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
    txt = tab.run_js("return (document.body.innerText || '').slice(0, 6000);")
    clickable = tab.run_js(DUMP_CLICKABLE)
    s1 = shot(tab, "item_recon_landing")
    # 静默监听 6s 页面自然刷新流量（含道具列表 XHR）
    apis = grab_apis(tab, seconds=6)
    txt2 = tab.run_js("return (document.body.innerText || '').slice(0, 3000);")
    s2 = shot(tab, "item_recon_settled")
    print(json.dumps({
        "token": token,
        "url": (tab.url or "")[:160],
        "text_landing": txt,
        "text_settled": txt2,
        "clickable": clickable,
        "apis_n": len(apis),
        "apis": apis[:30],
        "shot1": s1,
        "shot2": s2,
    }, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
