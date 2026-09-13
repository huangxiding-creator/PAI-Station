"""M6.4 技能锻造（FR16/R15/ADR-10）：案例层→信号→提案→升格→版本化→回滚。

技能库本体=git 仓库：升格=commit+tag（v1/v2/…），回滚=checkout 旧 tag
（FR10b：批准≠终点，效果差就一键回退）。升格闸在代码里：promote()
不带 approved=True 直接 PermissionError——R15 进化提案永不自批，
上岗必须走晨报一键确认，不靠提示自觉。
"""
from __future__ import annotations

import json
import re
import subprocess
from datetime import datetime
from pathlib import Path

# ---- 案例层 ----

class CaseLog:
    """执行案例流水（jsonl 只增不删）。"""

    def __init__(self, data_dir: str | Path):
        self._path = Path(data_dir) / "cases.jsonl"

    def append(self, case: dict) -> None:
        self._path.parent.mkdir(parents=True, exist_ok=True)
        with self._path.open("a", encoding="utf-8") as fh:
            fh.write(json.dumps(case, ensure_ascii=False) + "\n")

    def recent(self, limit: int = 100) -> list[dict]:
        if not self._path.is_file():
            return []
        lines = self._path.read_text(
            encoding="utf-8").splitlines()
        return [json.loads(ln) for ln in lines[-limit:] if ln.strip()]


# ---- 技能库 git 版本化 ----

class SkillRepo:
    """git 仓库薄封装：init/commit/tag/rollback。git 缺席则明错。"""

    def __init__(self, repo_dir: str | Path):
        self._dir = Path(repo_dir)

    def _git(self, *args: str) -> str:
        proc = subprocess.run(
            ["git", "-C", str(self._dir), *args],
            capture_output=True, text=True, encoding="utf-8", errors="replace")
        if proc.returncode != 0:
            raise RuntimeError(
                f"git {' '.join(args)} 失败：{proc.stderr.strip()[:200]}")
        return proc.stdout

    def ensure(self) -> None:
        self._dir.mkdir(parents=True, exist_ok=True)
        if not (self._dir / ".git").is_dir():
            self._git("init", "-q")
            self._git("config", "user.name", "PAI-Station")
            self._git("config", "user.email", "pai@local")

    def commit_and_tag(self, name: str, message: str) -> str:
        version = len(self.tags(name)) + 1
        tag = f"{name}/v{version}"
        self._git("add", "-A")
        if not self._has_changes():
            return self.tags(name)[-1] if self.tags(name) else tag
        self._git("commit", "-q", "-m", message)
        self._git("tag", tag)
        return tag

    def _has_changes(self) -> bool:
        out = self._git("status", "--porcelain")
        return bool(out.strip())

    def tags(self, name: str) -> list[str]:
        try:
            out = self._git("tag", "--list", f"{name}/v*")
        except RuntimeError:
            return []
        versions = sorted(
            int(t.rsplit("/v", 1)[1]) for t in out.split()
             if t.startswith(f"{name}/v") and t.rsplit("/v", 1)[1].isdigit())
        return [f"{name}/v{v}" for v in versions]

    def rollback(self, name: str, tag: str) -> None:
        """checkout 旧 tag 的该技能目录并提交（回滚也是历史，可再溯）。"""
        self._git("checkout", tag, "--", name)
        self._git("commit", "-q", "-m", f"rollback: {name} -> {tag}")


# ---- 信号与提案 ----

def _bigrams(text: str) -> set[str]:
    return {text[i:i + 2] for i in range(len(text) - 1)} or {text}


def _similar(a: str, b: str, threshold: float = 0.30) -> bool:
    ga, gb = _bigrams(a), _bigrams(b)
    if not ga or not gb:
        return False
    return len(ga & gb) / len(ga | gb) >= threshold


def _norm_title(title: str) -> str:
    return re.sub(r"[\d\s。，、！？]", "", title)


