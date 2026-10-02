// work/wxml_lint.mjs — WXML 闸门：拦截「模板表达式调用方法」类缺陷
// 背景：{{question.trim()}} 在 WXML 不执行（模板只支持简单表达式），导致 disabled 恒真、
// 按钮"点不动"这类线上事故。本闸门在上传前强制拦截。
// 用法: node work/wxml_lint.mjs <projectPath>  （发现缺陷 exit 1）
import { readFileSync, readdirSync, statSync } from 'node:fs';
import { join } from 'node:path';

const root = process.argv[2];
if (!root) { console.error('usage: node wxml_lint.mjs <projectPath>'); process.exit(2); }

// WXML 表达式里出现 .方法名( —— 方法调用（含 .trim( .slice( .toFixed( 等）
const BINDING_RE = /\{\{[^}]*\}\}/g;
const METHOD_CALL_RE = /\.(?:trim|slice|substring|substr|toFixed|replace|split|join|toLowerCase|toUpperCase|map|filter|forEach|indexOf|includes|charAt|padStart|padEnd|concat|repeat|startsWith|endsWith|find|some|every|reduce|sort|reverse|keys|values|entries|from|isArray|now|getDate)\s*\(/;

function walk(dir, out = []) {
  for (const name of readdirSync(dir)) {
    if (name === 'node_modules' || name === '.git' || name.startsWith('.')) continue;
    const p = join(dir, name);
    const st = statSync(p);
    if (st.isDirectory()) walk(p, out);
    else if (name.endsWith('.wxml')) out.push(p);
  }
  return out;
}

const files = walk(root);
let defects = 0;
for (const f of files) {
  const text = readFileSync(f, 'utf8');
  const lines = text.split('\n');
  lines.forEach((line, i) => {
    const rel = f.slice(root.length + 1);
    // 1) 绑定表达式内的方法调用
    for (const m of line.matchAll(BINDING_RE)) {
      if (METHOD_CALL_RE.test(m[0])) {
        console.error(`✗ [方法调用] ${rel}:${i + 1}  ${m[0].trim().slice(0, 80)}`);
        defects++;
      }
    }
    // 2) 未闭合的 {{ （同行缺 }}）
    const open = (line.match(/\{\{/g) || []).length;
    const close = (line.match(/\}\}/g) || []).length;
    if (open > close) {
      console.error(`✗ [未闭合绑定] ${rel}:${i + 1}  {{ 多于 }}`);
      defects++;
    }
  });
}

if (defects) { console.error(`\nWXML 闸门：${defects} 处缺陷，禁止上传`); process.exit(1); }
console.log(`WXML 闸门：${files.length} 个文件全 PASS`);
