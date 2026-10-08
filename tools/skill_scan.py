# -*- coding: utf-8 -*-
"""skill_scan.py — FT-9 外部技能入仓扫描门 (对标 DeerFlow SkillScan).

背景: github-to-skill / SuperSkillWeekly 大量激活上游外部技能, 此前只有
人工红线, 无确定性扫描; 本工具补上入仓前的机器门.

扫描面: .py/.md/.sh/.js/.ts/.ps1/.cmd/.bat/.vbs/.pyw/.json (跳过 .git/__pycache__/node_modules).

规则 (severity / rule):
  HIGH  frontmatter  SKILL.md 缺失或 name/description 缺失为空
  HIGH  eval/exec (排除属性访问 model.eval()/re.exec()) / os.system /
        import-os (__import__ 任意参数) / importlib (importlib.import_module) /
        curl-bash (curl|wget|fetch|aria2c 竖管进 sh 家族) / base64-pipe-sh /
        ps-encoded (PowerShell -enc 16+ 位 base64) / rm-rf / 硬编码密钥 (禁模式)
  HIGH  npm-hook     package.json 安装期钩子 (preinstall/install/postinstall/prepare)
        值含出站 URL 或管道/重定向/命令替换元字符 (| > ` $( 任一)
  MEDIUM domain       http(s) 出站域名在白名单 (tools/skill_scan_allowlist.json) 之外
  HIGH  syntax        .py 文件 ast.parse 不过

缓存: key=sha256(规则类 + NUL + 内容), 规则类按 rel 分化 (SKILL.md / .py /
package.json / 后缀) — 同字节不同规则面不共用缓存 (防 frontmatter HIGH 被同名
.md 干净缓存吞掉); 30 天过期才重扫; 扫描器版本或白名单指纹 (allowlist sha256)
变更 → 强制全量重扫. 命中时 findings 从缓存还原 (剥掉 file 字段按当前相对路径
回填, 同内容多文件不串路径).

用法: python skill_scan.py <dir> [--json] [--no-cache]
退出码: 0=干净 1=有 finding 2=目录不存在. 纯 stdlib / 零网络 / 不可变风格.
"""
from __future__ import annotations

import argparse
import ast
import hashlib
import json
import os
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SCANNER_VERSION = "2"  # v2: 缓存key带规则上下文+白名单指纹/混淆规则/新扩展名 (B1-B6)
CACHE_TTL_SECONDS = 30 * 24 * 3600  # 30 天过期才重扫 (出处: FT-9 spec)
SCAN_EXTS = {".py", ".md", ".sh", ".js", ".ts", ".ps1",
             ".cmd", ".bat", ".vbs", ".pyw", ".json"}
SKIP_DIRS = {".git", "__pycache__", "node_modules"}
FRONTMATTER_KEYS = ("name", "description")

HERE = Path(__file__).resolve().parent
DEFAULT_CACHE_PATH = HERE / "data" / ".skill_scan_cache.json"
ALLOWLIST_PATH = HERE / "skill_scan_allowlist.json"
DEFAULT_ALLOWLIST = (
    "github.com", "raw.githubusercontent.com", "api.github.com",
    "objects.githubusercontent.com", "pypi.org", "files.pythonhosted.org",
    "registry.npmjs.org", "skills.sh", "claude.ai", "anthropic.com",
)

