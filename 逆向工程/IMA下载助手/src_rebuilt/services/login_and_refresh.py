# -*- coding: utf-8 -*-
"""
重建源码：IMA下载助手 —— 登录服务 + Token自动刷新服务
======================================================

重建来源（CPython 3.13 .pyc 字节码逆向，非原始源文件）：
  - services/login_service.pyc         反汇编: dump/services_login_service.dis.txt
  - services/token_refresh_service.pyc 反汇编: dump/services_token_refresh_service.dis.txt

重建方法：
  逐函数按 CPython 3.13 dis 输出重建。LOAD_CONST 恢复全部字符串/数值常量；
  ExceptionTable + POP_JUMP_*/JUMP_BACKWARD/FOR_ITER 恢复 try/except 与循环控制流；
  CALL_KW 的 kw_names 元组恢复关键字实参；BUILD_CONST_KEY_MAP / BUILD_MAP+MAP_ADD
  恢复字典字面量；co_varnames[:co_argcount] 恢复参数名；co_consts[0] 恢复 docstring。

整体置信度：高（约 95%）
  - 请求 URL / headers 全部字段值 / JSON body 字段 / 超时秒数 / 响应解析键路径：
    逐条来自 LOAD_CONST 与指令序列，置信度极高
  - 控制流（if/elif 链、and 短路、循环、异常分支顺序）：逐跳转核对
  - 函数签名、类名、方法名、docstring：原文恢复
  - 已用本地 Python 3.13.1 对本重建做「重编译 + 指令流逐条 diff」验证，
    两个模块全部函数的 (opname, argrepr) 序列与原始反汇编一致
  - 具体不确定点见文件末尾「重建不确定点」

外部依赖（仅 import 调用，不在此实现，见原工程其他模块）：
  core.config.set_cookie
  utils.bkn.calculate_bkn / utils.bkn.get_timestamp
  data.database.get_login_credentials / is_token_expired / is_refresh_token_expired / update_token
"""

import requests
import re

from core.config import set_cookie
from utils.bkn import calculate_bkn, get_timestamp
from data.database import (
    get_login_credentials,
    is_token_expired,
    is_refresh_token_expired,
    update_token,
)


# =====================================================================
# 【第一节】原 services/login_service.py
#   原模块 docstring: "IMA登录模块 - 微信扫码登录"
#   原模块头部: import requests / import re /
#               from core.config import set_cookie /
#               from utils.bkn import calculate_bkn
#   原行号: class WeChatQRLogin=L6, __init__=L7, get_qr_uuid=L34,
#           get_qr_code_image=L60, check_scan_status=L73,
#           generate_ima_cookie=L117, login=L133
# =====================================================================

