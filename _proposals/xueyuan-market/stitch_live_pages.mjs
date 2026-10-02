// stitch_live_pages.mjs — T-P0-17 活体页面走查：xy-pages-smoke 的活体变体
// wx.request 桩替换为真实 fetch → 127.0.0.1:8872；appConfig.mockApi=false。
// 断言按引擎真实数据适配（38 报告/试点 17 章试读/搜索 LIKE），口径同源：渲染数据态而非 mock 精确值。
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'

const require = createRequire(import.meta.url)
const PROJECT = 'E:/AI-Station/WeAppForge/projects/zongbao'
const BASE = 'http://127.0.0.1:8872/api/v1'

const storage = new Map()
const navs = []
const toasts = []
const modals = []
let loginCount = 0

globalThis.__XY_BASE__ = BASE
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
  removeStorageSync: (k) => storage.delete(k),
  login: (o) => {
    loginCount += 1
    o.success({ code: `live-pages-${Date.now()}-${loginCount}` })
  },
  request: (o) => {
    // 活体模式：wx.request 桩=真实 HTTP（与 rawWxRequest 同契约应答）
    const headers = { 'Content-Type': 'application/json', ...(o.header || {}) }
    if (!headers.Authorization) delete headers.Authorization
    fetch(o.url, {
      method: o.method,
      headers,
      body: o.data === undefined || o.data === null ? undefined : JSON.stringify(o.data),
    })
      .then(async (r) => {
        const text = await r.text()
        let data = text
        try { data = JSON.parse(text) } catch { /* 非 JSON 原样 */ }
        o.success({ statusCode: r.status, data })
      })
      .catch((e) => o.fail({ errMsg: `request:fail ${e && e.message}` }))
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

const cfg = require(PROJECT + '/config/index.js')
cfg.appConfig.mockApi = false // 活体：真实 HTTP
cfg.appConfig.features.virtualPay = false // 现状：支付未开通

const pageDefs = new Map()
let currentFile = ''
globalThis.Page = (def) => pageDefs.set(currentFile, def)
function makePage(file) {
  currentFile = file
  require(PROJECT + '/' + file)
  const def = pageDefs.get(file)
  const inst = Object.create(def)
  inst.data = JSON.parse(JSON.stringify(def.data || {}))
  inst.setData = function (patch) { Object.assign(this.data, patch) }
  return inst
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))
const results = []
function check(name, cond, note) {
  results.push({ name, ok: !!cond })
  console.log(`[${cond ? 'ok ' : 'FAIL'}] ${name}${note ? ' — ' + note : ''}`)
}

// —— 首页：包内秒开→接口刷新→搜索→筛选 ——
{
  const page = makePage('pages/index/index.js')
  page.onLoad()
  check('首页·包内 catalog 先渲染（秒开）', page.data.items.length >= 1, `bundled=${page.data.items.length}`)
  await sleep(800)
  check('首页·引擎接口刷新（38 报告）', page.data.items.length > 5, `items=${page.data.items.length}`)
  check('首页·价格分转元', page.data.items.some((i) => i.priceYuan === '498'), 'price_fen=49800→498')
  check('首页·省份筛选聚合', page.data.facets.provinces.includes('江苏'), page.data.facets.provinces.slice(0, 5).join(','))

  page.onSearchInput({ detail: { value: '水网' } })
  await sleep(600)
  check('首页·搜索命中（LIKE title 层）', page.data.searching === true && page.data.searchItems.some((i) => i.id === 'js-shuiwang-2026'), `searchItems=${page.data.searchItems.length}`)

  page.onSearchInput({ detail: { value: '零命中词xyzq' } })
  await sleep(600)
  check('首页·零命中降级提示+热词', page.data.fallbackHint === true && page.data.hotWords.length > 0, `hotWords=${page.data.hotWords.length}`)

  page.onClearSearch()
  page.onChipTap({ currentTarget: { dataset: { field: 'province', value: '浙江' } } })
  await sleep(500)
  check('首页·省份筛选子集（浙江）', page.data.items.length > 0 && page.data.items.every((i) => i.province === '浙江'), `items=${page.data.items.length}`)

  navs.length = 0
  page.onOpenReport({ currentTarget: { dataset: { id: 'js-shuiwang-2026' } } })
  check('首页·卡片点击→详情导航', navs[0] && navs[0].includes('/pages/detail/detail?id=js-shuiwang-2026'), navs[0])
}

