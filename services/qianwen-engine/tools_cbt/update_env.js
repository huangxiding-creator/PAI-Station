// 更新 qianwen-engine 服务环境变量（含新 virtual_pay.secret → SECRET_FILES_B64）
const tcb = require('@cloudbase/node-sdk');
const fs = require('fs');
const path = require('path');

const ENV = 'cloudbase-d2gzke5r0b706b3a3';
const SECRET_DIR = path.resolve(__dirname, '..', '..', '..', 'data', 'secrets');

// 与 docker-entrypoint.sh 同源：这些文件打包成 base64 注入 SECRET_FILES_B64
const SECRET_FILES = [
  'zhipu.secret', 'metaso_kb_session.json', 'zongbao_qianwen_mp.secret',
  'qianwen_engine_hmac.key', 'metaso_api_key_user.txt',
  'virtual_pay.secret', 'kb_bridge.key',
  'telemetry.secret', 'xueyuan_engine_hmac.key',
];

function buildSecretB64() {
  const parts = {};
  for (const f of SECRET_FILES) {
    const fp = path.join(SECRET_DIR, f);
    if (fs.existsSync(fp)) {
      parts[f] = fs.readFileSync(fp).toString('base64');
      console.log(`  ✓ ${f} (${fs.statSync(fp).size}B)`);
    } else {
      console.log(`  ✗ ${f} 不存在`);
    }
  }
  return Buffer.from(JSON.stringify(parts)).toString('base64');
}

async function main() {
  const b64 = buildSecretB64();
  console.log(`\nSECRET_FILES_B64 总长: ${b64.length} chars`);

  // 用 CloudBase HTTP API 更新服务
  const app = tcb.init({ env: ENV });
  // 尝试通过 SDK 更新服务配置
  try {
    const res = await app.callFunction({
      name: 'cloudrun_deploy',
      data: { action: 'update_env', service: 'qianwen-engine', env_var: { SECRET_FILES_B64: b64 } }
    });
    console.log('SDK call:', JSON.stringify(res));
  } catch (e) {
    console.log('SDK callFunction 不通（无此云函数），换 HTTP API...');
    // 直接走 HTTP API
    const token = await getAccessToken();
    const url = `https://api.weixin.qq.com/tcb/updatecloudrunserver?access_token=${token}`;
    const body = JSON.stringify({
      env: ENV,
      serverName: 'qianwen-engine',
      envVars: JSON.stringify({ SECRET_FILES_B64: b64 }),
    });
    const resp = await fetch(url, { method: 'POST', body, headers: { 'Content-Type': 'application/json' } });
    const d = await resp.json();
    console.log('HTTP API:', JSON.stringify(d));
  }
}

async function getAccessToken() {
  const secretFile = path.join(SECRET_DIR, 'zongbao_qianwen_mp.secret');
  const lines = fs.readFileSync(secretFile, 'utf-8').split('\n');
  const secret = lines.find(l => l.startsWith('appsecret='))?.split('=')[1]?.trim();
  const r = await fetch(`https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx5cee1574ce45819b&secret=${secret}`);
  const d = await r.json();
  if (!d.access_token) throw new Error(`token fail: ${JSON.stringify(d)}`);
  return d.access_token;
}

main().catch(e => { console.error('FATAL:', e.message); process.exit(1); });
