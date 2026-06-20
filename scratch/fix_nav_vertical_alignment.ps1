# fix_nav_vertical_alignment.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"

$oldNavStart = 'class="absolute left-1/2 -translate-x-1/2 hidden xl:grid grid-cols-8'
$newNavStart = 'class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 hidden xl:grid grid-cols-8'

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "scratch" -or $file.Name -eq "images") { continue }
    
    $content = Get-Content $file.FullName -Raw
    if ($content -match $oldNavStart) {
        $content = $content -replace $oldNavStart, $newNavStart
        Set-Content $file.FullName -Value $content -NoNewline
        Write-Output "Aligned vertically: $($file.Name)"
    } else {
        Write-Output "No match or already aligned: $($file.Name)"
    }
}
