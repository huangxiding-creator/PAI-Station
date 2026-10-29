# -*- coding: utf-8 -*-
"""
配置层重建（ConfigManager + Config 静态配置类）

重建来源（CPython 3.13 .pyc → dis 反汇编，逐函数手工重建）：
  1. core/config_manager.pyc → dump/core_config_manager.dis.txt + core_config_manager.summary.txt
     原始源文件: core/config_manager.py （原类定义起始行 13，模块尾 get_config_manager=295 / get_config=304）
  2. config.pyc → dump/config.dis.txt + config.summary.txt
     原始源文件: config.py （原类定义起始行 10，模块尾语句 146-152）

置信度：高。
  - 全部函数/方法名、参数名、默认值、docstring、字符串常量均直接取自 co_consts/co_varnames/反汇编；
  - 控制流（if/or/not in/try-except 嵌套/异常表）逐跳转核对；
  - config_pack 读取键名结构逐键核对（见下方「config_pack 键结构」注记）。
不确定点（见文件尾 uncertainties 对照）：
  - 原始注释与空行排版不可恢复（本文件注释为重建注记）；
  - 两模块合并为单文件，原始行号未逐一复刻；
  - _load_config 的 except 分支为适配单文件部署加了本地回退（原始语义见该处注释）。

==============================================================
【重建注记：config_pack 键结构】（由 ConfigManager 各 getter 字节码逐键恢复）
==============================================================
config_pack 为授权验证后服务器下发、存于内存的 dict，读取侧结构如下：
  base_url            -> str                      （get_ima_base_url 主键；为空时回退读 'ima_base_url'）
  ima_base_url        -> str                      （base_url 为空时的备用键，or 链回退）
  endpoints           -> dict[str, dict]          （get_endpoint_url / get_endpoint_method）
      <endpoint_name>     -> {'path': str(默认''), 'method': str(默认'POST'，取值后 .upper())}
                            endpoint_name 不在 endpoints 中时 get_endpoint_url 返回 None
  timeout             -> dict                     （get_timeout；返回 (connect, read) 元组）
      connect             -> int（默认 15）
      read                -> int（默认 90）
  retry               -> dict                     （get_retry_config，原样整体返回）
  wechat_api_url      -> str                      （get_wechat_api_url，get 无默认值）
  app_cookie_fields   -> dict（默认 {}）           （get_app_cookie_fields）
  headers_template    -> dict（默认 {}）           （build_headers_with_cookie，先 .copy() 再 setdefault）

构建请求头（build_headers_with_cookie）固定注入：
  'From_browser_ima': '1'（setdefault，仅键不存在时写入）
  'X-Ima-Bkn':  cookie_bkn   （cookie_bkn  为真值时覆写）
  'X-Ima-Cookie': cookie_value（cookie_value 为真值时覆写）
RuntimeError 兜底头（load_cookie_from_cache 内，配置包未加载时）：
  Accept: */* ; Content-Type: application/json ; X-Ima-Bkn / X-Ima-Cookie 取缓存凭据 ;
  User-Agent: ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0
"""

import os
import sys
from pathlib import Path


# =====================================================================
# 第一部分：config.py 重建（静态配置类 + 模块级别名）
# 原始文件头 docstring：
#   "\nIMA Client 配置文件\n\n客户端只应保存公开配置和服务端验签公钥，不得保存共享秘密。\n"
# =====================================================================

