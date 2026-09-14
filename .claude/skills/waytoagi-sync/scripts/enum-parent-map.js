// 枚举 waytoagi 知识库的 精确父子关系（仅树元数据，不下载任何文档正文）。
// 复用 feishu-exporter 的 playwright-extra 环境：必须在 feishu-exporter 目录下运行
//   node "<skill>/scripts/enum-parent-map.js"
// 输出: <skill>/state/parent-map.json  { parentToken: [ {token,title,has_child} ... ] }
// 以及 state/node-info.json            { token: {title, parent, level} }
const path = require("path");
const fs = require("fs");
const { createRequire } = require("module");

// 必须用绝对路径指向 feishu-exporter 运行环境（脚本所在 skill 目录没有 node_modules）
const EXPORTER_DIR = path.resolve(__dirname, "..", "..", "..", "..",
  "ResearchFactory-Eng", "feishu-Down", "feishu-exporter");
const req = createRequire(path.join(EXPORTER_DIR, "package.json"));
const SKILL_STATE = path.resolve(__dirname, "..", "state");
const WIKI_URL = "https://waytoagi.feishu.cn/wiki/QPe5w5g7UisbEkkow8XcDmOpn8e";
const SPACE_ID = "7226178700923011075";

const playwright = req("playwright-extra");
const StealthPlugin = req("puppeteer-extra-plugin-stealth");
playwright.chromium.use(StealthPlugin());
const chromium = playwright.chromium;

