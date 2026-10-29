# -*- coding: utf-8 -*-
"""
重建来源: CPython 3.13 字节码反汇编 (dis 输出)
  - gui/download_mixin.pyc            -> dump/gui_download_mixin.dis.txt
  - gui/incremental_download_dialog.pyc -> dump/gui_incremental_download_dialog.dis.txt
重建方式: 逐函数从字节码恢复控制流/常量/属性链, 函数名/参数名/类名/docstring 均来自 co_names/co_varnames/co_consts。
置信度: 高 (~95%)。两个模块的字节码已 100% 逐条读取, 逻辑/常量/信号连接均与反汇编一一对应;
        不确定项仅剩: ①源码换行位置(语句拆行是美观近似, 语句顺序与语义精确) ②DownloadMixin 的基类
        (字节码中无显式基类, 为纯 Mixin) ③IncrementalUpdateDialog 类体中 line 33-36 的 4 条 NOP 为
        3.13 编译器对 __init__ 多行 docstring 的行号占位伪指令, 非真实语句。

重要说明(任务第3点「整库下载编排」语义归属):
  本文件两个模块只是【下载入口 UI 层】。真正的整库扫描(get_all_files_recursive)/文件分类分发/
  note 与 report 导出格式(md/html)/跳过已下载/增量 cutoff 时间过滤/目录结构落盘, 全部位于
  gui/workers/workers.py 的 StreamDownloadWorker 与 services/ima_service.py 中, 不在本反汇编范围内。
  本文件对其可见的接口为:
    - StreamDownloadWorker(selected_payloads) + 信号 progress/file_discovered/scan_progress/
      quota_error/quota_updated/finished + 方法 pause()/resume()/stop()
    - services.ima_service.close_session()
  增量更新对话框只负责采集 cutoff 起始时间(默认当前时间-7天, 提示「仅下载此时间之后更新的文件」)
  与循环间隔(1~24小时), cutoff 过滤动作本身在其他模块执行。
"""

# ===== 原模块 gui/download_mixin.py 的导入 (原文顺序) =====
# from PySide6.QtWidgets import QMessageBox
# from PySide6.QtCore import Qt
# from gui.workers.workers import StreamDownloadWorker

# ===== 原模块 gui/incremental_download_dialog.py 的导入 (原文顺序) =====
# from PySide6.QtWidgets import (QDialog, QVBoxLayout, QHBoxLayout, QLabel, QDateTimeEdit,
#     QPushButton, QSpinBox, QRadioButton, QScrollArea, QWidget, QCheckBox, QButtonGroup,
#     QFrame, QTableWidget, QTableWidgetItem, QHeaderView, QAbstractItemView, QMessageBox)
# from PySide6.QtCore import Qt, QDateTime, Signal
# from PySide6.QtGui import QColor
# from datetime import datetime
# from utils import set_window_icon

from PySide6.QtWidgets import (
    QMessageBox,
    QDialog,
    QVBoxLayout,
    QHBoxLayout,
    QLabel,
    QDateTimeEdit,
    QPushButton,
    QSpinBox,
    QRadioButton,
    QScrollArea,
    QWidget,
    QCheckBox,
    QButtonGroup,
    QFrame,
    QTableWidget,
    QTableWidgetItem,
    QHeaderView,
    QAbstractItemView,
)
from PySide6.QtCore import Qt, QDateTime, Signal
from PySide6.QtGui import QColor
from datetime import datetime

from utils import set_window_icon

from gui.workers.workers import StreamDownloadWorker


# =====================================================================
# 原模块 1: gui/download_mixin.py  (模块 docstring: "下载功能 Mixin")
# =====================================================================

