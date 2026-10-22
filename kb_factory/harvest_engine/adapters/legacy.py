# -*- coding: utf-8 -*-
"""legacy（Fish 遗产站）收割适配器·探针级骨架（T30）：per-site 传输策略注册表
+ R19 防线（仅 HTTP 存活站强制 http + 禁 scheme 自动升级；FR6.2）。

规格锚点（engine/SPECS/FISH_PROBE.md + SYNTHESIS.md §5 风险表）：
- **#16 www.woc88.com**：443 超时/80 正常（200）——https 强升会被劫持 → 落表
  ``transport=http``（http-only 特例）。防线三向：
  ① 构造向：``site_base_url`` 对 http 型站只产 ``http://`` 基址；
  ② 校验向：``enforce_transport`` 对该站 https URL **硬拒**（该站在 https 域白名单外）；
  ③ 结构向：函数族**不存在任何 scheme 改写路径**——不升 http→https（升级即踩 443 劫持面），
  也不静默降 https→http（降级会掩盖攻击面，宁可硬拒不改写）。
- **#8 www.dq123.com**：转型站（已转「电天下」电气 CAD 社区，旧文库协议失效）——
  443 在役 SSL 正常 → ``transport=auto`` 两 scheme 皆放行，转型事实只入 note（内容
  适配另起炉灶，本件不假装旧协议可用）。
- **#19 doc.vsharing.com 教训**：200 应答但服务器已转为他用——**连通≠存活**，故死活
  判定不进 transport 表，一律以 probe/health.py ``HealthRegistry`` 周探针 status 为准
  （FR1.3：判死站移出调度；plan 期 registry 命中 dead → 硬拒）。

政策区匹配（transport 维度）：按近似注册域（末两标签）归并——裸域/任意子域与落表站
同区即同政策（防线不因换子域旁路）；区外站默认 ``auto``（FISH_PROBE 未探站点不扩大
政策面，死活仍归周探针）。死站判定匹配更窄：精确/子域/www↔裸域互认（勿因
wenku.it168.com 死而误伤 it168 母站族）。

探针级射程（诚实声明）：本件只做策略门（transport 校验 + registry 死站硬拒），无收割
能力。四段中 search **不实现**——探针级无站内检索协议实测依据，返回 registry 内站点
的 FileMeta 占位属数字造假（公约 §6），故抛 NotImplementedError；由类适配器任务
（T34 docin 起）逐站实化后接管该站政策行。fetch_ladder/verify 同理不实现。
"""
from __future__ import annotations

import urllib.parse
from dataclasses import dataclass
from typing import Mapping

from kb_factory.channel_adapters.base import FileMeta
from kb_factory.harvest_engine.adapters.base import (
    HarvestPlan, LadderResult, DownloadAdapter)
from kb_factory.harvest_engine.probe.health import STATUS_DEAD, HealthRegistry

__all__ = [
    "TRANSPORT_HTTP", "TRANSPORT_HTTPS", "TRANSPORT_AUTO", "TRANSPORTS",
    "HTTPS_ALLOWED_TRANSPORTS", "DEFAULT_TRANSPORT", "SiteTransport", "LEGACY_SITES",
    "LegacyPolicyError", "LegacyTransportViolation", "LegacySiteDead",
    "_host_zone", "transport_for", "enforce_transport", "site_base_url",
    "LegacyDownloadAdapter",
]

TRANSPORT_HTTP = "http"    # 强制 http：仅 80 端口存活站（woc88，FISH_PROBE #16）
TRANSPORT_HTTPS = "https"  # 强制 https（对称分支，现表无实例，注入表可测）
TRANSPORT_AUTO = "auto"    # 两 scheme 皆放行（默认；不做任何改写）
TRANSPORTS = (TRANSPORT_HTTP, TRANSPORT_HTTPS, TRANSPORT_AUTO)

#: https 域白名单（transport 维度）：https/auto 在册；http-only 站在白名单外
HTTPS_ALLOWED_TRANSPORTS = (TRANSPORT_HTTPS, TRANSPORT_AUTO)

DEFAULT_TRANSPORT = TRANSPORT_AUTO  # 未落表站默认：两 scheme 放行（不为无据站点扩政策面）


@dataclass(frozen=True)
class SiteTransport:
    """单站传输策略行：transport + 探针依据 + 特例注记（policy 事实，死活另归 HealthRegistry）。"""

    site: str
    transport: str
    basis: str        # 判定依据（FISH_PROBE 总表 #N / SYNTHESIS §5 风险表锚点）
    note: str = ""    # 特例注记（http-only 特例 / 转型站等）


