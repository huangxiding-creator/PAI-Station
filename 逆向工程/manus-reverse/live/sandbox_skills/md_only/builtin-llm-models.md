---
name: builtin-llm-models
description: Reference for Manus's built-in LLM catalog and how to call it correctly. Read this BEFORE writing any script that calls LLMs in bulk (summarization, translation, classification, extraction, deep analysis, judging/evaluation, map/parallel fan-out) on a Manus computer — the Sandbox, the user's local computer, or a Cloud Computer — AND before using the built-in LLM in a webdev project (invokeLLM / listLLMModels). Use it to discover which models exist, each model's price/capabilities, how to pick one, the exact request shapes (thinking/reasoning, JSON-schema structured output, vision, tools), and the per-model gotchas (max-token handling, reasoning syntax) verified against the live proxy.
---

# Built-in LLM Models

For the commands below, replace `<skill-dir>` with the **absolute directory containing this loaded `SKILL.md`**, using its actual read path or the current runtime Skill catalog locator. Keep the quotes, including when the path contains spaces. Use a path accessible on the computer executing the command; do not derive it from the shell working directory or assume an installation root. Bundled documentation links resolve from the file containing the link.

Manus ships an OpenAI-compatible LLM proxy. These entry points share the same request schema, but each lists its own catalog — the webdev list can contain different models and fewer fields:

| Context | How to call | Credentials |
| --- | --- | --- |
| Scripts on any Manus computer (Sandbox, local computer, Cloud Computer) | `manus-node` with the bundled `lib/llm.mjs` and `scripts/*.mjs` | Automatic |
| Sandbox only: Python | `openai` Python SDK with `OpenAI()` | `OPENAI_API_KEY`, `OPENAI_API_BASE` (preconfigured) |
| Webdev project (server-side) | `invokeLLM` / `listLLMModels` from `server/_core/llm` | `BUILT_IN_FORGE_API_URL`, `BUILT_IN_FORGE_API_KEY` |

All speak the OpenAI Chat Completions schema. **Do NOT hardcode the model list
from memory** — it changes. Always pull the live catalog (Step 1) before relying
on any specific ID, price, or capability.

**Scripts on any Manus computer.** `manus-node` is supplied by Manus on the local computer, Cloud Computer and Sandbox. It requires no npm install or user Node setup. Authentication is automatic; never read, print, copy or manually pass tokens. If `manus-node` or the runtime is unavailable, report that the Manus runtime needs updating. Run scripts with a literal absolute script path (keep the quotes; not a shell variable) or an explicit execution directory, so Manus can inspect the script before it runs.

**On a local computer or Cloud Computer**, use only the `manus-node` path. Python, the `openai` package and `curl` may be missing there, and any `OPENAI_API_KEY` / `OPENAI_API_BASE` variables belong to the user's own provider account, not to Manus — do not use them. LLM calls require network access: when using `exec` on a local computer, set `network: true` so Manus can request the normal network permission.

## Step 1 — Always fetch the live catalog first

The catalog is the source of truth: IDs, `pricing`, `capabilities` and `description`
(positioning, `Quality vs. this catalog:`, `Cost per task:`, `Limits:`, `Effort:`, `Status:`).
This skill names no models; the catalog says what each one is good for today.
Use only model IDs listed by the live catalog. Unlisted IDs may still answer for
backward compatibility with older code, but they are retired and not for new
work; Step 2 covers a user who names one.

Any Manus computer:
```bash
manus-node "<skill-dir>/scripts/models.mjs"
```

Sandbox alternative:
```bash
curl -s "$OPENAI_API_BASE/models" -H "Authorization: Bearer $OPENAI_API_KEY" | python3 -m json.tool
```

Webdev (project shell, or `listLLMModels()` at runtime):
```bash
curl "$BUILT_IN_FORGE_API_URL/v1/models" -H "Authorization: Bearer $BUILT_IN_FORGE_API_KEY"
```

### Reading the catalog

