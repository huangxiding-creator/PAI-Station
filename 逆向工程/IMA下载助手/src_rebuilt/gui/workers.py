# -*- coding: utf-8 -*-
# =============================================================================
# 重建来源: E:/AI-Station/逆向工程/IMA下载助手/dump/gui_workers_workers.dis.txt
#   (CPython 3.13 dis 反汇编; 原始模块 gui/workers/workers.py, 共约 930 行)
# 重建方法: 逐函数从 3.13 字节码 (FOR_ITER / BINARY_OP / CALL_KW / ExceptionTable)
#   恢复控制流, LOAD_CONST 恢复字符串常量, LOAD_GLOBAL+LOAD_ATTR 恢复属性链调用。
# 整体置信度: 高 (~95%)。
#   - 类名/函数名/参数名/信号签名/docstring: 来自 co_names / co_varnames / LOAD_CONST, 精确。
#   - 控制流 (if/while/for/try 嵌套、break/continue/return 位置): 依据跳转目标与异常表逐条核对。
#   - 条件表达式 (x if c else y) 与 if/else 语句的区分依据 3.13 的 COPY/TO_BOOL/POP_TOP 短路模式。
# 已知保留:
#   1. 原 pyc 中 8 个字符串常量本身是 GBK 误解码乱码(原工程源码即如此), 本文件按字节原样
#      保留, 行尾注释标注本意 (如 '閿欒: ' 即 '错误: ')。
#   2. dump 中另一模块 gui/workers.pyc 仅含 RESUME/RETURN_CONST (空模块), 无代码可重建。
#   3. 空行与原始行号未逐行对齐; 各类/函数原始起始行号见注释。
# =============================================================================
"""Background workers."""

from PySide6.QtCore import Qt, QThread, Signal

from services.ima_service import (
    get_knowledge_base_list,
    download_single_file,
    get_folder_content,
    sanitize_filename,
    get_file_count,
    search_knowledge,
    get_tag_view,
    file_exists,
    make_dirs,
    fs_path,
)

from core.settings import get_setting
from core.auth import translate_error_message
import os


# ---- 模块级辅助 (orig line 20 / 25) ----

def is_auth_expired_response(result):
    """Only treat explicit auth-expired responses as login expiration."""
    return bool(result) and result.get('code') == 600001


def format_service_error(result):
    """Keep IMA business error codes visible instead of hiding them."""
    if not result:
        return '网络请求失败，请检查代理设置或网络连接'
    code = result.get('code')
    message = translate_error_message(result.get('msg', '加载失败'))
    if code is not None:
        return f'IMA接口错误 {code}：{message}'
    return message


# ---- 待下载文件收集器 (orig line 34) ----

class _PendingFileCollector:
    def __init__(self):
        self.files = []

    def put(self, file_info):
        self.files.append(file_info)


# ---- 知识库列表加载 Worker (orig line 42) ----

