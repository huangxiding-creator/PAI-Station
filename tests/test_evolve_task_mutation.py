"""Phase B3 任务级进化：任务结束→技能变异候选→A/B 验证→KEEP/DISCARD 裁决。

「diff 即梯度」（agentdescent 语义）：候选≠生效——生效必须 A/B 胜出。
mutations.jsonl append-only（R 只增不删）：状态变迁=新事件行，读侧取末值。
"""
from paistation.evolve.task_mutation import history, judge, pending, propose, record_ab


def test_propose_creates_candidate(tmp_path):
    propose(tmp_path, skill="weekly-report", diff="增加结论前置模板",
            task_id="T-101", origin="task")
    rows = history(tmp_path)
    assert len(rows) == 1
    assert rows[0]["event"] == "propose"
    assert rows[0]["status"] == "candidate"
    assert rows[0]["candidate_id"].startswith("MUT-")


def test_pending_lists_unjudged(tmp_path):
    propose(tmp_path, skill="weekly-report", diff="d1", task_id="T-101")
    propose(tmp_path, skill="daily-log", diff="d2", task_id="T-102")
    cid = propose(tmp_path, skill="weekly-report", diff="d3", task_id="T-103")
    judge(tmp_path, candidate_id=cid, verdict="KEEP", evidence="A/B 胜出")
    pend = pending(tmp_path)
    assert len(pend) == 2                      # 只剩未裁决的
    assert all(p["status"] == "candidate" for p in pend)


def test_judge_keep_marks_effective(tmp_path):
    cid = propose(tmp_path, skill="weekly-report", diff="d1", task_id="T-101")
    judge(tmp_path, candidate_id=cid, verdict="KEEP", evidence="RRF 提升")
    hist = [h for h in history(tmp_path) if h["candidate_id"] == cid]
    assert hist[-1]["status"] == "effective"   # KEEP → 生效


def test_judge_discard_marks_discarded(tmp_path):
    cid = propose(tmp_path, skill="s", diff="d", task_id="T-1")
    judge(tmp_path, candidate_id=cid, verdict="DISCARD", evidence="无提升")
    hist = [h for h in history(tmp_path) if h["candidate_id"] == cid]
    assert hist[-1]["status"] == "discarded"


def test_append_only_rejudge_last_wins(tmp_path):
    """重复裁决不删旧行：末事件行语义（双时态，Git 留痕）。"""
    cid = propose(tmp_path, skill="s", diff="d", task_id="T-1")
    judge(tmp_path, candidate_id=cid, verdict="DISCARD", evidence="初判")
    judge(tmp_path, candidate_id=cid, verdict="KEEP", evidence="复判翻案")
    rows = [r for r in history(tmp_path) if r["candidate_id"] == cid]
    assert len(rows) == 3                       # propose+2 judge，只增
    assert rows[-1]["status"] == "effective"    # 末值生效


def test_record_ab_run(tmp_path):
    record_ab(tmp_path, skill="weekly-report", task_id="T-101",
              baseline={"hit": 3}, variant={"hit": 5})
    from paistation.evolve.task_mutation import ab_runs

    runs = ab_runs(tmp_path)
    assert len(runs) == 1
    assert runs[0]["variant"]["hit"] > runs[0]["baseline"]["hit"]


def test_propose_idempotent_same_diff(tmp_path):
    """同任务同 diff 重复提案不翻倍（幂等，防代谢洪水）。"""
    propose(tmp_path, skill="s", diff="d", task_id="T-1")
    propose(tmp_path, skill="s", diff="d", task_id="T-1")
    assert len([h for h in history(tmp_path)
                if h["event"] == "propose"]) == 1


def test_evolution_cycle_is_task_level(tmp_path):
    """验收主判据演练：任务 T-101 结束→提案→A/B→裁决→生效，一个任务内闭环。"""
    cid = propose(tmp_path, skill="weekly-report", diff="结论前置",
                  task_id="T-101", origin="task")
    record_ab(tmp_path, skill="weekly-report", task_id="T-101",
              baseline={"hit": 3}, variant={"hit": 5})
    judge(tmp_path, candidate_id=cid, verdict="KEEP", evidence="hit 3→5")
    final = [h for h in history(tmp_path) if h["candidate_id"] == cid][-1]
    assert final["status"] == "effective"
