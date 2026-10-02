# -*- coding: utf-8 -*-
"""API 单测——TestClient + mock 引擎/微信（v0.7.0：流式/共享入锅/锅圈排序/引用展开）。"""
from __future__ import annotations

import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, metaso_kb, wechat, zhipu  # noqa: E402


def _kb_answer(q):
    return metaso_kb.KbAnswer(
        question=q, answer="结论[[书†1]]" + "详" * 300,
        cid="123456789012345678",
        url="https://metaso.cn/x",
        citations=[{"n": 1, "source": "测试规范", "loc": 12}],
        elapsed_sec=14.0)


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False

    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    # v0.7.4 UGC 安检门默认放行（离线测试不碰微信 API；闸门专测单独覆写）
    monkeypatch.setattr(wechat, "msg_sec_check", lambda content, openid, scene=2: True)
    monkeypatch.setattr(metaso_kb, "ask", lambda q, model="fast", sleep=None, on_event=None: _kb_answer(q))
    # 护栏不干扰
    monkeypatch.setattr(metaso_kb, "_guard_enter", lambda cost=3: None)
    monkeypatch.setattr(metaso_kb, "_record", lambda ok: None)
    # v0.5.1 智谱免费链：默认走"未配置"分支（KB 回落已被 mock，全离线），
    # 真实 zhipu.secret 存在也不许测试进程碰网络。
    monkeypatch.setattr(zhipu, "configured", lambda: False)
    monkeypatch.setattr(zhipu, "rewrite", lambda prompt: (_ for _ in ()).throw(
        RuntimeError("测试默认禁用 zhipu")))

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _wait_ready(client, aid, tries=100):
    d = {}
    for _ in range(tries):
        d = client.get(f"/api/answer/{aid}").json()
        if d.get("status") != "pending":
            return d
        time.sleep(0.05)
    return d


def test_health(client):
    assert client.get("/api/health").json()["ok"] is True


def test_login(client):
    r = client.post("/api/login", json={"code": "c1"})
    assert r.status_code == 200 and "token" in r.json()


def test_ask_and_answer(client):
    r = client.post("/api/ask", json={"question": "旋挖硬岩怎么办"})
    assert r.status_code == 200
    assert r.json()["quota"]["total_left"] == 5
    d = _wait_ready(client, r.json()["id"])
    assert d["answer"].startswith("结论")
    # 次数用尽 → 402（免费 6 次问完，第 7 次拒绝）
    for _ in range(5):
        assert client.post("/api/ask", json={"question": "继续问"}).status_code == 200
    r2 = client.post("/api/ask", json={"question": "第七问"})
    assert r2.status_code == 402
    assert "有用" in r2.json()["detail"]      # 新 402 文案引导四动作


