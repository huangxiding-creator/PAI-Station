# -*- coding: utf-8 -*-
# ============================================================================
# 重建来源: E:/AI-Station/逆向工程/IMA下载助手/dump/services_ima_service.dis.txt
#           (CPython 3.13 .pyc 反汇编, services/ima_service.py, 源文件约1388行)
# 重建方式: 逐函数从 3.13 dis 字节码(含 ExceptionTable)恢复控制流,
#           LOAD_CONST 恢复字符串常量, CALL_KW 恢复关键字参数, 行号注释对齐原文件行号。
# 整体置信度: 高 (95%+)。函数名/参数名/常量/分支结构均与字节码一一对应;
# 仅源码排版(空行/换行位置)与个别字面量的书写形式(raw/escape)为合理推断。
# 已知不确定性见文件底部注释。
# ============================================================================

"""
IMA知识库服务模块
提供知识库结构获取、文件下载等功能
"""

import os
import re
import time
import unicodedata
import requests
from requests.adapters import HTTPAdapter
import json
import base64
import hashlib
from urllib.parse import urlparse
import markdown

from core.config import (
    get_endpoint_url,
    get_endpoint_method,
    get_timeout,
    get_retry_config,
    get_wechat_api_url
)

# 特殊字符过滤: Emoji/圈数字/图案符号/零宽字符 (第19-23行)
# 注: \U0001ffff 与 ​-‍﻿ 为非打印字符, 按反汇编常量以转义形式还原
_SPECIAL_CHARS_RE = re.compile('[🀀-\U0001ffff✂-➿①-⓿☀-⛿⬀-⯿️​-‍﻿]')


import threading

_thread_local = threading.local()


def get_optimized_session():
    """获取优化的 requests Session（带连接池，线程独立）"""
    if not hasattr(_thread_local, 'session') or _thread_local.session is None:
        _thread_local.session = requests.Session()
        adapter = HTTPAdapter(
            pool_connections=10,
            pool_maxsize=20,
            max_retries=0,
            pool_block=False
        )
        _thread_local.session.mount('http://', adapter)
        _thread_local.session.mount('https://', adapter)
        _thread_local.session.verify = True
    return _thread_local.session


def close_session():
    """关闭并释放当前线程的 Session（下载完成后调用以释放内存）"""
    if hasattr(_thread_local, 'session') and _thread_local.session is not None:
        _thread_local.session.close()
        _thread_local.session = None


def _get_headers():
    """动态获取最新的HEADERS"""
    from core.config_manager import get_config_manager
    from data.database import get_login_credentials

    creds = get_login_credentials()
    if not creds:
        raise RuntimeError('未登录IMA，请先扫码登录')

    config = get_config_manager()
    return config.build_headers_with_cookie(creds['bkn'], creds['cookie'])


def _get_retry_params():
    """获取重试参数（内部辅助函数）"""
    cfg = get_retry_config()
    return cfg.get('max_retries', 3), cfg.get('delay', 2)


def sanitize_filename(filename):
    """
清理文件名/目录名中的非法字符，同时支持 Windows 和 macOS。

过滤内容：
- 换行符、回车符、制表符等控制字符
- Emoji 和特殊 Unicode 符号（如 ⓿❶❷ 等圈数字、图案符号）
- Windows/macOS 非法文件名字符（\ / : * ? " < > |）
- 首尾空格和点号

Args:
    filename: 原始文件名或目录名

Returns:
    清理后的安全文件名/目录名
"""
    if not filename:
        return 'untitled'

    safe_name = ''.join(
        ' ' if unicodedata.category(c) in ('Cc', 'Cf') else c
        for c in filename
    )
    safe_name = _SPECIAL_CHARS_RE.sub('', safe_name)
    safe_name = re.sub(r'[\\/:*?"<>|：""《》？｜＊]', '_', safe_name)
    safe_name = re.sub(r'\s+', ' ', safe_name)
    safe_name = safe_name.strip('. ')
    if not safe_name:
        safe_name = 'untitled'
    return safe_name


def fs_path(path):
    """Return a Windows long-path safe version for local filesystem calls."""
    if not path or os.name != 'nt':
        return path
    abs_path = os.path.abspath(path)
    if abs_path.startswith('\\\\?\\'):
        return abs_path
    if abs_path.startswith('\\\\'):
        return '\\\\?\\UNC\\' + abs_path[2:]
    return '\\\\?\\' + abs_path


def file_exists(path):
    return os.path.exists(fs_path(path))


def make_dirs(path):
    os.makedirs(fs_path(path), exist_ok=True)