class LoadKnowledgeBasesWorker(QThread):
    list_ready = Signal(list)          # 43
    icon_loaded = Signal(str, object)  # 44
    file_count_loaded = Signal(str, int)  # 45
    finished = Signal(list)            # 46
    error = Signal(str)                # 47
    auth_expired = Signal()            # 48

    def run(self):  # 50
        try:
            result = get_knowledge_base_list()
            if result and result.get('code') == 0:
                kbs = []
                for param_result in result.get('results', []):
                    for kb in param_result.get('knowledge_base_list', []):
                        basic_info = kb.get('basic_info', {})
                        member_info = kb.get('member_info', {})
                        permission_info = kb.get('permission_info', {})
                        status_toast = kb.get('knowledge_base_status_toast', '')
                        update_time = (
                            status_toast.replace('鏈€杩戞洿鏂?', '').strip()
                            if status_toast else '-'
                        )  # '鏈€杩戞洿鏂?' 为原 pyc 中的乱码常量, 本意 '最近更新'
                        kb_id = kb.get('id')
                        kbs.append({
                            'id': kb_id,
                            'name': basic_info.get('name', '未命名'),
                            'size': basic_info.get('size', '0'),
                            'member_count': member_info.get('member_count', 0),
                            'file_count': 0,
                            'update_time': update_time,
                            'visible_export_status': permission_info.get('visible_export_status', 3),
                            'description': basic_info.get('description', ''),
                            'cover_url': basic_info.get('cover_url', ''),
                        })

                self.list_ready.emit(kbs)

                from PySide6.QtGui import QIcon
                import requests
                from PySide6.QtGui import QPixmap

                for kb in kbs:
                    kb_id = kb['id']
                    if not kb_id:
                        continue
                    cover_url = kb.get('cover_url', '')
                    if cover_url:
                        try:
                            resp = requests.get(cover_url, timeout=5)
                            if resp.status_code == 200:
                                pixmap = QPixmap()
                                pixmap.loadFromData(resp.content)
                                if not pixmap.isNull():
                                    icon = QIcon(pixmap)
                                    self.icon_loaded.emit(kb_id, icon)
                        except Exception:
                            pass
                    try:
                        count = get_file_count(kb_id)
                        self.file_count_loaded.emit(kb_id, count)
                    except Exception:
                        pass

                self.finished.emit(kbs)
                return
            if is_auth_expired_response(result):
                self.auth_expired.emit()
                return
            self.error.emit(format_service_error(result))
        except Exception as e:
            self.error.emit(f'閿欒: {e}')  # 乱码常量, 本意 '错误: '


# ---- 流式下载 Worker: 整库下载执行引擎 (orig line 122) ----

