# -*- coding: utf-8 -*-
"""metaso_kb_api.py — 秘塔(metaso.cn)知识库专题 检索+下载 纯HTTP复刻件 (metaso-kb-reverse 1024)
================================================================
逆向结论 (证据: ../captures/):
  1. 登录 (密码面, 协议全破; 见 work/scope.md 凭据纪律):
     POST https://metaso.cn/login  {login_by:"account", account:<手机号/邮箱>, pwd:<RSA-JSEncrypt>}
     - RSA 公钥内置在前端 chunk (PKCS#1 v1.5, JSEncrypt 同构), 下方 RSA_PUB
     - 必带头: token=<首页 #meta-token> + cookie面(tid/aliyungf_tc/JSESSIONID预热)
     - 响应 {code:0}=成功(会话进cookie sid), {code:1003}=账号或密码不正确, {code:2704}=滑块
     - 手机号注册性判别: POST /verify?type=login_sms {phone:"86-<phone>"}
       {code:2701,"手机号不存在,请先注册!"}=号未注册(不发短信); 其他=已注册(发短信, 本件永不代收)
  2. 检索 (公开面, 免登录即可用——本专题 owner 公开了搜索):
     GET https://metaso.cn/api/knowledge/{sid}/search?s=<kw>&parentId=&pageSize=&pageIndex=
        [&sort=&sortDirection=]
     - 响应 {errCode:0, data:{content:[{id,fileName,size,pages,parentId,topicId,...}], totalElements,...}}
     - sort 传 updateTime 会把多词 s 当短语致空结果 → 无排序语义时省略 sort
  3. 下载 (owner面; 匿名=4401 岛主暂未开放下载权限 / preview=4402 请订阅):
     a. GET  /api/file/{fid}/ticket                    → {errCode:0,data:"<ticket>"}
     b. GET  https://files.metaso.cn/api/file/{fid}/stream-download?ticket=<urlenc>
        (浏览器即 a.href 直下; 文件主机=files.metaso.cn, 同链 metaso.cn 亦可)
     c. 批量: POST {files}/api/file/batch-download {ids:[...]} → zip blob
     d. 预检: GET /api/file/{fid}/check-download-size; POST /api/file/check-download-size {ids}
  4. 文件元数据: GET /api/file/{fid}/meta; 归属: GET /api/knowledge/detail/{rootId};
     失败清单: GET /api/knowledge/{sid}/failed-files
凭据纪律: 一切凭据/登录态读 E:/AI-Station/data/secrets/ (gitignored), 永不硬编码。
用法 (CLI):
  py -3 metaso_kb_api.py search "EPC" [--page 0] [--size 30] [--json out.json]
  py -3 metaso_kb_api.py download <fileId> [--out 落盘路径]
  py -3 metaso_kb_api.py login           (验证凭据并持久化登录态)
  py -3 metaso_kb_api.py info <fileId>   (meta)
import: from metaso_kb_api import MetasoKB  (见模块尾示例)
"""
import argparse, base64, json, os, re, sys, time, uuid

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
try:
    from curl_cffi import requests as cr
except ImportError:
    sys.exit("need curl_cffi: pip install curl_cffi")

HOME = "https://metaso.cn/"
FILES_HOST = "https://files.metaso.cn"
SECRET_FILE = r"E:/AI-Station/data/secrets/metaso_kb.secret"
STATE_FILE = r"E:/AI-Station/data/secrets/metaso_kb_state.json"
DEFAULT_SID = "8673582927558737920"  # 工程行业大脑 (用户自有专题)
UA_HEADERS = {"origin": "https://metaso.cn", "referer": "https://metaso.cn/",
              "accept-language": "zh-CN,zh;q=0.9"}

# 前端 chunks_41209 内置 RSA 公钥 (JSEncrypt PKCS#1 v1.5 同构)
RSA_PUB = ("MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCX4kRYjU6XclWT4mwxgQ55JerRar8CPEHp4uZRITqZuk8p"
           "0z5UTL02muequw2dgvgNlJkE8C7eyXf1S8TH+MvbVkHnCoKKigAPb08PtqcvVIqnZn+kNDpiQZapkpHrEXe"
           "R+rWfj3etTwMHYbV+zTaKOdxa7fm3oO4CWbgmfkSC8wIDAQAB")


