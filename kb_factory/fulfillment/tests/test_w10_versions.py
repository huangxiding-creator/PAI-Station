# -*- coding: utf-8 -*-
"""KB-FACTORY W10 任务A：发货腿集成测试（W7 履约 ↔ W8 转换 缝合）。

按 order.version_selection 组装交付：
  original    现行为（zip 原包）
  markdown    build 后 convert.convert_package 产 MD 版（转换报告随附）
  import_pack / ima_pack   convert.make_import_pack 产导入包 zip 与原包并列 outbox
  组合（markdown+import_pack）全都要；manifest 增 versions 字段记录各版本产物路径与计数。
测试纪律：走真实 CLI（subprocess py -3 -m kb_factory.fulfillment --once --base tmp，rc 断言——
直调不算数，上一任务教训）。
"""
import json
import os
import subprocess
import sys
import zipfile
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from test_fulfillment import make_blueprint, make_corpus  # 同目录夹具复用（W7 契约）

from kb_factory.fulfillment.order import Order, parse_selections

REPO_ROOT = Path(__file__).resolve().parents[3]


def _write_order(base: Path, bp_path: Path, order_id: str, selection: str) -> Path:
    inbox = base / "inbox"
    inbox.mkdir(parents=True, exist_ok=True)
    p = inbox / f"{order_id}.json"
    p.write_text(json.dumps({
        "id": order_id, "need_text": "水利水电EPC 知识库", "blueprint_ref": str(bp_path),
        "email": "buyer@example.com", "version_selection": selection,
        "price": "299.00", "paid_at": "2026-10-22T10:00:00", "status": "paid",
    }, ensure_ascii=False), encoding="utf-8")
    return p


def _run_cli(base: Path, corpus: Path) -> subprocess.CompletedProcess:
    """真实 CLI 入口：py -3 -m kb_factory.fulfillment --once --base tmp（上一任务教训：直调不算数）。"""
    env = dict(os.environ)
    env.update({
        "PYTHONIOENCODING": "utf-8",
        "KB_WECOM_NOTIFY": "0",                    # 冒烟/CI 不发真企微
        "KB_LOCAL_CORPUS": str(corpus),            # tmp 夹具语料
        "KB_SMTP_SECRET": str(base / "no.smtp.secret"),  # 缺配→wecom降级（不真发邮件）
    })
    env.pop("KB_PANDOC", None)
    return subprocess.run(
        [sys.executable, "-X", "utf8", "-m", "kb_factory.fulfillment",
         "--once", "--base", str(base)],
        cwd=REPO_ROOT, capture_output=True, text=True, timeout=300,
        encoding="utf-8", errors="replace", env=env,
    )


def _ledger(base: Path) -> list:
    return [json.loads(x) for x in
            (base / "ledger.jsonl").read_text(encoding="utf-8").strip().splitlines()]


def _manifest(base: Path, order_id: str) -> dict:
    for mf in (base / "outbox" / order_id).rglob("manifest.json"):
        return json.loads(mf.read_text(encoding="utf-8"))
    raise AssertionError(f"outbox/{order_id} 下无 manifest.json")


# ---------------------------------------------------------------- selection 解析

def test_w10_a_parse_selections_unit():
    """selection 解析：单值/别名(ima_pack=import_pack,md=markdown)/组合原包恒在/越界拒绝。"""
    assert parse_selections("original") == {"original"}
    assert parse_selections("markdown") == {"original", "markdown"}
    assert parse_selections("import_pack") == {"original", "import_pack"}
    assert parse_selections("ima_pack") == {"original", "import_pack"}       # 别名
    assert parse_selections("md+import") == {"original", "markdown", "import_pack"}
    assert parse_selections("markdown+import_pack") == {"original", "markdown", "import_pack"}
    assert parse_selections("markdown、ima_pack") == {"original", "markdown", "import_pack"}
    with pytest.raises(ValueError):
        parse_selections("bogus")
    with pytest.raises(ValueError):
        parse_selections("markdown+bogus")
    with pytest.raises(ValueError):
        Order(id="X1", blueprint_ref="bp.json", email="a@t",
              version_selection="md+not_a_version")  # 越界在订单门即拒


# ---------------------------------------------------------------- CLI 三 selection 各一单

def test_w10_a_cli_original_only(tmp_path):
    """original：现行为——只出原包 zip，无 MD 版/导入包；manifest.versions 只记 original。"""
    corpus = make_corpus(tmp_path)
    bp = make_blueprint(tmp_path)
    base = tmp_path / "base"
    _write_order(base, bp, "ORD-W10-ORIG", "original")
    r = _run_cli(base, corpus)
    assert r.returncode == 0, f"rc={r.returncode}\nstdout={r.stdout}\nstderr={r.stderr}"

    assert (base / "outbox" / "ORD-W10-ORIG.zip").is_file()          # 原包 zip
    assert not (base / "outbox" / "ORD-W10-ORIG_md.zip").exists()    # 无 MD 版
    assert not list((base / "outbox").glob("*_import_pack.zip"))     # 无导入包
    vs = _manifest(base, "ORD-W10-ORIG")["versions"]
    assert vs["selection"] == "original"
    assert vs["original"]["zip"].endswith("ORD-W10-ORIG.zip") and vs["original"]["files"] >= 1
    assert "markdown" not in vs and "import_pack" not in vs
    assert _ledger(base)[0]["result"] in ("ok", "ok_wecom_fallback", "degraded_not_delivered")


