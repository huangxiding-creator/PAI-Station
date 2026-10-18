# -*- coding: utf-8 -*-
import sys, json, ctypes, time
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

user32 = ctypes.windll.user32

SW_RESTORE = 9
SW_SHOW = 5

def find_chrome_windows():
    """枚举所有可见顶层窗口，返回 [(hwnd, title)]"""
    wins = []
    EnumWindowsProc = ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p)
    def cb(hwnd, _):
        if not user32.IsWindowVisible(hwnd):
            return True
        n = user32.GetWindowTextLengthW(hwnd)
        if n <= 0:
            return True
        buf = ctypes.create_unicode_buffer(n + 1)
        user32.GetWindowTextW(hwnd, buf, n + 1)
        wins.append((hwnd, buf.value))
        return True
    user32.EnumWindows(EnumWindowsProc(cb), 0)
    return wins

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or ''):
        tab = t
        break
if tab is None:
    raise SystemExit('no wrapper tab')

# 1) 先激活目标标签页（页签级）
tab.set.activate()
time.sleep(0.5)

# 2) 找 Chrome 主窗口并恢复/置前（窗口级）
targets = []
for hwnd, title in find_chrome_windows():
    if '微信' in title or 'Chrome' in title or 'chrome' in title or 'mp.weixin' in title or 'goods' in title:
        targets.append((hwnd, title))
print('candidate windows:')
for hwnd, title in targets:
    print(' ', hwnd, title[:70])

# 取第一个 Chrome 窗口（9336 调试实例）
if targets:
    hwnd = targets[0][0]
    if user32.IsIconic(hwnd):
        user32.ShowWindow(hwnd, SW_RESTORE)
        print('restored from minimize')
    else:
        user32.ShowWindow(hwnd, SW_SHOW)
    # 连续两次 SetForegroundWindow + ALT 键解锁前台锁
    user32.keybd_event(0x12, 0, 0, 0)          # ALT down
    user32.keybd_event(0x12, 0, 2, 0)          # ALT up
    ok = user32.SetForegroundWindow(hwnd)
    print('SetForegroundWindow ->', ok)

time.sleep(1.0)
# 3) 验证二维码墙还在
JS = r"""
(function(){
  var ifs = document.querySelectorAll('iframe');
  var out = [];
  for (var i = 0; i < ifs.length; i++) {
    try {
      var d = ifs[i].contentDocument;
      if (!d) { out.push('IF' + i + ' NODOC'); continue; }
      var t = ((d.body && d.body.innerText) || '');
      if (t) out.push('IF' + i + ' ' + t.slice(0, 60).replace(/\n/g, '|'));
    } catch (e) {}
  }
  return out.join(' ; ');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
print('frame state:', str(r.get('result', {}).get('value', ''))[:200])
tab.get_screenshot(path='E:/AI-Station/WeAppForge/work/vp_qr_now2.png', full_page=False)
print('shot2 saved')
