#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""通往AGI之路 语料批量上传秘塔知识库（借 We-AIPO metaso_uploader 配方）。

核心配方（We-AIPO 生产验证）：
  - DrissionPage + 持久 Chrome profile（登录态复用）
  - 页内 fetch 调站内 API：上传 PUT /api/file/{cfid}（FormData，cookie 认证，
    ⚠️ 绝不带 token header——meta-token 是只读 token，会覆盖 cookie 写权限）
  - 建夹 PUT /api/file/{parentId}/folder {"name":...}（2026-09-12 改版后端点，
    旧 /api/dir 已 404；已存在 errCode==1 时查 /api/knowledge/{sid}/search 拿现有 id）
  - 成功契约：HTTP 200 且 errCode==0；errCode==1 为已存在（幂等成功）
  - 上传间隔 2-4s 随机；连败 5 次熔断

本脚本特有：
  - docx 二进制上传：base64 → JS Uint8Array → File → FormData
  - 断点台账 state/metaso-uploads.jsonl（status=ok 即跳过）
  - 章节目录映射缓存 state/metaso-dirs.json
  - --limit / --chapter 用于冒烟

用法：
  python upload_metaso.py --smoke            # 冒烟：1 个章节 2 篇（md+docx）
  python upload_metaso.py                    # 全量（断点续跑）
  python upload_metaso.py --chapter "1.4 AI 绘画"
