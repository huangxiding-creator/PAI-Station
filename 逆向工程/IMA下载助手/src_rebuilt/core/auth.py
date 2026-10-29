# -*- coding: utf-8 -*-
# ============================================================================
# 重建文件  : core/auth.py  (IMA下载助手 - 授权验证与本地离线授权保护模块)
# 重建来源  : E:/AI-Station/逆向工程/IMA下载助手/dump/core_auth.dis.txt
#             (CPython 3.13 .pyc 的 dis 反汇编, 3412 行, 已全量逐函数读完)
#             常量对照: E:/AI-Station/逆向工程/IMA下载助手/dump/core_auth.summary.txt
# 总体置信度: 高 (~98%, 经机器验证)
#   - 24 个代码对象(模块 + 2 异常类 + 21 个函数 + 2 个内嵌 genexpr)全部重建,
#     控制流 / ExceptionTable 异常处理范围 / LOAD_CONST 常量索引 / CALL_KW
#     关键字参数均已逐条与反汇编核对
#   - 机器验证: 用本机 CPython 3.13 将本文件编译为字节码, 与原始反汇编逐函数
#     比对操作码序列(忽略 PUSH_NULL/RESUME/NOP 等布局指令), 27 段中 25 段
#     100% 逐一相同(含 <module> 与全部网络函数); 余 2 段(save_local_cache,
#     check_license.<genexpr>)仅差相邻 LOAD_FAST/STORE_FAST 的融合打包
#     (LOAD_FAST_LOAD_FAST 类指令), 属编译器 peephole 差异, 语义等价
#   - 与原始源码的已知差异均为非语义性:
#       1) 原注释丢失; 换行/空行位置为近似(关键处按原行号标注);
#       2) 原代码中 3/4 元素命令行列表编译为 BUILD_LIST+LIST_EXTEND, 即
#          [*('wmic', 'baseboard', ...)] 星号展开写法, 此处还原为等价普通列表;
#       3) "if not (A and B)" 与 "if not A or not B" 字节码相同, 此处取前者;
#          三元表达式已按跳转方向逐一确认;
#       4) ERROR_TRANSLATIONS 末 8 项被编译器折叠为 BUILD_CONST_KEY_MAP,
#          键值对应关系已按栈序逐一还原
#   - 外部依赖 core.config_manager.get_config_manager 属其他模块, 未重建,
#     按原样 import 调用
# 原始行号锚点: docstring=1 | AUTH_PROTOCOL_VERSION=21 | AuthProtocolError=26
#   | AuthServerError=30 | ERROR_TRANSLATIONS=34 | translate_error_message=63
#   | _get_config=75 | get_machine_code=80 | _build_request=176
#   | _signature_messages=191 | verify_ed25519_signature=204
#   | _response_error_detail=231 | unpack_secure_response=257
#   | get_local_aes_key=303 | _write_local_cache=315 | save_local_cache=336
#   | load_local_cache=371 | _signed_server_time=395 | _save_online_result=403
#   | activate_license=417 | verify_license=443 | issue_download_token=481
#   | refund_download_quota=514 | _offline_security_state=551
#   | _record_offline_check=581 | check_license=605 | renew_license=644
# ============================================================================

# [原文件第 1 行]
"""授权验证与本地离线授权保护。"""

# [原 2-9 行]
import base64
import binascii
import hashlib
import json
import os
import platform
import secrets
import time

# [原 11-16 行]
import requests
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric.ed25519 import Ed25519PublicKey
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC

# [原 18 行]
from core.config_manager import get_config_manager

# [原 21-23 行]
AUTH_PROTOCOL_VERSION = 2
MAX_OFFLINE_SECONDS = 172800            # 48 小时
CLOCK_ROLLBACK_TOLERANCE_SECONDS = 300  # 5 分钟


# [原 26 行]
class AuthProtocolError(ValueError):
    """服务端响应未满足认证协议安全要求。"""


# [原 30 行]
class AuthServerError(RuntimeError):
    """服务端明确返回的业务错误。"""


