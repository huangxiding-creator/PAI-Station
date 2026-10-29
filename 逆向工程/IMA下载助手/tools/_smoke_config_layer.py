# -*- coding: utf-8 -*-
"""Behavioral smoke test for rebuilt config_layer.py against dis-derived semantics."""
import sys, types, importlib.util

SRC = r'E:/AI-Station/逆向工程/IMA下载助手/src_rebuilt/core/config_layer.py'

spec = importlib.util.spec_from_file_location('config_layer', SRC)
m = importlib.util.module_from_spec(spec)
spec.loader.exec_module(m)
print('IMPORT OK')

C, CM = m.Config, m.ConfigManager

# ---- Config static ----
assert C.BASE_URL == 'https://imaima.iepose.cn'
assert C.API_ENDPOINTS == {
    'activate': '/api/v1/activate', 'verify': '/api/v1/verify',
    'quota_issue': '/api/v1/quota/issue_token', 'quota_refund': '/api/v1/quota/refund',
    'renew': '/api/v1/renew', 'version_check': '/api/version/check'}
assert C.SERVER_PUBLIC_KEY.startswith('-----BEGIN PUBLIC KEY-----\nMCowBQYDK2VwAyEAL7EUTOqGayZQ2QYFZwoaUh+aVNrQ7pblqRCqVvPBoZA=\n-----END PUBLIC KEY-----')
assert C.LICENSE_FILE == 'license.enc' and C.DB_FILE == 'download.db'
assert C.VERSION == '1.7.1' and C.BUILD_DATE == '2026-06-04'
assert (C.DOWNLOAD_DELAY_MIN, C.DOWNLOAD_DELAY_MAX, C.REQUEST_TIMEOUT, C.MAX_RETRIES) == (1, 3, 15, 3)
assert (C.TOKEN_VALID_TIME, C.REFRESH_TOKEN_VALID_TIME, C.TOKEN_REFRESH_ADVANCE) == (7200, 2592000, 300)
assert C.get_api_url('activate') == 'https://imaima.iepose.cn/api/v1/activate'
assert C.get_api_url('unknown_ep') == 'https://imaima.iepose.cn/api/unknown_ep'
assert m.config.__class__ is C and m.BASE_URL == C.BASE_URL and m.VERSION == '1.7.1' and m.BUILD_DATE == '2026-06-04'
print('Config static OK')

# ---- singleton ----
mgr = m.get_config_manager()
assert mgr is m.get_config() and mgr is m.get_config_manager()
assert mgr._config_class is not None  # local fallback engaged (no external config.py here)
assert mgr.base_url == 'https://imaima.iepose.cn'
assert mgr.get_api_url('verify') == 'https://imaima.iepose.cn/api/v1/verify'
assert mgr.server_public_key_pem == C.SERVER_PUBLIC_KEY.strip()
assert mgr.version == '1.7.1' and mgr.build_date == '2026-06-04'
assert (mgr.download_delay_min, mgr.download_delay_max, mgr.request_timeout, mgr.max_retries) == (1, 3, 15, 3)
assert (mgr.token_valid_time, mgr.refresh_token_valid_time, mgr.token_refresh_advance) == (7200, 2592000, 300)
assert isinstance(mgr.license_file, str) and mgr.license_file.endswith('license.enc')
assert isinstance(mgr.db_file, str) and mgr.db_file.endswith('download.db')
assert isinstance(mgr.default_download_dir, str) and len(mgr.default_download_dir) > 0
print('Singleton + static props OK')

# ---- config_pack not loaded ----
try:
    mgr.get_config_pack()
    raise SystemExit('FAIL: no RuntimeError')
except RuntimeError as e:
    assert str(e) == '配置包未加载，请先完成授权验证'
print('get_config_pack guard OK')

# ---- config_pack getters ----
pack = {
    'base_url': 'https://ima.example.com',
    'endpoints': {
        'search': {'path': '/api/v1/search', 'method': 'get'},
        'odd': {},
    },
    'timeout': {'connect': 5, 'read': 60},
    'retry': {'max_retries': 4, 'backoff': 2},
    'wechat_api_url': 'https://wx.example.com/api',
    'app_cookie_fields': {'a': '1'},
    'headers_template': {'User-Agent': 'tpl-ua', 'From_browser_ima': 'custom'},
}
mgr.set_config_pack(pack)
assert mgr.get_config_pack() is pack
assert mgr.get_ima_base_url() == 'https://ima.example.com'
pack2 = dict(pack)
pack2.pop('base_url')
pack2['ima_base_url'] = 'https://fallback.example.com'
mgr.set_config_pack(pack2)
assert mgr.get_ima_base_url() == 'https://fallback.example.com'
assert mgr.get_endpoint_url('search') == 'https://fallback.example.com/api/v1/search'
assert mgr.get_endpoint_url('missing') is None
assert mgr.get_endpoint_url('odd') == 'https://fallback.example.com'
assert mgr.get_endpoint_method('search') == 'GET'
assert mgr.get_endpoint_method('odd') == 'POST'
assert mgr.get_timeout() == (5, 60)
mgr.set_config_pack({'timeout': {}})
assert mgr.get_timeout() == (15, 90)
mgr.set_config_pack(pack)
assert mgr.get_retry_config() == {'max_retries': 4, 'backoff': 2}
assert mgr.get_retry_config() == mgr.get_config_pack().get('retry', {})
assert mgr.get_wechat_api_url() == 'https://wx.example.com/api'
assert mgr.get_app_cookie_fields() == {'a': '1'}
mgr.set_config_pack({'dummy': 1})  # 非空但缺 app_cookie_fields 键
assert mgr.get_app_cookie_fields() == {}  # default when absent
assert mgr.get_wechat_api_url() is None  # get 无默认值
assert mgr.get_retry_config() == {}
try:
    mgr.get_config_pack.__self__  # noop
