// pipeline/preview.mjs — L5 调试腿：ci.preview 体验版二维码 → data/preview-qr.png
// 用法: node pipeline/preview.mjs
import ci from 'miniprogram-ci'
import { loadSecrets, ROOT } from './lib/config.mjs'
import { resolve } from 'node:path'

const secrets = loadSecrets()
const qrOutput = resolve(ROOT, 'data', 'preview-qr.png')

const project = new ci.Project({
  appid: secrets.appid,
  type: 'miniProgram',
  projectPath: secrets.projectPath,
  privateKeyPath: secrets.privateKeyPath,
  ignores: ['node_modules/**/*'],
})

const result = await ci.preview({
  project,
  desc: 'WeAppForge 体验版预览',
  setting: { es6: true, es7: true, minify: true },
  qrcodeFormat: 'image',
  qrcodeOutputDest: qrOutput,
  onProgressUpdate: () => {},
})
console.log(JSON.stringify({ leg: 'L5', status: 'PASS', qrcode: qrOutput, result }, null, 2))
