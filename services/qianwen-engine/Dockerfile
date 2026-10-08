# 总包千问引擎 · CloudBase 云托管（TCB Run）容器镜像
# - 单端口监听：云托管负载均衡只暴露一个端口（容器读 PORT 环境变量，默认 8080）
# - 健康检查路径：GET /api/health（app.py 内建，返回 {"ok": true}）
#   → 云托管控制台「服务设置 → 健康检查」路径填 /api/health
# - 系统装 fonts-noto-cjk：海报/导出中文字体走 poster._ttc_pair 的 NotoSansCJK
#   ttc 路线（与 ECS 同路径 /usr/share/fonts/opentype/noto）
# - 数据面：DATA_DIR（字体/wxacode 缓存）与 SECRETS_DIR（密钥文件）须挂持久卷，
#   见 TCB_DEPLOY.md；应用只跑单副本/单 worker（_PROGRESS 与 KB 串行闸是进程内态）
FROM python:3.11-slim

ENV PYTHONUNBUFFERED=1 \
    PORT=8080

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends fonts-noto-cjk fontconfig \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# 研究报告商城内容层（64 份可售 PDF ≈92MB + report.json + 试读 sample/）
# 放在代码层之前：内容变动少，代码迭代不失效这层缓存（引擎缺省路径
# REPORT_CONTENT_DIR=/app/report_platform/content 与 REPO=/app 对齐）
COPY report_content ./report_platform/content

COPY qianwen_engine ./qianwen_engine
COPY docker-entrypoint.sh ./docker-entrypoint.sh
# DATA_DIR 默认落 /app/data：字体随镜像带（docx/pdf 导出与海报用），wxacode 缓存运行时可写
COPY fonts ./data/fonts
RUN mkdir -p /app/data/wxacode /app/secrets

# 非 root 运行（挂载卷须对该用户可写；如卷权限受限可删去下两行）
RUN useradd --create-home appuser \
    && chown -R appuser /app/data /app/secrets
USER appuser

EXPOSE 8080

ENTRYPOINT ["sh", "/app/docker-entrypoint.sh"]
CMD ["sh", "-c", "exec uvicorn qianwen_engine.app:app --host 0.0.0.0 --port ${PORT:-8080}"]
