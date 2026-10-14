# -*- coding: utf-8 -*-
"""企微回调消息加解密（WXBizMsgCrypt 官方算法自实现）。

算法（企业微信官方文档《加解密方案》）：
  签名: sha1(sort(token, timestamp, nonce, encrypt_msg))
  加密: AES-256-CBC，key = Base64Decode(EncodingAESKey + "=")，随机16字节前缀
        + 4字节网络序消息长度 + 明文 + corpid，PKCS7(32) 填充
"""
from __future__ import annotations

import base64
import hashlib
import os
import struct
import time

from Crypto.Cipher import AES


class WeComCrypto:
    def __init__(self, token: str, encoding_aes_key: str, corp_id: str):
        if len(encoding_aes_key) != 43:
            raise ValueError("EncodingAESKey 必须为 43 位")
        self.token = token
        self.corp_id = corp_id
        self.key = base64.b64decode(encoding_aes_key + "=")
        if len(self.key) != 32:
            raise ValueError("AES key 派生失败")

    # ---- 签名 ----
    def signature(self, timestamp: str, nonce: str, encrypt: str) -> str:
        raw = sorted([self.token, timestamp, nonce, encrypt])
        return hashlib.sha1("".join(raw).encode()).hexdigest()

    def verify(self, msg_signature: str, timestamp: str, nonce: str, encrypt: str) -> bool:
        return self.signature(timestamp, nonce, encrypt) == msg_signature

    # ---- 加解密 ----
    def decrypt(self, encrypt_b64: str) -> str:
        plain = AES.new(self.key, AES.MODE_CBC, self.key[:16]).decrypt(
            base64.b64decode(encrypt_b64))
        pad = plain[-1]
        content = plain[:-pad]
        msg_len = struct.unpack(">I", content[16:20])[0]
        msg = content[20:20 + msg_len].decode("utf-8")
        from_corp = content[20 + msg_len:].decode("utf-8")
        if from_corp != self.corp_id:
            raise ValueError(f"corpid 不匹配: {from_corp}")
        return msg

    def encrypt(self, plain: str) -> str:
        import json
        data = plain.encode("utf-8")
        block = os.urandom(16) + struct.pack(">I", len(data)) + data + self.corp_id.encode()
        pad = 32 - len(block) % 32
        block += bytes([pad]) * pad
        return base64.b64encode(
            AES.new(self.key, AES.MODE_CBC, self.key[:16]).encrypt(block)).decode()

    # ---- 回调验证（GET echostr）----
    def verify_echo(self, msg_signature, timestamp, nonce, echostr) -> str:
        if not self.verify(msg_signature, timestamp, nonce, echostr):
            raise ValueError("签名校验失败")
        return self.decrypt(echostr)

    # ---- 包裹/解包 XML 报文 ----
    def wrap_reply(self, plain_xml: str) -> dict:
        ts = str(int(time.time()))
        nonce = os.urandom(8).hex()[:10]
        encrypt = self.encrypt(plain_xml)
        return {"Encrypt": encrypt, "MsgSignature": self.signature(ts, nonce, encrypt),
                "TimeStamp": ts, "Nonce": nonce}
