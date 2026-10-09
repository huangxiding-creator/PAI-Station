// tests/xy-frontend.test.mjs — C 线前端出厂门：api 降级矩阵（401 重试/503 灰置/mock 切换/网络失败）+
// 决策卡整形+分转元+渲染适配+scene 容错（node --test 零依赖）
import { test, beforeEach } from 'node:test'
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'
import { resolve } from 'node:path'
import { readFileSync } from 'node:fs'

const require = createRequire(import.meta.url)
const PROJECT = resolve('E:/AI-Station/微信小程序/zongbao')

// —— wx 全局桩（node 环境无 wx；请求经 stubHandler 应答，全程可观测）——
const storage = new Map()
const calls = { requests: [], logins: 0, toasts: [], navs: [], virtualPays: [] }
let stubHandler = null // (opts) => { statusCode, data } | { network: true }

globalThis.__XY_BASE__ = 'http://stub-engine'
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
  removeStorageSync: (k) => storage.delete(k),
  login: (o) => {
    calls.logins += 1
    o.success({ code: `test-code-${calls.logins}` })
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
  showModal: (o) => o.success && o.success({ confirm: true }),
  navigateTo: (o) => calls.navs.push(o.url),
  requestVirtualPayment: (o) => {
    calls.virtualPays.push(o)
    o.success && o.success({})
  },
}

const cfg = require(resolve(PROJECT, 'config/index.js'))
const apiMod = require(resolve(PROJECT, 'utils/api.js'))
const fmt = require(resolve(PROJECT, 'utils/format.js'))
const render = require(resolve(PROJECT, 'utils/render.js'))
const pay = require(resolve(PROJECT, 'utils/pay.js'))

const realMockFlag = cfg.appConfig.mockApi
const realVirtualPay = cfg.appConfig.features.virtualPay

beforeEach(() => {
  storage.clear()
  calls.requests.length = 0
  calls.logins = 0
  calls.toasts.length = 0
  calls.navs.length = 0
  calls.virtualPays.length = 0
  stubHandler = null
  cfg.appConfig.mockApi = realMockFlag
  cfg.appConfig.features.virtualPay = realVirtualPay
  apiMod.resetPayGrayForTest()
})

// —— 1. 分转元 ——
test('fenToYuan：整数元不带小数、分位截尾零', () => {
  assert.equal(fmt.fenToYuan(49800), '498')
  assert.equal(fmt.fenToYuan(990), '9.9')
  assert.equal(fmt.fenToYuan(188800), '1888')
  assert.equal(fmt.fenToYuan(12345), '123.45')
  assert.equal(fmt.fenToYuan(0), '0')
})

// —— 2. 目录条目归一（服务端形状 + 包内形状同函数）——
test('normalizeReport：服务端 price_fen 与包内 price 双形状归一', () => {
  const server = fmt.normalizeReport({
    id: 'a', title: 'T', summary: 'S', price_fen: 49800, province: '江苏',
    owner_type: '水利', industry: '水网工程', chapter_count: 19, trial_chapters: 2, tags: ['水网'],
  })
  assert.equal(server.priceYuan, '498')
  assert.equal(server.ownerType, '水利')
  assert.equal(server.chapterCount, 19)
  const bundled = fmt.normalizeReport({ id: 'b', title: 'T2', summary: 'S2', price: 990, chapterCount: 12, source: '总包创研院' })
  assert.equal(bundled.priceFen, 990)
  assert.equal(bundled.priceYuan, '9.9')
  assert.equal(bundled.trialChapters, cfg.appConfig.trialChapterCount, '缺省试读章数回配置')
})

// —— 3. 决策卡整形：服务端形状全要素 ——
test('buildDecisionCard：服务端 decision_card → 已读页/剩余章页/模糊结论/目录树', () => {
  const d = fmt.buildDecisionCard({
    read_pages: 20,
    remaining_chapters: 17,
    remaining_pages: 280,
    locked_conclusions: [{ title: '第十一章 时间窗口与行动节奏', blurred: true }, { title: '第十三章 商机清单', blurred: true }],
    toc: [{ id: 'ch01', title: '第一章', is_trial: 1 }, { id: 'ch03', title: '第三章', is_trial: 0 }],
  })
  assert.equal(d.readText, '已读 20 页')
  assert.equal(d.remainText, '全文还有 17 章 · 280 页')
  assert.equal(d.lockedCount, 2)
  assert.ok(d.lockedTitles[0].includes('时间窗口'))
  assert.equal(d.toc[0].isTrial, true)
  assert.equal(d.toc[1].isTrial, false)
})

// —— 4. 决策卡整形：离线包内推导不编造页数 ——
test('buildDecisionCard：包内兜底只报章数、不造页数', () => {
  const chapters = Array.from({ length: 19 }, (_, i) => ({ id: `ch${i + 1}`, title: `章${i + 1}`, html: i < 2 ? 'x' : '' }))
  const d = fmt.buildDecisionCard(null, chapters)
  assert.equal(d.readPages, null)
  assert.equal(d.readText, '已读 2 章')
  assert.equal(d.remainText, '全文还有 17 章')
  assert.equal(d.remainingPages, null)
  assert.equal(d.toc.length, 19)
})

// —— 5. 筛选聚合 + 三层降级提示 + scene 容错 ——
test('aggregateFacets/layerHintText/parseScene：筛选项、降级话术、扫码容错', () => {
  const facets = fmt.aggregateFacets([
    { province: '江苏', ownerType: '水利', industry: '水网工程' },
    { province: '江苏', ownerType: '能源', industry: '抽水蓄能' },
    { province: '浙江', ownerType: '', industry: '抽水蓄能' },
  ])
  assert.deepEqual(facets.provinces, ['江苏', '浙江'])
  assert.deepEqual(facets.ownerTypes, ['水利', '能源'])
  assert.ok(fmt.layerHintText('L2', '江苏').includes('章节标题'))
  assert.ok(fmt.layerHintText('L3', '水网').includes('商机关键词'))
  assert.equal(fmt.layerHintText('L1', 'x'), '')
  assert.deepEqual(fmt.parseScene('r=Ab3xK9&i=U8mQ2z'), { reportId: 'Ab3xK9', inviterId: 'U8mQ2z' })
  assert.equal(fmt.parseScene('garbage-scene'), null, '解析失败返 null 走归因降级不报错')
  assert.equal(fmt.parseScene(''), null)
})

// —— 6. mock 切换：mockApi 与真实请求同一签名，试点数据齐 ——
test('mockApi：catalog/search 走本地夹具且形状合规', async () => {
  cfg.appConfig.mockApi = true
  const catalog = await apiMod.api.catalog({ tab: 'hot', page: 1, page_size: 20 })
  assert.equal(catalog.total, 5, '夹具含 5 份研报（试点+陪跑）')
  assert.equal(catalog.items[0].id, 'js-shuiwang-2026', '阅读榜榜首=江苏水网试点')
  assert.equal(catalog.items[0].price_fen, 49800)
  assert.equal(catalog.praise_visible, false, '好评榜 P0 不可见')

  const hit = await apiMod.api.search('抽水蓄能')
  assert.equal(hit.layer_used, 'L1')
  assert.ok(hit.items.some((i) => i.id === 'zj-chouneng-2026'))

  const none = await apiMod.api.search('不存在的关键词xyzq')
  assert.equal(none.layer_used, 'none')
  assert.equal(none.fallback_hint, true, '零命中→降级提示+榜单补位信号')
  assert.ok(Array.isArray(none.hot_words) && none.hot_words.length > 0)
})

// —— 7. mock 章节契约：未购付费章无 html 字段（字段缺席判据）——
test('mockApi：chapters 未购付费章响应不含 html 字段', async () => {
  cfg.appConfig.mockApi = true
  const res = await apiMod.api.chapters('js-shuiwang-2026')
  assert.equal(res.chapters.length, 19)
  const paid = res.chapters.find((c) => c.id === 'ch03')
  assert.equal(paid.is_trial, 0)
  assert.ok(!('html' in paid), '付费章 html 字段缺席（非空串）——防泄漏判据')
  const trial = res.chapters.find((c) => c.id === 'ch01')
  assert.ok(trial.html && trial.html.length > 100, '试读章带包内真正文')
})