class StreamDownloadWorker(QThread):
    """Stream download worker."""

    progress = Signal(int, int, str)   # 125: (downloaded_count, total_count, status_msg)
    finished = Signal()                # 126
    quota_error = Signal(str)          # 127
    file_discovered = Signal(int)      # 128: 新发现待下载文件后的最新总数
    scan_progress = Signal(str)        # 129
    quota_updated = Signal()           # 130

    def __init__(self, selected_items, cutoff_datetime=None):  # 132
        super().__init__()
        self.selected_items = selected_items      # 134
        self.cutoff_datetime = cutoff_datetime    # 135
        self._is_paused = False                   # 136
        self._is_stopped = False                  # 137
        self._downloaded_count = 0                # 138
        self._total_count = 0                     # 139
        self._quota_pool = 0                      # 140
        self._quota_requested = 0                 # 141
        self._excel_writers = {}                  # 142
        self._excel_lock = None                   # 143 (run() 中替换为 threading.Lock)
        self._date_suffix = ''                    # 146

    def pause(self):  # 148
        self._is_paused = True

    def resume(self):  # 151
        self._is_paused = False

    def stop(self):  # 154
        self._is_stopped = True

    def run(self):  # 157
        from core.auth import issue_download_token, refund_download_quota
        import queue
        import threading

        max_workers = 5
        lock = threading.Lock()
        failed_lock = threading.Lock()
        failed_count = 0
        download_token = None
        self._excel_lock = threading.Lock()

        try:
            # -- 阶段1: 扫描选中的树节点, 收集待下载文件清单 --
            collector = _PendingFileCollector()
            self._traverse_and_queue(collector)
            pending_files = collector.files
            if self._is_stopped:
                return  # finally 中统一关闭 Excel 并发 finished
            if pending_files:
                # -- 阶段2: 按文件数量申请下载配额(token) --
                ok, quota_msg, download_token = issue_download_token(len(pending_files))
                if not ok:
                    self.quota_error.emit(quota_msg)
                    return
                self.quota_updated.emit()

            # -- 阶段3: 队列 + 5 个守护线程并发消费 --
            file_queue = queue.Queue(maxsize=50)

            def download_worker():  # 185
                while True:
                    try:
                        file_info = file_queue.get(timeout=1)
                    except queue.Empty:
                        if self._is_stopped:
                            return
                        continue
                    try:
                        if file_info is None:  # 哨兵: 收尾退出
                            return
                        # 暂停节奏: 暂停且未停止时 100ms 轮询等待
                        while self._is_paused and not self._is_stopped:
                            self.msleep(100)
                        if self._is_stopped:
                            return
                        success = self._download_file(file_info, lock)
                        if not success:
                            with failed_lock:
                                failed_count += 1
                    except Exception:
                        with failed_lock:
                            failed_count += 1
                    finally:
                        file_queue.task_done()

            download_threads = []
            for _ in range(max_workers):
                t = threading.Thread(target=download_worker, daemon=True)
                t.start()
                download_threads.append(t)

            for file_info in pending_files:
                file_queue.put(file_info)

            # 每个工作线程一个 None 哨兵
            for _ in range(max_workers):
                file_queue.put(None)

            file_queue.join()
            for t in download_threads:
                t.join()

            # -- 阶段4: 失败数 > 0 时按数退还配额 --
            if failed_count > 0:
                ok, refund_msg = refund_download_quota(failed_count, download_token)
                if ok:
                    self.quota_updated.emit()
                    self.scan_progress.emit(refund_msg)
                else:
                    self.quota_error.emit(refund_msg)
        except Exception as e:
            self.quota_error.emit(f'下载任务异常: {e}')
        finally:
            self._close_all_excel_writers()
            self.finished.emit()

    def _traverse_and_queue(self, file_queue):  # 244
        """Traverse selected items and collect files."""
        for item in self.selected_items:
            if self._is_stopped:
                return
            self._traverse_item(item, '', file_queue)

    def _traverse_item(self, item, path, file_queue):  # 251
        """Traverse a selected item."""
        if self._is_stopped:
            return
        if isinstance(item, dict):
            data = item
        else:
            data = item.data(1, Qt.UserRole)
        if not data:
            return
        item_type = data.get('type')
        if item_type == 'file':
            self._add_file_to_queue(data, path, file_queue)
            return
        if item_type == 'kb':
            safe_kb_name = sanitize_filename(data['name'])
            # 知识库根: kb_id 与 folder_id 同为 data['id']
            self._traverse_folder(data['id'], data['id'], safe_kb_name, file_queue)
            return
        if item_type == 'folder':
            folder_full_path = data.get('full_path', '')
            if not folder_full_path:
                kb_name = data.get('kb_name', '')
                safe_kb_name = sanitize_filename(kb_name) if kb_name else ''
                safe_folder_name = sanitize_filename(data['name'])
                folder_full_path = (
                    f'{safe_kb_name}/{safe_folder_name}' if safe_kb_name else safe_folder_name
                )
            self._traverse_folder(data['kb_id'], data['folder_id'], folder_full_path, file_queue)

    def _traverse_folder(self, kb_id, folder_id, current_path, file_queue):  # 285
        """Traverse a folder recursively."""
        if self._is_stopped:
            return
        self.scan_progress.emit(f'正在扫描: {current_path or "根目录"}')
        content = get_folder_content(kb_id, folder_id)
        if not content:
            return
        files = content.get('files', [])
        skipped_by_cutoff = 0
        for file in files:
            if self._is_stopped:
                return
            access_status = file.get('access_status', 3)
            if access_status == 1:
                # 无下载权限: 只计数并计入"已处理", 不入队
                title = (
                    file.get('title', '')
                    .replace('\r\n', '')
                    .replace('\r', '')
                    .replace('\n', '')
                )
                self._total_count += 1
                self._downloaded_count += 1
                status_msg = (
                    f'跳过[{self._downloaded_count}/{self._total_count}] '
                    f'{title} - 无下载权限'
                )
                self.progress.emit(self._downloaded_count, self._total_count, status_msg)
                continue
            # 增量过滤: 更新时间早于起始时间的文件跳过
            if self.cutoff_datetime:
                from utils.time_parser import parse_time_wording
                file_update_time_str = file.get('update_time', '')
                file_update_datetime = parse_time_wording(file_update_time_str)
                if file_update_datetime and file_update_datetime < self.cutoff_datetime:
                    skipped_by_cutoff += 1
                    continue
            raw_title = (
                file.get('title', '')
                .replace('\r\n', '')
                .replace('\r', '')
                .replace('\n', '')
            )
            safe_title = sanitize_filename(raw_title) if raw_title else 'untitled'
            file_info = {
                'media_id': file['media_id'],
                'kb_id': kb_id,
                'media_type': file['media_type'],
                'media_type_info': file['media_type_info'],
                'title': safe_title,
                'display_title': raw_title,
                'path': current_path,
                'file_size': file.get('file_size', 0),
                'update_time': file.get('update_time', 0),
            }
            download_dir = get_setting('download_dir', 'download')
            file_path = current_path
            if self._date_suffix and file_path:
                path_parts = file_path.split('/', 1)
                kb_name = path_parts[0]
                rest_path = path_parts[1] if len(path_parts) > 1 else ''
                file_path = (
                    f'{kb_name}{self._date_suffix}/{rest_path}'
                    if rest_path else f'{kb_name}{self._date_suffix}'
                )
            save_dir = os.path.join(download_dir, file_path) if file_path else download_dir
            save_dir = save_dir.replace('\\', '/')
            local_file = self._expected_local_file(save_dir, safe_title, file_info)
            if not file_exists(local_file):
                # 新文件: 总数 +1, 入队等待下载线程消费
                self._total_count += 1
                self.file_discovered.emit(self._total_count)
                file_queue.put(file_info)
            else:
                # 本地已存在: 总数与已处理数各 +1, 跳过
                self._total_count += 1
                self._downloaded_count += 1
                status_msg = (
                    f'⊘ [{self._downloaded_count}/{self._total_count}] '
                    f'{raw_title} - 已跳过（文件已存在）'
                )
                self.progress.emit(self._downloaded_count, self._total_count, status_msg)
        if skipped_by_cutoff > 0:
            self.scan_progress.emit(
                f'  跳过 {skipped_by_cutoff} 个文件（更新时间早于起始时间）'
            )
        # 递归子文件夹
        for folder in content.get('folders', []):
            if self._is_stopped:
                return
            safe_folder_name = sanitize_filename(folder['name'])
            folder_path = (
                f'{current_path}/{safe_folder_name}' if current_path else safe_folder_name
            )
            self._traverse_folder(kb_id, folder['folder_id'], folder_path, file_queue)

    def _add_file_to_queue(self, data, path, file_queue):  # 401
        """Add one file to the pending download list."""
        if self.cutoff_datetime:
            from utils.time_parser import parse_time_wording
            file_update_time_str = data.get('update_time', '')
            file_update_datetime = parse_time_wording(file_update_time_str)
            if file_update_datetime and file_update_datetime < self.cutoff_datetime:
                return
        raw_title = (
            data['title']
            .replace('\r\n', '')
            .replace('\r', '')
            .replace('\n', '')
        )
        safe_title = sanitize_filename(raw_title) if raw_title else 'untitled'
        file_path = data.get('full_path', data.get('kb_name', ''))
        file_info = {
            'media_id': data['media_id'],
            'kb_id': data['kb_id'],
            'media_type': data['media_type'],
            'media_type_info': data['media_type_info'],
            'title': safe_title,
            'display_title': raw_title,
            'path': file_path,
            'file_size': data.get('file_size', 0),
            'update_time': data.get('update_time', 0),
        }
        download_dir = get_setting('download_dir', 'download')
        path_to_check = file_path
        if self._date_suffix and path_to_check:
            path_parts = path_to_check.split('/', 1)
            kb_name = path_parts[0]
            rest_path = path_parts[1] if len(path_parts) > 1 else ''
            path_to_check = (
                f'{kb_name}{self._date_suffix}/{rest_path}'
                if rest_path else f'{kb_name}{self._date_suffix}'
            )
        save_dir = os.path.join(download_dir, path_to_check) if path_to_check else download_dir
        save_dir = save_dir.replace('\\', '/')
        local_file = self._expected_local_file(save_dir, safe_title, file_info)
        if not file_exists(local_file):
            self._total_count += 1
            self.file_discovered.emit(self._total_count)
            file_queue.put(file_info)
            return
        self._total_count += 1
        self._downloaded_count += 1
        status_msg = (
            f'⊘ [{self._downloaded_count}/{self._total_count}] '
            f'{raw_title} - 已跳过（文件已存在）'
        )
        self.progress.emit(self._downloaded_count, self._total_count, status_msg)

    def _expected_local_file(self, save_dir, safe_title, file_info):  # 464
        """Best-effort local path used only for skip/existence checks."""
        type_name = file_info.get('media_type_info', {}).get('name', '')
        media_type = file_info.get('media_type')
        filename = safe_title
        if (media_type == 2 and type_name in ('网址', '腾讯新闻')) or \
                (media_type == 6 and type_name == '公众号'):
            if not filename.lower().endswith('.html'):
                filename += '.html'
        elif media_type == 11 and type_name == '笔记':
            note_format = get_setting('note_format', 'md')
            ext = '.md' if note_format == 'md' else '.html'
            if not filename.lower().endswith(ext):
                filename += ext
        elif media_type == 2 and type_name == 'ima 报告':
            if not filename.lower().endswith('.html'):
                filename += '.html'
        return os.path.join(save_dir, filename)

    def _download_file(self, file_info, lock):  # 486
        """Download one file and return whether it succeeded."""
        download_dir = get_setting('download_dir', 'download')
        file_path = file_info['path']
        if file_path:
            path_parts = file_path.split('/')
            path_parts = [sanitize_filename(part) for part in path_parts if part]
            file_path = '/'.join(path_parts)
        if self._date_suffix and file_path:
            path_parts = file_path.split('/', 1)
            kb_name = path_parts[0]
            rest_path = path_parts[1] if len(path_parts) > 1 else ''
            file_path = (
                f'{kb_name}{self._date_suffix}/{rest_path}'
                if rest_path else f'{kb_name}{self._date_suffix}'
            )
        save_dir = os.path.join(download_dir, file_path) if file_path else download_dir
        success, download_msg, result = download_single_file(
            file_info['media_id'],
            file_info['kb_id'],
            save_dir,
            file_info['media_type'],
            file_info['media_type_info'],
            file_info['file_size'],
            file_info['update_time'],
        )
        with lock:
            self._downloaded_count += 1
            display_title = file_info.get('display_title') or file_info['title']
            if success:
                if download_msg == 'link':
                    # 链接类内容: 不落文件, 记入知识库 Excel 汇总表
                    full_path = file_info.get('path', '')
                    if '/' in full_path:
                        kb_name = full_path.split('/')[0]
                        dir_path = '/'.join(full_path.split('/')[1:])
                    else:
                        kb_name = full_path or '未知知识库'
                        dir_path = ''
                    type_name = file_info['media_type_info'].get('name', '未知')
                    self._write_link_to_excel(
                        kb_name,
                        {
                            'kb_name': kb_name,
                            'path': dir_path,
                            'title': display_title,
                            'type': type_name,
                            'url': result,
                        },
                    )
                    status_msg = (
                        f'✓ [{self._downloaded_count}/{self._total_count}] '
                        f'{display_title} (链接已记录)'
                    )
                else:
                    status_msg = (
                        f'✓ [{self._downloaded_count}/{self._total_count}] '
                        f'{display_title}'
                    )
            else:
                status_msg = (
                    f'✗ [{self._downloaded_count}/{self._total_count}] '
                    f'{display_title} - {download_msg}'
                )
            self.progress.emit(self._downloaded_count, self._total_count, status_msg)
            return success

    def _write_link_to_excel(self, kb_name, link_data):  # 561
        """Write link records to an Excel file."""
        from openpyxl import Workbook, load_workbook
        import os

        with self._excel_lock:
            download_dir = get_setting('download_dir', 'download')
            kb_dir_name = (
                f'{kb_name}{self._date_suffix}' if self._date_suffix else kb_name
            )
            kb_dir = os.path.join(download_dir, kb_dir_name)
            make_dirs(kb_dir)
            excel_path = os.path.join(kb_dir, '公众号文章和网址汇总.xlsx')
            try:
                if kb_name in self._excel_writers:
                    wb = self._excel_writers[kb_name]['wb']
                    ws = self._excel_writers[kb_name]['ws']
                else:
                    if file_exists(excel_path):
                        wb = load_workbook(fs_path(excel_path))
                        ws = wb.active
                    else:
                        wb = Workbook()
                        ws = wb.active
                        ws.title = '链接汇总'
                        ws.append(['知识库名称', '所在目录', '名称', '类型', '链接'])
                        ws.column_dimensions['A'].width = 20
                        ws.column_dimensions['B'].width = 30
                        ws.column_dimensions['C'].width = 40
                        ws.column_dimensions['D'].width = 15
                        ws.column_dimensions['E'].width = 60
                    self._excel_writers[kb_name] = {
                        'wb': wb, 'ws': ws, 'path': excel_path,
                    }
                ws.append([
                    link_data['kb_name'],
                    link_data['path'],
                    link_data['title'],
                    link_data['type'],
                    link_data['url'],
                ])
                wb.save(fs_path(excel_path))
            except Exception:
                pass

    def _close_all_excel_writers(self):  # 616
        """Close all Excel writers."""
        with self._excel_lock:
            for kb_name, writer_info in self._excel_writers.items():
                try:
                    writer_info['wb'].save(fs_path(writer_info['path']))
                    writer_info['wb'].close()
                except Exception:
                    continue
            self._excel_writers.clear()


