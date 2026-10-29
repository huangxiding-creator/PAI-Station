# -*- coding: utf-8 -*-
"""渠道编排池（元数据层）：多渠道并发真检索 → 元数据池。

用户令背景：知识库蓝图三级编目树必须基于真实调研生成（非种子预置）——
本池就是「真实调研腿」的取材口：把一句话需求扩成查询词，向全部在役
渠道适配器并发取真实元数据（FileMeta dict 化），供编目树/蓝图回填层消费。
本模块零蓝图逻辑、零下载（网络全在各 adapter 内），不改 engine.py/blueprint.py
（接线由收口波统一做）。

【2.0 A1 调研深挖（轴①×5）——深化不破坏既有契约】
  - harvest_pool 新参数 pages=1：每查询词每渠道翻 N 页。各适配器 metadata(query,
    limit) 本就支持 limit 调大（内部自翻页到 limit 收满），故池侧等价翻页=
    有效 limit 提到 per_q*pages（缺省 per_q=12 时即 pages*12，任务口径）；
    pages=1 时行为与升级前逐字节一致（零漂移）。
  - expand_queries 出词 6-12 → 12（缺省满额 min_q=12）：THUOCL 高 DF 命中腿
    扩到「首关键词×命中 + 次关键词×命中」双路 + 关键词二元组合腿，名词库
    兜底补足仍在（词表缺席如实退化仍保下限）。
  - 目标账（池规模，在线渠道论——离线渠道 degrade 如实计 0 不冒充）：
    在线渠道数 × 词数 × per_q × pages ≥ 1000。七渠道全开缺省档
    7×12×12=1008 已达标；pages=5 深挖档 7×12×60=5040；即便 1 渠道离线，
    6×12×60=4320 仍达标。实测以 audit pool_end/pool_query 实数对账（零造假）。
  - wenku ndview 目录层透传：build_registry/harvest_pool 新参数 wenku_ndview
    （None=适配器缺省=env KB_WENKU_NDVIEW 自决）→ wenku extra['ndview'] 的
    tags/类目目录层情报（提取件=wenku_taxonomy.py 新文件，本池只透传开关）。

【5x 池扩容（用户令：云托管实测 212 件 → 目标池 1000+，文件数量再提 5 倍）】
  - 根因修复在适配器侧已闭环（v2.5 起 metadata 内部真翻页聚合到 limit 收满）：
    wenku syncmrecall pn 页式（每页硬限 12）/ djyanbao api page 参数（10）/
    doc88 post.do p= 页码（9），limit=36（per_q=12×pages=3）由适配器自翻
    3~4 页收满，不再「limit 放大但每页封顶拿不满」；页间频控走既有
    RateLimiter 正常间隔（翻页计入正常额度，每渠道日上限守恒）。本波池侧
    翻页零改动，行为由各适配器 x5 翻页用例钉死（两页聚合/短页终止/翻页间隔）。
  - expand_queries 出词 12 → 24（缺省满额 min_q=24）：关键词 C(2,3) 组合腿
    （二元 3 + 三元 1）+ THUOCL 高 DF 命中词三路（首/次/第三关键词×命中前 6）
    + 命中词自身精确腿 + 名词库两级兜底（kws0×名词 + 名词二元组合垫腿保
    24 必可达；词表缺席如实退化仍满额，同输入必同输出不变）。
  - 目标账（池规模，在线渠道论——离线渠道 degrade 如实计 0 不冒充）：
    24 词 × 36 条（per_q=12×pages=3）× 3+ 渠道 × ~75% 保留率 =
    24×36×3×0.75 = 1944 ≥ 1000；七渠道全开原始面 24×36×7=6048 更富余。
    实测以 audit pool_end/pool_query 实数对账（零造假）。

三件入口：
  1. harvest_pool(queries, channels=None, per_q=12, pages=1, timeout=120)
     → {channel: [FileMeta dict 化]}。默认渠道=在役适配器全家桶：
     wenku/djyanbao/doc88/chinca/dangdang/cnki + ima（登录态常缺可选，
     available() 本地门自动降级 []，零请求零网络）。
     并发：threading 每渠道一线程，线程内串行遵守各自 RateLimiter；
     timeout=总墙钟预算，到点置 stop：已收手退出的渠道保留实得部分
     （零造假不弃真数据，audit 记 stopped 一行）；宽限后仍卡在阻塞调用的
     渠道 → 返 [] 如实（audit 记 timeout 一行，daemon 线程不阻塞进程）。
     各渠道失败/熔断/日限 → 已得部分（或 []）+ audit 照常，绝不崩溃。
  2. expand_queries(text) → 24 查询词（缺省满额；纯本地零网络）：
     purpose.derive_purpose 关键词 × thuocl 高 DF 词扩展——领域词典命中
     （THUOCL 143k 词正扫文本，按跨域最大 DF 降序取头部）三路组合 +
     关键词 C(2,3) 二元/三元组合 + 命中词自身精确腿 + 通用名词库两级
     兜底，同输入必同输出；词表缺席如实退化（组合腿+兜底仍可达满额）。
  3. build_registry(audit, wenku_ndview=None) → 渠道名→适配器实例注册表
     （W3 接线/测试注入用）。

CLI：py -3 -m kb_factory.channel_adapters.pool "一句话需求" [--per-q N]
     [--pages N] [--timeout S] [--channels a,b] [--expand-only]
"""
import argparse
import functools
import json
import re
import sys
import threading
import time
from dataclasses import asdict

