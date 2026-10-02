# -*- coding: utf-8 -*-
"""端到端验证: 新鲜账号完整登录 (区域墙修复后)"""
import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
import manus_lib as lib

EMAIL = "qqffcrpmj5@cuhk.ac.cn"
accounts = dict(lib.load_accounts("Manus账号（全部）260922_干净版.txt"))
pw = accounts.get(EMAIL, "")
print(f"creds loaded: {len(accounts)} | target in file: {EMAIL in accounts}")

page = lib.make_page()
lib.ensure_network(page)
sess = lib.ensure_login(page, EMAIL, pw)
print("LOGIN_RESULT:", "OK" if sess is not None else "None(login-wall)",
      "| sessions:", len(sess) if isinstance(sess, list) else "-")
