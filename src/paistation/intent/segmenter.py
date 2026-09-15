"""M7b 分段器：银甲虫 task-blocks 规则移植 + TaskTracer 任务-资源绑定。

方法论栈第①层：事件流 → 活动段。断块规则（银甲虫标定）：
  - 采样间隔 >5 分钟
  - AFK 边界双向（进入 ≥5min 离席 / 离席后恢复）
  - 硬类别切换（聊天/娱乐/空闲 参与即切，不足票数也切）
  - 类别变更 ≥6 样本投票（噪声容忍）
  - 应用变更 ≥10 样本 / 应用+类别同时变更 ≥4 样本
资源绑定（TaskTracer 学术谱系）：fs.change / clipboard.change 按时间窗
（±30s）挂到活动块 → related_files / related_clipboard。

时长用事件真实时间戳（优于银甲虫 采样数×0.5min 估计）。
"""
from __future__ import annotations

from datetime import datetime, timedelta

from .l1_fast import CATEGORIES, classify

_GAP_SEC = 300.0                       # 采样间隔 >5min → 断块
_HARD_SWITCH = frozenset({"meeting", "chat", "leisure", "idle"})
_VOTES_CATEGORY = 6
_VOTES_APP = 10
_VOTES_APP_CATEGORY = 4
_RESOURCE_WINDOW_SEC = 30.0            # TaskTracer 绑定时间窗
_MAX_TITLES = 5
_MAX_DOMAINS = 6
_MAX_FILES = 6


def _parse_ts(raw) -> datetime | None:
    try:
        return datetime.fromisoformat(str(raw))
    except (TypeError, ValueError):
        return None


def samples_from_events(events) -> list[dict]:
    """window.focus / presence.afk / browser.url → 采样序列。

    browser.url 与 window.focus 同刻发射（SignalService 契约），
    域名挂到最近一个采样；presence.afk(start) 展开为离席样本。
    """
    out: list[dict] = []
    for ev in events:
        etype = ev.get("type")
        ts = _parse_ts(ev.get("ts"))
        if ts is None:
            continue
        if etype == "window.focus":
            out.append({"ts": ts,
                        "process": (ev.get("meta") or {}).get("process",
                                                              ""),
                        "title": ev.get("text") or "",
                        "domain": "", "idle_s": 0.0})
        elif etype == "browser.url":
            if out and out[-1]["ts"] == ts and not out[-1]["domain"]:
                out[-1]["domain"] = ev.get("text") or ""
        elif (etype == "presence.afk"
              and (ev.get("meta") or {}).get("phase") == "start"):
            out.append({"ts": ts, "process": "", "title": "",
                        "domain": "", "idle_s": 9999.0})
    return out


def build_blocks(samples) -> list[dict]:
    """采样序列（L1 已分类口径）→ 活动块列表。"""
    rows = []
    for s in samples:
        c = classify(s)
        rows.append({**s, "category": c["category"],
                     "confidence": c["confidence"]})
    blocks: list[dict] = []
    cur: dict | None = None
    for r in rows:
        if cur is None or _split_reason(cur, r):
            cur = {"rows": [], "last_ts": r["ts"], "max_idle": 0.0,
                   "category": r["category"],
                   "last_process": r["process"],
                   "same_cat": 0, "same_app": 0, "same_appcat": 0}
            blocks.append(cur)
        _absorb(cur, r)
    return [_finalize(b) for b in blocks]


def _split_reason(cur: dict, r: dict) -> bool:
    gap = (r["ts"] - cur["last_ts"]).total_seconds()
    if gap > _GAP_SEC:
        return True
    if r["idle_s"] >= 300 and cur["max_idle"] < 300:
        return True                            # 进入 AFK
    if cur["max_idle"] >= 300 and r["idle_s"] < 60:
        return True                            # 离席后恢复
    if r["category"] != cur["category"]:
        if r["category"] in _HARD_SWITCH or cur["category"] in _HARD_SWITCH:
            return True                        # 硬类别切换
        if cur["same_cat"] >= _VOTES_CATEGORY:
            return True                        # 类别变更 ≥6 票
        if (r["process"] != cur["last_process"]
                and cur["same_appcat"] >= _VOTES_APP_CATEGORY):
            return True                        # 应用+类别变更 ≥4 票
        return False
    if r["process"] != cur["last_process"] and cur["same_app"] >= _VOTES_APP:
        return True                            # 应用变更 ≥10 票
    return False


