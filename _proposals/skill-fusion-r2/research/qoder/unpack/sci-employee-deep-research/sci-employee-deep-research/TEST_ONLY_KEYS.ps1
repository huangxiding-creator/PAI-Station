# TEST ONLY - do not publish this file.
# This package intentionally includes the provided sk for local usability testing.
# Deep Research SSE endpoint currently does not require this key directly;
# it is included because this build is a user-requested test bundle.
$env:DASHSCOPE_API_KEY = "
sk-e803a9c098ac4e10947dba886f03e7f1
"
$env:ALIYUN_DASHSCOPE_API_KEY = "
sk-e803a9c098ac4e10947dba886f03e7f1
"

# Normal full streaming run, no automatic truncation:
# python .\scripts\stream_deep_research.py --prompt "graph neural networks for molecule property prediction, return recent paper evidence" --page-size 2 --timeout 180

# Optional quick probe only; this intentionally truncates after N events:
# python .\scripts\stream_deep_research.py --prompt "graph neural networks for molecule property prediction" --page-size 2 --max-events 12 --timeout 60