# [原 34-60 行]
ERROR_TRANSLATIONS = {
    'insufficient quota': '剩余额度不足，无法完成本次下载',
    'invalid token': '授权令牌无效，请重新激活卡密',
    'license not found': '授权不存在，请重新激活卡密',
    'license expired': '授权已过期，请续费后再使用',
    'card not found': '卡密不存在，请检查后重新输入',
    'invalid card': '卡密无效，请检查后重新输入',
    'card disabled': '卡密已停用，请联系管理员',
    'card revoked': '卡密已撤销，请联系管理员',
    'card deleted': '卡密已删除，请联系管理员',
    'card exhausted': '卡密可激活次数已用完',
    'card usage limit reached': '卡密可激活次数已用完',
    'activation limit exceeded': '卡密可激活次数已用完',
    'renewal card usage limit reached': '续费卡密可使用次数已用完',
    'activation card cannot renew itself': '不能使用当前激活卡密给自己续费',
    'invalid renewal card': '续费卡密无效或已停用',
    'machine mismatch': '当前设备与授权绑定设备不一致',
    'nonce expired': '请求已过期，请重试',
    'nonce replay': '请求已失效，请重试',
    'invalid nonce': '请求校验失败，请重试',
    'invalid signature': '服务端签名校验失败',
    'bad request': '请求参数错误',
    'not authorized': '未授权，请先激活卡密',
    'unauthorized': '未授权，请先激活卡密',
    'forbidden': '无权执行该操作',
    'internal server error': '服务端内部错误，请稍后重试',
}


# [原 63 行]
def translate_error_message(message):
    """Translate common service-side English errors into user-facing Chinese."""
    text = str(message or '').strip()          # [原 65 行]
    if not text:                               # [原 66 行]
        return text                            # [原 67 行]
    normalized = ' '.join(                     # [原 68 行]
        text.lower().replace('_', ' ').replace('-', ' ').split())
    for key, translated in ERROR_TRANSLATIONS.items():  # [原 69 行]
        if key in normalized:                  # [原 70 行]
            return translated                  # [原 71 行]
    return text                                # [原 72 行]


# [原 75 行]
def _get_config():
    """获取配置管理器。"""
    return get_config_manager()                # [原 77 行]


