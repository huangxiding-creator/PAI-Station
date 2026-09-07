"""M1.3 首扫镜像（T23 零输入上帝时刻）：只读扫描 → 10 条真度+非显然度陈述。"""
import json

from paistation.sense.mirror import MirrorScanner


class FakeDeep:
    def __init__(self, statements=None, fail=False):
        self._statements = statements
        self._fail = fail
        self.prompts: list[str] = []

    def __call__(self, prompt, reasoning=True):
        self.prompts.append(prompt)
        if self._fail:
            raise RuntimeError("模型不可用")
        return {"text": json.dumps(
            [{"text": s["text"], "evidence": s["evidence"]} for s in self._statements],
            ensure_ascii=False)}


def seed(tmp_path):
    """造一个小型工作目录：3 篇笔记 + 1 个脚本 + 噪音。"""
    docs = tmp_path / "docs"
    docs.mkdir()
    for _i, name in enumerate(("周报.md", "复盘.md", "风险清单.md")):
        (docs / name).write_text(f"{name} 内容 " * 20, encoding="utf-8")
    code = tmp_path / "code"
    code.mkdir()
    (code / "tool.py").write_text("print('hi')\n" * 50, encoding="utf-8")
    (tmp_path / ".git").mkdir(exist_ok=True)
    (tmp_path / ".git" / "config.md").write_text("noise", encoding="utf-8")
    (tmp_path / "junk.tmp").write_text("tmp", encoding="utf-8")
    return str(docs / "周报.md"), str(code / "tool.py")


def make_scanner(tmp_path, deep=None):
    return MirrorScanner(watch_dirs=[str(tmp_path)], deep_fn=deep,
                         ignore_patterns=[".git", "*.tmp", "~$*"])


def test_scan_counts_and_filters(tmp_path):
    seed(tmp_path)
    m = make_scanner(tmp_path)
    snap = m.scan()
    assert snap["files"] == 4                     # 3 md + 1 py；.git/tmp 被滤
    assert snap["by_suffix"][".md"] == 3
    assert all(".git" not in p for p in snap["recent"])


def test_scan_readonly(tmp_path):
    before = sorted(str(p) for p in tmp_path.rglob("*"))
    seed(tmp_path)
    m = make_scanner(tmp_path)
    m.scan()
    after = sorted(str(p) for p in tmp_path.rglob("*"))
    assert len(after) == len(before) + 9          # 2目录+6文件+1噪音(.git/与tmp均计入rglob)


def test_report_rule_fallback_ten_statements(tmp_path):
    seed(tmp_path)
    m = make_scanner(tmp_path, deep=FakeDeep(fail=True))
    rep = m.report()
    sts = rep["statements"]
    assert len(sts) == 10
    for s in sts:
        assert s["text"].strip() and s["evidence"].strip()
        assert len(s["text"]) >= 8                # 非显然度：不是两字废话


def test_report_rule_statements_grounded(tmp_path):
    seed(tmp_path)
    m = make_scanner(tmp_path, deep=FakeDeep(fail=True))
    rep = m.report()
    snap = m.scan()
    known = [p.lower() for p in snap["recent"]] + [d.lower() for d in snap["by_dir"]]
    for s in rep["statements"]:
        ev = s["evidence"].lower().replace("（", " ").replace("）", " ")
        for tok in ev.split():
            if ":/" in tok:  # 路径样 token：必须是扫描见过的真路径/真目录前缀
                assert any(tok.startswith(k) or k.startswith(tok) for k in known), tok


def test_report_uses_deep_model(tmp_path):
    seed(tmp_path)
    deep = FakeDeep(statements=[
        {"text": f"陈述{i}：你的工作重心在 docs 目录", "evidence": f"docs/{i}.md"}
        for i in range(10)])
    m = make_scanner(tmp_path, deep=deep)
    rep = m.report()
    assert rep["statements"][0]["text"].startswith("陈述0")
    assert len(deep.prompts) == 1                 # 一次深度调用，不过度挥霍
    assert "docs/0.md" not in deep.prompts[0]     # prompt 不含预置答案
    assert "快照" in deep.prompts[0]               # 带的是扫描事实


def test_report_deep_bad_output_falls_back(tmp_path):
    seed(tmp_path)
    deep = FakeDeep(statements=[])
    deep.__call__ = lambda *a, **k: {"text": "坏的输出"}
    m = make_scanner(tmp_path, deep=deep)
    rep = m.report()
    assert len(rep["statements"]) == 10           # 降级规则补足


def test_report_meta_has_snapshot(tmp_path):
    seed(tmp_path)
    m = make_scanner(tmp_path)
    rep = m.report()
    assert rep["meta"]["files"] == 4
    assert rep["meta"]["dirs"] >= 2
