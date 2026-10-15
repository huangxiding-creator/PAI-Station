# -*- coding: utf-8 -*-
"""REQ-044 judge valid 同事务存档快照内嵌单测 (T-019 / METHODOLOGY §三.2).

覆盖:
  a) judge valid 增量行 → manifest 行带 snapshot_hash/ts/url 三字段 + 快照体在盘
  b) 原文一致性: 快照读回 == 判定原文 (哈希锚定全文)
  c) >2MB 截断标记 (宪法容量纪律: 前 100KB+截断标记, 哈希仍锚定全文)
  d) A 级官方件指针豁免 (原文件即快照, 免复制)
  e) 写失败 fail-soft (monkeypatch open 抛错 → judge 仍成功 + snapshot_pending)
  f) cutoff 前存量行豁免 (W0 生效日=基线, 不补快照)
  g) snapshot_pending 行下轮 judge 自愈补档

跑法: py -m pytest reforge_factory/tests/test_snapshot_embed.py -q
"""
import builtins
import hashlib
import io
import json
import sys
import tempfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as AP                                # noqa: E402

_TMP = Path(tempfile.mkdtemp(prefix="t019_embed_"))

import pytest                                          # noqa: E402


@pytest.fixture(autouse=True, scope="module")
def _isolate_pool_root():
    """运行时根恢复: 其他测试文件收集期亦改 AP.POOL_ROOT, 本模块测试前重指
    自己的 tmp 池根, 防跨文件状态污染 (T-001 同款)."""
    _orig = AP.POOL_ROOT
    AP.POOL_ROOT = _TMP / "ammo_pool"
    yield
    AP.POOL_ROOT = _orig


def _init(cid: str, kws=("EPC", "总承包")) -> Path:
    camp = AP.POOL_ROOT / cid
    camp.mkdir(parents=True, exist_ok=True)
    s = AP._load_state(camp)
    AP._save_state(camp, {**s, "kws": list(kws)})
    return camp


def _ingest(cid: str, name: str, text: str, cred: str = "media") -> Path:
    fp = _TMP / name
    fp.write_text(text, encoding="utf-8")
    assert AP.ingest(cid, str(fp), "own:web", cred=cred) == 0
    return fp


def _rows(cid: str) -> list[dict]:
    mp = AP.POOL_ROOT / cid / "manifest.jsonl"
    return [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]


_TEXT = ("中石化南京工程有限公司在 EPC 总承包领域深耕多年，"
         "承接了宁波乙烯等多个大型水利枢纽项目。" * 60)


# ------------------------------------------------ a) valid 三字段+快照在盘
def test_valid_row_gets_snapshot_fields(gates_json):
    gates_json(effective_date="2000-01-01")          # cutoff 提前 → 全部算增量
    cid = "TEST-T019-A"
    _init(cid)
    _ingest(cid, "t_a.md", _TEXT)
    assert AP.judge(cid) == 0
    row = _rows(cid)[0]
    assert row["judge"] == "valid"
    for k in ("snapshot_hash", "snapshot_ts", "snapshot_url"):
        assert row.get(k), f"缺 {k}"
    loc = AP.POOL_ROOT / cid / row["snapshot_url"]    # 战役目录内相对定位
    assert loc.is_file()                              # 快照体在盘
    meta = json.loads((loc.parent / "meta.json").read_text(encoding="utf-8"))
    assert meta["sha256"] == row["snapshot_hash"]
    assert row["snapshot_mode"] == "content"


# ------------------------------------------------ b) 原文一致性
def test_snapshot_roundtrip_equals_source(gates_json):
    gates_json(effective_date="2000-01-01")
    cid = "TEST-T019-RT"
    _init(cid)
    text = "EPC 总承包专项研究：" + ("水利枢纽工程建设管理模式与索赔实务分析。" * 300)
    fp = _ingest(cid, "t_rt.md", text)
    assert AP.judge(cid) == 0
    row = _rows(cid)[0]
    body = (AP.POOL_ROOT / cid / row["snapshot_url"]).read_text(encoding="utf-8")
    assert body == text                               # 快照读回 == 原文
    assert row["snapshot_hash"] == hashlib.sha256(
        text.encode("utf-8")).hexdigest()             # 哈希锚定全文
    meta = json.loads((AP.POOL_ROOT / cid / "snapshots"
                       / row["snapshot_hash"][:16] / "meta.json")
                      .read_text(encoding="utf-8"))
    assert meta["truncated"] is False and meta["mode"] == "content"


