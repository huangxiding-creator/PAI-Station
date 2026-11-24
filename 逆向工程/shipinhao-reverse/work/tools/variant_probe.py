# -*- coding: utf-8 -*-
"""参数变体探测：对 4 个未打通端点试常见参数组合（只读）。"""
import json
import sys
import time
import pathlib

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from sph_probe import probe  # noqa: E402

NOW = str(int(time.time() * 1000))


def env(**kw):
    d = {"timestamp": NOW, "scene": 1, "reqScene": 1}
    d.update(kw)
    return d


VARIANTS = [
    ("post/post_list", env(count=10)),
    ("post/post_list", env(count=10, lastBuffer="")),
    ("post/post_list", env(count=10, lastBuffer="", continueFlag=1)),
    ("post/post_list", env(count=10, lastBuffer="", tabType=1)),
    ("post/post_list", env(count=10, lastBuffer="", feedType=1)),
    ("comment/comment_list", env(count=10, lastBuffer="", commentType=1)),
    ("comment/comment_list", env(count=10, lastBuffer="", type=0)),
    ("comment/feed_list", env(count=10, lastBuffer="", feedListType=1)),
    ("comment/feed_list", env(count=10, lastBuffer="", tabType=1)),
    ("menu/get_menu_info", env()),
    ("menu/get_menu_info", env(finderUsername="")),
]


def main():
    for path, body in VARIANTS:
        r = probe(path, body)
        ec, msg, keys = "", "", ""
        try:
            j = json.loads(r["body"])
            ec = j.get("errCode")
            msg = str(j.get("errMsg"))[:60]
            d = j.get("data")
            keys = ",".join(list(d.keys())[:8]) if isinstance(d, dict) else type(d).__name__
        except Exception:
            msg = str(r.get("body", ""))[:80]
        print(f"{path:25s} {json.dumps({k: v for k, v in body.items() if k not in ('timestamp','scene','reqScene')})[:70]:72s} -> errCode={ec} {msg} data[{keys}]")
        time.sleep(0.7)


if __name__ == "__main__":
    main()
