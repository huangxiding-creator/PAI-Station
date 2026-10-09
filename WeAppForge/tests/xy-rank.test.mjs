// tests/xy-rank.test.mjs — 3c 榜单/一周故事前端出厂门：夹具契约形状（周键/三榜/故事三段式/
// 公式四键）+ amountYi 派生口径 + api rankingsGet mock 命中与真实模式契约透传 + 榜单页状态机
// （loading→ready/failed 空态重试/barPct 比例/行点击穿卡详情与报告详情/分享载荷）+
// me 入口与 app.json 注册走查。机制照 tests/xy-cards.test.mjs：wx 全局桩 + require 编译产物。
import { test, beforeEach } from 'node:test'
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'
import { resolve } from 'node:path'
import { readFileSync } from 'node:fs'

const require = createRequire(import.meta.url)
const PROJECT = resolve('E:/AI-Station/微信小程序/zongbao')

// —— wx 全局桩（node 环境无 wx；请求经 stubHandler 应答，全程可观测）——
const storage = new Map()
const calls = { requests: [], toasts: [], navs: [] }
let stubHandler = null // (opts) => { statusCode, data } | { network: true }

globalThis.__XY_BASE__ = 'http://stub-engine'
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
  removeStorageSync: (k) => storage.delete(k),
  login: (o) => o.success({ code: 'rank-code' }),
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
}

const cfg = require(resolve(PROJECT, 'config/index.js'))
const apiMod = require(resolve(PROJECT, 'utils/api.js'))
const rankFix = require(resolve(PROJECT, 'utils/mock-fixtures-rank.js'))
const cardsFix = require(resolve(PROJECT, 'utils/mock-fixtures-cards.js'))

const realMockFlag = cfg.appConfig.mockApi
beforeEach(() => {
  cfg.appConfig.mockApi = realMockFlag
  calls.requests.length = 0
  calls.toasts.length = 0
  calls.navs.length = 0
  stubHandler = null
})

// —— 夹具契约形状（引擎 leaderboard.py 契约对拍）——
test('RANK 夹具：周键/三榜/故事三段式/公式四键齐', () => {
  const r = rankFix.RANK
  assert.match(r.week, /^\d{4}-W\d{2}$/)
  assert.ok(r.province_heat.length >= 2)
  assert.ok(r.province_heat.every((h, i, a) => i === 0 || a[i - 1].score >= h.score), 'heat 降序')
  assert.ok(r.max_deals.length >= 3)
  assert.ok(r.max_deals.every((d, i, a) => i === 0 || a[i - 1].amount_yi >= d.amount_yi), 'deals 金额降序')
  assert.ok(r.max_deals.every((d) => cardsFix.CARDS.some((c) => c.id === d.card_id)), 'deals 卡 id 可点穿')
  assert.ok(r.rising_owners.length >= 1)
  assert.ok(r.story && r.story.paragraphs.length === 3 && r.story.paragraphs.every((p) => p.length > 0))
  assert.deepEqual(Object.keys(r.formula).sort(),
    ['max_deals', 'province_heat', 'rising_owners', 'story'])
})

test('amountYi 口径：亿/万/裸元与无数字兜底（与引擎同口径）', () => {
  // 经 deriveDeals 间接验：CARDS 内 2.4亿 > 1.85亿 > 1.2亿 > 9600万(0.96) > 7300万(0.73)
  const amounts = rankFix.RANK.max_deals.map((d) => d.amount_yi)
  assert.equal(amounts[0], 2.4)
  assert.equal(amounts[1], 1.85)
  assert.ok(amounts[2] === 1.2)
  assert.equal(amounts[3], 0.96)
  assert.ok(amounts[4] === 0.73)
})

// —— api 双模式 ——
test('rankingsGet mock 模式：命中 /rankings 返回夹具整包', async () => {
  cfg.appConfig.mockApi = true
  const r = await apiMod.rankingsGet()
  assert.equal(r.week, rankFix.RANK.week)
  assert.equal(r.story.card_id, rankFix.RANK.story.card_id)
  assert.equal(calls.requests.length, 0, 'mock 不发真请求')
})

test('rankingsGet 真实模式：GET /rankings 透传（公开无鉴权头也可）', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = (o) => {
    assert.equal(o.url, `${globalThis.__XY_BASE__}/rankings`) // BASE 含 /api/v1（config 口径）
    assert.equal(o.method, 'GET')
    return { statusCode: 200, data: rankFix.RANK }
  }
  const r = await apiMod.rankingsGet()
  assert.equal(r.week, '2026-W40')
})

