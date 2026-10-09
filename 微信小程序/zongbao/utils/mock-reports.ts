// utils/mock-reports.ts — mockApi 夹具数据源（从 mock-fixtures.ts 拆出，守单文件行数预算）：
// 试点 js-shuiwang-2026（真章数据取包内 chapters.json）+ 陪跑样本（撑起筛选/榜单/搜索三层降级）。
import { ServerItem } from './format'

export interface MockReport extends ServerItem {
  chapters: Array<{ id: string; title: string; trialHtml?: string }>
  readingRank: number
}

const PRICE_FEN = 49800

function mockChapters(prefix: string, titles: string[], trialCount: number): MockReport['chapters'] {
  return titles.map((title, i) => ({
    id: `ch${String(i + 1).padStart(2, '0')}`,
    title,
    trialHtml:
      i < trialCount
        ? `<h1>${title}</h1><p>（联调样章）本章为 mock 正文：${prefix}试点样本，用于商城前端走查。</p><p>真实正文由 B 线引擎按权益下发。</p>`
        : undefined,
  }))
}

const CN_ORD = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一']
const APPX = ['项目台账', '统计口径', '全量台账', '资源清单']

/** 陪跑样本标准目录：core 章名（第N章）+ 附录台账四件套，总章数 = core.length + appxCount */
function genTitles(core: string[], appxCount = 4): string[] {
  const chapters = core.map((t, i) => `第${CN_ORD[i]}章  ${t}`)
  const appx = APPX.slice(0, appxCount).map((t, i) => `附录${'ABCD'[i]}  ${t}`)
  return chapters.concat(appx)
}

// 试点报告（真实章节数据取包内 chapters.json）
const SHUIWANG_TITLES = [
  '第一章  研究概述与方法论',
  '第二章  执行摘要与核心发现',
  '第三章  江苏水利建设宏观战略背景',
  '第四章  政策环境与规划体系分析',
  '第五章  市场全景与规模',
  '第六章  区域市场梯度对比',
  '第七章  产业链机会确定性',
  '第八章  重大项目清单专题追踪',
  '第九章  投资规模与资金流向分析',
  '第十章  招标采购与竞争格局',
  '第十一章  时间窗口与行动节奏',
  '第十二章  风险因素与应对',
  '第十三章  商机清单',
  '第十四章  投标策略与缓解建议',
  '第十五章  结果监测与行动指标',
  '附录A  Top 100 商机清单',
  '附录B  数据统计口径',
  '附录C  全量商机台账',
  '附录D  重点商机资源清单',
]

export const MOCK_PRICE_FEN = PRICE_FEN
export const MOCK_ANCHOR_FEN = 188800

export const REPORTS: MockReport[] = [
  {
    id: 'js-shuiwang-2026',
    title: '江苏省水网工程商机研究',
    summary: '16 个官方信源全站采集，江苏水网工程商机全景：市场规模、重大项目、招标节奏与行动窗口。',
    price_fen: PRICE_FEN,
    province: '江苏',
    owner_type: '水利',
    industry: '水网工程',
    chapter_count: 19,
    trial_chapters: 2,
    tags: ['水网', '江苏', '商机清单'],
    published_at: '2026-09-27',
    cover: '',
    readingRank: 1,
    chapters: SHUIWANG_TITLES.map((title, i) => ({
      id: `ch${String(i + 1).padStart(2, '0')}`,
      title,
      // 试读正文由 bundledChapters() 取包内真数据
    })),
  },
  {
    id: 'js-guanqu-2026',
    title: '江苏灌区现代化改造商机研究',
    summary: '大型灌区续建配套与现代化改造专项资金项目盘点，覆盖徐州、淮安、盐城核心灌区。',
    price_fen: PRICE_FEN,
    province: '江苏',
    owner_type: '水利',
    industry: '灌区改造',
    chapter_count: 12,
    trial_chapters: 2,
    tags: ['灌区', '江苏'],
    published_at: '2026-09-26',
    cover: '',
    readingRank: 3,
    chapters: mockChapters('灌区', genTitles(['研究概述', '执行摘要', '专项资金政策', '重点灌区盘点', '商机清单', '行动建议', '风险与应对', '监测指标']), 2),
  },
  {
    id: 'zj-chouneng-2026',
    title: '浙江省抽水蓄能商机研究',
    summary: '浙江抽水蓄能中长期规划站点全梳理：投资主体、EPC 格局与设备供应窗口。',
    price_fen: PRICE_FEN,
    province: '浙江',
    owner_type: '能源',
    industry: '抽水蓄能',
    chapter_count: 15,
    trial_chapters: 2,
    tags: ['抽水蓄能', '浙江'],
    published_at: '2026-09-25',
    cover: '',
    readingRank: 2,
    chapters: mockChapters('抽水蓄能', genTitles(['研究概述', '执行摘要', '规划站点全景', '投资主体分析', 'EPC 竞争格局', '设备供应窗口', '商机清单', '时间窗口', '风险因素', '投标策略', '监测指标']), 2),
  },
  {
    id: 'gd-guijiao-2026',
    title: '广东省城际轨道交通机遇研究',
    summary: '珠三角城际铁路新一轮建设计划解读：线路时序、标段划分与投标窗口。',
    price_fen: PRICE_FEN,
    province: '广东',
    owner_type: '交通',
    industry: '轨道交通',
    chapter_count: 14,
    trial_chapters: 2,
    tags: ['轨道交通', '广东'],
    published_at: '2026-09-24',
    cover: '',
    readingRank: 4,
    chapters: mockChapters('城际轨道', genTitles(['研究概述', '执行摘要', '建设计划解读', '线路时序', '标段划分', '竞争格局', '商机清单', '投标窗口', '风险与应对', '监测指标']), 2),
  },
  {
    id: 'sd-gangkou-2026',
    title: '山东港口航道提升研究',
    summary: '山东世界级港口群建设行动方案落地追踪：航道整治、码头泊位与疏港体系机会。',
    price_fen: PRICE_FEN,
    province: '山东',
    owner_type: '交通',
    industry: '港口航道',
    chapter_count: 13,
    trial_chapters: 2,
    tags: ['港口', '山东'],
    published_at: '2026-09-23',
    cover: '',
    readingRank: 5,
    chapters: mockChapters('港口航道', genTitles(['研究概述', '执行摘要', '行动方案追踪', '航道整治机会', '码头泊位机会', '疏港体系机会', '商机清单', '风险与应对', '监测指标']), 2),
  },
]

export function hotWords(): string[] {
  return ['江苏水网', '商机清单', '抽水蓄能']
}