- `description`: positioning, then `Quality vs. this catalog:` and `Cost per task:` (below), `Limits:` (behaviour to plan around), `Effort:` (accepted reasoning values and the level used if you do not send one) and, when relevant, `Status:` (preview, superseded, or deprecated with a shutdown date). Input types are in `capabilities` (`supports_vision`), not in the description.
- `Quality vs. this catalog:` places the model `top`, `middle` or `bottom` among the models in this catalog on reasoning, instruction following, factual accuracy, writing, coding and tool use, measured at each model's highest effort. A dimension it does not name, or a missing slot, means not measured, not weak. `Cost per task:` (`low`, `medium`, `high`) reflects real tasks, so it already counts how many tokens the model spends; it can rank models differently from per-token price.
- `capabilities` and `pricing` are facts: check them rather than assuming every model supports tools, vision, JSON schema or streaming. Prices are USD per 1M tokens, with credit equivalents.
- `created` is not a release date; do not use it to judge which model is newer.

## Step 2 — Pick a model

**A model the user names comes first**, and so does a model already named in the code or config you are extending: skip the selection below for it, but resolve the name first. IDs are exact and case-sensitive. Check them against the catalog of the entry point you will call (scripts: Step 1; webdev: `listLLMModels()`). Step 3 applies either way.

| What you find | Do |
| --- | --- |
| Listed and fits the task | Use it. |
| Listed, but with a shutdown date or `superseded` status, or missing what the task needs (`supports_vision`, JSON schema, tools, context window) | Tell the user and suggest a listed model; switch only if they agree. |
| A loose name (no version, a nickname, wrong case) | Use the listed ID it clearly means and say which; if several fit, ask. |
| Not listed | Do not call it anyway, and do not swap silently. Tell the user it is not offered for new work here and suggest the closest listed models (same provider first, then by `description`); wait for their answer before running batches, scheduled jobs or app code. A model the proxy does not offer can only come from the user's own provider account, which is outside this skill: ask, and never use credentials you find. |
| Unlisted, but already in the code you are extending | Keep it working; mention that it is retired and offer to migrate. |

A preference without an ID ("use Gemini", "cheapest", "best quality", "fast") narrows the selection below; tell the user which ID you chose and why.

Match the task to the dimensions it depends on, then read those dimensions in the live catalog.

| Task | Decisive dimensions | Also check |
| --- | --- | --- |
| Bulk translation | multilingual, factual accuracy, cost per task | instruction following |
| Bulk summarization | factual accuracy, cost per task | instruction following, long context |
| Rewrite / normalize / redact | instruction following | factual accuracy, cost per task |
| Classification / tagging | instruction following, cost per task | reasoning |
| Structured extraction | instruction following, factual accuracy | cost per task |
| Extraction from long documents | long context, factual accuracy | instruction following |
| Extraction from images or scans | vision, factual accuracy | instruction following |
| Per-item analysis | reasoning | factual accuracy, cost per task |
| Code over many files | coding | reasoning, long context |
| LLM-as-judge | reasoning, instruction following | factual accuracy |
| Audio / video | factual accuracy, long context | multilingual |
| Tool-calling loop in a script | tool use | reasoning, latency |
| In-app chat assistant | latency, instruction following | writing, multilingual, factual accuracy, cost per task |
| Content generation feature | writing | instruction following, factual accuracy |
| Structured feature in an app | instruction following | latency, factual accuracy |
| Multimodal feature in an app | vision | factual accuracy, latency |
| Game AI (NPC dialogue) | latency, writing, cost per task | instruction following, long context |
| Scheduled job in an app | factual accuracy, cost per task | instruction following |
| In-app agent | tool use, latency | reasoning, factual accuracy |

Descriptions rate reasoning, instruction following, factual accuracy, writing, coding, tool use and cost per task. Long context, vision, multilingual and latency are not rated: check `context_window` and `supports_vision`, and cover them in the pilot.

