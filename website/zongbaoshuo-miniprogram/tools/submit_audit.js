// 总包千问 · 提审/发布辅助 — 微信服务端 API
// 密钥红线: AppSecret 只从 data/secrets/zongbao_qianwen_mp.secret 读取, 不进仓不打印
// 流程: access_token → (get_category 自检) → submit_audit
// 已知风险: 家宽 IP 可能不在小程序后台 IP 白名单 → 40164, 此时转人工后台一键提审
const fs = require('fs');
const https = require('https');

const SECRET_FILE = String.raw`E:\AI-Station\data\secrets\zongbao_qianwen_mp.secret`;

function readSecret() {
  const kv = {};
  // 兼容 CRLF: JS 正则 $ 不匹配 \r, 先剥行尾空白再解析
  for (const line of fs.readFileSync(SECRET_FILE, 'utf-8').split(/\r?\n/)) {
    const m = line.match(/^(\w+)=(.+)$/);
    if (m) kv[m[1]] = m[2].trim();
  }
  if (!kv.appid || !kv.appsecret) throw new Error('secret 文件缺 appid/appsecret');
  return kv;
}

function getJson(url, body) {
  return new Promise((resolve, reject) => {
    // 微信网关两坑: ①chunked POST 回 412 空包 → 必须显式 Content-Length;
    // ②裸脚本 UA 偶被拦 → 带浏览器样式 UA
    const payload = body ? Buffer.from(JSON.stringify(body), 'utf-8') : null;
    const headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) zongbao-ci/1.0' };
    if (payload) {
      headers['Content-Type'] = 'application/json; charset=utf-8';
      headers['Content-Length'] = payload.length;
    }
    const req = https.request(url, { method: body ? 'POST' : 'GET', headers }, (res) => {
      let buf = '';
      res.on('data', (c) => { buf += c; });
      res.on('end', () => {
        if (res.statusCode !== 200) { reject(new Error(`HTTP ${res.statusCode} 空包(微信网关拦截)`)); return; }
        try { resolve(JSON.parse(buf)); } catch (e) { reject(new Error(`非JSON回包: ${buf.slice(0, 200)}`)); }
      });
    });
    req.on('error', reject);
    if (payload) req.write(payload);
    req.end();
  });
}

async function main() {
  const { appid, appsecret } = readSecret();
  const tok = await getJson(`https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=${appid}&secret=${appsecret}`);
  if (!tok.access_token) {
    console.error(`[token fail] errcode=${tok.errcode} errmsg=${tok.errmsg}`);
    if (tok.errcode === 40164 || /invalid ip/i.test(tok.errmsg || '')) {
      console.error('→ 家宽 IP 不在白名单 (40164)。请到 MP 后台「开发管理-开发设置-IP名单」加白, 或直接后台一键提审。');
    }
    process.exit(2);
  }
  console.log('[token ok] (已隐藏)');

  // get_category 是第三方平台代开发接口, 普通小程序回空包 — 仅探测不阻断
  try {
    const cat = await getJson(`https://api.weixin.qq.com/cgi-bin/wxa/get_category?access_token=${tok.access_token}`);
    console.log('[category]', JSON.stringify(cat).slice(0, 200));
  } catch (e) {
    console.log('[category] 探测跳过 (普通小程序无此接口):', e.message.slice(0, 80));
  }

  const audit = await getJson(
    `https://api.weixin.qq.com/wxa/submit_audit?access_token=${tok.access_token}`,
    {
      item_list: [{
        address: 'pages/index/index',
        tag: '工程行业资讯_企业介绍',
        first_class: 'IT科技',
        second_class: 'IT技术与其它',
        first_id: 1,
        second_id: 3,
        title: '总包说科技产品矩阵',
      }],
      version_desc: '首版: 总包说官网小程序版 (八线产品+四重价值+资产盘点)',
    },
  );
  console.log('[submit_audit]', JSON.stringify(audit));
  if (audit.errcode === 86000) {
    console.log('→ 86000: submit_audit 仅限第三方平台代开发。普通小程序提审走 MP 后台:');
    console.log('   版本管理 → 开发版本(1.0.0) → 提交审核 (类目建议: IT科技/IT技术与其它, 或商业服务/信息资讯)');
  }
  if (audit.errcode === 0) {
    console.log(`[ok] auditid=${audit.auditid} — 审核中, 微信侧通常数分钟到数天`);
    fs.writeFileSync(require('path').join(__dirname, '..', 'audit_id.txt'), String(audit.auditid));
  }
}

main().catch((e) => { console.error('[fail]', e.message); process.exit(1); });
