# -*- coding: utf-8 -*-
"""1009 用户令：总包智库飞书知识库一级目录结构有更新——拉 wiki 两层树对照小程序智库页硬编码。
做法=借鉴 We-AIPO（用户令）：lark-cli 用户态凭据（本机已登录、实弹验证过本 SPACE 1003）+ 1.2s 节流 + 串行（铁律≤3线程）。
兜底=app 凭证直连 open API（data/secrets/feishu_zhiku_kb.secret）。
"""
import io
import json
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\CPOPC\We-AIPO\scripts\feishu")
from lark_client import Lark, SPACE  # noqa: E402

lk = Lark()


def nodes(parent=None):
    return lk.wiki_node_list(SPACE, parent_token=parent, page_size=50)


top = nodes()
if not top or (isinstance(top, dict) and top.get("__error__")):
    raise SystemExit("L1_FAIL " + json.dumps(top, ensure_ascii=False)[:300])
print("TOP_LEVEL=%d" % len(top))
tree = []
for n in top:
    kids = nodes(n.get("node_token"))
    tree.append({"title": n.get("title"), "obj_type": n.get("obj_type"),
                 "node": n.get("node_token"),
                 "children": [{"title": k.get("title"), "obj_type": k.get("obj_type")} for k in kids]})
    print("L1 [%s] %s  (L2=%d)" % (n.get("obj_type"), n.get("title"), len(kids)))
    for k in kids:
        print("    - %s [%s]" % (k.get("title"), k.get("obj_type")))

io.open("E:/AI-Station/WeAppForge/work/feishu_zhiku_tree_1009.json", "w", encoding="utf-8").write(
    json.dumps(tree, ensure_ascii=False, indent=1))
print("SAVED feishu_zhiku_tree_1009.json")
