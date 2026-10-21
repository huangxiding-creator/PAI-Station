# -*- coding: utf-8 -*-
"""KB-FACTORY W7 履约流水线测试（test-first，无真网络无真SMTP）。

AC 编号即测试名后缀（供追溯矩阵引用）：
  ac1 本地绿源适配器：扫描建索引/标题关键词匹配/惰性哈希/KB_LOCAL_CORPUS 覆盖/扫不到→available=False
  ac2 渠道注册表：local ON；wenku 黄源默认 OFF（env+secret 双闸）；ima 登录态失效→OFF 降级；gb 手动批处理 OFF
  ac3 pipeline 全链：按蓝图建树/绿源真实文件复制（copy 非 move）/每目录 _INDEX.md/
      manifest.json/获取指引清单/免责与来源说明页/zip（镜像树根名=知识库名）
  ac4 SMTP 缺配→企微降级（mock subprocess，绝不真发、绝不崩）
  ac5 包 >50MB→只发网盘占位说明（mock smtplib，不真发）
  ac6 订单箱移动语义：成功→done/，失败→failed/ 带原因 sidecar；绝不删除；ledger 留痕
"""
import json
import os
import subprocess
import sys
import zipfile
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[3]))  # 仓库根入 sys.path

from kb_factory.fulfillment.order import Order, OrderInbox
from kb_factory.fulfillment.sources_local import LocalCorpus
from kb_factory.fulfillment.sources_registry import registry
from kb_factory.fulfillment import pipeline, deliver


# ---------------------------------------------------------------- fixtures

PDF_BYTES = b"%PDF-1.4 fake report body for W7 test"


def make_corpus(tmp: Path) -> Path:
    """tmp 本地语料：自产研报 PDF 目录 + 知识件 .md 目录。"""
    reports = tmp / "corpus" / "reports"
    knowledge = tmp / "corpus" / "knowledge"
    reports.mkdir(parents=True)
    knowledge.mkdir(parents=True)
    (reports / "中国水电市场研究报告2026.pdf").write_bytes(PDF_BYTES)
    (reports / "水利水电EPC总承包实战指南.pdf").write_bytes(PDF_BYTES + b"v2")
    (knowledge / "危险源辨识与风险评价方法.md").write_text("# 危险源辨识\n正文", encoding="utf-8")
    (knowledge / "重大事故隐患判定导则.md").write_text("# 隐患判定\n正文", encoding="utf-8")
    return tmp / "corpus"


def make_blueprint(tmp: Path) -> Path:
    """迷你蓝图：1 个 L1、2 个 L2、7 槽（覆盖绿命中/绿未命中/黄/ima/gb/红）。"""
    def slot(name, ext, title, badge, perm):
        return {"name": name, "path": "MK-01/01/", "tier": "core", "ext": ext,
                "title": title, "badge": badge, "perm": perm,
                "identifier": "T-" + name, "checksum_slot": None}

    bp = {
        "domain": "水利EPC",
        "need": {"domain": "水利EPC", "keywords": ["水利水电"], "intent": "施工", "size_hint": "small"},
        "tree": {
            "mode": "test", "root": "测试知识库",
            "l1": [{
                "code": "MK", "dir": "MK-01", "path": "MK-01/", "name": "市场库",
                "theme": "市场库（MK）：市场 · 研究", "source": "test",
                "l2": [
                    {"code": "MK-01/01", "dir": "01", "path": "MK-01/01/", "name": "区域市场报告",
                     "theme": "区域市场报告：市场主题组", "file_count": 4, "files": [
                         slot("区域市场报告_core_001.pdf", "pdf", "中国水电市场研究报告2026", "self_owned", "green"),
                         slot("区域市场报告_core_002.md", "md", "危险源辨识与风险评价方法", "self_owned", "green"),
                         slot("区域市场报告_core_003.pdf", "pdf", "完全不存在的绿源占位文件", "green_free", "green"),
                         slot("区域市场报告_core_004.pdf", "pdf", "文库黄源文件", "wenku_vip", "yellow"),
                     ]},
                    {"code": "MK-01/02", "dir": "02", "path": "MK-01/02/", "name": "研究成果",
                     "theme": "研究成果：研究主题组", "file_count": 3, "files": [
                         slot("研究成果_core_001.md", "md", "ima渠道占位文件", "ima_public", "green"),
                         slot("研究成果_core_002.pdf", "pdf", "国标占位文件", "gb_free", "green"),
                         slot("研究成果_core_003.pdf", "pdf", "红色渠道占位文件", "self_owned", "red"),
                     ]},
                ],
            }],
        },
        "stats": {"files": 7},
    }
    p = tmp / "bp.json"
    p.write_text(json.dumps(bp, ensure_ascii=False), encoding="utf-8")
    return p


