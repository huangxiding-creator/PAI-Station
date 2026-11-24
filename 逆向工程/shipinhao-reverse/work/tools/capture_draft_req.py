# -*- coding: utf-8 -*-
"""实捕 post_draft 真实请求：9222 新 tab 开发布页 → 监听 cgi → UI 上传测试片 → 存草稿。
产出: work/api_probe/captured_post_draft.json（请求头+体）+ 截图留档。
"""
import json
import pathlib
import sys
import time

sys.path.insert(0, r"F:/We-AIPO")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

TEST_VIDEO = r"E:/AI-Station/逆向工程/shipinhao-reverse/work/test/cli_test_clip.mp4"
OUT = pathlib.Path(r"E:/AI-Station/逆向工程/shipinhao-reverse/work/api_probe/captured_post_draft.json")


def find_file_input(tab):
    """跨 shadow/iframe 找 input[type=file]。"""
    js = r"""
    const out=[];
    const scan=(doc,label)=>{try{
      doc.querySelectorAll('input[type=file]').forEach((el,i)=>out.push({label:label+'#'+i,visible:!!(el.offsetWidth||el.offsetHeight)}));
    }catch(e){}};
    scan(document,'top');
    document.querySelectorAll('*').forEach(el=>{if(el.shadowRoot)scan(el.shadowRoot,'shadow')});
    for(const f of document.querySelectorAll('iframe')){try{scan(f.contentDocument,'iframe:'+f.src.slice(0,40))}catch(e){}}
    return JSON.stringify(out);
    """
    try:
        return json.loads(tab.run_js(js) or "[]")
    except Exception as e:
        print("FIND_INPUT_ERR:", e)
        return []


def main():
    co = ChromiumOptions().set_local_port(9222)
    page = ChromiumPage(addr_or_opts=co)
    tab = page.new_tab("https://channels.weixin.qq.com/platform/post/create")
    time.sleep(8)
    print("URL:", (tab.url or "")[:80])
    try:
        tab.listen.start("/cgi-bin/mmfinderassistant-bin/post/")
    except Exception as e:
        print("LISTEN_ERR:", e)
    # 上传文件
    inputs = find_file_input(tab)
    print("FILE_INPUTS:", json.dumps(inputs, ensure_ascii=False))
    done = False
    for spec in inputs:  # 不筛可见性：隐藏 input 走 CDP setFileInputFiles 照样能塞
        label = spec["label"]
        try:
            ele = tab.ele("css:input[type=file]")
            ele.input(TEST_VIDEO)
            done = True
            print("FILE_SET via", label)
            break
        except Exception as e:
            print("SET_FAIL", label, str(e)[:90])
    if not done:
        # 逐个 iframe 深挖（empty.htm 容器里的 input）
        try:
            frames = tab.eles("tag:iframe")
            for f in frames:
                try:
                    inner = f.ele("css:input[type=file]", timeout=2)
                    if inner:
                        inner.set.input(TEST_VIDEO)
                        done = True
                        print("FILE_SET via iframe", (f.attr("src") or "")[:50])
                        break
                except Exception as e:
                    pass
        except Exception as e:
            print("FRAME_ERR:", str(e)[:80])
    if not done:
        # 兜底：点击上传按钮触发 picker？禁止系统弹窗——改用 JS 直接注入 DataTransfer
        js = """
        const input=document.querySelector('input[type=file]');
        return input? 'TOP_INPUT_EXISTS':'NO_INPUT';
        """
        print("FALLBACK_CHECK:", tab.run_js(js))
    # 等上传完成（监听 uploadpartdfs/completepartuploaddfs 完成后出表单）
    deadline = time.time() + 120
    uploaded = False
    while time.time() < deadline:
        pkgs = []
        try:
            pkgs = tab.listen.steps(timeout=1)
        except Exception:
            pass
        for p in pkgs:
            u = getattr(p, "url", "") or ""
            if "completepartuploaddfs" in u:
                uploaded = True
        if uploaded:
            break
        time.sleep(2)
    print("UPLOADED:", uploaded)
    time.sleep(6)
    # 找 存草稿/保存草稿 按钮
    clicked = False
    for kw in ("存草稿", "保存草稿"):
        try:
            btn = tab.ele(f"text:{kw}", timeout=3)
            if btn:
                btn.click(by_js=True)
                clicked = True
                print("CLICKED:", kw)
                break
        except Exception as e:
            pass
    print("CLICKED:", clicked)
    time.sleep(6)
    # 收割监听包
    result = {"packets": []}
    try:
        pkgs = tab.listen.steps(timeout=3)
        for p in pkgs:
            entry = {"url": (getattr(p, "url", "") or "")[:150]}
            try:
                rb = p.requestBody
                entry["body"] = (rb if isinstance(rb, str) else json.dumps(rb, ensure_ascii=False))[:8000]
            except Exception:
                pass
            result["packets"].append(entry)
    except Exception as e:
        print("COLLECT_ERR:", e)
    try:
        tab.listen.stop()
    except Exception:
        pass
    OUT.write_text(json.dumps(result, ensure_ascii=False, indent=1), encoding="utf-8")
    print("SAVED:", OUT)
    for p in result["packets"]:
        print("PKT:", p["url"][:110])
        if p.get("body"):
            print("   BODY:", p["body"][:600])


if __name__ == "__main__":
    main()
