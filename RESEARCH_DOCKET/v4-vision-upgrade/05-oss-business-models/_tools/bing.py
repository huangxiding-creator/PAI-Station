"""Bing organic search via the local proxy. Prints top result URLs+titles. Track 05 helper.

Usage: python bing.py "query terms"
"""
import html
import re
import sys
import urllib.parse
import urllib.request

PROXY = "http://127.0.0.1:7890"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")


def main() -> int:
    query = " ".join(sys.argv[1:])
    url = "https://www.bing.com/search?q=" + urllib.parse.quote(query)
    handler = urllib.request.ProxyHandler({"http": PROXY, "https": PROXY})
    opener = urllib.request.build_opener(handler)
    req = urllib.request.Request(url, headers={"User-Agent": UA, "Accept-Language": "en-US,en;q=0.9"})
    try:
        with opener.open(req, timeout=35) as resp:
            body = resp.read(2_000_000).decode("utf-8", "replace")
    except Exception as exc:  # noqa: BLE001
        print(f"ERROR {type(exc).__name__}: {exc}")
        return 1

    seen = set()
    for m in re.finditer(r'<h2[^>]*><a[^>]+href="(https?://[^"]+)"[^>]*>(.*?)</a>', body):
        link = m.group(1)
        if "bing.com" in link or "microsoft.com/en-us/bing" in link:
            continue
        title = html.unescape(re.sub(r"<[^>]+>", "", m.group(2))).strip()
        if link in seen:
            continue
        seen.add(link)
        print(f"{title}\n  {link}")
        if len(seen) >= 9:
            break
    if not seen:
        print("(no organic results parsed)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
