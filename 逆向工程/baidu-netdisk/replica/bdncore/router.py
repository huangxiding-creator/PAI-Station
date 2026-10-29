# -*- coding: utf-8 -*-
"""ChannelRouter：读写路由表 + 读面自动降级（W5）。

路由表（W4 实测定型，漂移账 #13）：
- **写面唯一 = /api 家族**（api/create + api/filemanager）；xpan 写面 9019 need verify
  风控墙（本账号死路）结构性排除——写面永不降级，失败如实上报；
- **读面 = api 优先 → xpan 降级链**：api 家族 5xx/超时（BdnNetworkError=session 3 次
  退避耗尽）或接口下线（errno -10）时，xpan 同功能端点重试一次；
  业务性 errno（-9 不存在/2 参数错…）结果可信，不降级；
- pcs 遗产族已退役（漂移账 #1），除 superfile2/locateupload 数据面外一律不路由；
- 熔断（BdnCircuitOpen）与凭据错（BdnAuthError）= 全局性故障，换家族无意义不降级。

T1 bdpan 子进程通道（BdpanSubprocessChannel）：只留接口默认 off。bdpan=官方二进制，
走它=接受其自带遥测/rand 签名族/OAuth 沙箱路径（/apps/{appname} 锁死，与全盘绝对
路径红线冲突）——零遥测红线下仅在 /api 家族整面死亡时才值得评估启用（届时需独立
审批+遥测面审计），本战役不实现。

离线单测：FakeTransport 模拟降级路径（tests/test_offline_w5.py）。
"""
from __future__ import annotations

from .api import _normalize_entry
from .errors import (BdnApiError, BdnAuthError, BdnCircuitOpen,
                     BdnNetworkError)

# 读面路由表：op → 家族有序链（前者优先，可降级到后者）
READ_CHAINS = {
    "ls": ("api", "xpan"),             # router 级降级（W5 新增 xpan list 通道）
    "meta": ("builtin",),              # BdnApi.metas 自带 api→xpan 兜底（W3）
    "quota": ("builtin",),             # BdnApi.quota 自带 GET→POST 兜底（W3）
    "search": ("xpan",),               # api 家族无搜索端点（PROTOCOL G4）
    "share_records": ("api", "xpan"),  # router 级降级（W5 新增 xpan share record 通道）
    "recycle_list": ("api",),
}
# 家族标签 → 通道方法前缀
_FAMILY_PREFIX = {"api": "_ch_api", "xpan": "_ch_xpan", "builtin": "_ch_builtin"}
# 写面路由表：唯一家族=/api（漂移账 #13）；xpan 写面 9019 墙不进表=结构性不可达
WRITE_FAMILY = "api"

# 可降级 errno：仅「接口下线」；业务性 errno 结果可信不降级
FALLBACK_ERRNOS = frozenset({-10})


def should_fallback(exc: Exception) -> bool:
    """按异常类型/errno 判定是否换家族重试（降级钩子）。"""
    if isinstance(exc, (BdnCircuitOpen, BdnAuthError)):
        return False
    if isinstance(exc, BdnNetworkError):
        return True               # HTTP≥500/传输异常 3 次退避耗尽
    if isinstance(exc, BdnApiError):
        return exc.errno in FALLBACK_ERRNOS
    return False


class BdpanSubprocessChannel:
    """T1 bdpan 子进程通道接口（默认 off，本战役不实现）。

    取舍：启用=接受官方二进制自带遥测/rand 签名族/OAuth 沙箱路径，违背零遥测+
    全盘绝对路径两红线；且其失败退出码仍 0（bdp 实测），须文本解析。
    仅当 /api 家族整面死亡（如全员 9019 风控墙）时才值得评估，届时需独立审批。
    """

    enabled = False

    def call(self, op: str, **kw):
        raise NotImplementedError(
            "T1 bdpan 子进程通道默认关闭（遥测取舍见类注释；启用需独立审批）")


