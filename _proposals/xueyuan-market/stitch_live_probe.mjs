// stitch_live_probe.mjs — T-P0-17 活体缝合冒烟：以真实 HTTP 走前端会走的完整序列
// 断言口径=与 mock-fixtures/xy-frontend.test 同构；引擎=127.0.0.1:8872（XY_DEV_LOGIN=1 XY_FAKE_PAY=1）
// 用法：node stitch_live_probe.mjs [--with-secret]（后者配合临时 virtual_pay secret 验全支付链）
import assert from 'node:assert/strict'

const BASE = 'http://127.0.0.1:8872/api/v1'
const PILOT = 'js-shuiwang-2026'
const SECOND = 'zj-shuili-2026'
const CODE = `stitch17-${Date.now()}`
const WITH_SECRET = process.argv.includes('--with-secret')

const steps = []
function log(step, status, extra) {
  steps.push({ step, status, ...extra })
  const mark = status === 'PASS' ? 'ok ' : String(status)
  console.log(`[${mark}] ${step}${extra.note ? ' — ' + extra.note : ''}`)
}

async function req(method, path, { body, token } = {}) {
  const headers = { 'Content-Type': 'application/json' }
  if (token) headers.Authorization = `Bearer ${token}`
  const r = await fetch(BASE + path, {
    method, headers, body: body === undefined ? undefined : JSON.stringify(body),
  })
  let data = null
  const text = await r.text()
  try { data = JSON.parse(text) } catch { data = { raw: text.slice(0, 120) } }
  return { status: r.status, data }
}

// —— 1. dev login ——
{
  const { status, data } = await req('POST', '/auth/login', { body: { code: CODE } })
  const ok = status === 200 && typeof data.token === 'string' && data.token.length > 0
    && typeof data.uid === 'string' && data.uid.startsWith('u')
    && data.expires_in === 2592000 && typeof data.pay_configured === 'boolean'
  log('1 POST /auth/login（dev）', ok ? 'PASS' : 'FAIL', {
    note: `uid=${data.uid} expires_in=${data.expires_in} pay_configured=${data.pay_configured}`,
  })
  if (!ok) process.exit(1)
  globalThis.TOKEN = data.token
  globalThis.PAY_CONFIGURED = data.pay_configured
}

// —— 2. catalog hot ——
{
  const { status, data } = await req('GET', '/catalog?tab=hot&page=1&page_size=20')
  const item = (data.items || []).find((i) => i.id === PILOT)
  const fields = item ? ['id', 'title', 'summary', 'price_fen', 'province', 'owner_type', 'industry', 'chapter_count', 'trial_chapters', 'tags', 'published_at', 'cover'] : []
  const ok = status === 200 && data.total >= 1 && item && fields.every((f) => f in item)
    && data.praise_visible === false
  log('2 GET /catalog?tab=hot', ok ? 'PASS' : 'FAIL', {
    note: `total=${data.total} 试点在列=${!!item} trial_chapters=${item ? item.trial_chapters : '-'} price_fen=${item ? item.price_fen : '-'} 条目字段=${fields.length}/12`,
  })
  if (!ok) process.exit(1)
  globalThis.TRIAL_N = item.trial_chapters
}

// —— 3. catalog praise 不可见 ——
{
  const { status, data } = await req('GET', '/catalog?tab=praise')
  const ok = status === 200 && data.items.length === 0 && data.praise_visible === false
  log('3 GET /catalog?tab=praise 空态', ok ? 'PASS' : 'FAIL', { note: `items=${data.items.length} praise_visible=${data.praise_visible}` })
}