from kb_factory.catalog_engine import purpose, thuocl_lex
from kb_factory.channel_adapters.base import (AuditLog, ChannelAdapter, FileMeta,
                                              AUDIT_DEFAULT_PATH)
from kb_factory.channel_adapters.chinca_meta import ChincaAdapter
from kb_factory.channel_adapters.cnki_meta import CnkiAdapter
from kb_factory.channel_adapters.dangdang_meta import DangdangAdapter
from kb_factory.channel_adapters.djyanbao_meta import DjyanbaoAdapter
from kb_factory.channel_adapters.doc88_meta import Doc88Adapter
from kb_factory.channel_adapters.ima_meta import ImaMetaAdapter
from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter

__all__ = ["harvest_pool", "expand_queries", "build_registry", "meta_to_dict",
           "DEFAULT_CHANNELS"]

# 默认渠道序（=默认并发线程集）：四个免登录在役渠道 + 两复刻件新适配，
# ima 殿后（登录态常缺，available() 门降级 []，零请求零网络）
DEFAULT_CHANNELS = ("wenku", "djyanbao", "doc88", "chinca", "dangdang", "cnki", "ima")

# FileMeta dict 化字段序（asdict 保持 dataclass 字段序）
META_KEYS = ("title", "fmt", "pages", "badge", "perm", "source_url", "extra")

# 停止线程宽限（秒）：到点 stop 后给在飞请求/收手路径一点落地时间
_GRACE_DEFAULT = 2.0


def meta_to_dict(m: FileMeta) -> dict:
    """FileMeta → 纯 dict（槽位回填/JSON 落盘形态；extra 深拷贝防串改）。"""
    return asdict(m)


# ---------------------------------------------------------------- 注册表

def build_registry(audit=None, wenku_ndview: bool | None = None) -> dict:
    """渠道名 → 适配器实例（每次全新构造：配额/熔断态随池独立，互不串账）。

    构造全程零网络（复刻件惰性加载、频控器纯内存）；audit 注入后各适配器
    请求行与池级行共写同一 audit.jsonl（AuditLog 已加锁保行完整）。
    wenku_ndview：wenku ndview 元数据增强开关池级透传（2.0 A1 目录层）——
    None=适配器缺省（env KB_WENKU_NDVIEW 自决，行为与升级前一致）；
    True/False=显式定夺（tags/类目进 extra['ndview']，见 wenku_taxonomy.py）。
    """
    return {
        "wenku": WenkuMetaAdapter(audit=audit, ndview=wenku_ndview),
        "djyanbao": DjyanbaoAdapter(audit=audit),
        "doc88": Doc88Adapter(audit=audit),
        "chinca": ChincaAdapter(audit=audit),
        "dangdang": DangdangAdapter(audit=audit),
        "cnki": CnkiAdapter(audit=audit),
        "ima": ImaMetaAdapter(audit=audit),
    }


