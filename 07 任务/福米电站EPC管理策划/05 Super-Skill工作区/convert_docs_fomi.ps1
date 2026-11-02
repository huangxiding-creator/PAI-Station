$ErrorActionPreference = 'Continue'
$src = "D:\兰州水源地专著"
$dst = "E:\AI-Station\07 任务\福米电站EPC管理策划\05 Super-Skill工作区\doc_converted"
New-Item -ItemType Directory -Force $dst | Out-Null
$files = @(Get-ChildItem -Recurse $src -File | Where-Object { $_.Extension -eq '.doc' })
Write-Output ("found doc files: " + $files.Count)
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
$i = 0; $ok = 0; $fail = 0
foreach ($f in $files) {
    $i++
    $rel = $f.FullName.Substring($src.Length + 1) -replace '[\\/:*?"<>|]', '_'
    $target = Join-Path $dst ($rel + '.docx')
    if (Test-Path $target) { $ok++; continue }
    try {
        $doc = $word.Documents.Open($f.FullName, $false, $true, $false, "", "", $false, "", "", 0, $null, $false, $true)
        if (-not $doc) { throw "open-null" }
        $doc.SaveAs2($target, 16)
        $doc.Close($false)
        $ok++
    } catch { $fail++ }
    if ($i % 100 -eq 0) { Write-Output ("progress " + $i + "/" + $files.Count + " ok=" + $ok + " fail=" + $fail) }
}
try { $word.Quit() } catch {}
Write-Output ("DONE total=" + $files.Count + " ok=" + $ok + " fail=" + $fail)