# ---- 旧版批量下载 Worker (orig line 629) ----

class DownloadWorker(QThread):
    """Legacy batch download worker."""

    progress = Signal(int, int, str)   # 632
    finished = Signal()                # 633
    quota_error = Signal(str)          # 634

    def __init__(self, files):  # 636
        super().__init__()
        self.files = files
        self._is_paused = False
        self._is_stopped = False

    def pause(self):  # 642
        self._is_paused = True

    def resume(self):  # 645
        self._is_paused = False

    def stop(self):  # 648
        self._is_stopped = True

    def run(self):  # 651
        from core.auth import issue_download_token, refund_download_quota
        from data.database import save_download_records_batch
        from concurrent.futures import ThreadPoolExecutor, as_completed

        total = len(self.files)
        batch_size = 50
        max_workers = 5
        db_records = []
        failed_count = 0
        download_token = None

        if total > 0:
            ok, quota_msg, download_token = issue_download_token(total)
            if not ok:
                self.quota_error.emit(quota_msg)
                self.finished.emit()
                return

        # 分批(每批50) + 每批内 ThreadPoolExecutor(5线程) 并发
        for batch_start in range(0, total, batch_size):
            if self._is_stopped:
                return
            batch_end = min(batch_start + batch_size, total)
            batch_files = self.files[batch_start:batch_end]
            with ThreadPoolExecutor(max_workers=max_workers) as executor:
                futures = {}
                for i, file in enumerate(batch_files):
                    if self._is_stopped:
                        break
                    while self._is_paused and not self._is_stopped:
                        self.msleep(100)
                    download_dir = get_setting('download_dir', 'download')
                    save_dir = (
                        os.path.join(download_dir, file['path'])
                        if file['path'] else download_dir
                    )
                    future = executor.submit(
                        download_single_file,
                        file['media_id'],
                        file['kb_id'],
                        save_dir,
                        file['media_type'],
                        file['media_type_info'],
                        file.get('file_size', 0),
                        file.get('update_time', 0),
                    )
                    futures[future] = (file, batch_start + i)
                for future in as_completed(futures):
                    if self._is_stopped:
                        break
                    file, idx = futures[future]
                    try:
                        success, msg, result = future.result()
                        if success:
                            db_records.append({
                                'media_id': file['media_id'],
                                'file_name': file['title'],
                                'file_size': file.get('file_size', 0),
                                'update_time': file.get('update_time', 0),
                                'local_path': os.path.join(save_dir, file['title']),
                            })

                            self.progress.emit(
                                idx + 1, total,
                                f'✓ [{idx + 1}/{total}] {file["title"]}'
                            )
                        else:
                            failed_count += 1
                            self.progress.emit(
                                idx + 1, total,
                                f'✗ [{idx + 1}/{total}] {file["title"]} - {msg}'
                            )
                    except Exception as e:
                        failed_count += 1
                        self.progress.emit(
                            idx + 1, total,
                            f'✗ [{idx + 1}/{total}] {file["title"]} - {str(e)}'
                        )

        if db_records:
            save_download_records_batch(db_records)
        if failed_count > 0:
            ok, refund_msg = refund_download_quota(failed_count, download_token)
            if not ok:
                self.quota_error.emit(refund_msg)
        self.finished.emit()


