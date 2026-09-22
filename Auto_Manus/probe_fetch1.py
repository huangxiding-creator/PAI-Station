# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_api as api
import manus_lib as lib

page = lib.make_page()
email = lib.load_accounts("账号列表 - 调试.txt")[0][0]
tok = api.load_token(email)
print("token loaded:", bool(tok), "len:", len(tok.get("authorization", "")) if tok else 0)
# 确保页面在 app 域 (run_js 需要)
page.get(lib.APP_URL)
import time; time.sleep(3)
for path in [
    "/api/chat/getSessionV2?sessionId=Ri4iiQFcTGCfEIOVPpsOXH&type=private",
    "/api/chat/getSessionFilesV2?sessionId=Ri4iiQFcTGCfEIOVPpsOXH",
    "/api/chat/getSessionOutline?sessionId=Ri4iiQFcTGCfEIOVPpsOXH",
]:
    st, text = api.api_call(page, "GET", path, tok)
    print(st, path.split("?")[0].split("/")[-1], "len=", len(text), text[:100].replace("\n", " "))
