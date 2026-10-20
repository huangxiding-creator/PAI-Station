#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
IMA 知识库客户端复刻版（协议逆向自 IMA批量下载助手.exe v1.7.1 + ima.qq.com Web bundle）
功能：微信扫码登录 / 知识库列表 / 库内检索 / 整库递归扫描 / 一键整库下载 / token 自动刷新
依赖：requests, Pillow(可选,显示二维码)
"""
import base64
import json
import os
import random
import re
import sys
import threading
import time
import unicodedata
from concurrent.futures import ThreadPoolExecutor, as_completed

import requests
from requests.adapters import HTTPAdapter

# ============ 常量（逆向实锤值） ============
IMA_BASE = "https://ima.qq.com"
CGI = IMA_BASE + "/cgi-bin/"

# 端点表（实测验证：iOS 客户端头走 knowledge_tab_reader 模块；web 走 knowledge）
EP = {
    "login":              "auth_login/login",
    "refresh":            "auth_login/refresh",
    "get_knowledge_base_list": "knowledge_tab_reader/get_knowledge_base_list",
    "get_knowledge_list": "knowledge_tab_reader/get_knowledge_list",
    "search_knowledge":   "knowledge_tab_reader/search_knowledge",
    "search_knowledge_base": "knowledge_tab_reader/search_knowledge_base",
    "get_tag_view":       "knowledge_tab_reader/get_tag_view",
    "get_home_page_data": "knowledge_tab_reader/get_home_page_data",
    "join_knowledge":     "knowledge_member/join_knowledge",
    "get_media":          "file_manager/get_media",
    "get_share_know_doc": "knowledge_share_get/get_share_know_doc",
    "get_task_report":    "report_svr/get_task_report",
}

# 设备指纹（客户端硬编码，全用户共享；iOS 客户端伪装）
GUID = "guid-ca2055bffb9236ba0dea970403000002519701"
QIMEI36 = "ca2055bffb9236ba0dea970403000002519701"
FIXED_COOKIE_FIELDS = {
    "IMA-GUID": GUID,
    "IMA-Q36": QIMEI36,
    "UID-TYPE": "2",
    "CLIENT-TYPE": "256002",
    "APP-VERSION": "2.2.4.4069",
    "IMA-TOKEN-TYPE": "idcTokenImatokenBindSocial",
    "IMA-IUA": "PR=IMA&PP=com.tencent.imaios&PPVN=2.2.4.4069&PL=IOS&RL=440.0*956.0&MO=iPhone18,2&OS=18.2&DN=iPhone18,2",
}
WX_APPID = "wx0d63f5de059f1d52"
WX_REDIRECT = "https://ima.qq.com/login/#/qr-code-scanned/"
IOS_UA = "ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0"
WEB_UA = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 "
          "(KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36")

CRED_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "credentials.json")
RECORDS_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "download_records.json")

_SPECIAL_CHARS_RE = re.compile(
    "[🀀-\U0001ffff✂-➿①-⓿☀-⛿⬀-⯿️​-‍﻿]")


def calculate_bkn(token: str) -> int:
    """bkn = 腾讯 DJB 变体（逆向自 utils/bkn.pyc）"""
    if not token:
        return 0
    hv = 5381
    for ch in token:
        hv += (hv << 5) + ord(ch)
    return hv & 2147483647


def sanitize_filename(name: str) -> str:
    """逆向自 ima_service.sanitize_filename"""
    if not name or not name.strip():
        return "untitled"
    name = _SPECIAL_CHARS_RE.sub("", name)
    name = re.sub(r'[\\/:*?"<>|：""《》？｜＊]', "_", name)
    name = re.sub(r"\s+", " ", name)
    name = "".join(" " if unicodedata.category(c) in ("Cc", "Cf") else c for c in name)
    return name.strip().rstrip(". ") or "untitled"


def build_headers(bkn, cookie):
    return {
        "Accept": "*/*",
        "Content-Type": "application/json",
        "X-Ima-Bkn": str(bkn),
        "X-Ima-Cookie": cookie,
        "User-Agent": IOS_UA,
        "From_browser_ima": "1",
    }


class ImaClient:
    def __init__(self):
        self.s = requests.Session()
        self.s.mount("https://", HTTPAdapter(pool_connections=8, pool_maxsize=16))
        self.cred = None  # {user_id, token, refresh_token, bkn, cookie, ...}
        self._lock = threading.Lock()

    # ---------- 凭证 ----------
    def load_cred(self):
        if os.path.exists(CRED_FILE):
            with open(CRED_FILE, encoding="utf-8") as f:
                self.cred = json.load(f)
            print(f"[i] 已加载凭证 user_id={self.cred['user_id']}"
                  f" token过期时间={time.ctime(self.cred['token_expire_time'])}")
        return self.cred

    def save_cred(self):
        with open(CRED_FILE, "w", encoding="utf-8") as f:
            json.dump(self.cred, f, ensure_ascii=False, indent=2)

    def build_cookie(self, user_id, token, refresh_token):
        parts = [f"{k}={v}" for k, v in FIXED_COOKIE_FIELDS.items()]
        parts.insert(2, f"IMA-UID={user_id}")
        parts.insert(3, f"IMA-TOKEN={token}")
        parts.append(f"IMA-REFRESH-TOKEN={refresh_token}")
        return "; ".join(parts)

    # ---------- 登录 ----------
    def login_qr(self):
        """微信扫码登录全流程（逆向自 services/login_service.pyc）"""
        h = {"User-Agent": WEB_UA,
             "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
             "Accept-Language": "zh-CN,zh;q=0.9"}
        r = self.s.get("https://open.weixin.qq.com/connect/qrconnect", params={
            "appid": WX_APPID, "scope": "snsapi_login", "redirect_uri": WX_REDIRECT,
            "state": "", "login_type": "jssdk", "self_redirect": "true",
            "style": "dark", "stylelite": "1"}, headers=h, timeout=10)
        m = re.search(r'/connect/qrcode/([^"]+)', r.text)
        if not m:
            raise RuntimeError("获取二维码uuid失败")
        uuid = m.group(1)
        qr_url = "https://open.weixin.qq.com/connect/qrcode/" + uuid
        print(f"[i] 二维码链接: {qr_url}")
        qr_file = os.path.join(os.path.dirname(CRED_FILE), "login_qr.png")
        try:
            img = self.s.get(qr_url, headers=h, timeout=10).content
            with open(qr_file, "wb") as f:
                f.write(img)
            print(f"[i] 二维码已存: {qr_file} （微信扫码登录）")
            try:
                from PIL import Image
                Image.open(qr_file).show()
            except Exception:
                pass
        except Exception as ex:
            print(f"[!] 二维码下载失败({ex}), 用上面链接手动出码")

        wx_code = None
        poll_h = {"User-Agent": WEB_UA, "Accept": "*/*",
                  "Referer": "https://open.weixin.qq.com/"}
        print("[i] 等待扫码…")
        deadline = time.time() + 300
        while time.time() < deadline:
            try:
                r = self.s.get("https://lp.open.weixin.qq.com/connect/l/qrconnect",
                               params={"uuid": uuid, "last": ""}, headers=poll_h, timeout=35)
                errcode = re.search(r"window\.wx_errcode=(\d+)", r.text)
                code_m = re.search(r"window\.wx_code='([^']*)'", r.text)
                ec = errcode.group(1) if errcode else "0"
            except (requests.Timeout, requests.RequestException):
                continue
            if ec == "405" and code_m and code_m.group(1):
                wx_code = code_m.group(1)
                print("[✓] 扫码成功")
                break
            if ec == "404":
                print("[i] 已扫描，请在手机上确认…")
            elif ec == "403":
                print("[!] 二维码过期，重新获取…")
                return self.login_qr()
            elif ec == "402":
                print("[!] 二维码过期，重新获取…")
                return self.login_qr()
            time.sleep(1.5)
        if not wx_code:
            raise RuntimeError("5分钟未扫码")

        payload = {"account_type": 2, "code": wx_code, "auth_appid": WX_APPID,
                   "client_info": {"guid": GUID, "platform": 4, "qimei36": QIMEI36}}
        r = self.s.post(CGI + EP["login"], json=payload, headers={
            "User-Agent": WEB_UA, "Content-Type": "application/json", "Accept": "*/*",
            "Origin": IMA_BASE, "Referer": IMA_BASE + "/"}, timeout=15)
        r.raise_for_status()
        res = r.json()
        if res.get("code") != 0:
            raise RuntimeError(f"登录失败: {res.get('msg') or res}")
        token = res["token"]; rt = res["refresh_token"]; uid = res["user_id"]
        tvt = int(res.get("token_valid_time", 7200))
        rtvt = int(res.get("refresh_token_valid_time", 2592000))
        now = int(time.time())
        self.cred = {
            "user_id": uid, "token": token, "refresh_token": rt,
            "bkn": str(calculate_bkn(token)),
            "cookie": self.build_cookie(uid, token, rt),
            "token_expire_time": now + tvt,
            "refresh_token_expire_time": now + rtvt,
        }
        self.save_cred()
        print(f"[✓] IMA登录成功 user_id={uid} token有效期{tvt}s")
        return True

    def ensure_token(self):
        c = self.cred
        if not c:
            raise RuntimeError("未登录，先跑 login")
        now = time.time()
        if now < c["token_expire_time"] - 300:
            return
        if now >= c["refresh_token_expire_time"]:
            print("[!] refresh_token 也过期，需要重新扫码")
            return self.login_qr()
        print("[i] token 过期，自动刷新…")
        r = self.s.post(CGI + EP["refresh"], json={
            "user_id": c["user_id"], "refresh_token": c["refresh_token"],
            "token_type": 14}, headers={
            "User-Agent": WEB_UA, "Content-Type": "application/json", "Accept": "*/*",
            "Origin": IMA_BASE, "Referer": IMA_BASE + "/wikis?webFrom=10000050",
            "X-Ima-Cookie": (f"IMA-GUID={GUID}; IMA-Q36={QIMEI36}; IMA-IUA={WEB_UA}; "
                             "PLATFORM=H5; CLIENT-TYPE=256052; WEB-VERSION=999.999.999"),
            "From_browser_ima": "1"}, timeout=14)
        r.raise_for_status()
        res = r.json()
        if res.get("code") != 0:
            raise RuntimeError(f"刷新失败: {res.get('msg')}")
        token = res["token"]
        tvt = int(res.get("token_valid_time", 7200))
        # 响应可能带 set-cookie 中的新 IMA-TOKEN
        c["token"] = token
        c["bkn"] = str(calculate_bkn(token))
        c["token_expire_time"] = int(time.time()) + tvt
        c["cookie"] = self.build_cookie(c["user_id"], token, c["refresh_token"])
        self.save_cred()
        print("[✓] token 已刷新")

    # ---------- API ----------
    def api(self, endpoint, payload=None, timeout=(5, 20), retries=3):
        self.ensure_token()
        url = CGI + EP[endpoint]
        hdr = build_headers(self.cred["bkn"], self.cred["cookie"])
        last = None
        for i in range(retries):
            try:
                r = self.s.post(url, json=payload or {}, headers=hdr, timeout=timeout)
                r.raise_for_status()
                res = r.json()
                # 600001=登录过期（原版 is_auth_expired_response 实锤）：强制刷新一次后重试
                if res.get("code") == 600001 and i == 0:
                    self.cred["token_expire_time"] = 0
                    self.ensure_token()
                    hdr = build_headers(self.cred["bkn"], self.cred["cookie"])
                    continue
                return res
            except (requests.Timeout, requests.ConnectionError) as ex:
                last = ex
                time.sleep(2 * (i + 1))
        raise RuntimeError(f"请求失败 {endpoint}: {last}")

    def get_kb_list(self, kb_type=1, limit=49):
        res = self.api("get_knowledge_base_list", {"type": kb_type, "limit": limit},
                       timeout=(5, 90))
        if res.get("code") != 0:
            raise RuntimeError(f"get_knowledge_base_list: {res.get('msg')} code={res.get('code')}")
        return res

    def search_kb_plaza(self, query, limit=10, cursor=""):
        """知识库广场搜库（实测可用）"""
        res = self.api("search_knowledge_base", {"query": query, "limit": limit,
                                                 "cursor": cursor})
        if res.get("code") != 0:
            raise RuntimeError(f"search_knowledge_base: {res.get('msg')}")
        return res

    def join_kb(self, kb_id):
        """加入知识库（免审核库直接成功；付费库需另行订阅）"""
        res = self.api("join_knowledge", {"knowledge_base_id": kb_id})
        ok = res.get("code") == 0
        print(f"[{'✓' if ok else '✗'}] join {kb_id}: {res.get('msg')} "
              f"need_review={res.get('need_review')}")
        return ok

    def get_knowledge_list(self, kb_id, folder_id="", limit=30, cursor=""):
        res = self.api("get_knowledge_list", {
            "limit": limit, "knowledge_base_id": kb_id,
            "folder_id": folder_id, "cursor": cursor})
        if res.get("code") != 0:
            raise RuntimeError(f"get_knowledge_list: code={res.get('code')} {res.get('msg')}")
        return res

    def get_file_count(self, kb_id):
        res = self.get_knowledge_list(kb_id, limit=1)
        return res.get("total_size", 0)

    @staticmethod
    def decode_cursor(cursor):
        try:
            raw = base64.b64decode(cursor)
            return int.from_bytes(raw[:8], "big") if len(raw) >= 8 else 0
        except Exception:
            return 0

    def should_paginate(self, next_cursor, limit):
        if not next_cursor:
            return False
        return self.decode_cursor(next_cursor) < limit * 10000  # 保守翻页

    def extract_folders_and_files(self, knowledge_list):
        """逆向自 ima_service.extract_folders_and_files"""
        folders, files = [], []
        for it in knowledge_list or []:
            mti = it.get("media_type_info") or {}
            if it.get("media_type") == 99 or mti.get("name") == "文件夹":
                folders.append({
                    # 实测：文件夹真实ID在 media_id（folder_ 前缀），folder_id 字段常为空
                    "folder_id": it.get("folder_id") or it.get("media_id", ""),
                    "name": it.get("title") or (mti.get("name") or ""),
                    "file_number": int(it.get("file_number", "0") or 0),
                    "folder_number": int(it.get("folder_number", "0") or 0),
                    "parent_folder_id": it.get("parent_folder_id", ""),
                    "update_time": (it.get("time_wording") or "").replace("更新", "-"),
                    "type": "folder",
                })
            else:
                tags = it.get("tags") or []
                if isinstance(tags, dict):
                    tags = list(tags.values())
                files.append({
                    "media_id": it.get("media_id", ""),
                    "title": it.get("title", ""),
                    "media_type": it.get("media_type", 0),
                    "media_type_info": mti,
                    "file_size": it.get("file_size", 0),
                    "update_time": (it.get("time_wording") or "").replace("更新", "-"),
                    "parent_folder_id": it.get("parent_folder_id", ""),
                    "access_status": it.get("access_status", 3),
                    "tags": tags,
                    "type": "file",
                })
        return folders, files

    def get_folder_content(self, kb_id, folder_id="", limit=30):
        """单层内容（自动翻页）"""
        folders, files = [], []
        cursor = ""
        while True:
            res = self.get_knowledge_list(kb_id, folder_id, limit, cursor)
            f, fl = self.extract_folders_and_files(res.get("knowledge_list"))
            folders += f
            files += fl
            nc = res.get("next_cursor")
            if res.get("is_end") or not nc or not self.should_paginate(nc, limit):
                break
            cursor = nc
        return {"folders": folders, "files": files}

    def get_all_files_recursive(self, kb_id, folder_id="", current_path=""):
        """整库递归扫描（逆向自 ima_service.get_all_files_recursive）"""
        out = []
        content = self.get_folder_content(kb_id, folder_id)
        for f in content["files"]:
            f = dict(f)
            f["path"] = current_path
            out.append(f)
        for d in content["folders"]:
            sub = self.get_all_files_recursive(kb_id, d["folder_id"],
                                               (current_path + "/" + d["name"]).strip("/"))
            out.extend(sub)
        return out

    def search(self, kb_id, query, cursor="", policy="", filters=None):
        payload = {"cursor": cursor, "query": query, "knowledge_base_id": kb_id,
                   "compared_knowledge_base_id": kb_id,
                   "policy": policy, "forbid_default_cover": False}
        if filters:
            payload["filters"] = filters
        res = self.api("search_knowledge", payload)
        if res.get("code") != 0:
            raise RuntimeError(f"search: code={res.get('code')} {res.get('msg')}")
        return res

    def get_media_url(self, media_id, kb_id):
        """返回 (url, headers, title)；逆向自 ima_service.get_media_url"""
        res = self.api("get_media", {"media_id": media_id, "knowledge_base_id": kb_id},
                       timeout=(5, 15))
        if res.get("code") != 0:
            return None, None, None
        jui = (res.get("jump_url_info") or {})
        url = (jui.get("url") or "").replace("\\u0026", "&")
        return url, jui.get("headers"), res.get("title") or "unknown"

    # ---------- 笔记内容（逆向自 get_note_content + ImaNoteMdParser） ----------
    def get_note_content(self, docid, kb_id):
        res = self.api("get_share_know_doc", {
            "docid": docid, "knowledge_id": kb_id,
            "op": {"op_attach": True, "op_basic": True, "op_content": True,
                   "op_resource": True, "disable_cover": False}}, timeout=(5, 20))
        if res.get("code") != 0:
            return None, None, None, f"code={res.get('code')} {res.get('msg') or res.get('message')}"
        di = res.get("doc_info") or {}
        content = ((di.get("content_info") or {}).get("content")) or ""
        title = ((di.get("basic_info") or {}).get("title")) or "untitled"
        link_map = ((di.get("doc_link") or {}).get("link_map")) or {}
        return content, title, link_map, None

    @staticmethod
    def note_to_markdown(nodes, link_map=None):
        """逆向自 ImaNoteMdParser"""
        link_map = link_map or {}
        out = []

        def img_url(node):
            u = (node.get("url") or "").split("?")[0]
            if u in link_map:
                return link_map[u]
            return u

        def text(node):
            t = node.get("text") or ""
            marks = node.get("marks") or []
            for m in marks:
                k = m.get("type")
                if k == "bold":
                    t = f"**{t}**"
                elif k == "italic":
                    t = f"*{t}*"
                elif k == "strikethrough":
                    t = f"~~{t}~~"
            return t

        def children(ch, in_link=None):
            parts = []
            for c in ch or []:
                ty = c.get("type")
                if ty == "a":
                    u = c.get("url") or ""
                    if u in link_map:
                        u = link_map[u]
                    inner = "".join(children(c.get("children") or []) or [c]) or (c.get("text") or "")
                    parts.append(f"[{inner or (c.get('text') or '')}]({u})")
                elif ty == "text":
                    parts.append(text(c))
                elif ty == "cloud_image":
                    parts.append(f"![图片]({img_url(c)})")
                elif ty == "p":
                    parts.append(children(c.get("children") or []))
                else:
                    parts.append(c.get("text") or "")
            return "".join(parts)

        def nodes_md(ns):
            for n in ns or []:
                ty = n.get("type")
                if ty == "cursor-side":
                    for c in n.get("children") or []:
                        if c.get("type") == "cloud_image":
                            out.append(f"![图片]({img_url(c)})")
                elif ty == "p":
                    out.append(children(n.get("children") or []).strip() if isinstance(children(n.get("children") or []), str) else children(n.get("children") or []))
                elif ty in ("h1", "h2", "h3", "h4"):
                    out.append("#" * int(ty[1]) + " " + children(n.get("children") or []))
                elif ty == "cloud_image":
                    out.append(f"![图片]({img_url(n)})")
                elif ty == "blockquote":
                    inner = nodes_md_copy(n.get("children") or [])
                    out.append("\n".join("> " + l for l in inner.split("\n")))
                elif ty == "code_block":
                    lines = []
                    for c in n.get("children") or []:
                        if c.get("type") == "code_line":
                            lines.append(c.get("text") or "")
                    out.append("```\n" + "\n".join(lines) + "\n```")
                elif ty == "table":
                    rows = nodes_md_copy_rows(n.get("children") or [])
                    if rows:
                        out.append("| " + " | ".join(rows[0]) + " |")
                        out.append("| " + " | ".join("---" for _ in rows[0]) + " |")
                        for r in rows[1:]:
                            out.append("| " + " | ".join(r) + " |")
                elif ty == "text":
                    out.append(text(n))
            return "\n\n".join(x for x in out if x is not None)

        def nodes_md_copy(ns):
            saved, out[:] = out[:], []
            nodes_md(ns)
            r = "\n".join(out)
            out[:] = saved
            return r

        def nodes_md_copy_rows(ns):
            rows = []
            for tr in ns:
                if tr.get("type") == "tr":
                    saved, out[:] = out[:], []
                    for td in tr.get("children") or []:
                        out[:] = []
                        rows.append(nodes_md_copy(td.get("children") or []) or " ")
                    # flatten handled below
            return rows

        return nodes_md(nodes)

    def get_report_content(self, report_id, kb_id):
        res = self.api("get_task_report", {"report_id": report_id,
                                           "knowledge_base_id": kb_id}, timeout=(5, 20))
        if res.get("code") != 0:
            return None, None, f"code={res.get('code')} {res.get('msg')}"
        title = res.get("title") or "untitled"
        blocks = ((res.get("format_answer") or {}).get("block_list")) or []
        return title, blocks, None

    # ---------- 下载（media_type 分发逆向自 download_single_file） ----------
    def download_media(self, media_id, kb_id, save_dir, title="", media_type=0,
                       media_type_info=None, delay=(1, 3), link_log=None):
        """按 media_type 分发:
        11+笔记 -> get_share_know_doc -> .md
        2+ima报告 -> get_task_report -> .html
        2+网址/腾讯新闻, 6+公众号 -> 链接写台账(.html占位)
        其他 -> get_media -> jump_url 直下"""
        type_name = (media_type_info or {}).get("name", "")
        safe = sanitize_filename(title or media_id)
        # 台账幂等跳过
        recs = load_records()
        if media_id in recs and os.path.exists(recs[media_id].get("local_path", "")):
            return "skip", recs[media_id]["local_path"]
        if delay:
            time.sleep(random.uniform(*delay))
        os.makedirs(save_dir, exist_ok=True)

        # 笔记
        if media_type == 11 and type_name == "笔记":
            content, rtitle, link_map, err = self.get_note_content(media_id, kb_id)
            if err:
                return "fail", f"{safe}: {err}"
            if not title and rtitle:
                safe = sanitize_filename(rtitle)
            path = os.path.join(save_dir, safe + ".md")
            md = self.note_to_markdown(content if isinstance(content, list) else [], link_map)
            with open(path, "w", encoding="utf-8") as f:
                f.write(md or "")
            save_record(media_id, safe, path, rtitle)
            return "ok", path

        # ima 报告
        if media_type == 2 and type_name == "ima 报告":
            rtitle, blocks, err = self.get_report_content(media_id, kb_id)
            if err:
                return "fail", f"{safe}: {err}"
            if not title and rtitle:
                safe = sanitize_filename(rtitle)
            path = os.path.join(save_dir, safe + ".html")
            with open(path, "w", encoding="utf-8") as f:
                f.write(f"<html><head><meta charset='utf-8'><title>{safe}</title></head>"
                        f"<body><h1>{safe}</h1><pre>{json.dumps(blocks, ensure_ascii=False, indent=1)}</pre></body></html>")
            save_record(media_id, safe, path, rtitle)
            return "ok", path

        # 链接型（网址/腾讯新闻/公众号）
        if (media_type == 2 and type_name in ("网址", "腾讯新闻")) or (
                media_type == 6 and type_name == "公众号"):
            url, _, rtitle = self.get_media_url(media_id, kb_id)
            if url:
                if link_log is not None:
                    link_log.append({"media_id": media_id, "title": title or rtitle,
                                     "type": type_name, "url": url, "path": save_dir})
                save_record(media_id, safe, url, rtitle)
                return "link", url
            return "fail", f"{safe}: 无链接"

        # 普通文件
        url, dl_headers, rtitle = self.get_media_url(media_id, kb_id)
        if not url:
            return "fail", f"{safe}: 无下载URL"
        if not title:
            safe = sanitize_filename(rtitle)
        m = re.search(r"\.([a-zA-Z0-9]+)(?:\?|$)", url.split("?")[0])
        url_ext = ("." + m.group(1)) if m else ""
        if url_ext and not safe.lower().endswith(url_ext.lower()):
            if "." not in safe or not safe.rsplit(".", 1)[-1].isalnum():
                safe = safe + url_ext
        path = os.path.join(save_dir, safe)
        try:
            r = self.s.get(url, headers=dl_headers or {"User-Agent": IOS_UA},
                           stream=True, timeout=(10, 300))
            r.raise_for_status()
            tmp = path + ".part"
            with open(tmp, "wb") as f:
                for chunk in r.iter_content(1 << 20):
                    f.write(chunk)
            os.replace(tmp, path)
            save_record(media_id, safe, path, rtitle)
            return "ok", path
        except Exception as ex:
            return "fail", f"{safe}: {ex}"


def load_records():
    if os.path.exists(RECORDS_FILE):
        try:
            with open(RECORDS_FILE, encoding="utf-8") as f:
                return json.load(f)
        except Exception:
            return {}
    return {}


def save_record(media_id, name, path, title=""):
    recs = load_records()
    recs[media_id] = {"file_name": name, "local_path": path, "download_time": int(time.time())}
    tmp = RECORDS_FILE + ".tmp"
    with open(tmp, "w", encoding="utf-8") as f:
        json.dump(recs, f, ensure_ascii=False)
    os.replace(tmp, RECORDS_FILE)


# ============ CLI ============
def cmd_login(c):
    c.login_qr()


def cmd_kbs(c):
    res = c.get_kb_list()
    for kb in res.get("knowledge_base_list", []):
        cnt = "?"
        try:
            cnt = c.get_file_count(kb.get("knowledge_base_id"))
        except Exception:
            pass
        print(f"  [{kb.get('knowledge_base_id')}] {kb.get('name')}  文件数≈{cnt}")


def cmd_scan(c, kb_id, out_json):
    files = c.get_all_files_recursive(kb_id)
    print(f"[✓] 扫描完成 {len(files)} 个文件")
    with open(out_json, "w", encoding="utf-8") as f:
        json.dump(files, f, ensure_ascii=False, indent=1)
    print(f"[i] 清单已存 {out_json}")


def cmd_download(c, kb_id, out_dir, workers=4, limit=None):
    print(f"[i] 扫描知识库 {kb_id} …")
    files = c.get_all_files_recursive(kb_id)
    if limit:
        files = files[:limit]
    print(f"[i] 共 {len(files)} 个文件, {workers} 并发, 输出 {out_dir}")
    ok = fail = skip = links = 0
    lock = threading.Lock()
    link_log = []

    def one(fi):
        sub = os.path.join(out_dir, sanitize_filename(fi.get("path") or ""))
        st, info = c.download_media(fi["media_id"], kb_id, sub,
                                    title=fi.get("title", ""),
                                    media_type=fi.get("media_type", 0),
                                    media_type_info=fi.get("media_type_info") or {},
                                    link_log=link_log)
        return st, info, fi

    with ThreadPoolExecutor(max_workers=workers) as ex:
        futs = [ex.submit(one, fi) for fi in files]
        for i, fu in enumerate(as_completed(futs), 1):
            st, info, fi = fu.result()
            with lock:
                if st == "ok":
                    ok += 1
                    print(f"  ✓ [{i}/{len(files)}] {os.path.basename(str(info))}")
                elif st == "skip":
                    skip += 1
                elif st == "link":
                    links += 1
                else:
                    fail += 1
                    print(f"  ✗ [{i}/{len(files)}] {info}")
    if link_log:
        lp = os.path.join(out_dir, "_链接清单.json")
        with open(lp, "w", encoding="utf-8") as f:
            json.dump(link_log, f, ensure_ascii=False, indent=1)
        print(f"[i] 链接型条目 {links} 条已记 {lp}")
    print(f"[✓] 完成 ok={ok} skip={skip} link={links} fail={fail}")


def cmd_plaza(c, query):
    """广场搜库"""
    res = c.search_kb_plaza(query, limit=10)
    kbs = res.get("searched_knowledge_bases") or []
    print(f"搜「{query}」命中 {len(kbs)} 库:")
    for k in kbs:
        print(f"  [{k.get('id')}] {k.get('name')}  join_type={k.get('join_type')} "
              f"creator={(k.get('creator_info') or {}).get('nickname','')}  "
              f"desc={(k.get('description') or '')[:40]}")


def main():
    args = sys.argv[1:]
    c = ImaClient()
    if not args or args[0] in ("help", "-h"):
        print(__doc__)
        print("用法: ima_replica.py login | kbs | plaza <关键词> | join <kb_id> | "
              "scan <kb_id> <out.json> | download <kb_id> <out_dir> [--workers N] [--limit N] | "
              "search <kb_id> <关键词>")
        return
    cmd = args[0]
    if cmd == "login":
        return cmd_login(c)
    c.load_cred()
    if cmd == "kbs":
        return cmd_kbs(c)
    if cmd == "plaza":
        return cmd_plaza(c, args[1])
    if cmd == "join":
        c.join_kb(args[1])
        return
    if cmd == "scan":
        return cmd_scan(c, args[1], args[2])
    if cmd == "search":
        res = c.search(args[1], " ".join(args[2:]))
        for it in (res.get("knowledge_list") or [])[:30]:
            print(f"  [{it.get('media_id')}] {it.get('title')}")
        return
    if cmd == "download":
        kb_id, out_dir = args[1], args[2]
        workers = int(args[args.index("--workers") + 1]) if "--workers" in args else 4
        limit = int(args[args.index("--limit") + 1]) if "--limit" in args else None
        return cmd_download(c, kb_id, out_dir, workers, limit)
    print("未知命令", cmd)


if __name__ == "__main__":
    main()
