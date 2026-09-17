"""站点身份：ed25519 密钥对，落 data/swarm/identity.json（gitignored）。

签名口径：sign(canonical_json(manifest 去掉 sig 字段))；私钥永不入
注册表、永不入互换包——互换包只带公钥指纹可查的 site_id。

did:wba 派生（P3 第 13 路调研落地，ANP-03 v1.1 spec 2.2.2 六步）：
Ed25519 原始公钥 → 等价 JWK → RFC 7638 thumbprint → SHA-256 →
base64url 无填充（43 字符）→ "e1_" 前缀。密钥→身份的绑定本机即真实
成立；HTTPS DID 文档端点（域名 443 + proof 闭环）属基建，见
RESEARCH_DOCKET/v3/13-anp-did-prestudy/DIGEST.md ③。
"""
from __future__ import annotations

import base64
import hashlib
import json
import os
import re
import time

SPEC = "swarm-ed25519-v1"

_B58_ALPHABET = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"
# ABNF（spec 2.2）：path-segment = 1*(ALPHA/DIGIT/"-"/"_"/".")
_PATH_SEGMENT = re.compile(r"^[A-Za-z0-9._-]+$")
_MULTIKEY_ED25519_PREFIX = b"\xed\x01"  # multicodec: ed25519-pub


def _b64url_nopad(data: bytes) -> str:
    return base64.urlsafe_b64encode(data).rstrip(b"=").decode("ascii")


def _b58btc(data: bytes) -> str:
    n = int.from_bytes(data, "big")
    out = ""
    while n:
        n, r = divmod(n, 58)
        out = _B58_ALPHABET[r] + out
    for byte in data:          # 前导 0x00 每字节一个 '1'
        if byte:
            break
        out = "1" + out
    return out or "1"


def e1_fingerprint(raw_pubkey: bytes) -> str:
    """spec 2.2.2 六步的 3-6 步：JWK thumbprint(RFC 7638)→sha256→base64url。

    输入是 32 字节 Ed25519 原始公钥（第 2 步的等价 JWK 构造在函数内完成）。
    """
    jwk = json.dumps({"crv": "Ed25519", "kty": "OKP",
                      "x": _b64url_nopad(raw_pubkey)},
                     sort_keys=True, separators=(",", ":"))
    digest = hashlib.sha256(jwk.encode("utf-8")).digest()
    return "e1_" + _b64url_nopad(digest)


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
                       init_points: int = 0) -> SiteIdentity:
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

    # ---- did:wba（P3 预研落地：真指纹派生+合法 DID 字符串）----

    def raw_public_key(self) -> bytes:
        return self._priv.public_key().public_bytes_raw()  # type: ignore[attr-defined]

    def did_wba_fingerprint(self) -> str:
        return e1_fingerprint(self.raw_public_key())

    def did_wba(self, domain: str, *segments: str) -> str:
        """合法 did:wba 字符串：did:wba:<域名>[:<路径段>…:e1_<指纹>]。

        末段指纹=密钥绑定（同站同钥恒同值）；路径段须过 ABNF 字符集
        （site_id 含中文时不入路径——指纹本身已唯一标识密钥）。
        此时尚不可解析（HTTPS DID 端点属基建档），但绑定已真实成立。
        """
        if not domain or ":" in domain:
            raise ValueError(f"域名非法（FQDN，不得带端口/IP）: {domain!r}")
        parts = [domain]
        for seg in segments:
            if not _PATH_SEGMENT.match(seg):
                raise ValueError(f"路径段违反 did:wba ABNF: {seg!r}")
            parts.append(seg)
        parts.append(self.did_wba_fingerprint())
        return "did:wba:" + ":".join(parts)

    def did_document(self, domain: str) -> dict:
        """e1 profile DID 文档（spec 2.5 必填字段齐备）。

        proof 为简化实现：对 canonical(文档去 proof) 做 Ed25519 签名
        （eddsa-jcs-2022 形态）。发布到端点前须过 anp SDK verifier
        闭环自测（DIGEST ③ 第 3 条），故仅在本地生成、不入互换包。
        """
        did = self.did_wba(domain)
        vm_id = f"{did}#key-1"
        multikey = "z" + _b58btc(_MULTIKEY_ED25519_PREFIX
                                 + self.raw_public_key())
        doc = {
            "@context": ["https://www.w3.org/ns/did/v1",
                         "https://w3id.org/security/data-integrity/v2",
                         "https://w3id.org/security/multikey/v1"],
            "id": did,
            "verificationMethod": [{
                "id": vm_id, "type": "Multikey", "controller": did,
                "publicKeyMultibase": multikey}],
            "authentication": [vm_id],
            "assertionMethod": [vm_id],
        }
        proof = {"type": "DataIntegrityProof",
                 "cryptosuite": "eddsa-jcs-2022",
                 "verificationMethod": vm_id,
                 "proofPurpose": "assertionMethod",
                 "created": time.strftime("%Y-%m-%dT%H:%M:%SZ",
                                          time.gmtime())}
        sig = self.sign(canonical(doc))
        proof["proofValue"] = "z" + _b58btc(base64.b64decode(sig))
        doc["proof"] = proof
        return doc


def _b58btc_decode(text: str) -> bytes:
    n = 0
    for ch in text:
        n = n * 58 + _B58_ALPHABET.index(ch)
    pad = 0
    for ch in text:
        if ch != "1":
            break
        pad += 1
    body = n.to_bytes((n.bit_length() + 7) // 8, "big") if n else b""
    return b"\x00" * pad + body


def verify_document(doc: dict, pub_b64: str) -> bool:
    """did_document 简化口径自验：canonical(文档去 proof) 签名核对。"""
    if not isinstance(doc, dict) or "proof" not in doc:
        return False
    value = doc["proof"].get("proofValue", "")
    if not isinstance(value, str) or not value.startswith("z"):
        return False
    try:
        sig_b64 = base64.b64encode(_b58btc_decode(value[1:])).decode()
    except (ValueError, IndexError):
        return False
    body = {k: v for k, v in doc.items() if k != "proof"}
    return SiteIdentity.verify(canonical(body), sig_b64, pub_b64)


def canonical(manifest: dict) -> bytes:
    """签名覆盖面：排序键+紧凑分隔的确定性 JSON。"""
    return json.dumps(manifest, ensure_ascii=False, sort_keys=True,
                      separators=(",", ":")).encode("utf-8")
