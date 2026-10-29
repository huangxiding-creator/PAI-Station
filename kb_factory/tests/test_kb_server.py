# -*- coding: utf-8 -*-
"""kb_server 单元/集成测试（unittest；真网络腿 KB_LIVE 门控）。

验收口径（任务钉死）：
  1. 起服子线程 → POST /api/kb/blueprint → 202 {"task_id"} → 轮询到 done →
     bp.tree.mode==evidence_tree + provenance.evidence.pool_size>0（mock 收割
     注入 + 真建树链；真网络 wenku 单渠道腿走 KB_LIVE 门，不稳可 skip）；
  2. failed 路径（mock 断渠道）：收割函数抛异常 → status=failed + error 带原因，
     stage 如实停留在 researching（失败点位不虚报）；检索 0 件 → failed 带实测
     pool_size=0（零造假拒空树）；
  3. 404：未知/过期 task_id、未知路径；
  4. 超时清理逻辑单元级：终态任务过保留期出清、running 在飞不清；
  5. CORS 头（*）+ JSON UTF-8 + OPTIONS 预检 204 + 入参校验 400 族。

D 轴·实时直播升级（轴⑤，2.0 版扩 7 例非破坏）：
  6. live_progress 纯件：审计尾部增量三不认（旧行/他任务行/残行）+ 轮询线程
     聚合累加 + 簇名预览与建树 parity（预览簇名全数落树 L2 组名）；
  7. 任务板直播键快照段位收放：researching 带 channels_live / structuring 带
     clusters_forming / 终态不带（done 完整账在 bp，不重复不冒充）；
  8. HTTP 侧直播真值：mock 收割写审计行 → GET researching 回执带
     channels_live={channel:n}；零审计行全程不带（拿不到不编造）。

隔离纪律：mock 链测试收割函数直注（make_server(harvest=...)，零网络）；
setUp 强制清 KB_EVIDENCE_CHAIN_DIR/KB_EVIDENCE_HARVEST_MODULE env 针位
（保证用真 pool/evidence_tree 契约模块建树），测后复原互不外泄；直播腿审计位
一律注入临时目录（不碰生产 audit.jsonl）。
"""
import json
import os
import sys
import tempfile
import threading
import time
import unittest
import urllib.error
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[2]))  # 仓库根入 sys.path

from kb_factory import evidence_cli, kb_server, live_progress

REPO_ROOT = Path(__file__).resolve().parents[2]
SENT_WATER = "给水利工程公司建一个EPC行业知识库"

# 测试涉 env 开关全集（前后如实保存/复位，互不外泄）
_SWITCHES = ("KB_EVIDENCE_CHAIN_DIR", "KB_EVIDENCE_HARVEST_MODULE")

# mock 供弹标题（水利 EPC 主题词跨标题命中 ≥2 → 真聚类成组；口径同集成测试件）
_MOCK_TITLES = [("水利工程EPC总承包合同范本", "pdf"),
                ("水利水电工程施工组织设计指南", "doc"),
                ("EPC工程总承包项目管理实务", "pdf"),
                ("水利工程验收资料整编手册", "xls"),
                ("水利水电工程监理规划范本", "doc"),
                ("水利工程造价编制与审核", "pdf")]


def _mock_harvest(queries, channels=None):
    """mock 收割（零网络，真实 FileMeta dict 契约形状）：每查询 6 条供弹。"""
    metas = []
    for qi, _q in enumerate(queries):
        for i, (t, f) in enumerate(_MOCK_TITLES):
            metas.append({"title": f"{t}·{qi}", "fmt": f, "pages": 40 + i,
                          "badge": "green_free", "perm": "green",
                          "source_url": None, "extra": {"doc_id": f"mk{qi}{i}"}})
    return {"wenku": metas}


def _broken_harvest(queries, channels=None):
    """mock 断渠道：收割腿直接抛错（failed 路径腿）。"""
    raise RuntimeError("模拟渠道全断")


