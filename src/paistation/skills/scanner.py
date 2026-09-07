"""技能安全扫描（移植 QwenPaw 五层范式，提案 4.2 skills）。

五层：①SKILL.md frontmatter 完整性 ②正文危险命令（复用 ToolGuard 分级）
③路径越界（系统目录/逃逸引用）④未声明的网络外联（warn 级）
⑤体积与文件数上限。verdict：pass < warn < block。
"""
import os
import re

from ..security.tool_guard import ToolGuard

_FRONT = re.compile(r"\A---\s*\n(.*?)\n---\s*\n?", re.DOTALL)
_REQUIRED_KEYS = ("name", "description")
_SYSTEM_PATHS = ("c:/windows", "c:/program files", "/etc/", "/usr/bin",
                 "system32", "c:/users/all users")
_URL = re.compile(r"https?://")


def scan_skill(skill_dir: str, max_bytes: int = 2 * 1024 * 1024,
               max_files: int = 50) -> dict:
    """返回 {verdict, layers: [{layer, reason}]}；block 优先于 warn。"""
    layers: list[dict] = []

    def hit(level: int, reason: str):
        layers.append({"layer": level, "reason": reason})

    skill_md = os.path.join(skill_dir, "SKILL.md")
    if not os.path.isfile(skill_md):
        return {"verdict": "block",
                "layers": [{"layer": 1, "reason": "缺少 SKILL.md"}]}
    raw = open(skill_md, encoding="utf-8", errors="replace").read()
    match = _FRONT.match(raw)
    meta: dict[str, str] = {}
    if match:
        for line in match.group(1).splitlines():
            if ":" in line:
                key, _, value = line.partition(":")
                meta[key.strip()] = value.strip()
    missing = [k for k in _REQUIRED_KEYS if not meta.get(k)]
    if missing:
        hit(1, f"frontmatter 缺字段：{missing}")

    body = raw[match.end():] if match else raw
    guard = ToolGuard()
    for line in body.splitlines():
        verdict = guard.classify(line)
        if verdict == "deny":
            hit(2, f"正文含危险命令：{line.strip()[:60]}")

    norm = raw.replace("\\", "/").lower()
    for sys_path in _SYSTEM_PATHS:
        if sys_path in norm:
            hit(3, f"引用系统敏感路径：{sys_path}")
            break

    if _URL.search(body):
        hit(4, "正文含网络地址（需声明或人工确认）")

    total = 0
    count = 0
    for dirpath, _dirnames, filenames in os.walk(skill_dir):
        for name in filenames:
            count += 1
            total += os.path.getsize(os.path.join(dirpath, name))
    if total > max_bytes:
        hit(5, f"技能体积超限：{total} > {max_bytes} 字节")
    if count > max_files:
        hit(5, f"文件数超限：{count} > {max_files}")

    if any(item["layer"] in (1, 2, 3, 5) for item in layers):
        verdict = "block"
    elif layers:
        verdict = "warn"
    else:
        verdict = "pass"
    return {"verdict": verdict, "layers": layers}