# ---- 文件夹内容加载 Worker (orig line 744) ----

class LoadFolderWorker(QThread):
    finished = Signal(dict, str, bool)  # 745: ({folders, files}, next_cursor, has_more)
    error = Signal(str)                 # 746
    progress = Signal(str)              # 747

    def __init__(self, kb_id, folder_id, cursor=None, limit='50'):  # 749
        super().__init__()
        self.kb_id = kb_id
        self.folder_id = folder_id
        self.cursor = cursor
        self.limit = limit

    def run(self):  # 756
        try:
            self.progress.emit('姝ｅ湪鍔犺浇鏂囦欢鍒楄〃...')  # 乱码常量, 本意 '正在加载文件列表...'
            from services.ima_service import get_knowledge_list, extract_folders_and_files

            response_data = get_knowledge_list(
                self.kb_id,
                self.folder_id,
                self.limit,
                self.cursor,
            )
            if response_data and response_data.get('code') != 0:
                self.error.emit('鍔犺浇澶辫触')  # 乱码常量, 本意 '加载失败'
                return
            knowledge_list = response_data.get('knowledge_list', [])
            folders, files = extract_folders_and_files(knowledge_list)
            next_cursor = response_data.get('next_cursor')
            is_end = response_data.get('is_end', False)
            has_more = (not is_end) and next_cursor is not None
            self.finished.emit(
                {'folders': folders, 'files': files},
                next_cursor or '',
                has_more,
            )
        except Exception as e:
            self.error.emit(f'閿欒: {e}')  # 乱码常量, 本意 '错误: '