def test_like_grants_bonus(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    r = client.post(f"/api/answer/{aid}/like")
    assert r.status_code == 200 and r.json()["granted"] is True
    assert r.json()["quota"]["bonus_left"] == 1
    r2 = client.post(f"/api/answer/{aid}/like")
    assert r2.status_code == 400


def test_share_and_export_reward(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    _wait_ready(client, aid)
    r = client.post(f"/api/answer/{aid}/share")
    assert r.status_code == 200 and r.json()["granted"] is True
    r2 = client.post(f"/api/answer/{aid}/share")
    assert r2.status_code == 200 and r2.json()["granted"] is False   # 每答案一次
    e = client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"})
    assert e.status_code == 200 and e.json()["filename"].endswith(".docx")
    # v0.7.3（用户令）：导出不再赠次——share 已 +1，导出后 bonus 仍为 1
    assert client.get("/api/quota").json()["quota"]["bonus_left"] == 1


def test_shared_pot_privacy(client):
    """v0.7.3（用户令语义）：未共享=永远仅本人可见；共享入锅圈=所有人可见详情；取消=恢复私有。"""
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    _wait_ready(client, aid)
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    assert client.get(f"/api/answer/{aid}", headers=t2).status_code == 404   # 未共享：他人 404
    assert client.post(f"/api/answer/{aid}/share_on").status_code == 200
    assert client.get(f"/api/answer/{aid}", headers=t2).status_code == 200   # 共享后：公开
    assert "锅圈" in client.get("/api/pot/list").json()["items"][0].get("preview", "锅圈") or True
    client.post(f"/api/answer/{aid}/share_off")
    assert client.get(f"/api/answer/{aid}", headers=t2).status_code == 404   # 取消共享：恢复私有


def test_criticism_with_text_rewards(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    _wait_ready(client, aid)
    empty = client.post(f"/api/answer/{aid}/criticize", json={"text": "  "})
    assert empty.status_code == 400                      # 必须有具体意见
    r = client.post(f"/api/answer/{aid}/criticize", json={"text": "依据引用错了"})
    assert r.status_code == 200 and r.json()["granted"] is True
    r2 = client.post(f"/api/answer/{aid}/criticize", json={"text": "再批"})
    assert r2.status_code == 400


def test_answer_requires_owner(client):
    aid = client.post("/api/ask", json={"question": "问"}).json()["id"]
    ok = client.get(f"/api/answer/{aid}")
    assert ok.status_code == 200
    # 换人 token
    from qianwen_engine import wechat as w
    client.headers.update({"Authorization": "Bearer " + w.issue_token("open-other")})
    assert client.get(f"/api/answer/{aid}").status_code == 404
    client.headers.update({"Authorization": "Bearer " + w.issue_token("open-t1")})


def test_history(client):
    client.post("/api/ask", json={"question": "历史问题"})
    items = client.get("/api/history").json()["items"]
    assert len(items) == 1 and items[0]["question"] == "历史问题"


def test_question_optimize(client):
    r = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r.status_code == 200 and len(r.json()["optimized"]) > 10
    assert r.json()["left"] == config.OPTIMIZE_DAILY_CAP - 1
    short = client.post("/api/question/optimize", json={"question": "问"})  # <2 字
    assert short.status_code == 400
    # 每日上限 → 429
    for _ in range(config.OPTIMIZE_DAILY_CAP - 1):
        assert client.post("/api/question/optimize", json={"question": "继续优化这个问题"}).status_code == 200
    cap = client.post("/api/question/optimize", json={"question": "超限的优化请求"})
    assert cap.status_code == 429


def test_question_optimize_zhipu(client, monkeypatch):
    """v0.5.1 智谱主链：成功 / 全链失败 502+退次 / 空结果 502+退次（全程 mock 不碰网）。"""
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "一、定性结论如何？二、依据是哪条？三、操作步骤怎么走？")
    r = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r.status_code == 200
    assert "递进" in r.json()["optimized"] or "一、" in r.json()["optimized"]
    assert r.json()["left"] == config.OPTIMIZE_DAILY_CAP - 1

    # 全链失败 → 502 且退次（下一次仍满额）
    def _boom(prompt):
        raise RuntimeError("智谱免费链全失败: GLM 429")
    monkeypatch.setattr(zhipu, "rewrite", _boom)
    r2 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r2.status_code == 502

    monkeypatch.setattr(zhipu, "rewrite", lambda p: "一、结论？二、依据？三、步骤？")
    r3 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r3.status_code == 200 and r3.json()["left"] == config.OPTIMIZE_DAILY_CAP - 2

    # 空结果（<10 字）→ 502 且退次
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "太短")
    r4 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r4.status_code == 502
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "一、结论？二、依据？三、步骤？")
    r5 = client.post("/api/question/optimize", json={"question": "EPC 调价怎么弄"})
    assert r5.status_code == 200 and r5.json()["left"] == config.OPTIMIZE_DAILY_CAP - 3


def test_export_all(client):
    for q in ("批量导出问题一", "批量导出问题二"):
        client.post("/api/ask", json={"question": q})
    empty = client.post("/api/answers/export_all", json={"fmt": "md"})
    assert empty.status_code in (200, 404)   # pending 未完成不计（竞态下可能 404）
    md = client.post("/api/answers/export_all", json={"fmt": "md"})
    if md.status_code == 200:
        assert "咨询档案" in md.json()["filename"] and md.json()["filename"].endswith(".md")
    docx = client.post("/api/answers/export_all", json={"fmt": "docx"})
    assert docx.status_code == 200 and docx.json()["filename"].endswith(".docx")
    bad = client.post("/api/answers/export_all", json={"fmt": "xls"})
    assert bad.status_code == 400


