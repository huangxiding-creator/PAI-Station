# -*- coding: utf-8 -*-
"""总包学园引擎——配置与常量（ARCHITECTURE §五-1/§六；阈值全为配置项）。"""
from __future__ import annotations

import os
from pathlib import Path

REPO = Path(__file__).resolve().parents[3]          # E:\AI-Station
PKG = Path(__file__).resolve().parent

SECRETS_DIR = REPO / "data" / "secrets"
DATA_DIR = REPO / "data" / "xueyuan"
DB_PATH = DATA_DIR / "db.sqlite"
PDF_DIR = DATA_DIR / "pdfs"            # 双 PDF（read/print）静态区：pdfs/{slug}/{read|print}.pdf
POSTER_DIR = DATA_DIR / "posters"      # 情报卡海报静态区（P1）

# 内容进库源（T-P0-01 进库钩子；ECS 部署时用 XY_CONTENT_DIR 指到 /opt/xueyuan 内容区）
CONTENT_DIR = Path(os.environ.get("XY_CONTENT_DIR") or REPO / "WeAppForge" / "projects" / "zongbao" / "content")
# 引擎侧付费正文区：content/reports/<id>/chapters_full.json（包内 chapters.json 付费章=空壳，
# 服务端按权益下发全量正文的全量源；A 线切片②产物未到位前由部署侧暂存，进库只读不改）
SERVER_CONTENT_DIR = DATA_DIR / "content"

# 微信小程序「总包学园」（A8 判定：projects/zongbao 即本产品前端）
MP_SECRET_FILE = SECRETS_DIR / "xueyuan_mp.secret"   # appid=/appsecret=/name=
WX_APPID = "wxfdb55b184756e89e"

# 虚拟支付（道具直购 short_series_goods，A5）
# 密钥文件三行：offer_id= / product_id= / env=（0 正式 1 沙箱）；
# 文件缺失或字段空 = 未配置 → 相关初始化静默降级（/pay/sign 503，绝不炸）
VIRTUAL_PAY_FILE = SECRETS_DIR / "virtual_pay_xueyuan.secret"
REPORT_PRICE_FEN = 49800             # 单报告统一定价 ¥498（SCHEMAS §2）
TEAM_PRICE_FEN = 99800               # 组队 3 人价 ¥998（FR-P1-10）
PRODUCT_ID = "xy_report_unlock"      # 通用道具 ID（SCHEMAS §5 默认值）

# 试读（A3：试读章正文进包秒开，付费章空壳；与前端 config trialChapterCount 对齐）
TRIAL_CHAPTER_COUNT = 2              # 试读章数（reports.trial_chapters 默认）
TRIAL_RATIO_MIN = 0.15               # 试读占比校验区间（content_pipeline 拆分校验）
TRIAL_RATIO_MAX = 0.25

# 决策卡与详情页（API_DESIGN P0-4）
CHARS_PER_PAGE = 340                 # 每页正文字数估算（docx→PDF 排版实测口径，试点 2 章约 20 页）
ANCHOR_PRICE_FEN = 188800            # 价格锚 ¥1888（FR-P0-03 价格锚话术）
ANCHOR_COPY = "同等深度 1/4 价格"
LOCKED_PREVIEW_COUNT = 3             # 决策卡未解锁结论模糊预览条数（付费章标题前 N 条）
HOT_WORDS_TOP = 8                    # 搜索热词联想 Top N（tags 频次）
RANK_BADGE_TOP = 10                  # 详情页阅读榜徽章可见位次

# 限流与认证（§五-2/§五-5）
RATE_LIMIT_PER_MIN = 60              # 单账号付费章拉取限流：60 次/分，超→429+企微告警
TOKEN_TTL_DAYS = 30                  # Bearer token 有效期（HMAC 载荷 exp）

# XY_FAKE_PAY=1 免验签假支付 dev 闸（与 QW_FAKE_ASK 同款纪律）：
# 仅允许本地 dev 端口起进程；生产端口携此变量启动即拒绝启动（app.assert_fake_pay_allowed）
# 允许端口集见文末 DEV_FAKE_PAY_PORTS（与 LOCAL_DEV_PORT 同源定义）

# 批评评分四层闸（A6；SCHEMAS §6 资格闸参数）
CRITICISM_MIN_CHARS = 50             # 批评字数下限
CRITICISM_MAX_CHARS = 300            # 上限（冗长偏差校正）
REFUND_MONTHLY_LIMIT = 2             # 当月退款次数上限（users.refund_count_month 判据）
AUTO_REFUND_TIER_CAP = 50            # 自动退仅 ≤50% 档；更高档转人工（manual_review）

# 熔断硬门（链路④层④：触发→停「新发起」423+企微当日告警，已公示义务继续履行）
BREAKER_REPORT_REFUND_RATIO = 0.25        # 单报告退款率 >25%
BREAKER_WEEK_REFUND_REVENUE_RATIO = 0.15  # 全站周退款额 >营收 15%

# 引擎 HMAC 密钥（首启自动生成，§五-1；qianwen 同款惯例）
ENGINE_TOKEN_FILE = SECRETS_DIR / "xueyuan_engine_hmac.key"

# 端口口径（§七）：ECS 生产=8871；本地 dev 影子位=8872。
# ⚠ 8870 是 qianwen-engine 在役本地门实例（biaoxun 用），本项目任何操作避开 8870。
CLOUD_PORT = 8871
LOCAL_DEV_PORT = 8872

