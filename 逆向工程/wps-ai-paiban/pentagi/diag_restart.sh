#!/bin/bash
cd /root/pentagi
echo "== State =="
docker inspect pentagi --format 'Restarts={{.RestartCount}} OOM={{.State.OOMKilled}} ExitCode={{.State.ExitCode}} Health={{if .State.Health}}{{.State.Health.Status}}{{end}} Started={{.State.StartedAt}} Finished={{if .State.FinishedAt}}{{.State.FinishedAt}}{{end}}'
echo "== Healthcheck 配置 =="
docker inspect pentagi --format '{{json .Config.Healthcheck}}'
echo "== 内存 =="
docker stats --no-stream --format '{{.Name}} mem={{.MemUsage}}' pentagi pgvector
echo "== 崩溃前日志（shutdown 上下文）=="
docker logs pentagi 2>&1 | grep -B 8 'Application shutdown' | tail -12
