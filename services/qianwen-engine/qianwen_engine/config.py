# -*- coding: utf-8 -*-
"""总包千问引擎——配置与常量。"""
from __future__ import annotations

from pathlib import Path

REPO = Path(__file__).resolve().parents[3]          # E:\AI-Station
PKG = Path(__file__).resolve().parent

SECRETS_DIR = REPO / "data" / "secrets"
DATA_DIR = REPO / "data" / "qianwen"
DB_PATH = DATA_DIR / "db.sqlite"

# 秘塔工程大脑（网页会话线：cookie + meta-token，烧网页积分池）
KB_SESSION_FILE = SECRETS_DIR / "metaso_kb_session.json"
KB_TOPIC_ID = "8673582927558737920"                  # 工程行业大脑
KB_CHAT_URL = "https://metaso.cn/api/knowledge/chat"
KB_CONV_URL = "https://metaso.cn/api/conversation/{cid}/branched-messages"
KB_PAGE_URL = "https://metaso.cn/subject-v2/" + KB_TOPIC_ID

# search-api 外援腿（Bearer 线：API 积分池，须充值后启用）
SEARCH_API_KEY_FILE = SECRETS_DIR / "metaso_api_key_user.txt"
SEARCH_CHAT_URL = "https://metaso.cn/api/v1/chat/completions"

# 智谱免费链（AI优化提问主引擎；密钥行式 api_key=... / api_key_2=...，多账号免费池）
# 用户令 0929：key 在超级AI工作站 config/llm.secret.ini；除工程大脑答题烧 KB 积分外全链免费
ZHIPU_SECRET_FILE = SECRETS_DIR / "zhipu.secret"
ZHIPU_FREE_MODELS = ("glm-4-flash-250414", "glm-4.7-flash", "glm-4.5-flash")
ZHIPU_TIMEOUT_SEC = 30

# 微信小程序
MP_SECRET_FILE = SECRETS_DIR / "zongbao_qianwen_mp.secret"
WX_APPID = "wx5cee1574ce45819b"

# 虚拟支付（wx.requestVirtualPayment 道具直购 · 企业主体合规通道）
# 密钥文件三行：offer_id= / product_id= / env=（0 正式 1 沙箱）；后台开通后填写，空=未开通
VIRTUAL_PAY_FILE = SECRETS_DIR / "virtual_pay.secret"
UNLOCK_PRICE_FEN = 100        # 解锁价：¥1 = 100 分（goodsPrice 单位=分）

# 产品规则（v0.5.0 用户九点令）
FREE_PER_DAY = 6            # 每日免费提问（北京时间 00:00 全量清零，不累计）
REWARD_ACTIONS = ("like", "export", "share", "criticize")  # 互动赠次动作（每答案每动作一次，总量不封顶）
OPTIMIZE_DAILY_CAP = 10     # AI 优化提问每用户每日次数（护共享 KB 免费池）
PREVIEW_CHARS = 200         # 免费预览字数

# 锅圈（打破砂锅问到底）：热点问题公共展区
POT_OPENID = "pot-curator"  # 锅圈内容落库身份（answers 行 openid，复用答案管线）
POT_PREVIEW_CHARS = 100     # 锅圈列表答案预览字数

# 引擎护栏（账号安全四件套）
KB_MIN_INTERVAL_SEC = 5     # 节流：两问最小间隔
KB_DAILY_POINT_CAP = 90     # 日积分硬顶（网页池每问约3点 → 30问）
KB_BREAKER_THRESHOLD = 4    # 熔断阈值
KB_BREAKER_RECOVERY_SEC = 600
KB_ASK_TIMEOUT_SEC = 180
KB_POLL_INTERVAL_SEC = 5
KB_POLL_MAX_ROUNDS = 24     # 24×5s=120s
MIN_ANSWER_LEN = 100        # 低于此长度视为未完成

ENGINE_TOKEN_FILE = SECRETS_DIR / "qianwen_engine_hmac.key"