class SkillForge:
    """record_case→signals→propose→promote（升格闸）。"""

    def __init__(self, data_dir: str | Path, repo_dir: str | Path):
        self._log = CaseLog(data_dir)
        self.repo = SkillRepo(repo_dir)

    def record_case(self, case: dict) -> None:
        self._log.append(case)

    def signals(self) -> list[dict]:
        cases = self._log.recent()
        return self._repetition(cases) + self._fail_to_success(cases)

    def _repetition(self, cases: list[dict]) -> list[dict]:
        clusters: list[list[dict]] = []
        for c in cases:
            for cl in clusters:
                if _similar(_norm_title(c.get("task_title", "")),
                            _norm_title(cl[0].get("task_title", ""))):
                    cl.append(c)
                    break
            else:
                clusters.append([c])
        out = []
        for cl in clusters:
            if len(cl) >= 3:
                title = max((c.get("task_title", "") for c in cl), key=len)
                out.append({"kind": "repetition", "title": title,
                            "count": len(cl), "cases": cl})
        return out

    def _fail_to_success(self, cases: list[dict]) -> list[dict]:
        groups: dict[str, list[dict]] = {}
        for c in cases:
            groups.setdefault(_norm_title(c.get("task_title", "")), []).append(c)
        out = []
        for title, group in groups.items():
            failed = any(c.get("outcome") == "failure" for c in group)
            succeeded_later = any(
                c.get("outcome") == "success"
                and c.get("ts", "") > next(
                    (f.get("ts", "") for f in group
                     if f.get("outcome") == "failure"), "")
                for c in group)
            if failed and succeeded_later:
                out.append({"kind": "failure_to_success",
                            "title": group[0].get("task_title", title),
                            "count": len(group), "cases": group})
        return out

    def propose(self) -> list[dict]:
        candidates = []
        for s in self.signals():
            core = _norm_title(s["title"])[:20] or "未命名技能"
            evidence = [f"- {c.get('ts', '')} {c.get('task_title', '')}"
                        f"（{c.get('outcome', '?')}）"
                        for c in s["cases"][:10]]
            draft = (
                "---\n"
                f"name: {core}\n"
                f"description: {s['title']}类任务的自动沉淀技能\n"
                "version: 0.1.0\n"
                "source: skill-forge（SKILL.md 兼容格式）\n"
                "---\n\n"
                f"# {core}\n\n"
                f"> 来源：{s['kind']} 信号（{s['count']} 次案例）。\n"
                f"> 激活方式：晨报一键确认（永不自批）。\n\n"
                f"## 适用场景\n用户反复执行「{s['title']}」类任务。\n\n"
                f"## 建议流程\n1. 复用历史成功路径\n"
                f"2. 检索相关记忆注入\n3. 产出后对比历史成果\n\n"
                f"## 证据\n" + "\n".join(evidence) + "\n")
            candidates.append({"name": core, "title": s["title"],
                               "kind": s["kind"], "draft": draft,
                               "evidence": evidence, "approved": False})
        return candidates

    def promote(self, candidate: dict, approved: bool = False) -> str:
        if not approved:
            raise PermissionError(
                "升格闸：技能提案未经用户批准（R15 永不自批），"
                "须走晨报一键确认后携带 approved=True 再来")
        self.repo.ensure()
        skill_dir = self._dir_of(candidate["name"])
        skill_dir.mkdir(parents=True, exist_ok=True)
        (skill_dir / "SKILL.md").write_text(
            candidate["draft"], encoding="utf-8")
        now = datetime.now().strftime("%Y-%m-%d %H:%M")
        return self.repo.commit_and_tag(
            candidate["name"],
            f"promote: {candidate['name']}（{candidate['kind']}，"
            f"{len(candidate.get('evidence', []))} 条证据，{now}）")

    def _dir_of(self, name: str) -> Path:
        bad = re.sub(r"[<>:\"/\\|?*]", "", name).strip() or "skill"
        return self.repo._dir / bad
