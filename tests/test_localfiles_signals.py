"""P3 信号层：活跃目录/命名模式/TODO 抽取/画像生成。"""
import time

from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.indexer import Indexer
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.signals import SignalAnalyzer
from paistation.sense.localfiles.store import ChunkIndex


def _world(tmp_path):
    root = tmp_path / "u"
    (root / "活跃项目A").mkdir(parents=True)
    (root / "归档").mkdir(parents=True)
    domain = ScanDomain(includes=[str(root)], exclude_names=["node_modules"])
    inv = Inventory(tmp_path / "inv.db")
    chunks = ChunkIndex(tmp_path / "idx.db")
    ix = Indexer(domain, inv, chunks)
    recent = time.time()
    (root / "活跃项目A" / "方案v2.0最终版.md").write_text(
        "# 方案\n\n- [ ] 本周内回复甲方邮件\nTODO 补充预算表", encoding="utf-8")
    (root / "活跃项目A" / "note.md").write_text("近期内容", encoding="utf-8")
    for f in (("活跃项目A", "方案v2.0最终版.md"), ("活跃项目A", "note.md")):
        p = root.joinpath(*f)
        os.utime(p, (recent, recent)) if (os := __import__("os")) else None
    old = recent - 90 * 86400
    p = root / "归档" / "2023-01-15旧文档.md"
    p.write_text("老内容", encoding="utf-8")
    __import__("os").utime(p, (old, old))
    ix.full_cycle()
    return ix, inv, chunks


def test_active_dirs_and_patterns(tmp_path):
    ix, inv, chunks = _world(tmp_path)
    report = SignalAnalyzer(inv, chunks).analyze()
    tops = dict(report.active_dirs)
    assert any("活跃项目A" in d for d in tops)
    assert not any("归档" in d for d in tops)  # 90 天前不算活跃
    assert report.name_pattern_counts["versioned"] >= 1
    assert report.name_pattern_counts["final"] >= 1
    assert report.name_pattern_counts["dated"] >= 1
    ix.close()


def test_todo_extraction(tmp_path):
    ix, inv, chunks = _world(tmp_path)
    report = SignalAnalyzer(inv, chunks).analyze()
    texts = [t["text"] for t in report.todos]
    assert any("回复甲方" in t for t in texts)   # checkbox 语法
    assert any("补充预算" in t for t in texts)   # TODO: 语法


def test_profile_md_shape(tmp_path):
    ix, inv, chunks = _world(tmp_path)
    md = SignalAnalyzer(inv, chunks).analyze().to_profile_md()
    assert md.startswith("# LOCAL_FILES_PROFILE")
    assert "活跃目录" in md and "待办线索" in md
    assert "回复甲方" in md
    ix.close()