# [原 80 行]
def get_machine_code():
    """生成机器码。"""
    import subprocess                          # [原 82 行, 函数内导入]

    system = platform.system()                 # [原 84 行]
    machine = platform.machine()               # [原 85 行]

    if system == 'Windows':                    # [原 87 行]
        machine_guid = 'UNKNOWN_GUID'          # [原 88 行]
        try:                                   # [原 89 行]
            import winreg                      # [原 90 行]
            key = winreg.OpenKey(              # [原 92-94 行]
                winreg.HKEY_LOCAL_MACHINE,
                'SOFTWARE\\Microsoft\\Cryptography')
            machine_guid, _ = winreg.QueryValueEx(key, 'MachineGuid')  # [原 96]
            winreg.CloseKey(key)               # [原 97 行]
        except Exception:                      # [原 98 行]
            pass                               # [原 99 行]

        motherboard_sn = 'UNKNOWN_MB'          # [原 101 行]
        try:                                   # [原 102 行]
            si = subprocess.STARTUPINFO()      # [原 103 行]
            si.dwFlags |= subprocess.STARTF_USESHOWWINDOW  # [原 104 行]
            result = subprocess.run(           # [原 105-111 行]
                ['wmic', 'baseboard', 'get', 'serialnumber'],
                capture_output=True,
                text=True,
                timeout=5,
                startupinfo=si,
                creationflags=subprocess.CREATE_NO_WINDOW,
            )
            lines = result.stdout.strip().split('\n')  # [原 113 行]
            if len(lines) > 1:                 # [原 114 行]
                motherboard_sn = lines[1].strip()      # [原 115 行]
        except Exception:                      # [原 116 行]
            pass                               # [原 117 行]

        raw = f'{machine_guid}|{motherboard_sn}|{machine}'  # [原 118 行]
    elif system == 'Darwin':                   # [原 119 行]
        motherboard_sn = 'UNKNOWN_MB'          # [原 120 行]
        cpu_id = 'UNKNOWN_CPU'                 # [原 121 行]
        try:                                   # [原 122 行]
            result = subprocess.run(           # [原 123-127 行]
                ['system_profiler', 'SPHardwareDataType'],
                capture_output=True,
                text=True,
                timeout=5,
            )
            for line in result.stdout.split('\n'):    # [原 129 行]
                if 'Serial Number' in line:    # [原 130 行]
                    motherboard_sn = line.split(':', 1)[1].strip()  # [原 131]
                    break                      # [原 132 行]
        except Exception:                      # [原 133 行]
            pass                               # [原 134 行]

        try:                                   # [原 135 行]
            result = subprocess.run(           # [原 136-140 行]
                ['sysctl', '-n', 'machdep.cpu.brand_string'],
                capture_output=True,
                text=True,
                timeout=5,
            )
            cpu_id = result.stdout.strip()     # [原 142 行]
        except Exception:                      # [原 143 行]
            pass                               # [原 144 行]

        raw = f'{motherboard_sn}|{cpu_id}|{system}|{machine}'  # [原 145 行]
    else:                                      # [原 147 行, Linux/其他]
        motherboard_sn = 'UNKNOWN_MB'          # [原 148 行]
        cpu_id = 'UNKNOWN_CPU'                 # [原 149 行]
        try:                                   # [原 150 行]
            result = subprocess.run(           # [原 151-154 行]
                ['dmidecode', '-s', 'baseboard-serial-number'],
                capture_output=True,
                text=True,
                timeout=5,
            )
            motherboard_sn = result.stdout.strip()    # [原 156 行]
        except Exception:                      # [原 157 行]
            pass                               # [原 158 行]

        try:                                   # [原 160 行]
            result = subprocess.run(           # [原 161-164 行]
                ['dmidecode', '-t', 'processor'],
                capture_output=True,
                text=True,
                timeout=5,
            )
            for line in result.stdout.split('\n'):    # [原 166 行]
                if 'ID:' in line:              # [原 167 行]
                    cpu_id = line.split(':', 1)[1].strip()  # [原 168 行]
                    break                      # [原 169 行]
        except Exception:                      # [原 170 行]
            pass                               # [原 171 行]

        raw = f'{motherboard_sn}|{cpu_id}|{system}|{machine}'  # [原 172 行]

    return hashlib.sha256(raw.encode()).hexdigest()  # [原 173 行]


# [原 176 行] 参数为纯关键字收集 (**fields, co_argcount=0, DICT_UPDATE 确认)
def _build_request(**fields):
    """构造不包含客户端共享秘密的版本化请求。"""
    config = _get_config()                     # [原 178 行]
    request_data = {                           # [原 179-183 行]
        **fields,
        'timestamp': int(time.time()),
        'nonce': secrets.token_hex(16),
        'protocol_version': AUTH_PROTOCOL_VERSION,
    }
    client_version = getattr(config, 'version', None)  # [原 185 行]
    if client_version:                         # [原 186 行]
        request_data['client_version'] = str(client_version)  # [原 187 行]
    return request_data                        # [原 188 行]


# [原 191 行]
def _signature_messages(response_data):
    """同时兼容当前服务端 JSON 编码和 auth-v2 规范化编码。"""
    unsigned = {key: value                     # [原 193 行, 内联字典推导]
                for key, value in response_data.items()
                if key != 'signature'}
    legacy = json.dumps(unsigned, sort_keys=True).encode()  # [原 194 行]
    canonical = json.dumps(                    # [原 195-200 行]
        unsigned,
        sort_keys=True,
        ensure_ascii=False,
        separators=(',', ':'),
    ).encode()
    if legacy == canonical:                    # [原 201 行]
        return (legacy,)
    return (canonical, legacy)