class DownloadMixin:
    """下载功能，供 MainWindow 继承"""

    # __static_attributes__ = ('download_worker', 'is_paused', 'is_stopped')

    def download_selected(self):
        # 原始行号: def@10
        items = self.tree.selectedItems()
        if not items:
            QMessageBox.warning(self, '提示', '请选择要下载的项目')
            return

        # 权限校验: kb/folder 看 visible_export_status, file 看 access_status; 1 = 不可导出
        for item in items:
            data = item.data(1, Qt.UserRole)
            item_type = data.get('type')

            if item_type == 'kb':
                visible_export_status = data.get('visible_export_status', 3)
                if visible_export_status == 1:
                    QMessageBox.warning(self, '权限不足', '该知识库不可导出')
                    return
            elif item_type == 'folder':
                visible_export_status = data.get('visible_export_status', 3)
                if visible_export_status == 1:
                    QMessageBox.warning(self, '权限不足', '该文件夹不可导出')
                    return
            elif item_type == 'file':
                access_status = data.get('access_status', 3)
                if access_status == 1:
                    QMessageBox.warning(self, '权限不足', '该文件不可导出')
                    return

        self.add_log('正在扫描文件列表，请稍候...', 'info')

        # 展示进度面板并复位
        self.progress_panel.setVisible(True)
        self.progress.setVisible(True)
        self.progress_detail.setVisible(True)
        self.progress_detail.setText('正在扫描，已发现 0 个文件')
        self.pause_btn.setVisible(True)
        self.stop_btn.setVisible(True)
        self.progress.setMaximum(100)
        self.progress.setValue(0)
        self.is_paused = False
        self.is_stopped = False

        # 打包选中项 payload(拷贝为独立 dict), 交给 StreamDownloadWorker(其余模块)执行整库下载
        selected_payloads = [dict(item.data(1, Qt.UserRole) or {}) for item in items]
        self.download_worker = StreamDownloadWorker(selected_payloads)
        self.download_worker.progress.connect(self.on_download_progress)
        self.download_worker.file_discovered.connect(self.on_file_discovered)
        self.download_worker.scan_progress.connect(self.on_scan_progress)
        self.download_worker.quota_error.connect(self.on_error)
        self.download_worker.quota_updated.connect(self.update_license_info)
        self.download_worker.finished.connect(self.on_download_finished)
        self.download_worker.start()

    def pause_download(self):
        """暂停/继续下载"""
        # 原始行号: def@59
        if self.download_worker:
            if self.is_paused:
                self.download_worker.resume()
                self.pause_btn.setText('暂停')
                self.is_paused = False
                self.add_log('继续下载', 'info')
            else:
                self.download_worker.pause()
                self.pause_btn.setText('继续')
                self.is_paused = True
                self.add_log('已暂停', 'warning')

    def stop_download(self):
        """停止下载"""
        # 原始行号: def@73
        if self.download_worker:
            self.download_worker.stop()
            self.is_stopped = True
            self.add_log('已停止下载', 'error')

    def on_download_progress(self, current, total, msg):
        # 原始行号: def@80
        total = max(total, 1)
        current = min(current, total)
        percent = int(current * 100 / total)
        self.progress.setMaximum(total)
        self.progress.setValue(current)
        self.progress_detail.setVisible(True)
        self.progress_detail.setText(f'{current}/{total} · {percent}%')
        if msg.startswith('✓'):
            self.add_log(msg, 'success')
        elif msg.startswith('⊘'):
            self.add_log(msg, 'warning')
        elif msg.startswith('✗'):
            self.add_log(msg, 'error')
        else:
            self.add_log(msg, 'download')

    def on_file_discovered(self, total_count):
        """当发现新文件时更新进度条最大值"""
        # 原始行号: def@97
        total_count = max(total_count, 1)
        self.progress.setMaximum(total_count)
        self.progress_detail.setVisible(True)
        self.progress_detail.setText(f'正在扫描，已发现 {total_count} 个文件')

    def on_scan_progress(self, msg):
        """显示扫描进度"""
        # 原始行号: def@104
        self.progress_detail.setVisible(True)
        if msg.startswith('正在扫描'):
            self.progress_detail.setText(msg)
        self.add_log(msg, 'info')

    def on_download_finished(self):
        # 原始行号: def@111
        self.progress_panel.setVisible(False)
        self.progress.setVisible(False)
        self.progress_detail.setVisible(False)
        self.progress_detail.clear()
        self.pause_btn.setVisible(False)
        self.stop_btn.setVisible(False)
        self.update_license_info()
        self.add_log('所有文件下载完成', 'success')

        from services.ima_service import close_session
        close_session()
        if self.download_worker:
            self.download_worker.deleteLater()
            self.download_worker = None

    def on_error(self, msg):
        # 原始行号: def@127
        self.load_btn.setEnabled(True)
        self.add_log(f'错误: {msg}', 'error')
        QMessageBox.critical(self, '错误', msg)