class WeChatQRLogin:

    def __init__(self):
        self.appid = 'wx0d63f5de059f1d52'
        self.redirect_uri = 'https://ima.qq.com/login/#/qr-code-scanned/'
        self.auth_appid = 'wx0d63f5de059f1d52'
        self.guid = 'guid-ca2055bffb9236ba0dea970403000002519701'
        self.qimei36 = 'ca2055bffb9236ba0dea970403000002519701'

        self.fixed_cookie_fields = {
            'IMA-GUID': 'guid-ca2055bffb9236ba0dea970403000002519701',
            'IMA-Q36': 'ca2055bffb9236ba0dea970403000002519701',
            'UID-TYPE': '2',
            'CLIENT-TYPE': '256002',
            'APP-VERSION': '2.2.4.4069',
            'IMA-TOKEN-TYPE': 'idcTokenImatokenBindSocial',
            'IMA-IUA': 'PR=IMA&PP=com.tencent.imaios&PPVN=2.2.4.4069&PL=IOS&RL=440.0*956.0&MO=iPhone18,2&OS=18.2&DN=iPhone18,2',
        }

        self.headers = {
            'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36',
            'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            'Accept-Language': 'zh-CN,zh;q=0.9',
        }

        self.uuid = None
        self.wx_code = None

    def get_qr_uuid(self):
        """获取二维码UUID"""
        url = 'https://open.weixin.qq.com/connect/qrconnect'

        params = {
            'appid': self.appid,
            'scope': 'snsapi_login',
            'redirect_uri': self.redirect_uri,
            'state': '',
            'login_type': 'jssdk',
            'self_redirect': 'true',
            'style': 'dark',
            'stylelite': '1',
        }

        try:
            response = requests.get(url, params=params, headers=self.headers, timeout=10)
            response.raise_for_status()

            match = re.search('/connect/qrcode/([^"]+)', response.text)
            if match:
                self.uuid = match.group(1)
                return self.uuid
            return None
        except Exception:
            return None

    def get_qr_code_image(self):
        """获取二维码图片数据"""
        if not self.uuid:
            return None

        url = f'https://open.weixin.qq.com/connect/qrcode/{self.uuid}'

        try:
            response = requests.get(url, headers=self.headers, timeout=10)
            response.raise_for_status()
            return response.content
        except Exception:
            return None

    def check_scan_status(self, timeout=(3, 2)):
        """检查扫码状态（单次检查）"""
        if not self.uuid:
            return None

        url = 'https://lp.open.weixin.qq.com/connect/l/qrconnect'

        headers = {
            'User-Agent': self.headers['User-Agent'],
            'Accept': '*/*',
            'Referer': 'https://open.weixin.qq.com/',
        }

        try:
            params = {'uuid': self.uuid}

            response = requests.get(
                url,
                params=params,
                headers=headers,
                timeout=timeout
            )
            response.raise_for_status()

            errcode_match = re.search(r'window\.wx_errcode=(\d+)', response.text)
            code_match = re.search(r"window\.wx_code='([^']*)'", response.text)

            if errcode_match:
                errcode = errcode_match.group(1)
                if errcode == '405' and code_match:
                    self.wx_code = code_match.group(1)
                    return 'success'
                if errcode in ('408', '404'):
                    return 'waiting'
                if errcode == '403':
                    return 'expired'

                return 'waiting'
            return 'waiting'
        except requests.exceptions.Timeout:
            # 原文 L113 处存在一行不可恢复内容（注释或空行）
            return 'waiting'
        except requests.exceptions.RequestException:
            return 'error'

    def generate_ima_cookie(self, user_id, token, refresh_token):
        """生成 x-ima-cookie 字段"""
        cookie_parts = [
            f"IMA-GUID={self.fixed_cookie_fields['IMA-GUID']}",
            f"IMA-Q36={self.fixed_cookie_fields['IMA-Q36']}",
            f'IMA-UID={user_id}',
            f'IMA-TOKEN={token}',
            f"UID-TYPE={self.fixed_cookie_fields['UID-TYPE']}",
            f"CLIENT-TYPE={self.fixed_cookie_fields['CLIENT-TYPE']}",
            f"APP-VERSION={self.fixed_cookie_fields['APP-VERSION']}",
            f"IMA-TOKEN-TYPE={self.fixed_cookie_fields['IMA-TOKEN-TYPE']}",
            f"IMA-IUA={self.fixed_cookie_fields['IMA-IUA']}",
            f'IMA-REFRESH-TOKEN={refresh_token}',
        ]
        return ';'.join(cookie_parts)

    def login(self):
        """执行登录请求"""
        if not self.wx_code:
            return (False, '未获取到扫码授权码')

        url = 'https://ima.qq.com/cgi-bin/auth_login/login'

        headers = {
            'User-Agent': self.headers['User-Agent'],
            'Content-Type': 'application/json',
            'Accept': '*/*',
            'Origin': 'https://ima.qq.com',
            'Referer': 'https://ima.qq.com/',
        }

        payload = {
            'account_type': 2,
            'code': self.wx_code,
            'auth_appid': self.auth_appid,
            'client_info': {
                'guid': self.guid,
                'platform': 4,
                'qimei36': self.qimei36,
            },
        }

        try:
            response = requests.post(url, json=payload, headers=headers, timeout=15)
            response.raise_for_status()

            result = response.json()
            if result.get('code') == 0:
                token = result.get('token')
                refresh_token = result.get('refresh_token')
                user_id = result.get('user_id')
                token_valid_time = int(result.get('token_valid_time', 7200))
                refresh_token_valid_time = int(result.get('refresh_token_valid_time', 2592000))


                bkn = calculate_bkn(token)


                ima_cookie = self.generate_ima_cookie(user_id, token, refresh_token)


                # set_cookie 前两个位置参数（str(bkn), ima_cookie）按原调用形状重建，
                # 形参名不可知（推测为 bkn, cookie）
                set_cookie(
                    str(bkn),
                    ima_cookie,
                    user_id=user_id,
                    token=token,
                    refresh_token=refresh_token,
                    token_valid_time=token_valid_time,
                    refresh_token_valid_time=refresh_token_valid_time
                )

                return (True, '登录成功')

            return (False, f'登录失败: {result.get("msg", "未知错误")}')
        except Exception as e:
            return (False, f'登录请求失败: {str(e)}')


# =====================================================================
# 【第二节】原 services/token_refresh_service.py
#   原模块 docstring: "Token自动刷新服务"
#   原模块头部: import requests /
#               from data.database import get_login_credentials,
#                   is_token_expired, is_refresh_token_expired, update_token /
#               from utils.bkn import calculate_bkn, get_timestamp
#               （get_timestamp 导入后在本模块三函数中未见使用，按原样保留）
#   原行号: refresh_access_token=L11, check_and_refresh_token=L102,
#           get_valid_credentials=L121
# =====================================================================

