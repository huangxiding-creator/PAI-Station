import re, sys, html, io

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

def extract(path):
    raw = open(path, "rb").read()
    # detect charset
    m = re.search(rb'charset=["\']?([\w-]+)', raw[:2000], re.I)
    enc = m.group(1).decode() if m else "utf-8"
    try:
        text = raw.decode(enc, errors="replace")
    except LookupError:
        text = raw.decode("utf-8", errors="replace")
    # drop script/style
    text = re.sub(r"(?is)<(script|style)[^>]*>.*?</\1>", "", text)
    # block-level newlines
    text = re.sub(r"(?i)</?(p|div|br|tr|li|h[1-6]|table|section|article|td)[^>]*>", "\n", text)
    text = re.sub(r"<[^>]+>", "", text)
    text = html.unescape(text)
    # normalize whitespace
    lines = [re.sub(r"[ \t　\xa0]+", " ", ln).strip() for ln in text.splitlines()]
    lines = [ln for ln in lines if ln]
    return "\n".join(lines)

if __name__ == "__main__":
    out = extract(sys.argv[1])
    print(out)