// —— 8. mock 支付链：login→paySign→payStatus→me 全链本地走通 ——
test('mockApi：登录→签名→查单→已购出现（同签名全链）', async () => {
  cfg.appConfig.mockApi = true
  cfg.appConfig.features.virtualPay = true
  await apiMod.silentLogin()
  const sign = await apiMod.api.paySign('zj-chouneng-2026')
  assert.equal(sign.mode, 'short_series_goods')
  assert.ok(sign.sign_data.length > 0, 'sign_data 透传字符串')
  assert.ok(/^zj-chouneng-2026_\d+$/.test(sign.out_trade_no), 'outTradeNo={reportId}_{ts}')
  const status = await apiMod.api.payStatus(sign.out_trade_no)
  assert.equal(status.status, 'paid')
  assert.equal(status.entitlement_granted, true)
  const me = await apiMod.api.me()
  assert.ok(me.entitlements.some((e) => e.report_id === 'zj-chouneng-2026'), '支付成功后已购即时出现')
})

// —— 9. 401 静默重登重试一次（qianwen 惯例）——
test('api 真实模式：401→静默 wx.login 换发→原请求重试一次', async () => {
  cfg.appConfig.mockApi = false
  let catalogCalls = 0
  stubHandler = (o) => {
    if (o.url.indexOf('/auth/login') >= 0) return { statusCode: 200, data: { token: 't-new', uid: 'u1', pay_configured: true } }
    if (o.url.indexOf('/catalog') >= 0) {
      catalogCalls += 1
      return catalogCalls === 1
        ? { statusCode: 401, data: { code: 'AUTH_EXPIRED', message: 'token 过期' } }
        : { statusCode: 200, data: { items: [{ id: 'x', title: 'T', price_fen: 49800 }], total: 1, page: 1, page_size: 20 } }
    }
    return { statusCode: 404, data: {} }
  }
  const res = await apiMod.api.catalog({ tab: 'hot' })
  assert.equal(res.items[0].id, 'x')
  assert.equal(catalogCalls, 2, '原请求恰好重试一次')
  assert.equal(calls.logins, 1, 'wx.login 静默换发一次')
  const authHeader = calls.requests[calls.requests.length - 1].header.Authorization
  assert.equal(authHeader, 'Bearer t-new', '重试携带新 Bearer')
})

// —— 10. 401 重试后仍 401 → 不再循环 ——
test('api 真实模式：重登后仍 401 则上抛不循环', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = (o) =>
    o.url.indexOf('/auth/login') >= 0
      ? { statusCode: 200, data: { token: 't2', pay_configured: true } }
      : { statusCode: 401, data: { code: 'AUTH_EXPIRED', message: '仍过期' } }
  await assert.rejects(() => apiMod.api.me(), (e) => e.statusCode === 401)
  assert.equal(calls.logins, 1, '只重登一次')
})

// —— 11. 503 PAY_NOT_CONFIGURED → 灰置事件 + 错误码上抛 ——
test('api 真实模式：503 PAY_NOT_CONFIGURED 触发支付灰置事件', async () => {
  cfg.appConfig.mockApi = false
  let gray = null
  const off = apiMod.onPayGray((info) => (gray = info))
  stubHandler = () => ({ statusCode: 503, data: { code: 'PAY_NOT_CONFIGURED', message: '虚拟支付尚未开通', degrade: 'pay_gray' } })
  await assert.rejects(
    () => apiMod.api.paySign('js-shuiwang-2026'),
    (e) => e.code === 'PAY_NOT_CONFIGURED' && e.statusCode === 503,
  )
  off()
  assert.ok(gray, '灰置事件已触发')
  assert.equal(gray.code, 'PAY_NOT_CONFIGURED')
  assert.equal(gray.source, 'server_503')
  assert.equal(apiMod.isPayGrayed(), true)
})

// —— 12. 网络失败 → 「服务维护」降级（NFR-11）——
test('api 真实模式：网络失败返回服务维护语义', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ network: true })
  await assert.rejects(
    () => apiMod.api.catalog({ tab: 'hot' }),
    (e) => e.network === true && e.message.includes('服务维护'),
  )
})

// —— 13. login 回包 pay_configured:false 预判灰置 ——
test('api 真实模式：login 回包 pay_configured:false 预判灰置', async () => {
  cfg.appConfig.mockApi = false
  let gray = null
  const off = apiMod.onPayGray((info) => (gray = info))
  stubHandler = (o) =>
    o.url.indexOf('/auth/login') >= 0
      ? { statusCode: 200, data: { token: 't3', uid: 'u3', pay_configured: false } }
      : { statusCode: 200, data: {} }
  await apiMod.silentLogin()
  off()
  assert.ok(gray && gray.source === 'login_hint', 'login 预判灰置事件')
})

// —— 14. pay 三层灰置：本地开关未开 → 降级文案不触网 ——
test('pay 降级：virtualPay=false 返回开通中文案且零网络请求', async () => {
  cfg.appConfig.mockApi = false
  cfg.appConfig.features.virtualPay = false
  const result = await pay.unlockReport('js-shuiwang-2026', 49800)
  assert.equal(result.ok, false)
  assert.ok(result.message.includes('开通中'))
  assert.equal(calls.requests.length, 0, '未触任何网络请求')
})

// —— 15. 渲染适配：mammoth HTML → md2blocks 块契约 ——
test('chapterBlocks：HTML→md 块契约（标题/加粗/表格），重复章题去重', () => {
  const html =
    '<h1>第一章 概述</h1><h2>1.1 背景</h2><p>江苏<strong>水网</strong>建设。</p>' +
    '<table><tr><td><p><strong>站点</strong></p></td><td><p>URL</p></td></tr><tr><td><p>水利厅</p></td><td><p>jswater</p></td></tr></table>'
  const blocks = render.chapterBlocks(html, '第一章 概述')
  assert.ok(!blocks.some((b) => b.t === 'h1'), '与章标题重复的首 h1 去重')
  const h2 = blocks.find((b) => b.t === 'h2')
  assert.ok(h2 && h2.inl.some((s) => s.v.includes('背景')))
  const p = blocks.find((b) => b.t === 'p')
  assert.ok(p && p.inl.some((s) => s.k === 'b' && s.v === '水网'), 'strong→加粗行内段')
  const table = blocks.find((b) => b.t === 'table')
  assert.ok(table && table.head.length === 2 && table.rows.length === 1, '表格→表头+数据行')
  assert.equal(render.chapterBlocks('', '任何').length, 0, '空正文出空块不抛异常')
})

// —— 16-20. T-P0-26 用户协议与规则嵌入（AGREEMENT_COPY v1.0 逐字）——
const agr = require(resolve(PROJECT, 'utils/agreement.js'))

test('agreement 常量：2.2 三条支付前披露逐字（含结尾分号/句号）', () => {
  assert.deepEqual(agr.PAY_DISCLOSURE_BULLETS, [
    '本服务为付费数字内容，付款解锁后即可在线阅读和下载，属于一经消费即完成的数字化商品，不支持七天无理由退款；',
    '未成年人不得自行购买本服务内容；如确有需要，须在监护人同意和指导下使用监护人账户购买；',
    '购买所得权益仅限您的购买账号本人使用，使用范围详见 1.3 与 2.5。',
  ])
  assert.equal(agr.PAY_SHEET.price, '¥498')
  assert.equal(agr.PAY_SHEET.refundLine, '批评评分退款通道：认真读完不满意，打分可退最高 100%')
  assert.equal(agr.PAY_SHEET.rulesBtnText, '查看完整付费与退款规则')
  assert.equal(agr.PAY_SHEET.agreeBtnText, '同意并继续')
})

test('agreement 常量：八节结构+关键数字逐字（50-300 字/每月 ≤2 次/70 分→¥348.60）+版本行', () => {
  assert.equal(agr.AGREEMENT_SECTIONS.length, 8)
  const pay = agr.AGREEMENT_SECTIONS.find((s) => s.key === 'pay')
  assert.equal(pay.clauses.length, 7, '第二节 2.1-2.7 七条')
  assert.equal(pay.clauses[0].openByDefault, true, '2.1 默认展开')
  assert.ok(pay.clauses.slice(1).every((c) => c.openByDefault === false), '2.2-2.7 默认收起')
  assert.ok(agr.AGREEMENT_SECTIONS[0].clauses.every((c) => c.openByDefault === false), '1.1-1.5 默认收起')
  const flat = JSON.stringify(agr.AGREEMENT_SECTIONS)
  assert.ok(flat.includes('字数 50-300 字'), '批评字数下上限逐字')
  assert.ok(flat.includes('每个账号每月最多成功退款 2 次'), '月退款上限逐字')
  assert.ok(flat.includes('例：得分 70 分、单篇实付 ¥498，退 ¥348.60'), '70 分→¥348.60 线性映射例逐字')
  assert.equal(agr.AGREEMENT_VERSION_LINE, '版本：v1.2', 'AGREEMENT_COPY 升 v1.2，版本行锚定同步（情报官体系+转赠）')
  assert.equal(agr.AGREEMENT_EFFECTIVE_LINE, '生效日期：【上线日填写：YYYY-MM-DD】', '【】占位原样保留')
})

