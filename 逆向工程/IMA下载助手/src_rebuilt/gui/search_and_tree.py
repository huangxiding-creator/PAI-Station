# -*- coding: utf-8 -*-
"""
重建源码（非原始文件，由 CPython 3.13 .pyc 字节码反汇编重建）

重建来源:
  - E:/AI-Station/逆向工程/IMA下载助手/dump/gui_search_mixin.dis.txt   (gui/search_mixin.pyc)
  - E:/AI-Station/逆向工程/IMA下载助手/dump/gui_kb_tree_mixin.dis.txt   (gui/kb_tree_mixin.pyc)
  - 对应 *.summary.txt 常量摘要

重建方式: 逐函数比对 3.13 dis 输出（RESUME/POP_JUMP_IF_*/FOR_ITER/BINARY_OP/
  CALL_KW/BUILD_CONST_KEY_MAP/ExceptionTable），保留原函数名、参数名、类名、
  docstring、常量与控制流。两个 Mixin 按原文件结构合并到本文件两个独立类中，
  便于对照；原始为 gui/search_mixin.py 与 gui/kb_tree_mixin.py 两个模块。

整体置信度: 高（约 95%）。
  - 所有语句级结构（条件/循环/continue/break/with/try-except/三元表达式/闭包
    lambda 的捕获变量）均与字节码一一对应。
  - docstring 常量在 dump 中为 UTF-8 按 GBK 误读的 mojibake，已按
    gb18030 逐字符还原；个别 docstring 末尾 1 个字符因 dump 时字节丢失为
    依据语义推断（详见函数处标注，未丢失的不标注）。
  - 原文件 def 行号: SearchMixin=8(模块), on_search_clicked=11,
    on_search_finished=46, on_search_error=82, on_clear_search=91,
    convert_search_result_to_tree_item=114;
    KbTreeMixin=12(模块), _init_icons=15, _format_size=37(staticmethod),
    _get_file_icon=51, load_icon_from_url=78, get_default_icon=99,
    load_knowledge_bases=103, on_kb_list_ready=117, on_kb_icon_loaded=132,
    on_kb_file_count_loaded=142, on_kb_loaded=152, populate_kb_tree=158,
    on_item_expanded=198, on_tree_item_clicked=217, get_kb_name=241,
    get_kb_forbid_access=249, get_access_status_display=258, load_folder=267,
    on_folder_loaded=297, on_folder_error=418。
  - load_folder/on_folder_loaded 的 def 行与函数体首行之间在原文件中存在
    多行签名或注释（字节码行号跳跃 268-275、298-306），已折叠为单行签名。

其他模块依赖（本文件直接 import / 通过 self 调用，不在此重建）:
  - gui.workers.workers: SearchKnowledgeWorker / LoadKnowledgeBasesWorker /
    LoadFolderWorker（QThread 线程类）
  - MainWindow 其他 Mixin 提供的成员: add_log, _create_tag_widget,
    on_error, on_auth_expired 等
"""

# =====================================================================
# 以下为 gui/kb_tree_mixin.py 的重建部分
# =====================================================================

from PySide6.QtWidgets import QTreeWidgetItem, QApplication  # noqa: F401 (QApplication 原模块即导入)
from PySide6.QtCore import Qt, QByteArray
from PySide6.QtGui import QColor, QPixmap, QIcon

from gui.workers.workers import (
    LoadKnowledgeBasesWorker,
    LoadFolderWorker,
)
import os      # noqa: F401
import sys
import json
import base64


