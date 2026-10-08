# -*- coding: utf-8 -*-
"""behavior_verify.py — 行为级终审：清闸→全新导航→观察横幅/弹窗/初始态。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

TOKEN = "91558662"
INDEX = f"https://mp.weixin.qq.com/wxamp/index/index?token={TOKEN}&lang=zh_CN"

CHECK = """
var r = {};
// 横幅（渲染层）
var t = document.body.innerText || '';
r.banner_pause = t.indexOf('\\u5c0f\\u7a0b\\u5e8f\\u6682\\u505c\\u670d\\u52a1') >= 0;
r.cancel_word = t.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500') >= 0;
r.freeze_word = t.indexOf('\\u51bb\\u7ed3') >= 0;
// __INITIAL_STATE__ 全量
try { r.init_state = JSON.parse(JSON.stringify(window.__INITIAL_STATE__)); } catch (e) { r.init_state = 'ERR'; }
// store 关键态
var els = document.querySelectorAll('*');
var idx = null;
for (var j = 0; j < els.length; j++) {
  var v = els[j].__vue__;
  if (v && v.$options && v.$options.methods && v.$options.methods.SET_DIALOG_FORBID) { idx = v; break; }
}
if (idx) {
  var st = idx.$store.state;
  r.mgf = idx._data.dialogMiniGameFreeze;
  r.dialogForbid = (st.indexStore || {}).dialogForbid || null;
  r.minigameFreezeStatus = ((st.userInfo || {}).minigameFreezeStatus);
}
return JSON.stringify(r);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab

    # 清「每日一次」闸（让 init 逻辑可重跑）
    tab.run_js("try { localStorage.removeItem('minigame_freeze_show_time'); } catch (e) {} return localStorage.getItem('minigame_freeze_show_time');")
    tab.get(INDEX)
    time.sleep(6)
    r = json.loads(tab.run_js(CHECK) or "{}")
    s1 = shot(tab, "behavior1")
    r["shot"] = s1

    # 第二次：再清再刷（排除时序）
    tab.run_js("try { localStorage.removeItem('minigame_freeze_show_time'); } catch (e) {} return true;")
    tab.get(INDEX)
    time.sleep(6)
    r2 = json.loads(tab.run_js(CHECK) or "{}")
    r["second"] = {k: r2.get(k) for k in ("banner_pause", "cancel_word", "freeze_word", "mgf", "minigameFreezeStatus")}
    r["shot2"] = shot(tab, "behavior2")
    print(json.dumps(r, ensure_ascii=True))


if __name__ == "__main__":
    main()
