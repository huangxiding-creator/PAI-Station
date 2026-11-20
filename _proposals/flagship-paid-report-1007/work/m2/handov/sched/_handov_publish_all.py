# -*- coding: utf-8 -*-
"""_handov_publish_all — 第20份HANDOV 3稿自动发表收尾腿.
流程: 等永动机浏览器收工(轮询chrome by browser_profiles, 最多40分钟)
→ 逐号(acct05→acct01→acct07)自起浏览器(cookie注入+核号)
→ list_ex定位稿 → 列表页点行内publish-op → 全body搜「继续发表」点击
→ 金标准验证(草稿从箱里消失) → 汇总.
用法: py -X utf8 _handov_publish_all.py
"""
import json
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

KB = r"E:\AI-Station\电力KB收割"
PROFILE_DIR = r"F:\We-AIPO\autopub\data\browser_profiles"
PORTS = {"acct01": 9342, "acct05": 9341, "acct07": 9343}
EXPECT = {"acct01": "总包说", "acct05": "总包之声", "acct07": "工程行业大脑"}
TARGETS = [
    ("acct05", "发布| 《EPC竣工验收与移交实务实战研究报告》", "竣工验收与移交实务实战研究报告"),
    ("acct01", "工程交出去了，钱和责任什么时候交割完？", "钱和责任什么时候交割完"),
    ("acct07", "业主扣着质保金说工程有质量问题，法院怎么判？", "质保金说工程有质量问题"),
]


def autopub_chrome_count() -> int:
    try:
        out = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "(Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
             "Where-Object {$_.CommandLine -match 'browser_profiles'}).Count"],
            capture_output=True, text=True, timeout=30)
        return int((out.stdout or "0").strip() or 0)
    except Exception:
        return 0


def wait_autopub_done(max_s: int = 9000):
    print("[wait] 等永动机浏览器收工...", flush=True)
    t0 = time.time()
    idle = 0
    while time.time() - t0 < max_s:
        n = autopub_chrome_count()
        if n == 0:
            idle += 1
            if idle >= 3:
                print("[wait] 永动机已收工 (连续3次零进程)", flush=True)
                return True
        else:
            idle = 0
        time.sleep(60)
    print("[wait] 超时, 永动机仍在跑 — 放弃本轮", flush=True)
    return False


def shot(page, name):
    try:
        page.get_screenshot(str(f"{KB}/handov_all_{name}.png"))
    except Exception:
        pass