test('页脚一行版：常量逐字且 detail/reader 两页均以绑定引用（NFR-08）', () => {
  assert.equal(agr.FOOTER_DISCLAIMER, '行业研究，非投资建议；决策自担。')
  for (const f of ['pages/detail/detail.wxml', 'pages/reader/reader.wxml']) {
    assert.ok(readFileSync(resolve(PROJECT, f), 'utf8').includes('{{footerDisclaimer}}'), `${f} 页脚走绑定`)
  }
  for (const f of ['pages/detail/detail.js', 'pages/reader/reader.js']) {
    assert.ok(readFileSync(resolve(PROJECT, f), 'utf8').includes('FOOTER_DISCLAIMER'), `${f} 取自 agreement 单一真源`)
  }
})

test('detail 支付前置门：解锁先弹披露层（灰置照常可看），同意后才进支付链', async () => {
  cfg.appConfig.mockApi = true
  cfg.appConfig.features.virtualPay = true
  const store = require(resolve(PROJECT, 'utils/store.js'))
  let pageCfg = null
  globalThis.Page = (c) => {
    pageCfg = c
  }
  const detailPath = resolve(PROJECT, 'pages/detail/detail.js')
  delete require.cache[require.resolve(detailPath)]
  require(detailPath)
  delete require.cache[require.resolve(detailPath)]
  assert.ok(pageCfg, 'Page 定义已捕获')
  const mkPage = () => {
    const p = Object.create(pageCfg)
    p.data = JSON.parse(JSON.stringify(pageCfg.data))
    p.data.id = 'js-shuiwang-2026'
    p.data.view = { card: { priceFen: 49800, priceYuan: '498' } }
    p.setData = function (patch) {
      Object.assign(this.data, patch)
    }
    return p
  }

  // 正常形态：先弹层（未同意零支付动作）→ 同意 → mock 支付链走通
  const page = mkPage()
  pageCfg.onUnlock.call(page)
  assert.equal(page.data.paySheetOpen, true, '点解锁先开披露弹层')
  assert.equal(calls.virtualPays.length, 0, '未同意不触虚拟支付')
  assert.equal(store.isUnlocked('js-shuiwang-2026'), false)
  calls.navs.length = 0
  pageCfg.onOpenPayRules.call(page)
  assert.ok(calls.navs[0].includes('/pages/agreement/agreement?anchor=pay'), '完整规则一键可达第二节')
  await pageCfg.onPayAgree.call(page)
  assert.equal(page.data.paySheetOpen, false)
  assert.equal(calls.virtualPays.length, 1, '同意后进入支付链')
  assert.equal(page.data.owned, true, 'mock 支付成功置已解锁')
  assert.equal(store.isUnlocked('js-shuiwang-2026'), true, '本地解锁落盘')

  // 灰置形态（503）：弹层照常可看规则，同意走降级文案不进支付
  storage.clear()
  calls.toasts.length = 0
  calls.virtualPays.length = 0
  const gray = mkPage()
  gray.data.payGrayed = true
  pageCfg.onUnlock.call(gray)
  assert.equal(gray.data.paySheetOpen, true, '灰置时披露弹层照常打开')
  await pageCfg.onPayAgree.call(gray)
  assert.ok(calls.toasts.some((t) => t.includes('开通中')), '灰置同意走降级文案')
  assert.equal(calls.virtualPays.length, 0, '灰置不触支付')
  assert.equal(store.isUnlocked('js-shuiwang-2026'), false)
})

test('agreement 页注册与入口：app.json 已注册、me 页关于区挂「用户协议与规则」', () => {
  const appJson = JSON.parse(readFileSync(resolve(PROJECT, 'app.json'), 'utf8'))
  assert.ok(appJson.pages.includes('pages/agreement/agreement'), 'app.json 注册协议页')
  const meWxml = readFileSync(resolve(PROJECT, 'pages/me/me.wxml'), 'utf8')
  assert.ok(meWxml.includes('用户协议与规则') && meWxml.includes('onOpenAgreement'), 'me 页关于区入口在位')
  const agrWxml = readFileSync(resolve(PROJECT, 'pages/agreement/agreement.wxml'), 'utf8')
  assert.ok(agrWxml.includes('versionLine'), '规则页文末版本行渲染')
})

test('决策卡高试读比明示（决策②）：过半章免费时给付费范围注记', () => {
  const toc = []
  for (let i = 1; i <= 19; i++) toc.push({ id: `ch${String(i).padStart(2, '0')}`, title: `第${i}章`, is_trial: i <= 17 ? 1 : 0 })
  const d = fmt.buildDecisionCard({ toc, remaining_chapters: 2, remaining_pages: 1100 })
  assert.ok(d.paywallNote.includes('17/19'), '注记含试读比')
  assert.ok(d.paywallNote.includes('末 2 章'), '注记指明付费=末 2 章数据本体')
  const low = fmt.buildDecisionCard({
    toc: toc.slice(0, 10).map((t, i) => ({ ...t, is_trial: i < 1 ? 1 : 0 })),
    remaining_chapters: 9,
  })
  assert.equal(low.paywallNote, '', '低试读比报告不出现注记')
  const offline = fmt.buildDecisionCard(null, Array.from({ length: 19 }, (_, i) => ({ id: `c${i}`, title: `t${i}` })))
  assert.equal(offline.paywallNote, '', '包内兜底默认 2 章试读不触发')
})

// —— 22-31. P1 前端出厂门（点赞赠阅/批评评分退款/组队/书券/情报官/agreement v1.2 镜像）——
// mock 会话状态为模块级：每测先 resetMockStateForTest 取独立基线（与 api.resetPayGrayForTest 同惯例）
const mockFix = require(resolve(PROJECT, 'utils/mock-fixtures.js'))
const p1view = require(resolve(PROJECT, 'utils/p1-view.js'))
const freshMock = () => {
  mockFix.resetMockStateForTest()
  cfg.appConfig.mockApi = true
}

test('agreement v1.2 镜像：§六邀请双组件（情报官 L1 判据）+情报官体系规则逐字+变更行版本链', () => {
  assert.ok(agr.VOUCHER_SOURCE_INVITE_LINE.includes('「馆友」解锁'), '来源1含馆友组件')
  assert.ok(agr.VOUCHER_SOURCE_INVITE_LINE.includes('②50 书券'), '来源1含书券组件')
  assert.ok(agr.VOUCHER_SOURCE_INVITE_LINE.includes('未达成时进度可见但不发放'), '未达不发口径逐字')
  assert.ok(agr.INVITE_EFFECTIVE_RULE_LINE.includes('（首触归因）'), '统计口径含首触归因')
  assert.ok(agr.INVITE_EFFECTIVE_RULE_LINE.includes('累计停留满 3 分钟'), '有效带新条件②停留口径逐字')
  assert.equal(agr.INVITE_LADDER_RULES.length, 3, '三档梯队三条')
  assert.equal(agr.INVITE_LADDER_TAIL_RULES.length, 3, '收束三条')
  assert.ok(agr.INVITE_LADDER_TAIL_RULES.some((t) => t.includes('奖励保持有效，不因判据升级而回退')), '旧口径衔接逐字')
  assert.ok(agr.INVITE_LADDER_TAIL_RULES.some((t) => t.startsWith('分享是路径之一而非唯一：')), '路径声明逐字')
  assert.ok(agr.INVITE_LADDER_TAIL_RULES.some((t) => t.includes('平台保留调整或取消奖励的权利')), '异常参与保留权逐字')
  assert.ok(agr.AGREEMENT_CHANGELOG_LINE.startsWith('变更：v1.2（2026-09-28）'), '变更行版本与日期')
  const voucherSec = agr.AGREEMENT_SECTIONS.find((s) => s.key === 'voucher')
  const inviteClause = voucherSec.clauses.find((c) => c.id === 'invite')
  assert.ok(inviteClause, '§六内 invite clause 在位（结构化引用位）')
  assert.equal(inviteClause.foldable, false, '情报官体系规则平铺不折叠')
  assert.ok(JSON.stringify(voucherSec).includes(agr.VOUCHER_SOURCE_INVITE_LINE), '§六来源1整条逐字入节')
})