def _resolve_channels(channels, registry: dict) -> list:
    """channels 入参归一：None=默认全家桶；元素=渠道名 str 或适配器实例。"""
    if channels is None:
        return [registry[c] for c in DEFAULT_CHANNELS if c in registry]
    picked, seen = [], set()
    for c in channels:
        if isinstance(c, ChannelAdapter):
            ad = c
        elif isinstance(c, str):
            if c not in registry:
                raise ValueError(f"未知渠道名: {c!r}（可用: {sorted(registry)}）")
            ad = registry[c]
        else:
            raise TypeError("channels 元素须为 ChannelAdapter 实例或渠道名 str，"
                            f"得到 {type(c).__name__}")
        if ad.channel not in seen:      # 同名渠道去重（保留首现）
            seen.add(ad.channel)
            picked.append(ad)
    return picked


# ---------------------------------------------------------------- 渠道工作线程

def _channel_worker(adapter, queries, per_q_limit, stop: threading.Event,
                    results: dict, progress: dict, audit: AuditLog) -> None:
    """单渠道线程：available 门 → 逐查询串行调 metadata（各自 RateLimiter 频控）。

    per_q_limit=每查询词有效条上限（=per_q×pages，池侧翻页等价口径，见模块头）；
    契约：工作线程绝不向上抛；stop 置位后下一查询前收手（已得部分保留）；
    适配器抛异常（熔断/日限/未预期）→ 本渠道收工，已得部分保留 + audit 一行。
    """
    ch = adapter.channel
    try:
        try:
            ok, why = adapter.available(), ""
            if not ok:
                why = adapter.reason()
        except Exception as e:          # available() 自身异常也如实降级
            ok, why = False, f"available() {type(e).__name__}: {e}"
        if not ok:
            audit.log(channel=ch, event="degrade", query=queries[0] if queries else "",
                      count=0, detail=why or "unavailable")
            results[ch] = []
            return
        collected: list = []
        for i, q in enumerate(queries):
            if stop.is_set():           # 总超时收手：实得部分保留，审计如实
                audit.log(channel=ch, event="stopped", query=q, count=len(collected),
                          detail=f"queries_done={i}/{len(queries)}")
                break
            t0 = time.monotonic()
            try:
                metas = adapter.metadata(q, per_q_limit) or []
            except Exception as e:     # 熔断/日限类：本渠道收工（已得部分保留）
                audit.log(channel=ch, event="pool_error", query=q, count=len(collected),
                          elapsed_ms=int((time.monotonic() - t0) * 1000),
                          detail=f"{type(e).__name__}: {e}")
                break
            collected.extend(metas)
            progress[ch] = i + 1
            audit.log(channel=ch, event="pool_query", query=q, count=len(metas),
                      elapsed_ms=int((time.monotonic() - t0) * 1000))
        results[ch] = collected
    except Exception as e:              # 防御性兜底：线程内消化一切异常
        audit.log(channel=ch, event="pool_error", query="", count=0,
                  detail=f"worker {type(e).__name__}: {e}")
        results.setdefault(ch, [])


