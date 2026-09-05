# -*- coding: utf-8 -*-
"""Pin must-have repos via direct /repos lookups, merge into _all.json."""
import json, os, time, urllib.request

OUT = r"e:\AI-Station\RESEARCH_DOCKET\github"
UA = {"User-Agent": "PAI-Station-research", "Accept": "application/vnd.github+json"}
PINS = {
 "openclaw/openclaw":"framework", "screenpipeco/screenpipe":"screen-context",
 "mem0ai/mem0":"memory", "letta-ai/letta":"memory", "getzep/graphiti":"memory",
 "getzep/zep":"memory", "topoteretes/cognee":"memory", "langchain-ai/langmem":"memory",
 "supermemoryai/supermemory":"memory", "memodb-io/memobase":"memory",
 "LC044/WeChatMsg":"wechat", "xaoyaoo/PyWxDump":"wechat",
 "g1879/DrissionPage":"browser", "browser-use/browser-use":"browser", "Skyvern-AI/skyvern":"browser",
 "microsoft/MarkItDown":"doc2md", "opendatalab/MinerU":"doc2md", "docling-project/docling":"doc2md",
 "VikParuchuri/marker":"doc2md", "Unstructured-IO/unstructured":"doc2md",
 "Zackriya-Solutions/meetily":"meeting", "Whisper-Streaming":"meeting",
 "ufavvlab/Whisper-Streaming":"meeting", "modelscope/FunASR":"stt",
 "FunAudioLLM/SenseVoice":"stt", "SYSTRAN/faster-whisper":"stt", "KoljaB/RealtimeSTT":"stt",
 "k2-fsa/sherpa-onnx":"stt", "alphacep/vosk-api":"stt", "ChatTTS? no":"",
 "bytedance/UI-TARS":"gui-agent", "microsoft/UFO":"gui-agent",
 "simular-ai/Agent-S":"gui-agent", "OthersideAI/self-operating-computer":"gui-agent",
 "OpenInterpreter/open-interpreter":"gui-agent", "OS-Copilot/OS-Copilot":"gui-agent",
 "yuka-friends/Windrecorder":"screen-context", "openrecall/openrecall":"screen-context",
 "anthropics/skills":"skills", "obra/superpowers":"skills",
 "scrapy/scrapy":"crawler", "unclecode/crawl4ai":"crawler", "firecrawl/firecrawl":"crawler",
 "assafelovic/gpt-researcher":"deep-research", "stanford-oval/storm":"deep-research",
 "langchain-ai/langchain":"orchestration", "microsoft/autogen":"orchestration",
 "langchain-ai/langgraph":"orchestration", "crewAIInc/crewAI":"orchestration",
 "foundationagents/agno":"orchestration", "huggingface/smolagents":"orchestration",
 "OpenHands": "orchestration", "All-Hands-AI/OpenHands":"orchestration",
 "Microsoft/WinSW":"ops", "nssm/nssm":"ops", "agronholm/apscheduler":"ops",
 "gorakhargosh/watchdog":"ops", "mcp/modelcontextprotocol":"mcp", "modelcontextprotocol/modelcontextprotocol":"mcp",
 "Flet": "gui", "flet-dev/flet":"gui", "zauberzeug/nicegui":"gui", "tauri-apps/tauri":"gui",
 "pywebview/pywebview":"gui", "wxbool/video-screenshot-windows":"misc",
 "PaddlePaddle/PaddleOCR":"ocr", "RapidAI/RapidOCR":"ocr", "hiroi-sora/Umi-OCR":"ocr",
 "microsoft/OmniParser":"ocr", "khoj-ai/khoj":"rag-local", " Mintplex-Labs/anything-llm":"rag-local",
 "Mintplex-Labs/anything-llm":"rag-local", "open-webui/open-webui":"rag-local",
 "langgenius/dify":"rag-kb", "labring/FastGPT":"rag-kb", "1Panel-dev/MaxKB":"rag-kb", "infiniflow/ragflow":"rag-kb",
 "voidtools/Everything":"ops", "CircuitVerse? no":"misc",
}
rows = json.load(open(os.path.join(OUT, "_all.json"), encoding="utf-8"))
seen = {r["repo"].lower(): r for r in rows}
added = 0
for full, tag in PINS.items():
    if not full or "/" not in full or "?" in full: continue
    if full.lower() in seen: continue
    try:
        req = urllib.request.Request(f"https://api.github.com/repos/{full}", headers=UA)
        with urllib.request.urlopen(req, timeout=20) as resp:
            it = json.loads(resp.read().decode("utf-8"))
    except Exception as e:
        print(f"[MISS] {full}: {e}", flush=True); continue
    rec = {"repo": it["full_name"], "stars": it.get("stargazers_count"), "lang": it.get("language"),
           "desc": (it.get("description") or "")[:180], "pushed": (it.get("pushed_at") or "")[:10],
           "license": (it.get("license") or {}).get("spdx_id"), "url": it.get("html_url"), "tags": [tag, "pinned"]}
    rows.append(rec); seen[rec["repo"].lower()] = rec; added += 1
    print(f"[PIN] {rec['repo']} ★{rec['stars']} {rec['pushed']}", flush=True)
    time.sleep(1.2)

json.dump(rows, open(os.path.join(OUT, "_all.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=1)
rows.sort(key=lambda x: -x["stars"])
with open(os.path.join(OUT, "_digest.md"), "w", encoding="utf-8") as f:
    f.write(f"# GitHub harvest: {len(rows)} unique repos\n\n| # | Repo | Stars | Lang | Pushed | Tags |\n|--:|---|--:|---|---|---|\n")
    for i, r in enumerate(rows, 1):
        f.write(f"| {i} | [{r['repo']}]({r['url']}) | {r['stars']} | {r['lang']} | {r['pushed']} | {','.join(r['tags'])} |\n")
print(f"[DONE] added={added} total={len(rows)}", flush=True)
