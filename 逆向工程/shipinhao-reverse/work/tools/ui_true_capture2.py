# -*- coding: utf-8 -*-
"""真实 UI 请求捕获 v2：新 tab + XHR 钩子 + 全 input 塞文件+change 派发 + 存草稿。
产物: work/api_probe/ui_true_payload2.json
"""
import json
import pathlib
import sys
import time

sys.path.insert(0, r"F:/We-AIPO")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

TEST_VIDEO = r"E:/AI-Station/逆向工程/shipinhao-reverse/work/test/cli_test_clip.mp4"
OUT = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/api_probe/ui_true_payload2.json")


def main():
    co = ChromiumOptions().set_local_port(9222)
    page = ChromiumPage(addr_or_opts=co)
    tab = page.new_tab("https://channels.weixin.qq.com/platform/post/create")
    time.sleep(10)
    print("URL:", (tab.url or "")[:70])
    try:
        tab.listen.start("/cgi-bin/mmfinderassistant-bin/")
    except Exception as e:
        print("LISTEN_ERR:", e)
    # XHR 钩子（新 tab 无污染）
    tab.run_js("""
      window.__bodies=[]; window.__up=false;
      const oOpen=XMLHttpRequest.prototype.open, oSend=XMLHttpRequest.prototype.send;
      XMLHttpRequest.prototype.open=function(m,u){this.__u=String(u);return oOpen.apply(this,arguments)};
      XMLHttpRequest.prototype.send=function(d){
        try{ const u=this.__u||'';
          if(/post_(draft|create|preview)|completepartuploaddfs|uploadpartdfs|applyuploaddfs/.test(u))
            window.__bodies.push({url:u.slice(0,240), body:(d&&typeof d==='string')?d.slice(0,9000):'(non-string)', ts:Date.now()});
          if(/completepartuploaddfs/.test(u)) window.__up=true;
        }catch(e){}
        return oSend.call(this,d);
      };
      window.__hooked=true;
    """, as_expr=True)
    # 逐个 input 塞文件 + change 派发
    log = []
    eles = tab.eles("css:input[type=file]")
    print("N_INPUTS:", len(eles))
    for i, ele in enumerate(eles):
        try:
            r = ele.input(TEST_VIDEO)
            ok1 = bool(r)
        except Exception as e:
            ok1 = False
            log.append(f"ele#{i}:input_err:{str(e)[:40]}")
        try:
            ele.run_js("this.dispatchEvent(new Event('change',{bubbles:true})); this.dispatchEvent(new Event('input',{bubbles:true})); return 'dispatched'")
        except Exception:
            try:
                tab.run_js(
                    "document.querySelectorAll('input[type=file]').forEach(el=>el.dispatchEvent(new Event('change',{bubbles:true}))); return 'd2'",
                    as_expr=True)
            except Exception:
                pass
        log.append(f"ele#{i}:set={'OK' if ok1 else 'FAIL'}")
        time.sleep(2)
        up = tab.run_js("return !!window.__up")
        log.append(f"ele#{i}:up={up}")
        if up:
            break
    print("LOG:", log)
    print("FILLED:", tab.run_js("return window.__filled"))
    # 等上传完成
    for _ in range(45):
        time.sleep(2)
        if tab.run_js("return !!window.__up"):
            break
    print("UPLOADED:", tab.run_js("return !!window.__up"))
    time.sleep(8)
    # 填标题（向导第2步字段，多文档探）
    tab.run_js("""
      const fill=(el,v)=>{el.value=v;el.dispatchEvent(new Event('input',{bubbles:true}));};
      const docs=[document];
      document.querySelectorAll('iframe').forEach(f=>{try{docs.push(f.contentDocument)}catch(e){}});
      let n=0;
      for(const d of docs){try{
        d.querySelectorAll('textarea,input[type=text],[contenteditable=true]').forEach(el=>{
          const ph=(el.getAttribute('placeholder')||'')+(el.getAttribute('aria-label')||'');
          if(/标题|短标题/.test(ph)&&n<1){fill(el,'CLI实捕测试(将删除)');n++;}
          else if(/介绍|描述|一句话/.test(ph)){fill(el,'真实载荷实捕,存完即删');}
        });
      }catch(e){}}
      window.__filled=n;
    """, as_expr=True)
    time.sleep(3)
    # 存草稿
    clicked = ""
    for kw in ("存草稿", "保存草稿"):
        try:
            btn = tab.ele(f"text:{kw}", timeout=3)
            if btn:
                btn.click(by_js=True)
                clicked = kw
                break
        except Exception:
            pass
    print("CLICKED:", clicked)
    time.sleep(8)
    bodies = tab.run_js("return JSON.stringify(window.__bodies||[])") or "[]"
    try:
        tab.listen.stop()
    except Exception:
        pass
    data = json.loads(bodies)
    OUT.write_text(json.dumps({"bodies": data, "clicked": clicked},
                              ensure_ascii=False, indent=1), encoding="utf-8")
    print("SAVED:", OUT, "n_bodies:", len(data))
    for b in data:
        print("CAP:", b["url"][:110])
        if b.get("body") and b["body"] != "(non-string)":
            print("   BODY[:700]:", b["body"][:700])


if __name__ == "__main__":
    main()