# [原 204 行]
def verify_ed25519_signature(response_data, signature_b64=None):
    """验证完整响应体的 Ed25519 签名。"""
    if not isinstance(response_data, dict):    # [原 206 行]
        return False                           # [原 207 行]

    signature_b64 = signature_b64 or response_data.get('signature')  # [原 208]
    if not (isinstance(signature_b64, str) and signature_b64):  # [原 209]
        return False                           # [原 210 行]

    try:                                       # [原 212 行, 仅覆盖 213-218]
        public_key = serialization.load_pem_public_key(  # [原 213-214 行]
            _get_config().server_public_key_pem.encode())
        if not isinstance(public_key, Ed25519PublicKey):  # [原 216 行]
            return False                       # [原 217 行]

        signature = base64.b64decode(signature_b64, validate=True)  # [原 218]
    except (ValueError, TypeError, binascii.Error):  # [原 219 行]
        return False                           # [原 220 行]

    for message in _signature_messages(response_data):  # [原 222 行, try 之外]
        try:                                   # [原 223 行]
            public_key.verify(signature, message)       # [原 224 行]
            return True                        # [原 225 行]
        except Exception:                      # [原 226 行]
            continue                           # [原 227 行]

    return False                               # [原 228 行]


# [原 231 行]
def _response_error_detail(result, status_code):
    detail = result.get('detail') if isinstance(result, dict) else None  # [232]
    if isinstance(detail, list):               # [原 233 行]
        missing_sign = any(                    # [原 234-236 行, 内嵌 genexpr]
            isinstance(item, dict) and 'sign' in item.get('loc', ())
            for item in detail
        )
        if missing_sign:                       # [原 238 行]
            return '服务端认证协议过旧，请升级服务端以支持 auth-v2'  # [原 239]

        messages = [                           # [原 240-242 行, 内联列表推导]
            str(item.get('msg', ''))
            for item in detail
            if isinstance(item, dict) and item.get('msg')
        ]
        if messages:                           # [原 245 行]
            return translate_error_message('；'.join(messages))  # [原 246]

    if isinstance(detail, str) and detail:     # [原 247 行]
        return translate_error_message(detail)  # [原 248 行]

    if isinstance(result, dict):               # [原 249 行]
        for key in ('message', 'msg', 'error'):  # [原 250 行]
            value = result.get(key)            # [原 251 行]
            if isinstance(value, str) and value:  # [原 252 行]
                return translate_error_message(value)  # [原 253 行]

    return f'服务端请求失败（HTTP {status_code}）'  # [原 254 行]


# [原 257 行]
def unpack_secure_response(response, required_fields=()):
    """统一校验成功响应签名并安全解包 payload。"""
    try:                                       # [原 259-260 行]
        result = response.json()
    except Exception as exc:                   # [原 261 行]
        raise AuthProtocolError('服务端响应不是有效 JSON') from exc  # [原 262]

    if not isinstance(result, dict):           # [原 264 行]
        raise AuthProtocolError('服务端响应格式无效')    # [原 265 行]

    if not 200 <= response.status_code < 300:  # [原 267 行, 链式比较]
        raise AuthServerError(                 # [原 268 行]
            _response_error_detail(result, response.status_code))

    if not verify_ed25519_signature(result):   # [原 270 行]
        raise AuthProtocolError('服务端成功响应签名缺失或验证失败')  # [原 271]

    payload = result.get('payload')            # [原 273 行]
    if isinstance(payload, dict):              # [原 274 行]
        unpacked = payload                     # [原 275 行]
    else:                                      # [原 277 行, 加密信封分支]
        session_key_b64 = result.get('session_key')  # [原 277 行]
        if not (isinstance(payload, str)       # [原 278 行]
                and isinstance(session_key_b64, str)):
            raise AuthProtocolError('服务端成功响应缺少安全载荷')  # [原 279]

        try:                                   # [原 280 行]
            session_key = base64.b64decode(session_key_b64, validate=True)  # [281]
            encrypted = base64.b64decode(payload, validate=True)  # [原 282]
            if len(session_key) not in (16, 24, 32) or len(encrypted) < 13:
                raise ValueError('invalid encrypted envelope')     # [原 284]
            nonce, ciphertext = encrypted[:12], encrypted[12:]      # [原 285]
            plaintext = AESGCM(session_key).decrypt(               # [原 286]
                nonce, ciphertext, None)
            unpacked = json.loads(plaintext)   # [原 287 行]
        except (ValueError, TypeError, binascii.Error, json.JSONDecodeError) as exc:
            raise AuthProtocolError('服务端安全载荷解包失败') from exc  # [289]
        except Exception as exc:               # [原 290 行]
            raise AuthProtocolError('服务端安全载荷解密失败') from exc  # [291]

    if not isinstance(unpacked, dict):         # [原 293 行]
        raise AuthProtocolError('服务端载荷格式无效')    # [原 294 行]

    if 'server_time' in result:                # [原 295 行]
        unpacked.setdefault('server_time', result['server_time'])  # [原 296]

    missing = [field                            # [原 297 行, 内联列表推导]
               for field in required_fields
               if field not in unpacked]
    if missing:                                # [原 298 行]
        raise AuthProtocolError(               # [原 299 行]
            f'服务端载荷缺少字段: {", ".join(missing)}')

    return unpacked                            # [原 300 行]


