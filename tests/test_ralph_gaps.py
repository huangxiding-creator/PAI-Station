"""Phase 10 Ralph It5：覆盖弱项补测（feishu 登录流降级/编码回退）。"""
from paistation.memory.layers import LayeredLoader
from paistation.sense.cloud.feishu import FeishuDocsConnector
from paistation.sense.cloud.vault import SessionVault


def test_feishu_login_flow_without_app_config(tmp_path):
    """无 app 配置=未登录，login_flow 明确回 False 不装死。"""
    conn = FeishuDocsConnector(vault=SessionVault(tmp_path / "v"))
    assert conn.login_flow() is False


def test_layered_loader_gbk_fallback(tmp_path):
    """UTF-8 解码超脏（>5% �）自动降 GBK 读——老 Windows 文件保真。"""
    good = "合同编号二〇二六号：温控措施说明".encode("gbk")
    (tmp_path / "老档案.md").write_bytes(good)
    loader = LayeredLoader(data_dir=tmp_path)
    text = loader.l2(tmp_path / "老档案.md")
    assert "温控措施" in text
