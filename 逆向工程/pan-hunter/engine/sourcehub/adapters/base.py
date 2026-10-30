# -*- coding: utf-8 -*-
"""PAN-HUNTER L2 解析层基座（W1 · 2026-10-31）

铁律落地：
  零登录零凭据——BaseAdapter 不存在任何 cookie/token 输入位；只打公开分享面。
  出口契约：parse(url) → list[FileEntry] → direct_url(entry) → 直链（str）。
  HTTP 层沿 W0 定案：curl_cffi impersonate=chrome124（TLS 指纹）。

FileEntry.extra 盘内自持（fid/stoken 等），不外泄凭据概念。
"""
from __future__ import annotations

import re
import time
import random
from dataclasses import dataclass, field

from curl_cffi import requests as creq

IMPERSONATE = "chrome124"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
STEP_SLEEP = (0.6, 1.2)   # 盘 API 链内步骤间隔（礼貌性；蓝奏验证页另功能性强 制 2.2s）


@dataclass
class FileEntry:
    name: str
    size: int = 0                 # bytes；0=未知
    is_dir: bool = False
    fid: str = ""                 # 盘内文件标识
    extra: dict = field(default_factory=dict)   # 盘内自持参数（stoken/share_fid_token/...）


class PanError(Exception):
    """解析失败（业务语义，含上游 message）。"""


class BaseAdapter:
    """十盘 adapter 公共基类。子类实现 parse() 与 direct_url()。"""

    name: str = "base"            # 盘名（UC/115/123/lanzou/ilanzou/feijipan/ecpan/wenshushu/cow/guangya）
    green: bool = True            # 一级绿盘（黄盘插件 W2 另立）
    domains: tuple[str, ...] = () # 分享链域名匹配表

    #: 下载直链所需附加头（UA/Referer 等，按盘覆写）
    dl_headers: dict = {"User-Agent": UA}

    def _step(self):
        time.sleep(random.uniform(*STEP_SLEEP))

    # ---- HTTP 便捷件（curl_cffi）----
    #: DNS/网络层失败需代理回退的盘域（W0 架构：代理仅重试路径用完即弃）
    PROXY_RETRY_HOSTS = ("cowtransfer.com",)
    #: 代理回退时依次试的 TLS 指纹（cowtransfer 实测 chrome124 被掐、其他指纹另试）
    PROXY_RETRY_IMPERSONATE = ("chrome124", "chrome131", "safari17_0")

    def _req(self, method: str, url: str, *, headers=None, json_body=None,
             data=None, allow_redirects=True, timeout=20, proxies=None):
        h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
        if headers:
            h.update(headers)
        kw = dict(headers=h, timeout=timeout, impersonate=IMPERSONATE,
                  allow_redirects=allow_redirects)
        if proxies:
            kw["proxies"] = proxies
        if json_body is not None:
            kw["json"] = json_body
        if data is not None:
            kw["data"] = data
        try:
            return creq.request(method.upper(), url, **kw)
        except Exception:
            if proxies or not any(d in url for d in self.PROXY_RETRY_HOSTS):
                raise
            for imp in self.PROXY_RETRY_IMPERSONATE:
                kw2 = dict(kw)
                kw2["impersonate"] = imp
                kw2["proxies"] = {"http": "http://127.0.0.1:7892",
                                  "https": "http://127.0.0.1:7892"}
                try:
                    return creq.request(method.upper(), url, **kw2)
                except Exception:
                    continue
            raise

    def get(self, url, **kw):
        return self._req("GET", url, **kw)

    def post(self, url, **kw):
        return self._req("POST", url, **kw)

    # ---- 契约 ----
    @classmethod
    def match_url(cls, url: str) -> bool:
        return any(d in url for d in cls.domains)

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        """分享链 → 文件列表。"""
        raise NotImplementedError

    def direct_url(self, entry: FileEntry) -> str:
        """文件项 → 直链。"""
        raise NotImplementedError

    # ---- 门测试下载头 ----
    def download_headers(self) -> dict:
        return dict(self.dl_headers)

    def stream_download(self, url: str, out_path, cap_bytes: int) -> tuple[int, str]:
        """直链流式落盘（≤cap_bytes 截断），返回 (字节数, sha1)。
        有 _sess（如 UC cookie 引导会话）则用之——直链回调可查会话 cookie。"""
        import hashlib
        sess = getattr(self, "_sess", None)
        if sess is not None:
            r = sess.get(url, headers=self.download_headers(),
                         stream=True, timeout=180)
        else:
            r = creq.get(url, headers=self.download_headers(),
                         impersonate=IMPERSONATE, stream=True, timeout=180)
        if r.status_code >= 400:
            raise PanError(f"下载 HTTP {r.status_code}")
        total, sha = 0, hashlib.sha1()
        with open(out_path, "wb") as f:
            for chunk in r.iter_content(1 << 18):
                if not chunk:
                    continue
                f.write(chunk)
                sha.update(chunk)
                total += len(chunk)
                if total >= cap_bytes:
                    break
        return total, sha.hexdigest().upper()


def extract_pwd(url: str) -> tuple[str, str]:
    """url → (去参 url, 提取码)。识别 ?pwd=/&pwd=/#pwd=/?password=/?code=/?p=；
    尾部 # 及 URL 片段污染剥离（123 盘 TG 链形如 ?pwd=Qiye#）。"""
    m = re.search(r"[?&#](?:pwd|password|code|p)=([^&#\s]+)", url)
    pwd = m.group(1).rstrip("#") if m else ""
    base = re.sub(r"[?&#](?:pwd|password|code|p)=[^&#\s]+", "", url)
    base = re.sub(r"[#?]+$", "", base)
    return base, pwd
