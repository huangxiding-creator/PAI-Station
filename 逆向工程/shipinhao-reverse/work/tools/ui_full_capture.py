# -*- coding: utf-8 -*-
"""终极实捕：XHR 钩子记录 post_draft 真实请求体 + 全 file input 塞文件 + 宽监听。
产物: work/api_probe/ui_true_payload.json
"""
import json
import pathlib
import sys
import time

sys.path.insert(0, r"F:/We-AIPO")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

TEST_VIDEO = r"E:/AI-Station/逆向工程/shipinhao-reverse/work/test/cli_test_clip.mp4"
OUT = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/api_probe/ui_true_payload.json")


def main():
    co = ChromiumOptions().set_local_port(9222)
    page = ChromiumPage(addr_or_opts=co)
    tab = None
    for t in page.get_tabs():
        if "channels.weixin.qq.com/platform" in (t.url or "") and "login" not in t.url:
            tab = t
            break
    if not tab:
        print("NO_LOGGED_TAB"); return 1
    try:  # 清挂起弹窗（此前空载荷点存草稿的 alert）
        tab.run_cdp("Page.handleJavaScriptDialog", accept=True)
    except Exception:
        pass
    try:
        tab.get("https://channels.weixin.qq.com/platform/post/create")
    except Exception as e:
        print("NAV_RETRY:", str(e)[:60])
        try:
            tab.run_cdp("Page.handleJavaScriptDialog", accept=True)
            tab.get("https://channels.weixin.qq.com/platform/post/create")
        except Exception:
            pass
    time.sleep(8)
    print("URL:", (tab.url or "")[:70])
    # XHR 钩子：记录 post_draft / post_create / post_preview 的请求体
    tab.run_js("""
      window.__bodies=[]; window.__urls=[];
      if(!window.__hooked){
        const oOpen=XMLHttpRequest.prototype.open, oSend=XMLHttpRequest.prototype.send;
        XMLHttpRequest.prototype.open=function(m,u){this.__u=String(u);return oOpen.apply(this,arguments)};
        XMLHttpRequest.prototype.send=function(d){
          try{ const u=this.__u||'';
            if(/post_(draft|create|preview)/.test(u) && d && typeof d==='string')
              window.__bodies.push({url:u.slice(0,200), body:d.slice(0,9000)});
            if(/completepartuploaddfs/.test(u)) window.__up=true;
          }catch(e){}
          return oSend.call(this,d);
        };
        window.__hooked=true;
      }
      return 'hooked';
    """, as_expr=True)
    # 宽监听（抓所有 finder 请求含上传 CDN?监听只能本进程 CDP 抓 cgi——上传 CDN 另域，用 XHR 钩子兜）
    try:
        tab.listen.start("/cgi-bin/mmfinderassistant-bin/")
    except Exception as e:
        print("LISTEN_ERR:", e)
    # 所有 file input（含 iframe）都塞文件
    results = []
    try:
        eles = tab.eles("css:input[type=file]")
        for i, ele in enumerate(eles):
            try:
                r = ele.input(TEST_VIDEO)
                results.append(f"ele#{i}:{'OK' if r else 'FAIL'}")
            except Exception as e:
                results.append(f"ele#{i}:ERR:{str(e)[:50]}")
        for f in tab.eles("tag:iframe"):
            try:
                for ele in f.eles("css:input[type=file]"):
                    try:
                        r = ele.input(TEST_VIDEO)
                        results.append("iframe:OK")
                    except Exception as e:
                        results.append("iframe:ERR:" + str(e)[:50])
            except Exception:
                pass
    except Exception as e:
        print("INPUT_ERR:", str(e)[:100])
    print("INPUT_RESULTS:", results)
    # 等上传完成：XHR 钩子的 __up 标记 或 页面出现向导第2步
    up = False
    for _ in range(60):
        time.sleep(2)
        up = tab.run_js("return !!window.__up")
        if up:
            break
    print("UPLOADED:", up)
    time.sleep(8)
    # 页面状态
    txt = tab.run_js("return (document.body.innerText||'').slice(0,300)") or ""
    print("PAGE:", txt.replace("\n", "|")[:220])
    # 点存草稿
    clicked = ""
    for kw in ("存草稿", "保存草稿", "保存"):
        try:
            btn = tab.ele(f"text:{kw}", timeout=2)
            if btn:
                btn.click(by_js=True)
                clicked = kw
                break
        except Exception:
            pass
    print("CLICKED:", clicked)
    time.sleep(6)
    bodies = tab.run_js("return JSON.stringify(window.__bodies||[])") or "[]"
    try:
        tab.listen.stop()
    except Exception:
        pass
    OUT.write_text(json.dumps({"bodies": json.loads(bodies), "clicked": clicked,
                               "uploaded": bool(up)}, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    print("SAVED:", OUT)
    for b in json.loads(bodies):
        print("CAPTURED:", b["url"][:100])
        print("  BODY[:900]:", b["body"][:900])


if __name__ == "__main__":
    main()