def make_request_with_retry(url, method='POST', json_data=None, headers=None,
                            timeout=None, max_retries=None, retry_delay=None,
                            stream=False, raise_for_status=True):
    """带重试机制的请求函数（使用连接池优化）"""
    import time
    from core.config import load_cookie_from_cache

    if max_retries is None or retry_delay is None:
        retry_cfg = get_retry_config()
        max_retries = max_retries or retry_cfg.get('max_retries', 2)
        retry_delay = retry_delay or retry_cfg.get('delay', 1)

    if timeout is None:
        timeout = get_timeout()

    if headers is None:
        headers = _get_headers()

    session = get_optimized_session()

    for attempt in range(1, max_retries + 1):
        try:
            if method.upper() == 'POST':
                response = session.post(
                    url,
                    headers=headers,
                    json=json_data,
                    timeout=timeout,
                    stream=stream
                )
            else:
                response = session.get(
                    url,
                    headers=headers,
                    timeout=timeout,
                    stream=stream
                )

            if raise_for_status:
                response.raise_for_status()

            return response
        except requests.exceptions.Timeout:
            if attempt < max_retries:
                time.sleep(retry_delay)
            else:
                return None
        except requests.exceptions.ConnectionError:
            if attempt < max_retries:
                time.sleep(retry_delay)
            else:
                return None
        except requests.exceptions.RequestException:
            if attempt < max_retries:
                time.sleep(retry_delay)
            else:
                return None
        except Exception:
            return None
    return None


def decode_cursor(cursor):
    """解码next_cursor"""
    try:
        decoded = base64.b64decode(cursor)
        if len(decoded) >= 2 and decoded[0] == 8:
            return decoded[1]
    except Exception:
        return None
    return None


def should_paginate(next_cursor, limit):
    """判断是否需要翻页"""
    if not next_cursor:
        return False

    decoded_value = decode_cursor(next_cursor)
    if decoded_value is None:
        return False

    return decoded_value >= int(limit)


def get_knowledge_base_list():
    """获取用户的所有知识库列表"""
    url = get_endpoint_url('get_knowledge_base_list')
    method = get_endpoint_method('get_knowledge_base_list')

    payload = {
        'params': [
            {'type': 1, 'limit': '49'},
            {'type': 2, 'limit': '49'},
            {'type': 3, 'limit': '49'}
        ]
    }

    try:
        response = make_request_with_retry(url, method, json_data=payload)
        if response is None:
            return None

        try:
            return response.json()
        except json.JSONDecodeError:
            return None
    except Exception:
        return None


def get_knowledge_list(knowledge_base_id, folder_id, limit='50', cursor=None):
    """获取知识库列表"""
    url = get_endpoint_url('get_knowledge_list')
    method = get_endpoint_method('get_knowledge_list')

    payload = {
        'limit': limit,
        'knowledge_base_id': knowledge_base_id,
        'folder_id': folder_id
    }
    if cursor:
        payload['cursor'] = cursor

    try:
        response = make_request_with_retry(url, method, json_data=payload)
        if response is None:
            return None
        return response.json()
    except json.JSONDecodeError:
        return None
    except Exception:
        return None


def get_file_count(knowledge_base_id):
    """获取知识库文件总数"""
    result = get_knowledge_list(knowledge_base_id, knowledge_base_id, limit='1')
    if result and result.get('code') == 0:
        return int(result.get('total_size', 0))
    return 0


def search_knowledge(knowledge_base_id, query, cursor='', policy=0, filters=None):
    """搜索知识库文件"""
    url = get_endpoint_url('search_knowledge')
    method = get_endpoint_method('search_knowledge')

    payload = {
        'cursor': cursor,
        'query': query,
        'knowledge_base_id': knowledge_base_id,
        'compared_knowledge_base_id': knowledge_base_id,
        'policy': policy,
        'forbid_default_cover': False
    }
    if filters:
        payload['filters'] = filters

    try:
        response = make_request_with_retry(
            url, method, json_data=payload, timeout=(5, 20), max_retries=2
        )

        if response is None:
            return None
        return response.json()
    except Exception:
        return None


def get_tag_view(knowledge_base_id, cursor='', limit=50):
    """获取知识库标签列表（游标分页）"""
    url = get_endpoint_url('get_tag_view')
    if not url:
        return None
    method = get_endpoint_method('get_tag_view')

    payload = {
        'knowledge_base_id': knowledge_base_id,
        'cursor': cursor,
        'limit': limit
    }

    try:
        response = make_request_with_retry(
            url, method, json_data=payload, timeout=(5, 15), max_retries=2
        )

        if response is None:
            return None
        return response.json()
    except Exception:
        return None


def extract_folders_and_files(knowledge_list):
    """从knowledge_list中提取文件夹和文件信息"""
    folders = []
    files = []

    for item in knowledge_list:
        media_type = item.get('media_type')
        media_type_info = item.get('media_type_info', {})
        type_name = media_type_info.get('name', '')

        if media_type == 99 and type_name == '文件夹':
            folder_info = item.get('folder_info', {})
            time_wording = item.get('time_wording', '')
            update_time = time_wording.replace('更新', '').strip() if time_wording else '-'
            folders.append({
                'folder_id': folder_info.get('folder_id', item.get('media_id')),
                'name': item.get('title', ''),
                'file_number': folder_info.get('file_number', '0'),
                'folder_number': folder_info.get('folder_number', '0'),
                'parent_folder_id': item.get('parent_folder_id', ''),
                'update_time': update_time,
                'type': 'folder'
            })
            continue

        media_id = item.get('media_id')
        if not media_id:
            continue
        time_wording = item.get('time_wording', '')
        update_time = time_wording.replace('更新', '').strip() if time_wording else '-'
        files.append({
            'media_id': media_id,
            'title': item.get('title', ''),
            'media_type': media_type,
            'media_type_info': media_type_info,
            'file_size': item.get('file_size', '0'),
            'update_time': update_time,
            'parent_folder_id': item.get('parent_folder_id', ''),
            'access_status': item.get('access_status', 3),
            'tags': item.get('tags', []),
            'type': 'file'
        })

    return folders, files


