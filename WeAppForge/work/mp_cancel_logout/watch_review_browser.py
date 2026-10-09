# -*- coding: utf-8 -*-
"""watch_review_browser.py — 提审结果盯哨浏览器腿（9336 专属 Chrome，零外向动作）.

为什么是浏览器腿：官方 get_latest_auditstatus 是第三方平台专属端点（自研号直调
errcode 86000 实证），自研小程序无免登录 API 可查审核状态 → 只能读控制台版本管理页
（finish_review_0912.py 同款读法：getcodepage 标签 reload → 找目标版本行状态词）。

不扰民铁律：先 socket 探 9336，端口不在（机器重启后未拉起）→ SKIP 静默返回，
绝不冷启动 headful Chrome 弹窗；通道活着才 attach 读一轮。

用法: python watch_review_browser.py  → JSON 单行 verdict:
  APPROVED(审核通过/已发布——触发企微通知，发布六步清单就位)
  REJECTED(审核被拒——触发通知，修复重提)
  PENDING (审核中，静默)
  SKIP    (9336 通道不在跑，静默下轮)
  AUTH_EXPIRED(mp 登录态失效，静默——但翻转进 state 供会话腿看到)
  ERROR   (异常，静默下轮)
"""
import json
import socket
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

PORT = 9336
WATCH_VER = "0.9.12"  # 本次盯哨的目标提审版本
GETCODE = "https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage"

JS_READ_ROW = r"""
return (function(){
  var body = document.body.innerText || '';
  if (body.indexOf('登录超时') >= 0 || body.indexOf('扫码登录') >= 0){
    return JSON.stringify({verdict:'AUTH_EXPIRED'});
  }
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var el = els[i]; var own=false;
    for (var k=0;k<el.childNodes.length;k++){
      var n = el.childNodes[k];
      if (n.nodeType===3 && n.textContent.trim()==='""" + WATCH_VER + r"""'){own=true;break;}
    }
    if (own){
      var node = el;
      for (var d=0; d<8 && node; d++){
        var t2 = (node.innerText||'').replace(/\s+/g,'|');
        if (t2.length>10 && t2.length<600 && t2.indexOf('""" + WATCH_VER + r"""')>=0){
          return JSON.stringify({verdict:'ROW', row:t2.slice(0,220)});
        }
        node = node.parentElement;
      }
    }
  }
  return JSON.stringify({verdict:'NO_ROW', hasBody: body.length>200});
})();
"""


def port_alive(port: int) -> bool:
    with socket.socket() as s:
        s.settimeout(1.5)
        return s.connect_ex(("127.0.0.1", port)) == 0


def classify(row: str) -> str:
    if any(k in row for k in ("审核通过", "已发布", "线上版本")):
        return "APPROVED"
    if any(k in row for k in ("审核不通过", "驳回", "审核失败")):
        return "REJECTED"
    return "PENDING"  # 审核中/已提交审核 等流转态


def main() -> int:
    if not port_alive(PORT):
        print(json.dumps({"verdict": "SKIP", "detail": "9336 not running"},
                         ensure_ascii=False))
        return 0
    try:
        from DrissionPage import ChromiumOptions, ChromiumPage
        opts = ChromiumOptions()
        opts.set_local_port(PORT)  # 只 attach，绝不带 profile 冷启动
        page = ChromiumPage(addr_or_opts=opts)

        tab = next((t for t in page.get_tabs() if "getcodepage" in (t.url or "")), None)
        if tab is None:
            # 从任一登录态标签 harvest token 开一页（无登录态标签 → AUTH_EXPIRED）
            logged = next((t for t in page.get_tabs()
                           if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or "")), None)
            if logged is None:
                print(json.dumps({"verdict": "AUTH_EXPIRED"}, ensure_ascii=False))
                return 0
            token = (logged.url or "").split("token=")[1].split("&")[0]
            tab = page.new_tab(f"{GETCODE}?token={token}&lang=zh_CN")
            time.sleep(6)
        tab.run_js("location.reload();")
        time.sleep(9)
        r = tab.run_js(JS_READ_ROW)
        res = json.loads(r or "{}")
        v = res.get("verdict", "ERROR")
        if v == "NO_ROW" and not res.get("hasBody"):
            time.sleep(5)  # 首次 reload 未渲染完（僵尸标签冷加载慢）→ 再读一轮
            r = tab.run_js(JS_READ_ROW)
            res = json.loads(r or "{}")
            v = res.get("verdict", "ERROR")
        if v == "ROW":
            out = {"verdict": classify(res.get("row", "")), "row": res.get("row", "")}
        elif v in ("AUTH_EXPIRED", "NO_ROW"):
            out = {"verdict": v, "detail": res.get("hasBody", "")}
        else:
            out = {"verdict": "ERROR", "detail": r[:200] if r else "empty"}
        print(json.dumps(out, ensure_ascii=False))
        return 0
    except Exception as e:  # noqa: BLE001 — 任何异常如实降级 ERROR
        print(json.dumps({"verdict": "ERROR", "detail": f"{type(e).__name__}: {e}"[:250]},
                         ensure_ascii=False))
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
