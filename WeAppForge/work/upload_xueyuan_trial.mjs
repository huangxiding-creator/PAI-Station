// work/upload_xueyuan_trial.mjs — 总包学园体验版上传（privateKey 内容直注；快照 work/zongbao_trial：
// p1 关 / apiEnv prod / PROD_BASE http://47.120.43.20:8871/api/v1 / mockApi false 四翻已焊死）
// Node 25 兼容：debug.js 探测 global.localStorage（无同步 getItem）会 TypeError，遮蔽之
try { Object.defineProperty(globalThis, 'localStorage', { get: () => undefined, configurable: true }) } catch {}
import ci from 'miniprogram-ci'
import { readFileSync } from 'node:fs'

const KEY = readFileSync('E:/AI-Station/data/secrets/private.wxfdb55b184756e89e.key', 'utf8')
const version = process.argv[2] ?? '0.3.0'
const desc = process.argv[3] ?? '总包学园 P0 商城基线·32份在售·体验版'

const project = new ci.Project({
  appid: 'wxfdb55b184756e89e',
  type: 'miniProgram',
  projectPath: 'work/zongbao_trial',
  privateKey: KEY,
  ignores: [
    'node_modules/**/*',
    '**/*.ts',
    'content/cards/**',           // P1 商机卡（p1:false 关闭，不随体验版）
    'miniprogram_npm/@vant/**',   // 脚手架遗留，全库零引用（主包 2MB 限瘦身）
    'miniprogram_npm/mp-html/**', // 同上（渲染走自研 md2blocks）
    'tsconfig.json',
    'package-lock.json',
  ],
})

// 1) 上传为开发版本（控制台「版本管理→开发版本→选为体验版」一键转正）
const startedAt = Date.now()
const result = await ci.upload({
  project,
  version,
  desc,
  setting: { es6: true, es7: true, minify: true, autoPrefixWXSS: true },
  onProgressUpdate: () => {},
})
console.log(JSON.stringify(
  { status: 'UPLOAD_PASS', version, desc, seconds: ((Date.now() - startedAt) / 1000).toFixed(1), result },
  null, 2))

// 2) 开发版预览二维码（管理员/开发者立即可扫；体验者 QR 待控制台转体验版后取）
await ci.preview({
  project,
  desc: `${version} 预览`,
  qrcodeFormat: 'image',
  qrcodeOutputDest: 'work/xueyuan_trial_qr.png',
  pagePath: 'pages/index/index',
  onProgressUpdate: () => {},
})
console.log(JSON.stringify({ status: 'PREVIEW_PASS', qr: 'work/xueyuan_trial_qr.png' }))