test('p1-view 规则提取：组队 72h/批评退款映射/点赞规则均引自 agreement 真源逐字', () => {
  const team = p1view.teamRulesLines()
  assert.equal(team.length, 4, '组队规则四条')
  assert.ok(team.some((t) => t.includes('自组队内第一笔付款完成起 72 小时内未组满 3 人')), '72h 未满员处置逐字')
  assert.ok(team.some((t) => t.includes('全队共付 ¥998')), '组队价逐字')
  const refund = p1view.critRefundRulesLines()
  assert.equal(refund.length, 3, '退款映射三条')
  assert.ok(refund[0].includes('50 分退实付金额的 50%，100 分退 100%'), '线性映射逐字')
  assert.ok(refund[0].includes('例：得分 70 分、单篇实付 ¥498，退 ¥348.60'), '70 分示例逐字')
  const like = p1view.likeRulesLines()
  assert.equal(like.length, 5, '点赞规则五条')
  assert.ok(like.some((l) => l.includes('必得·附条件赠送')), '必得·附条件赠送逐字')
  assert.ok(like.some((l) => l.includes('与分享无关')), '点赞与分享解耦逐字（FR-P1-01）')
})

test('mockApi P1-1 点赞：当日首赞必得赠阅+防泄漏断言+同日二次 429+赠品非所赞报告', async () => {
  freshMock()
  await apiMod.silentLogin()
  const res = await apiMod.api.like('js-shuiwang-2026')
  assert.equal(res.granted, true, '当日首次点赞必得（非抽奖）')
  assert.equal(res.gift_rule, '每日限 1 份·必得·附条件赠送', 'gift_rule 契约串')
  assert.ok(res.granted_report_id && res.granted_report_id !== 'js-shuiwang-2026', '赠品=服务端从未购清单指定且≠所赞报告（防点赞白嫖所赞篇）')
  const s = JSON.stringify(res)
  assert.ok(!s.includes('html') && !s.includes('sign_data') && !s.includes('session_key'), '防泄漏：点赞响应无正文/密钥类字段')
  const me = await apiMod.api.me()
  const giftEnt = me.entitlements.find((e) => e.report_id === res.granted_report_id)
  assert.ok(giftEnt && giftEnt.source === 'gift', '赠品即时入 entitlements(source=gift)')
  await assert.rejects(
    () => apiMod.api.like('sd-gangkou-2026'),
    (e) => e.statusCode === 429 && e.code === 'GIFT_DAILY_LIMIT',
    '同日第二次点赞 429 明日再来（换一篇也限；FR-P1-01）',
  )
})

test('mockApi P1-2 批评前置闸：字数/未购/未读/锚定 同步拒绝', async () => {
  freshMock()
  await apiMod.silentLogin()
  const valid = '第九章 投资规模与招标节奏的数据和我在项目上的实际观察不一致，2026 年节奏偏慢，建议核对来源口径，希望补充资金到位的逐月明细以便复核。'
  await assert.rejects(() => apiMod.api.criticize('js-shuiwang-2026', '好'.repeat(49)), (e) => e.statusCode === 400 && e.code === 'LENGTH_INVALID', '49 字拒绝')
  await assert.rejects(() => apiMod.api.criticize('js-shuiwang-2026', '字'.repeat(301)), (e) => e.statusCode === 400 && e.code === 'LENGTH_INVALID', '301 字拒绝')
  await assert.rejects(
    () => apiMod.api.criticize('js-shuiwang-2026', valid),
    (e) => e.statusCode === 403 && e.code === 'NOT_PURCHASED',
    '未购该报告 403（先解锁/获赠）',
  )
  const sign = await apiMod.api.paySign('js-shuiwang-2026')
  await apiMod.api.payStatus(sign.out_trade_no)
  await assert.rejects(
    () => apiMod.api.criticize('js-shuiwang-2026', valid),
    (e) => e.statusCode === 400 && e.code === 'NO_READ_RECORD',
    '已购未读 400（层①真实阅读行为闸，FR-P1-03）',
  )
  await apiMod.api.fetchChapter('js-shuiwang-2026', 'ch03')
  await assert.rejects(
    () => apiMod.api.criticize('js-shuiwang-2026', '这句话完全没有引用任何具体的章节编号或者数据点只是把模板化的套话重复了一遍又一遍用来凑足五十个字以上的长度而已。'),
    (e) => e.statusCode === 400 && e.code === 'ANCHOR_ZERO',
    '纯模板话术锚定分=0 拒绝（FR-P1-03）',
  )
})

test('mockApi P1-2/3/4 批评全链：预筛→懒评分→线性退款→重复 409→/me 退款记录', async () => {
  freshMock()
  await apiMod.silentLogin()
  const sign = await apiMod.api.paySign('js-guanqu-2026')
  await apiMod.api.payStatus(sign.out_trade_no)
  await apiMod.api.fetchChapter('js-guanqu-2026', 'ch03') // 在线拉付费章=真实阅读行为落账
  const res = await apiMod.api.criticize('js-guanqu-2026', '第九章 投资规模的数据和我在项目上的实际观察不一致，2026 年的招标节奏明显偏慢，建议核对来源口径，希望后续版本补充资金到位的逐月明细以便复核与追踪。')
  assert.equal(res.stage, 'pre_gate_passed', '预筛通过')
  assert.equal(res.scoring, 'async', '评分异步')
  assert.ok(res.poll.endsWith(res.criticism_id), 'poll 路径指向本条')
  assert.ok(typeof res.anchor_score === 'number' && res.anchor_score >= 0.5, '含章引用锚定分达标')
  await assert.rejects(
    () => apiMod.api.criticize('js-guanqu-2026', '第九章 另一段批评内容长度足够五十个字并且也引用了具体章节编号与数据点用于验证每报告每账号一次的重复闸门是否生效可靠。'),
    (e) => e.statusCode === 400 && e.code === 'CRITICISM_DUP',
    '每报告每账号 1 次（FR-P1-02）',
  )
  const detail = await apiMod.api.criticism(res.criticism_id)
  assert.equal(detail.status, 'scored', '首查即落评分')
  assert.ok(detail.llm_scores.sincerity > 0 && detail.llm_scores.authenticity > 0 && detail.llm_scores.constructiveness > 0, '三维分各 0-100')
  assert.ok(detail.llm_scores.rationale.includes('↔'), '评分依据=批评句↔报告章节')
  assert.ok(detail.final_score >= 50, '高分样例（章引用+数据+建议）')
  const rf = await apiMod.api.refundApply(res.criticism_id)
  assert.equal(rf.amount_fen, Math.round((49800 * detail.final_score) / 100), '退款金额=线性映射 round(49800×分/100)')
  assert.equal(rf.method, detail.final_score / 100 <= 0.5 ? 'auto' : 'manual', '自动退仅 ≤50% 档（API_DESIGN P1-4）')
  assert.equal(rf.status, 'initiated')
  await assert.rejects(
    () => apiMod.api.refundApply(res.criticism_id),
    (e) => e.statusCode === 409 && e.code === 'REFUND_DUP',
    '同一批评重复申请 409',
  )
  const me = await apiMod.api.me()
  assert.ok(me.refunds.some((r) => r.report_id === 'js-guanqu-2026' && r.amount_fen === rf.amount_fen), '/me 扩展 refunds 列表出现（P0-12 向后兼容追加）')
  assert.equal(me.refund_count_month, 1, '当月退款计数 1（上限 2）')
})

test('mockApi P1-4 低分轨：总分 <50 不退款发感谢券（method=voucher 入书券账本）', async () => {
  freshMock()
  await apiMod.silentLogin()
  const sign = await apiMod.api.paySign('zj-chouneng-2026')
  await apiMod.api.payStatus(sign.out_trade_no)
  await apiMod.api.fetchChapter('zj-chouneng-2026', 'ch03')
  // 55 字·无章引用·无建议词·仅 1 个数字过锚定闸 → 真诚 51/真实 56/建设 42 → 49.7 <50
  const base = '篇幅只有下限，没有引用任何章节编号，也没有给出可落地的优化方向，只有一个数字 3 用来通过锚定闸门，其余全是凑字数的重复表述而已。'
  const low = Array.from(base).slice(0, 55).join('')
  assert.equal(Array.from(low).length, 55)
  const res = await apiMod.api.criticize('zj-chouneng-2026', low)
  const detail = await apiMod.api.criticism(res.criticism_id)
  assert.ok(detail.final_score < 50, `低分样例实测 ${detail.final_score} <50`)
  const rf = await apiMod.api.refundApply(res.criticism_id)
  assert.equal(rf.method, 'voucher', '<50 档=感谢券（书券）')
  assert.equal(rf.amount_fen, 2000, '感谢券金额=运营参数（mock 样例 ¥20）')
  const vc = await apiMod.api.meVouchers()
  assert.ok(vc.ledger.some((x) => x.source === 'criticism_thanks'), '感谢券入书券账本')
})

