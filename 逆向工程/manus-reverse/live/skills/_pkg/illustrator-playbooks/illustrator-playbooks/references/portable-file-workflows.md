# Portable file workflows

These workflows provide deterministic preparation and verification. They do not operate Illustrator state.

## Card 2: Variable-data preflight

Use when the user supplies structured data for badges, labels, names, SKUs, certificates, or other repeated variants.

1. Confirm the required fields, unique key, asset field, optional fields, output naming, and rejected-row policy.
2. Run the preflight against the source CSV and its asset root:

```bash
python3 scripts/preflight.py variables \
  --csv INPUT.csv \
  --asset-root INPUT_ROOT \
  --required-columns record_id,full_name,role,photo_path \
  --id-column record_id \
  --asset-column photo_path \
  --output preflight-manifest.json
```

3. Review duplicates, missing values, missing assets, and path escapes. Do not repair ambiguous data silently.
4. Deliver the normalized mapping specification and manifest. This is useful even when Illustrator is unavailable.
5. If the user needs a reusable Illustrator Variables template or generated AI files, detect a supported official automation runtime or keep that tail blocked pending live Desktop evidence.

The visual pilot must include the longest text, Unicode or bidirectional text where present, optional-empty fields, representative colors, and representative images. Data validity does not prove layout fit.

## Card 8: Standards SVG normalization

Use only when a portable standards SVG is the declared source of truth and Illustrator-private editability is not required.

```bash
python3 scripts/preflight.py svg \
  --input source.svg \
  --output normalized.svg \
  --report svg-report.json
```

The tested subset requires numeric unitless or `px` width and height, a positive viewBox, unique IDs, no scripts or foreign objects, no remote references, and no private namespaces. Normalization removes metadata, converts a bounded set of style declarations to presentation attributes, and orders attributes deterministically.

After normalization, compare source and output in the declared target renderer. The bundled script validates structure but does not ship a cross-platform renderer. If appearance, embedded Illustrator data, live effects, font behavior, or desktop editability must survive, do not use this portable route as the master mutation.

## Card 1 portable branch

If the user wants a standards SVG but not desktop AI state, Card 8 supplies the file contract. If the source is raster and a new portable vector reconstruction is required, use a currently exposed vector-capable mechanism only when its output and fidelity oracle are proved. Do not relabel a raster concept as vector artwork.