# [原 303 行]
def get_local_aes_key():
    """从机器码派生本地授权缓存密钥。"""
    kdf = PBKDF2HMAC(                          # [原 305-310 行, 全关键字参数]
        algorithm=hashes.SHA256(),
        length=32,
        salt=b'ima_local_salt',
        iterations=100000,
        backend=default_backend(),
    )
    return kdf.derive(get_machine_code().encode())  # [原 312 行]


# [原 315 行]
def _write_local_cache(data):
    config = _get_config()                     # [原 316 行]
    license_path = config.license_file         # [原 317 行]
    key = get_local_aes_key()                  # [原 318 行]
    nonce = os.urandom(12)                     # [原 319 行]
    ciphertext = AESGCM(key).encrypt(          # [原 320-323 行]
        nonce,
        json.dumps(data, ensure_ascii=False).encode(),
        None,
    )
    directory = os.path.dirname(license_path)  # [原 325 行]
    if directory:                              # [原 326 行]
        os.makedirs(directory, exist_ok=True)  # [原 327 行]
    temp_path = f'{license_path}.tmp'          # [原 328 行]
    with open(temp_path, 'wb') as file_obj:    # [原 329 行]
        file_obj.write(nonce + ciphertext)     # [原 330 行]
        file_obj.flush()                       # [原 331 行]
        os.fsync(file_obj.fileno())            # [原 332 行]
    os.replace(temp_path, license_path)        # [原 333 行]


# [原 336 行] 后两个为 keyword-only 参数(模块级 LOAD_CONST None + kwdefaults)
def save_local_cache(token, expire_at, remaining, *,
                     online_verified_at=None, last_seen_time=None):
    """保存授权缓存，并记录不可超过 48 小时的离线窗口。"""
    now = float(time.time())                   # [原 345 行]
    online_verified_at = float(                # [原 346-347 行]
        now if online_verified_at is None else online_verified_at)
    last_seen_time = max(                      # [原 349-351 行]
        online_verified_at,
        float(now if last_seen_time is None else last_seen_time))
    expire_at = float(expire_at)               # [原 353 行]

    data = {                                   # [原 354-366 行]
        'cache_version': 2,
        'token': token,
        'expire_at': expire_at,
        'last_verify': online_verified_at,
        'last_online_verify': online_verified_at,
        'last_seen_time': last_seen_time,
        'offline_deadline': min(expire_at, online_verified_at + MAX_OFFLINE_SECONDS),
        'cached_remaining': remaining,
        'machine_code': get_machine_code(),
    }
    _write_local_cache(data)                   # [原 368 行]


