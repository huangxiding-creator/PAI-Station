// miniprogram-ci Node25 兼容垫片：debug.js shouldRunInMainProcess 探测 localStorage.getItem
// （父进程 defineProperty 遮不到 corecompiler 子进程；NODE_OPTIONS=--require 父子同注）
try {
  Object.defineProperty(globalThis, 'localStorage', {
    get: () => ({ getItem: () => null, setItem: () => {}, removeItem: () => {} }),
    configurable: true,
  })
} catch {}