def get_folder_content(knowledge_base_id, folder_id, limit='50'):
    """
获取单层文件夹内容（不递归）
返回格式：{
    "folders": [...],
    "files": [...]
}
"""
    all_folders = []
    all_files = []
    cursor = None

    while True:
        response_data = get_knowledge_list(knowledge_base_id, folder_id, limit, cursor)
        if not response_data or response_data.get('code') != 0:
            break

        knowledge_list = response_data.get('knowledge_list', [])
        folders, files = extract_folders_and_files(knowledge_list)
        all_folders.extend(folders)
        all_files.extend(files)
        next_cursor = response_data.get('next_cursor')
        is_end = response_data.get('is_end', False)
        if is_end or not next_cursor:
            break
        if should_paginate(next_cursor, limit):
            cursor = next_cursor
            continue
        break

    return {
        'folders': all_folders,
        'files': all_files
    }


def get_all_files_recursive(knowledge_base_id, folder_id, current_path=''):
    """
递归获取文件夹下的所有文件
返回格式：[
    {
        "media_id": "xxx",
        "title": "文件名",
        "media_type": 2,
        "media_type_info": {...},
        "path": "文件夹路径"
    }
]
"""
    all_files_list = []

    content = get_folder_content(knowledge_base_id, folder_id)

    for file in content.get('files', []):
        file_with_path = file.copy()
        file_with_path['path'] = current_path
        all_files_list.append(file_with_path)

    for folder in content.get('folders', []):
        folder_path = current_path + '/' + folder['name'] if current_path else folder['name']
        sub_files = get_all_files_recursive(
            knowledge_base_id,
            folder['folder_id'],
            folder_path
        )

        all_files_list.extend(sub_files)

    return all_files_list


def get_media_url(media_id, knowledge_base_id):
    """获取文件的下载URL和headers（优化版：减少超时时间）"""
    url = get_endpoint_url('get_media')
    method = get_endpoint_method('get_media')

    payload = {
        'media_id': media_id,
        'knowledge_base_id': knowledge_base_id
    }

    try:
        response = make_request_with_retry(
            url, method, json_data=payload, timeout=(5, 15), max_retries=2
        )

        if response is None:
            return None, None, None
        data = response.json()
        if data.get('code') == 0:
            jump_url_info = data.get('jump_url_info', {})
            jump_url = jump_url_info.get('url', '').replace('\\u0026', '&')
            headers = jump_url_info.get('headers', {})
            title = data.get('title', 'unknown')
            return jump_url, headers, title

        return None, None, None
    except Exception:
        return None, None, None


def get_note_content(docid, knowledge_id):
    """获取note类型文件的内容（优化版）"""
    url = get_endpoint_url('get_share_know_doc')
    if not url:
        return None, None, '接口配置缺失: get_share_know_doc'
    method = get_endpoint_method('get_share_know_doc')

    payload = {
        'docid': docid,
        'op': {
            'op_attach': True,
            'op_basic': True,
            'op_content': True,
            'op_resource': True,
            'disable_cover': False
        },
        'knowledge_id': knowledge_id
    }

    try:
        response = make_request_with_retry(
            url,
            method,
            json_data=payload,
            timeout=(5, 20),
            max_retries=2,
            raise_for_status=False
        )

        if response is None:
            return None, None, '请求失败或超时'
        if response.status_code >= 400:
            detail = response.text[:200].replace('\n', ' ').replace('\r', ' ')
            return None, None, f'HTTP {response.status_code} {detail}'

        try:
            data = response.json()
        except Exception as e:
            return None, None, f'响应不是有效JSON: {str(e)}'

        if data.get('code') == 0:
            doc_info = data.get('doc_info', {})
            content_info = doc_info.get('content_info', {})
            content_json = content_info.get('content_info', {}).get('content', '')
            if not content_json:
                return None, None, '接口返回成功但正文为空'

            basic_info = doc_info.get('basic_info', {}).get('basic_info', {})
            title = basic_info.get('title', 'untitled')
            link_map = {}

            try:
                doc_link = data.get('doc_link', {})
                raw_link_map = doc_link.get('link_map', {})
                for base_url, signed_url in raw_link_map.items():
                    link_map[base_url] = signed_url

                    base_path = base_url.split('?')[0]
                    link_map[base_path] = signed_url
            except Exception:
                pass

            return content_json, title, link_map

        code = data.get('code')
        message = data.get('message') or data.get('msg') or data.get('error_msg') or '未知错误'
        return None, None, f'接口返回失败 code={code}, message={message}'
    except Exception as e:
        return None, None, f'异常: {str(e)}'


