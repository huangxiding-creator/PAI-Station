"""M2.5 铸造厂：微信读书签名算法黄金向量对拍（touchFish TS 原版移植验证）。"""
import json
import os

from paistation.forge.weread_sign import (
    USER_AGENT,
    calc_hash,
    get_app_id,
    sign,
)

_VECTORS = os.path.join(os.path.dirname(os.path.abspath(__file__)),
                        "weread_golden_vectors.json")


def _golden():
    with open(_VECTORS, encoding="utf-8") as fh:
        return json.load(fh)


def test_app_id_matches_ts():
    # 黄金向量由 TS 源码的 Chrome/116 UA 生成；默认 UA 已随扫码浏览器
    # 升到 Chrome/152，故此处显式用向量同源 UA 验证算法本身
    ts_ua = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
             "(KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36")
    assert get_app_id(ts_ua) == _golden()["appId"]
    assert "Chrome/152" in USER_AGENT


def test_calc_hash_vectors():
    for data, expect in _golden()["calcHash"].items():
        assert calc_hash(data) == expect, f"calcHash({data!r}) 不匹配"


def test_calc_hash_accepts_int():
    # chapterUid 传 int：TS 侧 typeof number 先 toString
    assert calc_hash(1) == calc_hash("1")


def test_sign_e0_vector():
    vec = _golden()["sign"]["e0"]
    assert sign(vec["payload"]) == vec["s"]


def test_sign_t0_vector():
    vec = _golden()["sign"]["t0"]
    assert sign(vec["payload"]) == vec["s"]


def test_sign_order_independent():
    # _stringify 键排序：插入序不影响签名
    a = {"b": "x1", "c": "y2", "st": 0}
    b = {"st": 0, "c": "y2", "b": "x1"}
    assert sign(a) == sign(b)
