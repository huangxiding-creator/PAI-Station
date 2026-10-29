// 微信 TCB HTTP API 直更 qianwen-engine 环境变量（SECRET_FILES_B64 含新 kb_product_id）
const fs = require('fs');
const path = require('path');

const SECRET_DIR = path.resolve(__dirname, '..', '..', '..', 'data', 'secrets');
const FILES = ['zhipu.secret','metaso_kb_session.json','zongbao_qianwen_mp.secret',
  'qianwen_engine_hmac.key','metaso_api_key_user.txt','virtual_pay.secret',
  'kb_bridge.key','telemetry.secret','xueyuan_engine_hmac.key'];

const b64 = () => {
  const parts = {};
  for (const f of FILES) {
    const fp = path.join(SECRET_DIR, f);
    if (fs.existsSync(fp)) parts[f] = fs.readFileSync(fp).toString('base64');
  }
  return Buffer.from(JSON.stringify(parts)).toString('base64');
};

async function token() {
  const sf = fs.readFileSync(path.join(SECRET_DIR, 'zongbao_qianwen_mp.secret'), 'utf-8');
  const secret = sf.split('\n').find(l => l.startsWith('appsecret='))?.split('=')[1]?.trim();
  const r = await fetch(`https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=wx5cee1574ce45819b&secret=${secret}`);
  const d = await r.json();
  if (!d.access_token) throw new Error(JSON.stringify(d));
  return d.access_token;
}

async function main() {
  const tok = await token();
  const secretB64 = b64();
  console.log(`SECRET_FILES_B64: ${secretB64.length} chars`);

  // 尝试多个 TCB API 端点
  const endpoints = [
    ['modifycloudrunserver', { env: 'cloudbase-d2gzke5r0b706b3a3', serverName: 'qianwen-engine', envParams: JSON.stringify({ SECRET_FILES_B64: secretB64 }) }],
    ['updatecloudrunserver', { env: 'cloudbase-d2gzke5r0b706b3a3', serverName: 'qianwen-engine', envParams: JSON.stringify({ SECRET_FILES_B64: secretB64 }) }],
    ['modifyserverenv', { env: 'cloudbase-d2gzke5r0b706b3a3', serverName: 'qianwen-engine', envParams: JSON.stringify({ SECRET_FILES_B64: secretB64 }) }],
  ];

  for (const [ep, body] of endpoints) {
    try {
      const r = await fetch(`https://api.weixin.qq.com/tcb/${ep}?access_token=${tok}`, {
        method: 'POST', body: JSON.stringify(body), headers: { 'Content-Type': 'application/json' }
      });
      const d = await r.json();
      console.log(`${ep}: errcode=${d.errcode} ${d.errmsg || 'OK'}`);
      if (d.errcode === 0) { console.log('✓ 成功！'); return; }
    } catch (e) { console.log(`${ep}: ${e.message}`); }
  }
  console.log('✗ 全部端点不通——需要 CloudBase 控制台手点或 CLI 交互部署');
}
main().catch(e => { console.error(e.message); process.exit(1); });