def get_report_content(report_id, knowledge_base_id):
    """获取IMA报告内容（优化版）"""
    url = get_endpoint_url('get_task_report')
    method = get_endpoint_method('get_task_report')
    payload = {'report_id': report_id}

    try:
        response = make_request_with_retry(
            url, method, json_data=payload, timeout=(5, 20), max_retries=2
        )

        if response is None:
            return None, None
        data = response.json()
        if data.get('code') == 0:
            title = data.get('title', 'untitled')
            format_answer = data.get('format_answer', {})
            block_list = format_answer.get('block_list', [])
            return title, block_list

        return None, None
    except Exception:
        return None, None


class ImaNoteMdParser:
    """IMA笔记Markdown解析器"""

    def __init__(self, json_data, link_map=None):
        self.json_data = json_data
        self.link_map = link_map or {}

    def parse_nodes(self, nodes):
        md_parts = []
        for node in nodes:
            node_type = node.get('type', 'text')

            if node_type == 'cursor-side':
                md_parts.append(self.parse_cursor_side(node))
            elif node_type == 'p':
                md_parts.append(self.parse_paragraph(node))
            elif node_type in ('h1', 'h2', 'h3', 'h4'):
                md_parts.append(self.parse_heading(node, int(node_type[1])))
            elif node_type == 'cloud_image':
                md_parts.append(self.parse_image(node))
            elif node_type == 'blockquote':
                md_parts.append(self.parse_blockquote(node))
            elif node_type == 'code_block':
                md_parts.append(self.parse_code_block(node))
            elif node_type == 'table':
                md_parts.append(self.parse_table(node))
            elif 'text' in node:
                md_parts.append(self.parse_text(node))

        return '\n\n'.join([p for p in md_parts if p.strip()])

    def parse_cursor_side(self, node):
        children = node.get('children', [])
        result = []
        for child in children:
            if child.get('type') == 'cloud_image':
                result.append(self.parse_image(child))
        return '\n'.join(result)

    def parse_image(self, node):
        url = node.get('url', '')

        if url in self.link_map:
            url = self.link_map[url]
        else:
            base_path = url.split('?')[0]
            if base_path in self.link_map:
                url = self.link_map[base_path]

        return f'![图片]({url})'

    def parse_paragraph(self, node):
        children = node.get('children', [])
        content = self.parse_children(children)
        return content if content.strip() else ''

    def parse_heading(self, node, level):
        children = node.get('children', [])
        content = self.parse_children(children)
        return f'{"#" * level} {content}'

    def parse_blockquote(self, node):
        children = node.get('children', [])
        content = self.parse_nodes(children)
        lines = content.split('\n')
        return '\n'.join([f'> {line}' for line in lines])

    def parse_code_block(self, node):
        children = node.get('children', [])
        code_lines = []

        for child in children:
            if child.get('type') == 'code_line':
                line_children = child.get('children', [])
                line_text = ''.join([c.get('text', '') for c in line_children])
                code_lines.append(line_text)

        code_content = '\n'.join(code_lines)
        return f'```\n{code_content}\n```'

    def parse_table(self, node):
        children = node.get('children', [])
        rows = []

        for row in children:
            if row.get('type') == 'tr':
                cells = []
                for cell in row.get('children', []):
                    cell_children = cell.get('children', [])
                    cell_content = self.parse_nodes(cell_children).replace('\n', ' ')
                    cells.append(cell_content)
                rows.append(cells)

        if not rows:
            return ''

        md_lines = []
        md_lines.append('| ' + ' | '.join(rows[0]) + ' |')
        md_lines.append('| ' + ' | '.join(['---'] * len(rows[0])) + ' |')
        for row in rows[1:]:
            md_lines.append('| ' + ' | '.join(row) + ' |')

        return '\n'.join(md_lines)

    def parse_children(self, children):
        parts = []
        for child in children:
            if child.get('type') == 'a':
                url = child.get('url', '')
                link_children = child.get('children', [])
                link_text = self.parse_children(link_children)
                parts.append(f'[{link_text}]({url})')
            elif 'text' in child:
                parts.append(self.parse_text(child))
            elif child.get('type') == 'cloud_image':
                parts.append(self.parse_image(child))
            elif child.get('type') == 'p':
                parts.append(self.parse_paragraph(child))
        return ''.join(parts)

    def parse_text(self, node):
        text = node.get('text', '')
        if not text:
            return ''

        if node.get('bold'):
            text = f'**{text}**'
        if node.get('italic'):
            text = f'*{text}*'
        if node.get('strikethrough'):
            text = f'~~{text}~~'

        return text


