// tests/xy-p2.test.mjs — C 线 P2 出厂门：AI 伴读（消息/引用跳章/降级 disclaimer）/转赠（错误族+source 闸+成功失权）/
// 已购检索（游标分页+空态+跳章参数）/订阅（501 隐藏+保存/删除载荷）四件 + p2-view 纯函数 + mock 卫生扫描。
// 走 mockApi 全链（页面桩驱动，xy-pages-smoke 同范式；api 层契约经 silentLogin 真实鉴权链）。
import { test, beforeEach } from 'node:test'
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'
import { resolve } from 'node:path'
import { readFileSync } from 'node:fs'

const require = createRequire(import.meta.url)
const PROJECT = resolve('projects/zongbao')

const storage = new Map()
const navs = []
const toasts = []
let loginCount = 0

globalThis.__XY_BASE__ = 'http://stub-engine'
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
  removeStorageSync: (k) => storage.delete(k),
  login: (o) => {
    loginCount += 1
    o.success({ code: `p2-${loginCount}` })
  },
  request: () => {
    throw new Error('mock 模式不应触网')
  },
  showToast: (o) => toasts.push(o.title),
  showModal: (o) => {
    if (o.success) o.success({ confirm: true })
  },
  navigateTo: (o) => navs.push(o.url),
  redirectTo: (o) => navs.push('REDIRECT:' + o.url),
  stopPullDownRefresh: () => {},
  setClipboardData: (o) => o.success && o.success(),
}

const cfg = require(resolve(PROJECT, 'config/index.js'))
const apiMod = require(resolve(PROJECT, 'utils/api.js'))
const mockFixtures = require(resolve(PROJECT, 'utils/mock-fixtures.js'))
const mockP2 = require(resolve(PROJECT, 'utils/mock-fixtures-p2.js'))
const p2view = require(resolve(PROJECT, 'utils/p2-view.js'))

// Page 桩（xy-pages-smoke 同范式）
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
function makePageFresh(file) {
  delete require.cache[resolve(PROJECT, file)]
  return makePage(file)
}

const sleep = (ms) => new Promise((r) => setTimeout(r, ms))

async function login() {
  await apiMod.silentLogin()
}

async function buy(rid) {
  const s = await apiMod.api.paySign(rid)
  const st = await apiMod.api.payStatus(s.out_trade_no)
  assert.equal(st.entitlement_granted, true, `购买 ${rid} 发货成功`)
}

beforeEach(() => {
  storage.clear()
  navs.length = 0
  toasts.length = 0
  loginCount = 0
  cfg.appConfig.mockApi = true
  cfg.appConfig.features.p1 = true
  apiMod.resetPayGrayForTest()
  mockFixtures.resetMockStateForTest()
  mockP2.resetMockP2ForTest()
})

// —— 1. 伴读契约形状（登录+已购全链）——
test('P2 伴读 mock：已购后问答返回 answer+citations+disclaimer（引擎 local_answer 形状）', async () => {
  await login()
  await buy('js-shuiwang-2026')
  const r = await apiMod.chatReport('js-shuiwang-2026', '水网商机清单在哪一章')
  assert.equal(r.report_id, 'js-shuiwang-2026')
  assert.equal(r.question, '水网商机清单在哪一章')
  assert.equal(r.provider, 'local', '免费模型铁律：mock 恒 local，前端不选模型')
  assert.equal(r.degraded, false)
  assert.equal(r.disclaimer, '检索式应答，待接免费模型')
  assert.ok(r.answer.includes('江苏省水网工程商机研究'), 'answer 引报告题')
  assert.ok(r.citations.length >= 1 && r.citations.length <= 3, 'citations Top-K≤3')
  const c = r.citations[0]
  assert.ok(c.chapter_id && c.chapter_title, '章节定位两件')
  assert.ok(Number.isFinite(c.page) && c.page >= 1, '页码估算')
  assert.ok(c.quote.length > 0 && c.quote.length <= 90, 'quote 命中句±40 字泄漏控制')
})

