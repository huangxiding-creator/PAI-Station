# -*- coding: utf-8 -*-
"""audit_watch_130.py — 总包AI顾问 1.3.0 审核状态只读轮询（cron 值守件）。
用法: py -3 -X utf8 tools/audit_watch_130.py
输出: ONLINE_130 / AUDIT_PASS / AUDITING / AUDIT_REJECT / UNKNOWN + detail
纪律: 只读不动 DOM；读完 page.quit() 关 9338（浏览器用完即清铁律）。
1023修正: 弃整页宽松正则（曾误报ONLINE_130），改 .code_version_log 块级精确解析
（微信版本页块序实测: [0]=线上版本块 [1]=审核版本块 [2]=开发版本块）。"""
import sys, re, json, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
try:
    tok = ""
    m = re.search(r"token=(\d+)", page.url or "")
    if not m:
        page.get("https://mp.weixin.qq.com/")
        time.sleep(5)
        m = re.search(r"token=(\d+)", page.url or "")
    if not m:
        print("UNKNOWN login-lost（需扫码续期，通知用户）"); sys.exit(0)
    tok = m.group(1)
    page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
    time.sleep(8)
    raw = None
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "getcodepage" in (t.url or ""):
            raw = t.run_js("return JSON.stringify(Array.from(document.querySelectorAll('.code_version_log')).map(function(b){return (b.innerText||'').split(NL).join(' ')}))".replace("NL", "String.fromCharCode(10)"))
            break
    if not raw:
        print("UNKNOWN no-version-tab"); sys.exit(0)
    blocks = json.loads(raw)
    if not blocks:
        print("UNKNOWN empty-blocks"); sys.exit(0)
    online_b = blocks[0] or ""
    audit_b = blocks[1] if len(blocks) > 1 else ""
    seg = re.sub(r"\s+", " ", audit_b)[:200]
    if "1.3.0" in online_b:                      # 线上块本身就是 1.3.0 → 已放量
        print("ONLINE_130 已放量上线 " + re.sub(r"\s+", " ", online_b)[:140])
    elif "审核中" in audit_b:
        print("AUDITING " + seg[:120])
    elif "审核不通过" in audit_b or "审核失败" in audit_b:
        print("AUDIT_REJECT " + seg[:180])
    elif "审核通过" in audit_b:
        print("AUDIT_PASS " + seg[:120])
    elif "1.3.0" in audit_b:
        print("AUDITING(块状推断) " + seg[:120])
    else:
        print("UNKNOWN audit-block=" + seg[:120])
finally:
    try: page.quit()
    except Exception: pass