class ImaNoteMaser:
    """IMA笔记解析器"""

    def __init__(self, json_data, link_map=None):
        self.json_data = json_data
        self.link_map = link_map or {}

    def parse_nodes(self, nodes):
        html_parts = []
        for node in nodes:
            node_type = node.get('type', 'text')

            if node_type == 'cursor-side':
                html_parts.append(self.parse_cursor_side(node))
            elif node_type == 'p':
                html_parts.append(self.parse_paragraph(node))
            elif node_type in ('h1', 'h2', 'h3', 'h4'):
                html_parts.append(self.parse_heading(node, int(node_type[1])))
            elif node_type == 'cloud_image':
                html_parts.append(self.parse_image(node))
            elif node_type == 'blockquote':
                html_parts.append(self.parse_blockquote(node))
            elif node_type == 'code_block':
                html_parts.append(self.parse_code_block(node))
            elif node_type == 'table':
                html_parts.append(self.parse_table(node))
            elif 'text' in node:
                html_parts.append(self.parse_text(node))

        return '\n'.join(html_parts)

    def parse_cursor_side(self, node):
        children = node.get('children', [])
        result = '<div class="image-container">\n'
        for child in children:
            if child.get('type') == 'cloud_image':
                result += self.parse_image(child)
        result += '</div>'
        return result

    def parse_image(self, node):
        url = node.get('url', '')
        width = node.get('width', '')
        height = node.get('height', '')

        if url in self.link_map:
            url = self.link_map[url]
        else:
            base_path = url.split('?')[0]
            if base_path in self.link_map:
                url = self.link_map[base_path]

        url_safe = url.replace('"', '&quot;').replace('<', '&lt;').replace('>', '&gt;')
        img_tag = f'  <img src="{url_safe}" '

        if width:
            img_tag += f'width="{width}" '
        if height:
            img_tag += f'height="{height}" '

        img_tag += 'alt="图片" />'
        return img_tag

    def parse_paragraph(self, node):
        children = node.get('children', [])
        content = self.parse_children(children)
        if not content.strip():
            return '<p>&nbsp;</p>'
        return f'<p>{content}</p>'

    def parse_heading(self, node, level):
        children = node.get('children', [])
        content = self.parse_children(children)
        return f'<h{level}>{content}</h{level}>'

    def parse_blockquote(self, node):
        children = node.get('children', [])
        content = self.parse_nodes(children)
        return f'<blockquote>{content}</blockquote>'

    def parse_code_block(self, node):
        children = node.get('children', [])
        code_lines = []

        for child in children:
            if child.get('type') == 'code_line':
                line_children = child.get('children', [])
                line_text = ''.join([c.get('text', '') for c in line_children])
                code_lines.append(line_text)

        code_content = '\n'.join(code_lines)

        from html import escape

        return f'<pre><code>{escape(code_content)}</code></pre>'

    def parse_table(self, node):
        children = node.get('children', [])
        html = ['<table>']

        for row in children:
            if row.get('type') == 'tr':
                html.append('<tr>')
                for cell in row.get('children', []):
                    cell_type = cell.get('type', 'td')
                    cell_children = cell.get('children', [])
                    cell_content = self.parse_nodes(cell_children)
                    html.append(f'<{cell_type}>{cell_content}</{cell_type}>')
                html.append('</tr>')
        html.append('</table>')
        return '\n'.join(html)

    def parse_children(self, children):
        parts = []
        for child in children:
            if child.get('type') == 'a':
                url = child.get('url', '')
                url_safe = url.replace('"', '&quot;').replace('<', '&lt;').replace('>', '&gt;')
                link_children = child.get('children', [])
                link_text = self.parse_children(link_children)
                parts.append(f'<a href="{url_safe}" target="_blank">{link_text}</a>')
            elif 'text' in child:
                parts.append(self.parse_text(child))
            elif child.get('type') == 'cloud_image':
                parts.append(self.parse_image(child))
            elif child.get('type') == 'p':
                parts.append(self.parse_paragraph(child))
        return ''.join(parts)

    def parse_text(self, node):
        text = node.get('text', '')
        if not text:
            return ''

        from html import escape

        text = escape(text)
        if node.get('bold'):
            text = f'<strong>{text}</strong>'
        if node.get('italic'):
            text = f'<em>{text}</em>'
        if node.get('underline'):
            text = f'<u>{text}</u>'
        if node.get('strikethrough'):
            text = f'<del>{text}</del>'

        return text


