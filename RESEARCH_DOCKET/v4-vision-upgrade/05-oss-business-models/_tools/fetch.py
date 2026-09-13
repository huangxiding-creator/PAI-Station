"""Fetch a URL through the local proxy and print readable text. Track 05 research helper.

Usage:
  python fetch.py <url> [--chars N] [--grep WORD] [--raw]

Prints "STATUS <code>" first, then text extracted from HTML (tags/scripts/styles removed).
"""
import argparse
import html
import re
import sys
import urllib.request

PROXY = "http://127.0.0.1:7890"
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/126.0.0.0 Safari/537.36")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("url")
    parser.add_argument("--chars", type=int, default=6000)
    parser.add_argument("--grep", default=None)
    parser.add_argument("--raw", action="store_true")
    args = parser.parse_args()

    handler = urllib.request.ProxyHandler({"http": PROXY, "https": PROXY})
    opener = urllib.request.build_opener(handler)
    req = urllib.request.Request(args.url, headers={"User-Agent": UA, "Accept-Language": "en-US,en;q=0.9"})
    try:
        with opener.open(req, timeout=35) as resp:
            status = resp.status
            body = resp.read(3_000_000).decode("utf-8", "replace")
    except Exception as exc:  # noqa: BLE001 - report any failure verbatim
        print(f"ERROR {type(exc).__name__}: {exc}")
        return 1

    print(f"STATUS {status}")
    if args.raw:
        print(body[: args.chars])
        return 0

    body = re.sub(r"<(script|style|noscript)[^>]*>.*?</\1>", " ", body, flags=re.S | re.I)
    body = re.sub(r"<br[^>]*>|</p>|</div>|</li>|</h[1-6]>", "\n", body, flags=re.I)
    text = re.sub(r"<[^>]+>", " ", body)
    text = html.unescape(text)
    text = re.sub(r"[ \t\r\f\v]+", " ", text)
    text = re.sub(r"\n\s*\n+", "\n", text).strip()

    if args.grep:
        lines = [ln.strip() for ln in text.split("\n") if args.grep.lower() in ln.lower()]
        print("\n".join(lines[:40]) if lines else "(no matching lines)")
    else:
        print(text[: args.chars])
    return 0


if __name__ == "__main__":
    sys.exit(main())