def _empty_harvest(queries, channels=None):
    """mock 检索 0 件：返回空池（零造假 failed 腿）。"""
    return {}


class _EnvCase(unittest.TestCase):
    """env 针位隔离基类：每用例前清空、测后复原（强制真契约模块链）。"""

    def setUp(self):
        self._saved = {k: os.environ.get(k) for k in _SWITCHES}
        for k in _SWITCHES:
            os.environ.pop(k, None)
        self.addCleanup(self._restore)

    def _restore(self):
        for k, v in self._saved.items():
            if v is None:
                os.environ.pop(k, None)
            else:
                os.environ[k] = v


# ── HTTP 小件（urllib stdlib 直连真 HTTP，走完整线上协议）────────────────────

def _post(port, body):
    data = body if isinstance(body, bytes) else json.dumps(body).encode("utf-8")
    req = urllib.request.Request(
        f"http://127.0.0.1:{port}/api/kb/blueprint", data=data,
        headers={"Content-Type": "application/json"}, method="POST")
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            return r.status, dict(r.headers), r.read()
    except urllib.error.HTTPError as e:
        return e.code, dict(e.headers), e.read()


def _req(port, path, method="GET", body=None):
    url = f"http://127.0.0.1:{port}{path}"
    data = json.dumps(body).encode("utf-8") if body is not None else None
    req = urllib.request.Request(url, data=data, method=method,
                                 headers={"Content-Type": "application/json"}
                                 if data else {})
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            return r.status, dict(r.headers), r.read()
    except urllib.error.HTTPError as e:
        return e.code, dict(e.headers), e.read()


# ── 单元级：任务板（无 HTTP，确定性直测）───────────────────────────────────

class TestBoardUnit(_EnvCase):

    def test_staged_harvest_switches_to_structuring(self):
        """段位收割包装：收割返回瞬间切 structuring（段二开始点如实）。"""
        board = kb_server.KBTaskBoard(channels=["mockch"], harvest=_mock_harvest)
        tid = board.create_task("t")
        box = {}
        sh = board._make_staged_harvest(tid, _mock_harvest, box)
        result = sh(["q1", "q2"])
        snap = board.snapshot(tid)
        self.assertEqual(snap["status"], "running")
        self.assertEqual(snap["stage"], "structuring")     # 段位已切（如实）
        self.assertGreater(box["pool"], 0)                 # 侧袋实测收割数
        self.assertIn("wenku", result)                     # mock 契约形状原样透传

    def test_fail_keeps_stage_at_failure_point(self):
        """failed 如实：stage 停在失败点位（researching），不虚报进展。"""
        board = kb_server.KBTaskBoard()
        tid = board.create_task("t")
        board.fail(tid, "Boom: 模拟异常")
        snap = board.snapshot(tid)
        self.assertEqual(snap["status"], "failed")
        self.assertEqual(snap["stage"], "researching")     # 失败在段一（如实）
        self.assertIn("Boom", snap["error"])
        self.assertNotIn("bp", snap)

    def test_sweep_removes_expired_terminal_keeps_running(self):
        """保留期清理：终态过 retention 出清；running 在飞永不清理。"""
        board = kb_server.KBTaskBoard(retention_sec=0.2)
        done_id = board.create_task("done 任务")
        board.finish(done_id, {"mode": "evidence_tree"})
        run_id = board.create_task("在飞任务")
        with board._lock:                                  # 人为把在飞任务拖过期龄
            board._tasks[run_id]["t_submit"] -= 999.0
        time.sleep(0.3)
        removed = board.sweep_expired()
        self.assertEqual(removed, 1)
        self.assertIsNone(board.snapshot(done_id))         # 过期终态已出清
        self.assertIsNotNone(board.snapshot(run_id))       # 在飞保留（不丢任务）

    def test_task_limit_guard(self):
        """并发上限熔断：超限 TaskLimitError（受理侧如实拒，不假排队）。"""
        board = kb_server.KBTaskBoard(max_running=1)
        board.create_task("占位在飞")
        with self.assertRaises(kb_server.TaskLimitError):
            board.create_task("第二个")

    def test_default_channels_fast_three(self):
        """渠道集缺省=快速三渠道；None=pool 全家桶（--full 语义）。"""
        srv = kb_server.make_server(port=0)
        self.assertEqual(srv.kb_board.channels, list(kb_server.DEFAULT_FAST_CHANNELS))
        self.assertEqual(kb_server.DEFAULT_FAST_CHANNELS, ("wenku", "djyanbao", "doc88"))
        srv.server_close()
        srv2 = kb_server.make_server(port=0, channels=None)
        self.assertIsNone(srv2.kb_board.channels)          # None=pool 默认全家桶
        srv2.server_close()

    def test_default_bind_loopback_only(self):
        """缺省绑定仅 127.0.0.1（默认不暴露网卡；ECS 走显式 --host）。"""
        srv = kb_server.make_server(port=0)
        self.addCleanup(srv.server_close)
        self.assertEqual(srv.server_address[0], "127.0.0.1")