# ---- 知识库搜索 Worker (orig line 782) ----

class SearchKnowledgeWorker(QThread):
    """Search knowledge worker."""

    finished = Signal(list, bool, str)  # 785: (searched_list, is_end, next_cursor)
    error = Signal(str)                 # 786

    def __init__(self, knowledge_base_id, query, cursor='', filters=None):  # 788
        super().__init__()
        self.knowledge_base_id = knowledge_base_id
        self.query = query
        self.cursor = cursor
        self.filters = filters

    def run(self):  # 795
        try:
            result = search_knowledge(
                self.knowledge_base_id,
                self.query,
                self.cursor,
                filters=self.filters,
            )
            if result and result.get('code') == 0:
                searched_list = result.get('searched_knowledge_list', [])
                is_end = result.get('is_end', True)
                next_cursor = result.get('next_cursor', '')
                self.finished.emit(searched_list, is_end, next_cursor)
                return
            msg = (
                result.get('msg', '鎼滅储澶辫触') if result else '缃戠粶璇锋眰澶辫触'
            )  # 乱码常量, 本意: '搜索失败' / '网络请求失败'
            self.error.emit(msg)
        except Exception as e:
            self.error.emit(f'鎼滅储寮傚父: {e}')  # 乱码常量, 本意 '搜索异常: '


