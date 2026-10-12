# -*- coding: utf-8 -*-
"""cover_edit — 视频号已发内容原位改封面（1012 用户令「封面不好看/世界级审美」）。

DrissionPage 独立实例（E:\AI-Station\data\state\sph_profile，9337 口）+ 注入
video_account_state.json 的 cookies（playwright storage_state 格式）→ 打开
内容管理列表 → 找蓝皮书行 → 探编辑/改封面口子。只侦察不点击（stage=recon），
stage=apply 时点击换封面并上传 bluebook_v1_cover.png。
用法: python -X utf8 cover_edit.py [recon|apply]
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

STATE = Path(r"E:\AI-Station\report_platform\promo\video_account_state.json")
COVER = Path(r"E:\AI-Station\report_platform\promo\videos\bluebook_v1_cover.png")
PORT = 9337
PROFILE = r"E:\AI-Station\data\state\sph_profile"


def build_page() -> ChromiumPage:
    co = ChromiumOptions()
    co.set_local_port(PORT)
    co.set_user_data_path(PROFILE)
    co.headless(False)
    return ChromiumPage(co)


def inject_cookies(page: ChromiumPage) -> bool:
    d = json.loads(STATE.read_text(encoding="utf-8"))
    cookies = d.get("cookies") or []
    ok = 0
    for c in cookies:
        try:
            page.set.cookies(c)
            ok += 1
        except Exception:
            pass
    return ok > 0


def main(stage: str = "recon") -> int:
    page = build_page()
    try:
        page.get("https://channels.weixin.qq.com/")
        inject_cookies(page)
        page.get("https://channels.weixin.qq.com/platform/post/list")
        time.sleep(8)
        url = page.url or ""
        print("url:", url[:90])
        txt = (page.run_js("return (document.body.innerText||'').slice(0,800);") or "")
        hit = txt.find("工程总承包这门生意")
        print("bluebook post in list:", "YES" if hit >= 0 else "NO")
        # 行内操作区探测：找蓝皮书行的按钮/菜单词
        r = page.run_js(r"""
        return (function(){
          var t = document.body.innerText || '';
          var i = t.indexOf('工程总承包这门生意');
          if (i < 0) return 'no-row';
          var seg = t.slice(Math.max(0,i-200), i+500);
          return seg.replace(/\n+/g, ' | ').slice(0, 400);
        })();
        """)
        print("row ctx:", r)
        # 全页找 编辑/封面 相关可点元素
        r2 = page.run_js(r"""
        return (function(){
          var out = [];
          var els = document.querySelectorAll('a, button, span, div[role=button]');
          for (var i=0;i<els.length;i++){
            var e = els[i];
            var t = (e.innerText||'').trim();
            var rc = e.getBoundingClientRect();
            if (t && t.length<=8 && rc.width>0 && /编辑|封面|修改|更多|操作/.test(t)){
              out.push(t+'['+Math.round(rc.x)+','+Math.round(rc.y)+']');
            }
          }
          return out.slice(0,15).join(' ') || 'none';
        })();
        """)
        print("edit affordances:", r2)
        return 0
    finally:
        if stage == "recon":
            time.sleep(2)


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1] if len(sys.argv) > 1 else "recon"))