#: 特例落表（任务卡：woc88 http-only 特例 + dq123 转型站；其余存活站无特例政策走默认）
LEGACY_SITES: dict[str, SiteTransport] = {
    "www.woc88.com": SiteTransport(
        site="www.woc88.com", transport=TRANSPORT_HTTP,
        basis="FISH_PROBE #16：443 超时/80 正常（200），https 强升会被劫持（R19 防线）",
        note="http-only 特例（SYNTHESIS §5「仅 HTTP 存活站」行）：帮帮文库，仅 80 端口在役"),
    "www.dq123.com": SiteTransport(
        site="www.dq123.com", transport=TRANSPORT_AUTO,
        basis="FISH_PROBE #8：DNS OK/200/SSL 正常（443 在役，两 scheme 皆可）",
        note="转型站：已转「电天下」电气 CAD/3D 社区，旧文库协议失效——内容适配另起炉灶"),
}


# ---------------- 异常族（策略硬拒；非 wall_status 标记类——墙标记词表不含传输策略） ----------------

class LegacyPolicyError(Exception):
    """legacy 策略硬拒基类（探针级 registry 规则）。"""


class LegacyTransportViolation(LegacyPolicyError):
    """R19 硬拒：URL scheme 违反站点传输策略（https 白名单外 / 强制 scheme 不符 / 非法 scheme）。"""


class LegacySiteDead(LegacyPolicyError):
    """FR1.3 registry 规则硬拒：周探针判死站移出调度（连通≠存活，FISH_PROBE #19 教训）。"""


# ---------------- 纯函数（零网络） ----------------

def _host_zone(host: str) -> str:
    """主机政策区（近似注册域）：末两标签——woc88.com 型单级 TLD 足用（本表无 co.uk 类）。"""
    parts = (host or "").rstrip(".").lower().split(".")
    return ".".join(parts[-2:]) if len(parts) >= 2 else ".".join(parts)


def transport_for(host: str, *,
                  transports: Mapping[str, SiteTransport] | None = None) -> SiteTransport:
    """站点 → 传输策略行：同政策区（注册域）命中落表行（排序遍历定序）；区外默认 auto 行。

    未落表≠放任不管：默认行如实标注「无 per-site 特例政策」，死活仍以 HealthRegistry 为准。
    """
    table = transports if transports is not None else LEGACY_SITES
    zone = _host_zone(host)
    for site in sorted(table):  # 同区多行取字典序首行（现表无同区冲突）
        if _host_zone(site) == zone:
            return table[site]
    return SiteTransport(site=(host or "").lower(), transport=DEFAULT_TRANSPORT,
                         basis="未落表站点：无 per-site 特例政策，两 scheme 放行（死活以 "
                               "HealthRegistry 周探针为准；入表须探针依据）")


def enforce_transport(url: str, *, transports: Mapping[str, SiteTransport] | None = None) -> str:
    """R19 防线校验（纯函数零网络）：scheme 合规则**原样返回**输入 URL——绝不改写。

    - scheme 只认 http/https，其他（ftp/file/空…）→ ``LegacyTransportViolation``；
    - URL 无主机名 → 同硬拒（无法按站定策）；
    - transport=http（woc88 型）：http 放行原样返回（**断言不升级**）；https → 硬拒
      （该站不在 https 域白名单：443 超时/被劫持，FISH_PROBE #16）；
    - transport=auto：http/https 均原样放行（禁双向改写：不升 https 也不降 http）；
    - transport=https：https 放行；http → 硬拒（强制 https 站，对称分支）。

    设计要点：本函数不存在任何 scheme 改写路径（禁自动升级是结构性的——升级 http→https
    正是 R19 劫持面；静默降级 https→http 同样拒，因为降级即掩盖攻击面）。
    """
    table = transports if transports is not None else LEGACY_SITES
    split = urllib.parse.urlsplit(str(url).strip())
    scheme = split.scheme.lower()
    host = (split.hostname or "").lower()
    if scheme not in ("http", "https"):
        raise LegacyTransportViolation(
            f"legacy 仅认 http/https URL，实测 scheme={scheme!r}：{url!r}")
    if not host:
        raise LegacyTransportViolation(f"URL 无主机名，无法按站点传输策略校验：{url!r}")
    entry = transport_for(host, transports=table)
    if scheme == "https" and entry.transport not in HTTPS_ALLOWED_TRANSPORTS:
        raise LegacyTransportViolation(
            f"https 硬拒（R19）：{host} 传输策略={entry.transport}（{entry.basis}）——"
            f"该站不在 https 域白名单，强制使用 http URL：{url!r}")
    if scheme == "http" and entry.transport == TRANSPORT_HTTPS:
        raise LegacyTransportViolation(
            f"http 硬拒：{host} 传输策略=https（强制 https 站），不接受 http URL：{url!r}")
    return url