def test_w10_a_cli_markdown(tmp_path):
    """markdown：MD 版并入交付（zip+目录+转换报告随附），计数入 manifest.versions。"""
    corpus = make_corpus(tmp_path)
    bp = make_blueprint(tmp_path)
    base = tmp_path / "base"
    _write_order(base, bp, "ORD-W10-MD", "markdown")
    r = _run_cli(base, corpus)
    assert r.returncode == 0, f"rc={r.returncode}\nstdout={r.stdout}\nstderr={r.stderr}"

    md_zip = base / "outbox" / "ORD-W10-MD_md.zip"
    assert md_zip.is_file(), "MD 版 zip 未产"
    md_dir = base / "outbox" / "ORD-W10-MD_md"
    report = md_dir / "转换报告.md"
    assert report.is_file(), "转换报告未随附"
    text = report.read_text(encoding="utf-8")
    assert "成功转换" in text and "合计" in text

    vs = _manifest(base, "ORD-W10-MD")["versions"]
    assert "markdown" in vs and "import_pack" not in vs
    md = vs["markdown"]
    assert md["zip"].endswith("ORD-W10-MD_md.zip")
    assert md["report"].endswith("转换报告.md")
    assert md["files"] == md["total"] and md["total"] >= 1
    # 计数与报告一致：占位（pdf）≥1、复制（md/索引/清单）≥1（零造假来源=报告末行）
    assert md["placeholders"] >= 1 and md["copied"] >= 1
    with zipfile.ZipFile(md_zip) as z:
        names = z.namelist()
    assert "转换报告.md" in names                              # 报告随附在 MD zip 内
    assert any(n.endswith("危险源辨识与风险评价方法.md") for n in names)  # 真实交付件进 MD 版
    led = _ledger(base)[0]
    assert led["result"] in ("ok", "ok_wecom_fallback", "degraded_not_delivered")
    assert "ORD-W10-MD_md.zip" in json.dumps(led.get("versions", {}), ensure_ascii=False)


def test_w10_a_cli_import_pack(tmp_path):
    """import_pack（ima_pack 别名同义）：导入包 zip 与原包并列 outbox，含如何导入/目录速览。"""
    corpus = make_corpus(tmp_path)
    bp = make_blueprint(tmp_path)
    base = tmp_path / "base"
    _write_order(base, bp, "ORD-W10-IMP", "ima_pack")   # 用别名下单
    r = _run_cli(base, corpus)
    assert r.returncode == 0, f"rc={r.returncode}\nstdout={r.stdout}\nstderr={r.stderr}"

    hits = list((base / "outbox").glob("*_import_pack.zip"))
    assert len(hits) == 1, f"导入包应恰 1 个（与原包并列 outbox），实得 {hits}"
    iz = hits[0]
    assert iz.name == "测试知识库_import_pack.zip"       # 库名读 manifest
    with zipfile.ZipFile(iz) as z:
        names = z.namelist()
        assert z.testzip() is None
    assert "如何导入.txt" in names and "目录速览.txt" in names
    assert any(n.endswith("中国水电市场研究报告2026.pdf") for n in names)  # 原包交付件全量在
    vs = _manifest(base, "ORD-W10-IMP")["versions"]
    assert "import_pack" in vs and "markdown" not in vs
    assert vs["import_pack"]["zip"].endswith("测试知识库_import_pack.zip")
    assert vs["import_pack"]["files"] == len(names)      # 计数=zip 实测条数（零造假）
    assert _ledger(base)[0]["result"] in ("ok", "ok_wecom_fallback", "degraded_not_delivered")


def test_w10_a_combo_pipeline_all(tmp_path):
    """组合 markdown+import_pack：全都要——原包/MD版/导入包三产物齐+manifest.versions 全录。"""
    corpus = make_corpus(tmp_path)
    bp = make_blueprint(tmp_path)
    base = tmp_path / "base"
    _write_order(base, bp, "ORD-W10-ALL", "markdown+import_pack")
    r = _run_cli(base, corpus)
    assert r.returncode == 0, f"rc={r.returncode}\nstdout={r.stdout}\nstderr={r.stderr}"

    assert (base / "outbox" / "ORD-W10-ALL.zip").is_file()
    assert (base / "outbox" / "ORD-W10-ALL_md.zip").is_file()
    assert (base / "outbox" / "测试知识库_import_pack.zip").is_file()
    vs = _manifest(base, "ORD-W10-ALL")["versions"]
    assert vs["selection"] == "markdown+import_pack"
    for key in ("original", "markdown", "import_pack"):
        assert key in vs and vs[key]["files"] >= 1, f"versions 缺 {key}"
    # ledger 记录各版本产物路径与计数
    led = _ledger(base)[0]
    lv = led.get("versions", {})
    assert set(lv) == {"original", "markdown", "import_pack"}
    assert all(v["files"] >= 1 for v in lv.values())
    # 转换报告随附（MD 版目录内）
    assert (base / "outbox" / "ORD-W10-ALL_md" / "转换报告.md").is_file()
