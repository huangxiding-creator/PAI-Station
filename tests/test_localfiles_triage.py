"""L1 分诊：路径级危险区路由（真机实证固化）。"""
from paistation.sense.localfiles.triage import Triage


def test_wxwork_cloud_placeholder_routed_metadata_only():
    """WeDrive 占位 open() 挂起拉云——前缀命中必须走零解析路由。"""
    kind, parser = Triage().classify(
        r"C:\Users\91216\Documents\WXWork\1688850732629034\WeDrive\报告.docx")
    assert kind == "cloud-placeholder" and parser == "metadata-only"


def test_normal_docx_still_routes_python_docx():
    kind, parser = Triage().classify(r"C:\Users\91216\Desktop\报告.docx")
    assert kind == "word" and parser == "python-docx"


def test_prefix_match_case_and_separator_insensitive():
    kind, parser = Triage().classify(
        "c:/users/91216/documents/wxwork/other/任意.pdf")
    assert kind == "cloud-placeholder" and parser == "metadata-only"
