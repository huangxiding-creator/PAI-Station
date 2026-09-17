"""USN readjournal CSV 解析：FRN 连接 rename/move 语义化增量（地基模块）。

fsutil usn readjournal <卷> csv 每行 = Usn,文件名,文件名长度,原因编号,
原因,时间戳,文件属性编号,文件属性,文件 ID,父文件 ID,源信息号,源信息,
安全 ID,主要版本,次要版本,记录长度,…（中文表头，列序固定）。
文件 ID/父文件 ID = 零填充十六进制字符串（int(x,16) 直取）。
startUsn 参数在本机构建（19045）rc=1 不可用——整读后按 Usn>游标
早过滤（352K 行逐行首段 int 比较亚秒级）。

价值：轮询型 live_watch 眼里移动=删+建，500 页 PDF 挪个目录就重
OCR；USN 的 RENAME_OLD/NEW_NAME 同文件 ID 把两侧连成一次 path
更新——chunk_id 内容哈希去重，向量全保留。journal 回卷（游标早于
第一个 USN）→ gap 标记回退全量扫兜底。
"""
from __future__ import annotations

import csv
import io
import logging
import re
from dataclasses import dataclass

_log = logging.getLogger("paistation.sense.localfiles.usn")

# USN_RECORD 原因位（语言无关；CSV 原因列是本地化文本，只做日志用）
REASON_DATA_OVERWRITE = 0x00000001
REASON_DATA_EXTEND = 0x00000002
REASON_DATA_TRUNCATION = 0x00000004
REASON_FILE_CREATE = 0x00000100
REASON_FILE_DELETE = 0x00000200
REASON_RENAME_OLD_NAME = 0x00001000
REASON_RENAME_NEW_NAME = 0x00002000
REASON_BASIC_INFO_CHANGE = 0x00008000
REASON_CLOSE = 0x80000000

_RENAME_MASK = REASON_RENAME_OLD_NAME | REASON_RENAME_NEW_NAME
# 纯噪音位组合（如仅 CLOSE / 仅基本信息变化）不入事件流
_INTERESTING = (REASON_FILE_CREATE | REASON_FILE_DELETE | _RENAME_MASK
                | REASON_DATA_OVERWRITE | REASON_DATA_EXTEND
                | REASON_DATA_TRUNCATION)

_HEADER_RE = re.compile(r"^(Usn|Usn,)")


@dataclass(slots=True)
class UsnRecord:
    usn: int
    name: str
    reasons: int
    file_id: int
    parent_id: int
    ts: str


def parse_csv(text: str, since_usn: int = 0) -> list[UsnRecord]:
    """整读 CSV 文本 → 记录列表（Usn 升序保持文件序）。

    头部元信息行（日志 ID/水位/版本）逐行跳过直到表头行；游标过滤
    在 csv 解析前做首段 int 比较——35 万行亚秒级，只精解析新尾部。
    解析失败的行跳过（journal 边缘被覆盖的半行常态，不致命）。
    """
    out: list[UsnRecord] = []
    started = False
    for line in text.splitlines():
        if not started:
            started = bool(_HEADER_RE.match(line))
            continue
        # 早过滤：首段（到第一个逗号）= 十进制 Usn
        head, sep, _rest = line.partition(",")
        if not sep:
            continue
        try:
            usn = int(head)
        except ValueError:
            continue
        if usn <= since_usn:
            continue
        try:
            row = next(csv.reader([line]))
            if len(row) < 10:
                continue
            out.append(UsnRecord(
                usn=usn,
                name=row[1],
                reasons=int(row[3], 16),
                file_id=int(row[8], 16),
                parent_id=int(row[9], 16),
                ts=row[5]))
        except (ValueError, IndexError):
            continue
    return out


def parse_meta(text: str) -> dict:
    """readjournal 头部元信息 → {'first_usn', 'next_usn'}（回卷判定用）。

    中文机标签行序固定（第一个/下一个 USN 均为十进制无 0x），
    标签文本不匹配时按行序取兜底。
    """
    res: dict = {}
    m = re.search(r"第一个 USN\s*:\s*(\d+)", text)
    if m:
        res["first_usn"] = int(m.group(1))
    m = re.search(r"下一个 USN\s*:\s*(\d+)", text)
    if m:
        res["next_usn"] = int(m.group(1))
    return res


@dataclass(slots=True)
class MoveEvent:
    """rename/move 合成事件：path=旧全路径前的旧名，dest=新名。

    父 ID 不变=同名移动；父 ID 变=跨目录移动。全路径拼装由上层
    （FRN→path 解析器）完成——本模块只做记录级配对。
    """
    file_id: int
    old_name: str
    new_name: str
    old_parent: int
    new_parent: int
    usn: int

    @property
    def cross_dir(self) -> bool:
        return self.old_parent != self.new_parent


