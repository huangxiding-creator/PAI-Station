// Enrich candidate part-repos with full metadata for maturity_index scoring.
// Usage: node candidates_enrich.js candidates.json  (JSON array of "owner/repo")
// Rate-limit friendly: 1.1s spacing, single retries, honest degraded notes.
import { execSync } from 'node:child_process';
import { readFileSync, writeFileSync } from 'node:fs';

const list = JSON.parse(readFileSync(process.argv[2], 'utf8'));
const sleep = (ms) => new Promise((r) => setTimeout(r, ms));
const out = [];
const failed = [];

for (const name of list) {
  let r;
  try {
    r = JSON.parse(execSync(`gh api repos/${name}`, { encoding: 'utf8', maxBuffer: 8e6, timeout: 30000 }));
  } catch (e) {
    failed.push({ repo: name, err: String(e).slice(0, 100) });
    console.log(`FAIL ${name}`);
    await sleep(1100);
    continue;
  }
  out.push({
    source: name,
    signals: {
      stars: r.stargazers_count,
      forks: r.forks_count,
      open_issues: r.open_issues_count,
      updated_at: r.pushed_at || r.updated_at,
      language: r.language || '',
      topics: r.topics || [],
      license: r.license ? r.license.spdx_id : 'NONE',
    },
  });
  console.log(`ok ${name} ★${r.stargazers_count}`);
  await sleep(1100);
}

writeFileSync('candidates_enriched.json', JSON.stringify({ generated_at: new Date().toISOString(), repos: out, failed }, null, 1));
console.log(`DONE ok=${out.length} failed=${failed.length}`);