1. Filter on hard facts: `supports_vision`, `context_window`, `supports_response_format_json_schema` and `Status:`. For anything that runs unattended or ships in an app, drop models with a shutdown date or a `superseded` status.
2. Read the decisive dimensions in each remaining model's `Quality vs. this catalog:`. Ratings come from each model's highest effort; at lower effort expect lower quality and cost, so pilot at the effort you will run.
3. Require `top` on decisive dimensions when an error spreads or stays silent (a judge scoring a whole batch, extraction feeding analysis, unattended jobs); `middle` is enough otherwise.
4. Treat a dimension the description does not name, or a model without the slot, as "needs a pilot", not as failing.
5. Among qualifying models, start from the lowest `Cost per task:`, or from price when it is not stated. Price per token is not cost per task: verbose or reasoning-heavy models spend more tokens.
6. Pilot on 20–50 real items, compare outputs and cost, then run the batch.

If no description has a `Quality vs. this catalog:` slot, filter on hard facts, shortlist two or three models from `description` and price, and decide by the pilot.

### Cost-aware batching pattern

For large batches, start with the model with the lowest `Cost per task:` that passes Step 2's filters, apply a programmatic quality gate (schema validation, length checks, confidence field), then re-run only the failures on a model that is `top` on the task's decisive dimensions. This typically cuts spend by an order of magnitude versus running everything on the top model.

### Mapping models to the `map` tool (wide / parallel research)

When using Manus's `map` tool for homogeneous parallel subtasks, the subtasks themselves run as full agents; you generally do not pick a proxy model there. Use this skill's `scripts/llm_batch.mjs` (or direct client calls) when YOU are writing a script that fans out raw LLM calls and needs explicit model/cost control.

## Step 3 — Call it with the correct request shape

The proxy mirrors OpenAI Chat Completions, but provider-specific behaviors (like extended thinking, reasoning effort, and strict JSON schemas) differ by family.

### 🚨 The Max-Token Trap (Crucial — differs by family)

When a model reasons/thinks, it consumes tokens *before* generating the final answer.

- **GPT:** Use `max_completion_tokens` to cap visible output while leaving reasoning unconstrained.
- **Gemini:** Use `max_tokens` (e.g. `max_tokens: 16384`). Do **NOT** use `max_completion_tokens` — on the current proxy it causes `content: null` with `finish_reason: "length"` regardless of budget size. Omitting the parameter entirely also works (the model will use its default limit).
- **Claude (when listed):** Use `max_tokens`, and it *must* be strictly greater than `budget_tokens` (e.g. `budget_tokens: 2048` requires `max_tokens: 2049` or higher).

### A. JavaScript with `manus-node` (every Manus computer)

Write a `.mjs` script, import the bundled client by absolute path with `pathToFileURL` (portable, including Windows drive paths), and run it with `manus-node "/absolute/path/script.mjs"`. The client sends the request body as-is: provider-specific keys (`reasoning`, `thinking`, `reasoning_effort`) go at the **top level** of the body.

#### A1. Basic chat

```js
import { pathToFileURL } from 'node:url'
const { LlmClient, messageText } = await import(pathToFileURL('<skill-dir>/lib/llm.mjs').href)

const MODEL = '<id chosen in Step 2>'
const llm = new LlmClient()
const resp = await llm.chat({
  model: MODEL,
  messages: [
    { role: 'system', content: 'You are a precise translator.' },
    { role: 'user', content: 'Translate to French: Good morning.' },
  ],
})
console.log(messageText(resp))
console.log(resp.usage.prompt_tokens, resp.usage.completion_tokens)
```

`new LlmClient({ timeoutMs, maxRetries })` defaults to a 300 s timeout and 3 retries. The client retries only transient failures (network errors, HTTP 408/409/429/5xx, proxy rate limits). Proxy errors can arrive as HTTP 200 with an `error` field; the client throws them as `LlmError`. `error.fatal` (runtime not ready, invalid session, insufficient credits, unsupported model, blocked user) means stop the whole batch and report it — retrying will not help.

#### A2. Thinking / reasoning (family-specific)