# ── HTTP 集成：mock 收割链（零网络 + 真建树）──────────────────────────────

class _ServerCase(_EnvCase):
    """起服子线程基类：port=0 系统分配，serve_forever daemon 线程。"""

    def start_server(self, **board_kwargs):
        kw = {"channels": ["wenku"]}                       # mock 键=wenku 走白名单
        kw.update(board_kwargs)
        srv = kb_server.make_server(host="127.0.0.1", port=0, **kw)
        t = threading.Thread(target=srv.serve_forever, daemon=True)
        t.start()
        self.addCleanup(srv.kb_board.close)
        self.addCleanup(srv.server_close)
        self.addCleanup(srv.shutdown)                      # 先停接收再关口
        self.srv, self.port = srv, srv.server_address[1]
        return srv

    def poll_terminal(self, task_id, timeout=180.0):
        """轮询到终态（done/failed），超时 fail 带最后快照（如实）。"""
        deadline = time.monotonic() + timeout
        last = None
        while time.monotonic() < deadline:
            code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{task_id}")
            self.assertEqual(code, 200, body)
            last = json.loads(body.decode("utf-8"))
            if last["status"] in ("done", "failed"):
                return last
            time.sleep(0.05)
        self.fail(f"超时未到终态: {last}")

    def submit(self, body):
        code, hdr, raw = _post(self.port, body)
        self.assertEqual(code, 202, raw)
        self.assertEqual(hdr.get("Access-Control-Allow-Origin"), "*")  # CORS 头在案
        return json.loads(raw.decode("utf-8"))["task_id"]


