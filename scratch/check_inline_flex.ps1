# check_inline_flex.ps1
$htmlFiles = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1" -Filter "*.html"
foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw
    if ($content -match 'inline-flex[^>]*Get In Touch|inline-flex[^>]*Contact Us') {
        Write-Output "$($file.Name): Match found"
    }
    # Let's search generally for inline-flex inside the page header titles
    if ($content -match 'inline-flex.*?silver-gradient-text') {
        Write-Output "$($file.Name): Found inline-flex near silver-gradient-text"
    }
}
