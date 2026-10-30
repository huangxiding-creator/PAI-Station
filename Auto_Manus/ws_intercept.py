# -*- coding: utf-8 -*-
"""ws_intercept — WebSocket帧拦截器: 逆向Manus会话创建协议."""
import sys, json, time
sys.path.insert(0, '.')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import Chromium, ChromiumOptions
from pathlib import Path
from DrissionPage.common import Keys

profile = Path('data/profiles_v3/5l8urxjdkd')
co = ChromiumOptions()
co.set_argument('--window-position=-32000,0')
co.set_argument('--disable-blink-features=AutomationControlled')
co.set_user_data_path(str(profile.resolve()))
co.set_local_port(9981)
browser = Chromium(co)
page = browser.latest_tab

page.get('https://manus.im/app')
time.sleep(6)
print('URL:', page.url[:40])

# 注入WebSocket拦截器
INJECT = """
window.__ws_frames = [];
(function() {
    var origSend = WebSocket.prototype.send;
    WebSocket.prototype.send = function(data) {
        var entry = {url: this.url, time: Date.now()};
        if (typeof data === 'string') {
            entry.type = 'text';
            entry.data = data.substring(0, 800);
        } else if (data instanceof ArrayBuffer) {
            entry.type = 'binary';
            entry.size = data.byteLength;
            var bytes = new Uint8Array(data);
            var parts = [];
            for (var i = 0; i < Math.min(200, bytes.length); i++) {
                parts.push(bytes[i]);
            }
            entry.bytesHead = parts;
        } else if (data instanceof Blob) {
            entry.type = 'blob';
            entry.size = data.size;
        }
        window.__ws_frames.push(entry);
        return origSend.apply(this, arguments);
    };
})();
"""
result = page.run_js(INJECT)
print('拦截器注入:', result)

# 提交简报
textarea = page.ele('css:textarea', timeout=10)
if textarea:
    textarea.click()
    textarea.input('API discovery test 1023')
    time.sleep(1)
    textarea.input(Keys.ENTER)
    time.sleep(6)
    print('简报已提交')
else:
    ce = page.ele('css:[contenteditable]', timeout=5)
    if ce:
        ce.click()
        ce.input('API discovery test 1023')
        time.sleep(1)
        ce.input(Keys.ENTER)
        time.sleep(6)
        print('已提交via CE')
    else:
        print('未找到输入框')

# 读取拦截结果
frames_raw = page.run_js('JSON.stringify(window.__ws_frames || [])')
browser.quit()

print('\n=== WebSocket帧 ===')
try:
    frames = json.loads(frames_raw)
    print(f'总帧数: {len(frames)}')
    for i, f in enumerate(frames[:15]):
        print(f'\n[{i}] URL: {f.get("url","")[:60]}')
        print(f'    Type: {f.get("type","?")} Size: {f.get("size","?")}')
        if f.get('data'):
            print(f'    TEXT: {f["data"][:300]}')
        if f.get('bytesHead'):
            bs = f['bytesHead'][:50]
            hex_str = ' '.join(f'{b:02x}' for b in bs)
            ascii_str = ''.join(chr(b) if 32 <= b < 127 else '.' for b in bs)
            print(f'    HEX: {hex_str}')
            print(f'    ASCII: {ascii_str}')
except Exception as e:
    print(f'解析异常: {e}')
    print(f'原始: {str(frames_raw)[:500]}')
