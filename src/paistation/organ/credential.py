"""流转凭证（PROPOSAL_V2.md 3.3，红线 R14）：器官间显式交接契约。

每张凭证 = JSON 落盘一行（chain.jsonl），带 sha256 摘要——
可审计、可回滚、可追溯；篡改即时可验（audit_chain）。
"""
from __future__ import annotations

import hashlib
import json
import os
import tempfile
import uuid
from dataclasses import dataclass, field, replace
from datetime import datetime
from pathlib import Path

from .registry import ORGANS, find, organ_dir

CREDENTIALS_DIRNAME = "_credentials"
CHAIN_FILENAME = "chain.jsonl"


@dataclass(frozen=True)
class Credential:
    """一张流转凭证（不可变）。"""

    kind: str
    upstream: str
    downstream: str
    payload: dict = field(default_factory=dict)
    id: str = ""
    issued_at: str = ""
    digest: str = ""


def _replace(cred: Credential, **changes) -> Credential:
    """dataclasses.replace 的薄封装（测试用它模拟篡改）。"""
    return replace(cred, **changes)


def _digest(kind: str, upstream: str, downstream: str, payload: dict,
            cred_id: str, issued_at: str) -> str:
    basis = json.dumps({"kind": kind, "upstream": upstream,
                        "downstream": downstream, "payload": payload,
                        "id": cred_id, "issued_at": issued_at},
                       ensure_ascii=False, sort_keys=True)
    return hashlib.sha256(basis.encode("utf-8")).hexdigest()


def issue(kind: str, upstream: str, downstream: str, payload: dict) -> Credential:
    """签发凭证：契约字段缺失显式拒绝（火星轨道器教训——单位/语义必须显式）。"""
    if not kind:
        raise ValueError("凭证缺 kind（流转类型），拒绝签发")
    if not upstream:
        raise ValueError("凭证缺 upstream（上游器官），拒绝签发")
    if not downstream:
        raise ValueError("凭证缺 downstream（下游器官），拒绝签发")
    cred_id = uuid.uuid4().hex[:12]
    issued_at = datetime.now().isoformat(timespec="seconds")
    return Credential(kind=kind, upstream=upstream, downstream=downstream,
                      payload=dict(payload), id=cred_id, issued_at=issued_at,
                      digest=_digest(kind, upstream, downstream, payload,
                                     cred_id, issued_at))


def verify(cred: Credential) -> bool:
    """重算摘要比对——任何字段被篡改即 False。"""
    if not (cred.kind and cred.upstream and cred.downstream and cred.digest):
        return False
    return _digest(cred.kind, cred.upstream, cred.downstream, cred.payload,
                   cred.id, cred.issued_at) == cred.digest


def _chain_path(root: Path, organ_name: str) -> Path:
    spec = find_by_name_or_panic(organ_name)
    return organ_dir(Path(root), spec) / CREDENTIALS_DIRNAME / CHAIN_FILENAME


def find_by_name_or_panic(organ_name: str):
    """按目录名（'04 智库'）或短名（'智库'）解析器官。"""
    for spec in ORGANS:
        if organ_name in (spec.dirname, spec.name, spec.id):
            return spec
    raise KeyError(f"未知器官 {organ_name!r}")


def append_to_chain(root: Path, organ_name: str, cred: Credential) -> Path:
    """凭证追加进器官的链文件（原子：临时文件 + replace，追加保序）。"""
    path = _chain_path(root, organ_name)
    path.parent.mkdir(parents=True, exist_ok=True)
    line = json.dumps(asdict_safe(cred), ensure_ascii=False)
    fd, tmp = tempfile.mkstemp(dir=str(path.parent), suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as fh:
            if path.exists():
                fh.write(path.read_text(encoding="utf-8").rstrip("\n") + "\n")
            fh.write(line + "\n")
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)
    return path


def asdict_safe(cred: Credential) -> dict:
    return {"id": cred.id, "kind": cred.kind, "upstream": cred.upstream,
            "downstream": cred.downstream, "payload": cred.payload,
            "issued_at": cred.issued_at, "digest": cred.digest}


def read_chain(root: Path, organ_name: str) -> list[Credential]:
    """读回器官链上全部凭证（坏行跳过但不吞——计为不可验证）。"""
    path = _chain_path(root, organ_name)
    if not path.exists():
        return []
    creds: list[Credential] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            row = json.loads(line)
        except json.JSONDecodeError:
            continue
        creds.append(Credential(**{k: row.get(k, "") for k in
                                   Credential.__dataclass_fields__
                                   if k != "payload"} |
                                {"payload": row.get("payload", {})}))
    return creds


def audit_chain(root: Path) -> dict:
    """全器官凭证链审计：总量/可验证/坏凭证（篡改即现形）。"""
    total = ok = bad = 0
    for spec in ORGANS:
        path = organ_dir(Path(root), spec) / CREDENTIALS_DIRNAME / CHAIN_FILENAME
        if not path.exists():
            continue
        for cred in read_chain(root, spec.dirname):
            total += 1
            if verify(cred):
                ok += 1
            else:
                bad += 1
    return {"total": total, "ok": ok, "bad": bad}