def make_order(tmp: Path, bp_path: Path, order_id: str = "ORD-W7-001") -> Path:
    od = tmp / "inbox"
    od.mkdir(parents=True, exist_ok=True)
    p = od / f"{order_id}.json"
    p.write_text(json.dumps({
        "id": order_id, "need_text": "水利水电EPC 知识库", "blueprint_ref": str(bp_path),
        "email": "buyer@example.com", "version_selection": "original",
        "price": "199.00", "paid_at": "2026-10-22T10:00:00", "status": "paid",
    }, ensure_ascii=False), encoding="utf-8")
    return p


# ---------------------------------------------------------------- ac1 本地绿源

def test_w7_ac1_local_corpus_scan_match_lazy_hash(tmp_path):
    corpus_dir = make_corpus(tmp_path)
    lc = LocalCorpus(roots=[str(corpus_dir)])
    assert lc.scan() is True and lc.available is True
    assert lc.size() == 4

    hits = lc.match("中国水电市场研究报告", limit=2)
    assert hits and hits[0].title == "中国水电市场研究报告2026"
    assert hits[0].ext == "pdf"

    hits2 = lc.match("危险源辨识与风险评价方法", limit=1)
    assert hits2 and hits2[0].ext == "md"

    # 惰性哈希：64 位十六进制，二次调用走缓存且值一致
    h1, h2 = hits[0].sha256(), hits[0].sha256()
    assert len(h1) == 64 and h1 == h2

    # 查不到 → 空列表
    assert lc.match("不存在的关键词xyzq", limit=3) == []


def test_w7_ac1_local_corpus_env_override_and_unavailable(tmp_path, monkeypatch):
    corpus_dir = make_corpus(tmp_path)
    monkeypatch.setenv("KB_LOCAL_CORPUS", str(corpus_dir))
    lc = LocalCorpus()  # 走 env 覆盖
    assert lc.scan() is True and lc.size() == 4

    empty = tmp_path / "empty"
    empty.mkdir()
    monkeypatch.setenv("KB_LOCAL_CORPUS", str(empty))
    lc2 = LocalCorpus()
    assert lc2.scan() is False and lc2.available is False and lc2.size() == 0


# ---------------------------------------------------------------- ac2 渠道注册表

def test_w7_ac2_registry_defaults_and_wenku_double_gate(tmp_path, monkeypatch):
    monkeypatch.delenv("KB_WENKU_FETCH", raising=False)
    monkeypatch.delenv("KB_IMA_FETCH", raising=False)
    reg = registry(env=os_env(monkeypatch), wenku_secret=str(tmp_path / "nope.secret"),
                   corpus_available=True)
    assert reg["local"].on is True and reg["local"].perm == "green"
    assert reg["wenku"].on is False and reg["wenku"].perm == "yellow"
    assert "OFF" in reg["wenku"].reason or "双闸" in reg["wenku"].reason
    assert reg["ima"].on is False and "登录态" in reg["ima"].reason
    assert reg["gb"].on is False and "std-samr-gb" in reg["gb"].reason

    # 双闸：env=1 但 secret 不在位 → 仍 OFF
    monkeypatch.setenv("KB_WENKU_FETCH", "1")
    reg2 = registry(env=os_env(monkeypatch), wenku_secret=str(tmp_path / "nope.secret"))
    assert reg2["wenku"].on is False

    # env=1 且 secret 在位 → ON
    secret = tmp_path / "wenku.secret.ini"
    secret.write_text("[wenku]\nuser=demo\n", encoding="utf-8")
    reg3 = registry(env=os_env(monkeypatch), wenku_secret=str(secret))
    assert reg3["wenku"].on is True

    # 本地语料不可用 → local OFF 且带原因
    reg4 = registry(env=os_env(monkeypatch), wenku_secret=str(tmp_path / "nope.secret"),
                    corpus_available=False)
    assert reg4["local"].on is False and reg4["local"].reason


def os_env(monkeypatch):
    import os
    return dict(os.environ)


# ---------------------------------------------------------------- ac3 pipeline 全链