// —— 2. 伴读错误闸 ——
test('P2 伴读 mock：匿名 401 / 未购 403 NOT_ENTITLED / 空与超长问句 400 INVALID_PARAM', async () => {
  // 匿名（错误 token 直打 mock，绕过 api 的 401 静默重登）
  const anon = await mockFixtures.mockRequest('POST', '/reports/js-shuiwang-2026/chat', { question: '水网' }, 'bogus-token')
  assert.equal(anon.status, 401)
  assert.equal(anon.body.code, 'UNAUTHORIZED')
  // 登录但未购
  await login()
  await assert.rejects(
    () => apiMod.chatReport('js-shuiwang-2026', '水网'),
    (e) => e.statusCode === 403 && e.code === 'NOT_ENTITLED',
  )
  // 空问句 / 201 字问句（登录+已购后）
  await buy('js-shuiwang-2026')
  const empty = await mockFixtures.mockRequest('POST', '/reports/js-shuiwang-2026/chat', { question: '   ' }, storage.get('zongbao_token'))
  assert.equal(empty.status === 400 && empty.body.code === 'INVALID_PARAM', true)
  const long = await mockFixtures.mockRequest('POST', '/reports/js-shuiwang-2026/chat', { question: '长'.repeat(201) }, storage.get('zongbao_token'))
  assert.equal(long.status === 400 && long.body.code === 'INVALID_PARAM', true)
  const edge = await mockFixtures.mockRequest('POST', '/reports/js-shuiwang-2026/chat', { question: '长'.repeat(200) }, storage.get('zongbao_token'))
  assert.equal(edge.status, 200, '200 字=边界放行')
})

// —— 3. 消息视图纯函数（降级 disclaimer 判据）——
test('P2 chatMsgOf：local/degraded 尾注 disclaimer，openai_compat 正常腿不渲染', () => {
  const local = p2view.chatMsgOf({ answer: 'a', citations: [], provider: 'local', degraded: false, disclaimer: '检索式应答，待接免费模型' })
  assert.equal(local.showDisclaimer, true)
  assert.equal(local.disclaimer, '检索式应答，待接免费模型')
  const degraded = p2view.chatMsgOf({ answer: 'a', provider: 'openai_compat', degraded: true, disclaimer: '检索式应答，待接免费模型' })
  assert.equal(degraded.showDisclaimer, true, '降级回 local 也渲染')
  const normal = p2view.chatMsgOf({ answer: 'a', provider: 'openai_compat', degraded: false, disclaimer: '' })
  assert.equal(normal.showDisclaimer, false)
  assert.equal(p2view.chatCounter('').ok, false, '空问句不合规')
  assert.equal(p2view.chatCounter('好'.repeat(200)).ok, true, '200 字边界合规')
  assert.equal(p2view.chatCounter('好'.repeat(201)).ok, false, '201 字不合规')
})

// —— 4. reader 面板：发送→应答上屏+引用跳章；开合不动 activeIdx ——
test('P2 reader 伴读面板：消息上屏+引用胶囊跳对应章+开合不破坏阅读进度', async () => {
  await login()
  await buy('js-shuiwang-2026')
  const page = makePage('pages/reader/reader.js')
  page.onLoad({ id: 'js-shuiwang-2026' })
  await sleep(400)
  assert.equal(page.data.unlocked, true, '已购 → 解锁态（问一问入口闸 p1&&unlocked 通过）')
  page.onPickChapter({ currentTarget: { dataset: { index: 1 } } })
  await sleep(100)
  assert.equal(page.data.activeIdx, 1, '阅读进度锚在试读第 2 章')
  const idxBefore = page.data.activeIdx
  // 开合面板不动进度
  page.onChatOpen()
  assert.equal(page.data.chatOpen, true)
  page.onChatClose()
  assert.equal(page.data.chatOpen, false)
  assert.equal(page.data.activeIdx, idxBefore, '面板开合后 activeIdx 原样')
  // 发送→应答上屏
  page.onChatOpen()
  page.onChatInput({ detail: { value: '商机清单在哪一章' } })
  assert.equal(page.data.chatCounter.text, '8/200')
  await page.onChatSend()
  await sleep(120)
  const msgs = page.data.chatMsgs
  assert.equal(msgs.length, 2, '用户问+助手答两条')
  assert.equal(msgs[0].role, 'user')
  assert.equal(msgs[0].text, '商机清单在哪一章')
  assert.equal(msgs[1].role, 'assistant')
  assert.equal(msgs[1].pending, false)
  assert.ok(msgs[1].citations.length >= 1, '引用胶囊数据就绪')
  assert.equal(msgs[1].showDisclaimer, true, 'local provider 渲染 disclaimer')
  // 引用胶囊 → 跳对应章（沿用 setActive 机制）
  const cid = msgs[1].citations[0].chapter_id
  const wantIdx = page.data.chapters.findIndex((c) => c.id === cid)
  assert.ok(wantIdx >= 0, '引用 chapter_id 与阅读器章表对齐')
  page.onChatCiteTap({ currentTarget: { dataset: { cid } } })
  assert.equal(page.data.chatOpen, false, '跳章时收起面板')
  await sleep(120)
  assert.equal(page.data.activeIdx, wantIdx, '跳到引用对应章')
})