async function main() {
  console.log("🚀 父子关系枚举（仅元数据）");
  fs.mkdirSync(SKILL_STATE, { recursive: true });
  const browser = await chromium.launch({
    channel: "chrome",          // 用系统 Chrome，免下载 playwright 自带浏览器
    headless: true,
    args: ["--no-sandbox", "--disable-blink-features=AutomationControlled"],
  });
  const context = await browser.newContext({
    userAgent:
      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 Chrome/124.0.0.0 Safari/537.36",
    viewport: { width: 1440, height: 900 },
    locale: "zh-CN",
    timezoneId: "Asia/Shanghai",
  });
  const page = await context.newPage();
  await page.route("**/*.{woff,woff2,ttf,otf}", (r) => r.abort());
  await page.goto(WIKI_URL, { waitUntil: "domcontentloaded", timeout: 90000 });
  try {
    await page.waitForSelector(".workspace-tree-view-node[data-node-uid]", { timeout: 30000 });
  } catch { await page.waitForTimeout(10000); }
  await page.waitForTimeout(2000);

  // 页面上下文内批量 fetch：每批 40 个父 token，返回 {parentToken, children[]}
  const parentMap = {};      // parentToken -> children
  let nodeInfo = {};        // token -> {title, parent, level}
  const rootTokens = [];

  // 1) 侧边栏根节点
  const roots = await page.evaluate(() => {
    const seen = [];
    const nodes = document.querySelectorAll(".workspace-tree-view-node[data-node-uid]");
    for (const node of nodes) {
      const level = parseInt(node.getAttribute("data-node-level") || "99");
      if (level > 1) continue;
      const uid = node.getAttribute("data-node-uid");
      const m = uid.match(/wikiToken=([A-Za-z0-9]+)/);
      if (!m || seen.find((s) => s.token === m[1])) continue;
      const c = node.querySelector(".workspace-tree-view-node-content");
      seen.push({ token: m[1], title: c ? c.textContent.trim().substring(0, 80) : "未命名" });
    }
    return seen;
  });
  console.log(`  根节点 ${roots.length} 个`);
  for (const r of roots) {
    rootTokens.push(r.token);
    nodeInfo[r.token] = { title: r.title, parent: null, level: 1 };
  }

  // 2) BFS 批量取子节点（带 parentToken，这是与 api-enumerate.js 的关键差异）
  //    节流：批间 2s；批内逐个 fetch 间 100ms；失败重试 3 次退避；连败 5 次熔断 60s
  const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
  // 断点续跑：已成功的父节点跳过，但其 has_child 子节点仍需入队
  const doneFile = path.join(SKILL_STATE, "parent-map.json");
  let queue = roots.map((r) => ({ token: r.token, level: 1 }));
  if (fs.existsSync(doneFile)) {
    const saved = JSON.parse(fs.readFileSync(doneFile, "utf-8"));
    Object.assign(parentMap, saved);
    let pend = 0;
    for (const kids of Object.values(saved)) {
      for (const k of kids) {
        if (k.has_child) { queue.push({ token: k.token, level: 0 }); pend++; }
      }
    }
    console.log(`  断点续跑：已缓存 ${Object.keys(saved).length} 父节点，待补 ${pend} 个 has_child 子节点`);
  }
  // 跳过已有结果的父亲，避免重复拉取
  queue = queue.filter((q) => !parentMap[q.token]);
  // 去重
  const seenQ = new Set();
  queue = queue.filter((q) => (seenQ.has(q.token) ? false : (seenQ.add(q.token), true)));
  let calls = 0, consecFail = 0, roundRetries = {};
  while (queue.length) {
    const batch = queue.splice(0, 20);
    const results = await page.evaluate(async ({ tokens, spaceId }) => {
      const out = [];
      for (const token of tokens) {
        try {
          const resp = await fetch(
            "/space/api/wiki/v2/tree/get_node_child/?space_id=" + spaceId + "&wiki_token=" + token,
            { credentials: "include" }
          );
          const data = await resp.json();
          const children = Array.isArray(data.data?.[token]) ? data.data[token] : null;
          out.push({ parentToken: token, ok: data.code === 0 && !!children, children: children || [] });
          await new Promise((r) => setTimeout(r, 100));
        } catch (e) {
          out.push({ parentToken: token, ok: false, children: [], error: String(e) });
        }
      }
      return out;
    }, { tokens: batch.map((b) => b.token), spaceId: SPACE_ID });
    calls += batch.length;

    let batchFail = 0;
    for (const r of results) {
      if (!r.ok) {
        batchFail++;
        const n = (roundRetries[r.parentToken] || 0) + 1;
        roundRetries[r.parentToken] = n;
        if (n <= 3) queue.push({ token: r.parentToken });  // 重试
        else console.log(`  ⚠️ 放弃 ${r.parentToken}（3次失败）: ${(r.error || "code!=0").slice(0, 60)}`);
        continue;
      }
      const kids = [];
      for (const c of r.children) {
        if (!c.wiki_token) continue;
        kids.push({ token: c.wiki_token, title: c.title || "未命名", has_child: !!c.has_child });
        if (c.has_child && !parentMap[c.wiki_token]) queue.push({ token: c.wiki_token });
      }
      parentMap[r.parentToken] = kids;
    }
    if (batchFail) {
      consecFail++;
      if (consecFail >= 5) { console.log("  ⏸️ 连续5批失败，熔断 60s"); await sleep(60000); consecFail = 0; }
      else await sleep(5000 + Math.random() * 5000);
    } else {
      consecFail = 0;
    }
    if (calls % 100 < 20) {
      console.log(`  已查询 ${calls}，队列剩 ${queue.length}，父子边 ${Object.values(parentMap).reduce((a, k) => a + k.length, 0)}`);
      fs.writeFileSync(doneFile, JSON.stringify(parentMap, null, 1));  // 周期性落盘
    }
    await sleep(2000);
  }

  await browser.close();
  fs.writeFileSync(doneFile, JSON.stringify(parentMap, null, 1));
  // node-info 从 parentMap + 根节点整体推导（续跑安全）
  nodeInfo = {};
  const rootTitle = Object.fromEntries(roots.map((r) => [r.token, r.title]));
  for (const t of rootTokens) nodeInfo[t] = { title: rootTitle[t] || "根节点", parent: null, level: 1 };
  for (const [pt, kids] of Object.entries(parentMap)) {
    for (const k of kids) {
      if (!nodeInfo[k.token]) nodeInfo[k.token] = { title: k.title, parent: pt, level: 0 };
    }
  }
  // 层级沿 parent 链推导
  const levelOf = (t, d = 0) => {
    if (d > 12) return 1;
    if (!nodeInfo[t] || nodeInfo[t].parent == null) return 1;
    if (nodeInfo[t].level) return nodeInfo[t].level;
    nodeInfo[t].level = levelOf(nodeInfo[t].parent, d + 1) + 1;
    return nodeInfo[t].level;
  };
  for (const t of Object.keys(nodeInfo)) levelOf(t);
  fs.writeFileSync(path.join(SKILL_STATE, "node-info.json"), JSON.stringify(nodeInfo, null, 1));
  const total = Object.values(parentMap).reduce((a, k) => a + k.length, 0);
  console.log(`✅ 完成：${calls} 次调用，${total} 条父子边，${Object.keys(nodeInfo).length} 个节点`);
}

main().catch((e) => { console.error("FATAL", e); process.exit(1); });
