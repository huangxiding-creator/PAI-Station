# Work Items

| ID | title | role | targets | surface | status | evidence | notes |
|----|-------|------|---------|---------|--------|----------|-------|
| WI-001 | Establish scope and auth | lead | case | process | in_progress | | |

## Coverage
- [ ] Recon/analysis complete for in_scope assets
- [ ] Critical/High candidates triaged (or N/A for pure RE)
- [ ] Validated findings have Evidence (E-*)
- [ ] Path documented (attack/call/solve)
- [ ] Timeline continuous across major phases
- [ ] Report via docs-generator
- [ ] field-journal anonymized

## Refs
- skills/ops/timeline-workitem.md
- skills/ops/evidence-finding-path.md
- WI-002 模板容器解密（Ghidra 定位 kwpsaitypeset.dll 解密例程）→ 未做，收益=合同/标书品类参数
- WI-003 oplist_exec 引擎函数级逆向（wpsmain.dll KFormatMolding）→ 未做，当前行为等价已由复刻件达成
- WI-004 wpscloudsvr 0.0.0.0:46608 鉴权验证 → 未做（安全面后续）

- WI-002 模板容器解密 → ✅ 完成（AES-128-CBC 密钥提取+12/12 解密+真身参数入库）
- WI-003 oplist_exec 引擎逆向 → ✅ 完成（四层链全量伪代码）
- WI-004 wpscloudsvr 鉴权 → ✅ 收口（私有协议无 HTTP 面；协议级逆向留档）
- WI-005 PentAGI 全栈 → ✅ 上线（运维手册 pentagi/README-运维手册.md）
- WI-006 keystream 复用弱点 crib-drag 深挖 / KSOLITE 协议逆向 → 未做（后续可选）