# ---- 标签视图加载 Worker (orig line 812) ----

class FetchTagsWorker(QThread):
    """Load knowledge tags worker."""

    finished = Signal(list, str, bool)  # 815: (tags, next_cursor, is_end)
    error = Signal(str)                 # 816

    def __init__(self, knowledge_base_id, cursor='', limit=20):  # 818
        super().__init__()
        self.knowledge_base_id = knowledge_base_id
        self.cursor = cursor
        self.limit = limit

    def run(self):  # 824
        try:
            result = get_tag_view(
                self.knowledge_base_id,
                cursor=self.cursor,
                limit=self.limit,
            )
            if result and result.get('code') != 0:
                self.finished.emit([], '', True)
                return
            views = result.get('views', [])
            tags = [v.get('tag', '') for v in views]
            is_end = result.get('is_end', True)
            next_cursor = result.get('next_cursor', '')
            self.finished.emit(tags, next_cursor, is_end)
        except Exception as e:
            self.error.emit(f'鑾峰彇鏍囩澶辫触: {e}')  # 乱码常量, 本意 '获取标签失败: '


# ---- 树节点适配器 (orig line 841) ----

class KbTreeItemAdapter:
    """Adapter exposing QTreeWidgetItem.data() for StreamDownloadWorker."""

    def __init__(self, kb_data, folder_id='', folder_name=''):  # 844
        self._data = kb_data
        self._folder_id = folder_id
        self._folder_name = folder_name

    def data(self, column, role):  # 849
        if column == 1 and role == Qt.UserRole:
            if self._folder_id:
                return {
                    'type': 'folder',
                    'kb_id': self._data['id'],
                    'kb_name': self._data['name'],
                    'folder_id': self._folder_id,
                    'name': self._folder_name,
                    'full_path': f"{self._data['name']}/{self._folder_name}",
                    'visible_export_status': self._data.get('visible_export_status', 3),
                }
            return {
                'type': 'kb',
                'id': self._data['id'],
                'name': self._data['name'],
                'full_path': self._data['name'],
                'visible_export_status': self._data.get('visible_export_status', 3),
            }
        return None


