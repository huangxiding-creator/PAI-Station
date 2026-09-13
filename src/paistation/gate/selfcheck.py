"""B2 记忆自检三套统一入口（只读不变量检测器）。

①冲突消解不变量：同 (layer,key) active 条目 ≤1（消解动作由 profile.record
内置：新值自动封口旧值；此处只验证不变量未被破坏）。
②结构回归：vault_validate **纯读**（不重算 MANIFEST，篡改必现）+ 画像结构
（JSONL 可解析/layer 合法/id=sha1[:10]）。
③遗忘合规：坟回流扫描（protocol.forget_violations，与 audit 同语义）。
"""
from __future__ import annotations

import hashlib
import json
from pathlib import Path

from paistation.profile.model import LAYERS, ProfileModel
from paistation.sovereign.format import vault_validate
from paistation.sovereign.protocol import forget_violations


def _conflict_scan(data_dir: Path) -> list[dict]:
    seen: dict[tuple[str, str], int] = {}
    for e in ProfileModel(data_dir)._entries:  # noqa: SLF001 —— 自检需全量读
        if e.active:
            k = (e.layer, e.key)
            seen[k] = seen.get(k, 0) + 1
    return [{"layer": layer, "key": key, "active_count": n}
            for (layer, key), n in sorted(seen.items()) if n > 1]


def _profile_structure(data_dir: Path) -> dict:
    path = data_dir / "profile" / "entries.jsonl"
    if not path.is_file():
        return {"parse_ok": True, "entries": 0, "bad_layers": [], "bad_ids": []}
    bad_layers: list[str] = []
    bad_ids: list[str] = []
    n = 0
    for i, line in enumerate(path.read_text(encoding="utf-8").splitlines()):
        if not line.strip():
            continue
        n += 1
        try:
            row = json.loads(line)
        except ValueError:
            return {"parse_ok": False, "entries": n, "bad_layers": [],
                    "bad_ids": [], "why": f"第 {i + 1} 行非 JSON"}
        if row.get("layer") not in LAYERS:
            bad_layers.append(str(row.get("layer")))
        want = hashlib.sha1(
            f"{row.get('layer')}|{row.get('key')}|{row.get('value')}".encode()
        ).hexdigest()[:10]
        if row.get("id") != want:
            bad_ids.append(str(row.get("id")))
    return {"parse_ok": True, "entries": n, "bad_layers": bad_layers,
            "bad_ids": bad_ids}


def selfcheck(data_dir: str | Path, clock=None) -> dict:
    data_dir = Path(data_dir)
    conflicts = _conflict_scan(data_dir)
    structure = vault_validate(data_dir / "sovereign")
    profile = _profile_structure(data_dir)
    forget, tombs_n = forget_violations(data_dir, clock=clock)
    ok = (not conflicts
          and structure["ok"]
          and profile["parse_ok"]
          and not profile["bad_layers"]
          and not profile["bad_ids"]
          and not forget)
    report = {
        "conflicts": conflicts,
        "structure": structure,
        "profile": profile,
        "forget": forget,
        "tombs_checked": tombs_n,
        "ok": ok,
        "report": data_dir / "gate" / "SELFCHECK.md",
    }
    report_path: Path = report["report"]
    report_path.parent.mkdir(parents=True, exist_ok=True)
    report_path.write_text(_render_md(report), encoding="utf-8")
    return report


def _render_md(r: dict) -> str:
    p = r["profile"]
    lines = [
        "# 记忆自检报告（三套）", "",
        f"- 总判定：{'✅ 全绿' if r['ok'] else '❌ 有违规'}", "",
        "## ① 冲突消解不变量",
        f"- 同 (layer,key) 双活：{len(r['conflicts'])} 组"
        + ("（正常：record 自动封口旧值）" if not r["conflicts"] else ""),
        *[f"  - ❌ {c['layer']}/{c['key']}：active×{c['active_count']}"
          for c in r["conflicts"]], "",
        "## ② 结构回归（纯读校验，不重算指纹）",
        f"- vault：{'✅' if r['structure']['ok'] else '❌'}"
        f"（篡改 {len(r['structure']['tampered'])}"
        f" / 未登记 {len(r['structure']['unmanifested'])}）",
        f"- 画像：{p['entries']} 条，layer 非法 {len(p['bad_layers'])}，"
        f"id 非法 {len(p['bad_ids'])}", "",
        "## ③ 遗忘合规（坟回流）",
        f"- 检查坟墓 {r['tombs_checked']} 条，回流违规 {len(r['forget'])} 条",
        *[f"  - ❌ [{v['kind']}] {v['target']}：{v['why']}" for v in r["forget"]],
    ]
    return "\n".join(lines) + "\n"
