# -*- coding: utf-8 -*-
"""蓝奏云 adapter（分享页游客解析全链：iframe→ajax→验证页→CDN 直链）

出处：refs_nfd parser/impl/LzTool.java（MIT，逐段移植：ajax 兜底域序/acw_sc__v2/二次验证 2.2s 等待）。
域名注意：分享主机保留原始（wwww.lanzoux 系超时常见）；文件 ajax 绝对地址优先（apifile.lanzouw.com）。
"""
from __future__ import annotations

import json
import re
import time
from urllib.parse import urljoin

from ._crypto import acw_sc_v2
from .base import BaseAdapter, FileEntry, PanError, UA

PAGE_H = {"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
          "Accept-Encoding": "identity", "Upgrade-Insecure-Requests": "1",
          "Sec-Fetch-Dest": "document", "Sec-Fetch-Mode": "navigate",
          "Sec-Fetch-Site": "cross-site", "Sec-Fetch-User": "?1"}
AJAX_H = {"Accept": "application/json, text/javascript, */*; q=0.01",
          "Content-Type": "application/x-www-form-urlencoded",
          "X-Requested-With": "XMLHttpRequest",
          "Sec-Fetch-Dest": "empty", "Sec-Fetch-Mode": "cors", "Sec-Fetch-Site": "same-origin"}

P_IFRAME = re.compile(r'src\s*=\s*["\'](/fn\?[^"\'\s>]+)["\']', re.I)
P_WP_SIGN = re.compile(r"wp_sign\s*=\s*'([^']+)'")
P_AJAXDATA = re.compile(r"ajaxdata\s*=\s*'([^']+)'")
P_WEBSIGN = re.compile(r"'websign'\s*:\s*'([^']*)'")
P_SIGN = re.compile(r"'sign'\s*:\s*'([^']+)'")
P_ISNGIS = re.compile(r"var\s+isngis\s*=\s*'([^']+)'")
P_AJAX_ABS = re.compile(r"['\"]((?:https?:)?//[^'\"\s<>]+/ajax(?:m|file)\.php\?file=\d+)['\"]", re.I)
P_AJAX_PATH = re.compile(r"(?:['\"/]|^)(ajax(?:m|file)\.php\?file=\d+)")
P_FI_NAME = re.compile(r'class="b"><span>(.*?)</span>|filenajax">(.*?)<')
P_FI_SIZE = re.compile(r'>文件大小：</span>(.*?)<br>|"n_filesize">大小：(.*?)</div>')

FILE_AJAX_FALLBACK = ["https://apifile.lanzouw.com", "https://w1.lanzn.com"]


