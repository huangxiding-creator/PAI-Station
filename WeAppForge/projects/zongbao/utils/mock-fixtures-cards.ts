// utils/mock-fixtures-cards.ts — mockApi 商机卡（情报裂变 2.0）夹具与路由处理器（契约 v2 纠偏后）：
// 契约1 GET /cards/{card_id}（公开落地页：无 Bearer 也可）→ {card, report}
// 契约2 GET /cards/by-report/{rid}（匿名/未购=前 3 张 + locked:true + total；Bearer 且已购=全量分页）
// 契约3 GET /cards/resolve?scene=（卡二维码 scene → {card_id}；解析失败恒 200 降级 {card_id:''}，同 invite/scan 哲学）
// card_id 为不透明字符串，真实形态 <report_id>-cNNN（本文件不做任何格式正则校验）；
// amount=展示串（可为空串，空则整行隐藏）/ amount_raw=原始文本串（非数字）；
// owner/stage/window 可为空串或占位 '-'（渲染层跳过，province 恒有值）；source_chapter 引擎已富化为显示串直渲染。
// 注册方式照 mock-fixtures-p1.ts 的 handleP1 惯例：导出 handleCards(method,route,q,deps) 供接线方注入依赖；
// mock-fixtures.ts 路由表不在本任务文件清单内，故接线位在 utils/api.ts 尾部追加段（mockApi 分支走 mockCardsRequest）。
// 鉴权/已购态不自建影子状态：经 mockRequest('GET','/me') 从同一 mock 会话推导（单一状态源）。
// 密钥卫生：本文件不含任何密钥/凭据类字段（卫生扫描断言目标）。
import { REPORTS } from './mock-reports'
import { mockRequest } from './mock-fixtures'

/** 商机卡条目（契约1 card 形状，字段名冻结不得改动；amount/amount_raw 均为字符串） */
export interface MockCard {
  id: string
  report_id: string
  title: string
  amount: string
  amount_raw: string
  owner: string
  stage: string
  window: string
  province: string
  source_chapter: string
  summary: string
}

