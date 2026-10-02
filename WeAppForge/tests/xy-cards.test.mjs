// tests/xy-cards.test.mjs — 商机卡（情报裂变 2.0）前端出厂门：mock 夹具三契约形状（契约 v2 纠偏后：
// card_id 不透明 <report_id>-cNNN 不做格式校验、amount/amount_raw 均字符串、空值/'-' 属性行跳过）+
// api 三函数 mock 路由命中/错误信封/真实模式契约透传 + 落地页状态机（card_id 直通/scene→resolve→detail 链/
// 空 scene 降级 invalid/瘦卡渲染/分享载荷/CTA 跳转）+ 注册与密钥卫生走查。
// 机制照 tests/xy-frontend.test.mjs：wx 全局桩 + require ts 编译产物（tsc -p 先行）。
import { test, beforeEach } from 'node:test'
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'
import { resolve } from 'node:path'
import { readFileSync } from 'node:fs'

const require = createRequire(import.meta.url)
const PROJECT = resolve('projects/zongbao')

// —— wx 全局桩（node 环境无 wx；请求经 stubHandler 应答，全程可观测）——
const storage = new Map()
const calls = { requests: [], logins: 0, toasts: [], navs: [], switchTabs: [] }
let stubHandler = null // (opts) => { statusCode, data } | { network: true }

globalThis.__XY_BASE__ = 'http://stub-engine'
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
  removeStorageSync: (k) => storage.delete(k),
  login: (o) => {
    calls.logins += 1
    o.success({ code: `cards-code-${calls.logins}` })
  },
  request: (o) => {
    calls.requests.push(o)
    const r = stubHandler ? stubHandler(o) : { statusCode: 200, data: {} }
    setTimeout(() => {
      if (r.network) o.fail({ errMsg: 'request:fail timeout' })
      else o.success({ statusCode: r.statusCode, data: r.data })
    }, 0)
  },
  showToast: (o) => calls.toasts.push(o.title),
  navigateTo: (o) => calls.navs.push(o.url),
  switchTab: (o) => calls.switchTabs.push(o.url),
}

const cfg = require(resolve(PROJECT, 'config/index.js'))
const apiMod = require(resolve(PROJECT, 'utils/api.js'))
const mockFix = require(resolve(PROJECT, 'utils/mock-fixtures.js'))
const cardsFix = require(resolve(PROJECT, 'utils/mock-fixtures-cards.js'))

const realMockFlag = cfg.appConfig.mockApi
const freshMock = () => {
  mockFix.resetMockStateForTest()
  cfg.appConfig.mockApi = true
}

beforeEach(() => {
  storage.clear()
  calls.requests.length = 0
  calls.logins = 0
  calls.toasts.length = 0
  calls.navs.length = 0
  calls.switchTabs.length = 0
  stubHandler = null
  cfg.appConfig.mockApi = realMockFlag
  apiMod.resetPayGrayForTest()
})

// —— 1. 契约1 形状：cardDetail 卡+报告全字段；夹具真实 id 形态与 amount/amount_raw 字串一致 ——
test('mockApi 契约1：cardDetail 卡+报告全字段；全量卡真实 id 形态、amount/amount_raw 字串一致', async () => {
  freshMock()
  const res = await apiMod.cardDetail('js-shuiwang-2026-c003')
  assert.equal(res.card.id, 'js-shuiwang-2026-c003')
  assert.equal(res.card.report_id, 'js-shuiwang-2026')
  assert.equal(res.card.amount, '1.2亿', 'amount=展示串')
  assert.equal(res.card.amount_raw, '1.2亿元', 'amount_raw=原始文本串（非数字）')
  assert.equal(res.card.province, '江苏')
  assert.ok(['owner', 'stage', 'window', 'source_chapter', 'summary'].every((k) => typeof res.card[k] === 'string' && res.card[k].length > 0), '五字段齐')
  assert.ok(res.card.source_chapter.includes('·'), 'source_chapter 为引擎富化显示串直渲染')
  assert.equal(res.report.id, 'js-shuiwang-2026')
  assert.equal(res.report.title, '江苏省水网工程商机研究', '报告引用与 mock-reports 单一真源同题')
  assert.equal(res.report.price_fen, 49800)
  assert.equal(res.report.trial_chapters, 2)

  assert.ok(cardsFix.CARDS.length >= 6 && cardsFix.CARDS.length <= 8, '6-8 张样例卡')
  const ids = new Set()
  for (const c of cardsFix.CARDS) {
    assert.ok(typeof c.id === 'string' && c.id.length > 0, 'card_id 不透明字符串')
    assert.ok(c.id.startsWith(c.report_id + '-c'), `真实形态 <report_id>-cNNN：${c.id}`)
    assert.ok(!ids.has(c.id), 'id 唯一')
    ids.add(c.id)
    assert.equal(typeof c.amount, 'string', 'amount 恒为字符串')
    assert.equal(typeof c.amount_raw, 'string', 'amount_raw 恒为字符串')
    if (c.amount === '') assert.equal(c.amount_raw, '', '空金额卡 amount_raw 同空')
    else assert.ok(c.amount_raw.includes(c.amount), `${c.id} amount_raw 含 amount 展示串`)
    assert.equal(c.province, '江苏', '江苏省份为主（province 恒有值）')
  }
  assert.ok(cardsFix.CARDS.some((c) => c.amount.length > 0), '金额富卡在位')
  assert.ok(cardsFix.CARDS.some((c) => c.amount === '' && c.owner === '-' && c.stage === '' && c.window === ''), '全空属性行瘦卡在位')
})