class LanzouAdapter(BaseAdapter):
    name = "lanzou"
    domains = ("lanzou", "lanzn", "lanzoux", "lanzoui", "lanzouw", "lanzouy", "lanzoub",
               "lanzoup", "lanzouq", "lanzout", "lanzoue", "lanzoud", "lanzouf", "lanzoug",
               "lanzouh", "lanzouj", "lanzouk", "lanzoul", "lanzoum", "lanzoun", "lanzoo",
               "lanrar.com")

    def __init__(self):
        self._cookies: dict[str, str] = {}

    def _h(self, extra: dict | None = None) -> dict:
        h = {"User-Agent": UA}
        if self._cookies:
            h["Cookie"] = "; ".join(f"{k}={v}" for k, v in self._cookies.items())
        if extra:
            h.update(extra)
        return h

    def _acw(self, body: str) -> bool:
        """ESA 挑战页：算 acw_sc__v2 入 cookie。"""
        m = re.search(r"var arg1='([^']+)'", body)
        if not m:
            return False
        self._cookies["acw_sc__v2"] = acw_sc_v2(m.group(1))
        return True

    def _get_html(self, url: str) -> str:
        r = self.get(url, headers=self._h(PAGE_H), allow_redirects=True)
        body = r.text
        if "var arg1='" in body:
            if self._acw(body):
                self._step()
                r = self.get(url, headers=self._h(PAGE_H), allow_redirects=True)
                body = r.text
        return body

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        page = url if url.endswith("/") else url
        html = self._get_html(page)
        name_m = P_FI_NAME.search(html)
        size_m = P_FI_SIZE.search(html)
        name = (name_m.group(1) or name_m.group(2) or "lanzou_file").strip() if name_m else "lanzou_file"
        size_str = (size_m.group(1) or size_m.group(2) or "").strip() if size_m else ""
        # nfd doParser 同构：文件分享页先取 /fn iframe，ajax 变量在 iframe 内页
        referer = page
        target_html = html
        m = P_IFRAME.search(html)
        if m:
            origin = "/".join(page.split("/")[:3])
            iframe_abs = m.group(1)
            if iframe_abs.startswith("//"):
                iframe_abs = "https:" + iframe_abs
            elif iframe_abs.startswith("/"):
                iframe_abs = origin + iframe_abs
            self._step()
            target_html = self._get_html(iframe_abs)
            referer = iframe_abs
        ajax_url, form = self._extract_ajax(target_html, pwd)
        if not ajax_url and target_html is not html:
            ajax_url, form = self._extract_ajax(html, pwd)   # 兜底：部分变体变量在外页
            referer = page
        if not ajax_url:
            if ('id="pwd"' in html or "down_p" in html) and not pwd:
                raise PanError("lanzou: 需要访问密码")
            raise PanError("lanzou: 未找到下载入口（失效/风控/需密码）")
        return [FileEntry(name=name, size=_cn_size(size_str), fid="0",
                          extra={"page": referer, "ajax_url": ajax_url, "form": form})]

    def _extract_ajax(self, html: str, pwd: str):
        """页面 → (ajax 绝对 url, downprocess form)。"""
        target = None
        m = P_AJAX_ABS.search(html)
        if m:
            target = m.group(1)
            if target.startswith("//"):
                target = "https:" + target
        else:
            m2 = P_AJAX_PATH.search(html)
            if m2:
                target = "/" + m2.group(1)
        if not target:
            return None, None
        form: dict[str, str] = {"action": "downprocess"}
        wp = P_WP_SIGN.search(html)
        ad = P_AJAXDATA.search(html)
        isngis = None
        for im in P_ISNGIS.finditer(html):
            if im.group(1):
                isngis = im.group(1)
        if wp:
            form["sign"] = wp.group(1)
            if ad:
                form["websignkey"] = ad.group(1)
                form["signs"] = ad.group(1)
            ws = P_WEBSIGN.search(html)
            form["websign"] = ws.group(1) if ws else ""
            form["kd"] = "1"
            form["ves"] = "1"
        elif isngis:
            form["sign"] = isngis
            form["kd"] = "1"
        else:
            signs = [s.group(1) for s in P_SIGN.finditer(html)]
            if not signs:
                return None, None
            form["sign"] = signs[1] if len(signs) > 1 else signs[0]
            form["kd"] = "1"
            if ad:
                form["websignkey"] = ad.group(1)
                form["signs"] = ad.group(1)
        if pwd:
            form["p"] = pwd
        return target, form

    def direct_url(self, entry: FileEntry) -> str:
        page = entry.extra["page"]
        target = entry.extra["ajax_url"]
        form = entry.extra["form"]
        page_origin = "/".join(page.split("/")[:3])
        if target.startswith("http"):
            path = "/" + target.split("/", 3)[-1]
            candidates = [target] + [urljoin(o + "/", path) for o in FILE_AJAX_FALLBACK]
        else:
            candidates = [urljoin(page_origin + "/", target)] + \
                         [urljoin(o + "/", target.lstrip("/")) for o in FILE_AJAX_FALLBACK]
        last = None
        for u in dict.fromkeys(candidates):   # 去重保序
            r = self.post(u, headers=self._h({**AJAX_H, "Referer": page}), data=form)
            body = r.text
            last = body[:200]
            j = _lz_json(body)
            if j is None or "超时" in str(j.get("inf", "")):
                continue
            if j.get("zt") != 1:
                raise PanError(f"lanzou ajax: zt={j.get('zt')} {j.get('inf')}")
            dom, tok = j.get("dom"), j.get("url")
            if not dom or not tok:
                raise PanError("lanzou ajax: dom/url 空")
            return self._follow(dom + "/file/" + tok)
        raise PanError(f"lanzou: ajax 全域失败 {last}")

    def _follow(self, down_url: str) -> str:
        """中间链：302 直出或验证页（等 2.2s POST ajax.php el=2）。"""
        host = down_url.split("/")[2]
        parent = ".".join(host.split(".")[-2:])
        self._cookies["down_ip"] = "1"
        r = self.get(down_url, headers=self._h({**PAGE_H, "Referer": down_url}),
                     allow_redirects=False)
        loc = r.headers.get("Location", "")
        if _is_direct(loc):
            return loc
        body = r.text or ""
        if "var arg1='" in body:
            if self._acw(body):
                self._step()
                return self._follow(down_url)
            raise PanError("lanzou: 下载域 acw 校验失败")
        if "down_r" in body and "ajax.php" in body:
            fm = P_VERIFY_FILE.search(body)
            sm = P_SIGN.search(body)
            if not (fm and sm):
                raise PanError("lanzou: 验证页缺 file/sign")
            time.sleep(2.2)   # 功能性等待：过早 POST → ?SignError
            origin = "/".join(down_url.split("/")[:3])
            r2 = self.post(origin + "/file/ajax.php",
                           headers=self._h({**AJAX_H, "Origin": origin, "Referer": down_url}),
                           data={"file": fm.group(1), "el": "2", "sign": sm.group(1)})
            j2 = _lz_json(r2.text or "")
            u2 = (j2 or {}).get("url", "")
            if _is_direct(u2):
                return u2
            raise PanError(f"lanzou: 二次验证未出直链 ({str(u2)[:80]})")
        raise PanError(f"lanzou: 下载域未出直链 status={r.status_code}")


