// utils/md2blocks.d.ts — utils/md2blocks.js（零依赖 CommonJS，自 biaoxun 搬入）的 TS 类型声明
export interface InlineSeg {
  k: 't' | 'b' | 'i' | 'c' | 'l'
  v: string
}

export interface MdBlock {
  t: 'h1' | 'h2' | 'h3' | 'p' | 'quote' | 'code' | 'ul' | 'ol' | 'table' | 'hr'
  inl?: InlineSeg[]
  text?: string
  items?: InlineSeg[][]
  nums?: string[]
  head?: InlineSeg[][]
  rows?: InlineSeg[][][]
}

export declare function md2blocks(src: string): MdBlock[]
export declare function parseInline(src: string): InlineSeg[]
export declare function decodeEntities(s: string): string
