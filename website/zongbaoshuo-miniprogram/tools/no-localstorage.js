// Node >= 25 内置 webstorage 在未配 --localstorage-file 时是残废实现:
// typeof localStorage === 'object' 但 getItem/setItem 均 undefined,
// licia safeStorage 的"存在即用"探测被击穿 → miniprogram-ci 上传报
// "r.getItem is not a function" (Node <= 24 因 typeof undefined 正常回退 memStorage)。
// 修复: 进程启动即删掉残废全局, 让 licia 走 memStorage 原生路径。
// 用法: node --require ./tools/no-localstorage.js tools/upload.js
//       (--require 进入 execArgv, 会被 child_process.fork 的编译子进程继承)
try { delete globalThis.localStorage; } catch (_) { /* already gone */ }
try { delete globalThis.sessionStorage; } catch (_) { /* already gone */ }
