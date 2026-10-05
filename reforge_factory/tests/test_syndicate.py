# -*- coding: utf-8 -*-
"""FT-4 辛迪加转载检测 — 测试 (从 reforge_factory 目录跑, 只跑本文件).

对标 hyperresearch#2: 辛迪加转载不算共识, 5 份通稿 = 1 票;
同文多站转发不得冒充多源共识骗亮 ✓饱和灯.
"""
import copy
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # 仓根

import ammo_pool                                   # noqa: E402 (接线冒烟)
from syndicate import (effective_hosts, minhash_sig,  # noqa: E402
                       normalize_for_sim, row_host, shingle_set, sim_estimate,
                       syndicate_groups)

CJK = [chr(0x4E00 + i) for i in range(520)]        # 互不相同汉字 (受控相似度)


def _row(host: str, text: str) -> dict:
    return {"url_norm": f"https://{host}/art.html",
            "source_path": f"E:/tmp/{host}.md", "text_head": text}


def test_normalize_for_sim():
    assert normalize_for_sim("A，B。 C_D!") == "abcd"   # 剥标点+空白+小写
    assert len(normalize_for_sim("字" * 900)) == 500    # 取头 500 字


def test_minhash_deterministic():
    """同输入两次签名一致 (禁 random, 跨进程可复现)."""
    text = "".join(CJK[:200])
    assert minhash_sig(shingle_set(text)) == minhash_sig(shingle_set(text))
    assert minhash_sig(frozenset()) == ()               # 空集=空签名


def test_three_station_syndicate_one_vote():
    """3 站转载同一文 → 独立源计数 = 1 (通稿不冒充共识)."""
    text = "".join(CJK[:200])
    rows = [_row(h, text) for h in ("a.com", "b.com", "c.com")]
    gids = syndicate_groups(rows)
    assert gids[0] is not None and gids == [gids[0]] * 3
    assert effective_hosts(rows) == frozenset({gids[0]})


def test_two_distinct_articles_two_votes():
    """2 篇不同文 → 独立源计数 = 2."""
    rows = [_row("a.com", "".join(CJK[:200])),
            _row("d.com", "".join(CJK[200:400]))]
    assert syndicate_groups(rows) == [None, None]
    assert effective_hosts(rows) == frozenset({"a.com", "d.com"})


def test_single_row_not_folded():
    """单行无折叠: 原样贡献自身 host."""
    rows = [_row("solo.com", "".join(CJK[:200]))]
    assert syndicate_groups(rows) == [None]
    assert effective_hosts(rows) == frozenset({"solo.com"})


def test_same_host_group_not_folded():
    """组内 host 数 <=1 不折叠 (同站多件本来就是 1 源)."""
    text = "".join(CJK[:200])
    rows = [_row("s.com", text), _row("s.com", text)]
    assert effective_hosts(rows) == frozenset({"s.com"})


def test_threshold_boundary():
    """阈值边界: 0.9 相似过阈 (同组), ~0.5 不过阈 (不同组)."""
    a = "".join(CJK[:200])
    hi = "".join(CJK[:190] + CJK[400:410])       # 真 Jaccard ≈ 0.90
    mid = "".join(CJK[:133] + CJK[410:477])      # 真 Jaccard ≈ 0.49
    sa, sh, sm = (minhash_sig(shingle_set(t)) for t in (a, hi, mid))
    assert sim_estimate(sa, sh) >= 0.8
    assert sim_estimate(sa, sm) < 0.8
    assert syndicate_groups(
        [_row("a.com", a), _row("b.com", hi)])[0] is not None
    assert syndicate_groups(
        [_row("a.com", a), _row("b.com", mid)]) == [None, None]


def test_effective_hosts_is_pure():
    """纯函数: 不改传入 rows (immutability)."""
    rows = [_row("a.com", "".join(CJK[:200])),
            _row("b.com", "".join(CJK[:200]))]
    snap = copy.deepcopy(rows)
    effective_hosts(rows)
    assert rows == snap


def test_rows_without_text_head_pass_through():
    """缺 text_head 的行原样参与 (fail-soft, 不折叠)."""
    rows = [{"url_norm": "https://a.com/x", "source_path": "E:/t/a.md"},
            {"url_norm": "https://b.com/y", "source_path": "E:/t/b.md"}]
    assert effective_hosts(rows) == frozenset({"a.com", "b.com"})


def test_ammo_pool_wiring():
    """fail-soft import 接线在位: coverage() 拿到的是本件 effective_hosts."""
    assert ammo_pool.effective_hosts is effective_hosts


