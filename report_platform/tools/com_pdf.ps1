# com_pdf.ps1 — 5 份缺 PDF 定稿 docx → PDF (Word COM, 静默)
$ErrorActionPreference = 'Stop'
$src = 'F:\新建文件夹\AI总包创新院'
$out = 'E:\AI-Station\report_platform\work\pdf_gen'
New-Item -ItemType Directory -Force -Path $out | Out-Null
$jobs = @(
  @{ sku='ENT-28';   p="$src\总包研报\00 排队处理研报\《中国建筑第六工程局有限公司EPC总承包业务全景洞察报告》.docx" },
  @{ sku='PROV-16';  p="$src\总包研报\00 排队处理研报\山西省EPC总承包市场深度研究报告.docx" },
  @{ sku='TOPIC-15'; p="$src\总包研报\《风电EPC项目管理策划工作指南》.docx" },
  @{ sku='TOPIC-16'; p="$src\总包研报\00 排队处理研报\辽宁省固定资产投资分析报告_最终版(1).docx" },
  @{ sku='TOPIC-17'; p="$src\总包研报\00 排队处理研报\工程人这样用AI：从入门到精通，成为AI时代的超级项目管理者_V2.docx" }
)
$word = New-Object -ComObject Word.Application
$word.Visible = $false
$word.DisplayAlerts = 0
try {
  foreach ($j in $jobs) {
    $dst = Join-Path $out ($j.sku + '.pdf')
    if (Test-Path $dst) { Write-Output "SKIP $($j.sku)"; continue }
    $doc = $word.Documents.Open($j.p, $false, $true)
    $doc.SaveAs2($dst, 17)
    $doc.Close($false)
    Write-Output "OK $($j.sku) $((Get-Item $dst).Length)"
  }
} finally {
  $word.Quit()
  [Runtime.Interopservices.Marshal]::ReleaseComObject($word) | Out-Null
}