// —— 详情页（游客→登录收藏） ——
{
  const page = makePage('pages/detail/detail.js')
  page.onLoad({ id: 'js-shuiwang-2026' })
  await sleep(900)
  check('详情·视图就绪', !!page.data.view, '')
  check('详情·决策卡（引擎真实页数）', /^已读 \d+ 页$/.test(page.data.decision.readText) && /章/.test(page.data.decision.remainText), `${page.data.decision.readText} / ${page.data.decision.remainText}`)
  check('详情·锚价 1888', page.data.view.anchorYuan === '1888', page.data.view.anchorYuan)
  check('详情·阅读榜徽章（read_log 聚合）', (page.data.view.rankBadge || '').includes('阅读榜'), page.data.view.rankBadge)
  check('详情·发票入口披露', page.data.view.invoiceEntry === true, '')

  navs.length = 0
  page.onTapToc({ currentTarget: { dataset: { idx: 0, trial: true } } })
  check('详情·试读章跳阅读器', navs[0] && navs[0].includes('/pages/reader/reader'), navs[0])
  const paidIdx = page.data.decision.toc.findIndex((t) => !t.isTrial)
  page.onTapToc({ currentTarget: { dataset: { idx: paidIdx, trial: false } } })
  check('详情·付费章提示（不触网）', toasts.some((t) => t.includes('付费内容')), `paidIdx=${paidIdx}`)

  await page.onUnlock()
  check('详情·支付前披露弹层', modals.some((m) => m.includes('不支持无理由退款')), '')
  check('详情·虚拟支付未开通灰置文案', toasts.some((t) => t.includes('开通中')), 'virtualPay=false 本地开关降级（真实现状同 503 态）')

  await page.onFavorite()
  await sleep(400)
  check('详情·收藏（引擎真源）', page.data.favorited === true, `favorited=${page.data.favorited}`)
}

// —— 阅读器：试读章渲染+付费锁定占位 ——
{
  const page = makePage('pages/reader/reader.js')
  page.onLoad({ id: 'js-shuiwang-2026' })
  await sleep(900)
  check('阅读器·章节数=19', page.data.chapters.length === 19, `chapters=${page.data.chapters.length}`)
  check('阅读器·试读章块渲染', page.data.activeBlocks.length > 3, `blocks=${page.data.activeBlocks.length}`)
  const paidChIdx = page.data.chapters.findIndex((c) => !c.isTrial)
  page.onPickChapter({ currentTarget: { dataset: { index: paidChIdx } } })
  await sleep(300)
  check('阅读器·付费章锁定占位（未购不拉正文）', page.data.activeLocked === true && page.data.activeBlocks.length === 0, `paidIdx=${paidChIdx}`)
  page.onPickChapter({ currentTarget: { dataset: { index: 0 } } })
  await sleep(200)
  check('阅读器·回到试读章', page.data.activeLocked === false && page.data.activeBlocks.length > 3, '')
  check('阅读器·决策卡就绪', !!page.data.decision, '')
}

// —— 我的页：服务端真源 ——
{
  const page = makePage('pages/me/me.js')
  page.onShow()
  await sleep(800)
  check('我的·非离线态（引擎可达）', page.data.offline === false, `offline=${page.data.offline}`)
  check('我的·赠阅位 P1 占位隐藏', page.data.giftTabEnabled === false, '')
  const favs = page.data.favs || []
  check('我的·收藏即时出现（服务端态）', favs.some((f) => f.id === 'js-shuiwang-2026'), `favs=${favs.map((f) => f.id).join(',')}`)
  check('我的·已购列表（本 live 用户未购）', Array.isArray(page.data.owned), `owned=${(page.data.owned || []).length}`)
}

const fails = results.filter((r) => !r.ok).length
console.log(`\n=== 活体页面走查：${results.length} 断言，PASS=${results.length - fails} FAIL=${fails} ===`)
process.exit(fails > 0 ? 1 : 0)