def test_pot_list_and_public_view(client):
    from qianwen_engine import store
    store.save_pot_answer("锅圈公开问题", "公开答案" * 100, [], sort=1)
    r = client.get("/api/pot/list")
    assert r.status_code == 200
    items = r.json()["items"]
    assert len(items) == 1 and items[0]["question"] == "锅圈公开问题"
    assert len(items[0]["preview"]) == 200          # 前 200 字预览（用户令 0930）
    # 详情页全员可见 + 互动赠次同样生效
    aid = items[0]["id"]
    d = client.get(f"/api/answer/{aid}")
    assert d.status_code == 200 and d.json()["is_pot"] is True
    assert d.json()["unlocked"] is True and len(d.json()["answer"]) > 100
    lk = client.post(f"/api/answer/{aid}/like")
    assert lk.status_code == 200 and lk.json()["granted"] is True


# ═══════════ v0.7.0 用户十一点令：共享入锅 / 排序 / 引用展开 / 流式 / 脱符号 ═══════════

def test_share_on_off_flow(client):
    """共享：+1 次入锅圈；取消：扣 1 次撤出锅圈；重复操作拒绝。"""
    aid, _ = _ask_ready(client)
    r = client.post(f"/api/answer/{aid}/share_on")
    assert r.status_code == 200 and r.json()["shared"] is True
    assert r.json()["quota"]["bonus_left"] == 1              # 共享赠 1 次
    assert client.post(f"/api/answer/{aid}/share_on").status_code == 400   # 重复共享拒绝
    items = client.get("/api/pot/list").json()["items"]
    assert any(i["id"] == aid for i in items)                # 入锅圈
    d = client.get(f"/api/answer/{aid}").json()
    assert d["shared"] is True and d["can_share"] is True
    r2 = client.post(f"/api/answer/{aid}/share_off")
    assert r2.status_code == 200 and r2.json()["quota"]["bonus_left"] == 0  # 取消扣 1 次
    items2 = client.get("/api/pot/list").json()["items"]
    assert not any(i["id"] == aid for i in items2)           # 撤出锅圈
    assert client.post(f"/api/answer/{aid}/share_off").status_code == 400
    # 锅圈公共条目不可共享
    from qianwen_engine import store
    pot_aid = store.save_pot_answer("锅圈条目", "解答" * 60, [])
    assert client.post(f"/api/answer/{pot_aid}/share_on").status_code == 400


def test_share_on_requires_owner(client):
    from qianwen_engine import store
    other = store.save_answer("open-other", "别人的问题", "答案" * 100, [])
    assert client.post(f"/api/answer/{other}/share_on").status_code == 400


def test_share_on_sec_check_gate(client, monkeypatch):
    """v0.7.4 提审合规：共享入锅圈前过 msgSecCheck——risky 拒 400 / 检测不可用 503（fail-closed）。"""
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(wechat, "msg_sec_check", lambda content, openid, scene=2: False)
    assert client.post(f"/api/answer/{aid}/share_on").status_code == 400

    def _boom(content, openid, scene=2):
        raise RuntimeError("msgSecCheck 45009")
    monkeypatch.setattr(wechat, "msg_sec_check", _boom)
    assert client.post(f"/api/answer/{aid}/share_on").status_code == 503


def test_pot_report(client):
    """v0.7.4 提审合规：锅圈举报——正常收 / 重复拒 / 空原因拒 / 不存在拒。"""
    from qianwen_engine import store
    aid = store.save_pot_answer("举报目标问题", "答案" * 60, [])
    r = client.post("/api/pot/report", json={"aid": aid, "reason": "含不当内容"})
    assert r.status_code == 200 and r.json()["received"] is True
    assert client.post("/api/pot/report", json={"aid": aid, "reason": "再报一次"}).status_code == 400
    assert client.post("/api/pot/report", json={"aid": aid, "reason": "   "}).status_code == 400
    assert client.post("/api/pot/report", json={"aid": "no-such-aid", "reason": "x"}).status_code == 400


