# -*- coding: utf-8 -*-
"""PAN-HUNTER W2 发现层基座（2026-10-30 深夜）

二级能力契约（PROPOSAL §四）：大四盘+139 免登「发现层」= 列表 + 探活，**不下载**。
铁律落地：
  零凭据零 Cookie——BDCLND 是分享码派生 cookie（公开面），除此之外不设任何凭据位；
  单盘并发≤1（调用方串行保证）/ 盘间≤4 / 链间间隔≥2s（调用方保证）；
  总预算硬门 ≤150 发（DiscoveryLedger 全局计数，超发即熔断抛 BudgetExceeded）；
  迅雷真验证码即熔断（见 xunlei.py）。

配方出处：RESEARCH_DOCKET/r3_big4_disks.md（A 级配方）+ pansou check_service.go
（MIT，fish2018/pansou，逐参数实证 2026-10-30）。
"""
from __future__ import annotations

import json
import random
import re
import threading
import time
from dataclasses import dataclass, field

from curl_cffi import requests as creq

IMPERSONATE = "chrome124"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
STEP_SLEEP = (0.8, 1.5)     # 盘 API 链内步骤礼貌间隔
LINK_GAP = (2.0, 3.5)       # 同盘链与链之间（调用方用）

MAX_SHOTS = 150             # 发现层总预算（铁律）


class BudgetExceeded(RuntimeError):
    """发现层预算（≤150 发）耗尽——立即停，不加发。"""


class DiscoveryLedger:
    """发现层全局记账（每 HTTP 发一行，数字零造假）。"""

    def __init__(self, max_shots: int = MAX_SHOTS, jsonl_path: str | None = None):
        self.lock = threading.Lock()
        self.max_shots = max_shots
        self.rows: list[dict] = []
        self.jsonl_path = jsonl_path

    def spend(self, disk: str, url: str) -> None:
        with self.lock:
            if len(self.rows) >= self.max_shots:
                raise BudgetExceeded(
                    f"发现层预算 {self.max_shots} 发已耗尽（last={self.rows[-1] if self.rows else '-' }）")
            row = {"ts": time.strftime("%H:%M:%S"), "disk": disk,
                   "host": url.split("/")[2] if "://" in url else url[:40],
                   "path": (url.split("/", 3)[3][:60] if url.count("/") >= 3 else "")}
            self.rows.append(row)
            if self.jsonl_path:
                with open(self.jsonl_path, "a", encoding="utf-8") as f:
                    f.write(json.dumps(row, ensure_ascii=False) + "\n")

    @property
    def shots(self) -> int:
        return len(self.rows)


#: 全局默认账本（ph.py discover / 跑批共用；预算按铁律 150）
LEDGER = DiscoveryLedger()


@dataclass
class DEntry:
    """发现层文件项（名/大小/目录树标记；不取直链不下载）。"""
    name: str
    size: int = 0            # bytes；0=未知
    is_dir: bool = False
    fid: str = ""


@dataclass
class DResult:
    """发现层结果契约：探活状态 + 文件清单 + 墙型。"""
    url: str
    disk: str
    ok: bool = False                 # 列表拿到（entries 或 file_count）
    alive: bool = False              # 链接存活（分享未失效/未删；验证码墙也算活）
    state: str = ""                  # ok / dead:失效 / wall:验证码 / wall:提取码 / err:...
    message: str = ""                # 上游 message / errno（证据留痕）
    title: str = ""                  # 分享名
    file_count: int = 0              # 上游口径文件总数（无清单时也算发现成功）
    entries: list[DEntry] = field(default_factory=list)
    shots: int = 0                   # 本链消耗发数

    def wall(self) -> str:
        return self.state if self.state.startswith(("wall:", "dead:")) else ""


class BaseDiscovery:
    """五盘发现层公共基类。子类实现 extract_id() 与 discover()。"""

    name: str = "base"
    domains: tuple[str, ...] = ()

    def __init__(self, ledger: DiscoveryLedger | None = None):
        self.ledger = ledger or LEDGER
        self._own_shots = 0           # 本链自身发数（不受并发盘干扰）

    def _spend(self, url: str):
        """预算扣减+本链计数（会话式请求也必须走这里）。"""
        self.ledger.spend(self.name, url)
        self._own_shots += 1

    # ---- 契约 ----
    @classmethod
    def match_url(cls, url: str) -> bool:
        return any(d in url for d in cls.domains)

    def extract_id(self, url: str) -> str:
        raise NotImplementedError

    def discover(self, url: str, pwd: str = "") -> DResult:
        raise NotImplementedError

    # ---- 便捷件 ----
    def _begin(self, url: str) -> DResult:
        self._own_shots = 0
        return DResult(url=url, disk=self.name)

    def _end(self, r: DResult) -> DResult:
        r.shots = self._own_shots
        return r

    def _step(self):
        time.sleep(random.uniform(*STEP_SLEEP))

    def _req(self, method: str, url: str, *, headers=None, json_body=None,
             data=None, params=None, timeout=20):
        """发现层 HTTP：先扣预算（超发熔断）→ curl_cffi 指纹发。"""
        self._spend(url)
        h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
        if headers:
            h.update(headers)
        kw = dict(headers=h, timeout=timeout, impersonate=IMPERSONATE,
                  allow_redirects=True)
        if params:
            kw["params"] = params
        if json_body is not None:
            kw["json"] = json_body
        if data is not None:
            kw["data"] = data
        return creq.request(method.upper(), url, **kw)

    def get(self, url, **kw):
        return self._req("GET", url, **kw)

    def post(self, url, **kw):
        return self._req("POST", url, **kw)


def link_gap():
    """同盘链间间隔（铁律 ≥2s，带抖动）。"""
    time.sleep(random.uniform(*LINK_GAP))


def strip_pwd(url: str) -> tuple[str, str]:
    """url → (去参 url, 提取码)。识别：
    ① ?pwd=/&pwd=/#pwd=/?password=/?code=/?p=
    ② 中文片段「#（提取码：xxxx」（语料实证：迅雷 TG 链常态，含 URL 编码态）
    ③ 尾部 # 及 URL 片段污染剥离。"""
    m = re.search(r"[?&#](?:pwd|password|code|p)=([^&#\s]+)", url)
    pwd = m.group(1).rstrip("#") if m else ""
    base = re.sub(r"[?&#](?:pwd|password|code|p)=[^&#\s]+", "", url)
    if not pwd:
        from urllib.parse import unquote
        dec = unquote(base)
        m2 = re.search(r"提取码[：:]\s*([A-Za-z0-9]{3,8})", dec)
        if m2:
            pwd = m2.group(1)
    base = re.sub(r"#.*$", "", base)          # 片段整体剥离（含中文码注释）
    base = re.sub(r"[#?]+$", "", base)
    return base, pwd
