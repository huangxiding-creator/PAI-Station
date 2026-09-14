"""metaso 专题库上传（M2.5 收尾）：自动登录 + 5 个 DOCX → 01、混沌学园。

借鉴 We-AIPO metaso_uploader 生产验证配方（安全：只上传，绝不删除）：
- 自动登录：登录态 markers 预检 → 点登录 → 账号密码 tab → 填凭据 →
  JS 勾协议（policy-checkbox 容器）→ 登录按钮 → 轮询 60s →
  验证码墙自动整轮重试一次（重导航+重填，滑块常为一次性）
- 上传：页面内 fetch() PUT /api/file/{cfid}，FormData + credentials=
  'include'（meta-token 是只读 token，加 header 反而覆盖 cookie 的
  写权限 → "您没有权限"，故上传绝不带 token 头）
- DOCX 二进制：Python 读 bytes → base64 → JS atob → Uint8Array → Blob
- 去重/验证：GET /api/knowledge/{sid}/search?parentId={cfid}（读接口
  带 token 头合法）；errCode 0=成功 1=已存在
用法: python scripts/metaso_upload.py
"""
import base64
import configparser
import json
import os
import sys
import time

from DrissionPage import ChromiumOptions, ChromiumPage

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "data", "hundun")
SECRET = os.path.join(ROOT, "config", "metaso.secret.ini")
SID = "8673582927558737920"
CFID = "2096794656849395712"
URL = f"https://metaso.cn/subject-v2/{SID}/manage?cfid={CFID}"
LOGIN_URL = "https://metaso.cn"
MARKERS = ("text:退出登录", "text:个人中心", "text:我的会员", "text:账号信息")
MIME = ("application/vnd.openxmlformats-officedocument"
        ".wordprocessingml.document")

FILES = [
    os.path.join(DATA, "AI时代的品牌营销_GEO背后的消费重塑与品牌表达.docx"),
    os.path.join(DATA, "AI原生组织转型_不是转型组织来用好AI_而是用AI来替代组织.docx"),
    os.path.join(DATA, "AI时代下的组织归核_从使用人到成就人.docx"),
    os.path.join(DATA, "技能卡总览_混沌学园13张.docx"),
    os.path.join(DATA, "学习笔记_混沌学园三门课.docx"),
]


def _creds():
    cp = configparser.ConfigParser()
    cp.read(SECRET, encoding="utf-8")
    return (cp.get("metaso", "account", fallback=""),
            cp.get("metaso", "password", fallback=""))


def _logged_in(page) -> bool:
    for marker in MARKERS:
        try:
            if page.ele(marker, timeout=1):
                return True
        except Exception:
            continue
    return False


def _tick_agreement(page) -> None:
    try:
        page.run_js(
            "var c=document.querySelector('input[name=\"policy-checkbox\"]');"
            "if(c){var b=c.closest('.MuiCheckbox-root,.MuiButtonBase-root')"
            "||c.parentElement;if(b)b.click();}")
    except Exception:
        pass


def _try_login(page, account: str, password: str) -> bool:
    """一轮 We-AIPO 配方自动登录；成功 True。"""
    page.get(LOGIN_URL, timeout=30)
    time.sleep(3)
    if _logged_in(page):
        return True
    page.ele("text:登录", timeout=5).click()
    time.sleep(1)
    try:
        page.ele("text:账号密码", timeout=5).click()
    except Exception:
        pass
    time.sleep(1)
    phone = (page.ele("@@tag()=input@@type=number", timeout=5)
             or page.ele("@@tag()=input@@type=tel", timeout=3))
    if phone:
        phone.input(account)
    pwd = page.ele("@@tag()=input@@type=password", timeout=5)
    if pwd:
        pwd.input(password)
    _tick_agreement(page)
    for label in ("登 录", "登　录", "登录"):
        btn = page.ele(f"text:{label}", timeout=3)
        if btn:
            btn.click()
            break
    for _ in range(30):  # 60s：可能弹验证码
        time.sleep(2)
        if _logged_in(page):
            return True
    return False


def _ensure_login(page, account: str, password: str) -> bool:
    if _try_login(page, account, password):
        return True
    # 验证码墙≠终点：自动整轮重试一次（We-AIPO PU3d：滑块常为一次性）
    print("[login] 首轮未成（可能验证码）——自动重试一轮")
    return _try_login(page, account, password)


def _get_token(page):
    try:
        return page.run_js(
            "var m=document.querySelector('meta[id=\"meta-token\"]');"
            "return m?m.getAttribute('content'):null;")
    except Exception:
        return None


def _list_files(page, token: str) -> list:
    """目录文件清单（读接口，token 头合法）。失败返回 []。"""
    if not token:
        return []
    js = f"""
    return (async () => {{
        try {{
            const resp = await fetch(
                'https://metaso.cn/api/knowledge/{SID}/search?s=&parentId={CFID}'
                + '&pageSize=200&pageIndex=0&sort=updateTime&sortDirection=desc',
                {{headers: {{'token': {json.dumps(token)}}}}});
            const data = await resp.json();
            return JSON.stringify((data.data&&(data.data.content||data.data.list))||data.list||[]);
        }} catch(e) {{ return '[]'; }}
    }})();
    """
    try:
        raw = page.run_js(js, timeout=30) or "[]"
        items = json.loads(raw)
        return [it.get("fileName") or it.get("name") or "" for it in items]
    except Exception:
        return []


