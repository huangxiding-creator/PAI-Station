// pages/index/index.ts — 商城首页：搜索（防抖 300ms）/榜单 tab/三筛选 chips/省份入口/
// 报告卡（封面占位+标签+分转元价格）/下拉刷新+上拉分页；catalog 双源=包内秒开+接口刷新（NFR-02）
import { loadCatalog, isUnlocked } from '../../utils/store'
import { api, onPayGray } from '../../utils/api'
import {
  normalizeReport,
  aggregateFacets,
  mergeFacets,
  layerHintText,
  ReportCard,
  Facets,
  ServerFacets,
  ServerItem,
} from '../../utils/format'

type MallItem = ReportCard & { unlocked: boolean }

const PAGE_SIZE = 20

Page({
  data: {
    tab: 'hot' as 'hot' | 'new',
    items: [] as MallItem[],
    facets: { provinces: [], ownerTypes: [], industries: [] } as Facets,
    province: '',
    ownerType: '',
    industry: '',
    page: 1,
    total: 0,
    hasMore: false,
    loading: false,
    netDown: false,
    // 搜索态
    query: '',
    searching: false,
    searchItems: [] as MallItem[],
    layerHint: '',
    hotWords: [] as string[],
    fallbackHint: false,
    payGrayed: false,
  },
  searchTimer: -1,
  offPayGray: null as null | (() => void),

  onLoad() {
    // 包内 catalog 先渲染（首屏秒开），再接口增量刷新
    const bundled = loadCatalog().reports.map((r) => normalizeReport(r))
    this.setData({ items: this.decorate(bundled), facets: aggregateFacets(bundled) })
    this.refresh()
    this.offPayGray = onPayGray(() => this.setData({ payGrayed: true }))
  },

  onUnload() {
    if (this.searchTimer >= 0) clearTimeout(this.searchTimer)
    if (this.offPayGray) this.offPayGray()
  },

  onShow() {
    this.setData({ items: this.decorate(this.data.items) })
  },

  decorate(list: ReportCard[]): MallItem[] {
    return list.map((r) => ({ ...r, unlocked: isUnlocked(r.id) }))
  },

  buildParams(page: number) {
    const { tab, province, ownerType, industry } = this.data
    return {
      tab,
      province,
      owner_type: ownerType,
      industry,
      page,
      page_size: PAGE_SIZE,
    }
  },

  async fetchPage(page: number): Promise<void> {
    this.setData({ loading: true })
    try {
      const res = await api.catalog(this.buildParams(page))
      const items = (res.items || []).map((raw) => normalizeReport(raw as unknown as ServerItem))
      const merged = page > 1 ? [...this.data.items, ...items] : items
      const seen = new Set<string>()
      const dedup = merged.filter((r) => (seen.has(r.id) ? false : seen.add(r.id)))
      const serverFacets = (res as unknown as { facets?: ServerFacets }).facets
      const aggregated = aggregateFacets([...this.data.items, ...items])
      this.setData({
        items: this.decorate(dedup),
        page,
        total: res.total,
        hasMore: page * PAGE_SIZE < res.total,
        netDown: false,
        facets: mergeFacets(serverFacets, aggregated),
      })
    } catch (err) {
      // 引擎不可达：保持包内列表可逛（NFR-11 服务维护+试读兜底）
      this.setData({ netDown: true, hasMore: false })
    } finally {
      this.setData({ loading: false })
    }
  },

  refresh(): Promise<void> {
    return this.fetchPage(1)
  },

  onTabTap(e: WechatMiniprogram.TouchEvent) {
    const tab = e.currentTarget.dataset.tab as 'hot' | 'new'
    if (tab === this.data.tab) return
    this.setData({ tab })
    this.refresh()
  },

  onChipTap(e: WechatMiniprogram.TouchEvent) {
    const { field, value } = e.currentTarget.dataset as { field: string; value: string }
    const cur = (this.data as unknown as Record<string, string>)[field]
    const patch = { [field]: cur === value ? '' : value } as Record<string, string>
    this.setData(patch)
    this.refresh()
  },

  async onPullDownRefresh() {
    await this.refresh()
    wx.stopPullDownRefresh()
  },

  async onReachBottom() {
    if (!this.data.hasMore || this.data.loading) return
    await this.fetchPage(this.data.page + 1)
  },

  // —— 搜索（输入防抖 300ms → GET /search）——
  onSearchInput(e: { detail: { value: string } }) {
    const q = e.detail.value
    this.setData({ query: q })
    if (this.searchTimer >= 0) clearTimeout(this.searchTimer)
    this.searchTimer = setTimeout(() => this.doSearch(q), 300)
  },

  onSearchConfirm() {
    if (this.searchTimer >= 0) clearTimeout(this.searchTimer)
    this.doSearch(this.data.query)
  },

  async doSearch(q: string) {
    const kw = String(q || '').trim()
    if (!kw) {
      this.setData({ searching: false, searchItems: [], layerHint: '', fallbackHint: false })
      return
    }
    try {
      const res = await api.search(kw)
      const items = (res.items || []).map((raw) => normalizeReport(raw as unknown as ServerItem))
      this.setData({
        searching: true,
        searchItems: this.decorate(items),
        layerHint: layerHintText(res.layer_used, kw),
        hotWords: res.hot_words || [],
        fallbackHint: !!res.fallback_hint,
        netDown: false,
      })
    } catch {
      this.setData({ searching: true, searchItems: [], layerHint: '', fallbackHint: true, netDown: true })
    }
  },

  onHotWordTap(e: WechatMiniprogram.TouchEvent) {
    const w = e.currentTarget.dataset.word as string
    this.setData({ query: w })
    this.doSearch(w)
  },

  onClearSearch() {
    this.setData({ query: '', searching: false, searchItems: [], layerHint: '', fallbackHint: false })
  },

  onOpenReport(e: WechatMiniprogram.TouchEvent) {
    const id = e.currentTarget.dataset.id as string
    wx.navigateTo({ url: `/pages/detail/detail?id=${id}` })
  },
})
