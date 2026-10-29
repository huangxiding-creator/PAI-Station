# -*- coding: utf-8 -*-
"""BdnApi：只读操作 + 写面（W4：mkdir/filemanager/上传三段/locateupload/metas?dlink=1/filediff）。

写面通道结论（W4 实测 2026-10-29）：
- **/api 家族写面全通**：POST /api/create（isdir=1 建目录 / 文件合并收尾，errno=0 带 fs_id；
  -8=已存在幂等）+ POST /api/filemanager（opera 四合一，info[] 逐条 errno）；query 需
  clienttype=8&app_id=250528&web=1，bdstoken 不需要。
- xpan 写面（file?method=create/filemanager）→ **9019 need verify**（风控验证墙，本账号死路）；
- pcs 遗产 mkdir → **假成功**（errno=0 但目录不落盘，勿用）；
- superfile2 数据面：门=参数完整度（vip=2/web=1/app_id + path query+form 双放）；
  UA 双腿均放行（ss-judge 1029 重放：native UA+全参=200；勘误见 ERRATA_1029.md）；
  失败信使是 error_code 不是 errno（31023=缺参/31024=缺 app_id）。
"""
from __future__ import annotations

import hashlib
import json
import time

from .errors import BdnApiError
from .session import BdnSession

MAX_NUM = 1000          # /api/list 单页上限（蓝本 #511 教训：PCS 通道 num 被忽略，必走翻页保护）
MAX_PAGES_PER_DIR = 10  # 单目录翻页护栏

# filediff 全参模板（CAPTURE_INVENTORY §六 + W1_LIVENESS #9：极简 query 被 RST，参数完整度有门）
FILEDIFF_QUERY = {
    "block_list": 1,
    "clienttype": 8,
    "channel": "00000000000000000000000040000001",
    "version": "8.2.5.103",
    "deviceid": "152236194638317114",
    "dname": "惠普",
}
APP_ID = 250528         # 蓝本 PanAppID（baidupcs.go:114）

# /api 家族写面公共 query（W4 实测 1029 放行形态；xpan 写面 9019 need verify 不可用）
_WEB_Q = {"clienttype": 8, "app_id": APP_ID, "web": 1}


def _ensure_abs(dir_path: str) -> str:
    """本战役约定：远端路径一律全盘绝对路径（/ 开头），与官方 bdpan 沙箱的本质区别。"""
    if not isinstance(dir_path, str) or not dir_path.startswith("/"):
        raise BdnApiError(-7, f"远端路径必须以 / 开头（全盘绝对路径）: {dir_path!r}")
    return dir_path if dir_path != "" else "/"


def _to_bool(v) -> bool:
    """isdir 归一：api 家族回字符串 '0'/'1'（bool('0')==True 的坑），xpan 回 int。"""
    try:
        return bool(int(v or 0))
    except (TypeError, ValueError):
        return bool(v)


def _normalize_entry(e: dict) -> dict:
    """api/list 与 xpan 两家族字段名差异归一。"""
    name = e.get("server_filename") or e.get("filename") or e.get("name") or ""
    isdir = _to_bool(e.get("isdir", 0))
    return {
        "fs_id": e.get("fs_id"),
        "path": e.get("path"),
        "name": name,
        "isdir": isdir,
        "size": e.get("size", 0),
        "category": e.get("category"),
        "md5": e.get("md5"),
        "dlink": e.get("dlink"),
        "server_mtime": e.get("server_mtime") or e.get("local_mtime"),
        "is_file": not isdir,
    }


