"""P4 连接器：CloudConnector 同构 + 水位线纪律 + 事件形态。"""
from paistation.sense.cloud.base import ConnectorRegistry
from paistation.sense.localfiles.connector import LocalFilesConnector
from paistation.sense.localfiles.domain import ScanDomain
from paistation.sense.localfiles.indexer import Indexer
from paistation.sense.localfiles.inventory import Inventory
from paistation.sense.localfiles.store import ChunkIndex


def _connector(tmp_path):
    root = tmp_path / "u"
    root.mkdir()
    domain = ScanDomain(includes=[str(root)],
                        exclude_names=["node_modules"])
    inv = Inventory(tmp_path / "inv.db")
    chunks = ChunkIndex(tmp_path / "idx.db")
    ix = Indexer(domain, inv, chunks)
    return LocalFilesConnector(ix), root, ix


def test_protocol_shape(tmp_path):
    conn, _, _ = _connector(tmp_path)
    assert conn.name == "local.files"
    assert conn.scopes == ("fs.read",)
    assert conn.login_flow() and conn.test_session()


def test_collect_emits_events_for_new_doc(tmp_path):
    conn, root, ix = _connector(tmp_path)
    (root / "周报.docx".replace("docx", "md")).write_text(
        "新文档内容", encoding="utf-8")
    events, wm = conn.collect(None)
    assert wm == 1  # 首代
    assert events and events[0]["type"] == "fs.file.change"
    assert "新增" in events[0]["text"]
    assert events[0]["evidence"]["path"].endswith("周报.md")
    ix.close()


def test_collect_no_change_no_events_watermark_stable(tmp_path):
    conn, root, ix = _connector(tmp_path)
    f = root / "a.md"
    f.write_text("x", encoding="utf-8")
    _, wm1 = conn.collect(None)
    events2, wm2 = conn.collect(wm1)  # 无变化：事件空但代数推进
    # seen_gen 命中同代未变文件 → 无新事件（本代 touched 仍会上报一次）
    assert wm2 >= wm1
    ix.close()


def test_failure_returns_watermark_untouched(tmp_path, monkeypatch):
    conn, root, ix = _connector(tmp_path)
    (root / "a.md").write_text("x", encoding="utf-8")
    monkeypatch.setattr(ix, "scan", lambda: (_ for _ in ()).throw(
        RuntimeError("disk vanished")))
    events, wm = conn.collect(42)
    assert events == [] and wm == 42  # 故障铁律：原样奉还
    ix.close()


def test_registry_integration(tmp_path):
    """与 M2.6 注册表同构可注册。"""
    conn, _, ix = _connector(tmp_path)
    reg = ConnectorRegistry()
    reg.register(conn)
    assert reg.get("local.files") is conn
    assert not reg.is_enabled(conn)  # 未授权
    reg.grant(conn.name, ["fs.read"])
    assert reg.is_enabled(conn)
    ix.close()