/** 夹具样本：江苏省份为主，金额/阶段/窗口多样化；含一张金额富卡与一张全空属性行瘦卡 */
export const CARDS: MockCard[] = [
  {
    id: 'js-shuiwang-2026-c003',
    report_id: 'js-shuiwang-2026',
    title: '江苏水网改造·城区管网更新标段商机',
    amount: '1.2亿',
    amount_raw: '1.2亿元',
    owner: '江苏省水务集团',
    stage: '招标阶段',
    window: '2026-10 至 2026-12',
    province: '江苏',
    source_chapter: '第 13 章 · 商机清单',
    summary:
      '设区市老旧管网更新年度包即将分批挂网，首批涵盖排水管网约 120 公里。资金来源为专项债+市级配套，业主已明确分标段招标意向，具备市政一级资质联合体优势窗口。',
  },
  {
    id: 'js-shuiwang-2026-c017',
    report_id: 'js-shuiwang-2026',
    title: '江苏水网改造·泵站智能化改造商机',
    amount: '6800万',
    amount_raw: '6800万元',
    owner: '南京水务集团',
    stage: '立项阶段',
    window: '2026-11 至 2027-03',
    province: '江苏',
    source_chapter: '第 8 章 · 重大项目清单专题追踪',
    summary:
      '重点排涝泵站自动化与远程集控改造进入立项公示期，涉及 14 座泵站的 SCADA 与水情感知设备更新。立项后通常 6-9 个月进入采购，设备集成商可提前对接业主技术标准。',
  },
  {
    id: 'js-shuiwang-2026-c021',
    report_id: 'js-shuiwang-2026',
    title: '江苏水网改造·雨污分流二期商机',
    amount: '2.4亿',
    amount_raw: '2.4亿元',
    owner: '苏州市水务局',
    stage: '可研阶段',
    window: '2027-01 至 2027-06',
    province: '江苏',
    source_chapter: '附录A · Top 100 商机清单',
    summary:
      '古城片区雨污分流二期工程可研正在编制，总投资较一期提升约三成。历史水质考核压力下推进确定性高，设计咨询与跟踪审计单位可先行切入，施工标段预计分四个包。',
  },
  {
    id: 'js-shuiwang-2026-c028',
    report_id: 'js-shuiwang-2026',
    title: '江苏水网改造·智慧水务平台商机',
    amount: '3500万',
    amount_raw: '3500万元',
    owner: '江苏省水务集团',
    stage: '招标阶段',
    window: '2026-12 至 2027-02',
    province: '江苏',
    source_chapter: '第 13 章 · 商机清单',
    summary:
      '省级智慧水务监管平台二期启动招标，覆盖数据中台、漏损分析与 GIS 一张图三大模块。一期承建方具备续约惯性，新进厂商宜以漏损算法与行业模型差异化切入。',
  },
  {
    id: 'js-shuiwang-2026-c035',
    report_id: 'js-shuiwang-2026',
    title: '江苏水网改造·原水管线迁建商机',
    amount: '9600万',
    amount_raw: '9600万元',
    owner: '无锡市水务集团',
    stage: '初步设计阶段',
    window: '2027-03 至 2027-09',
    province: '江苏',
    source_chapter: '第 8 章 · 重大项目清单专题追踪',
    summary:
      '配合铁路扩能工程的原水管线迁建专项，双线敷设约 18 公里，初设评审已排期。迁建类项目工期刚性，顶管与非开挖施工能力是资格审关键项，宜早锁劳务与设备资源。',
  },
  {
    id: 'js-shuiwang-2026-c042',
    report_id: 'js-shuiwang-2026',
    title: '江苏水网改造·农村供水提质商机',
    amount: '1.85亿',
    amount_raw: '1.85亿元',
    owner: '江苏省水利厅',
    stage: '规划阶段',
    window: '2027-05 至 2027-12',
    province: '江苏',
    source_chapter: '附录C · 全量商机台账',
    summary:
      '城乡供水一体化提质三年行动进入规划编制，苏北五市为主战场，单村改造小散标段将批量释放。县级水务平台公司为实际业主，区域属地资源与垫资能力决定拿单胜负手。',
  },
  {
    id: 'js-guanqu-2026-c005',
    report_id: 'js-guanqu-2026',
    title: '江苏灌区现代化改造·干渠衬砌标段商机',
    amount: '7300万',
    amount_raw: '7300万元',
    owner: '江苏省水利厅',
    stage: '招标阶段',
    window: '2026-11 至 2027-01',
    province: '江苏',
    source_chapter: '第 13 章 · 商机清单',
    summary:
      '大型灌区续建配套专项资金首批干渠衬砌标段即将挂网，涵盖徐州、淮安两处核心灌区。资金为中央+省级专项，回款信誉佳，冬春施工窗口固定，适合水利施工企业排产。',
  },
  {
    // 瘦卡样例：金额空（整行隐藏）、owner='-' 占位、stage/window 空串（属性行只剩省份）
    id: 'js-guanqu-2026-c011',
    report_id: 'js-guanqu-2026',
    title: '江苏灌区现代化改造·计量设施商机',
    amount: '',
    amount_raw: '',
    owner: '-',
    stage: '',
    window: '',
    province: '江苏',
    source_chapter: '第 13 章 · 商机清单',
    summary:
      '灌区用水计量体系升级处于早期线索阶段，金额与业主信息待披露。农业水价改革政策驱动明确，可先在报告全量台账中跟踪，设备厂商宜结合区域水资源监控平台提前渗透。',
  },
]

interface Resp {
  status: number
  body: unknown
}

const err = (status: number, code: string, message: string): Resp => ({ status, body: { code, message } })
const ok = (body: unknown): Resp => ({ status: 200, body })

function parseQuery(path: string): { route: string; q: Record<string, string> } {
  const [route, qs] = path.split('?')
  const q: Record<string, string> = {}
  String(qs || '').split('&').forEach((kv) => {
    if (!kv) return
    const [k, v] = kv.split('=')
    q[k] = decodeURIComponent(v || '')
  })
  return { route, q }
}

