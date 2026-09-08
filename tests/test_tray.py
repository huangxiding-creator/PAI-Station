"""M0.5 托盘：菜单模型与状态机（pystray 可选，逻辑无 GUI 可测）。"""
from paistation.ui.tray import MenuAction, TrayState, build_menu


def test_initial_state_not_paused():
    assert TrayState().paused is False


def test_toggle_pause_flips():
    s = TrayState()
    s.toggle_pause()
    assert s.paused is True
    s.toggle_pause()
    assert s.paused is False


def test_menu_has_three_entries_with_labels():
    menu = build_menu(TrayState())
    assert [m.label for m in menu] == ["暂停感知", "设置", "退出"]


def test_pause_label_reflects_state():
    s = TrayState()
    s.toggle_pause()
    assert build_menu(s)[0].label == "恢复感知"


def test_menu_actions_wired():
    menu = build_menu(TrayState())
    kinds = {m.action for m in menu}
    assert kinds == {MenuAction.TOGGLE_PAUSE, MenuAction.SETTINGS, MenuAction.QUIT}
    assert all(m.enabled for m in menu)


# ---- R9 GUI：图标生成 + --gui 入口 ----

def test_make_icon_image_geometry():
    """纯 Pillow 绘制托盘图标：RGBA 透明底 + 圆角方块（零素材文件）。"""
    from paistation.ui.tray import make_icon_image
    img = make_icon_image(64)
    assert img.size == (64, 64) and img.mode == "RGBA"
    corner = img.getpixel((0, 0))          # 圆角外 → 透明
    center = img.getpixel((32, 32))        # 中心圆点 → 青色不透明
    assert corner[3] == 0 and center[3] == 255


def test_gui_entry_rejects_bad_config(tmp_path, capsys):
    """配置非法 → 中文报错退出 1，不带病上托盘。"""
    from paistation.main import gui
    bad = tmp_path / "pai.ini"
    bad.write_text("[sense]\nwatch_dirs = Z:\\不存在\n", encoding="utf-8")
    assert gui(str(bad)) == 1
    assert "配置非法" in capsys.readouterr().out