def _norm(name: str) -> str:
    import re
    s = re.sub(r"\.[a-zA-Z0-9]+$", "", name)
    return re.sub(r"[\s\W_]+", "", s, flags=re.UNICODE).lower()


def _upload_docx(page, path: str) -> tuple:
    """页面内 fetch PUT 上传单个 DOCX → (ok, detail)。"""
    fname = os.path.basename(path)
    with open(path, "rb") as fh:
        b64 = base64.b64encode(fh.read()).decode("ascii")
    # 分块注入（避免超长脚本；文件均 <150KB，通常 1 块）
    chunks = [b64[i:i + 200000]
              for i in range(0, len(b64), 200000)] or [""]
    page.run_js(f"window.__pai_b64 = {json.dumps(chunks[0])};")
    for chunk in chunks[1:]:
        page.run_js(f"window.__pai_b64 += {json.dumps(chunk)};")
    fname_js = json.dumps(fname, ensure_ascii=False)
    js = f"""
    return (async () => {{
        try {{
            const b64 = window.__pai_b64; window.__pai_b64 = '';
            const bin = atob(b64);
            const bytes = new Uint8Array(bin.length);
            for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
            const blob = new Blob([bytes], {{type: {json.dumps(MIME)}}});
            const form = new FormData();
            form.append('file', blob, {fname_js});
            form.append('fileName', {fname_js});
            form.append('type', 'docx');
            const resp = await fetch('/api/file/{CFID}', {{
                method: 'PUT', body: form, credentials: 'include'
            }});
            const txt = await resp.text();
            return resp.status + '||' + txt;
        }} catch(e) {{ return '0||' + e.message; }}
    }})();
    """
    try:
        result = page.run_js(js, timeout=120)
    except Exception as exc:
        return False, f"JS执行失败: {exc}"
    status, _, body = str(result).partition("||")
    if status != "200":
        return False, f"HTTP {status}: {body[:120]}"
    try:
        err = json.loads(body).get("errCode", -99)
    except ValueError:
        return False, f"非JSON响应: {body[:120]}"
    if err == 0:
        return True, "errCode=0"
    if err == 1:
        return True, "errCode=1(已存在)"
    return False, f"errCode={err}: {body[:120]}"


def main():
    missing = [f for f in FILES if not os.path.exists(f)]
    if missing:
        print("[upload] 缺文件:", missing)
        return 1
    account, password = _creds()
    if not account or not password:
        print("[upload] config/metaso.secret.ini 缺账号/密码")
        return 1
    co = ChromiumOptions()
    co.headless(False)  # 自动填凭据不需人工介入；可见窗口利于滑块风控通过率
    co.set_user_data_path(os.path.join(ROOT, "data", "browser_profile"))
    co.set_local_port(9333)
    co.set_argument("--no-first-run")
    co.set_argument("--disable-blink-features=AutomationControlled")
    co.set_argument("--window-size=1280,900")
    page = ChromiumPage(co)
    try:
        if not _ensure_login(page, account, password):
            page.get_screenshot(os.path.join(DATA, "_recon",
                                             "login_failed.png"))
            print("[upload] 自动登录失败（已截图 _recon/login_failed.png）")
            return 2
        print("[login] 登录成功")
        page.get(URL, timeout=30)
        time.sleep(3)
        token = _get_token(page)
        if not token:
            time.sleep(3)
            token = _get_token(page)
        if not token:
            print("[upload] 未取到 meta-token（可能未登录或页面变化）")
            return 2
        existing = {_norm(n) for n in _list_files(page, token)}
        print(f"[upload] 目录现有 {len(existing)} 个文件")
        ok, skip, fail = 0, 0, []
        for path in FILES:
            fname = os.path.basename(path)
            if _norm(fname) in existing:
                print(f"  [skip] {fname}（已存在）")
                skip += 1
                continue
            good, detail = _upload_docx(page, path)
            print(f"  [{'OK' if good else 'FAIL'}] {fname}: {detail}")
            if good:
                ok += 1
            else:
                fail.append(fname)
            time.sleep(3)
        # 终验：目录清单复核
        final = {_norm(n) for n in _list_files(page, token)}
        verified = sum(1 for f in FILES if _norm(os.path.basename(f)) in final)
        print(f"\n[done] 上传 {ok} 跳过 {skip} 失败 {len(fail)}"
              f" | 终验 {verified}/{len(FILES)} 在目录中")
        if fail or verified < len(FILES):
            print("[upload] 未全部成功:", fail or "清单缺项")
            return 3
        return 0
    finally:
        page.quit()


if __name__ == "__main__":
    sys.exit(main())