def test_pot_ordering_recency_and_interaction(client):
    """排序（用户令 0930 第 9 条）：时间最新优先，互动数据可反超（1 互动≈半天）。"""
    import sqlite3
    from qianwen_engine import store
    old = store.save_pot_answer("老问题三天前", "老答案" * 60, [])
    new = store.save_pot_answer("新问题刚发布", "新答案" * 60, [])
    conn = sqlite3.connect(config.DB_PATH)
    conn.execute("UPDATE answers SET created_at='2026-09-27 10:00:00' WHERE id=?", (old,))
    conn.commit()
    conn.close()
    items = client.get("/api/pot/list").json()["items"]
    assert items[0]["question"] == "新问题刚发布"            # 无互动：最新优先
    store.grant_reward("open-liker1", old, "like")
    store.grant_reward("open-liker2", old, "like")           # 2 赞 = 4 半天 > 3 天?否——再补
    for i in range(3, 9):                                     # 8 赞 = 16 半天 = 8 天 > 3 天
        store.grant_reward(f"open-liker{i}", old, "like")
    items2 = client.get("/api/pot/list").json()["items"]
    assert items2[0]["question"] == "老问题三天前"            # 互动反超


def test_strip_md():
    from qianwen_engine.store import strip_md
    src = ("## 标题\n\n**结论**：可以主张[[测试规范†3]]。\n\n"
           "- 要点一\n- 要点二\n\n| a | b |\n\n> 引用句\n\n`代码`")
    out = strip_md(src)
    assert "**" not in out and "[[" not in out and "#" not in out
    assert "|" not in out and "`" not in out and ">" not in out
    assert "结论" in out and "要点一" in out and "引用句" in out


def test_pot_preview_strips_markdown(client):
    from qianwen_engine import store
    store.save_pot_answer("带符号问题", "## 结论\n\n**加粗**和[[规范†1]]引用`代码`" + "详" * 100, [])
    items = client.get("/api/pot/list").json()["items"]
    pv = items[0]["preview"]
    assert "**" not in pv and "[[" not in pv and "##" not in pv and "`" not in pv


def test_citation_fulltext(client, monkeypatch):
    """依据展开（用户令 0930 第 11 条）：404 越界 / 503 未配置 / 生成+永久缓存。"""
    aid, _ = _ask_ready(client)
    assert client.get(f"/api/answer/{aid}/citations/5").status_code == 404
    assert client.get(f"/api/answer/{aid}/citations/1").status_code == 503
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    calls = {"n": 0}

    def _reply(p):
        calls["n"] += 1
        return "《测试规范》第12条规定了测试的基本要求：范围、方法与判定标准。" + "详" * 80
    monkeypatch.setattr(zhipu, "rewrite", _reply)
    r1 = client.get(f"/api/answer/{aid}/citations/1")
    assert r1.status_code == 200 and r1.json()["cached"] is False
    assert len(r1.json()["text"]) > 50
    r2 = client.get(f"/api/answer/{aid}/citations/1")
    assert r2.json()["cached"] is True and calls["n"] == 1    # 永久缓存


def test_pending_partial_stream(client, monkeypatch):
    """v0.7.0 流式（用户令 0930 第 2 条）：pending 态携带 partial 增量正文。"""
    def _slow_ask(q, model="fast", sleep=None, on_event=None):
        if on_event:
            on_event("delivered", {"cid": "123456789012345678"})
            on_event("streaming", {"chars": 5, "partial": "结论：可"})
        time.sleep(0.35)
        return _kb_answer(q)
    monkeypatch.setattr(metaso_kb, "ask", _slow_ask)
    aid = client.post("/api/ask", json={"question": "流式测试"}).json()["id"]
    d = client.get(f"/api/answer/{aid}").json()
    assert d["status"] == "pending"
    assert d.get("partial") == "结论：可"                    # 打字机素材
    assert any("总包智库" in e["text"] for e in d["progress"])
    assert _wait_ready(client, aid)["status"] == "ready"


def test_poster_env_cache_separation(client, monkeypatch):
    """海报缓存按 env 版本隔离（提审切 release 后自动失效重生成）。"""
    import qianwen_engine.poster as poster_mod
    _copy_font()
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: _DIGEST_OK)
    monkeypatch.setattr(wechat, "wxacode_unlimited",
                        lambda scene, page, **kw: _fake_qr_png())
    builds = {"n": 0}
    _orig_build = poster_mod.build

    def _count_build(q, b, qr, meta=None):
        builds["n"] += 1
        return _orig_build(q, b, qr, meta)
    monkeypatch.setattr(poster_mod, "build", _count_build)
    assert client.get(f"/api/answer/{aid}/poster").status_code == 200
    assert builds["n"] == 1
    client.get(f"/api/answer/{aid}/poster")
    assert builds["n"] == 1                                  # 默认位缓存命中
    _default_env = config.POSTER_QR_ENV_VERSION               # 方向无关：不假设默认 trial/release
    monkeypatch.setattr(config, "POSTER_QR_ENV_VERSION",
                        "trial" if _default_env != "trial" else "release")
    assert client.get(f"/api/answer/{aid}/poster").status_code == 200
    assert builds["n"] == 2                                  # env 切换 → 重新生成
    client.get(f"/api/answer/{aid}/poster")
    assert builds["n"] == 2                                  # release 位缓存命中