class TestHTTPMockChain(_ServerCase):

    def test_post_poll_done_blueprint(self):
        """任务钉死主腿：202→轮询 done→真建树 mode=evidence_tree+pool_size>0。"""
        self.start_server(harvest=_mock_harvest)
        task_id = self.submit({"text": SENT_WATER, "depth": "pro", "guided": True})
        self.assertEqual(len(task_id), 32)
        snap = self.poll_terminal(task_id)
        self.assertEqual(snap["status"], "done", snap.get("error"))
        self.assertEqual(snap["stage"], "done")
        self.assertGreaterEqual(snap["elapsed"], 0.0)
        bp = snap["bp"]
        self.assertEqual(bp["tree"]["mode"], "evidence_tree")   # 真 W1 建树
        ev = bp["provenance"]["evidence"]
        self.assertGreater(ev["pool_size"], 0)                  # 真收割记账（mock 供弹）
        self.assertEqual(set(ev["channels"]), {"wenku"})        # 白名单如实
        srv_prov = bp["provenance"]["server"]
        self.assertEqual(srv_prov["depth"], "pro")              # 入参如实记账
        self.assertTrue(srv_prov["guided"])
        self.assertIn("depth_note", srv_prov)                   # depth 不冒充生效
        self.assertIs(bp["provenance"].get("guided_layer"), True)  # 导览层真挂
        self.assertTrue(any("kb_server" in s for s in bp["provenance"]["stage_log"]))

    def test_stage_progression_is_ordered_subsequence(self):
        """三段直播：观测到的 stage 序列是 researching→structuring→done 的顺序子列。"""
        self.start_server(harvest=_mock_harvest)
        task_id = self.submit({"text": SENT_WATER})
        ideal = ["researching", "structuring", "done"]
        seen, idx = [], 0
        deadline = time.monotonic() + 180.0
        while time.monotonic() < deadline:
            code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{task_id}")
            snap = json.loads(body.decode("utf-8"))
            stage = snap["stage"] if snap["status"] == "running" else "done"
            if not seen or seen[-1] != stage:
                seen.append(stage)
            if snap["status"] in ("done", "failed"):
                self.assertEqual(snap["status"], "done", snap.get("error"))
                break
            time.sleep(0.02)
        self.assertEqual(seen[-1], "done", seen)
        for s in seen:                                          # 顺序子列（不乱序不跳变）
            self.assertIn(s, ideal, seen)
            self.assertGreaterEqual(ideal.index(s), idx, seen)
            idx = ideal.index(s)

    def test_researching_visible_while_harvest_blocked(self):
        """段一可见性（确定性）：收割阻塞在 Event 上 → 轮询必见 researching。"""
        gate = threading.Event()

        def gated_harvest(queries, channels=None):
            gate.wait(timeout=60)                       # 阻塞：任务停在段一
            return _mock_harvest(queries)

        self.start_server(harvest=gated_harvest)
        task_id = self.submit({"text": SENT_WATER})
        deadline = time.monotonic() + 10.0
        snap = None
        while time.monotonic() < deadline:              # 阻塞期间必然观测到段一
            code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{task_id}")
            snap = json.loads(body.decode("utf-8"))
            if snap["status"] == "running" and snap["stage"] == "researching":
                break
            time.sleep(0.02)
        self.assertEqual(snap["stage"], "researching", snap)   # 段一在播（如实）
        self.assertEqual(snap["status"], "running")
        gate.set()                                      # 放行 → 继续走完两段
        final = self.poll_terminal(task_id)
        self.assertEqual(final["status"], "done", final.get("error"))

    def test_failed_mock_broken_channel(self):
        """failed 路径（mock 断渠道）：error 带原因、stage 停 researching、无 bp。"""
        self.start_server(harvest=_broken_harvest)
        task_id = self.submit({"text": SENT_WATER})
        snap = self.poll_terminal(task_id)
        self.assertEqual(snap["status"], "failed")
        self.assertIn("RuntimeError", snap["error"])
        self.assertIn("模拟渠道全断", snap["error"])
        self.assertEqual(snap["stage"], "researching")   # 失败点位如实（段一）
        self.assertNotIn("bp", snap)

    def test_failed_zero_pool_honest_count(self):
        """检索 0 件 → failed 带实测 pool_size=0（零造假拒空树）。"""
        self.start_server(harvest=_empty_harvest)
        task_id = self.submit({"text": SENT_WATER})
        snap = self.poll_terminal(task_id)
        self.assertEqual(snap["status"], "failed")
        self.assertIn("检索不足", snap["error"])
        self.assertIn("pool_size=0", snap["error"])
        self.assertNotIn("bp", snap)

    def test_retention_cleanup_over_http(self):
        """HTTP 侧保留期清理：终态过保留期 → GET 404（每请求顺手一扫）。"""
        self.start_server(harvest=_mock_harvest, retention_sec=0.3)
        task_id = self.submit({"text": SENT_WATER})
        snap = self.poll_terminal(task_id)
        self.assertEqual(snap["status"], "done")
        time.sleep(0.6)                                 # 过保留期（0.3s 保留）
        code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{task_id}")
        self.assertEqual(code, 404)
        self.assertIn("保留", json.loads(body.decode("utf-8"))["error"])

    def test_get_unknown_task_404(self):
        """未知 task_id → 404。"""
        self.start_server(harvest=_mock_harvest)
        code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{'0' * 32}")
        self.assertEqual(code, 404)
        self.assertIn("error", json.loads(body.decode("utf-8")))

    def test_unknown_path_404(self):
        """未知路径 POST/GET 均 404。"""
        self.start_server(harvest=_mock_harvest)
        code, _hdr, _b = _req(self.port, "/api/kb/other", method="POST",
                              body={"text": "x"})
        self.assertEqual(code, 404)
        code, _hdr, _b = _req(self.port, "/api/kb/blueprint/zz")
        self.assertEqual(code, 404)

    def test_options_preflight_204_cors(self):
        """OPTIONS 预检 → 204 + CORS 头（浏览器直连用）。"""
        self.start_server(harvest=_mock_harvest)
        code, hdr, _b = _req(self.port, "/api/kb/blueprint", method="OPTIONS")
        self.assertEqual(code, 204)
        self.assertEqual(hdr.get("Access-Control-Allow-Origin"), "*")
        self.assertIn("POST", hdr.get("Access-Control-Allow-Methods", ""))

    def test_post_validation_400_family(self):
        """入参校验 400 族：缺 text/空 text/非法 depth/非法 guided/非 JSON body。"""
        self.start_server(harvest=_mock_harvest)
        for bad in ({"depth": "pro"}, {"text": "   "}, {"text": "x", "depth": "ultra"},
                    {"text": "x", "guided": "yes"}):
            code, _hdr, body = _post(self.port, bad)
            self.assertEqual(code, 400, f"{bad} -> {body}")
        code, _hdr, body = _post(self.port, b"{not json")
        self.assertEqual(code, 400)
        code, _hdr, body = _req(self.port, "/api/kb/blueprint", method="POST",
                                body=["not", "dict"])
        self.assertEqual(code, 400)

    def test_guided_string_and_depth_case_tolerated(self):
        """guided "true"/depth 大写宽容归一（mini 程序字符串形态兼容）。"""
        self.start_server(harvest=_mock_harvest)
        task_id = self.submit({"text": SENT_WATER, "guided": "true", "depth": "PRO"})
        snap = self.poll_terminal(task_id)
        self.assertEqual(snap["status"], "done", snap.get("error"))
        self.assertIs(snap["bp"]["provenance"].get("guided_layer"), True)
        self.assertEqual(snap["bp"]["provenance"]["server"]["depth"], "pro")


