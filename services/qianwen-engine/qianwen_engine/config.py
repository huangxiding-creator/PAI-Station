# -*- coding: utf-8 -*-
"""总包千问引擎——配置与常量。"""
from __future__ import annotations

import os
from pathlib import Path

try:
    REPO = Path(__file__).resolve().parents[3]          # E:\AI-Station
except IndexError:                                      # 容器内 /app/qianwen_engine/ 只有两级父目录
    REPO = Path(__file__).resolve().parents[1]          # /app（DATA_DIR/SECRETS_DIR 缺省随之落 /app/data、/app/secrets）
PKG = Path(__file__).resolve().parent


def _env_int(name: str, default: int) -> int:
    """环境变量整型读取（缺省/非法回退默认值）。"""
    try:
        return int(os.environ.get(name) or default)
    except ValueError:
        return default


# ── 部署形态（v0.8.0 CloudBase 云托管迁移）：环境变量驱动，缺省=本地/ECS 行为不变 ──
# 生产值一律来自云托管「服务设置 → 环境变量」注入；本文件不落任何密钥。
DB_KIND = (os.environ.get("DB_KIND") or "sqlite").strip().lower()   # sqlite | mysql
MYSQL_HOST = os.environ.get("MYSQL_HOST") or ""
MYSQL_PORT = _env_int("MYSQL_PORT", 3306)
MYSQL_USER = os.environ.get("MYSQL_USER") or ""
MYSQL_PASSWORD = os.environ.get("MYSQL_PASSWORD") or ""
MYSQL_DATABASE = os.environ.get("MYSQL_DATABASE") or ""
PORT = _env_int("PORT", 8080)      # 容器监听端口（云托管注入 PORT，Dockerfile 同源默认 8080）

# 目录：容器内无仓库结构 → 允许环境变量覆盖（DATA_DIR=字体/wxacode 缓存，SECRETS_DIR=密钥文件挂载点）；
# 缺省保持仓库内路径，ECS/本地行为不变
SECRETS_DIR = Path(os.environ.get("SECRETS_DIR") or (REPO / "data" / "secrets"))
DATA_DIR = Path(os.environ.get("DATA_DIR") or (REPO / "data" / "qianwen"))
DB_PATH = DATA_DIR / "db.sqlite"
GOODS_STATIC_DIR = PKG / "static_goods"   # v0.9.13 虚拟支付道具图（item_url 公开承载，随镜像走）

# ── v0.9.4 发票（1009 用户令：累计消费满 ¥200 可申请增值税专用发票；申请即企业微信推送运营）──
INVOICE_THRESHOLD_FEN = _env_int("INVOICE_THRESHOLD_FEN", 20000)            # ¥200（分）
INVOICE_WECOM_WEBHOOK = (os.environ.get("INVOICE_WECOM_WEBHOOK") or "").strip()
INVOICE_WECOM_WEBHOOK_FILE = SECRETS_DIR / "invoice_wecom_webhook.txt"      # 兜底：密钥文件形态（ECS 挂载）

# ── v0.9.6 真机遥测（1009 真机根因战：devtools 全绿+真机失灵双盲区的地面真值腿）──
# 客户端匿名事件（boot/ask_load/ask_tap/…）上行 → 落库；读取端 GET /api/telemetry/recent
# 须 X-Tel-Key == telemetry.secret（运营自看，绝不公开）。公开写端点只收白名单事件名
# +截断字段，插入侧偶发修剪容量，防灌水膨胀。
TELEMETRY_SECRET_FILE = SECRETS_DIR / "telemetry.secret"
TELEMETRY_KEEP_ROWS = _env_int("TELEMETRY_KEEP_ROWS", 20000)               # 表容量上限

# 秘塔总包智库（网页会话线：cookie + meta-token，烧网页积分池）
KB_SESSION_FILE = SECRETS_DIR / "metaso_kb_session.json"
KB_TOPIC_ID = "8673582927558737920"                  # 工程行业大脑（总包智库知识库）
KB_CHAT_URL = "https://metaso.cn/api/knowledge/chat"
KB_CONV_URL = "https://metaso.cn/api/conversation/{cid}/branched-messages"
KB_PAGE_URL = "https://metaso.cn/subject-v2/" + KB_TOPIC_ID

# search-api 外援腿（Bearer 线：API 积分池，须充值后启用）
SEARCH_API_KEY_FILE = SECRETS_DIR / "metaso_api_key_user.txt"
SEARCH_CHAT_URL = "https://metaso.cn/api/v1/chat/completions"

