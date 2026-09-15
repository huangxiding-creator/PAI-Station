"""M7a 剪贴板流：密码形状红线 + 签名去重 + 元数据-only 事件。"""
from datetime import datetime

from paistation.sense.clipboard import ClipboardTracker, password_shape
from paistation.sense.voice_events import validate_event

_NOW = datetime(2026, 9, 15, 11, 0, 0)


def _tracker():
    return ClipboardTracker(now_fn=lambda: _NOW)


# ---- 密码形状判定（宁误杀勿泄漏）----

def test_password_shape_keys():
    assert password_shape("sk-abc123def456ghi789jkl")
    assert password_shape("ghp_16characterstoken")
    assert password_shape("AKIAIOSFODNN7EXAMPLE")
    assert password_shape("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.payload.sig")
    assert password_shape("MyP@ssw0rd1234567890ab")  # 高熵混合


def test_normal_text_not_password():
    assert not password_shape("这是一段普通的中文笔记，内容很长很长")
    assert not password_shape("The quick brown fox jumps over the lazy dog")
    assert not password_shape("https://github.com/some/repo/issues")
    assert not password_shape("12345678901234567890123")  # 纯数字=弱形状
    assert not password_shape("")


# ---- 事件产出 ----

def test_text_event_metadata_only():
    ev = _tracker().feed({"kind": "text", "text": "会议纪要正文"})
    assert ev["type"] == "clipboard.change"
    assert ev["text"] == ""                       # 正文永不入流
    assert ev["meta"]["kind"] == "text"
    assert ev["meta"]["length"] == 6
    assert validate_event(ev)


def test_duplicate_signature_suppressed():
    t = _tracker()
    t.feed({"kind": "text", "text": "相同内容"})
    assert t.feed({"kind": "text", "text": "相同内容"}) is None


def test_password_zero_trace():
    """密码形状：连长度/签名都不留。"""
    assert _tracker().feed({"kind": "text",
                            "text": "sk-proj-1234567890abcdef"}) is None


def test_image_and_file_kinds():
    ev = _tracker().feed({"kind": "image", "text": ""})
    assert ev["meta"]["kind"] == "image"
    assert _tracker().feed({"kind": "file", "text": ""}) is not None
    assert _tracker().feed({"kind": "empty", "text": ""}) is None
    assert _tracker().feed({"kind": "unknown", "text": ""}) is None