# =====================================================================
# 原模块 2: gui/incremental_download_dialog.py
#   (模块 docstring: "增量更新任务提交/编辑对话框 + 任务管理窗口")
# =====================================================================

class IncrementalUpdateDialog(QDialog):
    # 原始行号: class@28, __init__@29 (类体 33-36 行的 4 条 NOP 为编译器行号占位伪指令)

    def __init__(self, kb_id, kb_name, parent=None, folder_id='', folder_name='', edit_task=None):
        """
Args:
    kb_id: 知识库ID
    kb_name: 知识库名称
    parent: 父窗口
    folder_id: 文件夹ID，空表示整个知识库
    folder_name: 文件夹名称，空表示整个知识库
    edit_task: 编辑模式时传入任务 dict，None 表示新增模式
"""
        super().__init__(parent)
        self.kb_id = kb_id
        self.kb_name = kb_name
        self.folder_id = folder_id
        self.folder_name = folder_name
        self.edit_task = edit_task
        self.setWindowTitle('编辑更新任务' if edit_task else '提交增量更新任务')
        self.setModal(True)
        self.setMinimumWidth(500)

        set_window_icon(self)

        layout = QVBoxLayout(self)

        kb_layout = QHBoxLayout()
        kb_layout.addWidget(QLabel('知识库：'))
        kb_label = QLabel(kb_name)
        kb_label.setStyleSheet('font-weight: bold;')
        kb_layout.addWidget(kb_label)
        kb_layout.addStretch()
        layout.addLayout(kb_layout)

        dir_layout = QHBoxLayout()
        dir_layout.addWidget(QLabel('目　录：'))
        dir_label = QLabel(folder_name if folder_name else '整个知识库')
        dir_label.setStyleSheet('font-weight: bold;')
        dir_layout.addWidget(dir_label)
        dir_layout.addStretch()
        layout.addLayout(dir_layout)

        layout.addWidget(self._make_separator())

        time_layout = QHBoxLayout()
        time_layout.addWidget(QLabel('起始时间：'))
        self.datetime_edit = QDateTimeEdit()
        self.datetime_edit.setCalendarPopup(True)
        self.datetime_edit.setDisplayFormat('yyyy-MM-dd HH:mm')
        # 增量更新 cutoff: 默认当前时间往前推 7 天
        self.datetime_edit.setDateTime(QDateTime.currentDateTime().addDays(-7))
        time_layout.addWidget(self.datetime_edit)
        time_layout.addStretch()
        layout.addLayout(time_layout)

        hint = QLabel('仅下载此时间之后更新的文件')
        hint.setStyleSheet('color: #888; font-size: 12px;')
        layout.addWidget(hint)

        layout.addWidget(self._make_separator())

        mode_layout = QHBoxLayout()
        mode_layout.addWidget(QLabel('执行方式：'))
        self.radio_once = QRadioButton('仅执行一次')
        self.radio_loop = QRadioButton('定时循环')
        self.radio_once.setChecked(True)
        mode_group = QButtonGroup(self)
        mode_group.addButton(self.radio_once)
        mode_group.addButton(self.radio_loop)
        mode_layout.addWidget(self.radio_once)
        mode_layout.addWidget(self.radio_loop)
        mode_layout.addStretch()
        layout.addLayout(mode_layout)

        self.loop_container = QWidget()
        loop_layout = QVBoxLayout(self.loop_container)
        loop_layout.setContentsMargins(0, 0, 0, 0)

        interval_layout = QHBoxLayout()
        interval_layout.addWidget(QLabel('更新间隔：'))
        self.interval_spinbox = QSpinBox()
        self.interval_spinbox.setRange(1, 24)
        self.interval_spinbox.setValue(1)
        self.interval_spinbox.setSuffix(' 小时')
        interval_layout.addWidget(self.interval_spinbox)
        interval_layout.addStretch()
        loop_layout.addLayout(interval_layout)

        self.loop_container.setVisible(False)
        layout.addWidget(self.loop_container)

        self.radio_loop.toggled.connect(self._on_mode_changed)

        btn_layout = QHBoxLayout()
        btn_layout.addStretch()
        ok_btn = QPushButton('保存修改' if edit_task else '提交任务')
        ok_btn.clicked.connect(self.accept)
        cancel_btn = QPushButton('取消')
        cancel_btn.clicked.connect(self.reject)
        btn_layout.addWidget(ok_btn)
        btn_layout.addWidget(cancel_btn)
        layout.addLayout(btn_layout)

        if edit_task:
            self._fill_edit_mode(edit_task)

    def _make_separator(self):
        # 原始行号: def@140
        line = QFrame()
        line.setFrameShape(QFrame.HLine)
        line.setFrameShadow(QFrame.Sunken)
        line.setStyleSheet('color: #ddd;')
        return line

    def _on_mode_changed(self, checked):
        # 原始行号: def@147
        self.loop_container.setVisible(self.radio_loop.isChecked())
        self.adjustSize()

    def _fill_edit_mode(self, task):
        """编辑模式：回填已有配置"""
        # 原始行号: def@151
        if task.get('start_time', 0) > 0:
            from datetime import datetime
            dt = datetime.fromtimestamp(task['start_time'])
            from PySide6.QtCore import QDateTime as QDT

            self.datetime_edit.setDateTime(
                QDT.fromSecsSinceEpoch(int(dt.timestamp()))
            )
        interval = task.get('interval_hours', 0)
        if interval > 0:
            self.radio_loop.setChecked(True)
            self.interval_spinbox.setValue(interval)
        else:
            self.radio_once.setChecked(True)

    def get_selected_datetime(self):
        # 原始行号: def@170
        return self.datetime_edit.dateTime().toPython()

    def get_kb_id(self):
        # 原始行号: def@173
        return self.kb_id

    def get_kb_name(self):
        # 原始行号: def@176
        return self.kb_name

    def get_folder_id(self):
        # 原始行号: def@179
        return self.folder_id

    def get_folder_name(self):
        # 原始行号: def@182
        return self.folder_name

    def get_is_loop(self):
        # 原始行号: def@185
        return self.radio_loop.isChecked()

    def get_interval_hours(self):
        # 原始行号: def@188
        return self.interval_spinbox.value()