test('mockApi P1-2 相似查重：与历史批评高度雷同 409 转人工不自动拒', async () => {
  freshMock()
  await apiMod.silentLogin()
  const base = '第十章 招标采购格局的数据口径和我在项目上的实际观察不一致，2025 年的节奏偏快，建议核对来源，希望补充逐月明细以便复核追踪使用。'
  for (const rid of ['sd-gangkou-2026', 'gd-guijiao-2026']) {
    const sign = await apiMod.api.paySign(rid)
    await apiMod.api.payStatus(sign.out_trade_no)
    await apiMod.api.fetchChapter(rid, 'ch03')
  }
  const first = await apiMod.api.criticize('sd-gangkou-2026', base)
  assert.equal(first.stage, 'pre_gate_passed')
  await assert.rejects(
    () => apiMod.api.criticize('gd-guijiao-2026', base + '再补一句不同的结尾内容。'),
    (e) => e.statusCode === 409 && e.code === 'SIMILARITY_HIGH',
    '超阈值→409 SIMILARITY_HIGH（转人工队列，不自动拒；AGREEMENT 2.6）',
  )
})

test('mockApi P1-9 组队：创建→加入→满员发放→满员/重复 409（¥998/3 人）', async () => {
  freshMock()
  await apiMod.silentLogin()
  const t1 = await apiMod.api.teamCreate('js-shuiwang-2026')
  assert.equal(t1.size, 1, '创建后 size=1')
  assert.equal(t1.capacity, 3)
  assert.equal(t1.total_price_fen, 99800, '组队价 ¥998/3 人')
  assert.equal(t1.status, 'open')
  const t2 = await apiMod.api.teamJoin(t1.team_id)
  assert.equal(t2.size, 2, '加入后 size=2（mock 单用户演示：引擎按 uid 去重）')
  await assert.rejects(
    () => apiMod.api.teamCreate('js-guanqu-2026'),
    (e) => e.statusCode === 409 && e.code === 'TEAM_DUP',
    '已在 open 队重复创建 409',
  )
  const t3 = await apiMod.api.teamJoin(t1.team_id)
  assert.equal(t3.status, 'full', '满 3 人成队')
  assert.equal(t3.size, 3)
  const me = await apiMod.api.me()
  assert.ok(me.entitlements.some((e) => e.report_id === 'js-shuiwang-2026' && e.source === 'invite'), '满员全队发放 source=invite')
  await assert.rejects(
    () => apiMod.api.teamJoin(t1.team_id),
    (e) => e.statusCode === 409 && e.code === 'TEAM_FULL',
    '满员再加入 409',
  )
})

test('mockApi P1-10 书券：余额/账本→兑换成功→余额不足 400（发放/消耗/余额三链一致）', async () => {
  freshMock()
  await apiMod.silentLogin()
  const v0 = await apiMod.api.meVouchers()
  assert.equal(v0.balance_fen, 50000, '初始余额=campaign 样例（mock 演示）')
  assert.ok(Array.isArray(v0.ledger) && v0.ledger.length > 0, '账本逐笔在位')
  const r1 = await apiMod.api.voucherRedeem('js-shuiwang-2026')
  assert.equal(r1.redeemed, true)
  assert.equal(r1.deducted_fen, 49800, '49800 分兑一份')
  const v1 = await apiMod.api.meVouchers()
  assert.equal(v1.balance_fen, 200, '消耗后余额=发放-消耗')
  assert.ok(v1.ledger.some((x) => x.status === 'used' && x.source_ref === 'redeem:js-shuiwang-2026'), '消耗明细入账本')
  const me = await apiMod.api.me()
  assert.ok(me.entitlements.some((e) => e.report_id === 'js-shuiwang-2026' && e.source === 'voucher'), '兑换即得权益 source=voucher')
  await assert.rejects(
    () => apiMod.api.voucherRedeem('zj-chouneng-2026'),
    (e) => e.statusCode === 400 && e.code === 'BALANCE_INSUFFICIENT',
    '余额不足 400',
  )
})

test('mockApi P1-8 邀请：未达成时进度可见但不发放+情报官卡整形（v1.2 有效带新口径）', async () => {
  freshMock()
  await apiMod.silentLogin()
  const rel = await apiMod.api.inviteRelations()
  assert.equal(rel.progress.new_users, 0, '有效带新数 0（已邀 1 位未过质量门不算有效带新）')
  assert.equal(rel.progress.required, 1, 'required=1（L1 门槛）')
  assert.equal(rel.progress.unlocked, false, '未达 L1 不解锁（FR-P1-09 v1.2）')
  assert.equal(rel.voucher_earned_fen, 0, '未达成不发券')
  assert.ok(rel.invited.length === 1 && rel.invited[0].invitee_uid, '被邀列表在位')
  const card = p1view.buildInviteCard(rel)
  assert.equal(card.progressText, '有效带新 0/1 位')
  assert.ok(card.hint.includes('未达成时进度可见但不发放'), 'hint 引 v1.2 口径')
  assert.equal(card.unlocked, false, '馆友标记未点亮')
})

// —— 32-39. P1 降级矩阵 + 纯函数边界 + 三页 UI/逻辑走查 ——

test('api P1 端点真实模式降级：网络失败→服务维护语义（like/criticize/teamCreate/meVouchers）', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ network: true })
  for (const fn of [() => apiMod.api.like('x'), () => apiMod.api.criticize('x', 'y'), () => apiMod.api.teamCreate('x'), () => apiMod.api.meVouchers()]) {
    await assert.rejects(fn, (e) => e.network === true && e.message.includes('服务维护'), 'P1 入口离线走既有降级 idiom（NFR-11）')
  }
})

test('p1-view 纯函数：计数器 50-300 边界+组队视图+回执三态+书券卡', () => {
  assert.equal(p1view.critCounter('好'.repeat(49)).ok, false)
  assert.equal(p1view.critCounter('好'.repeat(50)).ok, true)
  assert.equal(p1view.critCounter('好'.repeat(300)).ok, true)
  assert.equal(p1view.critCounter('好'.repeat(301)).ok, false)
  assert.equal(p1view.critCounter('好'.repeat(120)).text, '120/300')
  const tv = p1view.buildTeamView({ team_id: 't1', size: 2, capacity: 3, total_price_fen: 99800, status: 'open' })
  assert.equal(tv.progressText, '已入队 2/3 人')
  assert.equal(tv.priceYuan, '998')
  assert.equal(tv.open, true)
  const pending = p1view.buildCritReceipt({ criticism_id: 'c1', stage: 'pre_gate_passed' })
  assert.ok(pending.stageText.includes('评分进行中'), '受理态文案')
  assert.equal(pending.canApplyRefund, false, '未出分不可申请退款')
  const scored = p1view.buildCritReceipt({ criticism_id: 'c1', stage: 'pre_gate_passed' }, { status: 'scored', final_score: 76.7, llm_scores: { rationale: '「x」↔ 第九章' } })
  assert.ok(scored.canApplyRefund, '≥50 分可申请')
  assert.ok(scored.refundText.includes('50 分退 50%'), '线性退款规则展示')
  assert.equal(scored.rationale, '「x」↔ 第九章')
  const refunded = p1view.buildCritReceipt({ criticism_id: 'c1', stage: 'pre_gate_passed' }, { status: 'scored', final_score: 76.7, refund: { method: 'manual', amount_fen: 38200, status: 'initiated' } })
  assert.equal(refunded.canApplyRefund, false)
  assert.ok(refunded.refundApplied && refunded.refundText.includes('382') && refunded.refundText.includes('人工审核处理'), '退款回执含金额与方式')
  const voucher = p1view.buildCritReceipt({ criticism_id: 'c1', stage: 'pre_gate_passed' }, { status: 'scored', final_score: 42, refund: { method: 'voucher', amount_fen: 2000, status: 'settled' } })
  assert.ok(voucher.refundText.includes('感谢券') && voucher.refundText.includes('20'), '<50 感谢券文案')
  const vc = p1view.buildVoucherCard({ balance_fen: 50000, ledger: [{ id: 'v1', amount_fen: 50000, source: 'campaign', status: 'active', created_at: '2026-09-28T09:00:00+08:00' }] })
  assert.equal(vc.canRedeem, true)
  assert.equal(vc.progressPct, 100)
  assert.equal(vc.balanceYuan, '500')
  assert.equal(vc.ledger[0].amountYuan, '+500')
  assert.equal(vc.ledger[0].neg, false)
})

