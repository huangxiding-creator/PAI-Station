// 不等完的部署（--wait 600s 超时是 CLI 构建慢，不是失败）
const { execSync } = require('child_process');
const path = require('path');

const ENGINE = path.resolve(__dirname, '..');
const CLI = 'C:\\Users\\91216\\AppData\\Roaming\\npm\\cloudbase.cmd';

console.log('[1] 部署（不等完，后台跑完自动切流量）...');
try {
  const out = execSync(
    `"${CLI}" cloudrun deploy -s qianwen-engine --source "${ENGINE}" --port 8080 --force`,
    { encoding: 'utf-8', timeout: 30000, cwd: ENGINE, env: {...process.env, CI: '1'} }
  );
  console.log(out);
} catch (e) {
  // 超时或非零退出都可能是部署已在后台跑
  console.log('[2] CLI 返回（可能部署在后台进行中）:', (e.stdout || e.message || '').slice(0, 200));
}
console.log('[3] 完——部署在 CloudBase 后台继续，稍后查服务版本确认');
