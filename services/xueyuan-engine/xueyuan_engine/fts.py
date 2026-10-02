# -*- coding: utf-8 -*-
"""FTS5 检索域——jieba 预分词+三层降级+LIKE 兜底（A2；API_DESIGN §三；R-10；NFR-01）。

索引：reports_fts 虚表四列（title_toks/summary_toks/chapter_titles_toks/
keyword_toks）均为 jieba 预分词空格连接列（默认 tokenizer 不适配 CJK，R-10）。
token 真源存 fts_docs，虚表以 content='fts_docs' 外部内容表挂接——契约样张
content='' 的可维护变体（增量重建须旧值逐列回删，外部内容表即为此而生；
超集记录见 RUN_LEDGER）。

三层降级（前层 0 命中才降，逐层放宽）：
  L1 title/summary → L2 章节标题（聚合报告级+命中章列表 hit_chapters）
  → L3 商机关键词 keyword_toks（tags+省份/业主/行业元数据；EPC100 章节商机
  实体标注接入后追加）→ LIKE 全扫兜底（38-200 份规模）→ none+fallback_hint。

入库钩子：store.sync_from_catalog → rebuild_reports(ids)（契约函数
rebuild_report(report_id) 的批量形态）；失败不阻塞进库——检索层自愈降级 LIKE。
layer_used 取契约枚举 L1|L2|L3|like|none（切片② A2 自愈点：缝合期恒 like 的
阶段差消除）；响应另带 layer 子层标记（LIKE 内部 title|chapter_title，切片①
超集字段保留）。
"""
from __future__ import annotations

import json
import logging
import re
import sqlite3
from collections import Counter
from functools import lru_cache

from fastapi import APIRouter

from . import config, store
from .catalog import item_of
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["search"])
logger = logging.getLogger("xueyuan.fts")

try:  # jieba 缺席→FTS 层不可用，全链降级 LIKE（引擎不因检索依赖炸启动）
    import jieba as _jieba

    _jieba.setLogLevel(60)  # 免首切建词典日志刷屏
except Exception:  # noqa: BLE001
    _jieba = None

_NONWORD = re.compile(r"^[\W_]+$")  # 纯标点/空白 token（查询与索引共用过滤）


@lru_cache(maxsize=8192)
def tokenize(text: str) -> tuple[str, ...]:
    """jieba lcut（HMM 默认）预分词：去空白/纯标点 token；结果缓存免重复切。"""
    if not text or _jieba is None:
        return ()
    return tuple(t for t in _jieba.lcut(text) if t.strip() and not _NONWORD.match(t))


_FTS_DDL = """
CREATE TABLE IF NOT EXISTS fts_docs (
  rowid INTEGER PRIMARY KEY,
  report_id TEXT NOT NULL UNIQUE,
  title_toks TEXT NOT NULL DEFAULT '',
  summary_toks TEXT NOT NULL DEFAULT '',
  chapter_titles_toks TEXT NOT NULL DEFAULT '',
  keyword_toks TEXT NOT NULL DEFAULT ''
);
CREATE VIRTUAL TABLE IF NOT EXISTS reports_fts USING fts5(
  title_toks, summary_toks, chapter_titles_toks, keyword_toks,
  content='fts_docs', content_rowid='rowid'
);
"""

_schema_ok: set[str] = set()  # 已建 FTS 表的库路径（重复 CREATE IF NOT EXISTS 免查）


def _ensure_schema(c: sqlite3.Connection) -> None:
    key = str(config.DB_PATH)
    if key not in _schema_ok:
        c.executescript(_FTS_DDL)
        _schema_ok.add(key)


# ── 入库钩子（进库后同步维护 FTS 索引；读路径不建表——缺表自愈降级 LIKE）──

def _fts_delete(c: sqlite3.Connection, old: sqlite3.Row) -> None:
    """外部内容表回删（须旧值逐列回放，SQLite FTS5 文档惯例）。"""
    c.execute(
        "INSERT INTO reports_fts(reports_fts, rowid, title_toks, summary_toks,"
        " chapter_titles_toks, keyword_toks) VALUES('delete', ?, ?, ?, ?, ?)",
        (old["rowid"], old["title_toks"], old["summary_toks"],
         old["chapter_titles_toks"], old["keyword_toks"]),
    )


