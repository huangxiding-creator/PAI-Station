"""微信读书 web 端请求签名（M2.5 铸造厂·电子书源）。

逆向自 weread.qq.com 前端 utils.js（对照开源还原版 touchFish
src/api/weread/utils/index.ts 逐字移植，Node 运行原版生成黄金向量对拍，
见 tests/test_weread_sign.py + tests/weread_golden_vectors.json）：
- calcHash：md5 前 3 位 + 类型标记（纯数字"3"每 9 位转 hex / 其他"4"
  逐字符 charCode hex）+ "2"+md5 末 2 位 + 段长 hex + 段体（g 分隔），
  不足 20 位补 md5 前缀，尾部再拼 md5(自身) 前 3 位
- sign：payload 键排序后 k=v& 拼接（encodeURIComponent），双累加器
  0x15051505 从串尾隔位异或滚动（位移取模 30、掩 0x7fffffff），
  (n1+n2) 转 16 进制
- appId："wb" + UA 各段长度%10 + "h" + BKDR(ua) 十进制串前 16 位

安全红线：纯函数模块，不含凭据；仅供 data/ 内容提取用途，
配套节流参数在 weread.py（账号安全宪法 R8/R10）。
"""
import hashlib
import time
import urllib.parse

# 与扫码登录浏览器同源（2026-09-10 实测 Chrome/152；cookie 签发 UA 与
# 请求 UA 保持一致，降低风控指纹摩擦）
USER_AGENT = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
              "(KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36")


def md5_hex(text: str) -> str:
    return hashlib.md5(text.encode("utf-8")).hexdigest()


def _js_encode_uri_component(value) -> str:
    """JS encodeURIComponent：不转义 A-Za-z0-9 - _ . ! ~ * ' ( )。"""
    return urllib.parse.quote(str(value), safe="-_.!~*'()")


def bkdr_hash(ua: str) -> str:
    """BKDR 累乘（131 进制），逐位 & 0x7fffffff，返回十进制字符串。"""
    num = 0
    for ch in ua:
        num = (131 * num + ord(ch)) & 0x7FFFFFFF
    return str(num)


def get_app_id(ua: str = USER_AGENT) -> str:
    """按 UA 生成 appId：wb + 段长%10 串 + h + BKDR 前 16 位。"""
    parts = ua.split(" ")
    rnd1 = "".join(str(len(p) % 10) for p in parts[:12])
    rnd2 = bkdr_hash(ua)
    if len(rnd2) > 16:
        rnd2 = rnd2[:16]
    return f"wb{rnd1}h{rnd2}"


def calc_hash(data) -> str:
    """calcHash：章节/书籍参数 hash（bookId、chapterUid 等）。"""
    data = str(data)
    data_md5 = md5_hex(data)
    out = data_md5[:3]
    if data.isdigit():
        kind, parts = "3", []
        for i in range(0, len(data), 9):
            chunk = data[i:i + 9]
            parts.append(format(int(chunk), "x"))
    else:
        kind = "4"
        parts = ["".join(format(ord(ch), "x") for ch in data)]
    out += kind
    out += "2" + data_md5[-2:]
    for i, part in enumerate(parts):
        hexlen = format(len(part), "x")
        if len(hexlen) == 1:
            hexlen = "0" + hexlen
        out += hexlen + part
        if i < len(parts) - 1:
            out += "g"
    if len(out) < 20:
        out += data_md5[:20 - len(out)]
    return out + md5_hex(out)[:3]


def _stringify(payload: dict) -> str:
    keys = sorted(payload.keys())
    return "&".join(f"{k}={_js_encode_uri_component(payload[k])}" for k in keys)


def _sign_str(data: str) -> str:
    """双累加器异或滚动签名（32 位语义，掩 0x7fffffff）。"""
    n1 = n2 = 0x15051505
    strlen = len(data)
    i = strlen - 1
    while i > 0:
        # JS int32 位移：先 & 0xFFFFFFFF 再异或，低 31 位与符号扩展等价
        n1 = (n1 ^ ((ord(data[i]) << ((strlen - i) % 30)) & 0xFFFFFFFF)) & 0x7FFFFFFF
        n2 = (n2 ^ ((ord(data[i - 1]) << (i % 30)) & 0xFFFFFFFF)) & 0x7FFFFFFF
        i -= 2
    return format(n1 + n2, "x")


def sign(payload: dict) -> str:
    """对 payload 键排序拼接后计算签名字段 s。"""
    return _sign_str(_stringify(payload))


def current_time() -> int:
    """秒级时间戳（注意：微信读书此字段用秒，非毫秒）。"""
    return int(time.time())