The catalog field `capabilities.thinking_param` tells you which key to send; `capabilities.thinking_example` shows its shape with one sample value — not the default and not a recommendation. The accepted values and what applies when the key is omitted are in the description's `Effort:` slot. Omitting the key does not turn reasoning off: the provider default applies, often `medium`. To keep reasoning to a minimum, send the lowest value listed in `Effort:`, or a small `budget_tokens` when `Effort:` names that key.

**1. OpenAI models** (`owned_by: "openai"`)
Controls reasoning via the `reasoning.effort` parameter. If you pass Anthropic/Google `thinking` syntax, it is silently ignored.
```js
await llm.chat({
  model: '<an openai id from the catalog>',
  messages: [{ role: 'user', content: 'Prove sqrt(2) is irrational.' }],
  max_completion_tokens: 2000, // Prevents reasoning from eating the output budget
  reasoning: { effort: 'high' }, // any value listed in the model's Effort: slot
})
```

**2. Google Gemini models** (`owned_by: "google"`)
Send the key named by `thinking_param`: `reasoning: { effort }` when it says `reasoning`, `thinking: { budget_tokens }` when it says `thinking`. Gemini reasons when the key is omitted.
```js
await llm.chat({
  model: '<a google id from the catalog>',
  messages: [{ role: 'user', content: 'Prove sqrt(2) is irrational.' }],
  max_tokens: 16384, // MUST use max_tokens for Gemini (NOT max_completion_tokens)
})
```

**3. Anthropic Claude models** (`owned_by: "anthropic"`, only when listed in the live catalog)
Sonnet/Opus 4.6-generation models require an explicit thinking budget; Opus 4.7 uses adaptive thinking and does not require thinking parameters.
```js
await llm.chat({
  model: '<claude model id from the live catalog>',
  messages: [{ role: 'user', content: 'Prove sqrt(2) is irrational.' }],
  max_tokens: 4000, // MUST be strictly > budget_tokens
  thinking: { type: 'enabled', budget_tokens: 2048 },
})
```

#### A3. Structured output (JSON schema) — preferred for extraction/analysis

Check `capabilities.supports_response_format_json_schema` for the chosen model. **Required:** `strict: true`, `additionalProperties: false`, and an explicit `model` — a request without one goes to a default route that has returned empty content with `response_format`.

```js
const resp = await llm.chat({
  model: MODEL,
  messages: [
    { role: 'system', content: 'Output JSON only.' },
    { role: 'user', content: 'My name is Alice and I am 30.' },
  ],
  response_format: {
    type: 'json_schema',
    json_schema: {
      name: 'person',
      strict: true,
      schema: {
        type: 'object',
        properties: { name: { type: 'string' }, age: { type: 'integer' } },
        required: ['name', 'age'],
        additionalProperties: false,
      },
    },
  },
})
const data = JSON.parse(messageText(resp))
```

#### A4. Vision (image input)

```js
import { readFile } from 'node:fs/promises'
const image = (await readFile('/absolute/path/photo.jpg')).toString('base64')
await llm.chat({
  model: MODEL, // its capabilities.supports_vision must be true
  messages: [{
    role: 'user',
    content: [
      { type: 'text', text: 'Describe this image.' },
      { type: 'image_url', image_url: { url: `data:image/jpeg;base64,${image}`, detail: 'auto' } },
    ],
  }],
})
```
For remote images, pass the `https://` URL directly.

#### A5. Tool / function calling

```js
const resp = await llm.chat({
  model: MODEL,
  messages: [{ role: 'user', content: 'Weather in Tokyo?' }],
  tools: [{
    type: 'function',
    function: {
      name: 'get_weather',
      description: 'Get weather for a city',
      parameters: { type: 'object', properties: { city: { type: 'string' } }, required: ['city'] },
    },
  }],
  tool_choice: 'auto',
})
// resp.choices[0].message.tool_calls -> execute -> append role:"tool" result -> call again
```

#### A6. Concurrent batch (the common case for bulk summarize/translate/analyze)

