import sys, json, tempfile, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "..", ".."))
from kb_factory.catalog_engine.document_engine import build_blueprint_document_driven
from kb_factory.catalog_engine.contract import (
    generate_contract, verify_reproducibility, save_contract, load_contract,
    generate_synthetic_domain)

docs = generate_synthetic_domain("水利水电", 50)
bp = build_blueprint_document_driven(
    {"domain": "水利水电", "keywords": ["水利水电", "EPC"], "intent": "水利水电知识库"}, docs)
c = generate_contract(bp, docs)
tmp = os.path.join(tempfile.mkdtemp(), "mapping_contract.yaml")
save_contract(c, tmp)
raw = open(tmp, encoding="utf-8").read().splitlines()
print("== contract JSON first 3 lines:")
for line in raw[:3]:
    print("   ", line)
print("== rules[0]:", json.dumps(c.rules[0], ensure_ascii=False))
print("== layer rule:", json.dumps([r for r in c.rules if r["action"] == "place_under"][0], ensure_ascii=False))
print("== verify:", json.dumps(verify_reproducibility(bp, c), ensure_ascii=False))
c2 = load_contract(tmp)
print("== verify(reloaded):", json.dumps(verify_reproducibility(bp, c2), ensure_ascii=False))
print("== doc_types:", sorted(bp["provenance"]["doc_types"]))
