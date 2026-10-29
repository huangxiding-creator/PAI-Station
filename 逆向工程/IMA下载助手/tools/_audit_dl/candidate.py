"""下载功能 Mixin"""
from PySide6.QtWidgets import QMessageBox
from PySide6.QtCore import Qt
from gui.workers.workers import StreamDownloadWorker


class DownloadMixin:
    """下载功能，供 MainWindow 继承"""

    def download_selected(self):
        items = self.tree.selectedItems()
        if not items:
            QMessageBox.warning(self, '提示', '请选择要下载的项目')
            return

        for item in items:
            data = item.data(1, Qt.UserRole)
            item_type = data.get('type')

            if item_type == 'kb':
                visible_export_status = data.get('visible_export_status', 3)
                if visible_export_status == 1:
                    QMessageBox.warning(self, '权限不足', '该知识库不可导出')
                    return
                continue

            if item_type == 'folder':
                visible_export_status = data.get('visible_export_status', 3)
                if visible_export_status == 1:
                    QMessageBox.warning(self, '权限不足', '该文件夹不可导出')
                    return
                continue

            if item_type == 'file':
                access_status = data.get('access_status', 3)
                if access_status == 1:
                    QMessageBox.warning(self, '权限不足', '该文件不可导出')
                    return

        self.add_log('正在扫描文件列表，请稍候...', 'info')

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
        if self.download_worker:
            self.download_worker.stop()
            self.is_stopped = True
            self.add_log('已停止下载', 'error')

    def on_download_progress(self, current, total, msg):
        total = max(total, 1)
        current = min(current, total)
        percent = int(current * 100 / total)
        self.progress.setMaximum(total)
        self.progress.setValue(current)
        self.progress_detail.setVisible(True)
        self.progress_detail.setText(f'{current}/{total} · {percent}%')
        if msg.startswith('✓'):
            self.add_log(msg, 'success')
            return
        if msg.startswith('⊘'):
            self.add_log(msg, 'warning')
            return
        if msg.startswith('✗'):
            self.add_log(msg, 'error')
            return
        self.add_log(msg, 'download')

    def on_file_discovered(self, total_count):
        """当发现新文件时更新进度条最大值"""
        total_count = max(total_count, 1)
        self.progress.setMaximum(total_count)
        self.progress_detail.setVisible(True)
        self.progress_detail.setText(f'正在扫描，已发现 {total_count} 个文件')

    def on_scan_progress(self, msg):
        """显示扫描进度"""
        self.progress_detail.setVisible(True)
        if msg.startswith('正在扫描'):
            self.progress_detail.setText(msg)
        self.add_log(msg, 'info')

    def on_download_finished(self):
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
        self.load_btn.setEnabled(True)
        self.add_log(f'错误: {msg}', 'error')
        QMessageBox.critical(self, '错误', msg)