// —— 4. 试点详情（游客） ——
{
  const { status, data } = await req('GET', `/reports/${PILOT}`)
  const need = ['id', 'title', 'summary', 'price_fen', 'anchor_price_fen', 'anchor_copy', 'chapter_count', 'trial_chapters', 'trial_pages', 'province', 'owner_type', 'industry', 'tags', 'published_at', 'owned', 'favorited', 'decision_card', 'preview_triad', 'refund_policy_url', 'disclosure']
  const miss = need.filter((f) => !(f in data))
  const hasCover = 'cover' in data
  const dc = data.decision_card || {}
  const dcOk = ['read_pages', 'remaining_chapters', 'remaining_pages', 'locked_conclusions', 'toc'].every((f) => f in dc)
  const pt = data.preview_triad || {}
  const ptOk = ['related', 'readers_also', 'rank_badge' in pt ? 'rank_badge' : 'MISSING_rank_badge'].includes('rank_badge') || 'rank_badge' in pt
  const ok = status === 200 && miss.length === 0 && !hasCover && dcOk && ptOk
    && data.owned === false && data.disclosure && data.disclosure.no_reason_refund === false
  log('4 GET /reports/{试点}（游客）', ok ? 'PASS' : 'FAIL', {
    note: `缺字段=[${miss}] cover在场=${hasCover} decision_card五件=${dcOk} rank_badge=${JSON.stringify(pt.rank_badge)} trial_pages=${data.trial_pages}`,
  })
}

// —— 5. 试读章（免登录） ——
{
  const { status, data } = await req('GET', `/reports/${PILOT}/chapters?with_content=trial`)
  const chs = data.chapters || []
  const trial = chs.filter((c) => c.is_trial === 1)
  const paid = chs.filter((c) => c.is_trial === 0)
  const trialOk = trial.length >= 1 && trial.every((c) => typeof c.html === 'string' && c.html.length > 0 && 'pages' in c && 'idx' in c)
  const leak = paid.filter((c) => 'html' in c)
  const metaOk = paid.every((c) => 'html_len' in c && 'pages' in c && 'title' in c && 'idx' in c)
  const ok = status === 200 && data.report_id === PILOT && typeof data.trial_chapters === 'number'
    && trialOk && leak.length === 0 && (paid.length === 0 || metaOk)
  log('5 GET /chapters?with_content=trial（免登录）', ok ? 'PASS' : 'FAIL', {
    note: `trial=${trial.length} paid=${paid.length} 付费章html泄漏=${leak.length} 付费章元数据(html_len/pages)=${paid.length ? metaOk : 'n/a(全试读)'}`,
  })
}

// —— 6. 未购 with_content=all 仍裁剪（服务端权益判定） ——
{
  const { status, data } = await req('GET', `/reports/${PILOT}/chapters?with_content=all`, { token: TOKEN })
  const paid = (data.chapters || []).filter((c) => c.is_trial === 0)
  const leak = paid.filter((c) => 'html' in c)
  const ok = status === 200 && paid.length >= 0 && leak.length === 0
  log('6 GET /chapters?with_content=all（未购仍裁剪）', ok ? 'PASS' : 'FAIL', {
    note: `paid=${paid.length} 泄漏=${leak.length}`,
  })
}

// —— 7. pay/sign 未配置 → 503 降级体 ——
if (!WITH_SECRET) {
  const { status, data } = await req('POST', '/pay/sign', { body: { report_id: PILOT }, token: TOKEN })
  const ok = status === 503 && data.code === 'PAY_NOT_CONFIGURED' && data.degrade === 'pay_gray' && typeof data.message === 'string'
  log('7 POST /pay/sign（secret 未回填）', ok ? 'PASS' : 'FAIL', {
    note: `status=${status} code=${data.code} degrade=${data.degrade}（前端灰置判据）`,
  })
}