def rsa_encrypt_pwd(pwd: str) -> str:
    """JSEncrypt 同构: RSAES-PKCS1-v1_5(password utf-8) → base64"""
    try:
        from Crypto.Cipher import PKCS1_v1_5
        from Crypto.PublicKey import RSA
        c = PKCS1_v1_5.new(RSA.import_key(base64.b64decode(RSA_PUB)))
        return base64.b64encode(c.encrypt(pwd.encode("utf-8"))).decode()
    except ImportError:
        # 纯python兜底 (同 padding)
        der = base64.b64decode(RSA_PUB)
        def rlen(b, i):
            l = b[i]; i += 1
            if l & 0x80:
                k = l & 0x7F; l = int.from_bytes(b[i:i+k], "big"); i += k
            return l, i
        def rint(b, i):
            assert b[i] == 0x02; i += 1
            l, i = rlen(b, i)
            return int.from_bytes(b[i:i+l], "big"), i + l
        _, i = rlen(der, 1); n, i = rint(der, i); e, _ = rint(der, i)
        k = (n.bit_length() + 7) // 8
        msg = pwd.encode("utf-8"); pad = k - 3 - len(msg)
        ps = b""
        while len(ps) < pad:
            ps += bytes(x for x in os.urandom(pad - len(ps)) if x)
        m = int.from_bytes(b"\x00\x02" + ps + b"\x00" + msg, "big")
        return base64.b64encode(pow(m, e, n).to_bytes(k, "big")).decode()