def test_w7_ac3_pipeline_full_chain(tmp_path):
    corpus_dir = make_corpus(tmp_path)
    bp_path = make_blueprint(tmp_path)
    order_json = make_order(tmp_path, bp_path)
    order = Order.from_json(order_json)

    base = tmp_path / "base"
    res = pipeline.run(order, base_dir=base, corpus=LocalCorpus(roots=[str(corpus_dir)]))

    kb_root = base / "outbox" / order.id / "测试知识库"
    assert res.kb_name == "测试知识库"
    assert (kb_root / "MK-01" / "01").is_dir() and (kb_root / "MK-01" / "02").is_dir()

    # 绿命中：真实文件被复制（copy 非 move，源仍在）；_INDEX.md 不算交付件
    delivered = [p for p in (kb_root / "MK-01" / "01").iterdir()
                 if p.name != "_INDEX.md"]
    assert len(delivered) == 2
    src_pdf = corpus_dir / "reports" / "中国水电市场研究报告2026.pdf"
    assert src_pdf.exists()  # copy 非 move
    assert delivered[0].read_bytes() == PDF_BYTES or (kb_root / "MK-01" / "01" /
           "中国水电市场研究报告2026.pdf").read_bytes() == PDF_BYTES

    # 每目录 _INDEX.md：编号/主题/文件表
    for idx in [kb_root / "MK-01" / "_INDEX.md", kb_root / "MK-01" / "01" / "_INDEX.md",
                kb_root / "MK-01" / "02" / "_INDEX.md"]:
        assert idx.is_file(), idx
        text = idx.read_text(encoding="utf-8")
        assert "路径编号" in text and "主题" in text and "文件表" in text

    # manifest.json：统计 + 每文件徽章/权限/来源URL/哈希槽 + 渠道状态
    mf = json.loads((kb_root / "manifest.json").read_text(encoding="utf-8"))
    assert mf["stats"]["slots"] == 7 and mf["stats"]["delivered"] == 2 and mf["stats"]["guide"] == 5
    assert mf["order"]["id"] == order.id
    names = {f["slot"] for f in mf["files"]}
    assert names == {"区域市场报告_core_001.pdf", "区域市场报告_core_002.md",
                     "区域市场报告_core_003.pdf", "区域市场报告_core_004.pdf",
                     "研究成果_core_001.md", "研究成果_core_002.pdf", "研究成果_core_003.pdf"}
    for f in mf["files"]:
        for key in ("badge", "perm", "source_url", "sha256"):
            assert key in f
        if f["status"] == "delivered":
            assert f["sha256"] and len(f["sha256"]) == 64 and f["source_path"]
    ch = {c["name"]: c for c in mf["channels"]}
    assert ch["local"]["on"] is True and ch["wenku"]["on"] is False

    # 获取指引清单：黄/绿未命中/ima/gb/红 各自的建议获取路径
    guide = (kb_root / "获取指引清单.md").read_text(encoding="utf-8")
    assert "需文库会员" in guide
    assert "已列入扩源计划" in guide
    assert "std-samr-gb" in guide
    assert "建议官方渠道购买" in guide
    assert "ima" in guide

    # 免责与来源说明页
    assert (kb_root / "使用与来源说明.md").is_file()

    # zip：镜像树根名=知识库名，含 manifest
    assert Path(res.zip_path).is_file()
    with zipfile.ZipFile(res.zip_path) as z:
        nl = z.namelist()
    assert all(n.startswith("测试知识库/") for n in nl)
    assert "测试知识库/manifest.json" in nl
    assert "测试知识库/获取指引清单.md" in nl


# ---------------------------------------------------------------- ac4 SMTP 缺配降级

def test_w7_ac4_smtp_missing_wecom_fallback(tmp_path, monkeypatch):
    bp_path = make_blueprint(tmp_path)
    order_json = make_order(tmp_path, bp_path)
    order = Order.from_json(order_json)
    zip_path = tmp_path / "pkg.zip"
    zip_path.write_bytes(b"PK-fake")

    calls = []
    monkeypatch.setattr(subprocess, "run", lambda cmd, **kw: calls.append(cmd) or _FakeProc(0))
    res = deliver.deliver(order, zip_path,
                          smtp_secret=str(tmp_path / "missing.secret"))
    assert res.mode == "wecom_fallback"
    assert zip_path.exists()  # 包留在 outbox，绝不崩
    assert calls and calls[0][1:3] == ["-X", "utf8"]
    flat = " ".join(calls[0])
    assert "KB交付待发" in flat and order.id in flat and order.email in flat and "pkg.zip" in flat


class _FakeProc:
    def __init__(self, rc):
        self.returncode = rc


