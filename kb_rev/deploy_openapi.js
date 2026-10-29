// CloudBase Open API 直更引擎（不走 CLI，用 SecretId/Key 签名）
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const ENV = 'cloudbase-d2gzke5r0b706b3a3';
const SECRET_DIR = path.resolve(__dirname, '..', 'data', 'secrets');
const SERVICE = 'qianwen-engine';

// 读 SecretId/Key
function readTcbSecret() {
  const lines = fs.readFileSync(path.join(SECRET_DIR, 'tcb_api.secret'), 'utf-8').split('\n');
  const id = lines.find(l => l.startsWith('SecretId='))?.split('=')[1]?.trim();
  const key = lines.find(l => l.startsWith('SecretKey='))?.split('=')[1]?.trim();
  return { id, key };
}

// TC3-HMAC-SHA256 签名（腾讯云标准）
function sign(action, payload, secretId, secretKey) {
  const service = 'tcb';
  const host = 'tcb.tencentcloudapi.com';
  const timestamp = Math.floor(Date.now() / 1000);
  const date = new Date(timestamp * 1000).toISOString().slice(0, 10);

  const hashedPayload = crypto.createHash('sha256').update(JSON.stringify(payload)).digest('hex');
  const canonicalRequest = `POST\n/\n\ncontent-type:application/json\nhost:${host}\n\ncontent-type;host\n${hashedPayload}`;

  const credentialScope = `${date}/${service}/tc3_request`;
  const hashedCanonical = crypto.createHash('sha256').update(canonicalRequest).digest('hex');
  const stringToSign = `TC3-HMAC-SHA256\n${timestamp}\n${credentialScope}\n${hashedCanonical}`;

  const kDate = crypto.createHmac('sha256', `TC3${secretKey}`).update(date).digest();
  const kService = crypto.createHmac('sha256', kDate).update(service).digest();
  const kSigning = crypto.createHmac('sha256', kService).update('tc3_request').digest();
  const signature = crypto.createHmac('sha256', kSigning).update(stringToSign).digest('hex');

  return {
    Authorization: `TC3-HMAC-SHA256 Credential=${secretId}/${credentialScope}, SignedHeaders=content-type;host, Signature=${signature}`,
    'X-TC-Action': action,
    'X-TC-Timestamp': String(timestamp),
    'X-TC-Version': '2023-06-06',
    'X-TC-Region': 'ap-shanghai',
  };
}

async function main() {
  const { id, key } = readTcbSecret();
  if (!id || !key) { console.log('FATAL: tcb_api.secret 缺'); return; }
  console.log(`SecretId: ${id.slice(0,8)}***`);

  // 构建 SECRET_FILES_B64（含新 kb_product_id）
  const FILES = ['zhipu.secret','metaso_kb_session.json','zongbao_qianwen_mp.secret',
    'qianwen_engine_hmac.key','metaso_api_key_user.txt','virtual_pay.secret',
    'kb_bridge.key','telemetry.secret','xueyuan_engine_hmac.key'];
  const parts = {};
  for (const f of FILES) {
    const fp = path.join(SECRET_DIR, f);
    if (fs.existsSync(fp)) parts[f] = fs.readFileSync(fp).toString('base64');
  }
  const secretB64 = Buffer.from(JSON.stringify(parts)).toString('base64');
  console.log(`SECRET_FILES_B64: ${secretB64.length} chars`);

  // 尝试 DescribeCloudRunServer（查当前状态）
  const payload = { EnvId: ENV, ServerName: SERVICE };
  const headers = sign('DescribeCloudRunServer', payload, id, key);
  const r = await fetch(`https://${'tcb.tencentcloudapi.com'}/`, {
    method: 'POST',
    headers: { ...headers, 'Content-Type': 'application/json', Host: 'tcb.tencentcloudapi.com' },
    body: JSON.stringify(payload),
  });
  const d = await r.json();
  console.log('Describe:', JSON.stringify(d).slice(0, 300));

  // 如果 Describe 通了，试 ModifyCloudRunServer 更新 env
  if (d.Response && !d.Response.Error) {
    const server = d.Response.Server || d.Response;
    const envParams = server.EnvParams ? JSON.parse(server.EnvParams) : {};
    envParams.SECRET_FILES_B64 = secretB64;
    const modPayload = { EnvId: ENV, ServerName: SERVICE, EnvParams: JSON.stringify(envParams) };
    const modHeaders = sign('ModifyCloudRunServer', modPayload, id, key);
    const r2 = await fetch('https://tcb.tencentcloudapi.com/', {
      method: 'POST',
      headers: { ...modHeaders, 'Content-Type': 'application/json', Host: 'tcb.tencentcloudapi.com' },
      body: JSON.stringify(modPayload),
    });
    const d2 = await r2.json();
    console.log('Modify:', JSON.stringify(d2).slice(0, 300));
  }
}

main().catch(e => { console.error(e.message); process.exit(1); });
