# -*- coding: utf-8 -*-
"""腾讯 ima 渠道适配器（W5，元数据层）。

import 复刻件（E:\\AI-Station\\逆向工程\\IMA下载助手\\replica\\ima_replica.py，协议级），
只包 search_knowledge_base（广场搜库）类只读能力成 metadata()——禁 join/download，
不触碰 login_qr 自动扫码（按令：不硬闯）。

运行时降级：无凭据 / token 过期 / 复刻件不可导入 → available()=False 且
metadata() 返回 []（不抛崩溃），审计记录降级原因。库级条目 pages/source_url
响应中无对应字段 → 如实 None，零造假。
"""
import json
import os
import sys
import time

from kb_factory.channel_adapters.base import ChannelAdapter, FileMeta, RateLimiter

DEFAULT_REPLICA_DIR = r"E:\AI-Station\逆向工程\IMA下载助手\replica"


class ImaMetaAdapter(ChannelAdapter):
    channel = "ima"

    def __init__(self, replica_dir: str = DEFAULT_REPLICA_DIR, limiter: RateLimiter | None = None,
                 audit=None):
        self.replica_dir = replica_dir
        if limiter is None:
            limiter = RateLimiter(min_interval=3.0, daily_limit=200, name="ima")
        self.limiter = limiter  # 复刻件检索无自带节流；3s 间隔（安全门下限，日 200）
        self.audit = audit
        self._reason = ""
        self._mod = None

    def _log(self, event, query, count, detail=""):
        if self.audit is not None:
            self.audit.log(channel=self.channel, event=event, query=query, count=count,
                           detail=detail)

    def _module(self):
        """导入复刻件模块（延迟导入；测试可指向 stub 目录）。"""
        if self._mod is None:
            if self.replica_dir not in sys.path:
                sys.path.insert(0, self.replica_dir)
            import importlib
            sys.modules.pop("ima_replica", None)  # 保证按本目录重新解析
            self._mod = importlib.import_module("ima_replica")
        return self._mod

    def _cred(self):
        """读凭据（纯本地 IO，不登录不请求）。返回 (cred|None, 原因)。"""
        m = self._module()
        cred_file = getattr(m, "CRED_FILE",
                            os.path.join(self.replica_dir, "credentials.json"))
        if not os.path.exists(cred_file):
            return None, "无凭据: credentials.json 缺失"
        with open(cred_file, encoding="utf-8") as f:
            cred = json.load(f)
        if time.time() >= cred.get("token_expire_time", 0) - 300:
            return None, "登录态失效(token过期, 需扫码/刷新, 按令不硬闯自动降级)"
        return cred, ""

    def available(self) -> bool:
        try:
            cred, why = self._cred()
        except Exception as e:
            cred, why = None, f"ima_replica 不可用: {type(e).__name__}: {e}"
        self._reason = why
        return cred is not None

    def metadata(self, query: str, limit: int = 12) -> list:
        if not self.available():
            self._log("degrade", query, 0, self._reason)
            return []
        cred, _ = self._cred()
        m = self._module()
        client = m.ImaClient()
        client.cred = cred  # 直塞凭据，绕开会打印/可能触发刷新登录的 load_cred
        self.limiter.acquire()
        t0 = time.monotonic()
        try:
            res = client.search_kb_plaza(query, limit=limit)
        except Exception as e:
            self.limiter.record_error()
            if self.audit is not None:
                self.audit.log(channel=self.channel, event="error", query=query,
                               elapsed_ms=int((time.monotonic() - t0) * 1000), count=0,
                               detail=f"{type(e).__name__}: {e}")
            return []
        self.limiter.record_success()
        kbs = res.get("searched_knowledge_bases") or []
        if self.audit is not None:
            self.audit.log(channel=self.channel, event="request", query=query,
                           elapsed_ms=int((time.monotonic() - t0) * 1000), count=len(kbs))
        return [FileMeta(title=k.get("name") or "", fmt="kb", pages=None,
                         badge="ima_public", perm="green", source_url=None,
                         extra={"kb_id": k.get("id"), "join_type": k.get("join_type"),
                                "creator": (k.get("creator_info") or {}).get("nickname"),
                                "description": k.get("description")})
                for k in kbs][:limit]