# ---------------------------------------------------------------- ac5 >50MB 网盘占位

def test_w7_ac5_oversize_netdisk_placeholder(tmp_path, monkeypatch):
    bp_path = make_blueprint(tmp_path)
    order = Order.from_json(make_order(tmp_path, bp_path, "ORD-W7-BIG"))
    big = tmp_path / "big.zip"
    big.write_bytes(b"\0" * (50 * 1024 * 1024 + 1))
    cfg = {"host": "smtp.test", "port": 465, "user": "a@t", "password": "x", "ssl": True}

    sent = []
    monkeypatch.setattr(deliver.smtplib, "SMTP_SSL", _FakeSMTP(sent))
    monkeypatch.setattr(deliver.smtplib, "SMTP", _FakeSMTP(sent))
    monkeypatch.setattr(deliver, "_wecom_notify", lambda *a, **k: True)
    res = deliver.deliver(order, big, cfg=cfg)
    assert res.mode == "netdisk_pending"
    assert sent and sent[0]["attachments"] == []  # 不带附件，只发占位说明
    assert "网盘" in sent[0]["body"]


class _FakeSMTP:
    def __init__(self, log):
        self._log = log

    def __call__(self, *a, **kw):
        self._inst = object.__new__(type(self))
        self._inst._log = self._log
        self._inst._a = a
        return self._inst

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False

    def login(self, *a):
        pass

    def send_message(self, msg):
        payload = msg.get_payload()
        if isinstance(payload, list):
            texts, atts = [], []
            for p in payload:
                fn = p.get_filename()
                if fn:
                    atts.append(fn)
                else:
                    texts.append(p.get_payload(decode=True).decode("utf-8", "replace"))
            body, attachments = "\n".join(texts), atts
        else:
            body, attachments = str(payload), []
        self._log.append({"to": [str(x) for x in msg["To"].split(",")],
                          "subject": str(msg["Subject"]),
                          "body": body, "attachments": attachments})


# ---------------------------------------------------------------- ac6 订单箱移动语义

def test_w7_ac6_order_box_move_semantics(tmp_path, monkeypatch):
    from kb_factory.fulfillment.__main__ import process_one
    corpus_dir = make_corpus(tmp_path)
    bp_path = make_blueprint(tmp_path)

    monkeypatch.setenv("KB_LOCAL_CORPUS", str(corpus_dir))
    base = tmp_path / "base"
    inbox = OrderInbox(base)
    inbox.ensure_dirs()
    good = make_order(tmp_path / "box", bp_path, "ORD-W7-OK")
    (base / "inbox").mkdir(parents=True, exist_ok=True)
    import shutil
    shutil.copy(good, base / "inbox" / good.name)
    bad = base / "inbox" / "ORD-W7-BAD.json"
    bad.write_text(json.dumps({"id": "ORD-W7-BAD", "blueprint_ref": str(tmp_path / "无.json"),
                               "email": "b@t"}), encoding="utf-8")

    monkeypatch.setattr(deliver, "_wecom_notify", lambda *a, **k: True)
    entries = [process_one(p, inbox, base_dir=base) for p in inbox.pending()]

    assert (base / "done" / "ORD-W7-OK.json").is_file()
    assert not (base / "inbox" / "ORD-W7-OK.json").exists()
    assert (base / "failed" / "ORD-W7-BAD.json").is_file()          # 移动非删除
    reason = base / "failed" / "ORD-W7-BAD.reason.txt"
    assert reason.is_file() and "蓝图" in reason.read_text(encoding="utf-8")

    by_id = {e["order"]: e for e in entries}
    assert by_id["ORD-W7-OK"]["result"] in ("ok", "ok_wecom_fallback")  # judge-W7#5: 投递态如实分级
    assert by_id["ORD-W7-OK"]["build"]["delivered"] == 2
    assert by_id["ORD-W7-BAD"]["result"] == "failed"

    ledger = (base / "ledger.jsonl").read_text(encoding="utf-8").strip().splitlines()
    assert len(ledger) == 2
    lines = [json.loads(x) for x in ledger]
    ok_line = next(x for x in lines if x["order"] == "ORD-W7-OK")
    assert ok_line["result"] in ("ok", "ok_wecom_fallback") and ok_line["sla"]["target_min"] == 30  # judge-W7#5: 投递态分级
    bad_line = next(x for x in lines if x["order"] == "ORD-W7-BAD")
    assert bad_line["result"] == "failed" and "蓝图" in bad_line["error"]