function reportRefOf(reportId: string): { id: string; title: string; price_fen: number; cover: string; trial_chapters: number } {
  const r = REPORTS.find((x) => x.id === reportId)
  return {
    id: reportId,
    title: r ? r.title : `研报 ${reportId}`,
    price_fen: r ? r.price_fen : 49800,
    cover: (r && r.cover) || '',
    trial_chapters: (r && r.trial_chapters) || 2,
  }
}

/** 卡路由处理器依赖（鉴权/已购态由接线方注入；注册方式同 handleP1 的 deps 注入惯例） */
export interface CardsDeps {
  authed: boolean
  owned: Set<string>
}

/** 商机卡 mock 路由：命中返回 {status,body}；非卡路由返回 null（回落调用方兜底） */
export function handleCards(method: string, route: string, q: Record<string, string>, deps: CardsDeps): Resp | null {
  // —— 契约3 GET /cards/resolve?scene=（解析失败恒 200 降级 card_id:''；card_id 不透明不做格式校验）——
  if (route === '/cards/resolve' && method === 'GET') {
    const scene = q.scene || ''
    // scene 容错形态：c=<card_id> 段（与 reader r=/i= 同族）；也容忍整串即完整 card_id 直传
    const seg = /(?:^|&)c=([^&]+)/.exec(scene)
    const cardId = seg ? seg[1] : scene
    return ok({ card_id: CARDS.some((c) => c.id === cardId) ? cardId : '' })
  }

  // —— 契约2 GET /cards/by-report/{rid}（两态：匿名/未购 locked 前 3 张；已购全量分页）——
  if (route.startsWith('/cards/by-report/') && method === 'GET') {
    const rid = route.slice('/cards/by-report/'.length)
    if (!REPORTS.some((r) => r.id === rid)) return err(404, 'REPORT_NOT_FOUND', '报告不存在或已下架')
    const all = CARDS.filter((c) => c.report_id === rid)
    const page = Math.max(1, Number(q.page) || 1)
    if (deps.authed && deps.owned.has(rid)) {
      const pageSize = Math.min(50, Math.max(1, Number(q.page_size) || 20))
      const items = all.slice((page - 1) * pageSize, page * pageSize)
      return ok({ cards: items, total: all.length, page, page_size: pageSize })
    }
    return ok({ cards: all.slice(0, 3), total: all.length, locked: true, page })
  }

  // —— 契约1 GET /cards/{card_id}（公开；404 标准错误信封 CARD_NOT_FOUND）——
  if (route.startsWith('/cards/') && method === 'GET') {
    const card = CARDS.find((c) => c.id === route.slice('/cards/'.length))
    if (!card) return err(404, 'CARD_NOT_FOUND', '商机卡不存在或已失效')
    return ok({ card: { ...card }, report: reportRefOf(card.report_id) })
  }

  return null
}

/** 鉴权/已购态推导：经 /me 从 mock-fixtures 单一会话状态源取（不自建影子态） */
async function sessionOf(tok?: string): Promise<CardsDeps> {
  const r = await mockRequest('GET', '/me', undefined, tok)
  if (r.status !== 200) return { authed: false, owned: new Set<string>() }
  const body = (r.body || {}) as { entitlements?: Array<{ report_id: string }> }
  return { authed: true, owned: new Set((body.entitlements || []).map((e) => e.report_id)) }
}

/** mock 入口：与 mockRequest 同构签名（{status,body} 应答，30ms 延迟对齐既有夹具体感） */
export function mockCardsRequest(method: string, path: string, data?: unknown, tok?: string): Promise<Resp> {
  return new Promise((resolve) => {
    const { route, q } = parseQuery(path)
    const finish = (resp: Resp | null) =>
      setTimeout(() => resolve(resp || err(404, 'NOT_FOUND', `mock 未实现: ${method} ${route}`)), 30)
    // 仅 by-report 需要会话态（locked/owned 判定）；detail/resolve 公开无态
    if (!(route.startsWith('/cards/by-report/') && method === 'GET')) {
      finish(handleCards(method, route, q, { authed: false, owned: new Set<string>() }))
      return
    }
    sessionOf(tok).then((deps) => finish(handleCards(method, route, q, deps)))
  })
}