class Config:
    """应用配置类"""

    # 服务器基础URL（原行15）
    BASE_URL = 'https://imaima.iepose.cn'

    # API端点定义（原行18-24，dict 字面量位于原行18）
    API_ENDPOINTS = {
        'activate': '/api/v1/activate',
        'verify': '/api/v1/verify',
        'quota_issue': '/api/v1/quota/issue_token',
        'quota_refund': '/api/v1/quota/refund',
        'renew': '/api/v1/renew',
        'version_check': '/api/version/check',
    }

    # 授权文件名（原行29）
    LICENSE_FILE = 'license.enc'

    # 服务端ED25519验签公钥（PEM，原行31）
    SERVER_PUBLIC_KEY = (
        '-----BEGIN PUBLIC KEY-----\n'
        'MCowBQYDK2VwAyEAL7EUTOqGayZQ2QYFZwoaUh+aVNrQ7pblqRCqVvPBoZA=\n'
        '-----END PUBLIC KEY-----'
    )

    # 数据库文件名（原行36）
    DB_FILE = 'download.db'

    # 应用版本号（原行38）
    VERSION = '1.7.1'

    # 构建日期（原行41）
    BUILD_DATE = '2026-06-04'

    # 默认下载目录（相对或绝对路径，原行45）
    DEFAULT_DOWNLOAD_DIR = 'download'

    # 下载延迟（秒）：最小/最大（原行49/50）
    DOWNLOAD_DELAY_MIN = 1
    DOWNLOAD_DELAY_MAX = 3

    # 请求超时时间（秒，原行53）
    REQUEST_TIMEOUT = 15

    # 最大重试次数（原行56）
    MAX_RETRIES = 3

    # Token / Refresh Token 有效期与提前刷新时间（秒，原行60/63/66）
    TOKEN_VALID_TIME = 7200
    REFRESH_TOKEN_VALID_TIME = 2592000
    TOKEN_REFRESH_ADVANCE = 300

    @classmethod
    def get_api_url(cls, endpoint):
        """获取完整的API URL

        Args:
            endpoint: API端点名称 (activate, verify, quota_issue, renew, version_check)

        Returns:
            str: 完整的API URL
        """
        path = cls.API_ENDPOINTS.get(endpoint, f'/api/{endpoint}')
        return f'{cls.BASE_URL}{path}'

    @classmethod
    def get_base_dir(cls):
        """获取应用基础目录

        Returns:
            str: 应用基础目录路径
        """
        import sys
        if getattr(sys, 'frozen', False):
            if sys.platform == 'darwin':
                user_dir = Path.home() / 'imahelper'
                os.makedirs(user_dir, exist_ok=True)
                base_dir = str(user_dir)
            else:
                appdata = os.environ.get('APPDATA', os.path.expanduser('~'))
                base_dir = os.path.join(appdata, 'imahelper')
                os.makedirs(base_dir, exist_ok=True)
        else:
            base_dir = os.path.dirname(os.path.abspath(__file__))
        return base_dir

    @classmethod
    def get_license_file_path(cls):
        """获取授权文件完整路径

        Returns:
            str: 授权文件路径
        """
        return os.path.join(cls.get_base_dir(), cls.LICENSE_FILE)

    @classmethod
    def get_db_file_path(cls):
        """获取数据库文件完整路径

        Returns:
            str: 数据库文件路径
        """
        return os.path.join(cls.get_base_dir(), cls.DB_FILE)

    @classmethod
    def get_log_file_path(cls):
        # 原实现无 docstring（co_consts[0] = None）
        return os.path.join(cls.get_base_dir(), 'log.txt')

    @classmethod
    def get_crash_log_file_path(cls):
        # 原实现无 docstring（co_consts[0] = None）
        return os.path.join(cls.get_base_dir(), 'crash.log')

    @classmethod
    def get_default_download_dir(cls):
        """获取解析后的默认下载目录"""
        default_dir = cls.DEFAULT_DOWNLOAD_DIR or 'download'
        if not os.path.isabs(default_dir):
            default_dir = os.path.join(cls.get_base_dir(), default_dir)
        os.makedirs(default_dir, exist_ok=True)
        return default_dir


# --- config.py 模块级尾语句（原行146-152）---
config = Config()
BASE_URL = Config.BASE_URL
VERSION = Config.VERSION
BUILD_DATE = Config.BUILD_DATE