class RoutedApi:
    """BdnApi 的路由门面：读面带 api→xpan 降级链；写面直通 /api 家族（唯一）。
    未路由的方法（login_status/tree/上传三段/分享写面…）经 __getattr__ 直通
    BdnApi——对调用方（CLI/引擎/冒烟）透明替换。"""

    def __init__(self, api):
        self.api = api
        self.s = api.s
        self.routing_log: list[dict] = []      # [{op,family,ok,errno,fallback}]
        self.t1 = BdpanSubprocessChannel()     # T1 桩：默认 off

    def __getattr__(self, name):
        if name.startswith("_") or name == "api":
            raise AttributeError(name)
        return getattr(self.api, name)

    # ---------- 分派 ----------

    def _dispatch(self, op: str, kw: dict) -> dict:
        chain = READ_CHAINS[op]
        last: Exception | None = None
        for i, family in enumerate(chain):
            fn = getattr(self, _FAMILY_PREFIX[family] + "_" + op)
            try:
                r = fn(**kw)
                self.routing_log.append({"op": op, "family": family, "ok": True})
                out = dict(r)
                out["_route"] = family
                return out
            except Exception as e:                       # noqa: BLE001 台账后按钩子决策
                fb = should_fallback(e) and i + 1 < len(chain)
                self.routing_log.append({
                    "op": op, "family": family, "ok": False,
                    "errno": getattr(e, "errno", None),
                    "error": type(e).__name__, "fallback": fb})
                if not fb:
                    raise
                last = e
        raise last    # pragma: no cover（链仅两段，前段 fb=False 直抛；保底防御）

    # ---------- 读面通道 ----------

    def list_dir(self, dir_path: str = "/", page: int = 1, num: int = 1000,
                 order: str = "name", desc: int = 0) -> dict:
        return self._dispatch("ls", dict(dir_path=dir_path, page=page,
                                         num=num, order=order, desc=desc))

    def metas(self, fsids: list, dlink: int = 0) -> dict:
        return self._dispatch("meta", dict(fsids=fsids, dlink=dlink))

    def quota(self) -> dict:
        return self._dispatch("quota", dict())

    def search(self, key: str, dir_path: str = "/", recursion: int = 1,
               page: int = 1, num: int = 100) -> dict:
        return self._dispatch("search", dict(key=key, dir_path=dir_path,
                                             recursion=recursion, page=page,
                                             num=num))

    def share_records(self, page: int = 1) -> dict:
        return self._dispatch("share_records", dict(page=page))

    def recycle_list(self, page: int = 1, num: int = 100) -> dict:
        return self._dispatch("recycle_list", dict(page=page, num=num))

    # 通道实现：api 腿直通 BdnApi（已实证形态）；xpan 腿为 W5 新增同功能端点；
    # builtin 腿=BdnApi 已内置家族兜底的方法（W3 在役，router 只记账不重排）
    def _ch_api_ls(self, dir_path="/", page=1, num=1000, order="name", desc=0):
        return self.api.list_dir(dir_path, page=page, num=num,
                                 order=order, desc=desc)

    def _ch_xpan_ls(self, dir_path="/", page=1, num=1000, order="name", desc=0):
        limit = max(1, min(int(num), 1000))
        p = self.s.get("/rest/2.0/xpan/file", params={
            "method": "list", "dir": dir_path, "order": order, "desc": desc,
            "start": (max(1, int(page)) - 1) * limit, "limit": limit,
            "web": 1, "folder": 1, "clienttype": 8})
        p["entries"] = [_normalize_entry(x) for x in (p.get("list") or [])]
        return p

    def _ch_builtin_meta(self, fsids, dlink=0):
        return self.api.metas(fsids, dlink=dlink)   # 内置 api→xpan 兜底（W3）

    def _ch_builtin_quota(self):
        return self.api.quota()                     # 内置 GET→POST 兜底（W3）

    def _ch_xpan_search(self, key, dir_path="/", recursion=1, page=1, num=100):
        return self.api.search(key, dir_path=dir_path, recursion=recursion,
                               page=page, num=num)

    def _ch_api_share_records(self, page=1):
        return self.api.share_records(page=page)

    def _ch_xpan_share_records(self, page=1):
        p = self.s.get("/rest/2.0/xpan/share", params={
            "method": "record", "page": max(1, int(page)), "clienttype": 8})
        p["entries"] = [
            {"shareid": e.get("shareId") or e.get("share_id"),
             "shortlink": e.get("shortlink") or e.get("short_url"),
             "typical_path": e.get("typicalPath") or e.get("typical_path"),
             "ctime": e.get("ctime"),
             "views": e.get("vCnt") or e.get("view_count"),
             "downloads": e.get("dCnt") or e.get("download_count"),
             "status": e.get("status"),
             "passwd": "***" if (e.get("passwd") or e.get("pwd")) else ""}
            for e in (p.get("list") or [])]
        return p

    def _ch_api_recycle_list(self, page=1, num=100):
        return self.api.recycle_list(page=page, num=num)

    # ---------- 写面（唯一家族=/api；直通 BdnApi，永不降级） ----------

    def mkdir(self, dir_path: str, rtype: int = 0) -> dict:
        return self.api.mkdir(dir_path, rtype=rtype)

    def rename(self, path: str, newname: str) -> dict:
        return self.api.rename(path, newname)

    def move(self, src: str, dst_dir: str) -> dict:
        return self.api.move(src, dst_dir)

    def copy(self, src: str, dst_dir: str) -> dict:
        return self.api.copy(src, dst_dir)

    def delete(self, paths: list) -> dict:
        return self.api.delete(paths)
