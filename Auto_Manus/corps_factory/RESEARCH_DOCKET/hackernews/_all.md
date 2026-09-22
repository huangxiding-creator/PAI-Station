# Channel: hackernews (20 docs)

## 1. Show HN: Framework for building multi-agent equity research agents

- type: `post` | url: https://github.com/schnetzlerjoe/hermes | credibility: 0.6

- signals: `{"points": 6, "comments": 0, "date": "2026-02-25T19:28:12Z"}`


I built Hermes, an open-source Python framework for multi-agent financial research.<p>Most AI “equity research” demos stop at generating text. In practice, real workflows require pulling structured XBRL financials from SEC filings, extracting labeled sections like MD&amp;A and Risk Factors, merging macro and market data, building actual Excel models with formulas, and generating investment memos in Word or PDF.<p>Hermes is designed to handle that full pipeline end to end.<p>It includes 35 financial data tools covering SEC EDGAR (via edgartools), FRED, Yahoo Finance market data, and RSS-based financial news. It also provides composable specialist agents for filings, macro data, market data, modeling, report generation, and multi-agent orchestration. On the output side, it can generate Excel workbooks using openpyxl, create Word documents, export PDFs, and index filings with ChromaDB for semantic search. It includes async rate limiting, file-based caching (filings cached permanently, quotes never cached), and streaming progress events.<p>Hermes is MIT licensed and designed to be extended. You can register custom tools and agents and plug in your own data sources or models.<p>I’d love feedback from both AI engineers and finance professionals, especially around validation, reliability, and real-world research workflows.<p>Repo: <a href="https:&#x2F;&#x2F;github.com&#x2F;schnetzlerjoe&#x2F;hermes" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;schnetzlerjoe&#x2F;hermes</a>


## 2. Show HN: Agentic Shift: Peter Steinberger Joins OpenAI

- type: `post` | url: https://blog.saimadugula.com/posts/steinberger-openai-openclaw.html | credibility: 0.6

- signals: `{"points": 1, "comments": 0, "date": "2026-02-16T11:42:16Z"}`


The Agentic Shift: Peter Steinberger Joins OpenAI to Scale OpenClaw
By Sai Srikanth Madugula, PhD Research Scholar &amp; Product Manager | February 16, 2026<p>In a move that signals the definitive start of the &quot;Agentic Era,&quot; Peter Steinberger, the architect behind the viral open-source framework OpenClaw, has officially joined OpenAI. This transition isn&#x27;t just a high-profile hire; it represents a fundamental change in how the industry views the intersection of proprietary intelligence and open-source orchestration.<p>As I continue my PhD research into AI-Blockchain models, I view this as a seminal moment. We are moving away from simple chatbots toward autonomous &quot;workers&quot; that can interact, reason, and execute. Steinberger’s integration into OpenAI provides the missing bridge between world-class models and real-world execution frameworks.<p>In the Words of Sam Altman
Sam Altman, CEO of OpenAI, took to X (formerly Twitter) to welcome Steinberger and clarify the future of the framework. His statement highlights a newfound commitment to the open-source community as part of OpenAI&#x27;s core product strategy:<p>&quot;Peter Steinberger is joining OpenAI to drive the next generation of personal agents. He is a genius with a lot of amazing ideas about the future of very smart agents interacting with each other to do very useful things for people... OpenClaw will live in a foundation as an open source project that OpenAI will continue to support.&quot;
Altman’s vision of a &quot;multi-agent&quot; future confirms what many of us in product management have suspected: the next billion-dollar startups won&#x27;t be built on a single LLM, but on the orchestration of many specialized agents working in concert.<p>Why This Matters: The OpenClaw Foundation
The decision to house OpenClaw in an independent open-source foundation while receiving OpenAI’s backing is a strategic masterstroke. It ensures that the framework remains a neutral ground for developers


## 3. Show HN: Mcp-Agent – Build effective agents with Model Context Protocol

- type: `post` | url: https://github.com/lastmile-ai/mcp-agent | credibility: 0.6

- signals: `{"points": 80, "comments": 28, "date": "2025-01-29T16:26:07Z"}`