except AttributeError:
    pass
mgr2_chk = m.ConfigManager()
mgr2_chk.set_config_pack({})  # 空 dict 为假值 -> get_config_pack 必须抛 RuntimeError
try:
    mgr2_chk.get_config_pack()
    raise SystemExit('FAIL: empty-dict pack should raise')
except RuntimeError:
    pass
print('config_pack getters OK')

# ---- headers build ----
mgr.set_config_pack(pack)
h = mgr.build_headers_with_cookie('BKN123', 'CK=1')
assert h == {'User-Agent': 'tpl-ua', 'From_browser_ima': 'custom', 'X-Ima-Bkn': 'BKN123', 'X-Ima-Cookie': 'CK=1'}
h2 = mgr.build_headers_with_cookie()  # 模板已含 From_browser_ima=custom，setdefault 不覆盖
assert h2 == {'User-Agent': 'tpl-ua', 'From_browser_ima': 'custom'}
mgr.set_config_pack({'headers_template': {'User-Agent': 'tpl-ua'}})
h2b = mgr.build_headers_with_cookie()  # 模板缺键时 setdefault 写入 '1'
assert h2b == {'User-Agent': 'tpl-ua', 'From_browser_ima': '1'}
mgr.set_config_pack(pack)
h3 = mgr.build_headers_with_cookie('BKN2', None)
assert h3 == {'User-Agent': 'tpl-ua', 'From_browser_ima': 'custom', 'X-Ima-Bkn': 'BKN2'}
assert mgr.get_headers() is mgr._headers
mgr.set_headers({'X': 'y'})
assert mgr.get_headers() == {'X': 'y'}
print('headers OK')

# ---- stub data.database / services.token_refresh_service ----
calls = {}
data_pkg = types.ModuleType('data')
db = types.ModuleType('data.database')


def save_login_credentials(bkn, cookie_value, user_id, token, refresh_token, tvt, rtvt):
    calls['save'] = (bkn, cookie_value, user_id, token, refresh_token, tvt, rtvt)


def get_login_credentials():
    return calls.get('creds')


def get_user_setting(key, default=None):
    return ('u', key, default)


def set_user_setting(key, value):
    calls['set'] = (key, value)


def get_all_user_settings():
    return {'k': 'v'}


db.save_login_credentials = save_login_credentials
db.get_login_credentials = get_login_credentials
db.get_user_setting = get_user_setting
db.set_user_setting = set_user_setting
db.get_all_user_settings = get_all_user_settings
data_pkg.database = db
sys.modules['data'] = data_pkg
sys.modules['data.database'] = db

svc = types.ModuleType('services')
trs = types.ModuleType('services.token_refresh_service')
trs.check_and_refresh_token = lambda: calls.__setitem__('refreshed', calls.get('refreshed', 0) + 1)
svc.token_refresh_service = trs
sys.modules['services'] = svc
sys.modules['services.token_refresh_service'] = trs

# user settings
assert mgr.get_user_setting('lang', 'zh') == ('u', 'lang', 'zh')
assert mgr.get_user_setting('lang') == ('u', 'lang', None)
assert mgr.set_user_setting('a', 'b') is True and calls['set'] == ('a', 'b')
assert mgr.get_all_user_settings() == {'k': 'v'}

# set_cookie
mgr.set_cookie('B1', 'C1')
assert calls['save'] == ('B1', 'C1', None, None, None, 7200, 2592000)
assert mgr._headers['X-Ima-Bkn'] == 'B1' and mgr._headers['X-Ima-Cookie'] == 'C1'
mgr.set_cookie('B2', 'C2', 'u9', 'tk', 'rtk', 100, 200)
assert calls['save'] == ('B2', 'C2', 'u9', 'tk', 'rtk', 100, 200)


def boom(*a):
    raise ValueError('db down')


db.save_login_credentials = boom
mgr.set_cookie('B3', 'C3')  # except Exception: pass -> headers still built
assert mgr._headers['X-Ima-Bkn'] == 'B3'
db.save_login_credentials = save_login_credentials
print('set_cookie OK')

# load_cookie_from_cache paths
calls['creds'] = {'bkn': 'KB', 'cookie': 'KC'}
assert mgr.load_cookie_from_cache() is True and calls['refreshed'] == 1
assert mgr._headers['X-Ima-Bkn'] == 'KB'
calls['creds'] = None
assert mgr.load_cookie_from_cache() is False
mgr2 = m.ConfigManager()
mgr2.set_config_pack(None)  # no pack -> build_headers raises RuntimeError -> fallback headers
calls['creds'] = {'bkn': 'FB', 'cookie': 'FC'}
assert mgr2.load_cookie_from_cache() is True
assert mgr2._headers == {
    'Accept': '*/*', 'Content-Type': 'application/json',
    'X-Ima-Bkn': 'FB', 'X-Ima-Cookie': 'FC',
    'User-Agent': 'ima/4032 CFNetwork/3860.300.31 Darwin/25.2.0'}


def raise_os():
    raise OSError('net')


trs.check_and_refresh_token = raise_os
assert mgr.load_cookie_from_cache() is False  # outer except Exception -> False
trs.check_and_refresh_token = lambda: None


def raise_val():
    raise ValueError('x')


db.get_login_credentials = raise_val
assert mgr.get_cookie() == {}
db.get_login_credentials = get_login_credentials
assert mgr.get_cookie() == {'bkn': 'FB', 'cookie': 'FC'}  # 最后一次设置的缓存凭据
calls['creds'] = None
assert mgr.get_cookie() == {}
print('load_cookie_from_cache / get_cookie OK')

print('ALL SMOKE TESTS PASSED')
