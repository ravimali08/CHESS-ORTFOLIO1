# update_navs_width.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"

$oldWidth = 'w-\[760px\] min-\[1400px\]:w-\[880px\]'
$newWidth = 'w-[640px] min-[1400px]:w-[760px]'

foreach ($file in $htmlFiles) {
    if ($file.Name -eq "scratch" -or $file.Name -eq "images") { continue }
    
    $content = Get-Content $file.FullName -Raw
    if ($content -match $oldWidth) {
        $content = $content -replace $oldWidth, $newWidth
        Set-Content $file.FullName -Value $content -NoNewline
        Write-Output "Updated width: $($file.Name)"
    } else {
        Write-Output "No match for width: $($file.Name)"
    }
}