test('detail 页 P1 UI 走查：点赞/组队/批评入口绑定+三弹层模板引用+批评带参直达', () => {
  const wxml = readFileSync(resolve(PROJECT, 'pages/detail/detail.wxml'), 'utf8')
  assert.ok(wxml.includes('bindtap="onLike"'), '底部栏点赞入口')
  assert.ok(wxml.includes('bindtap="onTeamOpen"'), '组队入口')
  assert.ok(wxml.includes('bindtap="onCritOpen"'), '批评入口')
  for (const t of ['like-sheet', 'team-sheet', 'criticize-sheet']) {
    assert.ok(wxml.includes(`template is="${t}"`), `${t} 模板渲染在位`)
  }
  const js = readFileSync(resolve(PROJECT, 'pages/detail/detail.js'), 'utf8')
  assert.ok(js.includes("query.criticize === '1'"), 'reader 轻入口带参直达批评 sheet')
  assert.ok(js.includes('p1-view'), '视图构建走 p1-view 共享层')
})

test('detail 页 P1 逻辑：点赞开结果弹层（服务端定赠品）+批评计数闸+未购分码提示', async () => {
  freshMock()
  await apiMod.silentLogin()
  let pageCfg = null
  globalThis.Page = (c) => {
    pageCfg = c
  }
  const detailPath = resolve(PROJECT, 'pages/detail/detail.js')
  delete require.cache[require.resolve(detailPath)]
  require(detailPath)
  delete require.cache[require.resolve(detailPath)]
  const mkPage = () => {
    const p = Object.create(pageCfg)
    p.data = JSON.parse(JSON.stringify(pageCfg.data))
    p.data.id = 'js-shuiwang-2026'
    p.setData = function (patch) {
      Object.assign(this.data, patch)
    }
    return p
  }
  const page = mkPage()
  await pageCfg.onLike.call(page)
  assert.equal(page.data.likeOpen, true, '点赞成功开结果弹层')
  assert.equal(page.data.likeGift.granted, true)
  assert.ok(page.data.likeGift.title.length > 0, '赠品卡标题来自服务端指定报告')
  assert.notEqual(page.data.likeGift.id, 'js-shuiwang-2026', '赠品≠所赞报告')
  assert.equal(page.data.likeRules.length, 5, '点赞规则引自 agreement 真源')
  const c49 = mkPage()
  pageCfg.onCritInput.call(c49, { detail: { value: '好'.repeat(49) } })
  assert.equal(c49.data.critCounter.ok, false, '49 字计数不通过')
  await pageCfg.onCritSubmit.call(c49)
  assert.equal(c49.data.critReceipt, null, '未达字数不发起提交')
  calls.toasts.length = 0
  const cOk = mkPage()
  pageCfg.onCritInput.call(cOk, { detail: { value: '第九章 投资规模的数据和实际观察不一致，2026 年节奏偏慢，建议核对口径，希望补充逐月明细以便复核追踪使用。' } })
  await pageCfg.onCritSubmit.call(cOk)
  assert.ok(calls.toasts.some((t) => t.includes('须先解锁')), '未购 403 分码提示')
})

test('reader 页 P1 末章轻入口：点赞/批评绑定+like-sheet 引用+末章条件', () => {
  const wxml = readFileSync(resolve(PROJECT, 'pages/reader/reader.wxml'), 'utf8')
  assert.ok(wxml.includes('bindtap="onReaderLike"'), '点赞轻入口')
  assert.ok(wxml.includes('bindtap="onReaderCriticize"'), '批评轻入口')
  assert.ok(wxml.includes('reader-p1-entry'), '轻入口区块类名（末章渲染断言）')
  assert.ok(wxml.includes('activeIdx === chapters.length - 1 || activeIdx === lastTrialIdx'), '试读末章或全文末章均出现')
  assert.ok(wxml.includes('template is="like-sheet"'), '点赞结果弹层复用共享模板')
  const js = readFileSync(resolve(PROJECT, 'pages/reader/reader.js'), 'utf8')
  assert.ok(js.includes('criticize=1'), '批评轻入口带参跳详情表单')
})

test('me 页 P1 UI 走查：书券/邀请/退款/赠品架四区块+兑换弹层', () => {
  const wxml = readFileSync(resolve(PROJECT, 'pages/me/me.wxml'), 'utf8')
  assert.ok(wxml.includes('voucher-card'), '书券余额区块')
  assert.ok(wxml.includes('攒满 ¥498 可兑换任一份研报'), '攒 498 换 1 份文案')
  assert.ok(wxml.includes('bindtap="onRedeemOpen"') && wxml.includes('bindtap="onRedeemConfirm"'), '兑换入口绑定')
  assert.ok(wxml.includes('invite-card'), '邀请战绩区块')
  assert.ok(wxml.includes('buddy-badge'), '馆友标记渲染位（v1.1）')
  assert.ok(wxml.includes('bindtap="onInviteRules"'), '邀请规则入口')
  assert.ok(wxml.includes('refund-card'), '退款记录区块')
  assert.ok(wxml.includes('赠品架'), '赠品架 tab 在位（P1 上线）')
  assert.ok(wxml.includes('redeem-mask'), '兑换弹层在位')
  const js = readFileSync(resolve(PROJECT, 'pages/me/me.js'), 'utf8')
  assert.ok(js.includes('meVouchers') && js.includes('inviteRelations'), '三源并行拉取（/me+/me/vouchers+/invite/relations）')
})

test('me 页 P1 逻辑：mock 装载四区块数据+网络全断离线降级不崩', async () => {
  freshMock()
  await apiMod.silentLogin()
  let pageCfg = null
  globalThis.Page = (c) => {
    pageCfg = c
  }
  const mePath = resolve(PROJECT, 'pages/me/me.js')
  delete require.cache[require.resolve(mePath)]
  require(mePath)
  delete require.cache[require.resolve(mePath)]
  const mkPage = () => {
    const p = Object.create(pageCfg)
    p.data = JSON.parse(JSON.stringify(pageCfg.data))
    p.setData = function (patch) {
      Object.assign(this.data, patch)
    }
    return p
  }
  const page = mkPage()
  await pageCfg.load.call(page)
  assert.equal(page.data.offline, false)
  assert.ok(page.data.voucher && page.data.voucher.balanceYuan === '500', '书券余额 500（campaign 样例）')
  assert.equal(page.data.voucher.canRedeem, true)
  assert.ok(page.data.invite && page.data.invite.progressText === '有效带新 0/1 位', '情报官卡有效带新 0/1')
  assert.equal(page.data.invitees.length, 1)
  assert.equal(page.data.refunds.length, 0, '初始无退款记录（空态渲染）')
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ network: true })
  const p2 = mkPage()
  await pageCfg.load.call(p2)
  assert.equal(p2.data.offline, true, '离线降级标记')
  assert.equal(p2.data.voucher, null, '书券区块空态（不展示错误数据）')
  assert.equal(p2.data.invite, null)
  assert.equal(p2.data.refunds.length, 0)
})

// —— 40-47. v1.2 情报官体系出厂门（AGREEMENT_COPY v1.2 镜像/转赠节/情报官卡/dwell 停留上报）——

test('agreement v1.2 版本链：八节顺移（transfer 插§四）+版本行/变更行', () => {
  assert.equal(agr.AGREEMENT_VERSION_LINE, '版本：v1.2')
  assert.deepEqual(
    agr.AGREEMENT_SECTIONS.map((s) => s.key),
    ['user', 'pay', 'like', 'transfer', 'team', 'voucher', 'invoice', 'footer'],
    '八节键序：转赠插第四节，组队/书券/发票/页脚顺移五六七八',
  )
  const h = agr.AGREEMENT_SECTIONS.map((s) => s.heading)
  assert.equal(h[3], '四、转赠规则（已购报告）')
  assert.equal(h[4], '五、组队规则')
  assert.equal(h[5], '六、书券说明')
  assert.equal(h[6], '七、发票')
  assert.equal(h[7], '八、页脚免责声明（一行版）')
  assert.ok(agr.AGREEMENT_CHANGELOG_LINE.startsWith('变更：v1.2（2026-09-28）'), '变更行头部逐字')
  assert.ok(agr.AGREEMENT_CHANGELOG_LINE.includes('新增 §四转赠规则（仅限本人付费购买、每报告终身 1 次、与退款互斥）'), '转赠要点入变更行')
  assert.ok(agr.AGREEMENT_CHANGELOG_LINE.includes('v1.1（2026-09-28）'), '版本链保留 v1.1 记录')
  assert.ok(agr.AGREEMENT_CHANGELOG_LINE.endsWith('v1.0 初版七节。'), '版本链以 v1.0 收尾逐字')
})