# 禁模式 (全部 HIGH); 元组顺序即报告顺序, 保证确定性.
# 语义: curl-bash 已泛化为 curl/wget/fetch/aria2c 竖管进 sh 家族 (B5, 保持 rule id
# 以稳报告消费方); import-os 从字面 os 参数解锚为任意参数 (B5).
DANGER_RULES = (
    ("eval", re.compile(r"(?<![.\w])eval\s*\(")),  # B3: 排除 model.eval() 属性访问
    ("exec", re.compile(r"(?<![.\w])exec\s*\(")),  # B3: 排除 re.exec() 属性访问
    ("os.system", re.compile(r"os\.system\s*\(")),
    ("import-os", re.compile(r"__import__\s*\(")),
    ("curl-bash", re.compile(
        r"(?<![.\w])(?:curl|wget|fetch|aria2c)\b[^|\n]*\|[^|\n]*\b(?:ba|z|k|da|fi)?sh\b")),
    ("base64-pipe-sh", re.compile(
        r"(?<![.\w])base64\b[^|\n]*\|[^|\n]*\b(?:ba|z|k|da|fi)?sh\b")),
    ("rm-rf", re.compile(r"\brm\s+-[rf]{2}\b")),
    ("secret-sk", re.compile(r"\bsk-[A-Za-z0-9_-]{20,}")),
    ("secret-ghp", re.compile(r"ghp_[A-Za-z0-9]{30,}")),
    ("secret-xoxb", re.compile(r"\bxoxb-")),
    ("secret-akid", re.compile(r"\bAKID[A-Z0-9]{16,}")),
    ("private-key", re.compile(r"-----BEGIN[^\n]*PRIVATE KEY-----")),
    ("importlib", re.compile(r"(?<![.\w])importlib\.import_module\s*\(")),
    ("ps-encoded", re.compile(
        r"(?<![\w-])-enc(?:odedcommand)?\s+['\"]?[A-Za-z0-9+/=]{16,}",
        re.IGNORECASE)),
)
URL_RE = re.compile(r"https?://([A-Za-z0-9._~-]+(?::\d+)?)")  # B6: 正向字符集, host 不吞 CJK/全角标点
# B4: package.json 安装期钩子值里的危险信号 = 出站 URL 或管道/重定向/命令替换元字符
NPM_HOOK_KEYS = ("preinstall", "install", "postinstall", "prepare")
NPM_HOOK_DANGER_RE = re.compile(r"https?://|[|>`]|\$\(")
FRONTMATTER_LINE_RE = re.compile(r"^([A-Za-z0-9_-]+):\s*(.*)$")


def load_allowlist(path: Path | None = None) -> list[str]:
    """读白名单域名; 文件缺失/损坏时回退内置默认 (不可变: 返回新 list)."""
    p = Path(path) if path is not None else ALLOWLIST_PATH
    try:
        data = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return list(DEFAULT_ALLOWLIST)
    domains = data.get("domains") if isinstance(data, dict) else None
    if isinstance(domains, list) and all(isinstance(d, str) for d in domains):
        return sorted({d.strip().lower() for d in domains if d.strip()})
    return list(DEFAULT_ALLOWLIST)


