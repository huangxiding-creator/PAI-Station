"""E3 托管层最小可用：同步（export）+备份（时间戳 zip，只增不删）。

商业边界的载体：主权层免费本地，托管是可选项（章程商业边界一致）。
"""
from __future__ import annotations

import zipfile
from datetime import datetime
from pathlib import Path

from paistation.sovereign.protocol import export_vault

_BACKUP_DIRS = ("sovereign", "profile", "skills", "evolve", "gate")


def sync_vault(data_dir: str | Path, dest: str | Path) -> dict:
    """托管同步=vault 导出到目标目录（增量语义由 export 幂等保证）。"""
    return export_vault(data_dir, dest)


def backup_data(data_dir: str | Path, backups_dir: str | Path) -> Path:
    """全量备份：data 下核心目录打包时间戳 zip；backups/ 只增不删。"""
    data_dir = Path(data_dir)
    backups_dir = Path(backups_dir)
    backups_dir.mkdir(parents=True, exist_ok=True)
    ts = datetime.now().strftime("%Y%m%d-%H%M%S-%f")   # 微秒防同秒覆盖
    path = backups_dir / f"pai-backup-{ts}.zip"
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as zf:
        for sub in _BACKUP_DIRS:
            src = data_dir / sub
            if not src.is_dir():
                continue
            for p in sorted(src.rglob("*")):
                if p.is_file():
                    zf.write(p, p.relative_to(data_dir).as_posix())
    return path
