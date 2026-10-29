#!/bin/bash
# wechat4x leg: ingest digests + judge
set -x
cd /e/AI-Station
py -X utf8 reforge_factory/ammo_pool.py ingest EPC-OVERSEAS --file "E:/AI-Station/ammo_pool/EPC-OVERSEAS/staging/wechat4x/wechat4x_epc_overseas_chats.md" --engine wechat4x --cred unknown --tree Q6-E1
py -X utf8 reforge_factory/ammo_pool.py ingest EPC-OVERSEAS --file "E:/AI-Station/ammo_pool/EPC-OVERSEAS/staging/wechat4x/wechat4x_country_access_chats.md" --engine wechat4x --cred unknown --tree Q24-E1
py -X utf8 reforge_pool_placeholder 2>/dev/null
py -X utf8 reforge_factory/ammo_pool.py ingest EPC-OVERSEAS --file "E:/AI-Station/ammo_pool/EPC-OVERSEAS/staging/wechat4x/wechat4x_risk_fidic_chats.md" --engine wechat4x --cred unknown --tree Q14-E1
py -X utf8 reforge_factory/ammo_pool.py judge EPC-OVERSEAS --limit 500
