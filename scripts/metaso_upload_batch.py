"""metaso 批量上传（混沌学园全量课程）。

沿用 metaso_upload.py 的生产配方（自动登录/页面内 fetch PUT/幂等去重），
扩展为：递归收集 DOCX + AI 子文件夹镜像 + 断点续传 + 进度落盘。
- 上传目标：专题 8673582927558737920 / 目录 01、混沌学园（cfid 2096794656849395712）
- AI 课程 → 子文件夹「AI课程」（探测到文件夹 API 时）；否则平铺
- 进度：data/hundun/_recon/metaso_progress.json（成功清单，重启跳过）
用法: python scripts/metaso_upload_batch.py [--dry-run] [--limit N]
"""
import base64
import configparser
import glob
import json
import os
import re
import sys
import time

from DrissionPage import ChromiumOptions, ChromiumPage

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "data", "hundun")
SECRET = os.path.join(ROOT, "config", "metaso.secret.ini")
PROGRESS = os.path.join(DATA, "_recon", "metaso_progress.json")
SID = "8673582927558737920"
CFID = "2096794656849395712"
URL = f"https://metaso.cn/subject-v2/{SID}/manage?cfid={CFID}"
LOGIN_URL = "https://metaso.cn"
MARKERS = ("text:退出登录", "text:个人中心", "text:我的会员", "text:账号信息")
MIME = ("application/vnd.openxmlformats-officedocument"
        ".wordprocessingml.document")
AI_SUBFOLDER = "AI课程"


# ---------- 登录（We-AIPO 配方，与 metaso_upload.py 一致） ----------

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
    for _ in range(30):
        time.sleep(2)
        if _logged_in(page):
            return True
    return False


def _ensure_login(page, account, password) -> bool:
    if _try_login(page, account, password):
        return True
    print("[login] 首轮未成（可能验证码）——自动重试一轮", flush=True)
    return _try_login(page, account, password)


# ---------- API（页面内 fetch） ----------

def _get_token(page):
    try:
        return page.run_js(
            "var m=document.querySelector('meta[id=\"meta-token\"]');"
            "return m?m.getAttribute('content'):null;")
    except Exception:
        return None


def _list_files(page, token: str, parent: str) -> list:
    """目录条目（文件+文件夹原始对象）。失败返回 []。"""
    if not token:
        return []
    js = f"""
    return (async () => {{
        try {{
            const resp = await fetch(
                'https://metaso.cn/api/knowledge/{SID}/search?s=&parentId={parent}'
                + '&pageSize=200&pageIndex=0&sort=updateTime&sortDirection=desc',
                {{headers: {{'token': {json.dumps(token)}}}}});
            const data = await resp.json();
            return JSON.stringify((data.data&&(data.data.content||data.data.list))||data.list||[]);
        }} catch(e) {{ return '[]'; }}
    }})();
    """
    try:
        raw = page.run_js(js, timeout=30) or "[]"
        return json.loads(raw)
    except Exception:
        return []


def _find_or_create_subfolder(page, token: str, parent: str,
                              name: str) -> str | None:
    """在 parent 下找/建子文件夹；返回新 cfid，失败 None（平铺降级）。"""
    items = _list_files(page, token, parent)
    for it in items:
        if isinstance(it, dict) and it.get("type") in (1, "1", "folder") \
                and (it.get("fileName") or it.get("name")) == name:
            return str(it.get("cfid") or it.get("id") or "") or None
    # 真实创建端点（JS chunk 71409 逆向）：
    # o3 = (e,t,n) => ev.put("/api/file/" + e + "/folder", {name: t}, n)
    js = f"""
    return (async () => {{
        try {{
            const resp = await fetch('https://metaso.cn/api/file/{parent}/folder', {{
                method: 'PUT',
                headers: {{'Content-Type': 'application/json',
                          'token': {json.dumps(token)}}},
                body: JSON.stringify({{name: {json.dumps(name, ensure_ascii=False)}}})
            }});
            return resp.status + '||' + (await resp.text());
        }} catch(e) {{ return '0||' + e.message; }}
    }})();
    """
    try:
        result = str(page.run_js(js, timeout=20))
        status, _, payload = result.partition("||")
        print(f"[folder] create -> HTTP {status}: {payload[:160]}", flush=True)
        if status == "200":
            data = json.loads(payload)
            for probe in (data.get("data") if isinstance(data.get("data"), dict) else None,
                          data if isinstance(data, dict) else None):
                if isinstance(probe, dict):
                    for key in ("cfid", "id", "folderId"):
                        if probe.get(key):
                            print(f"[folder] 建子目录 {name} -> {probe[key]}",
                                  flush=True)
                            return str(probe[key])
            # 响应不含 id → GET 目录列表按名找回（防重复建）
            js_get = f"""
            return (async () => {{
                try {{
                    const resp = await fetch(
                        'https://metaso.cn/api/file/{parent}/folder'
                        + '?pageSize=200&pageIndex=0',
                        {{headers: {{'token': {json.dumps(token)}}}}});
                    return resp.status + '||' + (await resp.text());
                }} catch(e) {{ return '0||' + e.message; }}
            }})();
            """
            raw = str(page.run_js(js_get, timeout=20) or "||")
            body = json.loads(raw.partition("||")[2] or "null")
            items = (((body or {}).get("data") or {}).get("content")
                     if isinstance(body, dict) else None)
            for it in items or []:
                if isinstance(it, dict) and (it.get("fileName") or it.get("name")) == name:
                    new_id = str(it.get("cfid") or it.get("id") or "") or None
                    print(f"[folder] 列表找回 {name} -> {new_id}", flush=True)
                    return new_id
    except Exception as exc:
        print(f"[folder] create 异常: {exc}", flush=True)
    print(f"[folder] 子目录创建失败——{name} 平铺上传", flush=True)
    return None