// —— 5. reader 面板 p1 闸（flag 关快照形态）——
test('P2 reader 伴读入口：p1 关 → 浮动入口随旗隐藏（makePageFresh 快照）', async () => {
  cfg.appConfig.features.p1 = false
  const page = makePageFresh('pages/reader/reader.js')
  assert.equal(page.data.p1, false, 'p1 flag 关（问一问入口 wx:if p1&&unlocked 不成立）')
  assert.equal(page.data.chatOpen, false)
  cfg.appConfig.features.p1 = true
})

// —— 6. 转赠错误族映射（纯函数 8 码全覆盖）——
test('P2 transferErrMsg：契约 8 码+网络+兜底逐码友好文案', () => {
  const cases = {
    ALREADY_TRANSFERRED: '已转赠过',
    NOT_ENTITLED: '尚未持有',
    NOT_TRANSFERABLE: '仅限本人付费购买',
    REFUND_IN_FLIGHT: '退款申请',
    TRANSFER_SELF: '不能把报告转赠给自己',
    ALREADY_ENTITLED: '对方已拥有',
    USER_NOT_FOUND: '学园号不存在',
    INVALID_PARAM: '学园号',
  }
  Object.entries(cases).forEach(([code, frag]) => {
    const msg = p2view.transferErrMsg({ code, message: `raw ${code}` })
    assert.ok(msg.includes(frag), `${code} → 含「${frag}」`)
    assert.ok(!msg.includes('raw'), `${code} → 不漏原始错误串`)
  })
  assert.equal(p2view.transferErrMsg({ code: 'NETWORK', message: '服务维护中' }), '服务维护中')
  assert.equal(p2view.transferErrMsg({ code: 'WHATEVER', message: '' }).includes('转赠失败'), true)
})

// —— 7. 转赠 mock 错误族（除退款在途外的 6 码 e2e）——
test('P2 转赠 mock：参数/未购/自赠/查无此人/对方已有/非购买源逐码', async () => {
  await login()
  // 未购
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', 'uPeer01'), (e) => e.statusCode === 403 && e.code === 'NOT_ENTITLED')
  await buy('js-shuiwang-2026')
  // 空学园号
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', '  '), (e) => e.statusCode === 400 && e.code === 'INVALID_PARAM')
  // 自赠
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', 'uMock01'), (e) => e.statusCode === 403 && e.code === 'TRANSFER_SELF')
  // 查无此人
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', 'uNobody99'), (e) => e.statusCode === 404 && e.code === 'USER_NOT_FOUND')
  // 对方已有（演示号拥有全部报告）
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', 'uPeerOwned'), (e) => e.statusCode === 409 && e.code === 'ALREADY_ENTITLED')
  // 非本人付费购买（点赞获赠源）
  const like = await apiMod.api.like('zj-chouneng-2026')
  assert.equal(like.granted, true)
  await assert.rejects(() => apiMod.transferReport(like.granted_report_id, 'uPeer01'), (e) => e.statusCode === 403 && e.code === 'NOT_TRANSFERABLE')
})