def harvest_pool(queries, channels=None, per_q: int = 12, pages: int = 1,
                 timeout: float = 120.0, audit: AuditLog | None = None,
                 grace: float = _GRACE_DEFAULT, registry: dict | None = None,
                 wenku_ndview: bool | None = None) -> dict:
    """多渠道并发真检索 → 元数据池 {channel: [FileMeta dict 化]}。

    - queries：查询词列表（建议 expand_queries 产物 24 词）；
    - channels：None=默认渠道全家桶；或渠道名 str / 适配器实例的混合列表；
    - per_q：每渠道每查询词取条基数上限（×pages 后透传 adapter.metadata(limit)）；
    - pages：每查询词每渠道翻页倍率（2.0 A1；缺省 1=行为与升级前一致）。
      各适配器 metadata(query, limit) 内部自翻页收满 limit，故有效上限=
      per_q×pages（缺省 12×1=12；深挖档如 12×5=60），无需池侧改适配器契约；
    - timeout：总墙钟预算（秒）；超时口径见模块 docstring（卡死渠道 [] 如实，
      收手渠道实得部分保留）；
    - audit：默认写包内 audit.jsonl（池级事件 + 各适配器请求行共用）；
    - registry：渠道注册表（测试注入用；None=build_registry(audit, wenku_ndview)）；
    - wenku_ndview：wenku ndview 目录层开关透传（None=适配器 env 缺省；仅
      registry=None 自建时生效，显式注入 registry 时以注册表内实例为准）。
    零造假：检索不到如实计 0（pool_query 行 count 实数），禁编造。
    """
    qs = [str(q).strip() for q in (queries or []) if str(q).strip()]
    pages_i = max(1, int(pages))               # 翻页倍率下限 1（零漂移兜底）
    per_q_i = max(1, int(per_q))
    per_q_limit = per_q_i * pages_i            # 池侧翻页等价：limit 调大即翻 N 页
    audit = audit if audit is not None else AuditLog(AUDIT_DEFAULT_PATH)
    reg = registry if registry is not None else build_registry(audit,
                                                               wenku_ndview=wenku_ndview)
    picked = _resolve_channels(channels, reg)
    results: dict = {ad.channel: [] for ad in picked}
    progress: dict = {ad.channel: 0 for ad in picked}
    audit.log(event="pool_start", count=len(qs), per_q=per_q_i, pages=pages_i,
              timeout=timeout, channels=[ad.channel for ad in picked])
    if qs and picked:
        stop = threading.Event()
        threads = []
        for ad in picked:
            t = threading.Thread(target=_channel_worker,
                                 args=(ad, qs, per_q_limit, stop, results, progress, audit),
                                 name=f"kbpool-{ad.channel}", daemon=True)
            threads.append((ad, t))
            t.start()
        deadline = time.monotonic() + max(0.0, float(timeout))
        for _, t in threads:            # 总预算内等各渠道自然完成
            t.join(max(0.0, deadline - time.monotonic()))
        stop.set()                      # 到点：通知未完渠道收手
        for _, t in threads:            # 宽限：让在飞请求/收手路径落地
            t.join(max(0.0, float(grace)))
        for ad, t in threads:
            if t.is_alive():            # 宽限后仍卡阻塞调用：返 [] 如实（不弃真数据——
                audit.log(               # 已得部分在 audit 可对账，线程 daemon 不阻进程）
                    channel=ad.channel, event="timeout", count=0,
                    detail=f"queries_done={progress[ad.channel]}/{len(qs)}")
                results[ad.channel] = []
    totals = {ch: len(v) for ch, v in results.items()}
    audit.log(event="pool_end", total=sum(totals.values()), by_channel=totals)
    # 快照返回：卡死线程事后落账不改本池结论
    return {ch: [meta_to_dict(m) for m in v] for ch, v in results.items()}


# ---------------------------------------------------------------- 查询词扩展

@functools.lru_cache(maxsize=1)
def _word_df_index() -> dict:
    """THUOCL 词→{领域:df} 倒排索引（进程内缓存一次；缺席如实空 dict）。"""
    try:
        return thuocl_lex.word_df_index()
    except Exception:                   # 词表缺位/损坏：扩展腿退化，名词库兜底
        return {}


def _thuocl_hits(text: str, index: dict, exclude) -> list:
    """领域词典命中：THUOCL 词正扫文本（纯本地），按跨域最大 DF 降序、
    同 DF 长词优先、同长字典序稳定排（确定性；top-N 截断自然滤低 DF 噪声）。"""
    hits = []
    for w, dfs in index.items():
        if len(w) < 2 or w in exclude:
            continue                    # 单字噪声大；已在关键词内不重复
        if w in text:
            hits.append((w, max(dfs.values())))
    hits.sort(key=lambda x: (-x[1], -len(x[0]), x[0]))
    return [w for w, _ in hits]