class MetasoKB:
    """秘塔知识库专题三段客户端: login(持久化) + search + download。"""

    def __init__(self, sid=DEFAULT_SID, secret_file=SECRET_FILE, state_file=STATE_FILE,
                 timeout=90, verbose=True):
        self.sid, self.timeout, self.v = sid, timeout, verbose
        self.secret_file, self.state_file = secret_file, state_file
        self.s = cr.Session(impersonate="chrome")
        self.s.cookies.set("tid", str(uuid.uuid4()), domain=".metaso.cn", path="/")
        self.s.cookies.set("_nb_ioWEgULi", "", domain=".metaso.cn", path="/")
        self.token = None
        self.logged_in = False

    def _log(self, *a):
        if self.v:
            print("[metaso-kb]", *a, file=sys.stderr)

    # ---------- 预热 (同域先例 metaso-reverse 的 meta-token 预热链) ----------
    def warmup(self):
        """GET home → #meta-token + aliyungf_tc; GET /api/search-template → JSESSIONID。"""
        r = self.s.get(HOME, timeout=30, headers=UA_HEADERS)
        r.raise_for_status()
        m = re.search(r'<meta id="meta-token" content="([^"]+)"', r.text)
        if not m:
            raise RuntimeError("meta-token not found (page shape changed?)")
        self.token = m.group(1)
        self.s.get("https://metaso.cn/api/search-template", timeout=25,
                   headers={**UA_HEADERS, "referer": HOME, "accept": "application/json"})
        self._log(f"warmup ok: token len={len(self.token)} cookies={sorted(self.s.cookies.keys())}")

    def _h(self, extra=None, refer=None):
        h = {"token": self.token or "",
             "origin": "https://metaso.cn",
             "referer": refer or f"https://metaso.cn/subject-v2/{self.sid}",
             "accept": "application/json, text/plain, */*"}
        if extra:
            h.update(extra)
        return h

    # ---------- 登录段 ----------
    def load_state(self):
        """从 secret 位载入持久化登录态(cookie面)。返回是否载入。"""
        if os.path.exists(self.state_file):
            try:
                st = json.load(open(self.state_file, encoding="utf-8"))
                for c in st.get("cookies", []):
                    self.s.cookies.set(c["name"], c["value"], domain=c.get("domain", ".metaso.cn"),
                                       path=c.get("path", "/"))
                self._log("state loaded:", len(st.get("cookies", [])), "cookies")
                return True
            except Exception as e:
                self._log("state load failed:", str(e)[:80])
        return False

    def save_state(self):
        cookies = [{"name": c.name, "value": c.value, "domain": c.domain, "path": c.path}
                   for c in self.s.cookies]
        os.makedirs(os.path.dirname(self.state_file), exist_ok=True)
        json.dump({"cookies": cookies, "saved_at": time.strftime("%Y-%m-%d %H:%M:%S"),
                   "sid": self.sid}, open(self.state_file, "w", encoding="utf-8"),
                  ensure_ascii=False, indent=1)
        self._log("state saved:", self.state_file)

    def login(self, force=False):
        """密码登录 + 登录态持久化。凭据只从 secret 文件读。
        返回 (ok, info)。服务端语义:
          code 0    = 成功 (会话在 cookie sid)
          code 1003 = 账号或密码不正确 (含: 账号未注册)
          code 2704 = 需滑块 (本件如实上报, 不破)
        手机号注册性判别: check_phone() — 未注册时 2701。"""
        if self.logged_in and not force:
            return True, "already logged in"
        if not force and self.load_state() and self._session_valid():
            self.logged_in = True
            return True, "state-reused"
        if self.token is None:
            self.warmup()
        sec = json.load(open(self.secret_file, encoding="utf-8")) if os.path.exists(self.secret_file) else {}
        phone, pwd = sec.get("phone") or sec.get("account"), sec.get("password")
        if not phone or not pwd:
            return False, "no credentials in secret file"
        r = self.s.post("https://metaso.cn/login",
                        json={"login_by": "account", "account": phone, "pwd": rsa_encrypt_pwd(pwd)},
                        timeout=60, headers=self._h(refer="https://metaso.cn/"))
        try:
            j = r.json()
        except Exception:
            return False, f"http {r.status_code} non-json"
        code = j.get("code")
        if code == 0:
            self.logged_in = True
            self.save_state()
            return True, "login ok (fresh)"
        self._log("login code:", code, j.get("msg"))
        return False, f"login rejected: code={code} msg={j.get('msg')}"

    def check_phone(self, cc="86"):
        """手机号注册性判别 (POST /verify?type=login_sms)。未注册→(False,'2701 未注册');
        已注册→(True,'已注册(服务端已发短信, 本件不代收)')。凭据从 secret 读。"""
        if self.token is None:
            self.warmup()
        sec = json.load(open(self.secret_file, encoding="utf-8")) if os.path.exists(self.secret_file) else {}
        phone = sec.get("phone")
        if not phone:
            return None, "no phone in secret"
        r = self.s.post("https://metaso.cn/verify?type=login_sms",
                        json={"phone": f"{cc}-{phone}"}, timeout=60, headers=self._h())
        j = r.json()
        if j.get("code") == 2701:
            return False, "手机号不存在,请先注册! (code 2701, 未发短信)"
        return True, f"已注册 (code={j.get('code')} msg={j.get('msg')}; 服务端可能已发短信——本件永不代收)"

    def _session_valid(self):
        """登录态实证: GET /api/my-info errCode==0。"""
        if self.token is None:
            try:
                self.warmup()
            except Exception:
                return False
        try:
            r = self.s.get("https://metaso.cn/api/my-info", timeout=30, headers=self._h())
            ok = r.json().get("errCode") == 0
            if ok:
                self._log("session valid (my-info errCode=0)")
            return ok
        except Exception:
            return False

    # ---------- 检索段 (公开面) ----------
    def search(self, q, page=0, size=30, parent_id=""):
        """知识库内检索文件。返回 {"files": [...], "total": N, "pages": N}。
        注意: 传 sort=updateTime 会使多词 s 命中塌缩 → 默认不带 sort。"""
        if self.token is None:
            self.warmup()
        params = {"s": q, "parentId": parent_id, "pageSize": size, "pageIndex": page}
        r = self.s.get(f"https://metaso.cn/api/knowledge/{self.sid}/search",
                       params=params, headers=self._h(), timeout=60)
        r.raise_for_status()
        j = r.json()
        if j.get("errCode") != 0:
            raise RuntimeError(f"search errCode={j.get('errCode')} msg={j.get('errMsg')}")
        d = j["data"]
        files = [{"id": it["id"], "fileName": it.get("fileName"),
                  "size": it.get("size"), "pages": it.get("pages"),
                  "parentId": it.get("parentId"), "topicId": it.get("topicId"),
                  "createTime": it.get("createTime"), "updateTime": it.get("updateTime"),
                  "contentType": it.get("contentType"), "originalUrl": it.get("originalUrl")}
                 for it in d.get("content", [])]
        return {"files": files, "total": d.get("totalElements"),
                "pages": d.get("totalPages"), "query": q, "page": page}

    def file_meta(self, fid):
        """GET /api/file/{fid}/meta — 文件详情 (公开面可用)。"""
        if self.token is None:
            self.warmup()
        r = self.s.get(f"https://metaso.cn/api/file/{fid}/meta", headers=self._h(), timeout=30)
        return r.json()

    # ---------- 下载段 (owner面) ----------
    def download(self, fid, out_path, refer=None):
        """下载原文件: ticket → files.metaso.cn stream-download → 落盘 + 魔数/大小校验。
        匿名会得 4401 (岛主暂未开放下载权限) → 需 owner 登录态。"""
        if self.token is None:
            self.warmup()
        refer = refer or f"https://metaso.cn/subject-v2/{self.sid}"
        # size 预检
        rc = self.s.get(f"https://metaso.cn/api/file/{fid}/check-download-size",
                        headers=self._h(), timeout=30)
        try:
            jc = rc.json()
            if jc.get("errCode") == 0:
                self._log("check-download-size:", jc.get("data"))
        except Exception:
            pass
        # ticket
        rt = self.s.get(f"https://metaso.cn/api/file/{fid}/ticket", headers=self._h(), timeout=30)
        jt = rt.json()
        if jt.get("errCode") != 0:
            return {"ok": False, "stage": "ticket", "errCode": jt.get("errCode"),
                    "errMsg": jt.get("errMsg")}
        ticket = jt["data"]
        url = f"{FILES_HOST}/api/file/{fid}/stream-download?ticket={ticket}"
        # 流式落盘
        with self.s.get(url, headers={**self._h({"accept": "*/*"}), "referer": refer},
                        timeout=self.timeout, stream=True) as r:
            ct = r.headers.get("content-type", "")
            if "json" in ct:
                j = r.json()
                return {"ok": False, "stage": "stream", "errCode": j.get("errCode"),
                        "errMsg": j.get("errMsg")}
            os.makedirs(os.path.dirname(os.path.abspath(out_path)), exist_ok=True)
            n = 0
            with open(out_path, "wb") as f:
                for chunk in r.iter_content(65536):
                    f.write(chunk); n += len(chunk)
        magic = open(out_path, "rb").read(8)
        return {"ok": True, "path": os.path.abspath(out_path), "bytes": n,
                "content_type": ct, "magic": magic.hex()}

    def batch_download(self, fids, out_path):
        """批量 zip: POST {FILES_HOST}/api/file/batch-download {ids:[...]}。"""
        if self.token is None:
            self.warmup()
        r = self.s.post(f"{FILES_HOST}/api/file/batch-download", json={"ids": fids},
                        headers=self._h({"accept": "application/zip, */*"}), timeout=300)
        if "json" in r.headers.get("content-type", ""):
            j = r.json()
            return {"ok": False, "errCode": j.get("errCode"), "errMsg": j.get("errMsg")}
        open(out_path, "wb").write(r.content)
        return {"ok": True, "path": out_path, "bytes": len(r.content)}


