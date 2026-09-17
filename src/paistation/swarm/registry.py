"""站群注册表：本站视角的通讯录（谁在群里、公钥是什么）。

data/swarm/registry.json；同 site_id 重复登记=更新字段（added_at 保留，
updated_at 刷新），列表本身只增。公钥是互换包验签的唯一依据——
登记错公钥=收到谁的包都验不过，这是特性不是缺陷。
"""
from __future__ import annotations

import json
import os
import time

REQUIRED = ("site_id", "pubkey")


class SiteRegistry:

    def __init__(self, path: str):
        self._path = path
        self._sites: dict[str, dict] = {}
        if os.path.isfile(path):
            with open(path, encoding="utf-8") as fh:
                row = json.load(fh)
            self._sites = {s["site_id"]: s for s in row.get("sites", [])}

    # ---- 写 ----

    def upsert(self, site: dict) -> dict:
        missing = [k for k in REQUIRED if not str(site.get(k, "")).strip()]
        if missing:
            raise ValueError(f"站点登记缺必填字段：{missing}")
        sid = site["site_id"]
        clean = {"site_id": sid, "pubkey": site["pubkey"],
                 "owner": site.get("owner", ""),
                 "endpoint": site.get("endpoint", ""),
                 "did": site.get("did", ""),          # ANP 预研位
                 "note": site.get("note", "")}
        if sid in self._sites:
            clean["added_at"] = self._sites[sid].get("added_at", "")
            clean["updated_at"] = time.strftime("%Y-%m-%dT%H:%M:%S+08:00")
        else:
            clean["added_at"] = time.strftime("%Y-%m-%dT%H:%M:%S+08:00")
        self._sites[sid] = clean
        self._save()
        return clean

    def _save(self) -> None:
        os.makedirs(os.path.dirname(self._path) or ".", exist_ok=True)
        tmp = self._path + ".tmp"
        with open(tmp, "w", encoding="utf-8") as fh:
            json.dump({"sites": list(self._sites.values())}, fh,
                      ensure_ascii=False, indent=2)
        os.replace(tmp, self._path)

    # ---- 读 ----

    def find(self, site_id: str) -> dict | None:
        return self._sites.get(site_id)

    def require(self, site_id: str) -> dict:
        site = self.find(site_id)
        if site is None:
            raise ValueError(
                f"站点 {site_id} 未登记（先 register，验签只认注册表公钥）")
        return site

    def list_sites(self) -> list[dict]:
        return list(self._sites.values())