class BdnApi:
    def __init__(self, session: BdnSession):
        self.s = session

    # ---------- 登录态/账号 ----------

    def login_status(self) -> dict:
        """GET /api/loginStatus（已实证）：账号画像在 login_info 子字典（探针实证 1029）。"""
        p = self.s.get("/api/loginStatus", params={"clienttype": 8})
        info = p.get("login_info") or {}
        p["account"] = {
            "username": info.get("username"), "uk": info.get("uk"),
            "vip_level": info.get("vip_level"), "vip_type": info.get("vip_type"),
            "vip_identity": info.get("vip_identity"),
            "photo": "yes" if info.get("photo_url") else "no",
            "bdstoken_masked": True,   # bdstoken 绝不落输出，只留掩码标记
        }
        return p

    def quota(self) -> dict:
        """配额（语义读）：先 GET /api/quota，不通再 POST /api/quota。"""
        params = {"clienttype": 8, "checkfree": 1, "checkexpire": 1}
        try:
            return self.s.get("/api/quota", params=params)
        except BdnApiError as e:
            if e.errno in (-6, 111):
                raise
            return self.s.post("/api/quota", params={"clienttype": 8},
                               data=params)

    # ---------- 文件域 ----------

    def list_dir(self, dir_path: str = "/", page: int = 1, num: int = MAX_NUM,
                 order: str = "name", desc: int = 0) -> dict:
        """GET /api/list（已实证）。num 自动钳制到 ≤1000（翻页保护）。"""
        _ensure_abs(dir_path)
        num = max(1, min(int(num), MAX_NUM))
        p = self.s.get("/api/list", params={
            "dir": dir_path, "order": order, "desc": desc,
            "clienttype": 8, "num": num, "page": max(1, int(page))})
        p["entries"] = [_normalize_entry(x) for x in (p.get("list") or [])]
        return p

    def search(self, key: str, dir_path: str = "/", recursion: int = 1,
               page: int = 1, num: int = 100) -> dict:
        """全盘/目录内搜索（默认递归）。api 家族无搜索端点 → xpan file?method=search。

        key 形态不适配时（errno -7）自动以 wd 别名重试一次（蓝本 PCS 用 wd）。
        """
        _ensure_abs(dir_path)
        params = {"method": "search", "key": key, "dir": dir_path,
                  "recursion": int(recursion), "page": max(1, int(page)),
                  "num": max(1, min(int(num), MAX_NUM)), "clienttype": 8}
        try:
            p = self.s.get("/rest/2.0/xpan/file", params=params)
        except BdnApiError as e:
            if e.errno != -7:
                raise
            params2 = dict(params)
            del params2["key"]
            params2["wd"] = key
            p = self.s.get("/rest/2.0/xpan/file", params=params2)
        p["entries"] = [_normalize_entry(x) for x in (p.get("list") or [])]
        return p

    def metas(self, fsids: list, dlink: int = 0) -> dict:
        """文件元信息（api 优先）：/api/filemetas（数据在 info 键，探针实证）→
        兜底 xpan multimedia?method=filemetas（现行形态，数据在 list 键）。
        dlink=1 时返回下载直链（约 8h 有效）。W1 实证 xpan/multifile 旧形态已 404。"""
        if not fsids:
            raise BdnApiError(-7, "fsids 不能为空")
        fsids_json = json.dumps([int(x) for x in fsids], separators=(",", ":"))
        dlink = 1 if dlink else 0
        try:
            p = self.s.get("/api/filemetas", params={
                "fsids": fsids_json, "dlink": dlink, "clienttype": 8})
            src, key = "api/filemetas", "info"
            if dlink and not any(x.get("dlink") for x in (p.get(key) or [])):
                # 请求了 dlink 但主通道不回 → 落 xpan multimedia 兜底（W4 韧性）
                raise BdnApiError(-1, "primary returned no dlink")
        except BdnApiError as e:
            if e.errno in (-6, 111):
                raise
            p = self.s.get("/rest/2.0/xpan/multimedia", params={
                "method": "filemetas", "fsids": fsids_json,
                "dlink": dlink, "thumb": 0, "clienttype": 8})
            src, key = "xpan/multimedia", "list"
        p["entries"] = [_normalize_entry(x) for x in (p.get(key) or [])]
        p["_source"] = src
        return p

    def meta_by_path(self, path: str, dlink: int = 0) -> dict:
        """按远端路径取单文件元信息：ls 父目录定位 fs_id（A级已实证链）→ metas。
        下载引擎的 dlink 入口（dlink=1）。找不到 → errno -9。"""
        _ensure_abs(path)
        path = path.rstrip("/")
        if path == "":
            path = "/"
        parent, _, name = path.rpartition("/")
        parent = parent or "/"
        if not name:
            raise BdnApiError(-7, f"路径不指向文件: {path!r}")
        r = self.list_dir(parent)
        for e in r.get("entries") or []:
            if e.get("name") == name and not e["isdir"]:
                m = self.metas([e["fs_id"]], dlink=dlink)
                entries = m.get("entries") or []
                if not entries:
                    break
                out = dict(entries[0])
                out["_fsid"] = e["fs_id"]
                out["_meta_source"] = m.get("_source")
                return out
        raise BdnApiError(-9, f"远端文件不存在（或为目录）: {path}")

    # ---------- 分享/回收站（只读） ----------

    def share_records(self, page: int = 1) -> dict:
        """我的分享记录：GET /share/record（蓝本 prepare.go:783-801；驼峰键，探针实证 1029）。"""
        p = self.s.get("/share/record", params={
            "page": max(1, int(page)), "desc": 1, "order": "time",
            "clienttype": 8})
        p["entries"] = [
            {"shareid": e.get("shareId"), "shortlink": e.get("shortlink"),
             "typical_path": e.get("typicalPath"), "ctime": e.get("ctime"),
             "views": e.get("vCnt"), "downloads": e.get("dCnt"),
             "status": e.get("status"),
             "passwd": "***" if e.get("passwd") else ""}
            for e in (p.get("list") or [])]
        return p

    def recycle_list(self, page: int = 1, num: int = 100) -> dict:
        """回收站列表：GET /api/recycle/list（蓝本 prepare.go:824-836）。"""
        p = self.s.get("/api/recycle/list", params={
            "num": max(1, min(int(num), 200)), "page": max(1, int(page)),
            "clienttype": 8})
        p["entries"] = list(p.get("list") or [])
        return p

    # ---------- 分享写面 + 转存链（W5：条件门；蓝本 prepare.go:739-821 + transfer.go:43-236） ----------

    def share_create(self, path: str, pwd: str = "", period: int = 0,
                     variant: int = 0) -> dict:
        """创建分享：POST /share/pset（旧代写面；官方 2026-09-16 宣布旧分享服务下线
        ——只读面 W1 已证仍活，写面生死 W5 实测回填 PROTOCOL G10）。
        variant=0: path_list=纯路径 JSON 数组（蓝本形态）；1: [{"path":…}]（web 形态）。
        带 pwd → schannel=4 提取码分享；无 pwd → schannel=0 公开。period=0 永久（天）。
        响应形态（实测回填）：shareid + link；失败信使=errno。"""
        _ensure_abs(path)
        if variant == 1:
            path_list = json.dumps([{"path": path}], ensure_ascii=False,
                                   separators=(",", ":"))
        else:
            path_list = json.dumps([path], ensure_ascii=False,
                                   separators=(",", ":"))
        return self.s.post("/share/pset", params=dict(_WEB_Q),
                           data={"path_list": path_list,
                                 "schannel": 4 if pwd else 0,
                                 "channel_list": "[]",
                                 "period": int(period),
                                 "pwd": pwd or "",
                                 "share_type": 9})

    def share_cancel(self, shareids: list) -> dict:
        """取消分享：POST /share/cancel body shareid_list（蓝本 prepare.go:762-780）。
        铁律：仅用于取消自建分享（**CLI 属主护栏强制**：bdn.cmd_share_cancel 先
        share_records() 校验 shareid ∈ 本账号自建列表，非自建退出码 3 拒发；
        库层不拦——直接调用本方法者自慎）。"""
        return self.s.post("/share/cancel", params=dict(_WEB_Q),
                           data={"shareid_list": json.dumps(
                               [int(x) for x in shareids],
                               separators=(",", ":"))})

    def share_surl_info(self, shareid) -> dict:
        """自有分享详情（含提取码明文——调用方输出侧必须掩码）：
        GET /share/surlinfoinrecord，sign=md5(shareID+"_sharesurlinfo!@#")
        （蓝本 netdisksign/share_sign.go:11-20，W5 首测）。"""
        sign = hashlib.md5(
            f"{shareid}_sharesurlinfo!@#".encode("utf-8")).hexdigest()
        return self.s.get("/share/surlinfoinrecord",
                          params={"shareid": shareid, "sign": sign,
                                  "clienttype": 8})

    def share_verify(self, shareid, share_uk, pwd: str, bdstoken=None) -> dict:
        """旧转存① 提取码校验：POST /share/verify → randsk（后续请求以 BDCLND cookie 携带）。
        -9=提取码错；8001=触发验证码（蓝本 pcscommand:59-74）。"""
        data = {"pwd": pwd or "", "vcode": ""}
        if bdstoken:
            data["bdstoken"] = bdstoken
        return self.s.post("/share/verify",
                           params={"shareid": shareid, "uk": share_uk,
                                   "clienttype": 1, "time": int(time.time())},
                           data=data)

    def share_list(self, surl: str, root: int = 1, randsk: str | None = None) -> dict:
        """旧转存② 分享文件列表：GET /share/list（web=5&channel=chunlei，蓝本口径）。
        randsk 来自 share_verify；无 randsk 直试（公开分享/自有分享或可直过）。"""
        return self.s.get("/share/list",
                          params={"shorturl": surl, "root": root, "web": 5,
                                  "channel": "chunlei", "app_id": APP_ID},
                          cookies=(f"BDCLND={randsk}" if randsk else None))

    def share_transfer(self, fsidlist: list, path: str, shareid=None,
                       share_uk=None, randsk: str | None = None,
                       bdstoken: str | None = None) -> dict:
        """旧转存③ 入库：POST /share/transfer body fsidlist+path。
        query 全参（蓝本 transfer.go:79-85）：app_id/channel=chunlei/clienttype=0/web=1
        + **shareid + from(=shareUK)** + bdstoken。W6 复测实证（hop 探针钉死断点）：
        仅带 bdstoken 仍 errno 2——W5「缺 bdstoken」单因假设被证伪，shareid/from
        为蓝本必参（本形态 W6 实装，1 发复测留 W7/用户令）。
        errno 12=超转存上限 / -30=同名 / 4=重复（蓝本 baidupcs/transfer.go:164-236）。"""
        _ensure_abs(path)
        params = {"app_id": APP_ID, "channel": "chunlei",
                  "clienttype": 0, "web": 1}
        if shareid is not None:
            params["shareid"] = int(shareid)
        if share_uk is not None:
            params["from"] = share_uk
        if bdstoken:
            params["bdstoken"] = bdstoken
        return self.s.post("/share/transfer",
                           params=params,
                           data={"fsidlist": json.dumps(
                               [int(x) for x in fsidlist],
                               separators=(",", ":")), "path": path},
                           cookies=(f"BDCLND={randsk}" if randsk else None))

    @staticmethod
    def surl_from_link(link: str) -> str:
        """分享短链 → surl：取 /s/ 尾段并去前导 '1'（蓝本 AccessSharePage 口径：
        页面链=/s/1<surl>，API shorturl 参数=<surl>）。无 /s/ 时按裸 surl 原样透传。"""
        tail = str(link).rstrip("/").rsplit("/s/", 1)[-1]
        return tail[1:] if len(tail) > 1 and tail.startswith("1") else tail

    # ---------- 增量 ----------

    def filediff(self, cursor: str | None, action: str = "manual") -> dict:
        """秒级增量轮询：POST /api/filediff（CAPTURE_INVENTORY §六 捕获全参形态）。

        cursor=上一次响应回传的 base64 游标；None=冷启动（body 不带 cursor 键，W4 试激活）。
        响应含新 cursor + entries（增量事件）。极简 query 会被 RST——参数完整度有门（W1 实证）。
        """
        body = {"action": action, "dname": FILEDIFF_QUERY["dname"]}
        if cursor is not None:                 # None=冷启动不带键；""=显式空串照发
            body["cursor"] = cursor
        return self.s.post("/api/filediff", params=dict(FILEDIFF_QUERY), data=body)

    def filediff_bootstrap(self) -> dict:
        """游标冷启动（W3 遗留）：尝试不带 cursor 键 → 空 cursor 串。
        成功 → {"errno":0,"cursor":...}；两试全败则抛最后一场的 BdnApiError（如实上报）。"""
        try:
            return self.filediff(None)
        except BdnApiError as e:
            if e.errno in (-6, 111):
                raise
            return self.filediff("")

    # ---------- 写面（W4：mkdir / rename / mv / cp / rm；/api 家族实测 1029 放行） ----------

    def mkdir(self, dir_path: str, rtype: int = 0) -> dict:
        """建目录：POST /api/create isdir=1（web 客户端同款；W4 实测 errno=0 带 fs_id）。
        已存在（errno -8）→ 幂等返回 exists=True。
        勿用：xpan create=9019 need verify（风控验证墙）；pcs mkdir=假成功（实测目录未建出）。"""
        _ensure_abs(dir_path)
        try:
            p = self.s.post("/api/create", params=dict(_WEB_Q),
                            data={"path": dir_path, "isdir": 1, "rtype": rtype})
            p.setdefault("exists", False)
            return p
        except BdnApiError as e:
            if e.errno == -8:                      # 已存在 → 幂等（实测 -8 形态）
                return {"errno": 0, "path": dir_path, "exists": True}
            raise

    def _filemanager(self, opera: str, filelist: list, ondup: str = "overwrite",
                     async_: int = 0) -> dict:
        """POST /api/filemanager 四合一（rename/move/copy/delete；W4 实测 rename errno=0）。
        async=0 同步；info 内逐条 errno 核验（任一非 0 → 抛首个）；
        返回 taskid（若服务端转异步）由调用方编排。"""
        p = self.s.post("/api/filemanager",
                        params={**_WEB_Q, "opera": opera, "async": async_,
                                "ondup": ondup},
                        data={"filelist": json.dumps(filelist, ensure_ascii=False,
                                                     separators=(",", ":"))})
        info = p.get("info") or []
        for x in info:
            if x.get("errno", 0) != 0:
                raise BdnApiError(x.get("errno", -1), payload=p)
        return p

    def rename(self, path: str, newname: str) -> dict:
        """重命名（同目录）。newname 为纯文件名，不带路径。"""
        _ensure_abs(path)
        if "/" in newname:
            raise BdnApiError(-7, f"newname 必须为纯文件名: {newname!r}")
        return self._filemanager("rename", [{"path": path, "newname": newname}])

    def move(self, src: str, dst_dir: str) -> dict:
        """移动 src（文件/目录）到 dst_dir 目录下。
        官方 OpenAPI 口径：filelist 每项 path+dest+newname（from/to 形态实测 errno 2）；
        全局 errno=2（info 空）时自动换 from/to 全路径形态重试一次。"""
        _ensure_abs(src), _ensure_abs(dst_dir)
        name = src.rstrip("/").rsplit("/", 1)[-1]
        dest = dst_dir.rstrip("/")
        try:
            return self._filemanager(
                "move", [{"path": src, "dest": dest, "newname": name}],
                ondup="newcopy")
        except BdnApiError as e:
            if e.errno == 2 and not (getattr(e, "payload", None) or {}).get("info"):
                return self._filemanager(
                    "move", [{"from": src, "to": dest + "/" + name}],
                    ondup="newcopy")
            raise

    def copy(self, src: str, dst_dir: str) -> dict:
        """复制 src（文件/目录）到 dst_dir 目录下（官方 path+dest+newname 口径，同 move）。"""
        _ensure_abs(src), _ensure_abs(dst_dir)
        name = src.rstrip("/").rsplit("/", 1)[-1]
        dest = dst_dir.rstrip("/")
        try:
            return self._filemanager(
                "copy", [{"path": src, "dest": dest, "newname": name}],
                ondup="newcopy")
        except BdnApiError as e:
            if e.errno == 2 and not (getattr(e, "payload", None) or {}).get("info"):
                return self._filemanager(
                    "copy", [{"from": src, "to": dest + "/" + name}],
                    ondup="newcopy")
            raise

    def delete(self, paths: list) -> dict:
        """删除（进回收站）。官方口径 filelist=纯路径数组；errno=2 时换 {"path":…} 形态。"""
        for pth in paths:
            _ensure_abs(pth)
        try:
            return self._filemanager("delete", list(paths), ondup="fail")
        except BdnApiError as e:
            if e.errno == 2 and not (getattr(e, "payload", None) or {}).get("info"):
                return self._filemanager("delete", [{"path": p} for p in paths],
                                         ondup="fail")
            raise

    # ---------- 上传三段（W4） ----------

    def locate_upload(self) -> dict:
        """上传服务器发现：d.pcs.baidu.com file?method=locateupload（A级在役，
        8.2.5 唯一 pcs 域调用）。返回归一化 {"servers": ["https://...", ...]}。"""
        p = self.s.get("https://d.pcs.baidu.com/rest/2.0/pcs/file",
                       params={"method": "locateupload", "upload_version": "2.0",
                               "app_id": APP_ID, "clienttype": 8})
        raw = p.get("servers") or []
        hosts = []
        for x in raw:
            u = x if isinstance(x, str) else (
                x.get("server") or x.get("url") or "") if isinstance(x, dict) else ""
            u = str(u).strip().rstrip("/")
            if u.startswith("http"):
                hosts.append(u)
        p["servers"] = hosts
        return p

    def precreate(self, remote_path: str, size: int, block_list: list,
                  content_md5: str, slice_md5: str, isdir: int = 0, rtype: int = 3,
                  local_ctime: int | None = None, local_mtime: int | None = None) -> dict:
        """上传① 预创建（蓝本 prepare.go:604-628）：POST /api/precreate。
        响应 return_type=2 秒传成功 / =1 拿 uploadid + block_list(待传分片序号)。"""
        _ensure_abs(remote_path)
        now = int(time.time())
        return self.s.post("/api/precreate",
                           params={"clienttype": 8, "app_id": APP_ID},
                           data={"path": remote_path, "size": size, "isdir": isdir,
                                 "autoinit": 1, "rtype": rtype, "web": 1,
                                 "block_list": json.dumps(block_list, separators=(",", ":")),
                                 "content-md5": content_md5, "slice-md5": slice_md5,
                                 "local_ctime": local_ctime or now,
                                 "local_mtime": local_mtime or now})

    def create_file(self, remote_path: str, size: int, uploadid: str,
                    block_list: list, isdir: int = 0, rtype: int = 3) -> dict:
        """上传③ 合并建文件（蓝本 prepare.go:580-602）：POST /api/create。"""
        _ensure_abs(remote_path)
        return self.s.post("/api/create",
                           params={"clienttype": 8, "app_id": APP_ID},
                           data={"path": remote_path, "size": size, "isdir": isdir,
                                 "rtype": rtype, "uploadid": uploadid,
                                 "block_list": json.dumps(block_list, separators=(",", ":"))})

    # ---------- tree 编排 ----------

    def tree(self, root: str = "/", depth: int = 3, max_requests: int = 20,
             num: int = MAX_NUM) -> dict:
        """递归树（BFS）。默认深度 ≤3；每层 list_dir 自带翻页护栏；总请求数护栏 max_requests。"""
        _ensure_abs(root)
        depth = max(1, min(int(depth), 8))
        start_sent = self.s.requests_sent
        out = {"root": root, "depth_limit": depth, "nodes": 0, "dirs": 0,
               "requests": 0, "truncated": False, "max_depth_reached": 0,
               "tree": []}

        def budget_left() -> bool:
            used = self.s.requests_sent - start_sent
            if used >= max_requests:
                out["truncated"] = True
                return False
            return True

        def node(e: dict) -> dict:
            return {"name": e["name"], "path": e.get("path"),
                    "isdir": e["isdir"], "size": e.get("size", 0),
                    "children": None}

        queue = [(root, out["tree"], 1)]
        while queue:
            dir_path, sink, lvl = queue.pop(0)
            out["max_depth_reached"] = max(out["max_depth_reached"], lvl)
            page = 1
            while page <= MAX_PAGES_PER_DIR:
                if not budget_left():
                    return out
                res = self.list_dir(dir_path, page=page, num=num)
                out["requests"] = self.s.requests_sent - start_sent
                entries = res.get("entries") or []
                for e in entries:
                    n = node(e)
                    sink.append(n)
                    out["nodes"] += 1
                    if e["isdir"]:
                        out["dirs"] += 1
                        n["children"] = []
                        if lvl < depth and budget_left():
                            queue.append((e["path"], n["children"], lvl + 1))
                        elif lvl >= depth:
                            n["children"] = None
                            n["pruned_depth"] = True
                if len(entries) < num:
                    break
                page += 1
        return out