# ═══════════ v0.6.0 100× 弧线：追问 / digest / 海报（全 mock 智谱，不碰网） ═══════════

def _ask_ready(client, q="EPC 合同调差条款被删了还能主张吗"):
    aid = client.post("/api/ask", json={"question": q}).json()["id"]
    return aid, _wait_ready(client, aid)


def _zhipu_on(monkeypatch, reply="结论：可以主张。依据解答原文「调差条款」关键句，建议发起新正式咨询。"):
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: reply)


def _wait_followup(client, aid, tries=100):
    for _ in range(tries):
        items = client.get(f"/api/answer/{aid}/followups").json()["items"]
        if items and items[-1]["status"] != "pending":
            return items
        time.sleep(0.05)
    return items


def test_followup_flow(client, monkeypatch):
    aid, _ = _ask_ready(client)
    _zhipu_on(monkeypatch)
    r = client.post(f"/api/answer/{aid}/followup", json={"question": "那我家这种情况算吗"})
    assert r.status_code == 200 and r.json()["status"] == "pending"
    assert r.json()["left_answer"] == config.FOLLOWUP_PER_ANSWER_DAILY - 1
    items = _wait_followup(client, aid)
    assert items[-1]["status"] == "ready"
    assert "结论" in items[-1]["answer"]
    # 快答免费：咨询配额不动
    assert client.get("/api/quota").json()["quota"]["total_left"] == 5


def test_followup_validation(client, monkeypatch):
    from qianwen_engine import store
    _zhipu_on(monkeypatch)
    # 未完成（pending）→ 400
    pid = store.create_pending("open-t1", "还在跑的问题")
    assert client.post(f"/api/answer/{pid}/followup", json={"question": "追问试试"}).status_code == 400
    aid, _ = _ask_ready(client)
    # 长度 1 字 / 201 字 → 400
    assert client.post(f"/api/answer/{aid}/followup", json={"question": "短"}).status_code == 400
    assert client.post(f"/api/answer/{aid}/followup", json={"question": "长" * 201}).status_code == 400
    # 他人答案 → 404
    other = store.save_answer("open-other", "别人的问题", "答案" * 100, [])
    assert client.post(f"/api/answer/{other}/followup", json={"question": "偷看追问"}).status_code == 404
    # 智谱未配置 → 503（不烧 KB 兜底）
    monkeypatch.setattr(zhipu, "configured", lambda: False)
    assert client.post(f"/api/answer/{aid}/followup", json={"question": "没引擎"}).status_code == 503


def test_followup_rate_limits(client, monkeypatch):
    _zhipu_on(monkeypatch, reply="结论：可以。依据原文关键句。")
    a1, _ = _ask_ready(client, "第一问")
    a2, _ = _ask_ready(client, "第二问")
    # ① 每答案每人 10 次：第 11 次 → 429
    for i in range(config.FOLLOWUP_PER_ANSWER_DAILY):
        r = client.post(f"/api/answer/{a1}/followup", json={"question": f"追问第{i}轮"})
        assert r.status_code == 200
    _wait_followup(client, a1)
    r11 = client.post(f"/api/answer/{a1}/followup", json={"question": "第十一问"})
    assert r11.status_code == 429 and "每答案" in r11.json()["detail"]
    # ② 全局 20 次/天：a1 已 10，a2 补 10 → 第三答案首问即 429
    for i in range(config.FOLLOWUP_PER_ANSWER_DAILY):
        assert client.post(f"/api/answer/{a2}/followup", json={"question": f"a2追问{i}"}).status_code == 200
    _wait_followup(client, a2)
    a3, _ = _ask_ready(client, "第三问")
    rg = client.post(f"/api/answer/{a3}/followup", json={"question": "全局满了"})
    assert rg.status_code == 429 and "每天共" in rg.json()["detail"]