test('agreement v1.2 §四转赠节：六条逐字（范围/终身 1 次/权益转移/退款互斥/发票/对价）', () => {
  const sec = agr.AGREEMENT_SECTIONS.find((s) => s.key === 'transfer')
  assert.ok(sec, 'transfer 节在位')
  const blk = sec.clauses[0].blocks[0]
  assert.equal(blk.kind, 'bullets')
  assert.equal(blk.items.length, 6, '转赠规则六条')
  assert.equal(blk.items[0], '转赠范围：仅限您本人付费购买解锁的报告。点赞获赠、书券兑换、组队获得、他人转赠给您的报告，以及馆友试读权益，均不可转赠。')
  assert.equal(blk.items[1], '次数限制：每份可转赠的报告，您的账号终身仅可转赠 1 次；转赠一经完成不可撤回。')
  assert.equal(blk.items[3], '与退款的关系：存在未完结的批评评分退款申请的报告不可转赠；转赠完成后，您不再可就该报告发起批评评分退款。')
  assert.equal(blk.items[4], '发票：发票按原购买记录开具，不随转赠转移。')
  assert.equal(blk.items[5], '受赠方须为总包学园注册用户；转赠不产生任何现金对价。')
  assert.equal(sec.clauses[0].foldable, false, '转赠节平铺不折叠')
})

test('agreement v1.2 情报官体系块：subhead 逐字+三档梯队锚点+书券来源（四种）', () => {
  const voucherSec = agr.AGREEMENT_SECTIONS.find((s) => s.key === 'voucher')
  const inviteClause = voucherSec.clauses.find((c) => c.id === 'invite')
  assert.ok(inviteClause, 'invite clause 在位（anchor=invite 跳转目标）')
  const flat = JSON.stringify(voucherSec)
  assert.ok(flat.includes('情报官体系与有效带新规则'), 'subhead 逐字（v1.2 新块名）')
  assert.ok(agr.INVITE_EFFECTIVE_RULE_LINE.includes('②进入总包学园后累计停留满 3 分钟（以平台记录为准）'), '有效带新条件②逐字')
  assert.ok(agr.INVITE_EFFECTIVE_RULE_LINE.endsWith('同一新用户只计入首位邀请人（首触归因）。'), '首触归因收尾逐字')
  assert.ok(agr.INVITE_LADDER_RULES[0].startsWith('L1「观察员」（累计 1 位有效带新）'), 'L1 档逐字')
  assert.ok(agr.INVITE_LADDER_RULES[0].includes('判据自本版本起由「邀 2 位新用户」升级为「1 位有效带新」'), '判据升级口径逐字')
  assert.ok(agr.INVITE_LADDER_RULES[1].includes('L2「分析师」（累计 5 位）'), 'L2 档逐字')
  assert.ok(agr.INVITE_LADDER_RULES[2].includes('L3「情报官」（累计 20 位）'), 'L3 档逐字')
  assert.ok(agr.INVITE_LADDER_RULES[2].endsWith('（闭门会为远期权益，具体安排以平台届时公告为准）。'), 'L3 收尾逐字')
  assert.ok(agr.VOUCHER_SOURCE_INVITE_LINE.includes('即情报官 L1「观察员」'), '来源1 挂 L1 判据逐字')
  assert.ok(agr.VOUCHER_SOURCE_LEVEL_LINE.includes('L2「分析师」达成发 200 书券、L3「情报官」达成发 1000 书券'), '来源2 情报官等级奖励逐字')
  assert.ok(flat.includes('书券来源（四种）：'), '来源数 v1.1 三种→v1.2 四种')
  const numbersBlk = voucherSec.clauses[0].blocks.find((b) => b.kind === 'numbers')
  assert.equal(numbersBlk.items.length, 4, 'numbers 四条')
  assert.equal(numbersBlk.items[1], agr.VOUCHER_SOURCE_LEVEL_LINE, '来源2 整条入 numbers')
})

test('p1-view 情报官卡：未达成形态（none 徽章+0/1 进度+三档全灰）', () => {
  const card = p1view.buildInviteCard({
    invited: [{ invitee_uid: 'uInvite01', status: 'registered', ts: '2026-09-28T09:30:00+08:00' }],
    progress: { new_users: 0, required: 1, unlocked: false },
    voucher_earned_fen: 0,
    level: 'none',
    level_name: '',
    effective_count: 0,
    next_threshold: 1,
    ladder: [
      { level: 'L1', name: '观察员', threshold: 1, reached: false },
      { level: 'L2', name: '分析师', threshold: 5, reached: false },
      { level: 'L3', name: '情报官', threshold: 20, reached: false },
    ],
  })
  assert.equal(card.level, 'none')
  assert.equal(card.levelName, '未达成')
  assert.equal(card.badgeText, '未达成', '未达成徽章')
  assert.equal(card.progressText, '有效带新 0/1 位')
  assert.equal(card.progressPct, 0)
  assert.equal(card.unlocked, false)
  assert.equal(card.effectiveCount, 0)
  assert.equal(card.nextThreshold, 1, '下一档=L1 门槛 1')
  assert.equal(card.ladder.length, 3, '三档梯队')
  assert.ok(card.ladder.every((s) => s.reached === false), '全档未亮')
  assert.equal(card.ladder[2].text, 'L3 情报官 · 20 位')
  assert.ok(card.hint.includes('未达成时进度可见但不发放'), '未达成 hint 引真源口径')
})

test('p1-view 情报官卡：L1 达成/L3 满级推导/v1.1 旧形状兼容', () => {
  const l1 = p1view.buildInviteCard({
    progress: { new_users: 1, required: 1, unlocked: true },
    voucher_earned_fen: 5000,
    level: 'L1',
    level_name: '观察员',
    effective_count: 1,
    next_threshold: 5,
    ladder: [
      { level: 'L1', name: '观察员', threshold: 1, reached: true },
      { level: 'L2', name: '分析师', threshold: 5, reached: false },
      { level: 'L3', name: '情报官', threshold: 20, reached: false },
    ],
  })
  assert.equal(l1.badgeText, 'L1 观察员', '等级徽章')
  assert.equal(l1.levelName, '观察员')
  assert.equal(l1.nextThreshold, 5, '下一档 L2=5')
  assert.equal(l1.ladder[0].reached, true)
  assert.equal(l1.ladder.filter((s) => s.reached).length, 1, '仅 L1 亮')
  assert.equal(l1.earnedYuan, '50', 'L1 奖励 50 书券')
  assert.equal(l1.progressText, '有效带新 1/5 位')
  assert.equal(l1.progressPct, 20)
  assert.ok(l1.hint.includes('升 L2「分析师」'), 'hint 指向下一档')

  // 引擎未升级（v1.1 旧形状无 level/ladder）：按有效带新数推导 L3 满级
  const l3 = p1view.buildInviteCard({ progress: { new_users: 20, unlocked: true } })
  assert.equal(l3.level, 'L3', '20 位有效带新推导满级')
  assert.equal(l3.badgeText, 'L3 情报官')
  assert.equal(l3.nextThreshold, null, '满级无下一档')
  assert.equal(l3.progressText, '有效带新 20 位 · 梯队满级')
  assert.equal(l3.progressPct, 100)
  assert.ok(l3.hint.includes('年度闭门会邀请'), 'L3 hint 含远期权益口径')

  // v1.1 兼容：progress.new_users=1（旧「已邀 1 位」）→ 新口径视为 1 位有效带新 → L1
  const legacy = p1view.buildInviteCard({ progress: { new_users: 1, required: 2, unlocked: false }, voucher_earned_fen: 0 })
  assert.equal(legacy.level, 'L1', '旧形状按新判据推导 L1')
  assert.equal(legacy.required, 2, '旧 required 原样保留（兼容不篡改服务端值）')
  assert.equal(legacy.progressText, '有效带新 1/5 位')
})