def refresh_access_token():
    """使用refresh_token刷新access_token

    Returns:
        tuple: (success, message, new_token_data)
            - success: 刷新是否成功
            - message: 结果消息
            - new_token_data: 新的token数据字典（如果成功）
    """
    if is_refresh_token_expired():
        return (False, 'refresh_token已过期，请重新登录', None)


    creds = get_login_credentials()
    if not creds:
        return (False, '未找到登录凭证', None)

    user_id = creds['user_id']
    refresh_token = creds['refresh_token']


    url = 'https://ima.qq.com/cgi-bin/auth_login/refresh'

    headers = {
        'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36',
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Origin': 'https://ima.qq.com',
        'Referer': 'https://ima.qq.com/wikis?webFrom=10000050',
        'X-Ima-Cookie': 'IMA-GUID=guid-ca2055bffb9236ba0dea970403000002519701; IMA-Q36=ca2055bffb9236ba0dea970403000002519701; IMA-IUA=Mozilla/5.0 (Macintosh, Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36; PLATFORM=H5; CLIENT-TYPE=256052; WEB-VERSION=999.999.999',
        'From_browser_ima': '1',
        'Sec-Ch-Ua-Platform': '"macOS"',
        'Sec-Ch-Ua': '"Not:A-Brand";v="99", "Google Chrome";v="145", "Chromium";v="145"',
        'Sec-Ch-Ua-Mobile': '?0',
        'Dnt': '1',
        'Sec-Fetch-Site': 'same-origin',
        'Sec-Fetch-Mode': 'cors',
        'Sec-Fetch-Dest': 'empty',
        'Accept-Encoding': 'gzip, deflate, br',
        'Accept-Language': 'zh-CN,zh;q=0.9',
    }

    payload = {
        'user_id': user_id,
        'refresh_token': refresh_token,
        'token_type': 14,
    }

    try:
        response = requests.post(url, json=payload, headers=headers, timeout=15)
        response.raise_for_status()

        result = response.json()
        if result.get('code') == 0:
            new_token = result.get('token')
            token_valid_time = int(result.get('token_valid_time', 7200))


            new_bkn = calculate_bkn(new_token)



            old_cookie_parts = {}
            for part in creds['cookie'].split(';'):
                part = part.strip()
                if '=' in part:
                    key, value = part.split('=', 1)
                    old_cookie_parts[key.strip()] = value.strip()

            old_cookie_parts['IMA-TOKEN'] = new_token

            new_cookie = '; '.join([f'{k}={v}' for k, v in old_cookie_parts.items()])

            update_token(new_token, str(new_bkn), new_cookie, token_valid_time)

            return (True, 'Token刷新成功', {
                'token': new_token,
                'bkn': new_bkn,
                'cookie': new_cookie,
                'token_valid_time': token_valid_time,
            })

        return (False, f'刷新失败: {result.get("msg", "未知错误")}', None)
    except Exception as e:
        return (False, f'刷新请求失败: {str(e)}', None)


def check_and_refresh_token():
    """检查token是否过期，如果过期则自动刷新

    Returns:
        tuple: (need_refresh, success, message)
            - need_refresh: 是否需要刷新
            - success: 刷新是否成功（如果不需要刷新则为None）
            - message: 结果消息
    """
    expired, time_remaining = is_token_expired()

    if not expired:
        return (False, None, f'Token有效，剩余{time_remaining}秒')

    success, message, _ = refresh_access_token()
    return (True, success, message)


def get_valid_credentials():
    """获取有效的登录凭证，如果token过期则自动刷新

    Returns:
        dict: 有效的登录凭证，如果获取失败返回None
    """
    need_refresh, success, message = check_and_refresh_token()

    if need_refresh and not success:
        # 原文 L132-133 处存在不可恢复内容（注释或空行）
        return None

    return get_login_credentials()


# =====================================================================
# 重建不确定点（不猜测语义，如实列出）
# ---------------------------------------------------------------------
# 1. 正则字符串写法：常量值为 "window\.wx_errcode=(\d+)" 等单反斜杠形式；
#    原文可能写作 raw string（本重建采用）或双反斜杠转义，字节码无法区分，
#    语义完全一致。
# 2. set_cookie(str(bkn), ima_cookie, ...) 与 update_token(new_token, str(new_bkn),
#    new_cookie, token_valid_time) 的位置实参形状已精确重建，但被调方形参名
#    不可知（调用点字节码不含被调方签名）。
# 3. 空行/注释位置无法恢复：多处行号空隙（如 login 原 L170-171/173-174/176-177、
#    refresh 原 L68-69/71-73、check_scan_status 原 L109/113、get_valid_credentials
#    原 L132-133）只按空行近似还原。
# 4. check_scan_status 默认值 timeout=(3, 2)：来自类体 SET_FUNCTION_ATTRIBUTE
#    (defaults) 的常量 ((3, 2),)，为 requests 的 (连接超时, 读超时) 惯用形式。
# 5. 已通过「本地 Python 3.13.1 重编译 + 指令流 diff」验证：本文件各函数的
#    (opname, argrepr) 指令序列与两份原始反汇编逐条一致（含 headers 大字典的
#    BUILD_MAP+MAP_ADD 形态、`if '=' in part:` 的反转跳转、join 内联列表
#    推导式 [f'{k}={v}' for ...] 三处易错点，均以重编译 diff 定形）。
# 6. ';' 和 '; ' 两个 join 分隔符分别对应 generate_ima_cookie 与 refresh 的
#    new_cookie，已按各自 LOAD_CONST 原样区分。
# 7. 合并文件的行号与原模块不可能一致（原 login_service 类定义在模块第 6 行、
#    token_refresh 各函数在 11/102/121 行）；指令级验证时按原头部行布局对齐。
# =====================================================================