# ── D 轴·实时直播升级（轴⑤）：live_progress 纯件 + 任务板直播键 + HTTP 真值 ────

class TestLiveProgressUnit(_EnvCase):
    """live_progress 纯件（零网络零线程，确定性直测）：审计尾部增量聚合/簇名预览。"""

    def setUp(self):
        super().setUp()
        self.lp = live_progress
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.audit = os.path.join(self.tmp.name, "audit.jsonl")

    def _write_rows(self, rows, partial=b""):
        """按渠道编排池 AuditLog 同形状落行（真实链由 pool 写，此处直写同款）。"""
        with open(self.audit, "ab") as f:
            for r in rows:
                f.write(json.dumps(r, ensure_ascii=False).encode("utf-8") + b"\n")
            if partial:
                f.write(partial)

    def test_tail_incremental_and_query_scoping(self):
        """尾部增量三不认：零点前旧行/别任务查询词行/无换行残行（只认本任务新增）。"""
        self._write_rows([{"ts": "t0", "channel": "wenku", "event": "pool_query",
                           "query": "上辈子的词", "count": 99}])
        base = os.path.getsize(self.audit)               # 零点偏移=收割前 EOF
        self._write_rows([
            {"ts": "t1", "channel": "wenku", "event": "pool_query",
             "query": "q1", "count": 5},
            {"ts": "t2", "channel": "djyanbao", "event": "pool_query",
             "query": "q2", "count": 3},
            {"ts": "t3", "channel": "wenku", "event": "pool_query",
             "query": "别家任务的词", "count": 50},       # 并发他任务行不串账
            {"ts": "t4", "channel": "wenku", "event": "stopped",
             "query": "q1", "count": 999},               # stopped 行 count=累计口径不可加
        ], partial=b'{"ts": "t5", "channel": "doc88", "event": "pool_qu')  # 残行
        rows, off = self.lp.read_audit_tail(self.audit, base)
        counts = self.lp.aggregate_live_counts(rows, ["q1", "q2"])
        self.assertEqual(counts, {"wenku": 5, "djyanbao": 3})  # 三不认全过
        self.assertLess(off, os.path.getsize(self.audit))      # 残行偏移回退
        rows2, _off2 = self.lp.read_audit_tail(self.audit, off)
        self.assertEqual(self.lp.aggregate_live_counts(rows2, ["q1", "q2"]), {})
        self._write_rows([], partial=b'ery", "query": "q1", "count": 2}\n')  # 补全残行
        rows3, _off3 = self.lp.read_audit_tail(self.audit, off)
        self.assertEqual(self.lp.aggregate_live_counts(rows3, ["q1", "q2"]),
                         {"doc88": 2})                    # 补齐后整行入账
        self.assertEqual(self.lp.aggregate_live_counts(rows3, []), {})  # 无属主判据不计

    def test_poller_thread_aggregates_and_accumulates(self):
        """轮询线程：收割阻塞期间回调渠道计数，且跨 tick 增量累加（interval 可缩）。"""
        seen = []
        poller = self.lp.LiveAuditPoller(self.audit, ["q1"], seen.append,
                                         interval=0.05)
        poller.start()
        self.addCleanup(poller.stop)
        self._write_rows([{"ts": "t1", "channel": "wenku", "event": "pool_query",
                           "query": "q1", "count": 4}])
        deadline = time.monotonic() + 5.0
        while not seen and time.monotonic() < deadline:
            time.sleep(0.02)
        self.assertEqual(seen[-1], {"wenku": 4})          # 首笔聚合到位
        self._write_rows([{"ts": "t2", "channel": "wenku", "event": "pool_query",
                           "query": "q1", "count": 4}])
        deadline = time.monotonic() + 5.0
        while seen[-1] != {"wenku": 8} and time.monotonic() < deadline:
            time.sleep(0.02)
        self.assertEqual(seen[-1], {"wenku": 8})          # 累计口径（两次行合计）
        poller.stop()
        self._write_rows([{"ts": "t3", "channel": "wenku", "event": "pool_query",
                           "query": "q1", "count": 100}])
        time.sleep(0.2)
        self.assertEqual(seen[-1], {"wenku": 8})          # 收线后不再回调（幂等停）

    def test_clusters_preview_parity_with_tree(self):
        """簇名预览=建树同一聚类（确定性零漂移）：预览簇名全数落树 L2 组名；
        契约模块缺席/空池如实 None（不编造预览）。"""
        _pool_mod, tree_mod, _note = evidence_cli.load_chain()
        self.assertIsNotNone(tree_mod)                    # 真契约模块在场（env 已清）
        metas = self.lp.flatten_pool_result({
            "wenku": [{"title": t, "fmt": f} for t, f in _MOCK_TITLES],
            "djyanbao": [{"title": t + "·第二版", "fmt": f} for t, f in _MOCK_TITLES],
        })
        self.assertEqual(len(metas), 2 * len(_MOCK_TITLES))   # 拍平+渠道锚注入
        self.assertEqual({m["channel"] for m in metas}, {"wenku", "djyanbao"})
        names = self.lp.clusters_preview(tree_mod, metas)
        self.assertTrue(names, "真实池簇名预览为空（不该）")
        bp = tree_mod.build_evidence_tree("测试域", metas)
        l2_names = {g["name"] for l1 in bp["tree"]["l1"] for g in l1["l2"]}
        self.assertTrue(set(names) <= l2_names,
                        f"预览簇名未全落树: {set(names) - l2_names}")
        self.assertIsNone(self.lp.clusters_preview(None, metas))     # 模块缺席
        self.assertIsNone(self.lp.clusters_preview(tree_mod, []))    # 空池


