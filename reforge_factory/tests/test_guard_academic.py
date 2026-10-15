# -*- coding: utf-8 -*-
"""学术三件套适配器合成守卫 (T-015 / REQ-029.AC1; 真请求守卫在
test_channels_academic.py, 本件全程 mock 不占真请求配额)。

覆盖:
  1. OpenAlex 解析: abstract_inverted_index 重建 + abstract_head 截 300
  2. S2 解析: venue→source, venue 缺席回退 "Semantic Scholar"
  3. arXiv Atom 解析: entry 题录/年份/摘要; 无题 entry 不成 Doc
  4. 礼貌限流: 同主机相邻请求 >=1s (失败请求也计数); 异主机不互卡
  5. Doc 契约: title 空剔除; abstract_head 恰截 300
"""
import io
import json
import sys
import time
import urllib.error
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from channels import academic  # noqa: E402


class _FakeResp:
    def __init__(self, body: bytes, status: int = 200):
        self._body = body
        self.status = status

    def read(self):
        return self._body

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


@pytest.fixture
def mock_urlopen(monkeypatch):
    """工厂: mock_urlopen(fn(url)->_FakeResp|raise) 并清礼貌时刻表。"""
    academic._last_request_at.clear()
    holder = {"calls": []}

    def _install(fn):
        def _fake(req, timeout=None):
            holder["calls"].append({"url": req.full_url, "timeout": timeout})
            out = fn(req.full_url)
            if isinstance(out, Exception):
                raise out
            return out

        monkeypatch.setattr(academic.urllib.request, "urlopen", _fake)
        return holder

    return _install


def _long_word(n):
    return "字" * n


# ---- 1. OpenAlex --------------------------------------------------------

def test_openalex_inverted_index_and_head_300(mock_urlopen):
    abstract = " ".join(_long_word(80) for _ in range(6))  # 480+ 字 > 300
    inv = {}
    for i, w in enumerate(abstract.split()):
        inv.setdefault(w, []).append(i)
    body = {
        "results": [{
            "display_name": "EPC contract risk allocation",
            "doi": "https://doi.org/10.1/x", "id": "https://openalex.org/W1",
            "publication_year": 2024, "abstract_inverted_index": inv,
            "primary_location": {"source": {"display_name": "JCEM"}},
        }]
    }
    mock_urlopen(lambda url: _FakeResp(json.dumps(body).encode("utf-8")))
    docs = academic.search_openalex("EPC contract", limit=1)
    assert len(docs) == 1
    d = docs[0]
    assert d["title"] == "EPC contract risk allocation"
    assert d["url"] == "https://doi.org/10.1/x"
    assert d["year"] == 2024
    assert d["source"] == "JCEM"
    assert len(d["abstract_head"]) == 300  # 恰截 300


def test_openalex_inverted_index_out_of_order(mock_urlopen):
    inv = {"contract": [1], "EPC": [0], "study": [3], "case": [2]}
    body = {"results": [{
        "display_name": "t", "doi": "https://doi.org/10.1/y",
        "publication_year": None, "abstract_inverted_index": inv,
        "primary_location": {},
    }]}
    mock_urlopen(lambda url: _FakeResp(json.dumps(body).encode("utf-8")))
    docs = academic.search_openalex("q", limit=1)
    assert docs[0]["abstract_head"] == "EPC contract case study"
    assert docs[0]["year"] is None
    assert docs[0]["source"] == "OpenAlex"  # 源缺联回退


# ---- 2. Semantic Scholar ------------------------------------------------

def test_s2_parse_and_source_fallback(mock_urlopen):
    body = {"data": [
        {"title": "Engineering procurement construction",
         "url": "https://semanticscholar.org/p/1", "year": 2023,
         "abstract": " abs ", "venue": "  IPME  "},
        {"title": "  ", "url": "u", "year": None, "abstract": None,
         "venue": None},  # 无题 → 剔除
    ]}
    mock_urlopen(lambda url: _FakeResp(json.dumps(body).encode("utf-8")))
    docs = academic.search_s2("EPC contract", limit=2)
    assert len(docs) == 1
    d = docs[0]
    assert d["source"] == "IPME"
    assert d["abstract_head"] == "abs"
    assert d["title"] == "Engineering procurement construction"


