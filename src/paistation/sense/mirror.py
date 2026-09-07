"""首扫镜像（提案 T23 零输入上帝时刻）：只读扫描 → 10 条镜像陈述。

双约束：真度（每条带可核对 evidence）+ 非显然度（有洞察而非罗列）。
deep 模型措辞增强；模型不可用/输出劣化时规则模板补足，永不空手而归。
感知红线：os.walk 只读，不写任何被扫文件。
"""
import fnmatch
import json
import logging
import os
import time

_log = logging.getLogger("paistation.sense.mirror")

_SUFFIXES = {".md", ".txt", ".py", ".ini", ".toml", ".yaml", ".yml", ".json", ".csv"}


class MirrorScanner:
    """白名单目录只读首扫 → 快照 → 10 条镜像陈述。"""

    def __init__(self, watch_dirs, deep_fn=None, ignore_patterns=None,
                 suffixes=None, max_per_dir=200):
        self._dirs = [os.path.expanduser(d) for d in watch_dirs]
        self._deep = deep_fn
        self._ignore = list(ignore_patterns or [".git", "node_modules"])
        self._suffixes = suffixes or _SUFFIXES
        self._max_per_dir = max_per_dir

    # ---------- 扫描（纯只读） ----------

    def _accept(self, path: str) -> bool:
        norm = path.replace("\\", "/").lower()
        for pattern in self._ignore:
            if fnmatch.fnmatch(norm, f"*{pattern.lower()}*"):
                return False
        return os.path.splitext(norm)[1] in self._suffixes

    def scan(self) -> dict:
        files: list[dict] = []
        now = time.time()
        for root in self._dirs:
            if not os.path.isdir(root):
                continue
            taken = 0
            for dirpath, dirnames, filenames in os.walk(root):
                dirnames[:] = [d for d in sorted(dirnames)
                               if not self._hit_ignore(os.path.join(dirpath, d))]
                for name in sorted(filenames):
                    full = os.path.join(dirpath, name)
                    if taken >= self._max_per_dir or not self._accept(full):
                        continue
                    try:
                        st = os.stat(full)
                    except OSError:
                        continue
                    files.append({"path": full.replace("\\", "/"),
                                  "size": st.st_size,
                                  "mtime": st.st_mtime,
                                  "age_days": max(0.0, (now - st.st_mtime) / 86400)})
                    taken += 1
        return self._snapshot(files)

    def _hit_ignore(self, path: str) -> bool:
        norm = path.replace("\\", "/").lower()
        return any(fnmatch.fnmatch(norm, f"*{p.lower()}*") for p in self._ignore)

    @staticmethod
    def _snapshot(files: list) -> dict:
        by_suffix: dict[str, int] = {}
        by_dir: dict[str, int] = {}
        total_size = 0
        for f in files:
            suffix = os.path.splitext(f["path"])[1].lower() or "(无)"
            by_suffix[suffix] = by_suffix.get(suffix, 0) + 1
            d = f["path"].rsplit("/", 1)[0]
            by_dir[d] = by_dir.get(d, 0) + 1
            total_size += f["size"]
        recent = sorted(files, key=lambda f: -f["mtime"])[:20]
        largest = sorted(files, key=lambda f: -f["size"])[:10]
        fresh = [f for f in files if f["age_days"] <= 7]
        return {"files": len(files), "bytes": total_size,
                "by_suffix": by_suffix, "by_dir": by_dir,
                "recent": [f["path"] for f in recent],
                "largest": [f["path"] for f in largest],
                "fresh_7d": len(fresh),
                "fresh_paths": [f["path"] for f in fresh[:10]]}

    # ---------- 报告 ----------

    def report(self, n: int = 10) -> dict:
        snap = self.scan()
        statements = self._deep_statements(snap, n) or self._rule_statements(snap, n)
        return {"statements": statements[:n],
                "meta": {"files": snap["files"],
                         "dirs": len(snap["by_dir"]),
                         "generated_at": time.time()}}

    def _deep_statements(self, snap: dict, n: int) -> list:
        if self._deep is None:
            return []
        prompt = (
            "以下是我电脑工作目录的首扫快照（JSON）。请产出"
            f"{n}条关于这位用户的'镜像陈述'——每条必须同时满足："
            "①真度：只依据快照事实，附 evidence（引用具体路径或数字）；"
            "②非显然度：给出洞察而非罗列（如工作重心、知识结构、近期焦点变化）。"
            "只输出 JSON 数组：[{\"text\": \"...\", \"evidence\": \"...\"}]。\n"
            f"快照：{json.dumps(snap, ensure_ascii=False)}")
        try:
            raw = self._deep(prompt, reasoning=True)["text"]
            data = json.loads(raw)
            if isinstance(data, list):
                sts = [{"text": str(d.get("text", "")).strip(),
                        "evidence": str(d.get("evidence", "")).strip()}
                       for d in data if isinstance(d, dict)]
                sts = [s for s in sts if s["text"] and s["evidence"]]
                if len(sts) >= max(4, n // 2):  # 至少半数可用才采信
                    _log.info("镜像陈述由 deep 模型生成 %d 条", len(sts))
                    return sts
        except Exception as exc:
            _log.warning("deep 镜像生成失败，规则补足: %s", exc)
        return []

    def _rule_statements(self, snap: dict, n: int) -> list:
        out: list[dict] = []
        by_dir = sorted(snap["by_dir"].items(), key=lambda kv: -kv[1])
        by_suffix = sorted(snap["by_suffix"].items(), key=lambda kv: -kv[1])
        fresh_ratio = (snap["fresh_7d"] / snap["files"]) if snap["files"] else 0

        def add(text: str, evidence: str):
            out.append({"text": text, "evidence": evidence})

        if by_dir:
            top_d, top_c = by_dir[0]
            share = top_c / snap["files"]
            add(f"你的文件最集中的目录是 {top_d.rsplit('/', 1)[-1]}，"
                f"占已索引文件的 {share:.0%}——这是当前的主战场。",
                f"{top_d}（{top_c} 个文件）")
        if by_suffix:
            names = "、".join(f"{s}（{c}）" for s, c in by_suffix[:3])
            add(f"你的知识载体以 {by_suffix[0][0]} 为主，文件类型分布反映工作性质："
                f"{names}。", json.dumps(dict(by_suffix[:5]), ensure_ascii=False))
        add(f"近 7 天有 {snap['fresh_7d']} 个文件被修改"
            f"（占比 {fresh_ratio:.0%}），近期活跃度"
            f"{'高' if fresh_ratio > 0.3 else '中等' if fresh_ratio > 0.1 else '低'}。",
            f"fresh_7d={snap['fresh_7d']}/{snap['files']}")
        if len(by_dir) >= 2:
            second_d, second_c = by_dir[1]
            add(f"第二活跃目录是 {second_d.rsplit('/', 1)[-1]}"
                f"（{second_c} 个文件），主战场之外还有一条稳定支线。",
                second_d)
        if snap["recent"]:
            newest = snap["recent"][0]
            add(f"你最近触碰的文件是 {os.path.basename(newest)}，"
                "最后一次编辑的对象往往指向当前最挂心的事。",
                newest)
        if snap["largest"]:
            biggest = snap["largest"][0]
            add(f"体量最大的文件是 {os.path.basename(biggest)}，"
                "长文件通常是长期沉淀而非随手草稿。",
                biggest)
        if len(snap["recent"]) >= 5:
            exts = {os.path.splitext(p)[1] for p in snap["recent"][:5]}
            add(f"最近 5 个活跃文件覆盖 {len(exts)} 种类型（{('、'.join(sorted(exts)))}），"
                "近期工作在多类型文件间切换。" if len(exts) > 1 else
                "近期工作高度聚焦于单一类型文件。",
                "、".join(snap["recent"][:5]))
        add(f"已索引总规模 {snap['files']} 个文件、"
            f"{snap['bytes'] / 1024:.0f} KB 文本量，这是记忆库的初始底座。",
            f"files={snap['files']} bytes={snap['bytes']}")
        if snap["fresh_paths"]:
            add("近 7 天新/改文件清单已入索引，下一次首扫将对比出焦点迁移轨迹。",
                "、".join(snap["fresh_paths"][:3]))
        # 不足 n 条时的安全垫（不空洞：引用扫描范围）
        i = 1
        while len(out) < n:
            add(f"本次扫描覆盖 {len(self._dirs)} 个白名单目录"
                f"（第 {i} 条基线陈述：目录集合与规模见 evidence）。",
                "、".join(d.replace("\\", "/") for d in self._dirs))
            i += 1
        _log.info("镜像陈述由规则模板生成 %d 条", len(out))
        return out
