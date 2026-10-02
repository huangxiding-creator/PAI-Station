// pipeline/build.mjs — L3 构建腿：tsc 类型门 → npm 安装 → ci.packNpm 产物构建
// 用法: node pipeline/build.mjs [projectDir]（默认 work/hello）
import { spawnSync } from 'node:child_process'
import { existsSync, mkdirSync, cpSync, writeFileSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'
import ci from 'miniprogram-ci'
import { ROOT } from './lib/config.mjs'

const projectDir = resolve(ROOT, process.argv[2] ?? 'work/hello')

// 0) 工作区就位：模板 → work 目录（已存在则跳过，保留生成层产物）
if (!existsSync(projectDir)) {
  const template = resolve(ROOT, 'templates', 'hello')
  mkdirSync(dirname(projectDir), { recursive: true })
  cpSync(template, projectDir, { recursive: true })
  console.log(`[L3] 模板已复制 → ${projectDir}`)
}

// 1) 项目依赖安装
const npmInstall = spawnSync('npm', ['install', '--no-fund', '--no-audit'], {
  cwd: projectDir,
  shell: true,
  encoding: 'utf8',
})
if (npmInstall.status !== 0) {
  console.error('[L3] FAIL 项目依赖安装失败：\n', npmInstall.stderr)
  process.exit(1)
}

// 2) tsc 编译门：类型检查 + 原地 emit JS（ci 上传链不做 TS 转译，必须产出 .js）
const tsc = spawnSync(
  resolve(ROOT, 'node_modules', '.bin', 'tsc'),
  ['-p', resolve(projectDir, 'tsconfig.json')],
  { encoding: 'utf8', shell: true },
)
if (tsc.status !== 0) {
  console.error('[L3] FAIL 编译未过：\n', tsc.stdout, tsc.stderr)
  process.exit(1)
}
console.log('[L3] tsc 编译门 PASS（.ts → .js 原地产出）')

// 3) ci.packNpm — 构建 miniprogram_npm（本地操作；构造器强制非空 privateKeyPath，用占位文件）
const placeholderKey = resolve(ROOT, 'data', 'secrets', 'placeholder.key')
if (!existsSync(placeholderKey)) {
  mkdirSync(dirname(placeholderKey), { recursive: true })
  writeFileSync(placeholderKey, 'placeholder-for-local-packNpm-only\n')
}
const packResult = await ci.packNpm(
  new ci.Project({
    appid: 'touristappid',
    type: 'miniProgram',
    projectPath: projectDir,
    privateKeyPath: placeholderKey,
    ignores: ['node_modules/**/*'],
  }),
  {
    reporter: (info) => console.log('[L3] packNpm:', JSON.stringify(info)),
  },
)
console.log(`[L3] packNpm PASS — miniprogram_npm 就绪`, packResult)
console.log(`[L3] 构建完成 → ${projectDir}`)