def parse_note_content_to_html(content_json, title, link_map=None):
    """将note的JSON内容转换为HTML格式"""
    try:
        content_data = json.loads(content_json)
        parser = ImaNoteMaser(content_data, link_map)

        html_parts = [
            '<!DOCTYPE html>',
            '<html lang="zh-CN">',
            '<head>',
            '<meta charset="UTF-8">',
            '<meta name="viewport" content="width=device-width, initial-scale=1.0">',
            f'<title>{title}</title>',
            '<style>',
            'body{font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Microsoft YaHei",sans-serif;line-height:1.6;max-width:800px;margin:0 auto;padding:20px;color:#333}',
            'h1,h2,h3,h4{color:#2c3e50;margin-top:1.5em;margin-bottom:0.5em}',
            'h1{font-size:2em;border-bottom:2px solid #3498db;padding-bottom:0.3em}',
            'img{max-width:100%;height:auto;display:block;margin:1em auto;border-radius:4px;box-shadow:0 2px 8px rgba(0,0,0,0.1)}',
            'a{color:#3498db;text-decoration:none;border-bottom:1px solid #3498db}',
            'blockquote{border-left:4px solid #3498db;margin:1em 0;padding:10px 15px;color:#666;background:#f8f9fa;border-radius:4px}',
            'code{background:#f4f4f4;padding:2px 6px;border-radius:3px;font-family:"Courier New",Consolas,monospace;font-size:0.9em}',
            'pre{background:#f4f4f4;padding:1em;border-radius:5px;overflow-x:auto;border:1px solid #ddd}',
            'pre code{background:none;padding:0}',
            'table{border-collapse:collapse;width:100%;margin:1em 0}',
            'th,td{border:1px solid #ddd;padding:8px;text-align:left}',
            'th{background-color:#f2f2f2;font-weight:bold}',
            '</style>',
            '</head>',
            '<body>',
            f'<h1>{title}</h1>'
        ]

        content_html = parser.parse_nodes(content_data)
        html_parts.append(content_html)
        html_parts.extend(['</body>', '</html>'])

        return '\n'.join(html_parts)
    except Exception:
        from html import escape

        return f'<html><body><h1>{escape(title)}</h1><pre>{escape(content_json)}</pre></body></html>'


def parse_note_content_to_md(content_json, title, link_map=None):
    """将note的JSON内容转换为Markdown格式"""
    try:
        content_data = json.loads(content_json)
        parser = ImaNoteMdParser(content_data, link_map)
        content_md = parser.parse_nodes(content_data)
        return f'# {title}\n\n{content_md}'
    except Exception:
        return f'# {title}\n\n```json\n{content_json}\n```'


def parse_report_to_html(title, block_list):
    """将IMA报告的block_list转换为HTML格式（渲染markdown）"""
    try:
        markdown_content = []
        for block_str in block_list:
            try:
                block_data = json.loads(block_str)
                if block_data.get('Type') == 'message':
                    text = block_data.get('Data', {}).get('Text', '')
                    if text:
                        markdown_content.append(text)
            except Exception:
                continue

        full_markdown = '\n\n'.join(markdown_content)

        import re

        lines = full_markdown.split('\n')
        processed_lines = []
        for i, line in enumerate(lines):
            is_table_line = line.strip().startswith('|') and '|' in line

            prev_is_table = False
            if i > 0 and processed_lines:
                prev_line = processed_lines[-1]
                prev_is_table = prev_line.strip().startswith('|') and '|' in prev_line

            if is_table_line and not prev_is_table and processed_lines and processed_lines[-1].strip() != '':
                processed_lines.append('')

            processed_lines.append(line)

            if is_table_line and i < len(lines) - 1:
                next_line = lines[i + 1]
                next_is_table = next_line.strip().startswith('|') and '|' in next_line
                if not next_is_table and next_line.strip() != '':
                    processed_lines.append('')

        full_markdown = '\n'.join(processed_lines)

        md = markdown.Markdown(extensions=['extra', 'sane_lists', 'smarty'])
        rendered_html = md.convert(full_markdown)

        html_template = f"""<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <style>
        body {{
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, "Microsoft YaHei", sans-serif;
            line-height: 1.8;
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px;
            color: #333;
            background: #f9f9f9;
        }}
        .content {{
            background: white;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }}
        h1 {{
            color: #2c3e50;
            border-bottom: 3px solid #667eea;
            padding-bottom: 10px;
            margin-bottom: 30px;
        }}
        h2 {{
            color: #34495e;
            margin-top: 2em;
            margin-bottom: 1em;
            border-bottom: 2px solid #e0e0e0;
            padding-bottom: 8px;
        }}
        h3 {{
            color: #555;
            margin-top: 1.5em;
            margin-bottom: 0.8em;
        }}
        p {{
            margin: 1em 0;
            text-align: justify;
        }}
        code {{
            background: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: "Consolas", "Monaco", "Courier New", monospace;
            font-size: 0.9em;
            color: #e83e8c;
        }}
        pre {{
            background: #2d2d2d;
            color: #f8f8f2;
            padding: 1.5em;
            border-radius: 6px;
            overflow-x: auto;
            line-height: 1.5;
        }}
        pre code {{
            background: none;
            padding: 0;
            color: inherit;
            font-size: 0.95em;
        }}
        blockquote {{
            border-left: 4px solid #667eea;
            margin: 1.5em 0;
            padding: 0.5em 1em;
            background: #f8f9fa;
            color: #555;
        }}
        table {{
            border-collapse: collapse;
            width: 100%;
            margin: 2em 0;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            overflow: hidden;
            border-radius: 8px;
        }}
        thead {{
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }}
        th {{
            border: none;
            padding: 14px 16px;
            text-align: left;
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.9em;
            letter-spacing: 0.5px;
        }}
        td {{
            border: 1px solid #e0e0e0;
            padding: 12px 16px;
            text-align: left;
        }}
        tbody tr {{
            transition: background-color 0.2s;
        }}
        tbody tr:nth-child(odd) {{
            background: #ffffff;
        }}
        tbody tr:nth-child(even) {{
            background: #f8f9fa;
        }}
        tbody tr:hover {{
            background: #e3f2fd;
        }}
        ul, ol {{
            margin: 1em 0;
            padding-left: 2em;
        }}
        li {{
            margin: 0.5em 0;
        }}
        a {{
            color: #667eea;
            text-decoration: none;
        }}
        a:hover {{
            text-decoration: underline;
        }}
        img {{
            max-width: 100%;
            height: auto;
            border-radius: 4px;
            margin: 1em 0;
        }}
    </style>
</head>
<body>
    <div class="content">
        <h1>{title}</h1>
        {rendered_html}
    </div>
</body>
</html>"""

        return html_template
    except Exception as e:
        return f'<html><body><h1>{title}</h1><p>解析报告内容失败: {str(e)}</p></body></html>'


