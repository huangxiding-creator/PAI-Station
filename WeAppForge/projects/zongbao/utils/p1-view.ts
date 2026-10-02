// utils/p1-view.ts — P1 展示层纯函数（detail/reader/me 三页共享；无 wx 依赖可单测）：
// 规则文案一律从 utils/agreement.ts 真源结构化提取（不改真源）；组队/批评/点赞/情报官/书券视图整形+停留上报判据。
import { AGREEMENT_SECTIONS } from './agreement'
import { fenToYuan } from './format'

/** 节内全部 bullets 平铺提取（结构化取文；真源零改动） */
function sectionBullets(key: string): string[] {
  const sec = AGREEMENT_SECTIONS.find((s) => s.key === key)
  if (!sec) return []
  const out: string[] = []
  sec.clauses.forEach((c) =>
    c.blocks.forEach((b) => {
      if (b.kind === 'bullets' && b.items) out.push(...b.items)
    }),
  )
  return out
}

/** 组队规则四条（含 72h 未满员处置，AGREEMENT_COPY §四逐字） */
export function teamRulesLines(): string[] {
  return sectionBullets('team')
}

/** 点赞赠报告规则五条（§三逐字） */
export function likeRulesLines(): string[] {
  return sectionBullets('like')
}

/** 2.4「四、退款映射」bullets（评分达标按比例退款规则，§二逐字） */
export function critRefundRulesLines(): string[] {
  const sec = AGREEMENT_SECTIONS.find((s) => s.key === 'pay')
  const clause = sec && sec.clauses.find((c) => c.id === '2.4')
  if (!clause) return []
  let after = false
  const out: string[] = []
  clause.blocks.forEach((b) => {
    if (b.kind === 'subhead' && b.text === '四、退款映射') {
      after = true
      return
    }
    if (after && b.kind === 'bullets' && b.items) out.push(...b.items)
  })
  return out
}

// —— 点赞结果卡（赠品由服务端指定，前端不本地随机）——
export interface LikeGiftView {
  id: string
  title: string
  rule: string
  granted: boolean
}

export function buildLikeGift(resp: { granted: boolean; granted_report_id: string; gift_rule: string }, titleOf: (id: string) => string): LikeGiftView {
  return {
    id: resp.granted_report_id || '',
    title: resp.granted_report_id ? titleOf(resp.granted_report_id) : '',
    rule: resp.gift_rule || '',
    granted: !!resp.granted,
  }
}

// —— 组队视图（¥998/3 人；进度以服务端 size/capacity 为准）——
export interface TeamView {
  teamId: string
  size: number
  capacity: number
  priceYuan: string
  open: boolean
  progressText: string
  statusText: string
}

export function buildTeamView(raw: { team_id: string; size: number; capacity: number; total_price_fen: number; status: string }): TeamView {
  return {
    teamId: raw.team_id || '',
    size: Number(raw.size) || 0,
    capacity: Number(raw.capacity) || 3,
    priceYuan: fenToYuan(Number(raw.total_price_fen) || 99800),
    open: raw.status !== 'full',
    progressText: `已入队 ${Number(raw.size) || 0}/${Number(raw.capacity) || 3} 人`,
    statusText: raw.status === 'full' ? '已满员成队，全队已获得阅读权益' : '组队进行中，满 3 人全队各得一份',
  }
}

// —— 批评计数器（50-300 字，按码点计数与引擎判据同口径）——
export interface CritCounterView {
  len: number
  text: string
  ok: boolean
}

export function critCounter(content: string): CritCounterView {
  const len = Array.from(content || '').length
  return { len, text: `${len}/300`, ok: len >= 50 && len <= 300 }
}

// —— 情报官卡（v1.2 情报官体系；L1 观察员/L2 分析师/L3 情报官；有效带新计数；馆友标记=L1 解锁）——
export interface LadderStepView {
  level: string
  name: string
  threshold: number
  reached: boolean
  text: string
}

export interface InviteCardView {
  newUsers: number
  required: number
  unlocked: boolean
  earnedYuan: string
  progressText: string
  hint: string
  /** v1.2 情报官等级（'none'|'L1'|'L2'|'L3'） */
  level: string
  levelName: string
  badgeText: string
  effectiveCount: number
  nextThreshold: number | null
  ladder: LadderStepView[]
  progressPct: number
}