class KbTreeMixin:
    """知识库树操作功能，供 MainWindow 继承"""

    def _init_icons(self):
        """初始化文件类型图标（从 resources/icons.json 加载）"""  # 末字"）"为推断
        if getattr(sys, 'frozen', False):
            base_path = sys._MEIPASS
        else:
            base_path = os.path.dirname(os.path.dirname(__file__))
        icons_path = os.path.join(base_path, 'resources', 'icons.json')

        with open(icons_path, 'r', encoding='utf-8') as f:
            icon_data = json.load(f)

        self._icon_map = {}
        self._default_icon = QIcon()
        for key, b64 in icon_data.items():
            data = base64.b64decode(b64)
            pixmap = QPixmap()
            pixmap.loadFromData(QByteArray(data))
            if key == 'kb':
                pixmap = pixmap.scaled(32, 32, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                self._default_icon = QIcon(pixmap)
            else:
                pixmap = pixmap.scaled(20, 20, Qt.KeepAspectRatio, Qt.SmoothTransformation)
                self._icon_map[key] = QIcon(pixmap)

    @staticmethod
    def _format_size(size_bytes):
        """将字节数格式化为可读字符串"""  # 末字"串"为推断
        size_bytes = int(size_bytes)
        if size_bytes >= 1073741824:
            return f'{size_bytes / 1073741824:.2f}GB'
        if size_bytes >= 1048576:
            return f'{size_bytes / 1048576:.1f}MB'
        if size_bytes >= 1024:
            return f'{size_bytes / 1024:.1f}KB'
        if size_bytes > 0:
            return f'{size_bytes}B'
        return '-'

    def _get_file_icon(self, type_name):
        """根据文件类型名称返回对应图标"""
        if not type_name:
            return self._icon_map.get('txt')
        name = type_name.lower()
        if '文件夹' in name or 'folder' in name:
            return self._icon_map['folder']
        if 'pdf' in name:
            return self._icon_map['pdf']
        if 'word' in name or 'doc' in name:
            return self._icon_map['word']
        if 'excel' in name or '表格' in name or 'sheet' in name:
            return self._icon_map['excel']
        if 'ppt' in name or '演示' in name or 'presentation' in name:
            return self._icon_map['ppt']
        if '音频' in name or 'audio' in name or '音乐' in name:
            return self._icon_map['audio']
        if '图片' in name or 'image' in name or 'photo' in name:
            return self._icon_map['image']
        if '笔记' in name or 'note' in name:
            return self._icon_map['note']
        if '网址' in name or 'url' in name or '链接' in name or '网页' in name:
            return self._icon_map['url']
        if 'md' in name or 'markdown' in name:
            return self._icon_map['md']
        return self._icon_map.get('txt')

    def load_icon_from_url(self, url):
        """从URL加载图标"""
        if not url:
            return self.get_default_icon()

        import requests

        try:
            response = requests.get(url, timeout=2)
            if response.status_code == 200:
                pixmap = QPixmap()
                if pixmap.loadFromData(QByteArray(response.content)):
                    if not pixmap.isNull():
                        pixmap = pixmap.scaled(
                            32, 32,
                            Qt.KeepAspectRatio, Qt.SmoothTransformation
                        )
                        return QIcon(pixmap)
        except Exception:
            return self.get_default_icon()

        return self.get_default_icon()

    def get_default_icon(self):
        """获取默认知识库图标"""  # 末字"标"为推断
        return self._default_icon

    def load_knowledge_bases(self):
        # （原函数无 docstring）
        self.load_btn.setEnabled(False)
        self.add_log('正在加载知识库...', 'info')

        self.worker = LoadKnowledgeBasesWorker()

        self.worker.list_ready.connect(self.on_kb_list_ready)
        self.worker.icon_loaded.connect(self.on_kb_icon_loaded)
        self.worker.file_count_loaded.connect(self.on_kb_file_count_loaded)
        self.worker.finished.connect(self.on_kb_loaded)
        self.worker.error.connect(self.on_error)
        self.worker.auth_expired.connect(self.on_auth_expired)

        self.worker.start()

    def on_kb_list_ready(self, data):
        """第一阶段：列表就绪，立即渲染，图标用默认，文件数显示加载中"""  # 末字"中"为推断
        self.current_kb_list = data
        self.populate_kb_tree(data)
        self.add_log(f'已加载 {len(data)} 个知识库，正在获取图标和文件数...', 'info')

        self.kb_selector.clear()
        self.kb_selector.addItem('请选择知识库', None)
        for kb in data:
            self.kb_selector.addItem(kb['name'], kb['id'])

        self.search_input.setEnabled(True)
        self.kb_selector.setEnabled(True)
        self.search_btn.setEnabled(True)
        self.clear_search_btn.setVisible(False)

    def on_kb_icon_loaded(self, kb_id, icon):
        """第二阶段：单个图标就绪，找到对应 item 替换图标"""
        root = self.tree.invisibleRootItem()
        for i in range(root.childCount()):
            item = root.child(i)
            data = item.data(1, Qt.UserRole)
            if not data or data.get('id') != kb_id:
                continue
            item.setIcon(0, icon)
            break

    def on_kb_file_count_loaded(self, kb_id, count):
        """第二阶段：单个文件数就绪，找到对应 item 更新名称列"""  # "应""列"两字为推断
        root = self.tree.invisibleRootItem()
        for i in range(root.childCount()):
            item = root.child(i)
            data = item.data(1, Qt.UserRole)
            if not data or data.get('id') != kb_id:
                continue
            item.setText(2, f'{item.text(2)}, {count} 个文件')
            break

    def on_kb_loaded(self, data):
        """全部加载完成（图标和文件数均已异步更新），启用操作按钮"""  # 末字"钮"为推断
        self.load_btn.setEnabled(True)
        self.update_btn.setEnabled(True)
        self.add_log(f'加载完成，共 {len(data)} 个知识库', 'success')

    def populate_kb_tree(self, data):
        """根据缓存数据渲染知识库列表"""  # 末字"表"为推断
        self.tree.setUpdatesEnabled(False)
        self.tree.clear()

        items = []

        for kb in data:
            size_str = self._format_size(kb['size'])
            update_time = kb.get('update_time', '-')
            description = kb.get('description', '').replace('\n', ' ').replace('\r', ' ')

            visible_export_status = kb.get('visible_export_status', 3)
            status_text, status_color = self.get_access_status_display(visible_export_status)

            item = QTreeWidgetItem([
                kb['name'],          # 0 名称
                '知识库',            # 1 类型
                size_str,            # 2 大小（后续被文件数列覆盖显示）
                update_time,         # 3 更新时间
                status_text,         # 4 权限状态
                description,         # 5 描述
            ])

            item.setIcon(0, self.load_icon_from_url(kb.get('cover_url', '')))
            item.setForeground(4, status_color)

            item.setData(1, Qt.UserRole, {
                'type': 'kb',
                'id': kb['id'],
                'name': kb['name'],
                'full_path': kb['name'],
                'visible_export_status': visible_export_status,
            })

            item.setChildIndicatorPolicy(QTreeWidgetItem.ShowIndicator)
            items.append(item)

        self.tree.addTopLevelItems(items)
        self.tree.setUpdatesEnabled(True)

    def on_item_expanded(self, item):
        # （原函数无 docstring）
        # UserRole+1 槽位存放 'loaded' 标记，防止重复加载
        if item.data(0, Qt.UserRole + 1) == 'loaded':
            return

        if self.folder_worker and self.folder_worker.isRunning():
            item.setExpanded(False)
            return

        data = item.data(1, Qt.UserRole)
        if data['type'] == 'kb':
            visible_export_status = data.get('visible_export_status', 3)
            self.load_folder(item, data['id'], data['id'], data['name'], visible_export_status)
            return
        if data['type'] == 'folder':
            kb_name = self.get_kb_name(item)
            visible_export_status = data.get('visible_export_status', 3)
            self.load_folder(
                item, data['kb_id'], data['folder_id'], kb_name, visible_export_status)
            return

    def on_tree_item_clicked(self, item, column):
        """处理"加载更多"点击"""
        data = item.data(1, Qt.UserRole)
        if not data or data.get('type') != 'load_more':
            return

        parent = item.parent()
        if not parent:
            return

        # UserRole+2 槽位存放下一次分页游标
        next_cursor = parent.data(0, Qt.UserRole + 2)
        if not next_cursor:
            return

        parent_data = parent.data(1, Qt.UserRole)
        kb_id = data.get('kb_id')
        folder_id = data.get('folder_id', kb_id)
        kb_name = data.get('kb_name', '')
        status = data.get('visible_export_status', 3)

        parent.removeChild(item)

        self.load_folder(parent, kb_id, folder_id, kb_name, status, cursor=next_cursor)

    def get_kb_name(self, item):
        # （原函数无 docstring）
        while item:
            data = item.data(1, Qt.UserRole)
            if data['type'] == 'kb':
                return data['name']
            item = item.parent()
        return ''

    def get_kb_forbid_access(self, item):
        """获取知识库的权限状态"""  # 末字"态"为推断
        while item:
            data = item.data(1, Qt.UserRole)
            if data['type'] == 'kb':
                return data.get('visible_export_status', 3) == 1
            item = item.parent()
        return False

    def get_access_status_display(self, status_code):
        """根据 access_status 返回状态文案及颜色"""  # "态""案"两字为推断
        mapping = {
            1: ('不可查看', QColor('#d32f2f')),
            2: ('可查看、不可导出', QColor('#FF9800')),
            3: ('可查看、可导出', QColor('#4CAF50')),
        }
        return mapping.get(status_code, mapping[3])

    def load_folder(self, parent_item, kb_id, folder_id, kb_name,
                    visible_export_status=3, cursor=None):
        # （原函数无 docstring；原签名区占 267-275 行）
        if self.folder_worker and self.folder_worker.isRunning():
            return

        parent_item.setText(4, '加载中...')

        self.folder_worker = LoadFolderWorker(kb_id, folder_id, cursor)

        self.folder_worker.progress.connect(
            lambda msg: parent_item.setText(4, msg)
        )
        self.folder_worker.finished.connect(
            lambda content, next_cursor, has_more:
                self.on_folder_loaded(parent_item, kb_id, kb_name,
                                      visible_export_status,
                                      content, next_cursor, has_more)
        )
        self.folder_worker.error.connect(
            lambda err: self.on_folder_error(parent_item, err)
        )

        self.folder_worker.start()

    def on_folder_loaded(self, parent_item, kb_id, kb_name, visible_export_status,
                         content, next_cursor='', has_more=False):
        # （原函数无 docstring；原签名区占 297-306 行）
        parent_data = parent_item.data(1, Qt.UserRole)
        parent_path = parent_data.get('full_path', kb_name) if parent_data else kb_name

        self.tree.setUpdatesEnabled(False)

        status, status_color = self.get_access_status_display(visible_export_status)

        children = []

        for folder in content.get('folders', []):
            update_time = folder.get('update_time', '-')

            child = QTreeWidgetItem([
                folder['name'],      # 0 名称
                '文件夹',            # 1 类型
                '-',                 # 2 大小（占位）
                update_time,         # 3 更新时间
                status,              # 4 权限状态
                '',                  # 5 标签/预览列
            ])
            child.setIcon(0, self._get_file_icon('文件夹'))
            child.setForeground(4, status_color)
            folder_full_path = f'{parent_path}/{folder["name"]}'
            child.setData(1, Qt.UserRole, {
                'type': 'folder',
                'kb_id': kb_id,
                'kb_name': kb_name,
                'folder_id': folder['folder_id'],
                'name': folder['name'],
                'full_path': folder_full_path,
                'visible_export_status': visible_export_status,
            })

            child.setChildIndicatorPolicy(QTreeWidgetItem.ShowIndicator)
            children.append(child)

        for file in content.get('files', []):
            size_str = self._format_size(file.get('file_size', 0))
            type_name = file.get('media_type_info', {}).get('name', '文件')
            update_time = file.get('update_time', '-')

            file_access_status = file.get('access_status', 3)
            file_status, file_status_color = self.get_access_status_display(file_access_status)

            tags = file.get('tags', [])

            child = QTreeWidgetItem([
                file['title'],       # 0 标题
                type_name,           # 1 类型
                size_str,            # 2 大小
                update_time,         # 3 更新时间
                file_status,         # 4 权限状态
                '',                  # 5 标签列
            ])
            child.setIcon(0, self._get_file_icon(type_name))
            child.setForeground(4, file_status_color)

            if tags:
                child.setData(5, Qt.UserRole, tags)

            child.setData(1, Qt.UserRole, {
                'type': 'file',
                'kb_id': kb_id,
                'kb_name': kb_name,
                'full_path': parent_path,
                'media_id': file['media_id'],
                'media_type': file['media_type'],
                'media_type_info': {'name': file.get('media_type_info', {}).get('name', '文件')},
                'title': file['title'],
                'file_size': file.get('file_size', 0),
                'update_time': file.get('update_time', 0),
                'access_status': file_access_status,
            })

            children.append(child)

        if has_more and next_cursor:
            more_item = QTreeWidgetItem(['加载更多...', '', '', '', '', ''])
            more_item.setForeground(0, QColor('#2196F3'))

            parent_data_for_id = parent_item.data(1, Qt.UserRole)
            current_folder_id = kb_id
            if parent_data_for_id and parent_data_for_id.get('type') == 'folder':
                current_folder_id = parent_data_for_id.get('folder_id', kb_id)

            more_item.setData(1, Qt.UserRole, {
                'type': 'load_more',
                'kb_id': kb_id,
                'kb_name': kb_name,
                'folder_id': current_folder_id,
                'visible_export_status': visible_export_status,
            })

            children.append(more_item)

            # 记录分页游标到 UserRole+2，供"加载更多"点击时读取
            parent_item.setData(0, Qt.UserRole + 2, next_cursor)

        parent_item.addChildren(children)

        # 为带 tags 的文件挂标签视图控件，并清掉临时 tags 数据
        for child in children:
            tags = child.data(5, Qt.UserRole)
            if not tags:
                continue
            tag_widget = self._create_tag_widget(tags)
            self.tree.setItemWidget(child, 5, tag_widget)
            child.setData(5, Qt.UserRole, None)

        # 标记该节点已加载（UserRole+1）
        parent_item.setData(0, Qt.UserRole + 1, 'loaded')

        self.tree.setUpdatesEnabled(True)

        parent_item.setText(4, status)

    def on_folder_error(self, parent_item, error):
        # （原函数无 docstring）
        parent_item.setText(4, '加载失败')
        self.add_log(f'加载失败：{error}', 'error')


# =====================================================================
# 以下为 gui/search_mixin.py 的重建部分
# =====================================================================

from PySide6.QtWidgets import QTreeWidgetItem, QMessageBox  # noqa: F401 (QTreeWidgetItem 与上方导入重复)
from PySide6.QtCore import Qt                                # noqa: F401
from PySide6.QtGui import QColor                             # noqa: F401

from gui.workers.workers import SearchKnowledgeWorker


class SearchMixin:
    """搜索功能，供 MainWindow 继承"""

    def on_search_clicked(self):
        """触发搜索"""
        query = self.search_input.text().strip()

        if not query and not self.selected_tags:
            QMessageBox.warning(self, '提示', '请输入关键词或选择标签')
            return

        kb_id = self.kb_selector.currentData()
        if not kb_id:
            QMessageBox.warning(self, '提示', '请选择要搜索的知识库')
            return

        kb_name = self.kb_selector.currentText()

        filters = None
        if self.selected_tags:
            # 标签筛选 policy 组装: filter_type=2, tags_filter 内嵌 tags 列表
            filters = [{'filter_type': 2, 'tags_filter': {'tags': self.selected_tags}}]

        self.search_mode = True
        self.search_btn.setEnabled(False)
        self.search_input.setEnabled(False)
        self.kb_selector.setEnabled(False)
        self.tag_selector.setEnabled(False)

        log_msg = f'正在搜索：{query}' if query else '正在按标签筛选'
        self.add_log(log_msg, 'info')

        # 知识库检索调用: 关键词 + filters(标签策略)，游标分页由 worker 回调带回
        self.search_worker = SearchKnowledgeWorker(kb_id, query, filters=filters)
        self.search_worker.finished.connect(
            lambda results, is_end, cursor:
                self.on_search_finished(results, is_end, cursor, kb_id, kb_name)
        )
        self.search_worker.error.connect(self.on_search_error)

        self.search_worker.start()

    def on_search_finished(self, results, is_end, next_cursor, kb_id, kb_name):
        """处理搜索结果"""
        self.search_btn.setEnabled(True)
        self.search_input.setEnabled(True)
        self.kb_selector.setEnabled(True)
        self.tag_selector.setEnabled(True)

        self.search_next_cursor = next_cursor

        if not results:
            self.tree.clear()
            self.add_log('未找到匹配的文件', 'warning')
            self.clear_search_btn.setVisible(True)
            return

        self.tree.setUpdatesEnabled(False)
        self.tree.clear()

        items = []

        for result in results:
            item = self.convert_search_result_to_tree_item(result, kb_id, kb_name)
            if not item:
                continue
            items.append(item)

        self.tree.addTopLevelItems(items)

        # 标签视图: 为携带 tags 的搜索结果项挂标签控件（第 5 列）
        for item in items:
            data = item.data(1, Qt.UserRole)
            if not data:
                continue
            tags = data.get('tags', [])
            if not tags:
                continue
            tag_widget = self._create_tag_widget(tags)
            self.tree.setItemWidget(item, 5, tag_widget)

        self.tree.setUpdatesEnabled(True)

        self.add_log(f'找到 {len(results)} 个文件', 'success')
        self.clear_search_btn.setVisible(True)

    def on_search_error(self, error_msg):
        """处理搜索错误"""
        self.search_btn.setEnabled(True)
        self.search_input.setEnabled(True)
        self.kb_selector.setEnabled(True)
        self.tag_selector.setEnabled(True)

        self.add_log(f'搜索失败：{error_msg}', 'error')
        QMessageBox.warning(self, '搜索失败', error_msg)

    def on_clear_search(self):
        """清除搜索结果，恢复原始树形结构"""  # 末字"构"为推断
        if not self.search_mode:
            return

        if self.current_kb_list:
            self.populate_kb_tree(self.current_kb_list)

        self.search_mode = False
        self.search_input.clear()
        self.search_next_cursor = ''
        self.clear_search_btn.setVisible(False)
        self.kb_selector.setEnabled(True)
        self.search_btn.setEnabled(True)
        self.tag_selector.setEnabled(True)
        for i in range(self.tag_list_widget.count()):
            self.tag_list_widget.item(i).setCheckState(Qt.Unchecked)
        self.selected_tags = []
        self.tag_selector.setEditText('')
        self.tag_selector.setPlaceholderText('选择标签（可选）')

        self.add_log('已返回知识库列表', 'info')

    def convert_search_result_to_tree_item(self, search_result, kb_id, kb_name):
        """将搜索结果转换为树形控件项"""  # 末字"项"为推断
        import re

        knowledge = search_result.get('knowledge', {})
        if not knowledge:
            return None

        media_id = knowledge.get('media_id', '')
        title = knowledge.get('title', '')
        file_size = int(knowledge.get('file_size', 0))
        media_type = knowledge.get('media_type', 0)
        media_type_info = knowledge.get('media_type_info', {})
        update_time = knowledge.get('time_wording', '-')
        parent_folder_name = search_result.get('parent_folder_name', '')
        size_str = self._format_size(file_size)

        highlight_content = search_result.get('highlight_content', '')
        content_preview = re.sub('<[^>]+>', '', highlight_content)[:100]

        tags = knowledge.get('tags', []) or search_result.get('tags', [])

        access_status = knowledge.get('access_status', 3)
        status_text, status_color = self.get_access_status_display(access_status)

        item = QTreeWidgetItem([
            title,               # 0 标题
            media_type_info.get('name', '文件'),  # 1 类型
            size_str,            # 2 大小
            update_time,         # 3 更新时间
            status_text,         # 4 权限状态
            content_preview,     # 5 高亮预览
        ])

        item.setIcon(0, self._get_file_icon(media_type_info.get('name', '')))
        item.setForeground(4, status_color)

        item.setData(1, Qt.UserRole, {
            'type': 'file',
            'kb_id': kb_id,
            'kb_name': kb_name,
            'media_id': media_id,
            'media_type': media_type,
            'media_type_info': media_type_info,
            'title': title,
            'full_path': f'{kb_name}/{parent_folder_name}' if parent_folder_name else kb_name,
            'file_size': file_size,
            'update_time': knowledge.get('update_time', 0),
            'access_status': access_status,
            'forbid_access': access_status == 1,
            'tags': tags,
        })

        return item
