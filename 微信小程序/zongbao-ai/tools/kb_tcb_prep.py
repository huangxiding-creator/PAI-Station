# -*- coding: utf-8 -*-
"""kb_tcb_prep.py — kb-evidence 云托管 staging 构造器（宪法模式部署件）。
产出 E:/AI-Station/data/state/kb_deploy_stage：Dockerfile+kb_factory 全源+seeds 轻数据
（thuocl/taxonomy/六域种子进镜像；fibo/brick/cilin 重数据留本地——evidence 链不依赖）。
CRLF→LF 全量归一（1022 W11 陷阱）。"""
import shutil
from pathlib import Path

STAGE = Path(r"E:\AI-Station\data\state\kb_deploy_stage")
SRC = Path(r"E:\AI-Station\kb_factory")

# Dockerfile：python:3-slim 零 requirements（kb_factory 纯 stdlib）
DOCKERFILE = """FROM python:3-slim
WORKDIR /app
COPY kb_factory /app/kb_factory
ENV PYTHONUNBUFFERED=1
EXPOSE 8080
CMD ["sh", "-c", "python -m kb_factory.kb_server --host 0.0.0.0 --port ${PORT:-8080}"]
"""

def copy_norm(src: Path, dst: Path):
    """拷贝并 CRLF→LF 归一（文本件）；二进制原样。"""
    data = src.read_bytes()
    try:
        text = data.decode("utf-8")
        dst.write_bytes(text.replace("\r\n", "\n").encode("utf-8"))
    except UnicodeDecodeError:
        dst.write_bytes(data)

def main():
    if STAGE.exists():
        for child in STAGE.iterdir():          # 只清子项不动根（Win 句柄占用防）
            if child.is_dir():
                shutil.rmtree(child, ignore_errors=True)
            else:
                child.unlink(missing_ok=True)
    (STAGE / "kb_factory").mkdir(parents=True, exist_ok=True)
    # Dockerfile
    (STAGE / "Dockerfile").write_text(DOCKERFILE, encoding="utf-8", newline="\n")
    # kb_factory 源码（py 全量；排除 cloudfn/harvest_engine/e2e/kb_harvest_out/__pycache__/tests 大头）
    EXCLUDE_DIRS = {"cloudfn", "harvest_engine", "e2e", "kb_harvest_out", "__pycache__",
                    "compare", "tests", "_work", "_raw", "node_modules", "shots", "samples"}
    n = 0
    for p in SRC.rglob("*"):
        if p.is_dir():
            continue
        rel = p.relative_to(SRC)
        parts = set(rel.parts)
        if parts & EXCLUDE_DIRS:
            continue
        if p.suffix in {".pyc", ".log", ".png", ".tar.gz"}:
            continue
        # seeds 只进轻数据域
        if "seeds" in rel.parts:
            allowed = False
            rp = rel.as_posix()
            for sub in ("seeds/thuocl/", "seeds/taxonomy/", "seeds/0", "seeds/seeds_index"):
                if rp.startswith(sub) and not rp.endswith(".txt"):  # _raw txt 不进
                    allowed = True
            if not allowed:
                continue
        dst = STAGE / "kb_factory" / rel
        dst.parent.mkdir(parents=True, exist_ok=True)
        copy_norm(p, dst)
        n += 1
    # 关键件自证
    for must in ["kb_factory/kb_server.py", "kb_factory/evidence_cli.py",
                 "kb_factory/catalog_engine/evidence_tree.py",
                 "kb_factory/channel_adapters/pool.py",
                 "kb_factory/seeds/taxonomy/engineering_epc.yaml",
                 "kb_factory/seeds/thuocl/law.json"]:
        assert (STAGE / must).exists(), f"缺 {must}"
    size = sum(f.stat().st_size for f in STAGE.rglob("*") if f.is_file())
    print(f"[stage] {n} 件 / {size/1048576:.1f}MB -> {STAGE}")

if __name__ == "__main__":
    main()