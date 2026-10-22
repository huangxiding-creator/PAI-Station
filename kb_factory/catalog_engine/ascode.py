# -*- coding: utf-8 -*-
"""类型化主题 + 即代码导出（as-code）——KB-FACTORY P2 #8。

调研 Top 模式 #8（DITA + wikibonsai + TemaTres）的落地件：
schema 放配置文件、内容存纯文本、git 友好（可 diff / 可回滚 / 可导出 / 可反导入）。

蓝图 schema（本模块权威定义，stdlib only）：
  bp = {
    "domain": str,        # 领域名
    "topics": [           # 有序主题清单（顺序保留进导出）
      {
        "id":   str,      # 稳定标识 = 文件名 stem，如 "standard_GB50500"；
                          #   缺省时按 "{type}_{标题去非法字符}" 派生
        "type": str,      # TOPIC_TYPES 六类型之一（DITA 风格）
        "title": str,     # 标题
        "source": str,    # 来源（颁发机构/出处）
        "authority": int|str,  # 权威度（如 5 或 "国标"）
        "parent": str|None,    # 层级：父节点 id（None/缺省 = 顶层）
        "description": str,    # 正文描述（写入 .md 正文）
        ...             # 其余标量键原样进 frontmatter（可扩展、可往返）
      }, ...
    ]
  }

导出布局（export_as_code 产出，LF 换行，无时间戳）：
  output_dir/
  ├── schema.yaml      # 本体 schema（类型定义+层级关系），git 可 diff 可版本化
  ├── tree.md          # 目录树总览（人类可读）
  ├── topics/<id>.md   # 每主题一文件：YAML frontmatter + 正文（内容即真相源）
  └── manifest.json    # 文件清单 + sha256 + 计数（审计/校验，导入取顺序）

frontmatter 标量一律按 JSON 标量书写（双引号串/裸数字/true/false/null），
既是合法 YAML，又可用 stdlib json 精确往返，零第三方依赖。

确定性纪律：无随机源、无时钟；同输入必同输出（两次导出字节级一致）。
"""
import hashlib
import json
import re
from pathlib import Path

SCHEMA_VERSION = "kb-factory-ascode/1.0"

TOPIC_TYPES = {
    "standard": "标准项（国标/行标/企标）",
    "regulation": "法规项（法律/行政法规/规章）",
    "case": "案例项（事故/纠纷/成功实践）",
    "method": "方法项（流程/指南/操作规程）",
    "template": "模板项（合同/报告/检查表）",
    "reference": "参考项（手册/图集/数据表）",
}

_FM_ORDER = ("id", "type", "title", "source", "authority", "parent")
_KEY_RE = re.compile(r"^[A-Za-z0-9_-]+$")


# ---------------------------------------------------------------- 蓝图校验/规范化

def _sanitize(name: str) -> str:
    """标题 → 安全文件名片段：去 Windows 非法字符与空白（与 metadata.sanitize_filename 同规）。"""
    return re.sub(r'[\\/:*?"<>|\s]+', "", name)


def _topic_id(topic: dict) -> str:
    tid = str(topic.get("id") or "").strip()
    return tid if tid else f"{topic['type']}_{_sanitize(topic['title'])}"


def _validate_bp(bp: dict) -> tuple:
    """校验并规范化蓝图：不改动入参，返回 (domain, 规范化 topics 新列表)。fail-loud。"""
    if not isinstance(bp, dict):
        raise ValueError("bp 必须是 dict")
    domain = bp.get("domain")
    if not isinstance(domain, str) or not domain.strip():
        raise ValueError("bp.domain 必须是非空 str")
    if not isinstance(bp.get("topics"), list):
        raise ValueError("bp.topics 必须是 list")

    topics, seen = [], set()
    for i, t in enumerate(bp["topics"]):
        if not isinstance(t, dict):
            raise ValueError(f"topics[{i}] 必须是 dict")
        if t.get("type") not in TOPIC_TYPES:
            raise ValueError(f"topics[{i}].type 越界: {t.get('type')!r}，可选 {sorted(TOPIC_TYPES)}")
        if not isinstance(t.get("title"), str) or not t["title"].strip():
            raise ValueError(f"topics[{i}].title 必须是非空 str")
        tid = _topic_id(t)
        if not tid or re.search(r'[\\/:*?"<>|]', tid):
            raise ValueError(f"topics[{i}] id 非法（含路径分隔符或为空）: {tid!r}")
        if tid in seen:
            raise ValueError(f"topics[{i}] id 重复: {tid}")
        seen.add(tid)
        if t.get("parent") == tid:
            raise ValueError(f"topics[{i}] parent 指向自身: {tid}")
        for k, v in t.items():
            if k == "description":
                if not isinstance(v, str):
                    raise ValueError(f"topics[{i}].description 必须是 str")
            elif not isinstance(v, (str, int, float, bool, type(None))):
                raise ValueError(f"topics[{i}].{k} 必须是标量（str/int/float/bool/None），got {type(v).__name__}")
        nt = dict(t)
        nt["id"] = tid
        topics.append(nt)
    return domain, topics


