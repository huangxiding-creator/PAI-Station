# Deep Research Skill Test Bundle

- Bundle type: local test package with user-provided sk included.
- Do not upload this zip to GitHub or public storage.
- Default streaming command does not pass `--max-events`; it waits for service `done`.
- `--max-events` is only a manual probe option for first-screen streaming checks.
- Latest local verification before packaging: `python -m pytest skills\sci-employee-deep-research\tests\test_stream_deep_research.py -q` -> 4 passed.
- Live full-stream probe before packaging: completed with `done`, 22 references, about 46 seconds.