# XY_FAKE_PAY dev 闸允许端口集（生产 8871 绝不在列；env 可扩如测试桩端口）
DEV_FAKE_PAY_PORTS = {LOCAL_DEV_PORT} | {
    int(p) for p in os.environ.get("XY_DEV_FAKE_PAY_PORTS", "").split(",") if p.strip().isdigit()
}

# ── 海报域（P1；FR-P1-07）——末尾追加键，不触上文任何既有键 ──────────────
POSTER_WIDTH = 1080                 # 朋友圈 3:4 竖版安全线（KNOWLEDGE_BASE/viral_poster §6）
POSTER_HEIGHT = 1440
POSTER_VERSION = "v1"               # 模板版本：改模板→升版本→(user,report,version) 缓存图自动重生成
POSTER_FONT_DIR = PKG.parent / "assets" / "fonts"   # 自托 CJK 字体（ECS fc-list=0，硬前提）
POSTER_FONT_REGULAR = POSTER_FONT_DIR / "NotoSansSC-Regular.otf"   # SIL OFL 1.1
POSTER_FONT_BOLD = POSTER_FONT_DIR / "NotoSansSC-Bold.otf"         # SIL OFL 1.1
POSTER_QR_DIR = DATA_DIR / "qrs"    # 小程序码预生成池（tools/qr_pool.py 灌；文件名=quote(scene).png）
POSTER_CTA = "长按识别 免费读前 20 页"   # 行动指令（FR-P1-07 字面；试读策略变化改此处）
POSTER_BRAND = "总包学园"           # 品牌条主名（社交货币定位，非卖课腔）
POSTER_BRAND_SUB = "总包创研院 出品"  # 品牌条副名（信任背书）
POSTER_SCENE_MAX = 32               # scene 可见字符官方上限（溢出走 poster_code 短码映射）

# ── P2 增值域（FR-P2-01~04；末尾追加键，不触上文任何既有键）─────────────
SEARCH_OWNED_RATE_PER_MIN = 30      # 已购检索限流（API_DESIGN §一 search 档：30 次/分）
SEARCH_OWNED_SNIPPET_RADIUS = 40    # 已购检索 snippet 泄漏控制：命中句 ±40 字（与 trial 防泄漏纪律一致）
SEARCH_OWNED_PAGE_SIZE = 20         # 已购检索默认页大小（上限同通例 50）
CHAT_QUESTION_MAX = 500             # AI 伴读问句长度上限（字符）
CHAT_TOP_K = 3                      # 检索式应答引用段条数上限
SUBSCRIBE_MAX_PER_KIND = 20         # 单类（省份/主题）订阅数上限

# ── 情报官体系（AGREEMENT_COPY v1.2 §六「情报官体系与有效带新规则」；末尾追加键，
#    不触上文任何既有键）──────────────────────────────────────────────
LADDER_THRESHOLDS = (1, 5, 20)        # L1/L2/L3 有效带新累计门槛（位；协议逐字）
LADDER_NAMES = ("观察员", "分析师", "情报官")   # 等级名（/me invite 契约回显）
INTELLECT_L2_FEN = 20000              # L2「分析师」达成奖 200 书券（分）
INTELLECT_L3_FEN = 100000             # L3「情报官」达成奖 1000 书券（分）
DWELL_EFFECTIVE_SECONDS = 180         # 停留腿达标：进入后累计满 3 分钟（协议口径）
DWELL_REPORT_CLAMP_MAX = 600          # 单次上报秒数 clamp 上限 [1,600]
DWELL_RELATION_TOTAL_CAP = 600        # 每关系累计上限（刷量防线：超封顶不计入）

# ── 商机情报卡域（w3a-2-E；末尾追加键，不触上文任何既有键）──────────────
# 数据区=CONTENT_DIR/cards/*.json（只读，cards_extract 产物；随内容区走，
# ECS XY_CONTENT_DIR 同位）。scene 冻结格式 c=<card_id>&i=<uid>。
CARD_TEASER_COUNT = 3                  # 未购 by-report 预览卡数（冻结契约：前 3 张）
CARD_PAGE_SIZE_DEFAULT = 20            # 已购卡分页默认页大小（同 /catalog 通例）
CARD_PAGE_SIZE_MAX = 50                # 已购卡分页页大小上限（同 /catalog 通例）
CARD_POSTER_VERSION = "v1"             # 卡海报模板版本（改模板→升版本→缓存图重生成）
CARD_POSTER_CTA = "长按识别 查看商机详情"  # 卡海报行动指令（与报告海报 CTA 分置）
CARD_H5_MORE_LINKS = 3                 # H5 长尾页「更多商机」同域内链数（有金额卡优先）

# ── 榜单/故事/K 看板域（3c；末尾追加键，不触上文任何既有键）─────────────
# 三榜单周快照（rank_week ISO 周冻结）+ 一周商机故事（确定性轮换零模型）+
# K 看板四级漏斗（运营令牌闸）。公式透明随 payload 下发（新闻感=数据本身）。
RANK_PROVINCE_TOP = 10                 # 省级商机热度榜条数
RANK_MAX_DEALS_TOP = 10                # 最大单榜条数（库内口径，见 leaderboard 文档）
RANK_NEW_OWNERS_TOP = 10               # 新入榜业主条数
RANK_STORY_POOL = 12                   # 一周故事候选池（金额 TOP-N 按 ISO 周轮换）
OPERATOR_TOKEN_FILE = SECRETS_DIR / "xueyuan_operator.key"  # K 看板运营令牌（X-Operator-Token 常时比较）
