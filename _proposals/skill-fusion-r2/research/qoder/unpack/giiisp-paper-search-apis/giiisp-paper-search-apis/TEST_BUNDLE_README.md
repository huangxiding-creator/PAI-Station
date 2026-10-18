# Giiisp Paper Search Skill Test Bundle

- Bundle type: local test package with user-provided key included.
- Do not upload this zip to GitHub or public storage.
- The search API is synchronous JSON; user-visible streaming is produced by progress events before and after each planned request.
- Latest local verification before packaging: `python -m pytest skills\giiisp-paper-search-apis\tests\test_progressive_paper_search.py -q` -> 3 passed.
- Live lightweight probe before packaging: auth ok, 2 responses, `search_complete`, about 15.8 seconds.
- No automatic truncation parameter is used for normal runs.
