// pipeline/lib/config.mjs — 工厂统一配置装载（密钥外置 R7：data/secrets/ 永不入 git）
import { readFileSync, existsSync } from 'node:fs'
import { resolve, dirname } from 'node:path'
import { fileURLToPath } from 'node:url'

const ROOT = resolve(dirname(fileURLToPath(import.meta.url)), '..', '..')
const SECRETS_PATH = resolve(ROOT, 'data', 'secrets', 'weappforge.json')

/**
 * 读取密钥配置。缺文件/缺字段时抛出带指引的错误（R2 no silent failure）。
 * @returns {{ appid: string, privateKeyPath: string, ipListPath?: string, projectPath: string, version: string }}
 */
export function loadSecrets() {
  if (!existsSync(SECRETS_PATH)) {
    throw new Error(
      `密钥配置缺失：${SECRETS_PATH}\n` +
        '请复制 data/secrets/weappforge.example.json 为 weappforge.json 并填入 AppID/上传密钥路径（生成向导：node pipeline/wizard.mjs）',
    )
  }
  const raw = JSON.parse(readFileSync(SECRETS_PATH, 'utf8'))
  const required = ['appid', 'privateKeyPath']
  const missing = required.filter((k) => !raw[k])
  if (missing.length > 0) {
    throw new Error(`密钥配置缺字段：${missing.join(', ')}（见 ${SECRETS_PATH}）`)
  }
  return { ...raw, projectPath: resolve(ROOT, raw.projectPath ?? 'work/hello') }
}

export { ROOT, SECRETS_PATH }