# [原 371 行]
def load_local_cache():
    """读取本地授权缓存并验证机器码与安全字段。"""
    license_path = _get_config().license_file  # [原 373 行]
    try:                                       # [原 374 行, 单一大 try 覆盖至 390]
        if not os.path.exists(license_path):   # [原 375 行]
            return None                        # [原 376 行]
        with open(license_path, 'rb') as file_obj:  # [原 377 行]
            encrypted = file_obj.read()        # [原 378 行]
        if len(encrypted) < 13:                # [原 379 行]
            return None                        # [原 380 行]
        nonce, ciphertext = encrypted[:12], encrypted[12:]  # [原 381 行]
        plaintext = AESGCM(get_local_aes_key()).decrypt(    # [原 382 行]
            nonce, ciphertext, None)
        data = json.loads(plaintext)           # [原 383 行]
        if not isinstance(data, dict):         # [原 384 行]
            return None                        # [原 385 行]
        if data.get('machine_code') not in (None, get_machine_code()):
            return None                        # [原 387 行]
        if not data.get('token') or 'expire_at' not in data:
            return None                        # [原 389 行]
        return data                            # [原 390 行]
    except Exception:                          # [原 391 行]
        return None                            # [原 392 行]


# [原 395 行]
def _signed_server_time(payload):
    value = payload.get('server_time', time.time())  # [原 396 行]
    try:                                       # [原 397 行]
        return float(value)                    # [原 398 行]
    except (TypeError, ValueError):            # [原 399 行]
        return float(time.time())              # [原 400 行]


# [原 403 行]
def _save_online_result(cache, payload, remaining=None):
    expire_at = payload.get('expire_at', cache.get('expire_at'))  # [原 404]
    if expire_at is None:                      # [原 405 行]
        raise AuthProtocolError('服务端载荷缺少授权到期时间')  # [原 406]
    if remaining is None:                      # [原 407 行]
        remaining = payload.get('remaining',   # [原 408 行]
                                cache.get('cached_remaining', 0))
    save_local_cache(                          # [原 409-413 行]
        cache['token'],
        expire_at,
        remaining,
        online_verified_at=_signed_server_time(payload),
    )


# [原 417 行]
def activate_license(card_key):
    """激活卡密。"""
    data = _build_request(                     # [原 419 行]
        card_key=card_key,
        machine_code=get_machine_code())
    try:                                       # [原 420 行]
        response = requests.post(              # [原 421-424 行]
            _get_config().get_api_url('activate'),
            json=data,
            timeout=10,
        )
        token_data = unpack_secure_response(   # [原 426-428 行]
            response,
            required_fields=('token', 'expire_at'),
        )
        save_local_cache(                      # [原 430-434 行]
            token_data['token'],
            token_data['expire_at'],
            token_data.get('quota_total', token_data.get('remaining', 0)),
            online_verified_at=_signed_server_time(token_data),
        )
        return True, '激活成功'                # [原 436 行]
    except (AuthProtocolError, AuthServerError) as exc:  # [原 437 行]
        return False, str(exc)                 # [原 438 行]
    except Exception as exc:                   # [原 439 行]
        return False, f'激活失败: {exc}'       # [原 440 行]


# [原 443 行]
def verify_license():
    """向服务端验证授权。"""
    config = _get_config()                     # [原 445 行]
    cache = load_local_cache()                 # [原 446 行]
    if not cache:                              # [原 447 行]
        return False, '未激活'                 # [原 448 行]

    data = _build_request(                     # [原 450-452 行]
        token=cache['token'],
        machine_code=get_machine_code(),
    )
    try:                                       # [原 454 行]
        response = requests.post(              # [原 455-458 行]
            config.get_api_url('verify'),
            json=data,
            timeout=10,
        )
        config_data = unpack_secure_response(  # [原 460-462 行]
            response,
            required_fields=('remaining',),
        )
        config_pack = config_data.get('config_pack') or config_data  # [原 464]
        if isinstance(config_pack, dict) and (  # [原 465-467 行]
                'base_url' in config_pack
                or 'ima_base_url' in config_pack):
            config.set_config_pack(config_pack)  # [原 468 行]

        _save_online_result(cache, config_data)  # [原 469 行]
        return True, config_data               # [原 470 行]
    except requests.exceptions.Timeout as exc:      # [原 471 行]
        return False, f'网络超时: {exc}'        # [原 472 行]
    except requests.exceptions.ConnectionError as exc:  # [原 473 行]
        return False, f'网络连接失败: {exc}'    # [原 474 行]
    except (AuthProtocolError, AuthServerError) as exc:  # [原 475 行]
        return False, str(exc)                 # [原 476 行]
    except Exception as exc:                   # [原 477 行]
        return False, f'网络错误: {exc}'        # [原 478 行]