def publish_one(acct: str, title_short: str) -> int:
    port = PORTS[acct]
    co = ChromiumOptions()
    co.set_local_port(port)
    co.set_user_data_path(rf"{PROFILE_DIR}\{acct}")
    co.set_argument("--start-minimized")
    page = ChromiumPage(co)
    try:
        # 登录态
        cred = json.load(open(rf"{KB}\mp_cred_{acct}.json", encoding="utf-8"))
        page.get("https://mp.weixin.qq.com/")
        time.sleep(3)
        m = re.search(r"token=(\d+)", page.url or "")
        if not m:
            page.set.cookies(cred["cookies"])
            time.sleep(1)
            page.get("https://mp.weixin.qq.com/")
            time.sleep(4)
            m = re.search(r"token=(\d+)", page.url or "")
        tok = m.group(1) if m else ""
        print(f"[{acct}] token: {tok or 'DEAD'}", flush=True)
        if not tok:
            return 3
        if EXPECT[acct] not in (page.html or ""):
            print(f"[{acct}] 账号核对失败, 中止", flush=True)
            return 2
        # 金标准预检: 稿在箱
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN")
        time.sleep(2)
        raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=50', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
        items = json.loads(raw or "{}").get("app_msg_list") or []
        if not any(title_short in (it.get("title") or "") for it in items):
            print(f"[{acct}] 稿不在箱 (可能已发), 金标准另验", flush=True)
            return 0
        # 列表页点 publish-op
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN&type=77")
        time.sleep(4)
        r = ""
        for tick in range(20):
            time.sleep(2)
            try:
                r = page.run_js("""
return (function(){
  var all=document.querySelectorAll('*'); var target=null;
  for (var i=0;i<all.length;i++){
    var t=(all[i].innerText||'');
    if(t.indexOf('%KEY%')>=0 && (!target || all[i].innerText.length<target.innerText.length)) target=all[i];
  }
  if(!target) return 'row-not-found';
  var row=target;
  for (var d=0;d<10 && row;d++){
    var ops=row.querySelectorAll('.weui-desktop-publish__op, [class*=publish__op]');
    if(ops.length){ var ev=new MouseEvent('mouseover',{bubbles:true}); row.dispatchEvent(ev); ops[0].click(); return 'clicked-op'; }
    row=row.parentElement;
  }
  return 'no-op';
})()
""".replace("%KEY%", title_short))
            except Exception as e:
                r = "err:" + str(e)[:40]
            if str(r).startswith("clicked"):
                break
        print(f"[{acct}] publish-op: {r}", flush=True)
        if not str(r).startswith("clicked"):
            return 5
        # 弹层: 全 body 搜「继续发表」(精确) 优先, 退而「发表/确定」
        clicked = ""
        for tick in range(30):
            time.sleep(2)
            try:
                s = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var wants=['继续发表','发 表','发表','确定','确认'];
  var btns=document.querySelectorAll('button, [role=button], a, .weui-desktop-btn');
  for (var w=0;w<wants.length;w++){
    for (var i=0;i<btns.length;i++){
      var t=(btns[i].innerText||'').replace(/[\\s\\u00a0]+/g,'').trim();
      if(t===wants[w] && vis(btns[i])){ btns[i].click(); return 'ok:'+wants[w]; }
    }
  }
  var mod=document.querySelectorAll('.weui-desktop-dialog,[class*=modal],[class*=dialog],[class*=popover]');
  for (var i=0;i<mod.length;i++){
    if(!vis(mod[i]))continue;
    var txt=(mod[i].innerText||'').replace(/\\s+/g,' ').slice(0,60);
    if(txt) return 'layer:'+txt;
  }
  return '';
})()
""")
            except Exception:
                s = ""
            if str(s).startswith("ok:"):
                clicked = s
                print(f"[{acct}] [{tick*2}s] 点了 {s}", flush=True)
                time.sleep(3)
                # 继续发表后可能再有确认
                continue
            if s:
                print(f"[{acct}] [{tick*2}s] {str(s)[:60]}", flush=True)
            if "群发通知" in str(s) or "已开启" in str(s):
                continue
        shot(page, f"{acct}_confirm")
        # 金标准: 草稿消失
        ok = False
        for _ in range(5):
            time.sleep(6)
            try:
                page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN")
                time.sleep(2)
                raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=50', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
                items = json.loads(raw or "{}").get("app_msg_list") or []
                still = any(title_short in (it.get("title") or "") for it in items)
                if not still:
                    ok = True
                    break
            except Exception:
                pass
        print(f"[{acct}] 金标准(草稿消失): {'PASS' if ok else 'FAIL'}", flush=True)
        return 0 if ok else 6
    finally:
        try:
            page.quit()
        except Exception:
            pass


def main() -> int:
    if not wait_autopub_done():
        return 1
    time.sleep(30)  # 收工缓冲
    results = {}
    for acct, title, short in TARGETS:
        print(f"\n===== {acct} ({EXPECT[acct]}) =====", flush=True)
        results[acct] = publish_one(acct, short)
        time.sleep(20)
    print("\n===== 汇总 =====")
    for k, v in results.items():
        print(k, EXPECT[k], "→", "OK" if v == 0 else f"rc={v}")
    return 0 if all(v == 0 for v in results.values()) else 2


if __name__ == "__main__":
    raise SystemExit(main())
