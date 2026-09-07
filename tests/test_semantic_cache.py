"""M1 语义缓存（第 26 章兵器五）：Jaccard 近重复 + SimHash 指纹。"""
from paistation.llm.semantic_cache import SemanticCache, hamming, simhash


def test_simhash_identical_text_zero_distance():
    assert hamming(simhash("项目周报 第一版"), simhash("项目周报 第一版")) == 0


def test_simhash_small_edit_closer_than_unrelated():
    near1 = simhash("请把这份文件总结一下，重点突出风险")
    near2 = simhash("请把这份文档总结一下，重点突出风险")
    far1 = simhash("季度财务报表分析会议纪要")
    far2 = simhash("python unit test fixture mock")
    # 短文本 SimHash 绝对距离噪声大，但相对序保持：一词差 < 完全无关
    assert hamming(near1, near2) < hamming(far1, far2)


def test_simhash_unrelated_large_distance():
    a = simhash("季度财务报表分析会议纪要")
    b = simhash("python unit test fixture mock")
    assert hamming(a, b) > 20


def test_get_hit_for_identical_prompt():
    c = SemanticCache()
    c.put("总结这个文件", {"text": "摘要A"})
    assert c.get("总结这个文件") == {"text": "摘要A"}


def test_get_hit_for_near_prompt():
    c = SemanticCache()  # 默认 Jaccard 阈值 0.6
    c.put("帮我把这份文件总结一下", {"text": "摘要B"})
    assert c.get("帮我把这份文档总结一下") == {"text": "摘要B"}


def test_get_miss_for_unrelated():
    c = SemanticCache()
    c.put("总结这个文件", {"text": "摘要"})
    assert c.get("完全无关的另一个问题") is None


def test_capacity_evicts_lru():
    c = SemanticCache(capacity=2)
    c.put("一", {"text": "1"})
    c.put("二", {"text": "2"})
    c.get("一")  # 一变最新
    c.put("三", {"text": "3"})  # 挤掉 二
    assert c.get("一") == {"text": "1"}
    assert c.get("二") is None
    assert c.get("三") == {"text": "3"}


def test_hit_miss_stats():
    c = SemanticCache()
    c.put("p", {"text": "r"})
    c.get("p")
    c.get("别的")
    assert c.stats == {"hits": 1, "misses": 1, "entries": 1}


def test_returns_copy_not_internal():
    c = SemanticCache()
    c.put("p", {"text": "r"})
    got = c.get("p")
    got["text"] = "被改坏"
    assert c.get("p") == {"text": "r"}  # 深防：命中结果不可回写