// —— 2. 契约3 形状：resolve scene 命中/完整 id 直传/乱码/空 → 恒 200 降级 ——
test('mockApi 契约3：resolve c=段命中、完整 id 直传、乱码与空 scene 恒 200 降级 card_id:""', async () => {
  freshMock()
  assert.deepEqual(await apiMod.cardResolve('c=js-shuiwang-2026-c017'), { card_id: 'js-shuiwang-2026-c017' }, '二维码 scene c=<card_id> 命中')
  assert.deepEqual(await apiMod.cardResolve('js-shuiwang-2026-c021'), { card_id: 'js-shuiwang-2026-c021' }, '完整 card_id 直传容忍')
  assert.deepEqual(await apiMod.cardResolve('garbage-scene'), { card_id: '' }, '解析失败恒 200 降级（同 invite/scan 哲学）')
  assert.deepEqual(await apiMod.cardResolve(''), { card_id: '' }, '空 scene 同降级不抛错')
})

// —— 3. 契约2 两态·匿名/未购：前 3 张 + locked:true + total ——
test('mockApi 契约2：匿名与已登录未购均回 locked 前 3 张；未知报告 404 REPORT_NOT_FOUND', async () => {
  freshMock()
  const anon = await apiMod.cardsByReport('js-shuiwang-2026')
  assert.equal(anon.cards.length, 3, '匿名只给前 3 张')
  assert.equal(anon.locked, true, 'locked:true 锁尾')
  assert.equal(anon.total, 6, 'total 报全量 6 张')

  await apiMod.silentLogin()
  const unpurchased = await apiMod.cardsByReport('js-shuiwang-2026')
  assert.equal(unpurchased.locked, true, '已登录未购仍是 locked 形态')
  assert.equal(unpurchased.cards.length, 3)

  // 未知报告：mock 路由层形状直查（api 层 cardsByReport 按契约吞错回 locked 空形状）
  const raw = await cardsFix.mockCardsRequest('GET', '/cards/by-report/no-such-report')
  assert.equal(raw.status, 404)
  assert.equal(raw.body.code, 'REPORT_NOT_FOUND')
  const fallback = await apiMod.cardsByReport('no-such-report')
  assert.deepEqual(fallback, { cards: [], total: 0, page: 1, locked: true }, 'api 层失败兜底=locked 空形状')
})

// —— 4. 契约2 已购全量分页 ——
test('mockApi 契约2：已购回全量分页（cards+total+page，locked 缺席）且分页切片正确', async () => {
  freshMock()
  await apiMod.silentLogin()
  const sign = await apiMod.api.paySign('js-shuiwang-2026')
  await apiMod.api.payStatus(sign.out_trade_no)
  const full = await apiMod.cardsByReport('js-shuiwang-2026')
  assert.equal(full.cards.length, 6, '已购全量 6 张')
  assert.equal(full.total, 6)
  assert.equal(full.page, 1)
  assert.ok(!('locked' in full), '已购形态无 locked 字段')
  const p2 = await apiMod.cardsByReport('js-shuiwang-2026', { page: 2, page_size: 2 })
  assert.equal(p2.cards.length, 2, 'page=2/page_size=2 切片后 2 张')
  assert.deepEqual(p2.cards.map((c) => c.id), ['js-shuiwang-2026-c021', 'js-shuiwang-2026-c028'], '分页按夹具顺序切片')
  assert.equal(p2.total, 6)
})

