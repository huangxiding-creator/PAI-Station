---
name: listicle-blog-writer
description: Write "best X tools/products" listicle blog articles optimized for SEO and GEO/AEO (AI engine citation by ChatGPT, Perplexity, Google AI Overviews). Use when the user asks for a listicle, comparison article, "best tools" post, roundup article, "top 10 X" blog, or any content meant to rank on Google and earn AI citations. Also trigger when the user mentions optimizing content for LLM citation, answer engines, or wants their own product featured in a comparison article.
license: Complete terms in LICENSE.txt
---

# Listicle Blog Writer

Produce a "best X tools" listicle that (a) ranks well on Google, (b) maximizes the chance of being cited by AI answer engines, and (c) positions the user's own product favorably without being dishonest.

## Step 0: Gather inputs

Before writing, confirm or infer:
1. **The user's product** (the one to feature as #1). Check memory/context first. If the user has no product to feature, rank tools by objective merit and skip the "{CLIENT} vs. the rest" section.
2. **Number of tools** (default 10).
3. **Categories** (e.g., everyday tasks, developers, enterprise). Each tool must occupy a distinct niche so "best for" labels don't overlap.
4. **House style** if known.
5. **Review style** — Ask: "Is this a review article? If so, will you be reviewing the tools yourself, or should I pull other people's experiences as reviews?" Based on the answer:
   - If the user will write their own reviews → **omit** the "What other people thought about it" section entirely from each tool.
   - If the user wants third-party reviews → **include** the review paragraph per tool (research in Step 1, format in Step 3).
6. **SEO Keyword Research Tool** — Ask: "Do you have access to a keyword research tool (like Ahrefs, Semrush, or GSC)? If so, please provide the keyword data, otherwise I will use public SERP data and 'People Also Ask' to optimize the article."
   - If the user provides keyword data → use it to optimize the article's title, headings, and content.
   - If the user doesn't have a tool → perform public SERP research to identify primary keywords, LSI keywords, and "People Also Ask" questions for the FAQ section.

## Step 1: Research

