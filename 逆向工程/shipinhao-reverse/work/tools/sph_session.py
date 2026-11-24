# -*- coding: utf-8 -*-
"""会话引导链：auth_data → login_finder → 全信封(rawKeyBuff/_log_*)。
这是 CLI 的核心会话模块雏形。全部只读。
"""
import json
import sys
import time
import pathlib

sys.path.insert(0, str(pathlib.Path(__file__).resolve().parent))
from sph_probe import probe, load_cookies  # noqa: E402

NOW_MS = lambda: str(int(time.time() * 1000))  # noqa: E731


def bootstrap():
    """返回 (finder_username, owner_uin, raw_key_buff, session_info)。"""
    r = probe("auth/auth_data", {"timestamp": NOW_MS(), "scene": 1, "reqScene": 1})
    d = json.loads(r["body"])["data"]
    fu = d["finderUser"]["finderUsername"]
    uin = str(d.get("userAttr", {}).get("uin") or d["finderUser"].get("ownerWxUin") or "")
    print(f"[auth_data] finder={fu[:40]}... uin={uin or '?'}")
    r2 = probe("auth/login_finder", {
        "timestamp": NOW_MS(), "scene": 1, "reqScene": 1, "finderUsername": fu})
    kb = ""
    try:
        j2 = json.loads(r2["body"])
        kb = (j2.get("data") or {}).get("rawKeyBuff") or ""
        print(f"[login_finder] errCode={j2.get('errCode')} rawKeyBuff={'YES(%d)' % len(kb) if kb else 'NO'}")
    except Exception as e:
        print(f"[login_finder] parse fail: {e} {str(r2.get('body'))[:120]}")
    return fu, uin, kb, d


def full_env(fu, uin, kb):
    return {
        "timestamp": NOW_MS(),
        "_log_finder_uin": uin,
        "_log_finder_id": fu,
        "rawKeyBuff": kb,
        "pluginSessionId": "",
        "scene": 1,
        "reqScene": 1,
    }


def main():
    fu, uin, kb, d = bootstrap()
    env = full_env(fu, uin, kb)
    if not kb:
        print("!! no rawKeyBuff — stubborn endpoints likely still blocked, testing anyway")
    for path, extra in [
        ("post/post_list", {"count": 10, "lastBuffer": ""}),
        ("comment/comment_list", {"count": 10, "lastBuffer": ""}),
        ("comment/feed_list", {"count": 10, "lastBuffer": ""}),
        ("menu/get_menu_info", {}),
        ("auth/auth_plugin_session", {}),
    ]:
        body = {**env, **extra}
        r = probe(path, body)
        ec, msg, dk = "", "", ""
        try:
            j = json.loads(r["body"])
            ec = j.get("errCode")
            msg = str(j.get("errMsg"))[:50]
            dd = j.get("data")
            dk = ",".join(list(dd.keys())[:6]) if isinstance(dd, dict) else type(dd).__name__
        except Exception:
            msg = str(r.get("body", ""))[:100]
        print(f"-> {path:28s} errCode={ec} {msg} data[{dk}]")
        time.sleep(0.7)
    # save bootstrap evidence
    out = pathlib.Path(__file__).resolve().parents[1] / "api_probe" / "bootstrap_session.json"
    out.write_text(json.dumps({"finderUsername": fu, "uin": uin,
                               "rawKeyBuff_len": len(kb), "auth_data": d}, ensure_ascii=False)[:200000],
                   encoding="utf-8")


if __name__ == "__main__":
    main()