// —— 8. 转赠成功链：失权+二次 409 ——
test('P2 转赠 mock：成功→/me 权益移除+再转 409 ALREADY_TRANSFERRED', async () => {
  await login()
  await buy('js-shuiwang-2026')
  const r = await apiMod.transferReport('js-shuiwang-2026', 'uPeer01')
  assert.equal(r.transferred, true)
  assert.ok(r.transfer_id)
  assert.equal(r.to_uid, 'uPeer01')
  const me = await apiMod.api.me()
  assert.equal(me.entitlements.some((e) => e.report_id === 'js-shuiwang-2026'), false, '转出后 /me 不再含该权益')
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', 'uPeer02'), (e) => e.statusCode === 409 && e.code === 'ALREADY_TRANSFERRED')
})

// —— 9. 转赠与退款互斥：退款在途 409 ——
test('P2 转赠 mock：未完结退款申请 → 409 REFUND_IN_FLIGHT', async () => {
  await login()
  await buy('js-shuiwang-2026')
  await apiMod.api.fetchChapter('js-shuiwang-2026', 'ch03') // 层①真实阅读落账
  const crit = await apiMod.api.criticize(
    'js-shuiwang-2026',
    '第3章的投资规模数据与我的项目经验不符，样本项目数偏少，建议补充区域梯度对比与业主偏好分析，便于投标决策参考。',
  )
  await apiMod.api.refundApply(crit.criticism_id)
  await assert.rejects(() => apiMod.transferReport('js-shuiwang-2026', 'uPeer01'), (e) => e.statusCode === 409 && e.code === 'REFUND_IN_FLIGHT')
})

// —— 10. detail 转赠闸与流程（source 闸+成功后页面态刷新）——
test('P2 detail 转赠：purchase 源显示入口→确认成功→owned 失去；gift 源入口熄灭', async () => {
  await login()
  await buy('js-shuiwang-2026')
  const page = makePage('pages/detail/detail.js')
  page.onLoad({ id: 'js-shuiwang-2026' })
  await sleep(350)
  assert.equal(page.data.owned, true)
  assert.equal(page.data.ownedSource, 'purchase', '/me 权益 source=purchase（detail 响应无 source 字段）')
  page.onTransferOpen()
  assert.equal(page.data.transferOpen, true)
  assert.ok(page.data.transferRules.length === 3, '三行规则摘要')
  page.onTransferUidInput({ detail: { value: 'uPeer01' } })
  await page.onTransferConfirm()
  await sleep(400)
  assert.equal(page.data.transferOpen, false)
  assert.equal(page.data.owned, false, '成功后整页刷新：权益已失')
  assert.equal(page.data.ownedSource, '', '转赠入口联动熄灭')
  assert.ok(toasts.some((t) => t.includes('转赠成功')))
  // 获赠源（点赞得到）→ 入口闸死
  const like = await apiMod.api.like('zj-chouneng-2026')
  const giftPage = makePage('pages/detail/detail.js')
  giftPage.onLoad({ id: like.granted_report_id })
  await sleep(350)
  assert.equal(giftPage.data.owned, true)
  assert.equal(giftPage.data.ownedSource, 'gift', '获赠源不可转（NOT_TRANSFERABLE 前端闸）')
})

