# -*- coding: utf-8 -*-
"""提取 biz/index.js 中所有 LLM 提示词/prompt 模板——识流的 AI 决策大脑。"""
import io, re, sys

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
src = open(r"e:\AI-Station\逆向工程\extracted\app64\resources\biz\index.js",
           encoding="utf-8", errors="replace").read()

# 1) 找所有含 "prompt" 或 "system" 的长字符串（>50字符的中英文混合）
# 2) 找 sendCompletionRequest 调用点的 question 参数
# 3) 找 /sees/speed 的请求构造

PATTERNS = [
    # 直接 prompt 赋值
    (r'(?:prompt|system_prompt|systemPrompt)\s*[=:]\s*["\'`]([^"\'`]{50,2000})["\'`]', 'prompt_assign'),
    # question 参数
    (r'question\s*:\s*["\'`]([^"\'`]{30,500})["\'`]', 'question_param'),
    # 中文长字符串（可能是提示词片段）
    (r'["\'`]([^"\'`]*[\u4e00-\u9fff]{20,}[^"\'`]*)["\'`]', 'chinese_text'),
]

print("=" * 100)
print("【一】显式 prompt 赋值（>50字符）")
print("=" * 100)
seen = set()
for pat, label in PATTERNS[:2]:
    for m in re.finditer(pat, src):
        text = m.group(1)
        if text in seen or len(text) < 50:
            continue
        seen.add(text)
        # 只保留含中文或明显是提示词的
        if not re.search(r'[\u4e00-\u9fff]', text) and 'AI' not in text and '微信' not in text:
            continue
        offset = m.start()
        print(f"\n--- {label} @{offset} ---")
        print(text[:500])

print("\n" + "=" * 100)
print("【二】vision_query / sendCompletionRequest 调用上下文")
print("=" * 100)
for kw in ['visionQuery', 'sendCompletionRequest', 'sendStreamingPromptMessage',
           'handleMacKeyboardInput', 'processVisionPrompt']:
    for m in list(re.finditer(re.escape(kw), src))[:3]:
        s = max(0, m.start() - 200)
        e = min(len(src), m.end() + 400)
        print(f"\n--- {kw} @{m.start()} ---")
        print(src[s:e].replace('\n', '\\n')[:600])

print("\n" + "=" * 100)
print("【三】AI 决策流程中的中文指令文本")
print("=" * 100)
# 找含"回复/回答/发送"等指令的字符串
for kw in ['你是', '请你', '帮我', '请回复', '请回答', '请分析', '智能体', '朋友圈', '总结']:
    for m in list(re.finditer(re.escape(kw), src))[:5]:
        # 向前后扩展到字符串边界
        s = m.start()
        while s > 0 and src[s-1] not in '"\'`':
            s -= 1
        e = m.end()
        while e < len(src) and src[e] not in '"\'`':
            e += 1
        text = src[s:e]
        if len(text) > 30 and text not in seen:
            seen.add(text)
            print(f"\n@{m.start()}: {text[:400]}")