# ---------- E1: ingest 落 text_head (生产空转根治) ----------
def test_ingest_writes_text_head_and_coverage_folds(tmp_path, monkeypatch,
                                                    capsys):
    """E1 集成回归: 真调 ingest() → manifest 行必含 text_head → 3 站转载
    同一文喂 coverage() 后折叠成 1 独立源 (syndicate_groups=1, 灯=△单源,
    通稿不再冒充多源共识灌水饱和门)."""
    monkeypatch.setattr(ammo_pool, "POOL_ROOT", tmp_path)   # 不碰真池
    cid = "E1-FOLD"
    d = tmp_path / cid
    ammo_pool._save_state(d, {**ammo_pool._load_state(d),     # init 等效
                              "kws": ["水库"]})
    (d / "question_tree.json").write_text(json.dumps({   # G1 schema: 1 问 1 EEI
        "topic": "示范课题",
        "subquestions": [{"id": "Q1", "dim": "事实", "text": "问",
                          "eeis": [{"id": "Q1-E1", "text": "eei"}]}]},
        ensure_ascii=False), encoding="utf-8")
    body = "水库EPC课题样板文章。" + "".join(CJK[:400])
    for h in ("news-a.com", "news-b.com", "news-c.com"):
        f = tmp_path / f"art-{h.replace('.', '_')}.md"
        f.write_text(body, encoding="utf-8")
        assert ammo_pool.ingest(cid, str(f), "own:test",
                                url=f"https://{h}/art.html",
                                tree="Q1-E1") == 0
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    assert len(rows) == 3                               # 3 站各自入池
    assert all(r.get("text_head") for r in rows)         # E1 主断言: 行含键
    assert {r["text_head"] for r in rows} == {body[:500]}
    assert ammo_pool.judge(cid) == 0                     # 全部判 valid
    assert ammo_pool.coverage(cid) == 0
    capsys.readouterr()
    tree = json.loads((d / "question_tree.json")
                      .read_text(encoding="utf-8"))
    assert tree["coverage"]["syndicate_groups"] == 1     # 3 站通稿 = 1 组
    assert tree["subquestions"][0]["eeis"][0]["status"] == "single"


# ---------- E2: row_host 域名级折叠 ----------
def test_row_host_domain_folding():
    """E2 回归: 同站 www/bare (及 m./old./端口) 双形态算 1 独立源,
    不再被 netloc 的站型噪声拆成 2 源."""
    rows = [_row("www.a.com", "".join(CJK[:200])),
            _row("a.com", "".join(CJK[200:400]))]        # 不同文, 只测 host
    assert effective_hosts(rows) == frozenset({"a.com"})
    assert row_host({"url_norm": "https://m.A.com:8080/x"}) == "a.com"
    assert row_host({"url_norm": "https://old.a.com/x"}) == "a.com"
    assert row_host({"url_norm": "https://www.www.a.com/x"}) == "a.com"
    assert row_host({"url_norm": "", "source_path": "E:/t/b.md"}) == "b"


# ---------- E3: ingest 记权威度两键 (FT-5 接线) ----------
def test_ingest_records_authority(tmp_path, monkeypatch):
    """E3 回归: authority 可用 → 行落 authority_score/authority_grade 两键
    (分数取 authority().score, 档取 grade_authority(分数)); import 不可用
    (置 None) → 行缺这两键, ingest 照常不炸."""
    monkeypatch.setattr(ammo_pool, "POOL_ROOT", tmp_path)
    cid = "E3-AUTH"
    d = tmp_path / cid
    d.mkdir()
    f1 = tmp_path / "a.md"
    f1.write_text("权威度样板内容" * 10, encoding="utf-8")
    monkeypatch.setattr(ammo_pool, "authority",
                        lambda u: {"score": 9, "tier": "省级政府/监管",
                                   "rule": "测试打分"})
    monkeypatch.setattr(ammo_pool, "grade_authority",
                        lambda s: "A" if s >= 8 else "D")
    assert ammo_pool.ingest(cid, str(f1), "own:test",
                            url="https://www.gov.cn/x") == 0
    row = json.loads((d / "manifest.jsonl")
                     .read_text(encoding="utf-8").splitlines()[0])
    assert row["authority_score"] == 9 and row["authority_grade"] == "A"

    monkeypatch.setattr(ammo_pool, "authority", None)    # 缺件形态
    monkeypatch.setattr(ammo_pool, "grade_authority", None)
    f2 = tmp_path / "b.md"
    f2.write_text("缺件形态另一篇内容" * 10, encoding="utf-8")
    assert ammo_pool.ingest(cid, str(f2), "own:test") == 0     # 不崩
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    assert len(rows) == 2
    assert "authority_score" not in rows[1]
    assert "authority_grade" not in rows[1]
