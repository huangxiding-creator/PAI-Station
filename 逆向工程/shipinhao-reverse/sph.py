# -*- coding: utf-8 -*-
"""sph.py — 视频号后台 CLI（channels.weixin.qq.com 视频号助手 纯 HTTP 复刻件）

逆向来源: finder-helper-web SPA 静态逆向 + 保险库 cookie 实证探针 (2026-11-24/25)
Base: https://channels.weixin.qq.com/cgi-bin/mmfinderassistant-bin
Auth: Cookie sessionid + wxuin (F:/We-AIPO/data/state/channels_cookies_vault.json)
信封: {timestamp, scene:1, reqScene:1, ...业务参数} → {errCode, errMsg, data}

v2 (1125 用户令): 写操作在役——上传(dfs分片协议)/存草稿/预览发布/正式发布/删除。
  危险命令一律 --confirm 门；发布默认走 post_preview(仅自己可见)；
  正式公开发布 = post publish --confirm。写测试只打自产测试片，永不触碰真实内容。

用法:
  python sph.py whoami
  python sph.py post list [--page 1] [--count 10] [--type 0]   # type: 0全部 3评论台 4弹幕 5直播回放
  python sph.py post drafts | post albums | post get <objectId> | post link [objectId]
  python sph.py post draft <视频文件> [--title T] [--desc D] [--cover 图片] [--dry-run]
  python sph.py post preview <视频文件> [--title T] [--desc D] [--cover 图片] [--dry-run]
  python sph.py post publish <视频文件> ... --confirm          # 正式公开发布
  python sph.py post delete <objectId> --confirm | post deldraft <objectId> --confirm
  python sph.py post visible <objectId> <1公开|2关注|3仅自己> --confirm
  python sph.py stat overview | stat posts | stat fans-trend | stat fans-portrait
  python sph.py live history [--count 10] | live replays | live last
  python sph.py comment list <exportId> | comment feeds
  python sph.py msg sessions | msg new
  python sph.py shop status | shop products | shop orders [--page 1]
  python sph.py notify list | income detail | member list | collection list | profile sections
  任何命令加 --json 输出原始 JSON；--cookie "k=v;k=v" 或 SPH_COOKIE 环境变量可覆盖凭据来源。
"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import os
import pathlib
import subprocess
import sys
import time
import urllib.error
import urllib.parse
import urllib.request
import uuid as _uuid

BASE = "https://channels.weixin.qq.com/cgi-bin/mmfinderassistant-bin"
DEFAULT_VAULT = r"F:/We-AIPO/data/state/channels_cookies_vault.json"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36")
# 1125 实捕定谳: 平台 scene=7 (FinderAssistant); _aid=设备稳定件; _rid=每请求 uuid
SCENE = 7
AID = "cfa380bc-1946-4fe3-81fb-8e8f99c19e80"
FP_DEVICE = "01b9e84a18ab696b22eb9aa7ea9725f5"


# ---------- 传输层 ----------

def _cookies_from_vault(path: str) -> dict:
    d = json.loads(pathlib.Path(path).read_text(encoding="utf-8"))
    return {c["name"]: c["value"] for c in d.get("cookies", [])}


def _cookies_from_str(s: str) -> dict:
    out = {}
    for part in s.split(";"):
        if "=" in part:
            k, v = part.strip().split("=", 1)
            out[k] = v
    return out


def load_cookies(args) -> dict:
    if getattr(args, "cookie", None):
        return _cookies_from_str(args.cookie)
    env = os.environ.get("SPH_COOKIE")
    if env:
        return _cookies_from_str(env)
    vault = getattr(args, "vault", None) or DEFAULT_VAULT
    return _cookies_from_vault(vault)


def call(path: str, body: dict, cookies: dict, timeout: int = 30) -> dict:
    """POST /cgi-bin/mmfinderassistant-bin/<path>?_aid&_rid&_pageUrl，返回解析后的 JSON。"""
    p = path.lstrip("/")
    q = urllib.parse.urlencode({
        "_aid": os.environ.get("SPH_AID", AID),
        "_rid": str(_uuid.uuid4()),
        "_pageUrl": "https://channels.weixin.qq.com/platform/post/create",
    })
    url = f"{BASE.rstrip('/')}/{p}?{q}"
    data = json.dumps(body, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(url, data=data, method="POST")
    req.add_header("User-Agent", UA)
    req.add_header("Cookie", "; ".join(f"{k}={v}" for k, v in cookies.items()))
    req.add_header("Referer", "https://channels.weixin.qq.com/platform/post/create")
    req.add_header("X-Requested-With", "XMLHttpRequest")
    req.add_header("Accept", "application/json, text/plain, */*")
    req.add_header("Content-Type", "application/json")
    req.add_header("finger-print-device-id", os.environ.get("SPH_FP", FP_DEVICE))
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return json.loads(r.read().decode("utf-8", errors="replace"))


def env(**kw) -> dict:
    d = {"timestamp": str(int(time.time() * 1000)), "scene": SCENE, "reqScene": SCENE,
         "_log_finder_uin": "", "_log_finder_id": "", "rawKeyBuff": "", "pluginSessionId": None}
    d.update(kw)
    return d


def api(cookies: dict, path: str, **kw) -> dict:
    """业务调用：自动带信封，返回 data 部分；errCode!=0 时抛 SystemExit 带错误信息。"""
    j = call(path, env(**kw), cookies)
    if j.get("errCode") != 0:
        raise SystemExit(f"[{path}] errCode={j.get('errCode')} errMsg={j.get('errMsg')}")
    return j.get("data") or {}


# ---------- 输出 ----------

def _utf8():
    try:
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    except Exception:
        pass


def emit(raw, args):
    if getattr(args, "json", False):
        print(json.dumps(raw, ensure_ascii=False, indent=1))
        return
    print(json.dumps(raw, ensure_ascii=False, indent=1))


def kv(title: str, pairs: list):
    print(f"== {title} ==")
    for k, v in pairs:
        print(f"  {k:<28} {v}")


def brief_list(items: list, fields: list, empty="(空)"):
    if not items:
        print(empty)
        return
    for i, it in enumerate(items, 1):
        cells = []
        for f in fields:
            v = it.get(f, "")
            s = str(v)
            if len(s) > 60:
                s = s[:57] + "..."
            cells.append(f"{f}={s}")
        print(f"[{i}] " + "  ".join(cells))


# ---------- 命令实现 ----------

def cmd_whoami(c, a):
    d = api(c, "auth/auth_data")
    fu = d.get("finderUser", {})
    ua = d.get("userAttr", {})
    kv("视频号身份", [
        ("昵称", fu.get("nickname")),
        ("认证企业", fu.get("authCompanyName") or "-"),
        ("内容数", fu.get("feedsCount")),
        ("粉丝数", fu.get("fansCount")),
        ("直播状态", fu.get("liveStatus")),
        ("认证类型", fu.get("authIconType")),
        ("uniqId", fu.get("uniqId")),
        ("管理员微信", ua.get("nickname")),
        ("短链", d.get("datacenterEntarnce") and "-" or "-"),
    ])
    if a.json:
        emit(d, a)


def cmd_post_list(c, a):
    d = api(c, "post/post_list", pageSize=a.count, currentPage=a.page,
            userpageType=a.type, onlyUnread=False, needAllCommentCount=True, forMcn=False)
    items = d.get("list") or []
    print(f"共 {d.get('totalCount')} 条，本页 {len(items)} 条 (page={a.page}, type={a.type})")
    for i, it in enumerate(items, 1):
        print(f"[{i}] {it.get('objectId', '')[:44]}  {_desc_of(it)}  t={it.get('createTime')}  "
              f"赞={it.get('likeCount')} 评={it.get('commentCount')} 转={it.get('forwardCount')} 藏={it.get('favCount')} 读={it.get('readCount')}")
    if a.json:
        emit(d, a)


def _desc_of(it):
    dd = it.get("desc") or {}
    if isinstance(dd, dict):
        st = dd.get("shortTitle") or []
        if st and isinstance(st, list):
            t = st[0]
            if isinstance(t, dict):
                return t.get("content") or t.get("text") or ""
        return (dd.get("desc") or "")[:40]
    return str(dd)[:40]


def cmd_post_drafts(c, a):
    d = api(c, "post/get_draft_list", count=a.count)
    items = d.get("list") or []
    print(f"草稿 {len(items)} 条")
    brief_list(items, ["objectId", "status", "visibleType", "createTime"])
    if a.json:
        emit(d, a)


def cmd_post_get(c, a):
    d = api(c, "post/get_post_info", objectId=a.object_id)
    o = d.get("object") or {}
    if a.json:
        emit(o, a)
        return
    kv("内容详情", [
        ("objectId", o.get("objectId")),
        ("类型", o.get("objectType")),
        ("状态", f"status={o.get('status')} visible={o.get('visibleType')} 关评论={o.get('commentClose')}"),
        ("创建t", o.get("createTime")),
        ("赞/评/转/藏/读", f"{o.get('likeCount')}/{o.get('commentCount')}/{o.get('forwardCount')}/{o.get('favCount')}/{o.get('readCount')}"),
    ])


def cmd_post_albums(c, a):
    d = api(c, "post/get_albums")
    items = d.get("albums") or []
    print(f"音频专辑 {len(items)} 张")
    brief_list(items, ["albumName", "songsCount", "albumStatus", "issueTime"])
    if a.json:
        emit(d, a)


def cmd_post_link(c, a):
    kw = {}
    if a.object_id:
        kw["objectId"] = a.object_id
    d = api(c, "post/get_object_short_link", **kw)
    print(d.get("shortUrl"))
    if a.json:
        emit(d, a)


def _sv(x):
    """时序字段摘要：list→[n点 最新值]；标量原样。"""
    if isinstance(x, list):
        return f"{len(x)}点 最新={x[-1] if x else '-'}"
    return x


def cmd_stat_overview(c, a):
    d1 = api(c, "statistic/get-finder-total-statics")
    kv("账号总览", [("粉丝数", d1.get("fansNum")), ("支持内容带货", d1.get("supportPostProduct"))])
    d2 = api(c, "statistic/post_total_data")
    kv("内容互动(时序)", [(k, _sv(d2.get(k))) for k in ("browse", "like", "comment", "forward", "fav")])
    if a.json:
        emit({"total_statics": d1, "post_total": d2}, a)


def cmd_stat_posts(c, a):
    d = api(c, "statistic/new_post_total_data")
    if a.json:
        emit(d, a)
        return
    for row in d.get("dataByTabtype") or []:
        dd = row.get("data") or {}
        print(f"[{row.get('tabTypeName')}] 播放={_sv(dd.get('browse'))} 赞={_sv(dd.get('like'))} "
              f"评={_sv(dd.get('comment'))} 转={_sv(dd.get('forward'))} 藏={_sv(dd.get('fav'))} 关注={_sv(dd.get('follow'))}")


def cmd_stat_fans_trend(c, a):
    d = api(c, "statistic/fans_trend")
    print(f"新增={_sv(d.get('add'))} 流失={_sv(d.get('reduce'))} 净增={_sv(d.get('netAdd'))} 总数={_sv(d.get('total'))}")
    for row in d.get("fansDataByTabtype") or []:
        print(f"  [{row.get('tabTypeName')}] 新增={_sv(row.get('add'))} 净增={_sv(row.get('netAdd'))} 总={_sv(row.get('total'))}")
    if a.json:
        emit(d, a)


def cmd_stat_fans_portrait(c, a):
    d = api(c, "statistic/fans_portrait")
    raw = d.get("respJson")
    if isinstance(raw, str):
        d = json.loads(raw)
    emit(d, a)


def cmd_live_history(c, a):
    d = api(c, "live/get_live_history", pageSize=a.count, currentPage=a.page, count=a.count)
    if getattr(a, "json", False):
        emit(d, a)
        return
    print(f"直播总数 {d.get('totalLiveCount')} 场, 累计时长(s) {d.get('totalLiveDuration')}")
    items = d.get("liveObjectList") or []
    for i, it in enumerate(items, 1):
        st = it.get("liveStats") or {}
        print(f"[{i}] {it.get('liveObjectId','')}  t={it.get('createTime')}  "
              f"在线峰值={it.get('maxOnlineCount', st.get('maxOnlineCount','-'))}  "
              f"GMV={it.get('payedGmv','-')}  付款人数={it.get('payedNum','-')}  "
              f"{str(it.get('description') or '')[:40]}")


def cmd_live_replays(c, a):
    d = api(c, "live/get_live_replay_list_v2", count=a.count)
    items = d.get("replayObjects") or []
    print(f"回放 {len(items)} 条")
    brief_list(items, ["liveId", "title", "startTime", "duration"])
    if a.json:
        emit(d, a)


def cmd_live_last(c, a):
    d = api(c, "live/get_last_live_info_v1")
    tag = d.get("liveTag") or {}
    sub = tag.get("subTag") or {}
    kv("最近直播", [
        ("标签", f"{tag.get('tagName')}/{sub.get('tagName')}"),
        ("封面", (d.get("liveCoverImgUrl") or "")[:80]),
    ])
    if a.json:
        emit(d, a)


def cmd_comment_feeds(c, a):
    d = api(c, "post/post_list", pageSize=a.count, currentPage=a.page,
            userpageType=3, onlyUnread=False, needAllCommentCount=True, forMcn=False)
    items = d.get("list") or []
    print(f"评论台作品 {len(items)} 条")
    for i, it in enumerate(items, 1):
        print(f"[{i}] exportId={it.get('exportId')}  评论数={it.get('commentCount')}  未读={it.get('unreadCommentCount', '-')}")
    if a.json:
        emit(d, a)


def cmd_comment_list(c, a):
    d = api(c, "comment/comment_list", lastBuff="", exportId=a.export_id,
            commentSelection=False, forMcn=False)
    items = d.get("comment") or []
    print(f"评论 {len(items)} 条 (总数 {d.get('commentCount')})")
    brief_list(items, ["commentId", "nickname", "content", "createTime", "likeCount"])
    if a.json:
        emit(d, a)


def cmd_msg_sessions(c, a):
    d = api(c, "private-msg/get-session-info")
    items = d.get("sessionInfo") or []
    print(f"私信会话 {len(items)} 个")
    brief_list(items, ["nickname", "lastMsg", "updateTime"])
    if a.json:
        emit(d, a)


def cmd_msg_new(c, a):
    d = api(c, "private-msg/get-new-msg")
    print(f"新私信 {len(d.get('msg') or [])} 条 (cookie={d.get('cookie')})")
    if a.json:
        emit(d, a)


def cmd_shop_status(c, a):
    d = api(c, "shop/check_shop_window_status")
    kv("橱窗状态", [
        ("有商品", d.get("hasProducts")),
        ("绑定小店", [s.get("nickname") for s in (d.get("shopItemList") or [])]),
    ])
    if a.json:
        emit(d, a)


def cmd_shop_products(c, a):
    d = api(c, "shop/get_all_window_products")
    items = d.get("products") or []
    print(f"橱窗商品 {len(items)} 件")
    for i, it in enumerate(items, 1):
        print(f"[{i}] {str(it.get('title') or '')[:44]}  价={it.get('sellingPrice')}  "
              f"库存={it.get('stock')}  平台={it.get('platformName')}  status={it.get('status')}  id={it.get('productId')}")
    if a.json:
        emit(d, a)


def cmd_shop_orders(c, a):
    d = api(c, "shop/get_commerce_order_list", page=a.page, count=a.count)
    items = d.get("orderList") or []
    print(f"订单 {len(items)} 条 (page={a.page})")
    for i, o in enumerate(items, 1):
        oi = o.get("orderInfo") or {}
        pi = o.get("productInfo") or {}
        print(f"[{i}] {oi.get('orderId')}  状态={oi.get('state')}  "
              f"价={pi.get('totalPayment') or oi.get('totalPrice')}  "
              f"{str(pi.get('title') or '')[:40]}  下单t={oi.get('createTime')}")
    if a.json:
        emit(d, a)


def cmd_notify(c, a):
    d = api(c, "notification/notification_list", count=a.count)
    print(f"通知 未读={d.get('unreadCount')}")
    brief_list(d.get("list") or [], ["title", "content", "time"])
    if a.json:
        emit(d, a)


def cmd_income(c, a):
    d = api(c, "income/get-my-finder-income-detail")
    emit(d, a)


def cmd_member(c, a):
    d = api(c, "member/member_list")
    kv("管理员", [str(i) for i in range(0, 0)] or [])
    for k in ("adminList", "operatorList", "memberList"):
        items = d.get(k) or []
        print(f"{k}: {len(items)}")
        for it in items:
            ua = (it.get("userAttr") or {}) if isinstance(it, dict) else {}
            print(f"  - {ua.get('nickname')}  role={it.get('role', '-')}")
    if a.json:
        emit(d, a)


def cmd_collection(c, a):
    d = api(c, "collection/get_collection_list", count=a.count)
    items = d.get("collectionList") or []
    print(f"合集 {len(items)} 个")
    for i, it in enumerate(items, 1):
        print(f"[{i}] {it.get('name') or '(无名)'}  内容数={it.get('feedCount')}  阅读={it.get('totalReadCount')}  "
              f"id={str(it.get('id') or '')[:36]}")
    if a.json:
        emit(d, a)


def cmd_profile_sections(c, a):
    d = api(c, "profile/get_user_page_section_list")
    for grp in ("availableSectionList", "noContentSectionList", "noPermissionSectionList"):
        g = (d.get(grp) or {})
        secs = g.get("userpageSection") or []
        names = [s.get("name") or s.get("sectionName") or "?" for s in secs]
        print(f"{grp}: {names}")
    if a.json:
        emit(d, a)


# ---------- v2 上传引擎（dfs 分片协议） ----------

def _http_raw(url: str, method: str, body=None, headers=None, timeout: int = 120):
    """裸 HTTP（上传 CDN 用，不走 cgi 信封）。返回 (status, bytes, headers)。"""
    req = urllib.request.Request(url, data=body, method=method)
    for k, v in (headers or {}).items():
        req.add_header(k, v)
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.status, r.read(), dict(r.headers)


def get_upload_params(c) -> dict:
    """helper/helper_upload_params → {uin, appType, authKey, scene, disKey/disTime/ext, 各 filetype 编号}。"""
    j = call("helper/helper_upload_params", env(), c)
    if j.get("errCode") != 0:
        raise SystemExit(f"[helper_upload_params] errCode={j.get('errCode')} {j.get('errMsg')}")
    return j.get("data") or {}


def get_env_info(c) -> dict:
    """auth_data → data.envInfo（cdnHost/cdnHostList/uploadVersion）。"""
    j = call("auth/auth_data", env(), c)
    return ((j.get("data") or {}).get("envInfo") or {})


def get_trace_key(c) -> str:
    try:
        j = call("post/get-finder-post-trace-key", env(), c)
        return (j.get("data") or {}).get("traceKey") or ""
    except Exception:
        return ""


def _upload_host(c) -> str:
    ei = get_env_info(c)
    host = None
    for k in ("cdnHostList", "spareCdnHostList"):
        v = ei.get(k)
        if isinstance(v, list) and v:
            host = v[0]
            break
    host = host or ei.get("cdnHost") or "finder.video.qq.com"
    if not str(host).startswith("http"):
        host = "https://" + str(host).lstrip("/")
    return host.rstrip("/")


def _upload_headers(auth: dict, file_name: str, size: int, taskid: str,
                    filetype: int, md5_hex: str) -> dict:
    a = f"apptype={auth.get('appType')}&filetype={filetype}&weixinnum={auth.get('uin')}" \
        f"&filekey={urllib.request.quote(file_name)}&filesize={size}&taskid={taskid}" \
        f"&scene={auth.get('scene') or 0}"
    if auth.get("disKey") is not None and auth.get("disTime") is not None and auth.get("ext"):
        a += f"&dis_k={auth['disKey']}&dis_t={auth['disTime']}&ext={auth['ext']}"
    h = {"Authorization": auth.get("authKey"), "X-Arguments": a,
         "Content-MD5": md5_hex or "null"}
    return h


def _file_md5(path: pathlib.Path, first_only: bool = False) -> str:
    h = hashlib.md5()
    cap = 5 * 1024 * 1024 if first_only else None
    with open(path, "rb") as f:
        while True:
            b = f.read(1024 * 1024)
            if not b:
                break
            if cap is not None:
                b = b[:cap]
            h.update(b)
            if cap is not None:
                break
    return h.hexdigest()


def video_meta(path: pathlib.Path) -> dict:
    """ffmpeg 探针取时长/宽高（gyan essentials 无 ffprobe，走 stderr 解析）。"""
    try:
        out = subprocess.run(
            ["ffmpeg", "-hide_banner", "-i", str(path)],
            capture_output=True, text=True, timeout=60)
        err = out.stderr or ""
        import re as _re
        dur = 0
        m = _re.search(r"Duration: (\d+):(\d+):([\d.]+)", err)
        if m:
            dur = int(round(int(m.group(1)) * 3600 + int(m.group(2)) * 60 + float(m.group(3))))
        w = h = 0
        s = _re.search(r"(\d{2,5})x(\d{2,5})", err)
        if s:
            w, h = int(s.group(1)), int(s.group(2))
        size = path.stat().st_size
        bitrate = int(size * 8 / dur) if dur else 0
        return {"duration": dur, "width": w, "height": h, "bitrate": bitrate}
    except Exception:
        return {"duration": 0, "width": 0, "height": 0, "bitrate": 0}


def extract_cover(path: pathlib.Path, out: pathlib.Path) -> pathlib.Path:
    """抽最清晰帧作封面（1113 Laplacian 法的简化版：取 1s 处关键帧，ffmpeg 质量优先）。"""
    try:
        subprocess.run(
            ["ffmpeg", "-y", "-v", "error", "-ss", "1", "-i", str(path),
             "-frames:v", "1", "-q:v", "2", str(out)],
            capture_output=True, timeout=60)
    except Exception:
        pass
    if not out.exists():
        subprocess.run(["ffmpeg", "-y", "-v", "error", "-i", str(path),
                        "-frames:v", "1", "-q:v", "2", str(out)],
                       capture_output=True, timeout=60)
    return out


def dfs_upload(c, path: pathlib.Path, kind: str = "video") -> dict:
    """dfs 分片上传。kind: video|picture|thumb|normal。
    返回 {url(httpsUrl), download_url, filekey, md5, size}。"""
    auth = get_upload_params(c)
    host = _upload_host(c)
    size = path.stat().st_size
    md5_full = _file_md5(path)
    md5_head = _file_md5(path, first_only=True)
    ft_key = {"video": "videoFileType", "picture": "pictureFileType",
              "thumb": "thumbFileType", "normal": "normalFile"}[kind]
    filetype = auth.get(ft_key) or auth.get("normalFile") or 20310
    taskid = str(_uuid.uuid4())
    common = _upload_headers(auth, path.name, size, taskid, filetype, md5_head)

    CHUNK = 8 * 1024 * 1024
    n_chunks = max(1, math.ceil(size / CHUNK))
    ends = [min((i + 1) * CHUNK, size) for i in range(n_chunks)]

    # 1) 申请 UploadID
    st, body, _ = _http_raw(f"{host}/applyuploaddfs", "PUT",
                            json.dumps({"BlockSum": n_chunks, "BlockPartLength": ends}).encode(),
                            {**common, "Content-Type": "application/json"})
    resp = json.loads(body.decode("utf-8", errors="replace"))
    upload_id = resp.get("UploadID") or resp.get("data", {}).get("UploadID") if isinstance(resp.get("data"), dict) else resp.get("UploadID")
    if not upload_id:
        raise SystemExit(f"applyuploaddfs 失败: HTTP{st} {str(resp)[:300]}")

    # 2) 分片（TransFlag 字符串须原样透传给 complete——布尔会 404）
    parts = []
    trans_flag = "0_0"
    with open(path, "rb") as f:
        for i in range(n_chunks):
            f.seek(i * CHUNK)
            blob = f.read(CHUNK)
            qs = f"?PartNumber={i + 1}&UploadID={urllib.request.quote(upload_id)}"
            st, body, _ = _http_raw(f"{host}/uploadpartdfs{qs}", "PUT", blob,
                                    {**common, "Content-Type": "application/octet-stream"})
            r2 = json.loads(body.decode("utf-8", errors="replace"))
            etag = r2.get("ETag") or (r2.get("data", {}).get("ETag") if isinstance(r2.get("data"), dict) else None)
            errno = r2.get("X-Errno", r2.get("data", {}).get("X-Errno") if isinstance(r2.get("data"), dict) else None)
            if errno not in (0, None, "0"):
                raise SystemExit(f"uploadpartdfs#{i+1} X-Errno={errno} {str(r2)[:200]}")
            if r2.get("TransFlag") is not None:
                trans_flag = r2.get("TransFlag")
            parts.append({"PartNumber": i + 1, "ETag": etag or ""})

    # 3) 完成
    st, body, _ = _http_raw(f"{host}/completepartuploaddfs?UploadID={urllib.request.quote(upload_id)}",
                            "POST",
                            json.dumps({"TransFlag": trans_flag,
                                        "PartInfo": sorted(parts, key=lambda p: p["PartNumber"])}).encode(),
                            {**common, "Content-Type": "application/json"})
    r3 = json.loads(body.decode("utf-8", errors="replace"))
    data = r3.get("data") if isinstance(r3.get("data"), dict) else {}
    dl = data.get("DownloadURL") or r3.get("DownloadURL")
    if not dl:
        raise SystemExit(f"completepartuploaddfs 失败: HTTP{st} {str(r3)[:300]}")
    url = dl.replace("http://wxapp.tc.qq.com", "https://finder.video.qq.com")
    return {"url": url, "download_url": dl, "filekey": path.name, "md5": md5_full, "size": size,
            "upload_id": upload_id, "taskid": taskid}


def build_post_payload(c, video: pathlib.Path, title: str, desc: str,
                       cover: pathlib.Path | None) -> dict:
    """组装 post_draft 载荷（草稿接受直传 url，免转码链）。"""
    vm = video_meta(video)
    v = dfs_upload(c, video, "video")
    cover_path = cover or extract_cover(video, video.with_suffix(".cover.jpg"))
    pic = dfs_upload(c, cover_path, "thumb")
    m = {"spec": [], "url": v["url"], "thumbUrl": pic["url"], "mediaType": 4,
         "videoPlayLen": vm["duration"], "width": vm["width"], "height": vm["height"],
         "md5sum": v["md5"], "fileSize": str(v["size"]), "bitrate": vm["bitrate"],
         "coverUrl": pic["url"], "fullThumbUrl": pic["url"], "fullUrl": "", "fullWidth": 0,
         "fullHeight": 0, "fullMd5sum": "", "fullFileSize": "0", "fullBitrate": 0,
         "halfRect": {}, "fullCoverUrl": pic["url"], "cardShowStyle": 2,
         "shareCoverUrl": "", "shareCoverShowStyle": 0}
    desc_obj = {"mpTitle": title, "description": desc or title,
                "extReading": {"link": "", "title": ""}, "mediaType": 4,
                "location": {}, "topic": {"finderTopicInfo": ""}, "event": {},
                "mentionedUser": [], "media": [m]}
    now_s = int(time.time())
    return {"objectType": 0,
            "longitude": 0, "latitude": 0, "feedLongitude": 0, "feedLatitude": 0,
            "originalFlag": 0, "topics": [], "postFlag": 0,
            "isFullPost": 1, "handleFlag": 2, "videoClipTaskId": "",
            "traceInfo": {"traceKey": get_trace_key(c),
                          "uploadCdnStart": now_s, "uploadCdnEnd": now_s},
            "objectDesc": desc_obj, "clientid": str(_uuid.uuid4())}


def publish_video(c, video: pathlib.Path, title: str, desc: str,
                  cover: pathlib.Path | None = None) -> dict:
    """完整发布链（asyncClipPostSwitch=1 必走）：上传→clip 注册→转码结果→post_create。
    返回 {errCode, data, draftId, clip}。1125 实测 errCode=0。"""
    vm = video_meta(video)
    v = dfs_upload(c, video, "video")
    cover_path = cover or extract_cover(video, video.with_suffix(".cover.jpg"))
    pic = dfs_upload(c, cover_path, "thumb")
    now_s = int(time.time())
    # 转码注册（asyncClipPostSwitch=1 时 post_create 必须 videoClipTaskId 对账）
    jc = call("post/post_clip_video", env(
        url=v["url"], timeStart=0, cropDuration=0, height=vm["height"], width=vm["width"],
        x=0, y=0, traceInfo={"traceKey": get_trace_key(c), "uploadCdnStart": now_s,
                             "uploadCdnEnd": now_s},
        targetWidth=0, targetHeight=0, type=0, useAstraThumbCover=False,
        clipOriginVideoInfo={}), c)
    if jc.get("errCode") != 0:
        raise SystemExit(f"[post_clip_video] errCode={jc.get('errCode')} {jc.get('errMsg')}")
    d0 = jc.get("data") or {}
    ck, did = d0.get("clipKey"), d0.get("draftId")
    # 轮询转码结果（"视频数据生成中"）
    res = None
    for _ in range(60):
        time.sleep(3)
        jr = call("post/post_clip_video_result", env(clipKey=ck, draftId=did), c)
        res = jr.get("data") or {}
        if res.get("url"):
            break
    if not res.get("url"):
        raise SystemExit(f"[clip_result] 转码超时未出 url: {str(res)[:200]}")
    m = {"spec": [], "url": res["url"], "thumbUrl": pic["url"], "mediaType": 4,
         "videoPlayLen": int(res.get("duration") or vm["duration"]),
         "width": int(res.get("width") or vm["width"]),
         "height": int(res.get("height") or vm["height"]),
         "md5sum": res.get("md5") or v["md5"],
         "fileSize": str(res.get("fileSize") or v["size"]),
         "bitrate": int(res.get("vbitrate") or 0) * 1000,
         "coverUrl": pic["url"], "fullThumbUrl": pic["url"], "fullUrl": "", "fullWidth": 0,
         "fullHeight": 0, "fullMd5sum": "", "fullFileSize": "0", "fullBitrate": 0,
         "halfRect": {}, "fullCoverUrl": pic["url"], "cardShowStyle": 2,
         "shareCoverUrl": "", "shareCoverShowStyle": 0, "urlCdnTaskId": did}
    payload = {"objectType": 0, "longitude": 0, "latitude": 0, "feedLongitude": 0,
               "feedLatitude": 0, "originalFlag": 0, "topics": [], "postFlag": 0,
               "isFullPost": 1, "handleFlag": 2, "videoClipTaskId": did,
               "traceInfo": {"traceKey": get_trace_key(c),
                             "uploadCdnStart": now_s, "uploadCdnEnd": now_s},
               "objectDesc": {"mpTitle": title, "description": desc or title,
                              "extReading": {"link": "", "title": ""}, "mediaType": 4,
                              "location": {}, "topic": {"finderTopicInfo": ""}, "event": {},
                              "mentionedUser": [], "media": [m]},
               "clientid": str(_uuid.uuid4())}
    j = call("post/post_create", env(**payload), c)
    return {"errCode": j.get("errCode"), "errMsg": j.get("errMsg"),
            "data": j.get("data"), "draftId": did, "clip": ck}


def _write_post(c, payload: dict, action: str):
    """action: create|preview|draft。draft/preview 走 {postReq} 包裹（实捕定谳）。"""
    if action == "draft":
        body = {"postReq": payload, "objectId": None}
    elif action == "preview":
        body = {"postReq": payload}
    else:
        body = payload
    j = call(f"post/post_{action}", env(**body), c)
    return j


# ---------- v2 写操作命令 ----------

def _confirm_guard(a, what):
    if not getattr(a, "confirm", False):
        raise SystemExit(f"拒绝执行：{what} 是危险写操作，必须加 --confirm")


def _send_or_dry(a, payload):
    if getattr(a, "dry_run", False):
        print("--dry-run 载荷如下（未发送）：")
        print(json.dumps(payload, ensure_ascii=False, indent=1)[:4000])
        return None
    return payload


def cmd_post_draft_new(c, a):
    video = pathlib.Path(a.file)
    if not video.exists():
        raise SystemExit(f"文件不存在: {video}")
    payload = build_post_payload(c, video, a.title, a.desc, pathlib.Path(a.cover) if a.cover else None)
    if _send_or_dry(a, payload) is None:
        return
    j = _write_post(c, payload, "draft")
    d = j.get("data") or {}
    print(f"草稿已存：errCode={j.get('errCode')} objectId={d.get('objectId') or d.get('objectIdStr')}")
    if a.json:
        emit(j, a)


def cmd_post_preview(c, a):
    """手机预览票据（post_preview 返回 ticket，扫码在自己手机看效果；非在册作品）。"""
    video = pathlib.Path(a.file)
    if not video.exists():
        raise SystemExit(f"文件不存在: {video}")
    payload = build_post_payload(c, video, a.title, a.desc, pathlib.Path(a.cover) if a.cover else None)
    if _send_or_dry(a, payload) is None:
        return
    j = _write_post(c, payload, "preview")
    d = j.get("data") or {}
    print(f"预览票据已生成：errCode={j.get('errCode')} ticket={d.get('ticket')}（手机扫码可看，非公开发布）")
    if a.json:
        emit(j, a)


def cmd_post_publish(c, a):
    _confirm_guard(a, "正式公开发布")
    video = pathlib.Path(a.file)
    if not video.exists():
        raise SystemExit(f"文件不存在: {video}")
    if getattr(a, "dry_run", False):
        print("--dry-run：完整链=上传→post_clip_video→轮询转码→post_create（未执行）")
        return
    r = publish_video(c, video, a.title, a.desc, pathlib.Path(a.cover) if a.cover else None)
    print(f"已正式发布：errCode={r['errCode']} {r.get('errMsg') or ''} clipDraftId={r.get('draftId')}")
    if getattr(a, "json", False):
        print(json.dumps(r, ensure_ascii=False, indent=1))


def cmd_post_delete(c, a):
    _confirm_guard(a, "删除已发布内容")
    j = call("post/post_delete", env(objectId=a.object_id), c)
    print(f"删除：errCode={j.get('errCode')} {j.get('errMsg')}")
    if a.json:
        emit(j, a)


def cmd_post_deldraft(c, a):
    _confirm_guard(a, "删除草稿")
    j = call("post/del_draft", env(objectId=a.object_id), c)
    print(f"删草稿：errCode={j.get('errCode')} {j.get('errMsg')}")
    if a.json:
        emit(j, a)


def cmd_post_visible(c, a):
    _confirm_guard(a, "修改可见性")
    j = call("post/post_update_visible", env(objectId=a.object_id, visibleType=int(a.level)), c)
    print(f"可见性→{a.level}：errCode={j.get('errCode')} {j.get('errMsg')}")
    if a.json:
        emit(j, a)


def cmd_post_upload_raw(c, a):
    """低层验证：上传单个文件，打印返回 URL（不发布）。"""
    p = pathlib.Path(a.file)
    if not p.exists():
        raise SystemExit(f"文件不存在: {p}")
    kind = a.kind
    r = dfs_upload(c, p, kind)
    print(f"[{kind}] {p.name} {r['size']}B md5={r['md5']}")
    print(f"  url={r['url'][:120]}")
    if a.json:
        emit(r, a)




# ---------- W1 直播/推流码命令（1125 实测） ----------

def cmd_live_stream(c, a):
    """创建准备态直播对象并取推流地址+密钥（rtmp://push-m1.wxlivecdn.com/... + txSecret）。
    注意：这会创建一个 liveObjectId（准备态，不公开）；不用请立即 live close 回收。"""
    j = call("live/create_live_prepare", env(), c)
    d = j.get("data") or {}
    if getattr(a, "json", False):
        emit(j, a)
        return
    print(f"errCode={j.get('errCode')}")
    print(f"  liveObjectId   = {d.get('liveObjectId')}")
    print(f"  推流地址        = {d.get('anchorStreamingUrl')}")
    print(f"  推流密钥        = {str(d.get('anchorStreamingKey'))[:60]}...")
    print(f"  回放地址        = {str(d.get('playbackUrl') or '')[:60]}")
    print("  (回收: python sph.py live close <liveObjectId> --confirm)")
    if a.json:
        emit(d, a)


def cmd_live_status(c, a):
    j = call("live/check_live_status", env(), c)
    d = j.get("data") or {}
    if getattr(a, "json", False):
        emit(d, a)
        return
    print(f"status={d.get('status')} liveObjectId={d.get('liveObjectId')} 昵称={d.get('wxNickname')}")
    if a.json:
        emit(d, a)


def cmd_live_close(c, a):
    _confirm_guard(a, "关闭直播对象")
    j = call("live/close_live", env(liveObjectId=a.live_id), c)
    print(f"close: errCode={j.get('errCode')} {j.get('errMsg')}")
    if a.json:
        emit(j, a)


def cmd_live_notices(c, a):
    j = call("live/current_live_notice", env(), c)
    d = j.get("data") or {}
    for r in d.get("noticeRecords") or []:
        print(f"[预告] {r.get('nickname','')} 通知数={r.get('reserveNoticeUserCount')}")
        for s in r.get("reserveNoticeUserCountByScene") or []:
            print(f"    {s.get('sceneName')}: {s.get('reserveNoticeUserCount')}")
    j2 = call("live/live_notice_list", env(), c)
    d2 = j2.get("data") or {}
    print(f"历史预告总数: {d2.get('totalCount')}")

    if getattr(a, "json", False):
        emit({"current": d, "list": d2}, a)


# ---------- 装配 ----------

def main(argv=None):
    _utf8()
    p = argparse.ArgumentParser(prog="sph", description="视频号后台 CLI (只读)")
    p.add_argument("--vault", help="cookie 保险库 JSON 路径")
    p.add_argument("--cookie", help='直接给 cookie，如 "sessionid=..;wxuin=.."')
    p.add_argument("--json", action="store_true", help="输出原始 JSON")
    sub = p.add_subparsers(dest="cmd", required=True)

    sub.add_parser("whoami")

    sp = sub.add_parser("post"); psp = sp.add_subparsers(dest="op", required=True)
    q = psp.add_parser("list"); q.add_argument("--page", type=int, default=1)
    q.add_argument("--count", type=int, default=10); q.add_argument("--type", type=int, default=0)
    psp.add_parser("drafts").add_argument("--count", type=int, default=10)
    psp.add_parser("albums")
    q = psp.add_parser("get"); q.add_argument("object_id")
    q = psp.add_parser("draft"); q.add_argument("file")
    q.add_argument("--title", default=""); q.add_argument("--desc", default="")
    q.add_argument("--cover", default=""); q.add_argument("--dry-run", action="store_true")
    q = psp.add_parser("preview"); q.add_argument("file")
    q.add_argument("--title", default=""); q.add_argument("--desc", default="")
    q.add_argument("--cover", default=""); q.add_argument("--dry-run", action="store_true")
    q = psp.add_parser("publish"); q.add_argument("file")
    q.add_argument("--title", default=""); q.add_argument("--desc", default="")
    q.add_argument("--cover", default=""); q.add_argument("--dry-run", action="store_true")
    q.add_argument("--confirm", action="store_true")
    q = psp.add_parser("delete"); q.add_argument("object_id"); q.add_argument("--confirm", action="store_true")
    q = psp.add_parser("deldraft"); q.add_argument("object_id"); q.add_argument("--confirm", action="store_true")
    q = psp.add_parser("visible"); q.add_argument("object_id"); q.add_argument("level")
    q.add_argument("--confirm", action="store_true")
    q = psp.add_parser("upload-raw"); q.add_argument("file")
    q.add_argument("--kind", default="video", choices=["video", "picture", "thumb", "normal"])
    q = psp.add_parser("link"); q.add_argument("object_id", nargs="?", default="")

    sp = sub.add_parser("stat"); psp = sp.add_subparsers(dest="op", required=True)
    psp.add_parser("overview"); psp.add_parser("posts")
    psp.add_parser("fans-trend"); psp.add_parser("fans-portrait")

    sp = sub.add_parser("live"); psp = sp.add_subparsers(dest="op", required=True)
    q = psp.add_parser("history"); q.add_argument("--count", type=int, default=10)
    q.add_argument("--page", type=int, default=1)
    q = psp.add_parser("replays"); q.add_argument("--count", type=int, default=10)
    psp.add_parser("last")
    psp.add_parser("stream"); psp.add_parser("status"); psp.add_parser("notices")
    q = psp.add_parser("close"); q.add_argument("live_id"); q.add_argument("--confirm", action="store_true")

    sp = sub.add_parser("comment"); psp = sp.add_subparsers(dest="op", required=True)
    q = psp.add_parser("list"); q.add_argument("export_id")
    q = psp.add_parser("feeds"); q.add_argument("--page", type=int, default=1)
    q.add_argument("--count", type=int, default=10)

    sp = sub.add_parser("msg"); psp = sp.add_subparsers(dest="op", required=True)
    psp.add_parser("sessions"); psp.add_parser("new")

    sp = sub.add_parser("shop"); psp = sp.add_subparsers(dest="op", required=True)
    psp.add_parser("status"); psp.add_parser("products")
    q = psp.add_parser("orders"); q.add_argument("--page", type=int, default=1)
    q.add_argument("--count", type=int, default=10)

    sp = sub.add_parser("notify"); psp = sp.add_subparsers(dest="op", required=True)
    q = psp.add_parser("list"); q.add_argument("--count", type=int, default=10)

    sp = sub.add_parser("income"); psp = sp.add_subparsers(dest="op", required=True)
    psp.add_parser("detail")

    sub.add_parser("member")
    sp = sub.add_parser("collection"); psp = sp.add_subparsers(dest="op", required=True)
    q = psp.add_parser("list"); q.add_argument("--count", type=int, default=10)

    sp = sub.add_parser("profile"); psp = sp.add_subparsers(dest="op", required=True)
    psp.add_parser("sections")

    a = p.parse_args(argv)
    c = load_cookies(a)
    if not c:
        raise SystemExit("无 cookie：--vault/--cookie/SPH_COOKIE 或放好保险库")
    table = {
        ("whoami", None): cmd_whoami,
        ("post", "list"): cmd_post_list, ("post", "drafts"): cmd_post_drafts,
        ("post", "albums"): cmd_post_albums, ("post", "link"): cmd_post_link,
        ("post", "get"): cmd_post_get,
        ("post", "draft"): cmd_post_draft_new, ("post", "preview"): cmd_post_preview,
        ("post", "publish"): cmd_post_publish, ("post", "delete"): cmd_post_delete,
        ("post", "deldraft"): cmd_post_deldraft, ("post", "visible"): cmd_post_visible,
        ("post", "upload-raw"): cmd_post_upload_raw,
        ("stat", "overview"): cmd_stat_overview, ("stat", "posts"): cmd_stat_posts,
        ("stat", "fans-trend"): cmd_stat_fans_trend,
        ("stat", "fans-portrait"): cmd_stat_fans_portrait,
        ("live", "history"): cmd_live_history, ("live", "replays"): cmd_live_replays,
        ("live", "last"): cmd_live_last,
        ("live", "stream"): cmd_live_stream, ("live", "status"): cmd_live_status,
        ("live", "close"): cmd_live_close, ("live", "notices"): cmd_live_notices,
        ("comment", "list"): cmd_comment_list, ("comment", "feeds"): cmd_comment_feeds,
        ("msg", "sessions"): cmd_msg_sessions, ("msg", "new"): cmd_msg_new,
        ("shop", "status"): cmd_shop_status, ("shop", "products"): cmd_shop_products,
        ("shop", "orders"): cmd_shop_orders,
        ("notify", "list"): cmd_notify, ("income", "detail"): cmd_income,
        ("member", None): cmd_member,
        ("collection", "list"): cmd_collection,
        ("profile", "sections"): cmd_profile_sections,
    }
    fn = table.get((a.cmd, getattr(a, "op", None)))
    if not fn:
        raise SystemExit(f"未知命令 {a.cmd} {getattr(a, 'op', '')}")
    fn(c, a)


if __name__ == "__main__":
    main()