def load_high_exemptions(path: Path | None = None) -> tuple[tuple[str, str, re.Pattern], ...]:
    """1008 增: HIGH 级人工裁决豁免表 (file+rule+anchor 三重锚定).

    语义: 命中行所在文件的 rel 以 file 结尾, 规则名全等, 且 anchor 正则在该
    文件全文命中 → 该 finding 压制. anchor 不匹配 (上游改代码移走锚) 即自动
    失效重新报警 — 豁免永不因「曾经裁决过」而永久沉默. 格式损坏=空表 (fail-closed).
    """
    p = Path(path) if path is not None else ALLOWLIST_PATH
    try:
        data = json.loads(p.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return ()
    raw = data.get("high_exemptions") if isinstance(data, dict) else None
    out: list[tuple[str, str, re.Pattern]] = []
    if isinstance(raw, list):
        for item in raw:
            if (isinstance(item, dict) and isinstance(item.get("file"), str)
                    and isinstance(item.get("rule"), str)
                    and isinstance(item.get("anchor"), str)):
                try:
                    out.append((item["file"], item["rule"],
                                re.compile(item["anchor"])))
                except re.error:
                    continue
    return tuple(out)


def _high_exempt(rel: str, rule: str, text: str,
                 exem: tuple[tuple[str, str, re.Pattern], ...]) -> bool:
    """该 HIGH finding 是否被三重锚定的豁免表压制."""
    return any(rel.endswith(f) and rule == r and a.search(text)
               for f, r, a in exem)


def _finding(sev: str, rule: str, rel: str, line: int | None,
             detail: str) -> dict:
    return {"severity": sev, "rule": rule, "file": rel, "line": line,
            "detail": detail[:120]}


def _rule_class(rel: str) -> str:
    """缓存 key 的规则上下文: 规则按 rel 分化 (frontmatter 只查 SKILL.md,
    ast 只查 .py, npm-hook 只查 package.json) → 同字节不同规则面不得共用缓存."""
    if rel == "SKILL.md":
        return "skillmd"
    if rel == "package.json" or rel.endswith("/package.json"):
        return "pkgjson"
    return Path(rel).suffix.lower() or "nosuffix"


def _cache_key(raw: bytes, rel: str) -> str:
    """B1: key = sha256(规则类字节 + NUL + 内容), 防跨规则串缓存 (fail-open)."""
    h = hashlib.sha256()
    h.update(_rule_class(rel).encode("utf-8"))
    h.update(b"\x00")
    h.update(raw)
    return h.hexdigest()


def _allowlist_hash(allow: tuple[str, ...]) -> str:
    """B2: 白名单指纹 — 名单一变缓存全失效, 不再按旧名单还原 domain findings."""
    payload = json.dumps(allow, sort_keys=True, ensure_ascii=False)
    return hashlib.sha256(payload.encode("utf-8")).hexdigest()


def _fingerprint(allow: tuple[str, ...],
                 exem: tuple[tuple[str, str, re.Pattern], ...]) -> str:
    """1008: 域名白名单 + HIGH 豁免表联合指纹 — 任一变动缓存全失效
    (豁免压制了 finding, 名单回滚时不得继续吃旧缓存的沉默)."""
    exem_raw = sorted((f, r, a.pattern) for f, r, a in exem)
    payload = json.dumps([sorted(allow), exem_raw], sort_keys=True,
                         ensure_ascii=False)
    return hashlib.sha256(payload.encode("utf-8")).hexdigest()


def _is_package_json(rel: str) -> bool:
    return rel == "package.json" or rel.endswith("/package.json")


def _npm_hook_gaps(text: str, rel: str) -> list[dict]:
    """B4: package.json 安装期钩子值含出站 URL 或管道/重定向/命令替换 → HIGH."""
    try:
        data = json.loads(text)
    except ValueError:
        return []
    scripts = data.get("scripts") if isinstance(data, dict) else None
    if not isinstance(scripts, dict):
        return []
    findings = []
    for key in NPM_HOOK_KEYS:
        value = scripts.get(key)
        if isinstance(value, str) and NPM_HOOK_DANGER_RE.search(value):
            findings.append(_finding("HIGH", "npm-hook", rel, None,
                                     f"scripts.{key}: {value}"))
    return findings


def _iter_files(root: Path) -> list[Path]:
    """递归收集待扫文本文件 (排序保证确定性; 跳过 .git/__pycache__/node_modules)."""
    out = []
    for p in root.rglob("*"):
        if not p.is_file() or p.suffix.lower() not in SCAN_EXTS:
            continue
        rel_parts = p.relative_to(root).parts
        if any(part in SKIP_DIRS for part in rel_parts[:-1]):
            continue
        out.append(p)
    return sorted(out, key=lambda p: p.relative_to(root).as_posix())


def _parse_frontmatter(text: str) -> dict:
    """极简 YAML 子集: 首段 --- 围栏内的顶层 key: value (纯 stdlib, 够用)."""
    if not text.startswith("---"):
        return {}
    fm: dict[str, str] = {}
    for line in text.splitlines()[1:]:
        if line.strip() == "---":
            break
        m = FRONTMATTER_LINE_RE.match(line)
        if m and m.group(1) not in fm:
            fm[m.group(1)] = m.group(2).strip().strip('"').strip("'")
    return fm


def _frontmatter_gaps(text: str) -> list[dict]:
    """SKILL.md 结构检查: name/description 存在且非空, 缺=HIGH."""
    fm = _parse_frontmatter(text)
    return [
        _finding("HIGH", "frontmatter", "SKILL.md", None,
                 f"{key} 缺失或为空")
        for key in FRONTMATTER_KEYS
        if not fm.get(key, "").strip()
    ]


def _syntax_gap(text: str, rel: str,
                exem: tuple[tuple[str, str, re.Pattern], ...] = ()) -> list[dict]:
    """.py 必须 ast.parse 通过 (语法错=HIGH, 三重锚定豁免可压制 —
    1008 实战: 宿主 3.11 语法面对 3.12+ 语法的伪报)."""
    try:
        ast.parse(text)
    except (SyntaxError, ValueError) as e:
        line = getattr(e, "lineno", None) or 1
        if _high_exempt(rel, "syntax", text, exem):
            return []
        return [_finding("HIGH", "syntax", rel, line, type(e).__name__)]
    return []


def _host_allowed(host: str, allow: tuple[str, ...]) -> bool:
    h = host.split(":")[0].rstrip(".").lower()  # 去端口/尾点
    return any(h == d or h.endswith("." + d) for d in allow)


def _scan_text(text: str, rel: str, allow: tuple[str, ...],
               exem: tuple[tuple[str, str, re.Pattern], ...] = ()) -> list[dict]:
    """禁模式逐行扫描 (HIGH, 三重锚定豁免可压制) + 出站域名 (白名单外=MEDIUM)."""
    findings = []
    for lineno, line in enumerate(text.splitlines(), 1):
        for rule, rx in DANGER_RULES:
            if rx.search(line) and not _high_exempt(rel, rule, text, exem):
                findings.append(_finding(
                    "HIGH", rule, rel, lineno, line.strip()))
    for host in dict.fromkeys(h.lower() for h in URL_RE.findall(text)):
        if not _host_allowed(host, allow):
            findings.append(_finding("MEDIUM", "domain", rel, None, host))
    return findings


def _scan_bytes(raw: bytes, rel: str, allow: tuple[str, ...],
                exem: tuple[tuple[str, str, re.Pattern], ...] = ()) -> list[dict]:
    """单文件全量扫描: frontmatter(仅 SKILL.md) + 语法(仅 .py)
    + npm-hook(仅 package.json) + 禁模式(豁免可压制) + 域名."""
    text = raw.decode("utf-8", errors="replace")
    findings: list[dict] = []
    if rel == "SKILL.md":
        findings.extend(_frontmatter_gaps(text))
    if rel.endswith(".py"):
        findings.extend(_syntax_gap(text, rel, exem))
    if _is_package_json(rel):
        findings.extend(_npm_hook_gaps(text, rel))
    findings.extend(_scan_text(text, rel, allow, exem))
    return findings


def _load_cache(cache_path: Path, allow_hash: str) -> dict:
    """载入缓存; 版本/白名单指纹不符或损坏 → 空 dict (强制全量重扫)."""
    try:
        data = json.loads(cache_path.read_text(encoding="utf-8"))
    except (OSError, ValueError):
        return {}
    if (not isinstance(data, dict)
            or data.get("_version") != SCANNER_VERSION
            or data.get("_allowlist_sha") != allow_hash):
        return {}
    entries = data.get("entries")
    return entries if isinstance(entries, dict) else {}


def _save_cache(cache_path: Path, entries: dict, allow_hash: str) -> None:
    """原子写缓存 (.tmp + os.replace); 只保留本次见到的文件 → 自动剪枝;
    顶层记录白名单指纹, 载入时不符即全量重扫."""
    payload = {"_version": SCANNER_VERSION, "_allowlist_sha": allow_hash,
               "entries": entries}
    cache_path.parent.mkdir(parents=True, exist_ok=True)
    tmp = cache_path.parent / (cache_path.name + ".tmp")
    tmp.write_text(json.dumps(payload, ensure_ascii=False), encoding="utf-8")
    os.replace(tmp, cache_path)


def scan_skill(skill_dir, *, cache_path=None, use_cache=True,
               allowlist_path=None) -> dict:
    """扫描一个技能目录 → {"skill", "findings", "files_scanned", "cache_hit"}.

    缓存 key=sha256(规则类+NUL+内容) (规则类按 rel 分化, 见 _cache_key);
    命中且未过 30 天 TTL → findings 从缓存还原.
    不修改任何传入参数, findings/findings 内 dict 均为新对象.
    """
    root = Path(skill_dir).resolve()
    if not root.is_dir():
        raise FileNotFoundError(f"目录不存在: {root}")
    cpath = Path(cache_path) if cache_path is not None else DEFAULT_CACHE_PATH
    allow = tuple(load_allowlist(allowlist_path))
    exem = load_high_exemptions(allowlist_path)
    allow_hash = _fingerprint(allow, exem)
    files = _iter_files(root)
    cache = _load_cache(cpath, allow_hash) if use_cache else {}
    now = time.time()
    findings: list[dict] = []
    entries: dict = {}
    hits = 0
    for path in files:
        rel = path.relative_to(root).as_posix()
        try:
            raw = path.read_bytes()
        except OSError as e:
            findings.append(_finding("HIGH", "unreadable", rel, None, str(e)))
            continue
        key = _cache_key(raw, rel)
        entry = cache.get(key) if use_cache else None
        fresh = (isinstance(entry, dict)
                 and now - float(entry.get("ts", 0)) <= CACHE_TTL_SECONDS)
        if fresh:
            stored = [f for f in entry.get("findings", [])
                      if isinstance(f, dict)]
            file_findings = [{**f, "file": rel} for f in stored]
            hits += 1
            entries[key] = entry  # 命中保留原 ts (30 天自原扫描起算)
        else:
            file_findings = _scan_bytes(raw, rel, allow, exem)
            entries[key] = {
                "ts": now,  # 存缓存剥掉 file, 还原时按当前 rel 回填
                "findings": [{k: v for k, v in f.items() if k != "file"}
                             for f in file_findings],
            }
        findings.extend(file_findings)
    if not (root / "SKILL.md").is_file():
        findings.append(_finding("HIGH", "frontmatter", "SKILL.md", None,
                                 "SKILL.md 缺失"))
    if use_cache:
        _save_cache(cpath, entries, allow_hash)
    return {
        "skill": root.name or str(root),
        "findings": findings,
        "files_scanned": len(files),
        "cache_hit": use_cache and bool(files) and hits == len(files),
    }


def _print_report(result: dict) -> None:
    """人类可读摘要 (技术细节进 detail, 面向入仓把关者)."""
    print(f"[skill_scan] skill={result['skill']} files="
          f"{result['files_scanned']} cache_hit={result['cache_hit']} "
          f"findings={len(result['findings'])}")
    for f in result["findings"]:
        line = f["line"] if f["line"] is not None else "-"
        print(f"  {f['severity']:<6} {f['rule']:<12} "
              f"{f['file']}:{line}  {f['detail']}")


def main(argv: list[str] | None = None) -> int:
    """CLI 入口: 0=干净 1=有 finding 2=目录不存在."""
    ap = argparse.ArgumentParser(
        description="FT-9 外部技能入仓扫描门 (禁模式/密钥/出站域名/语法)")
    ap.add_argument("dir", help="技能目录")
    ap.add_argument("--json", action="store_true", help="输出 JSON")
    ap.add_argument("--no-cache", action="store_true", help="跳过增量缓存")
    args = ap.parse_args(argv)
    if not Path(args.dir).is_dir():
        print(f"目录不存在: {args.dir}")
        return 2
    result = scan_skill(args.dir, use_cache=not args.no_cache)
    if args.json:
        print(json.dumps(result, ensure_ascii=False, indent=2))
    else:
        _print_report(result)
    return 0 if not result["findings"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
