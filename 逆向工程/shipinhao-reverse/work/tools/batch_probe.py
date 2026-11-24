# -*- coding: utf-8 -*-
"""批量只读探针：验证各功能域 list/get 端点在纯 cookie 直连下的真实形状。
全部只读（list/get/query/trend），零写操作。产物: api_probe/batch_results.json
"""
import json
import sys
import time
import pathlib

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from sph_probe import probe  # noqa: E402

NOW = str(int(time.time() * 1000))
ENV = {"timestamp": NOW, "scene": 1, "reqScene": 1}

PROBES = [
    # --- 内容管理 ---
    ("post/post_list", {**ENV, "lastBuff": "", "page": 1, "count": 5}),
    ("post/get_draft_list", {**ENV, "count": 5}),
    ("post/get_albums", ENV),
    # --- 数据中心 ---
    ("statistic/post_total_data", ENV),
    ("statistic/fans_trend", ENV),
    ("statistic/fans_portrait", ENV),
    ("statistic/new_post_total_data", ENV),
    ("statistic/get-finder-total-statics", ENV),
    # --- 直播 ---
    ("live/get_live_history", {**ENV, "count": 5}),
    ("live/get_live_replay_list_v2", ENV),
    ("live/get_last_live_info_v1", ENV),
    # --- 互动 ---
    ("comment/comment_list", {**ENV, "count": 5}),
    ("comment/feed_list", {**ENV, "count": 5}),
    # --- 私信 ---
    ("private-msg/get-session-info", ENV),
    ("private-msg/get-new-msg", ENV),
    # --- 成员/运营者 ---
    ("member/member_list", ENV),
    # --- 橱窗/带货 ---
    ("shop/check_shop_window_status", ENV),
    ("shop/get_all_window_products", ENV),
    ("shop/get_commerce_order_list", {**ENV, "page": 1}),
    # --- 通知/其他 ---
    ("notification/notification_list", {**ENV, "count": 5}),
    ("collection/get_collection_list", {**ENV, "count": 5}),
    ("menu/get_menu_info", ENV),
    ("income/get-my-finder-income-detail", ENV),
    ("profile/get_user_page_section_list", ENV),
    ("post/get_object_short_link", ENV),
]


def main():
    out = []
    for path, body in PROBES:
        r = probe(path, body)
        tag = "OK" if r.get("status") == 200 else "HTTP" + str(r.get("status"))
        ec = ""
        try:
            j = json.loads(r["body"])
            ec = f"errCode={j.get('errCode')} errMsg={j.get('errMsg')}"
        except Exception:
            ec = r.get("body", "")[:80] if isinstance(r.get("body"), str) else str(r)
        print(f"[{tag}] {path:45s} {ec[:110]}")
        out.append({"path": path, "req": body, "res": r})
        time.sleep(0.8)
    dest = pathlib.Path(__file__).resolve().parents[1] / "api_probe" / "batch_results.json"
    dest.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\nSaved {len(out)} probes -> {dest}")


if __name__ == "__main__":
    main()