test('api.inviteDwell：mock 契约（无归因恒 200/401/400）+真实模式 POST 契约（Bearer+body）', async () => {
  // mock：已登录无归因关系 → 恒 200 relation_marked:false
  freshMock()
  await apiMod.silentLogin()
  const r = await apiMod.api.inviteDwell('js-shuiwang-2026', 120)
  assert.deepEqual(r, { relation_marked: false, effective: false }, '无归因关系回包两字段恒定')

  // mock：未登录 401（anon 直连不触发 401 静默重登重试）
  mockFix.resetMockStateForTest()
  storage.delete('zongbao_token')
  await assert.rejects(
    () => apiMod.request('POST', '/invite/dwell', { report_id: 'js-shuiwang-2026', seconds: 60 }, { anon: true }),
    (e) => e.statusCode === 401,
    'dwell 须 Bearer',
  )

  // mock：缺 report_id 400
  await apiMod.silentLogin()
  await assert.rejects(() => apiMod.api.inviteDwell('', 60), (e) => e.statusCode === 400 && e.code === 'PARAM_INVALID', '缺 report_id 拒绝')

  // 真实模式：POST /invite/dwell + Authorization + body {report_id, seconds}
  cfg.appConfig.mockApi = false
  stubHandler = (o) =>
    o.url.indexOf('/invite/dwell') >= 0
      ? { statusCode: 200, data: { relation_marked: false, effective: false } }
      : { statusCode: 404, data: {} }
  storage.set('zongbao_token', 'tk-dwell')
  await apiMod.api.inviteDwell('js-shuiwang-2026', 45)
  const hit = calls.requests[calls.requests.length - 1]
  assert.ok(hit.url.endsWith('/invite/dwell'), '路径=POST /api/v1/invite/dwell')
  assert.equal(hit.method, 'POST')
  assert.deepEqual(hit.data, { report_id: 'js-shuiwang-2026', seconds: 45 }, 'body 契约')
  assert.equal(hit.header.Authorization, 'Bearer tk-dwell', 'Bearer 注入')
})

test('reader 停留上报触发条件：<30s 不报/≥30s 报/600 封顶/p1 关不报/onHide 分段不重复计', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ statusCode: 200, data: {} })
  let pageCfg = null
  globalThis.Page = (c) => {
    pageCfg = c
  }
  const readerPath = resolve(PROJECT, 'pages/reader/reader.js')
  delete require.cache[require.resolve(readerPath)]
  require(readerPath)
  delete require.cache[require.resolve(readerPath)]
  const mkPage = () => {
    const p = Object.create(pageCfg)
    p.data = JSON.parse(JSON.stringify(pageCfg.data))
    p.data.reportId = 'js-shuiwang-2026'
    p.setData = function (patch) {
      Object.assign(this.data, patch)
    }
    return p
  }
  const flush = () => new Promise((r) => setTimeout(r, 20))
  const dwellCalls = () => calls.requests.filter((x) => x.url.indexOf('/invite/dwell') >= 0)

  // 纯函数判据：29s→0 / 30s→30 / 700s→600
  const t0 = 1700000000000
  assert.equal(p1view.dwellReportSeconds(t0, t0 + 29 * 1000), 0, '29 秒不上报')
  assert.equal(p1view.dwellReportSeconds(t0, t0 + 30 * 1000), 30, '恰 30 秒上报')
  assert.equal(p1view.dwellReportSeconds(t0, t0 + 700 * 1000), 600, '单段封顶 600（契约 seconds≤600）')

  // 页面：停留 29 秒离开 → 不上报
  calls.requests.length = 0
  const short = mkPage()
  short.onShow()
  short.dwellStart = Date.now() - 29 * 1000
  pageCfg.onUnload.call(short)
  await flush()
  assert.equal(dwellCalls().length, 0, '29 秒静默不上报')

  // 页面：停留 31 秒 → 上报 31 秒
  const ok31 = mkPage()
  ok31.onShow()
  ok31.dwellStart = Date.now() - 31 * 1000
  pageCfg.onUnload.call(ok31)
  await flush()
  assert.equal(dwellCalls().length, 1, '≥30 秒上报一次')
  assert.equal(dwellCalls()[0].data.seconds, 31)
  assert.equal(dwellCalls()[0].data.report_id, 'js-shuiwang-2026')

  // 页面：长停留封顶 600
  calls.requests.length = 0
  const cap = mkPage()
  cap.dwellStart = Date.now() - 60 * 60 * 1000
  pageCfg.onUnload.call(cap)
  await flush()
  assert.equal(dwellCalls()[0].data.seconds, 600, '1 小时停留按契约封顶 600')

  // 页面：p1 关 → 即便 ≥30 秒也不上报
  calls.requests.length = 0
  const off = mkPage()
  off.data.p1 = false
  off.dwellStart = Date.now() - 60 * 1000
  pageCfg.onUnload.call(off)
  await flush()
  assert.equal(dwellCalls().length, 0, 'p1 关零上报')

  // 页面：onHide 分段结算后返回，onUnload 只计新增停留（不重复累计）
  calls.requests.length = 0
  const seg = mkPage()
  seg.dwellStart = Date.now() - 61 * 1000
  pageCfg.onHide.call(seg)
  await flush()
  assert.equal(dwellCalls().length, 1, 'onHide 结算一次')
  pageCfg.onUnload.call(seg) // dwellStart 已重锚 → 本段 ~0 秒不再报
  await flush()
  assert.equal(dwellCalls().length, 1, '分段重锚后不重复上报')
})

test('mockApi v1.2 invite 两形态：默认未达成 / ?form=achieved=L1 达成（ladder 三档）', async () => {
  freshMock()
  await apiMod.silentLogin()
  const pend = await apiMod.request('GET', '/invite/relations')
  assert.equal(pend.level, 'none', '默认=未达成形态')
  assert.equal(pend.level_name, '')
  assert.equal(pend.effective_count, 0)
  assert.equal(pend.progress.new_users, 0, 'new_users 语义升级=有效带新数')
  assert.equal(pend.progress.required, 1, 'required=1（L1 门槛）')
  assert.equal(pend.next_threshold, 1)
  assert.equal(pend.ladder.length, 3, 'ladder 三档')
  assert.ok(pend.ladder.every((x) => x.reached === false), '全档未达成')

  const ach = await apiMod.request('GET', '/invite/relations?form=achieved')
  assert.equal(ach.level, 'L1', 'form=achieved=L1 达成形态')
  assert.equal(ach.level_name, '观察员')
  assert.equal(ach.effective_count, 1)
  assert.equal(ach.next_threshold, 5, 'L1 后下一档 L2=5')
  assert.equal(ach.progress.unlocked, true, 'L1 达成点亮馆友')
  assert.equal(ach.voucher_earned_fen, 5000, 'L1 达成发 50 书券')
  assert.equal(ach.ladder[0].reached, true)
  assert.equal(ach.ladder[1].reached, false)
  const card = p1view.buildInviteCard(ach)
  assert.equal(card.badgeText, 'L1 观察员', '情报官卡徽章=形态驱动')
  assert.equal(card.unlocked, true)
  assert.equal(card.ladder[0].reached, true)
})

test('me 页情报官卡 UI + 协议页锚点：等级徽章/三档梯队/anchor=invite（v1.2）', () => {
  const wxml = readFileSync(resolve(PROJECT, 'pages/me/me.wxml'), 'utf8')
  assert.ok(wxml.includes('level-badge'), '等级徽章渲染位')
  assert.ok(wxml.includes('invite-ladder'), '三档梯队渲染位（已达成亮）')
  assert.ok(wxml.includes('情报官体系规则'), '规则入口文案')
  const js = readFileSync(resolve(PROJECT, 'pages/me/me.js'), 'utf8')
  assert.ok(js.includes('anchor=invite'), '规则入口跳协议页情报官体系块')
  const agrJs = readFileSync(resolve(PROJECT, 'pages/agreement/agreement.js'), 'utf8')
  assert.ok(agrJs.includes('clause-invite'), 'anchor=invite 精确到§六情报官体系块')
  assert.ok(agrJs.includes('sec-transfer'), 'anchor=transfer 可跳§四转赠节')
  const agrWxml = readFileSync(resolve(PROJECT, 'pages/agreement/agreement.wxml'), 'utf8')
  assert.ok(agrWxml.includes('id="clause-{{clause.id}}"'), 'clause 级锚点 id 渲染')
})