Hey HN, I spent my xmas break building an agent framework called mcp-agent [1](<a href="https:&#x2F;&#x2F;github.com&#x2F;lastmile-ai&#x2F;mcp-agent">https:&#x2F;&#x2F;github.com&#x2F;lastmile-ai&#x2F;mcp-agent</a>) for Model Context Protocol [2]. It makes it easy to build AI apps with MCP servers, and implements every pattern from the popular Building Effective Agents blog [3] as well as OpenAI’s Swarm [4]. I’m sharing it early to get community feedback on where to take it from here, and to ask for contributions.<p>For those who aren’t familiar with MCP, I think of it as a standardized interface to let AI communicate with software via tool calls, resources and prompts.<p>mcp-agent provides a higher level interface to build apps with MCP. It handles the connection management of MCP servers so you don’t have to. It also implements the Building Effective Agents patterns:
- Augmented LLM (an LLM with access to one or more MCP servers)
- Router, Orchestrator-Worker, Evaluator-Optimizer, and more
- Swarm<p>The key design principles are composability and reusability – every pattern is an AugmentedLLM itself, so you can chain them into more complex workflows.<p>Some background: I worked on LSP [5] and language servers at Microsoft, and saw firsthand how standards and protocols can revolutionize developer workflows. Before LSP every IDE had its own esoteric ways of providing language services. LSP changed all that, and arguably made every language server better, since they can focus on improving a single implementation for all clients.<p>I think AI development is in a similar pre-LSP space right now. There are tons of frameworks [6], every model provider has its own way of handling messages, tool calls, streaming, etc. I really think we need a protocol to standardize these patterns.<p>Pretty soon every service is going to expose an MCP interface, and mcp-agent is about letting developers orchestrate these services into applications (i.e. build “MCP apps”). This can cover an


## 4. Show HN: Building an AI-native mini-OS for developers

- type: `post` | url: https://vibemind.space/ | credibility: 0.6

- signals: `{"points": 2, "comments": 1, "date": "2025-09-18T16:46:41Z"}`


TL;DR: Vibemind is an AI-native “mini OS” — a single canvas where you interact through thoughts, spaces, and flows instead of switching apps. Multi-agent orchestration, live knowledge graphs, and OCR-driven UI automation are built-in. We’re opening a small waitlist for early builders and power users: [your-waitlist-link].<p>What this is
We built Vibemind because context switching is wasting everyone’s life. Instead of tabs and apps, you get a single workspace that spawns tiny agents (Planner, Coder, Researcher, Automator), links knowledge into a live graph, and can operate parts of your desktop through OCR + scripted flows. It’s part note-taking, part agent orchestra, part automation playground.<p>Why it might matter to you (technical folks)
• Agent-first architecture: each task is an agent with capabilities and failure-memory, so retries get smarter.
• Knowledge graph at runtime: nodes are live (files, API responses, chat snippets) — queries return provenance, not guesses.
• OCR UI automation: pick a UI region, teach an agent, and it repeats actions reliably even on dynamic pages.
• Developer-first: CLI + tiny SDK so you can extend agents, add custom fitness functions, or run components locally.<p>Current status &amp; numbers (honest)
• Prototype: frontend + working agent orchestration, knowledge-graph POC, OCR automation demo.
• Team: small, product-driven. Open to early contributors.
• Waitlist: limited early seats (beta invites will be staggered). We’re not pretending we have millions of users; we have a focused demo and want feedback from people who break things.<p>Privacy &amp; safety (short)
You can run agents locally or in our hosted environment. We log actions for reproducibility but plan fine-grained export&#x2F;delete controls. We’re building with minimal data retention by default.<p>What we want from HN readers
• Try the demo if you’re curious.
• Sign the waitlist if you want early access and can give feedback.
• Tell us what would make you replace a doz


## 5. Show HN: Opaal Visual multi-agent prompt designer for Claude Code and agentic AI

- type: `post` | url: https://github.com/Agravak/opaal | credibility: 0.6

- signals: `{"points": 2, "comments": 0, "date": "2026-02-18T14:59:27Z"}`


Hi HN!<p>I built Opaal because writing multi-agent orchestration prompts was becoming tedious and error-prone. Every time I wanted to coordinate 3-5 AI agents on a complex task, I would spend 20+ minutes crafting the prompt by hand.<p>Opaal (Orchestration Prompts for Agentic AI Launch) lets you design these workflows visually instead. You drag agent cards onto a canvas, organize them into phases (columns), draw connections between them, and the app generates a production-ready prompt automatically. The prompt updates live as you build.<p>Built with Electron + React + React Flow + Zustand + Tailwind CSS v4.<p>Key features:
 - 15 agent roles (Researcher, Architect, Developer, Reviewer, etc.)
 - Smart auto-connections between adjacent phases
 - Manual wiring for custom data flow
 - 3 starter templates (Code Review, Feature Build, Bug Fix)
 - Auto-detects installed Claude Code skills
 - Save&#x2F;load .opaal files, export to CLAUDE.md
 - Full keyboard shortcuts, undo&#x2F;redo, multi-select<p>MIT licensed. Would love feedback on what features would make this more useful for your workflows.


## 6. Show HN: Computer Agents – AI Agents That Work While You Sleep

- type: `post` | url: https://computer-agents.com | credibility: 0.6

- signals: `{"points": 1, "comments": 0, "date": "2026-03-02T13:12:55Z"}`


Hey HN,
Chatbots are amazing at conversation. They suck at getting shit done while you’re sleeping, in a meeting, or at the beach.
So I built Computer Agents: real AI coworkers that each get their own isolated computer in the cloud.
What actually happens when you create one:<p>It boots its own persistent workspace (files, code, memory, everything survives forever)
You give it a goal + tools&#x2F;skills
It runs 24&#x2F;7 on cron, webhooks, or just “keep working until done”
You get results via email, Telegram, or just check back whenever<p>No more “remember this for next time.” It literally remembers.
Killer features I’m stupidly excited about<p>Persistent workspaces: your agent can iterate on the same codebase&#x2F;project for weeks
Code execution that just works – auto pip install &#x2F; npm install, isolated containers, no Docker hell
Deep Research skill – reads dozens of sources, synthesizes, cites everything (actually useful reports)
Multi-agent orchestration: chain, parallel, map-reduce, conditional workflows (yes, agent teams)
Triggers: GitHub push → agent starts reviewing PR. Slack message → agent replies. Webhook with HMAC.
Native SDKs – npm install computer-agents or pip install computer-agents (TypeScript + Python)
iOS + Mac apps so you can literally yell at your agents from your phone<p>Real examples people are already running:<p>London architect: agents generate full floor plans + client presentations overnight
FireChatbot team: 80% of customer emails handled autonomously, 35% workload drop
Solo devs: daily competitive analysis reports waiting in inbox every morning<p>This isn’t another wrapper around Claude Computer Use or Perplexity. It’s the operating system for those kinds of agents. always-on, persistent, and actually shippable.
Free tier gives you 150 compute tokens (~15-23 solid tasks) so you can go deploy something stupid right now. First paid tier is $19&#x2F;mo for basically your first full-time AI employee.
Live at → <a href="https:&#x2F;&#x2F;


## 7. Show HN: TalkCAD – AI agent to generate CAD models using OpenSCAD code

- type: `post` | url: https://github.com/outerreaches/talkcad | credibility: 0.6

- signals: `{"points": 1, "comments": 0, "date": "2026-01-22T20:36:50Z"}`


I built an open-source tool that uses multi-agent orchestration to generate parametric CAD models via OpenSCAD.<p>The system has three modes: Guided (collaborative building), Researched (agent searches for datasheets&#x2F;specs automatically), and Verified (research + visual&#x2F;code verification with auto-repair loops).<p>It runs locally via Electron and supports OpenRouter, Ollama, or LM Studio. Files are exportable to STL.


## 8. Show HN: Computer Agents – Agents that work while you sleep

- type: `post` | url: https://computer-agents.com | credibility: 0.6

- signals: `{"points": 7, "comments": 0, "date": "2026-03-01T03:28:41Z"}`


Hey HN,
Most AI “agents” I’ve tried are basically chatbots with amnesia — they forget everything the moment you close the tab and can’t do anything unless you’re sitting there watching them.
I wanted real AI coworkers that just… work.
So I built Computer Agents (aiOS).
Every agent you create gets its own isolated computer in the cloud — complete with persistent memory, a real file system, code execution environment (with automatic dependency management), and the ability to run scheduled or webhook-triggered tasks 24&#x2F;7.
You give it a goal (“research this market and email me a report every Monday”, “generate floor plans from client briefs”, “handle incoming support emails”, “run my weekly data analysis”), walk away, and come back to finished results in your inbox, Telegram, or dashboard.
Key highlights:
•  Persistent workspaces — context and files survive forever (no more “remember what we talked about last week?”)
•  Native iOS app (iPhone + iPad) + native Mac app + web dashboard
•  Python + TypeScript SDKs (pip install computer-agents, npm install computer-agents)
•  Multi-agent orchestration (sequential, parallel, map-reduce, conditional flows)
•  Built-in skills: deep web research with citations, web search, image generation, full code interpreter
•  Integrations: Email, Telegram, GitHub, Google Drive, OneDrive, Notion, webhooks, etc.
•  Runs in secure isolated cloud containers (you own your data)
It’s live at <a href="https:&#x2F;&#x2F;computer-agents.com" rel="nofollow">https:&#x2F;&#x2F;computer-agents.com</a>
Free tier gives you 150 compute tokens (~15–23 decent-sized tasks) so you can try it right now. Pro starts at $19&#x2F;mo when you want more.
This is very much still a young indie project (I’m the solo founder), but it’s already helping real teams automate support, research, content, and coding workflows.
Would love your honest feedback — especially:
•  What persistent&#x2F;long-running agent pain points have you hit with other tools?
•  Interesting 


## 9. Show HN: AgentML – SCXML for Deterministic AI Agents (MIT)

- type: `post` | url: https://github.com/agentflare-ai/agentml | credibility: 0.6

- signals: `{"points": 5, "comments": 1, "date": "2025-11-03T20:41:07Z"}`


Hey HN,<p>We’ve been experimenting with how to make AI agents more deterministic, observable, and production-safe, and that led us to build AgentML — an open-source language for defining agent behavior as state machines, not prompt chains.<p>My co-founder posted before but linked to the project website instead of the repo, so resharing here.<p>AgentML lets you describe your agent’s reasoning and actions as a finite-state model (think SCXML for agents). Each state, transition, and tool call is explicit and machine-verifiable.<p>That means you can:<p>- Reproduce any decision path deterministically<p>- Trace reasoning and tool calls for debugging or compliance<p>- Guarantee agents only take valid actions (e.g. “never send a payment before verification”)<p>- Run locally, in the cloud, or within MCP-based frameworks<p>Example:<p>```<p>&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;<p>&lt;agentml xmlns=&quot;github.com&#x2F;agentflare-ai&#x2F;agentml&quot;
 xmlns:openai=&quot;github.com&#x2F;agentflare-ai&#x2F;agentml-go&#x2F;openai&quot;
 version=&quot;1.0&quot;
 datamodel=&quot;ecmascript&quot;
 name=&quot;researcher&quot;&gt;<p>&lt;datamodel&gt;<p><pre><code>    &lt;data id=&quot;papers&quot; expr=&quot;[]&quot;
        schema=&#x27;{&quot;type&quot;:&quot;array&quot;,&quot;description&quot;:&quot;Fetched papers from Hugging Face&quot;}&#x27; &#x2F;&gt;

    &lt;data id=&quot;summary&quot; expr=&quot;&#x27;&#x27;&quot;
        schema=&#x27;{&quot;type&quot;:&quot;string&quot;,&quot;description&quot;:&quot;Summary of the papers&quot;}&#x27; &#x2F;&gt;
</code></pre>
&lt;&#x2F;datamodel&gt;<p>&lt;state id=&quot;start&quot;&gt;<p><pre><code>    &lt;onentry&gt;

        &lt;log label=&quot;Researcher: &quot;
            expr=&quot;`Fetching papers from Hugging Face and summarizing with OpenAI\n`&quot; &#x2F;&gt;

        &lt;openai:generate model=&quot;gpt-4o&quot; location=&quot;summary&quot; stream=&quot;false&quot;&gt;

            &lt;openai:prompt&gt;S


## 10. AI CTO

- type: `post` | url: https://news.ycombinator.com/item?id=43306474 | credibility: 0.6

- signals: `{"points": 2, "comments": 1, "date": "2025-03-09T05:13:19Z"}`


Small startup teams often juggle a lot of tools and responsibilities with very few people. We have AI coding assistants, project tracking tools, and plenty of DevOps automation – but what we lack is a unifying layer to coordinate them. As a result, the technical founder&#x2F;CTO still ends up manually managing each tool and process, which is cognitively taxing and error-prone. I’m exploring the idea of an AI orchestration layer that acts like a mini “AI CTO” or project lead. The concept: it would delegate tasks to multiple AI agents specialized in different roles (coding, testing, DevOps&#x2F;SRE, project management, etc.) and coordinate their output to keep the software development pipeline flowing. For example, you could describe a feature or goal, and the orchestrator breaks it down: the coding agent writes code or unit tests, the SRE agent sets up necessary infrastructure or monitors performance, the PM agent updates your task board and timelines – all under the guidance of a central AI that understands the project’s priorities and checks the work. The aim is to reduce the cognitive load on the human CTO by having the AI system align all these tasks, catch routine issues, and maybe even flag decisions for human review when necessary. My questions to HN:
Usefulness: Would such a system actually be useful for a small startup team, or would it end up adding more complexity than it removes? If you’ve been a lone developer or CTO, can you imagine this making you more productive, or just getting in your way?
“AI CTO” – right framing or not?: Is calling it an “AI CTO” the right framing? Or would you think of this more as an advanced AI project manager&#x2F;dev assistant rather than a true CTO replacement? (I’m cautious about the term – not trying to replace strategic roles, more about automating execution and coordination.)
Failure modes &#x2F; pitfalls: What do you see as the failure modes or risks of this approach? For example, cascading errors if one agent misinterp


## 11. Show HN: The MCP Blueprint – First Comprehensive Book on Model Context Protocol

- type: `post` | url: https://www.amazon.com/dp/B0GPNSPK3Y | credibility: 0.6

- signals: `{"points": 2, "comments": 0, "date": "2026-02-23T08:52:49Z"}`


Hi HN, I wrote a book on the Model Context Protocol (MCP) – the open standard from Anthropic that lets AI agents connect to external tools and data sources.<p>I&#x27;m an RPA&#x2F;automation practitioner (CEO of Niuexa, LinkedIn Learning instructor) and I noticed there was no comprehensive resource covering MCP architecture, security patterns, and enterprise deployment strategy. So I wrote one.<p>The book covers:
- MCP architecture deep dive (servers, clients, hosts, transport layers)
- 20-point security checklist for MCP deployments
- EU AI Act compliance for agentic systems
- Real-world breach timeline from 2025
- Enterprise integration patterns
- Multi-agent orchestration<p>I used Claude Code to help with the writing and production workflow – the whole pipeline from research to KDP publishing is automated with Python scripts.<p>Happy to answer questions about MCP, AI agent architecture, or the book production process.


## 12. Show HN: Open-sourced AI Agent runtime (YAML-first)

- type: `post` | url: https://github.com/NikoSokratous/agentctl | credibility: 0.6

- signals: `{"points": 1, "comments": 0, "date": "2026-03-03T13:31:20Z"}`


Been running AI agents in production for a while and kept running into the same issues:<p>controlling what they can do
tracking costs
debugging failures
making it safe for real workloads<p>So we built AgentRuntime, the infrastructure layer we wished we had.
Not an agent framework, but the platform around agents:<p>policies
memory
workflows
observability
cost tracking
RAG
governance<p>Agents and policies are defined in YAML, so it&#x27;s infrastructure-as-code rather than a chatbot builder.
Example – agents and policies in YAML
agent.yaml – declarative agent config
name: support_agent<p>model:
  provider: anthropic
  name: claude-3-5-sonnet<p>context_assembly:
  enabled: true<p><pre><code>  embeddings:
    provider: openai
    model: text-embedding-3-small

  providers:
    - type: knowledge
      config:
        sources: [&quot;.&#x2F;docs&quot;]
        top_k: 3
</code></pre>
policies&#x2F;safety.yaml – governance as code
name: security-policy<p>rules:
  - id: block-file-deletion
    condition: tool.name == &quot;file_delete&quot;
    action: deny<p>CLI – run and inspect
Create and run an agent
agentctl agent create researcher --goal &quot;Research AI safety&quot; --llm gpt-4
agentctl agent run researcher
agentctl runs watch &lt;run-id&gt;<p>Manage policies
agentctl policy list
agentctl policy activate security-policy 1.0.0<p>RAG – ingest docs and ground responses in your knowledge base
agentctl context ingest .&#x2F;docs
agentctl run --agent agent.yaml --goal &quot;How do I deploy?&quot;<p>Agent-level debugging
agentctl debug -c agent.yaml -g &quot;Analyze this dataset.&quot;<p>Cost tracking is exposed via the API (per agent&#x2F;tenant), and the Web UI shows analytics.
The workflow debugger (breakpoints, step-through) lives in the pkg layer; the CLI debug is for agent execution.
What’s in there
Governance<p>Policy engine (CEL)
Risk scoring
Encrypted audit logs
RBAC
Multi-tenancy
Fully YAML-configurable<p>Orchestration<p>Visual workflow designer (React Flow)
DAG w


## 13. Show HN: Spin up 5 agents that don't trip over each other in 10 lines of code

- type: `post` | url: https://github.com/kagehq/bus | credibility: 0.6

- signals: `{"points": 4, "comments": 0, "date": "2025-08-16T14:50:26Z"}`


I’ve been playing with multi-agent systems and kept hitting the same issue: agents duplicate work, step on each other’s tasks, or return conflicting results.<p>So I built a tiny package: Kage Bus - <a href="https:&#x2F;&#x2F;github.com&#x2F;kagehq&#x2F;bus" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;kagehq&#x2F;bus</a><p>It’s a lightweight message bus that makes sure only ONE agent handles each task.<p>Example:<p>```js
import { createBus } from &quot;@kagehq&#x2F;bus&quot;;<p>const bus = createBus();<p>bus.on(&quot;task:research&quot;, (payload) =&gt; {
  console.log(&quot;Research agent:&quot;, payload.query);
});<p>bus.on(&quot;task:research&quot;, (payload) =&gt; {
  console.log(&quot;Backup agent:&quot;, payload.query);
});<p>bus.send(&quot;task:research&quot;, { query: &quot;latest AI news&quot; });<p>Right now it:<p>- Routes tasks to one agent (first-claim wins)<p>- Supports conflict resolution (last-writer-wins)<p>- Logs everything to agent-bus.log<p>Repo: <a href="https:&#x2F;&#x2F;github.com&#x2F;kagehq&#x2F;bus" rel="nofollow">https:&#x2F;&#x2F;github.com&#x2F;kagehq&#x2F;bus</a><p>npm: <a href="https:&#x2F;&#x2F;www.npmjs.com&#x2F;package&#x2F;@kagehq&#x2F;bus" rel="nofollow">https:&#x2F;&#x2F;www.npmjs.com&#x2F;package&#x2F;@kagehq&#x2F;bus</a><p>It’s just an MVP, but I’d love feedback from folks experimenting with multi-agent workflows:
Is this useful? What features would make orchestration actually production-ready?