P_VERIFY_FILE = re.compile(r"'file'\s*:\s*'([^']+)'")

# ---- 目录分享（filemoreajax）----
P_FILEMORE = re.compile(
    r"url\s*:\s*'(/filemoreajax\.php\?file=\d+)'[\s\S]*?data\s*:\s*\{([^}]+)\}")
P_DATA_KV = re.compile(r"'(\w+)'\s*:\s*('(?:\\'|[^'])*'|\d+|\w+)")


class LanzouFolderAdapter(LanzouAdapter):
    """蓝奏目录分享：filemoreajax 列目录 → 文件页（host+id）走单文件链。"""

    name = "lanzou"
    is_folder_runner = True

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        page = url
        html = self._get_html(page)
        if "filemoreajax" not in html and 'id="infos"' not in html:
            return super().parse(url, pwd)      # 单文件分享回落
        m = P_FILEMORE.search(html)
        if not m:
            raise PanError("lanzou: 目录页未提取到 filemoreajax 参数")
        path, datablock = m.group(1), m.group(2)
        form: dict[str, str] = {}
        for kv in P_DATA_KV.finditer(datablock):
            k, raw = kv.group(1), kv.group(2)
            if k == "pwd":
                form[k] = pwd or ""
                continue
            if k in ("pg", "pgs"):
                form["pg"] = "1"
                continue
            if raw.startswith("'") and raw.endswith("'"):
                form[k] = raw[1:-1].replace("\\'", "'")
            else:
                vm = re.search(r"var\s+" + re.escape(raw) + r"\s*=\s*'([^']*)'", html)
                form[k] = vm.group(1) if vm else raw
        if not all(k in form for k in ("fid", "t", "k")):
            raise PanError("lanzou: 目录参数缺 fid/t/k")
        origin = "/".join(page.split("/")[:3])
        r = self.post(origin + path, headers=self._h({**AJAX_H, "Referer": page}), data=form)
        j = _lz_json(r.text or "")
        if not j or j.get("zt") != 1:
            raise PanError(f"lanzou 目录: zt={j and j.get('zt')} {j and j.get('info','')}")
        out = []
        for it in j.get("text", []):
            out.append(FileEntry(
                name=it.get("name_all", ""), size=_cn_size(it.get("size", "")),
                is_dir=False, fid=it.get("id", ""),
                extra={"file_page": origin + "/" + it.get("id", ""), "pwd": pwd},
            ))
        return out

    def direct_url(self, entry: FileEntry) -> str:
        """目录内文件：先开文件页再走单文件链。"""
        if "file_page" in entry.extra:
            sub = LanzouAdapter()
            sub._cookies = dict(self._cookies)
            entries = sub.parse(entry.extra["file_page"], entry.extra.get("pwd", ""))
            if not entries:
                raise PanError("lanzou: 文件页空")
            return sub.direct_url(entries[0])
        return super().direct_url(entry)


def _lz_json(text: str):
    if not text:
        return None
    t = text.strip()
    i = t.find("{")
    if i < 0:
        return None
    try:
        return json.loads(t[i:])
    except Exception:
        return None


def _is_direct(u: str) -> bool:
    return bool(u) and u.startswith(("http://", "https://")) and "SignError" not in u \
        and "/file/?" not in u and ".plist" not in u and "itms" not in u


def _cn_size(s: str) -> int:
    """'49.8 M' → bytes（近似解析，缺单位按 0）。"""
    if not s:
        return 0
    m = re.match(r"([\d.]+)\s*([KMGT]?B?|字节?)?", s.strip(), re.I)
    if not m:
        return 0
    v = float(m.group(1))
    unit = (m.group(2) or "").upper()
    return int(v * {"": 1, "B": 1, "K": 1024, "KB": 1024, "M": 1024**2, "MB": 1024**2,
                    "G": 1024**3, "GB": 1024**3, "T": 1024**4, "TB": 1024**4,
                    "字": 1, "字节": 1}.get(unit.replace("字节", "").strip() or "", 1))
