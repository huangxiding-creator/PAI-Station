# -*- coding: utf-8 -*-
"""W7 渠道注册表：每渠道 ON/OFF 状态与原因（进 manifest）。

合规三级：绿（公开/自有）直取、黄（用户权益代取，文库账号默认 OFF）、
红不取只列代购清单。
  local  绿，ON（本地语料在位；扫不到→OFF 带原因）
  wenku  黄，默认 OFF，双闸：env KB_WENKU_FETCH=1 且 secret 在位才启用；
         v1 保持 OFF，未启用时该渠道文件进获取指引清单
  ima    绿，但登录态失效 → OFF 降级（KB_IMA_FETCH=1 可重启用）
  gb     绿，但由 std-samr-gb 技能执行，v1 手动批处理 → 产出指引条目
"""
import os
from dataclasses import dataclass, asdict
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
WENKU_SECRET_DEFAULT = REPO_ROOT / "07 任务" / "自动建库Agent" / "_credentials" / "wenku.secret.ini"

# 获取指引建议文案（绿未命中/黄/红/gb/ima）
ADVICE_GREEN_MISS = "已列入扩源计划"
ADVICE_YELLOW = "需文库会员，可在文库搜索该标题"
ADVICE_RED = "建议官方渠道购买"
ADVICE_GB = "国标件：由 std-samr-gb 技能执行（v1 手动批处理），已列入获取指引"
ADVICE_IMA = "ima 渠道登录态失效已降级，已列入扩源计划"


@dataclass
class ChannelStatus:
    name: str
    badge: str
    perm: str          # green/yellow
    on: bool
    reason: str        # OFF/降级原因（进审计与 manifest，如实）
    note: str = ""

    def to_dict(self) -> dict:
        return asdict(self)


def registry(env: dict | None = None, *, wenku_secret: str | None = None,
             corpus_available: bool = True) -> dict:
    """构建四渠道状态表。env=None 时读 os.environ（缺 key 视为未设）。"""
    e = os.environ if env is None else env
    secret_path = Path(wenku_secret) if wenku_secret else Path(
        e.get("KB_WENKU_SECRET", "") or WENKU_SECRET_DEFAULT)
    fetch = str(e.get("KB_WENKU_FETCH", "")).strip() == "1"
    ima_on = str(e.get("KB_IMA_FETCH", "")).strip() == "1"

    if fetch and secret_path.is_file():
        wenku = ChannelStatus("wenku", "wenku_vip", "yellow", True, "双闸放行（env+secret）",
                              "黄源代取：仅限用户权益范围，v1 下载腿未接线")
    elif fetch:
        wenku = ChannelStatus("wenku", "wenku_vip", "yellow", False,
                              "KB_WENKU_FETCH=1 但 secret 未就位（双闸不放行）")
    else:
        wenku = ChannelStatus("wenku", "wenku_vip", "yellow", False,
                              "默认OFF（黄源双闸：KB_WENKU_FETCH=1 且 secret 在位才启用）")

    return {
        "local": ChannelStatus(
            "local", "self_owned", "green", corpus_available,
            "" if corpus_available else "本地语料目录无可用文件（KB_LOCAL_CORPUS 可配置）",
            "本地绿源：09 发布 自产研报 + mosaico 知识件，复制直取"),
        "wenku": wenku,
        "ima": ChannelStatus(
            "ima", "ima_public", "green", ima_on,
            "" if ima_on else "登录态失效（v1 降级，KB_IMA_FETCH=1 可重启用）"),
        "gb": ChannelStatus(
            "gb", "gb_free", "green", False,
            "由 std-samr-gb 技能执行，v1 手动批处理（产出获取指引条目）"),
    }


def advice_for(badge: str, perm: str = "green") -> str:
    """槽位未取得时的建议获取路径文案。"""
    if perm == "red":
        return ADVICE_RED
    if badge == "wenku_vip":
        return ADVICE_YELLOW
    if badge == "gb_free":
        return ADVICE_GB
    if badge == "ima_public":
        return ADVICE_IMA
    return ADVICE_GREEN_MISS


def manifest_channels(reg: dict) -> list:
    return [c.to_dict() for c in reg.values()]
