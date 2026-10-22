# -*- coding: utf-8 -*-
"""断点台账 Store 单测（FR3.1/FR4.1 支持；SYNTHESIS 要点11 / DOC88_SPEC §3 R14 / BOOK118_SPEC §2）。

- 全部本地 fixtures、零网络、零 mock：被测物=Store 本体（字节缓存/token 台账/失败页重单）。
- 台账根写 tests/fixtures/store_ledger_test/（包内无默认位；测毕 teardown 清理）。
- 键控口径：资产=ebt 名（键→文件名含键 sha 盐防撞）；token=(site, aid, project_id)；
  失败页=(site, doc, page)，页号一律 int 数值序（防 "10"<"2" 字典序坑）。
"""
import concurrent.futures
import json
import shutil
import sys
from pathlib import Path

import pytest

_KB_DIR = Path(__file__).resolve().parents[2]  # kb_factory/
sys.path.insert(0, str(_KB_DIR))  # worktree 阶段 kb_factory 无 __init__.py：顶层导入 harvest_engine

try:  # 合并后正名 kb_factory.harvest_engine.*；worktree 阶段回退顶层名
    from kb_factory.harvest_engine.store.ledger import Store  # noqa: E402
except ImportError:
    from harvest_engine.store.ledger import Store  # noqa: E402

_BASE = Path(__file__).resolve().parent / "fixtures" / "store_ledger_test"

# doc88 ebt 键样例：层头 PH 与两页 PK（名含 enc2 特殊字符 =/!/+ 走文件名净化）
_DOC = "69091550288"
_PH_KEY = "0rUX3ZmQ!x9mY0pzT8v+Wb2hcg==.ebt"
_PK1_KEY = "aY5tR2sWq1eVgU7iOoP0kKjJ9hHnNnBbVvCcXxZzLl==.ebt"
_PK2_KEY = "Qq3W8eR1tY6uI9oP5aS7dF2gH4jK7lZ0xC3vB1nM6==.ebt"
_PH_DATA = b"YBD\x01" + b"\x00" * 36 + b"\x78\x9c" + b"PH-payload"
_PK1_DATA = b"\x5c\xa7" * 16 + b"\x78\x9c" + b"PK-page-1"
_PK2_DATA = b"\x11\x22" * 16 + b"\x78\x9c" + b"PK-page-2"


def _fresh_store(base: Path | None = None) -> Store:
    base = base or _BASE
    if base.exists():
        shutil.rmtree(base)
    base.parent.mkdir(parents=True, exist_ok=True)
    return Store(str(base))


def _progress_records(doc: str) -> dict:
    path = _BASE / "progress" / f"{doc}.json"
    return json.loads(path.read_text(encoding="utf-8"))["chunks"]


def test_fr4_1_r14_whole_file_bytes_cache_second_request_local_hit():
    """FR4.1/R14：CDN 忽略 Range→整文件字节缓存；二次请求同文件直接本地命中（零再下载）。"""
    store = _fresh_store()
    path = store.put_asset(_PH_KEY, _PH_DATA, doc=_DOC)
    assert Path(path).exists() and Path(path).is_file()
    assert store.get_asset(_PH_KEY) == _PH_DATA      # 首次落缓存
    assert store.get_asset(_PH_KEY) == _PH_DATA      # 二次请求=本地命中
    assert store.get_asset("从未下载过的键.ebt") is None  # 未命中如实 None（不造假）


def test_fr4_1_doc88_progress_json_chunk_records_and_reopen_resume():
    """FR4.1：progress.json 分块记录（每块实测字节数）+ 重开 Store 断点续跑全命中。"""
    store = _fresh_store()
    store.put_asset(_PH_KEY, _PH_DATA, doc=_DOC)
    store.put_asset(_PK1_KEY, _PK1_DATA, doc=_DOC)
    store.put_asset(_PK2_KEY, _PK2_DATA, doc=_DOC)
    chunks = _progress_records(_DOC)
    assert set(chunks) == {_PH_KEY, _PK1_KEY, _PK2_KEY}
    assert chunks[_PH_KEY]["bytes"] == len(_PH_DATA)     # 零造假：字节数=实测 len(data)
    assert chunks[_PK1_KEY]["bytes"] == len(_PK1_DATA)
    # 断点续跑：新 Store 实例（= 新进程/崩溃后重开）同库全命中，无需再碰 CDN
    store2 = Store(str(_BASE))
    assert store2.get_asset(_PH_KEY) == _PH_DATA
    assert store2.get_asset(_PK1_KEY) == _PK1_DATA
    store2.put_asset("chunk-4", b"n4", doc=_DOC)          # 续跑追加新块
    assert len(_progress_records(_DOC)) == 4


def test_fr4_1_asset_cache_immutable_first_write_wins():
    """FR4.1：资产按名幂等不可变——同名再写保留首写字节（并避免替换期间读写竞态）。"""
    store = _fresh_store()
    store.put_asset("same-key.ebt", b"first-bytes", doc=_DOC)
    store.put_asset("same-key.ebt", b"second-bytes", doc=_DOC)
    assert store.get_asset("same-key.ebt") == b"first-bytes"
    assert len(_progress_records(_DOC)) == 1              # 分块记录不重复