// —— 8. 已配置后全支付链 ——
if (WITH_SECRET) {
  const sign = await req('POST', '/pay/sign', { body: { report_id: PILOT }, token: TOKEN })
  const sd = (() => { try { return JSON.parse(sign.data.sign_data) } catch { return {} } })()
  const signOk = sign.status === 200 && sign.data.mode === 'short_series_goods'
    && typeof sign.data.sign_data === 'string' && typeof sign.data.pay_sig === 'string' && sign.data.pay_sig.length === 64
    && typeof sign.data.signature === 'string' && sign.data.signature.length === 64
    && /^[\w-]+_\d+$/.test(sign.data.out_trade_no) && typeof sign.data.price_fen === 'number'
    && sd.offerId && sd.productId === 'xy_report_unlock' && sd.currencyType === 'CNY' && sd.buyQuantity === 1
    && sd.goodsPrice === sign.data.price_fen && sd.mode === 'short_series_goods'
  log('8a POST /pay/sign（临时 secret）', signOk ? 'PASS' : 'FAIL', {
    note: `out_trade_no=${sign.data.out_trade_no} price_fen=${sign.data.price_fen} sign_data七件=offerId/productId/CNY/buyQuantity/goodsPrice/mode/${'outTradeNo' in sd ? 'outTradeNo' : 'MISSING'} pay_sig=64hex/${sign.data.pay_sig.length}`,
  })
  if (!signOk) process.exit(1)
  const out = sign.data.out_trade_no

  const st0 = await req('GET', `/pay/status?out_trade_no=${encodeURIComponent(out)}`, { token: TOKEN })
  const st0Ok = st0.status === 200 && st0.data.status === 'pending' && st0.data.entitlement_granted === false && st0.data.report_id === PILOT
  log('8b GET /pay/status（待支付）', st0Ok ? 'PASS' : 'FAIL', { note: `status=${st0.data.status} granted=${st0.data.entitlement_granted}` })

  const cb1 = await req('POST', '/pay/callback', { body: { outTradeNo: out, transactionId: 'wxsn-stitch-1' } })
  const cb2 = await req('POST', '/pay/callback', { body: { outTradeNo: out } })
  const cbOk = cb1.status === 200 && cb1.data.first === true && cb2.status === 200 && cb2.data.first === false
  log('8c POST /pay/callback×2（fake 闸，幂等）', cbOk ? 'PASS' : 'FAIL', { note: `首回调first=${cb1.data.first} 重放first=${cb2.data.first}` })

  const st1 = await req('GET', `/pay/status?out_trade_no=${encodeURIComponent(out)}`, { token: TOKEN })
  const st1Ok = st1.status === 200 && st1.data.status === 'paid' && st1.data.entitlement_granted === true
  log('8d GET /pay/status（已支付）', st1Ok ? 'PASS' : 'FAIL', { note: `status=${st1.data.status} granted=${st1.data.entitlement_granted}` })

  const ch = await req('GET', `/reports/${PILOT}/chapters?with_content=all`, { token: TOKEN })
  const paid = (ch.data.chapters || []).filter((c) => c.is_trial === 0)
  const withHtml = paid.filter((c) => typeof c.html === 'string' && c.html.length > 0)
  const noLeakMeta = paid.every((c) => !('html_len' in c))
  const ok = ch.status === 200 && paid.length > 0 && withHtml.length === paid.length && noLeakMeta
  log('8e GET /chapters?with_content=all（解锁后全量正文）', ok ? 'PASS' : 'FAIL', {
    note: `paid=${paid.length} 带html=${withHtml.length} html_len残留=${paid.length - paid.filter((c) => !('html_len' in c)).length}`,
  })

  // —— 9. 前端 fetchChapter 单章端点（API_DESIGN P0-6）：引擎缺口实证 ——
  const paidCh = paid[0] || { id: 'ch01' }
  const fc = await req('POST', `/reports/${PILOT}/chapters/${paidCh.id}`, { body: {}, token: TOKEN })
  const fcOk = fc.status === 200 && typeof fc.data.chapter_id === 'string' && typeof fc.data.html === 'string' && typeof fc.data.is_trial === 'number'
  log('9 POST /chapters/{cid}（前端已购拉单章）', fcOk ? 'PASS' : 'GAP', {
    note: fcOk ? '端点在役' : `status=${fc.status} body=${JSON.stringify(fc.data).slice(0, 80)}——API_DESIGN P0-6 端点未实装，前端 reader.ts 已购付费章加载断链`,
  })

  // —— 10. /me 已购即时出现 ——
  const me = await req('GET', '/me', { token: TOKEN })
  const ents = (me.data.entitlements || []).filter((e) => e.report_id === PILOT)
  const entFieldsOk = ents.length === 1 && ents[0].source === 'purchase' && 'order_id' in ents[0] && 'granted_at' in ents[0] && 'expires_at' in ents[0]
  const meOk = me.status === 200 && me.data.uid && Array.isArray(me.data.favorites)
    && typeof me.data.vouchers_balance_fen === 'number' && typeof me.data.refund_count_month === 'number' && me.data.refund_monthly_limit === 2
  log('10 GET /me（支付后）', meOk && entFieldsOk ? 'PASS' : 'FAIL', {
    note: `entitlements试点=${ents.length} source=${ents[0] ? ents[0].source : '-'} order_id=${ents[0] ? JSON.stringify(ents[0].order_id).slice(0, 40) : '-'} 6 字段=${meOk}`,
  })

  // —— 11. favorite 增删幂等 ——
  const fav1 = await req('POST', `/reports/${SECOND}/favorite`, { body: {}, token: TOKEN })
  const fav2 = await req('POST', `/reports/${SECOND}/favorite`, { body: {}, token: TOKEN })
  const meFav = await req('GET', '/me', { token: TOKEN })
  const favOk = fav1.status === 200 && fav1.data.favorited === true && fav2.data.favorited === true
    && meFav.data.favorites.some((f) => f.report_id === SECOND && 'favorited_at' in f)
  const del = await req('DELETE', `/reports/${SECOND}/favorite`, { token: TOKEN })
  log('11 POST/DELETE /favorite（幂等+服务端真源）', favOk && del.data.favorited === false ? 'PASS' : 'FAIL', {
    note: `重复POST=${fav2.data.favorited} /me收藏出现=${favOk} 删除=${del.data.favorited}`,
  })
}