def rebuild_report(report_id: str) -> bool:
    """单报告 FTS 增量重建（契约钩子 fts.rebuild_report）；返回报告是否在库。

    幂等：报告已删→清 FTS 残留行；在库→回删旧 token 后重灌（试读/付费章
    标题一律入索引——标题非正文，不涉付费内容边界，A3）。
    """
    store.init()
    with store._LOCK, store._db() as c:
        _ensure_schema(c)
        row = c.execute("SELECT * FROM reports WHERE id=?", (report_id,)).fetchone()
        old = c.execute(
            "SELECT rowid, title_toks, summary_toks, chapter_titles_toks, keyword_toks"
            " FROM fts_docs WHERE report_id=?", (report_id,)).fetchone()
        if not row:
            if old:
                _fts_delete(c, old)
                c.execute("DELETE FROM fts_docs WHERE report_id=?", (report_id,))
            return False
        chaps = [r["title"] for r in c.execute(
            "SELECT title FROM chapters WHERE report_id=? ORDER BY idx", (report_id,))]
        kws = [*json.loads(row["tags"] or "[]"), row["province"],
               row["owner_type"], row["industry"]]
        vals = (
            " ".join(tokenize(row["title"])),
            " ".join(tokenize(row["summary"])),
            " ".join(t for title in chaps for t in tokenize(title)),
            " ".join(t for k in kws if k for t in tokenize(str(k))),
        )
        if old:
            _fts_delete(c, old)
            c.execute(
                "UPDATE fts_docs SET title_toks=?, summary_toks=?,"
                " chapter_titles_toks=?, keyword_toks=? WHERE report_id=?",
                (*vals, report_id))
            rowid = old["rowid"]
        else:
            cur = c.execute(
                "INSERT INTO fts_docs(report_id, title_toks, summary_toks,"
                " chapter_titles_toks, keyword_toks) VALUES(?,?,?,?,?)",
                (report_id, *vals))
            rowid = cur.lastrowid
        c.execute(
            "INSERT INTO reports_fts(rowid, title_toks, summary_toks,"
            " chapter_titles_toks, keyword_toks) VALUES(?,?,?,?,?)", (rowid, *vals))
    return True


def rebuild_reports(report_ids: list[str]) -> dict:
    """批量钩子（store.sync_from_catalog 调）；单报告失败不拖垮整批。"""
    ok = fail = 0
    for rid in report_ids:
        try:
            ok += rebuild_report(rid)
        except Exception:  # noqa: BLE001
            logger.exception("fts rebuild failed: %s", rid)
            fail += 1
    return {"rebuilt": ok, "failed": fail}


def rebuild_all() -> int:
    """全量重建（运维/admin 用）：清索引重灌，自愈任何漂移。"""
    store.init()
    with store._LOCK, store._db() as c:
        c.execute("DROP TABLE IF EXISTS reports_fts")
        c.execute("DROP TABLE IF EXISTS fts_docs")
        _schema_ok.discard(str(config.DB_PATH))
    with store._db() as c:
        ids = [r["id"] for r in c.execute(
            "SELECT id FROM reports WHERE status='on'").fetchall()]
    rebuild_reports(ids)
    return len(ids)


# ── 查询管线：q→jieba 切词→FTS5 OR MATCH（当前层）→0 命中→下一层→LIKE→none ──

_LAYERS = (
    ("L1", ("title_toks", "summary_toks")),
    ("L2", ("chapter_titles_toks",)),
    ("L3", ("keyword_toks",)),
)


def _match_expr(toks: tuple[str, ...], cols: tuple[str, ...]) -> str:
    """FTS5 列过滤 OR MATCH：{cols} : ("t1" OR "t2")；token 引号转义防语法注入。"""
    terms = " OR ".join('"' + t.replace('"', '""') + '"' for t in toks)
    return "{%s} : (%s)" % (" ".join(cols), terms)


