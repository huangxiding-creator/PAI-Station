# -*- coding: utf-8 -*-
"""深度搜索：DrissionPage 元素查找（自动穿透 iframe/shadow DOM）+ 截屏。"""
import sys, time, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
tok = "1185026370"

# 确保在 goods 页
url = f"https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token={tok}&lang=zh_CN"
page.run_js(f"location.href='{url}'")
time.sleep(8)

# 截屏看实际界面
page.get_screenshot(shot=r"E:\AI-Station\kb_rev\vp_goods_page.png")
print("[1] 截屏已存 kb_rev/vp_goods_page.png")

# 方法1：DrissionPage 的 ele() 全局搜（会穿透 iframe）
for keyword in ["新建道具", "添加道具", "新建商品", "添加商品", "Create", "新建"]:
    try:
        el = page.ele(f'text:{keyword}')
        if el:
            print(f"[2] 找到 '{keyword}': tag={el.tag} text={el.text[:50]}")
            el.click()
            time.sleep(4)
            page.get_screenshot(shot=r"E:\AI-Station\kb_rev\vp_after_click.png")
            print("[3] 点击后截屏已存")
            break
    except Exception:
        continue

# 方法2：全文搜索看当前页面实际内容（可能被 wujie 嵌套在自定义元素里）
full_html = page.html or ""
# 找 wujie 自定义元素
import re
wujie_tags = re.findall(r'<(wujie-[^>]+|we[c-u][j]?[b]?i[e]?-[^>]+)', full_html)
print(f"[4] wujie 标签: {wujie_tags[:5]}")

# 找所有 custom elements
custom = re.findall(r'<([a-z]+-[a-z]+)[\s>]', full_html)
print(f"[5] 自定义元素: {list(set(custom))[:10]}")

# 方法3：直接读 iframe 内容（用 CDP）
cdp_result = page.run_js("""
return (function(){
  // wujie 微前端：找到 wujie 容器，读其 innerHTML
  var containers = document.querySelectorAll('[class*=wujie], [id*=wujie], wujie-app, [class*=micro]');
  var out = [];
  for (var i=0;i<containers.length;i++){
    var html = containers[i].innerHTML || '';
    if (html.length > 100) {
      // 提取文本
      var div = document.createElement('div');
      div.innerHTML = html;
      var text = (div.innerText || '').replace(/\\s+/g,' ');
      if (text.length > 20) out.push({cls: containers[i].className.slice(0,30), text: text.slice(0,300)});
    }
  }
  return JSON.stringify(out.slice(0,5));
})()
""")
print("[6] wujie容器内容:", cdp_result[:500] if cdp_result else "空")

# 方法4：看主区域（排除侧栏）
main_content = page.run_js("""
return (function(){
  // 找主内容区域（通常在 sidebar 之后的大块区域）
  var main = document.querySelector('.main, [class*=content], [class*=body-wrap], [role=main]');
  if (main) {
    var text = (main.innerText || '').replace(/\\s+/g, ' ');
    return text.slice(0, 500);
  }
  // 如果没有标准 main，取 body 减去 sidebar
  var body = document.body.innerText || '';
  // 找侧栏文本并去除
  var side = document.querySelector('[class*=sidebar], [class*=menu], [class*=nav]');
  if (side) {
    var sideText = side.innerText || '';
    body = body.replace(sideText, '');
  }
  return body.replace(/\\s+/g, ' ').slice(0, 500);
})()
""")
print("[7] 主区域内容:", main_content[:500] if main_content else "空")