# ------------------------------------------------ c) >2MB 截断标记
def test_snapshot_truncation_over_2mb(gates_json):
    gates_json(effective_date="2000-01-01")
    cid = "TEST-T019-TR"
    _init(cid)
    text = "EPC 大坝施工总承包质量管控要点：" + ("混凝土重力坝温控防裂工法。" * 500000)
    raw = text.encode("utf-8")
    assert len(raw) > AP.SNAPSHOT_FULL_LIMIT          # 确实超 2MiB
    _ingest(cid, "t_tr.md", text)
    assert AP.judge(cid) == 0
    row = _rows(cid)[0]
    body = (AP.POOL_ROOT / cid / row["snapshot_url"]).read_text(encoding="utf-8")
    assert "SNAPSHOT-TRUNCATED" in body               # 截断标记在
    assert body.startswith(raw[:AP.SNAPSHOT_KEEP_BYTES].decode(
        "utf-8", errors="ignore"))                    # 前 100KB 保真
    assert row["snapshot_hash"] == hashlib.sha256(raw).hexdigest()  # 哈希仍锚定全文
    meta = json.loads((AP.POOL_ROOT / cid / "snapshots"
                       / row["snapshot_hash"][:16] / "meta.json")
                      .read_text(encoding="utf-8"))
    assert meta["truncated"] is True
    assert meta["stored_bytes"] <= AP.SNAPSHOT_KEEP_BYTES + 500   # 标记+头
    assert meta["full_bytes"] == len(raw)


# ------------------------------------------------ d) A 级官方件指针豁免
def test_grade_a_pointer_exemption(gates_json):
    gates_json(effective_date="2000-01-01")
    cid = "TEST-T019-AP"
    _init(cid)
    fp = _ingest(cid, "t_official.md", _TEXT, cred="official")   # GRADE→A
    assert AP.judge(cid) == 0
    row = _rows(cid)[0]
    assert row["grade"] == "A"
    assert row["snapshot_mode"] == "pointer"          # 原文件即快照
    assert row["snapshot_url"] == str(fp)             # 指针=本地原文件路径
    assert row["snapshot_hash"] == hashlib.sha256(
        fp.read_bytes()).hexdigest()                  # 哈希=原文件字节
    sdir = AP.POOL_ROOT / cid / "snapshots" / row["snapshot_hash"][:16]
    meta = json.loads((sdir / "meta.json").read_text(encoding="utf-8"))
    assert meta["mode"] == "pointer"
    assert not (sdir / "content.txt").exists()        # 免复制零占盘


# ------------------------------------------------ e) 写失败 fail-soft
def _boom_open_factory():
    real_open = builtins.open

    def boom(f, *a, **k):
        if "snapshots" in str(f):                     # 只炸快照落盘
            raise OSError("EIO: 模拟快照写失败")
        return real_open(f, *a, **k)
    return boom


def test_snapshot_write_failure_failsoft(gates_json, monkeypatch):
    gates_json(effective_date="2000-01-01")
    cid = "TEST-T019-FS"
    _init(cid)
    _ingest(cid, "t_fs.md", _TEXT)
    boom = _boom_open_factory()
    monkeypatch.setattr(builtins, "open", boom)
    monkeypatch.setattr(io, "open", boom)             # Path.write_text 走 io.open
    assert AP.judge(cid) == 0                         # fail-soft: judge 不阻断
    monkeypatch.undo()
    row = _rows(cid)[0]
    assert row["judge"] == "valid"                    # 判定照常入账
    assert row.get("snapshot_pending") is True        # 留 pending 标记
    assert row.get("snapshot_error")                  # 判由在案
    assert not row.get("snapshot_hash")
    assert not (AP.POOL_ROOT / cid / "manifest.tmp").exists()  # manifest 已提交


# ------------------------------------------------ f) cutoff 前存量豁免
def test_rows_before_cutoff_exempt(gates_json):
    gates_json(effective_date="2099-01-01")           # cutoff 在未来 → 今日行=存量
    cid = "TEST-T019-EX"
    _init(cid)
    _ingest(cid, "t_ex.md", _TEXT)
    assert AP.judge(cid) == 0
    row = _rows(cid)[0]
    assert row["judge"] == "valid"
    assert not row.get("snapshot_hash")               # 存量不补快照
    assert not (AP.POOL_ROOT / cid / "snapshots").exists()


# ------------------------------------------------ g) pending 下轮自愈补档
def test_snapshot_pending_heals_next_judge(gates_json, monkeypatch):
    gates_json(effective_date="2000-01-01")
    cid = "TEST-T019-HE"
    _init(cid)
    _ingest(cid, "t_he.md", _TEXT)
    boom = _boom_open_factory()
    with monkeypatch.context() as m:                  # 只挂 open 补丁, 退出即撤
        m.setattr(builtins, "open", boom)             # (gates 权威源补丁保留)
        m.setattr(io, "open", boom)
        assert AP.judge(cid) == 0
    assert _rows(cid)[0]["snapshot_pending"] is True
    assert AP.judge(cid) == 0                         # 第二轮: 只补档不重判
    row = _rows(cid)[0]
    assert row.get("snapshot_hash")                   # 三字段补齐
    assert not row.get("snapshot_pending")            # pending 清除
    assert (AP.POOL_ROOT / cid / row["snapshot_url"]).is_file()