# ---------------------------------------------------------------- frontmatter 编解码

def _fm_dump(topic: dict) -> str:
    """topic → YAML frontmatter 块（键序：_FM_ORDER 在前，扩展键按原序）。"""
    keys = [k for k in _FM_ORDER if k in topic and k != "description"]
    keys += [k for k in topic if k not in _FM_ORDER and k != "description"]
    lines = []
    for k in keys:
        if not _KEY_RE.match(k):
            raise ValueError(f"frontmatter 键名非法（仅限字母数字_-）: {k!r}")
        lines.append(f"{k}: {json.dumps(topic[k], ensure_ascii=False)}")
    return "---\n" + "\n".join(lines) + "\n---\n"


def _fm_load(text: str) -> dict:
    """frontmatter + 正文 → topic dict（编码的逆函数，逐字节精确还原）。"""
    lines = text.split("\n")
    if not lines or lines[0] != "---":
        raise ValueError("frontmatter 缺失：文件须以 '---' 开头")
    topic, i = {}, 1
    while i < len(lines) and lines[i] != "---":
        k, sep, raw = lines[i].partition(": ")
        if not sep or not _KEY_RE.match(k):
            raise ValueError(f"frontmatter 行非法: {lines[i]!r}")
        try:
            topic[k] = json.loads(raw)
        except (json.JSONDecodeError, ValueError):
            topic[k] = raw  # 手写未加引号的纯文本值，按原字符串收
        i += 1
    if i >= len(lines):
        raise ValueError("frontmatter 未闭合：缺少结尾 '---'")
    body = "\n".join(lines[i + 1:])
    if body.endswith("\n"):
        body = body[:-1]  # 导出恒追加一个结尾换行，此处对称剥掉
    topic["description"] = body
    return topic


def _topic_md(topic: dict) -> str:
    return _fm_dump(topic) + topic.get("description", "") + "\n"


# ---------------------------------------------------------------- 三大导出件渲染

def _render_schema_yaml(domain: str, topics: list) -> str:
    by_type = {t: sum(1 for x in topics if x["type"] == t) for t in TOPIC_TYPES}
    lines = [
        f"# KB-FACTORY as-code 本体 schema —— export_as_code 生成（确定性：无时间戳）",
        f"ontology: {SCHEMA_VERSION}",
        f"domain: {json.dumps(domain, ensure_ascii=False)}",
        "topic_types:",
    ]
    lines += [f"  {k}: {json.dumps(v, ensure_ascii=False)}" for k, v in TOPIC_TYPES.items()]
    lines += [
        "hierarchy:",
        "  model: parent-id",
        '  description: "topics/*.md frontmatter 的 parent 字段指向父节点 id；null = 顶层"',
        "counts:",
        f"  topics: {len(topics)}",
        "  by_type:",
    ]
    lines += [f"    {t}: {n}" for t, n in by_type.items()]
    return "\n".join(lines) + "\n"


def _render_tree_md(domain: str, topics: list) -> str:
    by_id = {t["id"]: t for t in topics}
    children: dict = {}
    roots = []
    for t in topics:
        p = t.get("parent")
        (children.setdefault(p, []).append(t) if p in by_id else roots.append(t))
    lines = [f"# 目录树 · {domain}", ""]
    dist = " · ".join(f"{t}×{sum(1 for x in topics if x['type'] == t)}"
                      for t in TOPIC_TYPES
                      if any(x["type"] == t for x in topics))
    lines.append(f"> {len(topics)} 个主题 · {dist}")
    lines.append(f"> schema: {SCHEMA_VERSION}（类型定义与层级关系见 schema.yaml）")
    lines += ["", "## 层级结构", ""]

    def walk(t: dict, depth: int) -> None:
        pad = "  " * depth
        orphan = "" if (not t.get("parent") or t["parent"] in by_id) \
            else f"（父缺失: {t['parent']}）"
        lines.append(f"{pad}- {t['id']} 【{t['type']}】{t.get('title', '')}{orphan}")
        for c in children.get(t["id"], []):
            walk(c, depth + 1)

    for r in roots:
        walk(r, 0)
    return "\n".join(lines) + "\n"