MAGIC = {b"%PDF-": "pdf", b"PK\x03\x04": "zip/docx/xlsx", b"\xd0\xcf\x11\xe0": "doc/xls",
         b"{\\rtf": "rtf"}


def sniff(magic8: bytes):
    for pre, name in MAGIC.items():
        if magic8.startswith(pre):
            return name
    return "binary/text"


def main():
    ap = argparse.ArgumentParser(description="秘塔知识库专题 纯HTTP复刻件 (检索/下载/登录)")
    ap.add_argument("cmd", choices=["search", "download", "login", "info", "check-phone"])
    ap.add_argument("arg", nargs="?", help="search=关键词 | download/info=fileId")
    ap.add_argument("--sid", default=DEFAULT_SID)
    ap.add_argument("--page", type=int, default=0)
    ap.add_argument("--size", type=int, default=30)
    ap.add_argument("--json", dest="jout")
    ap.add_argument("--out", help="download 落盘路径")
    ap.add_argument("--quiet", action="store_true")
    a = ap.parse_args()
    c = MetasoKB(sid=a.sid, verbose=not a.quiet)

    if a.cmd == "login":
        ok, info = c.login(force=True)
        print(("OK " if ok else "FAIL ") + info)
        if ok:
            r = c.s.get("https://metaso.cn/api/my-info", headers=c._h(), timeout=30)
            d = r.json().get("data") or {}
            ph = (d.get("phone") or "")
            print("my-info:", d.get("name"), (ph[:3] + "****" + ph[-4:]) if ph else "-")
        sys.exit(0 if ok else 2)

    if a.cmd == "check-phone":
        reg, info = c.check_phone()
        print(("REGISTERED " if reg else "NOT-REGISTERED ") + info)
        sys.exit(0)

    if a.cmd == "search":
        res = c.search(a.arg, page=a.page, size=a.size)
        if a.jout:
            open(a.jout, "w", encoding="utf-8").write(json.dumps(res, ensure_ascii=False, indent=1))
        print(f"query={res['query']} hits={len(res['files'])} total={res['total']} "
              f"totalPages={res['pages']}")
        for f in res["files"][:10]:
            print(f"  - {f['fileName'][:56]} | id={f['id']} | {f['size']}B | p{f['pages']}")
        sys.exit(0 if res["files"] else 1)

    if a.cmd == "info":
        j = c.file_meta(a.arg)
        print(json.dumps(j, ensure_ascii=False)[:800])
        sys.exit(0 if j.get("errCode") == 0 else 1)

    if a.cmd == "download":
        out = a.out or (a.arg + ".bin")
        r = c.download(a.arg, out)
        if r.get("ok"):
            m = sniff(bytes.fromhex(r["magic"]))
            print(f"OK {r['path']} {r['bytes']}B type={m} ct={r['content_type']}")
        else:
            print(f"FAIL stage={r['stage']} errCode={r.get('errCode')} msg={r.get('errMsg')}")
        sys.exit(0 if r.get("ok") else 2)


if __name__ == "__main__":
    main()
