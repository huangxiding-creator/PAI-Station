"""分身传承（提案第 24 章⑤）：avatar.pai 只读教学副本。

三铁律（写进文件自说明）：opt-in 授权 / 随时可吊销 / 禁止冒充本人。
只传方法（SKILL.md 技能卡），绝不携带隐私（记忆/画像/账本零导出）。
"""
import json
import os
import time

_ETHICS = ("授权：opt-in——仅经本人主动导出生效；"
           "可吊销：导出方随时可声明作废本副本；"
           "禁冒充：本副本不得以本人身份对外行事——只传方法，不传身份")


def export_avatar(skills_dir: str, out_path: str,
                  learned_from: str = "", now_fn=time.time) -> dict:
    """技能目录 → avatar.pai 教学副本（JSON）。返回导出清单。"""
    skills = []
    if os.path.isdir(skills_dir):
        for name in sorted(os.listdir(skills_dir)):
            md = os.path.join(skills_dir, name, "SKILL.md")
            if os.path.isfile(md):
                with open(md, encoding="utf-8") as fh:
                    content = fh.read()
                skills.append({"name": name, "skill_md": content})
    data = {
        "format": "avatar.pai/v1",
        "exported_at": now_fn(),
        "learned_from": learned_from,       # 师承链：方法从谁的长出来的
        "ethics": _ETHICS,
        "skills": skills,                   # 只有方法——零隐私字段
    }
    parent = os.path.dirname(os.path.abspath(out_path))
    os.makedirs(parent, exist_ok=True)
    with open(out_path, "w", encoding="utf-8") as fh:
        json.dump(data, fh, ensure_ascii=False, indent=1)
    return data
