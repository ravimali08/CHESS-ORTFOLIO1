$files = Get-ChildItem -Path "c:\Users\sujal\OneDrive\Desktop\Desktop\CHESS PORTFOLIO 1\*.html"
foreach ($file in $files) {
    $content = Get-Content -Path $file.FullName -Raw
    $newContent = $content -replace '<style> img, video, \[style\*="background-image"\], \.bg-cover, \.bg-center, \.hero-mesh \{ filter: grayscale\(100%\) !important; \}</style>', ''
    Set-Content -Path $file.FullName -Value $newContent -Encoding UTF8
}
