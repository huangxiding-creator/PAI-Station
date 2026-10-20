# -*- coding: utf-8 -*-
"""Skill 库原文收割器 — SkillService API 直调 (token 路, 不碰浏览器).

先 listSkills → 逐个 downloadSkill → 落盘 live/skills/<name>.md
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

AM = Path(r"E:\AI-Station\Auto_Manus")
sys.path.insert(0, str(AM))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api  # noqa: E402

OUT = Path(__file__).resolve().parent.parent / "live" / "skills"
OUT.mkdir(parents=True, exist_ok=True)

EMAIL = "05nroahztr@manus.edu.kg"


def try_call(tok, path, body=None):
    variants = [
        (path, body if body is not None else {}),
        (path.replace(".v1/", ".v1.").replace("//", "/"), body),
    ]
    for p, b in variants:
        st, text = api.api_call(None, "POST", p, tok, body=b)
        if st == 200:
            return st, text
        time.sleep(1)
    return st, text


def main():
    tok = api.load_token(EMAIL)
    if not tok:
        print("✗ 无 token")
        return 1
    # 候选路径: gRPC 风格几种包装
    cands = [
        "/skill.v1.SkillService/ListSkills",
        "/api/skill.v1.SkillService/ListSkills",
        "/skill.v1.SkillService/listSkills",
    ]
    st = text = None
    for p in cands:
        st, text = api.api_call(None, "POST", p, tok, body={})
        print(p, "→", st, (text or "")[:150])
        if st == 200:
            break
    if st != 200:
        print("listSkills 全路径失败")
        return 2
    data = json.loads(text)
    (OUT / "_list_raw.json").write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
    items = list(data.get("officialSkills") or []) + list(data.get("userAddedSkills") or [])
    seen = set()
    uniq = []
    for it in items:
        if it.get("id") not in seen:
            seen.add(it.get("id"))
            uniq.append(it)
    print(f"skills: {len(uniq)} (official {len(data.get('officialSkills') or [])} + user {len(data.get('userAddedSkills') or [])})")
    n = 0
    for it in uniq:
        sid = it.get("id")
        name = it.get("name") or str(sid)
        ver = it.get("version")
        got = False
        for body in ({"skillId": sid}, {"id": sid},
                     {"skillId": sid, "version": ver},
                     {"name": name}):
            st2, t2 = api.api_call(None, "POST",
                                   "/skill.v1.SkillService/DownloadSkill",
                                   tok, body=body)
            if st2 == 200 and len(t2) > 200:
                (OUT / f"{name}.json").write_text(t2, encoding="utf-8")
                print(f"✓ {name} ({len(t2)}B)")
                n += 1
                got = True
                break
            time.sleep(0.8)
        if not got:
            print(f"✗ {name} id={sid} last rc={st2} {(t2 or '')[:60]}")
        time.sleep(1.2)
    print(f"=== harvested {n}/{len(uniq)} ===")
    return 0


if __name__ == "__main__":
    sys.exit(main())