# ---- 自动增量更新 Worker (orig line 875) ----

class AutoUpdateWorker(QThread):
    """Auto incremental update worker."""

    progress = Signal(int, int, str)   # 878
    file_discovered = Signal(int)      # 879
    scan_progress = Signal(str)        # 880
    finished = Signal()                # 881
    quota_error = Signal(str)          # 882
    quota_updated = Signal()           # 883
    kb_started = Signal(str)           # 884
    kb_finished = Signal(str, int)     # 885

    def __init__(self, kb_data_list, cutoff_datetime, folder_id=''):  # 887
        super().__init__()
        self.kb_data_list = kb_data_list
        self.cutoff_datetime = cutoff_datetime
        self.folder_id = folder_id
        self._is_stopped = False
        self._current_stream_worker = None

    def run(self):  # 895
        for kb in self.kb_data_list:
            if self._is_stopped:
                break
            self.kb_started.emit(kb['name'])
            adapter = KbTreeItemAdapter(kb, folder_id=self.folder_id)
            worker = StreamDownloadWorker([adapter], self.cutoff_datetime)
            self._current_stream_worker = worker

            worker.progress.connect(self.progress)
            worker.file_discovered.connect(self.file_discovered)
            worker.scan_progress.connect(self.scan_progress)
            worker.quota_error.connect(self.quota_error)
            worker.quota_updated.connect(self.quota_updated)

            worker.run()  # 同步执行, 不另起 QThread

            self._current_stream_worker = None
            self.kb_finished.emit(kb['name'], 0)
        self.finished.emit()

    def pause(self):  # 919
        if self._current_stream_worker:
            self._current_stream_worker.pause()

    def resume(self):  # 923
        if self._current_stream_worker:
            self._current_stream_worker.resume()

    def stop(self):  # 927
        self._is_stopped = True
        if self._current_stream_worker:
            self._current_stream_worker.stop()