## 14. Show HN: eBook to audiobook narration with realistic AI voices

- type: `post` | url: https://ebookaloud.com | credibility: 0.6

- signals: `{"points": 8, "comments": 7, "date": "2026-06-24T15:04:54Z"}`


For a while I&#x27;ve wanted to try out the new AI voices for long-form narration, but everything I found required a subscription that didn&#x27;t justify my limited usage. I came across the open Kokoro model [0] and the voices are very good -- good enough to listen to for hours without the fatigue I got from legacy, robotic TTS voices. The model is 82m parameters and designed to run fast, but I still struggled to get reasonable times from CPU inference on my 12-core laptop. I thought a cloud-based GPU service would let me generate audiobooks fast enough to feed my own self-hosted library, and that same pipeline could become a product other people could use.<p>I had two goals in building this: get some exposure to AI multi-agent coding workflows, and build a TTS product targeting ebook to audiobook conversion specifically. 99% of ebookaloud was written by DeepSeek v4 in OpenCode. I&#x27;ve used about 750 million tokens costing $12 in credits over the course of a month, and I&#x27;m very pleased with the results. Every change&#x2F;feature went through a plan -&gt; implement -&gt; test -&gt; review -&gt; correct -&gt; commit cycle with a mix of Pro and Flash agents. This was generally limited to one or two concurrent workers. I had a separate eval agent for quality control on various parts of the extraction and synthesis pipeline, which I could run 8-10 at a time. I may be approaching Yegge&#x27;s Stage 6 [1] in terms of AI workflow automation.<p>I later set up Claude Code and ran Opus 4.8 side by side with DeepSeek. There are definitely quality differences, but I&#x27;m an experienced developer with a hands-on approach. I didn&#x27;t write any of the code, but I have read critical sections of what it generated and had extensive conversations with DS Pro about each step of the approach. Opus didn&#x27;t have much critical to say about DeepSeek&#x27;s choices, and I&#x27;m not convinced a frontier model would have made an appreciable difference for my workflow. I suspe