def _norm(name: str) -> str:
    s = re.sub(r"\.[a-zA-Z0-9]+$", "", name)
    return re.sub(r"[\s\W_]+", "", s, flags=re.UNICODE).lower()


def _upload_docx(page, path: str, cfid: str) -> tuple:
    fname = os.path.basename(path)
    with open(path, "rb") as fh:
        b64 = base64.b64encode(fh.read()).decode("ascii")
    chunks = [b64[i:i + 200000] for i in range(0, len(b64), 200000)] or [""]
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
            const resp = await fetch('/api/file/{cfid}', {{
                method: 'PUT', body: form, credentials: 'include'
            }});
            const txt = await resp.text();
            return resp.status + '||' + txt;
        }} catch(e) {{ return '0||' + e.message; }}
    }})();
    """
    try:
        result = page.run_js(js, timeout=180)
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


# ---------- 主流程 ----------

def collect() -> list:
    """[(path, subfolder)]：subfolder 为云端子目录名（""=根目录平铺）。"""
    out = []
    for path in sorted(glob.glob(os.path.join(DATA, AI_SUBFOLDER, "*.docx"))):
        out.append((path, AI_SUBFOLDER))
    for path in sorted(glob.glob(os.path.join(DATA, "课程资料", "**", "*.docx"),
                                 recursive=True)):
        tab = os.path.basename(os.path.dirname(path))
        out.append((path, tab))
    # 根级既有 DOCX（技能卡总览/学习笔记，沿用原目标目录）
    for path in sorted(glob.glob(os.path.join(DATA, "*.docx"))):
        out.append((path, ""))
    return out


def load_progress() -> dict:
    try:
        return json.load(open(PROGRESS, encoding="utf-8"))
    except (OSError, ValueError):
        return {"uploaded": []}


def save_progress(prog: dict) -> None:
    os.makedirs(os.path.dirname(PROGRESS), exist_ok=True)
    with open(PROGRESS, "w", encoding="utf-8") as fh:
        json.dump(prog, fh, ensure_ascii=False, indent=1)


def main(argv: list) -> int:
    dry = "--dry-run" in argv
    limit = 0
    if "--limit" in argv:
        limit = int(argv[argv.index("--limit") + 1])
    files = collect()
    if limit:
        files = files[:limit]
    print(f"[batch] 收集 DOCX {len(files)} 个（AI "
          f"{sum(1 for _, s in files if s == AI_SUBFOLDER)}）", flush=True)
    prog = load_progress()
    uploaded = {_norm(os.path.basename(p)) for p in prog["uploaded"]}
    todo = [(p, s) for p, s in files
            if _norm(os.path.basename(p)) not in uploaded]
    print(f"[batch] 待传 {len(todo)}（已传 {len(uploaded)}）", flush=True)
    if dry or not todo:
        return 0

    account, password = _creds()
    if not account or not password:
        print("[upload] config/metaso.secret.ini 缺账号/密码")
        return 1
    co = ChromiumOptions()
    co.headless(False)
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
            print("[upload] 自动登录失败")
            return 2
        print("[login] 登录成功", flush=True)
        page.get(URL, timeout=30)
        time.sleep(3)
        token = _get_token(page) or (time.sleep(3) or _get_token(page))
        if not token:
            print("[upload] 未取到 meta-token")
            return 2
        # 子目录镜像：AI课程/ + 课程资料各 <tab>/（失败平铺根目录）
        sub_cfids: dict[str, str | None] = {}
        for sub in sorted({s for _, s in todo if s}):
            sub_cfids[sub] = _find_or_create_subfolder(page, token, CFID, sub)
        existing_main = {_norm(it.get("fileName") or it.get("name") or "")
                         for it in _list_files(page, token, CFID)}
        existing_sub: dict[str, set] = {}
        for sub, cid in sub_cfids.items():
            existing_sub[sub] = ({_norm(it.get("fileName") or it.get("name") or "")
                                  for it in _list_files(page, token, cid)}
                                 if cid else set())
        ok = skip = 0
        fails = []
        for i, (path, sub) in enumerate(todo, 1):
            fname = os.path.basename(path)
            cfid = sub_cfids.get(sub) or CFID
            if _norm(fname) in (existing_sub.get(sub) if sub_cfids.get(sub)
                                else existing_main):
                print(f"  [{i}/{len(todo)}] [skip] {fname}（云端已存在）",
                      flush=True)
                prog["uploaded"].append(path)
                save_progress(prog)
                skip += 1
                continue
            good, detail = _upload_docx(page, path, cfid)
            print(f"  [{i}/{len(todo)}] [{'OK' if good else 'FAIL'}] "
                  f"{sub + '/' if sub else ''}{fname}: {detail}", flush=True)
            if good:
                prog["uploaded"].append(path)
                save_progress(prog)
                ok += 1
            else:
                fails.append(fname)
            time.sleep(2)
        print(f"\n[done] 上传 {ok} 跳过 {skip} 失败 {len(fails)}", flush=True)
        if fails:
            print("[upload] 失败清单:", fails[:20], flush=True)
            return 3
        return 0
    finally:
        page.quit()


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
