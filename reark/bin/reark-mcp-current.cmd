@echo off
rem ReArk MCP launcher for Claude Code (station integration 1102)
rem Reads the absolute target path from E:\AI-Station\reark\target.txt (first non-empty line).
rem To switch targets: rewrite target.txt, then restart the reark MCP server (/mcp or new session).
setlocal
for /f "usebackq delims=" %%T in ("E:\AI-Station\reark\target.txt") do (
  "E:\AI-Station\reark\app\reark-mcp.exe" --target "%%T"
  exit /b 0
)
echo [reark] target.txt is empty or missing. Write one absolute target path (first line wins), then restart the reark MCP server. 1>&2
exit /b 1