## 15. AgentLink: On-demand AI agents you can assemble into teams

- type: `post` | url: https://news.ycombinator.com/item?id=44101091 | credibility: 0.6

- signals: `{"points": 5, "comments": 6, "date": "2025-05-26T19:57:40Z"}`


Over the past few weeks, I’ve been building AgentLink — a platform where you can discover and deploy AI agents trained for specific tasks like code review, market research, or sales outreach.<p>The idea is to make it feel like hiring a freelance team — but powered entirely by AI.<p>Here’s what AgentLink enables:<p>- Find agents trained for narrow tasks (e.g., code reviewers, data summarizers, lead generators)
- Assemble teams instantly, like snapping together Lego blocks
- Hire agents on-demand and scale usage up or down as needed
- Track agent output, provide feedback, and iterate quickly.<p>It’s built on a custom system that handles agent orchestration, memory, and inter-agent communication.<p>Still very early — I’m currently testing with solo developers and small teams.<p>I’d love feedback from anyone who’s worked with AI agents, multi-agent frameworks, or automation tooling.<p>What technical (or product) challenges would you anticipate in scaling a system like this?


## 16. Show HN: FEDERaiDE, a TUI harness with P2P multi-agent routing and built in IDE

- type: `post` | url: https://federaide.rocklab.in | credibility: 0.6