A ready-to-run batch driver is bundled. It reads lines or a JSON array, keeps output in input order, writes JSONL (`index`, `input`, `output`, `error`, `usage`), applies the family rules above, and stops early on fatal errors:
```bash
manus-node "<skill-dir>/scripts/llm_batch.mjs" --help
manus-node "<skill-dir>/scripts/llm_batch.mjs" --input items.txt --out out.jsonl \
  --model <id> --workers 8 --template "Summarize in one sentence: {input}"
```
`--model` is required. Options: `--system`, `--schema schema.json` (strict structured output), `--reasoning-effort <a value from the model's Effort: slot>`, `--thinking-budget N`, `--max-retries N`, `--timeout-seconds N`.

Minimal inline version:
```js
import { pathToFileURL } from 'node:url'
const { LlmClient, mapLimit, messageText } = await import(pathToFileURL('<skill-dir>/lib/llm.mjs').href)

const MODEL = '<id chosen in Step 2>'
const llm = new LlmClient()
const items = [/* inputs */]
let fatal
const results = await mapLimit(items, 8, async text => {
  if (fatal) return { text, output: null, error: 'skipped' }
  try {
    const resp = await llm.chat({
      model: MODEL,
      messages: [{ role: 'user', content: `Summarize in one sentence:\n${text}` }],
    })
    return { text, output: messageText(resp), error: null }
  } catch (error) {
    if (error.fatal) fatal = error
    return { text, output: null, error: error.message }
  }
})
if (fatal) throw fatal
```
Keep concurrency modest (4–10); the proxy rate-limits each user and the client already retries transient failures. Save large results to files in the working directory instead of printing them.

### B. Sandbox Python (optional, Sandbox only)

The SDK auto-reads `OPENAI_API_KEY` and `OPENAI_API_BASE`; just call `OpenAI()`. Request bodies are the same as section A, except that non-OpenAI keys (`reasoning`, `thinking`) go in `extra_body`; `reasoning_effort`, `max_tokens`, `max_completion_tokens`, `response_format` and `tools` are regular keyword arguments.

```python
from openai import OpenAI
client = OpenAI()

resp = client.chat.completions.create(
    model="<an openai id from the catalog>",
    messages=[{"role": "user", "content": "Prove sqrt(2) is irrational."}],
    max_completion_tokens=2000,
    extra_body={"reasoning": {"effort": "high"}},  # a value from the model's Effort: slot
)
print(resp.choices[0].message.content)
print(resp.usage.prompt_tokens, resp.usage.completion_tokens)
```

The Python batch driver accepts the same options as `llm_batch.mjs` except `--timeout-seconds`:
```bash
python3 "<skill-dir>/scripts/llm_batch.py" --help
```
With a thread pool, keep `max_workers` modest (4–10); the proxy rate-limits and the SDK already retries.

### C. Webdev project (TypeScript, server-side only)

Import from the scaffold's core helper. Credentials are injected by the platform (`BUILT_IN_FORGE_API_URL` / `BUILT_IN_FORGE_API_KEY`); never call from the client. Calls deduct project credits. `listLLMModels()` returns the IDs this project can call, without descriptions or tiers. A model the user names only needs to be in `listLLMModels()`; if the Step 1 catalog also lists it, apply Step 2's checks to it. Otherwise pick with Step 2 using the Step 1 catalog, then use only an ID that `listLLMModels()` also returns.

#### C1. Basic + list models

```ts
import { invokeLLM, listLLMModels } from "./server/_core/llm";

const { data } = await listLLMModels();         // IDs this project can call
const MODEL = "<id chosen in Step 2>";
if (!data.some(m => m.id === MODEL)) throw new Error(`${MODEL} is not available to this project`);

const res = await invokeLLM({
  model: MODEL,                                   // always set it; requests without a model go to an unspecified default route
  messages: [
    { role: "system", content: "You are helpful." },
    { role: "user", content: "Hello" },
  ],
});
const text = res.choices[0].message.content;
```

#### C2. Thinking / reasoning (forwarded unchanged)