def site_base_url(site: str, *, transports: Mapping[str, SiteTransport] | None = None) -> str:
    """站点规范基址（构造向强制）：http 型站产 ``http://site/``（woc88），其余产
    ``https://site/``（现代站默认）。新 URL 一律经此产 scheme，再经 enforce_transport
    复核（两函数共享同一表，构造结果天然自通过校验）。
    """
    entry = transport_for(site, transports=transports)
    scheme = "http" if entry.transport == TRANSPORT_HTTP else "https"
    return f"{scheme}://{site}/"


def _site_alias(host: str, site: str) -> bool:
    """死站判定主机归属（比 transport 政策区窄）：精确 / registry 键子域 / www↔裸域互认
    ——勿因 wenku.it168.com 死而扩大到 it168.com 全族误伤母站。"""
    return host == site or host.endswith("." + site) or site.endswith("." + host)


# ---------------- DownloadAdapter 子类骨架（探针级） ----------------

class LegacyDownloadAdapter(DownloadAdapter):
    """Fish 遗产站收割适配器·探针级骨架（T30/FR6.2）：只做策略门，不做收割。

    - 注册名 ``channel = site = "legacy"``（orchestrator/T40 注册表口径；本件未过验收
      不入注册——缝合契约「只接已过 AC 适配器」）；
    - 策略门两道（plan 段）：①HealthRegistry 判死硬拒（FR1.3；判死优先于传输校验——
      死站连策略校验都不必）；②R19 传输策略校验（enforce_transport）；
    - 政策事实落 ``meta.extra["legacy_site"/"legacy_transport"]``（供 ledger 留痕）；
    - search/fetch_ladder/verify 不实现：探针级无检索协议与收割能力，占位即造假。
    """

    site = "legacy"
    channel = "legacy"

    def __init__(self, registry: HealthRegistry,
                 transports: Mapping[str, SiteTransport] | None = None):
        self.registry = registry      # probe/health.py 真符号：{site:{status,last_probe,reason}}
        self.registry.load()          # 以磁盘为准（upsert/mark 落盘后重建实例亦一致）
        self._transports = transports if transports is not None else LEGACY_SITES

    def search(self, query: str, limit: int) -> list[FileMeta]:
        """段1 不实现（探针级射程声明）：无站内检索协议实测依据，返回 registry 站点
        FileMeta 占位=数字造假（公约 §6）；类适配器（T34 docin 起）逐站实化后接管。"""
        raise NotImplementedError(
            "legacy 段1 search 探针级不实现（无站内检索协议实测依据，占位 FileMeta=数字造假）；"
            "由类适配器（T34 docin 起）逐站实化")

    def plan(self, meta: FileMeta) -> HarvestPlan:
        """段2（探针级=策略门）：死站硬拒（HealthRegistry/FR1.3）+ R19 传输校验；
        配置发现属类适配器（探针级无站点配置协议，不假装能发现）。"""
        url = str(meta.source_url or "").strip()
        split = urllib.parse.urlsplit(url)
        host = (split.hostname or "").lower()
        if not url or not host:
            raise LegacyPolicyError(
                f"FileMeta 无站点 URL（source_url 空/无主机），探针级无法按站定策：{meta.title!r}")
        dead = self._dead_verdict(host)
        if dead is not None:
            raise LegacySiteDead(
                f"{host} 周探针判死（registry reason={dead.get('reason')!r}，"
                f"last_probe={dead.get('last_probe')}）——已移出调度，硬拒（FR1.3）")
        entry = transport_for(host, transports=self._transports)
        enforce_transport(url, transports=self._transports)  # R19：scheme 违规硬拒不改写
        meta.extra["legacy_site"] = host
        meta.extra["legacy_transport"] = entry.transport
        return HarvestPlan(meta=meta)

    def fetch_ladder(self, plan: HarvestPlan) -> LadderResult:
        """段3 不实现：探针级无收割能力（遗产站协议须先活探验证，SYNTHESIS §5
        「协议代际漂移」行——Fish 2021 端点表不可直接信）；类适配器实化。"""
        raise NotImplementedError("legacy 段3 fetch_ladder 探针级不实现（遗产协议须先活探验证），"
                                  "由类适配器（T34 起）实化")

    def verify(self, result: LadderResult) -> bool:
        """段4 不实现：质检核验对接 quality_gate 属类适配器实化后的事。"""
        raise NotImplementedError("legacy 段4 verify 探针级不实现（无产物可验），由类适配器实化")

    def _dead_verdict(self, host: str) -> dict | None:
        """registry 死站判定：host 归属任一 status==dead 记录（_site_alias 口径）即死；
        状态未知（未入表）不猜死——死活结论只出自周探针（零造假）。"""
        for site in sorted(self.registry.sites()):
            record = self.registry[site]
            if record.get("status") == STATUS_DEAD and _site_alias(host, site):
                return record
        return None