// —— 11. 已购检索契约：游标分页+空态+400 ——
test('P2 已购检索 mock：游标分页（next_cursor 空串止）+空 q 400+零命中空态+未购空库', async () => {
  await login()
  // 未购库：空结果不报错
  const none = await apiMod.searchOwned('章')
  assert.deepEqual([none.items.length, none.total, none.has_more, none.next_cursor], [0, 0, false, ''])
  await buy('js-shuiwang-2026')
  await buy('js-guanqu-2026')
  // 空 q
  await assert.rejects(() => apiMod.searchOwned(''), (e) => e.statusCode === 400 && e.code === 'INVALID_PARAM')
  // 游标分页：31 命中 > 页大小 20 → 两页到底
  const p1r = await apiMod.searchOwned('章')
  assert.equal(p1r.total, 31, '两报告全章命中（19+12）')
  assert.equal(p1r.items.length, 20, '首页=页大小 20')
  assert.equal(p1r.has_more, true)
  assert.ok(/^\S+:\d+$/.test(p1r.next_cursor), '游标形态 {report_id}:{chapter_idx}')
  const p2r = await apiMod.searchOwned('章', p1r.next_cursor)
  assert.equal(p2r.items.length, 11, '次页=余量 11')
  assert.equal(p2r.has_more, false)
  assert.equal(p2r.next_cursor, '', '到底游标空串')
  const keys1 = new Set(p1r.items.map((i) => `${i.report_id}/${i.chapter_id}`))
  p2r.items.forEach((i) => assert.ok(!keys1.has(`${i.report_id}/${i.chapter_id}`), '两页无重叠'))
  const first = p1r.items[0]
  assert.ok(first.title && first.chapter_title && first.snippet && Number.isFinite(first.offset), '条目五件形状')
  // 零命中
  const miss = await apiMod.searchOwned('不存在的词xyzq')
  assert.deepEqual([miss.items.length, miss.total, miss.has_more], [0, 0, false])
})

// —— 12. 已购检索页：搜索/加载更多/跳章参数 ——
test('P2 已购检索页：onSearch→onLoadMore 追加→结果项跳 reader 对应章', async () => {
  await login()
  await buy('js-shuiwang-2026')
  await buy('js-guanqu-2026')
  const page = makePage('pages/search/owned.js')
  assert.equal(page.data.p1, true)
  page.onSearchInput({ detail: { value: '章' } })
  await page.onSearch()
  await sleep(80)
  assert.equal(page.data.searched, true)
  assert.equal(page.data.items.length, 20)
  assert.equal(page.data.hasMore, true)
  await page.onLoadMore()
  await sleep(80)
  assert.equal(page.data.items.length, 31, '加载更多追加至全量')
  assert.equal(page.data.hasMore, false)
  // 跳章参数：chapter_id chNN → ?ch=NN
  const it = page.data.items.find((x) => /^ch(\d+)$/.test(x.chapter_id))
  const nn = Number(/^ch(\d+)$/.exec(it.chapter_id)[1])
  navs.length = 0
  page.onOpenItem({ currentTarget: { dataset: { rid: it.report_id, cid: it.chapter_id } } })
  assert.ok(navs[0].includes(`/pages/reader/reader?id=${it.report_id}&ch=${nn}`), `跳章参数 ch=${nn}`)
  // 空搜索词
  page.onSearchInput({ detail: { value: '  ' } })
  await page.onSearch()
  assert.ok(toasts.some((t) => t.includes('搜索词')))
})

