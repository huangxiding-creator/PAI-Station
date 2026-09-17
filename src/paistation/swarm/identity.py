"""站点身份：ed25519 密钥对，落 data/swarm/identity.json（gitignored）。

签名口径：sign(canonical_json(manifest 去掉 sig 字段))；私钥永不入
注册表、永不入互换包——互换包只带公钥指纹可查的 site_id。
"""
from __future__ import annotations

import base64
import json
import os
import time

SPEC = "swarm-ed25519-v1"


class SwarmUnavailable(RuntimeError):
    """缺 cryptography（swarm extra 未装）。"""


def _crypto():
    try:
        from cryptography.hazmat.primitives.asymmetric import ed25519
    except ImportError as exc:  # pragma: no cover - 装齐即不触发
        raise SwarmUnavailable(
            "站群签名需要 cryptography：pip install paistation[swarm]") from exc
    return ed25519


class SiteIdentity:
    """一个站的身份。load_or_create 幂等：文件在则载入，不在则生成。"""

    def __init__(self, site_id: str, private_b64: str, created_at: str):
        ed25519 = _crypto()
        self.site_id = site_id
        self.created_at = created_at
        self._priv = ed25519.Ed25519PrivateKey.from_private_bytes(
            base64.b64decode(private_b64))
        self._private_b64 = private_b64

    # ---- 生命周期 ----

    @classmethod
    def load_or_create(cls, data_dir: str, site_id: str | None = None,
                       init_points: int = 0) -> "SiteIdentity":
        path = os.path.join(data_dir, "identity.json")
        if os.path.isfile(path):
            with open(path, encoding="utf-8") as fh:
                row = json.load(fh)
            return cls(row["site_id"], row["private_key"], row["created_at"])
        ed25519 = _crypto()
        priv = ed25519.Ed25519PrivateKey.generate()
        private_b64 = base64.b64encode(
            priv.private_bytes_raw()).decode()  # type: ignore[attr-defined]
        import secrets
        sid = site_id or f"pai-{secrets.token_hex(4)}"
        created = time.strftime("%Y-%m-%dT%H:%M:%S+08:00")
        os.makedirs(data_dir, exist_ok=True)
        row = {"spec": SPEC, "site_id": sid, "private_key": private_b64,
               "created_at": created}
        with open(path, "w", encoding="utf-8") as fh:
            json.dump(row, fh, ensure_ascii=False, indent=2)
        return cls(sid, private_b64, created)

    # ---- 公开面 ----

    def public_key_b64(self) -> str:
        pub = self._priv.public_key().public_bytes_raw()  # type: ignore[attr-defined]
        return base64.b64encode(pub).decode()

    def did_hint(self) -> str:
        """ANP did:wba 预研位（P3 接真 DID，这里只留稳定格式）。"""
        return f"did:wba:placeholder:{self.site_id}"

    def sign(self, data: bytes) -> str:
        return base64.b64encode(self._priv.sign(data)).decode()

    @staticmethod
    def verify(data: bytes, sig_b64: str, pub_b64: str) -> bool:
        ed25519 = _crypto()
        try:
            pub = ed25519.Ed25519PublicKey.from_public_bytes(
                base64.b64decode(pub_b64))
            pub.verify(base64.b64decode(sig_b64), data)
            return True
        except Exception:  # noqa: BLE001 - 坏签名/坏公钥统一 False
            return False


def canonical(manifest: dict) -> bytes:
    """签名覆盖面：排序键+紧凑分隔的确定性 JSON。"""
    return json.dumps(manifest, ensure_ascii=False, sort_keys=True,
                      separators=(",", ":")).encode("utf-8")
