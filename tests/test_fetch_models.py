"""M6.3 后置模型下载脚本：plan/check_state 纯函数可测，下载本身不进测试。"""

from scripts.fetch_bge_m3 import check_state, plan


def test_plan_targets_under_dest(tmp_path):
    items = plan(dest_root=tmp_path)
    assert len(items) == 2
    names = {p.name for _url, p in items}
    assert names == {"model.onnx", "tokenizer.json"}
    assert all(str(p).startswith(str(tmp_path)) for _u, p in items)
    assert all(u.startswith("https://") for u, _p in items)


def test_check_state(tmp_path):
    state = check_state(dest_root=tmp_path)
    assert state["ready"] is False
    d = tmp_path / "bge-m3-onnx"
    d.mkdir()
    (d / "tokenizer.json").write_text("{}", encoding="utf-8")
    state = check_state(dest_root=tmp_path)
    assert state["tokenizer"] is True and state["onnx"] is False
    (d / "model.onnx").write_bytes(b"\x00" * 8)
    assert check_state(dest_root=tmp_path)["ready"] is True