class TestLiveCountsBoard(_EnvCase):
    """任务板直播键：channels_live/clusters_forming 写入与快照段位收放。"""

    def test_snapshot_stage_scoped_live_fields(self):
        """快照段位收放：researching 带 channels_live→structuring 换带
        clusters_forming→终态两者皆不带（done 完整账在 bp，不重复不冒充）。"""
        board = kb_server.KBTaskBoard()
        tid = board.create_task("t")
        self.assertNotIn("channels_live", board.snapshot(tid))  # 无真值不带
        board.update_live(tid, {"wenku": 5})
        snap = board.snapshot(tid)
        self.assertEqual(snap["stage"], "researching")
        self.assertEqual(snap["channels_live"], {"wenku": 5})
        board.set_clusters_forming(tid, ["水利水电工程", "EPC总承包"])
        board.set_stage(tid, kb_server.STAGE_STRUCTURING)
        snap = board.snapshot(tid)
        self.assertEqual(snap["clusters_forming"], ["水利水电工程", "EPC总承包"])
        self.assertNotIn("channels_live", snap)          # 段二收线（收割已完成）
        board.finish(tid, {"mode": "evidence_tree"})
        snap = board.snapshot(tid)
        self.assertNotIn("clusters_forming", snap)       # 终态不带预览
        self.assertNotIn("channels_live", snap)
        board.update_live(tid, {"x": 1})                 # 终态后不回写（仅 running）
        self.assertNotIn("channels_live", board.snapshot(tid))

    def test_staged_harvest_live_wiring(self):
        """staged_harvest 直播接线：收割期轮询聚合入 box+任务板；返回瞬间簇名
        预览入账（tree_mod 缺席时仅段一线，预览如实缺位）。"""
        _pool_mod, tree_mod, _note = evidence_cli.load_chain()
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        audit = os.path.join(tmp.name, "audit.jsonl")

        def harvesting_with_audit(queries, channels=None):
            with open(audit, "a", encoding="utf-8") as f:  # 模拟 pool 审计落账
                f.write(json.dumps({"ts": "t", "channel": "wenku",
                                    "event": "pool_query", "query": queries[0],
                                    "count": 5}, ensure_ascii=False) + "\n")
            time.sleep(1.0)                              # 阻塞给轮询窗口（0.05s 档）
            return _mock_harvest(queries)

        board = kb_server.KBTaskBoard(channels=["wenku"],
                                      harvest=harvesting_with_audit,
                                      audit_path=audit, live_interval=0.05)
        tid = board.create_task("t")
        box = {}
        sh = board._make_staged_harvest(tid, harvesting_with_audit, box, tree_mod)
        result = sh(["q1", "q2"])
        self.assertIn("wenku", result)                   # 收割契约形状原样透传
        self.assertEqual(box.get("channels_live"), {"wenku": 5})   # 轮询聚合入侧袋
        self.assertTrue(box.get("clusters_forming"))     # 真实池簇名预览在案
        self.assertTrue(all(isinstance(n, str) and n
                            for n in box["clusters_forming"]))
        snap = board.snapshot(tid)
        self.assertEqual(snap["stage"], "structuring")
        self.assertTrue(snap.get("clusters_forming"))    # 任务板段二真值在案