test('rankingsGet 真实模式网络失败：上抛（页面落空态，不静默造数）', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ network: true })
  await assert.rejects(() => apiMod.rankingsGet())
})

// —— 榜单页状态机（Page 桩捕获编译产物）——
let pageCfg = null
function loadPage() {
  pageCfg = null
  globalThis.Page = (c) => {
    pageCfg = c
  }
  const p = resolve(PROJECT, 'pages/rank/rank.js')
  delete require.cache[require.resolve(p)]
  require(p)
  delete require.cache[require.resolve(p)]
  assert.ok(pageCfg, 'Page 定义已捕获')
  return pageCfg
}

function mkPage(pc) {
  const pg = Object.create(pc)
  pg.data = JSON.parse(JSON.stringify(pc.data))
  pg.setData = function (patch) {
    Object.assign(this.data, patch)
  }
  return pg
}

test('榜单页：onLoad→ready（周键/三榜/故事/barPct 比例）', async () => {
  cfg.appConfig.mockApi = true
  const page = mkPage(loadPage())
  assert.equal(page.data.loading, true)
  await page.onLoad()
  await new Promise((r) => setTimeout(r, 60))
  assert.equal(page.data.loading, false)
  assert.equal(page.data.failed, false)
  assert.equal(page.data.week, '2026-W40')
  assert.equal(page.data.heat[0].barPct, 100)
  assert.ok(page.data.heat[1].barPct < 100 && page.data.heat[1].barPct >= 6, '次席按比例且不低于 6%')
  assert.ok(page.data.deals.length >= 3 && page.data.story)
})

test('榜单页：失败空态+重试恢复', async () => {
  cfg.appConfig.mockApi = false
  stubHandler = () => ({ network: true })
  const page = mkPage(loadPage())
  await page.onLoad()
  await new Promise((r) => setTimeout(r, 60))
  assert.equal(page.data.failed, true)
  assert.equal(page.data.loading, false)
  cfg.appConfig.mockApi = true // 重试走 mock 成功
  await page.onRetry()
  await new Promise((r) => setTimeout(r, 60))
  assert.equal(page.data.failed, false)
  assert.equal(page.data.week, '2026-W40')
})

test('榜单页：行点击穿（卡详情带 encodeURIComponent；报告详情 id 参数）', async () => {
  cfg.appConfig.mockApi = true
  const page = mkPage(loadPage())
  await page.onLoad()
  await new Promise((r) => setTimeout(r, 60))
  calls.navs.length = 0
  page.onOpenCard({ currentTarget: { dataset: { id: rankFix.RANK.max_deals[0].card_id } } })
  page.onOpenReport({ currentTarget: { dataset: { rid: 'js-shuiwang-2026' } } })
  assert.equal(calls.navs[0], `/pages/cards/detail?card_id=${rankFix.RANK.max_deals[0].card_id}`)
  assert.equal(calls.navs[1], '/pages/detail/detail?id=js-shuiwang-2026')
  calls.navs.length = 0
  page.onOpenCard({ currentTarget: { dataset: {} } }) // 空 id 不跳
  assert.equal(calls.navs.length, 0)
})

test('榜单页：分享载荷=周榜谈资（标题含周键，path 自指）', async () => {
  cfg.appConfig.mockApi = true
  const page = mkPage(loadPage())
  await page.onLoad()
  await new Promise((r) => setTimeout(r, 60))
  const s = page.onShareAppMessage()
  assert.ok(s.title.includes('商机周榜') && s.title.includes('2026-W40'))
  assert.equal(s.path, '/pages/rank/rank')
})

// —— 接线走查（app.json 注册 + me 入口 + 密钥卫生）——
test('app.json 注册 pages/rank/rank；me 页入口与处理器在位', () => {
  const appJson = JSON.parse(readFileSync(resolve(PROJECT, 'app.json'), 'utf8'))
  assert.ok(appJson.pages.includes('pages/rank/rank'))
  const meJs = readFileSync(resolve(PROJECT, 'pages/me/me.js'), 'utf8')
  assert.ok(meJs.includes('onOpenRank') && meJs.includes("url: '/pages/rank/rank'"))
  const meWxml = readFileSync(resolve(PROJECT, 'pages/me/me.wxml'), 'utf8')
  assert.ok(meWxml.includes('bindtap="onOpenRank"'))
})

test('密钥卫生：mock-fixtures-rank 无凭据类字段', () => {
  const src = readFileSync(resolve(PROJECT, 'utils/mock-fixtures-rank.js'), 'utf8')
  assert.ok(!/(secret|apikey|api_key|password|token)\s*[:=]/i.test(src), '无凭据键')
})