def _absorb(cur: dict, r: dict) -> None:
    same_cat = r["category"] == cur["category"]
    same_app = r["process"] == cur["last_process"]
    cur["same_cat"] = cur["same_cat"] + 1 if same_cat else 1
    cur["same_app"] = cur["same_app"] + 1 if same_app else 1
    cur["same_appcat"] = (cur["same_appcat"] + 1
                          if same_cat and same_app else 1)
    cur["rows"].append(r)
    cur["category"] = r["category"]
    cur["last_process"] = r["process"]
    cur["last_ts"] = r["ts"]
    cur["max_idle"] = max(cur["max_idle"], r["idle_s"])


def _finalize(cur: dict) -> dict:
    rows = cur["rows"]
    counts: dict[str, int] = {}
    for r in rows:
        counts[r["category"]] = counts.get(r["category"], 0) + 1
    dominant = max(counts, key=lambda k: counts[k])
    dom_rows = [r for r in rows if r["category"] == dominant]
    start, end = rows[0]["ts"], rows[-1]["ts"]
    app_counts: dict[str, int] = {}
    titles, domains = [], []
    for r in rows:
        if r["process"]:
            app_counts[r["process"]] = app_counts.get(r["process"], 0) + 1
        if r["title"] and r["title"] not in titles and len(titles) < \
                _MAX_TITLES:
            titles.append(r["title"])
        if r["domain"] and r["domain"] not in domains:
            domains.append(r["domain"])
    return {
        "start": start,
        "end": end,
        "duration_min": round((end - start).total_seconds() / 60, 1),
        "samples": len(rows),
        "process": (max(app_counts, key=lambda k: app_counts[k])
                    if app_counts else ""),  # 离席块无进程样本
        "titles": titles,
        "domains": domains[:_MAX_DOMAINS],
        "category": dominant,
        "label": CATEGORIES[dominant],
        "category_counts": counts,
        "coverage": round(counts[dominant] / len(rows), 2),
        "confidence": round(sum(r["confidence"] for r in dom_rows)
                            / len(dom_rows), 2),
        "related_files": [],
        "related_clipboard": [],
    }


def attach_resources(blocks: list[dict], events) -> list[dict]:
    """TaskTracer 任务-资源绑定：时间窗内 fs/剪贴板事件挂块。"""
    fs = [e for e in events if e.get("type") == "fs.change"]
    clips = [e for e in events if e.get("type") == "clipboard.change"]
    if not fs and not clips:
        return blocks
    fs_ts = [(_parse_ts(e.get("ts")), e) for e in fs]
    clip_ts = [(_parse_ts(e.get("ts")), e) for e in clips]
    for b in blocks:
        w0 = b["start"] - timedelta(seconds=_RESOURCE_WINDOW_SEC)
        w1 = b["end"] + timedelta(seconds=_RESOURCE_WINDOW_SEC)
        files = []
        for ts, e in fs_ts:
            if ts and w0 <= ts <= w1:
                meta = e.get("meta") or {}
                files.extend(meta.get("paths")
                             or (e.get("evidence") or {}).get("paths")
                             or [])
        kinds = []
        for ts, e in clip_ts:
            if ts and w0 <= ts <= w1:
                kind = (e.get("meta") or {}).get("kind")
                if kind:
                    kinds.append(kind)
        b["related_files"] = sorted(set(files))[:_MAX_FILES]
        b["related_clipboard"] = sorted(set(kinds))
    return blocks


def blocks_from_events(events) -> list[dict]:
    """事件流 → 活动块（采样→分类→分段→资源绑定 全链）。"""
    return attach_resources(build_blocks(samples_from_events(events)),
                            events)
