// tests/xy-pages-smoke.test.mjs — mockApi 模式全页面走查（自动化腿）：本机无微信开发者工具 CLI，
// 以 Page 桩直接驱动四页 onLoad/onShow 数据流（wx 桩+mock 引擎），逐页断言渲染数据态。
// 页面×数据态×期望的余下人工走查项见 RUN_LEDGER 走查表。
import { test, beforeEach } from 'node:test'
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'
import { resolve } from 'node:path'

const require = createRequire(import.meta.url)
const PROJECT = resolve('E:/AI-Station/微信小程序/zongbao')

const storage = new Map()
const navs = []
const toasts = []
const modals = []
let loginCount = 0

globalThis.__XY_BASE__ = 'http://stub-engine'
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
  removeStorageSync: (k) => storage.delete(k),
  login: (o) => {
    loginCount += 1
    o.success({ code: `smoke-${loginCount}` })
  },
  request: () => {
    throw new Error('mock 模式不应触网')
  },
  showToast: (o) => toasts.push(o.title),
  showModal: (o) => {
    modals.push(o.content)
    if (o.success) o.success({ confirm: true })
  },
  navigateTo: (o) => navs.push(o.url),
  redirectTo: (o) => navs.push('REDIRECT:' + o.url),
  stopPullDownRefresh: () => {},
  setClipboardData: (o) => o.success && o.success(),
}

const cfg = require(resolve(PROJECT, 'config/index.js'))

// Page 桩：按文件缓存页面定义（require 缓存下二次 require 不再触发 Page()）
const pageDefs = new Map()
let currentFile = ''
globalThis.Page = (def) => {
  pageDefs.set(currentFile, def)
}
function makePage(file) {
  currentFile = file
  require(resolve(PROJECT, file))
  const def = pageDefs.get(file)
  const inst = Object.create(def)
  inst.data = JSON.parse(JSON.stringify(def.data || {}))
  inst.setData = function (patch) {
    Object.assign(this.data, patch)
  }
  return inst
}