class TaskManagerDialog(QDialog):
    """更新任务管理窗口，非 modal，可常驻打开"""

    tasks_changed = Signal()   # 原始行号@195, 无参信号

    def __init__(self, kb_list, parent=None):
        # 原始行号: def@197
        super().__init__(parent)
        self.kb_list = kb_list
        self.setWindowTitle('更新任务管理')
        self.setMinimumSize(800, 400)
        self.setModal(False)

        set_window_icon(self)

        layout = QVBoxLayout(self)

        top_layout = QHBoxLayout()
        top_layout.addWidget(QLabel('增量更新任务列表'))
        top_layout.addStretch()
        layout.addLayout(top_layout)

        self.table = QTableWidget()
        self.table.setColumnCount(7)
        self.table.setHorizontalHeaderLabels([
            *('知识库', '目录', '起始时间', '间隔', '上次运行', '状态', '操作')
        ])
        self.table.setSelectionBehavior(QAbstractItemView.SelectRows)
        self.table.setEditTriggers(QAbstractItemView.NoEditTriggers)
        self.table.verticalHeader().setVisible(False)

        header = self.table.horizontalHeader()
        header.setSectionResizeMode(0, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(1, QHeaderView.Stretch)
        header.setSectionResizeMode(2, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(3, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(4, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(5, QHeaderView.ResizeToContents)
        header.setSectionResizeMode(6, QHeaderView.Fixed)
        header.resizeSection(6, 120)

        layout.addWidget(self.table)
        self._refresh_pending = False
        self.refresh_table()

    def showEvent(self, event):
        # 原始行号: def@236
        super().showEvent(event)
        if not self._refresh_pending:
            self._refresh_pending = True
            from PySide6.QtCore import QTimer

            QTimer.singleShot(0, self._do_deferred_refresh)

    def _do_deferred_refresh(self):
        # 原始行号: def@244
        self._refresh_pending = False
        self.refresh_table()

    def refresh_table(self):
        # 原始行号: def@248
        from data.database import get_all_tasks

        tasks = get_all_tasks()
        self.table.setRowCount(len(tasks))
        for row, task in enumerate(tasks):
            task_id = task['id']
            is_loop = task['interval_hours'] > 0
            is_enabled = task['enabled'] == 1

            self.table.setItem(
                row, 0, QTableWidgetItem(task.get('kb_name', ''))
            )

            folder_name = task.get('folder_name', '')
            self.table.setItem(
                row, 1, QTableWidgetItem(folder_name if folder_name else '整个知识库')
            )

            self.table.setItem(
                row, 2,
                QTableWidgetItem(self._format_time(task.get('start_time', 0)))
            )

            self.table.setItem(
                row, 3,
                QTableWidgetItem(f"{task['interval_hours']}小时" if is_loop else '单次')
            )

            self.table.setItem(
                row, 4,
                QTableWidgetItem(self._format_time(task.get('last_run', 0)))
            )

            status_item = QTableWidgetItem()
            if not is_enabled:
                status_item.setText('已停用' if is_loop else '已结束')
                status_item.setForeground(QColor('#999'))
            else:
                running_ids = self._get_running_task_ids()
                if task_id in running_ids:
                    status_item.setText('运行中')
                    status_item.setForeground(QColor('#4CAF50'))
                else:
                    status_item.setText('等待中')
                    status_item.setForeground(QColor('#2196F3'))
            self.table.setItem(row, 5, status_item)
            self.table.setCellWidget(row, 6, self._make_action_widget(task))

    def _make_action_widget(self, task):
        # 原始行号: def@299
        widget = QWidget()
        layout = QHBoxLayout(widget)
        layout.setContentsMargins(4, 2, 4, 2)
        layout.setSpacing(4)

        task_id = task['id']
        is_enabled = task['enabled'] == 1
        is_loop = task['interval_hours'] > 0

        if is_loop:
            toggle_btn = QPushButton('停用' if is_enabled else '启用')
            toggle_btn.setFixedWidth(50)
            toggle_btn.clicked.connect(
                lambda _, tid=task_id, en=is_enabled: self._toggle_task(tid, en)
            )
            layout.addWidget(toggle_btn)

        del_btn = QPushButton('删除')
        del_btn.setFixedWidth(50)
        del_btn.clicked.connect(
            lambda _, tid=task_id: self._delete_task(tid)
        )
        layout.addWidget(del_btn)

        layout.addStretch()
        return widget

    def _toggle_task(self, task_id, current_enabled):
        # 原始行号: def@325
        try:
            from data.database import update_task

            update_task(task_id, enabled=0 if current_enabled else 1)
            self.refresh_table()
            self.tasks_changed.emit()
        except Exception as e:
            QMessageBox.warning(self, '操作失败', f'停用/启用失败: {e}')

    def _delete_task(self, task_id):
        # 原始行号: def@335
        reply = QMessageBox.question(
            self,
            '确认删除',
            '确定要删除此任务吗？',
            QMessageBox.Yes | QMessageBox.No
        )
        if reply == QMessageBox.Yes:
            try:
                from data.database import delete_task

                delete_task(task_id)
                self.refresh_table()
                self.tasks_changed.emit()
            except Exception as e:
                QMessageBox.warning(self, '删除失败', f'删除任务失败: {e}')

    def _get_running_task_ids(self):
        # 原始行号: def@352
        parent = self.parent()
        if parent and hasattr(parent, '_running_task_ids'):
            return parent._running_task_ids
        return set()

    @staticmethod
    def _format_time(ts):
        # 原始行号: def@358 (staticmethod 包装在 359 行)
        if not ts or ts <= 0:
            return '—'
        return datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M')
