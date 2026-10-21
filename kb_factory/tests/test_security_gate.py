# -*- coding: utf-8 -*-
"""KB-FACTORY W10 任务B：安全自检门测试（PentAGI 蒸馏）。

- CLI 真入口：subprocess 跑 py -3 -m kb_factory.security_gate --check，rc=0 且
  三态汇总为 0 FAIL（9 PASS / 2 MANUAL 基线）。
- 检查器负例：植入 os.remove / 白名单外域名 / 凭据文件名 → 检查器必须报 FAIL 形态命中
  （门不是恒真的橡皮图章）。
"""
import os
import subprocess
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # 仓库根入 sys.path

from kb_factory import security_gate as sg

REPO_ROOT = Path(__file__).resolve().parents[2]


def test_w10_b_gate_cli_green(tmp_path):
    """CLI 真入口全绿：rc=0，汇总 0 FAIL，PASS/MANUAL 三态齐备。"""
    env = dict(os.environ)
    env["PYTHONIOENCODING"] = "utf-8"
    r = subprocess.run(
        [sys.executable, "-X", "utf8", "-m", "kb_factory.security_gate", "--check"],
        cwd=REPO_ROOT, capture_output=True, text=True, timeout=600,
        encoding="utf-8", errors="replace", env=env,
    )
    assert r.returncode == 0, f"rc={r.returncode}\n{r.stdout}\n{r.stderr}"
    assert "0 FAIL" in r.stdout
    assert "PASS" in r.stdout and "MANUAL" in r.stdout
    assert "[FAIL]" not in r.stdout


def test_w10_b_detector_planted_delete(tmp_path):
    """检查器负例：植入 os.remove/rmtree/unlink 的伪运行文件 → 零删除红线必须命中。"""
    bad = tmp_path / "planted.py"
    bad.write_text("import os, shutil\nos.remove(p)\nshutil.rmtree(d)\nf.unlink()\n",
                   encoding="utf-8")
    hits = sg.scan_deletions([bad])
    assert len(hits) == 3, hits
    res = sg.check_no_delete([bad])
    assert res.verdict == "FAIL" and "删除" in res.detail


def test_w10_b_detector_planted_bad_host(tmp_path):
    """检查器负例：白名单外域名 → 网络白名单检查必须 FAIL。"""
    bad = tmp_path / "planted_net.py"
    bad.write_text('X = "https://evil.example.com/api"\n', encoding="utf-8")
    res, urls = sg.check_net_whitelist([bad])
    assert res.verdict == "FAIL" and "evil.example.com" in res.detail
    assert urls and urls[0][1] == "evil.example.com"


def test_w10_b_detector_planted_credential_file():
    """检查器负例：发布面凭据形态文件名 → 凭据零入仓必须 FAIL。"""
    res = sg.check_credentials(["kb_factory/wenku.secret.ini", "kb_factory/__main__.py"])
    assert res.verdict == "FAIL" and "wenku.secret.ini" in res.detail
    # _credentials 下空占位（.gitkeep/chain.jsonl）放行；发布面外不入门
    ok = sg.check_credentials(["kb_factory/_credentials/.gitkeep",
                               "05 方法/_credentials/chain.jsonl",
                               "kb_factory/pipeline.py"])
    assert ok.verdict == "PASS"


def test_w10_b_detector_cred_print(tmp_path):
    """检查器负例：print(cfg['password']) 形 → 日志无凭据打印必须命中。"""
    bad = tmp_path / "planted_log.py"
    bad.write_text("print('pw=' + cfg['password'])\n", encoding="utf-8")
    assert sg.scan_cred_prints([bad])
    assert sg.check_no_cred_print([bad]).verdict == "FAIL"