// 清 require 缓存后重载页面定义（flag 关→开的快照形态验证用）
function makePageFresh(file) {
  delete require.cache[resolve(PROJECT, file)]
  return makePage(file)
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

beforeEach(() => {
  storage.clear()
  navs.length = 0
  toasts.length = 0
  modals.length = 0
  loginCount = 0
  cfg.appConfig.mockApi = true
  cfg.appConfig.features.virtualPay = false
  cfg.appConfig.features.p1 = true
})

test('首页：包内秒开→接口刷新 5 份；筛选聚合；搜索命中与零命中降级', async () => {
  const page = makePage('pages/index/index.js')
  page.onLoad()
  assert.ok(page.data.items.length >= 1, '包内 catalog 先渲染（首屏秒开）')
  await sleep(300)
  assert.equal(page.data.items.length, 5, '接口刷新后 5 份研报')
  assert.equal(page.data.items[0].id, 'js-shuiwang-2026', '阅读榜榜首=试点')
  assert.equal(page.data.items[0].priceYuan, '498', '价格分转元')
  assert.ok(page.data.facets.provinces.includes('江苏'), '省份筛选聚合')
  assert.ok(page.data.facets.industries.includes('抽水蓄能'), '行业筛选聚合')

  // 搜索：命中（L1）
  page.onSearchInput({ detail: { value: '抽水蓄能' } })
  await sleep(450) // 防抖 300ms + mock 30ms
  assert.equal(page.data.searching, true)
  assert.ok(page.data.searchItems.some((i) => i.id === 'zj-chouneng-2026'))

  // 搜索：零命中 → 降级提示 + 热词（榜单补位信号）
  page.onSearchInput({ detail: { value: '零命中词xyzq' } })
  await sleep(450)
  assert.equal(page.data.fallbackHint, true)
  assert.ok(page.data.hotWords.length > 0)

  // 筛选：省份=浙江
  page.onClearSearch()
  page.onChipTap({ currentTarget: { dataset: { field: 'province', value: '浙江' } } })
  await sleep(200)
  assert.ok(page.data.items.every((i) => i.province === '浙江'), '省份筛选子集正确')

  // 卡片点击 → 详情页
  page.onOpenReport({ currentTarget: { dataset: { id: 'zj-chouneng-2026' } } })
  assert.ok(navs[0].includes('/pages/detail/detail?id=zj-chouneng-2026'))
})

test('详情页：决策卡全要素+价格锚+预览三件套+披露与发票弹层', async () => {
  const page = makePage('pages/detail/detail.js')
  page.onLoad({ id: 'js-shuiwang-2026' })
  await sleep(300)
  assert.ok(page.data.view, '详情就绪')
  assert.equal(page.data.decision.readText, '已读 20 页')
  assert.equal(page.data.decision.remainText, '全文还有 17 章 · 272 页')
  assert.ok(page.data.decision.lockedCount >= 1, '未解锁核心结论条数')
  assert.equal(page.data.view.anchorYuan, '1888', '行业均价参照锚价')
  assert.ok(page.data.view.related.length >= 1, '三维关联推荐位')
  assert.ok(page.data.view.rankBadge.includes('阅读榜'))
  assert.equal(page.data.view.invoiceEntry, true)

  // 目录树：试读章跳阅读器、付费章提示
  navs.length = 0
  page.onTapToc({ currentTarget: { dataset: { idx: 2, trial: true } } })
  assert.ok(navs[0].includes('/pages/reader/reader?id=js-shuiwang-2026&ch=2'))
  page.onTapToc({ currentTarget: { dataset: { idx: 5, trial: false } } })
  assert.ok(toasts.some((t) => t.includes('付费内容')))

  // 支付前披露半屏弹层（T-P0-26：先弹层，同意后才进支付链）→ 虚拟支付未开通降级（NFR-10）
  await page.onUnlock()
  assert.equal(page.data.paySheetOpen, true, '支付前先开披露弹层')
  assert.ok(page.data.paySheet.bullets.some((b) => b.includes('不支持七天无理由退款')), '2.2 披露逐字')
  await page.onPayAgree()
  assert.ok(toasts.some((t) => t.includes('开通中')), '灰置降级文案')

  // 发票收集（P0 备注级）
  page.onInvoiceOpen()
  page.onInvoiceInput({ detail: { value: '某某建设集团' }, currentTarget: { dataset: { field: 'invoiceTitle' } } })
  page.onInvoiceSave()
  const inv = wx.getStorageSync('zongbao_invoice')
  assert.equal(inv['js-shuiwang-2026'].title, '某某建设集团')

  // 披露入口
  page.onRefundRules()
  assert.ok(page.data.rulesBody.includes('不支持无理由退款'))
  page.onGiftRules()
  assert.ok(page.data.rulesBody.includes('必得'))
})

test('阅读器：试读章 md2blocks 块渲染+付费章锁定占位+末章决策卡+侧栏', async () => {
  const page = makePage('pages/reader/reader.js')
  page.onLoad({ id: 'js-shuiwang-2026' })
  await sleep(400)
  assert.equal(page.data.chapters.length, 19)
  assert.ok(page.data.activeBlocks.length > 3, '试读章按块渲染（真实包内正文）')
  assert.equal(page.data.activeLocked, false)
  assert.ok(page.data.chapters[2].isTrial === false, '第 3 章起付费')

  // 付费章锁定占位（不触网拉正文）
  page.onPickChapter({ currentTarget: { dataset: { index: 10 } } })
  await sleep(100)
  assert.equal(page.data.activeLocked, true)
  assert.equal(page.data.activeBlocks.length, 0)

  // 试读末章（ch=2）后决策卡块
  page.onPickChapter({ currentTarget: { dataset: { index: 1 } } })
  await sleep(100)
  assert.equal(page.data.activeIdx, 1)
  assert.equal(page.data.lastTrialIdx, 1)
  assert.ok(page.data.decision, '决策卡数据就绪')

  // 侧栏开关
  page.onToggleSidebar()
  assert.equal(page.data.sidebarOpen, true)
  page.onCloseSidebar()
  assert.equal(page.data.sidebarOpen, false)

  // scene 容错：坏 scene 归因降级不报错（默认取目录首篇）
  const scenePage = makePage('pages/reader/reader.js')
  scenePage.onLoad({ scene: 'garbage' })
  await sleep(50)
  assert.equal(scenePage.data.reportId, 'js-shuiwang-2026', '坏 scene 降级到目录首篇')
})

test('我的页：服务端已购/收藏为真源，收藏动作即时反映', async () => {
  const page = makePage('pages/me/me.js')
  page.onShow()
  await sleep(300)
  assert.equal(page.data.offline, false)
  assert.equal(page.data.owned.length, 0, '初始未购')

  // 经详情页收藏 → /me 收藏即时出现（服务端态）
  const detail = makePage('pages/detail/detail.js')
  detail.onLoad({ id: 'gd-guijiao-2026' })
  await sleep(200)
  await detail.onFavorite()
  assert.equal(detail.data.favorited, true)

  page.onShow()
  await sleep(300)
  assert.equal(page.data.favs.length, 1)
  assert.ok(page.data.favs[0].id === 'gd-guijiao-2026')

  // P1 赠品架随 p1 flag（config/features 总开关）：默认开→tab 可见；关（体验版快照形态）→重载后隐藏
  assert.equal(cfg.appConfig.features.p1, true, 'p1 flag 默认开')
  assert.equal(page.data.giftTabEnabled, true, 'p1 开→赠品架 tab 可见')
  cfg.appConfig.features.p1 = false
  const pageFlagOff = makePageFresh('pages/me/me.js')
  assert.equal(pageFlagOff.data.giftTabEnabled, false, 'p1 关→赠品架 tab 隐藏')
  cfg.appConfig.features.p1 = true
})