class TestLiveCountsHTTP(_ServerCase):
    """HTTP 侧直播真值（mock 收割链零网络）：GET 回执按段位带直播键。"""

    def test_researching_carries_channels_live(self):
        """GET researching 回执 channels_live={channel:n}（审计尾部聚合真值）。"""
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)
        audit = os.path.join(tmp.name, "audit.jsonl")

        def harvesting_with_audit(queries, channels=None):
            with open(audit, "a", encoding="utf-8") as f:
                f.write(json.dumps({"ts": "t", "channel": "wenku",
                                    "event": "pool_query", "query": queries[0],
                                    "count": 5}, ensure_ascii=False) + "\n")
            time.sleep(0.8)                              # 收割阻塞：直播观测窗口
            return _mock_harvest(queries)

        self.start_server(harvest=harvesting_with_audit, audit_path=audit,
                          live_interval=0.05)
        task_id = self.submit({"text": SENT_WATER})
        seen_live, seen_stage = None, None
        deadline = time.monotonic() + 20.0
        while time.monotonic() < deadline:
            code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{task_id}")
            snap = json.loads(body.decode("utf-8"))
            if snap["status"] == "running" and "channels_live" in snap:
                seen_live, seen_stage = snap["channels_live"], snap["stage"]
                break
            time.sleep(0.02)
        self.assertIsNotNone(seen_live, "researching 回执未见 channels_live")
        self.assertEqual(seen_stage, "researching")
        self.assertEqual(seen_live, {"wenku": 5})        # 只认真值（5=审计行实数）
        final = self.poll_terminal(task_id)
        self.assertEqual(final["status"], "done", final.get("error"))

    def test_no_live_keys_without_audit_rows(self):
        """零审计行如实不带：收割不落审计 → 全程回执无 channels_live（不编造）。"""
        tmp = tempfile.TemporaryDirectory()
        self.addCleanup(tmp.cleanup)

        def silent_harvest(queries, channels=None):
            time.sleep(0.5)                              # 阻塞但零审计行
            return _mock_harvest(queries)

        self.start_server(harvest=silent_harvest,
                          audit_path=os.path.join(tmp.name, "never.jsonl"),
                          live_interval=0.05)
        task_id = self.submit({"text": SENT_WATER})
        saw_researching = False
        deadline = time.monotonic() + 20.0
        while time.monotonic() < deadline:
            code, _hdr, body = _req(self.port, f"/api/kb/blueprint/{task_id}")
            snap = json.loads(body.decode("utf-8"))
            if snap["status"] == "running" and snap["stage"] == "researching":
                saw_researching = True
                self.assertNotIn("channels_live", snap)  # 无真值不带
            if snap["status"] in ("done", "failed"):
                break
            time.sleep(0.02)
        self.assertTrue(saw_researching, "未观测到 researching 段")
        self.assertEqual(snap["status"], "done", snap.get("error"))