/** 三档梯队缺省（与 agreement INVITE_LADDER_RULES 阈值对齐：1/5/20；服务端 ladder 缺席时兜底） */
const LADDER_DEFAULT: ReadonlyArray<{ level: 'L1' | 'L2' | 'L3'; name: string; threshold: number }> = [
  { level: 'L1', name: '观察员', threshold: 1 },
  { level: 'L2', name: '分析师', threshold: 5 },
  { level: 'L3', name: '情报官', threshold: 20 },
]

export interface InviteRaw {
  invited?: Array<{ invitee_uid: string; status: string; ts: string }>
  progress?: { new_users?: number; required?: number; unlocked?: boolean }
  voucher_earned_fen?: number
  /** v1.2 情报官扩展（引擎未升级时缺席，前端按有效带新数推导） */
  level?: string
  level_name?: string
  effective_count?: number
  next_threshold?: number | null
  ladder?: Array<{ level: string; name?: string; threshold?: number; reached?: boolean }>
}

export function buildInviteCard(raw: InviteRaw): InviteCardView {
  // new_users 语义 v1.2 升级为「有效带新数」（=effective_count；引擎未升级时以该字段近似）
  const eff =
    typeof raw.effective_count === 'number' && raw.effective_count >= 0
      ? Math.floor(raw.effective_count)
      : Number(raw.progress && raw.progress.new_users) || 0
  const ladderRaw = Array.isArray(raw.ladder) ? raw.ladder : []
  const ladder: LadderStepView[] = LADDER_DEFAULT.map((fixed) => {
    const hit = ladderRaw.find((x) => x && x.level === fixed.level)
    const threshold = hit && Number(hit.threshold) > 0 ? Math.floor(Number(hit.threshold)) : fixed.threshold
    const name = hit && hit.name ? String(hit.name) : fixed.name
    const reached = hit && typeof hit.reached === 'boolean' ? hit.reached : eff >= threshold
    return { level: fixed.level, name, threshold, reached, text: `${fixed.level} ${name} · ${threshold} 位` }
  })
  // 等级：服务端 level 优先（'none' 或缺席=未达成），缺席时按梯队已达成的最高档推导
  const derived = ladder.reduce<string>((acc, s) => (s.reached ? s.level : acc), 'none')
  const level = raw.level === 'L1' || raw.level === 'L2' || raw.level === 'L3' ? raw.level : derived
  const levelName = level === 'none' ? '未达成' : ladder.filter((s) => s.level === level).map((s) => s.name)[0] || String(raw.level_name || '')
  // 下一档阈值：服务端 next_threshold 优先；缺席=按当前等级取梯队下一档（none→L1；L3 满级=null）
  const curIdx = ladder.findIndex((s) => s.level === level)
  const nextFromLadder =
    level === 'none' ? (ladder[0] ? ladder[0].threshold : null) : curIdx >= 0 && curIdx < ladder.length - 1 ? ladder[curIdx + 1].threshold : null
  const hasServerNext = raw.next_threshold === null || typeof raw.next_threshold === 'number'
  const nextThreshold = level === 'L3' ? null : hasServerNext ? (raw.next_threshold as number | null) : nextFromLadder
  const req = Number(raw.progress && raw.progress.required) || (ladder[0] ? ladder[0].threshold : 1)
  const unlocked = raw.progress && typeof raw.progress.unlocked === 'boolean' ? raw.progress.unlocked : level !== 'none'
  const remainNext = nextThreshold !== null ? Math.max(0, nextThreshold - eff) : 0
  const hint =
    level === 'L3'
      ? '已达成 L3「情报官」：1000 书券已入账+周榜署名「本周情报官」+年度闭门会邀请（远期权益，安排以届时公告为准）'
      : level === 'L2'
        ? `已达成 L2「分析师」：200 书券已入账+新报告首读权；再带 ${remainNext} 位有效带新升 L3「情报官」`
        : level === 'L1'
          ? `已达成 L1「观察员」：馆友标记已点亮，50 书券已入账；再带 ${remainNext} 位有效带新升 L2「分析师」`
          : '邀 1 位有效带新即达成 L1「观察员」：点亮馆友标记并发 50 书券（未达成时进度可见但不发放）'
  return {
    newUsers: eff,
    required: req,
    unlocked,
    earnedYuan: fenToYuan(Number(raw.voucher_earned_fen) || 0),
    progressText: nextThreshold === null ? `有效带新 ${eff} 位 · 梯队满级` : `有效带新 ${eff}/${nextThreshold} 位`,
    hint,
    level,
    levelName,
    badgeText: level === 'none' ? '未达成' : `${level} ${levelName}`,
    effectiveCount: eff,
    nextThreshold,
    ladder,
    progressPct: nextThreshold === null ? 100 : Math.min(100, Math.round((eff / nextThreshold) * 100)),
  }
}