# =====================================================================
# 第二部分：core/config_manager.py 重建（统一配置管理器 + 单例访问函数）
# 原始模块 docstring：
#   "统一配置管理模块\n\n配置层次：\n1. 静态配置 - config.py 文件中的配置（系统配置）\n
#    2. 用户设置 - SQLite数据库中的设置（可在运行时修改）\n3. 运行时配置 - 内存中的配置包（从服务器下发）\n"
# =====================================================================

class ConfigManager:
    """统一配置管理器"""

    def __init__(self):
        self._config_class = None
        self._config_pack = None
        self._headers = {}
        self._load_config()

    def _load_config(self):
        """加载配置类"""
        try:
            from config import Config
            self._config_class = Config
        except ImportError:
            # 【重建适配】原始字节码此处为：
            #     except ImportError as e:
            #         raise ImportError(f'无法加载配置文件 config.py: {e}')
            # 原工程中 Config 位于独立顶层 config.py；本单文件重建版已将 Config
            # 内联于上方，故回退使用本文件内的定义（经 globals() 取模块级类，
            # 因上方 import 语句中的 Config 是函数局部名，导入失败后未绑定），
            # 使本模块可脱离原工程目录独立运行。
            self._config_class = globals()['Config']

    @property
    def _config(self):
        """获取配置类"""
        if self._config_class is None:
            self._load_config()
        return self._config_class

    @property
    def base_url(self):
        """服务器基础URL"""
        return self._config.BASE_URL

    def get_api_url(self, endpoint):
        """获取完整的API URL

        Args:
            endpoint: API端点名称 (activate, verify, quota_issue, renew, version_check)
        """
        return self._config.get_api_url(endpoint)

    @property
    def license_file(self):
        """授权文件路径"""
        path = self._config.get_license_file_path()
        return path

    @property
    def server_public_key_pem(self):
        """服务端ED25519公钥"""
        return self._config.SERVER_PUBLIC_KEY.strip()

    @property
    def db_file(self):
        """数据库文件路径"""
        return self._config.get_db_file_path()

    @property
    def version(self):
        """应用版本号"""
        return self._config.VERSION

    @property
    def build_date(self):
        """构建日期"""
        return self._config.BUILD_DATE

    @property
    def default_download_dir(self):
        """默认下载目录"""
        return self._config.get_default_download_dir()

    @property
    def download_delay_min(self):
        """最小下载延迟（秒）"""
        return self._config.DOWNLOAD_DELAY_MIN

    @property
    def download_delay_max(self):
        """最大下载延迟（秒）"""
        return self._config.DOWNLOAD_DELAY_MAX

    @property
    def request_timeout(self):
        """请求超时时间（秒）"""
        return self._config.REQUEST_TIMEOUT

    @property
    def max_retries(self):
        """最大重试次数"""
        return self._config.MAX_RETRIES

    @property
    def token_valid_time(self):
        """Token有效期（秒）"""
        return self._config.TOKEN_VALID_TIME

    @property
    def refresh_token_valid_time(self):
        """Refresh Token有效期（秒）"""
        return self._config.REFRESH_TOKEN_VALID_TIME

    @property
    def token_refresh_advance(self):
        """Token提前刷新时间（秒）"""
        return self._config.TOKEN_REFRESH_ADVANCE

    def get_user_setting(self, key, default=None):
        """获取用户设置

        Args:
            key: 设置键名
            default: 默认值
        """
        try:
            from data.database import get_user_setting
            return get_user_setting(key, default)
        except Exception:
            return default

    def set_user_setting(self, key, value):
        """保存用户设置

        Args:
            key: 设置键名
            value: 设置值
        """
        try:
            from data.database import set_user_setting
            set_user_setting(key, value)
            return True
        except Exception:
            return False

    def get_all_user_settings(self):
        """获取所有用户设置"""
        try:
            from data.database import get_all_user_settings
            return get_all_user_settings()
        except Exception:
            return {}

    def set_config_pack(self, config_pack):
        """设置配置包（从服务器下发）"""
        self._config_pack = config_pack

    def get_config_pack(self):
        """获取配置包"""
        if not self._config_pack:
            raise RuntimeError('配置包未加载，请先完成授权验证')
        return self._config_pack

    def get_ima_base_url(self):
        """获取IMA基础URL（从配置包）"""
        return self.get_config_pack().get('base_url') or self.get_config_pack().get('ima_base_url')

    def get_endpoint_url(self, endpoint_name):
        """获取IMA接口URL（从配置包），endpoint不存在时返回None"""
        config = self.get_config_pack()
        endpoints = config.get('endpoints', {})
        if endpoint_name not in endpoints:
            return None
        path = endpoints[endpoint_name].get('path', '')
        return f'{self.get_ima_base_url()}{path}'

    def get_endpoint_method(self, endpoint_name):
        """获取IMA接口HTTP方法（从配置包），默认POST"""
        config = self.get_config_pack()
        endpoint = config.get('endpoints', {}).get(endpoint_name, {})
        return endpoint.get('method', 'POST').upper()

    def get_timeout(self):
        """获取超时配置（从配置包）"""
        timeout = self.get_config_pack().get('timeout', {})
        return (timeout.get('connect', 15), timeout.get('read', 90))

    def get_retry_config(self):
        """获取重试配置（从配置包）"""
        return self.get_config_pack().get('retry', {})

    def get_wechat_api_url(self):
        """获取微信API URL（从配置包）"""
        return self.get_config_pack().get('wechat_api_url')

    def get_app_cookie_fields(self):
        """获取App Cookie固定字段（从配置包）"""
        return self.get_config_pack().get('app_cookie_fields', {})

    def set_headers(self, headers):
        """设置请求头"""
        self._headers = headers

    def get_headers(self):
        """获取请求头"""
        return self._headers

    def build_headers_with_cookie(self, cookie_bkn=None, cookie_value=None):
        """构建请求头"""
        headers = self.get_config_pack().get('headers_template', {}).copy()
        headers.setdefault('From_browser_ima', '1')
        if cookie_bkn:
            headers['X-Ima-Bkn'] = cookie_bkn
        if cookie_value:
            headers['X-Ima-Cookie'] = cookie_value
        return headers

    def set_cookie(self, bkn, cookie_value, user_id=None, token=None,
                   refresh_token=None, token_valid_time=7200,
                   refresh_token_valid_time=2592000):
        """设置Cookie并保存到数据库"""
        from data.database import save_login_credentials
        try:
            save_login_credentials(
                bkn, cookie_value,
                user_id, token,
                refresh_token,
                token_valid_time, refresh_token_valid_time
            )
        except Exception:
            pass
        self._headers = self.build_headers_with_cookie(bkn, cookie_value)

    def load_cookie_from_cache(self):
        """从数据库加载Cookie，并自动刷新过期的token"""
        from data.database import get_login_credentials
        from services.token_refresh_service import check_and_refresh_token

        try:
            check_and_refresh_token()

            cache_data = get_login_credentials()
            if not cache_data:
                return False

            try:
                self._headers = self.build_headers_with_cookie(
                    cache_data['bkn'],
                    cache_data['cookie']
                )
            except RuntimeError:
                # 配置包未加载（get_config_pack 抛 RuntimeError）时的兜底静态请求头
                self._headers = {
                    'Accept': '*/*',
                    'Content-Type': 'application/json',
                    'X-Ima-Bkn': cache_data['bkn'],
                    'X-Ima-Cookie': cache_data['cookie'],
                    'User-Agent': 'ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0',
                }

            return True
        except Exception:
            return False

    def get_cookie(self):
        """获取Cookie缓存"""
        from data.database import get_login_credentials
        try:
            cache_data = get_login_credentials()
            return cache_data if cache_data else {}
        except Exception:
            return {}


# 模块级单例（原行292：_config_manager = None）
_config_manager = None


def get_config_manager():
    """获取配置管理器单例"""
    global _config_manager
    if _config_manager is None:
        _config_manager = ConfigManager()
    return _config_manager


def get_config():
    """获取配置管理器"""
    return get_config_manager()