```ts
await invokeLLM({
  model: "<an openai id from the catalog>",
  messages: [...],
  reasoning: { effort: "low" },                   // a value from the model's Effort: slot
});
await invokeLLM({
  model: "<claude model id from the live catalog>",
  messages: [...],
  thinking: { type: "enabled", budget_tokens: 2048 },
});
```

#### C3. Structured output

```ts
const r = await invokeLLM({
  model: MODEL,                                   // required with response_format
  messages: [
    { role: "system", content: "Output JSON." },
    { role: "user", content: "name=Alice age=30" },
  ],
  response_format: {
    type: "json_schema",
    json_schema: {
      name: "person",
      strict: true,
      schema: {
        type: "object",
        properties: { name: { type: "string" }, age: { type: "integer" } },
        required: ["name", "age"],
        additionalProperties: false,
      },
    },
  },
});
// JSON.parse(r.choices[0].message.content)
```
The helper also accepts `outputSchema`/`output_schema` as a shorthand, plus `tools`, `toolChoice`, `maxTokens`. It retries non-2xx/network errors with exponential backoff internally.

#### C4. Streaming (not exposed by default)

`invokeLLM()` does not expose `stream`. If you truly need it, modify the helper to send `stream: true` and parse the SSE response. When proxying SSE, listen on the response object's close event (not the request) and guard with a `finished` flag, or the upstream gets aborted after the first event. Render markdown with `<Streamdown>{content}</Streamdown>` from `streamdown`.

### D. Raw HTTP (Sandbox only)

```bash
curl -s "$OPENAI_API_BASE/chat/completions" \
  -H "Authorization: Bearer $OPENAI_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{"model":"<id>","messages":[{"role":"user","content":"ping"}]}'
```
Webdev path is `"$BUILT_IN_FORGE_API_URL/v1/chat/completions"` with `BUILT_IN_FORGE_API_KEY`. On a local computer or Cloud Computer, use the JavaScript client instead of raw HTTP.

## Troubleshooting

| Symptom | Likely Cause | Fix |
| --- | --- | --- |
| `Built-in LLM runtime is not ready` | Script not run with `manus-node`, or the Manus connection/runtime is outdated | Run with `manus-node` and an absolute script path; if it persists, report that the Manus runtime needs updating. Never supply credentials manually |
| `LLM proxy: Insufficient credits` | Account balance too low | Stop the batch and tell the user; do not retry |
| `LLM proxy: Unsupported model ...` (arrives as HTTP 200 with an `error` body) | ID not in the live catalog; IDs are exact and case-sensitive | Use the exact catalog ID. If the user named this model, follow Step 2's "Not listed" row instead of switching on your own; otherwise re-run Step 1 and pick a listed ID |
| `LLM proxy: Rate limit exceeded` after retries | Too many concurrent requests | Lower concurrency (`--workers`) and re-run failed items |
| Gemini returns `content: null` + `finish_reason: "length"` | Used `max_completion_tokens` | Switch to `max_tokens` or omit the parameter |
| Claude returns 400 Bad Request | `max_tokens` <= `budget_tokens` | Set `max_tokens` strictly greater than `budget_tokens` |
| GPT output truncated with reasoning on | Used `max_tokens` with reasoning | Switch to `max_completion_tokens` for GPT |
| 400 `Unsupported value` for `reasoning.effort` | The model does not accept that value | Use a value from the model's `Effort:` slot; the error usually lists the supported values |
| 400 `Invocation of model ID ... with on-demand throughput isn't supported` right after setting an effort | The model does not accept that effort value; the upstream error is misleading | Use a value from `Effort:` |
| Slower or costlier than expected with no reasoning key | The provider default (often `medium`) applied | Send the lowest value in `Effort:` explicitly |

## Files in this skill

- `lib/llm.mjs` — `LlmClient` (`models()`, `chat()`), `messageText()`, `mapLimit()`; runtime resolution, retries and credential redaction for every Manus computer.
- `scripts/models.mjs` — prints the live catalog.
- `scripts/llm_batch.mjs` — concurrent, retrying batch driver for every Manus computer.
- `scripts/llm_batch.py` — the same batch driver for Sandbox Python.
