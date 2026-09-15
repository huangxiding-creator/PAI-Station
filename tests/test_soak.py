"""M8 无人值守浸泡跑：循环→日志→断点续跑→异常不杀→随时可停。"""
import json

from paistation.ops.soak import SoakRunner, soak_report


def _run(path, cycles, step, **kw):
    return SoakRunner(cycles=cycles, step_fn=step, journal_path=path,
                      sleep_fn=lambda s: None, **kw).run()


def test_runs_all_cycles_and_journals(tmp_path):
    j = tmp_path / "j.jsonl"
    seen = []
    rep = _run(j, 3, lambda i: (seen.append(i), f"第{i}轮")[1])
    assert seen == [0, 1, 2]
    lines = [json.loads(x) for x in
             j.read_text(encoding="utf-8").splitlines()]
    assert len(lines) == 3
    assert lines[0]["status"] == "ok"
    assert lines[0]["detail"] == "第0轮"
    assert rep["done"] == 3 and rep["errors"] == 0


def test_step_exception_does_not_kill(tmp_path):
    j = tmp_path / "j.jsonl"

    def step(i):
        if i == 1:
            raise RuntimeError("某轮炸了")
        return "ok"

    rep = _run(j, 3, step)
    assert rep["done"] == 3 and rep["errors"] == 1   # 炸一轮不停跑
    lines = [json.loads(x) for x in
             j.read_text(encoding="utf-8").splitlines()]
    assert lines[1]["status"] == "error"
    assert "某轮炸了" in lines[1]["detail"]


def test_resume_from_journal(tmp_path):
    """断点续跑：journal 已有 0/1 轮 → 从第 2 轮续。"""
    j = tmp_path / "j.jsonl"
    j.write_text(json.dumps({"cycle": 0, "ts": "t", "status": "ok",
                             "detail": ""}) + "\n" +
                 json.dumps({"cycle": 1, "ts": "t", "status": "ok",
                             "detail": ""}) + "\n", encoding="utf-8")
    seen = []
    rep = _run(j, 4, lambda i: seen.append(i) or "")
    assert seen == [2, 3]                     # 0/1 不重跑
    assert rep["done"] == 4                   # 累计口径


def test_stop_flag_cooperative(tmp_path):
    j = tmp_path / "j.jsonl"
    seen = []
    rep = _run(j, 5, lambda i: seen.append(i) or "",
               stop_fn=lambda: len(seen) >= 2)
    assert seen == [0, 1]                      # 跑完当前轮即停
    assert rep["stopped"] is True


def test_report_from_journal_corrupt_lines(tmp_path):
    j = tmp_path / "j.jsonl"
    j.write_text("坏行\n" +
                 json.dumps({"cycle": 0, "ts": "t", "status": "ok",
                             "detail": ""}) + "\n" +
                 json.dumps({"cycle": 1, "ts": "t", "status": "error",
                             "detail": "x"}) + "\n", encoding="utf-8")
    rep = soak_report(j)
    assert rep["done"] == 2 and rep["errors"] == 1
    assert rep["stopped"] is False
