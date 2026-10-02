// pipeline/upload.mjs — L4 上传腿：ci.upload → 用户小程序后台（密钥外置）
// 用法: node pipeline/upload.mjs [version] [desc]
import ci from 'miniprogram-ci'
import { loadSecrets } from './lib/config.mjs'

const secrets = loadSecrets()
const version = process.argv[2] ?? `0.${new Date().toISOString().slice(2, 10).replace(/-/g, '.')}`
const desc = process.argv[3] ?? 'WeAppForge 自动上传'

const project = new ci.Project({
  appid: secrets.appid,
  type: 'miniProgram',
  projectPath: secrets.projectPath,
  privateKeyPath: secrets.privateKeyPath,
  ignores: ['node_modules/**/*'],
})

const startedAt = Date.now()
const result = await ci.upload({
  project,
  version,
  desc,
  setting: { es6: true, es7: true, minify: true, autoPrefixWXSS: true },
  onProgressUpdate: () => {},
})
console.log(
  JSON.stringify(
    { leg: 'L4', status: 'PASS', version, desc, seconds: ((Date.now() - startedAt) / 1000).toFixed(1), result },
    null,
    2,
  ),
)