// —— reader 停留上报判据（v1.2 有效带新条件②：停留 ≥30 秒才上报；单段封顶 600 秒与引擎契约一致）——
export const DWELL_MIN_SECONDS = 30
export const DWELL_MAX_SECONDS = 600

/** 停留秒数 → 应上报秒数（<30 返 0 不上报；>600 封顶） */
export function dwellReportSeconds(startMs: number, nowMs: number): number {
  const seconds = Math.floor((nowMs - startMs) / 1000)
  return seconds >= DWELL_MIN_SECONDS ? Math.min(DWELL_MAX_SECONDS, seconds) : 0
}

// —— 书券卡（1 券=1 元；攒满 498 券兑一份）——
export const VOUCHER_REDEEM_FEN = 49800

export interface VoucherCardView {
  balanceFen: number
  balanceYuan: string
  progressPct: number
  canRedeem: boolean
  ledger: Array<{ id: string; amountYuan: string; neg: boolean; sourceText: string; statusText: string; createdAt: string }>
}

const VOUCHER_SOURCE_TEXT: Record<string, string> = {
  invite: '邀请奖励',
  criticism_thanks: '感谢券',
  ios_refund: 'iOS 退款补偿',
  campaign: '活动发放',
}

export function buildVoucherCard(raw: { balance_fen?: number; ledger?: Array<{ id: string; amount_fen: number; source: string; status: string; created_at: string }> }): VoucherCardView {
  const balanceFen = Number(raw.balance_fen) || 0
  const pct = Math.min(100, Math.round((balanceFen / VOUCHER_REDEEM_FEN) * 100))
  return {
    balanceFen,
    balanceYuan: fenToYuan(balanceFen),
    progressPct: pct,
    canRedeem: balanceFen >= VOUCHER_REDEEM_FEN,
    ledger: (raw.ledger || []).map((x) => ({
      id: x.id,
      amountYuan: (x.status === 'used' ? '-' : '+') + fenToYuan(Number(x.amount_fen) || 0),
      neg: x.status === 'used',
      sourceText: VOUCHER_SOURCE_TEXT[x.source] || x.source,
      statusText: x.status === 'used' ? '已消耗' : x.status === 'expired' ? '已过期' : '生效中',
      createdAt: String(x.created_at || '').slice(0, 10),
    })),
  }
}

// —— 批评回执视图（P1-2 受理→P1-3 评分→P1-4 退款 三态合一展示）——
export interface CritReceiptView {
  criticismId: string
  stageText: string
  scoreText: string
  rationale: string
  refundText: string
  canApplyRefund: boolean
  refundApplied: boolean
}

export function buildCritReceipt(
  submitted: { criticism_id: string; stage: string },
  result?: {
    status?: string
    final_score?: number
    llm_scores?: { rationale?: string }
    refund?: { method: string; amount_fen: number; status: string } | null
  },
): CritReceiptView {
  const stage = submitted.stage
  const manual = stage === 'manual_pending' || (result && result.status === 'manual_pending')
  const score = result && typeof result.final_score === 'number' ? result.final_score : null
  const refund = result && result.refund ? result.refund : null
  return {
    criticismId: submitted.criticism_id || '',
    stageText: manual
      ? '已受理：与历史批评相似度较高，转人工复核，结论将在结果页通知'
      : score === null
        ? '已受理：评分进行中，稍后点「刷新评分结果」查看'
        : `评分完成：总分 ${score} 分`,
    scoreText: score === null ? '' : `总分 ${score}（真诚/真实/建设 三维综合）`,
    rationale: (result && result.llm_scores && result.llm_scores.rationale) || '',
    refundText: refund
      ? refund.method === 'voucher'
        ? `总分未达 50 分：不退款，感谢券 ¥${fenToYuan(refund.amount_fen)} 已入账书券`
        : `退款已发起：¥${fenToYuan(refund.amount_fen)}（${refund.method === 'auto' ? '原路自动退回' : '人工审核处理'}，${refund.status}）`
      : score === null
        ? ''
        : score >= 50
          ? '总分 ≥50：可按分数线性申请退款（50 分退 50%，100 分退 100%）'
          : '总分 <50：不退款，发放感谢券致谢',
    canApplyRefund: score !== null && score >= 50 && !refund,
    refundApplied: !!refund,
  }
}
