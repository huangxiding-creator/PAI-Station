# -*- coding: utf-8 -*-
"""mp_cancel_logout driver — 独立 Chrome 实例驱动「取消注销」全链。

背景：MCP 共管浏览器被调研腿争抢（hide/show+重启毁标签页），二维码页无法存活。
本驱动用专属 profile + 端口 9336 的独立 Chrome，无争抢；二维码常驻窗口等扫。

用法（一次性调用，可反复重入）:
  python driver.py           # attach-or-launch + 状态机推进一轮，输出 JSON 状态

状态机:
  QR_WAIT      仍在二维码登录页（等管理员扫码）
  LOGGED_IN    已登录（URL 离开根页）
  ACT_<n>      取消注销链推进到第 n 步
  RESTORED     红条已消失/账号恢复（终态成功）
  NEED_USER    出现需人工/扫码确认的弹窗
  ERROR        异常（带 msg）

红线：绝不动控制台其他任何按钮。
"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

PORT = 9336
PROFILE = r"E:\AI-Station\data\state\mp_qr_profile"
FILING = Path(r"E:\AI-Station\WeAppForge\filing")
STATE_FILE = Path(__file__).parent / "state.json"
MP_ROOT = "https://mp.weixin.qq.com/"

from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402


def out(state, **kw):
    payload = {"state": state, "ts": time.strftime("%Y-%m-%d %H:%M:%S")}
    payload.update(kw)
    print(json.dumps(payload, ensure_ascii=True))
    STATE_FILE.write_text(json.dumps(payload, ensure_ascii=True, indent=2), encoding="utf-8")


def attach_or_launch():
    opts = ChromiumOptions()
    opts.set_local_port(PORT)
    opts.set_user_data_path(PROFILE)
    opts.set_argument("--window-size=1100,860")  # 默认即 headful：二维码须显示到桌面
    opts.set_argument("--no-first-run")
    try:
        page = ChromiumPage(addr_or_opts=opts)  # 已在跑则 attach，否则拉起
    except Exception as e:
        raise RuntimeError(f"attach_or_launch failed: {e}")
    return page


def qr_fresh(page):
    """二维码页是否新鲜（无过期遮罩）。"""
    try:
        txt = page.html or ""
        return ("已失效" not in txt) and ("点击刷新" not in txt)
    except Exception:
        return True


def main():
    try:
        page = attach_or_launch()
    except Exception as e:
        out("ERROR", msg=str(e)[:300])
        return 1

    try:
        tab = page.latest_tab
        url = tab.url or ""
        title = tab.title or ""

        # --- 状态判定 ---
        if "mp.weixin.qq.com" not in url:
            tab.get(MP_ROOT)
            url, title = tab.url, tab.title
            time.sleep(2)

        if url.rstrip("/") == MP_ROOT.rstrip("/") or "scanlogin" in url or title == "微信公众平台":
            fresh = qr_fresh(tab)
            if not fresh:
                tab.get(MP_ROOT)  # 过期遮罩 → 重载换新码
                time.sleep(2)
                fresh = qr_fresh(tab)
            out("QR_WAIT", url=url, title=title, qr_fresh=fresh)
            return 0

        # 已登录（URL 离开根页，带 token 的 /wxamp/ 或 cgi-bin 页）
        return act(tab, url)
    except Exception as e:
        out("ERROR", msg=str(e)[:300])
        return 1


def shot(tab, name):
    try:
        p = FILING / f"cancel_logout_{name}_{time.strftime('%H%M%S')}.png"
        tab.get_screenshot(path=str(p))
        return str(p)
    except Exception:
        return ""


def act(tab, url):
    """登录后：定位红横幅 → 查看详情 → 取消注销 → 验证。绝不动其他按钮。"""
    out("ACT_1_logged_in", url=url[:200])
    # 落到控制台首页
    if "/wxamp/index" not in url:
        token = ""
        if "token=" in url:
            token = url.split("token=")[1].split("&")[0]
        target = "https://mp.weixin.qq.com/wxamp/index/index" + (f"?token={token}&lang=zh_CN" if token else "")
        tab.get(target)
        time.sleep(3)
        url = tab.url
    if "登录超时" in (tab.html or ""):
        out("QR_WAIT", url=url[:200], note="login_timeout_shell")
        return 0

    # 找可见红横幅「小程序暂停服务」
    html = tab.html or ""
    if "暂停服务" not in html and "自主注销" not in html:
        out("RESTORED", url=url[:200], note="banner_gone_no_suspension_text", shot=shot(tab, "restored"))
        return 0

    banner = tab.ele('text:小程序暂停服务', timeout=5)
    if not banner:
        out("RESTORED", url=url[:200], note="no_visible_banner_element", shot=shot(tab, "nobanner"))
        return 0
    out("ACT_2_banner_found", shot=shot(tab, "banner"))

    # 点「查看详情」弹 weapp_forbid_dialog（banner 内或紧邻；兜底直接找弹窗链接）
    detail = tab.ele('text:查看详情', timeout=3)
    if detail:
        try:
            detail.click()
            time.sleep(2)
        except Exception as e:
            out("ACT_2b_detail_click_err", msg=str(e)[:200])
    cancel = tab.ele('@data-msgid=取消注销', timeout=6)
    if not cancel:
        # 兜底：也许 dialog 常渲染（非隐藏），直接可见即点
        cancel = tab.ele('text:取消注销', timeout=3)
    if not cancel:
        out("NEED_USER", note="cancel_link_not_found", shot=shot(tab, "nocancel"))
        return 0
    out("ACT_3_cancel_link_found", visible=cancel.states.is_displayed, shot=shot(tab, "dialog"))
    try:
        cancel.click()
        time.sleep(3)
    except Exception as e:
        out("ACT_3b_cancel_click_err", msg=str(e)[:200], shot=shot(tab, "clickerr"))
        return 1

    # 处理可能的确认弹窗（weui 对话框「确定」类）
    for label in ("确定", "确认"):
        try:
            btn = tab.ele(f'text:{label}', timeout=2)
            if btn and btn.states.is_displayed:
                btn.click()
                time.sleep(2)
                break
        except Exception:
            pass

    # 验证：重载首页看红条是否消失
    tab.get(tab.url)
    time.sleep(3)
    html2 = tab.html or ""
    gone = ("自主注销" not in html2) and ("暂停服务" not in html2)
    out("RESTORED" if gone else "ACT_4_still_present",
        url=tab.url[:200], shot=shot(tab, "after"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
