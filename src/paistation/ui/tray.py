"""系统托盘（pystray 可选依赖）：暂停感知 / 设置 / 退出（提案 4.2 ui）。

菜单模型（TrayState + build_menu）与 GUI 解耦，无 pystray 也可单测；
TrayApp 懒加载 pystray，缺依赖时给出安装指引而非崩溃。
"""
import enum
import logging
import os
from dataclasses import dataclass, field

_log = logging.getLogger("paistation.ui.tray")


class MenuAction(enum.Enum):
    TOGGLE_PAUSE = "toggle_pause"
    SETTINGS = "settings"
    QUIT = "quit"


@dataclass
class MenuItemSpec:
    label: str
    action: MenuAction
    enabled: bool = True


@dataclass
class TrayState:
    """托盘可观测状态（暂停感知一键闭眼，提案 17.4）。"""
    paused: bool = False

    def toggle_pause(self) -> None:
        self.paused = not self.paused


def build_menu(state: TrayState) -> list[MenuItemSpec]:
    """三菜单：暂停感知（随状态变标签）/设置/退出。"""
    return [
        MenuItemSpec("恢复感知" if state.paused else "暂停感知",
                     MenuAction.TOGGLE_PAUSE),
        MenuItemSpec("设置", MenuAction.SETTINGS),
        MenuItemSpec("退出", MenuAction.QUIT),
    ]


@dataclass
class TrayApp:
    """pystray 承载器：icon 懒加载，动作回调可注入（默认只记日志）。"""
    state: TrayState = field(default_factory=TrayState)
    config_dir: str = ""
    on_quit: object = None

    def _dispatch(self, action: MenuAction):
        if action is MenuAction.TOGGLE_PAUSE:
            self.state.toggle_pause()
            _log.info("感知%s", "已恢复" if not self.state.paused else "已暂停")
        elif action is MenuAction.SETTINGS:
            self.open_settings()
        elif action is MenuAction.QUIT:
            _log.info("托盘退出")
            if callable(self.on_quit):
                self.on_quit()

    def open_settings(self):
        """打开配置目录（explorer 只读浏览，不改动任何文件）。"""
        target = self.config_dir or os.getcwd()
        _log.info("打开设置目录：%s", target)

    def run(self):
        """启动托盘循环（阻塞）。pystray 缺失时抛出可行动的指引。"""
        try:
            import pystray  # noqa: F401 懒加载
        except ImportError as exc:
            raise RuntimeError(
                "托盘需要 pystray：pip install 'paistation[tray]'") from exc
        import pystray  # 上面仅探测

        def _pystray_menu():
            return pystray.Menu(*(
                pystray.MenuItem(m.label,
                                 lambda _s, _a, act=m.action: self._dispatch(act),
                                 enabled=m.enabled)
                for m in build_menu(self.state)))

        icon = pystray.Icon("PAI-Station", title="PAI-Station",
                            menu=_pystray_menu())
        icon.run()
