# TEST ONLY - do not publish this file.
# This package intentionally includes the provided key for local Giiisp search usability testing.
$env:GIIISP_AUTH_TOKEN = "
sk-e803a9c098ac4e10947dba886f03e7f1
"

# Normal live progressive search, no automatic truncation:
# python .\scripts\progressive_paper_search.py --query "graph neural network molecule property prediction" --mode arxiv --expand arxiv-title --page-size 2 --max-pages 1 --timeout 30

# Dry-run only, no network call:
# python .\scripts\progressive_paper_search.py --query "large language model scientific discovery" --mode arxiv-title --expand arxiv-abstract,oa --max-pages 2 --dry-run