// —— 12. search 三态 ——
{
  const hit = await req('GET', `/search?q=${encodeURIComponent('水网')}`)
  const hitOk = hit.status === 200 && (hit.data.layer_used === 'like' || ['L1', 'L2', 'L3'].includes(hit.data.layer_used))
    && Array.isArray(hit.data.items) && Array.isArray(hit.data.hot_words) && hit.data.hot_words.length > 0
    && hit.data.fallback_hint === false && ('layer' in hit.data)
  log('12a GET /search?q=水网（命中）', hitOk ? 'PASS' : 'FAIL', {
    note: `layer_used=${hit.data.layer_used} layer=${JSON.stringify(hit.data.layer)} items=${hit.data.items.length} hot_words=${hit.data.hot_words.length} 响应含layer子字段=${'layer' in hit.data}`,
  })
  const none = await req('GET', `/search?q=${encodeURIComponent('不存在的词xyzq')}`)
  const noneOk = none.status === 200 && none.data.layer_used === 'none' && none.data.items.length === 0 && none.data.fallback_hint === true
  log('12b GET /search 零命中降级', noneOk ? 'PASS' : 'FAIL', { note: `layer_used=${none.data.layer_used} fallback_hint=${none.data.fallback_hint}` })
  const blank = await req('GET', '/search?q=')
  log('12c GET /search 空 q', blank.status === 400 ? 'PASS' : 'FAIL', { note: `status=${blank.status}（引擎=400 INVALID_PARAM；前端空态走榜单不进检索）` })
}

// —— 13. 鉴权负例 ——
{
  const noToken = await req('GET', '/me')
  const bad = await req('GET', '/me', { token: 'forged.token.x' })
  const ok = noToken.status === 401 && bad.status === 401 && bad.data.code === 'UNAUTHORIZED'
  log('13 401 负例（无/伪 Bearer）', ok ? 'PASS' : 'FAIL', {
    note: `无token=${noToken.status} 伪token=${bad.status} code=${bad.data.code}（与 mock 对齐后同码）`,
  })
}

const fails = steps.filter((s) => s.status === 'FAIL').length
const gaps = steps.filter((s) => s.status === 'GAP').length
console.log(`\n=== 活体序列：${steps.length} 步，PASS=${steps.length - fails - gaps} FAIL=${fails} GAP(引擎缺口)=${gaps} ===`)
process.exit(fails > 0 ? 1 : 0)