# 智谱免费链（AI优化提问主引擎；密钥行式 api_key=... / api_key_2=...，多账号免费池）
# 用户令 0929：key 在超级AI工作站 config/llm.secret.ini；除总包智库答题烧 KB 积分外全链免费
ZHIPU_SECRET_FILE = SECRETS_DIR / "zhipu.secret"
ZHIPU_FREE_MODELS = ("glm-4-flash-250414", "glm-4.7-flash", "glm-4.5-flash")
ZHIPU_TIMEOUT_SEC = 30

# 微信小程序
MP_SECRET_FILE = SECRETS_DIR / "zongbao_qianwen_mp.secret"
WX_APPID = "wx5cee1574ce45819b"

# 虚拟支付（wx.requestVirtualPayment 道具直购 · 企业主体合规通道）
# 密钥文件键：offer_id= / product_id= / export_product_id= / env=（0 正式 1 沙箱）/
# sandbox_appkey= / prod_appkey= / report_product_<价格元>=（报告商城分档道具）；
# 后台开通后填写，缺=未开通
VIRTUAL_PAY_FILE = SECRETS_DIR / "virtual_pay.secret"
EXPORT_PRICE_FEN = 10         # 导出价：¥0.1/条（用户令 1008：咨询全免费，仅导出按条收费）
EXPORT_BATCH_MAX = 99         # 批量导出单笔 buyQuantity 上限（支付单护栏）

# ── v0.9.0 报告商城（用户令 1008：研究报告售卖整合进总包AI顾问）──
# 内容目录：镜像内 /app/report_content（report.json + full/ + sample/）；
# 本地/CI 缺省指仓库源目录，tests 走 fixtures 临时目录。
REPORT_CONTENT_DIR = Path(os.environ.get("REPORT_CONTENT_DIR")
                          or (REPO / "report_platform" / "content"))
REPORT_PDF_MAX_BYTES = _env_int("REPORT_PDF_MAX_BYTES", 20 * 1024 * 1024)  # 20MB 手机端可流畅打开的上限
REPORT_HIDDEN_SKUS: tuple = ()   # 强制隐藏（目录不展示）；整理中（可看不可买）走 PDF 判定

# 产品规则（v0.5.0 用户九点令）
FREE_PER_DAY = 6            # 每日免费提问（北京时间 00:00 全量清零，不累计）
REWARD_ACTIONS = ("like", "share", "criticize")  # 互动赠次动作（v0.7.3 用户令：导出退出赠次；每答案每动作一次，总量不封顶）
OPTIMIZE_DAILY_CAP = 10     # AI 优化提问每用户每日次数（护共享 KB 免费池）
PREVIEW_CHARS = 200         # 免费预览字数

# 锅圈（打破砂锅问到底）：热点问题公共展区
POT_OPENID = "pot-curator"  # 锅圈内容落库身份（answers 行 openid，复用答案管线）
POT_PREVIEW_CHARS = 200     # 锅圈列表答案预览字数（用户令 0930：100→200）

# v0.6.0 100× 弧线（全免费：追问/要点/相关问题走智谱接地，海报走 Pillow，绝不烧 KB）
FOLLOWUP_PER_ANSWER_DAILY = 10   # 追问双日限①：每答案每人每日
FOLLOWUP_GLOBAL_DAILY = 20       # 追问双日限②：每人每日全局（跨答案）
FOLLOWUP_MAX_CHARS = 200         # 追问长度上限
POSTER_QR_ENV_VERSION = "release"   # 海报码指向版本：发布当日切 release 一行即切（0930 修正：正式版未发布前置 release 会开出旧 1.0.7）

# 引擎护栏（账号安全四件套）
KB_MIN_INTERVAL_SEC = 5     # 节流：两问最小间隔
KB_DAILY_POINT_CAP = 90     # 日积分硬顶（网页池每问约3点 → 30问）
KB_BREAKER_THRESHOLD = 4    # 熔断阈值
KB_BREAKER_RECOVERY_SEC = 600
KB_ASK_TIMEOUT_SEC = 180
KB_STREAM_TIMEOUT_SEC = 150  # v0.7.0 SSE 流消费硬上限（超时带已收文本走兜底轮询）
KB_POLL_INTERVAL_SEC = 5
KB_POLL_MAX_ROUNDS = 24     # 24×5s=120s（兜底线）
MIN_ANSWER_LEN = 100        # 低于此长度视为未完成

ENGINE_TOKEN_FILE = SECRETS_DIR / "qianwen_engine_hmac.key"