def download_file(jump_url, custom_headers, save_path):
    """下载文件到指定路径（优化版：使用连接池，更大的chunk_size）
返回: (success: bool, error_msg: str)
"""
    import time

    max_retries = 2
    session = get_optimized_session()

    for attempt in range(1, max_retries + 1):
        try:
            download_headers = {
                'Accept': '*/*',
                'Accept-Language': 'zh-CN,zh-Hans;q=0.9',
                'User-Agent': 'ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0'
            }

            if custom_headers:
                for key, value in custom_headers.items():
                    download_headers[key] = value

            response = session.get(
                jump_url,
                headers=download_headers,
                timeout=(10, 30),
                stream=True
            )

            response.raise_for_status()

            try:
                make_dirs(os.path.dirname(save_path))
            except Exception as e:
                return False, f'创建目录失败: {str(e)}'

            with open(fs_path(save_path), 'wb') as f:
                for chunk in response.iter_content(chunk_size=262144):
                    if not chunk:
                        continue
                    f.write(chunk)
            return True, ''

        except Exception as e:
            if attempt < max_retries:
                time.sleep(1)
            else:
                return False, str(e)

    return False, '下载失败'


def download_single_file(media_id, knowledge_base_id, save_dir, media_type=None,
                         media_type_info=None, file_size=0, update_time=0):
    """
下载单个文件（支持普通文件、笔记、IMA报告、网址、公众号文章）
返回: (success, message, file_path)
"""
    try:
        jump_url, custom_headers, title = get_media_url(media_id, knowledge_base_id)
        if not jump_url:
            return False, '获取下载URL失败', None

        safe_filename = sanitize_filename(title) if title else 'unknown'

        import re
        from urllib.parse import urlparse, unquote

        parsed_url = urlparse(jump_url)
        url_path = unquote(parsed_url.path)
        url_ext_match = re.search(r'\.([a-zA-Z0-9]+)(?:\?|$)', url_path)
        url_ext = f'.{url_ext_match.group(1)}' if url_ext_match else ''

        if url_ext and not safe_filename.endswith(url_ext):
            if '.' not in safe_filename or not safe_filename.split('.')[-1].isalnum():
                safe_filename += url_ext

        type_name = media_type_info.get('name', '') if media_type_info else ''

        if media_type == 11 and type_name == '笔记':
            from core.settings import get_setting

            note_format = get_setting('note_format', 'md')
            return download_note_file(media_id, knowledge_base_id, save_dir, jump_url, safe_filename, note_format)
        elif media_type == 2 and type_name == 'ima 报告':
            return download_report_file(jump_url, knowledge_base_id, save_dir, safe_filename)
        elif (media_type == 2 and type_name == '网址') or (media_type == 2 and type_name == '腾讯新闻') or (media_type == 6 and type_name == '公众号'):
            return download_url_file(jump_url, save_dir, safe_filename)
        else:
            return download_normal_file(jump_url, custom_headers, save_dir, safe_filename)
    except Exception as e:
        import traceback

        error_detail = f'异常: {str(e)}\n{traceback.format_exc()}'
        return False, error_detail, None


def download_normal_file(jump_url, custom_headers, save_dir, filename):
    """下载普通文件"""
    save_path = os.path.join(save_dir, filename)
    if file_exists(save_path):
        return True, '文件已存在', save_path

    success, error_msg = download_file(jump_url, custom_headers, save_path)
    if success:
        return True, '下载成功', save_path

    return False, f'下载失败: {error_msg}', None


def download_url_file(jump_url, save_dir, filename):
    """保存网址为可打开的 HTML 跳转文件。"""
    from html import escape

    if not filename.lower().endswith('.html'):
        filename += '.html'

    save_path = os.path.join(save_dir, filename)
    if file_exists(save_path):
        return True, '文件已存在', save_path

    url_safe = escape(jump_url, quote=True)
    title_safe = escape(filename[:-5] if filename[:-5] else '网址', quote=False)

    html_content = f"""<!doctype html>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta http-equiv="refresh" content="0; url={url_safe}">
  <title>{title_safe}</title>
  <style>
    body {{
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", "Microsoft YaHei", sans-serif;
      line-height: 1.6;
      max-width: 760px;
      margin: 48px auto;
      padding: 0 20px;
      color: #222;
    }}
    a {{ color: #1565c0; word-break: break-all; }}
  </style>
</head>
<body>
  <h1>{title_safe}</h1>
  <p>正在打开原始网址。如果没有自动跳转，请点击下面的链接：</p>
  <p><a href="{url_safe}" target="_blank" rel="noopener noreferrer">{url_safe}</a></p>
</body>
</html>
"""

    try:
        make_dirs(os.path.dirname(save_path))

        with open(fs_path(save_path), 'w', encoding='utf-8') as f:
            f.write(html_content)

        return True, '下载成功', save_path
    except Exception as e:
        return False, f'保存网址HTML失败: {str(e)}', None


