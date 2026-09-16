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

# 微信内置系统号（语音记事本/漂流瓶等伪联系人，非真人）
SYSTEM_ACCOUNTS = frozenset({
    "weixin", "weixinhelper", "weixinremind", "weixinreminder", "weibo",
    "qqmail", "fmessage", "tmessage", "qmessage", "qqsync", "floatbottle",
    "lbsapp", "shakeapp", "medianote", "qqfriend", "readerapp", "blogapp",
    "facebookapp", "masssendapp", "notifymessage", "experiencesession",
    "officialaccounts", "brandsessionholder", "filehelper", "newsapp",
})


def parse_rion_contacts(json_text: str) -> list[dict]:
    """解析 rion-wechat-cli contacts 导出 → 归一化联系人列表。

    正名取 remark（用户自己打的备注，最接近真实称呼）优先，否则昵称；
    wxid/微信号/另一名进别名。系统号与 gh_ 公众号滤除。
    """
    try:
        rows = json.loads(json_text).get("data", {}).get("contacts", [])
    except ValueError:
        return []
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
