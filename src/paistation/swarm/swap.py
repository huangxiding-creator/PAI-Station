"""技能包互换：打包（签名）→ 接收（验签+扫描+记账）→ 回执（对账）。

互换包 = 外层 zip：SWARM.json（清单+签名）+ payload.zip（技能目录，
由 skills/market.export 产出，含 meta.yaml）。签名覆盖清单本体
（去 sig 字段的 canonical JSON），payload 完整性靠 sha256 字段互锁——
改价格、改来源、换 payload 任何一处，验签/哈希必炸其一。

方向语义：A 打包（卖方，回执确认后 +price）；B 接收（买方，收包即
-price，余额不足拒收）；回执由 B 签发，A confirm 后入账收入。
"""
from __future__ import annotations

import hashlib
import io
import json
import os
import tempfile
import time
import zipfile

from ..skills.market import SkillMarket, read_meta
from .identity import SiteIdentity, canonical

SWAP_SPEC = "swarm-swap/1"
RECEIPT_SPEC = "swarm-receipt/1"
_REQUIRED = ("spec", "package", "from_site", "price_points",
             "packed_at", "payload_sha256", "sig")


def _sha256(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


# ---- 打包（发布侧） ----

def pack_swap(skill_dir: str, out_path: str, identity: SiteIdentity,
              price: int = 0, to_site: str = "") -> dict:
    """技能目录 → 签名互换包。meta.yaml 缺失时 market.export 自动补默认。"""
    name = os.path.basename(os.path.normpath(skill_dir))
    with tempfile.TemporaryDirectory() as tmp:
        payload_path = SkillMarket("").export(skill_dir, tmp)
        payload = open(payload_path, "rb").read()
    manifest = {"spec": SWAP_SPEC, "package": name,
                "version": str(read_meta(skill_dir).get("version", "")),
                "from_site": identity.site_id, "to_site": to_site,
                "price_points": int(price),
                "packed_at": time.strftime("%Y-%m-%dT%H:%M:%S+08:00"),
                "payload_sha256": _sha256(payload)}
    manifest["sig"] = identity.sign(canonical(
        {k: v for k, v in manifest.items() if k != "sig"}))
    os.makedirs(os.path.dirname(out_path) or ".", exist_ok=True)
    with zipfile.ZipFile(out_path, "w", zipfile.ZIP_DEFLATED) as zf:
        zf.writestr("SWARM.json",
                    json.dumps(manifest, ensure_ascii=False, indent=2))
        zf.writestr("payload.zip", payload)
    return manifest


def read_swap_package(zip_path: str) -> tuple[dict, bytes]:
    with zipfile.ZipFile(zip_path) as zf:
        names = zf.namelist()
        if "SWARM.json" not in names or "payload.zip" not in names:
            raise ValueError(f"不是站群互换包（缺 SWARM.json/payload.zip）：{zip_path}")
        manifest = json.loads(zf.read("SWARM.json").decode("utf-8"))
        payload = zf.read("payload.zip")
    return manifest, payload


# ---- 验签（消费侧闸门） ----

def verify_swap(manifest: dict, payload: bytes, registry,
                my_site_id: str = "") -> dict:
    missing = [k for k in _REQUIRED if k not in manifest]
    if missing:
        raise ValueError(f"互换包清单缺字段：{missing}")
    if manifest["spec"] != SWAP_SPEC:
        raise ValueError(f"清单 spec 不识：{manifest['spec']}（要 {SWAP_SPEC}）")
    to_site = str(manifest.get("to_site", ""))
    if to_site and my_site_id and to_site != my_site_id:
        raise ValueError(f"包发给 {to_site} 的，不是本站（{my_site_id}）")
    site = registry.require(manifest["from_site"])
    sig = manifest.pop("sig")
    ok = SiteIdentity.verify(canonical(manifest), sig, site["pubkey"])
    manifest["sig"] = sig
    if not ok:
        raise ValueError(
            f"验签失败：{manifest['from_site']} 公钥对不上（清单被改或登记错公钥）")
    if _sha256(payload) != manifest["payload_sha256"]:
        raise ValueError("payload 哈希不符（包内容被换过）")
    return site


# ---- 接收（导入+支出记账） ----

def receive_swap(zip_path: str, dest: str, registry, identity: SiteIdentity,
                 ledger) -> dict:
    """验签→余额闸→安全扫描导入→记账→签回执。任一步失败零残留。"""
    manifest, payload = read_swap_package(zip_path)
    verify_swap(manifest, payload, registry, my_site_id=identity.site_id)
    price = int(manifest["price_points"])
    ledger.ensure_mint()
    if price > ledger.balance():
        raise ValueError(f"积分不足：需 {price}，余额 {ledger.balance()}")
    with tempfile.TemporaryDirectory() as tmp:
        with zipfile.ZipFile(io.BytesIO(payload)) as zf:
            zf.extractall(tmp)  # noqa: S108 - 临时目录
        src = os.path.join(tmp, manifest["package"])
        if not os.path.isdir(src):
            raise ValueError(f"payload 内无 {manifest['package']}/ 目录")
        SkillMarket("").import_from(src, dest)   # 五层扫描+元数据+同版闸
    ledger.append("swap_in", package=manifest["package"],
                  counterparty=manifest["from_site"], points=-price)
    receipt = {"spec": RECEIPT_SPEC, "package": manifest["package"],
               "from_site": identity.site_id, "to_site": manifest["from_site"],
               "received_at": time.strftime("%Y-%m-%dT%H:%M:%S+08:00"),
               "price_points": price,
               "payload_sha256": manifest["payload_sha256"]}
    receipt["sig"] = identity.sign(canonical(
        {k: v for k, v in receipt.items() if k != "sig"}))
    return receipt


# ---- 回执确认（收入入账） ----

def confirm_receipt(receipt: dict, registry, ledger) -> dict:
    if receipt.get("spec") != RECEIPT_SPEC:
        raise ValueError(f"不是回执（spec={receipt.get('spec')}）")
    for field in ("package", "from_site", "to_site", "sig"):
        if not receipt.get(field):
            raise ValueError(f"回执缺字段：{field}")
    site = registry.require(receipt["from_site"])
    sig = receipt.pop("sig")
    ok = SiteIdentity.verify(canonical(receipt), sig, site["pubkey"])
    receipt["sig"] = sig
    if not ok:
        raise ValueError(f"回执验签失败：{receipt['from_site']} 公钥对不上")
    if ledger.has_receipt(receipt):
        raise ValueError("该回执已入账（幂等拒绝）")
    return ledger.append("income", package=receipt["package"],
                         counterparty=receipt["from_site"],
                         points=int(receipt["price_points"]),
                         extra={"receipt_sha": ledger.receipt_sha(receipt)})