def expand_queries(text, min_q: int = 24, max_q: int = 24, index: dict | None = None) -> list:
    """一句话需求 → 查询词（缺省满额 24；纯本地零网络，同输入必同输出）。

    5x 扩容（出词 12 → 24，用户令池 1000+）七腿（确定性序，_add 全程去重）：
      ① purpose.derive_purpose 关键词前 3 合体主查询；
      ② 单词精确腿（前 5）；
      ③ THUOCL 高 DF 命中词 × 首关键词（前 6 命中，跨域最大 DF 降序）；
      ④ 关键词 C(2,3) 组合腿：二元（k0k1/k0k2/k1k2）+ 三元（k0k1k2，
         与①同串自然去重——组合语义入队，不虚占词位）；
      ⑤⑥ THUOCL 高 DF 命中词 × 次/第三关键词（各前 6，深化路）；
      ⑦ THUOCL 高 DF 命中词自身精确腿（前 6）；
      末位 purpose.KEY_NOUN_BANK 两级兜底：kws0×名词补足 + 名词二元组合
      垫腿（名词库 22 词时单级只到 23，垫腿保 min_q=24 必可达）。
    词表缺席/零命中如实退化（④+两级兜底仍满额），空文本走
    「原文截断 + 名词库 + 名词组合」路径。
    """
    t = re.sub(r"\s+", " ", str(text or "")).strip()
    kws = list(purpose.derive_purpose(t)["keywords"])
    hit_words = _thuocl_hits(t, index if index is not None else _word_df_index(),
                             set(kws)) if t else []
    queries: list = []

    def _add(q):
        q = (q or "").strip()
        if q and q not in queries:
            queries.append(q)

    if kws:
        _add(" ".join(kws[:3]))                     # ① 主查询：前 3 关键词合体
        for k in kws[:5]:                           # ② 单词精确腿
            _add(k)
        for h in hit_words[:6]:                     # ③ THUOCL 高 DF × 首关键词
            _add(f"{kws[0]} {h}")
        top = kws[:3]                               # ④ C(2,3) 组合腿：二元+三元
        for i in range(len(top)):
            for j in range(i + 1, len(top)):
                _add(f"{top[i]} {top[j]}")
        _add(" ".join(top))                         #    三元组合（与①同串自然去重）
        for k in kws[1:3]:                          # ⑤⑥ 高 DF × 次/第三关键词
            for h in hit_words[:6]:
                _add(f"{k} {h}")
        for h in hit_words[:6]:                     # ⑦ 高 DF 命中词自身精确腿
            _add(h)
        for noun in purpose.KEY_NOUN_BANK:          # 兜底一级：首关键词×名词
            if len(queries) >= min_q:
                break
            _add(f"{kws[0]} {noun}")
    else:                                           # 零关键词：原文（或缺省词）+名词库
        _add(t[:16] or "综合资料")
        for noun in purpose.KEY_NOUN_BANK:
            if len(queries) >= min_q:
                break
            _add(noun)
    nouns = list(purpose.KEY_NOUN_BANK)             # 兜底二级：名词二元组合垫腿
    for i in range(len(nouns)):                     # （名词库 22 词时上两级只到 23，
        if len(queries) >= min_q:                   #   垫腿保 min_q=24 必可达）
            break
        for j in range(i + 1, len(nouns)):
            if len(queries) >= min_q:
                break
            _add(f"{nouns[i]} {nouns[j]}")
    return queries[:max_q]


# ---------------------------------------------------------------- CLI

def main(argv=None) -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser(description="渠道编排池：多渠道并发真检索→元数据池")
    ap.add_argument("text", help="一句话需求（自动 expand_queries 扩词）")
    ap.add_argument("--per-q", type=int, default=12)
    ap.add_argument("--pages", type=int, default=1,
                    help="每查询词每渠道翻页倍率（有效 limit=per_q×pages；缺省 1）")
    ap.add_argument("--timeout", type=float, default=120.0)
    ap.add_argument("--channels", default=None, help="渠道名逗号分隔（缺省=全家桶）")
    ap.add_argument("--expand-only", action="store_true", help="只扩词不打网络")
    ns = ap.parse_args(argv)
    queries = expand_queries(ns.text)
    print(json.dumps({"queries": queries}, ensure_ascii=False, indent=1))
    if ns.expand_only:
        return 0
    channels = [c.strip() for c in ns.channels.split(",")] if ns.channels else None
    pool = harvest_pool(queries, channels=channels, per_q=ns.per_q, pages=ns.pages,
                        timeout=ns.timeout)
    print(json.dumps({ch: {"count": len(v), "first": v[0]["title"] if v else None}
                      for ch, v in pool.items()}, ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