def _fts_hits(c: sqlite3.Connection, toks: tuple[str, ...],
              cols: tuple[str, ...]) -> list[dict]:
    """当前层 MATCH 命中→回表 reports（status='on' 过滤 FTS 残留行）。"""
    rows = c.execute(
        "SELECT * FROM reports WHERE status='on' AND id IN"
        " (SELECT report_id FROM fts_docs WHERE rowid IN"
        "  (SELECT rowid FROM reports_fts WHERE reports_fts MATCH ?))"
        " ORDER BY published_at DESC",
        (_match_expr(toks, cols),),
    ).fetchall()
    return [dict(r) for r in rows]


def _attach_hit_chapters(c: sqlite3.Connection, items: list[dict],
                         toks: tuple[str, ...]) -> None:
    """L2 命中章列表（超集字段）：与层内 OR 语义一致——任一查询 token 交集
    即计入（解释报告为何在 L2 命中）；id 取目录短形 chNN。"""
    qset = set(toks)
    for it in items:
        chaps = c.execute(
            "SELECT id, title FROM chapters WHERE report_id=? ORDER BY idx",
            (it["id"],)).fetchall()
        it["hit_chapters"] = [
            {"id": ch["id"].split("/")[-1], "title": ch["title"]}
            for ch in chaps if qset & set(tokenize(ch["title"]))
        ]


def _resp(layer_used: str, items: list[dict], layer: str | None) -> dict:
    return {"layer_used": layer_used, "layer": layer, "items": items,
            "hot_words": hot_words(), "fallback_hint": not items}


def search(q: str) -> dict:
    """三层降级检索核心管线（HTTP 端点与基准脚本共用；q 须非空）。"""
    store.init()
    toks = tokenize(q.strip())
    if toks:
        try:
            with store._db() as c:
                for layer, cols in _LAYERS:
                    rows = _fts_hits(c, toks, cols)
                    if rows:
                        items = [item_of(r) for r in rows]
                        if layer == "L2":
                            _attach_hit_chapters(c, items, toks)
                        return _resp(layer, items, None)
        except sqlite3.Error:  # 表缺/库异态→LIKE 自愈（读路径不建表）
            logger.warning("fts unavailable, degrade to like", exc_info=True)
    return search_like(q)


def _like(q: str) -> str:
    """LIKE 模式（% _ 转义，防通配注入）。"""
    return "%" + q.replace("\\", "\\\\").replace("%", r"\%").replace("_", r"\_") + "%"


def search_like(q: str) -> dict:
    """LIKE 兜底两层：标题/摘要 → 章节标题；零命中→none+fallback_hint。"""
    store.init()
    pat = _like(q)
    with store._db() as c:
        rows = c.execute(
            "SELECT * FROM reports WHERE status='on'"
            " AND (title LIKE ? ESCAPE '\\' OR summary LIKE ? ESCAPE '\\')"
            " ORDER BY published_at DESC",
            (pat, pat),
        ).fetchall()
        layer = "title"
        if not rows:  # 前层 0 命中才降层（逐层放宽）
            rows = c.execute(
                "SELECT DISTINCT r.* FROM reports r JOIN chapters ch ON ch.report_id=r.id"
                " WHERE r.status='on' AND ch.title LIKE ? ESCAPE '\\'"
                " ORDER BY r.published_at DESC",
                (pat,),
            ).fetchall()
            layer = "chapter_title"
    hits = [dict(r) for r in rows]
    if not hits:
        return _resp("none", [], None)
    return _resp("like", [item_of(r) for r in hits], layer)


def hot_words() -> list[str]:
    """热词联想：全库 tags 频次 Top N（免登录无个性化；API_DESIGN §三）。"""
    with store._db() as c:
        rows = c.execute("SELECT tags FROM reports WHERE status='on'").fetchall()
    counter: Counter = Counter()
    for r in rows:
        for t in json.loads(r["tags"] or "[]"):
            if t:
                counter[str(t)] += 1
    return [w for w, _ in counter.most_common(config.HOT_WORDS_TOP)]


@router.get("/search")
def search_endpoint(q: str = ""):
    """三层检索入口（P0-3）。空 q→400（前端搜索框空态走榜单，不进检索）。"""
    q = (q or "").strip()
    if not q:
        raise ApiError(400, "INVALID_PARAM", "缺少搜索词 q")
    return search(q)