def _write(path: Path, content: str) -> bytes:
    blob = content.encode("utf-8")
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "wb") as f:  # 二进制写：强制 LF、跨平台字节一致
        f.write(blob)
    return blob


# ---------------------------------------------------------------- 公开 API

def export_as_code(bp: dict, output_dir: str) -> list:
    """蓝图 → 即代码文件系统结构。返回创建文件的相对路径清单（posix 风格）。

    topics/*.md 是主题的真相源（frontmatter+正文完整可逆）；
    manifest.json 登记顺序与 sha256 供审计；不删除既有文件。
    """
    domain, topics = _validate_bp(bp)
    out = Path(output_dir)
    plan = [("schema.yaml", _render_schema_yaml(domain, topics), None),
            ("tree.md", _render_tree_md(domain, topics), None)]
    plan += [(f"topics/{t['id']}.md", _topic_md(t), t["id"]) for t in topics]

    entries, rel_paths = [], []
    for rel, content, tid in plan:
        blob = _write(out / rel, content)
        e = {"path": rel, "sha256": hashlib.sha256(blob).hexdigest(), "bytes": len(blob)}
        if tid:
            e["topic_id"] = tid
        entries.append(e)
        rel_paths.append(rel)

    manifest = {
        "schema": SCHEMA_VERSION,
        "domain": domain,
        "counts": {"topics": len(topics),
                   "by_type": {t: sum(1 for x in topics if x["type"] == t)
                               for t in TOPIC_TYPES}},
        "files": entries,
    }
    manifest_rel = "manifest.json"
    _write(out / manifest_rel,
           json.dumps(manifest, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    rel_paths.append(manifest_rel)
    return rel_paths


def import_from_code(dir_path: str) -> dict:
    """从 export_as_code 导出的目录反导入为蓝图 dict（与导出双向兼容）。

    主题内容取自 topics/*.md（可手改后再导入）；manifest.json 提供领域与顺序。
    """
    mfile = Path(dir_path) / "manifest.json"
    if not mfile.is_file():
        raise FileNotFoundError(f"manifest.json 不存在: {mfile}（请先 export_as_code）")
    manifest = json.loads(mfile.read_text(encoding="utf-8"))
    topics = [_fm_load((Path(dir_path) / e["path"]).read_text(encoding="utf-8"))
              for e in manifest["files"] if "topic_id" in e]
    return {"domain": manifest["domain"], "topics": topics}


def diff_blueprints(old_bp: dict, new_bp: dict) -> list:
    """对比两版蓝图 → 人类可读 diff 行清单（+新增/-删除/~修改，含 topics 文件路径）。

    按 id 对齐（无 id 时按 type+标题派生）；相同蓝图返回 []。
    """
    _, olds = _validate_bp(old_bp)
    _, news = _validate_bp(new_bp)
    o, n = {t["id"]: t for t in olds}, {t["id"]: t for t in news}
    lines = []
    if old_bp.get("domain") != new_bp.get("domain"):
        lines.append(f"~ 领域: {old_bp.get('domain')} → {new_bp.get('domain')}")
    for t in olds:  # 旧序：删除与修改
        tid = t["id"]
        nt = n.get(tid)
        if nt is None:
            lines.append(f"- 删除节点 [{t['type']}] {tid}（{t.get('title', '')}）"
                         f" → topics/{tid}.md")
            continue
        for k in sorted(set(t) | set(nt)):
            if t.get(k) != nt.get(k):
                lines.append(f"~ 修改节点 [{t['type']}] {tid}.{k}: "
                             f"{json.dumps(t.get(k), ensure_ascii=False)} → "
                             f"{json.dumps(nt.get(k), ensure_ascii=False)}"
                             f" → topics/{tid}.md")
    for t in news:  # 新序：新增
        if t["id"] not in o:
            lines.append(f"+ 新增节点 [{t['type']}] {t['id']}（{t.get('title', '')}）"
                         f" → topics/{t['id']}.md")
    return lines