def test_s2_venue_missing_falls_back(mock_urlopen):
    body = {"data": [{"title": "t2", "url": "https://s2/p/2", "year": 2020,
                      "abstract": None, "venue": None}]}
    mock_urlopen(lambda url: _FakeResp(json.dumps(body).encode("utf-8")))
    docs = academic.search_s2("q", limit=1)
    assert docs[0]["source"] == "Semantic Scholar"


# ---- 3. arXiv -----------------------------------------------------------

_ARXIV_XML = """<?xml version='1.0' encoding='UTF-8'?>
<feed xmlns="http://www.w3.org/2005/Atom">
  <entry>
    <title>  EPC project\n  delivery  </title>
    <id>http://arxiv.org/abs/2401.00001v1</id>
    <published>2024-01-02T00:00:00Z</published>
    <summary> Linear scheduling for EPC. </summary>
  </entry>
  <entry>
    <title></title>
    <id>http://arxiv.org/abs/2401.00002v1</id>
    <published>2024-01-03T00:00:00Z</published>
    <summary>no title entry</summary>
  </entry>
</feed>"""


def test_arxiv_atom_parse(mock_urlopen):
    mock_urlopen(lambda url: _FakeResp(_ARXIV_XML.encode("utf-8")))
    docs = academic.search_arxiv("EPC contract", limit=2)
    assert len(docs) == 1  # 无题 entry 剔除
    d = docs[0]
    assert d["title"] == "EPC project delivery"
    assert d["url"] == "http://arxiv.org/abs/2401.00001v1"
    assert d["year"] == 2024
    assert d["abstract_head"] == "Linear scheduling for EPC."
    assert d["source"] == "arXiv"


def test_arxiv_published_not_int_year_none(mock_urlopen):
    xml = _ARXIV_XML.replace("2024-01-02", "xxxx-01-02")
    mock_urlopen(lambda url: _FakeResp(xml.encode("utf-8")))
    docs = academic.search_arxiv("q", limit=1)
    assert docs[0]["year"] is None


# ---- 4. 礼貌限流 --------------------------------------------------------

def test_polite_throttle_same_host_counts_failures(mock_urlopen, monkeypatch):
    sleeps = []
    monkeypatch.setattr(time, "sleep", lambda s: sleeps.append(round(s, 3)))
    academic._last_request_at.clear()

    calls = {"n": 0}

    def responder(url):
        calls["n"] += 1
        if calls["n"] == 1:
            return urllib.error.HTTPError(url, 429, "Too Many Requests",
                                          hdrs=None, fp=io.BytesIO(b"{}"))
        return _FakeResp(b"{}")

    mock_urlopen(responder)
    # 第 1 发: 表空不睡
    with pytest.raises(urllib.error.HTTPError):
        academic.http_get("https://api.semanticscholar.org/x")
    assert sleeps == []
    # 第 2 发 (同主机, 失败也计了礼貌时刻) → 睡满 ~1s
    academic.http_get("https://api.semanticscholar.org/y")
    assert len(sleeps) == 1 and 0.9 <= sleeps[0] <= 1.0


def test_polite_throttle_cross_host_not_blocked(mock_urlopen, monkeypatch):
    sleeps = []
    monkeypatch.setattr(time, "sleep", lambda s: sleeps.append(round(s, 3)))
    academic._last_request_at.clear()
    mock_urlopen(lambda url: _FakeResp(b"{}"))
    academic.http_get("https://api.openalex.org/works")   # 主机 A
    academic.http_get("http://export.arxiv.org/api/query")  # 主机 B 不互卡
    assert sleeps == []


def test_http_get_marks_host_after_success(mock_urlopen, monkeypatch):
    monkeypatch.setattr(time, "sleep", lambda s: None)
    academic._last_request_at.clear()
    mock_urlopen(lambda url: _FakeResp(b"ok"))
    academic.http_get("https://api.openalex.org/works")
    assert "api.openalex.org" in academic._last_request_at


# ---- 5. Doc 契约 --------------------------------------------------------

def test_make_doc_contract():
    d = academic.make_doc(title=" T ", url="u", year="2024", abstract="a" * 500,
                          source=" s ")
    assert d["title"] == "T"
    assert d["year"] is None  # 非整型年份不硬转
    assert len(d["abstract_head"]) == 300
    assert d["source"] == "s"
    assert academic.make_doc(title="  ", url="u", year=1, abstract="a",
                             source="s") is None