// —— 13. 订阅：默认 501 隐藏 + configured 后保存/删除 ——
test('P2 订阅：未配置 501 SUBSCRIBE_NOT_CONFIGURED（入口隐藏）；配置后保存/删除载荷', async () => {
  await login()
  // 默认未配置 → 501 → 前端整块隐藏契约
  await assert.rejects(() => apiMod.subscriptionsGet(), (e) => e.statusCode === 501 && e.code === 'SUBSCRIBE_NOT_CONFIGURED')
  const meHidden = makePage('pages/me/me.js')
  meHidden.onShow()
  await sleep(300)
  assert.equal(meHidden.data.subscribeOn, false, '探测失败/未配置 → me 入口隐藏')
  // 配置位翻转（引擎 XY_SUBSCRIBE_* 配置后形态）
  mockP2.setMockSubscribeConfiguredForTest(true)
  const probe = await apiMod.subscriptionsGet()
  assert.equal(probe.configured, true)
  assert.deepEqual(probe.items, [])
  // 页面整块露出+保存
  const page = makePage('pages/subscribe/index.js')
  page.onLoad()
  await sleep(100)
  assert.equal(page.data.hidden, false)
  assert.equal(page.data.provinces.length, 31, '31 省常量候选')
  assert.ok(page.data.topics.length >= 1, '主题候选=catalog industry 聚合')
  page.onToggleProvince({ currentTarget: { dataset: { value: '江苏' } } })
  page.onToggleTopic({ currentTarget: { dataset: { value: page.data.topics[0].value } } })
  await page.onSubSave()
  await sleep(80)
  assert.equal(page.data.saved.length, 2, '已订阅列表两条')
  const after = await apiMod.subscriptionsGet()
  assert.deepEqual(
    after.items.map((i) => `${i.kind}:${i.value}`).sort(),
    [`province:江苏`, `topic:${page.data.topics.find((t) => t.on).value}`].sort(),
    'POST 载荷=选中的省份+主题集合',
  )
  // 空保存 → 400 INVALID_PARAM
  await assert.rejects(() => apiMod.subscriptionsSet([], []), (e) => e.statusCode === 400 && e.code === 'INVALID_PARAM')
  // 点删（DELETE kind,value）
  page.onSubRemove({ currentTarget: { dataset: { kind: 'province', value: '江苏' } } })
  await sleep(80)
  assert.equal(page.data.saved.some((i) => i.kind === 'province' && i.value === '江苏'), false, '删除后列表移除')
  assert.equal(page.data.provinces.find((p) => p.value === '江苏').on, false, '标签选中态同步熄灭')
  const final = await apiMod.subscriptionsGet()
  assert.equal(final.items.length, 1, 'DELETE 后仅剩主题')
})

// —— 14. me 页 configured 探测露出 + p1 闸 ——
test('P2 me 订阅入口：configured 后露出；p1 关 → 检索/订阅两入口随旗隐藏', async () => {
  await login()
  mockP2.setMockSubscribeConfiguredForTest(true)
  const page = makePage('pages/me/me.js')
  page.onShow()
  await sleep(300)
  assert.equal(page.data.subscribeOn, true, 'configured=true → 订阅入口露出')
  page.onOpenOwnedSearch()
  page.onOpenSubscribe()
  assert.ok(navs.some((u) => u === '/pages/search/owned'), '已购检索入口导航')
  assert.ok(navs.some((u) => u === '/pages/subscribe/index'), '订阅入口导航')
  cfg.appConfig.features.p1 = false
  const flagOff = makePageFresh('pages/me/me.js')
  assert.equal(flagOff.data.p1, false, 'p1 关 → 检索/订阅两入口（wx:if p1）隐藏')
  cfg.appConfig.features.p1 = true
})

// —— 15. 订阅候选与跳章纯函数 ——
test('P2 p2-view：31 省常量/主题聚合/chapterIdxOf 解析', () => {
  assert.equal(p2view.PROVINCE_OPTIONS.length, 31)
  assert.ok(p2view.PROVINCE_OPTIONS.includes('江苏'))
  const topics = p2view.subscribeTopics([{ industry: '水网工程' }, { industry: '灌区改造' }, { industry: '水网工程' }, {}])
  assert.deepEqual(topics, ['水网工程', '灌区改造'], 'catalog industry 聚合去重排序')
  assert.ok(p2view.subscribeTopics([]).length >= 1, '聚合空兜底固定集')
  assert.equal(p2view.chapterIdxOf('ch05'), 5)
  assert.equal(p2view.chapterIdxOf('ch12'), 12)
  assert.equal(p2view.chapterIdxOf('weird'), 1, '解析失败回第 1 章')
})

// —— 16. mock 卫生：无密钥/appid 串；伴读不外泄全文 ——
test('P2 卫生：mock-fixtures-p2 无 wx+hex appid/appsecret/offerId 字样', () => {
  const src = readFileSync(resolve(PROJECT, 'utils/mock-fixtures-p2.ts'), 'utf8')
  assert.equal(/wx[0-9a-f]{16}/i.test(src), false, '无 wx+16hex appid 形态')
  assert.equal(src.includes('appsecret'), false)
  assert.equal(src.includes('offerId'), false)
  assert.equal(src.includes('session_key'), false)
})
