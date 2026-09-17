# -*- coding: utf-8 -*-
"""Git 全库本人 commit 聚合（2026-09-17，演化维补全）。

对旧版（cx_ingest.py --sources git，19 仓不过滤作者）的两大修正：
1. 扫描面：E:/D:/ 深度 3 → +C:/Users/91216 深度 5（19 仓 → 100+ 仓）
2. 纯度：按主人 git 身份过滤（六变体成对匹配）——克隆仓（yt-dlp 等
   5.2 万条别人 commit）不入轴；同 sha 跨拷贝去重（We-AIPO-19x 副本）。

重灌语义：source='git' 先清后插（TimelineStore 本身只增不删，此处是
全量重建源，DELETE 显式声明）。重跑零重复、可回滚（旧数据可由
cx_ingest.py 旧路径重建）。

实测（2026-09-17）：104 仓 → 本人 2,199 commits（2026-03-02 起步，
此前"2025 前历史缺口"不存在——本人 git 史起点即 2026-03）。
"""
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent / "src"))

from paistation.cx.events import EventEnvelope  # noqa: E402
from paistation.cx.ingest_sources import _parse_dt, find_git_repos  # noqa: E402
from paistation.cx.timeline import TimelineStore  # noqa: E402

ROOT = Path(r"E:\AI-Station")
DB = ROOT / "data" / "cx" / "timeline.db"
NO_WINDOW = 0x08000000
ROOTS = ["E:/", "D:/", "C:/Users/91216"]
DEPTH = 5

# 主人 git 身份锚点（owner.json identifiers + GitHub 网页端变体，成对匹配）
_NAME_KEYS = ("zongbaoj", "总包君", "huangxiding", "黄细丁")
_EMAIL_KEYS = ("huangxiding", "91851817")  # 拼音邮箱/QQ 邮箱（不可能撞他人）


def _is_owner(email: str, name: str) -> bool:
    blob_e = (email or "").lower()
    blob_n = (name or "").lower()
    return (any(k in blob_e for k in _EMAIL_KEYS)
            or any(k in blob_n for k in _NAME_KEYS))


def collect_owner_commits(repos: list[str]) -> list[EventEnvelope]:
    """全库 git log → 主人过滤 → 全局 sha 去重 → 事件封套。"""
    seen_sha: set[str] = set()
    events: list[EventEnvelope] = []
    for repo in repos:
        try:
            r = subprocess.run(
                ["git", "-c", "safe.directory=*", "-C", repo, "log", "--all",
                 "--date=iso-strict",
                 "--pretty=format:%H%x1f%ae%x1f%an%x1f%ad%x1f%s"],
                capture_output=True, text=True, encoding="utf-8",
                errors="replace", creationflags=NO_WINDOW, timeout=90)
        except subprocess.TimeoutExpired:
            continue
        if r.returncode != 0:
            continue
        name = Path(repo).name
        for line in (r.stdout or "").splitlines():
            p = line.split("\x1f")
            if len(p) != 5 or not _is_owner(p[1], p[2]):
                continue
            sha, ad, subject = p[0], p[3], p[4]
            when = _parse_dt(ad)
            if when is None:
                continue
            if sha in seen_sha:  # 跨拷贝同 commit（We-AIPO-19x 等）
                continue
            seen_sha.add(sha)
            events.append(
                EventEnvelope(
                    source="git",
                    source_id=f"{name}/{sha}",
                    start=when,
                    type="work.commit",
                    payload={"repo": name, "subject": subject[:200]},
                ))
    return events


def main() -> int:
    repos = find_git_repos(ROOTS, max_depth=DEPTH)
    events = collect_owner_commits(repos)
    store = TimelineStore(DB)
    store._conn.execute("DELETE FROM events WHERE source='git'")
    store._conn.commit()
    inserted, _ = store.ingest(events)
    months: dict[str, int] = {}
    for e in events:
        key = e.start.strftime("%Y-%m") if hasattr(e.start, "strftime") else str(e.start)[:7]
        months[key] = months.get(key, 0) + 1
    print(f"[git-all] {len(repos)} 仓扫描 → 主人 {len(events)} commits，"
          f"重灌 {inserted} 条（旧 git 源已清）")
    print("[git-all] 月度:", dict(sorted(months.items())))
    print(f"[git-all] 起点 {min(months) if months else '—'} → {max(months) if months else '—'}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
