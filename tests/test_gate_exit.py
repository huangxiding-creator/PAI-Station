"""Phase B1 出口闸：确定性 done token（evidence over narrative）。

无人值守任务 100% 收口=每个任务结束必产一条 ExitToken 进 exits.jsonl；
done 与否机器可查（test 全绿+ruff+evidence 存在），不靠自述。
"""
import json

import pytest

from paistation.gate.exit import ExitToken, last_token, read_exits, validate_token, write_exit_token


@pytest.fixture()
def env(tmp_path):
    data_dir = tmp_path / "data"
    data_dir.mkdir()
    ini = tmp_path / "pai.ini"
    ini.write_text(f"[privacy]\ndata_dir = {data_dir}\n"
                   f"[sense]\nwatch_dirs = {data_dir}\n", encoding="utf-8")
    return tmp_path, data_dir, str(ini)


def _token(**kw):
    base = dict(task_id="T-001", ts="2026-09-13T21:00:00", status="done",
                evidence=[], commit="abc1234",
                tests_total=938, tests_failed=0, ruff_ok=True, note="")
    base.update(kw)
    return ExitToken(**base)


def test_write_then_read_roundtrip(tmp_path):
    write_exit_token(tmp_path, _token())
    rows = read_exits(tmp_path)
    assert len(rows) == 1
    assert rows[0]["task_id"] == "T-001"
    assert rows[0]["done"] is True


def test_append_only_multiple_tokens(tmp_path):
    write_exit_token(tmp_path, _token())
    write_exit_token(tmp_path, _token(task_id="T-002", status="failed",
                                      tests_failed=3))
    rows = read_exits(tmp_path)
    assert [r["task_id"] for r in rows] == ["T-001", "T-002"]  # 只增不删


def test_done_requires_all_green():
    ok = validate_token(_token())
    assert ok["done"] is True and ok["reasons"] == []


def test_not_done_when_tests_failed():
    r = validate_token(_token(tests_failed=2))
    assert r["done"] is False and any("tests_failed" in x for x in r["reasons"])


def test_not_done_when_ruff_dirty():
    r = validate_token(_token(ruff_ok=False))
    assert r["done"] is False and any("ruff" in x for x in r["reasons"])


def test_not_done_when_status_running():
    r = validate_token(_token(status="running"))
    assert r["done"] is False


def test_evidence_existence_checked(tmp_path):
    (tmp_path / "report.md").write_text("x", encoding="utf-8")
    good = validate_token(_token(), root=tmp_path)
    assert good["done"] is True
    bad = validate_token(_token(evidence=["missing.md"]), root=tmp_path)
    assert bad["done"] is False
    assert any("missing.md" in x for x in bad["reasons"])


def test_last_token_filters_by_task(tmp_path):
    write_exit_token(tmp_path, _token())
    write_exit_token(tmp_path, _token(task_id="T-002"))
    last = last_token(tmp_path, task_id="T-001")
    assert last["task_id"] == "T-001"
    assert last_token(tmp_path)["task_id"] == "T-002"


def test_write_sets_done_from_validation(tmp_path):
    """落盘即裁决：写入口自动按 validate 结果填 done，防手填绿。"""
    (tmp_path / "report.md").write_text("x", encoding="utf-8")
    write_exit_token(tmp_path, _token(tests_failed=1), root=tmp_path)
    assert read_exits(tmp_path)[0]["done"] is False


def test_jsonl_ascii_immune_gbk(tmp_path):
    write_exit_token(tmp_path, _token(note="中文备注"))
    raw = (tmp_path / "gate" / "exits.jsonl").read_text(encoding="ascii")
    assert json.loads(raw.splitlines()[0])["note"] == "中文备注"


def test_cli_exit_action(env):  # noqa: F811 —— 复用 test_sovereign_cli 夹具
    """`paistation --sovereign exit`：全绿收口 exit 0；带失败 exit 1。"""
    from paistation.main import main

    tmp, data_dir, ini = env
    rc = main(["--config", ini, "--sovereign", "exit", "--target", "B1-任务",
               "--status", "done", "--tests-total", "938", "--tests-failed", "0",
               "--ruff-ok", "1"])
    assert rc == 0
    assert read_exits(data_dir)[0]["done"] is True
    rc2 = main(["--config", ini, "--sovereign", "exit", "--target", "B1-任务2",
                "--status", "done", "--tests-total", "10", "--tests-failed", "2"])
    assert rc2 == 1
    assert read_exits(data_dir)[1]["done"] is False
