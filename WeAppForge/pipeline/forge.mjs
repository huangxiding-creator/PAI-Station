// pipeline/forge.mjs — 全链锻造：L2 模板→L3 构建→L4 上传→L5 体验码，逐腿计时落盘
// onboarding_time 测量仪表（北极星1：想法→我的后台可扫码 ≤4h）
// 用法: node pipeline/forge.mjs [version] [desc]
import { mkdirSync, writeFileSync } from 'node:fs'
import { resolve } from 'node:path'
import { ROOT, loadSecrets } from './lib/config.mjs'
import { spawnSync } from 'node:child_process'

const t0 = Date.now()
const legs = []
const mark = (leg, status, detail = {}) =>
  legs.push({ leg, status, ms: Date.now() - t0, ...detail })

const secrets = loadSecrets()

// L3 构建（含模板复制 L2 + tsc 编译门 + packNpm），项目取自 secrets.projectPath
const build = spawnSync(
  'node',
  [resolve(ROOT, 'pipeline', 'build.mjs'), secrets.projectPath],
  { encoding: 'utf8', shell: true },
)
if (build.status !== 0) {
  mark('L3', 'FAIL', { stderr: (build.stderr || build.stdout || '').slice(-800) })
} else {
  mark('L3', 'PASS')
}

// L4 上传（真实密钥，密钥外置；--no-experimental-webstorage=绕开 Node≥22 localStorage 与 ci 探针的冲突）
if (legs.at(-1).status === 'PASS') {
  const upload = spawnSync(
    'node',
    ['--no-experimental-webstorage', resolve(ROOT, 'pipeline', 'upload.mjs'), process.argv[2], process.argv[3]],
    { encoding: 'utf8', shell: true },
  )
  mark('L4', upload.status === 0 ? 'PASS' : 'FAIL', {
    stderr: (upload.stderr || upload.stdout || '').slice(-800),
  })
} else {
  mark('L4', 'SKIP', { reason: 'upstream L3 fail' })
}

// L5 体验版二维码
if (legs.at(-1).status === 'PASS') {
  const preview = spawnSync(
    'node',
    ['--no-experimental-webstorage', resolve(ROOT, 'pipeline', 'preview.mjs')],
    { encoding: 'utf8', shell: true },
  )
  mark('L5', preview.status === 0 ? 'PASS' : 'FAIL', {
    stderr: (preview.stderr || preview.stdout || '').slice(-800),
  })
} else {
  mark('L5', 'SKIP', { reason: 'upstream L4 fail' })
}

const report = {
  run_at: new Date().toISOString(),
  total_seconds: Number(((Date.now() - t0) / 1000).toFixed(1)),
  legs,
}
const reportDir = resolve(ROOT, 'data', 'reports')
mkdirSync(reportDir, { recursive: true })
const reportPath = resolve(reportDir, `forge-${Date.now()}.json`)
writeFileSync(reportPath, JSON.stringify(report, null, 2))
console.log(JSON.stringify(report, null, 2))
console.log(`\n报告 → ${reportPath}`)
if (legs.some((l) => l.status === 'FAIL')) process.exit(1)
