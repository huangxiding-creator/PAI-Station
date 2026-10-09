// tests/zongbao-utils.test.mjs — L6 出厂门首件：数据层与支付降级单测（node:test 零依赖）
import { test, beforeEach } from 'node:test'
import assert from 'node:assert/strict'
import { createRequire } from 'node:module'
import { resolve } from 'node:path'

const require = createRequire(import.meta.url)
const PROJECT = resolve('E:/AI-Station/微信小程序/zongbao')

// wx 全局桩（node 环境无 wx）
const storage = new Map()
globalThis.wx = {
  getStorageSync: (k) => (storage.has(k) ? storage.get(k) : ''),
  setStorageSync: (k, v) => storage.set(k, v),
}

beforeEach(() => storage.clear())

test('loadCatalog 装载江苏研报且字段齐全', () => {
  const store = require(resolve(PROJECT, 'utils/store.js'))
  const catalog = store.loadCatalog()
  assert.ok(catalog.reports.length >= 1, '书架至少一篇研报')
  const r = catalog.reports[0]
  for (const field of ['id', 'title', 'price', 'chapterCount', 'source']) {
    assert.ok(r[field] !== undefined, `字段缺失: ${field}`)
  }
  assert.equal(r.chapterCount, 19, '江苏研报应为19实质章')
})

test('试读章数=2（配置中心）', () => {
  const store = require(resolve(PROJECT, 'utils/store.js'))
  assert.equal(store.trialChapterCount(), 2)
})

test('权益：未购→锁定；unlockLocal→解锁持久化', () => {
  const store = require(resolve(PROJECT, 'utils/store.js'))
  assert.equal(store.isUnlocked('js-shuiwang-2026'), false, '初始未解锁')
  store.unlockLocal('js-shuiwang-2026')
  assert.equal(store.isUnlocked('js-shuiwang-2026'), true, '解锁后可读')
  // 幂等：重复解锁不炸
  store.unlockLocal('js-shuiwang-2026')
  assert.deepEqual(store.getEntitlements(), ['js-shuiwang-2026'], '权益列表去重')
})

test('支付降级：未开通虚拟支付返回友好提示且不解锁', async () => {
  const pay = require(resolve(PROJECT, 'utils/pay.js'))
  const result = await pay.unlockReport('js-shuiwang-2026', '江苏省水网工程商机研究', 990)
  assert.equal(result.ok, false, '未开通必然失败降级')
  assert.ok(result.message.includes('开通中'), `提示语应含"开通中"，实际: ${result.message}`)
})
