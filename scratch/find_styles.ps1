# find_styles.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match '<style[^>]*>(.*?)<\/style>') {
        $styles = $Matches[1]
        if ($styles -match '(nav|header|a\s*\{|\.text-\[|\.font-medium)') {
            Write-Output "--- $($file.Name) has style matching: ---"
            # Print matching lines
            $styles -split "`n" | Where-Object { $_ -match '(nav|header|a\s*\{|\.text-\[|\.font-medium)' } | ForEach-Object { Write-Output "  $_" }
        }
    }
}
