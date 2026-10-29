// CloudBase 云托管部署 — 用 Manager Node SDK（绕 CLI 交互提示）
// 方法：直接调 CloudBase 内部 HTTP API（CLI 底层同款，用 SecretId/Key 认证）
const crypto = require('crypto');
const fs = require('fs');
const path = require('path');

const ENV = 'cloudbase-d2gzke5r0b706b3a3';
const SERVICE = 'qianwen-engine';
const REGION = 'ap-shanghai';
const SECRET_DIR = path.resolve(__dirname, '..', 'data', 'secrets');

function readSecret() {
  const lines = fs.readFileSync(path.join(SECRET_DIR, 'tcb_api.secret'), 'utf-8').split('\n');
  return {
    id: lines.find(l => l.startsWith('SecretId='))?.split('=')[1]?.trim(),
    key: lines.find(l => l.startsWith('SecretKey='))?.split('=')[1]?.trim(),
  };
}

// 腾讯云 TC3 签名
function tc3Sign(service, host, action, version, region, payload, secretId, secretKey) {
  const timestamp = Math.floor(Date.now() / 1000);
  const date = new Date(timestamp * 1000).toISOString().slice(0, 10);
  const body = JSON.stringify(payload);
  const hashedPayload = crypto.createHash('sha256').update(body).digest('hex');
  const canonicalRequest = `POST\n/\n\ncontent-type:application/json\nhost:${host}\n\ncontent-type;host\n${hashedPayload}`;
  const credentialScope = `${date}/${service}/tc3_request`;
  const hashedCanonical = crypto.createHash('sha256').update(canonicalRequest).digest('hex');
  const stringToSign = `TC3-HMAC-SHA256\n${timestamp}\n${credentialScope}\n${hashedCanonical}`;
  const kDate = crypto.createHmac('sha256', `TC3${secretKey}`).update(date).digest();
  const kService = crypto.createHmac('sha256', kDate).update(service).digest();
  const kSigning = crypto.createHmac('sha256', kService).update('tc3_request').digest();
  const signature = crypto.createHmac('sha256', kSigning).update(stringToSign).digest('hex');
  return {
    'Content-Type': 'application/json',
    'Host': host,
    'Authorization': `TC3-HMAC-SHA256 Credential=${secretId}/${credentialScope}, SignedHeaders=content-type;host, Signature=${signature}`,
    'X-TC-Action': action,
    'X-TC-Timestamp': String(timestamp),
    'X-TC-Version': version,
    'X-TC-Region': region,
  };
}

async function callAPI(host, service, action, version, payload) {
  const { id, key } = readSecret();
  const headers = tc3Sign(service, host, action, version, REGION, payload, id, key);
  const r = await fetch(`https://${host}/`, {
    method: 'POST', headers, body: JSON.stringify(payload)
  });
  return r.json();
}

async function main() {
  console.log('[1] 查 CloudBase Open API 可用 action...');

  // 试多个版本+action 组合
  const attempts = [
    // 云托管 可能走 flexdb 或 cloudrun API 族
    ['tcb.tencentcloudapi.com', 'tcb', 'DescribeCloudRunProject', '2021-06-23', { EnvId: ENV, ServerName: SERVICE }],
    ['tcb.tencentcloudapi.com', 'tcb', 'DescribeEnvs', '2021-06-23', { EnvId: ENV }],
    // 也许在 scf (Serverless Cloud Function) 族
    ['scf.tencentcloudapi.com', 'scf', 'ListFunctions', '2018-04-16', { Namespace: ENV, Limit: 5, SearchKey: SERVICE }],
  ];

  for (const [host, svc, action, ver, payload] of attempts) {
    try {
      const d = await callAPI(host, svc, action, ver, payload);
      const hasError = d.Response?.Error;
      console.log(`  ${action}@${ver}: ${hasError ? hasError.Code : 'OK'}`);
      if (!hasError) {
        console.log('  DATA:', JSON.stringify(d.Response).slice(0, 300));
        return d.Response;
      }
    } catch (e) {
      console.log(`  ${action}: ${e.message}`);
    }
  }

  // 如果 DescribeEnvs 通了，试更多 action
  console.log('\n[2] DescribeEnvs 探底...');
  const envData = await callAPI('tcb.tencentcloudapi.com', 'tcb', 'DescribeEnvs', '2021-06-23', { EnvId: ENV });
  if (!envData.Response?.Error) {
    console.log('  env OK:', JSON.stringify(envData.Response).slice(0, 200));
    // 试云托管相关 action
    const actions = ['DescribeCloudRunServers', 'ModifyCloudRunServer', 'CreateCloudRunServerVersion'];
    for (const act of actions) {
      const d = await callAPI('tcb.tencentcloudapi.com', 'tcb', act, '2021-06-23', { EnvId: ENV, ServerName: SERVICE });
      const err = d.Response?.Error;
      console.log(`  ${act}: ${err ? err.Code : JSON.stringify(d.Response).slice(0, 150)}`);
    }
  }

  console.log('\n[3] 如果都不通，走 CloudBase 特有 HTTP API...');
  // CloudBase 有自己的 HTTP API（非腾讯云标准 TC3）
  // POST https://api-inner.cloudbase.com/api/v2/...
  // 或 POST https://tcb-api.tencentcloudapi.com/web?Action=...
  const innerPayload = { action: 'server.list', env: ENV };
  try {
    const { id, key } = readSecret();
    const r = await fetch(`https://tcb-api.tencentcloudapi.com/web?Action=DescribeCloudRunServer&EnvId=${ENV}&ServerName=${SERVICE}`, {
      method: 'POST',
      headers: {
        'X-TC-CloudApiSecretId': id,
        'X-TC-CloudApiKey': key,
        'Content-Type': 'application/json',
      },
    });
    const d = await r.json();
    console.log('  inner API:', JSON.stringify(d).slice(0, 300));
  } catch (e) {
    console.log('  inner API:', e.message);
  }
}

main().catch(e => { console.error('FATAL:', e.message); process.exit(1); });
