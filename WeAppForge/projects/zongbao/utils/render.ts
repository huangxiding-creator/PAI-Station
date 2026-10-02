// utils/render.ts — 章节 HTML（mammoth 产物）→ Markdown 文本 → md2blocks 块
// 排版革命（总包AI顾问 v0.2.6）：块契约沿用 utils/md2blocks，阅读器排版由 WXSS 精细控制，
// 不再裸露 HTML 标签也不引入 rich-text 黑盒。容错：任何输入绝不抛异常，出不了块就出空数组。
import { md2blocks, MdBlock } from './md2blocks'

/** 行内 HTML → Markdown 行内文本（strong/em/code/a/br；其余标签剥离） */
function inlineMd(html: string): string {
  return String(html || '')
    .replace(/<br\s*\/?>/gi, '\n')
    .replace(/<(strong|b)\b[^>]*>([\s\S]*?)<\/\1>/gi, '**$2**')
    .replace(/<(em|i)\b[^>]*>([\s\S]*?)<\/\1>/gi, '*$2*')
    .replace(/<code\b[^>]*>([\s\S]*?)<\/code>/gi, '`$1`')
    .replace(/<a\b[^>]*>([\s\S]*?)<\/a>/gi, '$1')
    .replace(/<[^>]+>/g, '')
    .replace(/[ \t]+/g, ' ')
    .trim()
}

function cellsToMd(rowHtml: string): string[] {
  const cells: string[] = []
  const re = /<t[dh]\b[^>]*>([\s\S]*?)<\/t[dh]>/g
  let m: RegExpExecArray | null
  while ((m = re.exec(rowHtml))) cells.push(inlineMd(m[1]).replace(/\n+/g, ' '))
  return cells
}

/** 表格 → Markdown 表（首行作表头 + |---| 分隔行；空表出空串） */
function tableToMd(inner: string): string {
  const rows: string[][] = []
  const re = /<tr\b[^>]*>([\s\S]*?)<\/tr>/g
  let m: RegExpExecArray | null
  while ((m = re.exec(inner))) {
    const cells = cellsToMd(m[1])
    if (cells.length) rows.push(cells)
  }
  if (!rows.length) return ''
  const width = Math.max(...rows.map((r) => r.length))
  const pad = (r: string[]) => [...r, ...Array(width - r.length).fill('')]
  const line = (r: string[]) => `| ${pad(r).join(' | ')} |`
  const head = line(rows[0])
  const sep = `| ${Array(width).fill('---').join(' | ')} |`
  const body = rows.slice(1).map(line)
  return [head, sep, ...body].join('\n')
}

/** 列表 → Markdown 列表（ol 按序号编号；嵌套列表按平级降级） */
function listToMd(inner: string, ordered: boolean): string {
  const items: string[] = []
  const re = /<li\b[^>]*>([\s\S]*?)<\/li>/g
  let m: RegExpExecArray | null
  while ((m = re.exec(inner))) items.push(inlineMd(m[1]))
  return items
    .map((t, i) => (ordered ? `${i + 1}. ${t}` : `- ${t}`))
    .filter((l) => l.length > 2)
    .join('\n')
}

/** 顶层 HTML → Markdown（mammoth 顶层块：h1-h6/p/table/ul/ol；游离文本丢弃） */
export function htmlToMd(html: string): string {
  const re = /<(h[1-6]|p|table|ul|ol)\b[^>]*>([\s\S]*?)<\/\1>/g
  const out: string[] = []
  let m: RegExpExecArray | null
  while ((m = re.exec(String(html || '')))) {
    const tag = m[1]
    const inner = m[2]
    if (tag[0] === 'h') {
      const level = Math.min(Number(tag[1]) || 1, 3)
      const t = inlineMd(inner)
      if (t) out.push(`${'#'.repeat(level)} ${t}\n`)
    } else if (tag === 'p') {
      const t = inlineMd(inner)
      if (t) out.push(`${t}\n\n`)
    } else if (tag === 'table') {
      const t = tableToMd(inner)
      if (t) out.push(`${t}\n\n`)
    } else {
      const t = listToMd(inner, tag === 'ol')
      if (t) out.push(`${t}\n`)
    }
  }
  return out.join('').trim()
}

const segText = (inl: Array<{ k: string; v: string }> | undefined): string =>
  (inl || []).map((s) => s.v).join('')

/** 章节 HTML → md2blocks 块；首块 h1 与章标题重复时去重 */
export function chapterBlocks(html: string, chapterTitle: string): MdBlock[] {
  let blocks: MdBlock[]
  try {
    blocks = md2blocks(htmlToMd(html))
  } catch (e) {
    console.error('[render] 章节渲染失败', e)
    return []
  }
  if (blocks.length && chapterTitle) {
    const first = blocks[0]
    if (first.t === 'h1' && segText(first.inl).trim() === String(chapterTitle).trim()) {
      blocks = blocks.slice(1)
    }
  }
  return blocks
}
