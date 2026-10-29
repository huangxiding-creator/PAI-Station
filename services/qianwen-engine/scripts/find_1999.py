import sys; sys.path.insert(0, ".")
from qianwen_engine.report_catalog import catalog
for it in catalog():
    p = it.get("price_yuan") or it.get("price") or 0
    if str(p) == "1999":
        print("SKU=" + str(it.get("sku","?")) + " | " + str(it.get("title","?"))[:50])
