# find_all_inline_flex.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    $matches_inf = [regex]::Matches($content, 'class="[^"]*inline-flex[^"]*"')
    if ($matches_inf.Count -gt 0) {
        Write-Output "--- $($file.Name) ($($matches_inf.Count) matches) ---"
        foreach ($m in $matches_inf) {
            # Print the line containing the match
            $content -split "`n" | Where-Object { $_ -match $m.Value } | ForEach-Object { Write-Output "  $_" }
        }
    }
}
