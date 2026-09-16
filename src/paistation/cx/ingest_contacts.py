# -*- coding: utf-8 -*-
"""CX 域2 工作人际：微信联系人（rion reader 导出）→ 实体登记表。

- 解析层纯函数：parse_rion_contacts(json_text)
- 登记层：register_wechat_contacts(store, contacts, owner_wxid)
  每位好友 → person 实体（wxid/微信号/昵称进别名=后续 splink 消解的强标识符）；
  好友 → 主人 friend_of 边（主人自身账号作锚点；锚点 wxid 配置在本地私有
  data/cx/owner.json，代码与仓库不含个人标识符）。
- 目的边界（2026-09-16）：只登记身份事实，不解析聊天内容；个人消费/纯私人
  内容不入画像。
"""

from __future__ import annotations

import json
import os
import shutil
import subprocess
from pathlib import Path

READER = Path(__file__).resolve().parents[3] / ".claude/skills/wechat-cli/scripts/reader.sh"


def git_bash() -> str:
    """Git Bash 绝对路径。坑：Python 子进程裸 'bash' 会命中 System32 的
    WSL bash（未装发行版即 rc=1），必须显式解析。"""
    override = os.environ.get("CX_BASH")
    if override:
        return override
    for cand in (
        r"C:\Program Files\Git\bin\bash.exe",
        r"C:\Program Files (x86)\Git\bin\bash.exe",
    ):
        if Path(cand).exists():
            return cand
    w = shutil.which("bash")
    if w and "system32" not in w.lower():
        return w
    raise RuntimeError("Git Bash 未找到：设 CX_BASH 指向 bash.exe")


def run_reader(*args: str, timeout: int = 120) -> str:
    """调 rion-wechat-cli reader（UTF-8 强制防 GBK 崩 + 无窗 + 幂等缓存由调用方管）。"""
    env = dict(os.environ, PYTHONUTF8="1")
    proc = subprocess.run(
        [git_bash(), str(READER), *args],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=timeout, env=env,
        cwd=str(READER.parents[3]),
    )
    if proc.returncode != 0 or not proc.stdout.strip():
        raise RuntimeError(f"reader {args[0]} rc={proc.returncode}: {proc.stderr[-200:]}")
    return proc.stdout

# 微信内置系统号（语音记事本/漂流瓶等伪联系人，非真人）
SYSTEM_ACCOUNTS = frozenset({
    "weixin", "weixinhelper", "weixinremind", "weixinreminder", "weibo",
    "qqmail", "fmessage", "tmessage", "qmessage", "qqsync", "floatbottle",
    "lbsapp", "shakeapp", "medianote", "qqfriend", "readerapp", "blogapp",
    "facebookapp", "masssendapp", "notifymessage", "experiencesession",
    "officialaccounts", "brandsessionholder", "filehelper", "newsapp",
})


def parse_rion_contact_rows(rows: list) -> list[dict]:
    """rion contacts/members 共用行结构 → 归一化联系人列表。

    正名取 remark（用户自己打的备注，最接近真实称呼）优先，否则昵称；
    wxid/微信号/另一名进别名。系统号与 gh_ 公众号滤除。
    """
    out: list[dict] = []
    for c in rows:
        username = (c.get("username") or "").strip()
        if not username or username in SYSTEM_ACCOUNTS or username.startswith("gh_"):
            continue
        nick = (c.get("nick_name") or "").strip()
        remark = (c.get("remark") or "").strip()
        name = remark or nick
        if not name:
            continue
        aliases = {nick, remark, (c.get("alias") or "").strip(), username}
        aliases.discard(name)
        aliases.discard("")
        out.append({"wxid": username, "name": name, "aliases": sorted(aliases)})
    return out


def parse_rion_contacts(json_text: str) -> list[dict]:
    """解析 rion-wechat-cli contacts 导出。"""
    try:
        rows = json.loads(json_text).get("data", {}).get("contacts", [])
    except ValueError:
        return []
    return parse_rion_contact_rows(rows)


def parse_rion_group_sessions(json_text: str) -> list[dict]:
    """sessions 导出 → 群聊列表 [{chatroom_id, name, last_ts}]。

    群列表不在 contacts 里（--groups-only 返回空），在会话表中
    （username 以 @chatroom 结尾，display_name 为群名）。
    """
    try:
        rows = json.loads(json_text).get("data", {}).get("sessions", [])
    except ValueError:
        return []
    out: list[dict] = []
    for s in rows:
        cid = (s.get("username") or "").strip()
        name = (s.get("display_name") or "").strip()
        if not cid.endswith("@chatroom") or not name:
            continue
        out.append({"chatroom_id": cid, "name": name, "last_ts": s.get("last_timestamp")})
    return out


def register_wechat_contacts(
    store,
    contacts: list[dict],
    owner_wxid: str | None = None,
    owner_name: str | None = None,
) -> dict:
    """批量登记 person 实体 + 好友→主人 friend_of 边。幂等可重跑。

    owner_name：主人正名覆盖（微信昵称常带"@状态"后缀导致与 git 同名实体
    分叉；指定后锚点直接落进既有实体，别名自然合并）。
    """
    created = 0
    eids: list[str] = []
    owner_eid: str | None = None
    for c in contacts:
        is_owner = bool(owner_wxid and c["wxid"] == owner_wxid)
        name = (owner_name or c["name"]) if is_owner else c["name"]
        eid, is_new = store.register("person", name, aliases=c["aliases"], source="wechat")
        created += int(is_new)
        eids.append(eid)
        if is_owner:
            owner_eid = eid
    links = 0
    if owner_eid:
        for eid, c in zip(eids, contacts):
            if c["wxid"] == owner_wxid:
                continue
            links += int(store.register_link(eid, owner_eid, "friend_of", "wechat"))
    return {"persons": len(contacts), "created": created, "links": links}


def register_wechat_groups(store, groups: list[dict]) -> tuple[dict[str, str], int]:
    """群聊 → org 实体。返回 ({chatroom_id: entity_id}, 新建数)。"""
    eids: dict[str, str] = {}
    created = 0
    for g in groups:
        eid, is_new = store.register(
            "org", g["name"], aliases=[g["chatroom_id"]], source="wechat_group"
        )
        eids[g["chatroom_id"]] = eid
        created += int(is_new)
    return eids, created


def register_group_members(store, group_eid: str, members: list[dict]) -> dict:
    """群成员 → person 实体 + member_of 边（含主人自身：他在哪些群=工作事实）。"""
    links = 0
    for m in members:
        eid, _ = store.register("person", m["name"], aliases=m["aliases"], source="wechat_group")
        links += int(store.register_link(eid, group_eid, "member_of", "wechat_group"))
    return {"members": len(members), "links": links}
