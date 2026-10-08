# -*- coding: utf-8 -*-
"""store_dump.py — 读 Vuex store：dialogForbid.content / appServiceType / 冻结真态。"""
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch  # noqa: E402

DUMP = """
var els = document.querySelectorAll('*');
var vueEls = [];
for (var j = 0; j < els.length; j++) { if (els[j].__vue__) vueEls.push(els[j].__vue__); }
var idx = null;
for (var k = 0; k < vueEls.length; k++) {
  if (vueEls[k].$options.methods && vueEls[k].$options.methods.SET_DIALOG_FORBID) { idx = vueEls[k]; break; }
}
if (!idx) return JSON.stringify({err: 'no_index'});
var st = idx.$store.state;
var out = {modules: Object.keys(st)};
// userInfo
try {
  var ui = st.userInfo || {};
  out.userInfo = {appServiceType: ui.appServiceType, nickname: (ui.wxaInfo || {}).nickname || ui.nickname || null,
    keys: Object.keys(ui).slice(0, 25)};
} catch (e) { out.userInfo = {err: String(e).slice(0, 60)}; }
// 找 dialogForbid 所在模块
for (var m in st) {
  var mod = st[m];
  if (mod && typeof mod === 'object') {
    if (mod.dialogForbid) out['dlg_' + m] = JSON.parse(JSON.stringify(mod.dialogForbid)).toString === undefined ? mod.dialogForbid : null;
    if (mod.dialogForbid) out['dlg_' + m] = {show: mod.dialogForbid.show, value: mod.dialogForbid.value, content: String(mod.dialogForbid.content || '').slice(0, 600)};
    if (m === 'userInfo' || (mod.userInfo)) continue;
  }
}
// minigameFreezeStatus 在哪
for (var m2 in st) {
  var mod2 = st[m2];
  if (mod2 && mod2.minigameFreezeStatus !== undefined) out.mfs = {mod: m2, val: mod2.minigameFreezeStatus};
}
// index 组件自身的 dialogMiniGameFreeze
out.mgf = idx._data.dialogMiniGameFreeze;
return JSON.stringify(out);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    r = json.loads(tab.run_js(DUMP) or "{}")
    print(json.dumps(r, ensure_ascii=False, indent=1))


if __name__ == "__main__":
    main()