# [原 481 行]
def issue_download_token(file_count):
    """申请下载令牌。"""
    cache = load_local_cache()                 # [原 483 行]
    if not cache:                              # [原 484 行]
        return False, '未激活', None           # [原 485 行]

    data = _build_request(                     # [原 487-490 行]
        token=cache['token'],
        machine_code=get_machine_code(),
        file_count=file_count,
    )
    try:                                       # [原 492 行]
        response = requests.post(              # [原 493-496 行]
            _get_config().get_api_url('quota_issue'),
            json=data,
            timeout=10,
        )
        token_data = unpack_secure_response(   # [原 498-500 行]
            response,
            required_fields=('remaining', 'download_token'),
        )
        _save_online_result(cache, token_data)  # [原 502 行]

        return (                               # [原 503-506 行]
            True,
            f'剩余 {token_data["remaining"]} 次',
            token_data['download_token'],
        )
    except (AuthProtocolError, AuthServerError) as exc:  # [原 508 行]
        return False, str(exc), None           # [原 509 行]
    except Exception as exc:                   # [原 510 行]
        return False, f'网络错误: {exc}', None  # [原 511 行]


# [原 514 行]
def refund_download_quota(file_count, download_token=None):
    """退回下载失败所消耗的额度。"""
    if file_count <= 0:                        # [原 516 行]
        return True, '无需退回额度'            # [原 517 行]

    cache = load_local_cache()                 # [原 519 行]
    if not cache:                              # [原 520 行]
        return False, '未激活'                 # [原 521 行]

    fields = {                                 # [原 523-526 行]
        'token': cache['token'],
        'machine_code': get_machine_code(),
        'file_count': file_count,
    }
    if download_token:                         # [原 528 行]
        fields['download_token'] = download_token  # [原 529 行]
    data = _build_request(**fields)            # [原 530 行, CALL_FUNCTION_EX]

    try:                                       # [原 532 行]
        response = requests.post(              # [原 533-536 行]
            _get_config().get_api_url('quota_refund'),
            json=data,
            timeout=10,
        )
        token_data = unpack_secure_response(   # [原 538-540 行]
            response,
            required_fields=('remaining',),
        )
        remaining = token_data['remaining']    # [原 542 行]
        _save_online_result(cache, token_data, remaining)  # [原 543 行]
        return True, f'已退回 {file_count} 次，剩余 {remaining} 次'  # [544]
    except (AuthProtocolError, AuthServerError) as exc:  # [原 545 行]
        return False, str(exc)                 # [原 546 行]
    except Exception as exc:                   # [原 547 行]
        return False, f'退回额度失败: {exc}'   # [原 548 行]


# [原 551 行]
def _offline_security_state(cache, current_time, enforce_offline_limit=True):
    try:                                       # [原 552 行]
        expire_at = float(cache['expire_at'])  # [原 553 行]
        last_online = float(                   # [原 554-555 行]
            cache.get('last_online_verify', cache.get('last_verify', 0)))
        last_seen = float(cache.get('last_seen_time', last_online))  # [原 557]
        offline_deadline = float(              # [原 558-561 行]
            cache.get(
                'offline_deadline',
                min(expire_at, last_online + MAX_OFFLINE_SECONDS),
            )
        )
    except (KeyError, TypeError, ValueError):  # [原 564 行]
        return False, '本地授权缓存无效'       # [原 565 行]

    if (current_time + CLOCK_ROLLBACK_TOLERANCE_SECONDS < last_seen   # [568]
            or current_time + CLOCK_ROLLBACK_TOLERANCE_SECONDS < last_online):
        return False, '检测到系统时间回拨，请联网重新验证'  # [原 571 行]
    if current_time >= expire_at:              # [原 572 行]
        return False, '授权已过期'             # [原 573 行]
    if enforce_offline_limit and (             # [原 574-575 行]
            not last_online
            or current_time > min(expire_at, offline_deadline)):
        return False, '离线授权已超过 48 小时，请联网验证'  # [原 577 行]
    return True, None                          # [原 578 行]


