"""D2 git-native 市场协议：发布=push / 安装=add+版本缓存+依赖白名单。

语义对齐 Claude Code 市场协议：技能包=目录（SKILL.md 主体）+ card.json
（name/version/depends/eval_result/signature）。签名=发布者 HMAC
（密钥外置，publish/install 双方各自注入）；安装闸=验签+依赖白名单
（供应链防线）。
"""
from __future__ import annotations

import hashlib
import hmac
import json
import re
import shutil
from dataclasses import asdict, dataclass, field
from pathlib import Path

_FRONT = re.compile(r"\A---\s*\n(.*?)\n---", re.DOTALL)


@dataclass
class SkillCard:
    name: str
    version: str
    depends: list[str] = field(default_factory=list)
    eval_result: dict = field(default_factory=dict)
    signature: str = ""

    def digest_material(self) -> bytes:
        material = {"name": self.name, "version": self.version,
                    "depends": self.depends, "eval_result": self.eval_result}
        return json.dumps(material, ensure_ascii=False,
                          sort_keys=True).encode("utf-8")


def _sign(secret: bytes, payload: bytes) -> str:
    return "hmac-sha256:" + hmac.new(secret, payload,
                                     hashlib.sha256).hexdigest()


def _skill_digest(bundle: Path) -> bytes:
    parts = []
    for p in sorted(bundle.rglob("*")):
        if p.is_file() and p.name != "card.json":
            parts.append(p.relative_to(bundle).as_posix().encode()
                         + b"\x00" + p.read_bytes())
    return hashlib.sha256(b"\x00".join(parts)).digest()


def _read_frontmatter(skill_md: Path) -> dict:
    text = skill_md.read_text(encoding="utf-8")
    m = _FRONT.match(text)
    meta: dict = {}
    if m:
        for line in m.group(1).splitlines():
            if ":" in line:
                k, _, v = line.partition(":")
                meta[k.strip()] = v.strip()
    return meta


def publish(skill_dir: str | Path, dest: str | Path, signer: bytes,
            depends: list[str] | None = None,
            eval_result: dict | None = None) -> Path:
    """发布=打包到 dest/<name>-<version>/（=git push 的本地语义）。"""
    skill_dir = Path(skill_dir)
    meta = _read_frontmatter(skill_dir / "SKILL.md")
    name, version = meta.get("name", skill_dir.name), meta.get("version", "1.0")
    bundle = Path(dest) / f"{name}-{version}"
    if bundle.exists():
        shutil.rmtree(bundle)
    bundle.mkdir(parents=True)
    for p in skill_dir.rglob("*"):
        if p.is_file():
            target = bundle / p.relative_to(skill_dir)
            target.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(p, target)
    card = SkillCard(name=name, version=version,
                     depends=depends or [], eval_result=eval_result or {})
    card.signature = _sign(signer, card.digest_material()
                           + b"\x00" + _skill_digest(bundle))
    (bundle / "card.json").write_text(
        json.dumps(asdict(card), ensure_ascii=False, indent=2),
        encoding="utf-8")
    return bundle


def verify_bundle(bundle: str | Path, secret: bytes) -> bool:
    bundle = Path(bundle)
    card_path = bundle / "card.json"
    if not card_path.is_file():
        return False
    card = SkillCard(**json.loads(card_path.read_text(encoding="utf-8")))
    want = _sign(secret, card.digest_material() + b"\x00"
                 + _skill_digest(bundle))
    return hmac.compare_digest(want, card.signature)


def install(bundle: str | Path, data_dir: str | Path, secret: bytes,
            allowed_deps: list[str] | None = None) -> dict:
    """安装=add（复制进 data/skills）+版本缓存（data/skills-cache）；
    安装闸=验签+依赖白名单（供应链防线）。"""
    bundle = Path(bundle)
    data_dir = Path(data_dir)
    card = SkillCard(**json.loads(
        (bundle / "card.json").read_text(encoding="utf-8")))
    bad_deps = [d for d in card.depends if d not in set(allowed_deps or [])]
    if bad_deps:
        return {"installed": False,
                "reason": f"依赖不在白名单：{bad_deps}"}
    if not verify_bundle(bundle, secret=secret):
        return {"installed": False, "reason": "签名校验失败（包被篡改或密钥不符）"}
    target = data_dir / "skills" / card.name
    if target.exists():
        shutil.rmtree(target)
    shutil.copytree(bundle, target)
    cache = data_dir / "skills-cache" / card.name / card.version
    if cache.exists():
        shutil.rmtree(cache)
    shutil.copytree(bundle, cache)
    return {"installed": True, "reason": "",
            "name": card.name, "version": card.version}


def list_installed(data_dir: str | Path) -> list[tuple[str, str]]:
    cache = Path(data_dir) / "skills-cache"
    if not cache.is_dir():
        return []
    out = []
    for name_dir in sorted(cache.iterdir()):
        if name_dir.is_dir():
            for ver_dir in sorted(name_dir.iterdir()):
                out.append((name_dir.name, ver_dir.name))
    return out
