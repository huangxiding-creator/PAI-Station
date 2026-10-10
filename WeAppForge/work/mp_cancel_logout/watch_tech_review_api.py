# -*- coding: utf-8 -*-
"""watch_tech_review_api.py — 总包科技(wxfdb) v1.2.0 审核状态盯哨·探测腿（控制台刮取版）.

背景: get_auditstatus API 直营号被 86000 拒(仅三方平台), 纯 API 路死;
getcodepage 版本管理页即真源, 沿用 1010 提审当日的 DrissionPage 9336 常驻配方。

输出 JSON verdict:
  RELEASED   线上版本已是 1.2.0（终态, 发布完成）
  PASS       审核通过待发布（触发翻转通知, 发布留给会话腿——哨兵不盲发外向动作）
  REJECT     审核驳回（带 reason 摘录）
  CHECKING   审核中（静默）
  SESSION_LOST 控制台登录态失效（一次性报警, 修好前不重复扰民）
  ERROR      异常（下轮再试）

Tier1: 常驻 Chrome 里已有 getcodepage tab → 直接 reload 解析;
Tier2: 无 tab → 开 mp 首页抓 token 拼 getcodepage URL; 抓不到 token = SESSION_LOST。
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402

TARGET = "1.2.0"


def parse_verdicts(tab):
    """解析 getcodepage 版本块 → (verdict, detail)。"""
    r = tab.run_js(r"""
return (function(){
  var blocks = document.querySelectorAll('.code_version_log');
  var out = [];
  for (var i = 0; i < blocks.length; i++) {
    var t = (blocks[i].innerText || '').replace(/\s+/g, ' ');
    out.push(t.slice(0, 220));
  }
  return JSON.stringify({n: blocks.length, blocks: out,
    url: location.href.slice(0, 90),
    loginish: (document.body.innerText || '').indexOf('扫码') >= 0 &&
              (document.body.innerText || '').indexOf('登录') >= 0});
})()
""")
    d = json.loads(r or "{}")
    if d.get("n", 0) == 0:
        if d.get("loginish"):
            return "SESSION_LOST", "login page"
        return "ERROR", f"no blocks, url={d.get('url')}"
    for b in d["blocks"]:
        if TARGET in b:
            if "线上版本" in b:
                return "RELEASED", b[:160]
            if "审核不通过" in b or "驳回" in b:
                m = re.search(r"(审核不通过|驳回).{0,140}", b)
                return "REJECT", (m.group(0) if m else b[:160])
            if "审核通过" in b:
                return "PASS", b[:160]
            if "审核中" in b:
                return "CHECKING", b[:120]
    return "CHECKING", f"1.2.0 block not seen; n={d['n']}"


def main() -> int:
    try:
        page = attach_or_launch()
    except Exception as e:  # noqa: BLE001
        print(json.dumps({"verdict": "ERROR", "detail": f"chrome: {type(e).__name__}: {e}"},
                         ensure_ascii=False))
        return 1

    tab = None
    for tid in page.tab_ids:
        t = page.get_tab(tid)
        if "mp.weixin.qq.com" in (t.url or "") and "getcodepage" in (t.url or ""):
            tab = t
            break

    try:
        if tab is not None:
            tab.get(tab.url)
            time.sleep(6)
            v, d = parse_verdicts(tab)
        else:
            home = page.new_tab("https://mp.weixin.qq.com/")
            time.sleep(5)
            r = home.run_js(r"""
return (function(){
  var a = document.querySelector('a[href*="token="]');
  if (!a) return '';
  var m = (a.href || '').match(/token=(\d+)/);
  return m ? m[1] : '';
})()
""")
            tok = (r or "").strip().strip('"')
            if not tok:
                home.close()
                print(json.dumps({"verdict": "SESSION_LOST", "detail": "no token on home"},
                                 ensure_ascii=False))
                return 1
            home.get(f"https://mp.weixin.qq.com/wxamp/wadevelopcode/getcodepage"
                     f"?token={tok}&lang=zh_CN")
            time.sleep(6)
            v, d = parse_verdicts(home)
    except Exception as e:  # noqa: BLE001
        print(json.dumps({"verdict": "ERROR", "detail": f"{type(e).__name__}: {e}"},
                         ensure_ascii=False))
        return 1

    print(json.dumps({"verdict": v, "detail": d}, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