- signals: `{"points": 3, "comments": 0, "date": "2026-08-12T15:20:19Z"}`


Hi!<p>Federaide is a general purpose multi-agent harness that runs in your terminal. It is meant for recreational programming and automating your scripts. The agents are just named instances of language models which have their own memories, backstories et cetera, and can coordinate with each other as they require. It has its own IDE (complete with interactive structure parsing and jump to def).  
I am building Federaide as a solo project.<p>Why do I build this? Some reasons:<p>- I reached out to some people to try my other IDE, many of them did not have suitable computers (or at all).<p>- During this time I observed almost every normal person has interacted with AI via their phones (usually the Gemini&#x2F;ChatGPT app).<p>- I felt I could bring the joy of coding to a lot more people if I could make an AI assisted IDE run on Android.<p>- When I go to sleep I like to try out code ideas. Can&#x27;t take my macbook to bed, have cats. Do have a spare Android, thought it would be nice to have a coding platform I could use in bed.<p>- Wanted to &quot;vibecode&quot; something, at the time gemini-cli was available, so this was the chosen project (tried a lot of concepts&#x2F;variants, in rust go etc). Ultimately chose textual over a very simple reason: horizontal scrollbox (absolutely needed that for code display, may be OCD but linewrap does not do it for me).<p>- Wanted to create a truly powerful AI agent system without worrying about safety. Complete unabashed power was desired.<p>- Therefore termux native operation was a huge design goal.<p>- Kept wanting new features, kept adding them too.<p>- When I started this (in March) multi-agent harnesses were not a thing (arguably they still aren&#x27;t mainstream, but there are other projects out there now). Wanted to see how different LLMs would react to each other in the same workspace.<p>- So here we are. It is at an early stage, there are often bugs, but if you find them, I will fix them. Thought I&#x27;d share it, it can b


## 17. Show HN: NSED 0.3 Release. Steer Multi-Agent AI Swarm for Frontier Performance

- type: `post` | url: https://blog.peeramid.xyz/nsed-public/ | credibility: 0.6

- signals: `{"points": 3, "comments": 0, "date": "2026-02-26T16:18:50Z"}`


Use open-weight models on your own GPU or combine with proprietary to max out reasoning quality while staying compliant!<p>Three 8–20B open-weight models on a $7K machine have matched frontier model reasoning on AIME 2025. Here&#x27;s the orchestrator that makes it work.<p>Today we&#x27;re publishing the core orchestration engine behind our paper benchmark results. The NSED repository is live at github.com&#x2F;peeramid-labs&#x2F;nsed — source-available under BSL 1.1, free for organizations under $1M revenue, research, and education.<p>This post explains what NSED does, why it matters for teams that rely on AI for high-stakes reasoning, and how to run it today.


## 18. Show HN: AI agents designed and shipped this app end-to-end in 36 hours for $270

- type: `post` | url: https://www.ninjaflix.ai/ | credibility: 0.6

- signals: `{"points": 2, "comments": 4, "date": "2026-02-18T09:43:15Z"}`


Hey HN — I&#x27;m Arash Sadrieh, building multi-agent infrastructure at NinjaTech AI. This started as a stress test of our orchestration system and turned into something I genuinely didn&#x27;t expect.<p>The experiment: We gave a team of 4 AI agents a single high-level goal — &quot;build a platform that turns trending news into short AI-generated videos.&quot; No wireframes, no spec, no architecture doc. Just the goal.<p>What they did in 36 hours:<p>Chose the tech stack and project structure themselves
Designed the UX and built the frontend
Wrote the backend, API layer, and database schema
Built an autonomous content pipeline: research news → debate which story to cover → collaboratively write a video generation prompt → produce a 30-90 second video via Sora 2 Pro or Veo 3.1
Deployed the whole thing to production
Then created 3 new agents that now run the platform 24&#x2F;7 — researching, debating, and generating videos on a loop
Total cost: ~$270 in compute. Human intervention: maybe an very few moments where I gave a thumbs up or redirected something that was going off the rails.<p>The interesting part isn&#x27;t the app — it&#x27;s the agent collaboration. Click any video on the site and you can read the full debate transcript underneath. You&#x27;ll see the agents genuinely disagree — Scout (the researcher) pushes for data-driven stories, Pixel (the designer) argues for visual potential, Bolt (the developer) challenges technical feasibility. Sometimes one agent convinces the others to change direction. Sometimes they compromise badly.<p>Where it breaks down (and there&#x27;s plenty):<p>Groupthink is real even for LLMs. When all 4 agents agree too quickly, the output is usually boring. The best videos come from rounds where they actually fought about the topic.
Video quality is wildly inconsistent. Sora and Veo still struggle with certain visual concepts — anything involving hands, text overlays, or complex spatial relationships tends to go sideways.
News selecti


## 19. EvidionAI – open-source multi-agent research system built on LangGraph

- type: `post` | url: https://news.ycombinator.com/item?id=47510639 | credibility: 0.6

- signals: `{"points": 1, "comments": 1, "date": "2026-03-24T22:48:42Z"}`


Hi HN, I built EvidionAI — an autonomous research pipeline where a Supervisor 
orchestrates a loop of specialized agents to answer scientific questions 
end-to-end.<p>The workflow:
Supervisor → Search (DDG + arXiv + Wikipedia) → Code (Python in sandboxed Docker) 
→ Analysis → Skeptic → back to Supervisor if the conclusions don&#x27;t hold up.<p>The focus is not just on execution, but on validation — the system actively 
tries to break its own conclusions via a skeptic loop.<p>Stack: LangGraph, LangChain, FastAPI, ChromaDB, SQLite (before that, there was PostgreSQL and Redis), nginx. 
Works with Ollama (local&#x2F;cloud) and any OpenAI-compatible API. 
One-command Docker Compose setup.<p>https:&#x2F;&#x2F;github.com&#x2F;Evidion-AI&#x2F;EvidionAI<p>I&#x27;m open-sourcing this because a lot of similar projects are emerging right now, 
each exploring different approaches to autonomous research and agent orchestration.<p>I&#x27;m building this solo, and it seems more valuable to share the approach early 
rather than develop it in isolation — especially since the space is evolving fast 
and there’s clearly convergent interest in this direction.<p>Would really appreciate feedback on the agent architecture — especially the 
Supervisor routing logic, which is currently the most fragile and interesting part.


## 20. Plug this into your LLM advanced AI Agent research AST

- type: `post` | url: https://news.ycombinator.com/item?id=43153859 | credibility: 0.6

- signals: `{"points": 2, "comments": 0, "date": "2025-02-23T22:31:44Z"}`


AI_Ecosystem
├── MultiAgent_Systems
│   ├── Autonomous_Agents
│   │   ├── WebSurfer
│   │   ├── Coder
│   │   ├── FileSurfer
│   │   ├── Mariner_Agent
│   ├── Orchestrator_Agent (Prefrontal Cortex Function)
│   ├── Task_Ledger 
│   ├── Progress_Ledger (Execution Tracking)
│
├── Memory_Knowledge_Systems
│   ├── Memoripy (Hierarchical Memory)
│   │   ├── Short-Term_Memory (LTCNs - Liquid Time Constant Networks)
│   │   ├── Working_Memory (NAMMs - Non-Associative Memory Modules)
│   │   ├── Long-Term_Memory (DNCs - Differentiable Neural Computers)
│   ├── Hierarchical_Memory
│   │   ├── Dynamic_Memory_Prioritization
│   │   ├── Memory_Gating (Task-Sensitive Retrieval)
│   │   ├── Vector_Database_Integration
│
├── Learning_Optimization_Frameworks
│   ├── SDRO_Framework (Surprise-Driven Reflective Optimization)
│   │   ├── Local_Surprise (Agent-Level Adaptation)
│   │   ├── Global_Surprise (System-Wide Reconfiguration)
│   │   ├── Novelty_Surprise (Exploration &amp; Skill Acquisition)
│   ├── Predictive_Coding (Free Energy Minimization)
│   ├── Free_Energy_Principle (Perception &amp; Action Optimization)
│
├── Knowledge_Representation
│   ├── Polysynthetic_Language (Hyper-Efficient AI Communication)
│   ├── Glyph_Compression (SynthLang&#x2F;Glyphstral Model 93% Token Reduction)
│   ├── AST_Encoding (Abstract Syntax Tree Knowledge Representation)
│   │   ├── Set_Theory (Logical Foundations)
│   │   ├── Category_Theory (Complex Mappings)
│   │   ├── Topology (Spatial &amp; Conceptual Representation)
│
├── Hybrid_AI_Architecture
│   ├── Neural_Module (LLMs, Transformers)
│   ├── Symbolic_Engine (Rule-Based Reasoning)
│   ├── TPTrans (Transformer-Based Symbol-Embedding Bridge)
│   ├── Hybrid_AI (Associative Logic + Machine Learning)
│
├── Federated_Decentralized_Learning
│   ├── Crypto_Bounties (AI Skill Acquisition &amp; Rewards)
│   ├── zk-SNARKs (Privacy-Preserving AI Training)
│   ├── Federated_Neuroplasticity (Cross-Agent Adaptation)
│
├── Hardware_Software_CoDesign
│  