// —— 5. 真实模式契约：三函数路径/方法/Bearer + owned 分页参数透传（默认 1/20）——
test('api 真实模式：cardDetail/cardResolve/cardsByReport 路径与分页参数透传、Bearer 注入', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = (o) => {
    const path = o.url.replace('http://stub-engine', '')
    if (path === '/cards/js-shuiwang-2026-c003') return { statusCode: 200, data: { card: { id: 'js-shuiwang-2026-c003' }, report: { id: 'r', title: 'T', price_fen: 49800, cover: '', trial_chapters: 2 } } }
    if (path.startsWith('/cards/resolve')) return { statusCode: 200, data: { card_id: 'js-shuiwang-2026-c017' } }
    if (path.startsWith('/cards/by-report/')) return { statusCode: 200, data: { cards: [], total: 0, page: 1 } }
    return { statusCode: 404, data: {} }
  }
  storage.set('zongbao_token', 'tk-cards')
  await apiMod.cardDetail('js-shuiwang-2026-c003')
  await apiMod.cardResolve('c=js-shuiwang-2026-c017')
  await apiMod.cardsByReport('js-shuiwang-2026', { page: 2, page_size: 5 })
  await apiMod.cardsByReport('js-shuiwang-2026')

  const [d, r, p, def] = calls.requests.slice(-4)
  assert.ok(d.url.endsWith('/cards/js-shuiwang-2026-c003') && d.method === 'GET', '契约1 GET /cards/{card_id}')
  assert.equal(d.header.Authorization, 'Bearer tk-cards', 'Bearer 注入')
  assert.ok(r.url.includes('/cards/resolve?scene='), '契约3 GET /cards/resolve?scene=')
  assert.equal(decodeURIComponent(r.url.split('scene=')[1]), 'c=js-shuiwang-2026-c017', 'scene 编码透传')
  assert.ok(p.url.endsWith('/cards/by-report/js-shuiwang-2026?page=2&page_size=5'), '契约2 owned 分页参数透传')
  assert.ok(def.url.endsWith('/cards/by-report/js-shuiwang-2026?page=1&page_size=20'), '缺省分页 1/20')
})

// —— 6. 错误信封解析：mock 404 CARD_NOT_FOUND；真实模式嵌套 {error:{code}} 信封 → 404 语义；网络失败 by-report 兜底 ——
test('api 错误信封：mock 404 CARD_NOT_FOUND 解析出 code；真实模式嵌套信封与网络失败均按降级语义收敛', async () => {
  freshMock()
  await assert.rejects(
    () => apiMod.cardDetail('js-shuiwang-2026-c999'),
    (e) => e.statusCode === 404 && e.code === 'CARD_NOT_FOUND',
    'mock 未知卡 404 错误信封解析',
  )
  await assert.rejects(
    () => apiMod.cardDetail('not-a-card-id'),
    (e) => e.statusCode === 404 && e.code === 'CARD_NOT_FOUND',
    'mock 任意未知 id 同 404 CARD_NOT_FOUND（不透明 id 不做格式校验）',
  )

  // 真实模式：引擎嵌套信封 {error:{code,message}} 经既有 httpError 机制归一为 HTTP 404 语义（机制为准适配）
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ statusCode: 404, data: { error: { code: 'CARD_NOT_FOUND', message: '商机卡不存在或已失效' } } })
  await assert.rejects(() => apiMod.cardDetail('js-shuiwang-2026-c003'), (e) => e.statusCode === 404, '嵌套信封仍以 404 上抛（页层走 invalid 兜底）')

  stubHandler = () => ({ network: true })
  const offline = await apiMod.cardsByReport('js-shuiwang-2026')
  assert.deepEqual(offline, { cards: [], total: 0, page: 1, locked: true }, '网络失败 by-report 按 locked 空形状兜底')
})

// —— 页面机制：Page 桩捕获 + 编译产物 require（照 xy-frontend 惯例）——
function loadPageDef() {
  let pageCfg = null
  globalThis.Page = (c) => {
    pageCfg = c
  }
  const pagePath = resolve(PROJECT, 'pages/cards/detail.js')
  delete require.cache[require.resolve(pagePath)]
  require(pagePath)
  delete require.cache[require.resolve(pagePath)]
  assert.ok(pageCfg, 'Page 定义已捕获')
  return pageCfg
}