# [原 581 行]
def _record_offline_check(cache, current_time):
    migrated = dict(cache)                     # [原 582 行]
    last_online = float(                       # [原 583-584 行]
        migrated.get('last_online_verify', migrated.get('last_verify', 0)))
    migrated.update({                          # [原 586-599 行, 单个字典实参]
        'cache_version': 2,
        'last_verify': last_online,
        'last_online_verify': last_online,
        'last_seen_time': max(
            float(migrated.get('last_seen_time', last_online)),
            current_time,
        ),
        'offline_deadline': min(
            float(migrated['expire_at']),
            last_online + MAX_OFFLINE_SECONDS,
        ),
        'machine_code': get_machine_code(),
    })
    _write_local_cache(migrated)               # [原 602 行]


# [原 605 行]
def check_license():
    """检查授权，网络不可用时最多允许离线 48 小时。"""
    cache = load_local_cache()                 # [原 607 行]
    if not cache:                              # [原 608 行]
        return False, '未激活'                 # [原 609 行]

    current_time = float(time.time())          # [原 611 行]
    secure, reason = _offline_security_state(  # [原 612-615 行]
        cache,
        current_time,
        enforce_offline_limit=False,
    )
    if not secure:                             # [原 617 行]
        return False, reason                   # [原 618 行]

    success, result = verify_license()         # [原 620 行]
    if success:                                # [原 621 行]
        expire_at = float(result.get('expire_at', cache['expire_at']))  # [622]
        expire_date = time.strftime('%Y-%m-%d', time.localtime(expire_at))
        return True, f'授权有效，到期: {expire_date}'      # [原 624 行]

    result_text = str(result)                  # [原 626 行, 闭包变量]
    if any(marker in result_text               # [原 627 行, 内嵌 genexpr]
           for marker in ('网络', '超时', '连接')):
        secure, reason = _offline_security_state(cache, current_time)  # [628]
        if not secure:                         # [原 629 行]
            return False, reason               # [原 630 行]

        try:                                   # [原 631 行]
            _record_offline_check(cache, current_time)  # [原 632 行]
        except Exception:                      # [原 633 行]
            return False, '无法更新本地授权安全状态'  # [原 634 行]

        expire_date = time.strftime(           # [原 635-637 行]
            '%Y-%m-%d',
            time.localtime(float(cache['expire_at'])),
        )
        return True, f'授权有效（离线），到期: {expire_date}'  # [原 639 行]

    return False, result                       # [原 641 行]


# [原 644 行]
def renew_license(card_key):
    """使用续费卡密延长授权。"""
    cache = load_local_cache()                 # [原 646 行]
    if not cache:                              # [原 647 行]
        return False, '请先激活卡密'           # [原 648 行]

    data = _build_request(                     # [原 650-653 行]
        card_key=card_key,
        token=cache['token'],
        machine_code=get_machine_code(),
    )
    try:                                       # [原 655 行]
        response = requests.post(              # [原 656-659 行]
            _get_config().get_api_url('renew'),
            json=data,
            timeout=10,
        )
        renew_data = unpack_secure_response(   # [原 661-663 行]
            response,
            required_fields=('expire_at', 'remaining'),
        )
        _save_online_result(cache, renew_data)  # [原 665 行]
        expire_date = time.strftime(           # [原 666-668 行]
            '%Y-%m-%d',
            time.localtime(float(renew_data['expire_at'])),
        )
        return True, f'续费成功！到期时间: {expire_date}'  # [原 670 行]
    except (AuthProtocolError, AuthServerError) as exc:  # [原 671 行]
        return False, str(exc)                 # [原 672 行]
    except Exception as exc:                   # [原 673 行]
        return False, f'续费失败: {exc}'       # [原 674 行]