def synthesize_moves(records: list[UsnRecord]) -> tuple[list[MoveEvent],
                                                        list[UsnRecord]]:
    """按 file_id 配对 RENAME_OLD/NEW_NAME（窗口内 Usn 序）。

    返回 (配对事件, 未配对的 NEW_NAME 记录)。OLD 落在窗口外（游标
    前已发生）时 NEW 无对——上层按『新路径出现』处理（等价 created，
    语义不丢）。多次连续 rename（a→b→c）自然链式配对。
    """
    moves: list[MoveEvent] = []
    pendings: dict[int, UsnRecord] = {}  # file_id → 最近一条 OLD
    news: list[UsnRecord] = []
    for r in records:
        if not r.reasons & _RENAME_MASK:
            continue
        if r.reasons & REASON_RENAME_OLD_NAME:
            pendings[r.file_id] = r  # 后到的 OLD 覆盖（链式改名）
        elif r.reasons & REASON_RENAME_NEW_NAME:
            old = pendings.pop(r.file_id, None)
            if old is None:
                news.append(r)
            else:
                moves.append(MoveEvent(
                    file_id=r.file_id, old_name=old.name,
                    new_name=r.name, old_parent=old.parent_id,
                    new_parent=r.parent_id, usn=r.usn))
    return moves, news


def classify(record: UsnRecord) -> str | None:
    """记录 → 队列事件 op 分类；噪音（纯 CLOSE/纯基本信息）→ None。"""
    if not record.reasons & _INTERESTING:
        return None
    if record.reasons & REASON_FILE_DELETE:
        return "deleted"
    if record.reasons & _RENAME_MASK:
        return "renamed"
    if record.reasons & REASON_FILE_CREATE:
        return "created"
    return "modified"


def gap_check(cursor_usn: int, meta: dict) -> bool:
    """journal 回卷判定：游标早于最早记录=中间记录已被覆盖丢失。"""
    first = meta.get("first_usn")
    return first is not None and cursor_usn < first


def resolve_events(records: list[UsnRecord],
                   dir_frn: dict[int, str],
                   domain_prefixes: tuple[str, ...] = (),
                   ) -> list[dict]:
    """记录 → 队列事件（路径反解全靠父目录 FRN 映射，零库存依赖）。

    - rename 对（synthesize_moves）→ {"path": 旧, "op": "renamed",
      "dest": 新}：新旧路径任一拼不出（父目录不在映射=域外/新目录
      未刷新）→ 整对丢弃，全量扫兜底
    - 普通记录 classify 后按 父FRN+文件名 拼全路径，域前缀过滤
    - deleted/created/modified 直接发；消费端 apply_event 幂等
    载荷与库存库完全解耦——避免与 extract 写端并发。
    """
    events: list[dict] = []

    def _path(parent: int, name: str) -> str | None:
        d = dir_frn.get(parent)
        if d is None:
            return None
        p = f"{d}\\{name}" if not d.endswith("\\") else f"{d}{name}"
        if domain_prefixes and not p.startswith(domain_prefixes):
            return None
        return p

    moves, news = synthesize_moves(records)
    for m in moves:
        old = _path(m.old_parent, m.old_name)
        new = _path(m.new_parent, m.new_name)
        if old and new:
            events.append({"path": old, "op": "renamed", "dest": new})
    for r in news:  # 旧侧在窗口外的 rename 新侧：等价 created
        p = _path(r.parent_id, r.name)
        if p:
            events.append({"path": p, "op": "created"})
    seen: set[tuple] = set()
    for r in records:
        op = classify(r)
        if op is None or op == "renamed":  # rename 已走对专线
            continue
        p = _path(r.parent_id, r.name)
        if p and (p, op) not in seen:
            seen.add((p, op))
            events.append({"path": p, "op": op})
    return events


def build_dir_frn_map(roots: list[str],
                      exclude_names: set[str] = frozenset(
                          {"node_modules", ".git", "__pycache__"})
                      ) -> dict[int, str]:
    """域根目录树 → {目录FRN: 目录绝对路径}（文件不进，秒级）。

    新建目录 15 分钟窗内的事件可能拼不出路径而丢弃——全量扫兜底；
    映射每轮全量重建自愈。
    """
    import os

    out: dict[int, str] = {}
    stack = [r.rstrip("\\") for r in roots]
    while stack:
        cur = stack.pop()
        try:
            frn = os.stat(cur).st_ino
            if frn:
                out[frn] = cur
        except OSError:
            continue
        try:
            with os.scandir(cur) as it:
                for e in it:
                    try:
                        if e.is_dir(follow_symlinks=False) and \
                                e.name.lower() not in exclude_names:
                            stack.append(e.path)
                    except OSError:
                        continue
        except OSError:
            continue
    return out