# ── 真网络腿（KB_LIVE 门控；不稳可 skip，mock 链已全绿兜底）──────────────────

@unittest.skipUnless(os.environ.get("KB_LIVE"), "真网络腿: 设 KB_LIVE=1 才跑（wenku 单渠道实弹）")
class TestRealNetworkWenku(_ServerCase):

    def test_real_wenku_single_channel_live(self):
        """真网络 wenku 单渠道：POST→轮询 done→mode=evidence_tree+pool_size>0。"""
        self.start_server(channels=["wenku"], harvest=None)   # 真链（无 mock 注入）
        task_id = self.submit({"text": SENT_WATER})
        snap = self.poll_terminal(task_id, timeout=300.0)
        if snap["status"] == "failed":
            # 网络不济/渠道 0 命中 → 如实 skip（零造假：不造实调假象）
            self.skipTest(f"真链如实失败: {snap.get('error')}")
        self.assertEqual(snap["status"], "done")
        self.assertEqual(snap["bp"]["tree"]["mode"], "evidence_tree")
        self.assertGreater(snap["bp"]["provenance"]["evidence"]["pool_size"], 0)
        self.assertEqual(snap["bp"]["provenance"]["server"]["channels"], ["wenku"])


if __name__ == "__main__":
    unittest.main()