"""
import argparse
import base64
import json
import os
import random
import re
import sys
import time
from pathlib import Path

SKILL = Path(__file__).resolve().parent.parent
STATE = SKILL / "state"
KB_DIR = Path(r"E:\AI-Station\04 智库\通往AGI之路")

SUBJECT_ID = "8673582927558737920"          # 用户知识库
TARGET_CFID = "2096794719386992640"          # 目标管理目录（二级目录建在这下面）

WE_AIPO = Path(r"E:\CPOPC\We-AIPO")
PROFILE_PRIMARY = WE_AIPO / "data" / "browser_profile" / "metaso"    # 生产登录态
PROFILE_FALLBACK = WE_AIPO / "data" / "browser_profiles" / "metaso"  # login 脚本登录态

LEDGER = STATE / "metaso-uploads.jsonl"
DIRS = STATE / "metaso-dirs.json"

LOGIN_MARKERS = ("退出登录", "个人中心", "我的会员", "账号信息")


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def read_env_creds():
    env = WE_AIPO / ".env"
    if not env.exists():
        return None, None
    acct = pwd = None
    for line in env.read_text(encoding="utf-8").splitlines():
        m = re.match(r"(METASO_ACCOUNT|METASO_PASSWORD)\s*=\s*(.+)", line.strip())
        if m:
            if m.group(1) == "METASO_ACCOUNT":
                acct = m.group(2).strip().strip('"')
            else:
                pwd = m.group(2).strip().strip('"')
    return acct, pwd


def build_options(profile_dir):
    """借 We-AIPO driver.build_chromium_options 精髓：持久 profile + 稳定端口 + 反检测。"""
    from DrissionPage import ChromiumOptions
    import zlib
    co = ChromiumOptions()
    co.set_user_data_path(str(profile_dir))
    co.set_local_port(9300 + zlib.crc32(str(profile_dir).encode()) % 200)  # 禁 auto_port，防丢登录态
    for arg in ("--disable-blink-features=AutomationControlled", "--disable-infobars",
                "--no-first-run", "--no-default-browser-check",
                "--disable-features=IsolateOrigins,site-per-process"):
        co.set_argument(arg)
    return co


class MetasoClient:
    def __init__(self):
        self.tab = None
        self.browser = None
        self._since_nav = 0
        self._dir_map = json.loads(DIRS.read_text(encoding="utf-8")) if DIRS.exists() else {}

    # ---------- 浏览器与登录 ----------
    def ensure_browser(self):
        from DrissionPage import Chromium
        for profile in (PROFILE_PRIMARY, PROFILE_FALLBACK):
            try:
                self.browser = Chromium(build_options(profile))
                self.tab = self.browser.latest_tab
                log(f"浏览器就绪（profile={profile.name}）")
                return True
            except Exception as e:
                log(f"profile {profile.name} 启动失败: {str(e)[:80]}，尝试下一个")
        raise RuntimeError("两个 metaso profile 都无法启动（可能被占用），关掉占用它的 Chrome 后重试")

    def reconnect(self):
        """页面断连自愈：开新标签页（旧 tab 可能已 crash）→ 整浏览器重启兜底。
        绝不抛异常，只返回 bool。"""
        for _ in range(2):
            try:
                self.tab = self.browser.new_tab(
                    f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={TARGET_CFID}")
                time.sleep(2)
                self.tab.run_js("return 1")  # 连接实证
                return True
            except Exception:
                time.sleep(2)
        try:
            try:
                self.browser.quit()
            except Exception:
                pass
            time.sleep(3)
            self.ensure_browser()
            return self.ensure_login()
        except Exception as e:
            log(f"  自愈失败: {str(e)[:80]}")
            return False

    def ensure_login(self):
        self.tab.get("https://metaso.cn")
        time.sleep(3)
        html = self.tab.html or ""
        if any(m in html for m in LOGIN_MARKERS):
            log("登录态有效")
            return True
        # 2026-09-12 首页改版标记漂移：HTML 标记缺失≠掉登录态。
        # 用专题列表接口实证（errCode==0 = 会话有效）
        js = f"""
        return (async () => {{
            try {{
                const meta = document.querySelector('meta[id="meta-token"]');
                const token = meta ? meta.content : '';
                const resp = await fetch(
                    '/api/knowledge/{SUBJECT_ID}/search?s=&parentId={TARGET_CFID}' +
                    '&pageSize=1&pageIndex=0&sort=updateTime&sortDirection=desc',
                    {{credentials: 'include', headers: {{'token': token}}}});
                const data = await resp.json();
                return (data.errCode === 0) ? 'ok' : 'no';
            }} catch(e) {{ return 'no'; }}
        }})();
        """
        if str(self.tab.run_js(js, timeout=30)) == "ok":
            log("登录态有效（API 实证，首页标记漂移）")
            return True
        log("⚠️ 登录态失效，尝试账密自动登录")
        acct, pwd = read_env_creds()
        if not acct or not pwd:
            return self._manual_login()
        try:
            return self._auto_login(acct, pwd)
        except Exception as e:
            log(f"自动登录异常: {str(e)[:80]}")
            return self._manual_login()

    def _auto_login(self, acct, pwd):
        tab = self.tab
        tab.get("https://metaso.cn")
        time.sleep(2)
        try:
            tab.ele("text=登录").click()
            time.sleep(1.5)
            tab.ele("text=账号密码").click()
            time.sleep(1)
            num = tab.ele("css:input[type=number]") or tab.ele("css:input[type=tel]")
            num.clear()
            num.input(acct)
            pw = tab.ele("css:input[type=password]")
            pw.clear()
            pw.input(pwd)
            # MUI 复选框：点容器不点文字
            tab.run_js(
                "var c=document.querySelector('input[name=\"policy-checkbox\"]');"
                "if(c){c.closest('.MuiCheckbox-root, label, span')?.click();c.click();}")
            time.sleep(0.5)
            for label in ("登 录", "登　录", "登录"):
                btn = tab.ele(f"text={label}")
                if btn:
                    btn.click()
                    break
            for _ in range(30):
                time.sleep(2)
                if any(m in (tab.html or "") for m in LOGIN_MARKERS):
                    log("自动登录成功")
                    return True
            return self._manual_login()
        except Exception as e:
            log(f"自动登录控件定位失败: {str(e)[:80]}")
            return self._manual_login()

    def _manual_login(self):
        log("👉 请在弹出的浏览器窗口手动登录 metaso.cn（完成后再回车）")
        self.browser.show_browser() if hasattr(self.browser, "show_browser") else None
        input("登录完成后按回车继续...")
        self.tab.get("https://metaso.cn")
        time.sleep(2)
        ok = any(m in (self.tab.html or "") for m in LOGIN_MARKERS)
        log(f"手动登录{'成功' if ok else '仍失败'}")
        return ok

    # ---------- 站内 API ----------
    def create_folder(self, parent_cfid, name):
        """建二级目录，返回新 cfid；已存在则查父目录列表拿现有 id；失败返回 ''。

        2026-09-12 站方改版：旧 PUT /api/dir 已 404。
        新端点（UI 抓包实测，state/metaso-dir-probe4.json）：
          PUT /api/file/{parentId}/folder   body {"name": ...}
        响应 errCode==0 + data.id；同 cookie 认证契约不变。
        """
        js = f"""
        return (async () => {{
            try {{
                const resp = await fetch('/api/file/{parent_cfid}/folder', {{
                    method: 'PUT', credentials: 'include',
                    headers: {{'Content-Type': 'application/json'}},
                    body: JSON.stringify({{name: {json.dumps(name, ensure_ascii=False)}}})
                }});
                const txt = await resp.text();
                return resp.status + '||' + txt;
            }} catch(e) {{ return '0||' + e.message; }}
        }})();
        """
        result = self.tab.run_js(js, timeout=30)
        status, _, body = str(result).partition("||")
        if status == "200":
            try:
                data = json.loads(body)
            except ValueError:
                log(f"建夹响应非JSON({name[:20]}): {body[:80]}")
                return ""
            d = data.get("data") or {}
            new_id = str(d.get("id") or d.get("cfid") or "")
            if data.get("errCode") == 0 and new_id.isdigit():
                return new_id
            if data.get("errCode") == 1:  # 已存在 → 列表兜底拿现有 id
                exist = self.find_folder(parent_cfid, name)
                if exist:
                    return exist
        log(f"建夹未命中({name[:20]}): {status} {body[:100]}")
        return ""

    def find_folder(self, parent_cfid, name):
        """父目录下列表检索同名文件夹 id（读接口，带 meta-token，字段 data.content）。"""
        js = f"""
        return (async () => {{
            try {{
                const meta = document.querySelector('meta[id="meta-token"]');
                const token = meta ? meta.content : '';
                const resp = await fetch(
                    '/api/knowledge/{SUBJECT_ID}/search?s=&parentId={parent_cfid}' +
                    '&pageSize=200&pageIndex=0&sort=updateTime&sortDirection=desc',
                    {{credentials: 'include', headers: {{'token': token}}}});
                const data = await resp.json();
                const d = data.data || data;
                return JSON.stringify(d.content || d.list || []);
            }} catch(e) {{ return '[]'; }}
        }})();
        """
        try:
            items = json.loads(self.tab.run_js(js, timeout=30) or "[]")
        except Exception:
            return ""
        for it in items:
            iname = str(it.get("fileName") or it.get("name") or "")
            if iname != name:
                continue
            fid = str(it.get("id") or it.get("cfid") or "")
            looks_dir = any(it.get(k) for k in ("isDir", "is_dir", "dir"))
            itype = str(it.get("type") or "").lower()
            if fid.isdigit() and (looks_dir or itype in ("dir", "folder", "1")):
                return fid
        return ""

    def ensure_chapter_dir(self, chapter):
        """章节 → metaso cfid（缓存优先，缺则建夹；建夹失败回退 TARGET_CFID）。"""
        if chapter in self._dir_map:
            return self._dir_map[chapter]
        # 导航到管理页（fetch 需要同源上下文）
        self.tab.get(f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={TARGET_CFID}")
        time.sleep(2)
        cfid = self.create_folder(TARGET_CFID, chapter)
        if not cfid:
            log(f"⚠️ 章节建夹失败，回退到目标根目录: {chapter}")
            cfid = TARGET_CFID
        self._dir_map[chapter] = cfid
        DIRS.write_text(json.dumps(self._dir_map, ensure_ascii=False, indent=1), encoding="utf-8")
        return cfid

    def maybe_refresh(self):
        """每 150 次页内 fetch 主动刷新页面，防标签页内存累积崩溃。"""
        self._since_nav += 1
        if self._since_nav < 150:
            return
        self._since_nav = 0
        try:
            self.tab.get(f"https://metaso.cn/subject-v2/{SUBJECT_ID}/manage?cfid={TARGET_CFID}")
            time.sleep(2)
            log("  🔄 页面例行刷新（防内存累积）")
        except Exception:
            pass  # 刷新失败交给断连自愈

    def upload_md(self, cfid, fname, content):
        self.maybe_refresh()
        payload = json.dumps(content, ensure_ascii=False)
        fname_js = json.dumps(fname, ensure_ascii=False)
        js = f"""
        return (async () => {{
            try {{
                const blob = new Blob([{payload}], {{type: 'text/markdown'}});
                const form = new FormData();
                form.append('file', blob, {fname_js});
                form.append('fileName', {fname_js});
                form.append('type', 'md');
                const resp = await fetch('/api/file/{cfid}', {{
                    method: 'PUT', body: form, credentials: 'include'
                }});
                const txt = await resp.text();
                return resp.status + '||' + txt;
            }} catch(e) {{ return '0||' + e.message; }}
        }})();
        """
        return self._check(self.tab.run_js(js, timeout=120), fname)

    def upload_docx(self, cfid, fname, path):
        self.maybe_refresh()
        raw = Path(path).read_bytes()
        b64 = base64.b64encode(raw).decode()
        fname_js = json.dumps(fname, ensure_ascii=False)
        js = f"""
        return (async () => {{
            try {{
                const bin = atob({json.dumps(b64)});
                const bytes = new Uint8Array(bin.length);
                for (let i = 0; i < bin.length; i++) bytes[i] = bin.charCodeAt(i);
                const file = new File([bytes], {fname_js}, {{type:
                    'application/vnd.openxmlformats-officedocument.wordprocessingml.document'}});
                const form = new FormData();
                form.append('file', file);
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
        return self._check(self.tab.run_js(js, timeout=180), fname)

    @staticmethod
    def _check(result, fname):
        status, _, body = str(result).partition("||")
        if status == "200":
            try:
                data = json.loads(body)
                err = data.get("errCode", -99)
                if err == 0:
                    return True, "ok"
                if err == 1:
                    return True, "exists"
                return False, f"errCode={err}:{data.get('errMsg', '')[:60]}"
            except Exception:
                return False, f"non-json:{body[:60]}"
        return False, f"http {status}:{body[:60]}"


# ---------- 台账 ----------
def load_ledger():
    done = set()
    if LEDGER.exists():
        for line in LEDGER.read_text(encoding="utf-8").splitlines():
            try:
                rec = json.loads(line)
                if rec.get("status") == "ok":
                    done.add(rec["path"])
            except Exception:
                pass
    return done


def append_ledger(rec):
    with open(LEDGER, "a", encoding="utf-8") as f:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")


def safe_fname(stem, ext, limit=70):
    s = re.sub(r'[\\/:*?"<>|\r\n\t]', "_", stem).strip().strip(".")[:limit] or "未命名"
    return s + ext


def iter_jobs(chapter_filter=None):
    """产出 (chapter, abs_path, fname)。每个 docx/md 成对。"""
    if not KB_DIR.exists():
        raise SystemExit(f"❌ {KB_DIR} 不存在，先跑 md2docx_batch.py")
    for chap in sorted(os.listdir(KB_DIR)):
        cdir = KB_DIR / chap
        if not cdir.is_dir():
            continue
        if chapter_filter and chap != chapter_filter:
            continue
        for f in sorted(os.listdir(cdir)):
            if f.endswith((".md", ".docx")):
                yield chap, str(cdir / f), f


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--smoke", action="store_true", help="冒烟：首个章节前2篇")
    ap.add_argument("--chapter", default=None)
    ap.add_argument("--limit", type=int, default=0)
    ap.add_argument("--only", choices=["md", "docx"], default=None, help="只传一种格式")
    args = ap.parse_args()

    STATE.mkdir(exist_ok=True)
    cli = MetasoClient()
    cli.ensure_browser()
    if not cli.ensure_login():
        return 1

    jobs = []
    for chap, path, fname in iter_jobs(args.chapter):
        if args.only and not fname.endswith("." + args.only):
            continue
        jobs.append((chap, path, fname))
    if args.smoke:
        # 首章节 × 前2篇文档（md+docx 全部算上，最多6个上传动作）
        chap0 = jobs[0][0] if jobs else None
        jobs = [j for j in jobs if j[0] == chap0][:6]
    if args.limit:
        jobs = jobs[: args.limit]

    done = load_ledger()
    jobs = [j for j in jobs if j[1] not in done]
    total = len(jobs)
    log(f"待上传 {total} 个文件（台账已跳过）")
    if not total:
        return 0

    ok = fail = 0
    consec = 0
    t0 = time.time()

    def upload_one(chap, path, fname):
        """单文件上传；断连自愈重试，永不抛异常（耗尽转熔断统计）。"""
        last_err = "unknown"
        for attempt in range(4):
            try:
                cfid = cli.ensure_chapter_dir(chap)
                if fname.endswith(".md"):
                    return cli.upload_md(cfid, safe_fname(Path(fname).stem, ".md"),
                                         Path(path).read_text(encoding="utf-8",
                                                              errors="replace"))
                return cli.upload_docx(cfid, safe_fname(Path(fname).stem, ".docx"), path)
            except Exception as ex:
                last_err = type(ex).__name__
                log(f"  ⚡ {last_err} @ {fname[:30]}，自愈重试 {attempt + 1}/4")
                time.sleep(5 + attempt * 15)
                if not cli.reconnect():
                    log("  自愈未成，60s 宽限后再试")
                    time.sleep(60)
        return False, f"conn:{last_err}"

    for i, (chap, path, fname) in enumerate(jobs, 1):
        good, info = upload_one(chap, path, fname)
        append_ledger({"path": path, "chapter": chap, "fname": fname,
                       "status": "ok" if good else "fail", "info": info,
                       "ts": time.strftime("%Y-%m-%d %H:%M:%S")})
        if good:
            ok += 1
            consec = 0
        else:
            fail += 1
            consec += 1
            log(f"  ✗ [{i}/{total}] {fname[:40]}: {info}")
            if consec >= 5:
                log("⏸️ 连续 5 次失败，熔断退出（可重跑续传）")
                break
        if i % 25 == 0:
            log(f"  进度 {i}/{total} ok={ok} fail={fail} 用时{int(time.time()-t0)}s")
        time.sleep(random.uniform(2, 4))
    log(f"🏁 完成：ok={ok} fail={fail} / {total}，用时 {int(time.time()-t0)}s")
    return 0 if fail == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