function mkPage(pageCfg) {
  const p = Object.create(pageCfg)
  p.data = JSON.parse(JSON.stringify(pageCfg.data))
  p.setData = function (patch) {
    Object.assign(this.data, patch)
  }
  return p
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

// —— 7. onLoad card_id 直通：loading→ready，视图字段齐 ——
test('detail 页 onLoad card_id 直通：ready 态卡视图+属性行+报告 CTA（¥498 分转元）', async () => {
  freshMock()
  const pageCfg = loadPageDef()
  const page = mkPage(pageCfg)
  page.onLoad({ card_id: 'js-shuiwang-2026-c003' })
  assert.equal(page.data.status, 'loading', '先入 loading 态')
  await sleep(250)
  assert.equal(page.data.status, 'ready')
  assert.equal(page.data.cardId, 'js-shuiwang-2026-c003')
  assert.equal(page.data.card.title, '江苏水网改造·城区管网更新标段商机')
  assert.equal(page.data.card.amount, '1.2亿')
  assert.equal(page.data.props.length, 5, '富卡属性行五项（owner/stage/window/province/source_chapter）')
  assert.ok(page.data.props.some((row) => row.label === '业主单位' && row.value === '江苏省水务集团'))
  assert.deepEqual(page.data.tags.map((t) => t.text), ['江苏', '招标阶段', '第 13 章 · 商机清单'], '卡头标签行（省份/阶段/来源章）')
  assert.equal(page.data.report.priceYuan, '498', 'CTA 价格分转元')
  assert.equal(page.data.footerDisclaimer, '行业研究，非投资建议；决策自担。', '页脚免责与现有页逐字一致')
})

// —— 8. 瘦卡渲染纠偏：金额空整行隐藏、空值/'-' 属性行跳过（只留省份）——
test('detail 页瘦卡渲染：amount 空→金额行隐藏；owner="-"/空 stage/window→属性行只剩省份', async () => {
  freshMock()
  const pageCfg = loadPageDef()
  const page = mkPage(pageCfg)
  page.onLoad({ card_id: 'js-guanqu-2026-c011' })
  await sleep(250)
  assert.equal(page.data.status, 'ready')
  assert.equal(page.data.card.amount, '', '瘦卡金额空串（wxml wx:if 整行隐藏，不渲染 ¥ 或 0）')
  assert.deepEqual(
    page.data.props.map((row) => row.label),
    ['省份', '来源章节'],
    'owner="-"/空 stage/window 三行全跳过，只留省份与来源章节',
  )
  assert.deepEqual(page.data.tags.map((t) => t.text), ['江苏', '第 13 章 · 商机清单'], 'stage 空不出标签，source_chapter 富化串直渲染')
})

// —— 9. scene→resolve→detail 链（含二维码 URL 编码形态解码）——
test('detail 页 scene 链：resolve→detail 两跳就绪；URL 编码 scene 安全解码', async () => {
  freshMock()
  const pageCfg = loadPageDef()
  const page = mkPage(pageCfg)
  page.onLoad({ scene: 'c=js-shuiwang-2026-c017' })
  await sleep(300)
  assert.equal(page.data.status, 'ready', 'scene 两跳链就绪')
  assert.equal(page.data.cardId, 'js-shuiwang-2026-c017')
  assert.equal(page.data.card.owner, '南京水务集团')

  const encoded = mkPage(pageCfg)
  encoded.onLoad({ scene: 'c%3Djs-shuiwang-2026-c021' })
  await sleep(300)
  assert.equal(encoded.data.status, 'ready', 'URL 编码 scene 解码后命中')
  assert.equal(encoded.data.cardId, 'js-shuiwang-2026-c021')
})

// —— 10. 空参/坏 scene/请求失败 → invalid 兜底（不 throw 到用户脸上）——
test('detail 页 invalid 兜底：无参同步失效、坏 scene 解析空失效、真实模式网络失败失效', async () => {
  freshMock()
  const pageCfg = loadPageDef()
  const none = mkPage(pageCfg)
  none.onLoad({})
  assert.equal(none.data.status, 'invalid', 'card_id/scene 都无 → 卡片已失效')

  const bad = mkPage(pageCfg)
  bad.onLoad({ scene: 'garbage-scene' })
  await sleep(250)
  assert.equal(bad.data.status, 'invalid', '解析空 card_id 降级 invalid')

  cfg.appConfig.mockApi = false
  stubHandler = () => ({ network: true })
  const offline = mkPage(pageCfg)
  offline.onLoad({ card_id: 'js-shuiwang-2026-c003' })
  await sleep(250)
  assert.equal(offline.data.status, 'invalid', '请求失败走 invalid 不上抛')
  offline.onGoHome()
  assert.deepEqual(calls.switchTabs, ['/pages/index/index'], '失效态去首页走 switchTab')
})

// —— 11. onShareAppMessage 载荷：path 带 card_id、title 用卡 title ——
test('detail 页分享载荷：path=pages/cards/detail?card_id=…，title 用卡 title', async () => {
  freshMock()
  const pageCfg = loadPageDef()
  const page = mkPage(pageCfg)
  page.onLoad({ card_id: 'js-shuiwang-2026-c028' })
  await sleep(250)
  const share = pageCfg.onShareAppMessage.call(page)
  assert.equal(share.path, '/pages/cards/detail?card_id=js-shuiwang-2026-c028', '分享回跳本页落地路径')
  assert.equal(share.title, page.data.card.title, 'title 用卡 title')
})

// —— 12. 来源报告 CTA：跳研报详情页 ——
test('detail 页 CTA：查看完整报告 → navigate 研报详情页（id=report_id）', async () => {
  freshMock()
  const pageCfg = loadPageDef()
  const page = mkPage(pageCfg)
  page.onLoad({ card_id: 'js-guanqu-2026-c005' })
  await sleep(250)
  pageCfg.onOpenReport.call(page)
  assert.deepEqual(calls.navs, ['/pages/detail/detail?id=js-guanqu-2026'])
})

// —— 13. 注册与密钥卫生走查：app.json/标题/模板绑定/免责单一真源/无格式校验/无密钥类字段 ——
test('注册与卫生：app.json 注册页、标题「商机情报卡」、分享按钮与免责绑定、无 id 正则校验、无 appid/appsecret/offerId', () => {
  const appJson = JSON.parse(readFileSync(resolve(PROJECT, 'app.json'), 'utf8'))
  assert.ok(appJson.pages.includes('pages/cards/detail'), 'app.json pages 注册')
  const pageJson = JSON.parse(readFileSync(resolve(PROJECT, 'pages/cards/detail.json'), 'utf8'))
  assert.equal(pageJson.navigationBarTitleText, '商机情报卡')

  const wxml = readFileSync(resolve(PROJECT, 'pages/cards/detail.wxml'), 'utf8')
  assert.ok(wxml.includes('open-type="share"') && wxml.includes('分享这张卡'), '分享按钮在位')
  assert.ok(wxml.includes('wx:if="{{card.amount}}"'), '金额行空串隐藏（不渲染 ¥ 或 0）')
  assert.ok(wxml.includes('{{footerDisclaimer}}'), '页脚免责走绑定（NFR-08 同款）')
  assert.ok(wxml.includes('bindtap="onOpenReport"') && wxml.includes('查看完整报告'), '来源报告 CTA 绑定')
  assert.ok(wxml.includes('bindtap="onGoHome"') && wxml.includes('去首页'), '失效态去首页按钮')
  assert.ok(wxml.includes('卡片已失效'), '兜底态文案')

  const js = readFileSync(resolve(PROJECT, 'pages/cards/detail.js'), 'utf8')
  assert.ok(js.includes('FOOTER_DISCLAIMER'), '免责取 utils/agreement 单一真源')
  assert.ok(!js.includes('features.p1'), '落地页不挂 p1 开关')
  assert.ok(!/\^\s*c_\[0-9a-f\]/.test(js) && !js.includes('test(/c_'), 'card_id 不透明不做格式正则校验')
  assert.ok(readFileSync(resolve(PROJECT, 'pages/cards/detail.wxss'), 'utf8').length > 0, '样式文件在位')

  // 密钥卫生：新增四类文件无 wx+16hex appid 形态、无 appsecret/offerId 字样
  for (const f of ['utils/mock-fixtures-cards.ts', 'pages/cards/detail.ts', 'pages/cards/detail.wxml', 'pages/cards/detail.wxss', 'pages/cards/detail.json']) {
    const src = readFileSync(resolve(PROJECT, f), 'utf8')
    assert.ok(!/wx[0-9a-f]{16}/i.test(src), `${f} 无 appid 形态字符串`)
    assert.ok(!/appsecret|offerId/i.test(src), `${f} 无密钥类字段`)
  }
})