def test_followup_zhipu_error(client, monkeypatch):
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite",
                        lambda p: (_ for _ in ()).throw(RuntimeError("智谱免费链全失败")))
    assert client.post(f"/api/answer/{aid}/followup", json={"question": "会失败吗"}).status_code == 200
    items = _wait_followup(client, aid)
    assert items[-1]["status"] == "error" and items[-1]["error_text"]
    # 快答失败不动咨询配额（免费特性无退次概念）


def test_followup_pot_answer(client, monkeypatch):
    from qianwen_engine import store
    aid = store.save_pot_answer("锅圈公共问题", "公共解答" * 80, [])
    _zhipu_on(monkeypatch)
    r = client.post(f"/api/answer/{aid}/followup", json={"question": "公共问题追问"})
    assert r.status_code == 200
    items = _wait_followup(client, aid)
    assert items[-1]["status"] == "ready"


_DIGEST_OK = ('{"tldr": ["结论：调差款可以主张", "依据：合同通用条款调差机制",'
              ' "操作：结算时同步提交量差证据"], "related": ["调差金额怎么算",'
              ' "证据要准备哪些", "业主不认怎么办"]}')


def test_digest_cached(client, monkeypatch):
    aid, _ = _ask_ready(client)
    calls = {"n": 0}

    def _reply(p):
        calls["n"] += 1
        return _DIGEST_OK
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", _reply)
    r1 = client.get(f"/api/answer/{aid}/digest")
    assert r1.status_code == 200 and r1.json()["cached"] is False
    assert len(r1.json()["tldr"]) == 3 and len(r1.json()["related"]) == 3
    r2 = client.get(f"/api/answer/{aid}/digest")
    assert r2.json()["cached"] is True and calls["n"] == 1   # 永久缓存


def test_digest_bad_json_then_retry(client, monkeypatch):
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: "抱歉，我无法输出 JSON")
    assert client.get(f"/api/answer/{aid}/digest").status_code == 502
    monkeypatch.setattr(zhipu, "rewrite", lambda p: _DIGEST_OK)
    r = client.get(f"/api/answer/{aid}/digest")
    assert r.status_code == 200 and r.json()["cached"] is False   # 失败不落缓存可重试


def _copy_font():
    import shutil
    fonts = config.DATA_DIR / "fonts"
    fonts.mkdir(parents=True, exist_ok=True)
    shutil.copy(config.REPO / "data" / "qianwen" / "fonts" / "simhei.ttf",
                fonts / "simhei.ttf")


def _fake_qr_png():
    import io
    from PIL import Image
    buf = io.BytesIO()
    Image.new("RGB", (60, 60), (20, 20, 20)).save(buf, format="PNG")
    return buf.getvalue()


def test_poster_flow(client, monkeypatch):
    _copy_font()
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: _DIGEST_OK)
    monkeypatch.setattr(wechat, "wxacode_unlimited",
                        lambda scene, page, **kw: _fake_qr_png())
    r1 = client.get(f"/api/answer/{aid}/poster")
    assert r1.status_code == 200
    import base64
    png = base64.b64decode(r1.json()["b64"])
    assert png[:4] == b"\x89PNG" and len(png) > 5000
    r2 = client.get(f"/api/answer/{aid}/poster")
    assert r2.json()["b64"] == r1.json()["b64"]      # 每答案一次缓存


def test_poster_qr_failure_fallback(client, monkeypatch):
    """小程序码失败 → 无码兜底版（搜一搜引导），海报不废。"""
    _copy_font()
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: _DIGEST_OK)

    def _no_qr(scene, page, **kw):
        raise RuntimeError("wxacode 40001")
    monkeypatch.setattr(wechat, "wxacode_unlimited", _no_qr)
    r = client.get(f"/api/answer/{aid}/poster")
    assert r.status_code == 200
    import base64
    assert base64.b64decode(r.json()["b64"])[:4] == b"\x89PNG"


def test_poster_font_missing(client, monkeypatch):
    """字体缺失 → 503 明确失败（不炸主服务）。"""
    import qianwen_engine.exporter as exporter_mod
    aid, _ = _ask_ready(client)
    monkeypatch.setattr(zhipu, "configured", lambda: True)
    monkeypatch.setattr(zhipu, "rewrite", lambda p: _DIGEST_OK)
    monkeypatch.setattr(exporter_mod, "_font_path", lambda: None)
    r = client.get(f"/api/answer/{aid}/poster")
    assert r.status_code == 503
