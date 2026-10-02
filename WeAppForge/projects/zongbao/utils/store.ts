// utils/store.ts — 研报目录装载 + 已购权益/收藏本地镜像（云端发货与收藏服务端态为准，本地仅离线兜底）
import { appConfig } from '../config/index'

export interface ReportMeta {
  id: string
  title: string
  summary: string
  price: number // 单位：分
  chapterCount: number
  source: string
  publishedAt: string
  province?: string
  industry?: string
  owner_type?: string
}

export interface Catalog {
  reports: ReportMeta[]
}

export interface BundledChapter {
  id: string
  title: string
  html: string
}

let catalogCache: Catalog | null = null

export function loadCatalog(): Catalog {
  if (catalogCache) return catalogCache
  try {
    catalogCache = require('../content/catalog.json') as Catalog
    return catalogCache
  } catch (e) {
    console.error('[store] catalog 装载失败', e)
    return { reports: [] }
  }
}

export function getReport(id: string): ReportMeta | undefined {
  return loadCatalog().reports.find((r) => r.id === id)
}

/** 包内章节（试读章带正文，付费章空壳——A 线产物）；装载失败降级空目录不崩 */
export function loadBundledChapters(reportId: string): BundledChapter[] {
  try {
    return require(`../content/reports/${reportId}/chapters.json`) as BundledChapter[]
  } catch (e) {
    console.error('[store] 章节装载失败', e)
    return []
  }
}

// —— 已购权益（本地缓存，支付成功回调的先行动作；云端发货为准）——
const ENTITLE_KEY = 'zongbao_entitlements'

export function getEntitlements(): string[] {
  try {
    return (wx.getStorageSync(ENTITLE_KEY) as string[]) || []
  } catch {
    return []
  }
}

export function isUnlocked(reportId: string): boolean {
  return getEntitlements().includes(reportId)
}

export function unlockLocal(reportId: string): void {
  const next = Array.from(new Set([...getEntitlements(), reportId]))
  wx.setStorageSync(ENTITLE_KEY, next)
}

/** 服务端确认转出（转赠）后移除本地已购镜像（云端态为准；本地镜像仅为离线兜底） */
export function lockLocal(reportId: string): void {
  const next = getEntitlements().filter((id) => id !== reportId)
  wx.setStorageSync(ENTITLE_KEY, next)
}

// —— 收藏本地镜像（服务端态为真源，此处仅离线兜底展示）——
const FAV_KEY = 'zongbao_favorites'

export function getFavoritesLocal(): string[] {
  try {
    return (wx.getStorageSync(FAV_KEY) as string[]) || []
  } catch {
    return []
  }
}

export function favoriteLocal(reportId: string, on: boolean): void {
  const cur = getFavoritesLocal()
  const next = on ? Array.from(new Set([...cur, reportId])) : cur.filter((id) => id !== reportId)
  wx.setStorageSync(FAV_KEY, next)
}

export function trialChapterCount(): number {
  return appConfig.trialChapterCount
}
