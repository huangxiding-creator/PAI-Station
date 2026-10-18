# -*- coding: utf-8 -*-
"""vp_publish_10000.py — report_10000（¥10,000 蓝皮书道具）现网发布。

流程: attach 9336 → live_token → skit 道具配置页 → DUMP 验行(未发布) → click("发布")
→ 处理原生确认(确定) → 轮询管理员扫码框(qrcheck-caas-dialog) → 出码即企微文字召唤一次
→ 等扫(≤10min) → 点确认尾巴 → 复查行翻「已发布」→ 截图留档。

纪律: QR 图只留桌面 9336 窗口给用户扫，不发企微（扫码召唤协议）；企微只发一次。
"""
import json
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402
from vpay_item_create import DUMP, click  # noqa: E402

PRODUCT_ID = "report_10000"
AI_STATION = r"E:\AI-Station"
NOTIFY = r"E:\AI-Station\tools\notify_wecom.py"

# 抄 vp_publish_rest.py 实弹配方：qrcheck 弹窗 + 二维码 img src 判可见
QR_JS = """
(() => {
  const w = document.getElementById('qrcheck-caas-dialog');
  if (!w) return 'no-el';
  let vis = true;
  try { vis = getComputedStyle(w).display !== 'none'; } catch (e) {}
  const img = w.querySelector('.weui-desktop-qrcheck__img');
  return (vis && img && img.src) ? 'QR-VISIBLE' : 'hidden';
})()
"""


def dump_txt(tab):
    parts = json.loads(tab.run_js(DUMP) or "[]")
    return "\n".join(p.get("txt", "") for p in parts)


def row_state(txt):
    """返回 report_10000 行的状态：published / unpublished / absent。
    先把片段截断到本行边界（下一个 report_/export_ 行首），再按位置取最近的
    未发布/已发布——否则窗口漏进邻行的「已发布」会假绿（首跑实锤）。"""
    i = txt.find(PRODUCT_ID)
    if i < 0:
        return "absent"
    seg = txt[i:i + 400]
    cut = len(seg)
    for marker in ("\nreport_", "\nexport_once"):
        j = seg.find(marker, 10)
        if j > 0:
            cut = min(cut, j)
    seg = seg[:cut]
    u, p = seg.find("未发布"), seg.find("已发布")
    if u >= 0 and (p < 0 or u < p):
        return "unpublished"
    if p >= 0:
        return "published"
    return "unclear"


def qr_state(tab):
    try:
        r = tab.run_cdp("Runtime.evaluate", expression=QR_JS, returnByValue=True)
        return (r.get("result") or {}).get("value", "err")
    except Exception as e:  # noqa: BLE001
        return "eval-err:" + str(e)[:60]


def wecom_summon():
    """扫码召唤协议：企微文字叫用户（30秒动作），QR 图不发企微只留桌面窗口。"""
    try:
        subprocess.run(
            ["python", NOTIFY,
             "蓝皮书道具发布需扫码确认（30秒）",
             "微信虚拟支付后台弹出了管理员扫码确认框：需要您在桌面 Chrome 窗口（9336）里用微信扫一下，"
             "确认把 ¥10,000 蓝皮书道具发布到线上。扫完会自动继续，无需其他操作。"],
            cwd=AI_STATION, capture_output=True, timeout=40,
            creationflags=0x08000000,  # CREATE_NO_WINDOW
        )
        return True
    except Exception as e:  # noqa: BLE001
        print("wecom_err:" + str(e)[:80], file=sys.stderr, flush=True)
        return False


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(10)
    res = {"token": token, "pid": PRODUCT_ID}

    res["c_base"] = click(tab, "基本配置")
    time.sleep(6)
    res["c_itemcfg"] = click(tab, "道具配置")
    time.sleep(5)

    pre = dump_txt(tab)
    res["pre_state"] = row_state(pre)
    if res["pre_state"] == "published":
        res["skip"] = True  # 已是现网态，幂等退出
        print(json.dumps(res, ensure_ascii=False))
        return 0
    if res["pre_state"] != "unpublished":
        res["err"] = f"行态异常: {res['pre_state']}（截图排查）"
        shot(tab, "vp_pub10000_pre_anomaly")
        print(json.dumps(res, ensure_ascii=False))
        return 1

    print("== stage: click publish ==", file=sys.stderr, flush=True)
    res["c_pub"] = click(tab, "发布")
    time.sleep(3)
    # 原生确认框（若有）: 精确词「确定」
    res["c_confirm"] = click(tab, "确定")
    time.sleep(4)

    # 轮询 ≤90s：QR 出现 / 行已翻 / 再点确认尾巴
    qr_seen = ""
    deadline = time.time() + 90
    while time.time() < deadline:
        st = qr_state(tab)
        if st == "QR-VISIBLE":
            qr_seen = st
            break
        if row_state(dump_txt(tab)) == "published":
            break
        click(tab, "确定")
        time.sleep(4)
    res["qr"] = qr_seen or "none"

    if qr_seen:
        shot(tab, "vp_pub10000_qr")  # 留档（窗口本身就在桌面给用户扫）
        res["wecom_sent"] = wecom_summon()
        # 等扫码 ≤10min；QR 消失即扫完
        wait_deadline = time.time() + 600
        while time.time() < wait_deadline:
            if qr_state(tab) != "QR-VISIBLE":
                break
            time.sleep(8)
        res["qr_closed"] = qr_state(tab) != "QR-VISIBLE"
        time.sleep(2)
        click(tab, "确定")
        time.sleep(2)
        click(tab, "我知道了")

    time.sleep(8)
    post = dump_txt(tab)
    res["post_state"] = row_state(post)
    if res["post_state"] != "published":
        # 表可能要刷新才回填——重走导航再验一次
        tab.get(root)
        time.sleep(8)
        click(tab, "基本配置")
        time.sleep(5)
        click(tab, "道具配置")
        time.sleep(5)
        post2 = dump_txt(tab)
        res["post_state2"] = row_state(post2)
        res["final"] = res["post_state2"]
    else:
        res["final"] = res["post_state"]

    res["shot_done"] = shot(tab, "vp_pub10000_done")
    print(json.dumps(res, ensure_ascii=False))
    return 0 if res.get("final") == "published" else 1


if __name__ == "__main__":
    raise SystemExit(main())
