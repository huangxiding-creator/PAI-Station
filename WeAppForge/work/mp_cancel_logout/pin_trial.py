# -*- coding: utf-8 -*-
"""pin_trial.py — 体验版钉位通用器（1009 v0.9.7 八轮攻坚终版配方固化，用户令「好的方法固化下来」）。

用法: python pin_trial.py <版本号>   # 例: python pin_trial.py 0.9.8

★ 1009 八轮血泪沉淀（a-h 谱系，勿回退到任何旧打法）：
  1. 定位反直觉：从 .arrowBtn 向上找含版本号的块=必错（祖先容器跨区，d 版点到
     线上版本卡菜单「版本回退/暂停服务」）。正解=锚点向下：ownText=='<版本号>'
     的元素 → 行容器（≤6 层内）→ 行内 .arrowBtn。版本号 ownText 全等，零歧义。
  2. 菜单要轮询不要定睡：⋯ 菜单渲染慢于 1.5s（a 版死因），15s 轮询 ownText 含
     「选为」的可见元素，出现即点。
  3. 全 JS 链即可（勿用原生坐标点击）：.arrowBtn 的 JS click 真能开菜单（a 版
     截图实锤）；DrissionPage 原生坐标点击反而点出「行展开」副作用（e/f/g 版
     全死于此）。原生点击只在对 JS click 免疫的元素上用（如 1004 取消注销）。
  4. 菜单不在 iframe（g 版跨文档扫描实证唯一 iframe=0×0 像素），别再查 iframe。
  5. 四防线不变：新标签读真态 / 精确文本点击 / 确认键文本直配「切换体验版」/
     钉后新标签复核。红线：绝不碰「提交审核」。
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

VER = sys.argv[1] if len(sys.argv) > 1 else ""
if not re.fullmatch(r"\d+\.\d+\.\d+", VER or ""):
    raise SystemExit("用法: python pin_trial.py <版本号>  例: 0.9.8")

JS_READ_TRIAL = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '体验版'){
      var node = els[i];
      for (var d=0; d<8 && node; d++){
        node = node.parentElement;
        if (!node) break;
        var t = node.innerText || '';
        if (t.length > 20 && t.length < 600){
          var m = t.match(/\d+\.\d+\.\d+/);
          if (m) return JSON.stringify({ver: m[0], ctx: t.slice(0,80).replace(/\n/g,'|')});
        }
      }
    }
  }
  return JSON.stringify({ver: null});
})();
"""

JS_CLICK_ARROW = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i]) === '""" + VER + r"""'){
      var row = els[i].parentElement;
      for (var d=0; d<6 && row; d++){
        var btns = row.querySelectorAll('.arrowBtn');
        if (btns.length){
          btns[0].scrollIntoView({block: 'center'});
          btns[0].click();
          return 'arrow-js-clicked@depth' + d;
        }
        row = row.parentElement;
      }
      return 'row-no-btn';
    }
  }
  return 'no-anchor';
})();
"""

JS_CLICK_PICK = r"""
return (function(){
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var o = ownText(els[i]);
    if (o && o.length <= 14 && o.indexOf('选为') >= 0){
      var r = els[i].getBoundingClientRect();
      if (r.width > 0){ els[i].click(); return 'clicked:' + o; }
    }
  }
  return 'waiting';
})();
"""

JS_CONFIRM = r"""
return (function(){
  var btns = document.querySelectorAll('button, .weui-desktop-btn');
  for (var j = 0; j < btns.length; j++) {
    var own = (btns[j].innerText || '').trim();
    var r = btns[j].getBoundingClientRect();
    if (own === '切换体验版' && r.width > 0) { btns[j].click(); return 'confirmed'; }
  }
  return 'no-switch-btn';
})();
"""


def main() -> None:
    page = attach_or_launch()
    tab = None
    for t in page.get_tabs():
        if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
            tab = t; break
    if tab is None:
        print("NO_LOGGED_IN_TAB（先跑 mp 登录保活，或企微叫码 30 秒重登）")
        sys.exit(1)
    token = re.search(r"token=(\d{8,})", tab.url or "").group(1)

    nt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
    time.sleep(6)
    print("live_pin_before:", nt.run_js(JS_READ_TRIAL))
    r0 = json.loads(nt.run_js(JS_READ_TRIAL))
    if r0.get("ver") == VER:
        print("ALREADY_PINNED:", VER)
        sys.exit(0)

    print("arrow:", nt.run_js(JS_CLICK_ARROW))
    picked = False
    for attempt in range(15):
        res = nt.run_js(JS_CLICK_PICK)
        if str(res).startswith("clicked"):
            print(f"pick[{attempt}]:", res)
            picked = True
            break
        time.sleep(1.0)
    if not picked:
        print("PICK_FAILED_15S")
        sys.exit(1)
    time.sleep(2.0)

    for attempt in range(12):
        res = nt.run_js(JS_CONFIRM)
        print(f"confirm[{attempt}]:", res)
        if str(res).startswith("confirmed"):
            break
        time.sleep(1.5)
    time.sleep(3.5)

    vt = page.new_tab(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
    time.sleep(6)
    r1 = json.loads(vt.run_js(JS_READ_TRIAL))
    print("live_pin_after:", json.dumps(r1, ensure_ascii=False))
    print("PIN_RESULT:", "OK" if r1.get("ver") == VER else "FAIL")


if __name__ == "__main__":
    main()
