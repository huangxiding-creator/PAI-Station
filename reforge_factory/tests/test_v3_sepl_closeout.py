# -*- coding: utf-8 -*-
"""test_v3_sepl_closeout — SEPL 收口审计单测 (T-028 / REQ-061).

合成 git log / git show --name-only / 全量 pytest 输出 (全 monkeypatch,
零真仓依赖), 验四类判定:
  ①摘要行覆盖: 「N passed」模式 + Co-Authored-By 行
  ②白名单合规: 变更文件须落在白名单目录/单文件内
  ③回归态: 当前全量计数只许增长不许回退 (vs 最近提交声明值)
  ④报告落盘: work/sepl_closeout.md 四节齐备

跑法: py -m pytest reforge_factory/tests/test_v3_sepl_closeout.py -q
"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import v3_sepl_closeout as SC                                    # noqa: E402

COAUTHOR = "Co-Authored-By: Claude Code <noreply@anthropic.com>"


# ---------------------------------------------------------- 合成 git log ----
def _log_record(h: str, short: str, date: str, subject: str, body: str) -> str:
    return "\x1f".join([h, short, date, subject, body]) + "\x1e"


def _good_body(count: str) -> str:
    return (f"feat(v3-tXYZ): 合成好提交\n\n- 详情省略\n"
            f"- pytest: 全量 {count} passed, 0 failed\n\n{COAUTHOR}\n")


# ------------------------------------------------------- ①摘要行/署名判定 ----
class TestSummaryLine:
    def test_has_summary_plain(self):
        assert SC.has_pytest_summary(_good_body("549")) is True

    def test_has_summary_with_skipped(self):
        assert SC.has_pytest_summary("全量 457 passed, 2 skipped") is True

    def test_no_summary_bare_pass_word(self):
        # 真案 t015: "OpenAlex passed ... 43 pass + 2 honest skip" — 无数字+passed
        assert SC.has_pytest_summary(
            "pytest: 全量 457 collected 0 failed 2 skipped; OpenAlex passed") is False

    def test_no_summary_pass_slash_fail(self):
        # 真案 t010: "272 pass / 3 fail" — pass 无ed无N passed模式
        assert SC.has_pytest_summary("全量 275 collect / 272 pass / 3 fail") is False

    def test_no_summary_empty(self):
        assert SC.has_pytest_summary("") is False

    def test_declared_last_match_wins(self):
        body = ("feat(v3-tXYZ): x\n\n- 本任务新增 20 passed\n"
                f"- 全量回归 = 549 passed\n\n{COAUTHOR}\n")
        assert SC.extract_declared_passed(body) == 549

    def test_declared_none_when_absent(self):
        assert SC.extract_declared_passed("272 pass / 3 fail") is None

    def test_coauthor_present_absent(self):
        assert SC.has_coauthor(_good_body("1")) is True
        assert SC.has_coauthor("feat(v3-tXYZ): 无署名提交") is False


# ------------------------------------------------------------ ②白名单判定 ----
class TestWhitelist:
    def test_all_inside(self):
        files = ["reforge_factory/forge.py",
                 "reforge_factory/tests/test_x.py",
                 "report_platform/funnel_query.py",
                 "report_platform/tests/test_funnel.py",
                 "_proposals/flagship-paid-report-1007/work/pipeline_state.json",
                 "ResearchFactory-Eng/channel_manifest.json"]
        assert SC.whitelist_violations(files) == []

    def test_prefix_must_be_directory(self):
        # 前缀必须带斜杠: reforge_factory_evil.py 不是 reforge_factory/ 内文件
        assert SC.whitelist_violations(["reforge_factory_evil.py"]) == [
            "reforge_factory_evil.py"]

    def test_outside_flagged(self):
        # 真实在案形态: ammo_pool 弹药池文件在白名单外
        viol = SC.whitelist_violations(
            ["ammo_pool/EPC-BID26/completeness/T_axis.json",
             "reforge_factory/entity_timeline.py"])
        assert viol == ["ammo_pool/EPC-BID26/completeness/T_axis.json"]

    def test_sibling_file_of_exact_whitelist_file(self):
        # channel_manifest.json 是单文件白名单, 同目录其他文件不算
        assert SC.whitelist_violations(
            ["ResearchFactory-Eng/channel_manifest.json",
             "ResearchFactory-Eng/other.json"]) == ["ResearchFactory-Eng/other.json"]

    def test_windows_sep_normalized(self):
        # git 输出恒为正斜杠; 防御: 反斜杠路径同样判内
        assert SC.whitelist_violations(["reforge_factory\\forge.py"]) == []


# ------------------------------------------------------------ ③回归态判定 ----
class TestRegression:
    def test_pytest_output_plain(self):
        r = SC.parse_pytest_output(".....\n549 passed in 12.30s")
        assert r == {"passed": 549, "failed": 0, "errors": 0}

    def test_pytest_output_with_failed(self):
        r = SC.parse_pytest_output("545 passed, 4 failed in 9.99s")
        assert r == {"passed": 545, "failed": 4, "errors": 0}

    def test_pytest_output_with_errors(self):
        r = SC.parse_pytest_output("2 passed, 1 error in 3.2s")
        assert r == {"passed": 2, "failed": 0, "errors": 1}

    def test_pytest_output_none(self):
        assert SC.parse_pytest_output("no summary here") is None

    def test_curve_decreases_flagged(self):
        seq = [("a1", 199), ("a2", 218), ("a3", 194), ("a4", 194), ("a5", 302)]
        drops = SC.curve_decreases(seq)
        # 218→194 回落一处; 194→194 持平不算; 194→302 增长
        assert drops == [("a2", 218, "a3", 194)]

    def test_current_vs_last_declared(self):
        # 增长/持平 → 无违规; 回退 → 违规
        assert SC.regression_violation(549, 551) is False
        assert SC.regression_violation(549, 549) is False
        assert SC.regression_violation(549, 540) is True
        assert SC.regression_violation(None, 540) is False  # 无声明值无从比对


# --------------------------------------------------------- ④回滚记录扫描 ----
class TestRollbackScan:
    def test_rollback_lines_detected(self):
        text = ('{"event": "commit", "note": "ok"}\n'
                '{"event": "rollback", "note": "计数回滚"}\n'
                '{"event": "rollback_ledger", "note": "x"}\n')
        hits = SC.scan_rollbacks(text)
        assert len(hits) == 2

    def test_no_rollback(self):
        assert SC.scan_rollbacks('{"event": "commit"}\n') == []


# ------------------------------------------------------------- 解析层单测 ----
class TestParsers:
    def test_parse_commits(self):
        raw = (_log_record("f" * 40, "abc1234", "2026-10-01",
                           "feat(v3-t1): 甲", _good_body("199")) +
               _log_record("e" * 40, "def5678", "2026-10-02",
                           "feat(v3-t2): 乙", "feat(v3-t2): 乙\n\n无摘要\n"))
        cs = SC.parse_commits(raw)
        assert len(cs) == 2
        assert cs[0]["short"] == "abc1234" and cs[0]["declared"] == 199
        assert cs[0]["has_summary"] and cs[0]["has_coauthor"]
        assert cs[1]["declared"] is None and not cs[1]["has_summary"]

    def test_parse_commit_files(self):
        raw = ("reforge_factory/forge.py\n"
               "ammo_pool/EPC-BID26/coverage_facets.json\n")
        assert SC.parse_commit_files(raw) == [
            "reforge_factory/forge.py", "ammo_pool/EPC-BID26/coverage_facets.json"]

    def test_parse_commit_files_empty(self):
        assert SC.parse_commit_files("") == []


# ------------------------------------------------- run_audit 编排 (mock 全链) --
class TestPytestCmdGotcha:
    def test_cmd_no_extra_q(self, monkeypatch):
        """真机踩坑回归: 命令行不得再叠 -q (pyproject addopts 已有一个,
        双 -q = -qq 会在 -2 verbosity 下隐藏「N passed」摘要行)。"""
        seen = {}

        def fake_run(cmd, **kw):
            seen["cmd"] = cmd

            class _R:
                stdout = "3 passed in 0.1s\n"
                stderr = ""
            return _R()

        monkeypatch.setattr(SC.subprocess, "run", fake_run)
        out = SC.run_full_pytest(Path("x"))
        assert seen["cmd"][1:4] == ["-m", "pytest", SC.PYTEST_TARGET]
        assert "-q" not in seen["cmd"]                     # 只靠 addopts 的 -q
        assert SC.parse_pytest_output(out)["passed"] == 3



def _patch_git(monkeypatch, log_raw: str, files_by_short: dict[str, str]):
    monkeypatch.setattr(SC, "git_log_v3", lambda repo: log_raw)
    monkeypatch.setattr(
        SC, "git_commit_files",
        lambda repo, short: files_by_short.get(short, ""))


def _patch_pytest(monkeypatch, out: str):
    monkeypatch.setattr(SC, "run_full_pytest", lambda repo: out)


GOOD_A = _log_record("a" * 40, "aaa1111", "2026-10-01",
                     "feat(v3-tA): 好提交", _good_body("199"))
MISSING_SUMMARY = _log_record("b" * 40, "bbb2222", "2026-10-02",
                              "feat(v3-tB): 缺摘要",
                              f"feat(v3-tB): 缺摘要\n\n- 只有文字\n\n{COAUTHOR}\n")
OUTSIDE_FILES = _log_record("c" * 40, "ccc3333", "2026-10-03",
                            "feat(v3-tC): 白名单外", _good_body("210"))
LATEST = _log_record("d" * 40, "ddd4444", "2026-10-04",
                     "feat(v3-tD): 最新", _good_body("549"))


class TestRunAudit:
    def _run(self, monkeypatch, tmp_path, pytest_out="549 passed in 10s\n",
             log_raw=None, files=None):
        # git log 输出序 = 新→旧: LATEST(最近声明549) 居首
        log_raw = log_raw or (LATEST + OUTSIDE_FILES + MISSING_SUMMARY + GOOD_A)
        files = files or {
            "aaa1111": "reforge_factory/a.py\n",
            "bbb2222": "reforge_factory/b.py\n",
            "ccc3333": "ammo_pool/EPC-BID26/depth_ladder.json\n",
            "ddd4444": "reforge_factory/d.py\n",
        }
        _patch_git(monkeypatch, log_raw, files)
        _patch_pytest(monkeypatch, pytest_out)
        report = tmp_path / "sepl_closeout.md"
        return SC.run_audit(report_path=report), report

    def test_violations_collected(self, monkeypatch, tmp_path):
        res, report = self._run(monkeypatch, tmp_path)
        kinds = [v["kind"] for v in res["violations"]]
        assert "missing_summary" in kinds            # bbb2222 缺摘要
        assert "out_of_whitelist" in kinds           # ccc3333 白名单外
        assert res["commit_total"] == 4
        assert res["summary_ok"] == 3                # 4-1
        assert res["whitelist_ok"] == 3
        assert res["current"]["passed"] == 549
        assert res["regression_violation"] is False  # 549 vs 最近声明 549 持平
        assert report.exists()

    def test_count_regression_detected(self, monkeypatch, tmp_path):
        # 最近声明 549, 当前实测 540 → 回退违规
        res, _ = self._run(monkeypatch, tmp_path, pytest_out="540 passed in 9s\n")
        assert res["regression_violation"] is True
        kinds = [v["kind"] for v in res["violations"]]
        assert "count_regression" in kinds

    def test_growth_ok(self, monkeypatch, tmp_path):
        res, _ = self._run(monkeypatch, tmp_path,
                           pytest_out="560 passed, 0 failed in 11s\n")
        assert res["regression_violation"] is False

    def test_current_failures_are_violation(self, monkeypatch, tmp_path):
        res, _ = self._run(monkeypatch, tmp_path,
                           pytest_out="549 passed, 2 failed in 11s\n")
        kinds = [v["kind"] for v in res["violations"]]
        assert "current_red_suite" in kinds

    def test_report_sections(self, monkeypatch, tmp_path):
        res, report = self._run(monkeypatch, tmp_path)
        text = report.read_text(encoding="utf-8")
        for needle in ("提交清单", "摘要行", "白名单", "回归计数曲线",
                       "bbb2222", "ccc3333", "ammo_pool/EPC-BID26/depth_ladder.json",
                       "549"):
            assert needle in text, needle
        assert "回滚" in text          # ledger 扫描节 (无 ledger 时也保留节标题)

    def test_transient_red_recovers(self, monkeypatch, tmp_path):
        """真机踩坑回归: 首跑瞬态 error (并行 worker 文件锁), 复跑绿 →
        不留 current_red_suite 违规, 但两次轨迹全落报告。"""
        outs = iter(["1 error in 2.0s\n", "595 passed, 2 skipped in 21.0s\n"])
        monkeypatch.setattr(SC, "run_full_pytest", lambda repo: next(outs))
        _patch_git(monkeypatch, GOOD_A, {"aaa1111": "reforge_factory/a.py\n"})
        report = tmp_path / "c.md"
        res = SC.run_audit(report_path=report)
        assert res["current"]["passed"] == 595
        assert not any(v["kind"] == "current_red_suite"
                       for v in res["violations"])
        assert SC.exit_code(res) == 0
        text = report.read_text(encoding="utf-8")
        assert "第1次: 0 passed, 0 failed, 1 errors" in text
        assert "第2次: 595 passed, 0 failed, 0 errors" in text

    def test_both_red_stays_violation(self, monkeypatch, tmp_path):
        """两次皆红 → 维持违规 (重试不遮掩真实红态)。"""
        outs = iter(["1 error in 2.0s\n", "545 passed, 4 failed in 9s\n"])
        monkeypatch.setattr(SC, "run_full_pytest", lambda repo: next(outs))
        _patch_git(monkeypatch, GOOD_A, {"aaa1111": "reforge_factory/a.py\n"})
        res = SC.run_audit(report_path=tmp_path / "c.md")
        kinds = [v["kind"] for v in res["violations"]]
        assert "current_red_suite" in kinds
        assert SC.exit_code(res) == 2

    def test_exit_code_mapping(self, monkeypatch, tmp_path):
        # main: 全合规→0 / 有违规→2 (mock run_audit 层)
        res, _ = self._run(monkeypatch, tmp_path)
        assert SC.exit_code(res) == 2
        res2 = dict(res)
        res2["violations"] = []
        res2["regression_violation"] = False
        assert SC.exit_code(res2) == 0


class TestExitPath:
    def test_main_writes_report_and_exits_2(self, monkeypatch, tmp_path):
        _patch_git(monkeypatch, GOOD_A + MISSING_SUMMARY,
                   {"aaa1111": "reforge_factory/a.py\n",
                    "bbb2222": "reforge_factory/b.py\n"})
        _patch_pytest(monkeypatch, "199 passed in 1s\n")
        out = tmp_path / "out.md"
        rc = SC.main(["--report", str(out)])
        assert rc == 2
        assert out.exists()

    def test_main_all_good_exits_0(self, monkeypatch, tmp_path):
        _patch_git(monkeypatch, GOOD_A, {"aaa1111": "reforge_factory/a.py\n"})
        _patch_pytest(monkeypatch, "205 passed in 1s\n")
        out = tmp_path / "out.md"
        rc = SC.main(["--report", str(out)])
        assert rc == 0
        text = out.read_text(encoding="utf-8")
        assert "全部合规" in text

    def test_main_pytest_unparseable_exits_1(self, monkeypatch, tmp_path):
        _patch_git(monkeypatch, GOOD_A, {"aaa1111": "reforge_factory/a.py\n"})
        _patch_pytest(monkeypatch, "garbage output no summary\n")
        out = tmp_path / "out.md"
        rc = SC.main(["--report", str(out)])
        assert rc == 1

    def test_main_git_failure_exits_1(self, monkeypatch, tmp_path):
        def boom(repo):
            raise SC.GitError("git log failed")
        monkeypatch.setattr(SC, "git_log_v3", boom)
        rc = SC.main(["--report", str(tmp_path / "out.md")])
        assert rc == 1

    def test_main_skip_pytest_no_regression_section_data(
            self, monkeypatch, tmp_path):
        _patch_git(monkeypatch, GOOD_A, {"aaa1111": "reforge_factory/a.py\n"})
        out = tmp_path / "out.md"
        rc = SC.main(["--report", str(out), "--skip-pytest"])
        assert rc == 0
        assert "跳过" in out.read_text(encoding="utf-8")
