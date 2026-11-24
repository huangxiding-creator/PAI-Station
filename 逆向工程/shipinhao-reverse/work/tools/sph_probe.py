# -*- coding: utf-8 -*-
"""视频号后台 HTTP 探针：用保险库 cookie 直连 /cgi-bin/mmfinderassistant-bin/*。
只读探测（auth_data/post_list/statistic），不做任何写操作。产物落 api_probe/。
用法: sph_probe.py <endpoint_path> [json_body]
"""
import json
import sys
import time
import pathlib
import urllib.request

VAULT = pathlib.Path("F:/We-AIPO/data/state/channels_cookies_vault.json")
OUT = pathlib.Path(__file__).resolve().parents[1] / "api_probe"
BASE = "https://channels.weixin.qq.com/cgi-bin/mmfinderassistant-bin"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/156.0.0.0 Safari/537.36")


def load_cookies():
    d = json.loads(VAULT.read_text(encoding="utf-8"))
    return {c["name"]: c["value"] for c in d["cookies"]}


def probe(path, body=None, method="POST", extra_headers=None):
    cks = load_cookies()
    cookie = "; ".join(f"{k}={v}" for k, v in cks.items())
    data = None
    if body is not None:
        data = json.dumps(body, ensure_ascii=False).encode("utf-8")
    req = urllib.request.Request(BASE.rstrip("/") + "/" + path.lstrip("/"), data=data, method=method)
    req.add_header("User-Agent", UA)
    req.add_header("Cookie", cookie)
    req.add_header("Referer", "https://channels.weixin.qq.com/platform/post/list")
    req.add_header("X-Requested-With", "XMLHttpRequest")
    req.add_header("Accept", "application/json, text/plain, */*")
    if data is not None:
        req.add_header("Content-Type", "application/json")
    for k, v in (extra_headers or {}).items():
        req.add_header(k, v)
    t0 = time.time()
    try:
        with urllib.request.urlopen(req, timeout=30) as r:
            raw = r.read().decode("utf-8", errors="replace")
            return {
                "status": r.status,
                "set_cookie": r.headers.get_all("Set-Cookie") or [],
                "ms": round((time.time() - t0) * 1000),
                "body": raw[:300000],
            }
    except urllib.error.HTTPError as e:
        return {"status": e.code, "body": e.read().decode("utf-8", errors="replace")[:2000]}
    except Exception as e:
        return {"error": repr(e)}


def main():
    OUT.mkdir(exist_ok=True)
    path = (sys.argv[1] if len(sys.argv) > 1 else "auth/auth_data").strip("/")
    if "\\" in path or ":" in path:  # MSYS path-mangling guard
        raise SystemExit(f"BAD_ARG: {path}")
    body = json.loads(sys.argv[2]) if len(sys.argv) > 2 else {
        "timestamp": str(int(time.time() * 1000)), "scene": 1, "reqScene": 1}
    res = probe(path, body)
    slug = path.strip("/").replace("/", "_")
    (OUT / f"{slug}.json").write_text(
        json.dumps({"path": path, "req": body, "res": res}, ensure_ascii=False, indent=1),
        encoding="utf-8")
    print(json.dumps(res, ensure_ascii=False)[:1500])


if __name__ == "__main__":
    main()
