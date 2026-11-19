# -*- coding: utf-8 -*-
"""mp_quick_login_auto — 小程序后台免扫码全自动登录（1119 用户常令：
「桌面微信授权确认也由你自动完成，不要让我手动」）。

链路: 9338+mp_qr_profile2 → mp.weixin.qq.com 无 token → 点「微信快捷登录」
→ UIA 监视桌面微信授权弹窗 → 程序化 Invoke 确认钮（InvokePattern，零鼠标移动，
合规于 1104 抢鼠标禁令）→ 轮询 token 落地。

前置: Weixin.exe 桌面微信已登录（快捷登录的会话源）。
用法: py -3 -X utf8 mp_quick_login_auto.py   （.venv: uiautomation+DrissionPage）
标定记录: 授权弹窗结构首跑未知——watcher 走泛匹配(确认|允许|授权|同意|登录),
命中日志回填本文件「标定」段; 未命中时如实报败,绝不谎报已授权。
"""
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import uiautomation as u  # noqa: E402
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

PORT = 9338
PROFILE = r"E:\AI-Station\data\state\mp_qr_profile2"
WX_PROC = ("Weixin.exe", "WeChat.exe", "WeChatApp.exe")
CONFIRM_WORDS = ("确认", "允许", "授权", "同意", "登录")


def wx_pids() -> set:
    out = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "Get-Process Weixin,WeChat -ErrorAction SilentlyContinue | "
         "Select-Object -ExpandProperty Id"],
        capture_output=True, text=True).stdout or ""
    return {int(x) for x in out.split() if x.isdigit()}


def find_auth_button():
    """扫微信进程的新顶层窗 → 找确认类按钮（InvokePattern 程序化点）。"""
    hits = []
    pids = wx_pids()
    if not pids:
        return None, "no-wechat-process"
    root = u.GetRootControl()
    for w in root.GetChildren():
        try:
            if w.ProcessId not in pids:
                continue
            # 遍历该窗两层子树找按钮
            stack = [w] + list(w.GetChildren())
            for node in stack:
                for btn in (node.GetChildren() or []):
                    name = (btn.Name or "").strip()
                    cls = (btn.ClassName or "")
                    if ("Button" in cls or btn.ControlTypeName == "ButtonControl") \
                            and name and any(k in name for k in CONFIRM_WORDS):
                        hits.append((w, btn, name))
        except Exception:
            continue
    if not hits:
        return None, "no-confirm-btn"
    # 优先小窗（授权弹窗是独立小顶层窗, 非主窗）
    hits.sort(key=lambda h: (h[0].BoundingRectangle.right - h[0].BoundingRectangle.left))
    win, btn, name = hits[0]
    try:
        btn.GetInvokePattern().Invoke()
        return name, f"invoked@{win.Name[:20]}"
    except Exception:
        try:
            btn.Click(simulateMove=False)  # 兜底: 控件坐标单击(不模拟移动轨迹)
            return name, "click-fallback"
        except Exception as e:
            return None, f"invoke-fail:{str(e)[:40]}"


def main() -> int:
    opts = ChromiumOptions()
    opts.set_local_port(PORT)
    opts.set_user_data_path(PROFILE)
    page = ChromiumPage(addr_or_opts=opts)
    page.get("https://mp.weixin.qq.com/")
    time.sleep(4)
    tok = ""
    m = re.search(r"token=(\d+)", page.url or "")
    if m and "scanlogin" not in (page.url or ""):
        print("[ok] 会话已活 token=" + m.group(1))
        return 0
    # 点快捷登录
    r = page.run_js("""
return (function(){
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if (t==='微信快捷登录'){ els[i].click(); return 'clicked'; }
  }
  return 'not-found';
})()
""")
    print("[1] 快捷登录:", r)
    if r != "clicked":
        return 2
    # UIA watcher + token 轮询（并行动作: 弹窗一出现即点）
    for i in range(40):
        time.sleep(3)
        m = re.search(r"token=(\d+)", (page.url or ""))
        if m and "scanlogin" not in (page.url or ""):
            print(f"[ok] LOGGED_IN token={m.group(1)} ({(i+1)*3}s)")
            return 0
        if i % 2 == 0:
            name, detail = find_auth_button()
            if name:
                print(f"[2] 授权已自动点: 「{name}」 {detail}")
                time.sleep(2)
        if i % 10 == 9:
            print(f"  [{(i+1)*3}s] 等待授权弹窗/token…", flush=True)
    print("[fail] 120s 未落地（微信未弹窗? 桌面微信未登录? 结构未标定?）——如实报败")
    return 3


if __name__ == "__main__":
    sys.exit(main())
