"""用户裁决进化提案 CLI（M12，R15 配套——批准必须人来按）。

用法：
  python tools/evolution_approve.py                # 列出待裁提案
  python tools/evolution_approve.py 2026-W37-01 --approve
  python tools/evolution_approve.py 2026-W37-01 --reject
批准 → land()：状态 approved + R14 凭证落 11 进化 链。
"""
import json
import os
import sys

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)),
                                "..", "src"))

from paistation.evolve.proposer import land          # noqa: E402
from paistation.organ.registry import find_by_name, organ_dir  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))


def _proposals_root():
    return organ_dir(ROOT, find_by_name("进化")) / "proposals"


def _find(proposal_id: str):
    fname = proposal_id.replace("-", "_") + ".json"
    path = _proposals_root() / fname
    if not path.is_file():
        raise SystemExit(f"未找到提案文件：{path}")
    return json.loads(path.read_text(encoding="utf-8"))


def main() -> int:
    argv = [a for a in sys.argv[1:] if not a.startswith("--")]
    flag = next((a for a in sys.argv[1:] if a.startswith("--")), "")
    folder = _proposals_root()
    if not argv:
        pending = sorted(folder.glob("2*.json")) if folder.exists() else []
        rows = []
        for p in pending:
            try:
                row = json.loads(p.read_text(encoding="utf-8"))
            except (OSError, json.JSONDecodeError):
                continue
            if row.get("status") == "pending_user":
                rows.append(row)
        if not rows:
            print("无待裁提案（pending_user 为空）")
            return 0
        for row in rows:
            ev = row.get("evidence", {})
            print(f"[{row['id']}] {row['kind']} {row['target']} "
                  f"证据 {ev.get('before')}→{ev.get('after')} {ev.get('gate', '')}")
        print("\n裁决：python tools/evolution_approve.py <id> --approve|--reject")
        return 0
    prop = _find(argv[0])
    if flag == "--approve":
        user = os.environ.get("USERNAME") or "用户"
        landed = land(ROOT, prop, approved_by=user)
        print(f"已批准并落地：{landed['id']}（凭证已入 11 进化 链）")
        return 0
    if flag == "--reject":
        prop = {**prop, "status": "rejected",
                "rejected_at": prop.get("issued_at", "")}
        path = folder / (argv[0].replace("-", "_") + ".json")
        path.write_text(json.dumps(prop, ensure_ascii=False, indent=1),
                        encoding="utf-8")
        print(f"已驳回：{prop['id']}")
        return 0
    print(__doc__)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