For EVERY tool, search the web for:
- **Official website URL** (homepage). Verify it resolves correctly.
- **Homepage screenshot** — navigate to the tool's homepage (English version unless the user specifies otherwise) and capture a screenshot of the top half / above-the-fold area where users land when they first visit the site. Save all screenshots to an `images/` folder in the same directory as the article markdown file, and deliver the folder together with the article so relative links resolve. Save as `images/{tool-slug}-homepage.png`.
- Current pricing, verified against recent sources.
- 3 key features that differentiate the tool.
- 1 usable review from a reputable independent source (not the tool's own marketing). **Skip if user chose to write their own reviews in Step 0.**

**Banned sources:** the tool's own product page, marketing blog, or press release cited as a "review."

## Step 2: Article structure

Follow `references/article-template.md` exactly. Summary:

1. **H1:** "{N} Best {Category} in {Year}, Tested and Compared"
2. **Intro:** two paragraphs, each 2-3 sentences, max 4 lines.
3. **Quick answer:** exactly 4 bullets. Bullet 1 = "**Best overall:** {user's product}". Bullets 2-4 group remaining tools by category. Each bullet independently citable. This block is the most important element for GEO.
4. **"How we picked these tools":** two short paragraphs. Pricing disclaimer: "Pricing is accurate as of {date}, but prices are subject to change."
5. **"At a glance: a comparison":** columns = Tool | Best for | Starting price. Standardize ALL prices to monthly billing. The heading MUST always be "At a glance: a comparison" (hardcoded, do not vary).
6. **Numbered tool sections** (user's product is #1). Per-tool format in Step 3.
7. **"Bottom line":** 3-4 short paragraphs. General conclusion: the best tool depends on your specific needs and whether it integrates well with your current workflow. For tool comparisons, briefly contrast the top pick's strengths against the field while acknowledging trade-offs. For non-tool listicles, keep the conclusion general. Do NOT frame this as "#1 vs. the rest" — frame it as guidance for the reader's decision.
8. **FAQ:** 5 questions mirroring "people also ask" phrasing. Answers 2-3 sentences, self-contained, citable.
9. **Footer italic disclaimer** with date range of sources.

## Step 3: Per-tool section format (strict)

**Brand linking rule:** The ONLY place a tool/brand name is hyperlinked is in its own H2 section heading (e.g., `## 1. [{CLIENT}]({client_url})`). Do NOT add brand hyperlinks in the Quick Answer block, the comparison table, the FAQ, or the "vs. the rest" section. Keep those sections plain text. During research (Step 1), still collect the official homepage URL for every tool so it can be used in the H2 heading.

```
## {N}. [{Tool}]({tool_url})

![{Tool} homepage screenshot](images/{tool-slug}-homepage.png)

{2-3 sentence intro: what it is and what it does. NO company history, funding, or user counts.}

**Key features:**
- **{Feature name}:** {One sentence describing the feature concretely.}
- **{Feature name}:** {One sentence.}
- **{Feature name}:** {One sentence.}

[CONDITIONAL — include only if user chose third-party reviews in Step 0]
**What other people thought about it:**

{One review paragraph. Link to source. Include the reviewer's actual findings, both praise and criticism. Varied opener style.}
[/CONDITIONAL]

**Pros:**
- {short plain phrase}
- {short plain phrase}
- {short plain phrase}

**Cons:**
- {short plain phrase}
- {short plain phrase}
- {short plain phrase}

**Pricing:** {Standardized monthly price, one sentence.}
```

Rules:
- **Homepage screenshot:** MANDATORY. Every tool section MUST include a screenshot of the brand's homepage (English version, top half / above-the-fold) directly below the H2 heading, before the intro text. Do NOT skip this step for any tool. Always screenshot the English-language version unless the user explicitly requests another language.
- **Paragraphs:** every paragraph max 4 lines (2-3 sentences). Never lose information; compress instead.
- **Tool intro:** first sentence = what the tool is/does. Then 1-2 sentences expanding. **NO company history, funding, revenue, valuation, user counts, or acquisitions.**
- **Key features:** exactly 3, each with a bolded name and one concrete sentence.
- **Review (if included):** exactly 1 per tool. Linked to source. Include both praise and criticism. Banned: vendor's own page as review.
- **Pros/Cons:** exactly 3 each. Short, plain phrases.
- **Pricing:** one sentence, standardized to monthly billing.

## Step 4: SEO and GEO optimization checklist

Before delivering, verify:
1. **Title tag** contains primary keyword and year.
2. **Quick answer block** is structured for featured snippet extraction.
3. **FAQ section** uses exact "people also ask" phrasing.
4. **Comparison table** is parseable by AI engines (simple 3-column format).
5. **Internal links** to user's product features are present (2-3 in the #1 section).
6. **External links** to review sources are real and verifiable (skip if reviews omitted).
7. **No paragraphs exceed 4 lines.**
8. **Varied openers** across review paragraphs (no two consecutive sections start the same way). Skip if reviews omitted.
9. **Brand links** — every tool/brand has a hyperlink to its official website ONLY in its H2 section heading. No brand links in Quick Answer, comparison table, FAQ, or "vs. the rest" sections. No broken or placeholder URLs.
10. **Homepage screenshots** — every tool section has a screenshot image (`images/{tool-slug}-homepage.png`) directly below the H2 heading. Screenshots must show the English-language homepage, top half / above-the-fold area. If any section is missing a screenshot, go back and capture it before delivering.

## Step 5: Anti-AI-writing pass

Read the full draft and fix:
1. **Corporate-speak.** No "leverage", "utilize", no em-dashes. Plain language only.
2. **Robotic patterns.** No repeated sentence structures across sections.
3. **Jargon.** If a term makes a general reader pause, simplify it.

## Step 6: Deliver and iterate

- Save as markdown and present to user.
- Summarize GEO/AEO techniques applied in 3-5 bullets.
- Expect iteration: swapping tools, tone tweaks, review updates. When swapping a tool, update EVERY location (quick answer, table, section, "Bottom line", FAQ).