def download_note_file(media_id, knowledge_base_id, save_dir, jump_url, filename, note_format='html'):
    """下载笔记文件（转换为HTML或Markdown）

Args:
    note_format: 'html' 或 'md'，默认为 'html'
"""
    from urllib.parse import urlparse, parse_qs

    try:
        parsed_url = urlparse(jump_url)
        params = parse_qs(parsed_url.query)
        docid = params.get('docid', [None])[0]
        if not docid:
            return False, '无法提取docid', None
    except Exception as e:
        return False, f'解析jump_url失败: {str(e)}', None

    ext = '.md' if note_format == 'md' else '.html'
    if not filename.endswith(ext):
        filename += ext
    save_path = os.path.join(save_dir, filename)
    if file_exists(save_path):
        return True, '文件已存在', save_path

    content_json, note_title, link_map = get_note_content(docid, knowledge_base_id)
    if not content_json:
        error_msg = link_map if isinstance(link_map, str) and link_map else '未知原因'
        return False, f'获取note内容失败: {error_msg}', None

    if note_title:
        filename = sanitize_filename(note_title)
        if not filename.endswith(ext):
            filename += ext
        save_path = os.path.join(save_dir, filename)

    if note_format == 'md':
        content = parse_note_content_to_md(content_json, note_title or filename, link_map)
    else:
        content = parse_note_content_to_html(content_json, note_title or filename, link_map)

    try:
        make_dirs(os.path.dirname(save_path))
    except Exception as e:
        return False, f'创建目录失败: {str(e)}', None

    try:
        with open(fs_path(save_path), 'w', encoding='utf-8') as f:
            f.write(content)

        return True, '下载成功', save_path
    except Exception as e:
        return False, f'保存文件失败: {str(e)}', None


def download_report_file(jump_url, knowledge_base_id, save_dir, filename):
    """下载IMA报告文件（转换为HTML）"""
    from urllib.parse import urlparse, parse_qs

    try:
        parsed_url = urlparse(jump_url)
        params = parse_qs(parsed_url.query)
        report_id = params.get('reportId', [None])[0]
        if not report_id:
            return False, '无法提取reportId', None
    except Exception as e:
        return False, f'解析jump_url失败: {str(e)}', None

    title, block_list = get_report_content(report_id, knowledge_base_id)
    if not title or not block_list:
        return False, '获取报告内容失败', None

    html_content = parse_report_to_html(title, block_list)

    if not filename.endswith('.html'):
        filename += '.html'
    save_path = os.path.join(save_dir, filename)
    if file_exists(save_path):
        return True, '文件已存在', save_path

    try:
        make_dirs(os.path.dirname(save_path))
        with open(fs_path(save_path), 'w', encoding='utf-8') as f:
            f.write(html_content)

        return True, '下载成功', save_path
    except Exception as e:
        return False, f'保存文件失败: {str(e)}', None


# ============================================================================
# 重建不确定性说明 (uncertainties):
# 1. 源码排版(缩进内的空行/换行宽度)为推断; 所有语句、常量、参数名与字节码一致。
# 2. sanitize_filename 中的非法字符正则, .pyc 常量为 [\\/:*?"<>|：""《》？｜＊] ——
#    全角冒号后是两个 ASCII 双引号 0x22 0x22(十六进制核验 dis 行448, 类内重复项)。
#    [1019对抗审计修正] 初版误还原为全角弯引号 “”(U+201C/U+201D), 会错误剔除文件名
#    中的弯引号, 已改回 ASCII 引号与字节码严格一致。
# 3. _SPECIAL_CHARS_RE 的原始写法可能使用了 \U0001FFFF/​ 等转义形式;
#    本文件按等效字符(部分零宽字符为字面量)还原, 语义一致。
# 4. download_single_file 的 media_type 分发: 11=笔记, 2=ima 报告/网址/腾讯新闻,
#    6=公众号, 其余走普通文件下载; 条件组合顺序与字节码跳转表一一对应。
# 5. get_note_content 中 link_map 构建: 同时按完整 base_url 和去查询串的 base_path
#    两个键写入 signed_url (字节码 546-548 行为顺序两条 STORE_SUBSCR)。
# 6. f-string 与 .format()/百分号格式在字节码中难以完全区分(FORMAT_SIMPLE 均按
#    f-string 还原); BUILD_STRING 序列的静态片段与插值顺序已逐一对齐。
# 7. make_request_with_retry 内 `from core.config import load_cookie_from_cache`
#    导入后未使用(字节码仅 STORE_FAST), 按原样保留。
# ============================================================================