def test_fr3_1_book118_token_ledger_cross_month_reuse():
    """FR3.1/BOOK118_SPEC §2：view_token+aid+project_id 键控台账，跨月（重开）稳定复用。"""
    store = _fresh_store()
    token = "Bw_2kzdPgXts68EgVwn_mM4e8ALH_opi"
    store.put_token(token, aid=188244482, project_id=1, aid_encode="113657916")
    rec = store.get_token(aid=188244482, project_id=1)
    assert rec is not None
    assert rec["token"] == token
    assert rec["aid_encode"] == "113657916"   # 四字段全留档：复用时可跳过 Playwright 首跳
    assert rec["first_seen"] <= rec["last_used"]
    # 跨月=新进程新 Store：台账持久，token 仍可取（免首跳指纹墙）
    rec2 = Store(str(_BASE)).get_token(aid=188244482, project_id=1)
    assert rec2 is not None and rec2["token"] == token


def test_fr3_1_token_key_isolation_and_rotation():
    """FR3.1：键=(site, aid, project_id) 三元隔离；同键换 token=轮换覆盖且 first_seen 保留。"""
    store = _fresh_store()
    store.put_token("token-A", aid=188244482, project_id=1, aid_encode="113657916")
    assert store.get_token(aid=188244482, project_id=2) is None   # project_id 不同=另一文档键
    assert store.get_token(aid=999, project_id=1) is None         # aid 不同=miss
    assert store.get_token(aid=188244482, project_id=1, site="doc88") is None  # site 隔离
    first = store.get_token(aid=188244482, project_id=1)
    store.put_token("token-B", aid=188244482, project_id=1, aid_encode="113657916")
    rec = store.get_token(aid=188244482, project_id=1)
    assert rec["token"] == "token-B" and rec["first_seen"] == first["first_seen"]


def test_fr3_1_failed_pages_retry_only_failed_numeric_order():
    """FR3.1：失败页号集合——mark/unfailed/iter；数值升序（"10" 不许排 "2" 前）；持久续跑。"""
    store = _fresh_store()
    doc = "113657916"
    assert store.iter_failed(site="book118", doc=doc) == []       # 无失败=空，不造假
    store.mark_failed(site="book118", doc=doc, page=10, detail="空 data")
    store.mark_failed(site="book118", doc=doc, page=2, detail="图床 502")
    store.mark_failed(site="book118", doc=doc, page=3)
    assert store.iter_failed(site="book118", doc=doc) == [2, 3, 10]  # int 数值序
    assert store.mark_failed(site="book118", doc=doc, page=2) == 2   # 重单计数+1
    assert store.unfailed(site="book118", doc=doc, page=3) is True   # 成功后除名
    assert store.unfailed(site="book118", doc=doc, page=3) is False
    assert store.iter_failed(site="book118", doc=doc) == [2, 10]
    # 下次只拉失败页：重开 Store 集合仍在
    assert Store(str(_BASE)).iter_failed(site="book118", doc=doc) == [2, 10]
    # site/doc 维度隔离：doc88 的失败页不混入 book118
    store.mark_failed(site="doc88", doc=_DOC, page=7)
    assert store.iter_failed(site="book118", doc=_DOC) == []
    assert store.iter_failed(site="doc88", doc=_DOC) == [7]


def test_fr4_1_thread_safety_concurrent_chunk_and_failed_writes():
    """线程安全：并发 put_asset/mark_failed（含两实例同库）零丢更新——doc88 默认 10 线程下载。"""
    store_a = _fresh_store()
    store_b = Store(str(_BASE))  # 同 base_dir 双实例：验证锁注册表按库共享
    n_threads, per_thread = 8, 25

    def worker(tid: int) -> None:
        store = store_a if tid % 2 == 0 else store_b
        for i in range(per_thread):
            key = f"chunk-t{tid:02d}-i{i:03d}.ebt"
            store.put_asset(key, f"data-{tid}-{i}".encode(), doc=_DOC)
            if i < 6:
                store.mark_failed(site="book118", doc="113657916", page=(tid + 1) * 10 + i)

    with concurrent.futures.ThreadPoolExecutor(max_workers=n_threads) as pool:
        list(pool.map(worker, range(n_threads)))
    total = n_threads * per_thread
    assert len(_progress_records(_DOC)) == total          # 分块记录零丢失
    verify = Store(str(_BASE))
    for tid in range(n_threads):
        for i in range(per_thread):
            assert verify.get_asset(f"chunk-t{tid:02d}-i{i:03d}.ebt") == f"data-{tid}-{i}".encode()
    failed = verify.iter_failed(site="book118", doc="113657916")
    assert failed == sorted(failed) and len(failed) == n_threads * 6  # 失败页零丢失且数值序


def test_store_ledger_input_validation_and_miss_semantics():
    """输入校验：空键/非字节/非法页号硬拒；miss 一律 None/[]，不抛不造假。"""
    store = _fresh_store()
    with pytest.raises(ValueError):
        store.put_asset("", b"data", doc=_DOC)                    # 空键硬拒
    with pytest.raises(TypeError):
        store.put_asset("k.ebt", "字符串不是字节", doc=_DOC)      # 只收 bytes 型
    with pytest.raises(ValueError):
        store.mark_failed(site="book118", doc="113657916", page=0)  # 页号≥1
    with pytest.raises(ValueError):
        store.mark_failed(site="book118", doc="", page=1)          # 空 doc 硬拒
    assert store.get_asset("missing.ebt") is None
    assert store.get_token(aid=1, project_id=1) is None
    assert store.iter_failed(site="book118", doc="never-seen") == []


def teardown_module(module):
    """运行时台账不留仓：测毕清理 fixtures 下临时台账根。"""
    if _BASE.exists():
        shutil.rmtree(_BASE)
