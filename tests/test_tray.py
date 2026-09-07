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
